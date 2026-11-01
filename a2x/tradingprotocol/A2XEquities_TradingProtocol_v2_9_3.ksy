# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X TradingProtocol Atp v2.9.3
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: A2X Binary Protocol
#   Encoding: A2X Binary Protocol
#   Version: 2.9.3
#   Date: 7/13/2026
#   Specification: A2X ATP Binary Protocol Specification v2.9.3.pdf
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
  id: a2x_a2xequities_tradingprotocol_atp_v2_9_3
  title: A2X TradingProtocol Atp v2.9.3
  license: GPL-3.0
  endian: le

doc: 'A2X Markets A2X Equities A2X Binary Protocol Atp v2.9.3'
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
            'msg_type::order_add_response_message': order_add_response_message
            'msg_type::order_cancel_message': order_cancel_message
            'msg_type::order_cancel_response_message': order_cancel_response_message
            'msg_type::order_modify_message': order_modify_message
            'msg_type::order_modify_extended_message': order_modify_extended_message
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
      - id: reserved_16
        size: 16
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
      - id: reserved_16
        size: 16
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
      - id: min_qty
        type: u4
        doc: 'Minimum quantity (shares) of an order to be executed. Only valid when OrderType = 2 or 3'
  order_add_response_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: market_data_id
        type: u4_nullable
        doc: 'The id of this order as seen in the A2X market data. Nullable, No Value = 0'
      - id: status
        type: status
        doc: 'Status of order and reject or cancel code'
      - id: traded_quantity
        type: u4
        doc: 'Number of shares traded if any'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time that the order was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
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
  order_cancel_message:
    seq:
      - id: order_ref
        type: u4
        doc: 'Order reference number'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
      - id: reserved_16
        size: 16
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
      - id: cancellation_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the cancellation was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
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
      - id: reserved_16
        size: 16
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
      - id: reserved_16
        size: 16
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity'
      - id: display_quantity
        type: u4_nullable
        doc: 'Display quantity for an iceberg order. Nullable, No Value = 0'
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
      - id: modification_timestamp
        type: nanosecond_timestamp
        doc: 'Time that the modification was accepted or rejected by the A2X system. Nanoseconds since Unix epoch'
      - id: user_tag
        type: u8
        doc: 'Free form tag assigned by trading Member'
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
    6:
      id: 'order_add_response_message'
      doc: 'A2X sends an Add Order Response message to acknowledge the receipt of an Order Add message.'
    7:
      id: 'order_cancel_message'
      doc: 'The Order Cancel message is sent when a user wishes to cancel an open order.'
    8:
      id: 'order_cancel_response_message'
      doc: 'A2X sends an Order Cancel Response to accept or reject an Order Cancel message. The message is also used if an order is cancelled by Market Operations or due to cancel on disconnect.'
    9:
      id: 'order_modify_message'
      doc: 'The Order Modify message is sent when a user wishes to modify an open order. Order quantity and/or limit price may be modified. Both values must be included, even if one of them is unchanged.'
    22:
      id: 'order_modify_extended_message'
      doc: 'The Order Modify Extended message is sent when a user wants to modify an open Order Add Extended. Order quantity and/or limit price and/or display quantity and/or minimum quantity may be modified. All values must be included, even if some are unchanged.'
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
    0:
      id: 'unchanged'
      doc: 'Unchanged'
    1:
      id: 'agency'
      doc: 'Agency'
    2:
      id: 'principal'
      doc: 'Principal'
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

