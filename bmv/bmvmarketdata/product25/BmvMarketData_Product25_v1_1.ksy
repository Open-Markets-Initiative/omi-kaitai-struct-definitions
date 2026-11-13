# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product25 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 25
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P25_1_ENG.pdf
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
  id: bmv_bmvmarketdata_product25_intra_v1_1
  title: Bmv BmvMarketData Product25 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 25 Intra v1.1'
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
            'message_type::mutual_funds_trades_message': mutual_funds_trades_message
            'message_type::opening_of_continuous_auctions_message': opening_of_continuous_auctions_message
            'message_type::existence_of_bids_at_mid_price_message': existence_of_bids_at_mid_price_message
            'message_type::catalogue_of_debt_and_metals_instruments_message': catalogue_of_debt_and_metals_instruments_message
            'message_type::catalog_sent_for_instruments_belonging_to_mutual_funds_message': catalog_sent_for_instruments_belonging_to_mutual_funds_message
            'message_type::weighted_average_price_message': weighted_average_price_message
            'message_type::system_events_message': system_events_message
            'message_type::reference_price_message': reference_price_message
            'message_type::changes_in_status_message': changes_in_status_message
            'message_type::catalog_for_instruments_belonging_to_the_capital_warrants_market_message': catalog_for_instruments_belonging_to_the_capital_warrants_market_message
            'message_type::catalog_sent_for_instruments_belonging_to_capital_tracs_message': catalog_sent_for_instruments_belonging_to_capital_tracs_message
            'message_type::consolidated_inav_message': consolidated_inav_message
            'message_type::catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message': catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message
            'message_type::probable_price_of_allocation_message': probable_price_of_allocation_message
            'message_type::relation_between_bmvbiva_instruments_message': relation_between_bmvbiva_instruments_message
            'message_type::equities_market_trades_message': equities_market_trades_message
            'message_type::consolidated_trade_cancellation_message': consolidated_trade_cancellation_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying the message'
  mutual_funds_trades_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: date_of_the_trade
        type: millisecond_timestamp
        doc: 'Date when the trade was made. Milliseconds since Unix epoch'
      - id: price
        type: decimal_s8_8
        doc: 'Market price. Implied decimal with scale 1e-8'
      - id: book_value
        type: decimal_s8_8
        doc: 'Book value per share. Implied decimal with scale 1e-8'
      - id: number_of_sales_trades
        type: s4
        doc: 'Number of sales trades'
      - id: sales_volume
        type: s8
        doc: 'Sales volume'
      - id: number_of_purchase_trades
        type: s4
        doc: 'Number of purchase trades'
      - id: purchase_volume
        type: s8
        doc: 'Purchase volume'
  opening_of_continuous_auctions_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: auction_session_startup_time
        type: millisecond_timestamp
        doc: 'Time when the auction session opens. Milliseconds since Unix epoch'
      - id: auction_session_end_time
        type: millisecond_timestamp
        doc: 'Time when the auction session ends. Milliseconds since Unix epoch'
  existence_of_bids_at_mid_price_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: bids_existing
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the value is "1", it will be construed as true (there are bids), in any other case it will be false (there are no bids)'
  catalogue_of_debt_and_metals_instruments_message:
    seq:
      - id: number_of_the_instrument
        type: s4
        doc: 'Sole code throughout the life of the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: type_of_value
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Type Value'
      - id: issuing_company
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuing Company'
      - id: issuance
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuance'
      - id: date_of_issuance
        type: millisecond_timestamp
        doc: 'Date of issuance and placement. Milliseconds since Unix epoch'
      - id: date_of_maturity
        type: millisecond_timestamp
        doc: 'Date of maturity. Milliseconds since Unix epoch'
      - id: price_rate_of_reference
        type: decimal_s8_8
        doc: 'Last reference price or rate. Implied decimal with scale 1e-8'
      - id: date_of_reference
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: u1
        enum: reference
        doc: 'N – Prior, “ ” – W/O Price, V – Adjusted Nominal Value'
      - id: term_days
        type: s2
        doc: 'Term days of the issuance'
      - id: coupon_period
        type: s2
        doc: 'Coupon number in effect or period number'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of the instrument'
      - id: market
        type: u1
        enum: market
        doc: 'D – Local debt, F- Global debt, E – Money'
      - id: current_nominal_value
        type: decimal_s8_8
        doc: 'Current nominal value. Implied decimal with scale 1e-8'
      - id: original_nominal_value
        type: decimal_s8_8
        doc: 'Original nominal value. Implied decimal with scale 1e-8'
      - id: outstanding_shares
        type: s8
        doc: 'Outstanding Shares'
      - id: amount_placed
        type: s8
        doc: 'Amount Placed'
      - id: trades_rate_price
        type: u1
        enum: trades_rate_price
        doc: 'T - Rate P - Price " "- By default'
  catalog_sent_for_instruments_belonging_to_mutual_funds_message:
    seq:
      - id: number_of_the_instrument
        type: s4
        doc: 'Sole code throughout the life of the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: type_of_value
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Type Value'
      - id: issuing_company
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuing Company'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Series'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: sub_sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: industry
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: sub_industry
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: trading_company
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the trading company of the investment fund'
      - id: reference_price
        type: decimal_s8_8
        doc: 'Last reference price or rate. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: u1
        enum: reference
        doc: 'N – Prior, “ ” – W/O Price, V – Adjusted Nominal Value'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of the instrument'
      - id: rating
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rating'
  weighted_average_price_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: weighted_average_price
        type: decimal_s8_8
        doc: 'Average price of the instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Volatility of the instrument. Implied decimal with scale 1e-8'
  system_events_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: code_of_event
        type: u1
        enum: code_of_event
        doc: 'See Catalogue of Codes of System Event on the Connections and Appendix document'
      - id: market
        type: u1
        enum: market
        doc: 'D – Local debt, F- Global debt, E – Money'
      - id: send_time
        type: millisecond_timestamp
        doc: 'Send time of administrative recess. Used only in case of administrative recess notices. Milliseconds since Unix epoch'
      - id: end_time
        type: millisecond_timestamp
        doc: 'End time of administrative recess. Used only in case of administrative recess notices and in the case of an automatic resource. Milliseconds since Unix epoch'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group identifier. If blank, it applies at system level'
  reference_price_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: price
        type: decimal_s8_8
        doc: 'Market price. Implied decimal with scale 1e-8'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Type of Price sent. See Catalogue of types of price on the Connections and Appendix document'
  changes_in_status_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: status
        type: u1
        enum: status
        doc: 'New status of the instrument. See Catalogue of status changes. on the Connections and Appendix document'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for the change of status. See Catalogue of reasons. on the Connections and Appendix document'
  catalog_for_instruments_belonging_to_the_capital_warrants_market_message:
    seq:
      - id: number_of_the_instrument
        type: s4
        doc: 'Sole code throughout the life of the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: type_of_value
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Type Value'
      - id: issuing_company
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuing Company'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Series'
      - id: type_of_warrant
        type: u1
        enum: type_of_warrant
        doc: '"C"- Purchase "V"- Sale'
      - id: date_of_maturity
        type: millisecond_timestamp
        doc: 'Date of maturity. Milliseconds since Unix epoch'
      - id: price_of_exercise
        type: decimal_s8_8
        doc: 'Price to exercise the Warrant. Implied decimal with scale 1e-8'
      - id: reference_price
        type: decimal_s8_8
        doc: 'Last reference price or rate. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: u1
        enum: reference
        doc: 'N – Prior, “ ” – W/O Price, V – Adjusted Nominal Value'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of the instrument'
  catalog_sent_for_instruments_belonging_to_capital_tracs_message:
    seq:
      - id: number_of_the_trac
        type: s4
        doc: 'Sole code throughout the life of the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: name_of_the_trac
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the name of the Trac'
      - id: underlying_issuing_company
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuing company of the underlying value'
      - id: underlying_series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the series of the underlying value'
      - id: securities
        type: decimal_s8_8
        doc: 'Number of Securities of the underlying value. Implied decimal with scale 1e-8'
      - id: excluded_securities
        type: decimal_s8_8
        doc: 'Number of securities excluded from the underlying value. Implied decimal with scale 1e-8'
      - id: price
        type: decimal_s8_8
        doc: 'Market price. Implied decimal with scale 1e-8'
      - id: component_in_cash
        type: decimal_s8_8
        doc: 'Cash component per unit. Implied decimal with scale 1e-8'
      - id: excluded_value
        type: decimal_s8_8
        doc: 'Estimated value of excluded assets by unit. Implied decimal with scale 1e-8'
      - id: number_of_certificates
        type: s8
        doc: 'Estimated value of the excluded assets per unit (Document label: Excluded Value)'
      - id: theoretical_price
        type: decimal_s8_8
        doc: 'Theoretical Price. Implied decimal with scale 1e-8'
  consolidated_inav_message:
    seq:
      - id: number_of_the_trac
        type: s4
        doc: 'Sole code throughout the life of the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: current_theoretical_price
        type: decimal_s8_8
        doc: 'Last theoretical price of the Trac. Implied decimal with scale 1e-8'
  catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message:
    seq:
      - id: mse_instrument_number
        type: s4
        doc: 'Unique code during instruments life'
      - id: value_of_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Type of Value'
      - id: issuing_company
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the issuing Company'
      - id: series
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the Series'
      - id: last_price
        type: decimal_s8_8
        doc: 'Last reference price. Implied decimal with scale 1e-8'
      - id: ppp_weighted_average_price
        type: decimal_s8_8
        doc: 'Weighted average price. Implied decimal with scale 1e-8'
      - id: reference_date
        type: millisecond_timestamp
        doc: 'Last reference date. Milliseconds since Unix epoch'
      - id: reference
        type: u1
        enum: reference
        doc: 'N – Prior, “ ” – W/O Price, V – Adjusted Nominal Value'
      - id: coupon_in_effect
        type: s2
        doc: 'Coupon number in effect'
      - id: marketability
        type: u1
        enum: marketability
        doc: 'See Marketability Catalog on the Connections and Appendix document'
      - id: numerical_marketability
        type: decimal_s4_4
        doc: 'Refer to the BMV Marketability Indices Methodology. Implied decimal with scale 1e-4'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of the instrument'
      - id: market
        type: u1
        enum: market
        doc: 'D – Local debt, F- Global debt, E – Money'
      - id: registered_values
        type: s8
        doc: 'Outstanding shares'
      - id: exchange
        type: u1
        enum: exchange
        doc: 'Exchange where the value was listed. M-BMV I-BIVA (Document label: Registered Values)'
  probable_price_of_allocation_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: probable_price_of_allocation
        type: decimal_s8_8
        doc: 'Probable price of allocation. Implied decimal with scale 1e-8'
      - id: volume
        type: s8
        doc: 'Maximum volume to be traded'
  relation_between_bmvbiva_instruments_message:
    seq:
      - id: number_of_the_bmv_instrument
        type: s4
        doc: 'Sole code throughout the life of the instrument at BMV'
      - id: biva_instrument
        type: s4
        doc: 'Code of the instrument at BIVA'
      - id: type_of_trading
        type: u1
        enum: type_of_trading
        doc: 'See Catalogue of Type of BIVA operations on the Connections and Appendix document'
  equities_market_trades_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: time_of_the_trade
        type: millisecond_timestamp
        doc: 'Time when the transaction took place. Milliseconds since Unix epoch'
      - id: volume
        type: s8
        doc: 'Maximum volume to be traded'
      - id: price
        type: decimal_s8_8
        doc: 'Market price. Implied decimal with scale 1e-8'
      - id: type_of_agreement
        type: u1
        enum: type_of_agreement
        doc: 'See Catalogue of Type of Agreement on the Connections and Appendix document'
      - id: consecutive_number_of_the_trade
        type: s8
        doc: 'Numbering stamp per instrument'
      - id: sets_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'If the Value is 1, it will be construed as true, in any other case it will be false'
      - id: type_of_trading
        type: u1
        enum: type_of_trading
        doc: 'See Catalogue of Type of BIVA operations on the Connections and Appendix document'
      - id: amount
        type: decimal_s8_8
        doc: 'Amount. Implied decimal with scale 1e-8'
      - id: purchases
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short code of the Purchasing Exchange (BMV and BIVA)'
      - id: sells
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short code of the Selling Exchange (BMV and BIVA)'
      - id: settlement
        type: u1
        enum: settlement
        doc: 'See Catalogue of Types of Settlement on the Connections and Appendix document'
      - id: auction_indicator
        type: u1
        enum: auction_indicator
        doc: '"P"-Opening Auction "S"-Other Auctions " "- Continuous Market "N"- Not Applicable'
      - id: indicator
        type: u1
        enum: indicator
        doc: 'Denotes if the execution must be reflected for the volume calculations: "N" – No, "Y" – Yes In the case of the BMV this field does not apply and will be sent blank'
  consolidated_trade_cancellation_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Sole code throughout the life on the instrument'
      - id: origin
        type: u1
        enum: origin
        doc: 'M-BMV'
      - id: consecutive_number_of_the_trade
        type: s8
        doc: 'Numbering stamp per instrument'
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
    0x28:
      id: 'mutual_funds_trades_message'
      doc: 'Any transaction made in mutual funds is reported.'
    0x29:
      id: 'opening_of_continuous_auctions_message'
      doc: 'The message is sent when one of the ongoing, volatility or SIC bidding sessions is generated.'
    0x2c:
      id: 'existence_of_bids_at_mid_price_message'
      doc: 'This message is generated when an instrument enters a bid in the hidden electronic book At Mean Price.'
    0x2e:
      id: 'catalogue_of_debt_and_metals_instruments_message'
      doc: 'Catalogue sent for instruments pertaining to the Local Fixed rate, Global Fixed rate and metals markets.'
    0x30:
      id: 'catalog_sent_for_instruments_belonging_to_mutual_funds_message'
      doc: 'Catalogue sent for instrument pertaining to the investment companies.'
    0x36:
      id: 'weighted_average_price_message'
      doc: 'This message will have the weighted average price (WAP) per instrument and is sent for each transaction generated within the calculation period of the WAP (last 20 minutes of the trading session); when there are no more trades in this period, the message is sent with the Weighted Average Price in zeros.'
    0x37:
      id: 'system_events_message'
      doc: 'The system events message is used to inform that an event has taken place, which needs to be disclosed to the public for its attention.'
    0x38:
      id: 'reference_price_message'
      doc: 'This message is sent to define the reference price of an instrument.'
    0x39:
      id: 'changes_in_status_message'
      doc: 'This message is sent when there has been a change in the status of the instruments.'
    0x54:
      id: 'catalog_for_instruments_belonging_to_the_capital_warrants_market_message'
      doc: 'Catalogue for instruments pertaining to the Equities Warrants market.'
    0x5b:
      id: 'catalog_sent_for_instruments_belonging_to_capital_tracs_message'
      doc: 'Catalogue sent for instruments pertaining to the equities TRACS.'
    0x5d:
      id: 'consolidated_inav_message'
      doc: 'Disclosure of the TRACS during the trading hours of the ongoing market.'
    0x68:
      id: 'catalog_for_instruments_belonging_to_the_local_and_global_stock_market_message'
      doc: 'Catalog of instruments from the local and global stock markets.'
    0x69:
      id: 'probable_price_of_allocation_message'
      doc: 'The message is sent during any type of bidding (Opening, Ongoing, Volatility and Intraday) and only in the instruments where there already is a virtual term matching or pre-allotment.'
    0x6a:
      id: 'relation_between_bmvbiva_instruments_message'
      doc: 'Relation between identifiers of instruments between BIVA and BMV.'
    0x70:
      id: 'equities_market_trades_message'
      doc: 'Informs about any transaction which was accepted at the BMV or BIVA.'
    0x71:
      id: 'consolidated_trade_cancellation_message'
      doc: 'This message in sent when a transaction is cancelled from BMV or BIVA system.'
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
  reference:
    0x4e:
      id: 'previous'
      doc: 'N - Prior'
    0x4a:
      id: 'adjusted'
      doc: 'Adjusted'
    0x56:
      id: 'adjusted_nominal_value'
      doc: 'Adjusted Nominal Value'
    0x20:
      id: 'without_price'
      doc: 'Without Price'
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
  trades_rate_price:
    0x54:
      id: 'rate'
      doc: 'Rate'
    0x50:
      id: 'price'
      doc: 'Price'
    0x20:
      id: 'by_default'
      doc: 'By Default'
  code_of_event:
    0x41:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x42:
      id: 'cancelation_of_offers'
      doc: 'Cancelation Of Offers'
    0x43:
      id: 'start_of_opening_auction'
      doc: 'Start Of Opening Auction'
    0x44:
      id: 'start_of_continuous_market'
      doc: 'Start Of Continuous Market'
    0x45:
      id: 'start_of_wap_period'
      doc: 'Start Of Wap Period'
    0x46:
      id: 'continuous_market_ends'
      doc: 'Continuous Market Ends'
    0x47:
      id: 'start_of_after_closing_phase'
      doc: 'Start Of After Closing Phase'
    0x48:
      id: 'it_ends_after_closing'
      doc: 'It Ends After Closing'
    0x4a:
      id: 'transmission_of_final_prices_ends'
      doc: 'Transmission Of Final Prices Ends'
    0x4b:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x4d:
      id: 'start_of_administrative_recess'
      doc: 'Start Of Administrative Recess'
    0x4e:
      id: 'end_of_administrative_recess'
      doc: 'End Of Administrative Recess'
    0x4f:
      id: 'start_dvmamx_markets'
      doc: 'Start Dvmamx Markets'
    0x50:
      id: 'end_of_dvma_markets'
      doc: 'End Of Dvma Markets'
    0x51:
      id: 'end_of_mx_markets'
      doc: 'End Of Mx Markets'
    0x52:
      id: 'start_of_opc_modality'
      doc: 'Start Of Opc Modality'
    0x53:
      id: 'end_of_opc_modality'
      doc: 'End Of Opc Modality'
    0x54:
      id: 'start_of_settlement_auction'
      doc: 'Start Of Settlement Auction'
    0x55:
      id: 'end_of_settlement_auction'
      doc: 'End Of Settlement Auction'
    0x56:
      id: 'final_register_of_settlement_prices'
      doc: 'Final Register Of Settlement Prices'
    0x57:
      id: 'open_interest'
      doc: 'Open Interest'
  price_type:
    0x52:
      id: 'reference'
      doc: 'Reference'
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
    0x49:
      id: 'inav'
      doc: 'INAV (for ITCH INDEX only)'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
  status:
    0x43:
      id: 'bids_cancellation'
      doc: 'Bids Cancellation'
    0x41:
      id: 'opening_bidding_session'
      doc: 'Opening Bidding Session'
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
    0x45:
      id: 'in_allotment'
      doc: 'In Allotment'
    0x47:
      id: 'assigned_bidding_session'
      doc: 'Assigned Bidding Session'
    0x54:
      id: 'ended_bidding_session'
      doc: 'BMV: Ended Bidding Session; BIVA: Active instrument'
    0x4e:
      id: 'ongoing_trading'
      doc: 'Ongoing Trading'
    0x4b:
      id: 'bidding_session_due_to_parameters_breaking'
      doc: 'Bidding Session Due To Parameters Breaking'
    0x4d:
      id: 'ongoing_bidding_session_due_to_operations_ceasing_for_more_than_20_business_days'
      doc: 'Ongoing Bidding Session Due To Operations Ceasing For More Than 20 Business Days'
    0x55:
      id: 'demerger_bidding_session'
      doc: 'Demerger (Spin Off) Bidding Session'
    0x4f:
      id: 'suspended_series'
      doc: 'Suspended Series'
    0x56:
      id: 'suspended_listing'
      doc: 'BMV: Suspended Listing; BIVA: Suspended instrument'
    0x4c:
      id: 'bidding_session_due_to_breach'
      doc: 'Bidding Session Due To Breach'
    0x49:
      id: 'withdrawal_of_orders_in_an_ongoing_bidding_session'
      doc: 'Withdrawal Of Orders In An Ongoing Bidding Session'
    0x42:
      id: 'withdrawal_of_orders_in_intraday_bidding_session'
      doc: 'Withdrawal Of Orders In Intraday Bidding Session'
    0x57:
      id: 'awaiting_news'
      doc: 'Awaitng News'
    0x58:
      id: 'settlement_bidding_session'
      doc: 'Settlement Bidding Session'
    0x59:
      id: 'extraordinary_settlement_bidding_session'
      doc: 'Extraordinary Settlement Bidding Session'
    0x52:
      id: 'ckdes_total_bidding_session'
      doc: 'Ckdes Total Bidding Session'
  reason:
    0x4e:
      id: 'normal_operation'
      doc: 'Normal Operation'
    0x48:
      id: 'volatility_bidding_session'
      doc: 'Volatility Bidding Session'
    0x41:
      id: 'startup_of_the_volatility_bidding_session'
      doc: 'Startup Of The Volatility Bidding Session'
    0x42:
      id: 'end_of_the_volatility_bidding_session'
      doc: 'End Of The Volatility Bidding Session'
    0x51:
      id: 'awaiting_news'
      doc: 'Awaiting News'
    0x53:
      id: 'static_price_band_breach'
      doc: 'Static Price Band Breach'
    0x4d:
      id: 'suspension_due_to_markets_surveillance'
      doc: 'Suspension Due To Markets Surveillance'
    0x4f:
      id: 'suspension_from_the_market_of_origin'
      doc: 'Suspension From The Market Of Origin'
    0x43:
      id: 'without_compliance'
      doc: 'Without Compliance'
    0x49:
      id: 'startup_of_the_interest_notice'
      doc: 'Startup Of The Interest Notice'
  type_of_warrant:
    0x43:
      id: 'purchase'
      doc: 'Purchase'
    0x56:
      id: 'sale'
      doc: 'Sale'
  marketability:
    0x41:
      id: 'high'
      doc: 'High'
    0x4d:
      id: 'medium'
      doc: 'Medium'
    0x42:
      id: 'low'
      doc: 'Low'
    0x4e:
      id: 'minimum'
      doc: 'Minimum'
    0x52:
      id: 'recent_quotation'
      doc: 'Recent Quotation'
    0x20:
      id: 'null_or_inapplicable'
      doc: 'Null Or Inapplicable'
  exchange:
    0x4d:
      id: 'bmv'
      doc: 'Bmv'
    0x49:
      id: 'biva'
      doc: 'Biva'
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
  type_of_agreement:
    0x43:
      id: 'crossing_operation'
      doc: 'Crossing Operation'
    0x4f:
      id: 'order_closing'
      doc: 'Order Closing'
    0x48:
      id: 'operation_at_closing_price'
      doc: 'Operation At Closing Price'
    0x44:
      id: 'operation_after_closing'
      doc: 'Operation After Closing'
    0x4d:
      id: 'operation_at_medium_price'
      doc: 'Operation At Medium Price'
    0x50:
      id: 'operation_at_average_price_for_the_day'
      doc: 'Operation At Average Price For The Day'
    0x58:
      id: 'block_operations_by_exception'
      doc: 'Block Operations By Exception'
    0x76:
      id: 'vwap_operations_by_exception'
      doc: 'Vwap Operations By Exception'
    0x77:
      id: 'twap_operations_by_exception'
      doc: 'Twap Operations By Exception'
    0x25:
      id: 'basket_trading'
      doc: 'Basket Trading'
    0x78:
      id: 'otc_recent_operations'
      doc: 'Otc Recent Operations'
    0x79:
      id: 'otc_agreed_operations'
      doc: 'Otc Agreed Operations'
    0x41:
      id: 'buy_auto_entry'
      doc: 'Buy Auto Entry'
    0x42:
      id: 'sell_auto_entry'
      doc: 'Sell Auto Entry'
    0x45:
      id: 'block_trade'
      doc: 'Block Trade'
    0x46:
      id: 'leg_of_blocktrade_for_chain_of_forwards'
      doc: 'Leg Of Blocktrade For Chain Of Forwards'
    0x47:
      id: 'leg_of_chain_of_forwards'
      doc: 'Leg Of Chain Of Forwards'
    0x4a:
      id: 'leg_of_crossing_of_foreign_currency_strategy'
      doc: 'Leg Of Crossing Of Foreign Currency Strategy'
    0x4b:
      id: 'sell_leg_auto_entry_of_foreign_currency_strategy'
      doc: 'Sell Leg Auto Entry Of Foreign Currency Strategy'
    0x4c:
      id: 'buy_leg_auto_entry_of_foreign_currency_strategy'
      doc: 'Buy Leg Auto Entry Of Foreign Currency Strategy'
    0x4e:
      id: 'leg_of_foreign_currency_strategy'
      doc: 'Leg Of Foreign Currency Strategy'
    0x51:
      id: 'leg_of_foreign_currency_strategy_x51'
      doc: 'Leg Of Foreign Currency Strategy'
    0x52:
      id: 'leg_of_crossing_of_chain_of_forwards'
      doc: 'Leg Of Crossing Of Chain Of Forwards'
    0x53:
      id: 'sell_leg_auto_entry_of_chain_of_forwards'
      doc: 'Sell Leg Auto Entry Of Chain Of Forwards'
    0x54:
      id: 'buy_leg_auto_entry_of_chain_of_forwards'
      doc: 'Buy Leg Auto Entry Of Chain Of Forwards'
    0x55:
      id: 'leg_of_auction_of_chain_of_forwards'
      doc: 'Leg Of Auction Of Chain Of Forwards'
    0x56:
      id: 'leg_of_round_of_chain_of_forwards'
      doc: 'Leg Of Round Of Chain Of Forwards'
    0x57:
      id: 'chains_of_forwards'
      doc: 'Chains Of Forwards'
    0x59:
      id: 'leg_of_rollover_crossing'
      doc: 'Leg Of Rollover Crossing'
    0x5a:
      id: 'sell_leg_auto_entry_of_rollover'
      doc: 'Sell Leg Auto Entry Of Rollover'
    0x61:
      id: 'buy_leg_auto_entry_of_rollover'
      doc: 'Buy Leg Auto Entry Of Rollover'
    0x62:
      id: 'leg_of_round_of_rollover'
      doc: 'Leg Of Round Of Rollover'
    0x63:
      id: 'depth_of_round_of_chain_of_forwards'
      doc: 'Depth Of Round Of Chain Of Forwards'
    0x64:
      id: 'trading_of_chain_of_forwards'
      doc: 'Trading Of Chain Of Forwards'
    0x65:
      id: 'depth_of_round'
      doc: 'Depth Of Round'
    0x66:
      id: 'round_of_chain_of_forwards'
      doc: 'Round Of Chain Of Forwards'
    0x67:
      id: 'rollover_sentra'
      doc: 'Rollover Sentra'
    0x68:
      id: 'type_round'
      doc: 'Type Round'
    0x69:
      id: 'auctions'
      doc: 'Auctions'
    0x6a:
      id: 'leg_of_block_trade_of_rollover'
      doc: 'Leg Of Block Trade Of Rollover'
    0x6b:
      id: 'leg_of_block_trade_of_foreign_currency_strategy'
      doc: 'Leg Of Block Trade Of Foreign Currency Strategy'
    0x6c:
      id: 'block_trade_of_foreign_currency_strategy'
      doc: 'Block Trade Of Foreign Currency Strategy'
    0x6d:
      id: 'block_trade_of_chain_of_forwards'
      doc: 'Block Trade Of Chain Of Forwards'
    0x6e:
      id: 'blocktrade_of_rollover'
      doc: 'Blocktrade Of Rollover'
    0x6f:
      id: 'crossing_of_chain_of_forwards'
      doc: 'Crossing Of Chain Of Forwards'
    0x70:
      id: 'sell_auto_entry_of_chain_of_forwards'
      doc: 'Sell Auto Entry Of Chain Of Forwards'
    0x71:
      id: 'buy_auto_entry_of_chain_of_forwards'
      doc: 'Buy Auto Entry Of Chain Of Forwards'
    0x72:
      id: 'swap_block_trade'
      doc: 'Swap Block Trade'
    0x73:
      id: 'swap_block_trade_with_continuous_coupon'
      doc: 'Swap Block Trade With Continuous Coupon'
    0x74:
      id: 'block_trade_of_unwind'
      doc: 'Block Trade Of Unwind'
    0x75:
      id: 'block_trade_of_substitution'
      doc: 'Block Trade Of Substitution'
    0x7a:
      id: 'voice_over'
      doc: 'Voice Over'
    0x23:
      id: 'firm_order'
      doc: 'Firm Order'
    0x49:
      id: 'ipo_cross'
      doc: 'Ipo Cross'
    0x2b:
      id: 'unintentional_self_cross'
      doc: 'Unintentional Self Cross'
    0x26:
      id: 'without_concertation'
      doc: 'Without Concertation'
    0x28:
      id: 'inav_to_closing_price_trading'
      doc: 'Inav To Closing Price Trading'
    0x29:
      id: 'inav_after_closing'
      doc: 'Inav After Closing'
  settlement:
    0x4d:
      id: 'same_day'
      doc: 'Same Day'
    0x32:
      id: 'twenty_four_hours'
      doc: '24 hours'
    0x34:
      id: 'forty_eight_hours'
      doc: '48 hours'
    0x37:
      id: 'seventy_two_hours'
      doc: '72 hours'
    0x39:
      id: 'ninety_six_hours'
      doc: '96 hours'
    0x31:
      id: 'one_hundred_twenty_hours'
      doc: '120 hours'
  auction_indicator:
    0x50:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x53:
      id: 'other_auctions'
      doc: 'Other Auctions'
    0x20:
      id: 'continuous_market'
      doc: 'Continuous Market'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'

