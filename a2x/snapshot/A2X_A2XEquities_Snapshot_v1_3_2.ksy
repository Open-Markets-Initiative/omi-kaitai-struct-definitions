# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X A2XEquities Snapshot Amd v1.3.2
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: Snapshot Feed
#   Encoding: A2X Market Data
#   Version: 1.3.2
#   Date: 9/15/2022
#   Specification: A2X712-Market-Data-Techincal-Specification-v1.3.2.pdf
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
  id: a2x_a2xequities_snapshot_amd_v1_3_2
  title: A2X A2XEquities Snapshot Amd v1.3.2
  license: GPL-3.0
  endian: be

doc: 'A2X Markets A2X Equities Snapshot Feed Amd v1.3.2'
doc-ref: https://www.a2x.co.za/?page_id=531

seq:
  - id: num_message
    type: u1
    doc: 'number of messages in this packet'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: num_message

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'A2X message header'
      - id: payload
        size: message_header.msg_length - 6
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::snapshot_start_message': snapshot_start_message
            'msg_type::book_status_message': book_status_message
            'msg_type::book_entry_message': book_entry_message
            'msg_type::market_at_close_book_entry_message': market_at_close_book_entry_message
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
        doc: 'The sequence number of the last message'
      - id: security_count
        type: u2le
        doc: 'Number of securities reported in this'
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
        doc: 'Trading Status'
      - id: market_flags
        type: market_flags
        doc: 'Market Flagss'
      - id: entries
        type: u2le
        doc: 'Number of open orders in the book for this'
      - id: closing_buy_qty
        type: u4le
        doc: 'Total order quantity on the buy side during'
      - id: closing_sell_qty
        type: u4le
        doc: 'Total order quantity on the sell side during'
      - id: indicative_price
        type: u8le
        doc: 'Indicative auction price'
  market_flags:
    seq:
      - id: unused
        type: b5
        doc: 'Reserved for future use'
      - id: mac_run
        type: b1
        doc: 'Locked'
      - id: mac_open
        type: b1
        doc: 'Open'
      - id: trading
        type: b1
        doc: 'Continuous Trading'
  book_entry_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4le
        doc: 'Number of open shares'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'
  market_at_close_book_entry_message:
    seq:
      - id: security_id
        type: u2le
        doc: 'Numeric identifier of the relevant security'
      - id: quantity
        type: u4le
        doc: 'Number of open shares'
      - id: price
        type: u8le
        doc: 'The price of the order'
      - id: order_ref
        type: u4le
        doc: 'Order reference number'

enums:
  msg_type:
    1:
      id: 'heartbeat_message'
      doc: 'The Heartbeat message carries no data'
    10:
      id: 'snapshot_start_message'
      doc: 'A Snapshot Start message is published as the first message in a snapshot to identify the continous stream'
    11:
      id: 'book_status_message'
      doc: 'A Book Status message is published to report the trading and market status of each security and the number of open orders on the order book for the security at the time of the snapshot'
    12:
      id: 'book_entry_message'
      doc: 'An appropriate number of Book Entry messages is published after each Book Status message to provide details of each order and allow the book to be built'
    18:
      id: 'market_at_close_book_entry_message'
      doc: 'A2X will publish the volume of the 5 best bid and offer orders per security in chronological order'

