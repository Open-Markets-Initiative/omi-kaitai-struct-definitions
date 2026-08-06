# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis AquisEquities TradingProtocol Atp v4.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Aquis Trading Protocol
#   Encoding: Aquis Trading Protocol
#   Version: 4.0
#   Date: 8/1/2025
#   Specification: Production_Aquis_ATP_Technical_Specification_v4_0_f0cd559010.pdf
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
  id: aquisequities_tradingprotocol_v4_0
  title: Aquis AquisEquities TradingProtocol Atp v4.0
  license: GPL-3.0
  endian: le

doc: 'Aquis Exchange Aquis Equities Aquis Trading Protocol Atp v4.0'
doc-ref: https://www.aquis.eu/markets/documents

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Aquis Atp Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis Atp message header'
      - id: payload
        size: message_header.msg_length - 7
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::login_message': login_message
            'msg_type::login_response_message': login_response_message
            'msg_type::logout_message': logout_message
            'msg_type::order_add_message': order_add_message
            'msg_type::order_add_extended_message': order_add_extended_message
            'msg_type::order_cancel_message': order_cancel_message
            'msg_type::order_modify_message': order_modify_message
            'msg_type::order_modify_extended_message': order_modify_extended_message
            'msg_type::order_add_response_message': order_add_response_message
            'msg_type::order_cancel_response_message': order_cancel_response_message
            'msg_type::order_modify_response_message': order_modify_response_message
            'msg_type::iceberg_order_refresh_message': iceberg_order_refresh_message
            'msg_type::trade_capture_message': trade_capture_message
            'msg_type::trade_capture_response_message': trade_capture_response_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_bust_message': trade_bust_message
            'msg_type::ioi_add_message': ioi_add_message
            'msg_type::ioi_invite_message': ioi_invite_message
            'msg_type::ioi_firmup_message': ioi_firmup_message
  message_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of message including this header'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Atp Message type'
      - id: msg_seq_no
        type: u4
        doc: 'Message sequence number, from the user or Aquis'
  login_message:
    seq:
      - id: protocol_version
        type: u2
        doc: 'Version of the protocol being used'
      - id: sender_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Value as agreed with Aquis to identify the Member’s ATP session'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        doc: 'Password as agreed with Aquis to verify the user'
      - id: inactivity_timeout
        type: u2
        doc: 'Optional inactivity timeout, in seconds'
      - id: atp_seq_no
        type: u4
        doc: 'The next sequence number that the trading Member is expecting to receive on messages from Aquis'
  login_response_message:
    seq:
      - id: result_code
        type: u1
        enum: result_code
        doc: 'Login result code'
      - id: client_seq_no
        type: u4
        doc: 'Next sequence number Aquis expects to receive'
  logout_message:
    seq:
      - id: logout_reason_code
        type: u1
        enum: logout_reason_code
        doc: 'Reason code for logout'
      - id: reason_text
        type: str
        size: 32
        encoding: ASCII
        doc: 'Text describing reason for logout'
  order_add_message:
    seq:
      - id: security_id_u_162
        type: u2
        doc: 'Numeric security identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier; 1 = House Account, 2 or above = agreed Client Account code'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
  flags:
    seq:
      - id: liq_prov
        type: b1
        doc: 'Whether the order relates to liquidity provision activity'
      - id: algo_trade_flag
        type: b1
        doc: 'Whether the order was generated by an algorithm'
      - id: dea_flag
        type: b1
        doc: 'Whether the order originates from a Direct Electronic Access client'
      - id: reserved_5
        type: b5
        doc: 'Reserved'
  table_select_1:
    seq:
      - id: party_role
        type: b4
        enum: party_role
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        enum: party_role_qualifier
        doc: 'Party role qualifier'
  table_select_2:
    seq:
      - id: party_role
        type: b4
        enum: party_role
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        enum: party_role_qualifier
        doc: 'Party role qualifier'
  table_select_3:
    seq:
      - id: party_role
        type: b4
        enum: party_role
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        enum: party_role_qualifier
        doc: 'Party role qualifier'
  order_add_extended_message:
    seq:
      - id: security_id_u_162
        type: u2
        doc: 'Numeric security identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier; 1 = House Account, 2 or above = agreed Client Account code'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
      - id: display_quantity
        type: u4
        doc: 'Display quantity for an iceberg order; set to 0 for non-iceberg orders'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity of an order to be executed; 0 = no minimum quantity'
      - id: extended_order_flags
        type: extended_order_flags
        doc: 'Extended order flags'
      - id: reserved_u_648
        type: u8
        doc: 'Reserved'
      - id: designated_order_id
        type: u8
        doc: 'The order ID of the contra as provided by OptimX; set to 0 if not applicable'
      - id: reserved_u_162
        type: u2
        doc: 'Reserved'
      - id: peg_difference
        type: s8
        doc: 'Only applicable for AoD Near Touch Pegged orders; value added to the peg calculation'
  extended_order_flags:
    seq:
      - id: stp_enable
        type: b1
        doc: 'Self-trade prevention; only valid when OrderType=12; 0 = No restriction, 1 = Enabled'
      - id: lis_only
        type: b1
        doc: 'LIS executions only; only valid when OrderType=12; 0 = No restriction, 1 = LIS executions only'
      - id: routetolit
        type: b1
        doc: 'Route to Lit; 0 = Order is not routed, 1 = Route to Lit'
      - id: routing
        type: b3
        enum: routing
        doc: 'Behaviour of the Lit portion of a Dark-to-Lit sweep order. ignored when Routetolit = 0'
      - id: reserved_2
        type: b2
        doc: 'Reserved'
  order_cancel_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
  order_modify_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
  order_modify_extended_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: display_quantity
        type: u4
        doc: 'Display quantity for an iceberg order; set to 0 for non-iceberg orders'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity of an order to be executed; 0 = no minimum quantity'
      - id: reserved_u_648
        type: u8
        doc: 'Reserved'
  order_add_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: market_data_id
        type: u4
        doc: 'The ID of this order as seen in the Aquis market data; zero if the order is cancelled (IOC) or fully traded on entry'
      - id: status
        type: status
        doc: 'Order status and reason code'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded, if any'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: order_add_response_flags
        type: order_add_response_flags
        doc: 'Order add response flags'
  status:
    seq:
      - id: reason_code
        type: b5
        doc: 'Reason code if rejected or cancelled; otherwise zero'
      - id: order_status
        type: b3
        enum: order_status
        doc: 'Order status'
  order_add_response_flags:
    seq:
      - id: reserved_6
        type: b6
        doc: 'Reserved'
      - id: lis
        type: b1
        enum: lis
        doc: 'LIS indicator set by the system'
      - id: dark_flag
        type: b1
        doc: 'Indicates if an order is a dark order'
  order_cancel_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: request_ref
        type: u4
        doc: 'Sequence number of the trading Member''s Order Cancel message; zero for forced cancels generated by Aquis or cancel messages from the MaC'
      - id: status
        type: status
        doc: 'Order status and reason code'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  order_modify_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: request_ref
        type: u4
        doc: 'Sequence number of the trading Member''s Order Cancel message; zero for forced cancels generated by Aquis or cancel messages from the MaC'
      - id: status
        type: status
        doc: 'Order status and reason code'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: order_modify_response_flags_u_81
        type: u1
        doc: 'Order modify response flags'
  iceberg_order_refresh_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: orig_aqx_ord_id
        type: u4
        doc: 'The ID of the original order as seen in the Aquis market data'
      - id: new_aqx_ord_id
        type: u4
        doc: 'The ID of the iceberg order refresh as seen in the Aquis market data'
      - id: quantity
        type: u4
        doc: 'Number of shares'
  trade_capture_message:
    seq:
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: security_id_u_324
        type: u4
        doc: 'Numeric security identifier'
      - id: trade_capture_type
        type: u1
        enum: trade_capture_type
        doc: 'Trade capture type'
      - id: trade_capture_flags
        type: trade_capture_flags
        doc: 'Trade capture flags'
      - id: account
        type: u1
        doc: 'Clearing account identifier; 1 = House Account, 2 or above = agreed Client Account code'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  trade_capture_flags:
    seq:
      - id: reserved_1
        type: b1
        doc: 'Reserved'
      - id: algo_trade_flag
        type: b1
        doc: 'Whether the order was generated by an algorithm'
      - id: reserved_6
        type: b6
        doc: 'Reserved'
  trade_capture_response_message:
    seq:
      - id: status
        type: status
        doc: 'Order status and reason code'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number; corresponds to the TVTIC'
      - id: request_ref
        type: u4
        doc: 'Sequence number of the trading Member''s Order Cancel message; zero for forced cancels generated by Aquis or cancel messages from the MaC'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  trade_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number; corresponds to the TVTIC'
      - id: ccp_code
        type: u1
        doc: 'Clearing CCP code; 1 = Self clearing, 2 and above = CCP code'
      - id: liq_indicator
        type: u1
        enum: liq_indicator
        doc: 'Liquidity indicator'
      - id: security_id_u_162
        type: u2
        doc: 'Numeric security identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade flags'
  trade_flags:
    seq:
      - id: reserved_6
        type: b6
        doc: 'Reserved'
      - id: lis
        type: b1
        enum: lis
        doc: 'LIS indicator set by the system'
      - id: dark_flag
        type: b1
        doc: 'Indicates if an order is a dark order'
  trade_bust_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number; corresponds to the TVTIC'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
  ioi_add_message:
    seq:
      - id: security_id_u_162
        type: u2
        doc: 'Numeric security identifier'
      - id: ioi_order_type
        type: u1
        enum: ioi_order_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier; 1 = House Account, 2 or above = agreed Client Account code'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity of an order to be executed; 0 = no minimum quantity'
      - id: ioi_extended_flags
        type: ioi_extended_flags
        doc: 'IOI extended order flags'
      - id: optim_x_universe
        type: u1
        enum: optim_x_universe
        doc: 'OptimX universe visibility'
      - id: blotter_blacklist
        type: str
        size: 50
        encoding: ASCII
        doc: '50 byte blacklist as agreed with OptimX'
  ioi_extended_flags:
    seq:
      - id: stp_enable
        type: b1
        doc: 'Self-trade prevention; only valid when OrderType=12; 0 = No restriction, 1 = Enabled'
      - id: lis_only
        type: b1
        doc: 'LIS executions only; only valid when OrderType=12; 0 = No restriction, 1 = LIS executions only'
      - id: reserved_6
        type: b6
        doc: 'Reserved'
  ioi_invite_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity of an order to be executed; 0 = no minimum quantity'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  ioi_firmup_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: u8
        doc: 'Limit price of the order; 0 for MaC orders'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity of an order to be executed; 0 = no minimum quantity'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000

