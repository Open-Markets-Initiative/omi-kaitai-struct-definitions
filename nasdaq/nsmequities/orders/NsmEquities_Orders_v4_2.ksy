# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities Orders Ouch v4.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Orders
#   Encoding: Ouch
#   Version: 4.2
#   Date: 7/8/2019
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_nsmequities_orders_ouch_v4_2
  title: Nasdaq NsmEquities Orders Ouch v4.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market Orders Ouch v4.2'
doc-ref: https://nasdaqtrader.com/Trader.aspx?id=TradingSpecs

seq:
  - id: soup_bin_tcp_packet
    type: soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet'

types:
  soup_bin_tcp_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
      - id: payload
        size: packet_header.packet_length + 2 - 3
        type:
          switch-on: packet_header.packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
  packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::accepted_message': accepted_message
            'sequenced_message_type::replaced_message': replaced_message
            'sequenced_message_type::canceled_message': canceled_message
            'sequenced_message_type::aiq_cancelled_message': aiq_cancelled_message
            'sequenced_message_type::executed_message': executed_message
            'sequenced_message_type::broken_trade_message': broken_trade_message
            'sequenced_message_type::executed_with_reference_price_message': executed_with_reference_price_message
            'sequenced_message_type::trade_correction_message': trade_correction_message
            'sequenced_message_type::rejected_order_message': rejected_order_message
            'sequenced_message_type::cancel_pending_message': cancel_pending_message
            'sequenced_message_type::cancel_reject_message': cancel_reject_message
            'sequenced_message_type::order_priority_update_message': order_priority_update_message
            'sequenced_message_type::order_modified_message': order_modified_message
            'sequenced_message_type::sequenced_trade_now_message': sequenced_trade_now_message
  system_event_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See Event Codes below'
  accepted_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Buy/Sell Indicator'
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
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Values other than “A”, “P”, or “R” will be converted to “O” = Other'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Intermarket Sweep Eligibility'
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross Type'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order State'
      - id: bbo_weight_indicator
        type: u1
        enum: bbo_weight_indicator
        doc: 'BBO Weight indicator'
  replaced_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: replacement_order_token_alphanumeric_14
        type: str
        size: 14
        encoding: ASCII
        doc: 'The Replacement Order Token field as entered'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Buy/Sell Indicator'
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
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Values other than “A”, “P”, or “R” will be converted to “O” = Other'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Intermarket Sweep Eligibility'
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross Type'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order State'
      - id: previous_order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'The Order Token of the order that was replaced'
      - id: bbo_weight_indicator
        type: u1
        enum: bbo_weight_indicator
        doc: 'BBO Weight indicator'
  canceled_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: decrement_shares
        type: u4
        doc: 'The number of shares just decremented from the order. This number is incremental, not cumulative'
      - id: cancel_order_reason
        type: u1
        enum: cancel_order_reason
        doc: 'Reason the order was reduced or canceled'
  aiq_cancelled_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: decrement_shares
        type: u4
        doc: 'The number of shares just decremented from the order. This number is incremental, not cumulative'
      - id: cancel_order_reason
        type: u1
        enum: cancel_order_reason
        doc: 'Reason the order was reduced or canceled'
      - id: quantity_prevented_from_trading
        type: u4
        doc: 'Shares that would have executed if the trade would have occurred. Depending on AIQ type and the sizes of orders in question the value for this field could either be the same or different than the Decrement Shares field. For “Decrement both” they are always the same. For “Cancel oldest” they will be different if the incoming order is smaller than the resting order'
      - id: execution_price
        type: u4
        doc: 'Price at which the trade would have occurred'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
  executed_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: executed_shares
        type: u4
        doc: 'Incremental number of shares executed'
      - id: execution_price
        type: u4
        doc: 'Price at which the trade would have occurred'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
      - id: match_number
        type: u8
        doc: 'Assigned by NASDAQ to each match executed. Each match consists of one buy and one sell. The matching buy and sell executions share the same match number'
  broken_trade_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: match_number
        type: u8
        doc: 'Assigned by NASDAQ to each match executed. Each match consists of one buy and one sell. The matching buy and sell executions share the same match number'
      - id: broken_trade_reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reason the trade was broken. See currently supported Broken Trade Reasons table below. Clients should anticipate additions to this list and thus support all capital letters of the English alphabet'
  executed_with_reference_price_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: executed_shares
        type: u4
        doc: 'Incremental number of shares executed'
      - id: execution_price
        type: u4
        doc: 'Price at which the trade would have occurred'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
      - id: match_number
        type: u8
        doc: 'Assigned by NASDAQ to each match executed. Each match consists of one buy and one sell. The matching buy and sell executions share the same match number'
      - id: reference_price
        type: decimal_u4_4
        doc: 'The reference price associated with the execution. Implied decimal with scale 1e-4'
      - id: reference_price_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Only value currently supported is: I = Intraday Indicative Value'
  trade_correction_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: executed_shares
        type: u4
        doc: 'Incremental number of shares executed'
      - id: execution_price
        type: u4
        doc: 'Price at which the trade would have occurred'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity flag the order would have received'
      - id: match_number
        type: u8
        doc: 'Assigned by NASDAQ to each match executed. Each match consists of one buy and one sell. The matching buy and sell executions share the same match number'
      - id: reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Only value currently allowed is: N = Adjusted to NAV'
  rejected_order_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: rejected_order_reason
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reason the order was rejected. See currently supported Rejected Order Reasons below. Clients should anticipate additions to this list and thus support all capital letters of the English alphabet'
  cancel_pending_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
  cancel_reject_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
  order_priority_update_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: price
        type: decimal_u4_4
        doc: 'The price of the order. Please refer to the section in Data Types for more clarification. Implied decimal with scale 1e-4'
      - id: display
        type: u1
        enum: display
        doc: 'Display'
      - id: order_reference_number
        type: u8
        doc: 'The day-unique Order Reference Number assigned by NASDAQ to this order'
  order_modified_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Buy/Sell Indicator'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  sequenced_trade_now_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Timestamp – reflected as the number of nanoseconds past midnight'
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
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
        size: _parent.packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::replace_order_message': replace_order_message
            'unsequenced_message_type::cancel_order_message': cancel_order_message
            'unsequenced_message_type::modify_order_message': modify_order_message
            'unsequenced_message_type::trade_now_message': trade_now_message
  enter_order_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Buy/Sell Indicator'
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
        doc: 'Display'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Values other than “A”, “P”, or “R” will be converted to “O” = Other'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Intermarket Sweep Eligibility'
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross Type'
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
        doc: 'This must be filled out with the exact Order Token sent on the Enter Order Message or last Replace Order Message'
      - id: replacement_order_token_token_14
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
      - id: price
        type: decimal_u4_4
        doc: 'The price of the order. Please refer to the section in Data Types for more clarification. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u4
        doc: 'The number of seconds that this order should live before being automatically canceled. Special values for Time in Force are listed in Data Types above'
      - id: display
        type: u1
        enum: display
        doc: 'Display'
      - id: intermarket_sweep_eligibility
        type: u1
        enum: intermarket_sweep_eligibility
        doc: 'Intermarket Sweep Eligibility'
      - id: minimum_quantity
        type: u4
        doc: 'Specifies the minimum acceptable quantity to execute'
  cancel_order_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  modify_order_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Buy/Sell Indicator'
      - id: shares
        type: u4
        doc: 'Total number of shares. Must be greater than zero and less than 1,000,000'
  trade_now_message:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        doc: 'As described above in Data Types. You can put any information you like. Token must be day-unique for each OUCH account'
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  packet_type:
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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire NASDAQ system:'
    0x41:
      id: 'accepted_message'
      doc: 'Functionality that is not available will be greyed out in the specifications. Any changes will be conveyed via the NASDAQ Head Trader Alerts or Technical Updates.'
    0x55:
      id: 'replaced_message'
      doc: 'This message acknowledges the receipt and acceptance of a valid Replace Order Message. The data fields from the Replace Order Message are echoed back in this message. Note that the accepted values may differ from the entered values for some fields. You will receive one and only one of these two for each replacement.'
    0x43:
      id: 'canceled_message'
      doc: 'A Canceled Message informs you that an order has been reduced or canceled. This could be acknowledging a Cancel Order Message, or it could be the result of the order timing out or being canceled automatically.'
    0x44: 'aiq_cancelled_message'
    0x45:
      id: 'executed_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade Message informs you that an execution has been broken. The trade is no longer good and will not clear. The reason for the break is given.'
    0x47:
      id: 'executed_with_reference_price_message'
      doc: 'An Executed Order Message informs you that all or part of an order has been executed.'
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
    0x4e:
      id: 'sequenced_trade_now_message'
      doc: 'The Trade Now Message is used to request that an order remove against any available shares of locking contra-side orders. Usage of the Trade Now Message will not affect order priority on the book'
  event_code:
    0x53:
      id: 'start_of_day_this_is_always_the_first_message_each_day'
      doc: 'Start of Day — This is always the first message each day. It indicates that NASDAQ is open and ready to start accepting orders.'
    0x45:
      id: 'end_of_day_this_indicates_that_nasdaq_is_now_closed_and_will_not_accept_any_new_orders_or_replaces_in_this_session'
      doc: 'End of Day — This indicates that NASDAQ is now closed and will not accept any new orders or replaces in this session. There will be no further executions during this session; however, it is still possible to receive Broken Trade Messages and Canceled Order Messages'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'buy order.'
    0x53:
      id: 'sell'
      doc: 'sell order'
    0x54:
      id: 'sell_short'
      doc: 'sell short, client affirms ability to borrow securities in good deliverable form for delivery within three business days'
    0x45:
      id: 'sell_short_exempt'
      doc: 'sell short exempt, client affirms ability to borrow securities in good deliverable form for delivery within three business days'
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
      id: 'mid_point'
      doc: 'Mid-Point Peg'
    0x57:
      id: 'mid_point_x57'
      doc: 'Mid-Point Peg Post Only'
    0x4c:
      id: 'post_only_and_attributable'
      doc: 'Post-Only and Attributable – Price to Display'
    0x4f:
      id: 'retail_order'
      doc: 'Retail Order Type 1'
    0x54:
      id: 'retail_order_x54'
      doc: 'Retail Order Type 2'
    0x51:
      id: 'retail_price'
      doc: 'Retail Price Improvement Order'
    0x6d:
      id: 'mid_point_x6d'
      doc: 'Mid-Point Peg and Mid-Point Trade Now'
    0x6e:
      id: 'non_display_and_mid_point'
      doc: 'Non-Display and Mid-Point Trade Now'
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
      id: 'tradeat'
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
    0x52:
      id: 'retail'
      doc: 'Retail'
    0x45:
      id: 'extended'
      doc: 'Extended Life'
  order_state:
    0x4c:
      id: 'order'
      doc: 'Order Live'
    0x44:
      id: 'order_x44'
      doc: 'Order Dead'
  bbo_weight_indicator:
    0x30:
      id: 'less_than_point_two_percent'
      doc: 'Less Than Point Two Percent'
    0x31:
      id: 'less_than_one_percent'
      doc: 'Less Than One Percent'
    0x32:
      id: 'less_than_two_percent'
      doc: 'Less Than Two Percent'
    0x33:
      id: 'greater_than_two_percent'
      doc: 'Greater Than Two Percent'
    0x53:
      id: 'sets_the_qbbo'
      doc: 'Sets the QBBO while joining the NBBO'
    0x4e:
      id: 'improves_the_nbbo_upon_entry'
      doc: 'Improves the NBBO'
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
      id: 'post_only_cancel'
      doc: 'Post Only Cancel. This Post Only order was cancelled because it would have been price slid for NMS.'
    0x47:
      id: 'post_only_cancel_x47'
      doc: 'Post Only Cancel. This Post Only order was cancelled because it would have been price slid due to a contra side displayed order on the book.'
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
      id: 'nondisplayed'
      doc: 'Non-displayed adding liquidity'
    0x57:
      id: 'added_x57'
      doc: 'Added post-only'
    0x6d:
      id: 'removed_x6d'
      doc: 'Removed liquidity at a midpoint'
    0x6b:
      id: 'added_x6b'
      doc: 'Added liquidity via a midpoint order'
    0x30:
      id: 'supplemental'
      doc: 'Supplemental Order Execution'
    0x37:
      id: 'displayed'
      doc: 'Displayed, liquidity-adding order improves the NBBO'
    0x38:
      id: 'displayed_x38'
      doc: 'Displayed, liquidity-adding order sets the QBBO while joining the NBBO'
    0x64:
      id: 'retail_designated'
      doc: 'Retail designated execution that removed liquidity'
    0x65:
      id: 'retail_designated_x65'
      doc: 'Retail designated execution that added displayed liquidity'
    0x66:
      id: 'retail_designated_x66'
      doc: 'Retail designated execution that added non-displayed liquidity'
    0x6a:
      id: 'rpi_retail_price_improving'
      doc: 'RPI (Retail Price Improving) order provides liquidity'
    0x72:
      id: 'retail_order'
      doc: 'Retail Order removes RPI liquidity'
    0x74:
      id: 'retail_order_x74'
      doc: 'Retail Order removes price improving non-displayed liquidity other than RPI liquidity'
    0x34:
      id: 'added_x34'
      doc: 'Added displayed liquidity in a Group A symbol'
    0x35:
      id: 'added_x35'
      doc: 'Added non-displayed liquidity in a Group A symbol'
    0x36:
      id: 'removed_x36'
      doc: 'Removed liquidity in a Group A symbol'
    0x67:
      id: 'added_x67'
      doc: 'Added non-displayed mid-point liquidity in a Group A symbol'
    0x6e:
      id: 'midpoint'
      doc: 'Midpoint Extended Life Order execution'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'The system event message type is used to signal a market or data feed handler event. The format is as follows:'
    0x55:
      id: 'replace_order_message'
      doc: 'The Replace Order Message allows you to alter most of the attributes of an order in a single message. This is more efficient than canceling an existing order and immediately succeeding it with a new order. Replacing an order always gives it a new timestamp for its time priority on the book. If you wish you simply partially cancel an order and retain its time priority, send a Cancel Order Message instead.'
    0x58:
      id: 'cancel_order_message'
      doc: 'The Cancel Order Message is used to request that an order be canceled or reduced. In the Cancel Order Message, you must specify the new "intended order size" for the order. The "intended order size" is the maximum number of shares that can be executed in total after the cancel is applied.'
    0x4d:
      id: 'modify_order_message'
      doc: 'The Modify Order Message is used to request modifications that will not affect order priority on the book unless the share amount is increased. Since priority of the order does not change (exception noted), allowed modifications are restricted to only the ones specified in the message details below.'
    0x4e:
      id: 'trade_now_message'
      doc: 'The Trade Now Message is used to request that an order remove against any available shares of locking contra-side orders. Usage of the Trade Now Message will not affect order priority on the book'
  customer_type:
    0x52:
      id: 'retail_designated'
      doc: 'Retail designated order'
    0x4e:
      id: 'not_a_retail_designated'
      doc: 'Not a retail designated order'
    0x20:
      id: 'default_field'
      doc: 'Default'

