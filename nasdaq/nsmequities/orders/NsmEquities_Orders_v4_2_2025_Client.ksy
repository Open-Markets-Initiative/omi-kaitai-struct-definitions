# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Orders Ouch v4.2.2025
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Orders
#   Encoding: Ouch
#   Version: 4.2.2025
#   Date: 10/7/2025
#   Specification: OUCH4.2.pdf
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
  id: nasdaq_nsmequities_orders_ouch_v4_2_2025_client
  title: Nasdaq NsmEquities Orders Ouch v4.2.2025
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Orders Ouch v4.2.2025'
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
      - id: debug_text
        type: str
        size: _parent.client_packet_header.packet_length - 1
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
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'As described above in Data Types. You can put any information you like. Token must be day- unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: stock
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u4_4
        doc: 'The price of the order. Please refer to the section in Data Types for more clarification. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u4
        enum: time_in_force
        doc: 'The number of seconds that this order should live before being automatically canceled. Special values for Time in Force are listed in Data Types above'
      - id: firm
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field should contain all caps. Firm Identifier for the order entry firm. One logical OUCH Account can potentially enter orders for multiple firms in a Service Bureau configuration. If this field is blank-filled, the default firm for the OUCH Account will be used'
      - id: display
        type: u1
        enum: display
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Values other than “A”, “P”, or “R” will be converted to “O” = Other'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
      - id: cross_type
        type: u1
        enum: cross_type
      - id: customer_type
        type: u1
        enum: customer_type
        doc: 'Indicates if the order is a retail designated order (optional field)'
  replace_order_message:
    seq:
      - id: existing_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'This must be filled out with the exact Order Token sent on the Enter Order Message or last Replace Order Message'
      - id: replacement_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Replacement Order Token field as entered'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: price
        type: decimal_u4_4
        doc: 'The price of the order. Please refer to the section in Data Types for more clarification. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u4
        enum: time_in_force
        doc: 'The number of seconds that this order should live before being automatically canceled. Special values for Time in Force are listed in Data Types above'
      - id: display
        type: u1
        enum: display
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
  cancel_order_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'As described above in Data Types. You can put any information you like. Token must be day- unique for each OUCH account'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  modify_order_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'As described above in Data Types. You can put any information you like. Token must be day- unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
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
      doc: 'The Enter Order Message lets you enter a new order into NASDAQ. Each new order must have an Order Token that is unique for that day and that logical OUCH account. If you send a valid order, you should receive an acknowledgement as an Accepted Message or an Atomically Accepted and Canceled Message. If you send an Enter Order Message with a previously used Order Token, the new order will be ignored.'
    0x55:
      id: 'replace_order_message'
      doc: 'The Replace Order Message allows you to alter most of the attributes of an order in a single message. This is more efficient than canceling an existing order and immediately succeeding it with a new order. Replacing an order always gives it a new timestamp for its time priority on the book. If you wish you simply partially cancel an order and retain its time priority, send a Cancel Order Message instead.'
    0x58:
      id: 'cancel_order_message'
      doc: 'The Cancel Order Message is used to request that an order be canceled or reduced. In the Cancel Order Message, you must specify the new "intended order size" for the order. The "intended order size" is the maximum number of shares that can be executed in total after the cancel is applied.'
    0x4d:
      id: 'modify_order_message'
      doc: 'The Modify Order Message is used to request modifications that will not affect order priority on the book unless the share amount is increased. Since priority of the order does not change (exception noted), allowed modifications are restricted to only the ones specified in the message details below.'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'buy order'
    0x53:
      id: 'sell'
      doc: 'sell order'
    0x54:
      id: 'sell_short'
      doc: 'sell short, client affirms ability to borrow securities in good deliverable form for delivery within three business days'
    0x45:
      id: 'sell_short_exempt'
      doc: 'sell short exempt, client affirms ability to borrow securities in good deliverable form for delivery within three business days'
  time_in_force:
    0:
      id: 'immediate_or_cancel'
      doc: 'Immediate or cancel — If no match for the order is available at the moment the order is accepted, any unexecuted shares in the order are immediately canceled.'
    99998:
      id: 'market_hours'
      doc: 'Market Hours — Indicates that the order should live until the market close on the primary market for the security'
    99999:
      id: 'system_hours'
      doc: 'System Hours — Indicates that the order should live until the end of the NASDAQ trading day'
    99996:
      id: 'extended_trading_close'
      doc: 'Extended Trading Close – Indicates that the order should live until the conclusion of the Extended Trading Close for the security'
  display:
    0x41:
      id: 'attributable_price'
      doc: 'Attributable-Price to Display'
    0x59:
      id: 'anonymous_price'
      doc: 'Anonymous-Price to Comply'
    0x4e:
      id: 'non_display'
      doc: 'Non-Display'
    0x50:
      id: 'post_only'
      doc: 'Post-Only'
    0x49:
      id: 'imbalance_only'
      doc: 'Imbalance-Only (for opening and closing cross only)'
    0x4d:
      id: 'mid_point_peg'
      doc: 'Mid-Point Peg'
    0x57:
      id: 'mid_point_peg_post_only'
      doc: 'Mid-Point Peg Post Only'
    0x4c:
      id: 'post_only_and_attributable'
      doc: 'Post-Only and Attributable – Price to Display'
    0x4f:
      id: 'retail_order_type_1'
      doc: 'Retail Order Type 1'
    0x54:
      id: 'retail_order_type_2'
      doc: 'Retail Order Type 2'
    0x51:
      id: 'retail_price'
      doc: 'Retail Price Improvement Order'
    0x6d:
      id: 'mid_point_peg_and_mid_point_trade_now'
      doc: 'Mid-Point Peg and Mid-Point Trade Now'
    0x6e:
      id: 'non_display_and_mid_point'
      doc: 'Non-Display and Mid-Point Trade Now'
    0x42:
      id: 'm_elo_and_continuous_book_midpoint'
      doc: 'M-ELO and Continuous Book Midpoint'
  capacity:
    0x4f:
      id: 'other'
      doc: 'Other'
    0x41:
      id: 'agency'
      doc: 'agency'
    0x50:
      id: 'principal'
      doc: 'principal'
    0x52:
      id: 'riskless'
      doc: 'riskless'
  intermarket_sweep_eligibility:
    0x59:
      id: 'eligible'
      doc: 'eligible'
    0x4e:
      id: 'not_eligible'
      doc: 'not eligible'
    0x79:
      id: 'trade_at'
      doc: 'Trade-at Intermarket Sweep Order'
  cross_type:
    0x4e:
      id: 'no_cross'
      doc: 'No cross (continuous market)'
    0x4f:
      id: 'opening'
      doc: 'Opening cross'
    0x43:
      id: 'closing'
      doc: 'Closing cross'
    0x48:
      id: 'halt_ipo_cross'
      doc: 'Halt/IPO cross (Must be market price, refer to Prices in Data Types)'
    0x53:
      id: 'supplemental'
      doc: 'Supplemental Order'
    0x45:
      id: 'extended'
      doc: 'Extended Life'
    0x41:
      id: 'extended_trading_close'
      doc: 'Extended Trading Close'
  customer_type:
    0x52:
      id: 'retail_designated'
      doc: 'Retail designated order'
    0x4e:
      id: 'not_a_retail_designated'
      doc: 'Not a retail designated order'
    0x20:
      id: 'default_field'
      doc: 'use the default configured on the port for your firm'
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
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire NASDAQ system:'
    0x41:
      id: 'accepted_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Enter Order Message. The data fields from the Enter Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields.'
    0x55:
      id: 'replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. The data fields from the Replace Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields. You will receive one and only one of these two for each replacement.'
    0x43:
      id: 'canceled_message'
      doc: 'A Canceled Message informs you that an order has been reduced or canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order timing out or being canceled automatically.'
    0x44: 'aiq_cancelled_message'
    0x45:
      id: 'executed_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear. The reason for the break is given.'
    0x47:
      id: 'executed_with_reference_price_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
    0x4a:
      id: 'rejected_order_message'
      doc: 'A Rejected Message may be sent in response to an Enter Order Message or Replace Order Message if the order or replace cannot be accepted at this time. The reason for the rejection is given.'
    0x50:
      id: 'cancel_pending_message'
      doc: 'A Cancel Pending Message is sent in response to a cancel request for a cross order during a pre-cross late period signifying that it cannot be canceled at this time, but any unexecuted portion of this order will automatically be canceled immediately after the cross completes. This message will only be sent once for a given token. Duplicate cancel requests for the same token will be ignored by OUCH.'
    0x49:
      id: 'cancel_reject_message'
      doc: 'A Cancel Reject Message is sent in response to a partial cancel request (with non-zero “intended order size”) for a cross order during a pre-cross late period signifying that it cannot be partially canceled at this time. No automatic cancel will be scheduled for this order. Clients could repeat their request for any unexecuted portion of the order after the cross completes. This message will only be sent once for a given token. Duplicate cancel requests for the same token will be ignored by OUCH.'
    0x54:
      id: 'order_priority_update_message'
      doc: 'A Priority Update Message is sent whenever priority of the order has been changed by the system.'
    0x4d:
      id: 'order_modified_message'
      doc: 'An Order Modified Message is sent in response to an order modify request.'
  event_code:
    0x53:
      id: 'start_of_day_this_is_always_the_first_message_each_day'
      doc: 'Start of Day — This is always the first message each day. It indicates that NASDAQ is open and ready to start accepting orders.'
    0x45:
      id: 'end_of_day_this_indicates_that_nasdaq_is_now_closed_and_will_not_accept_any_new_orders_or_replaces_in_this_session'
      doc: 'End of Day — This indicates that NASDAQ is now closed and will not accept any new orders or replaces in this session. There will be no further executions during this session; however, it is still possible to receive Broken Trade Messages and Canceled Order Messages'
  order_state:
    0x4c:
      id: 'order_live'
      doc: 'Order Live'
    0x44:
      id: 'order_dead'
      doc: 'Order Dead'
  bbo_weight_indicator:
    0x30:
      id: 'less_than_point_two_percent'
      doc: '0-0.2%'
    0x31:
      id: 'less_than_one_percent'
      doc: '0.2%-1%'
    0x32:
      id: 'less_than_two_percent'
      doc: '1%-2%'
    0x33:
      id: 'greater_than_two_percent'
      doc: 'greater than 2%'
    0x20:
      id: 'unspecified'
      doc: 'unspecified'
    0x53:
      id: 'sets_the_qbbo'
      doc: 'Sets the QBBO while joining the NBBO'
    0x4e:
      id: 'improves_the_nbbo_upon_entry'
      doc: 'Improves the NBBO upon entry'
  cancel_order_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User requested cancel. Sent in response to a Cancel Order Message or a Replace Order Message'
    0x49:
      id: 'immediate_or_cancel_order'
      doc: 'Immediate or Cancel order. This order was originally sent with a timeout of zero and no further matches were available on the book so the remaining unexecuted shares were immediately canceled'
    0x54:
      id: 'timeout'
      doc: 'Timeout. The Time In Force for this order has expired'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory. This order was manually canceled or reduced by a NASDAQ supervisory terminal. This is usually in response to a participant request via telephone.'
    0x44:
      id: 'this_order_cannot_be_executed_because_of_a_regulatory_restriction'
      doc: 'This order cannot be executed because of a regulatory restriction (e.g.: trade through restrictions).'
    0x51:
      id: 'self_match_prevention'
      doc: 'Self Match Prevention. The order was cancelled because it would have executed with an existing order entered by the same MPID.'
    0x5a:
      id: 'system_cancel'
      doc: 'System cancel. This order was cancelled by the system.'
    0x43:
      id: 'cross_canceled'
      doc: 'Cross canceled. Non-bookable cross orders that did not execute in the cross.'
    0x4b:
      id: 'this_order_cannot_be_executed'
      doc: 'This order cannot be executed because of Market Collars'
    0x48:
      id: 'halted'
      doc: 'Halted. The on-open order was canceled because the symbol remained halted after the opening cross completed.'
    0x58:
      id: 'open_protection'
      doc: 'Open Protection. Orders that are cancelled as a result of the Opening Price Protection Threshold.'
    0x45:
      id: 'closed'
      doc: 'Closed. Any DAY order that was received after the closing cross is complete in a given symbol will receive this cancel reason.'
    0x46:
      id: 'post_only_cancel_for_nms'
      doc: 'Post Only Cancel. This Post Only order was cancelled because it would have been price slid for NMS.'
    0x47:
      id: 'post_only_cancel_due_to_contra_side_displayed_order'
      doc: 'Post Only Cancel. This Post Only order was cancelled because it would have been price slid due to a contra side displayed order on the book'
  liquidity_flag:
    0x41:
      id: 'added'
      doc: 'Added'
    0x52:
      id: 'removed'
      doc: 'Removed'
    0x4f:
      id: 'opening'
      doc: 'Opening Cross'
    0x4d:
      id: 'opening_cross'
      doc: 'Opening Cross (imbalance-only)'
    0x43:
      id: 'closing'
      doc: 'Closing Cross'
    0x4c:
      id: 'closing_cross'
      doc: 'Closing Cross (imbalance-only)'
    0x48:
      id: 'halt_ipo'
      doc: 'Halt/IPO Cross'
    0x4b:
      id: 'halt'
      doc: 'Halt Cross'
    0x4a:
      id: 'non_displayed'
      doc: 'Non-displayed adding liquidity'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'Passive Midpoint Execution'
    0x57:
      id: 'added_post_only'
      doc: 'Added post-only'
    0x6d:
      id: 'removed_at_midpoint'
      doc: 'Removed liquidity at a midpoint'
    0x6b:
      id: 'added_via_midpoint'
      doc: 'Added liquidity via a midpoint order'
    0x30:
      id: 'supplemental'
      doc: 'Supplemental Order Execution'
    0x37:
      id: 'improves_nbbo'
      doc: 'Displayed, liquidity-adding order improves the NBBO'
    0x38:
      id: 'sets_qbbo_while_joining_nbbo'
      doc: 'Displayed, liquidity-adding order sets the QBBO while joining the NBBO'
    0x64:
      id: 'retail_designated_removed_liquidity'
      doc: 'Retail designated execution that removed liquidity'
    0x65:
      id: 'retail_designated_added_displayed_liquidity'
      doc: 'Retail designated execution that added displayed liquidity'
    0x66:
      id: 'retail_designated_added_non_displayed_liquidity'
      doc: 'Retail designated execution that added non-displayed liquidity'
    0x6a:
      id: 'rpi_retail_price_improving'
      doc: 'RPI (Retail Price Improving) order provides liquidity'
    0x72:
      id: 'retail_order_removes_rpi_liquidity'
      doc: 'Retail Order removes RPI liquidity'
    0x74:
      id: 'retail_order_removes_other_price_improving_liquidity'
      doc: 'Retail Order removes price improving non-displayed liquidity other than RPI liquidity'
    0x34:
      id: 'added_displayed_in_group_a'
      doc: 'Added displayed liquidity in a Group A symbol'
    0x36:
      id: 'removed_in_group_a'
      doc: 'Removed liquidity in a Group A symbol'
    0x67:
      id: 'added_non_displayed_mid_point_in_group_a'
      doc: 'Added non-displayed mid-point liquidity in a Group A symbol'
    0x6e:
      id: 'midpoint'
      doc: 'Midpoint Extended Life Order execution'
    0x69:
      id: 'extended_trading_close_execution'
      doc: 'Extended Trading Close execution'
    0x75:
      id: 'added_non_displayed_liquidity_via_a_reserve_order'
      doc: 'Added non-displayed liquidity via a Reserve order'
    0x32:
      id: 'added_in_the_pre_market'
      doc: 'Added in the pre-market'
    0x33:
      id: 'removed_in_the_pre_market'
      doc: 'Removed in the pre-market'
    0x35:
      id: 'displayed_liquidity_adding_order_improves_the_nbbo_in_the_pre_market'
      doc: 'Displayed, liquidity-adding order improves the NBBO in the pre-market'
    0x39:
      id: 'non_displayed_adding_liquidity_in_the_pre_market'
      doc: 'Non-displayed adding liquidity in the pre-market'
  broken_trade_reason:
    0x45:
      id: 'erroneous'
      doc: 'Erroneous — The trade was deemed clearly erroneous.'
    0x43:
      id: 'consent'
      doc: 'Consent — The two parties mutually agreed to break the trade.'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory — The trade was manually broken by a NASDAQ supervisory terminal.'
    0x58:
      id: 'external'
      doc: 'External — The trade was broken by an external third party.'
  reference_price_type:
    0x49:
      id: 'intraday_indicative_value'
      doc: 'Intraday Indicative Value'
  rejected_order_reason:
    0x61:
      id: 'risk_restricted_stock'
      doc: 'Risk: Restricted Stock'
    0x62:
      id: 'risk_short_sell_restricted'
      doc: 'Risk: Short Sell Restricted'
    0x63:
      id: 'risk_order_type_restricted'
      doc: 'Risk: Order Type Restricted'
    0x43:
      id: 'nasdaq_is_closed'
      doc: 'NASDAQ is closed'
    0x64:
      id: 'risk_exceeds_adv_limit'
      doc: 'Risk: Exceeds ADV Limit'
    0x44:
      id: 'invalid_display_type'
      doc: 'Invalid Display Type - Sent when Display Type entered cannot be accepted in current circumstances and can''t be simply converted to a valid Display Type.'
    0x65:
      id: 'risk_fat_finger'
      doc: 'Risk: Fat Finger'
    0x48:
      id: 'halted'
      doc: 'Halted — There is currently a trading halt so no orders can be accepted in this stock at this time.'
    0x4c:
      id: 'requested_firm_not_authorized_for_requested_clearing_type_on_this_account'
      doc: 'Requested firm not authorized for requested clearing type on this account — To authorize additional firms, use the NASDAQ Service Bureau Agreement.'
    0x6d:
      id: 'risk_max_shares_exceeded'
      doc: 'Risk: Max Shares Exceeded'
    0x4d:
      id: 'outside_of_permitted_times'
      doc: 'Outside of permitted times for requested clearing type'
    0x6e:
      id: 'risk_max_notional_exceeded'
      doc: 'Risk: Max Notional Exceeded'
    0x4e:
      id: 'invalid_minimum'
      doc: 'Invalid Minimum Quantity'
    0x6f:
      id: 'there_is_no_reference_price'
      doc: 'There is no reference price in the 9:28 a.m. ET NOII dissemination and no previous day’s closing price, or there is no reference price in the 3:50 p.m. and 3:55 p.m. ET NOII dissemination, and so no LOO or LOC orders, respectively, can be accepted in this stock at this time'
    0x4f:
      id: 'other'
      doc: 'Other'
    0x71:
      id: 'midpoint_peg_orders_are_not_accepted'
      doc: 'Midpoint Peg orders are not accepted in a crossed market'
    0x72:
      id: 'risk_market_impact'
      doc: 'Risk: Market Impact'
    0x52:
      id: 'this_order_is_not_allowed_in_this_type_of_cross'
      doc: 'This order is not allowed in this type of cross (stock or time restrictions)'
    0x53:
      id: 'invalid_stock'
      doc: 'Invalid stock — The stock field must be a valid issue, tradable on NASDAQ.'
    0x54:
      id: 'test_mode'
      doc: 'Test Mode — This OUCH Account is configured for test mode and is not able to accept orders in non-TEST securities.'
    0x75:
      id: 'order_priced_more_aggressively'
      doc: 'LOO Order priced more aggressively than either the 9:28 a.m. ET NOII reference price or the previous day’s closing price; or LOC Order priced more aggressively than either the 3:50 p.m. or 3:55 p.m. NOII reference prices'
    0x76:
      id: 'risk_aggregate_exposure_exceeded'
      doc: 'Risk: Aggregate Exposure Exceeded'
    0x56:
      id: 'retail_not_allowed'
      doc: 'Retail Not Allowed'
    0x77:
      id: 'risk_symbol_message_rate_restriction'
      doc: 'Risk: Symbol Message Rate Restriction'
    0x57:
      id: 'invalid_midpoint'
      doc: 'Invalid Midpoint Post Only Price'
    0x78:
      id: 'risk_port_message_rate_restriction'
      doc: 'Risk: Port Message Rate Restriction'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid price'
    0x79:
      id: 'risk_duplicate_message_rate_restriction'
      doc: 'Risk: Duplicate Message Rate Restriction'
    0x5a:
      id: 'shares_exceeds_configured_safety_threshold'
      doc: 'Shares exceeds configured safety threshold — The number of shares entered must be less than the safety threshold configured for this Account. The safety threshold can be added/updated through NASDAQ Subscriber Services.'