enums:
  msg_type:
    1:
      id: 'login_message'
      doc: 'The Login message is sent by the trading Member as the initial message used to establish a trading session'
    2:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by Aquis to acknowledge a Login request, and either accept or reject it.'
    0:
      id: 'heartbeat'
      doc: 'A Heartbeat message is a message header with msgType set to 0 and msgSeqNo set to the sequence number of the next business message.'
    3:
      id: 'logout_request_message'
      doc: 'The Logout Request message is used by the trading Member to request the closure of a trading session.'
    4:
      id: 'logout_message'
      doc: 'The Logout message is usually sent as a response to the Logout Request. The TCP/IP connection is closed immediately after this message has been sent.'
    5:
      id: 'order_add_message'
      doc: 'The Order Add message is sent by the trading Member to enter an order for a particular security.'
    21:
      id: 'order_add_extended_message'
      doc: 'The Order Add Extended message is sent by the trading Member to enter an order for a particular security with additional attributes.'
    7:
      id: 'order_cancel_message'
      doc: 'The Order Cancel message is sent when a user wishes to cancel an open order.'
    9:
      id: 'order_modify_message'
      doc: 'The Order Modify message is sent when a user wishes to modify an open order. Order quantity and/or limit price may be modified. Both values must be included, even if one of them is unchanged.'
    22:
      id: 'order_modify_extended_message'
      doc: 'The Order Modify Extended message is sent when a user wants to modify an open Order Add Extended. All values must be included, even if some are unchanged.'
    6:
      id: 'order_add_response_message'
      doc: 'Aquis sends an Order Add Response message to acknowledge the receipt of an Order Add or an Order Add Extended message.'
    8:
      id: 'order_cancel_response_message'
      doc: 'Aquis sends an Order Cancel Response to accept or reject an Order Cancel message. The message is also used if an order is cancelled by Market Operations or due to cancel on disconnect.'
    10:
      id: 'order_modify_response_message'
      doc: 'Aquis sends an Order Modify Response to accept or reject an Order Modify or an Order Modify Extended message.'
    23:
      id: 'iceberg_order_refresh_message'
      doc: 'Aquis sends an Iceberg Order Refresh message to notify the Member when an iceberg order is refreshed from the non-displayed reserve quantity.'
    17:
      id: 'trade_capture_message'
      doc: 'Aquis uses a Trade Capture Report message for the purposes of allowing members to submit Large In Scale (LIS) and Benchmark Cross trades to the exchange.'
    18:
      id: 'trade_capture_response_message'
      doc: 'Aquis sends a Trade Capture Response Message to accept or reject a Trade Capture Message.'
    11:
      id: 'trade_message'
      doc: 'The Trade message is published by Aquis when an order executes. The Trade message is also used to communicate indicative trade reports at lock time for Market at Close orders, and matched firm VWAP orders beginning their crossing duration.'
    12:
      id: 'trade_bust_message'
      doc: 'If a trade is invalidated, a Trade Bust message is sent to notify the trading Member.'
    27:
      id: 'ioi_add_message'
      doc: 'IOI to send a conditional into the AMP or AVM. IOIs can be cancelled and modified using Order Modify and Order Cancel.'
    28:
      id: 'ioi_invite_message'
      doc: 'Message from Aquis to the member indicating a firm up invite. The invite will expire 300ms after the value in the timestamp field.'
    29:
      id: 'ioi_firmup_message'
      doc: 'Firm up message to be used as a response to an invite.'
  result_code:
    0:
      id: 'success'
      doc: 'Success'
    1:
      id: 'already_logged_in'
      doc: 'Already Logged In'
    2:
      id: 'sequence_number_error'
      doc: 'Sequence Number Error'
    3:
      id: 'unsupported_protocol'
      doc: 'Unsupported Protocol'
    4:
      id: 'failed_authentication'
      doc: 'Failed Authentication'
    5:
      id: 'unknown_source_network'
      doc: 'Unknown Source Network'
  logout_reason_code:
    0:
      id: 'user_requested'
      doc: 'User Requested'
    1:
      id: 'admin'
      doc: 'Admin'
    2:
      id: 'disconnect'
      doc: 'Disconnect'
    3:
      id: 'end_of_day'
      doc: 'End Of Day'
    4:
      id: 'inactivity_timeout'
      doc: 'Inactivity Timeout'
    5:
      id: 'protocol_error'
      doc: 'Protocol Error'
    6:
      id: 'sequence_number_error'
      doc: 'Sequence Number Error'
  order_type:
    1:
      id: 'limit_order'
      doc: 'Limit Order'
    2:
      id: 'auction_on_demand_limit_order'
      doc: 'Auction On Demand Limit Order'
    3:
      id: 'auction_on_demand_mid_pegged_limit'
      doc: 'Auction On Demand Mid Pegged Limit'
    4:
      id: 'auction_on_demand_near_touch_pegged'
      doc: 'Auction On Demand Near Touch Pegged'
    6:
      id: 'market_at_close'
      doc: 'Market At Close'
    8:
      id: 'post_only_cancel_replace'
      doc: 'Post Only Cancel Replace'
    9:
      id: 'post_only'
      doc: 'Post Only'
    10:
      id: 'restricted_pocr_order'
      doc: 'Restricted Pocr Order'
    11:
      id: 'restricted_post_only_order'
      doc: 'Restricted Post Only Order'
  time_in_force:
    1:
      id: 'day'
      doc: 'Day'
    2:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
    3:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel'
    9:
      id: 'good_for_auction'
      doc: 'Good For Auction'
  order_capacity:
    1:
      id: 'aotc'
      doc: 'Aotc'
    2:
      id: 'deal'
      doc: 'Deal'
    3:
      id: 'mtch'
      doc: 'Mtch'
  party_role:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'client_id'
      doc: 'Client Id'
    2:
      id: 'executing_decision_id'
      doc: 'Executing Decision Id'
    3:
      id: 'investing_decision_id'
      doc: 'Investing Decision Id'
  party_role_qualifier:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'algo'
      doc: 'Algo'
    2:
      id: 'firm'
      doc: 'Firm'
    3:
      id: 'person'
      doc: 'Person'
  short_code_1:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggregated'
      doc: 'Aggregated'
    2:
      id: 'pending_allocation'
      doc: 'Pending Allocation'
    3:
      id: 'client'
      doc: 'Client'
  short_code_2:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggregated'
      doc: 'Aggregated'
    2:
      id: 'pending_allocation'
      doc: 'Pending Allocation'
    3:
      id: 'client'
      doc: 'Client'
  short_code_3:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'aggregated'
      doc: 'Aggregated'
    2:
      id: 'pending_allocation'
      doc: 'Pending Allocation'
    3:
      id: 'client'
      doc: 'Client'
  routing:
    0:
      id: 'limit'
      doc: 'Limit'
    1:
      id: 'post_only'
      doc: 'Post Only'
    2:
      id: 'pocr'
      doc: 'Pocr'
    3:
      id: 'restricted_post_only_order'
      doc: 'Restricted Post Only Order'
    4:
      id: 'restricted_pocr_order'
      doc: 'Restricted Pocr Order'
  order_status:
    1:
      id: 'pending_new'
      doc: 'Pending New'
    2:
      id: 'acknowledged'
      doc: 'Acknowledged'
    3:
      id: 'cancelled'
      doc: 'Cancelled'
    4:
      id: 'rejected'
      doc: 'Rejected'
    5:
      id: 'filled'
      doc: 'Filled'
    6:
      id: 'modified'
      doc: 'Modified'
  lis:
    0:
      id: 'reference_price_waiver'
      doc: 'Reference Price Waiver'
    1:
      id: 'large_in_scale'
      doc: 'Large In Scale'
  trade_capture_type:
    1:
      id: 'lis_cross'
      doc: 'Lis Cross'
    2:
      id: 'lis_cross_no_clearing'
      doc: 'Lis Cross No Clearing'
    3:
      id: 'vwap_benchmark_cross'
      doc: 'Vwap Benchmark Cross'
    4:
      id: 'vwap_benchmark_cross_no_clearing'
      doc: 'Vwap Benchmark Cross No Clearing'
    5:
      id: 'twap_benchmark_cross'
      doc: 'Twap Benchmark Cross'
    6:
      id: 'twap_benchmark_cross_no_clearing'
      doc: 'Twap Benchmark Cross No Clearing'
  liq_indicator:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    3:
      id: 'removed_liquidity_hidden_quantity'
      doc: 'Removed Liquidity Hidden Quantity'
    4:
      id: 'auction_ma_c'
      doc: 'Auction Ma C'
    6:
      id: 'auction_on_demand'
      doc: 'Auction On Demand'
  ioi_order_type:
    12:
      id: 'mid_pegged'
      doc: 'Mid Pegged'
    17:
      id: 'aquis_vwap_match'
      doc: 'Aquis Vwap Match'
    18:
      id: 'targeted_aquis_vwap_match'
      doc: 'Targeted Aquis Vwap Match'
  optim_x_universe:
    0:
      id: 'off'
      doc: 'Off'
    1:
      id: 'show_to_all_optim_x_clients'
      doc: 'Show To All Optim X Clients'
    2:
      id: 'show_to_current_broker_clients_only'
      doc: 'Show To Current Broker Clients Only'

