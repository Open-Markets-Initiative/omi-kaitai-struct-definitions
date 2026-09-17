# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexEquities Tops IexTp v1.56
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Top Of Book
#   Encoding: Investors Exchange Transport Protocol
#   Version: 1.56
#   Date: 9/23/2016
#   Specification: IEX TOPS Specification.pdf
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
  id: iex_iexequities_tops_iextp_v1_56
  title: Iex IexEquities Tops IexTp v1.56
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Equities Top Of Book IexTp v1.56'
doc-ref: https://www.iexexchange.io/resources/trading/documents

seq:
  - id: iextp_header
    type: iextp_header_struct
    doc: 'IexTp packet header'
  - id: messages
    repeat: expr
    repeat-expr: iextp_header.message_count
    type:
      switch-on: iextp_header.message_count
      cases:
        _: message

types:
  iextp_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Version of transport specification'
      - id: reserved
        size: 1
        doc: 'Reserved byte'
      - id: message_protocol_id
        type: u2
        doc: 'Unique identifier of the higher layer protocol'
      - id: channel_id
        type: u4
        doc: 'Identifies the stream of bytes sequenced messages'
      - id: session_id
        type: u4
        doc: 'Identifies the session'
      - id: payload_length
        type: u2
        doc: 'Byte length of the payload'
      - id: message_count
        type: u2
        doc: 'Number of messages in the payload'
      - id: stream_offset
        type: u8
        doc: 'Byte offset of the data stream'
      - id: first_message_sequence_number
        type: u8
        doc: 'Sequence of the first message in the segment'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of segment. Nanoseconds since Unix epoch'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'IexTp message header'
      - id: message_data
        size: message_header.message_length + 2 - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::quote_update_message': quote_update_message
            'message_type::trade_report_message': trade_report_message
            'message_type::trade_break_message': trade_break_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  quote_update_message:
    seq:
      - id: quote_update_flags
        type: quote_update_flags
        doc: 'Quote Update Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: bid_size
        type: u4
        doc: 'Aggregate quoted best bid size'
      - id: bid_price
        type: decimal_s8_4
        doc: 'Best quoted bid price. Implied decimal with scale 1e-4'
      - id: ask_price
        type: decimal_s8_4
        doc: 'Best quoted ask price. Implied decimal with scale 1e-4'
      - id: ask_size
        type: u4
        doc: 'Aggregate quoted best ask size'
  quote_update_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_6
        type: b6
        doc: 'Unused'
      - id: market_session
        type: b1
        doc: 'Market Session Flag'
      - id: symbol_availability
        type: b1
        doc: 'Symbol is halted, paused, or otherwise not available for trading on IEX'
  trade_report_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Trade volume'
      - id: price
        type: decimal_s8_4
        doc: 'Trade price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier. Trade ID is also'
      - id: reserved_4
        type: u4
        doc: 'Reserved bytes'
  sale_condition_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: trade_through_exempt
        type: b1
        doc: 'Trade is not subject to Rule 611'
      - id: odd_lot
        type: b1
        doc: 'Odd Lot'
      - id: extended_hours
        type: b1
        doc: 'Extended Hours Trade'
      - id: intermarket_sweep
        type: b1
        doc: 'Intermarket Sweep Order'
  trade_break_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Trade volume'
      - id: price
        type: decimal_s8_4
        doc: 'Trade price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier. Trade ID is also'
      - id: reserved_4
        type: u4
        doc: 'Reserved bytes'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x51:
      id: 'quote_update_message'
      doc: 'Tops broadcasts a real-time Quote Update Message each time IEX''s best bid or offer quotation is updated during the trading day'
    0x54:
      id: 'trade_report_message'
      doc: 'Trade Report Messages are sent when an order on the IEX Order Book is executed in whole or in part'
    0x42:
      id: 'trade_break_message'
      doc: 'Trade Break Messages are sent when an execution on IEX is broken on that same trading day'

