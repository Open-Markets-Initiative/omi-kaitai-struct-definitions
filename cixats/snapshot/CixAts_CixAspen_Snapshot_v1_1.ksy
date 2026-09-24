# ---------------------------------------------------------------------
# Kaitai struct definition for: CixAts Snapshot TcpOut v1.1
#
# Protocol:
#   Organization: CIX Trading Inc.
#   Protocol: CIX Tcp Snapshot
#   Encoding: TcpOut
#   Version: 1.1
#   Date: 9/15/2025
#   Specification: Market Data Recovery Feed Specification-1.1.pdf
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
  id: cixats_cixaspen_snapshot_tcpout_v1_1
  title: CixAts Snapshot TcpOut v1.1
  license: GPL-3.0
  endian: le

doc: 'CIX Trading Inc. CIX Aspen CIX Tcp Snapshot TcpOut v1.1'
doc-ref: https://www.thecix.ca/market-data

seq:
  - id: tcp_packet
    type: tcp_packet_struct
    repeat: eos
    doc: 'Length delimited TcpOut packet'

types:
  tcp_packet_struct:
    seq:
      - id: packet_header
        type: packet_header
        doc: 'TcpOut packet header'
      - id: packet_payload
        size: packet_header.length - 3
        type:
          switch-on: packet_header.packet_type
          cases:
            'packet_type::login_message': login_message
            'packet_type::successful_login_message': successful_login_message
            'packet_type::login_reject_message': login_reject_message
            'packet_type::binary_data_message': binary_data_message
  packet_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying the TcpOut packet type'
  login_message:
    seq:
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username'
      - id: pass_field
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password'
      - id: market_day_identifier
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier for trading day'
      - id: feed_identifier
        type: u1
        enum: feed_identifier
        doc: 'Unique code for feed'
      - id: requested_sequence
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Requested starting sequence, 0 starts at the latest message and snapshot connections must specify 1'
  successful_login_message:
    seq:
      - id: market_day_identifier
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier for trading day'
      - id: feed_identifier
        type: u1
        enum: feed_identifier
        doc: 'Unique code for feed'
      - id: next_sequence
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ascii sequence number of the next Binary Data Message'
  login_reject_message:
    seq:
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'Reject Reason'
  binary_data_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying the encapsulated message type'
      - id: payload
        size: _parent.packet_header.length - 3 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::market_event_message': market_event_message
            'message_type::symbol_information_message': symbol_information_message
            'message_type::symbol_state_message': symbol_state_message
            'message_type::new_order_add_message': new_order_add_message
            'message_type::order_partial_cancel_message': order_partial_cancel_message
            'message_type::order_cancel_all_message': order_cancel_all_message
            'message_type::order_executed_message': order_executed_message
            'message_type::end_of_snapshot_message': end_of_snapshot_message
  market_event_message:
    seq:
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: event_field
        type: u1
        enum: event_field
        doc: 'Session state event code'
  symbol_information_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'Code identifying the primary listing market'
      - id: board_lot_size
        type: u4
        doc: 'Board Lot Size in Shares'
  symbol_state_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: state
        type: u1
        enum: state
        doc: 'Symbol trading state'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: info
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'optional text'
  new_order_add_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: decimal_u8_6
        doc: 'Quantity - 6 implied decimals. Implied decimal with scale 1e-6'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_6
        doc: 'Price - 6 implied decimals. Implied decimal with scale 1e-6'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Three digit number Broker Number or 001 for anonymous'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  order_partial_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: quantity_canceled
        type: decimal_u8_6
        doc: 'Quantity canceled - Quantity 6 implied decimals. Implied decimal with scale 1e-6'
  order_cancel_all_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: quantity
        type: decimal_u8_6
        doc: 'Quantity - 6 implied decimals. Implied decimal with scale 1e-6'
      - id: execution_id
        type: u8
        doc: 'Market Issued Unique Execution ID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price
        type: decimal_u8_6
        doc: 'Price - 6 implied decimals. Implied decimal with scale 1e-6'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Three digit number Broker Number or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Three digit number Broker Number of the contra order or 001 for anonymous'
  end_of_snapshot_message:
    seq:
      - id: sequence
        type: u8
        doc: 'Multicast output feed sequence number of the previous message, where this snapshot ends'
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
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  packet_type:
    0x4c:
      id: 'login_message'
      doc: 'TcpOut Login Message'
    0x52:
      id: 'client_heartbeat_message'
      doc: 'TcpOut Client Heartbeat Message'
    0x41:
      id: 'successful_login_message'
      doc: 'TcpOut Successful Login Message'
    0x4a:
      id: 'login_reject_message'
      doc: 'TcpOut Login Reject Message'
    0x48:
      id: 'server_heartbeat_message'
      doc: 'TcpOut Server Heartbeat Message'
    0x53:
      id: 'binary_data_message'
      doc: 'TcpOut Binary Data Message'
  feed_identifier:
    0x41:
      id: 'aspen'
      doc: 'Aspen'
    0x56:
      id: 'aspen_vert'
      doc: 'Aspen Vert'
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x42:
      id: 'aspen_uat'
      doc: 'Aspen Uat'
    0x57:
      id: 'aspen_vert_uat'
      doc: 'Aspen Vert Uat'
    0x4e:
      id: 'midpoint_uat'
      doc: 'Midpoint Uat'
  reason_code:
    0x41:
      id: 'invalid_user_password'
      doc: 'Invalid User/Password'
    0x42:
      id: 'invalid_sequence'
      doc: 'Invalid Sequence'
    0x53:
      id: 'invalid_market_day_feed_id'
      doc: 'Invalid Market Day/Feed Id'
  message_type:
    0x41:
      id: 'market_event_message'
      doc: 'Transitions in the overall session state'
    0x42:
      id: 'symbol_information_message'
      doc: 'Reference data for each symbol that may be traded'
    0x43:
      id: 'symbol_state_message'
      doc: 'Individual symbol trading state (halts)'
    0x44:
      id: 'new_order_add_message'
      doc: 'A new resting order added to the book'
    0x46:
      id: 'order_partial_cancel_message'
      doc: 'Part of a resting order is canceled'
    0x47:
      id: 'order_cancel_all_message'
      doc: 'Sent when the order is canceled in its entirety'
    0x4a:
      id: 'order_executed_message'
      doc: 'Sent when an order is executed'
    0x58:
      id: 'end_of_snapshot_message'
      doc: 'Sent once the snapshot has completed'
  event_field:
    0x4f:
      id: 'start_of_session'
      doc: 'Start Of Session'
    0x53:
      id: 'market_accepting_orders'
      doc: 'Market Accepting Orders'
    0x51:
      id: 'market_open_for_trading'
      doc: 'Market Open For Trading'
    0x45:
      id: 'market_closed_for_trading'
      doc: 'Market Closed For Trading'
    0x43:
      id: 'end_of_session'
      doc: 'End Of Session'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'venture'
      doc: 'Venture'
    0x43:
      id: 'cse'
      doc: 'Cse'
    0x4e:
      id: 'neo'
      doc: 'Neo'
  state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

