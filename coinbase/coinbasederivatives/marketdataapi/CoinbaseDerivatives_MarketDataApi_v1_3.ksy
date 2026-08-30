# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase CoinbaseDerivatives MarketDataApi Sbe v1.3
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Market Data Api
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 7/27/2020
#   Specification: FairX_UDP_MarketData_API_V1.2.pdf
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
  id: coinbase_coinbasederivatives_marketdataapi_sbe_v1_3
  title: Coinbase CoinbaseDerivatives MarketDataApi Sbe v1.3
  license: GPL-3.0
  endian: le

doc: 'Coinbase Coinbase Derivatives Market Data Api Sbe v1.3'

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Coinbase Udp Common Header'
  - id: sbe_message
    type: sbe_message_struct
    repeat: eos
    doc: 'Sbe Message'

types:
  packet_header_struct:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: seq_num
        type: s8
        doc: 'Sequence number of first message in packet'
      - id: channel_id
        type: u2
        doc: 'Channel identifier for product/instrument set'
      - id: packet_flags
        type: packet_flags
        doc: 'Uint8 bit set carrying the packet type (INCREMENTAL_UPDATE / SNAPSHOT / RETRANSMIT)'
      - id: message_count
        type: u1
        doc: 'messageCount'
      - id: snapshot_instrument_id
        type: s4
        doc: 'Instrument id of messages in snapshot packet (not used for incrementals)'
  packet_flags:
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
        type: b5
        doc: 'Bits reserved for future use'
  sbe_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Coinbase Sbe Market Data message header — frame length plus standard SBE header'
      - id: payload
        size: message_header.frame_length - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::outright_instrument_definition_message': outright_instrument_definition_message
            'template_id::spread_instrument_definition_message': spread_instrument_definition_message
            'template_id::option_instrument_definition_message': option_instrument_definition_message
            'template_id::trading_status_update_message': trading_status_update_message
            'template_id::order_put_message': order_put_message
            'template_id::order_delete_message': order_delete_message
            'template_id::implied_order_update_message': implied_order_update_message
            'template_id::trade_summary_message': trade_summary_message
            'template_id::trade_message': trade_message
            'template_id::trade_amend_message': trade_amend_message
            'template_id::spread_trade_amend_message': spread_trade_amend_message
            'template_id::trade_bust_message': trade_bust_message
            'template_id::market_stat_message': market_stat_message
            'template_id::trade_session_volume_message': trade_session_volume_message
            'template_id::open_interest_message': open_interest_message
            'template_id::start_of_outright_instrument_snapshot_message': start_of_outright_instrument_snapshot_message
            'template_id::start_of_spread_instrument_snapshot_message': start_of_spread_instrument_snapshot_message
            'template_id::start_of_option_instrument_snapshot_message': start_of_option_instrument_snapshot_message
            'template_id::order_snapshot_message': order_snapshot_message
            'template_id::end_of_snapshot_message': end_of_snapshot_message
            'template_id::retransmit_request_message': retransmit_request_message
            'template_id::retransmit_reject_message': retransmit_reject_message
      - id: padding
        size: message_header.frame_length - _io.pos
        doc: 'Udp sbe alignment padding'
  message_header:
    seq:
      - id: frame_length
        type: u2
        doc: 'Total message size in bytes including this header'
      - id: block_length
        type: u2
        doc: 'Length of message body excluding this header and any repeating groups or variable-length fields'
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
  outright_instrument_definition_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: price_increment
        type: decimal_s8_9
        doc: 'priceIncrement. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: currency
        type: str
        size: 8
        encoding: ASCII
        doc: 'currency'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: prior_settlement_price_optional
        type: decimal_s8_9_nullable
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_9_nullable
        doc: 'settlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: limit_down_price
        type: decimal_s8_9
        doc: 'limitDownPrice. Implied decimal with scale 1e-9'
      - id: limit_up_price
        type: decimal_s8_9
        doc: 'limitUpPrice. Implied decimal with scale 1e-9'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
  instr_header:
    seq:
      - id: instrument_flags
        type: u1
        doc: 'Total message size in bytes including this header'
      - id: instrument_side
        type: s1
        doc: 'Instrument Side'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: instr_seq_num
        type: u4
        doc: 'instrSeqNum'
      - id: trading_session_date
        type: epoch_date
        doc: 'tradingSessionDate'
      - id: reserved
        type: s2
        doc: 'reserved'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
  definition_flags:
    seq:
      - id: is_prior_settlement_theoretical
        type: b1
        doc: 'isPriorSettlementTheoretical'
      - id: is_announced
        type: b1
        doc: 'isAnnounced'
      - id: is_call
        type: b1
        doc: 'isCall'
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
  spread_instrument_definition_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: price_increment
        type: decimal_s8_9
        doc: 'priceIncrement. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: currency
        type: str
        size: 8
        encoding: ASCII
        doc: 'currency'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: prior_settlement_price_optional
        type: decimal_s8_9_nullable
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_9_nullable
        doc: 'settlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: limit_down_price
        type: decimal_s8_9
        doc: 'limitDownPrice. Implied decimal with scale 1e-9'
      - id: limit_up_price
        type: decimal_s8_9
        doc: 'limitUpPrice. Implied decimal with scale 1e-9'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: leg_1_instrument_id
        type: s4
        doc: 'leg1InstrumentId'
      - id: leg_2_instrument_id
        type: s4
        doc: 'leg2InstrumentId'
      - id: spread_buy_convention
        type: s1
        enum: spread_buy_convention
        doc: 'spreadBuyConvention'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
  option_instrument_definition_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: small_tick
        type: decimal_s8_9
        doc: 'smallTick. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: large_tick
        type: decimal_s8_9
        doc: 'largeTick. Implied decimal with scale 1e-9'
      - id: large_tick_threshold
        type: decimal_s8_9
        doc: 'largeTickThreshold. Implied decimal with scale 1e-9'
      - id: strike_price
        type: decimal_s8_9
        doc: 'strikePrice. Implied decimal with scale 1e-9'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: prior_settlement_price
        type: decimal_s8_9
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: decimal_s8_9_nullable
        doc: 'settlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: underlying_instrument_id
        type: s4
        doc: 'underlyingInstrumentId'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
  trading_status_update_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: limit_down_price
        type: decimal_s8_9
        doc: 'limitDownPrice. Implied decimal with scale 1e-9'
      - id: limit_up_price
        type: decimal_s8_9
        doc: 'limitUpPrice. Implied decimal with scale 1e-9'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
  order_put_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
  order_delete_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: order_id
        type: s8
        doc: 'orderId'
  implied_order_update_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: best_price
        type: decimal_s8_9_nullable
        doc: 'bestPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: next_price
        type: decimal_s8_9_nullable
        doc: 'nextPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: best_qty
        type: s4
        doc: 'bestQty'
      - id: next_qty
        type: s4
        doc: 'nextQty'
  trade_summary_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: aggressor_order_id
        type: s8
        doc: 'aggressorOrderId'
      - id: aggressor_receive_time
        type: s8
        doc: 'aggressorReceiveTime'
      - id: vwap_price
        type: decimal_s8_9
        doc: 'vwapPrice. Implied decimal with scale 1e-9'
      - id: deepest_price
        type: decimal_s8_9
        doc: 'deepestPrice. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
  trade_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: buy_order_id
        type: s8_nullable
        doc: 'buyOrderId. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'sellOrderId. Nullable, No Value = -9223372036854775808'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
  trade_amend_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: buy_order_id
        type: s8_nullable
        doc: 'buyOrderId. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'sellOrderId. Nullable, No Value = -9223372036854775808'
      - id: old_price
        type: decimal_s8_9
        doc: 'oldPrice. Implied decimal with scale 1e-9'
      - id: new_price
        type: decimal_s8_9
        doc: 'newPrice. Implied decimal with scale 1e-9'
  spread_trade_amend_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: buy_order_id
        type: s8_nullable
        doc: 'buyOrderId. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'sellOrderId. Nullable, No Value = -9223372036854775808'
      - id: old_price
        type: decimal_s8_9
        doc: 'oldPrice. Implied decimal with scale 1e-9'
      - id: new_price
        type: decimal_s8_9
        doc: 'newPrice. Implied decimal with scale 1e-9'
      - id: old_leg_1_price
        type: decimal_s8_9
        doc: 'oldLeg1Price. Implied decimal with scale 1e-9'
      - id: new_leg_1_price
        type: decimal_s8_9
        doc: 'newLeg1Price. Implied decimal with scale 1e-9'
      - id: old_leg_2_price
        type: decimal_s8_9
        doc: 'oldLeg2Price. Implied decimal with scale 1e-9'
      - id: new_leg_2_price
        type: decimal_s8_9
        doc: 'newLeg2Price. Implied decimal with scale 1e-9'
  trade_bust_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: buy_order_id
        type: s8_nullable
        doc: 'buyOrderId. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'sellOrderId. Nullable, No Value = -9223372036854775808'
  market_stat_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: stat_type
        type: u1
        enum: stat_type
        doc: 'statType'
  trade_session_volume_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: vwap_price
        type: decimal_s8_9
        doc: 'vwapPrice. Implied decimal with scale 1e-9'
      - id: trade_volume
        type: s4
        doc: 'tradeVolume'
  open_interest_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: quantity
        type: s4
        doc: 'quantity'
  start_of_outright_instrument_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: last_instr_seq_num
        type: u4
        doc: 'lastInstrSeqNum'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: price_increment
        type: decimal_s8_9
        doc: 'priceIncrement. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: currency
        type: str
        size: 8
        encoding: ASCII
        doc: 'currency'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: order_count
        type: s4
        doc: 'orderCount'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: epoch_date
        doc: 'tradingSessionDate'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
  start_of_spread_instrument_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: last_instr_seq_num
        type: u4
        doc: 'lastInstrSeqNum'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: price_increment
        type: decimal_s8_9
        doc: 'priceIncrement. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: currency
        type: str
        size: 8
        encoding: ASCII
        doc: 'currency'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: order_count
        type: s4
        doc: 'orderCount'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: epoch_date
        doc: 'tradingSessionDate'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: leg_1_instrument_id
        type: s4
        doc: 'leg1InstrumentId'
      - id: leg_2_instrument_id
        type: s4
        doc: 'leg2InstrumentId'
      - id: spread_buy_convention
        type: s1
        enum: spread_buy_convention
        doc: 'spreadBuyConvention'
  start_of_option_instrument_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: last_instr_seq_num
        type: u4
        doc: 'lastInstrSeqNum'
      - id: symbol
        type: str
        size: 24
        encoding: ASCII
        doc: 'symbol'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'productCode'
      - id: description
        type: str
        size: 32
        encoding: ASCII
        doc: 'description'
      - id: small_tick
        type: decimal_s8_9
        doc: 'smallTick. Implied decimal with scale 1e-9'
      - id: cfi_code
        type: str
        size: 8
        encoding: ASCII
        doc: 'cfiCode'
      - id: large_tick
        type: decimal_s8_9
        doc: 'largeTick. Implied decimal with scale 1e-9'
      - id: large_tick_threshold
        type: decimal_s8_9
        doc: 'largeTickThreshold. Implied decimal with scale 1e-9'
      - id: strike_price
        type: decimal_s8_9
        doc: 'strikePrice. Implied decimal with scale 1e-9'
      - id: product_id
        type: s4
        doc: 'productId'
      - id: underlying_instrument_id
        type: s4
        doc: 'underlyingInstrumentId'
      - id: order_count
        type: s4
        doc: 'orderCount'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: epoch_date
        doc: 'tradingSessionDate'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
  order_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: quantity
        type: s4
        doc: 'quantity'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
  end_of_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: trade_volume
        type: s4
        doc: 'tradeVolume'
      - id: indicative_open_price
        type: decimal_s8_9_nullable
        doc: 'indicativeOpenPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: day_open_price
        type: decimal_s8_9_nullable
        doc: 'dayOpenPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_9_nullable
        doc: 'closePrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_9_nullable
        doc: 'lowPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: high_price
        type: decimal_s8_9_nullable
        doc: 'highPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: vwap_price_optional
        type: decimal_s8_9_nullable
        doc: 'vwapPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_9_nullable
        doc: 'settlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: last_trade_price
        type: decimal_s8_9_nullable
        doc: 'lastTradePrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time
        type: nanosecond_timestamp_nullable
        doc: 'lastTradeTime. Nanoseconds since Unix epoch. Nullable, No Value = -9223372036854775808'
      - id: best_bid_implied_price
        type: decimal_s8_9_nullable
        doc: 'bestBidImpliedPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: best_ask_implied_price
        type: decimal_s8_9_nullable
        doc: 'bestAskImpliedPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: next_bid_implied_price
        type: decimal_s8_9_nullable
        doc: 'nextBidImpliedPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: next_ask_implied_price
        type: decimal_s8_9_nullable
        doc: 'nextAskImpliedPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: limit_down_price
        type: decimal_s8_9
        doc: 'limitDownPrice. Implied decimal with scale 1e-9'
      - id: limit_up_price
        type: decimal_s8_9
        doc: 'limitUpPrice. Implied decimal with scale 1e-9'
      - id: last_trade_qty
        type: s4_nullable
        doc: 'lastTradeQty. Nullable, No Value = -2147483648'
      - id: open_interest
        type: s4_nullable
        doc: 'openInterest. Nullable, No Value = -2147483648'
      - id: best_bid_implied_qty
        type: s4_nullable
        doc: 'bestBidImpliedQty. Nullable, No Value = -2147483648'
      - id: best_ask_implied_qty
        type: s4_nullable
        doc: 'bestAskImpliedQty. Nullable, No Value = -2147483648'
      - id: next_bid_implied_qty
        type: s4_nullable
        doc: 'nextBidImpliedQty. Nullable, No Value = -2147483648'
      - id: next_ask_implied_qty
        type: s4_nullable
        doc: 'nextAskImpliedQty. Nullable, No Value = -2147483648'
      - id: prior_settlement_price_optional
        type: decimal_s8_9_nullable
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
  retransmit_request_message:
    seq:
      - id: begin_seq_num
        type: s8
        doc: 'beginSeqNum'
      - id: message_count
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
  epoch_date:
    seq:
      - id: days
        type: u2
    instances:
      unix_seconds:
        value: days * 86400
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -9223372036854775808
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648

