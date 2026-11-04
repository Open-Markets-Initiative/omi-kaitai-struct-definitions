# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis Snapshot Amd v1.2.3
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Snapshot
#   Encoding: Aquis Market Data Protocol
#   Version: 1.2.3
#   Date: 4/23/2024
#   Specification: Aquis Stock Exchange Multicast Market Data Specification v1.2.3 (2024).pdf
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
  id: aquis_aquisstockexchange_snapshot_amd_v1_2_3
  title: Aquis Snapshot Amd v1.2.3
  license: MIT-0
  endian: le

doc: 'Aquis Exchange Aquis Stock Exchange Snapshot Amd v1.2.3'
doc-ref: https://www.aquisexchange.com/aquis-stock-exchange

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Aquis udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Aquis Amd Message'

types:
  packet_header_struct:
    seq:
      - id: message_count
        type: u1
        doc: 'number of messages (n) in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis market data message header'
      - id: payload
        size: message_header.msg_length - 6
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::snapshot_start_message': snapshot_start_message
            'msg_type::book_status_message': book_status_message
            'msg_type::book_entry_message': book_entry_message
  message_header:
    seq:
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Message type identifier'
      - id: msg_length
        type: u1
        doc: 'Length of market data message, including header'
      - id: seq_no
        type: u4
        doc: 'Sequence number of this message in the market data stream for the current trading day'
  snapshot_start_message:
    seq:
      - id: stream_seq_no
        type: u4
        doc: 'The sequence number of the last message in the continuous stream which relates to this snapshot'
      - id: security_count
        type: u2
        doc: 'Number of securities reported in this snapshot'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp of this snapshot. Nanoseconds since Unix epoch'
  book_status_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the security'
      - id: market_flags
        type: market_flags
        doc: 'Market status flags'
      - id: entries
        type: u2
        doc: 'Number of open orders in the book for this security'
      - id: closing_buy_qty
        type: u4_nullable
        doc: 'Total order quantity on the buy side during the closing market. Nullable, No Value = 0'
      - id: closing_sell_qty
        type: u4_nullable
        doc: 'Total order quantity on the sell side during the closing market. Nullable, No Value = 0'
      - id: indicative_price
        type: decimal_u8_5
        doc: 'Indicative auction price. Implied decimal with scale 1e-5'
  market_flags:
    meta:
      bit-endian: le
    seq:
      - id: trading
        type: b1
        doc: 'Continuous trading open or closed, which also states whether AoD is available'
      - id: unused_2
        type: b2
        doc: 'Reserved'
      - id: pre_open_close
        type: b1
        doc: 'Pre-open or pre-close market phase, read with the trading bit: pre-open when trading is closed, pre-close when it is open'
      - id: unused_4
        type: b4
        doc: 'Reserved'
  book_entry_message:
    seq:
      - id: security_id
        type: u2
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of open shares'
      - id: price
        type: decimal_u8_5
        doc: 'The price of the order. Implied decimal with scale 1e-5'
      - id: order_ref
        type: u4
        doc: 'Unique order reference number for the day'
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
  decimal_u8_5:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000.0

enums:
  msg_type:
    10:
      id: 'snapshot_start_message'
      doc: 'A Snapshot Start message is published as the first message in a snapshot to identify the sequence number in the continuous stream that this snapshot relates to. It also states the number of securities being reported in this snapshot. This message is only applicable to continuous trading.'
    11:
      id: 'book_status_message'
      doc: 'A Book Status message is published to report the trading and market status of each security and the number of open orders on the order book for the security at the time of the snapshot. This message is only applicable to continuous trading.'
    12:
      id: 'book_entry_message'
      doc: 'An appropriate number of Book Entry messages is published after each Book Status message to provide details of each order and allow the book to be built. This message is only applicable to continuous trading.'
  trading_status:
    1:
      id: 'active'
      doc: 'Active'
    2:
      id: 'halted'
      doc: 'Halted'
    3:
      id: 'suspended'
      doc: 'Suspended'
  trading:
    0:
      id: 'continuous_trading_closed'
      doc: 'Continuous Trading Closed (AoD unavailable)'
    1:
      id: 'continuous_trading_open'
      doc: 'Continuous Trading Open (AoD available)'
  pre_open_close:
    0:
      id: 'not_a_pre_phase'
      doc: 'Not a pre phase'
    1:
      id: 'pre_phase'
      doc: 'Pre phase'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'

