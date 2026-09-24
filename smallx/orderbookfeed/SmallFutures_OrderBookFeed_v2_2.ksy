# ---------------------------------------------------------------------
# Kaitai struct definition for: SmallX OrderBookFeed Sbe v2.2
#
# Protocol:
#   Organization: The Small Exchange
#   Protocol: Order Book Feed
#   Encoding: Simple Binary Encoding
#   Version: 2.2
#   Date: 10/12/2021
#   Specification: Small Exchange Market Data Feed 2.2.pdf
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
  id: smallx_smallfutures_orderbookfeed_sbe_v2_2
  title: SmallX OrderBookFeed Sbe v2.2
  license: GPL-3.0
  endian: le

doc: 'The Small Exchange Small Exchange Order Book Feed Sbe v2.2'
doc-ref: https://smallexchange.com/reference/info-hub

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Order Book Feed PacketHeader Header'
  - id: sbe_frame
    type: sbe_frame_struct
    repeat: eos
    doc: 'Sbe Frame'

types:
  packet_header_struct:
    seq:
      - id: channel_id
        type: u1
        doc: 'Identifier of Market Data Channel distributing data for a group of instruments'
      - id: incarnation
        type: s2
        doc: 'Incarnation of the Market Data Channel'
      - id: source
        type: u1
        doc: 'Packet source line type'
      - id: packet_flags
        type: packet_flags
        doc: 'Packet flags'
      - id: message_sequence
        type: s4
        doc: 'Sequence of the first message in this packet'
      - id: message_count
        type: u1
        doc: 'Number of messages in the packet'
  packet_flags:
    meta:
      bit-endian: le
    seq:
      - id: incarnation_end
        type: b1
        doc: 'Set when the packet is incarnation end'
      - id: retransmission
        type: b1
        doc: 'Set when the packet is resent by the retransmission service'
      - id: administrative
        type: b1
        doc: 'Set when the packet contains an administrative message such as an indication of the retransmission error'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  sbe_frame_struct:
    seq:
      - id: frame_length
        type: u2
        doc: 'Total message size in bytes including this header length'
      - id: message_header
        type: message_header
        doc: 'SmallX Sbe message header'
      - id: payload
        size: frame_length - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::instrument_trading_status_incremental_message': instrument_trading_status_incremental_message
            'template_id::trades_incremental_message': trades_incremental_message
            'template_id::trade_correct_message': trade_correct_message
            'template_id::trade_bust_message': trade_bust_message
            'template_id::order_book_incremental_message': order_book_incremental_message
            'template_id::market_summary_incremental_message': market_summary_incremental_message
            'template_id::order_book_snapshot_message': order_book_snapshot_message
            'template_id::market_summary_snapshot_message': market_summary_snapshot_message
            'template_id::index_value_snapshot_message': index_value_snapshot_message
            'template_id::single_instrument_definition_incremental_v_2_message': single_instrument_definition_incremental_v_2_message
            'template_id::multileg_definition_incremental_v_2_message': multileg_definition_incremental_v_2_message
            'template_id::single_instrument_definition_snapshot_v_2_message': single_instrument_definition_snapshot_v_2_message
            'template_id::multileg_definition_snapshot_v_2_message': multileg_definition_snapshot_v_2_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema publishing the message'
      - id: version
        type: u2
        doc: 'Schema version'
  instrument_trading_status_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
  incremental_message_instructions:
    meta:
      bit-endian: le
    seq:
      - id: transaction_begin
        type: b1
        doc: 'TransactionBegin'
      - id: transaction_end
        type: b1
        doc: 'TransactionEnd'
      - id: instrument_begin
        type: b1
        doc: 'InstrumentBegin'
      - id: instrument_end
        type: b1
        doc: 'InstrumentEnd'
      - id: book_begin
        type: b1
        doc: 'BookBegin'
      - id: book_end
        type: b1
        doc: 'BookEnd'
      - id: book_reset
        type: b1
        doc: 'BookReset'
      - id: reserved_9
        type: b9
        doc: '9 reserved bits'
  trades_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'LastTradePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'LastTradeSize. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: s8_nullable
        doc: 'LastTradeTime. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'TotalVolume. Implied decimal with scale 1e0'
      - id: incremental_trade_groups
        type: incremental_trade_groups
        doc: 'NoTrades Block'
  incremental_trade_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: incremental_trade_group
        type: incremental_trade_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  group_dimension:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  incremental_trade_group:
    seq:
      - id: trade_id
        type: s8
        doc: 'TradeId'
      - id: price
        type: decimal_s8_7
        doc: 'Traded price. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Traded quantity. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8
        doc: 'Buy order id'
      - id: sell_order_id
        type: s8
        doc: 'Sell order id'
      - id: trade_conditions
        type: trade_conditions
        doc: 'TradeConditions bit set'
  trade_conditions:
    meta:
      bit-endian: le
    seq:
      - id: synthetic
        type: b1
        doc: 'Synthetic'
      - id: auction
        type: b1
        doc: 'Auction'
      - id: reserved_14
        type: b14
        doc: '14 reserved bits'
  trade_correct_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'LastTradePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'LastTradeSize. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: s8_nullable
        doc: 'LastTradeTime. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'TotalVolume. Implied decimal with scale 1e0'
      - id: trade_correct_groups
        type: trade_correct_groups
        doc: 'NoTrades Block'
  trade_correct_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: trade_correct_group
        type: trade_correct_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  trade_correct_group:
    seq:
      - id: trade_update_action
        type: u1
        enum: trade_update_action
        doc: 'Trade update action'
      - id: trade_id
        type: s8
        doc: 'TradeId'
      - id: time
        type: s8
        doc: 'Trade timestamp'
      - id: price
        type: decimal_s8_7
        doc: 'Traded price. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Traded quantity. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8
        doc: 'Buy order id'
      - id: sell_order_id
        type: s8
        doc: 'Sell order id'
      - id: trade_conditions
        type: trade_conditions
        doc: 'TradeConditions bit set'
  trade_bust_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'LastTradePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'LastTradeSize. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: s8_nullable
        doc: 'LastTradeTime. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'TotalVolume. Implied decimal with scale 1e0'
      - id: trade_bust_groups
        type: trade_bust_groups
        doc: 'NoTrades Block'
  trade_bust_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: trade_bust_group
        type: trade_bust_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  trade_bust_group:
    seq:
      - id: trade_id
        type: s8
        doc: 'TradeId'
      - id: time
        type: s8
        doc: 'Trade timestamp'
      - id: price
        type: decimal_s8_7
        doc: 'Traded price. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Traded quantity. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8
        doc: 'Buy order id'
      - id: sell_order_id
        type: s8
        doc: 'Sell order id'
      - id: trade_conditions
        type: trade_conditions
        doc: 'TradeConditions bit set'
  order_book_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: incremetal_orders_groups
        type: incremetal_orders_groups
        doc: 'NoOrders Block'
  incremetal_orders_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: incremetal_orders_group
        type: incremetal_orders_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoOrders'
  incremetal_orders_group:
    seq:
      - id: order_update_action
        type: u1
        enum: order_update_action
        doc: 'Order update action'
      - id: order_id
        type: s8
        doc: 'OrderId'
      - id: trade_id_optional
        type: s8_nullable
        doc: 'TradeId. Nullable, No Value = -9223372036854775808'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: price_optional
        type: decimal_s8_7_nullable
        doc: 'Order price. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: size
        type: decimal_s8_0
        doc: 'Traded quantity. Implied decimal with scale 1e0'
      - id: order_priority_optional
        type: s8_nullable
        doc: 'Time priority. Nullable, No Value = -9223372036854775808'
      - id: order_attributes
        type: order_attributes
        doc: 'OrderAttributes bit set'
  order_attributes:
    meta:
      bit-endian: le
    seq:
      - id: implied
        type: b1
        doc: 'Implied'
      - id: reserved_15
        type: b15
        doc: '15 reserved bits'
  market_summary_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'OpenPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_price_type
        type: u1
        enum: open_price_type
        doc: 'OpenPriceType'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'HighPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'LowPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'ClosePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_interest
        type: decimal_s8_0_nullable
        doc: 'OpenInterest. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_7_nullable
        doc: 'SettlementPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: settlement_price_type
        type: u1
        enum: settlement_price_type
        doc: 'SettlementPriceType'
  order_book_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'SnapshotMessageInstructions bit set'
      - id: snapshot_instruments_count
        type: s4
        doc: 'SnapshotInstrumentsCount'
      - id: last_incremental_message_seq
        type: s8
        doc: 'LastIncrementalMessageSeq'
      - id: snaphot_orders_groups
        type: snaphot_orders_groups
        doc: 'NoOrders Block'
  snapshot_message_instructions:
    meta:
      bit-endian: le
    seq:
      - id: unused_snapshot_message_instructions_0
        type: b1
        doc: 'Unused SnapshotMessageInstructions 0'
      - id: unused_snapshot_message_instructions_1
        type: b1
        doc: 'Unused SnapshotMessageInstructions 1'
      - id: instrument_begin
        type: b1
        doc: 'InstrumentBegin'
      - id: instrument_end
        type: b1
        doc: 'InstrumentEnd'
      - id: book_begin
        type: b1
        doc: 'BookBegin'
      - id: book_end
        type: b1
        doc: 'BookEnd'
      - id: unused_snapshot_message_instructions_6
        type: b1
        doc: 'Unused SnapshotMessageInstructions 6'
      - id: snapshot_begin
        type: b1
        doc: 'SnapshotBegin'
      - id: snapshot_end
        type: b1
        doc: 'SnapshotEnd'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  snaphot_orders_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: snaphot_orders_group
        type: snaphot_orders_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoOrders'
  snaphot_orders_group:
    seq:
      - id: order_id
        type: s8
        doc: 'OrderId'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: price
        type: decimal_s8_7
        doc: 'Traded price. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Traded quantity. Implied decimal with scale 1e0'
      - id: order_priority
        type: s8
        doc: 'Time priority'
      - id: order_attributes
        type: order_attributes
        doc: 'OrderAttributes bit set'
      - id: time
        type: s8
        doc: 'Trade timestamp'
  market_summary_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'SnapshotMessageInstructions bit set'
      - id: snapshot_instruments_count
        type: s4
        doc: 'SnapshotInstrumentsCount'
      - id: last_incremental_message_seq
        type: s8
        doc: 'LastIncrementalMessageSeq'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'LastTradePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'LastTradeSize. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp
        type: s8
        doc: 'LastTradeTime'
      - id: total_volume_quantity_optional
        type: decimal_s8_0_nullable
        doc: 'TotalVolume. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'OpenPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_price_type
        type: u1
        enum: open_price_type
        doc: 'OpenPriceType'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'HighPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'LowPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'ClosePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_interest
        type: decimal_s8_0_nullable
        doc: 'OpenInterest. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_7_nullable
        doc: 'SettlementPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: settlement_price_type
        type: u1
        enum: settlement_price_type
        doc: 'SettlementPriceType'
  index_value_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'SnapshotMessageInstructions bit set'
      - id: index_count
        type: s4
        doc: 'IndexCount'
      - id: index_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Symbol'
      - id: value_field
        type: decimal_s8_7_nullable
        doc: 'Value. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: session_date
        type: u2
        doc: 'SessionDate'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'OpenPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'HighPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'LowPrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'ClosePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
  single_instrument_definition_incremental_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: instrument_update_action
        type: u1
        enum: instrument_update_action
        doc: 'InstrumentUpdateAction'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Symbol'
      - id: product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Product'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'InstrumentType'
      - id: maturity_date
        type: u2
        doc: 'MaturityDate'
      - id: first_trading_session_date
        type: u2
        doc: 'FirstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'LastTradingSessionDate'
      - id: expiration_date
        type: u2
        doc: 'ExpirationDate'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CfiCode'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency'
      - id: price_increment
        type: decimal_s8_7
        doc: 'PriceIncrement. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'PriceMultiplier. Implied decimal with scale 1e-7'
      - id: underlying_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'UnderlyingSymbol'
      - id: underlying_instrument_id
        type: s4
        doc: 'UnderlyingInstrumentId'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'PutOrCall'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'StrikePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: shares_per_contract
        type: decimal_s8_0_nullable
        doc: 'SharesPerContract. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: expiration_style
        type: u1
        enum: expiration_style
        doc: 'ExpirationStyle'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'ExerciseStyle'
      - id: delivery
        type: u1
        enum: delivery
        doc: 'Delivery'
  multileg_definition_incremental_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'IncrementalMessageInstructions bit set'
      - id: instrument_update_action
        type: u1
        enum: instrument_update_action
        doc: 'InstrumentUpdateAction'
      - id: spread_symbol
        type: str
        size: 120
        encoding: ASCII
        doc: 'Symbol'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'InstrumentType'
      - id: maturity_date
        type: u2
        doc: 'MaturityDate'
      - id: first_trading_session_date
        type: u2
        doc: 'FirstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'LastTradingSessionDate'
      - id: expiration_date
        type: u2
        doc: 'ExpirationDate'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CfiCode'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency'
      - id: price_increment
        type: decimal_s8_7
        doc: 'PriceIncrement. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'PriceMultiplier. Implied decimal with scale 1e-7'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'StrategyType'
      - id: legs_groups
        type: legs_groups
        doc: 'NoLegs Block'
  legs_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: legs_group
        type: legs_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoLegs'
  legs_group:
    seq:
      - id: leg_instrument_id
        type: s4
        doc: 'Leg Instrument id'
      - id: leg_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Leg symbol'
      - id: leg_product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Leg product'
      - id: leg_ratio_quantity
        type: decimal_s8_0
        doc: 'Leg ratio. Implied decimal with scale 1e0'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side'
  single_instrument_definition_snapshot_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'SnapshotMessageInstructions bit set'
      - id: snapshot_instruments_count
        type: s4
        doc: 'SnapshotInstrumentsCount'
      - id: last_incremental_message_seq
        type: s8
        doc: 'LastIncrementalMessageSeq'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Symbol'
      - id: product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Product'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'InstrumentType'
      - id: maturity_date
        type: u2
        doc: 'MaturityDate'
      - id: first_trading_session_date
        type: u2
        doc: 'FirstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'LastTradingSessionDate'
      - id: expiration_date
        type: u2
        doc: 'ExpirationDate'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CfiCode'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency'
      - id: price_increment
        type: decimal_s8_7
        doc: 'PriceIncrement. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'PriceMultiplier. Implied decimal with scale 1e-7'
      - id: underlying_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'UnderlyingSymbol'
      - id: underlying_instrument_id
        type: s4
        doc: 'UnderlyingInstrumentId'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'PutOrCall'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'StrikePrice. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: shares_per_contract
        type: decimal_s8_0_nullable
        doc: 'SharesPerContract. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: expiration_style
        type: u1
        enum: expiration_style
        doc: 'ExpirationStyle'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'ExerciseStyle'
      - id: delivery
        type: u1
        enum: delivery
        doc: 'Delivery'
  multileg_definition_snapshot_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'InstrumentId'
      - id: instrument_message_no
        type: s8
        doc: 'InstrumentMessageNo'
      - id: transact_time
        type: s8
        doc: 'TransactTime'
      - id: trading_session_date
        type: u2
        doc: 'TradingSessionDate'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'InstrumentTradingStatus'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'SnapshotMessageInstructions bit set'
      - id: snapshot_instruments_count
        type: s4
        doc: 'SnapshotInstrumentsCount'
      - id: last_incremental_message_seq
        type: s8
        doc: 'LastIncrementalMessageSeq'
      - id: spread_symbol
        type: str
        size: 120
        encoding: ASCII
        doc: 'Symbol'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'InstrumentType'
      - id: maturity_date
        type: u2
        doc: 'MaturityDate'
      - id: first_trading_session_date
        type: u2
        doc: 'FirstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'LastTradingSessionDate'
      - id: expiration_date
        type: u2
        doc: 'ExpirationDate'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CfiCode'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency'
      - id: price_increment
        type: decimal_s8_7
        doc: 'PriceIncrement. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'PriceMultiplier. Implied decimal with scale 1e-7'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'StrategyType'
      - id: legs_groups
        type: legs_groups
        doc: 'NoLegs Block'
  decimal_s8_7:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000.0
  decimal_s8_7_nullable:
    seq:
      - id: value
        type: decimal_s8_7
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  decimal_s8_0:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1.0
  decimal_s8_0_nullable:
    seq:
      - id: value
        type: decimal_s8_0
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808

