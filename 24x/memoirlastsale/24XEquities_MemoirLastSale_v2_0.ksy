# ---------------------------------------------------------------------
# Kaitai struct definition for: 24X MemoirLastSale Sbe v2.0
#
# Protocol:
#   Organization: 24 National Exchange
#   Protocol: Member Order Information Record Last Sale
#   Encoding: Simple Binary Encoding
#   Version: 2.0
#   Date: 9/25/2026
#   Specification: MEMOIR Last Sale Feed-v2.0a.pdf
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
  id: n24x_24xequities_memoirlastsale_sbe_v2_0
  title: 24X MemoirLastSale Sbe v2.0
  license: GPL-3.0
  endian: be

doc: '24 National Exchange 24X Equities Member Order Information Record Last Sale Sbe v2.0'
doc-ref: https://equities.24exchange.com/technical-resources

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Memx Udp Common Header'
  - id: sequenced_messages
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Memx Udp Message Type'
      - id: header_length
        type: u1
        doc: 'Total bytes in this header'
      - id: session_id
        type: u8
        doc: 'session identifier'
      - id: sequence_number
        type: u8
        doc: 'Sequence Number'
  sequenced_message:
    seq:
      - id: num_message
        type: u2
        doc: 'Number of messages in this packet'
      - id: message
        type: message
        repeat: expr
        repeat-expr: num_message
        doc: 'Memx Udp Message'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Number of bytes in the following message'
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: payload
        size: sbe_header.block_length
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::instrument_directory_message': instrument_directory_message
            'template_id::reg_sho_restriction_message': reg_sho_restriction_message
            'template_id::security_trading_status_message': security_trading_status_message
            'template_id::trading_session_status_message': trading_session_status_message
            'template_id::trade_report_message': trade_report_message
            'template_id::trade_cancel_message': trade_cancel_message
            'template_id::trade_correct_message': trade_correct_message
            'template_id::auction_trade_message': auction_trade_message
            'template_id::broken_auction_trade_message': broken_auction_trade_message
            'template_id::corrected_auction_trade_message': corrected_auction_trade_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Memx Udp Message Type'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
  instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_sfx
        type: str
        size: 6
        encoding: ASCII
        doc: 'SymbolSfx'
      - id: round_lot
        type: u4
        doc: 'RoundLot'
      - id: is_test_symbol
        type: u1
        enum: is_test_symbol
        doc: 'IsTestSymbol'
      - id: block_extension
        size: _parent.sbe_header.block_length - 27
        doc: 'Bytes the stated block holds beyond the 27 this version reads'
  reg_sho_restriction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'ShortSaleRestriction'
      - id: block_extension
        size: _parent.sbe_header.block_length - 11
        doc: 'Bytes the stated block holds beyond the 11 this version reads'
  security_trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'SecurityTradingStatus'
      - id: security_trading_status_reason
        type: u1
        enum: security_trading_status_reason
        doc: 'SecurityTradingStatusReason'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'HaltReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 13
        doc: 'Bytes the stated block holds beyond the 13 this version reads'
  trading_session_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'TradingSession'
      - id: block_extension
        size: _parent.sbe_header.block_length - 9
        doc: 'Bytes the stated block holds beyond the 9 this version reads'
  trade_report_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: trade_qty
        type: u4
        doc: 'TradeQty'
      - id: trade_price
        type: decimal_s8_6
        doc: 'TradePrice. Implied decimal with scale 1e-6'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'SaleCondition1'
      - id: sale_condition_2
        type: u1
        enum: sale_condition_2
        doc: 'SaleCondition2'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'SaleCondition3'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'SaleCondition4'
      - id: block_extension
        size: _parent.sbe_header.block_length - 34
        doc: 'Bytes the stated block holds beyond the 34 this version reads'
  trade_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: trade_qty
        type: u4
        doc: 'TradeQty'
      - id: last_price
        type: decimal_s8_6
        doc: 'LastPrice. Implied decimal with scale 1e-6'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'SaleCondition1'
      - id: sale_condition_2
        type: u1
        enum: sale_condition_2
        doc: 'SaleCondition2'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'SaleCondition3'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'SaleCondition4'
      - id: block_extension
        size: _parent.sbe_header.block_length - 34
        doc: 'Bytes the stated block holds beyond the 34 this version reads'
  trade_correct_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_trade_qty
        type: u4
        doc: 'OriginalTradeQty'
      - id: original_trade_price
        type: decimal_s8_6
        doc: 'OriginalTradePrice. Implied decimal with scale 1e-6'
      - id: original_sale_condition_1
        type: u1
        enum: original_sale_condition_1
        doc: 'OriginalSaleCondition1'
      - id: original_sale_condition_2
        type: u1
        enum: original_sale_condition_2
        doc: 'OriginalSaleCondition2'
      - id: original_sale_condition_3
        type: u1
        enum: original_sale_condition_3
        doc: 'OriginalSaleCondition3'
      - id: original_sale_condition_4
        type: u1
        enum: original_sale_condition_4
        doc: 'OriginalSaleCondition4'
      - id: corrected_trade_qty
        type: u4
        doc: 'CorrectedTradeQty'
      - id: corrected_trade_price
        type: decimal_s8_6
        doc: 'CorrectedTradePrice. Implied decimal with scale 1e-6'
      - id: corrected_sale_condition_1
        type: u1
        enum: corrected_sale_condition_1
        doc: 'CorrectedSaleCondition1'
      - id: corrected_sale_condition_2
        type: u1
        enum: corrected_sale_condition_2
        doc: 'CorrectedSaleCondition2'
      - id: corrected_sale_condition_3
        type: u1
        enum: corrected_sale_condition_3
        doc: 'CorrectedSaleCondition3'
      - id: corrected_sale_condition_4
        type: u1
        enum: corrected_sale_condition_4
        doc: 'CorrectedSaleCondition4'
      - id: block_extension
        size: _parent.sbe_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
  auction_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: auction_id
        type: u8
        doc: 'AuctionID'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType'
      - id: auction_quantity
        type: u8
        doc: 'AuctionQuantity'
      - id: auction_price
        type: decimal_s8_6
        doc: 'AuctionPrice. Implied decimal with scale 1e-6'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: sale_condition_1
        type: u1
        enum: sale_condition_1
        doc: 'SaleCondition1'
      - id: sale_condition_2
        type: u1
        enum: sale_condition_2
        doc: 'SaleCondition2'
      - id: sale_condition_3
        type: u1
        enum: sale_condition_3
        doc: 'SaleCondition3'
      - id: sale_condition_4
        type: u1
        enum: sale_condition_4
        doc: 'SaleCondition4'
      - id: block_extension
        size: _parent.sbe_header.block_length - 47
        doc: 'Bytes the stated block holds beyond the 47 this version reads'
  broken_auction_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: auction_id
        type: u8
        doc: 'AuctionID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_auction_quantity
        type: u8
        doc: 'OriginalAuctionQuantity'
      - id: original_auction_price
        type: decimal_s8_6
        doc: 'OriginalAuctionPrice. Implied decimal with scale 1e-6'
      - id: block_extension
        size: _parent.sbe_header.block_length - 42
        doc: 'Bytes the stated block holds beyond the 42 this version reads'
  corrected_auction_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: auction_id
        type: u8
        doc: 'AuctionID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: original_auction_quantity
        type: u8
        doc: 'OriginalAuctionQuantity'
      - id: original_auction_price
        type: decimal_s8_6
        doc: 'OriginalAuctionPrice. Implied decimal with scale 1e-6'
      - id: original_sale_condition_1
        type: u1
        enum: original_sale_condition_1
        doc: 'OriginalSaleCondition1'
      - id: original_sale_condition_2
        type: u1
        enum: original_sale_condition_2
        doc: 'OriginalSaleCondition2'
      - id: original_sale_condition_3
        type: u1
        enum: original_sale_condition_3
        doc: 'OriginalSaleCondition3'
      - id: original_sale_condition_4
        type: u1
        enum: original_sale_condition_4
        doc: 'OriginalSaleCondition4'
      - id: corrected_auction_quantity
        type: u8
        doc: 'CorrectedAuctionQuantity'
      - id: corrected_auction_price
        type: decimal_s8_6
        doc: 'CorrectedAuctionPrice. Implied decimal with scale 1e-6'
      - id: corrected_sale_condition_1
        type: u1
        enum: corrected_sale_condition_1
        doc: 'CorrectedSaleCondition1'
      - id: corrected_sale_condition_2
        type: u1
        enum: corrected_sale_condition_2
        doc: 'CorrectedSaleCondition2'
      - id: corrected_sale_condition_3
        type: u1
        enum: corrected_sale_condition_3
        doc: 'CorrectedSaleCondition3'
      - id: corrected_sale_condition_4
        type: u1
        enum: corrected_sale_condition_4
        doc: 'CorrectedSaleCondition4'
      - id: block_extension
        size: _parent.sbe_header.block_length - 66
        doc: 'Bytes the stated block holds beyond the 66 this version reads'
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
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  message_type:
    0:
      id: 'heartbeat_message'
      doc: 'Memx Udp Heartbeat Message'
    1:
      id: 'session_shutdown_message'
      doc: 'Memx Udp Session Shutdown Message'
    2:
      id: 'sequenced_message'
      doc: 'Memx Udp Sequenced Message'
  template_id:
    1:
      id: 'instrument_directory_message'
      doc: 'InstrumentDirectoryMessage'
    2:
      id: 'reg_sho_restriction_message'
      doc: 'RegSHORestrictionMessage'
    3:
      id: 'security_trading_status_message'
      doc: 'SecurityTradingStatusMessage'
    5:
      id: 'trading_session_status_message'
      doc: 'TradingSessionStatusMessage'
    10:
      id: 'trade_report_message'
      doc: 'TradeReportMessage'
    11:
      id: 'trade_cancel_message'
      doc: 'TradeCancelMessage'
    12:
      id: 'trade_correct_message'
      doc: 'TradeCorrectMessage'
    13:
      id: 'auction_trade_message'
      doc: 'AuctionTradeMessage'
    14:
      id: 'broken_auction_trade_message'
      doc: 'BrokenAuctionTradeMessage'
    15:
      id: 'corrected_auction_trade_message'
      doc: 'CorrectedAuctionTradeMessage'
  is_test_symbol:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  short_sale_restriction:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  security_trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x50:
      id: 'paused'
      doc: 'Paused'
    0x51:
      id: 'quoting'
      doc: 'Quoting'
    0x54:
      id: 'trading'
      doc: 'Trading'
  security_trading_status_reason:
    0x58:
      id: 'none'
      doc: 'None'
    0x52:
      id: 'regulatory'
      doc: 'Regulatory'
    0x41:
      id: 'administrative'
      doc: 'Administrative'
  halt_reason:
    0:
      id: 'unknown'
      doc: 'Unknown'
    1:
      id: 'admin'
      doc: 'Admin'
    2:
      id: 'additional_info_requested'
      doc: 'AdditionalInfoRequested'
    3:
      id: 'regulatory_concern'
      doc: 'RegulatoryConcern'
    4:
      id: 'news_released'
      doc: 'NewsReleased'
    5:
      id: 'merger_effective'
      doc: 'MergerEffective'
    6:
      id: 'etf_component_prices_not_available'
      doc: 'ETFComponentPricesNotAvailable'
    7:
      id: 'order_imbalance'
      doc: 'OrderImbalance'
    8:
      id: 'luld_trading_pause'
      doc: 'LULDTradingPause'
    9:
      id: 'corporate_action'
      doc: 'CorporateAction'
    10:
      id: 'new_security_offering'
      doc: 'NewSecurityOffering'
    11:
      id: 'news_pending'
      doc: 'NewsPending'
    12:
      id: 'intraday_indicative_value_not_available'
      doc: 'IntradayIndicativeValueNotAvailable'
    13:
      id: 'operational'
      doc: 'Operational'
    14:
      id: 'sub_penny_trading'
      doc: 'SubPennyTrading'
    15:
      id: 'market_wide_circuit_breaker_level_1'
      doc: 'MarketWideCircuitBreakerLevel1'
    16:
      id: 'market_wide_circuit_breaker_level_2'
      doc: 'MarketWideCircuitBreakerLevel2'
    17:
      id: 'market_wide_circuit_breaker_level_3'
      doc: 'MarketWideCircuitBreakerLevel3'
  trading_session:
    0x30:
      id: 'overnight'
      doc: 'Overnight'
    0x31:
      id: 'opening'
      doc: 'Opening'
    0x32:
      id: 'trading'
      doc: 'Trading'
    0x33:
      id: 'post_trading'
      doc: 'PostTrading'
    0x34:
      id: 'closed'
      doc: 'Closed'
  sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x46:
      id: 'intermarket_sweep'
      doc: 'IntermarketSweep'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'MarketCenterOpeningTrade'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'MarketCenterReopeningTrade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'MarketCenterClosingTrade'
  sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'FormT'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  sale_condition_4:
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  original_sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  original_sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x46:
      id: 'intermarket_sweep'
      doc: 'IntermarketSweep'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'MarketCenterOpeningTrade'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'MarketCenterReopeningTrade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'MarketCenterClosingTrade'
  original_sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'FormT'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  original_sale_condition_4:
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  corrected_sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  corrected_sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x46:
      id: 'intermarket_sweep'
      doc: 'IntermarketSweep'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'MarketCenterOpeningTrade'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'MarketCenterReopeningTrade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'MarketCenterClosingTrade'
  corrected_sale_condition_3:
    0x54:
      id: 'form_t'
      doc: 'FormT'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  corrected_sale_condition_4:
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
  auction_type:
    0x20:
      id: 'unknown'
      doc: 'Unknown'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x49:
      id: 'ipo'
      doc: 'IPO'
    0x50:
      id: 'pause'
      doc: 'Pause'

