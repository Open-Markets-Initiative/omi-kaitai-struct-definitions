# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse ReplayBbo Wats v1.7.6.20
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange BBO Replay
#   Encoding: Warsaw Automated Trading System
#   Version: 1.7.6.20
#   Date: 10/05/2026
#   Specification: GPW_WATS_3.01_Market_Data_Protocol_v1.7.6.20.pdf
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
  id: gpw_wse_replaybbo_wats_v1_7_6_20_tcp
  title: Gpw Wse ReplayBbo Wats v1.7.6.20
  license: GPL-3.0
  endian: le

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange BBO Replay Wats v1.7.6.20'
doc-ref: https://gpwwats.pl/useful-documents-and-faqs

seq:
  - id: message
    type: message_struct
    repeat: eos

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Every market data message opens with the same 42 byte header'
      - id: payload
        size: message_header.message_length - 42
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::week_plan': week_plan
            'message_type::calendar_exception': calendar_exception
            'message_type::tick_table_entry': tick_table_entry
            'message_type::collar_table_entry': collar_table_entry
            'message_type::trading_phase_schedule_entry': trading_phase_schedule_entry
            'message_type::market_structure': market_structure
            'message_type::collar_group': collar_group
            'message_type::external_underlying': external_underlying
            'message_type::instrument': instrument
            'message_type::accrued_interest_table_entry': accrued_interest_table_entry
            'message_type::indexation_table_entry': indexation_table_entry
            'message_type::index_params': index_params
            'message_type::index_portfolio_entry': index_portfolio_entry
            'message_type::auction_summary': auction_summary
            'message_type::auction_update': auction_update
            'message_type::price_level_snapshot': price_level_snapshot
            'message_type::top_price_level_update': top_price_level_update
            'message_type::trade': trade
            'message_type::position_report': position_report
            'message_type::instrument_status_change': instrument_status_change
            'message_type::order_collars': order_collars
            'message_type::trade_collars': trade_collars
            'message_type::instrument_summary': instrument_summary
            'message_type::product_summary': product_summary
            'message_type::price_update': price_update
            'message_type::news': news
            'message_type::real_time_index': real_time_index
            'message_type::index_summary': index_summary
            'message_type::trading_session_status': trading_session_status
            'message_type::test_event': test_event
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message, which the worked example of section 6.1.4.2 shows includes the 42 byte header: an Instrument message states length 741 and occupies 741 bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'Type of the message'
      - id: message_version
        type: u2
        doc: 'Message version, used to differentiate between messages sent using different versions of the protocol'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the message, used for gap detection and, for orders at one price level, for priority'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Exact date and time of the event, in nanoseconds since the Unix epoch. Section 12.1 states the zone, that GPW WATS runs on UTC time, and the worked example of section 6.1.4.2 states the unit, 1717902001730705137 being 9 June 2024. Nanoseconds since Unix epoch'
      - id: source_timestamp
        type: nanosecond_timestamp
        doc: 'Date and time the source system generated the event, in nanoseconds since the Unix epoch. Nanoseconds since Unix epoch'
      - id: is_encrypted
        type: u1
        doc: 'A boolean value specifying whether the level is encrypted'
      - id: encryption_offset
        type: u8
        doc: 'Encryption byte offset'
      - id: encryption_key_id
        type: u4
        doc: 'Encryption Key ID - reference to a EncryptionKey message'
      - id: session_id
        type: u2
        doc: 'ID of the session'
      - id: stream_id
        type: u1
        doc: 'ID of the md stream'
  week_plan:
    seq:
      - id: calendar_id
        type: u4
        doc: 'Calendar ID'
      - id: weekdays
        size: 7
        doc: 'Boolean array of weekdays (Monday to Sunday) open or closed for trading; true – weekday open for trading, false – weekday closed for trading'
  calendar_exception:
    seq:
      - id: calendar_id
        type: u4
        doc: 'Calendar ID'
      - id: calendar_exception_date
        type: yyyymmdd_date
        doc: 'Calendar exception date'
      - id: calendar_exception_type
        type: u1
        enum: calendar_exception_type
        doc: 'Calendar exception type'
  tick_table_entry:
    seq:
      - id: tick_size
        type: decimal_s8_8
        doc: 'Size of the tick. Implied decimal with scale 1e-8'
      - id: lower_bound
        type: decimal_s8_8
        doc: 'Tick size lower bound. Implied decimal with scale 1e-8'
      - id: tick_table_id
        type: u4
        doc: 'Tick table ID'
  collar_table_entry:
    seq:
      - id: collar_table_id
        type: u4
        doc: 'Collar table ID'
      - id: collar_mode
        type: u1
        enum: collar_mode
        doc: 'Collar mode (trade price collar or order price collar)'
      - id: collar_expression
        type: u1
        enum: collar_expression
        doc: 'Collar expression (percentage or absolute value in reference price)'
      - id: collar_lower_bound
        type: decimal_s8_8
        doc: 'Collar lower bound. Implied decimal with scale 1e-8'
      - id: collar_value
        type: decimal_s8_8
        doc: 'Collar value. Implied decimal with scale 1e-8'
      - id: collar_lower_bid
        type: decimal_s8_8
        doc: 'Lower bid collar. Implied decimal with scale 1e-8'
      - id: collar_upper_bid
        type: decimal_s8_8
        doc: 'Upper bid collar. Implied decimal with scale 1e-8'
      - id: collar_upper_ask
        type: decimal_s8_8
        doc: 'Upper ask collar. Implied decimal with scale 1e-8'
      - id: collar_lower_ask
        type: decimal_s8_8
        doc: 'Lower ask collar. Implied decimal with scale 1e-8'
  trading_phase_schedule_entry:
    seq:
      - id: trading_schedule_id
        type: u4
        doc: 'Trading schedule ID'
      - id: trading_phase_id
        type: u4
        doc: 'Trading phase ID'
      - id: trading_phase_settlement_cycle
        type: u1
        doc: 'Settlement cycle for transactions made during a continuous phase'
      - id: trading_phase_max_block_settlement_cycle
        type: u1
        doc: 'Max settlement cycle for block transactions'
      - id: static_collar_volatility_auction_id
        type: u4
        doc: 'Static collar volatility auction ID'
      - id: dynamic_collar_volatility_auction_id
        type: u4
        doc: 'Dynamic collar volatility auction ID'
      - id: trading_phase_start_time
        type: nanosecond_timestamp
        doc: 'Trading phase start time. Nanoseconds since Unix epoch'
      - id: trading_phase_type
        type: u1
        enum: trading_phase_type
        doc: 'Type of matching algorithm'
      - id: uncrossing
        type: u1
        doc: 'True if the phase includes an uncrossing'
      - id: ext_static_collar_volatility_auction_id
        type: u4
        doc: 'ID of Static Collar Volatility Auction'
      - id: ext_dynamic_collar_volatility_auction_id
        type: u4
        doc: 'ID of Dynamic Collar Volatility Auction'
      - id: clat_id
        type: u4
        doc: 'ID of last auction phase'
  market_structure:
    seq:
      - id: id
        type: u4
        doc: 'ID of the market structure'
      - id: parent_id
        type: u4
        doc: 'ID of the market structure''s parent market structure if the market structure is a sub-structure'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: name
        type: str
        size: 50
        encoding: ASCII
        doc: 'Market structure name assigned by market operator'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
  collar_group:
    seq:
      - id: id
        type: u4
        doc: 'ID of the market structure'
      - id: order_static_collar_table_id
        type: u4
        doc: 'Collar table ID'
      - id: order_dynamic_collar_table_id
        type: u4
        doc: 'Collar table ID'
      - id: trade_static_collar_table_id
        type: u4
        doc: 'Collar table ID'
      - id: trade_dynamic_collar_table_id
        type: u4
        doc: 'Collar table ID'
  external_underlying:
    seq:
      - id: external_underlying_id
        type: u4
        doc: 'External underlying ID'
      - id: product_identification_product_identification
        type: str
        size: 30
        encoding: ASCII
        doc: 'Product identification'
      - id: product_identification_type
        type: u1
        enum: product_identification_type
        doc: 'Product identification type'
      - id: product_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Product code'
      - id: product_name
        type: str
        size: 50
        encoding: ASCII
        doc: 'Product name'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: nominal_currency
        type: u2
        enum: nominal_currency
        doc: 'Nominal currency'
      - id: trading_currency
        type: u2
        enum: trading_currency
        doc: 'Trading currency'
  instrument:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'Type of the product'
      - id: product_subtype
        type: u1
        enum: product_subtype
        doc: 'Subtype of the product'
      - id: first_trading_date
        type: yyyymmdd_date
        doc: 'First trading day of the financial instrument'
      - id: last_trading_date
        type: yyyymmdd_date
        doc: 'Last trading day of the financial instrument'
      - id: product_id
        type: u4
        doc: 'Reference to financial product definition'
      - id: currency
        type: u2
        enum: currency
        doc: 'Trading currency (e.g'
      - id: iceberg_min_value
        type: decimal_s8_2
        doc: 'Minimum iceberg order value. Implied decimal with scale 1e-2'
      - id: lot_size
        type: u4
        doc: 'Lot size for the instrument'
      - id: price_expression_type
        type: u1
        enum: price_expression_type
        doc: 'Price expression type for the financial instrument'
      - id: calendar_id
        type: u4
        doc: 'Calendar ID'
      - id: market_structure_id
        type: u4
        doc: 'ID of the financial instrument’s market segment'
      - id: tick_table_id
        type: u4
        doc: 'Tick table ID'
      - id: reference_instrument_id
        type: u4
        doc: 'Identifier of reference instrument'
      - id: collar_group_id
        type: u4
        doc: 'Collar group ID'
      - id: trading_schedule_id
        type: u4
        doc: 'Trading schedule ID'
      - id: description
        type: str
        size: 64
        encoding: ASCII
        doc: 'Financial instrument code'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: nominal_value_price
        type: decimal_s8_8
        doc: 'Nominal value of the financial instrument. Implied decimal with scale 1e-8'
      - id: nominal_value_type
        type: u1
        enum: nominal_value_type
        doc: 'Type of the product''s nominal value (no nominal, constant or unknown)'
      - id: multiplier_multiplier
        type: decimal_s8_8
        doc: 'Product value multiplier. Implied decimal with scale 1e-8'
      - id: strike_price
        type: decimal_s8_8
        doc: 'Product strike price. Implied decimal with scale 1e-8'
      - id: strike_price_currency
        type: u2
        enum: strike_price_currency
        doc: 'Strike Price Currency'
      - id: product_identification_product_identification
        type: str
        size: 30
        encoding: ASCII
        doc: 'Product identification'
      - id: product_identification_type
        type: u1
        enum: product_identification_type
        doc: 'Product identification type'
      - id: settlement_calendar_id
        type: u4
        doc: 'Settlement calendar ID'
      - id: bond_coupon_type
        type: u1
        enum: bond_coupon_type
        doc: 'Coupon type for a bond'
      - id: pre_trade_check_min_price
        type: decimal_s8_8
        doc: 'Minimum order price for pre-trade check. Implied decimal with scale 1e-8'
      - id: pre_trade_check_max_price
        type: decimal_s8_8
        doc: 'Maximum order price for pre-trade check. Implied decimal with scale 1e-8'
      - id: pre_trade_check_min_quantity
        type: u8
        doc: 'Minimum volume for pre-trade check'
      - id: pre_trade_check_max_quantity
        type: u8
        doc: 'Maximum volume for pre-trade check'
      - id: pre_trade_check_max_value
        type: decimal_s8_2
        doc: 'Maximum value for pre-trade check. Implied decimal with scale 1e-2'
      - id: pre_trade_check_min_value
        type: decimal_s8_2
        doc: 'Minimum value for pre-trade check. Implied decimal with scale 1e-2'
      - id: liquidity
        type: u1
        doc: 'Liquidity flag, true - liquid, false - Illiquid'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
      - id: issuer
        type: str
        size: 150
        encoding: ASCII
        doc: 'Name of the issuer'
      - id: issuer_reg_country
        type: u2
        enum: issuer_reg_country
        doc: 'Identifier of the country of the registration'
      - id: underlying_instrument_id
        type: u4
        doc: 'Identifier of the underlying instrument'
      - id: product_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Product code'
      - id: cfi
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFI (Classification of Financial Instrument) code'
      - id: fisn
        type: str
        size: 35
        encoding: ASCII
        doc: 'Product FISN (Financial Instrument Short Name) code'
      - id: issue_size
        type: u8
        doc: 'Size of the issue (depends on the issue size type)'
      - id: nominal_currency
        type: u2
        enum: nominal_currency
        doc: 'Nominal currency'
      - id: us_indicator
        type: u1
        enum: us_indicator
        doc: 'Identifier of the us indicator'
      - id: expiry_date
        type: yyyymmdd_date
        doc: 'Expiration date'
      - id: version_number
        type: u1
        doc: 'Version of the derivative'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Identifier of settlement type'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Identifier of option type'
      - id: exercise_type
        type: u1
        enum: exercise_type
        doc: 'Identifier of exercise style'
      - id: product_name
        type: str
        size: 50
        encoding: ASCII
        doc: 'Product name'
      - id: reference_price
        type: decimal_s8_8
        doc: 'Reference price. Implied decimal with scale 1e-8'
      - id: status
        type: u1
        enum: status
        doc: 'Instrument status'
      - id: initial_phase_id
        type: u4
        doc: 'Id of starting phase for the instrument'
      - id: threshold_max
        type: decimal_s8_8
        doc: 'upper threshold for leveraged instruments. Implied decimal with scale 1e-8'
      - id: threshold_min
        type: decimal_s8_8
        doc: 'lower threshold for leveraged instruments. Implied decimal with scale 1e-8'
      - id: is_leverage
        type: u1
        enum: is_leverage
        doc: 'Identifier of leverage instruments'
      - id: accrued_interest_value
        type: decimal_s8_8
        doc: 'Accrued iterest value of the instrument. Implied decimal with scale 1e-8'
      - id: kid
        type: str
        size: 128
        encoding: ASCII
        doc: 'KID'
      - id: kid_issue_date
        type: yyyymmdd_date
        doc: 'KID issue date'
      - id: value_at_risk
        type: u1
        doc: 'Value at risk'
      - id: external_underlying_id
        type: u4
        doc: 'External underlying ID'
  accrued_interest_table_entry:
    seq:
      - id: product_id
        type: u4
        doc: 'Reference to financial product definition'
      - id: accrued_interest_table_entry_date
        type: yyyymmdd_date
        doc: 'Accrued interest table entry date'
      - id: accrued_interest_table_entry_value
        type: decimal_s8_8
        doc: 'Accrued interest table entry value. Implied decimal with scale 1e-8'
  indexation_table_entry:
    seq:
      - id: product_id
        type: u4
        doc: 'Reference to financial product definition'
      - id: indexation_table_entry_date
        type: yyyymmdd_date
        doc: 'Indexation table entry date'
      - id: indexation_table_entry_value
        type: decimal_s8_8
        doc: 'Indexation table entry value. Implied decimal with scale 1e-8'
  index_params:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: index_base_value
        type: decimal_s8_8
        doc: 'Index base value. Implied decimal with scale 1e-8'
      - id: index_base_capitalisation
        type: decimal_s8_2
        doc: 'Index base capitalisation. Implied decimal with scale 1e-2'
      - id: index_base_date
        type: yyyymmdd_date
        doc: 'Index base date'
      - id: correction_coefficient
        type: decimal_s8_8
        doc: 'Index adjustment coefficient K(t). Implied decimal with scale 1e-8'
      - id: num_of_components
        type: u2
        doc: 'Total number of instruments in the portfolio'
      - id: index_publication_schedule
        type: u1
        enum: index_publication_schedule
        doc: 'Mode of index dissemination'
      - id: index_type
        type: u1
        enum: index_type
        doc: 'Index product classification'
      - id: presence_flags_index_params_presence_flags
        type: presence_flags_index_params_presence_flags
        doc: 'Indicates presence of values within IndexParams fields'
      - id: days_since_last_publication
        type: u1
        doc: 'Number of calendar days between current session and the previous session day'
      - id: number_of_dividends
        type: u2
        doc: 'Number of dividends included in the index calculation'
      - id: index_underlyings
        type: index_underlyings
        doc: 'IndexUnderlyings'
      - id: publication_order
        type: u2
        doc: 'Index publication presentation order'
      - id: currency
        type: u2
        enum: currency
        doc: 'Trading currency (e.g'
      - id: date_validity
        type: yyyymmdd_date
        doc: 'Date of validity of index portfolio'
  presence_flags_index_params_presence_flags:
    meta:
      bit-endian: le
    seq:
      - id: has_days_since_last_publication
        type: b1
      - id: has_number_of_dividends
        type: b1
      - id: reserved_27_index_params_presence_flags
        type: b6
  index_underlyings:
    seq:
      - id: count
        type: u1
        doc: 'How many elements does IndexUnderlyings contain'
      - id: items
        type: items
        repeat: expr
        repeat-expr: 3
        doc: 'IndexUnderlying Array'
  items:
    seq:
      - id: index_underlying
        type: index_underlying
        doc: 'IndexUnderlying'
  index_underlying:
    seq:
      - id: product_identification_public_product_identification
        type: product_identification_public_product_identification
        doc: 'PublicProductIdentification'
      - id: index_underlying_type
        type: u1
        enum: index_underlying_type
        doc: 'Underlying type of index'
  product_identification_public_product_identification:
    seq:
      - id: product_identification_product_identification
        type: str
        size: 30
        encoding: ASCII
        doc: 'Product identification'
      - id: product_identification_type
        type: u1
        enum: product_identification_type
        doc: 'Product identification type'
  index_portfolio_entry:
    seq:
      - id: id
        type: u4
        doc: 'ID of the market structure'
      - id: index_id
        type: u4
        doc: 'ID of index'
      - id: presence_flags_index_portfolio_entry_presence_flags
        type: presence_flags_index_portfolio_entry_presence_flags
        doc: 'Indicates presence of values within IndexPortfolioEntry fields'
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: public_product_identification
        type: public_product_identification
        doc: 'PublicProductIdentification'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: currency
        type: u2
        enum: currency
        doc: 'Trading currency (e.g'
      - id: instrument_packet
        type: u8
        doc: 'Instrument packet in index portfolio / of information product'
      - id: suspended
        type: u1
        doc: 'Is instrument suspended'
  presence_flags_index_portfolio_entry_presence_flags:
    meta:
      bit-endian: le
    seq:
      - id: has_instrument_id
        type: b1
      - id: reserved_17_index_portfolio_entry_presence_flags
        type: b7
  public_product_identification:
    seq:
      - id: product_identification_product_identification
        type: str
        size: 30
        encoding: ASCII
        doc: 'Product identification'
      - id: product_identification_type
        type: u1
        enum: product_identification_type
        doc: 'Product identification type'
  auction_summary:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Auction quantity (final auction volume)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction'
  auction_update:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: indicative_matching_price
        type: decimal_s8_8
        doc: 'Indicative Matching Price (IMP). Implied decimal with scale 1e-8'
      - id: indicative_matching_volume
        type: u8
        doc: 'Indicative Matching Volume (IMV)'
      - id: total_sell_quantity_at_imp
        type: u8
        doc: 'Total sell quantity at IMP'
      - id: total_buy_quantity_at_imp
        type: u8
        doc: 'Total buy quantity at IMP'
      - id: best_sell_level
        type: decimal_s8_8
        doc: 'Best sell price level (1st BBO level). Implied decimal with scale 1e-8'
      - id: best_sell_level_quantity
        type: u8
        doc: 'Quantity at the best sell price level'
      - id: best_buy_level
        type: decimal_s8_8
        doc: 'Best buy price level (1st BBO level). Implied decimal with scale 1e-8'
      - id: best_buy_level_quantity
        type: u8
        doc: 'Quantity at the best buy price level'
  price_level_snapshot:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: max_depth
        type: u1
        doc: 'The number of BBO levels contained in the message'
      - id: mm_buy_quote_level
        type: u1
        doc: 'Id of an level on which mm quote rests (0 means no mm)'
      - id: mm_sell_quote_level
        type: u1
        doc: 'Id of an level on which mm quote rests (0 means no mm)'
      - id: buy
        type: buy
        repeat: expr
        repeat-expr: 5
        doc: 'PriceLevel table'
      - id: sell
        type: sell
        repeat: expr
        repeat-expr: 5
        doc: 'PriceLevel table'
  buy:
    seq:
      - id: price_level
        type: price_level
        doc: 'PriceLevel'
  price_level:
    seq:
      - id: is_encrypted
        type: u1
        doc: 'A boolean value specifying whether the level is encrypted'
      - id: encryption_offset
        type: u8
        doc: 'Encryption byte offset'
      - id: encryption_key_id
        type: u4
        doc: 'Encryption Key ID - reference to a EncryptionKey message'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Auction quantity (final auction volume)'
      - id: order_count
        type: u2
        doc: 'Number of open orders at BBO level 1'
  sell:
    seq:
      - id: price_level
        type: price_level
        doc: 'PriceLevel'
  top_price_level_update:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: quantity
        type: u8
        doc: 'Auction quantity (final auction volume)'
      - id: side
        type: u1
        enum: side
        doc: 'Side (buy or sell)'
      - id: order_count
        type: u2
        doc: 'Number of open orders at BBO level 1'
  trade:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: settlement_value_value
        type: decimal_s8_2
        doc: 'Settlement value. Implied decimal with scale 1e-2'
      - id: settlement_date
        type: yyyymmdd_date
        doc: 'Settlement date'
      - id: trading_timestamp
        type: nanosecond_timestamp
        doc: 'Date and time when the transaction was executed. Nanoseconds since Unix epoch'
      - id: public_product_identification
        type: public_product_identification
        doc: 'PublicProductIdentification'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: price_currency
        type: u2
        enum: price_currency
        doc: 'Currency in which the price is expressed (applicable if the price is expressed as monetary value)'
      - id: price_notation
        type: u1
        enum: price_notation
        doc: 'Indication as to whether the price is expressed in monetary value, in percentage or in yield'
      - id: quantity
        type: u8
        doc: 'Auction quantity (final auction volume)'
      - id: nominal_value_value
        type: decimal_s8_2
        doc: 'Nominal value. Implied decimal with scale 1e-2'
      - id: nominal_currency
        type: u2
        enum: nominal_currency
        doc: 'Nominal currency'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: publication_timestamp
        type: nanosecond_timestamp
        doc: 'Date and time when the transaction was published by a trading venue. Nanoseconds since Unix epoch'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
      - id: trade_to_be_cleared
        type: u1
        doc: 'Code to identify whether the transaction will be cleared'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: mmt_market_mechanism
        type: u1
        enum: mmt_market_mechanism
        doc: 'MMT Market Mechanism'
      - id: mmt_trading_mode
        type: u1
        enum: mmt_trading_mode
        doc: 'MMT Trading Mode'
      - id: mmt_transaction_category
        type: u1
        enum: mmt_transaction_category
        doc: 'MMT Transaction Category'
      - id: mmt_negotiation_indicator
        type: u1
        enum: mmt_negotiation_indicator
        doc: 'MMT Negotiation Indicator'
      - id: mmt_agency_cross_trade_indicator
        type: u1
        enum: mmt_agency_cross_trade_indicator
        doc: 'MMT Agency Cross Trade Indicator'
      - id: mmt_modification_indicator
        type: u1
        enum: mmt_modification_indicator
        doc: 'MMT Modification Indicator'
      - id: mmt_benchmark_reference_price_indicator
        type: u1
        enum: mmt_benchmark_reference_price_indicator
        doc: 'MMT Benchmark / Reference Price Indicator'
      - id: mmt_special_dividend_indicator
        type: u1
        enum: mmt_special_dividend_indicator
        doc: 'MMT Special Dividend Indicator'
      - id: mmt_off_book_automated_indicator
        type: u1
        enum: mmt_off_book_automated_indicator
        doc: 'MMT Off Book Automated Indicator'
      - id: mmt_ordinary_trade_indicator
        type: u1
        enum: mmt_ordinary_trade_indicator
        doc: 'MMT Ordinary Trade Indicator'
      - id: mmt_algorithmic_indicator
        type: u1
        enum: mmt_algorithmic_indicator
        doc: 'MMT Algorithmic Indicator'
      - id: mmt_post_trade_deferral_reason
        type: u1
        enum: mmt_post_trade_deferral_reason
        doc: 'MMT Post-Trade Deferral Reason'
      - id: mmt_post_trade_deferral_type
        type: u1
        enum: mmt_post_trade_deferral_type
        doc: 'MMT Post-Trade Deferral Type'
  position_report:
    seq:
      - id: public_product_identification
        type: public_product_identification
        doc: 'PublicProductIdentification'
      - id: pos_type
        type: u1
        enum: pos_type
        doc: 'Type of quantity returned'
      - id: open_positions
        type: u4
        doc: 'Number of open positions'
      - id: trade_id
        type: u4
        doc: 'ID of the trade'
  instrument_status_change:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: trading_phase_id
        type: u4
        doc: 'Trading phase ID'
      - id: trading_phase_type
        type: u1
        enum: trading_phase_type
        doc: 'Type of matching algorithm'
      - id: status
        type: u1
        enum: status
        doc: 'Instrument status'
      - id: stressed_market
        type: u1
        doc: 'Stressed market conditions is called for when instrument experience high and short term intraday volatility'
  order_collars:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: collar_type
        type: u1
        enum: collar_type
        doc: 'Collars type'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: lower_bid
        type: decimal_s8_8
        doc: 'Value of the lower bid Price collar. Implied decimal with scale 1e-8'
      - id: upper_bid
        type: decimal_s8_8
        doc: 'Value of the upper bid Price collar. Implied decimal with scale 1e-8'
      - id: lower_ask
        type: decimal_s8_8
        doc: 'Value of the lower ask Price collar. Implied decimal with scale 1e-8'
      - id: upper_ask
        type: decimal_s8_8
        doc: 'Value of the upper ask Price collar. Implied decimal with scale 1e-8'
  trade_collars:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: collar_type
        type: u1
        enum: collar_type
        doc: 'Collars type'
      - id: price
        type: decimal_s8_8
        doc: 'Auction price (final auction price). Implied decimal with scale 1e-8'
      - id: lower
        type: decimal_s8_8
        doc: 'Value of the lower Price collar. Implied decimal with scale 1e-8'
      - id: upper
        type: decimal_s8_8
        doc: 'Value of the upper Price collar. Implied decimal with scale 1e-8'
  instrument_summary:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: last_traded_price
        type: decimal_s8_8
        doc: 'Last Traded Price (LTP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing Price (CP). Implied decimal with scale 1e-8'
      - id: closing_price_type
        type: u1
        enum: closing_price_type
        doc: 'Closing Price Type'
      - id: adjusted_closing_price
        type: decimal_s8_8
        doc: 'Adjusted Closing Price (ACP). Implied decimal with scale 1e-8'
      - id: adjusted_closing_price_reason
        type: u1
        enum: adjusted_closing_price_reason
        doc: 'Reason for adjusting the Closing Price'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: is_correction
        type: u1
        doc: 'Previous message correction flag'
  product_summary:
    seq:
      - id: clob_instrument
        type: clob_instrument
        doc: 'SingleInstrumentSummary'
      - id: cross_instrument
        type: cross_instrument
        doc: 'SingleInstrumentSummary'
      - id: block_instrument
        type: block_instrument
        doc: 'SingleInstrumentSummary'
      - id: hybrid_instrument
        type: hybrid_instrument
        doc: 'SingleInstrumentSummary'
      - id: product_identification_type
        type: u1
        enum: product_identification_type
        doc: 'Product identification type'
      - id: product_identification_product_identification
        type: str
        size: 30
        encoding: ASCII
        doc: 'Product identification'
      - id: product_id
        type: u4
        doc: 'Reference to financial product definition'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: accumulated_interest
        type: decimal_s8_8
        doc: 'Accumulated interest on the bonds or for mortgage-backed bonds on the day of settling the transaction. Implied decimal with scale 1e-8'
      - id: interest_rate
        type: decimal_s8_8
        doc: 'Interest rate is determined on the basis of WIBOR/WIBID/WIRON rates for each expiration date of options and futures. Implied decimal with scale 1e-8'
      - id: currency
        type: u2
        enum: currency
        doc: 'Trading currency (e.g'
      - id: session_date
        type: yyyymmdd_date
        doc: 'Stock Exchange session date'
      - id: trading_value_currency
        type: decimal_s8_2
        doc: 'The field comprises the trading value expressed in trading currency. Implied decimal with scale 1e-2'
      - id: status
        type: u1
        enum: status
        doc: 'Instrument status'
      - id: sector
        type: u2
        doc: 'Defines the sector of the economy that the company belongs to'
      - id: market
        type: u1
        doc: 'Defines the market the instrument belongs to'
      - id: marker_price_change
        type: u1
        enum: marker_price_change
        doc: 'The field contains the direction of the percentage change in the instrument closing price from the current session in relation to the reference price'
      - id: lower_liquidity
        type: u1
        doc: 'The positive field value (true) informs if the company was qualified to Lower Liquidity Space'
      - id: multiplier_number
        type: decimal_s8_8
        doc: 'Instrument multiplier. Implied decimal with scale 1e-8'
      - id: dividend_rate
        type: decimal_s8_8
        doc: 'Dividend rate for the company is given on the basis of dividends paid by companies being the base instrument for futures and options. Implied decimal with scale 1e-8'
      - id: delta
        type: decimal_s8_8
        doc: 'Value of Delta indicator from the current session. Implied decimal with scale 1e-8'
      - id: gamma
        type: decimal_s8_8
        doc: 'Value of Gamma indicator from the current session. Implied decimal with scale 1e-8'
      - id: rho
        type: decimal_s8_8
        doc: 'Value of Rho indicator from the current session. Implied decimal with scale 1e-8'
      - id: theta
        type: decimal_s8_8
        doc: 'Value of Theta indicator from the current session. Implied decimal with scale 1e-8'
      - id: vega
        type: decimal_s8_8
        doc: 'Value of Vega indicator from the current session. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Volatility is calculated according to algorithm worked out by the WSE. Implied decimal with scale 1e-8'
      - id: options_strike_price
        type: decimal_s8_8
        doc: 'Option product strike price. Implied decimal with scale 1e-8'
      - id: dividend
        type: u1
        doc: 'The positive field value (true) informs that the instruments are traded the first time after determining the right to dividend'
      - id: subscription_right
        type: u1
        doc: 'The positive field value (true) informs that the instruments are traded the first time after determining the subscription right'
      - id: interim_dividend_right
        type: u1
        doc: 'The positive field value (true) informs that the instruments are traded the first time after determining the interim dividend right'
      - id: split
        type: u1
        doc: 'The positive field value (true) informs that the instruments are traded the first time after the change of the nominal value of shares'
      - id: quotation_system
        type: u1
        enum: quotation_system
        doc: 'The field informing about the system of listing the instrument'
      - id: liquidity_support_pge
        type: u1
        doc: 'The field informs if the company entered to Liquidity Support Programme'
  clob_instrument:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
      - id: last_traded_price
        type: decimal_s8_8
        doc: 'Last Traded Price (LTP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing Price (CP). Implied decimal with scale 1e-8'
      - id: closing_price_type
        type: u1
        enum: closing_price_type
        doc: 'Closing Price Type'
      - id: adjusted_closing_price
        type: decimal_s8_8
        doc: 'Adjusted Closing Price (ACP). Implied decimal with scale 1e-8'
      - id: adjusted_closing_price_reason
        type: u1
        enum: adjusted_closing_price_reason
        doc: 'Reason for adjusting the Closing Price'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: settlement_price
        type: decimal_s8_8
        doc: 'Settlement price. Implied decimal with scale 1e-8'
      - id: settlement_value_price
        type: decimal_s8_8
        doc: 'Settlement value. Implied decimal with scale 1e-8'
      - id: end_trading_date
        type: yyyymmdd_date
        doc: 'End of trading date'
      - id: last_trade_date
        type: yyyymmdd_date
        doc: 'The date of execution of the last trade for the given instrument'
  cross_instrument:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
      - id: last_traded_price
        type: decimal_s8_8
        doc: 'Last Traded Price (LTP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing Price (CP). Implied decimal with scale 1e-8'
      - id: closing_price_type
        type: u1
        enum: closing_price_type
        doc: 'Closing Price Type'
      - id: adjusted_closing_price
        type: decimal_s8_8
        doc: 'Adjusted Closing Price (ACP). Implied decimal with scale 1e-8'
      - id: adjusted_closing_price_reason
        type: u1
        enum: adjusted_closing_price_reason
        doc: 'Reason for adjusting the Closing Price'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: settlement_price
        type: decimal_s8_8
        doc: 'Settlement price. Implied decimal with scale 1e-8'
      - id: settlement_value_price
        type: decimal_s8_8
        doc: 'Settlement value. Implied decimal with scale 1e-8'
      - id: end_trading_date
        type: yyyymmdd_date
        doc: 'End of trading date'
      - id: last_trade_date
        type: yyyymmdd_date
        doc: 'The date of execution of the last trade for the given instrument'
  block_instrument:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
      - id: last_traded_price
        type: decimal_s8_8
        doc: 'Last Traded Price (LTP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing Price (CP). Implied decimal with scale 1e-8'
      - id: closing_price_type
        type: u1
        enum: closing_price_type
        doc: 'Closing Price Type'
      - id: adjusted_closing_price
        type: decimal_s8_8
        doc: 'Adjusted Closing Price (ACP). Implied decimal with scale 1e-8'
      - id: adjusted_closing_price_reason
        type: u1
        enum: adjusted_closing_price_reason
        doc: 'Reason for adjusting the Closing Price'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: settlement_price
        type: decimal_s8_8
        doc: 'Settlement price. Implied decimal with scale 1e-8'
      - id: settlement_value_price
        type: decimal_s8_8
        doc: 'Settlement value. Implied decimal with scale 1e-8'
      - id: end_trading_date
        type: yyyymmdd_date
        doc: 'End of trading date'
      - id: last_trade_date
        type: yyyymmdd_date
        doc: 'The date of execution of the last trade for the given instrument'
  hybrid_instrument:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: market_model_type
        type: u1
        enum: market_model_type
        doc: 'Market model type'
      - id: last_traded_price
        type: decimal_s8_8
        doc: 'Last Traded Price (LTP). Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing Price (CP). Implied decimal with scale 1e-8'
      - id: closing_price_type
        type: u1
        enum: closing_price_type
        doc: 'Closing Price Type'
      - id: adjusted_closing_price
        type: decimal_s8_8
        doc: 'Adjusted Closing Price (ACP). Implied decimal with scale 1e-8'
      - id: adjusted_closing_price_reason
        type: u1
        enum: adjusted_closing_price_reason
        doc: 'Reason for adjusting the Closing Price'
      - id: pct_change
        type: decimal_s8_8
        doc: 'Percentage change. Implied decimal with scale 1e-8'
      - id: vwap
        type: decimal_s8_8
        doc: 'Volume-weighted average price. Implied decimal with scale 1e-8'
      - id: no_trades
        type: u8
        doc: 'Total number of transactions'
      - id: total_volume
        type: u8
        doc: 'Total transaction volume'
      - id: total_value
        type: decimal_s8_2
        doc: 'Total transaction value. Implied decimal with scale 1e-2'
      - id: opening_price
        type: decimal_s8_8
        doc: 'The price of the first trade on the current trading day. Implied decimal with scale 1e-8'
      - id: max_price
        type: decimal_s8_8
        doc: 'Highest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: min_price
        type: decimal_s8_8
        doc: 'Lowest price of the instrument on the current trading day. Implied decimal with scale 1e-8'
      - id: settlement_price
        type: decimal_s8_8
        doc: 'Settlement price. Implied decimal with scale 1e-8'
      - id: settlement_value_price
        type: decimal_s8_8
        doc: 'Settlement value. Implied decimal with scale 1e-8'
      - id: end_trading_date
        type: yyyymmdd_date
        doc: 'End of trading date'
      - id: last_trade_date
        type: yyyymmdd_date
        doc: 'The date of execution of the last trade for the given instrument'
  price_update:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: price_update_type
        type: u1
        enum: price_update_type
        doc: 'Indicates price update message variant'
      - id: price_ytm_presence
        type: price_ytm_presence
        doc: 'Bit flags indicating the filling of ''value'', ''valueAsk'', ''valueBid'' attributes in the price update message'
      - id: value_field
        type: decimal_s8_8
        doc: 'Indicates the updated price or YTM. Implied decimal with scale 1e-8'
      - id: value_bid
        type: decimal_s8_8
        doc: 'Indicates the updated bid price or bid YTM. Implied decimal with scale 1e-8'
      - id: value_ask
        type: decimal_s8_8
        doc: 'Indicates the updated ask price or ask YTM. Implied decimal with scale 1e-8'
  price_ytm_presence:
    meta:
      bit-endian: le
    seq:
      - id: value_price_ytm_presence
        type: b1
        doc: 'A price was provided'
      - id: value_bid_price_ytm_presence
        type: b1
        doc: 'A bid price was provided'
      - id: value_ask_price_ytm_presence
        type: b1
        doc: 'An ask price was provided'
      - id: ytm_no_calc
        type: b1
        doc: 'YTM was not provided due to the absence of its calculation'
      - id: ytm_bid_no_calc
        type: b1
        doc: 'Bid YTM was not provided due to the absence of its calculation'
      - id: ytm_ask_no_calc
        type: b1
        doc: 'Ask YTM was not provided due to the absence of its calculation'
      - id: reserved_615
        type: b10
  news:
    seq:
      - id: market_structure_id
        type: u4
        doc: 'ID of the financial instrument’s market segment'
      - id: news_id
        type: u4
        doc: 'News id - The news id serves as a unique reference for tracking purposes within the WATS system'
      - id: title
        type: str
        size: 80
        encoding: ASCII
        doc: 'News title, unique per message'
      - id: entry_number
        type: u1
        doc: 'News entry number'
      - id: total
        type: u1
        doc: 'Total number of news entries'
      - id: text
        type: str
        size: 800
        encoding: ASCII
        doc: 'News text'
  real_time_index:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: index_level_code
        type: u1
        enum: index_level_code
        doc: 'Level of the index'
      - id: num_of_active_instruments
        type: u2
        doc: 'Number of instruments – participants of the index, for which the quotation was set during the session'
      - id: ind_index_opening_portfolio
        type: decimal_s8_8
        doc: 'Indicator of the index opening portfolio W(t). Implied decimal with scale 1e-8'
      - id: index_value
        type: decimal_s8_8
        doc: 'The value of the last level for the index according to the definition provided in the indexLevelCode. Implied decimal with scale 1e-8'
      - id: pct_change_index_val_prev_session
        type: decimal_s8_8
        doc: 'Percentage change of the index value in relation to the value of the closing index from the previous session. Implied decimal with scale 1e-8'
      - id: session_low
        type: decimal_s8_8
        doc: 'Lowest value of the day. Implied decimal with scale 1e-8'
      - id: session_high
        type: decimal_s8_8
        doc: 'Highest value of the day. Implied decimal with scale 1e-8'
      - id: presence_flags_real_time_index_presence_flags
        type: presence_flags_real_time_index_presence_flags
        doc: 'Indicates presence of values within RealTimeIndex fields'
      - id: trading_value
        type: decimal_s8_2
        doc: 'Value of trading in the instruments from the given index. Implied decimal with scale 1e-2'
      - id: index_value_bid
        type: decimal_s8_8
        doc: 'Value of the buy index based on the best sell offers of instruments. Implied decimal with scale 1e-8'
      - id: index_value_ask
        type: decimal_s8_8
        doc: 'Value of the sell index based on the best sell offers of instruments. Implied decimal with scale 1e-8'
      - id: mid_spread_index
        type: decimal_s8_8
        doc: 'Mean of indexValueBid and indexValueAsk. Implied decimal with scale 1e-8'
      - id: difference_central_spread
        type: decimal_s8_8
        doc: 'The point difference between midSpreadIndex and indexValue. Implied decimal with scale 1e-8'
  presence_flags_real_time_index_presence_flags:
    meta:
      bit-endian: le
    seq:
      - id: has_trading_value
        type: b1
      - id: has_index_value_bid
        type: b1
      - id: has_index_value_ask
        type: b1
      - id: has_mid_spread_index
        type: b1
      - id: has_difference_central_spread
        type: b1
      - id: reserved_57
        type: b3
  index_summary:
    seq:
      - id: instrument_id
        type: u4
        doc: 'ID of financial instrument'
      - id: opening_index_value
        type: decimal_s8_8
        doc: 'Opening index value. Implied decimal with scale 1e-8'
      - id: session_low
        type: decimal_s8_8
        doc: 'Lowest value of the day. Implied decimal with scale 1e-8'
      - id: session_high
        type: decimal_s8_8
        doc: 'Highest value of the day. Implied decimal with scale 1e-8'
      - id: closing_index_value
        type: decimal_s8_8
        doc: 'Closing index value. Implied decimal with scale 1e-8'
      - id: presence_flags_index_summary_presence_flags
        type: presence_flags_index_summary_presence_flags
        doc: 'Indicates presence of values within IndexSummary fields'
      - id: session_avg
        type: decimal_s8_8
        doc: 'Average value of the day. Implied decimal with scale 1e-8'
      - id: pct_change_index_val_prev_session
        type: decimal_s8_8
        doc: 'Percentage change of the index value in relation to the value of the closing index from the previous session. Implied decimal with scale 1e-8'
      - id: pct_change_index_val_prev_year
        type: decimal_s8_8
        doc: 'Percentage change of the index value in relation to its value at the end of the previous year. Implied decimal with scale 1e-8'
      - id: closing_capitalisation_portfolio
        type: decimal_s8_2
        doc: 'Capitalisation of the portfolio for the closing index expressed in the currency of the index, on basis of which the closing index is calculated. Implied decimal with scale 1e-2'
      - id: ind_index_opening_portfolio
        type: decimal_s8_8
        doc: 'Indicator of the index opening portfolio W(t). Implied decimal with scale 1e-8'
  presence_flags_index_summary_presence_flags:
    meta:
      bit-endian: le
    seq:
      - id: has_session_avg
        type: b1
      - id: reserved_17_index_summary_presence_flags
        type: b7
  trading_session_status:
    seq:
      - id: market_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market structure''s Market Identifier Code (MIC) as specified in ISO 10383'
      - id: market_structure_id
        type: u4
        doc: 'ID of the financial instrument’s market segment'
      - id: trading_session_event
        type: u1
        enum: trading_session_event
        doc: 'Identifies an event related to the trading status of a trading session'
      - id: date
        type: yyyymmdd_date
        doc: 'Date of the business session when provided and 0 for StartOfTechnicalSession and EndOfTechnicalSession events'
  test_event:
    seq:
      - id: scenario_name
        type: str
        size: 200
        encoding: ASCII
        doc: 'Test scenario name'
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Test event type'
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    33:
      id: 'week_plan'
      doc: 'Trading week plan'
    35:
      id: 'calendar_exception'
      doc: 'Upcoming calendar day exception'
    32:
      id: 'tick_table_entry'
      doc: 'Tick size definition'
    108:
      id: 'collar_table_entry'
      doc: 'Collar table definition'
    27:
      id: 'trading_phase_schedule_entry'
      doc: 'Trading phase definition'
    275:
      id: 'market_structure'
      doc: 'Messages defining the Trading Venue’s market structure'
    299:
      id: 'collar_group'
      doc: 'Message defining a collar group'
    806:
      id: 'external_underlying'
      doc: 'The message contains a list of underlyings not traded in WATS. It concerns underlyings for derivatives and structured products'
    279:
      id: 'instrument'
      doc: 'Definition of a financial instrument'
    36:
      id: 'accrued_interest_table_entry'
      doc: 'Message describing an accrued interest table entry'
    37:
      id: 'indexation_table_entry'
      doc: 'Message describing an indexation table entry'
    503:
      id: 'index_params'
      doc: 'The metadata message for the given index'
    502:
      id: 'index_portfolio_entry'
      doc: 'The message contains information about a product providing the index portfolio'
    270:
      id: 'auction_summary'
      doc: 'Auction summary, including auction price and quantity'
    268:
      id: 'auction_update'
      doc: 'Updates IMP/IMV and BBO during an auction'
    257:
      id: 'price_level_snapshot'
      doc: 'BBO price levels and volumes'
    256:
      id: 'top_price_level_update'
      doc: 'BBO Level 1'
    38:
      id: 'trade'
      doc: 'Enriched trade report'
    801:
      id: 'position_report'
      doc: 'Report of open positions'
    26:
      id: 'instrument_status_change'
      doc: 'Start of a new trading phase'
    272:
      id: 'order_collars'
      doc: 'New order price collars'
    273:
      id: 'trade_collars'
      doc: 'New trade price collars'
    671:
      id: 'instrument_summary'
      doc: 'Provides brief instrument summary'
    672:
      id: 'product_summary'
      doc: 'Session day product summary'
    271:
      id: 'price_update'
      doc: 'Message indicating a price or YTM update'
    517:
      id: 'news'
      doc: 'News message'
    500:
      id: 'real_time_index'
      doc: 'Message providing real-time index values for instruments'
    501:
      id: 'index_summary'
      doc: 'The index summary message provides a summary of the data calculated in a stock index for a given day'
    23:
      id: 'trading_session_status'
      doc: 'The Trading Session Status provides information on the status of a market and on a trading day events'
    1:
      id: 'heartbeat'
      doc: 'A message type used to check connectivity'
    8192:
      id: 'test_event'
      doc: 'Test event'
  calendar_exception_type:
    1:
      id: 'closed'
      doc: 'The day is closed for trading'
    2:
      id: 'open'
      doc: 'The day is open for trading'
  collar_mode:
    1:
      id: 'trade_price_collar'
      doc: 'Trade price collar'
    2:
      id: 'order_price_collar'
      doc: 'Order price collar'
  collar_expression:
    1:
      id: 'percentage'
      doc: 'Percentage'
    2:
      id: 'absolute_value'
      doc: 'Absolute value'
  trading_phase_type:
    1:
      id: 'continuous_price_time'
      doc: 'Continuous price and time'
    2:
      id: 'continuous_ref_price_time'
      doc: 'Continuous time at reference price'
    3:
      id: 'continuous_last_auction_time'
      doc: 'Trade at last'
    4:
      id: 'auction_opening'
      doc: 'Opening auction'
    5:
      id: 'block_exact_matching'
      doc: 'Block transaction, exact matching'
    6:
      id: 'no_trading_closed'
      doc: 'Trading disabled, no matching'
    7:
      id: 'uncrossing'
      doc: 'Uncrossing'
    8:
      id: 'auction_closing'
      doc: 'Closing auction'
    9:
      id: 'auction_intraday'
      doc: 'Intraday auction'
    10:
      id: 'auction_volatility_static'
      doc: 'Volatility auction after static collars breach'
    11:
      id: 'auction_volatility_dynamic'
      doc: 'Volatility auction after dynamic collars breach'
    12:
      id: 'auction_extended_volatility_static'
      doc: 'Additional volatility auction after static collar breach'
    13:
      id: 'auction_extended_volatility_dynamic'
      doc: 'Additional volatility auction after dynamic collar breach'
    14:
      id: 'no_trading_early_monitoring'
      doc: 'Early Monitoring'
    15:
      id: 'no_trading_late_monitoring'
      doc: 'Late Monitoring'
    16:
      id: 'hybrid'
      doc: 'Hybrid normal trading'
    17:
      id: 'hybrid_buy_only'
      doc: 'Hybrid buy only phase'
    18:
      id: 'hybrid_pre_trade'
      doc: 'Hybrid pre trade phase'
    19:
      id: 'unsuspension_auction'
      doc: 'A phase triggered whenever an instrument’s changes its status from RegulatorySuspension or MarketOperationSuspension before entering into continuous phase'
    20:
      id: 'ipo'
      doc: 'Initial public offering phase'
    21:
      id: 'tender_offer'
      doc: 'Tender offer phase'
    22:
      id: 'hybrid_pre_trade_buy_only'
      doc: 'Hybrid pre trade BuyOnly phase'
    23:
      id: 'distribution'
      doc: 'Instrument distribution phase'
  market_model_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'clob'
      doc: 'A Central Limit Order Book (CLOB)'
    3:
      id: 'block'
      doc: 'BLOCK'
    4:
      id: 'hybrid'
      doc: 'HYBRID market model'
    5:
      id: 'cross'
      doc: 'CROSS'
    6:
      id: 'ipo'
      doc: 'Initial public offering'
    7:
      id: 'tender_offer'
      doc: 'Tender offer'
    8:
      id: 'redistribution'
      doc: 'Redistribution'
  product_identification_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'isin'
      doc: 'Financial instrument''s ISIN'
  nominal_currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  trading_currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  product_type:
    1:
      id: 'equity'
      doc: 'Equity'
    2:
      id: 'fixed_income'
      doc: 'Fixed income'
    3:
      id: 'derivative_futures'
      doc: 'Derivative Futures'
    4:
      id: 'derivative_options'
      doc: 'Derivative Options'
    5:
      id: 'index'
      doc: 'Index'
    6:
      id: 'currency'
      doc: 'Currency'
    7:
      id: 'structured_product'
      doc: 'Structured Product'
    9:
      id: 'tracker'
      doc: 'Tracker'
  product_subtype:
    1:
      id: 'share'
      doc: 'Share'
    2:
      id: 'allotment_right'
      doc: 'Allotment Right'
    3:
      id: 'subscription_right'
      doc: 'Subscription Right'
    4:
      id: 'tender_offer'
      doc: 'Tender Offer'
    5:
      id: 'issue_right'
      doc: 'Issue Right'
    6:
      id: 'subscription_warrant'
      doc: 'Subscription Warrant'
    7:
      id: 'bank_securities'
      doc: 'Bank Securities'
    8:
      id: 'bond'
      doc: 'Bond'
    9:
      id: 'treasury_bond'
      doc: 'Treasury Bond'
    10:
      id: 'agency_bond'
      doc: 'Bond issued by a government institution'
    11:
      id: 'municipal_bond'
      doc: 'Municipal Bond'
    12:
      id: 'corporate_bank_bond'
      doc: 'Corporate Bond - bank'
    13:
      id: 'corporate_firm_bond'
      doc: 'Corporate Bond - firm'
    14:
      id: 'convertible_bond'
      doc: 'Convertible Bond'
    15:
      id: 'mortgage_bond'
      doc: 'Mortgage Bond'
    16:
      id: 'mortgage_backed_bond'
      doc: 'Mortgage Backed Bond'
    17:
      id: 'public_mortgage_bond'
      doc: 'Public Mortgage Bond'
    18:
      id: 'bill'
      doc: 'Bill'
    19:
      id: 'treasury_bill'
      doc: 'Treasury Bill'
    20:
      id: 'commercial_bill'
      doc: 'Commercial Bill'
    21:
      id: 'exchange_traded_fund'
      doc: 'ETF - Exchange Traded Fund'
    22:
      id: 'exchange_traded_note'
      doc: 'ETN - Exchange Traded Note'
    23:
      id: 'exchange_traded_commodity'
      doc: 'ETC - Exchange Traded Commodity'
    24:
      id: 'investment_certificate'
      doc: 'Investment Certificate'
    25:
      id: 'index_futures'
      doc: 'Index Futures'
    26:
      id: 'stock_futures'
      doc: 'Stock Futures'
    27:
      id: 'currency_futures'
      doc: 'Currency Futures'
    28:
      id: 'bond_futures'
      doc: 'Bond Futures'
    29:
      id: 'interest_rate_futures'
      doc: 'Interest Rate Futures'
    30:
      id: 'index_options'
      doc: 'Index Options'
    31:
      id: 'stock_options'
      doc: 'Stock Options'
    32:
      id: 'option_warrants'
      doc: 'Option warrants'
    33:
      id: 'factor_certificates'
      doc: 'Factor certificates'
    34:
      id: 'turbo_certificates'
      doc: 'Turbo certificates'
    35:
      id: 'capital_protection_certificates'
      doc: 'Capital protection certificates'
    36:
      id: 'bonus_certificates'
      doc: 'Bonus certificates'
    37:
      id: 'reverse_convertible_certificates'
      doc: 'Reverse convertible certificates'
    38:
      id: 'express_certificates'
      doc: 'Express certificates'
    39:
      id: 'discount_certificates'
      doc: 'Discount certificates'
    40:
      id: 'index_tracker_certificates'
      doc: 'Index/tracker certificates'
    41:
      id: 'other_investment_certificates'
      doc: 'Other investment certificates (non leveraged)'
    42:
      id: 'structured_notes'
      doc: 'Structured notes'
    43:
      id: 'reference_rate'
      doc: 'Reference rate'
    44:
      id: 'interest_rate'
      doc: 'Interest rate'
    45:
      id: 'exchange_rate'
      doc: 'Exchange rate'
    46:
      id: 'price_index'
      doc: 'Price index'
    47:
      id: 'total_return_index'
      doc: 'Total return index'
    48:
      id: 'sector_price_index'
      doc: 'Sector price index'
    49:
      id: 'sector_total_return_index'
      doc: 'Sector total return index'
    50:
      id: 'dividend_index'
      doc: 'Dividend index'
    51:
      id: 'strategy_price_index'
      doc: 'Strategy price index'
    52:
      id: 'strategy_total_return_index'
      doc: 'Strategy total return index'
    53:
      id: 'commodity_index'
      doc: 'Commodity index'
    54:
      id: 'bond_total_return_index'
      doc: 'Bond total return index'
    55:
      id: 'supranational_bond'
      doc: 'Supranational Bond'
    56:
      id: 'warrant_with_knock_out'
      doc: 'Warrant with Knock Out'
  currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  price_expression_type:
    3:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'price'
      doc: 'Price expressed as absolute value'
    2:
      id: 'percentage'
      doc: 'Price expressed as percentage'
  nominal_value_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'constant'
      doc: 'Indicates that the security has a constant nominal value'
  strike_price_currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  bond_coupon_type:
    1:
      id: 'not_applicable'
      doc: 'NotApplicable'
    2:
      id: 'zero'
      doc: 'Zero coupon'
    3:
      id: 'fixed_field'
      doc: 'Fixed coupon'
    4:
      id: 'floating'
      doc: 'Floating coupon'
    5:
      id: 'indexed'
      doc: 'Indexed coupon'
  issuer_reg_country:
    4:
      id: 'afg'
      doc: 'Afghanistan'
    8:
      id: 'alb'
      doc: 'Albania'
    10:
      id: 'ata'
      doc: 'Antarctica'
    12:
      id: 'dza'
      doc: 'Algeria'
    16:
      id: 'asm_field'
      doc: 'American Samoa'
    20:
      id: 'and_field'
      doc: 'Andorra'
    24:
      id: 'ago'
      doc: 'Angola'
    28:
      id: 'atg'
      doc: 'Antigua and Barbuda'
    31:
      id: 'aze'
      doc: 'Azerbaijan'
    32:
      id: 'arg'
      doc: 'Argentina'
    36:
      id: 'aus'
      doc: 'Australia'
    40:
      id: 'aut'
      doc: 'Austria'
    44:
      id: 'bhs'
      doc: 'Bahamas'
    48:
      id: 'bhr'
      doc: 'Bahrain'
    50:
      id: 'bgd'
      doc: 'Bangladesh'
    51:
      id: 'arm'
      doc: 'Armenia'
    52:
      id: 'brb'
      doc: 'Barbados'
    56:
      id: 'bel'
      doc: 'Belgium'
    60:
      id: 'bmu'
      doc: 'Bermuda'
    64:
      id: 'btn'
      doc: 'Bhutan'
    68:
      id: 'bol'
      doc: 'Bolivia'
    70:
      id: 'bih'
      doc: 'Bosnia and Herzegovina'
    72:
      id: 'bwa'
      doc: 'Botswana'
    74:
      id: 'bvt'
      doc: 'Bouvet Island'
    76:
      id: 'bra'
      doc: 'Brazil'
    84:
      id: 'blz'
      doc: 'Belize'
    86:
      id: 'iot'
      doc: 'British Indian Ocean Territory'
    90:
      id: 'slb'
      doc: 'Solomon Islands'
    92:
      id: 'vgb'
      doc: 'Virgin Islands (British)'
    96:
      id: 'brn'
      doc: 'Brunei Darussalam'
    100:
      id: 'bgr'
      doc: 'Bulgaria'
    104:
      id: 'mmr'
      doc: 'Myanmar'
    108:
      id: 'bdi'
      doc: 'Burundi'
    112:
      id: 'blr'
      doc: 'Belarus'
    116:
      id: 'khm'
      doc: 'Cambodia'
    120:
      id: 'cmr'
      doc: 'Cameroon'
    124:
      id: 'can'
      doc: 'Canada'
    132:
      id: 'cpv'
      doc: 'Cabo Verde'
    136:
      id: 'cym'
      doc: 'Cayman Islands'
    140:
      id: 'caf'
      doc: 'Central African Republic'
    144:
      id: 'lka'
      doc: 'Sri Lanka'
    148:
      id: 'tcd'
      doc: 'Chad'
    152:
      id: 'chl'
      doc: 'Chile'
    156:
      id: 'chn'
      doc: 'China'
    158:
      id: 'twn'
      doc: 'Taiwan'
    162:
      id: 'cxr'
      doc: 'Christmas Island'
    166:
      id: 'cck'
      doc: 'Cocos (Keeling) Islands'
    170:
      id: 'col'
      doc: 'Colombia'
    174:
      id: 'com'
      doc: 'Comoros'
    175:
      id: 'myt'
      doc: 'Mayotte'
    178:
      id: 'cog'
      doc: 'Congo'
    180:
      id: 'cod'
      doc: 'Democratic Republic of the Congo'
    184:
      id: 'cok'
      doc: 'Cook Islands'
    188:
      id: 'cri'
      doc: 'Costa Rica'
    191:
      id: 'hrv'
      doc: 'Croatia'
    192:
      id: 'cub'
      doc: 'Cuba'
    196:
      id: 'cyp'
      doc: 'Cyprus'
    203:
      id: 'cze'
      doc: 'Czechia'
    204:
      id: 'ben'
      doc: 'Benin'
    208:
      id: 'dnk'
      doc: 'Denmark'
    212:
      id: 'dma'
      doc: 'Dominica'
    214:
      id: 'dom'
      doc: 'Dominican Republic'
    218:
      id: 'ecu'
      doc: 'Ecuador'
    222:
      id: 'slv'
      doc: 'El Salvador'
    226:
      id: 'gnq'
      doc: 'Equatorial Guinea'
    231:
      id: 'eth'
      doc: 'Ethiopia'
    232:
      id: 'eri'
      doc: 'Eritrea'
    233:
      id: 'est'
      doc: 'Estonia'
    234:
      id: 'fro'
      doc: 'Faroe Islands'
    238:
      id: 'flk'
      doc: 'Falkland Islands (Malvinas)'
    239:
      id: 'sgs'
      doc: 'South Georgia and the South Sandwich Islands'
    242:
      id: 'fji'
      doc: 'Fiji'
    246:
      id: 'fin'
      doc: 'Finland'
    248:
      id: 'ala'
      doc: 'AlandIslands'
    250:
      id: 'fra'
      doc: 'France'
    254:
      id: 'guf'
      doc: 'French Guiana'
    258:
      id: 'pyf'
      doc: 'French Polynesia'
    260:
      id: 'atf'
      doc: 'French Southern Territories'
    262:
      id: 'dji'
      doc: 'Djibouti'
    266:
      id: 'gab'
      doc: 'Gabon'
    268:
      id: 'geo'
      doc: 'Georgia'
    270:
      id: 'gmb'
      doc: 'Gambia'
    275:
      id: 'pse'
      doc: 'Palestine'
    276:
      id: 'deu'
      doc: 'Germany'
    288:
      id: 'gha'
      doc: 'Ghana'
    292:
      id: 'gib'
      doc: 'Gibraltar'
    296:
      id: 'kir'
      doc: 'Kiribati'
    300:
      id: 'grc'
      doc: 'Greece'
    304:
      id: 'grl'
      doc: 'Greenland'
    308:
      id: 'grd'
      doc: 'Grenada'
    312:
      id: 'glp'
      doc: 'Guadeloupe'
    316:
      id: 'gum'
      doc: 'Guam'
    320:
      id: 'gtm'
      doc: 'Guatemala'
    324:
      id: 'gin'
      doc: 'Guinea'
    328:
      id: 'guy'
      doc: 'Guyana'
    332:
      id: 'hti'
      doc: 'Haiti'
    334:
      id: 'hmd'
      doc: 'Heard Island and McDonald Islands'
    336:
      id: 'vat'
      doc: 'Holy See'
    340:
      id: 'hnd'
      doc: 'Honduras'
    344:
      id: 'hkg'
      doc: 'Hong Kong'
    348:
      id: 'hun'
      doc: 'Hungary'
    352:
      id: 'isl'
      doc: 'Iceland'
    356:
      id: 'ind'
      doc: 'India'
    360:
      id: 'idn'
      doc: 'Indonesia'
    364:
      id: 'irn'
      doc: 'Iran'
    368:
      id: 'irq'
      doc: 'Iraq'
    372:
      id: 'irl'
      doc: 'Ireland'
    376:
      id: 'isr'
      doc: 'Israel'
    380:
      id: 'ita'
      doc: 'Italy'
    384:
      id: 'civ'
      doc: 'Cote d''Ivoire'
    388:
      id: 'jam'
      doc: 'Jamaica'
    392:
      id: 'jpn'
      doc: 'Japan'
    398:
      id: 'kaz'
      doc: 'Kazakhstan'
    400:
      id: 'jor'
      doc: 'Jordan'
    404:
      id: 'ken'
      doc: 'Kenya'
    408:
      id: 'prk'
      doc: 'Democratic People''s Republic of Korea'
    410:
      id: 'kor'
      doc: 'Republic of Korea'
    414:
      id: 'kwt'
      doc: 'Kuwait'
    417:
      id: 'kgz'
      doc: 'Kyrgyzstan'
    418:
      id: 'lao'
      doc: 'Lao People''s Democratic Republic'
    422:
      id: 'lbn'
      doc: 'Lebanon'
    426:
      id: 'lso'
      doc: 'Lesotho'
    428:
      id: 'lva'
      doc: 'Latvia'
    430:
      id: 'lbr'
      doc: 'Liberia'
    434:
      id: 'lby'
      doc: 'Libya'
    438:
      id: 'lie'
      doc: 'Liechtenstein'
    440:
      id: 'ltu'
      doc: 'Lithuania'
    442:
      id: 'lux'
      doc: 'Luxembourg'
    446:
      id: 'mac'
      doc: 'Macao'
    450:
      id: 'mdg'
      doc: 'Madagascar'
    454:
      id: 'mwi'
      doc: 'Malawi'
    458:
      id: 'mys'
      doc: 'Malaysia'
    462:
      id: 'mdv'
      doc: 'Maldives'
    466:
      id: 'mli'
      doc: 'Mali'
    470:
      id: 'mlt'
      doc: 'Malta'
    474:
      id: 'mtq'
      doc: 'Martinique'
    478:
      id: 'mrt'
      doc: 'Mauritania'
    480:
      id: 'mus'
      doc: 'Mauritius'
    484:
      id: 'mex'
      doc: 'Mexico'
    492:
      id: 'mco'
      doc: 'Monaco'
    496:
      id: 'mng'
      doc: 'Mongolia'
    498:
      id: 'mda'
      doc: 'Republic of Moldova'
    499:
      id: 'mne'
      doc: 'Montenegro'
    500:
      id: 'msr'
      doc: 'Montserrat'
    504:
      id: 'mar'
      doc: 'Morocco'
    508:
      id: 'moz'
      doc: 'Mozambique'
    512:
      id: 'omn'
      doc: 'Oman'
    516:
      id: 'nam'
      doc: 'Namibia'
    520:
      id: 'nru'
      doc: 'Nauru'
    524:
      id: 'npl'
      doc: 'Nepal'
    528:
      id: 'nld'
      doc: 'Netherlands (the)'
    531:
      id: 'cuw'
      doc: 'Curacao'
    533:
      id: 'abw'
      doc: 'Aruba'
    534:
      id: 'sxm'
      doc: 'Sint Maarten (Dutch part)'
    535:
      id: 'bes'
      doc: 'Bonaire, Sint Eustatius and Saba'
    540:
      id: 'ncl'
      doc: 'New Caledonia'
    548:
      id: 'vut'
      doc: 'Vanuatu'
    554:
      id: 'nzl'
      doc: 'New Zealand'
    558:
      id: 'nic'
      doc: 'Nicaragua'
    562:
      id: 'ner'
      doc: 'Niger'
    566:
      id: 'nga'
      doc: 'Nigeria'
    570:
      id: 'niu'
      doc: 'Niue'
    574:
      id: 'nfk'
      doc: 'Norfolk Island'
    578:
      id: 'nor'
      doc: 'Norway'
    580:
      id: 'mnp'
      doc: 'Northern Mariana Islands'
    581:
      id: 'umi'
      doc: 'United States Minor Outlying Islands'
    583:
      id: 'fsm'
      doc: 'Micronesia, Federated States of'
    584:
      id: 'mhl'
      doc: 'Marshall Islands'
    585:
      id: 'plw'
      doc: 'Palau'
    586:
      id: 'pak'
      doc: 'Pakistan'
    591:
      id: 'pan'
      doc: 'Panama'
    598:
      id: 'png'
      doc: 'Papua New Guinea'
    600:
      id: 'pry'
      doc: 'Paraguay'
    604:
      id: 'per'
      doc: 'Peru'
    608:
      id: 'phl'
      doc: 'Philippines'
    612:
      id: 'pcn'
      doc: 'Pitcairn'
    616:
      id: 'pol'
      doc: 'Poland'
    620:
      id: 'prt'
      doc: 'Portugal'
    624:
      id: 'gnb'
      doc: 'Guinea-Bissau'
    626:
      id: 'tls'
      doc: 'Timor-Leste'
    630:
      id: 'pri'
      doc: 'Puerto Rico'
    634:
      id: 'qat'
      doc: 'Qatar'
    638:
      id: 'reu'
      doc: 'Réunion'
    642:
      id: 'rou'
      doc: 'Romania'
    643:
      id: 'rus'
      doc: 'Russian Federation'
    646:
      id: 'rwa'
      doc: 'Rwanda'
    652:
      id: 'blm'
      doc: 'Saint Barthélemy'
    654:
      id: 'shn'
      doc: 'Saint Helena, Ascension and Tristan da Cunha'
    659:
      id: 'kna'
      doc: 'Saint Kitts and Nevis'
    660:
      id: 'aia'
      doc: 'Anguilla'
    662:
      id: 'lca'
      doc: 'Saint Lucia'
    663:
      id: 'maf'
      doc: 'Saint Martin (French part)'
    666:
      id: 'spm'
      doc: 'Saint Pierre and Miquelon'
    670:
      id: 'vct'
      doc: 'Saint Vincent and the Grenadines'
    674:
      id: 'smr'
      doc: 'San Marino'
    678:
      id: 'stp'
      doc: 'Sao Tome and Principe'
    682:
      id: 'sau'
      doc: 'Saudi Arabia'
    686:
      id: 'sen'
      doc: 'Senegal'
    688:
      id: 'srb'
      doc: 'Serbia'
    690:
      id: 'syc'
      doc: 'Seychelles'
    694:
      id: 'sle'
      doc: 'Sierra Leone'
    702:
      id: 'sgp'
      doc: 'Singapore'
    703:
      id: 'svk'
      doc: 'Slovakia'
    704:
      id: 'vnm'
      doc: 'Viet Nam'
    705:
      id: 'svn'
      doc: 'Slovenia'
    706:
      id: 'som'
      doc: 'Somalia'
    710:
      id: 'zaf'
      doc: 'South Africa'
    716:
      id: 'zwe'
      doc: 'Zimbabwe'
    724:
      id: 'esp'
      doc: 'Spain'
    728:
      id: 'ssd'
      doc: 'South Sudan'
    729:
      id: 'sdn'
      doc: 'Sudan'
    732:
      id: 'esh'
      doc: 'Western Sahara'
    740:
      id: 'sur'
      doc: 'Suriname'
    744:
      id: 'sjm'
      doc: 'Svalbard and Jan Mayen'
    748:
      id: 'swz'
      doc: 'Eswatini'
    752:
      id: 'swe'
      doc: 'Sweden'
    756:
      id: 'che'
      doc: 'Switzerland'
    760:
      id: 'syr'
      doc: 'Syrian Arab Republic'
    762:
      id: 'tjk'
      doc: 'Tajikistan'
    764:
      id: 'tha'
      doc: 'Thailand'
    768:
      id: 'tgo'
      doc: 'Togo'
    772:
      id: 'tkl'
      doc: 'Tokelau'
    776:
      id: 'ton'
      doc: 'Tonga'
    780:
      id: 'tto'
      doc: 'Trinidad and Tobago'
    784:
      id: 'are'
      doc: 'United Arab Emirates'
    788:
      id: 'tun'
      doc: 'Tunisia'
    792:
      id: 'tur'
      doc: 'Türkiye'
    795:
      id: 'tkm'
      doc: 'Turkmenistan'
    796:
      id: 'tca'
      doc: 'Turks and Caicos Islands'
    798:
      id: 'tuv'
      doc: 'Tuvalu'
    800:
      id: 'uga'
      doc: 'Uganda'
    804:
      id: 'ukr'
      doc: 'Ukraine'
    807:
      id: 'mkd'
      doc: 'North Macedonia'
    818:
      id: 'egy'
      doc: 'Egypt'
    826:
      id: 'gbr'
      doc: 'United Kingdom of Great Britain and Northern Ireland (the)'
    831:
      id: 'ggy'
      doc: 'Guernsey'
    832:
      id: 'jey'
      doc: 'Jersey'
    833:
      id: 'imn'
      doc: 'Isle of Man'
    834:
      id: 'tza'
      doc: 'Tanzania, United Republic of'
    840:
      id: 'usa'
      doc: 'United States of America (the)'
    850:
      id: 'vir'
      doc: 'Virgin Islands (U.S.)'
    854:
      id: 'bfa'
      doc: 'Burkina Faso'
    858:
      id: 'ury'
      doc: 'Uruguay'
    860:
      id: 'uzb'
      doc: 'Uzbekistan'
    862:
      id: 'ven'
      doc: 'Venezuela'
    876:
      id: 'wlf'
      doc: 'Wallis and Futuna'
    882:
      id: 'wsm'
      doc: 'Samoa'
    887:
      id: 'yem'
      doc: 'Yemen'
    894:
      id: 'zmb'
      doc: 'Zambia'
  us_indicator:
    1:
      id: 'not_applicable'
      doc: 'No trading restrictions'
    2:
      id: 'regulation_s'
      doc: 'Trading restricted due to US Regulation S'
    3:
      id: 'regulation_s_plus_rule_144a'
      doc: 'Trading restricted due to US Regulation S with Rule 144A'
  settlement_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'cash_settlement'
      doc: 'Derivatives are settled in cash'
    3:
      id: 'physical_delivery'
      doc: 'Derivatives are settled as physical delivery of the underlying'
  option_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'call'
      doc: 'Call option'
    3:
      id: 'put'
      doc: 'Put option'
  exercise_type:
    1:
      id: 'amer'
      doc: 'AMER'
    2:
      id: 'euro'
      doc: 'EURO'
    3:
      id: 'na'
      doc: 'Not applicable'
  status:
    1:
      id: 'active'
      doc: 'Financial instrument is active'
    2:
      id: 'inactive'
      doc: 'Financial instrument is inactive and is not trading'
    3:
      id: 'market_operations_suspension'
      doc: 'Manual suspension by Market Operations'
    4:
      id: 'outside_collars_static'
      doc: 'Outside static trade price collars'
    5:
      id: 'outside_collars_dynamic'
      doc: 'Outside dynamic trade price collars'
    6:
      id: 'regulatory_suspension'
      doc: 'Regulatory suspension'
    8:
      id: 'hybrid_no_quotes'
      doc: 'Hybrid no valid quotes'
    9:
      id: 'hybrid_knockout'
      doc: 'Hybrid knockout'
    10:
      id: 'hybrid_knockout_by_issuer'
      doc: 'Hybrid knockout by issuer'
  is_leverage:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'yes_field'
      doc: 'Leveraged'
    3:
      id: 'no_field'
      doc: 'Not leveraged'
  index_publication_schedule:
    1:
      id: 'continuous'
      doc: 'Index is quoted in determined time intervals'
    2:
      id: 'fixing'
      doc: 'Index is quoted on determined hours'
    3:
      id: 'closing'
      doc: 'Index is quoted on closing'
  index_type:
    1:
      id: 'w'
      doc: 'WSE index from the main or alternative markets'
    2:
      id: 'z'
      doc: 'External index'
    3:
      id: 'v'
      doc: 'Another WSE information product'
    4:
      id: 'm'
      doc: 'WSE strategy dividend point index'
    5:
      id: 's'
      doc: 'WSE strategy index of short type'
    6:
      id: 'l'
      doc: 'WSE strategy index of leverage type'
  index_underlying_type:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'index'
      doc: 'Index'
    3:
      id: 'reference_rate'
      doc: 'Reference Rate'
  auction_type:
    1:
      id: 'not_applicable'
      doc: 'NotApplicable'
    2:
      id: 'auction_opening'
      doc: 'Opening auction'
    3:
      id: 'auction_closing'
      doc: 'Closing auction'
    4:
      id: 'auction_intraday'
      doc: 'Intraday auction'
    5:
      id: 'auction_volatility_static'
      doc: 'Volatility auction after static collars breach'
    6:
      id: 'auction_volatility_dynamic'
      doc: 'Volatility auction after dynamic collars breach'
    7:
      id: 'auction_extended_volatility_static'
      doc: 'Additional volatility auction after static collar breach'
    8:
      id: 'auction_extended_volatility_dynamic'
      doc: 'Additional volatility auction after dynamic collar breach'
    9:
      id: 'unsuspension_auction'
      doc: 'A phase triggered whenever an instrument’s changes its status from RegulatorySuspension or MarketOperationSuspension before entering into continuous phase'
  side:
    1:
      id: 'buy'
      doc: 'Buy order'
    2:
      id: 'sell'
      doc: 'Sell order'
  price_currency:
    8:
      id: 'all'
      doc: 'Lek'
    12:
      id: 'dzd'
      doc: 'Algerian Dinar'
    32:
      id: 'ars'
      doc: 'Argentine Peso'
    36:
      id: 'aud'
      doc: 'Australian Dollar'
    44:
      id: 'bsd'
      doc: 'Bahamian Dollar'
    48:
      id: 'bhd'
      doc: 'Bahraini Dinar'
    50:
      id: 'bdt'
      doc: 'Taka'
    51:
      id: 'amd'
      doc: 'Armenian Dram'
    52:
      id: 'bbd'
      doc: 'Barbados Dollar'
    60:
      id: 'bmd'
      doc: 'Bermudian Dollar'
    64:
      id: 'btn'
      doc: 'Ngultrum'
    68:
      id: 'bob'
      doc: 'Boliviano'
    72:
      id: 'bwp'
      doc: 'Pula'
    84:
      id: 'bzd'
      doc: 'Belize Dollar'
    90:
      id: 'sbd'
      doc: 'Solomon Islands Dollar'
    96:
      id: 'bnd'
      doc: 'Brunei Dollar'
    104:
      id: 'mmk'
      doc: 'Kyat'
    108:
      id: 'bif'
      doc: 'Burundi Franc'
    116:
      id: 'khr'
      doc: 'Riel'
    124:
      id: 'cad'
      doc: 'Canadian Dollar'
    132:
      id: 'cve'
      doc: 'Cabo Verde Escudo'
    136:
      id: 'kyd'
      doc: 'Cayman Islands Dollar'
    144:
      id: 'lkr'
      doc: 'Sri Lanka Rupee'
    152:
      id: 'clp'
      doc: 'Chilean Peso'
    156:
      id: 'cny'
      doc: 'Yuan Renminbi'
    170:
      id: 'cop'
      doc: 'Colombian Peso'
    174:
      id: 'kmf'
      doc: 'Comorian Franc'
    188:
      id: 'crc'
      doc: 'Costa Rican Colon'
    191:
      id: 'hrk'
      doc: 'Kuna'
    192:
      id: 'cup'
      doc: 'Cuban Peso'
    203:
      id: 'czk'
      doc: 'Czech Koruna'
    208:
      id: 'dkk'
      doc: 'Danish Krone'
    214:
      id: 'dop'
      doc: 'Dominican Peso'
    222:
      id: 'svc'
      doc: 'El Salvador Colon'
    230:
      id: 'etb'
      doc: 'Ethiopian Birr'
    232:
      id: 'ern'
      doc: 'Nakfa'
    238:
      id: 'fkp'
      doc: 'Falkland Islands Pound'
    242:
      id: 'fjd'
      doc: 'Fiji Dollar'
    262:
      id: 'djf'
      doc: 'Djibouti Franc'
    270:
      id: 'gmd'
      doc: 'Dalasi'
    292:
      id: 'gip'
      doc: 'Gibraltar Pound'
    320:
      id: 'gtq'
      doc: 'Quetzal'
    324:
      id: 'gnf'
      doc: 'Guinean Franc'
    328:
      id: 'gyd'
      doc: 'Guyana Dollar'
    332:
      id: 'htg'
      doc: 'Gourde'
    340:
      id: 'hnl'
      doc: 'Lempira'
    344:
      id: 'hkd'
      doc: 'Hong Kong Dollar'
    348:
      id: 'huf'
      doc: 'Forint'
    352:
      id: 'isk'
      doc: 'Iceland Krona'
    356:
      id: 'inr'
      doc: 'Indian Rupee'
    360:
      id: 'idr'
      doc: 'Rupiah'
    364:
      id: 'irr'
      doc: 'Iranian Rial'
    368:
      id: 'iqd'
      doc: 'Iraqi Dinar'
    376:
      id: 'ils'
      doc: 'New Israeli Sheqel'
    388:
      id: 'jmd'
      doc: 'Jamaican Dollar'
    392:
      id: 'jpy'
      doc: 'Yen'
    398:
      id: 'kzt'
      doc: 'Tenge'
    400:
      id: 'jod'
      doc: 'Jordanian Dinar'
    404:
      id: 'kes'
      doc: 'Kenyan Shilling'
    408:
      id: 'kpw'
      doc: 'North Korean Won'
    410:
      id: 'krw'
      doc: 'Won'
    414:
      id: 'kwd'
      doc: 'Kuwaiti Dinar'
    417:
      id: 'kgs'
      doc: 'Som'
    418:
      id: 'lak'
      doc: 'Lao Kip'
    422:
      id: 'lbp'
      doc: 'Lebanese Pound'
    426:
      id: 'lsl'
      doc: 'Loti'
    430:
      id: 'lrd'
      doc: 'Liberian Dollar'
    434:
      id: 'lyd'
      doc: 'Libyan Dinar'
    446:
      id: 'mop'
      doc: 'Pataca'
    454:
      id: 'mwk'
      doc: 'Malawi Kwacha'
    458:
      id: 'myr'
      doc: 'Malaysian Ringgit'
    462:
      id: 'mvr'
      doc: 'Rufiyaa'
    480:
      id: 'mur'
      doc: 'Mauritius Rupee'
    484:
      id: 'mxn'
      doc: 'Mexican Peso'
    496:
      id: 'mnt'
      doc: 'Tugrik'
    498:
      id: 'mdl'
      doc: 'Moldovan Leu'
    504:
      id: 'mad'
      doc: 'Moroccan Dirham'
    512:
      id: 'omr'
      doc: 'Rial Omani'
    516:
      id: 'nad'
      doc: 'Namibia Dollar'
    524:
      id: 'npr'
      doc: 'Nepalese Rupee'
    532:
      id: 'ang'
      doc: 'Netherlands Antillean Guilder'
    533:
      id: 'awg'
      doc: 'Aruban Florin'
    548:
      id: 'vuv'
      doc: 'Vatu'
    554:
      id: 'nzd'
      doc: 'New Zealand Dollar'
    558:
      id: 'nio'
      doc: 'Cordoba Oro'
    566:
      id: 'ngn'
      doc: 'Naira'
    578:
      id: 'nok'
      doc: 'Norwegian Krone'
    586:
      id: 'pkr'
      doc: 'Pakistan Rupee'
    590:
      id: 'pab'
      doc: 'Balboa'
    598:
      id: 'pgk'
      doc: 'Kina'
    600:
      id: 'pyg'
      doc: 'Guarani'
    604:
      id: 'pen'
      doc: 'Sol'
    608:
      id: 'php'
      doc: 'Philippine Peso'
    634:
      id: 'qar'
      doc: 'Qatari Rial'
    643:
      id: 'rub'
      doc: 'Russian Ruble'
    646:
      id: 'rwf'
      doc: 'Rwanda Franc'
    654:
      id: 'shp'
      doc: 'Saint Helena Pound'
    682:
      id: 'sar'
      doc: 'Saudi Riyal'
    690:
      id: 'scr'
      doc: 'Seychelles Rupee'
    702:
      id: 'sgd'
      doc: 'Singapore Dollar'
    704:
      id: 'vnd'
      doc: 'Dong'
    706:
      id: 'sos'
      doc: 'Somali Shilling'
    710:
      id: 'zar'
      doc: 'Rand'
    728:
      id: 'ssp'
      doc: 'South Sudanese Pound'
    748:
      id: 'szl'
      doc: 'Lilangeni'
    752:
      id: 'sek'
      doc: 'Swedish Krona'
    756:
      id: 'chf'
      doc: 'Swiss Franc'
    760:
      id: 'syp'
      doc: 'Syrian Pound'
    764:
      id: 'thb'
      doc: 'Baht'
    776:
      id: 'top'
      doc: 'Pa’anga'
    780:
      id: 'ttd'
      doc: 'Trinidad and Tobago Dollar'
    784:
      id: 'aed'
      doc: 'UAE Dirham'
    788:
      id: 'tnd'
      doc: 'Tunisian Dinar'
    800:
      id: 'ugx'
      doc: 'Uganda Shilling'
    807:
      id: 'mkd'
      doc: 'Denar'
    818:
      id: 'egp'
      doc: 'Egyptian Pound'
    826:
      id: 'gbp'
      doc: 'Pound Sterling'
    834:
      id: 'tzs'
      doc: 'Tanzanian Shilling'
    840:
      id: 'usd'
      doc: 'US Dollar'
    858:
      id: 'uyu'
      doc: 'Peso Uruguayo'
    860:
      id: 'uzs'
      doc: 'Uzbekistan Sum'
    882:
      id: 'wst'
      doc: 'Tala'
    886:
      id: 'yer'
      doc: 'Yemeni Rial'
    901:
      id: 'twd'
      doc: 'New Taiwan Dollar'
    925:
      id: 'sle'
      doc: 'Leone'
    926:
      id: 'ved'
      doc: 'Bolívar Soberano'
    927:
      id: 'uyw'
      doc: 'Unidad Previsional'
    928:
      id: 'ves'
      doc: 'Bolívar Soberano'
    929:
      id: 'mru'
      doc: 'Ouguiya'
    930:
      id: 'stn'
      doc: 'Dobra'
    931:
      id: 'cuc'
      doc: 'Peso Convertible'
    932:
      id: 'zwl'
      doc: 'Zimbabwe Dollar'
    933:
      id: 'byn'
      doc: 'Belarusian Ruble'
    934:
      id: 'tmt'
      doc: 'Turkmenistan New Manat'
    936:
      id: 'ghs'
      doc: 'Ghana Cedi'
    938:
      id: 'sdg'
      doc: 'Sudanese Pound'
    940:
      id: 'uyi'
      doc: 'Uruguay Peso en Unidades Indexadas (URUIURUI)'
    941:
      id: 'rsd'
      doc: 'Serbian Dinar'
    943:
      id: 'mzn'
      doc: 'Mozambique Metical'
    944:
      id: 'azn'
      doc: 'Azerbaijan Manat'
    946:
      id: 'ron'
      doc: 'Romanian Leu'
    947:
      id: 'che'
      doc: 'WIR Euro'
    948:
      id: 'chw'
      doc: 'WIR Franc'
    949:
      id: 'try_field'
      doc: 'Turkish Lira'
    950:
      id: 'xaf'
      doc: 'CFA Franc BEAC'
    951:
      id: 'xcd'
      doc: 'East Caribbean Dollar'
    952:
      id: 'xof'
      doc: 'CFA Franc BCEAO'
    953:
      id: 'xpf'
      doc: 'CFP Franc'
    955:
      id: 'xba'
      doc: 'Bond Markets Unit European Composite Unit (EURCO)'
    956:
      id: 'xbb'
      doc: 'Bond Markets Unit European Monetary Unit (E.M.U.-6)'
    957:
      id: 'xbc'
      doc: 'Bond Markets Unit European Unit of Account 9 (E.U.A.-9)'
    958:
      id: 'xbd'
      doc: 'Bond Markets Unit European Unit of Account 17 (E.U.A.-17)'
    959:
      id: 'xau'
      doc: 'Gold'
    960:
      id: 'xdr'
      doc: 'SDR (Special Drawing Right)'
    961:
      id: 'xag'
      doc: 'Silver'
    962:
      id: 'xpt'
      doc: 'Platinum'
    963:
      id: 'xts'
      doc: 'Codes specifically reserved for testing purposes'
    964:
      id: 'xpd'
      doc: 'Palladium'
    965:
      id: 'xua'
      doc: 'ADB Unit of Account'
    967:
      id: 'zmw'
      doc: 'Zambian Kwacha'
    968:
      id: 'srd'
      doc: 'Surinam Dollar'
    969:
      id: 'mga'
      doc: 'Malagasy Ariary'
    970:
      id: 'cou'
      doc: 'Unidad de Valor Real'
    971:
      id: 'afn'
      doc: 'Afghani'
    972:
      id: 'tjs'
      doc: 'Somoni'
    973:
      id: 'aoa'
      doc: 'Kwanza'
    975:
      id: 'bgn'
      doc: 'Bulgarian Lev'
    976:
      id: 'cdf'
      doc: 'Congolese Franc'
    977:
      id: 'bam'
      doc: 'Convertible Mark'
    978:
      id: 'eur'
      doc: 'Euro'
    979:
      id: 'mxv'
      doc: 'Unidad de inversion (UDI)'
    980:
      id: 'uah'
      doc: 'Hryvnia'
    981:
      id: 'gel'
      doc: 'Lari'
    984:
      id: 'bov'
      doc: 'Mvdol'
    985:
      id: 'pln'
      doc: 'Zloty'
    986:
      id: 'brl'
      doc: 'Brazilian Real'
    990:
      id: 'clf'
      doc: 'Unidad de Fomento'
    994:
      id: 'xsu'
      doc: 'Sucre'
    997:
      id: 'usn'
      doc: 'US Dollar (next day)'
    999:
      id: 'xxx'
      doc: 'The codes assigned for transactions where no currency is involved'
  price_notation:
    3:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'price'
      doc: 'Price expressed as absolute value'
    2:
      id: 'percentage'
      doc: 'Price expressed as percentage'
  mmt_market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: '1 = Central Limit Order Book'
    2:
      id: 'quote_driven_market'
      doc: '2 = Quote Driven Market'
    3:
      id: 'dark_order_book'
      doc: '3 = Dark Order Book'
    4:
      id: 'off_book'
      doc: '4 = Off Book'
    5:
      id: 'periodic_auction'
      doc: '5 = Periodic Auction'
    6:
      id: 'request_for_quotes'
      doc: '6 = Request For Quotes'
    7:
      id: 'other'
      doc: '7 = Any other including Hybrid'
  mmt_trading_mode:
    1:
      id: 'undefined_auction'
      doc: '1 = Undefined Auction'
    2:
      id: 'scheduled_opening_auction'
      doc: 'O = Scheduled Opening Auction'
    3:
      id: 'scheduled_closing_auction'
      doc: 'K = Scheduled Closing Auction'
    4:
      id: 'scheduled_intraday_auction'
      doc: 'I = Scheduled Intraday Auction'
    5:
      id: 'unscheduled_auction'
      doc: 'U = Unscheduled Auction'
    6:
      id: 'continuous_trading'
      doc: '2 = Continuous Trading'
    7:
      id: 'at_market_close_trading'
      doc: '3 = At Market Close Trading'
    8:
      id: 'out_of_main_session_trading'
      doc: '4 = Out Of Main Session Trading'
    9:
      id: 'trade_reporting_on_exchange'
      doc: '5 = Trade Reporting (On Exchange)'
    10:
      id: 'trade_reporting_off_exchange'
      doc: '6 = Trade Reporting (Off Exchange)'
    11:
      id: 'trade_reporting_systematic_internaliser'
      doc: '7 = Trade Reporting (Systematic Internaliser)'
  mmt_transaction_category:
    1:
      id: 'dark_trade'
      doc: 'D = Dark Trade'
    2:
      id: 'trade_price_improvement'
      doc: 'R = Trade that has received price improvement'
    3:
      id: 'package_trade'
      doc: 'Z = Package Trade (excluding Exchange For Physicals)'
    4:
      id: 'exchange_for_physicals_trade'
      doc: 'Y = Exchange For Physicals Trade'
    5:
      id: 'none'
      doc: '- = None apply (a standard trade for the Market Mechanism and Trading Mode)'
  mmt_negotiation_indicator:
    1:
      id: 'negotiated_trade'
      doc: 'N = Negotiated Trade'
    2:
      id: 'negotiated_trade_liquid_financial_instruments'
      doc: '1 = Negotiated Trade in Liquid Financial Instruments'
    3:
      id: 'negotiated_trade_illiquid_financial_instruments'
      doc: '2 = Negotiated Trade in Illiquid Financial Instruments'
    4:
      id: 'negotiated_trade_other'
      doc: '3 = Negotiated Trade subject to conditions other than the current market price'
    5:
      id: 'no_negotiated_trade'
      doc: '- = No Negotiated Trade'
    6:
      id: 'pre_trade_transparency_waiver_illiquid_instrument'
      doc: '4 = Pre-Trade Transparency Waiver for Illiquid Instrument on an SI (for RTS 1 only)'
    7:
      id: 'pre_trade_transparency_waiver_standard_market_size'
      doc: '5 = Pre-Trade Transparency Waiver for above Standard Market Size on an SI (for RTS 1 only)'
    8:
      id: 'pre_trade_transparency_waivers_ilqd_and_size'
      doc: '6 = Pre-Trade Transparency Waivers of ILQD and SIZE (for RTS 1 only)'
  mmt_agency_cross_trade_indicator:
    1:
      id: 'agency_cross_trade'
      doc: 'X = Agency Cross Trade'
    2:
      id: 'no_agency_cross_trade'
      doc: '- = No Agency Cross Trade'
  mmt_modification_indicator:
    1:
      id: 'trade_cancellation'
      doc: 'C = Trade Cancellation'
    2:
      id: 'trade_amendment'
      doc: 'A = Trade Amendment'
    3:
      id: 'new_trade'
      doc: '- = New Trade'
  mmt_benchmark_reference_price_indicator:
    1:
      id: 'benchmark_trade'
      doc: 'B = Benchmark Trade'
    2:
      id: 'reference_price_trade'
      doc: 'S = Reference Price Trade'
    3:
      id: 'no_benchmarkor_reference_price_trade'
      doc: '- = No Benchmark or Reference Price Trade'
  mmt_special_dividend_indicator:
    1:
      id: 'special_dividend_trade'
      doc: 'E = Special Dividend Trade'
    2:
      id: 'no_special_dividend_trade'
      doc: '- = No Special Dividend Trade'
  mmt_off_book_automated_indicator:
    1:
      id: 'unspecified_or_not_apply'
      doc: '''- = Unspecified or does not apply'
    2:
      id: 'off_book_non_automated'
      doc: 'M = Off Book Non-Automated'
    3:
      id: 'off_book_automated'
      doc: 'Q = Off Book Automated'
  mmt_ordinary_trade_indicator:
    1:
      id: 'plain_vanilla_trade'
      doc: 'P = Plain-Vanilla Trade'
    2:
      id: 'non_price_forming_trade'
      doc: 'T = Non-Price Forming Trade (formerly defined as a Technical Trade)'
    3:
      id: 'trade_not_contributing_to_price_discovery'
      doc: 'J = Trade not contributing to the price discovery process (formerly defined as a Technical Trade)'
    4:
      id: 'price_pending'
      doc: 'N = Price is currently not available but pending'
  mmt_algorithmic_indicator:
    1:
      id: 'algorithmic_trade'
      doc: 'H = Algorithmic Trade'
    2:
      id: 'no_algorithmic_trade'
      doc: '- = No Algorithmic Trade'
  mmt_post_trade_deferral_reason:
    1:
      id: 'immediate_publication'
      doc: '- = Immediate Publication'
    2:
      id: 'non_immediate_publication'
      doc: '1 = Non-Immediate Publication'
    3:
      id: 'non_immediate_publication_large_in_scale'
      doc: '2 = Non-Immediate Publication : Deferral for ''Large in Scale'''
    4:
      id: 'non_immediate_publication_illiquid_instrument'
      doc: '3 = Non-Immediate Publication : Deferral for ''Illiquid Instrument'' (for RTS 2 only)'
    5:
      id: 'non_immediate_publication_size_specific'
      doc: '4 = Non-Immediate Publication : Deferral for ''Size Specific'' (for RTS 2 only)'
    6:
      id: 'non_immediate_publication_ilqd_and_size'
      doc: '5 = Non-Immediate Publication : Deferrals of ILQD and SIZE (for RTS 2 use only)'
    7:
      id: 'non_immediate_publication_ilqd_and_lrgs'
      doc: '6 = Non-Immediate Publication : Deferrals of ILQD and LRGS (for RTS 2 use only)'
  mmt_post_trade_deferral_type:
    1:
      id: 'limited_details_trade'
      doc: '1 = Limited Details Trade'
    2:
      id: 'daily_aggregated_trade'
      doc: '2 = Daily Aggregated Trade'
    3:
      id: 'volume_omission_trade'
      doc: '3 = Volume Omission Trade'
    4:
      id: 'four_weeks_aggregation_trade'
      doc: '4 = Four Weeks Aggregation Trade'
    5:
      id: 'indefinite_aggregation_trade'
      doc: '5 = Indefinite Aggregation Trade'
    6:
      id: 'volume_omission_trade_aggregated'
      doc: '6 = Volume Omission Trade, eligible for subsequent enrichment in aggregated form'
    7:
      id: 'not_applicable'
      doc: '- = Not applicable / No relevant deferral or enrichment type'
  pos_type:
    1:
      id: 'sod'
      doc: 'Start-of-Day Qty'
    2:
      id: 'itd'
      doc: 'Intraday Qty'
    3:
      id: 'fin'
      doc: 'End-of-Day Qty'
  collar_type:
    1:
      id: 'static_field'
      doc: 'Static'
    2:
      id: 'dynamic'
      doc: 'Dynamic'
  closing_price_type:
    1:
      id: 'initial_price'
      doc: 'Initial price of the instrument'
    2:
      id: 'ltp'
      doc: 'Last traded price'
    3:
      id: 'last_acp'
      doc: 'Last adjusted closing price'
    4:
      id: 'fair_value'
      doc: 'Fair value'
    5:
      id: 'daily_settlement_price'
      doc: 'Daily Settlement Price'
    6:
      id: 'final_settlement_price'
      doc: 'Final Settlement Price'
  adjusted_closing_price_reason:
    1:
      id: 'not_applicable'
      doc: 'Not applicable'
    2:
      id: 'dividend'
      doc: 'Dividend'
    3:
      id: 'issue_right'
      doc: 'Issue Right'
    4:
      id: 'split'
      doc: 'Split'
    5:
      id: 'reverse_split'
      doc: 'Reverse Split'
    6:
      id: 'bonus'
      doc: 'Bonus'
    7:
      id: 'spin_off'
      doc: 'Spin-Off'
    8:
      id: 'tick_size_change'
      doc: 'Tick Size Change'
    9:
      id: 'order_purge'
      doc: 'Order Purge'
    10:
      id: 'other_reason'
      doc: 'Other reason'
  marker_price_change:
    1:
      id: 'increase'
      doc: 'Increase'
    2:
      id: 'decrease'
      doc: 'Decrease'
    3:
      id: 'no_change'
      doc: 'No change'
    4:
      id: 'not_applicable'
      doc: 'Not Applicable'
  quotation_system:
    1:
      id: 'na'
      doc: 'Not Applicable'
    2:
      id: 'single_price_single_fixing'
      doc: 'Single price quotation system with a single fixing'
    3:
      id: 'continuous_trading'
      doc: 'Continuous trading'
    4:
      id: 'single_price_two_fixings'
      doc: 'Single price quotation system with two fixings'
  price_update_type:
    1:
      id: 'reference_price'
      doc: 'Reference price placed in the value field'
    2:
      id: 'reference_index_price'
      doc: 'TBSP.Price price placed in the value field'
    3:
      id: 'reference_fixing_index_price'
      doc: 'TBSP.FixPrice price placed in the value field'
    4:
      id: 'mid_price'
      doc: 'MidPrice price placed in the value field'
    5:
      id: 'fixing_price'
      doc: 'The fixing prices placed appropriately in the value field as the average price, valueBid as the bid price, and valueAsk as the ask price'
    6:
      id: 'fixing_ytm'
      doc: 'The fixing YTM (i.e'
  index_level_code:
    1:
      id: 'previous_closing_value'
      doc: 'Closing index value from previous session (reference index)'
    2:
      id: 'theoretical_value_before_opening'
      doc: 'Theoretical opening index before opening the session'
    3:
      id: 'value_before_opening'
      doc: 'Theoretical value of the index before its opening'
    4:
      id: 'opening_value'
      doc: 'Index opening value'
    5:
      id: 'current_value'
      doc: 'Current index value'
    6:
      id: 'pre_closing_value'
      doc: 'Preliminary closing value'
    7:
      id: 'closing_value'
      doc: 'Closing index value'
    8:
      id: 'value_without_opening'
      doc: 'Index value without opening'
  trading_session_event:
    1:
      id: 'na'
      doc: 'Not applicable'
    2:
      id: 'start_of_technical_session'
      doc: 'Start of technical session'
    3:
      id: 'end_of_technical_session'
      doc: 'End of technical session'
    4:
      id: 'initial_reference_data_start'
      doc: 'Initial reference data start'
    5:
      id: 'initial_reference_data_end'
      doc: 'Initial reference data end'
    6:
      id: 'previous_day_restate_start'
      doc: 'Previous day restate start'
    7:
      id: 'previous_day_restate_end'
      doc: 'Previous day restate end'
    8:
      id: 'next_session_reference_data_start'
      doc: 'Next session reference data start'
    9:
      id: 'next_session_reference_data_end'
      doc: 'Next session reference data end'
    12:
      id: 'start_of_trading_session_mic'
      doc: 'Start of trading session MIC'
    13:
      id: 'end_of_trading_session_mic'
      doc: 'End of trading session MIC'
  event_type:
    1:
      id: 'flush'
      doc: 'Flush the test scenario'
    2:
      id: 'scenario_start'
      doc: 'Start of test scenario'
    3:
      id: 'scenario_end'
      doc: 'End of test scenario'
  replay_message_type:
    1:
      id: 'replay_request'
      doc: 'Message replay request'

