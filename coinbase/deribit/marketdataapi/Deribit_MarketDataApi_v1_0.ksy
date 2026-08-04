# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase Deribit MarketDataApi Sbe v1.0
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Market Data Api
#   Encoding: Simple Binary Encoding
#   Version: 1.0
#   Date: 6/8/2026
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
# The Binary Data Compiler technologies used to produce this file
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
  id: deribit_marketdataapi_v1_0
  title: Coinbase Deribit MarketDataApi Sbe v1.0
  license: GPL-3.0
  endian: le

doc: 'Coinbase Deribit Market Data Api Sbe v1.0'
doc-ref: https://docs.cdp.coinbase.com/derivatives/introduction/downloads

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Coinbase Deribit Market Data packet header — 24 bytes, common to all multicast channels'
  - id: md_message
    type: md_message_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Coinbase Deribit Market Data per-message wrapper — Md Message Header plus payload'

types:
  packet_header_struct:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'UTC timestamp of when the packet was sent, nanoseconds since Unix epoch (January 1st, 1970, 00:00:00 GMT). Nanoseconds since Unix epoch'
      - id: seq_num
        type: s8
        doc: 'Sequence number of the first message in the packet'
      - id: channel_id
        type: s4
        doc: 'Channel identifier for the product / instrument set'
      - id: packet_type
        type: packet_type
        doc: 'Uint16 bit set carrying the packet type (INCREMENTAL_UPDATE / SNAPSHOT / RETRANSMIT)'
      - id: message_count
        type: u2
        doc: 'Count of messages contained within the packet'
  packet_type:
    seq:
      - id: incremental_update
        type: b1
        doc: 'Incremental update packet indicator (Bit 0)'
      - id: snapshot
        type: b1
        doc: 'Snapshot packet indicator (Bit 1)'
      - id: retransmit
        type: b1
        doc: 'Retransmit packet indicator (Bit 2)'
      - id: reserved_bits
        type: b13
        doc: 'Bits reserved for future use'
  md_message_struct:
    seq:
      - id: md_message_header
        type: md_message_header
        doc: 'Coinbase Deribit Market Data per-message header'
      - id: payload
        size: md_message_header.message_length - 16
        type:
          switch-on: md_message_header.template_id
          cases:
            'template_id::instrument_definition_message': instrument_definition_message
            'template_id::index_definition_message': index_definition_message
            'template_id::instrument_info_message': instrument_info_message
            'template_id::instrument_ref_message': instrument_ref_message
            'template_id::instrument_status_update_message': instrument_status_update_message
            'template_id::bid_put_message': bid_put_message
            'template_id::ask_put_message': ask_put_message
            'template_id::bid_qty_reduced_message': bid_qty_reduced_message
            'template_id::ask_qty_reduced_message': ask_qty_reduced_message
            'template_id::bid_delete_message': bid_delete_message
            'template_id::ask_delete_message': ask_delete_message
            'template_id::trade_summary_message': trade_summary_message
            'template_id::trade_message': trade_message
            'template_id::block_trade_message': block_trade_message
            'template_id::snapshot_header_message': snapshot_header_message
            'template_id::snapshot_trailer_message': snapshot_trailer_message
            'template_id::end_of_cycle_message': end_of_cycle_message
            'template_id::retransmit_request_message': retransmit_request_message
            'template_id::retransmit_reject_message': retransmit_reject_message
  md_message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message including this header'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_version
        type: u2
        doc: 'Schema version'
      - id: message_flags
        type: message_flags
        doc: 'Uint16 bit set carrying transaction boundary indicators'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'UTC timestamp of when the transaction occurred, nanoseconds since Unix epoch (January 1st, 1970, 00:00:00 GMT). Nanoseconds since Unix epoch'
  message_flags:
    seq:
      - id: start_of_transaction
        type: b1
        doc: 'Start of transaction indicator'
      - id: end_of_transaction
        type: b1
        doc: 'End of transaction indicator'
      - id: reserved_bits
        type: b14
        doc: 'Bits reserved for future use'
  instrument_definition_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: name
        type: str
        size: 128
        encoding: ASCII
        doc: 'name'
      - id: index_id
        type: s8
        doc: 'indexId'
      - id: underlying
        type: str
        size: 64
        encoding: ASCII
        doc: 'underlying'
      - id: quantity_asset
        type: str
        size: 8
        encoding: ASCII
        doc: 'quantityAsset'
      - id: price_asset
        type: str
        size: 8
        encoding: ASCII
        doc: 'priceAsset'
      - id: expiry_time
        type: s8
        doc: 'expiryTime'
      - id: strike_price
        type: s8
        doc: 'strikePrice. Implied decimal with scale 1e-9'
      - id: min_order_quantity
        type: s8
        doc: 'minOrderQuantity'
      - id: tick_size
        type: s8
        doc: 'tickSize. Implied decimal with scale 1e-9'
      - id: quantity_exponent
        type: s1
        doc: 'quantityExponent'
      - id: type
        type: s1
        enum: type
        doc: 'type'
      - id: flags
        type: flags
        doc: 'InstrumentFlags bit set'
      - id: status
        type: s1
        enum: status
        doc: 'status'
      - id: instrument_definition_message_large_tick_sizes_groups
        type: instrument_definition_message_large_tick_sizes_groups
        doc: 'largeTickSizes Block'
      - id: instrument_definition_message_legs_groups
        type: instrument_definition_message_legs_groups
        doc: 'legs Block'
  flags:
    seq:
      - id: is_reversed
        type: b1
        doc: 'isReversed'
      - id: is_put_option
        type: b1
        doc: 'isPutOption'
      - id: is_perpetual
        type: b1
        doc: 'isPerpetual'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  instrument_definition_message_large_tick_sizes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: instrument_definition_message_large_tick_sizes_group
        type: instrument_definition_message_large_tick_sizes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'largeTickSizes'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u2
        doc: 'numInGroup'
  instrument_definition_message_large_tick_sizes_group:
    seq:
      - id: large_tick_size
        type: s8
        doc: 'largeTickSize. Implied decimal with scale 1e-9'
      - id: threshold_price
        type: s8
        doc: 'thresholdPrice. Implied decimal with scale 1e-9'
  instrument_definition_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: instrument_definition_message_legs_group
        type: instrument_definition_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  instrument_definition_message_legs_group:
    seq:
      - id: leg_instrument_id
        type: s8
        doc: 'legInstrumentId'
      - id: ratio
        type: s1
        doc: 'ratio'
  index_definition_message:
    seq:
      - id: index_id
        type: s8
        doc: 'indexId'
      - id: name
        type: str
        size: 128
        encoding: ASCII
        doc: 'name'
  instrument_info_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: min_sell_price
        type: s8
        doc: 'minSellPrice. Implied decimal with scale 1e-9'
      - id: max_buy_price
        type: s8
        doc: 'maxBuyPrice. Implied decimal with scale 1e-9'
      - id: index_price
        type: s8
        doc: 'indexPrice. Implied decimal with scale 1e-9'
      - id: mark_price
        type: s8
        doc: 'markPrice. Implied decimal with scale 1e-9'
  instrument_ref_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: current_funding
        size: 8
        doc: 'currentFunding'
      - id: funding_8h
        size: 8
        doc: 'funding8h'
      - id: estimated_delivery_price
        type: s8
        doc: 'estimatedDeliveryPrice. Implied decimal with scale 1e-9'
      - id: delivery_price
        type: s8
        doc: 'deliveryPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: s8
        doc: 'settlementPrice. Implied decimal with scale 1e-9'
  instrument_status_update_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
  bid_put_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: quantity_mantissa
        type: s8
        doc: 'quantityMantissa'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-9'
      - id: sort_order_id
        type: s8
        doc: 'sortOrderId'
  ask_put_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: quantity_mantissa
        type: s8
        doc: 'quantityMantissa'
      - id: price
        type: s8
        doc: 'price. Implied decimal with scale 1e-9'
      - id: sort_order_id
        type: s8
        doc: 'sortOrderId'
  bid_qty_reduced_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: quantity_mantissa
        type: s8
        doc: 'quantityMantissa'
  ask_qty_reduced_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: quantity_mantissa
        type: s8
        doc: 'quantityMantissa'
  bid_delete_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
  ask_delete_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
  trade_summary_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: taker_order_id
        type: s8
        doc: 'takerOrderId'
      - id: total_filled_mantissa
        type: s8
        doc: 'totalFilledMantissa'
      - id: deepest_price
        type: s8
        doc: 'deepestPrice. Implied decimal with scale 1e-9'
      - id: mark_price
        type: s8
        doc: 'markPrice. Implied decimal with scale 1e-9'
      - id: index_price
        type: s8
        doc: 'indexPrice. Implied decimal with scale 1e-9'
      - id: trade_count
        type: s4
        doc: 'tradeCount'
      - id: taker_flags
        type: taker_flags
        doc: 'TradeFlags bit set'
  taker_flags:
    seq:
      - id: is_sell
        type: b1
        doc: 'isSell'
      - id: is_liquidation
        type: b1
        doc: 'isLiquidation'
      - id: reserved_30
        type: b30
        doc: '30 reserved bits'
  trade_message:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: maker_order_id
        type: s8
        doc: 'makerOrderId'
      - id: fill_qty_mantissa
        type: s8
        doc: 'fillQtyMantissa'
      - id: fill_price
        type: s8
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: maker_flags
        type: maker_flags
        doc: 'TradeFlags bit set'
  maker_flags:
    seq:
      - id: is_sell
        type: b1
        doc: 'isSell'
      - id: is_liquidation
        type: b1
        doc: 'isLiquidation'
      - id: reserved_30
        type: b30
        doc: '30 reserved bits'
  block_trade_message:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: block_trade_id
        type: s8
        doc: 'blockTradeId'
      - id: block_rfq_id
        type: s8
        doc: 'blockRfqId'
      - id: fill_qty_mantissa
        type: s8
        doc: 'fillQtyMantissa'
      - id: fill_price
        type: s8
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: mark_price
        type: s8
        doc: 'markPrice. Implied decimal with scale 1e-9'
      - id: index_price
        type: s8
        doc: 'indexPrice. Implied decimal with scale 1e-9'
      - id: implied_volatility
        size: 8
        doc: 'impliedVolatility'
      - id: taker_flags
        type: taker_flags
        doc: 'TradeFlags bit set'
      - id: number_of_legs
        type: u2
        doc: 'numberOfLegs'
  snapshot_header_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: incremental_timestamp
        type: s8
        doc: 'incrementalTimestamp'
      - id: incremental_seq_num
        type: s8
        doc: 'incrementalSeqNum'
  snapshot_trailer_message:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: timestamp
        type: s8
        doc: 'timestamp'
      - id: increment_seq_num
        type: s8
        doc: 'incrementSeqNum'
  end_of_cycle_message:
    seq:
      - id: active_instrument_count
        type: s4
        doc: 'activeInstrumentCount'
  retransmit_request_message:
    seq:
      - id: begin_seq_num
        type: s8
        doc: 'beginSeqNum'
      - id: message_count_uint_8
        type: u1
        doc: 'messageCount'
  retransmit_reject_message:
    seq:
      - id: retry_delay_nanos
        type: s8
        doc: 'retryDelayNanos'
      - id: details
        type: str
        size: 40
        encoding: ASCII
        doc: 'details'
      - id: reason
        type: s1
        enum: reason
        doc: 'reason'
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

