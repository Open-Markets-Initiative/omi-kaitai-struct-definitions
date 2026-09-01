# ---------------------------------------------------------------------
# Kaitai struct definition for: Jnx JnxBonds Pts Itch v1.2
#
# Protocol:
#   Organization: Japannext Securities
#   Protocol: Proprietary Trading System
#   Encoding: Itch
#   Version: 1.2
#   Date: 04/01/2020
#   Specification: Japannext_PTS_ITCH_Bonds_v1.2.pdf
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
  id: jnx_jnxbonds_pts_itch_v1_2
  title: Jnx JnxBonds Pts Itch v1.2
  license: GPL-3.0
  endian: be

doc: 'Japannext Securities Japannext Bonds Proprietary Trading System Itch v1.2'
doc-ref: https://www.japannext.co.jp/library

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::seconds_message': seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::price_tick_size_message': price_tick_size_message
            'message_type::orderbook_directory_message': orderbook_directory_message
            'message_type::trading_state_message': trading_state_message
            'message_type::order_added_message': order_added_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_deleted_message': order_deleted_message
            'message_type::order_replaced_message': order_replaced_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  seconds_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since midnight of the day that the trading session started. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier'
      - id: system_event
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Refer to the System Events table below'
  price_tick_size_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price tick size table identifier'
      - id: price_tick_size
        type: u4
        doc: 'Price tick size'
      - id: price_start
        type: decimal_s4_3
        doc: 'Start of price range for this price tick size. Implied decimal with scale 1e-3'
  orderbook_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook_id
        type: u4
        doc: 'Bond code per SICC definition'
      - id: orderbook_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'International Securities Identification Number (ISIN)'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier'
      - id: round_lot_size
        type: u4
        doc: 'Number of bonds that represent a round lot'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price tick size table identifier'
      - id: price_decimals
        type: u4
        doc: 'Number of decimal places in price fields'
      - id: upper_price_limit
        type: decimal_s4_3
        doc: 'Maximum tradable price. Implied decimal with scale 1e-3'
      - id: lower_price_limit
        type: decimal_s4_3
        doc: 'Minimum tradable price. Implied decimal with scale 1e-3'
  trading_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook_id
        type: u4
        doc: 'Bond code per SICC definition'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state'
  order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Total number of bonds added to the book'
      - id: orderbook_id
        type: u4
        doc: 'Bond code per SICC definition'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier'
      - id: price
        type: decimal_s4_3
        doc: 'Yield of the order. Implied decimal with scale 1e-3'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order'
      - id: executed_quantity
        type: u4
        doc: 'Number of bonds executed'
      - id: match_number
        type: u8
        doc: 'Reference number of the match'
  order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order'
  order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: original_order_number
        type: u8
        doc: 'Reference number of the original order'
      - id: new_order_number
        type: u8
        doc: 'Reference number of the replaced order'
      - id: quantity
        type: u4
        doc: 'Total number of bonds added to the book'
      - id: price
        type: decimal_s4_3
        doc: 'Yield of the order. Implied decimal with scale 1e-3'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_s4_3:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 1000.0

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Number of seconds past midnight that the message was generated; the nanoseconds portion is provided in subsequent messages as the number of nanoseconds since the most recent Timestamp Seconds Message.'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal data feed, system and market events.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Price Tick Size Messages define a set of price tick size tables.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Messages provide information about orderbooks available in the Japannext PTS execution system.'
    0x48:
      id: 'trading_state_message'
      doc: 'Trading State Message indicates current trading status of an orderbook.'
    0x41:
      id: 'order_added_message'
      doc: 'Order Added Message indicates that a new order has been accepted by the Japannext PTS execution system and was added to the displayable book.'
    0x45:
      id: 'order_executed_message'
      doc: 'Order Executed Message is sent whenever an order in the book is executed in whole or part.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Order Deleted Message is sent whenever an order in the book has been canceled.'
    0x55:
      id: 'order_replaced_message'
      doc: 'Order Replaced Message is sent whenever an order in the book has been replaced.'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

