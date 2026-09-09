# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCm Snapshot Binary v6.8
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Mtbt Order Book Snapshot Recovery
#   Encoding: Binary
#   Version: 6.8
#   Date: 12/1/2025
#   Specification: MTBT_CM_NNF_PROTOCOL_6_8_20260401172216.pdf
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
  id: nse_nsecm_snapshot_binary_v6_8
  title: Nse NseCm Snapshot Binary v6.8
  license: GPL-3.0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE Capital Market Mtbt Order Book Snapshot Recovery Binary v6.8'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: snapshot_header
    type: snapshot_header_struct
    doc: 'Snapshot header has a size of 16 bytes'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: snapshot_header.number_of_records
    doc: 'Order Book message. First field is always Message Type and must be read/interpreted first'

types:
  snapshot_header_struct:
    seq:
      - id: trans_code
        type: s2
        enum: trans_code
        doc: 'Transcode of the message [2, Short]'
      - id: size
        type: s4
        doc: 'Total size of the message, including snapshot header [4, Int]'
      - id: number_of_records
        type: s4
        doc: 'Number of orders in the current message [4, Int]'
      - id: last_sequence_number
        type: u4
        doc: 'Last sequence number of tick received on Mtbt till which this snapshot is published. For Equity Derivative (FO) segment, this field is unsigned int [4, Uint]'
      - id: stream_id
        type: s2
        doc: 'Identifies a particular stream [2, Short]'
  message_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying message type [1, Char]'
      - id: payload
        type:
          switch-on: message_type
          cases:
            'message_type::new_order_message': new_order_message
            'message_type::new_spread_order_message': new_spread_order_message
  new_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  new_spread_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
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
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

enums:
  trans_code:
    10501:
      id: 'order_book_snapshot'
      doc: 'Transcode carried by every Mtbt order book snapshot buffer'
  message_type:
    0x4e:
      id: 'new_order_message'
      doc: 'Outstanding normal order in the order book at the last snapshot refresh.'
    0x47:
      id: 'new_spread_order_message'
      doc: 'Outstanding spread order in the order book at the last snapshot refresh.'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'