enums:
  template_id:
    10:
      id: 'outright_instrument_definition_message'
      doc: 'OutrightInstrumentDefinitionMessage'
    11:
      id: 'spread_instrument_definition_message'
      doc: 'SpreadInstrumentDefinitionMessage'
    12:
      id: 'option_instrument_definition_message'
      doc: 'OptionInstrumentDefinitionMessage'
    17:
      id: 'trading_status_update_message'
      doc: 'TradingStatusUpdateMessage'
    20:
      id: 'order_put_message'
      doc: 'OrderPutMessage'
    21:
      id: 'order_delete_message'
      doc: 'OrderDeleteMessage'
    22:
      id: 'implied_order_update_message'
      doc: 'ImpliedOrderUpdateMessage'
    33:
      id: 'trade_summary_message'
      doc: 'TradeSummaryMessage'
    30:
      id: 'trade_message'
      doc: 'TradeMessage'
    31:
      id: 'trade_amend_message'
      doc: 'TradeAmendMessage'
    34:
      id: 'spread_trade_amend_message'
      doc: 'SpreadTradeAmendMessage'
    32:
      id: 'trade_bust_message'
      doc: 'TradeBustMessage'
    40:
      id: 'market_stat_message'
      doc: 'MarketStatMessage'
    41:
      id: 'trade_session_volume_message'
      doc: 'TradeSessionVolumeMessage'
    42:
      id: 'open_interest_message'
      doc: 'OpenInterestMessage'
    110:
      id: 'start_of_outright_instrument_snapshot_message'
      doc: 'StartOfOutrightInstrumentSnapshotMessage'
    111:
      id: 'start_of_spread_instrument_snapshot_message'
      doc: 'StartOfSpreadInstrumentSnapshotMessage'
    112:
      id: 'start_of_option_instrument_snapshot_message'
      doc: 'StartOfOptionInstrumentSnapshotMessage'
    120:
      id: 'order_snapshot_message'
      doc: 'OrderSnapshotMessage'
    122:
      id: 'end_of_snapshot_message'
      doc: 'EndOfSnapshotMessage'
    200:
      id: 'retransmit_request_message'
      doc: 'RetransmitRequestMessage'
    202:
      id: 'retransmit_reject_message'
      doc: 'RetransmitRejectMessage'
  product_group:
    0:
      id: 'currency'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'equity'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'energy'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'metals'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'interest_rate'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'agriculture'
      doc: 'ProductGroup Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_status:
    0:
      id: 'pre_open'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'open'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'halt'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'pause'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'close'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'pre_open_no_cancel'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'expired'
      doc: 'InstrumentTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  spread_buy_convention:
    1:
      id: 'use_far_bid'
      doc: 'SpreadBuyConvention Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  stat_type:
    0x34:
      id: 'day_opening_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'closing_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'settlement_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'trading_session_high_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'trading_session_low_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'reference_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'indicative_opening_price'
      doc: 'MarketStatType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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

