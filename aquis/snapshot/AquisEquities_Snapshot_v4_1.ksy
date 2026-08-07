# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis AquisEquities Snapshot Amd v4.1
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Aquis Market Data Snapshot
#   Encoding: Aquis Market Data Protocol
#   Version: 4.1
#   Date: 1/1/2026
#   Specification: Unknown
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: aquis_aquisequities_snapshot_amd_v4_1
  title: Aquis AquisEquities Snapshot Amd v4.1
  license: GPL-3.0
  endian: be

doc: 'Aquis Exchange Aquis Equities Aquis Market Data Snapshot Amd v4.1'
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
        doc: 'Number of messages in this packet'
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
            'msg_type::ma_c_book_entry_message': ma_c_book_entry_message
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
        type: u4le
        doc: 'Sequence number of the last message in the continuous stream which relates to this snapshot'
      - id: security_count
        type: u2le
        doc: 'Number of securities reported in this snapshot'
      - id: timestamp
        type: u8le
        doc: 'Timestamp of this snapshot'
  book_status_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the security'
      - id: market_flags
        type: market_flags
        doc: 'Market status flags'
      - id: entries
        type: u2le
        doc: 'Number of open orders in the book for this security'
      - id: closing_buy_qty
        type: u4le
        doc: 'Total order quantity on the buy side during the closing market; otherwise 0'
      - id: closing_sell_qty
        type: u4le
        doc: 'Total order quantity on the sell side during the closing market; otherwise 0'
      - id: indicative_price
        type: u8le
        doc: 'Indicative auction price'
  market_flags:
    seq:
      - id: trading
        type: b1
        doc: 'Continuous trading status; 0 = Closed, 1 = Open'
      - id: mac_open
        type: b1
        doc: 'MaC status; 0 = Closed, 1 = Open'
      - id: mac_run
        type: b1
        doc: 'MaC lockdown status; 0 = Not locked down, 1 = Locked down'
      - id: reserved
        type: b5
        doc: 'Reserved'
  book_entry_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u4le
        doc: 'Number of open shares'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Unique order reference number for the day'
  ma_c_book_entry_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: side
        type: u1
        enum: side
        doc: '1 = Buy Order, 2 = Sell Order'
      - id: quantity
        type: u4le
        doc: 'Number of open shares'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Unique order reference number for the day'

enums:
  msg_type:
    10:
      id: 'snapshot_start_message'
      doc: 'Published as the first message in a snapshot, identifying the continuous stream sequence number and number of securities being reported.'
    11:
      id: 'book_status_message'
      doc: 'Published to report the trading and market status of each security and the number of open orders on the order book at the time of the snapshot.'
    12:
      id: 'book_entry_message'
      doc: 'Published after each Book Status message to provide details of each order for building the book.'
    18:
      id: 'ma_c_book_entry_message'
      doc: 'Published during MaC phase to provide the volume of the 5 best bid and offer orders per security in chronological order.'
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
      id: 'ao_d_start'
      doc: 'Ao D Start'
    24:
      id: 'ao_d_end'
      doc: 'Ao D End'
  side:
    1:
      id: 'buy_order'
      doc: 'Buy Order'
    2:
      id: 'sell_order'
      doc: 'Sell Order'