enums:
  template_id:
    10:
      id: 'instrument_definition_message'
      doc: 'InstrumentDefinitionMessage'
    11:
      id: 'index_definition_message'
      doc: 'IndexDefinitionMessage'
    14:
      id: 'instrument_info_message'
      doc: 'InstrumentInfoMessage'
    15:
      id: 'instrument_ref_message'
      doc: 'InstrumentRefMessage'
    16:
      id: 'instrument_status_update_message'
      doc: 'InstrumentStatusUpdateMessage'
    20:
      id: 'bid_put_message'
      doc: 'BidPutMessage'
    21:
      id: 'ask_put_message'
      doc: 'AskPutMessage'
    22:
      id: 'bid_qty_reduced_message'
      doc: 'BidQtyReducedMessage'
    23:
      id: 'ask_qty_reduced_message'
      doc: 'AskQtyReducedMessage'
    24:
      id: 'bid_delete_message'
      doc: 'BidDeleteMessage'
    25:
      id: 'ask_delete_message'
      doc: 'AskDeleteMessage'
    30:
      id: 'trade_summary_message'
      doc: 'TradeSummaryMessage'
    31:
      id: 'trade_message'
      doc: 'TradeMessage'
    33:
      id: 'block_trade_message'
      doc: 'BlockTradeMessage'
    100:
      id: 'snapshot_header_message'
      doc: 'SnapshotHeaderMessage'
    101:
      id: 'snapshot_trailer_message'
      doc: 'SnapshotTrailerMessage'
    119:
      id: 'end_of_cycle_message'
      doc: 'EndOfCycleMessage'
    200:
      id: 'retransmit_request_message'
      doc: 'RetransmitRequestMessage'
    202:
      id: 'retransmit_reject_message'
      doc: 'RetransmitRejectMessage'
  type:
    0:
      id: 'perp_future'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'option'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'spot'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'future_combo'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'option_combo'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'dated_future'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  status:
    0:
      id: 'open'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'inactive'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'settlement'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'delivered'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'locked'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'halted'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_status:
    0:
      id: 'open'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'inactive'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'settlement'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'delivered'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'locked'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'halted'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reason:
    1:
      id: 'seq_too_low'
      doc: 'RetransmitRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'seq_too_high'
      doc: 'RetransmitRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'rate_limit_exceeded'
      doc: 'RetransmitRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'other_error'
      doc: 'RetransmitRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

