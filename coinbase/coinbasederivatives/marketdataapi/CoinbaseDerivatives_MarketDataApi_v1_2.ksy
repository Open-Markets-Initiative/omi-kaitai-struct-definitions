# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Coinbase CoinbaseDerivatives MarketDataApi v1.2
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: coinbasederivatives_marketdataapi_v1_2
  title: Coinbase CoinbaseDerivatives MarketDataApi Sbe v1.2
  license: GPL-3.0
  endian: le

doc: 'Coinbase Coinbase Derivatives Market Data Api Sbe v1.2'

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
        type: s8
        doc: 'Nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: seq_num
        type: s8
        doc: 'Sequence number of first message in packet'
      - id: channel_id
        type: u2
        doc: 'Channel identifier for product/instrument set'
      - id: packet_flags
        type: u1
        doc: 'Packet Flags'
      - id: message_count
        type: u1
        doc: 'messageCount'
      - id: snapshot_instrument_id
        type: s4
        doc: 'Instrument id of messages in snapshot packet (not used for incrementals)'
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
        type: s8
        doc: 'priceIncrement'
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
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: prior_settlement_price
        type: s8
        doc: 'priorSettlementPrice'
      - id: settlement_price
        type: s8
        doc: 'settlementPrice'
      - id: limit_down_price
        type: s8
        doc: 'limitDownPrice'
      - id: limit_up_price
        type: s8
        doc: 'limitUpPrice'
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
        type: u2
        doc: 'tradingSessionDate'
      - id: reserved
        type: s2
        doc: 'reserved'
      - id: transact_time
        type: s8
        doc: 'transactTime. Nanoseconds since Unix epoch'
  definition_flags:
    seq:
      - id: is_prior_settlement_theoretical
        type: b1
        doc: 'isPriorSettlementTheoretical'
      - id: reserved_15
        type: b15
        doc: '15 reserved bits'
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
        type: s8
        doc: 'priceIncrement'
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
      - id: contract_size
        type: s4
        doc: 'contractSize'
      - id: prior_settlement_price
        type: s8
        doc: 'priorSettlementPrice'
      - id: settlement_price
        type: s8
        doc: 'settlementPrice'
      - id: limit_down_price
        type: s8
        doc: 'limitDownPrice'
      - id: limit_up_price
        type: s8
        doc: 'limitUpPrice'
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
  trading_status_update_message:
    seq:
      - id: instr_header
        type: instr_header
        doc: 'Instrument Header'
      - id: limit_down_price
        type: s8
        doc: 'limitDownPrice'
      - id: limit_up_price
        type: s8
        doc: 'limitUpPrice'
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
        type: s8
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
        type: s8
        doc: 'bestPrice'
      - id: next_price
        type: s8
        doc: 'nextPrice'
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
        type: s8
        doc: 'vwapPrice'
      - id: deepest_price
        type: s8
        doc: 'deepestPrice'
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
        type: s8
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
        type: s8
        doc: 'oldPrice'
      - id: new_price
        type: s8
        doc: 'newPrice'
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
        type: s8
        doc: 'oldPrice'
      - id: new_price
        type: s8
        doc: 'newPrice'
      - id: old_leg_1_price
        type: s8
        doc: 'oldLeg1Price'
      - id: new_leg_1_price
        type: s8
        doc: 'newLeg1Price'
      - id: old_leg_2_price
        type: s8
        doc: 'oldLeg2Price'
      - id: new_leg_2_price
        type: s8
        doc: 'newLeg2Price'
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
        type: s8
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
        type: s8
        doc: 'vwapPrice'
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
        type: s8
        doc: 'priceIncrement'
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
        type: s8
        doc: 'priceIncrement'
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
  order_snapshot_message:
    seq:
      - id: snapshot_seq_num
        type: u2
        doc: 'snapshotSeqNum'
      - id: quantity
        type: s4
        doc: 'quantity'
      - id: transact_time
        type: s8
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: price
        type: s8
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
        type: s8
        doc: 'indicativeOpenPrice'
      - id: day_open_price
        type: s8
        doc: 'dayOpenPrice'
      - id: close_price
        type: s8
        doc: 'closePrice'
      - id: low_price
        type: s8
        doc: 'lowPrice'
      - id: high_price
        type: s8
        doc: 'highPrice'
      - id: vwap_price_optional
        type: s8
        doc: 'vwapPrice'
      - id: settlement_price
        type: s8
        doc: 'settlementPrice'
      - id: last_trade_price
        type: s8
        doc: 'lastTradePrice'
      - id: last_trade_time
        type: s8
        doc: 'lastTradeTime'
      - id: best_bid_implied_price
        type: s8
        doc: 'bestBidImpliedPrice'
      - id: best_ask_implied_price
        type: s8
        doc: 'bestAskImpliedPrice'
      - id: next_bid_implied_price
        type: s8
        doc: 'nextBidImpliedPrice'
      - id: next_ask_implied_price
        type: s8
        doc: 'nextAskImpliedPrice'
      - id: limit_down_price
        type: s8
        doc: 'limitDownPrice'
      - id: limit_up_price
        type: s8
        doc: 'limitUpPrice'
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
      - id: prior_settlement_price
        type: s8
        doc: 'priorSettlementPrice'
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

enums:
  template_id:
    10:
      id: 'outright_instrument_definition_message'
      doc: 'OutrightInstrumentDefinitionMessage'
    11:
      id: 'spread_instrument_definition_message'
      doc: 'SpreadInstrumentDefinitionMessage'
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
    -1:
      id: 'use_near_bid'
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

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: Coinbase
#   Version: 1.2
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
