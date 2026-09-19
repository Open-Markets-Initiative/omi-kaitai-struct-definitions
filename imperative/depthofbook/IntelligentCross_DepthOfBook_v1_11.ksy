# ---------------------------------------------------------------------
# Kaitai struct definition for: Imperative DepthOfBook Aspen v1.11
#
# Protocol:
#   Organization: Imperative Execution
#   Protocol: Depth Of Book
#   Encoding: Aspen
#   Version: 1.11
#   Date: 7/30/2020
#   Specification: IntelligentCrossMarketDataFeedSpec.v.1.11.pdf
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
  id: imperative_intelligentcross_depthofbook_aspen_v1_11
  title: Imperative DepthOfBook Aspen v1.11
  license: GPL-3.0
  endian: le

doc: 'Imperative Execution Intelligent Cross Depth Of Book Aspen v1.11'
doc-ref: https://www.imperativex.com/market-data

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.count

types:
  packet_header_struct:
    seq:
      - id: market_day_identifier
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier for trading day'
      - id: feed_identifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Unique code for feed'
      - id: sequence
        type: u8
        doc: 'Sequence number for next message'
      - id: count
        type: u2
        doc: 'Number of messages in packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Length of the message'
      - id: payload
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::market_event_message': market_event_message
            'message_type::symbol_information_message': symbol_information_message
            'message_type::symbol_state_message': symbol_state_message
            'message_type::new_order_add_message': new_order_add_message
            'message_type::order_partial_cancel_message': order_partial_cancel_message
            'message_type::order_cancel_all_message': order_cancel_all_message
            'message_type::order_updated_message': order_updated_message
            'message_type::order_executed_message': order_executed_message
            'message_type::trade_message': trade_message
            'message_type::trade_break_message': trade_break_message
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying message type'
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
        doc: 'Event Values'
  symbol_information_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
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
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: round_lot_size
        type: u4
        doc: 'size of one round lot'
  symbol_state_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: state
        type: u1
        enum: state
        doc: 'State Values'
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
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: side
        type: u1
        enum: side
        doc: '''B''/''S'''
      - id: shares
        type: u4
        doc: 'Qty'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_6
        doc: 'Price -6 implied decimals. Implied decimal with scale 1e-6'
      - id: reserved_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  order_partial_cancel_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: shares_canceled
        type: u4
        doc: 'Number of shares cancelled'
  order_cancel_all_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
  order_updated_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: shares
        type: u4
        doc: 'Qty'
      - id: price
        type: decimal_u8_6
        doc: 'Price -6 implied decimals. Implied decimal with scale 1e-6'
  order_executed_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Market Issued Unique Order ID'
      - id: shares
        type: u4
        doc: 'Qty'
      - id: execution_id
        type: u8
        doc: 'Market Issued Unique Execution ID'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: price
        type: decimal_u8_6
        doc: 'Price -6 implied decimals. Implied decimal with scale 1e-6'
  trade_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: reserved_8
        type: u8
        doc: 'Reserved for future use'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: shares
        type: u4
        doc: 'Qty'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol'
      - id: price
        type: decimal_u8_6
        doc: 'Price -6 implied decimals. Implied decimal with scale 1e-6'
      - id: execution_id
        type: u8
        doc: 'Market Issued Unique Execution ID'
  trade_break_message:
    seq:
      - id: symbol_id
        type: u2
        doc: 'Symbol Index'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds Since Epoch (UTC). Nanoseconds since Unix epoch'
      - id: execution_id
        type: u8
        doc: 'Market Issued Unique Execution ID'
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
  message_type:
    0x41:
      id: 'market_event_message'
      doc: 'This message appears on all quote channels and indicates the beginning of a spin message cycle'
    0x42:
      id: 'symbol_information_message'
      doc: 'Symbol Information'
    0x43:
      id: 'symbol_state_message'
      doc: 'Symbol State'
    0x44:
      id: 'new_order_add_message'
      doc: 'New Order Add'
    0x46:
      id: 'order_partial_cancel_message'
      doc: 'Order Partial Cancel'
    0x47:
      id: 'order_cancel_all_message'
      doc: 'Order Cancel All'
    0x48:
      id: 'order_updated_message'
      doc: 'Order Updated'
    0x4a:
      id: 'order_executed_message'
      doc: 'Sent when a visible order is executed'
    0x4b:
      id: 'trade_message'
      doc: 'Sent when a hidden order is executed'
    0x4d:
      id: 'trade_break_message'
      doc: 'Trade Break'
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
      id: 'market_trading_ended_for_day'
      doc: 'Market Trading Ended For Day'
    0x43:
      id: 'end_of_session'
      doc: 'End Of Session'
  listing_market:
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x50:
      id: 'arca'
      doc: 'Arca'
    0x5a:
      id: 'bats'
      doc: 'Bats'
    0x41:
      id: 'amex'
      doc: 'Amex'
    0x56:
      id: 'iex'
      doc: 'Iex'
  state:
    0x49:
      id: 'inactive'
      doc: 'Inactive'
    0x41:
      id: 'active'
      doc: 'Active'
    0x44:
      id: 'disabled'
      doc: 'Disabled'
    0x45:
      id: 'enabled'
      doc: 'Enabled'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x43:
      id: 'end_of_session'
      doc: 'End Of Session'