enums:
  template_id:
    3:
      id: 'instrument_trading_status_incremental_message'
      doc: 'InstrumentTradingStatusIncrementalMessage'
    4:
      id: 'trades_incremental_message'
      doc: 'TradesIncrementalMessage'
    5:
      id: 'trade_correct_message'
      doc: 'TradeCorrectMessage'
    6:
      id: 'trade_bust_message'
      doc: 'TradeBustMessage'
    7:
      id: 'order_book_incremental_message'
      doc: 'OrderBookIncrementalMessage'
    8:
      id: 'market_summary_incremental_message'
      doc: 'MarketSummaryIncrementalMessage'
    11:
      id: 'order_book_snapshot_message'
      doc: 'OrderBookSnapshotMessage'
    12:
      id: 'market_summary_snapshot_message'
      doc: 'MarketSummarySnapshotMessage'
    13:
      id: 'index_value_snapshot_message'
      doc: 'IndexValueSnapshotMessage'
    14:
      id: 'single_instrument_definition_incremental_v_2_message'
      doc: 'SingleInstrumentDefinitionIncrementalV2Message'
    15:
      id: 'multileg_definition_incremental_v_2_message'
      doc: 'MultilegDefinitionIncrementalV2Message'
    16:
      id: 'single_instrument_definition_snapshot_v_2_message'
      doc: 'SingleInstrumentDefinitionSnapshotV2Message'
    17:
      id: 'multileg_definition_snapshot_v_2_message'
      doc: 'MultilegDefinitionSnapshotV2Message'
  instrument_trading_status:
    0x43:
      id: 'closed'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'pre_open'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'pre_open_nc'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'open'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'paused'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'halted'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  aggressor_side:
    0x4e:
      id: 'no_aggressor'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'buy'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trade_update_action:
    0x4e:
      id: 'new_field'
      doc: 'TradeUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'delete_field'
      doc: 'TradeUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_update_action:
    0x4e:
      id: 'new_field'
      doc: 'OrderUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'update'
      doc: 'OrderUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'delete_field'
      doc: 'OrderUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    0x42:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  open_price_type:
    0x49:
      id: 'indicative'
      doc: 'OpenPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'traded'
      doc: 'OpenPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'no_price'
      doc: 'OpenPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  settlement_price_type:
    0x46:
      id: 'final_field'
      doc: 'SettlementPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'preliminary'
      doc: 'SettlementPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'no_price'
      doc: 'SettlementPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_update_action:
    0x41:
      id: 'add'
      doc: 'InstrumentUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'delete_field'
      doc: 'InstrumentUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'modify'
      doc: 'InstrumentUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_type:
    0x46:
      id: 'futures'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'option'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'mleg'
      doc: 'InstrumentType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  put_or_call:
    0x50:
      id: 'put'
      doc: 'PutOrCall Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'call'
      doc: 'PutOrCall Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'not_option'
      doc: 'PutOrCall Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  expiration_style:
    0x53:
      id: 'standard'
      doc: 'ExpirationStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'daily'
      doc: 'ExpirationStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'weekly'
      doc: 'ExpirationStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'quaterly'
      doc: 'ExpirationStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exercise_style:
    0x45:
      id: 'european'
      doc: 'ExerciseStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'american'
      doc: 'ExerciseStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'not_option'
      doc: 'ExerciseStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  delivery:
    0x43:
      id: 'cash'
      doc: 'Delivery Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'physical'
      doc: 'Delivery Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  strategy_type:
    0:
      id: 'custom'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'futures_calendar'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'futures_inter_commodity'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'covered'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'option_butterfly'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'option_vertical'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'option_strangle'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'option_straddle'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'option_diagonal'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'option_calendar'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'option_iron_condor'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'protective_put'
      doc: 'StrategyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

