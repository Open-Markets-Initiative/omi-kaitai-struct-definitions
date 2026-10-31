# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis Snapshot Amd v4.2
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Aquis Market Data Snapshot
#   Encoding: Aquis Market Data Protocol
#   Version: 4.2
#   Date: 8/17/2026
#   Specification: Aquis Market Data Technical Specification v4.2.pdf
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
  id: aquis_aquisequities_snapshot_amd_v4_2
  title: Aquis Snapshot Amd v4.2
  license: GPL-3.0
  endian: le

doc: 'Aquis Exchange Aquis Equities Aquis Market Data Snapshot Amd v4.2'
doc-ref: https://www.aquis.eu/markets/documents

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
            'msg_type::mac_book_entry_message': mac_book_entry_message
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
        doc: 'Continuous trading open or closed'
      - id: mac_open
        type: b1
        doc: 'MaC open or closed'
      - id: mac_run
        type: b1
        doc: 'MaC locked down or not'
      - id: unused_2
        type: b2
        doc: 'Reserved'
      - id: macplus_open
        type: b1
        doc: 'MaC+ open or closed'
      - id: macplus_run
        type: b1
        doc: 'MaC+ locked down or not'
      - id: unused_1
        type: b1
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
  mac_book_entry_message:
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
      doc: 'A Snapshot Start message is published as the first message in a snapshot to identify the sequence number in the continuous stream that this snapshot relates to. It also states the number of securities being reported in this snapshot.'
    11:
      id: 'book_status_message'
      doc: 'A Book Status message is published to report the trading and market status of each security and the number of open orders on the order book for the security at the time of the snapshot.'
    12:
      id: 'book_entry_message'
      doc: 'An appropriate number of Book Entry messages is published after each Book Status message to provide details of each order and allow the book to be built.'
    18:
      id: 'mac_book_entry_message'
      doc: 'During the MaC phase, Aquis will publish the volume of the first 5 valid best bid and offer orders per security in chronological order using the MaC Book Entry Message.'
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
    8:
      id: 'aod_start'
      doc: 'AoD Start'
    24:
      id: 'aod_finish'
      doc: 'AoD Finish'
  trading:
    0:
      id: 'continuous_trading_closed'
      doc: 'Continuous Trading Closed'
    1:
      id: 'continuous_trading_open'
      doc: 'Continuous Trading Open'
  mac_open:
    0:
      id: 'mac_is_closed'
      doc: 'MaC is Closed'
    1:
      id: 'mac_is_open'
      doc: 'MaC is Open'
  mac_run:
    0:
      id: 'mac_is_not_locked_down'
      doc: 'MaC is not locked down'
    1:
      id: 'mac_is_locked_down'
      doc: 'MaC is locked down'
  macplus_open:
    0:
      id: 'mac_plus_is_closed'
      doc: 'MaC+ is closed'
    1:
      id: 'mac_plus_is_open'
      doc: 'MaC+ is open'
  macplus_run:
    0:
      id: 'mac_plus_is_not_locked_down'
      doc: 'MaC + is not locked down'
    1:
      id: 'mac_plus_is_locked_down'
      doc: 'MaC + is locked down'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'

