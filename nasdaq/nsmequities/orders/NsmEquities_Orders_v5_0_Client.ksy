# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Orders Ouch v5.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Orders
#   Encoding: Ouch
#   Version: 5.0
#   Date: 4/1/2023
#   Specification: OUCH5.0.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: Public/GPLv3
#   Authors: Omi Developers
#
# Copyright (c) 2026 Scaled Sources LLC.  https://www.scaledsources.com
#
# This kaitai struct definition is contributed to The Open Markets Initiative under
# the license noted above.
#
# The protocol compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nsmequities_orders_ouch_v5_0_client
  title: Nasdaq NsmEquities Orders Ouch v5.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Orders Ouch v5.0'
doc-ref: https://nasdaqtrader.com/Trader.aspx?id=TradingSpecs

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::replace_order_message': replace_order_message
            'unsequenced_message_type::cancel_order_message': cancel_order_message
            'unsequenced_message_type::modify_order_message': modify_order_message
  enter_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Please refer to the Data Types section for more clarification. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Corresponds to TimeInForce (59) in Nasdaq FIX'
      - id: display
        type: u1
        enum: display
        doc: 'Y = visible N = hidden A = attributable'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'A = agency P = principal R = riskless O = other'
      - id: inter_market_sweep_eligibility
        type: u1
        enum: inter_market_sweep_eligibility
        doc: 'Y = eligible N = not eligible'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross type'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: enter_order_appendage
        type: enter_order_appendage
        repeat: eos
        doc: 'Enter Order Appendage'
  enter_order_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: enter_order_optional_field
        type: s1
        enum: enter_order_optional_field
        doc: 'Apendage Id'
      - id: enter_order_optional_value
        size: optional_field_length + 1 - 2
  replace_order_message:
    seq:
      - id: orig_user_ref_num
        type: u4
        doc: 'This must be filled out with the Order UserRefNum sent on the Enter Order Message or last Replace Order Message'
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the order. Please refer to the Data Types section for more clarification. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Corresponds to TimeInForce (59) in Nasdaq FIX'
      - id: display
        type: u1
        enum: display
        doc: 'Y = visible N = hidden A = attributable'
      - id: inter_market_sweep_eligibility
        type: u1
        enum: inter_market_sweep_eligibility
        doc: 'Y = eligible N = not eligible'
      - id: clordid
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer order identifier. ClOrdID will not be checked for day-uniqueness for each OUCH account'
      - id: appendage_length
        type: u2
        doc: 'The length of the remaining Optional Appendage field'
      - id: replace_order_appendage
        type: replace_order_appendage
        repeat: eos
        doc: 'Replace Order Appendage'
  replace_order_appendage:
    seq:
      - id: optional_field_length
        type: s1
        doc: 'Apendage Length Type'
      - id: replace_order_optional_field
        type: s1
        enum: replace_order_optional_field
        doc: 'Apendage Id'
      - id: replace_order_optional_value
        size: optional_field_length + 1 - 2
  cancel_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  modify_order_message:
    seq:
      - id: user_ref_num
        type: u4
        doc: 'As described above in Data Types. UserRefNum must be day-unique and strictly increasing for each OUCH account'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'Identifies this message as Enter Order Message type'
    0x55:
      id: 'replace_order_message'
      doc: 'The Replace Order Message allows you to alter most of the attributes of an order in a single message. This is more efficient than canceling an existing order and immediately succeeding it with a new order. Replacing an order always gives it a new timestamp for its time priority on the book. If you wish you simply partially cancel an order and retain its time priority, send a Cancel Order Message instead.'
    0x58:
      id: 'cancel_order_message'
      doc: 'The Cancel Order Message is used to request that an order be canceled or reduced. In the Cancel Order Message, you must specify the new ''intended order size'' for the order. The ''intended order size'' is the maximum number of shares that can be executed in total after the cancel is applied.'
    0x4d:
      id: 'modify_order_message'
      doc: 'The Modify Order Message is used to request modifications that will not affect order priority on the book unless the share amount is increased. Since priority of the order does not change (exception noted), allowed modifications are restricted to only the ones specified in the message details below.'
    0x51:
      id: 'account_query_message'
      doc: 'The Account Query Request message can be used when recovering state to request the next available UserRefNum that can be used for identifying new transactions.'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x54:
      id: 'sell_short'
      doc: 'Sell Short Client Affirms Ability To Borrow Securities In Good Deliverable Form For Delivery Within Three Business Days'
    0x45:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt Client Affirms Ability To Borrow Securities In Good Deliverable Form For Delivery Within Three Business Days'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day Market Hours'
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x35:
      id: 'gtx_extended_hours'
      doc: 'Gtx Extended Hours'
    0x36:
      id: 'gtt'
      doc: 'Gtt Expire Time Needs To Be Specified'
    0x45:
      id: 'after_hours'
      doc: 'After Hours'
  display:
    0x41:
      id: 'attributable'
      doc: 'Attributable'
    0x59:
      id: 'visible'
      doc: 'Visible'
    0x4e:
      id: 'hidden'
      doc: 'Hidden'
    0x50:
      id: 'post_only'
      doc: 'Post Only'
    0x49:
      id: 'imbalance_only'
      doc: 'Imbalance Only For Opening And Closing Cross Only'
    0x4d:
      id: 'mid_point_peg'
      doc: 'Mid Point Peg'
    0x57:
      id: 'mid_point_peg_post_only'
      doc: 'Mid Point Peg Post Only'
    0x4c:
      id: 'post_only_and_attributable'
      doc: 'Post Only And Attributable Price To Display'
    0x4f:
      id: 'retail_order_type_1'
      doc: 'Retail Order Type 1'
    0x54:
      id: 'retail_order_type_2'
      doc: 'Retail Order Type 2'
    0x51:
      id: 'retail_price_improvement_order'
      doc: 'Retail Price Improvement Order'
    0x5a:
      id: 'conformant'
      doc: 'Conformant'
    0x6d:
      id: 'mid_point_peg_and_mid_point_trade_now'
      doc: 'Mid Point Peg And Mid Point Trade Now'
    0x6e:
      id: 'non_display_and_mid_point'
      doc: 'Non Display And Mid Point Trade Now'
  capacity:
    0x4f:
      id: 'other'
      doc: 'Other'
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x52:
      id: 'riskless'
      doc: 'Riskless'
  inter_market_sweep_eligibility:
    0x59:
      id: 'eligible'
      doc: 'Eligible'
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible'
  cross_type:
    0x4e:
      id: 'continuous_market'
      doc: 'Continuous Market'
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x48:
      id: 'halt_ipo'
      doc: 'Halt Ipo'
    0x53:
      id: 'supplemental'
      doc: 'Supplemental'
    0x52:
      id: 'retail'
      doc: 'Retail'
    0x45:
      id: 'extended'
      doc: 'Extended Life'
    0x41:
      id: 'after_hours_close'
      doc: 'After Hours Close'
  enter_order_optional_field:
    2:
      id: 'firm'
      doc: 'Enter Order Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Enter Order Optional MinQty Enum'
    4:
      id: 'customertype'
      doc: 'Enter Order Optional CustomerType Enum'
    5:
      id: 'maxfloor'
      doc: 'Enter Order Optional MaxFloor Enum'
  replace_order_optional_field:
    3:
      id: 'minqty'
      doc: 'Replace Order Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Replace Order Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Replace Order Optional PriceType Enum'
    12:
      id: 'postonly'
      doc: 'Replace Order Optional PostOnly Enum'
    15:
      id: 'expiretime'
      doc: 'Replace Order Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Replace Order Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Replace Order Optional HandleInst Enum'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire NASDAQ system.'
    0x41:
      id: 'order_accepted_message'
      doc: 'Functionality that is not available will be greyed out in the specifications. Any changes will be conveyed via the NASDAQ Head Trader Alerts or Technical Updates.'
    0x55:
      id: 'replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. The data fields from the Replace Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields. You will receive one and only one of these two for each replacement.'
    0x43:
      id: 'canceled_message'
      doc: 'A Canceled Message informs you that an order has been reduced or canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order timing out or being canceled automatically.'
    0x44:
      id: 'aiq_canceled_message'
      doc: 'AIQ Canceled Message'
    0x45:
      id: 'order_executed_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear. The reason for the break is given.'
    0x46:
      id: 'trade_correction_message'
      doc: 'An Executed Restatement Message informs you that there has been a change to an execution.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'A Rejected Message may be sent in response to an Enter Order Message or Replace Order Message if the order or replace cannot be accepted at this time. The reason for the rejection is given.'
    0x50:
      id: 'cancel_pending_message'
      doc: 'This message will only be sent once for a given token. Duplicate cancel requests for the same token will be ignored by OUCH.'
    0x49:
      id: 'cancel_reject_message'
      doc: 'This message will only be sent once for a given token. Duplicate cancel requests for the same token will be ignored by OUCH.'
    0x54:
      id: 'order_priority_update_message'
      doc: 'A Priority Update Message is sent whenever priority of the order has been changed by the system.'
    0x4d:
      id: 'order_modified_message'
      doc: 'An Order Modified Message is sent in response to an order modify request.'
    0x52:
      id: 'order_restated_message'
      doc: 'The Order Restated Message is sent to indicate that the system has modified an order as part of its order management.'
    0x51:
      id: 'account_query_response_message'
      doc: 'The Account Query Response message in sent in response to an Account Query Request to indicate the next available UserRefNum that can be used to identify new transactions.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day Exchange Is Open And Is Ready To Accept Orders'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day Exchange Is Closed And Will No Longer Accept New Orders Note That It Is Still Possible To Receive Breaks And Cancels After This Event'
  order_state:
    0x4c:
      id: 'order_live'
      doc: 'Order Live'
    0x44:
      id: 'order_dead'
      doc: 'Order Dead'
  order_accepted_optional_field:
    2:
      id: 'firm'
      doc: 'Order Accepted Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Order Accepted Optional MinQty Enum'
    4:
      id: 'customertype'
      doc: 'Order Accepted Optional CustomerType Enum'
    5:
      id: 'maxfloor'
      doc: 'Order Accepted Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Order Accepted Optional PriceType Enum'
    7:
      id: 'pegoffset'
      doc: 'Order Accepted Optional PegOffset Enum'
    9:
      id: 'discretionprice'
      doc: 'Order Accepted Optional DiscretionPrice Enum'
    10:
      id: 'discretionpegtype'
      doc: 'Order Accepted Optional DiscretionPegType Enum'
    11:
      id: 'discretionpegoffset'
      doc: 'Order Accepted Optional DiscretionPegOffset Enum'
    12:
      id: 'postonly'
      doc: 'Order Accepted Optional PostOnly Enum'
    13:
      id: 'randomreserves'
      doc: 'Order Accepted Optional RandomReserves Enum'
    14:
      id: 'route'
      doc: 'Order Accepted Optional Route Enum'
    15:
      id: 'expiretime'
      doc: 'Order Accepted Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Order Accepted Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Order Accepted Optional HandleInst Enum'
    18:
      id: 'bbo_weight_indicator'
      doc: 'Order Accepted Optional BBO Weight Indicator Enum'
  replaced_message_optional_field:
    2:
      id: 'firm'
      doc: 'Replaced Message Optional Firm Enum'
    3:
      id: 'minqty'
      doc: 'Replaced Message Optional MinQty Enum'
    5:
      id: 'maxfloor'
      doc: 'Replaced Message Optional MaxFloor Enum'
    6:
      id: 'pricetype'
      doc: 'Replaced Message Optional PriceType Enum'
    12:
      id: 'postonly'
      doc: 'Replaced Message Optional PostOnly Enum'
    15:
      id: 'expiretime'
      doc: 'Replaced Message Optional ExpireTime Enum'
    16:
      id: 'tradenow'
      doc: 'Replaced Message Optional TradeNow Enum'
    17:
      id: 'handleinst'
      doc: 'Replaced Message Optional HandleInst Enum'
    18:
      id: 'bbo_weight_indicator'
      doc: 'Replaced Message Optional BBO Weight Indicator Enum'
  cancel_order_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'Sent In Response To A Cancel Order Message Or A Replace Order Message'
    0x49:
      id: 'immediate_or_cancel_order'
      doc: 'This Order Was Originally Sent With A Timeout Of Zero And No Further Matches Were Available On The Book So The Remaining Unexecuted Shares Were Immediately Canceled'
    0x54:
      id: 'timeout'
      doc: 'The Time In Force For This Order Has Expired'
    0x53:
      id: 'supervisory'
      doc: 'This Order Was Manually Canceled Or Reduced By A Nasdaq Supervisory Terminal This Is Usually In Response To A Participant Request Via Telephone'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This Order Cannot Be Executed Because Of A Regulatory Restriction Eg Trade Through Restrictions'
    0x51:
      id: 'self_match_prevention'
      doc: 'The Order Was Cancelled Because It Would Have Executed With An Existing Order Entered By The Same Mpid'
    0x5a:
      id: 'system_cancel'
      doc: 'This Order Was Cancelled By The System'
    0x43:
      id: 'cross_canceled'
      doc: 'Nonbookable Cross Orders That Did Not Execute In The Cross'
    0x4b:
      id: 'this_order_cannot_be_executed'
      doc: 'This Order Cannot Be Executed Because Of Market Collars'
    0x48:
      id: 'halted'
      doc: 'The Onopen Order Was Canceled Because The Symbol Remained Halted After The Opening Cross Completed'
    0x58:
      id: 'open_protection'
      doc: 'Orders That Are Cancelled As A Result Of The Opening Price Protection Threshold'
    0x45:
      id: 'closed'
      doc: 'Any Day Order That Was Received After The Closing Cross Is Complete In A Given Symbol Will Receive This Cancel Reason'
    0x46:
      id: 'post_only_cancel'
      doc: 'This Post Only Order Was Cancelled Because It Would Have Been Price Slid For Nms'
    0x47:
      id: 'post_only_cancel_contra_side_displayed'
      doc: 'This Post Only Order Was Cancelled Because It Would Have Been Price Slid Due To A Contra Side Displayed Order On The Book'
  liquidity_flag:
    0x41:
      id: 'added'
      doc: 'Added'
    0x65:
      id: 'retail_designated'
      doc: 'Retail Designated Execution That Added Displayed Liquidity'
    0x48:
      id: 'halt_ipo'
      doc: 'Halt Ipo Cross'
    0x69:
      id: 'after_hours_closing'
      doc: 'After Hours Closing Cross'
    0x4a:
      id: 'nondisplayed_adding_liquidity'
      doc: 'Nondisplayed Adding Liquidity'
    0x6a:
      id: 'rpi_order_provides_liquidity'
      doc: 'Retail Price Improving Order Provides Liquidity'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'Added Liquidity Via A Midpoint Order'
    0x4b:
      id: 'halt_cross'
      doc: 'Halt Cross'
    0x4c:
      id: 'closing_cross'
      doc: 'Closing Cross Imbalanceonly'
    0x4d:
      id: 'opening_cross'
      doc: 'Opening Cross Imbalanceonly'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'Removed Liquidity At A Midpoint'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'Passive Midpoint Execution'
    0x6e:
      id: 'midpoint_extended_life_order_execution'
      doc: 'Midpoint Extended Life Order Execution'
    0x4f:
      id: 'opening'
      doc: 'Opening Cross'
    0x70:
      id: 'removed_price_improving_nondisplayed_liquidity'
      doc: 'Removed Price Improving Nondisplayed Liquidity'
    0x71:
      id: 'rmo_retail_order_removes_non_rpi_midpoint_liquidity'
      doc: 'Rmo Retail Order Removes Non Rpi Midpoint Liquidity'
    0x52:
      id: 'removed'
      doc: 'Removed'
    0x72:
      id: 'retail_order_removes_rpi_liquidity'
      doc: 'Retail Order Removes Rpi Liquidity'
    0x74:
      id: 'retail_order_removes_price_improving_nondisplayed_liquidity_other_than_rpi_liquidity'
      doc: 'Retail Order Removes Price Improving Nondisplayed Liquidity Other Than Rpi Liquidity'
    0x30:
      id: 'supplemental'
      doc: 'Supplemental Order Execution'
    0x37:
      id: 'displayed_liquidityadding_order_improves_the_nbbo'
      doc: 'Displayed Liquidityadding Order Improves The Nbbo'
    0x38:
      id: 'displayed_liquidityadding_order_sets_the_qbbo_while_joining_the_nbbo'
      doc: 'Displayed Liquidityadding Order Sets The Qbbo While Joining The Nbbo'
  order_executed_optional_field:
    19:
      id: 'reference_price'
      doc: 'Order Executed Optional Reference Price Enum'
    20:
      id: 'reference_price_type'
      doc: 'Order Executed Optional Reference Price Type Enum'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous Trade Deemed Clearly Erroneous'
    0x43:
      id: 'consent'
      doc: 'Consent Both Parties Agreed To Break The Trade'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory Manually Broken By Supervisory'
    0x58:
      id: 'external'
      doc: 'External Trade Broken By An External Third Party'
  trade_correction_reason:
    0x4e:
      id: 'adjusted_to_nav'
      doc: 'Adjusted To Nav'
  rejected_order_reason:
    0x0001:
      id: 'quote_unavailable'
      doc: 'Quote Unavailable'
    0x0002:
      id: 'destination_closed'
      doc: 'Destination Closed'
    0x0003:
      id: 'invalid_display'
      doc: 'Invalid Display'
    0x0004:
      id: 'invalid_max_floor'
      doc: 'Invalid Max Floor'
    0x0005:
      id: 'invalid_peg_type'
      doc: 'Invalid Peg Type'
    0x0006:
      id: 'fat_finger'
      doc: 'Fat Finger'
    0x0007:
      id: 'halted'
      doc: 'Halted'
    0x0008:
      id: 'iso_not_allowed'
      doc: 'Iso Not Allowed'
    0x0009:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x000a:
      id: 'processing_error'
      doc: 'Processing Error'
    0x000b:
      id: 'cancel_pending'
      doc: 'Cancel Pending'
    0x000c:
      id: 'firm_not_authorized'
      doc: 'Firm Not Authorized'
    0x000d:
      id: 'invalid_min_quantity'
      doc: 'Invalid Min Quantity'
    0x000e:
      id: 'no_closing_reference_price'
      doc: 'No Closing Reference Price'
    0x000f:
      id: 'other'
      doc: 'Other'
    0x0010:
      id: 'cancel_not_allowed'
      doc: 'Cancel Not Allowed'
    0x0011:
      id: 'pegging_not_allowed'
      doc: 'Pegging Not Allowed'
    0x0012:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x0013:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    0x0014:
      id: 'invalid_cross_order'
      doc: 'Invalid Cross Order'
    0x0015:
      id: 'replace_not_allowed'
      doc: 'Replace Not Allowed'
    0x0016:
      id: 'routing_not_allowed'
      doc: 'Routing Not Allowed'
    0x0017:
      id: 'invalid_symbol'
      doc: 'Invalid Symbol'
    0x0018:
      id: 'test'
      doc: 'Test'
    0x0019:
      id: 'late_loc_too_aggressive'
      doc: 'Late Loc Too Aggressive'
    0x001a:
      id: 'retail_not_allowed'
      doc: 'Retail Not Allowed'
    0x001b:
      id: 'invalid_midpoint_post_only_price'
      doc: 'Invalid Midpoint Post Only Price'
    0x001c:
      id: 'invalid_destination'
      doc: 'Invalid Destination'
    0x001d:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x001e:
      id: 'shares_exceed_threshold'
      doc: 'Shares Exceed Threshold'
    0x001f:
      id: 'exceeds_maximum_allowed_notional_value'
      doc: 'Exceeds Maximum Allowed Notional Value'
  order_restated_reason:
    0x52:
      id: 'refresh_of_display'
      doc: 'Refresh Of Display On An Order With Reserves'
    0x50:
      id: 'update_of_displayed_price'
      doc: 'Update Of Displayed Price'
  order_restated_optional_field:
    22:
      id: 'display_quantity'
      doc: 'Order Restated Optional Display Quantity Enum'
    23:
      id: 'display_price'
      doc: 'Order Restated Optional Display Price Enum'
    1:
      id: 'secondaryordrefnum'
      doc: 'Order Restated Optional SecondaryOrdRefNum Enum'

