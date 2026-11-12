# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product40 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 40
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P40_2_ENG.pdf
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
  id: bmv_bmvmarketdata_product40_intra_v1_1
  title: Bmv BmvMarketData Product40 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 40 Intra v1.1'
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
        size: message_header.message_length + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message': catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message
            'message_type::catalog_of_instruments_that_belong_to_the_debt_metals_and_money_market_message': catalog_of_instruments_that_belong_to_the_debt_metals_and_money_market_message
            'message_type::catalog_for_instruments_belonging_to_the_capital_warrants_market_message': catalog_for_instruments_belonging_to_the_capital_warrants_market_message
            'message_type::options_futures_and_swaps_derivatives_market_instruments_catalog_message': options_futures_and_swaps_derivatives_market_instruments_catalog_message
            'message_type::catalog_sent_for_instruments_belonging_to_capital_tracs_message': catalog_sent_for_instruments_belonging_to_capital_tracs_message
            'message_type::catalog_sent_for_instruments_belonging_to_mutual_funds_message': catalog_sent_for_instruments_belonging_to_mutual_funds_message
            'message_type::catalog_sent_for_instruments_belonging_to_the_strategy_derivative_market_message': catalog_sent_for_instruments_belonging_to_the_strategy_derivative_market_message
            'message_type::underlying_value_on_warrants_catalog_message': underlying_value_on_warrants_catalog_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'Code identifying the message'
  catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer code'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series code'
      - id: last_price
        type: decimal_s8_8
        doc: 'Last reference price. Implied decimal with scale 1e-8'
      - id: wap
        type: decimal_s8_8
        doc: 'Weighted Average Price (WAP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Close price of the day. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Reference Catalog'
      - id: current_coupon
        type: s2
        doc: 'Current coupon number'
      - id: marketability
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Marketability Catalog on the Connections and Appendix document'
      - id: numeric_marketability
        type: decimal_s4_4
        doc: 'View BMV Marketability Index Methodology on the Connections and Appendix document. Implied decimal with scale 1e-4'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN instrument code'
      - id: market
        type: u1
        enum: market
        doc: 'See Markets Catalog on the Connections and Appendix document'
      - id: shares_outstanding
        type: s8
        doc: 'Shares Outstanding'
      - id: blocks_amount
        type: decimal_s8_8
        doc: 'Minimum amount for block trade. Implied decimal with scale 1e-8'
      - id: exchange
        type: u1
        enum: exchange
        doc: 'Exchange where the issuer was listed M-BMV I- BIVA'
      - id: filler
        size: 20
        doc: 'Filler'
  catalog_of_instruments_that_belong_to_the_debt_metals_and_money_market_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer code'
      - id: issue
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue code'
      - id: issue_date
        type: millisecond_timestamp
        doc: 'Placement and issue date. Milliseconds since Unix epoch'
      - id: maturity_date
        type: millisecond_timestamp
        doc: 'Maturity date. Milliseconds since Unix epoch'
      - id: reference_pricerate
        type: decimal_s8_8
        doc: 'Last reference price or rate. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Reference Catalog'
      - id: term_days
        type: s2
        doc: 'Term days issue'
      - id: current_coupon
        type: s2
        doc: 'Current coupon number'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN instrument code'
      - id: market
        type: u1
        enum: market
        doc: 'See Markets Catalog on the Connections and Appendix document'
      - id: current_nominal_value
        type: decimal_s8_8
        doc: 'Current Nominal Value. Implied decimal with scale 1e-8'
      - id: original_nominal_value
        type: decimal_s8_8
        doc: 'Original Nominal Value. Implied decimal with scale 1e-8'
      - id: outstanding_shares
        type: s8
        doc: 'Outstanding Shares'
      - id: amount_placed
        type: s8
        doc: 'Amount Placed'
      - id: operate_price_rate
        type: u1
        enum: operate_price_rate
        doc: 'T - Rate P - Price " " - Default'
      - id: exchange
        type: u1
        enum: exchange
        doc: 'Exchange where the issuer was listed M-BMV I- BIVA'
      - id: filler
        size: 20
        doc: 'Filler'
  catalog_for_instruments_belonging_to_the_capital_warrants_market_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer code'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series code'
      - id: warrant_type
        type: u1
        enum: warrant_type
        doc: 'Warrant type: "C"-Buy "V"-Sell “Null”-For BIVA’s instruments'
      - id: maturity_date
        type: millisecond_timestamp
        doc: 'Maturity date. Milliseconds since Unix epoch'
      - id: exercise_price
        type: decimal_s8_8
        doc: 'Warrant exercise price. Implied decimal with scale 1e-8'
      - id: reference_price
        type: decimal_s8_8
        doc: 'Last reference price. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Reference Catalog'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN instrument code'
      - id: exchange
        type: u1
        enum: exchange
        doc: 'Exchange where the issuer was listed M-BMV I- BIVA'
      - id: filler
        size: 20
        doc: 'Filler'
  options_futures_and_swaps_derivatives_market_instruments_catalog_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: class_field
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class name'
      - id: maturity
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Maturity code. Blank space for swaps'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option type: "C" - Call "P" - Put'
      - id: exercise_price
        type: decimal_s8_8
        doc: 'Warrant exercise price. Implied decimal with scale 1e-8'
      - id: bid
        type: decimal_s8_8
        doc: 'Multiple bid price. Implied decimal with scale 1e-8'
      - id: prior_day_settlement_price
        type: decimal_s8_8
        doc: 'Previous settlement price. Implied decimal with scale 1e-8'
      - id: last_day_of_operation
        type: millisecond_timestamp
        doc: 'Date of last operation. Milliseconds since Unix epoch'
      - id: maturity_date
        type: millisecond_timestamp
        doc: 'Maturity date. Milliseconds since Unix epoch'
      - id: open_contracts
        type: s4
        doc: 'Number of open contracts at prior closing day'
      - id: contract_size
        type: s4
        doc: 'Number of securities covered by an operated contract'
      - id: product_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'CME Identification (Chicago Mercantile Exchange)'
      - id: daily_maturity
        type: u1
        enum: daily_maturity
        doc: '1-For daily maturity 0 - Not daily maturity'
      - id: key_exercise_price
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Key Exercise Price'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'CFI Code'
      - id: filler
        size: 20
        doc: 'Filler'
  catalog_sent_for_instruments_belonging_to_capital_tracs_message:
    seq:
      - id: trac_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: trac_name
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies trac name'
      - id: underlying_issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying value issuer code'
      - id: underlying_series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying value series code'
      - id: securities
        type: decimal_s8_8
        doc: 'Number of underlying value certificates. Implied decimal with scale 1e-8'
      - id: excluded_securities
        type: decimal_s8_8
        doc: 'Number of excluded underlying value securities. Implied decimal with scale 1e-8'
      - id: price
        type: decimal_s8_8
        doc: 'Underlying value price. Implied decimal with scale 1e-8'
      - id: cash_component
        type: decimal_s8_8
        doc: 'Cash component by unit. Implied decimal with scale 1e-8'
      - id: excluded_value
        type: decimal_s8_8
        doc: 'Estimated value of excluded assets by unit. Implied decimal with scale 1e-8'
      - id: number_of_certificates
        type: s8
        doc: 'Number of Certificates by unit'
      - id: theoretical_price
        type: decimal_s8_8
        doc: 'Theoretical Price by certificate. Implied decimal with scale 1e-8'
      - id: filler
        size: 20
        doc: 'Filler'
  catalog_sent_for_instruments_belonging_to_mutual_funds_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer code'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series code'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: subsector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: business_line
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: sub_line
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: operating_company
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Mutual fund operating company code'
      - id: reference_price
        type: decimal_s8_8
        doc: 'Last reference price. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Reference Catalog'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN instrument code'
      - id: rating
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rating'
      - id: filler
        size: 20
        doc: 'Filler'
  catalog_sent_for_instruments_belonging_to_the_strategy_derivative_market_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: class_field
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Class name'
      - id: maturity
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Maturity code. Blank space for swaps'
      - id: type_of_strategy
        type: u1
        enum: type_of_strategy
        doc: 'R-Rollover E-Engrapado(Chain of forwards) F-Forward(Foreign currency strategy)'
      - id: bid
        type: decimal_s8_8
        doc: 'Multiple bid price. Implied decimal with scale 1e-8'
      - id: last_date_operation
        type: millisecond_timestamp
        doc: 'Last operation date. Milliseconds since Unix epoch'
      - id: maturity_date
        type: millisecond_timestamp
        doc: 'Maturity date. Milliseconds since Unix epoch'
      - id: short_leg_instrument_identifier
        type: s4
        doc: 'Applicable only in rollovers and forwards'
      - id: long_leg_instruments_id
        type: s4
        doc: 'Applicable only in rollovers and forwards'
      - id: frequency
        type: s1
        doc: 'Applicable only for forward chains'
      - id: number_of_maturities
        type: s1
        doc: 'Applicable only for forward chains'
      - id: filler
        size: 20
        doc: 'Filler'
  underlying_value_on_warrants_catalog_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer code'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Series code'
      - id: value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Value type code'
      - id: underlying_issuer
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying value issuer code'
      - id: underlying_series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying value series code'
      - id: underlying_value_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying value type code'
      - id: number_of_registered_values
        type: s8
        doc: 'Registered value numbers code'
      - id: exchange
        type: u1
        enum: exchange
        doc: 'Exchange where the issuer was listed M-BMV I- BIVA'
      - id: filler
        size: 20
        doc: 'Filler'
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
  message_type:
    0x6361:
      id: 'catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message'
      doc: 'It disseminates information on the local and global stock market.'
    0x6362:
      id: 'catalog_of_instruments_that_belong_to_the_debt_metals_and_money_market_message'
      doc: 'Catalog of instruments that belong to the Debt, Metals and Money market'
    0x6363:
      id: 'catalog_for_instruments_belonging_to_the_capital_warrants_market_message'
      doc: 'Catalog for instruments belonging to the capital warrants market'
    0x6364:
      id: 'options_futures_and_swaps_derivatives_market_instruments_catalog_message'
      doc: 'Options, futures and swaps derivatives market instruments catalog'
    0x6365:
      id: 'catalog_sent_for_instruments_belonging_to_capital_tracs_message'
      doc: 'Catalog sent for instruments belonging to capital TRACS'
    0x6366:
      id: 'catalog_sent_for_instruments_belonging_to_mutual_funds_message'
      doc: 'Catalog sent for instruments belonging to mutual funds'
    0x6367:
      id: 'catalog_sent_for_instruments_belonging_to_the_strategy_derivative_market_message'
      doc: 'Catalog sent for instruments belonging to the strategy derivative market'
    0x6379:
      id: 'underlying_value_on_warrants_catalog_message'
      doc: 'Underlying value on warrants catalog'
  market:
    0x4c:
      id: 'local'
      doc: 'Local'
    0x47:
      id: 'global_field'
      doc: 'Global (Foreign Instruments)'
    0x44:
      id: 'local_debt'
      doc: 'Local Debt'
    0x46:
      id: 'global_debt'
      doc: 'Global Debt'
    0x45:
      id: 'money'
      doc: 'Money'
    0x4d:
      id: 'dollar_option_market'
      doc: 'Dollar option market (MA)'
    0x58:
      id: 'stock_market'
      doc: 'Stock Market (MX)'
    0x56:
      id: 'forex_and_rates_market'
      doc: 'FOREX and rates Market (DV)'
    0x4a:
      id: 'fixed_income'
      doc: 'Fixed Income'
    0x42:
      id: 'variable_income'
      doc: 'Variable Income'
    0x54:
      id: 'metals'
      doc: 'Metals'
    0x49:
      id: 'mutual_funds'
      doc: 'Mutual Funds'
    0x57:
      id: 'warrants'
      doc: 'Warrants'
    0x20:
      id: 'all_markets'
      doc: 'Empty/Blank'
  exchange:
    0x4d:
      id: 'bmv'
      doc: 'Bmv'
    0x49:
      id: 'biva'
      doc: 'Biva'
  operate_price_rate:
    0x54:
      id: 'rate'
      doc: 'Rate'
    0x50:
      id: 'price'
      doc: 'Price'
    0x20:
      id: 'default_field'
      doc: 'Default'
  warrant_type:
    0x43:
      id: 'buy'
      doc: 'Buy'
    0x56:
      id: 'sell'
      doc: 'Sell'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  daily_maturity:
    0x31:
      id: 'for_daily_maturity'
      doc: 'For Daily Maturity'
    0x30:
      id: 'not_daily_maturity'
      doc: 'Not Daily Maturity'
  type_of_strategy:
    0x52:
      id: 'rollover'
      doc: 'Rollover'
    0x45:
      id: 'engrapado'
      doc: 'Engrapado (Chain of forwards)'
    0x46:
      id: 'forward'
      doc: 'Forward (Foreign currency strategy)'

