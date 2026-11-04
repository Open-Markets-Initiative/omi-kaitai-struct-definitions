# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X TradingProtocol Atp v2.9
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: A2X Binary Protocol
#   Encoding: A2X Binary Protocol
#   Version: 2.9
#   Date: 5/24/2023
#   Specification: A2X ATP Binary Protocol Specification v2.9.pdf
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
  id: a2x_a2xequities_tradingprotocol_atp_v2_9
  title: A2X TradingProtocol Atp v2.9
  license: MIT-0
  endian: le

doc: 'A2X Markets A2X Equities A2X Binary Protocol Atp v2.9'
doc-ref: https://www.a2x.co.za/?page_id=531

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'A2X Atp Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'A2X Atp message header'
      - id: payload
        size: message_header.length - 7
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
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of message including this header'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Message type'
      - id: msg_seq_no
        type: u4
        doc: 'Message sequence number from the user or A2X'
  login_message:
    seq:
      - id: protocol_version
        type: u2
        doc: 'A two byte field to represent the version of the ATP protocol that the user conforms to with major version number in the most significant byte and minor version number in the least significant byte. i.e. The current version v2.9 is LSB =9 MSB = 2 represented by value 0x0209'
      - id: sender_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Value as agreed with A2X to identify the Members ATP session'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        doc: 'Password as agreed with A2X to verify the user'
      - id: inactivity_timeout
        type: u2
        doc: 'Optional inactivity timeout in seconds. If there are no messages received for this period of time then A2X will close the session (triggering cancel on disconnect)'
      - id: atp_seq_no
        type: u4
        doc: 'The next sequence number from A2X that the trading Member is expecting. After a drop or break in the session this can be used by A2X to identify a gap and trigger any missed messages to be re-sent (see Login Response)'
  login_response_message:
    seq:
      - id: result_code
        type: u1
        enum: result_code
        doc: 'Login result code'
      - id: client_seq_no
        type: u4
        doc: 'Next sequence number A2X expects to receive'
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
        doc: 'Time in force for this order'
      - id: side
        type: u1
        enum: side
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
        type: u2
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_1
        size: 1
      - id: reserved_byte_2
        size: 1
      - id: reserved_4
        size: 4
      - id: reserved_byte_3
        size: 1
      - id: reserved_int_2
        size: 4
      - id: reserved_byte_4
        size: 1
      - id: reserved_int_3
        size: 4
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
        doc: 'Time in force for this order'
      - id: side
        type: u1
        enum: side
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
        type: u2
        doc: 'Clearing account identifier'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_1
        size: 1
      - id: reserved_byte_2
        size: 1
      - id: reserved_4
        size: 4
      - id: reserved_byte_3
        size: 1
      - id: reserved_int_2
        size: 4
      - id: reserved_byte_4
        size: 1
      - id: reserved_int_3
        size: 4
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity (shares) of an order to be executed. Only valid when OrderType = 2 or 3'
      - id: reserved_byte_5
        size: 1
  order_cancel_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
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
      - id: reserved_1
        size: 1
      - id: reserved_byte_2
        size: 1
      - id: reserved_4
        size: 4
      - id: reserved_byte_3
        size: 1
      - id: reserved_int_2
        size: 4
      - id: reserved_byte_4
        size: 1
      - id: reserved_int_3
        size: 4
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
      - id: reserved_int_4
        size: 4
  order_add_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: market_data_id
        type: u4_nullable
        doc: 'The id of this order as seen in the A2X market data. Nullable, No Value = 0'
      - id: order_add_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::cancelled': status_cancel_reason
            'order_status::rejected': status_reject_reason
            _: status
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded if any'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_1
        size: 1
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status:
        value: (peek_order_status_container >> 5) & 7
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
  order_cancel_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: request_ref
        type: u4_nullable
        doc: 'Sequence number (msgSeqNo) of the trading Member''s request message. Nullable, No Value = 0'
      - id: order_cancel_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::cancelled': status_cancel_reason
            'order_status::rejected': status_reject_reason
            _: status
      - id: cancellation_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the cancellation was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status:
        value: (peek_order_status_container >> 5) & 7
        enum: order_status
  order_modify_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: request_ref
        type: u4_nullable
        doc: 'Sequence number (msgSeqNo) of the trading Member''s request message. Nullable, No Value = 0'
      - id: order_modify_response_status
        type:
          switch-on: peek_order_status
          cases:
            'order_status::rejected': status_reject_reason
            _: status_modification_reason
      - id: modification_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the modification was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_1
        size: 1
    instances:
      peek_order_status_container:
        pos: _io.pos
        type: u1
      peek_order_status:
        value: (peek_order_status_container >> 5) & 7
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
  iceberg_order_refresh_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: orig_a2x_ord_id
        type: u4
        doc: 'The ID of the original order as seen in the A2X market data'
      - id: new_a2x_ord_id
        type: u4
        doc: 'The ID of the Iceberg order refresh as seen in the A2X market data'
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
      - id: reserved_1
        size: 1
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_8
        size: 8
      - id: buy_account
        type: u2
        doc: 'Clearing account identifier of the buy side'
      - id: buy_order_capacity
        type: u1
        enum: buy_order_capacity
        doc: 'Order capacity of the buy side'
      - id: reserved_long_2
        size: 8
      - id: sell_account
        type: u2
        doc: 'Clearing account identifier of the sell side'
      - id: sell_order_capacity
        type: u1
        enum: sell_order_capacity
        doc: 'Order capacity of the sell side'
  trade_capture_response_message:
    seq:
      - id: status
        type: status
        doc: 'Status of order and reject or cancel code'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
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
        enum: side
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'Clearing CCP code'
      - id: liq_indicator
        type: u1
        enum: liq_indicator
        doc: 'Liquidity indicator'
      - id: security_id_short
        type: u2
        doc: 'Numeric security identifier'
      - id: trade_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the trade occurred on the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_1
        size: 1
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
        enum: side
        doc: 'Side of the order'
      - id: trade_ref
        type: u4
        doc: 'Trade reference number'
      - id: bust_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the trade was busted by A2X Market Operations. Nanoseconds since Unix epoch'
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
      doc: 'The Login message is the initial message used to establish a trading session. It is also used to re-establish a session after a break.'
    2:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by A2X to acknowledge a Login request, and either accept or reject it.'
    0:
      id: 'heartbeat'
      doc: 'A Heartbeat message is simply a message header with a heartbeat id as the message content. For a heartbeat, msgType is set to 0 and msgSeqNo is set to the sequence number that will be set on the next business message.'
    3:
      id: 'logout_request_message'
      doc: 'The Logout Request message is used by the trading Member to request the closure of a trading session.'
    4:
      id: 'logout_message'
      doc: 'The Logout message is usually sent as a response to the Logout Request however it may also be sent by A2X in case of a low sequence number or other protocol violation, or for other reasons. The TCP/IP connection is closed immediately after this message has been sent.'
    24:
      id: 'order_add_message'
      doc: 'The Add Order message is sent by the trading Member to enter an order for a particular security.'
    25:
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
      doc: 'The Order Modify Extended message is sent when a user wants to modify an open Order Add Extended. Order quantity and/or limit price and/or display quantity and/or minimum quantity may be modified. All values must be included, even if some are unchanged.'
    6:
      id: 'order_add_response_message'
      doc: 'A2X sends an Add Order Response message to acknowledge the receipt of an Order Add message.'
    8:
      id: 'order_cancel_response_message'
      doc: 'A2X sends an Order Cancel Response to accept or reject an Order Cancel message. The message is also used if an order is cancelled by Market Operations or due to cancel on disconnect.'
    10:
      id: 'order_modify_response_message'
      doc: 'A2X sends an Order Modify Response to accept or reject an Order Modify or an Order Modify Extended message.'
    23:
      id: 'iceberg_order_refresh_message'
      doc: 'A2X sends an Iceberg Order Refresh message to notify the Member when an iceberg order is refreshed from the non-displayed reserve quantity.'
    26:
      id: 'trade_capture_message'
      doc: 'A2X uses a Trade Capture Report message for the purpose of allowing members to submit Large in Scale (LS), Negotiated Benchmark Cross (NBC) and Matched Principal (MP) trades to the exchange.'
    18:
      id: 'trade_capture_response_message'
      doc: 'A2X sends a Trade Capture Response Message to accept or reject a Trade Capture Message.'
    11:
      id: 'trade_message'
      doc: 'The Trade message is published when an order executes. The Trade message is also used to communicate indicative trade reports at lock time for Market at Close orders. Note that the price and tradeRef values will be zero for indicative trade reports published when MaC orders are matched at lock time.'
    12:
      id: 'trade_bust_message'
      doc: 'If a trade is invalidated, a Trade Bust message is sent to notify the trading Member.'
  result_code:
    0:
      id: 'successful_login'
      doc: 'Successful login'
    1:
      id: 'already_logged_in'
      doc: 'Already logged in'
    2:
      id: 'sequence_number_error'
      doc: 'Sequence number error'
    3:
      id: 'unsupported_protocol'
      doc: 'Unsupported protocol'
    4:
      id: 'failed_authentication'
      doc: 'Failed authentication (incorrect password)'
    5:
      id: 'unknown_source_network'
      doc: 'Unknown Source Network'
  logout_reason_code:
    0:
      id: 'user_requested'
      doc: 'User requested'
    1:
      id: 'admin'
      doc: 'Admin (market operations)'
    2:
      id: 'disconnect'
      doc: 'Disconnect'
    3:
      id: 'end_of_day'
      doc: 'End Of Day'
    4:
      id: 'inactivity_timeout'
      doc: 'Inactivity timeout'
    5:
      id: 'protocol_error'
      doc: 'Protocol error'
    6:
      id: 'sequence_number_error'
      doc: 'Sequence number error'
  order_type:
    1:
      id: 'limit_order'
      doc: 'Limit Order'
    2:
      id: 'auction_on_demand_limit_order'
      doc: 'Auction on Demand (Limit Order)'
    3:
      id: 'auction_on_demand_trade_at_middle_limit_or_pegged_limit'
      doc: 'Auction on Demand (Trade at Middle/Limit or Pegged/Limit)'
    6:
      id: 'market_at_close'
      doc: 'Market At Close'
    8:
      id: 'post_only_cancel_replace'
      doc: 'Post Only Cancel Replace (POCR)'
    9:
      id: 'post_only'
      doc: 'Post-Only (PO)'
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
      doc: 'Good for Auction (GFA)'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy order'
    2:
      id: 'sell_order'
      doc: 'Sell order'
  order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
  cancel_reason:
    1:
      id: 'member_request'
      doc: 'Member request'
    2:
      id: 'a2x_forced_cancel'
      doc: 'A2X forced cancel'
    3:
      id: 'market_close'
      doc: 'Market close'
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
      doc: 'Self-trade prevention'
    8:
      id: 'cancel_on_disconnect'
      doc: 'Cancel on disconnect'
    9:
      id: 'post_only_cancel'
      doc: 'Post-only cancel (cancel to prevent aggressive trade)'
    10:
      id: 'cancel_residual_quantity'
      doc: 'Cancel residual quantity'
    11:
      id: 'post_only_cancel_resting'
      doc: 'Post-only cancel resting (cancel to prevent aggressive trade)'
    12:
      id: 'minimum_resting_value'
      doc: 'Minimum resting value'
  order_status:
    1:
      id: 'pending_new'
      doc: 'Pending New (Internal use only)'
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
      id: 'order_not_found_not_open'
      doc: 'Order Not Found / Not Open'
    14:
      id: 'no_clearing_in_place'
      doc: 'No Clearing In Place'
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
      id: 'drop_feed_is_down'
      doc: 'Drop Feed Is Down'
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
      id: 'order_cancelled'
      doc: 'Order cancelled as a result of modification which updates the remaining quantity to zero'
  trade_capture_type:
    1:
      id: 'large_in_scale'
      doc: 'Large in Scale (LS)'
    3:
      id: 'negotiated_benchmark_cross'
      doc: 'Negotiated Benchmark Cross (NBC)'
    5:
      id: 'matched_principal'
      doc: 'Matched Principal (MP)'
  buy_order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
  sell_order_capacity:
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
  ccp_code:
    1:
      id: 'self_clearing'
      doc: 'Self clearing'
    2:
      id: 'emcfnl_2_a'
      doc: 'Emcfnl 2 A'
  liq_indicator:
    1:
      id: 'added_liquidity'
      doc: 'Added liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed liquidity'
    3:
      id: 'removed_liquidity_hidden_quantity'
      doc: 'Removed liquidity (hidden quantity)'

