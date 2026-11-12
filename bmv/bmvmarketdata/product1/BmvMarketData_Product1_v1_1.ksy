# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Product1 Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Product 1
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Market Data Multicast_P1_1_ENG.pdf
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
  id: bmv_bmvmarketdata_product1_intra_v1_1
  title: Bmv BmvMarketData Product1 Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Product 1 Intra v1.1'
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
            83: events_system_message
            72: trade_cancellation_message
            52: status_changes_message
            77: weighted_average_price_settlement_prices_message
            80: capital_trades_message
            50: probable_allocation_price_message
            51: continuous_auctions_beginning_message
            53: middle_price_existing_quotes_message
            89: mutual_fund_trades_message
            69: tradability_message
            86: virtual_trades_message
            65: order_addition_message
            67: execution_of_orders_message
            68: order_cancellation_message
            70: order_change_message
  message_header:
    seq:
      - id: message_length
        type: s2
        doc: 'Indicates message length contained in this message block'
      - id: message_type
        type: u1
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
  trade_cancellation_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: trade_number
        type: s4
        doc: 'Stamp number by instrument'
  status_changes_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: instrument_status
        type: u1
        enum: instrument_status
        doc: 'See the table of Instrument Status Catalog on the Connections and Appendix document'
  weighted_average_price_settlement_prices_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: weighted_average_price
        type: decimal_s8_8
        doc: 'Average price instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Volatility instrument. Implied decimal with scale 1e-8'
  capital_trades_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: trade_time
        type: millisecond_timestamp
        doc: 'Time the operation was carried out. Milliseconds since Unix epoch'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
      - id: price
        type: decimal_s8_8
        doc: 'Operation price. Implied decimal with scale 1e-8'
      - id: concertation_type
        type: u1
        enum: concertation_type
        doc: 'See the table of Concertation Type Catalog on the Connections and Appendix document'
      - id: trade_number
        type: s4
        doc: 'Stamp number by instrument'
      - id: price_setter
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For value equal to 1, be taken as true; otherwise, false'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'See the table of Type of Operation Catalog on the Connections and Appendix document'
      - id: amount
        type: decimal_s8_8
        doc: 'Amount. Implied decimal with scale 1e-8'
      - id: buy
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buyers’ brokerage house short key'
      - id: sell
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Seller’s brokerage house short key'
      - id: settlement
        type: u1
        enum: settlement
        doc: 'See the table of Settlement Type Catalog on the Connections and Appendix document'
      - id: auction_indicator
        type: u1
        enum: auction_indicator
        doc: '"P" – Opening Auction "S" – Other Auctions " " – Continuous Market "N" – Not Applicable'
  probable_allocation_price_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: probable_allocation_price
        type: decimal_s8_8
        doc: 'Probable allocation price. Implied decimal with scale 1e-8'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
  continuous_auctions_beginning_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: beginning_time_of_auction
        type: millisecond_timestamp
        doc: 'Time at which auction begins. Milliseconds since Unix epoch'
      - id: end_auction_time
        type: millisecond_timestamp
        doc: 'Time at which auction ends. Milliseconds since Unix epoch'
  middle_price_existing_quotes_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: existing_postures
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'For value equal to "1", True (there are postures), otherwise False (there are no postures)'
  mutual_fund_trades_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: trade_date
        type: millisecond_timestamp
        doc: 'Date operation was carried out. Milliseconds since Unix epoch'
      - id: price
        type: decimal_s8_8
        doc: 'Operation price. Implied decimal with scale 1e-8'
      - id: book_value
        type: decimal_s8_8
        doc: 'Book value by stock. Implied decimal with scale 1e-8'
      - id: number_of_sales_transactions
        type: s4
        doc: 'Number of sales transactions'
      - id: sales_volume
        type: s8
        doc: 'Sales volume'
      - id: number_of_buy_transactions
        type: s4
        doc: 'Number of buy transactions'
      - id: buy_volume
        type: s8
        doc: 'Buy volume'
  tradability_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: number_of_operations
        type: s4
        doc: 'Number of operations'
      - id: volume_int_648
        type: s8
        doc: 'Traded volume'
      - id: amount
        type: decimal_s8_8
        doc: 'Amount. Implied decimal with scale 1e-8'
      - id: opening_price
        type: decimal_s8_8
        doc: 'Opening price. Implied decimal with scale 1e-8'
      - id: maximum
        type: decimal_s8_8
        doc: 'Maximum price. Implied decimal with scale 1e-8'
      - id: minimum
        type: decimal_s8_8
        doc: 'Minimum price. Implied decimal with scale 1e-8'
      - id: average
        type: decimal_s8_8
        doc: 'Average price of the day. Implied decimal with scale 1e-8'
      - id: last
        type: decimal_s8_8
        doc: 'Last time price. Implied decimal with scale 1e-8'
  virtual_trades_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: virtual_trades_status
        type: u1
        enum: virtual_trades_status
        doc: 'A-Addition B-Deletion (Document label: Status)'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'See the table of Type of Operation Catalog on the Connections and Appendix document'
      - id: number
        type: s4
        doc: 'Virtual trade number'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
      - id: concertation
        type: u1
        enum: concertation
        doc: 'See the table of Concertation Type Catalog on the Connections and Appendix document'
      - id: buy
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buyers’ brokerage house short key'
      - id: sell
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Seller’s brokerage house short key'
  order_addition_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: date_and_time
        type: millisecond_timestamp
        doc: 'Date and time for the addition of order. Milliseconds since Unix epoch'
      - id: number
        type: s4
        doc: 'Virtual trade number'
      - id: direction
        type: u1
        enum: direction
        doc: 'C - Buy V - Sell'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
      - id: price
        type: decimal_s8_8
        doc: 'Operation price. Implied decimal with scale 1e-8'
      - id: participant
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short key of participant'
  execution_of_orders_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: date
        type: millisecond_timestamp
        doc: 'Date for the addition of order. Milliseconds since Unix epoch'
      - id: number
        type: s4
        doc: 'Virtual trade number'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
      - id: trade_number
        type: s4
        doc: 'Stamp number by instrument'
      - id: execution_price
        type: decimal_s8_8
        doc: 'Price with which the trade was made. Implied decimal with scale 1e-8'
  order_cancellation_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: date
        type: millisecond_timestamp
        doc: 'Date for the addition of order. Milliseconds since Unix epoch'
      - id: number
        type: s4
        doc: 'Virtual trade number'
  order_change_message:
    seq:
      - id: instrument_number
        type: s4
        doc: 'Always zero'
      - id: original_date
        type: millisecond_timestamp
        doc: 'Date and time when the order was registered. Milliseconds since Unix epoch'
      - id: original_number
        type: s4
        doc: 'Number originally allocated to the order'
      - id: new_date
        type: millisecond_timestamp
        doc: 'New Date and time when the order was registered (Document label: Original date). Milliseconds since Unix epoch'
      - id: new_number
        type: s4
        doc: 'Number allocated to the new order'
      - id: direction
        type: u1
        enum: direction
        doc: 'C - Buy V - Sell'
      - id: volume_int_324
        type: s4
        doc: 'Traded stocks'
      - id: price
        type: decimal_s8_8
        doc: 'Operation price. Implied decimal with scale 1e-8'
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
  instrument_status:
    0x43:
      id: 'cancellation_of_offers'
      doc: 'Cancellation Of Offers'
    0x41:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
    0x45:
      id: 'being_allocated'
      doc: 'Being Allocated'
    0x47:
      id: 'auction_allocated'
      doc: 'Auction Allocated'
    0x54:
      id: 'auction_ended'
      doc: 'Auction Ended'
    0x4e:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x4b:
      id: 'breaking_auction_parameters'
      doc: 'Breaking Auction Parameters'
    0x4d:
      id: 'continuous_auction_due_to_stop_operating_more_than_20_working_days'
      doc: 'Continuous Auction Due To Stop Operating More Than 20 Working Days'
    0x55:
      id: 'cleaving_auction'
      doc: 'Cleaving Auction'
    0x4f:
      id: 'suspended_series'
      doc: 'Suspended Series'
    0x56:
      id: 'suspended_quotation'
      doc: 'Suspended Quotation'
    0x4c:
      id: 'auction_for_breach'
      doc: 'Auction For Breach'
    0x49:
      id: 'withdrawal_of_orders_on_continuous_auction'
      doc: 'Withdrawal Of Orders On Continuous Auction'
    0x42:
      id: 'withdrawal_of_order_on_intraday_auction'
      doc: 'Withdrawal Of Order On Intraday Auction'
    0x57:
      id: 'news_pending'
      doc: 'News Pending'
    0x58:
      id: 'settlement_auction'
      doc: 'Settlement Auction'
    0x59:
      id: 'extraordinary_settlement_auction'
      doc: 'Extraordinary Settlement Auction'
    0x52:
      id: 'auction_total_of_ck_des'
      doc: 'Auction Total Of Ck Des'
  concertation_type:
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
  operation_type:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4f:
      id: 'public_offering'
      doc: 'Public Offering'
    0x52:
      id: 'registration_operation'
      doc: 'Registration Operation'
    0x41:
      id: 'overallocation'
      doc: 'Overallocation'
    0x53:
      id: 'reciprocal_subscription'
      doc: 'Reciprocal Subscription'
    0x46:
      id: 'public_buy_offering'
      doc: 'Public Buy Offering'
    0x48:
      id: 'trades_at_closing'
      doc: 'Trades At Closing'
    0x4d:
      id: 'medium_price'
      doc: 'Medium Price'
    0x58:
      id: 'operation_by_exception'
      doc: 'Operation By Exception'
    0x50:
      id: 'average_for_the_day'
      doc: 'Average For The Day'
    0x44:
      id: 'after_closing'
      doc: 'After Closing'
    0x4e:
      id: 'inav_trading'
      doc: 'Inav Trading'
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
  virtual_trades_status:
    0x41:
      id: 'addition'
      doc: 'Addition'
    0x42:
      id: 'deletion'
      doc: 'Deletion'
  concertation:
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
  direction:
    0x43:
      id: 'buy'
      doc: 'Buy'
    0x56:
      id: 'sell'
      doc: 'Sell'

