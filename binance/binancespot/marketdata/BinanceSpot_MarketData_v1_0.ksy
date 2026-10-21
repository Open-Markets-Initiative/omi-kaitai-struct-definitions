# ---------------------------------------------------------------------
# Kaitai struct definition for: Binance BinanceSpot MarketData Sbe v1.0
#
# Protocol:
#   Organization: Binance
#   Protocol: Market Data
#   Encoding: Simple Binary Encoding
#   Version: 1.0
#   Date: 2026-09-18
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
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: binance_binancespot_marketdata_sbe_v1_0
  title: Binance BinanceSpot MarketData Sbe v1.0
  license: GPL-3.0
  endian: le

doc: 'Binance Binance Spot Market Data Sbe v1.0'
doc-ref: https://developers.binance.com/en/docs/products/spot

seq:
  - id: sbe_message
    type: sbe_message_struct
    doc: 'Binance Sbe message'

types:
  sbe_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Binance Sbe message header — block length, template id, schema id and version of the message root'
      - id: payload
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::trades_stream_event_message': trades_stream_event_message
            'template_id::best_bid_ask_stream_event_message': best_bid_ask_stream_event_message
            'template_id::depth_snapshot_stream_event_message': depth_snapshot_stream_event_message
            'template_id::depth_diff_stream_event_message': depth_diff_stream_event_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template id of the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema the message belongs to'
      - id: version
        type: u2
        doc: 'Schema version'
  trades_stream_event_message:
    seq:
      - id: event_time
        type: microsecond_timestamp
        doc: 'eventTime. Microseconds since Unix epoch'
      - id: transact_time
        type: microsecond_timestamp
        doc: 'transactTime. Microseconds since Unix epoch'
      - id: price_exponent
        type: s1
        doc: 'priceExponent'
      - id: qty_exponent
        type: s1
        doc: 'qtyExponent'
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
      - id: trades_stream_event_message_trades_groups
        type: trades_stream_event_message_trades_groups
        doc: 'trades Block'
      - id: symbol
        type: symbol
        doc: 'symbol data struct'
  trades_stream_event_message_trades_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: trades_stream_event_message_trades_group
        type: trades_stream_event_message_trades_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group_uint_32
        doc: 'trades'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group_uint_32
        type: u4
        doc: 'numInGroup'
  trades_stream_event_message_trades_group:
    seq:
      - id: id
        type: s8
        doc: 'id'
      - id: price
        type: s8
        doc: 'price'
      - id: qty
        type: s8
        doc: 'qty'
      - id: is_buyer_maker
        type: u1
        enum: is_buyer_maker
        doc: 'isBuyerMaker'
      - id: block_extension
        size: _parent.group_size_encoding.block_length - 25
        doc: 'Bytes the stated block holds beyond the 25 this version reads'
  symbol:
    seq:
      - id: len_symbol_data
        type: u1
      - id: symbol_data
        type: str
        size: len_symbol_data
        encoding: ASCII
        if: len_symbol_data > 0
  best_bid_ask_stream_event_message:
    seq:
      - id: event_time
        type: microsecond_timestamp
        doc: 'eventTime. Microseconds since Unix epoch'
      - id: book_update_id
        type: s8
        doc: 'bookUpdateId'
      - id: price_exponent
        type: s1
        doc: 'priceExponent'
      - id: qty_exponent
        type: s1
        doc: 'qtyExponent'
      - id: bid_price
        type: s8
        doc: 'bidPrice'
      - id: bid_qty
        type: s8
        doc: 'bidQty'
      - id: ask_price
        type: s8
        doc: 'askPrice'
      - id: ask_qty
        type: s8
        doc: 'askQty'
      - id: block_extension
        size: _parent.message_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
      - id: symbol
        type: symbol
        doc: 'symbol data struct'
  depth_snapshot_stream_event_message:
    seq:
      - id: event_time
        type: microsecond_timestamp
        doc: 'eventTime. Microseconds since Unix epoch'
      - id: book_update_id
        type: s8
        doc: 'bookUpdateId'
      - id: price_exponent
        type: s1
        doc: 'priceExponent'
      - id: qty_exponent
        type: s1
        doc: 'qtyExponent'
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
      - id: depth_snapshot_stream_event_message_bids_groups
        type: depth_snapshot_stream_event_message_bids_groups
        doc: 'bids Block'
      - id: depth_snapshot_stream_event_message_asks_groups
        type: depth_snapshot_stream_event_message_asks_groups
        doc: 'asks Block'
      - id: symbol
        type: symbol
        doc: 'symbol data struct'
  depth_snapshot_stream_event_message_bids_groups:
    seq:
      - id: group_size_16_encoding
        type: group_size_16_encoding
        doc: 'groupSize16Encoding'
      - id: depth_snapshot_stream_event_message_bids_group
        type: depth_snapshot_stream_event_message_bids_group
        repeat: expr
        repeat-expr: group_size_16_encoding.num_in_group_uint_16
        doc: 'bids'
  group_size_16_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group_uint_16
        type: u2
        doc: 'numInGroup'
  depth_snapshot_stream_event_message_bids_group:
    seq:
      - id: price
        type: s8
        doc: 'price'
      - id: qty
        type: s8
        doc: 'qty'
      - id: block_extension
        size: _parent.group_size_16_encoding.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  depth_snapshot_stream_event_message_asks_groups:
    seq:
      - id: group_size_16_encoding
        type: group_size_16_encoding
        doc: 'groupSize16Encoding'
      - id: depth_snapshot_stream_event_message_asks_group
        type: depth_snapshot_stream_event_message_asks_group
        repeat: expr
        repeat-expr: group_size_16_encoding.num_in_group_uint_16
        doc: 'asks'
  depth_snapshot_stream_event_message_asks_group:
    seq:
      - id: price
        type: s8
        doc: 'price'
      - id: qty
        type: s8
        doc: 'qty'
      - id: block_extension
        size: _parent.group_size_16_encoding.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  depth_diff_stream_event_message:
    seq:
      - id: event_time
        type: microsecond_timestamp
        doc: 'eventTime. Microseconds since Unix epoch'
      - id: first_book_update_id
        type: s8
        doc: 'firstBookUpdateId'
      - id: last_book_update_id
        type: s8
        doc: 'lastBookUpdateId'
      - id: price_exponent
        type: s1
        doc: 'priceExponent'
      - id: qty_exponent
        type: s1
        doc: 'qtyExponent'
      - id: block_extension
        size: _parent.message_header.block_length - 26
        doc: 'Bytes the stated block holds beyond the 26 this version reads'
      - id: depth_diff_stream_event_message_bids_groups
        type: depth_diff_stream_event_message_bids_groups
        doc: 'bids Block'
      - id: depth_diff_stream_event_message_asks_groups
        type: depth_diff_stream_event_message_asks_groups
        doc: 'asks Block'
      - id: symbol
        type: symbol
        doc: 'symbol data struct'
  depth_diff_stream_event_message_bids_groups:
    seq:
      - id: group_size_16_encoding
        type: group_size_16_encoding
        doc: 'groupSize16Encoding'
      - id: depth_diff_stream_event_message_bids_group
        type: depth_diff_stream_event_message_bids_group
        repeat: expr
        repeat-expr: group_size_16_encoding.num_in_group_uint_16
        doc: 'bids'
  depth_diff_stream_event_message_bids_group:
    seq:
      - id: price
        type: s8
        doc: 'price'
      - id: qty
        type: s8
        doc: 'qty'
      - id: block_extension
        size: _parent.group_size_16_encoding.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  depth_diff_stream_event_message_asks_groups:
    seq:
      - id: group_size_16_encoding
        type: group_size_16_encoding
        doc: 'groupSize16Encoding'
      - id: depth_diff_stream_event_message_asks_group
        type: depth_diff_stream_event_message_asks_group
        repeat: expr
        repeat-expr: group_size_16_encoding.num_in_group_uint_16
        doc: 'asks'
  depth_diff_stream_event_message_asks_group:
    seq:
      - id: price
        type: s8
        doc: 'price'
      - id: qty
        type: s8
        doc: 'qty'
      - id: block_extension
        size: _parent.group_size_16_encoding.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  microsecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000 % 24
      minute:
        value: time / 60000000 % 60
      second:
        value: time / 1000000 % 60
      millisecond:
        value: time / 1000 % 1000
      microsecond:
        value: time % 1000

enums:
  template_id:
    10000:
      id: 'trades_stream_event_message'
      doc: 'TradesStreamEventMessage'
    10001:
      id: 'best_bid_ask_stream_event_message'
      doc: 'BestBidAskStreamEventMessage'
    10002:
      id: 'depth_snapshot_stream_event_message'
      doc: 'DepthSnapshotStreamEventMessage'
    10003:
      id: 'depth_diff_stream_event_message'
      doc: 'DepthDiffStreamEventMessage'
  is_buyer_maker:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'

