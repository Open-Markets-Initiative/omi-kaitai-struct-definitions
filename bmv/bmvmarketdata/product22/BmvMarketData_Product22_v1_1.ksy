# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product22 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 22
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P22_1_ENG.pdf
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
  id: bmv_bmvmarketdata_product22_intra_v1_1
  title: Bmv BmvMarketData Product22 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 22 Intra v1.1'
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
            'message_type::events_system_message': events_system_message
            'message_type::dollar_buy_sell_message': dollar_buy_sell_message
            'message_type::short_sales_balances_per_instrument_message': short_sales_balances_per_instrument_message
            'message_type::capital_market_multiples_message': capital_market_multiples_message
            'message_type::capitalization_rules_message': capitalization_rules_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying the message'
  events_system_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See the table of System Event Codes Catalog on the Connections and Appendix document'
      - id: market
        type: u1
        enum: market
        doc: 'See the table of Markets Catalog (only used when there is an official recess) on the Connections and Appendix document'
      - id: sending_time
        type: millisecond_timestamp
        doc: 'Recess’s official sending time. Only used when official recess has occurred. Milliseconds since Unix epoch'
      - id: ending_time
        type: millisecond_timestamp
        doc: 'Recess official ending time. Only used when an official recess or automatic recess occurred. Milliseconds since Unix epoch'
  dollar_buy_sell_message:
    seq:
      - id: posture_date
        type: millisecond_timestamp
        doc: 'Posture Date. Milliseconds since Unix epoch'
      - id: currency
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency'
      - id: dollar_side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side (Document label: Side)'
      - id: buy
        type: decimal_s8_8
        doc: 'Buy. Implied decimal with scale 1e-8'
      - id: sell
        type: decimal_s8_8
        doc: 'Sell. Implied decimal with scale 1e-8'
      - id: last_deal
        type: decimal_s8_8
        doc: 'Last Deal. Implied decimal with scale 1e-8'
  short_sales_balances_per_instrument_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: date
        type: millisecond_timestamp
        doc: 'Information Date. Milliseconds since Unix epoch'
      - id: previous_balance
        type: s8
        doc: 'Previous Balance'
      - id: amount_traded
        type: s8
        doc: 'Amount Traded'
      - id: buybacks
        type: s8
        doc: 'Buybacks'
      - id: current_balance
        type: s8
        doc: 'Current Balance'
  capital_market_multiples_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique code during instruments life For the sector multiples a null is sent (represented by the maximum possible value for this type of value, in this case it is 2,147,483,647)'
      - id: multiple_type
        type: u1
        enum: multiple_type
        doc: '"E"=Multiple of market by transmitter, "S"=Multiple of market by sector'
      - id: registry_number
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Registries sent number'
      - id: sector
        type: s1
        doc: 'Sector'
      - id: subsector
        type: s1
        doc: 'Subsector'
      - id: business_line
        type: s1
        doc: 'Business Line'
      - id: sub_line
        type: s1
        doc: 'Sub-Line'
      - id: pflepa_multiple
        type: decimal_s8_8
        doc: 'P/FLEPA Multiple. Implied decimal with scale 1e-8'
      - id: pfepa_multiple
        type: decimal_s8_8
        doc: 'P/FEPA Multiple. Implied decimal with scale 1e-8'
      - id: ve_uaiida_multiple
        type: decimal_s8_8
        doc: 'VE-UAIIDA Multiple. Implied decimal with scale 1e-8'
      - id: p_u
        type: decimal_s8_8
        doc: 'P U. Implied decimal with scale 1e-8'
      - id: p_vl
        type: decimal_s8_8
        doc: 'P VL. Implied decimal with scale 1e-8'
      - id: f_1_p_unoc
        type: decimal_s8_8
        doc: 'F1_P_UNOC. Implied decimal with scale 1e-8'
      - id: f_2_p_unoc
        type: decimal_s8_8
        doc: 'F2_P_UNOC. Implied decimal with scale 1e-8'
      - id: f_1_p_ue
        type: decimal_s8_8
        doc: 'F1_P_UE. Implied decimal with scale 1e-8'
      - id: f_2_p_ue
        type: decimal_s8_8
        doc: 'F2_P_UE. Implied decimal with scale 1e-8'
      - id: f_1_ve_uaiida
        type: decimal_s8_8
        doc: 'F1_VE_UAIIDA. Implied decimal with scale 1e-8'
      - id: f_2_ve_uaiida
        type: decimal_s8_8
        doc: 'F2_VE_UAIIDA. Implied decimal with scale 1e-8'
      - id: f_1_p_u
        type: decimal_s8_8
        doc: 'F1_P_U. Implied decimal with scale 1e-8'
      - id: f_2_p_u
        type: decimal_s8_8
        doc: 'F2_P_U. Implied decimal with scale 1e-8'
      - id: f_1_p_vl
        type: decimal_s8_8
        doc: 'F1_P_VL. Implied decimal with scale 1e-8'
      - id: f_2_p_vl
        type: decimal_s8_8
        doc: 'F2_P_VL. Implied decimal with scale 1e-8'
  capitalization_rules_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: date_indicators
        type: millisecond_timestamp
        doc: 'Date indicators. Milliseconds since Unix epoch'
      - id: bursatility_indices
        type: decimal_s4_4
        doc: 'Bursatility Indices. Implied decimal with scale 1e-4'
      - id: bursatility_indices_sign
        type: u1
        enum: bursatility_indices_sign
        doc: 'Bursatility Indices Sign: " " - Positive, "_" - Negative'
      - id: beta_coefficient
        type: decimal_s8_8
        doc: 'Beta Coefficient. Implied decimal with scale 1e-8'
      - id: beta_coefficient_sign
        type: u1
        enum: beta_coefficient_sign
        doc: 'Beta Coefficient Sign: " " - Positive, "_" - Negative'
      - id: correlation_coefficient
        type: decimal_s8_8
        doc: 'Correlation Coefficient. Implied decimal with scale 1e-8'
      - id: correlation_coefficient_sign
        type: u1
        enum: correlation_coefficient_sign
        doc: 'Correlation Coefficient Sign: " " - Positive, "_" - Negative'
      - id: delta_difference
        type: decimal_s4_4
        doc: 'Delta Difference. Implied decimal with scale 1e-4'
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
    0x53:
      id: 'events_system_message'
      doc: 'The system of events message is used to inform that an event has occurred, which needs to be of public domain.'
    0x72:
      id: 'dollar_buy_sell_message'
      doc: 'Dollar Buy/Sell'
    0x73:
      id: 'short_sales_balances_per_instrument_message'
      doc: 'Short sales balances per instrument'
    0x74:
      id: 'capital_market_multiples_message'
      doc: 'Capital Market Multiples'
    0x7a:
      id: 'capitalization_rules_message'
      doc: 'Capitalization Rules'
  event_code:
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
  multiple_type:
    0x45:
      id: 'multiple_of_market_by_transmitter'
      doc: 'Multiple Of Market By Transmitter'
    0x53:
      id: 'multiple_of_market_by_sector'
      doc: 'Multiple Of Market By Sector'
  bursatility_indices_sign:
    0x20:
      id: 'positive'
      doc: 'Positive'
    0x5f:
      id: 'negative'
      doc: 'Negative'
  beta_coefficient_sign:
    0x20:
      id: 'positive'
      doc: 'Positive'
    0x5f:
      id: 'negative'
      doc: 'Negative'
  correlation_coefficient_sign:
    0x20:
      id: 'positive'
      doc: 'Positive'
    0x5f:
      id: 'negative'
      doc: 'Negative'

