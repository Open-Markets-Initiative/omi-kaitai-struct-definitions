# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Rash AsciiRash v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Rash
#   Encoding: Ascii Rash
#   Version: 1.0
#   Date: 03/11/2020
#   Specification: rash.pdf
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
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nsmequities_rash_asciirash_v1_0_client
  title: Nasdaq NsmEquities Rash AsciiRash v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Rash AsciiRash v1.0'
doc-ref:
  - https://www.nasdaqtrader.com/Trader.aspx?id=TradingSpecs
  - https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/rash.pdf

seq:
  - id: client_packet_header
    type: client_packet_header_struct
    doc: 'SoupTcp Packet Header sent by the client'
  - id: client_payload
    type:
      switch-on: client_packet_header.client_packet_type
      cases:
        'client_packet_type::debug_packet': debug_packet
        'client_packet_type::login_request_packet': login_request_packet
        'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
  client_packet_header_struct:
    seq:
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type'
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
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Code identifying the RASH inbound message type'
      - id: unsequenced_message
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::enter_order_message_with_cross_functionality': enter_order_message_with_cross_functionality
            'unsequenced_message_type::cancel_order_message': cancel_order_message
  enter_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: side
        type: u1
        enum: side
        doc: 'B/S/T/E: Buy, Sell, Short, Short Exempt. For sell short and sell short exempt, the subscriber affirms the ability to borrow securities in good deliverable form for delivery within three business days'
      - id: shares_order_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Total number of shares entered. Must be greater than zero'
      - id: stock_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price, 6 whole and 4 implied decimal digits. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of seconds that this order should live before being automatically canceled; special values (0 = Immediate or Cancel, 99998 = Market Day, 99999 = system day and the others the document lists) are listed in section 2.1.1'
      - id: firm_client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MPID'
      - id: display
        type: u1
        enum: display
        doc: 'Display instruction; see the Display values'
      - id: min_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum fill amount allowed'
      - id: max_floor
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to display. If zero this field will default to the order quantity. Use the display field to specify a hidden order'
      - id: peg_type
        type: u1
        enum: peg_type
        doc: 'Peg type'
      - id: peg_difference_sign
        type: u1
        enum: peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: discretion_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Discretion Price for Discretionary Order. If set to 0, this order does not have discretion. Implied decimal with scale 1e-4'
      - id: discretion_peg_type
        type: u1
        enum: discretion_peg_type
        doc: 'Discretion peg type'
      - id: discretion_peg_difference_sign
        type: u1
        enum: discretion_peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: discretion_peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: capacity_rule_80_a_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Capacity code'
      - id: random_reserve
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to do random reserve with'
      - id: route_dest_exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Target ID: a routing strategy or a directed order destination code'
      - id: cust_terminal_id_sender_sub_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client initiated; pass-thru. Must be left-justified'
      - id: customer_type
        type: u1
        enum: customer_type
        doc: 'Indicates if the order is a retail designated order (optional field)'
  enter_order_message_with_cross_functionality:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: side
        type: u1
        enum: side
        doc: 'B/S/T/E: Buy, Sell, Short, Short Exempt. For sell short and sell short exempt, the subscriber affirms the ability to borrow securities in good deliverable form for delivery within three business days'
      - id: shares_order_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Total number of shares entered. Must be greater than zero'
      - id: stock_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Price, 6 whole and 4 implied decimal digits. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: str
        size: 5
        encoding: ASCII
        doc: 'The number of seconds that this order should live before being automatically canceled; special values (0 = Immediate or Cancel, 99998 = Market Day, 99999 = system day and the others the document lists) are listed in section 2.1.1'
      - id: firm_client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MPID'
      - id: display
        type: u1
        enum: display
        doc: 'Display instruction; see the Display values'
      - id: min_qty
        type: str
        size: 6
        encoding: ASCII
        doc: 'Minimum fill amount allowed'
      - id: max_floor
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to display. If zero this field will default to the order quantity. Use the display field to specify a hidden order'
      - id: peg_type
        type: u1
        enum: peg_type
        doc: 'Peg type'
      - id: peg_difference_sign
        type: u1
        enum: peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: discretion_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Discretion Price for Discretionary Order. If set to 0, this order does not have discretion. Implied decimal with scale 1e-4'
      - id: discretion_peg_type
        type: u1
        enum: discretion_peg_type
        doc: 'Discretion peg type'
      - id: discretion_peg_difference_sign
        type: u1
        enum: discretion_peg_difference_sign
        doc: '+ or -. If peg type is set to N, specify +'
      - id: discretion_peg_difference
        type: str
        size: 10
        encoding: ASCII
        doc: 'Amount; 6.4 (implied decimal). If peg type is set to N, specify 0. Implied decimal with scale 1e-4'
      - id: capacity_rule_80_a_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Capacity code'
      - id: random_reserve
        type: str
        size: 6
        encoding: ASCII
        doc: 'Shares to do random reserve with'
      - id: route_dest_exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Target ID: a routing strategy or a directed order destination code'
      - id: cust_terminal_id_sender_sub_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client initiated; pass-thru. Must be left-justified'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Inter-market sweep eligibility'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross type'
      - id: customer_type
        type: u1
        enum: customer_type
        doc: 'Indicates if the order is a retail designated order (optional field)'
      - id: reactive_trade_now
        type: u1
        enum: reactive_trade_now
        doc: 'Indicates if the order is a reactive trade now order (optional field)'
  cancel_order_message:
    seq:
      - id: order_token_client_order_id
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Token must be day unique for each RASH port account'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        doc: 'Specify zero to cancel the order; otherwise the new intended order size'

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupTcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupTcp Logout Request Packet'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'The Enter Order Message lets you enter a new order. Each new order must have a Token that is unique to the day and that logical RASH Port account. If you send a valid order, you should receive an Accepted Order Message.'
    0x51:
      id: 'enter_order_message_with_cross_functionality'
      doc: 'Enters orders in much the same way as the Enter Order Message, with a few additional fields. Notably, the Cross Type Flag allows you to specify that an order begins participation in a cross.'
    0x58:
      id: 'cancel_order_message'
      doc: 'Requests that an order be canceled. A Shares field of zero cancels the entire balance of the order; otherwise Shares is the new intended order size.'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x54:
      id: 'short_field'
      doc: 'Sell Short'
    0x45:
      id: 'short_exempt'
      doc: 'Sell Short Exempt'
  display:
    0x59:
      id: 'anonymous_price_to_comply'
      doc: 'Anonymous Price To Comply'
    0x4e:
      id: 'non_displayed'
      doc: 'Non Displayed'
    0x41:
      id: 'attributable_price_to_display'
      doc: 'Attributable Price To Display'
    0x49:
      id: 'imbalance_only'
      doc: 'Imbalance Only'
    0x50:
      id: 'post_only'
      doc: 'Post Only'
    0x57:
      id: 'mid_point_peg_post_only'
      doc: 'Mid Point Peg Post Only'
    0x4c:
      id: 'post_only_and_attributable_price_to_display'
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
    0x4d:
      id: 'mid_point_peg'
      doc: 'Mid Point Peg'
    0x6d:
      id: 'mid_point_peg_and_mid_point_trade_now'
      doc: 'Mid Point Peg And Mid Point Trade Now'
    0x6e:
      id: 'non_display_and_mid_point_trade_now'
      doc: 'Non Display And Mid Point Trade Now'
    0x42:
      id: 'm_elo_and_continuous_book_midpoint'
      doc: 'Melo And Continuous Book Midpoint'
  peg_type:
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x4e:
      id: 'no_peg'
      doc: 'No Peg'
    0x50:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'primary'
      doc: 'Primary'
    0x51:
      id: 'market_maker_peg'
      doc: 'Market Maker Peg'
    0x49:
      id: 'inav_peg'
      doc: 'Inav Peg'
  peg_difference_sign:
    0x2b:
      id: 'plus'
      doc: 'Positive Peg Difference'
    0x2d:
      id: 'minus'
      doc: 'Negative Peg Difference'
  discretion_peg_type:
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x4e:
      id: 'no_peg'
      doc: 'No Peg'
    0x50:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'primary'
      doc: 'Primary'
    0x49:
      id: 'inav_peg'
      doc: 'Inav Peg'
  discretion_peg_difference_sign:
    0x2b:
      id: 'plus'
      doc: 'Positive Peg Difference'
    0x2d:
      id: 'minus'
      doc: 'Negative Peg Difference'
  customer_type:
    0x52:
      id: 'retail_designated_order'
      doc: 'Retail Designated Order'
    0x4e:
      id: 'not_a_retail_designated_order'
      doc: 'Not A Retail Designated Order'
  intermarket_sweep_eligibility:
    0x59:
      id: 'eligible'
      doc: 'Eligible'
    0x4e:
      id: 'not_eligible'
      doc: 'Not Eligible'
    0x79:
      id: 'trade_at_intermarket_sweep_order'
      doc: 'Tradeat Intermarket Sweep Order'
  cross_type:
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x43:
      id: 'closing_cross'
      doc: 'Closing Cross'
    0x4e:
      id: 'immediately_live'
      doc: 'Order Is Immediately Live Dont Wait For A Cross'
    0x52:
      id: 'retail_cross'
      doc: 'Retail Cross Rpi Orders Can Only Participate In The Retail Cross'
    0x45:
      id: 'extended_life'
      doc: 'Extended Life'
  reactive_trade_now:
    0x42:
      id: 'reactive_trade_now'
      doc: 'Reactive Trade Now'
    0x4e:
      id: 'not_a_reactive_trade_now'
      doc: 'Not A Reactive Trade Now Order'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupTcp Server Heartbeat Packet'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire system.'
    0x41:
      id: 'accepted_order_message'
      doc: 'An Accepted Order Message acknowledges the receipt of a valid Enter Order Message. The data fields from the Enter Order Message are echoed back; the accepted values may differ from the entered values for some fields.'
    0x52:
      id: 'accepted_order_message_with_cross_functionality'
      doc: 'Similar to the regular Accepted Order Message, with the additional information provided upon order entry using the Enter Order Message with Cross Functionality.'
    0x43:
      id: 'canceled_order_message'
      doc: 'A Canceled Order Message informs you that an order has been reduced or canceled. Canceled shares reflect the number of shares that are out.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'A Rejected Order Message may be sent in response to an Enter Order Message if the order cannot be accepted at this time. The Token of a rejected order cannot be re-used.'
    0x45:
      id: 'executed_order_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear.'
    0x47:
      id: 'executed_with_reference_price_message'
      doc: 'Informs you that all or part of an order has been executed, with the reference price associated with the execution.'
    0x46:
      id: 'trade_correction_message'
      doc: 'A Trade Correction Message informs you that there has been a change to an execution.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day This Is Always The First Message Each Day It Indicates That The System Is Open And Ready To Start Accepting Orders'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day This Indicates That The System Is Now Closed And Will Not Accept Any New Orders In This Session There Will Not Be Any More Executions During This Session However It Is Still Possible To Receive Broken Trade Messages And Canceled Order Messages'
  cancel_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User Requested Cancel Sent In Response To A Cancel Request Message'
    0x49:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel Order'
    0x54:
      id: 'timeout'
      doc: 'Timeout The Time In Force For This Order Has Expired'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory The Order Was Manually Canceled Or Reduced By A Supervisory Terminal'
    0x44:
      id: 'regulatory_restriction'
      doc: 'This Order Cannot Be Executed Because Of A Regulatory Restriction Eg Trade Through Restrictions'
    0x51:
      id: 'self_match_prevention'
      doc: 'Self Match Prevention The Order Was Cancelled Because It Would Have Executed With An Existing Order Entered By The Same Mpid'
    0x5a:
      id: 'system_cancel'
      doc: 'System Cancel This Order Was Cancelled By The System'
    0x4b:
      id: 'market_collars'
      doc: 'This Order Cannot Be Executed Because Of Market Collars'
    0x43:
      id: 'cross_cancel'
      doc: 'Cross Cancel'
    0x71:
      id: 'insufficient_quantity'
      doc: 'Order Cancelled Due To Insufficient Quantity'
    0x48:
      id: 'halted'
      doc: 'Halted The Onopen Order Was Canceled Because The Symbol Remained Halted After The Opening Cross Completed'
    0x58:
      id: 'open_protection'
      doc: 'Open Protection Orders That Are Cancelled As A Result Of The Opening Price Protection Threshold'
    0x45:
      id: 'closed'
      doc: 'Closed Any Day Order That Was Received After The Closing Cross Is Complete In A Given Symbol Will Receive This Cancel Reason'
    0x4a:
      id: 'rejected_by_away_destination'
      doc: 'System Cancel This Order Was Cancelled Because It Was Rejected By An Away Destination Includes Midpoint Orders Cancelled Due To A Crossed Market'
    0x41:
      id: 'administrative_cancel'
      doc: 'Administrative Cancel This Order Was Cancelled By The System'
    0x46:
      id: 'post_only_cancel_nms'
      doc: 'Post Only Cancel This Post Only Order Was Cancelled Because It Would Have Been Price Slid For Nms'
    0x47:
      id: 'post_only_cancel_contra_displayed_order'
      doc: 'Post Only Cancel This Post Only Order Was Cancelled Because It Would Have Been Price Slid Due To A Contra Side Displayed Order On The Book'
  reject_reason:
    0x59:
      id: 'no_shares_found_for_routing'
      doc: 'No Shares Found For Routing'
    0x43:
      id: 'nasdaq_is_closed'
      doc: 'Nasdaq Is Closed'
    0x49:
      id: 'invalid_order_side'
      doc: 'Invalid Order Side'
    0x45:
      id: 'invalid_peg'
      doc: 'Invalid Peg'
    0x4c:
      id: 'invalid_firm'
      doc: 'Invalid Firm'
    0x5a:
      id: 'quantity_exceeds_threshold'
      doc: 'Quantity Exceeds Threshold'
    0x4f:
      id: 'other'
      doc: 'Other A Reason Not Contemplated In This Version Of Rash'
    0x42:
      id: 'quote_not_available_for_pegged_order'
      doc: 'Quote Not Available For Pegged Order'
    0x50:
      id: 'pegging_not_allowed'
      doc: 'Pegging Not Allowed'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x47:
      id: 'destination_not_available'
      doc: 'Destination Not Available'
    0x4a:
      id: 'processing_error'
      doc: 'Processing Error'
    0x4e:
      id: 'invalid_routing_instructions'
      doc: 'Invalid Routing Instructions'
    0x44:
      id: 'invalid_display_value'
      doc: 'Invalid Display Value'
    0x4d:
      id: 'outside_of_permitted_times_for_clearing_destination'
      doc: 'Outside Of Permitted Times For Clearing Destination'
    0x48:
      id: 'security_is_halted'
      doc: 'Security Is Halted'
    0x53:
      id: 'invalid_symbol'
      doc: 'Invalid Symbol'
    0x51:
      id: 'invalid_order_quantity'
      doc: 'Invalid Order Quantity'
    0x4b:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x57:
      id: 'invalid_destination'
      doc: 'Invalid Destination'
    0x41:
      id: 'advance_features_not_allowed'
      doc: 'Advance Features Not Allowed'
    0x55:
      id: 'possible_duplicate_order'
      doc: 'Possible Duplicate Order'
    0x56:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x54:
      id: 'test_mode'
      doc: 'Test Mode'
    0x52:
      id: 'routing_not_allowed'
      doc: 'Routing Not Allowed'
    0x46:
      id: 'order_not_marketable'
      doc: 'Order Not Marketable Conflicting Instructions Improper Cross Type'
    0x6f:
      id: 'no_noii_reference_price_for_loc'
      doc: 'There Is No Reference Price In The First Noii Dissemination And So No Loc Orders Can Be Accepted In This Stock At This Time'
    0x71:
      id: 'midpoint_peg_not_accepted_in_crossed_market'
      doc: 'Midpoint Peg Orders Are Not Accepted In A Crossed Market'
    0x75:
      id: 'loc_priced_more_aggressively_than_noii_reference_price'
      doc: 'Loc Order Priced More Aggressively Than The First Noii Reference Price'
    0x61:
      id: 'prm_invalid_message_format'
      doc: 'Pre Trade Risk Management Invalid Message Format'
    0x62:
      id: 'prm_no_quote'
      doc: 'Pre Trade Risk Management No Quote'
    0x63:
      id: 'prm_invalid_account'
      doc: 'Pre Trade Risk Management Invalid Account'
    0x64:
      id: 'prm_short_sale_violation'
      doc: 'Pre Trade Risk Management Short Sale Violation'
    0x65:
      id: 'prm_iso_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Iso Order Check'
    0x66:
      id: 'prm_gtc_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Gtc Order Check'
    0x67:
      id: 'prm_pre_market_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Premarket Order Check'
    0x68:
      id: 'prm_post_market_order_check'
      doc: 'Pre Trade Risk Management Order Rejected Due To Postmarket Order Check'
    0x69:
      id: 'prm_delayed_checking_flag_off'
      doc: 'Pre Trade Risk Management Order Rejected Due To The Delayed Checking Flag Turned Off'
    0x6a:
      id: 'prm_exceeded_maximum_shares_threshold'
      doc: 'Pre Trade Risk Management Exceeded Maximum Shares Threshold'
    0x6b:
      id: 'prm_exceeded_maximum_value_threshold'
      doc: 'Pre Trade Risk Management Exceeded Maximum Value Threshold'
    0x6d:
      id: 'prm_reject_all_orders'
      doc: 'Pre Trade Risk Management Order Rejected Due To Previous Command To Reject All Orders'
    0x6e:
      id: 'prm_invalid_price_fat_finger'
      doc: 'Pre Trade Risk Management Order Rejected Due To Invalid Price Fat Finger'
    0x70:
      id: 'prm_not_available'
      doc: 'Pre Trade Risk Management Prm Is Not Available'
    0x72:
      id: 'prm_snap_in_process'
      doc: 'Pre Trade Risk Management Snap Is In Process'
    0x73:
      id: 'prm_symbol_halted'
      doc: 'Pre Trade Risk Management Symbol Halted'
    0x74:
      id: 'prm_on_open'
      doc: 'Pre Trade Risk Management Order Rejected Due To On Open'
    0x76:
      id: 'prm_program_trading'
      doc: 'Pre Trade Risk Management Order Rejected Due To Program Trading'
    0x7b:
      id: 'prm_not_on_restricted_list'
      doc: 'Pre Trade Risk Management Order Rejected Due To Symbol Not Listed On Restricted List'
  liquidity:
    0x41:
      id: 'added'
      doc: 'Added'
    0x52:
      id: 'removed'
      doc: 'Removed'
    0x4a:
      id: 'non_displayed_adding_liquidity'
      doc: 'Nondisplayed Adding Liquidity'
    0x58:
      id: 'routed'
      doc: 'Routed'
    0x44:
      id: 'dot'
      doc: 'Dot'
    0x46:
      id: 'opening_trade'
      doc: 'Opening Trade On Nyse'
    0x47:
      id: 'on_close_order'
      doc: 'On Close Order On Nyse'
    0x4f:
      id: 'opening_cross'
      doc: 'Opening Cross'
    0x4d:
      id: 'opening_cross_x4d'
      doc: 'Opening Cross Imbalanceonly'
    0x43:
      id: 'closing_cross'
      doc: 'Closing Cross'
    0x4c:
      id: 'closing_cross_x4c'
      doc: 'Closing Cross Imbalanceonly'
    0x48:
      id: 'halt_ipo_cross'
      doc: 'Halt Ipo Cross'
    0x4b:
      id: 'halt_cross'
      doc: 'Halt Cross'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Re Routed By Nyse'
    0x53:
      id: 'odd_lot_execution'
      doc: 'Odd Lot Execution On Nyse'
    0x55:
      id: 'added_liquidity'
      doc: 'Added Liquidity On Nyse'
    0x42:
      id: 'routed_to_bx'
      doc: 'Routed To Bx'
    0x45:
      id: 'nyse_other'
      doc: 'Nyse Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'Routed To Psx'
    0x54:
      id: 'executed_in_open_close_or_re_open_on_arca'
      doc: 'Executed In Open Close Or Reopen On Arca'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'Passive Midpoint Execution Greyed Out Not Available'
    0x57:
      id: 'added_post_only'
      doc: 'Added Postonly Greyed Out Not Available'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'Removed Liquidity At A Midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'Added Liquidity Via A Midpoint Order'
    0x30:
      id: 'supplemental_order_execution'
      doc: 'Supplemental Order Execution'
    0x37:
      id: 'displayed_liquidity_adding_order_improves_the_nbbo'
      doc: 'Displayed Liquidityadding Order Improves The Nbbo'
    0x38:
      id: 'displayed_liquidity_adding_order_sets_the_qbbo_while_joining_the_nbbo'
      doc: 'Displayed Liquidityadding Order Sets The Qbbo While Joining The Nbbo'
    0x64:
      id: 'retail_designated_execution_that_removed_liquidity'
      doc: 'Retail Designated Execution That Removed Liquidity Greyed Out Not Available'
    0x65:
      id: 'retail_designated_execution_that_added_displayed_liquidity'
      doc: 'Retail Designated Execution That Added Displayed Liquidity'
    0x66:
      id: 'retail_designated_execution_that_added_non_displayed_liquidity'
      doc: 'Retail Designated Execution That Added Nondisplayed Liquidity Greyed Out Not Available'
    0x6a:
      id: 'rpi_order_provides_liquidity'
      doc: 'Rpi Retail Price Improving Order Provides Liquidity'
    0x72:
      id: 'retail_order_removes_rpi_liquidity'
      doc: 'Retail Order Removes Rpi Liquidity'
    0x74:
      id: 'retail_order_removes_price_improving_non_displayed_liquidity_other_than_rpi_liquidity'
      doc: 'Retail Order Removes Price Improving Nondisplayed Liquidity Other Than Rpi Liquidity'
    0x34:
      id: 'added_displayed_liquidity_in_a_group_a_symbol'
      doc: 'Added Displayed Liquidity In A Group A Symbol'
    0x35:
      id: 'added_non_displayed_liquidity_in_a_group_a_symbol'
      doc: 'Added Nondisplayed Liquidity In A Group A Symbol'
    0x36:
      id: 'removed_liquidity_in_a_group_a_symbol'
      doc: 'Removed Liquidity In A Group A Symbol'
    0x67:
      id: 'added_non_displayed_mid_point_liquidity_in_a_group_a_symbol'
      doc: 'Added Nondisplayed Midpoint Liquidity In A Group A Symbol'
    0x6e:
      id: 'midpoint_extended_life_order_execution'
      doc: 'Midpoint Extended Life Order Execution'
    0x76:
      id: 'midp_order_executed_on_away_nms_protected_market_center'
      doc: 'Midp Order Executed On Away Nms Protected Market Center'
    0x77:
      id: 'midp_order_executed_on_off_exchange_venue'
      doc: 'Midp Order Executed On Offexchange Venue'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous The Trade Was Deemed Clearly Erroneous'
    0x43:
      id: 'consent'
      doc: 'Consent The Two Parties Mutually Agreed To Break The Trade'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory The Trade Was Manually Broken By A Supervisory Terminal'
    0x58:
      id: 'external'
      doc: 'External The Trade Was Broken By An External Third Party'
  reference_price_type:
    0x49:
      id: 'intraday_indicative_value'
      doc: 'Intraday Indicative Value The Only Value Currently Supported'
  trade_correction_reason:
    0x4e:
      id: 'adjusted_to_nav'
      doc: 'Adjusted To Nav The Only Value Currently Allowed'

