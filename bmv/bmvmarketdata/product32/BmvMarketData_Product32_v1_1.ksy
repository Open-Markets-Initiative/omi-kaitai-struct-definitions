# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product32 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 32
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P32_1_ENG.pdf
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
  id: bmv_bmvmarketdata_product32_intra_v1_1
  title: Bmv BmvMarketData Product32 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 32 Intra v1.1'
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
            'message_type::effective_spread_message': effective_spread_message
            'message_type::spread_quality_message': spread_quality_message
            'message_type::price_leaderboard_message': price_leaderboard_message
            'message_type::quotes_quality_message': quotes_quality_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying the message'
  effective_spread_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: es_mxn
        type: decimal_s4_4
        doc: 'Effective Spread expressed in monetary units (MXN). Implied decimal with scale 1e-4'
      - id: es_basis_points
        type: decimal_s4_4
        doc: 'Effective Spread expressed in basis points. Implied decimal with scale 1e-4'
      - id: es_mxn_bid
        type: decimal_s4_4
        doc: 'Bid effective spread expressed in monetary units (MXN). Implied decimal with scale 1e-4'
      - id: es_basis_points_bid
        type: decimal_s4_4
        doc: 'Bid effective spread expressed in basis points. Implied decimal with scale 1e-4'
      - id: es_mxn_ask
        type: decimal_s4_4
        doc: 'Ask effective spread expressed in monetary units (MXN). Implied decimal with scale 1e-4'
      - id: es_basis_points_ask
        type: decimal_s4_4
        doc: 'Ask effective spread expressed in basis points. Implied decimal with scale 1e-4'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  spread_quality_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: time_best_spread
        type: decimal_s4_4
        doc: 'Time proportion in which the Stock Exchange (origin) had the best spread. Implied decimal with scale 1e-4'
      - id: time_tie_best_spread
        type: decimal_s4_4
        doc: 'Time proportion in which the Stock Exchange (origin) tied at the best spread. Implied decimal with scale 1e-4'
      - id: time_without_best_spread
        type: decimal_s4_4
        doc: 'Time proportion of the session in which the Stock Exchange (origin) did not have the best spread. Implied decimal with scale 1e-4'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
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
        doc: 'Unique code during instruments life'
      - id: indices
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Samples Catalog on the Connections and Appendix document'
  quotes_quality_message:
    seq:
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV I-BIVA'
      - id: instruments
        type: s2
        doc: 'Number of instruments where Stock Exchange (origin) has quotes on both sides, bid and ask'
      - id: time
        type: decimal_s4_4
        doc: 'Time proportion of the session in which the Stock Exchange (origin) maintains quotes on both sides, bid and ask. Implied decimal with scale 1e-4'
      - id: market
        type: u1
        enum: market
        doc: 'L-Local / G-Global / T-ETF’s / F-REIT’s'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
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
  message_type:
    0x3d:
      id: 'effective_spread_message'
      doc: 'Transaction cost analysis benchmark.'
    0x7b:
      id: 'spread_quality_message'
      doc: 'Quality of the quoted spread throughout the session.'
    0x40:
      id: 'price_leaderboard_message'
      doc: 'Measures time proportion that a stock Exchange maintains the best bid and (or) ask throughout the session.'
    0x7c:
      id: 'quotes_quality_message'
      doc: 'Time proportion in which an Exchange maintains quotes on both sides, bid and ask.'
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

