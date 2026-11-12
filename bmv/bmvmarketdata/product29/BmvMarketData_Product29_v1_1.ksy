# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product29 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 29
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P29_1_ENG.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: bmv_bmvmarketdata_product29_intra_v1_1
  title: Bmv BmvMarketData Product29 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 29 Intra v1.1'
doc-ref: https://www.bmv.com.mx/es/productos-de-informacion/market-data

seq:
  - id: intra_multicast_header
    type: intra_multicast_header_struct
    doc: 'BMV INTRA Multicast Header'
  - id: message_block
    type: message_block_struct
    repeat: expr
    repeat-expr: intra_multicast_header.total_messages
    doc: 'BMV INTRA Multicast message block'

types:
  intra_multicast_header_struct:
    seq:
      - id: length
        type: s2
        doc: 'Packet length, including header and all attached messages'
      - id: total_messages
        type: s1
        doc: 'Number of messages after the header'
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: session
        type: s1
        doc: 'Current session identifier'
      - id: sequence_number
        type: s4
        doc: 'Sequence number of the first message attached to header'
      - id: datetime
        type: millisecond_timestamp
        doc: 'Date and time the packet is created. Milliseconds since Unix epoch'
  message_block_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Message length and message type'
      - id: payload
        size: message_header.message_length + 2 - 3
        type:
          switch-on: message_header.message_type
          cases:
            109: last_quote_message
            58: benchmark_trade_message
            64: price_leaderboard_message
            60: trading_sniper_message
            94: depth_at_best_prices_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u1
        doc: 'Code identifying the message'
  last_quote_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: volume
        type: s8
        doc: 'Volume of the order'
      - id: price_rate
        type: decimal_s8_8
        doc: 'Price of the best bid. Implied decimal with scale 1e-8'
      - id: direction_of_the_bid
        type: u1
        enum: direction_of_the_bid
        doc: 'C- Purchase V-Sale'
      - id: type_of_trading
        type: u1
        enum: type_of_trading
        doc: 'See Catalogue of Type of Trading on the Connections and Appendix document'
  benchmark_trade_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: average_volume
        type: s8
        doc: 'Average volume per trade'
      - id: average_traded_value
        type: decimal_s8_8
        doc: 'Average traded value per trade. Implied decimal with scale 1e-8'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  price_leaderboard_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: t_best_bid
        type: decimal_s4_4
        doc: 'Time proportion of the session, having the best bid. Implied decimal with scale 1e-4'
      - id: t_tie_best_bid
        type: decimal_s4_4
        doc: 'Time proportion of the session with a tie on the best bid. Implied decimal with scale 1e-4'
      - id: t_without_best_bid
        type: decimal_s4_4
        doc: 'Time proportion of the session without having the best bid. Implied decimal with scale 1e-4'
      - id: t_best_ask
        type: decimal_s4_4
        doc: 'Time proportion of the session, having the best ask. Implied decimal with scale 1e-4'
      - id: t_tie_best_ask
        type: decimal_s4_4
        doc: 'Time proportion of the session with a tie on the best ask. Implied decimal with scale 1e-4'
      - id: t_without_best_ask
        type: decimal_s4_4
        doc: 'Time proportion of the session without having the best ask. Implied decimal with scale 1e-4'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  trading_sniper_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: depth_bid
        type: s8
        doc: 'Total volume of bid’s full depth'
      - id: depth_ask
        type: s8
        doc: 'Total volume of ask’s full depth'
      - id: depth_bid_10_l
        type: s8
        doc: 'Total volume of bid’s first 10 levels'
      - id: depth_ask_10_l
        type: s8
        doc: 'Total volume of ask’s first 10 levels'
      - id: vwp_bid_10_l
        type: decimal_s8_8
        doc: 'Bid’s first 10 levels volume weighted price. Implied decimal with scale 1e-8'
      - id: vwp_ask_10_l
        type: decimal_s8_8
        doc: 'Ask’s first 10 levels volume weighted price. Implied decimal with scale 1e-8'
      - id: vwp_bid
        type: decimal_s8_8
        doc: 'Full bid’s depth volume weighted price. Implied decimal with scale 1e-8'
      - id: vwp_ask
        type: decimal_s8_8
        doc: 'Full ask’s depth volume weighted price. Implied decimal with scale 1e-8'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  depth_at_best_prices_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: instruments_bb
        type: s2
        doc: 'Number of instruments at which the Exchange has quotes at the national best bid up to the message reception'
      - id: instruments_gv_bb
        type: s2
        doc: 'Number of instruments at which the Exchange has greater volume at the national best bid up to the message reception'
      - id: ratio_v_at_bb
        type: s4
        doc: 'Volume ratio between the total volume of the Exchange at the best bid and the national total volume at the best bid'
      - id: instruments_ba
        type: s2
        doc: 'Number of instruments at which the Exchange has quotes at the national best ask up to the message reception'
      - id: instruments_gv_ba
        type: s2
        doc: 'Number of instruments at which the Exchange has greater volume at the national best ask up to the message reception'
      - id: ratio_v_at_ba
        type: s4
        doc: 'Volume ratio between the total volume of the Exchange at the best ask and the national total volume at the best ask'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  millisecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  market_data_group:
    1:
      id: 'indepth_local_market'
      doc: 'in-depth local market'
    2:
      id: 'indepth_global_market'
      doc: 'in-depth global market'
    3:
      id: 'twenty_price_levels_of_local_market'
      doc: '20 price levels of local market'
    4:
      id: 'twenty_price_levels_of_global_market'
      doc: '20 price levels of global market'
    5:
      id: 'best_offers_of_local_market'
      doc: 'Best offers of local market'
    6:
      id: 'best_offers_of_global_market'
      doc: 'Best offers of global market'
    7:
      id: 'ten_price_levels_of_derivative_futures'
      doc: '10 price levels of derivative futures'
    8:
      id: 'ten_price_levels_of_derivative_options'
      doc: '10 price levels of derivative options'
    9:
      id: 'best_offers_for_derivative_futures'
      doc: 'Best offers for derivative futures'
    10:
      id: 'best_offers_for_derivative_options'
      doc: 'Best offers for derivative options'
    11:
      id: 'money_market'
      doc: 'Money market'
    12:
      id: 'indices_components'
      doc: 'Indices Components'
    13:
      id: 'level_of_indices'
      doc: 'Level of Indices'
    14:
      id: 'levels_of_inavs'
      doc: 'Levels of INAV''s'
    15:
      id: 'indepth_local_and_global_market'
      doc: 'In-depth local and global market'
    16:
      id: 'twenty_price_levels_of_local_and_global_market'
      doc: '20 price levels of local and global market'
    17:
      id: 'best_offers_of_local_and_global_market_with_money_market'
      doc: 'Best offers of local and global market with Money market'
    18:
      id: 'twenty_price_levels_of_local_and_global_market_indices_components_level_of_indices_and_levels_of_inavs'
      doc: '20 price levels of local and global Market, Indices components, level of Indices and levels of INAV''s'
    19:
      id: 'ten_price_levels_of_derivate_futures_and_derivative_options'
      doc: '10 price levels of derivate futures and derivative options'
    20:
      id: 'best_offers_for_derivative_futures_and_derivative_options'
      doc: 'Best offers for derivative futures and derivative options'
    21:
      id: 'added_value_with_benchmark'
      doc: 'Added Value with Benchmark'
    22:
      id: 'added_value_with_capitalization_rules'
      doc: 'Added Value with Capitalization Rules'
    23:
      id: 'indices_levels_with_delay'
      doc: 'Indices Levels with delay'
    24:
      id: 'local_and_global_market_with_money_market_best_positions_with_delay'
      doc: 'Local and Global market with Money market best positions with delay'
    25:
      id: 'equities_market_trades_consolidated_feed'
      doc: 'Equities market trades, Consolidated Feed'
    26:
      id: 'best_bid_of_the_equities_market_consolidated_feed'
      doc: 'Best bid of the equities market, Consolidated Feed'
    27:
      id: 'full_depth_consolidated_feed'
      doc: 'Full depth, Consolidated Feed'
    28:
      id: 'closing_price_origin'
      doc: 'Closing price origin'
    29:
      id: 'analytics_price_and_market_depth'
      doc: 'Analytics Price and Market Depth'
    32:
      id: 'analytics_market_quality'
      doc: 'Analytics Market Quality'
    33:
      id: 'analytics_spead_performance'
      doc: 'Analytics Spead Performance'
    34:
      id: 'analytics_negotiation'
      doc: 'Analytics Negotiation'
    40:
      id: 'channel_zero_catalogs'
      doc: 'Channel Zero (catalogs)'
  origin:
    0x4d:
      id: 'bmv'
      doc: 'Bmv'
    0x49:
      id: 'biva'
      doc: 'Biva'
    0x41:
      id: 'both'
      doc: 'Snapshot consolidated Feed request only'
  direction_of_the_bid:
    0x43:
      id: 'purchase'
      doc: 'Purchase'
    0x56:
      id: 'sale'
      doc: 'Sale'
  type_of_trading:
    0x45:
      id: 'continuous_electronic_trading'
      doc: 'Continuous Electronic Trading'
    0x43:
      id: 'market_on_close'
      doc: 'Market on close (MOC)'
    0x42:
      id: 'block_trading'
      doc: 'Block Trading'
    0x44:
      id: 'debt_trading'
      doc: 'Debt Trading'
    0x57:
      id: 'warrants_trading'
      doc: 'Warrants Trading'
  market:
    0x4c:
      id: 'local'
      doc: 'Local'
    0x47:
      id: 'global_field'
      doc: 'Global'
    0x54:
      id: 'et_fs'
      doc: 'ETF''s'
    0x46:
      id: 'rei_ts'
      doc: 'REIT''s'

