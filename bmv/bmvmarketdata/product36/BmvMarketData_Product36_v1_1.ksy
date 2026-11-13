# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product36 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 36
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P36_1_ENG.pdf
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
  id: bmv_bmvmarketdata_product36_intra_v1_1
  title: Bmv BmvMarketData Product36 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 36 Intra v1.1'
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
            'message_type::indices_components_message': indices_components_message
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
  indices_components_message:
    seq:
      - id: date
        type: millisecond_timestamp
        doc: 'Date. Milliseconds since Unix epoch'
      - id: component
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'See Indices Components Catalog on the Connections and Appendix document'
      - id: sector
        type: s1
        doc: 'See Industry Classification on the Connections and Appendix document'
      - id: type_field
        type: u1
        enum: type_field
        doc: 'See Equity’s Indices Components Catalog on the Connections and Appendix document'
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
      - id: indices_stocks
        type: s8
        doc: 'Number of stocks of the issuer that making up the component'
      - id: last_price
        type: decimal_s8_8
        doc: 'Last price. Implied decimal with scale 1e-8'
      - id: closing_price
        type: decimal_s8_8
        doc: 'Closing price. Implied decimal with scale 1e-8'
      - id: influence
        type: decimal_s8_8
        doc: 'Issuer weight inside the Indices. Implied decimal with scale 1e-8'
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
    0x57:
      id: 'indices_components_message'
      doc: 'Indices components obtained during the day.'
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
  type_field:
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x53:
      id: 'strategy'
      doc: 'Strategy'
    0x47:
      id: 'spbmvesg'
      doc: 'Spbmvesg'

