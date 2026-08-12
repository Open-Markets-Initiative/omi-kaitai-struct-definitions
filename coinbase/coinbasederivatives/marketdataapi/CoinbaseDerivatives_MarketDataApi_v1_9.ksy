# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase CoinbaseDerivatives MarketDataApi Sbe v1.9
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Market Data Api
#   Encoding: Simple Binary Encoding
#   Version: 1.9
#   Date: 9/5/2025
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
  id: coinbase_coinbasederivatives_marketdataapi_sbe_v1_9
  title: Coinbase CoinbaseDerivatives MarketDataApi Sbe v1.9
  license: GPL-3.0
  endian: le

doc: 'Coinbase Coinbase Derivatives Market Data Api Sbe v1.9'
doc-ref: https://docs.cdp.coinbase.com/derivatives/introduction/downloads

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
            'template_id::funding_rate_message': funding_rate_message
            'template_id::start_of_outright_instrument_snapshot_message': start_of_outright_instrument_snapshot_message
            'template_id::start_of_spread_instrument_snapshot_message': start_of_spread_instrument_snapshot_message
            'template_id::start_of_option_instrument_snapshot_message': start_of_option_instrument_snapshot_message
            'template_id::order_snapshot_message': order_snapshot_message
            'template_id::end_of_snapshot_message': end_of_snapshot_message
            'template_id::end_of_cycle_message': end_of_cycle_message
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
      - id: tick_size
        type: decimal_s8_9
        doc: 'tickSize. Implied decimal with scale 1e-9'
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
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: old_contract_size
        type: s4
        doc: 'oldContractSize'
      - id: prior_settlement_price_optional
        type: decimal_s8_9
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'settlementPrice. Implied decimal with scale 1e-9'
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
      - id: contract_size
        type: s8
        doc: 'contractSize'
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
      - id: funding_interval_minutes
        type: s4
        doc: 'fundingIntervalMinutes'
      - id: fair_value_limit
        type: s4
        doc: 'fairValueLimit'
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
        type: u2
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
      - id: is_strike_delisted
        type: b1
        doc: 'isStrikeDelisted'
      - id: funding_rate_applicable
        type: b1
        doc: 'fundingRateApplicable'
      - id: reserved_11
        type: b11
        doc: '11 reserved bits'
  logical_expiry:
    seq:
      - id: year
        type: s2
        doc: 'year'
      - id: month
        type: s2
        doc: 'month'
      - id: week_of_month
        type: s2
        doc: 'weekOfMonth'
      - id: day_of_month
        type: s2
        doc: 'dayOfMonth'
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
      - id: tick_size
        type: decimal_s8_9
        doc: 'tickSize. Implied decimal with scale 1e-9'
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
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: old_contract_size
        type: s4
        doc: 'oldContractSize'
      - id: prior_settlement_price_optional
        type: decimal_s8_9
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'settlementPrice. Implied decimal with scale 1e-9'
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
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
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
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: prior_settlement_price
        type: decimal_s8_9
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'settlementPrice. Implied decimal with scale 1e-9'
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
      - id: option_expiry_type
        type: s1
        enum: option_expiry_type
        doc: 'optionExpiryType'
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
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
        type: decimal_s8_9
        doc: 'bestPrice. Implied decimal with scale 1e-9'
      - id: next_price
        type: decimal_s8_9
        doc: 'nextPrice. Implied decimal with scale 1e-9'
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
        type: s8
        doc: 'buyOrderId'
      - id: sell_order_id
        type: s8
        doc: 'sellOrderId'
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
        type: s8
        doc: 'buyOrderId'
      - id: sell_order_id
        type: s8
        doc: 'sellOrderId'
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
        type: s8
        doc: 'buyOrderId'
      - id: sell_order_id
        type: s8
        doc: 'sellOrderId'
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
        type: s8
        doc: 'buyOrderId'
      - id: sell_order_id
        type: s8
        doc: 'sellOrderId'
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
  funding_rate_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: funding_rate
        type: decimal_s8_9
        doc: 'fundingRate. Implied decimal with scale 1e-9'
      - id: futures_mark_price_price
        type: decimal_s8_9
        doc: 'futuresMarkPrice. Implied decimal with scale 1e-9'
      - id: spot_mark_price_price
        type: decimal_s8_9
        doc: 'spotMarkPrice. Implied decimal with scale 1e-9'
      - id: fair_value_price
        type: decimal_s8_9
        doc: 'fairValue. Implied decimal with scale 1e-9'
      - id: final_funding_rate_timestamp
        type: s8
        doc: 'finalFundingRateTimestamp'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: flags
        type: flags
        doc: 'FundingRateFlags bit set'
  flags:
    seq:
      - id: is_final
        type: b1
        doc: 'isFinal'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
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
      - id: tick_size
        type: decimal_s8_9
        doc: 'tickSize. Implied decimal with scale 1e-9'
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
      - id: old_contract_size
        type: s4
        doc: 'oldContractSize'
      - id: order_count
        type: s4
        doc: 'orderCount'
      - id: first_trading_session_date
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: u2
        doc: 'tradingSessionDate'
      - id: product_group
        type: s1
        enum: product_group
        doc: 'productGroup'
      - id: trading_status
        type: s1
        enum: trading_status
        doc: 'tradingStatus'
      - id: contract_size
        type: s8
        doc: 'contractSize'
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
      - id: funding_interval_minutes
        type: s4
        doc: 'fundingIntervalMinutes'
      - id: fair_value_limit
        type: s4
        doc: 'fairValueLimit'
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
      - id: tick_size
        type: decimal_s8_9
        doc: 'tickSize. Implied decimal with scale 1e-9'
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
      - id: old_contract_size
        type: s4
        doc: 'oldContractSize'
      - id: order_count
        type: s4
        doc: 'orderCount'
      - id: first_trading_session_date
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: u2
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
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
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
        type: u2
        doc: 'firstTradingSessionDate'
      - id: last_trading_session_date
        type: u2
        doc: 'lastTradingSessionDate'
      - id: trading_session_date
        type: u2
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
      - id: option_expiry_type
        type: s1
        enum: option_expiry_type
        doc: 'optionExpiryType'
      - id: logical_expiry
        type: logical_expiry
        doc: 'OutrightInstrumentDefinitionMessage'
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
        type: decimal_s8_9
        doc: 'indicativeOpenPrice. Implied decimal with scale 1e-9'
      - id: day_open_price
        type: decimal_s8_9
        doc: 'dayOpenPrice. Implied decimal with scale 1e-9'
      - id: close_price
        type: decimal_s8_9
        doc: 'closePrice. Implied decimal with scale 1e-9'
      - id: low_price
        type: decimal_s8_9
        doc: 'lowPrice. Implied decimal with scale 1e-9'
      - id: high_price
        type: decimal_s8_9
        doc: 'highPrice. Implied decimal with scale 1e-9'
      - id: vwap_price_optional
        type: decimal_s8_9
        doc: 'vwapPrice. Implied decimal with scale 1e-9'
      - id: settlement_price
        type: decimal_s8_9
        doc: 'settlementPrice. Implied decimal with scale 1e-9'
      - id: last_trade_price
        type: decimal_s8_9
        doc: 'lastTradePrice. Implied decimal with scale 1e-9'
      - id: last_trade_time
        type: nanosecond_timestamp
        doc: 'lastTradeTime. Nanoseconds since Unix epoch'
      - id: best_bid_implied_price
        type: decimal_s8_9
        doc: 'bestBidImpliedPrice. Implied decimal with scale 1e-9'
      - id: best_ask_implied_price
        type: decimal_s8_9
        doc: 'bestAskImpliedPrice. Implied decimal with scale 1e-9'
      - id: next_bid_implied_price
        type: decimal_s8_9
        doc: 'nextBidImpliedPrice. Implied decimal with scale 1e-9'
      - id: next_ask_implied_price
        type: decimal_s8_9
        doc: 'nextAskImpliedPrice. Implied decimal with scale 1e-9'
      - id: limit_down_price
        type: decimal_s8_9
        doc: 'limitDownPrice. Implied decimal with scale 1e-9'
      - id: limit_up_price
        type: decimal_s8_9
        doc: 'limitUpPrice. Implied decimal with scale 1e-9'
      - id: last_trade_qty
        type: s4
        doc: 'lastTradeQty'
      - id: open_interest
        type: s4
        doc: 'openInterest'
      - id: best_bid_implied_qty
        type: s4
        doc: 'bestBidImpliedQty'
      - id: best_ask_implied_qty
        type: s4
        doc: 'bestAskImpliedQty'
      - id: next_bid_implied_qty
        type: s4
        doc: 'nextBidImpliedQty'
      - id: next_ask_implied_qty
        type: s4
        doc: 'nextAskImpliedQty'
      - id: prior_settlement_price_optional
        type: decimal_s8_9
        doc: 'priorSettlementPrice. Implied decimal with scale 1e-9'
      - id: definition_flags
        type: definition_flags
        doc: 'InstrumentDefinitionFlags bit set'
      - id: final_funding_rate
        type: decimal_s8_9
        doc: 'finalFundingRate. Implied decimal with scale 1e-9'
      - id: final_futures_mark_price
        type: decimal_s8_9
        doc: 'finalFuturesMarkPrice. Implied decimal with scale 1e-9'
      - id: final_funding_rate_timestamp
        type: s8
        doc: 'finalFundingRateTimestamp'
      - id: futures_mark_price_price_optional
        type: decimal_s8_9
        doc: 'futuresMarkPrice. Implied decimal with scale 1e-9'
      - id: predicted_funding_rate
        type: decimal_s8_9
        doc: 'predictedFundingRate. Implied decimal with scale 1e-9'
      - id: spot_mark_price_price_optional
        type: decimal_s8_9
        doc: 'spotMarkPrice. Implied decimal with scale 1e-9'
      - id: fair_value_price_optional
        type: decimal_s8_9
        doc: 'fairValue. Implied decimal with scale 1e-9'
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
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0

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
    43:
      id: 'funding_rate_message'
      doc: 'FundingRateMessage'
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
    124:
      id: 'end_of_cycle_message'
      doc: 'EndOfCycleMessage'
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
    6:
      id: 'crypto'
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
  option_expiry_type:
    0:
      id: 'weekly'
      doc: 'OptionExpiryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'monthly'
      doc: 'OptionExpiryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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

