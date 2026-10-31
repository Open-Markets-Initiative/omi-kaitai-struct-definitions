# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis TradingProtocol Atp v4.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Aquis Trading Protocol
#   Encoding: Aquis Trading Protocol
#   Version: 4.0
#   Date: 8/1/2025
#   Specification: Aquis ATP Technical Specification v4.0.pdf
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
  id: aquis_aquisequities_tradingprotocol_atp_v4_0
  title: Aquis TradingProtocol Atp v4.0
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
        doc: 'Optional inactivity timeout, in seconds. If there are no messages received for this period of time then Aquis will close the session (triggering cancel on disconnect)'
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
      - id: security_id_short
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: liq_prov
        type: b1
        doc: 'Whether the order relates to liquidity provision activity'
      - id: algo_trade_flag
        type: b1
        doc: 'Whether the order was generated by an algorithm'
      - id: dea_flag
        type: b1
        doc: 'Whether the order originates from a Direct Electronic Access Client'
      - id: reserved_5
        type: b5
        doc: 'Reserved'
  table_select_1:
    meta:
      bit-endian: le
    seq:
      - id: party_role
        type: b4
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        doc: 'Party role qualifier'
  table_select_2:
    meta:
      bit-endian: le
    seq:
      - id: party_role
        type: b4
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        doc: 'Party role qualifier'
  table_select_3:
    meta:
      bit-endian: le
    seq:
      - id: party_role
        type: b4
        doc: 'Party role'
      - id: party_role_qualifier
        type: b4
        doc: 'Party role qualifier'
  order_add_extended_message:
    seq:
      - id: security_id_short
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity (shares) of an order to be executed. Nullable, No Value = 0'
      - id: extended_order_flags
        type: extended_order_flags
        doc: 'Extended order flags'
      - id: reserved_long
        type: u8
        doc: 'Reserved'
      - id: designated_order_id
        type: u8_nullable
        doc: 'The order ID of the contra as provided by OptimX. Nullable, No Value = 0'
      - id: reserved_short
        type: u2
        doc: 'Reserved'
      - id: peg_difference
        type: s8
        doc: 'Only applicable for AoD Near Touch Pegged orders. Value will be added to the peg calculation. Value should be < 0 for an aggressive offset on a sell order. PegDifference is rounded (down for buy, up for sell) to fit the tick size'
  extended_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: stp_enable
        type: b1
        doc: 'Self-trade prevention'
      - id: lis_only
        type: b1
        doc: 'Restricts the order to LIS executions'
      - id: routetolit
        type: b1
        doc: 'Route to Lit: whether the order is routed to the lit order book'
      - id: routing
        type: b3
        doc: 'Behaviour of the Lit portion of a Dark-to-Lit sweep order. This flag is ignored when Bit2 (Routetolit) = 0'
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
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
  order_modify_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity (shares) of an order to be executed. Nullable, No Value = 0'
      - id: reserved_long
        type: u8
        doc: 'Reserved'
  order_add_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: market_data_id
        type: u4_nullable
        doc: 'The ID of this order as seen in the Aquis market data. Nullable, No Value = 0'
      - id: status
        type: status
        doc: 'Status of order and reject or cancel code'
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
    meta:
      bit-endian: le
    seq:
      - id: reason_code
        type: b5
        doc: 'Reason code if rejected or cancelled; otherwise zero'
      - id: order_status
        type: b3
        doc: 'Order status'
  order_add_response_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_6
        type: b6
        doc: 'Reserved'
      - id: lis
        type: b1
        doc: 'The pre-trade transparency waiver of the order or trade, set by the system. Only valid when OrderType=12'
      - id: dark_flag
        type: b1
        doc: 'Indicates whether the order, order modify request or trade is on the dark order book'
  order_cancel_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: request_ref
        type: u4_nullable
        doc: 'Sequence number (msgSeqNo) of the trading Member''s request message. Nullable, No Value = 0'
      - id: status
        type: status
        doc: 'Status of order and reject or cancel code'
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
        type: u4_nullable
        doc: 'Sequence number (msgSeqNo) of the trading Member''s request message. Nullable, No Value = 0'
      - id: status
        type: status
        doc: 'Status of order and reject or cancel code'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: order_modify_response_flags
        type: order_modify_response_flags
        doc: 'Order modify response flags'
  order_modify_response_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_6
        type: b6
        doc: 'Reserved'
      - id: lis
        type: b1
        doc: 'The pre-trade transparency waiver of the order or trade, set by the system. Only valid when OrderType=12'
      - id: dark_flag
        type: b1
        doc: 'Indicates whether the order, order modify request or trade is on the dark order book'
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: security_id_long
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
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  trade_capture_flags:
    meta:
      bit-endian: le
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
        doc: 'Status of order and reject or cancel code'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number. Corresponds to the TVTIC (RTS 24 Art.12 & RTS 22 Field 3 Table 2)'
      - id: request_ref
        type: u4_nullable
        doc: 'Sequence number (msgSeqNo) of the trading Member''s request message. Nullable, No Value = 0'
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number. Corresponds to the TVTIC (RTS 24 Art.12 & RTS 22 Field 3 Table 2)'
      - id: ccp_code
        type: u1
        doc: 'Clearing CCP code'
      - id: liq_indicator
        type: u1
        enum: liq_indicator
        doc: 'Liquidity indicator'
      - id: security_id_short
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
    meta:
      bit-endian: le
    seq:
      - id: reserved_6
        type: b6
        doc: 'Reserved'
      - id: lis
        type: b1
        doc: 'The pre-trade transparency waiver of the order or trade, set by the system. Only valid when OrderType=12'
      - id: dark_flag
        type: b1
        doc: 'Indicates whether the order, order modify request or trade is on the dark order book'
  trade_bust_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: price
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: side
        type: u1
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number. Corresponds to the TVTIC (RTS 24 Art.12 & RTS 22 Field 3 Table 2)'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the Aquis system. Nanoseconds since Unix epoch'
  ioi_add_message:
    seq:
      - id: security_id_short
        type: u2
        doc: 'Numeric security identifier'
      - id: ioi_order_type
        type: u1
        enum: ioi_order_type
        doc: 'IOI order type'
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: account
        type: u1
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role for party 1'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short code for party 1, as qualified by tableSelect1'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role for party 2'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short code for party 2, as qualified by tableSelect2'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role for party 3'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short code for party 3, as qualified by tableSelect3'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity (shares) of an order to be executed. Nullable, No Value = 0'
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
    meta:
      bit-endian: le
    seq:
      - id: stp_enable
        type: b1
        doc: 'Self-trade prevention'
      - id: lis_only
        type: b1
        doc: 'Restricts the order to LIS executions'
      - id: reserved_6
        type: b6
        doc: 'Reserved'
  ioi_invite_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: price
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity (shares) of an order to be executed. Nullable, No Value = 0'
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
        type: decimal_u8_5_nullable
        doc: 'Price of the order or trade. Implied decimal with scale 1e-5. Nullable, No Value = 0'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity (shares) of an order to be executed. Nullable, No Value = 0'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0
  decimal_u8_5_nullable:
    seq:
      - id: value
        type: decimal_u8_5
    instances:
      is_null:
        value: value.mantissa == 0
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0
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
      doc: 'The Login message is sent by the trading Member as the initial message used to establish a trading session. It is also used to re-establish a session after a break.'
    2:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by Aquis to acknowledge a Login request, and either accept or reject it.'
    0:
      id: 'heartbeat'
      doc: 'A Heartbeat message is simply a message header with msgType is set to 0 and msgSeqNo set to the sequence number that will be sent on the next business message.'
    3:
      id: 'logout_request_message'
      doc: 'The Logout Request message is used by the trading Member to request the closure of a trading session.'
    4:
      id: 'logout_message'
      doc: 'The Logout message is usually sent as a response to the Logout Request. However it may also be sent by Aquis in case of a low sequence number or other protocol violation, or for other reasons. The TCP/IP connection is closed immediately after this message has been sent.'
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
      doc: 'IOI to send a conditional into the AMP or AVM. Expect a response using Order Add Response Message. IOIs can be cancelled and modified using Order Modify and Order Cancel.'
    28:
      id: 'ioi_invite_message'
      doc: 'Message from Aquis to the member indicating a firm up invite. The invite will expire 300ms after the value in the timestamp field.'
    29:
      id: 'ioi_firmup_message'
      doc: 'Firm up message to be used as a response to an invite.'
  result_code:
    0:
      id: 'successful_login'
      doc: 'Set to 0 for successful login'
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
      doc: 'Failed Authentication (incorrect password)'
    5:
      id: 'unknown_source_network'
      doc: 'Unknown Source Network'
  logout_reason_code:
    0:
      id: 'user_requested'
      doc: 'User Requested'
    1:
      id: 'admin'
      doc: 'Admin (Market Operations)'
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
      doc: 'Post-Only Cancel Replace (POCR)'
    9:
      id: 'post_only'
      doc: 'Post-Only (PO)'
    10:
      id: 'restricted_pocr_order'
      doc: 'Restricted Pocr Order'
    11:
      id: 'restricted_post_only_order'
      doc: 'Restricted Post Only Order'
    12:
      id: 'non_display_aquis_matching_pool_order'
      doc: 'Non-display Aquis Matching Pool (AMP) order'
  time_in_force:
    1:
      id: 'day'
      doc: 'Day order'
    2:
      id: 'fill_or_kill'
      doc: 'Fill or Kill (FOK)'
    3:
      id: 'immediate_or_cancel'
      doc: 'Immediate or Cancel (IOC)'
    9:
      id: 'good_for_auction'
      doc: 'Good For Auction (GFA)'
  order_capacity:
    1:
      id: 'aotc'
      doc: 'AOTC (A)'
    2:
      id: 'deal'
      doc: 'DEAL (P)'
    3:
      id: 'mtch'
      doc: 'MTCH (R)'
  party_role:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'client_id'
      doc: 'ClientID'
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
      doc: 'NONE (no client ID)'
    1:
      id: 'aggr'
      doc: 'AGGR (aggregated)'
    2:
      id: 'pnal'
      doc: 'PNAL (pending allocation)'
    3:
      id: 'client'
      doc: 'CLIENT (order instructed by client)'
  short_code_2:
    0:
      id: 'none'
      doc: 'NONE (no client ID)'
    1:
      id: 'aggr'
      doc: 'AGGR (aggregated)'
    2:
      id: 'pnal'
      doc: 'PNAL (pending allocation)'
    3:
      id: 'client'
      doc: 'CLIENT (order instructed by client)'
  short_code_3:
    0:
      id: 'none'
      doc: 'NONE (no client ID)'
    1:
      id: 'aggr'
      doc: 'AGGR (aggregated)'
    2:
      id: 'pnal'
      doc: 'PNAL (pending allocation)'
    3:
      id: 'client'
      doc: 'CLIENT (order instructed by client)'
  stp_enable:
    0:
      id: 'no_restriction'
      doc: 'No Restriction'
    1:
      id: 'self_trade_prevention_enabled'
      doc: 'Self-trade prevention enabled'
  lis_only:
    0:
      id: 'no_restriction'
      doc: 'No Restriction'
    1:
      id: 'lis_executions_only'
      doc: 'LIS executions only'
  routetolit:
    0:
      id: 'order_is_not_routed'
      doc: 'Order Is Not Routed'
    1:
      id: 'route_to_lit'
      doc: 'Route To Lit'
  routing:
    0:
      id: 'limit'
      doc: 'Limit'
    1:
      id: 'post_only'
      doc: 'Post Only'
    2:
      id: 'pocr'
      doc: 'POCR'
    3:
      id: 'restricted_post_only_order'
      doc: 'Restricted Post Only Order'
    4:
      id: 'restricted_pocr_order'
      doc: 'Restricted POCR Order'
  order_status:
    1:
      id: 'pending_new'
      doc: 'Pending New (internal use only)'
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
      doc: 'Reference Price Waiver (RPW)'
    1:
      id: 'large_in_scale'
      doc: 'Large in Scale (LIS)'
  trade_capture_type:
    1:
      id: 'lis_cross'
      doc: 'LIS Cross'
    2:
      id: 'lis_cross_no_clearing'
      doc: 'LIS Cross (No Clearing)'
    3:
      id: 'vwap_benchmark_cross'
      doc: 'VWAP Benchmark Cross'
    4:
      id: 'vwap_benchmark_cross_no_clearing'
      doc: 'VWAP Benchmark Cross (No Clearing)'
    5:
      id: 'twap_benchmark_cross'
      doc: 'TWAP Benchmark Cross'
    6:
      id: 'twap_benchmark_cross_no_clearing'
      doc: 'TWAP Benchmark Cross (No Clearing)'
  liq_indicator:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    3:
      id: 'removed_liquidity_hidden_quantity'
      doc: 'Removed liquidity (hidden quantity)'
    4:
      id: 'auction_mac'
      doc: 'Auction (MaC)'
    6:
      id: 'auction_on_demand'
      doc: 'Auction on Demand (AoD)'
  ioi_order_type:
    12:
      id: 'mid_pegged'
      doc: 'Mid pegged (AMP)'
    17:
      id: 'aquis_vwap_match'
      doc: 'Aquis Vwap Match'
    18:
      id: 'targeted_aquis_vwap_match'
      doc: 'Targeted Aquis Vwap Match'
  optim_x_universe:
    0:
      id: 'off_field'
      doc: 'Off'
    1:
      id: 'show_to_all_optim_x_clients'
      doc: 'Show to all OptimX Clients'
    2:
      id: 'show_to_current_broker_clients_only'
      doc: 'Show to current broker clients only'

