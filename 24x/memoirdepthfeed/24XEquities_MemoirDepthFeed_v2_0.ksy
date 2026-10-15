# ---------------------------------------------------------------------
# Kaitai struct definition for: 24X MemoirDepthFeed Sbe v2.0
#
# Protocol:
#   Organization: 24 National Exchange
#   Protocol: Member Order Information Record Depth Feed
#   Encoding: Simple Binary Encoding
#   Version: 2.0
#   Date: 9/25/2026
#   Specification: MEMOIR Depth Feed-v2.0a.pdf
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
  id: n24x_24xequities_memoirdepthfeed_sbe_v2_0
  title: 24X MemoirDepthFeed Sbe v2.0
  license: GPL-3.0
  endian: be

doc: '24 National Exchange 24X Equities Member Order Information Record Depth Feed Sbe v2.0'
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
            'template_id::order_added_message': order_added_message
            'template_id::order_deleted_message': order_deleted_message
            'template_id::order_reduced_message': order_reduced_message
            'template_id::order_executed_message': order_executed_message
            'template_id::trade_message': trade_message
            'template_id::broken_trade_message': broken_trade_message
            'template_id::corrected_trade_message': corrected_trade_message
            'template_id::clear_book_message': clear_book_message
            'template_id::auction_status_message': auction_status_message
            'template_id::auction_trade_message': auction_trade_message
            'template_id::broken_auction_trade_message': broken_auction_trade_message
            'template_id::corrected_auction_trade_message': corrected_auction_trade_message
            'template_id::snapshot_complete_message': snapshot_complete_message
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
  trading_session_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: trading_session
        type: u1
        enum: trading_session
        doc: 'TradingSession'
  order_added_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
      - id: order_flags
        type: order_flags
        doc: 'OrderFlagsType bit set'
  order_flags:
    meta:
      bit-endian: le
    seq:
      - id: retail_present
        type: b1
        doc: 'RetailPresent'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  order_deleted_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderID'
  order_reduced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: quantity
        type: u4
        doc: 'Quantity'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: trade_id
        type: u8
        doc: 'TradeID'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
  trade_message:
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
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: price
        type: decimal_s8_6
        doc: 'Price. Implied decimal with scale 1e-6'
  broken_trade_message:
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
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_s8_6
        doc: 'OriginalPrice. Implied decimal with scale 1e-6'
  corrected_trade_message:
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
      - id: original_quantity
        type: u4
        doc: 'OriginalQuantity'
      - id: original_price
        type: decimal_s8_6
        doc: 'OriginalPrice. Implied decimal with scale 1e-6'
      - id: corrected_quantity
        type: u4
        doc: 'CorrectedQuantity'
      - id: corrected_price
        type: decimal_s8_6
        doc: 'CorrectedPrice. Implied decimal with scale 1e-6'
  clear_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: security_id
        type: u2
        doc: 'SecurityID'
  auction_status_message:
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
      - id: tie_breaker_price
        type: decimal_s8_6
        doc: 'TieBreakerPrice. Implied decimal with scale 1e-6'
      - id: lower_collar_price
        type: decimal_s8_6
        doc: 'LowerCollarPrice. Implied decimal with scale 1e-6'
      - id: upper_collar_price
        type: decimal_s8_6
        doc: 'UpperCollarPrice. Implied decimal with scale 1e-6'
      - id: reference_price
        type: decimal_s8_6
        doc: 'ReferencePrice. Implied decimal with scale 1e-6'
      - id: reference_buy_quantity
        type: u8
        doc: 'ReferenceBuyQuantity'
      - id: reference_sell_quantity
        type: u8
        doc: 'ReferenceSellQuantity'
      - id: indicative_price
        type: decimal_s8_6
        doc: 'IndicativePrice. Implied decimal with scale 1e-6'
      - id: auction_only_price
        type: decimal_s8_6
        doc: 'AuctionOnlyPrice. Implied decimal with scale 1e-6'
      - id: number_of_extensions
        type: u4
        doc: 'NumberOfExtensions'
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
  snapshot_complete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Timestamp. Nanoseconds since Unix epoch'
      - id: as_of_sequence_number
        type: u8
        doc: 'AsOfSequenceNumber'
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
      id: 'order_added_message'
      doc: 'OrderAddedMessage'
    11:
      id: 'order_deleted_message'
      doc: 'OrderDeletedMessage'
    12:
      id: 'order_reduced_message'
      doc: 'OrderReducedMessage'
    13:
      id: 'order_executed_message'
      doc: 'OrderExecutedMessage'
    14:
      id: 'trade_message'
      doc: 'TradeMessage'
    15:
      id: 'broken_trade_message'
      doc: 'BrokenTradeMessage'
    16:
      id: 'corrected_trade_message'
      doc: 'CorrectedTradeMessage'
    18:
      id: 'clear_book_message'
      doc: 'ClearBookMessage'
    19:
      id: 'auction_status_message'
      doc: 'AuctionStatusMessage'
    20:
      id: 'auction_trade_message'
      doc: 'AuctionTradeMessage'
    21:
      id: 'broken_auction_trade_message'
      doc: 'BrokenAuctionTradeMessage'
    22:
      id: 'corrected_auction_trade_message'
      doc: 'CorrectedAuctionTradeMessage'
    100:
      id: 'snapshot_complete_message'
      doc: 'SnapshotCompleteMessage'
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
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
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
  sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
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
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x54:
      id: 'form_t'
      doc: 'FormT'
  sale_condition_4:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'
  original_sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  original_sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
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
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x54:
      id: 'form_t'
      doc: 'FormT'
  original_sale_condition_4:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'
  corrected_sale_condition_1:
    0x40:
      id: 'regular_trade'
      doc: 'RegularTrade'
  corrected_sale_condition_2:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
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
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x54:
      id: 'form_t'
      doc: 'FormT'
  corrected_sale_condition_4:
    0x20:
      id: 'not_applicable'
      doc: 'NotApplicable'
    0x48:
      id: 'price_variation_trade'
      doc: 'PriceVariationTrade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'OddLotTrade'
    0x58:
      id: 'auction_trade'
      doc: 'AuctionTrade'

