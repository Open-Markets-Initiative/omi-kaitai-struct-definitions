# ---------------------------------------------------------------------
# Kaitai struct definition for: Bmv BmvMarketData Snapshot Intra v1.1
#
# Protocol:
#   Organization: Bolsa Mexicana de Valores
#   Protocol: Bmv Market Data Snapshot
#   Encoding: INTRA Multicast
#   Version: 1.1
#   Date: Unknown
#   Specification: Connection_Appendix_6.pdf
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
  id: bmv_bmvmarketdata_snapshot_intra_v1_1_client
  title: Bmv BmvMarketData Snapshot Intra v1.1
  license: MIT-0
  endian: be

doc: 'Bolsa Mexicana de Valores Bolsa Mexicana de Valores Market Data Bmv Market Data Snapshot Intra v1.1'
doc-ref: https://www.bmv.com.mx/es/productos-de-informacion/market-data

seq:
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'One request'

types:
  client_message_struct:
    seq:
      - id: client_message_header
        type: client_message_header
        doc: 'Request length and message type'
      - id: client_payload
        size: client_message_header.client_length - 2
        type:
          switch-on: client_message_header.client_message_type
          cases:
            'client_message_type::login_message': login_message
            'client_message_type::replay_request_message': replay_request_message
            'client_message_type::snapshot_request_message': snapshot_request_message
            'client_message_type::snapshot_indices_request_message': snapshot_indices_request_message
            'client_message_type::snapshot_consolidated_feed_request_message': snapshot_consolidated_feed_request_message
  client_message_header:
    seq:
      - id: client_length
        type: s1
        doc: 'Message length including this field'
      - id: client_message_type
        type: u1
        enum: client_message_type
        doc: 'Code identifying the message'
  login_message:
    seq:
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: user
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'User assigned to receiver'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password assigned to receiver, filled with blank spaces to the right'
  replay_request_message:
    seq:
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: first_message
        type: s4
        doc: 'Sequence number of the first message intended to recover'
      - id: quantity
        type: s2
        doc: 'Quantity of requested messages'
  snapshot_request_message:
    seq:
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: instrument_id
        type: s4
        doc: 'Instrument identifier to which request is related; zeros when not related to any instrument'
      - id: snapshot_type
        type: s1
        enum: snapshot_type
        doc: 'See Snapshot Type Catalog'
  snapshot_indices_request_message:
    seq:
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: component
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Component'
      - id: recovery_hour
        type: millisecond_timestamp
        doc: 'Hour from which to recover the index; zero sends all the information of the sample of the day. Milliseconds since Unix epoch'
  snapshot_consolidated_feed_request_message:
    seq:
      - id: market_data_group
        type: s1
        enum: market_data_group
        doc: 'See Market Data Groups Catalog'
      - id: instrument_id
        type: s4
        doc: 'Instrument identifier to which request is related; zeros when not related to any instrument'
      - id: snapshot_type
        type: s1
        enum: snapshot_type
        doc: 'See Snapshot Type Catalog'
      - id: origin
        type: u1
        enum: origin
        doc: 'Origin of the message: M (BMV), I (BIVA), A (Both)'
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
    0x26:
      id: 'login_response_message'
      doc: 'Answers a login request.'
    0x2a:
      id: 'replay_response_message'
      doc: 'Answers a replay request; the replayed messages follow an accepted one.'
    0x2b:
      id: 'snapshot_response_message'
      doc: 'Answers a snapshot request.'
    0x3f:
      id: 'snapshot_complete_message'
      doc: 'Ends a snapshot with the sequence number it synchronizes with on the online channel.'
    0x53:
      id: 'events_system_message'
      doc: 'The system of events message is used to inform that an event has occurred, which needs to be of public domain.'
    0x48:
      id: 'trade_cancellation_message'
      doc: 'This message is sent when a transaction is cancelled from the BMV system.'
    0x34:
      id: 'status_changes_message'
      doc: 'All instruments are in a certain status before and during trading session.'
    0x4d:
      id: 'weighted_average_price_settlement_prices_message'
      doc: 'For equities market, this message will be sent for each operation containing weighted average price per instrument generated within WAP calculation period (last 20 minutes of trading).'
    0x50:
      id: 'capital_trades_message'
      doc: 'Contains information on any BMV accepted transaction.'
    0x32:
      id: 'probable_allocation_price_message'
      doc: 'Sent during any auction type (Opening, Continuous, Volatility and Intraday) and only on instruments where there is already a virtual match or pre-allocation.'
    0x33:
      id: 'continuous_auctions_beginning_message'
      doc: 'Sent at the moment one of the Continuous, Volatility or SIC auctions is generated.'
    0x35:
      id: 'middle_price_existing_quotes_message'
      doc: 'Generated when an instrument enters a posture in the hidden electronic Middle Price book.'
    0x5a:
      id: 'registry_operations_message'
      doc: 'Sent whenever there is a debt or capital instrument placement.'
    0x59:
      id: 'mutual_fund_trades_message'
      doc: 'Contains any mutual funds operation realized.'
    0x45:
      id: 'tradability_message'
      doc: 'Message sent every half hour during trading session, informing general tradability by instrument.'
    0x56:
      id: 'virtual_trades_message'
      doc: 'When an operation has been pre-assigned to the at closing and average day Price electronic books, a virtual trade message is sent, where also notifying of this operation.'
    0x41:
      id: 'order_addition_message'
      doc: 'The moment an order is being accepted by the BMV central system; this message is diffused to the corresponding media.'
    0x43:
      id: 'execution_of_orders_message'
      doc: 'The message is disseminated at the time there is a matching or closing in BMV’s electronic system.'
    0x44:
      id: 'order_cancellation_message'
      doc: 'This message fully eliminates the order from the trading floor.'
    0x46:
      id: 'order_change_message'
      doc: 'Message sent when the order changes one of its data, the system allocates to it a new priority in the electronic book, the order to be replaced is identified with the original Instrument, Date and Number, the new allocation of priority in the electronic book appears in the New Date and Number fields.'
    0x31:
      id: 'depth_message'
      doc: 'Market depth: up to 20 best buy or sale price levels (10 on the derivatives groups 7, 8 and 19), as many as Purchase or sale levels.'
    0x4f:
      id: 'best_offer_message'
      doc: 'Message sent by instrument when best offer changes in the electronic book.'
    0x42:
      id: 'public_offerings_message'
      doc: 'Trade from a Public offering.'
    0x49:
      id: 'open_interest_message'
      doc: 'Open Interest'
    0x51:
      id: 'derivatives_market_trades_message'
      doc: 'Contains information on any MexDer accepted transaction.'
    0x52:
      id: 'statistics_of_instruments_message'
      doc: 'Update message from derivatives statistics sent each time there is an update on the trading floor at any level price.'
    0x55:
      id: 'general_indices_message'
      doc: 'Information about the MSE Indices.'
    0x57:
      id: 'indices_components_message'
      doc: 'Indices components obtained during the day.'
    0x47:
      id: 'inav_message'
      doc: 'TRACS dissemination during continuous market trading hours.'
    0x72:
      id: 'dollar_buy_sell_message'
      doc: 'Dollar Buy/Sell'
    0x73:
      id: 'short_sales_balances_per_instrument_message'
      doc: 'Short sales balances per instrument'
    0x74:
      id: 'capital_market_multiples_message'
      doc: 'Capital Market Multiples'
    0x78:
      id: 'benchmark_message'
      doc: 'Benchmark'
    0x7a:
      id: 'capitalization_rules_message'
      doc: 'Capitalization Rules'
    0x7e:
      id: 'closing_price_origin_message'
      doc: 'Closing price origin'
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
    0x5c:
      id: 'pricevolume_indicator_message'
      doc: 'Price/volume indicator for the messages coming from BIVA.'
    0x6b:
      id: 'consolidated_execution_of_orders_message'
      doc: 'The message is published when there is a term matching or closing in the electronic system of the BMV or BIVA.'
    0x6e:
      id: 'registration_of_order_message'
      doc: 'When the order is accepted by the central system of the BMV or BIVA, this message is sent to the appropriate media.'
    0x75:
      id: 'cancellations_of_orders_message'
      doc: 'This message deletes the trading floor order.'
    0x6d:
      id: 'last_quote_message'
      doc: 'Message sent by instrument when the best bid is modified in the electronic book by the Origin Exchange; denotes the side that is modified, the sale or the purchase.'
  login_response_status:
    0x41:
      id: 'accepted_session'
      doc: 'Accepted Session'
    0x42:
      id: 'invalid_market_data_group'
      doc: 'Invalid Market Data Group'
    0x43:
      id: 'login_on_another_channel'
      doc: 'Login On Another Channel'
    0x44:
      id: 'unavailable_service'
      doc: 'Unavailable Service'
  replay_response_status:
    0x41:
      id: 'accepted_request'
      doc: 'Accepted Request'
    0x42:
      id: 'invalid_market_data_group'
      doc: 'Invalid Market Data Group'
    0x44:
      id: 'unavailable_service'
      doc: 'Unavailable Service'
    0x45:
      id: 'not_logged_in'
      doc: 'Not Logged In'
    0x46:
      id: 'surpass_requests_limit'
      doc: 'Surpass Requests Limit'
    0x47:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x4a:
      id: 'first_invalid_message'
      doc: 'First Invalid Message'
    0x4b:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
  snapshot_response_status:
    0x41:
      id: 'accepted_request'
      doc: 'Accepted Request'
    0x42:
      id: 'invalid_market_data_group'
      doc: 'Invalid Market Data Group'
    0x44:
      id: 'unavailable_service'
      doc: 'Unavailable Service'
    0x45:
      id: 'not_logged_in'
      doc: 'Not Logged In'
    0x46:
      id: 'surpass_requests_limit'
      doc: 'Surpass Requests Limit'
    0x48:
      id: 'invalid_snapshot_type'
      doc: 'Invalid Snapshot Type'
    0x49:
      id: 'invalid_identifier_instrument'
      doc: 'Invalid Identifier Instrument'
    0x4c:
      id: 'market_data_combination_unavailable_snapshot_type'
      doc: 'Market Data Combination Unavailable Snapshot Type'
    0x4d:
      id: 'empty_information_from_requested_instrument'
      doc: 'Empty Information From Requested Instrument'
    0x53:
      id: 'invalid_sample'
      doc: 'Invalid Sample'
  snapshot_type:
    1:
      id: 'full_depth'
      doc: 'Full Depth'
    2:
      id: 'price_levels'
      doc: 'Price Levels'
    3:
      id: 'best_offers'
      doc: 'Best Offers'
    4:
      id: 'trades'
      doc: 'Trades'
    5:
      id: 'full_depth_tradability_and_trades'
      doc: 'Full Depth Tradability And Trades'
    6:
      id: 'price_levels_tradability_and_trades'
      doc: 'Price Levels Tradability And Trades'
    7:
      id: 'best_offers_and_trades'
      doc: 'Best Offers And Trades'
    8:
      id: 'full_depth_tradability_and_price_setter_trade'
      doc: 'Full Depth Tradability And Price Setter Trade'
    9:
      id: 'price_levels_tradability_and_price_setter_trade'
      doc: 'Price Levels Tradability And Price Setter Trade'
    10:
      id: 'best_offers_and_price_setter_trade'
      doc: 'Best Offers And Price Setter Trade'
    11:
      id: 'general_indices'
      doc: 'General Indices'
    12:
      id: 'price_levels_best_offers_and_tradability'
      doc: 'Price Levels Best Offers And Tradability'
    13:
      id: 'instruments_catalog_consolidated_feed'
      doc: 'Instruments Catalog Consolidated Feed'
    14:
      id: 'trades_consolidated_feed'
      doc: 'Trades Consolidated Feed'
    15:
      id: 'best_offers_consolidated_feed'
      doc: 'Best Offers Consolidated Feed'
    16:
      id: 'full_depth_consolidated_feed'
      doc: 'Full Depth Consolidated Feed'
    17:
      id: 'best_offers_and_trades_consolidated_feed'
      doc: 'Best Offers And Trades Consolidated Feed'
    18:
      id: 'full_depth_and_trades_consolidated_feed'
      doc: 'Full Depth And Trades Consolidated Feed'
    19:
      id: 'agile_snapshot'
      doc: 'Agile Snapshot'
    20:
      id: 'latest_trades'
      doc: 'Latest Trades'
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
  offer_type:
    0x50:
      id: 'public_offering'
      doc: 'Public Offering'
    0x52:
      id: 'registration_operation'
      doc: 'Registration Operation'
    0x43:
      id: 'buy_public_offering'
      doc: 'Buy Public Offering'
    0x41:
      id: 'overallocation'
      doc: 'Overallocation'
    0x53:
      id: 'reciprocal_subscription'
      doc: 'Reciprocal Subscription'
  income:
    0x56:
      id: 'variable_income'
      doc: 'Variable Income'
    0x46:
      id: 'fixed_income'
      doc: 'Fixed Income'
    0x57:
      id: 'warrants'
      doc: 'Warrants'
  movement:
    0x41:
      id: 'registry_operation'
      doc: 'Registry Operation'
    0x55:
      id: 'operation_authorization'
      doc: 'Operation Authorization'
    0x43:
      id: 'placement_operation'
      doc: 'Placement Operation'
    0x42:
      id: 'delete_operation'
      doc: 'Delete Operation'
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
  side:
    0:
      id: 'buy'
      doc: 'O - Buy (the document prints the letter O)'
    1:
      id: 'sell'
      doc: 'Sell'
  offer_direction:
    0x43:
      id: 'buy'
      doc: 'Buy'
    0x56:
      id: 'sell'
      doc: 'Sell'
  currency_type:
    0x4e:
      id: 'mexican_currency'
      doc: 'Mexican Currency'
    0x44:
      id: 'dollar'
      doc: 'Dollar'
  leg_type:
    0x4c:
      id: 'long_leg'
      doc: 'Long Leg'
    0x43:
      id: 'short_leg'
      doc: 'Short Leg'
    0x58:
      id: 'forwards_chain_leg'
      doc: 'Forwards Chain Leg'
    0x50:
      id: 'parent_strategy'
      doc: 'Indicates if its parent strategy'
    0x20:
      id: 'not_generated_from_a_strategy'
      doc: '"" - Fact not generated from a strategy'
  trend:
    0x41:
      id: 'increase'
      doc: 'Increase'
    0x42:
      id: 'decrease'
      doc: 'Decrease'
    0x53:
      id: 'without_change'
      doc: 'Without Change'
    0x20:
      id: 'without_operation'
      doc: 'Without Operation'
  indices_status:
    0x41:
      id: 'previous'
      doc: 'Previous'
    0x50:
      id: 'preliminary'
      doc: 'Preliminary'
    0x43:
      id: 'preliminary_figures'
      doc: 'Preliminary Figures'
    0x44:
      id: 'final_field'
      doc: 'Final'
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
  multiple_type:
    0x45:
      id: 'multiple_of_market_by_transmitter'
      doc: 'Multiple Of Market By Transmitter'
    0x53:
      id: 'multiple_of_market_by_sector'
      doc: 'Multiple Of Market By Sector'
  rebalance:
    0x52:
      id: 'rebalanced'
      doc: 'Rebalanced'
    0x4e:
      id: 'not_rebalanced'
      doc: 'Not Rebalanced'
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
  sending:
    0x41:
      id: 'preopening'
      doc: 'Preopening'
    0x43:
      id: 'after_closing'
      doc: 'After Closing'
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
  indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  type_of_cross_trading:
    0x4f:
      id: 'pre_opening'
      doc: 'Pre Opening'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  direction_of_the_bid:
    0x43:
      id: 'purchase'
      doc: 'Purchase'
    0x56:
      id: 'sale'
      doc: 'Sale'
  client_message_type:
    0x21:
      id: 'login_message'
      doc: 'Logs the consumer in to the replay or snapshot channel.'
    0x23:
      id: 'replay_request_message'
      doc: 'Requests the replay of messages already published on a multicast group.'
    0x24:
      id: 'snapshot_request_message'
      doc: 'Requests a snapshot of a multicast group.'
    0x2d:
      id: 'snapshot_indices_request_message'
      doc: 'Requests a snapshot of an index.'
    0x5f:
      id: 'snapshot_consolidated_feed_request_message'
      doc: 'Requests a snapshot of a Consolidated Feed group.'

