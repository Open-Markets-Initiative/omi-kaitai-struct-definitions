# ---------------------------------------------------------------------
# Kaitai struct definition for: AsiaNext AsiaNextDerivatives TradingProtocol Atp v1.2
#
# Protocol:
#   Organization: AsiaNext
#   Protocol: Aquis Trading Protocol
#   Encoding: Aquis Trading Protocol
#   Version: 1.2
#   Date: 11/6/2026
#   Specification: 251015-AsiaNext-ATP-Technical-Specification-v1.2.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: asianext_asianextderivatives_tradingprotocol_atp_v1_2
  title: AsiaNext AsiaNextDerivatives TradingProtocol Atp v1.2
  license: MIT-0
  endian: le

doc: 'AsiaNext AsiaNext Derivatives Aquis Trading Protocol Atp v1.2'
doc-ref: https://www.asianext.com/tech/

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'AsiaNext Atp Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'AsiaNext Atp message header'
      - id: payload
        size: message_header.msg_length - 11
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
            'msg_type::quote_request_message': quote_request_message
            'msg_type::quote_request_notification_message': quote_request_notification_message
            'msg_type::quote_add_message': quote_add_message
            'msg_type::quote_modify_message': quote_modify_message
            'msg_type::quote_cancel_message': quote_cancel_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_bust_message': trade_bust_message
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
        type: u8
        doc: 'Message sequence number, from the user or AsiaNext'
  login_message:
    seq:
      - id: protocol_version
        type: u2
        doc: 'Version of the protocol being used'
      - id: sender_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Value as agreed with AsiaNext to identify the Member’s ATP session'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        doc: 'Password as agreed with AsiaNext to verify the user'
      - id: inactivity_timeout
        type: u2
        doc: 'It is recommended to use 5 seconds. If there are no messages received for this period of time then AsiaNext will close the session (triggering cancel on disconnect)'
      - id: atp_seq_no
        type: u8
        doc: 'The next sequence number that the trading Member is expecting to receive on messages from AsiaNext'
  login_response_message:
    seq:
      - id: result_code
        type: u1
        enum: result_code
        doc: 'Set to 0 for successful login'
      - id: client_seq_no
        type: u8
        doc: 'Next sequence number AsiaNext expects to receive'
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
      - id: security_id_long
        type: u4
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
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: '1 = AOTC (A), 2 = DEAL (P), 3 = MTCH (R)'
      - id: account
        type: u2
        doc: 'Clearing account identifier. 2 or above = ID for an agreed Client Account code. Account value assigned by AsiaNext is mandatory'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short Code (as qualified by previous field)'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: liq_prov
        type: b1
        doc: 'Whether the order relates to liquidity provision activity 0 = No 1 = Yes'
      - id: algo_trade_flag
        type: b1
        doc: 'Whether the order was generated by an algorithm 0 = No 1 = Yes'
      - id: dea_flag
        type: b1
        doc: 'Whether the order originates from a Direct Electronic Access Client 0 = No 1 = Yes'
      - id: unused_5
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
      - id: security_id_long
        type: u4
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
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: '1 = AOTC (A), 2 = DEAL (P), 3 = MTCH (R)'
      - id: account
        type: u2
        doc: 'Clearing account identifier. 2 or above = ID for an agreed Client Account code. Account value assigned by AsiaNext is mandatory'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short Code (as qualified by previous field)'
      - id: display_quantity
        type: u4
        doc: 'Value must be set to 0'
      - id: min_qty
        type: u4
        doc: 'Value must be set to 0'
      - id: extended_order_flags
        type: extended_order_flags
        doc: 'Reserved'
      - id: expire_time
        type: u8
        doc: 'Expire date/time for Good Till Date orders. Mandatory if timeInForce = 4. If not applicable, value must be set to 0'
      - id: rfq_session_id
        type: u8
        doc: 'ID of RFQ Session'
  extended_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_8
        type: b8
        doc: 'Reserved'
  order_cancel_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short Code (as qualified by previous field)'
  order_modify_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short Code (as qualified by previous field)'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: '1 = AOTC (A), 2 = DEAL (P), 3 = MTCH (R)'
  order_modify_extended_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: flags
        type: flags
        doc: 'Order flags'
      - id: table_select_1
        type: table_select_1
        doc: 'Party role qualifier and role'
      - id: short_code_1
        type: u4
        enum: short_code_1
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_2
        type: table_select_2
        doc: 'Party role qualifier and role'
      - id: short_code_2
        type: u4
        enum: short_code_2
        doc: 'Short Code (as qualified by previous field)'
      - id: table_select_3
        type: table_select_3
        doc: 'Party role qualifier and role'
      - id: short_code_3
        type: u4
        enum: short_code_3
        doc: 'Short Code (as qualified by previous field)'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: '1 = AOTC (A), 2 = DEAL (P), 3 = MTCH (R)'
      - id: display_quantity
        type: u4
        doc: 'Value must be set to 0'
      - id: min_qty
        type: u4
        doc: 'Value must be set to 0'
      - id: expire_time
        type: u8
        doc: 'Expire date/time for Good Till Date orders. Mandatory if timeInForce = 4. If not applicable, value must be set to 0'
  order_add_response_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: market_data_id
        type: u8
        doc: 'The ID of this order as seen in the AsiaNext market data. This value will be zero if the order is cancelled (IOC) or fully traded on entry'
      - id: order_add_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::cancelled': status_cancel_reason
            'order_status::rejected': status_reject_reason
            _: status
      - id: traded_quantity
        type: u4
        doc: 'Number of contracts traded, if any'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the AsiaNext system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: order_add_response_flags
        type: order_add_response_flags
        doc: 'Reserved'
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status_bits:
        value: (peek_order_status_container >> 5) & 7
      peek_order_status:
        value: peek_order_status_bits
        enum: order_status
  status_cancel_reason:
    meta:
      bit-endian: le
    seq:
      - id: cancel_reason
        type: b5
        doc: 'Reason code if rejected or cancelled; otherwise zero'
      - id: order_status
        type: b3
        doc: 'Order status'
  status_reject_reason:
    meta:
      bit-endian: le
    seq:
      - id: reject_reason
        type: b5
        doc: 'Reason code if rejected or cancelled; otherwise zero'
      - id: order_status
        type: b3
        doc: 'Order status'
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
      - id: unused_8
        type: b8
        doc: 'Reserved'
  order_cancel_response_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: request_ref
        type: u8
        doc: 'Sequence number (msgSeqNo) of the trading Member’s Order Cancel message. Note that this field will be zero in the case of a forced cancel generated by AsiaNext'
      - id: order_cancel_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::cancelled': status_cancel_reason
            'order_status::rejected': status_reject_reason
            _: status
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the AsiaNext system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status_bits:
        value: (peek_order_status_container >> 5) & 7
      peek_order_status:
        value: peek_order_status_bits
        enum: order_status
  order_modify_response_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: request_ref
        type: u8
        doc: 'Sequence number (msgSeqNo) of the trading Member’s Order Cancel message. Note that this field will be zero in the case of a forced cancel generated by AsiaNext'
      - id: order_modify_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::rejected': status_reject_reason
            _: status_modification_reason
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the AsiaNext system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: order_modify_response_flags
        type: order_modify_response_flags
        doc: 'Reserved'
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status_bits:
        value: (peek_order_status_container >> 5) & 7
      peek_order_status:
        value: peek_order_status_bits
        enum: order_status
  status_modification_reason:
    meta:
      bit-endian: le
    seq:
      - id: modification_reason
        type: b5
        doc: 'Reason code if rejected or cancelled; otherwise zero'
      - id: order_status
        type: b3
        doc: 'Order status'
  order_modify_response_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_8
        type: b8
        doc: 'Reserved'
  quote_request_message:
    seq:
      - id: security_id_long
        type: u4
        doc: 'Numeric security identifier'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: market_maker_code_1
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Maker code of recipient of Quote Request'
      - id: market_maker_code_2
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Maker code of recipient of Quote Request'
      - id: market_maker_code_3
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Maker code of recipient of Quote Request'
      - id: market_maker_code_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Maker code of recipient of Quote Request'
      - id: market_maker_code_5
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market Maker code of recipient of Quote Request'
  quote_request_notification_message:
    seq:
      - id: rfq_session_id
        type: u8
        doc: 'ID of RFQ Session'
      - id: security_id_long
        type: u4
        doc: 'Numeric security identifier'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quote_request_status
        type: u1
        enum: quote_request_status
        doc: '1 = Acknowledgement, 2 = Expired, 3 = Rejected'
      - id: status_details
        type: u1
        enum: status_details
        doc: 'Status details'
      - id: msg_ref
        type: u8
        doc: 'Message reference number'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
  quote_add_message:
    seq:
      - id: aqx_order_id
        type: u8
        doc: 'Unique Quote ID'
      - id: security_id_short
        type: u2
        doc: 'Numeric security identifier'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: rfq_session_id
        type: u8
        doc: 'ID of RFQ Session'
  quote_modify_message:
    seq:
      - id: aqx_order_id
        type: u8
        doc: 'Unique Quote ID'
      - id: security_id_short
        type: u2
        doc: 'Numeric security identifier'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
  quote_cancel_message:
    seq:
      - id: aqx_order_id
        type: u8
        doc: 'Unique Quote ID'
      - id: security_id_short
        type: u2
        doc: 'Numeric security identifier'
  trade_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: trade_ref
        type: u8
        doc: 'Trade reference number. Corresponds to the TVTIC (RTS 24 Art.12 & RTS 22 Field 3 Table 2)'
      - id: ccp_code
        type: u1
        doc: 'CCP Code'
      - id: liq_indicator
        type: u1
        enum: liq_indicator
        doc: 'Liquidity indicator'
      - id: security_id_long
        type: u4
        doc: 'Numeric security identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the AsiaNext system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: trade_flags
        type: trade_flags
        doc: 'Reserved'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_8
        type: b8
        doc: 'Reserved'
  trade_bust_message:
    seq:
      - id: order_ref
        type: u8
        doc: 'Order reference number'
      - id: quantity
        type: u4
        doc: 'Number of contracts'
      - id: price
        type: decimal_u8_5
        doc: 'Limit price of the order. Implied decimal with scale 1e-5'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: trade_ref
        type: u8
        doc: 'Trade reference number. Corresponds to the TVTIC (RTS 24 Art.12 & RTS 22 Field 3 Table 2)'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the AsiaNext system. Nanoseconds since Unix epoch'
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0
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
      doc: 'The Login Response message is sent by AsiaNext to acknowledge a Login request, and either accept or reject it.'
    0:
      id: 'heartbeat_message'
      doc: 'A Heartbeat message is simply a message header with msgType is set to 0 and msgSeqNo set to the sequence number that will be sent on the next business message.'
    3:
      id: 'logout_request_message'
      doc: 'The Logout Request message is used by the trading Member to request the closure of a trading session.'
    4:
      id: 'logout_message'
      doc: 'The Logout message is usually sent as a response to the Logout Request. However it may also be sent by AsiaNext in case of a low sequence number or other protocol violation, or for other reasons.'
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
      doc: 'The Order Modify message is sent when a user wishes to modify an open order. Order quantity and/or limit price may be modified.'
    22:
      id: 'order_modify_extended_message'
      doc: 'The Order Modify Extended message is sent when a user wants to modify an open Order Add Extended.'
    6:
      id: 'order_add_response_message'
      doc: 'AsiaNext sends an Order Add Response message to acknowledge the receipt of an Order Add or an Order Add Extended message.'
    8:
      id: 'order_cancel_response_message'
      doc: 'AsiaNext sends an Order Cancel Response to accept or reject an Order Cancel message. The message is also used if an order is cancelled by Market Operations or due to cancel on disconnect.'
    10:
      id: 'order_modify_response_message'
      doc: 'AsiaNext sends an Order Modify Response to accept or reject an Order Modify or an Order Modify Extended message.'
    30:
      id: 'quote_request_message'
      doc: 'The Quote Request Message is sent to commence RFQ session.'
    31:
      id: 'quote_request_notification_message'
      doc: 'The Quote Request Notification is sent back to requestor to acknowledge the Quote Request. It is also sent to Market Maker to share the Quote Request.'
    13:
      id: 'quote_add_message'
      doc: 'The Quote Add Message is used to disseminate quotes sent by Market Makers to the RFQ session requestor.'
    14:
      id: 'quote_modify_message'
      doc: 'Quote Modify Message is used to disseminate any quote modification submitted by the market makers to the RFQ session requestor.'
    15:
      id: 'quote_cancel_message'
      doc: 'Quote Cancel Message is used to disseminate any quote cancelation messages submitted by the market makers to the RFQ session requestor.'
    11:
      id: 'trade_message'
      doc: 'The Trade message is published by AsiaNext when an order executes.'
    12:
      id: 'trade_bust_message'
      doc: 'If a trade is invalidated, a Trade Bust message is sent to notify the trading Member.'
  result_code:
    0:
      id: 'successful_login'
      doc: 'Successful Login'
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
    8:
      id: 'maintenance'
      doc: 'Maintenance'
  order_type:
    1:
      id: 'limit_order'
      doc: 'Limit Order'
    8:
      id: 'post_only_cancel_replace'
      doc: 'Post-Only Cancel Replace (POCR)'
    9:
      id: 'post_only'
      doc: 'Post-Only (PO)'
    15:
      id: 'rfq_limit'
      doc: 'Order Add Extended only'
    16:
      id: 'rfq_quote'
      doc: 'Order Add Extended only'
  time_in_force:
    1:
      id: 'day'
      doc: 'Order Add Extended only; mandatory when orderType = 16 (RFQ Quote)'
    2:
      id: 'fill_or_kill'
      doc: 'Fill or Kill (FOK)'
    3:
      id: 'immediate_or_cancel'
      doc: 'Immediate or Cancel (IOC)'
    4:
      id: 'good_till_date'
      doc: 'Good Till Date (GTD), Order Add Extended only'
  side:
    0:
      id: 'no_side_specified'
      doc: 'Quote Request only'
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'
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
  cancel_reason:
    0:
      id: 'ioc_or_fok_not_filled'
      doc: 'Cancelled due to IOC or FOK orders not filled'
    1:
      id: 'member_request'
      doc: 'Member Request'
    2:
      id: 'asia_next_forced_cancel'
      doc: 'Asia Next Forced Cancel'
    3:
      id: 'market_close'
      doc: 'Market Close'
    4:
      id: 'expired'
      doc: 'Expired'
    5:
      id: 'reserved'
      doc: 'Reserved'
    6:
      id: 'aborted'
      doc: 'Aborted'
    7:
      id: 'self_trade_prevention'
      doc: 'Self Trade Prevention'
    8:
      id: 'cancel_on_disconnect'
      doc: 'Cancel On Disconnect'
    9:
      id: 'post_only_cancel'
      doc: 'Post-only cancel (cancel to prevent aggressive trade)'
    10:
      id: 'cancel_residual_quantity'
      doc: 'Cancel Residual Quantity'
    11:
      id: 'post_only_cancel_resting'
      doc: 'Post-only cancel resting (cancel to prevent aggressive trade)'
    12:
      id: 'minimum_resting_value'
      doc: 'Minimum Resting Value'
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
  reject_reason:
    1:
      id: 'not_authorised_to_trade'
      doc: 'Not Authorised To Trade'
    2:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    3:
      id: 'invalid_price'
      doc: 'Invalid Price'
    4:
      id: 'unknown_security'
      doc: 'Unknown Security'
    5:
      id: 'price_does_not_conform_to_tick'
      doc: 'Price Does Not Conform To Tick'
    6:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    7:
      id: 'invalid_side'
      doc: 'Invalid Side'
    8:
      id: 'invalid_order_capacity'
      doc: 'Invalid Order Capacity'
    9:
      id: 'market_is_closed'
      doc: 'Market Is Closed'
    10:
      id: 'halted'
      doc: 'Halted'
    11:
      id: 'suspended'
      doc: 'Suspended'
    12:
      id: 'invalid_time_in_force'
      doc: 'Invalid Time In Force'
    13:
      id: 'order_not_found_or_not_open'
      doc: 'Order Not Found / Not Open'
    15:
      id: 'failed_price_range_check'
      doc: 'Failed Price Range Check'
    16:
      id: 'invalid_clearing_account'
      doc: 'Invalid Clearing Account'
    17:
      id: 'not_supported'
      doc: 'Not Supported'
    18:
      id: 'max_value_exceeded'
      doc: 'Max Value Exceeded'
    19:
      id: 'auction_ended'
      doc: 'Auction Ended'
    20:
      id: 'drop_feed_down'
      doc: 'Drop Feed Down'
    21:
      id: 'technical_reject'
      doc: 'Technical Reject'
    23:
      id: 'stock_restricted'
      doc: 'Stock Restricted'
    24:
      id: 'minimum_consideration'
      doc: 'Minimum Consideration'
    27:
      id: 'invalid'
      doc: 'Invalid'
    29:
      id: 'bad_date'
      doc: 'Bad Date'
    30:
      id: 'duplicate'
      doc: 'Duplicate'
    31:
      id: 'reject_internal'
      doc: 'Reject Internal'
  modification_reason:
    1:
      id: 'modification_accepted'
      doc: 'Modification Accepted'
    2:
      id: 'cancelled_by_modification_to_zero'
      doc: 'Order cancelled as a result of modification which updates the remaining quantity to zero'
  quote_request_status:
    1:
      id: 'acknowledgement'
      doc: 'Acknowledgement'
    2:
      id: 'expired'
      doc: 'Expired'
    3:
      id: 'rejected'
      doc: 'Rejected'
  status_details:
    0:
      id: 'acknowledgement'
      doc: 'Acknowledgement'
    1:
      id: 'security_suspended'
      doc: 'Security Suspended'
    2:
      id: 'security_halted'
      doc: 'Security Halted'
    3:
      id: 'unsupported_security'
      doc: 'Unsupported Security'
    4:
      id: 'invalid_market_maker'
      doc: 'Invalid Market Maker'
    5:
      id: 'invalid_side'
      doc: 'Invalid Side'
    6:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    8:
      id: 'not_supported'
      doc: 'Not Supported'
    9:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    10:
      id: 'internal_error'
      doc: 'Internal Error'
    11:
      id: 'not_authorised'
      doc: 'Not Authorised'
    12:
      id: 'market_closed'
      doc: 'Market Closed'
    13:
      id: 'session_closed'
      doc: 'Session Closed'
  liq_indicator:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'

