# ---------------------------------------------------------------------
# Kaitai struct definition for: Bme BmeEquities Retail BmeGate v1.6
#
# Protocol:
#   Organization: Bolsas y Mercados Españoles
#   Protocol: BME Equities Retail Top Of Book
#   Encoding: BMEGate Binary Interface
#   Version: 1.6
#   Date: 06/13/2025
#   Specification: BMEGate binary protocol B1.6.pdf
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
  id: bme_bmeequities_retail_bmegate_v1_6
  title: Bme BmeEquities Retail BmeGate v1.6
  license: GPL-3.0
  endian: le

doc: 'Bolsas y Mercados Españoles BME Equities BME Equities Retail Top Of Book BmeGate v1.6'
doc-ref: https://www.meff.es/ing/Technology/Technical-documentation

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Bme BmeGate Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'What every message carries, in either direction: its length and its type. Section 2.1 gives a published message a third field, the sequence number that lets a listener continue an interrupted session without gaps and without repeated messages, and the message tables state it as the message''s own first field - which is where it is declared, since a client''s Logon, Replay Request and Logout do not carry one'
      - id: payload
        size: message_header.message_size - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::logon_response_message': logon_response_message
            'message_type::logout_response_message': logout_response_message
            'message_type::heartbeat_message': heartbeat_message
            'message_type::network_status_message': network_status_message
            'message_type::trading_session_status_message': trading_session_status_message
            'message_type::news_message': news_message
            'message_type::security_list_cancellation_report_message': security_list_cancellation_report_message
            'message_type::statistics_message': statistics_message
            'message_type::security_list_message': security_list_message
            'message_type::security_list_update_report_message': security_list_update_report_message
            'message_type::security_status_message': security_status_message
            'message_type::trade_market_post_transparency_information_topofbook_message': trade_market_post_transparency_information_topofbook_message
            'message_type::trade_trade_amendment_or_cancellation_message': trade_trade_amendment_or_cancellation_message
            'message_type::topofbook_retail_message': topofbook_retail_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of message, including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Message type. Section 3.3 assigns the message code of the equivalent Fix protocol message where there is one, so Logon is 0x41, and gives the rest a hexadecimal value below 0x20 or at or above 0x80'
  logon_response_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: heart_bt_int
        type: u1
        doc: 'Interval at which messages are sent to verify the connection (Heartbeat message) expressed in seconds'
      - id: protocol_version
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identification of the binary protocol version'
      - id: test_production_ind
        type: u1
        enum: test_production_ind
        doc: 'T: Test P: Production'
      - id: environment_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'Environment code'
      - id: session_date
        type: epoch_date
        doc: 'Session Date'
      - id: expected_sequence_number
        type: u4
        doc: 'Requested sequence number'
      - id: sequence_number_to
        type: u4
        doc: 'Actual sequence number corresponding to the Snapshot'
  logout_response_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout reason'
  heartbeat_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
  network_status_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: network_status_value
        type: u1
        enum: network_status_value
        doc: 'Connection status'
  trading_session_status_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        doc: 'Session phase'
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
        doc: 'Trading session status'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
  news_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: news_text
        type: str
        size: 78
        encoding: ASCII
        doc: 'News text'
  security_list_cancellation_report_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: market_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Operating MIC Code'
      - id: market_segment_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Segment MIC Code'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'Instrument ISIN'
  statistics_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: num_statistics_repeating_group
        type: u1
        doc: 'Number of data values'
      - id: statistics_repeating_group
        type: statistics_repeating_group
        repeat: expr
        repeat-expr: num_statistics_repeating_group
        doc: 'Repeating group of the Statistics message, one entry per data value, DataCount entries'
  statistics_repeating_group:
    seq:
      - id: data_code
        type: u1
        enum: data_code
        doc: 'Data field code'
      - id: data_value
        type: s8
        doc: 'Data field value. Its type follows DataCode: P (price, 6 implicit decimals) for D, d, G, H, h, M, Q, Z, z, j, k and n; V (volume, 6 implicit decimals) for J, V, v and W; A (amount, 4 implicit decimals) for E and e; R (rate, 4 implicit decimals) for l, m and R; U (unsigned integer) for f (0 if not end of session) and N'
  security_list_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: market_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Operating MIC Code'
      - id: market_segment_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Segment MIC Code'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'Instrument ISIN'
      - id: fisn
        type: str
        size: 35
        encoding: ASCII
        doc: 'FISN'
      - id: issuer_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Issuer LEI'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Security group'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFICode'
      - id: security_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Security type'
      - id: maturity_date
        type: epoch_date
        doc: 'Expiration date'
      - id: issue_date
        type: epoch_date
        doc: 'Date security issued'
      - id: contract_multiplier
        type: decimal_s8_4
        doc: 'Conversion factor between price units and monetary units. Implied decimal with scale 1e-4'
      - id: li_spre
        type: decimal_s8_4
        doc: 'LIS pretransparency threshold. Implied decimal with scale 1e-4'
      - id: sst_ipre
        type: decimal_s8_4
        doc: 'SSTI pretransparency threshold. Implied decimal with scale 1e-4'
      - id: li_spost
        type: decimal_s8_4
        doc: 'LIS posttransparency threshold. Implied decimal with scale 1e-4'
      - id: sst_ipost
        type: decimal_s8_4
        doc: 'SSTI posttransparency threshold. Implied decimal with scale 1e-4'
      - id: liquid_instrument
        type: u1_nullable
        doc: 'Liquid Instrument. Nullable, No Value = 255'
      - id: admission_requested_by_issuer
        type: u1_nullable
        doc: 'Security request for admission to trading by the issuer. Nullable, No Value = 255'
      - id: min_trade_vol
        type: u4
        doc: 'Minimum Tradeable Volume'
      - id: round_lot
        type: u4
        doc: 'Lot Size'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency code'
      - id: modality_mask_b_4
        type: u4
        doc: 'Modality mask ∑ 2^(ModalityCode - 100) ModalityCode valid values are the TradingSessionID values listed in Table 25 - TradingSessionID in “BMEGate Codification Tables”'
      - id: security_description
        type: str
        size: 80
        encoding: ASCII
        doc: 'Security Description'
      - id: trading_obligation
        type: u1_nullable
        doc: 'Trading obligation. Indicates whether the security has to be traded in a regulated exchange. Nullable, No Value = 255'
      - id: security_name
        type: str
        size: 40
        encoding: ASCII
        doc: 'Security Name'
      - id: net_asset_value_identifier
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net Asset Value Identifier'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Subtype'
      - id: maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security Status'
      - id: strike_price
        type: decimal_s8_6
        doc: 'Exercise price. Only present for warrants. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Number of shares for each security. Implied decimal with scale 1e-4'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise style'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether the contract is a put or a call'
      - id: position_limit
        type: decimal_s8_4
        doc: 'Capital of listed securities. Implied decimal with scale 1e-4'
      - id: nt_position_limit
        type: u8
        doc: 'Volume of listed securities (Near Term Position Limit)'
      - id: issuer
        type: str_12_nullable
        doc: 'Issuer. Nullable, Not Specified = ????????????'
      - id: cp_reg_type
        type: u1_nullable
        doc: 'Indicates if it is an institutional security or not. Nullable, No Value = 255'
      - id: barrier
        type: decimal_s8_6
        doc: 'Barrier. Implied decimal with scale 1e-6'
      - id: last_trading_day
        type: epoch_date
        doc: 'Last Trading Day'
      - id: automatic_expiration
        type: u1_nullable
        doc: 'Automatic Expiration. Nullable, No Value = 255'
      - id: fee_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Fee Type'
      - id: barrier_2
        type: decimal_s8_6
        doc: 'Second Barrier. Implied decimal with scale 1e-6'
      - id: trigger_barrier
        type: decimal_s8_6
        doc: 'Trigger Lower Barrier. Implied decimal with scale 1e-6'
      - id: trigger_upper_barrier
        type: decimal_s8_6
        doc: 'Trigger Upper Barrier. Implied decimal with scale 1e-6'
      - id: average_quarterly_turnover
        type: decimal_s8_4
        doc: 'Average Quarterly Turnover. Implied decimal with scale 1e-4'
      - id: trading_scope
        type: u1
        enum: trading_scope
        doc: 'Trading Scope'
      - id: sicav_counterparty_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'SICAV/Fund Counterparty Member'
      - id: net_asset_value_indicator
        type: u1_nullable
        doc: 'Net Asset Value Indicator. Nullable, No Value = 255'
      - id: reference_trading_venue
        type: u1
        enum: reference_trading_venue
        doc: 'Reference Trading Venue'
      - id: outstanding_capital
        type: decimal_s8_4
        doc: 'Outstanding Capital. Implied decimal with scale 1e-4'
      - id: first_trading_date
        type: epoch_date
        doc: 'First Trading Date'
      - id: settlement_system
        type: u1
        enum: settlement_system
        doc: 'Settlement System'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: number_of_holders
        type: u4
        doc: 'Number of Holders'
      - id: outstanding_shares
        type: u4
        doc: 'Outstanding Number of Shares'
      - id: minimum_authorized_shares
        type: u4
        doc: 'Minimum Authorized Shares'
      - id: minimum_capital
        type: decimal_s8_4
        doc: 'Minimum Capital. Implied decimal with scale 1e-4'
      - id: last_admission_date
        type: epoch_date
        doc: 'Last Trading Date'
      - id: barrier_return
        type: decimal_s8_6
        doc: 'Barrier Return. Implied decimal with scale 1e-6'
      - id: investment_fund_manager
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Manager Denomination'
      - id: effective_amount_filters_routed_orders
        type: decimal_s8_4
        doc: 'Effective amount for filters for routed orders. Implied decimal with scale 1e-4'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: investment_fund_class
        type: u1_nullable
        doc: 'Investment Fund Class. Nullable, No Value = 255'
      - id: master_fund_name
        type: str
        size: 80
        encoding: ASCII
        doc: 'Master Fund Name'
      - id: investment_fund_management_company
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Management Company Name'
      - id: investment_fund_depository
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Depository Entity Name'
      - id: investment_fund_category
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Category'
      - id: investment_fund_minimum_subscription_amount
        type: decimal_s8_4
        doc: 'Investment Fund Minimum Subscription Amount. Implied decimal with scale 1e-4'
      - id: investment_fund_minimum_maintenance_amount
        type: decimal_s8_4
        doc: 'Investment Fund Minimum Maintenance Amount. Implied decimal with scale 1e-4'
      - id: investment_fund_cut_off_time
        type: nanosecond_timestamp
        doc: 'Investment Fund Cut Off Time. Nanoseconds since Unix epoch'
      - id: nav_communication_term
        type: u1
        enum: nav_communication_term
        doc: 'Net Asset Value Communication Term'
      - id: investment_fund_number_of_decimals
        type: u1
        doc: 'Investment Fund Number of Decimals'
      - id: commodity_derivative_indicator
        type: u1
        enum: commodity_derivative_indicator
        doc: 'Commodity Derivative Indicator'
      - id: double_volume_cap_reached
        type: u1_nullable
        doc: 'Double Volume Cap Reached. Nullable, No Value = 255'
      - id: adt
        type: decimal_s8_4
        doc: 'Average Daily Turnover. Implied decimal with scale 1e-4'
      - id: base_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'Base Product'
      - id: sub_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'SubProduct'
      - id: further_sub_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'Further SubProduct'
      - id: adnt
        type: decimal_s8_4
        doc: 'Average Daily Number of Trades. Implied decimal with scale 1e-4'
      - id: price_tick_rule
        type: u1
        enum: price_tick_rule
        doc: 'Price Tick rules for security'
      - id: underlying_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'Underlying Symbol'
      - id: underlying_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying ISIN Code'
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Underlying Strike Currency'
      - id: minimum_display_qty
        type: u4
        doc: 'Minimum Display Volume'
      - id: retail_service_flag
        type: u1_nullable
        doc: 'Availability of Retail Service for the security. Nullable, No Value = 255'
      - id: self_match_prevention
        type: u1_nullable
        doc: 'Indicates whether the security admits self- match prevention. Nullable, No Value = 255'
  security_list_update_report_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: market_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Operating MIC Code'
      - id: market_segment_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Segment MIC Code'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol'
      - id: symbol_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'Instrument ISIN'
      - id: fisn
        type: str
        size: 35
        encoding: ASCII
        doc: 'FISN'
      - id: issuer_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Issuer LEI'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Security group'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFICode'
      - id: security_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Security type'
      - id: maturity_date
        type: epoch_date
        doc: 'Expiration date'
      - id: issue_date
        type: epoch_date
        doc: 'Date security issued'
      - id: contract_multiplier
        type: decimal_s8_4
        doc: 'Conversion factor between price units and monetary units. Implied decimal with scale 1e-4'
      - id: li_spre
        type: decimal_s8_4
        doc: 'LIS pretransparency threshold. Implied decimal with scale 1e-4'
      - id: sst_ipre
        type: decimal_s8_4
        doc: 'SSTI pretransparency threshold. Implied decimal with scale 1e-4'
      - id: li_spost
        type: decimal_s8_4
        doc: 'LIS posttransparency threshold. Implied decimal with scale 1e-4'
      - id: sst_ipost
        type: decimal_s8_4
        doc: 'SSTI posttransparency threshold. Implied decimal with scale 1e-4'
      - id: liquid_instrument
        type: u1_nullable
        doc: 'Liquid Instrument. Nullable, No Value = 255'
      - id: admission_requested_by_issuer
        type: u1_nullable
        doc: 'Security request for admission to trading by the issuer. Nullable, No Value = 255'
      - id: min_trade_vol
        type: u4
        doc: 'Minimum Tradeable Volume'
      - id: round_lot
        type: u4
        doc: 'Lot Size'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency code'
      - id: modality_mask_b_4
        type: u4
        doc: 'Modality mask ∑ 2^(ModalityCode - 100) ModalityCode valid values are the TradingSessionID values listed in Table 25 - TradingSessionID in “BMEGate Codification Tables”'
      - id: security_description
        type: str
        size: 80
        encoding: ASCII
        doc: 'Security Description'
      - id: trading_obligation
        type: u1_nullable
        doc: 'Trading obligation. Indicates whether the security has to be traded in a regulated exchange. Nullable, No Value = 255'
      - id: security_name
        type: str
        size: 40
        encoding: ASCII
        doc: 'Security Name'
      - id: net_asset_value_identifier
        type: str
        size: 7
        encoding: ASCII
        doc: 'Net Asset Value Identifier'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Subtype'
      - id: maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security Status'
      - id: strike_price
        type: decimal_s8_6
        doc: 'Exercise price. Only present for warrants. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Number of shares for each security. Implied decimal with scale 1e-4'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise style'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether the contract is a put or a call'
      - id: position_limit
        type: decimal_s8_4
        doc: 'Capital of listed securities. Implied decimal with scale 1e-4'
      - id: nt_position_limit
        type: u8
        doc: 'Volume of listed securities (Near Term Position Limit)'
      - id: issuer
        type: str_12_nullable
        doc: 'Issuer. Nullable, Not Specified = ????????????'
      - id: cp_reg_type
        type: u1_nullable
        doc: 'Indicates if it is an institutional security or not. Nullable, No Value = 255'
      - id: barrier
        type: decimal_s8_6
        doc: 'Barrier. Implied decimal with scale 1e-6'
      - id: last_trading_day
        type: epoch_date
        doc: 'Last Trading Day'
      - id: automatic_expiration
        type: u1_nullable
        doc: 'Automatic Expiration. Nullable, No Value = 255'
      - id: fee_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Fee Type'
      - id: barrier_2
        type: decimal_s8_6
        doc: 'Second Barrier. Implied decimal with scale 1e-6'
      - id: trigger_barrier
        type: decimal_s8_6
        doc: 'Trigger Lower Barrier. Implied decimal with scale 1e-6'
      - id: trigger_upper_barrier
        type: decimal_s8_6
        doc: 'Trigger Upper Barrier. Implied decimal with scale 1e-6'
      - id: average_quarterly_turnover
        type: decimal_s8_4
        doc: 'Average Quarterly Turnover. Implied decimal with scale 1e-4'
      - id: trading_scope
        type: u1
        enum: trading_scope
        doc: 'Trading Scope'
      - id: sicav_counterparty_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'SICAV/Fund Counterparty Member'
      - id: net_asset_value_indicator
        type: u1_nullable
        doc: 'Net Asset Value Indicator. Nullable, No Value = 255'
      - id: reference_trading_venue
        type: u1
        enum: reference_trading_venue
        doc: 'Reference Trading Venue'
      - id: outstanding_capital
        type: decimal_s8_4
        doc: 'Outstanding Capital. Implied decimal with scale 1e-4'
      - id: first_trading_date
        type: epoch_date
        doc: 'First Trading Date'
      - id: settlement_system
        type: u1
        enum: settlement_system
        doc: 'Settlement System'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: number_of_holders
        type: u4
        doc: 'Number of Holders'
      - id: outstanding_shares
        type: u4
        doc: 'Outstanding Number of Shares'
      - id: minimum_authorized_shares
        type: u4
        doc: 'Minimum Authorized Shares'
      - id: minimum_capital
        type: decimal_s8_4
        doc: 'Minimum Capital. Implied decimal with scale 1e-4'
      - id: last_admission_date
        type: epoch_date
        doc: 'Last Trading Date'
      - id: barrier_return
        type: decimal_s8_6
        doc: 'Barrier Return. Implied decimal with scale 1e-6'
      - id: investment_fund_manager
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Manager Denomination'
      - id: effective_amount_filters_routed_orders
        type: decimal_s8_4
        doc: 'Effective amount for filters for routed orders. Implied decimal with scale 1e-4'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: investment_fund_class
        type: u1_nullable
        doc: 'Investment Fund Class. Nullable, No Value = 255'
      - id: master_fund_name
        type: str
        size: 80
        encoding: ASCII
        doc: 'Master Fund Name'
      - id: investment_fund_management_company
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Management Company Name'
      - id: investment_fund_depository
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Depository Entity Name'
      - id: investment_fund_category
        type: str
        size: 80
        encoding: ASCII
        doc: 'Investment Fund Category'
      - id: investment_fund_minimum_subscription_amount
        type: decimal_s8_4
        doc: 'Investment Fund Minimum Subscription Amount. Implied decimal with scale 1e-4'
      - id: investment_fund_minimum_maintenance_amount
        type: decimal_s8_4
        doc: 'Investment Fund Minimum Maintenance Amount. Implied decimal with scale 1e-4'
      - id: investment_fund_cut_off_time
        type: nanosecond_timestamp
        doc: 'Investment Fund Cut Off Time. Nanoseconds since Unix epoch'
      - id: nav_communication_term
        type: u1
        enum: nav_communication_term
        doc: 'Net Asset Value Communication Term'
      - id: investment_fund_number_of_decimals
        type: u1
        doc: 'Investment Fund Number of Decimals'
      - id: commodity_derivative_indicator
        type: u1
        enum: commodity_derivative_indicator
        doc: 'Commodity Derivative Indicator'
      - id: double_volume_cap_reached
        type: u1_nullable
        doc: 'Double Volume Cap Reached. Nullable, No Value = 255'
      - id: adt
        type: decimal_s8_4
        doc: 'Average Daily Turnover. Implied decimal with scale 1e-4'
      - id: base_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'Base Product'
      - id: sub_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'SubProduct'
      - id: further_sub_product
        type: str
        size: 4
        encoding: ASCII
        doc: 'Further SubProduct'
      - id: adnt
        type: decimal_s8_4
        doc: 'Average Daily Number of Trades. Implied decimal with scale 1e-4'
      - id: price_tick_rule
        type: u1
        enum: price_tick_rule
        doc: 'Price Tick rules for security'
      - id: underlying_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'Underlying Symbol'
      - id: underlying_isin
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying ISIN Code'
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Underlying Strike Currency'
      - id: minimum_display_qty
        type: u4
        doc: 'Minimum Display Volume'
      - id: retail_service_flag
        type: u1_nullable
        doc: 'Availability of Retail Service for the security. Nullable, No Value = 255'
      - id: self_match_prevention
        type: u1_nullable
        doc: 'Indicates whether the security admits self- match prevention. Nullable, No Value = 255'
  security_status_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: reference_price
        type: decimal_s8_6
        doc: 'Reference price. Implied decimal with scale 1e-6'
      - id: static_price
        type: decimal_s8_6
        doc: 'Static Price. Implied decimal with scale 1e-6'
      - id: dynamic_price_oscilation_percentage
        type: decimal_s8_4
        doc: 'Percentage of dynamic range. Implied decimal with scale 1e-4'
      - id: dynamic_range_multiplier
        type: u1
        doc: 'Dynamic Range Multiplier'
      - id: auction_trigger_price
        type: decimal_s8_6
        doc: 'Auction Trigger Price. Implied decimal with scale 1e-6'
      - id: auction_end_time
        type: nanosecond_timestamp
        doc: 'Actual UTC time for the end of the auction. Nanoseconds since Unix epoch'
      - id: liquidative_value_date
        type: epoch_date
        doc: 'Date of the Net Asset Value'
      - id: bonus_warrants_with_active_bonus
        type: u1_nullable
        doc: 'Indicates whether the bonus is active or not (bonus). Nullable, No Value = 255'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Security Trading Status'
      - id: auction_origin
        type: u1
        enum: auction_origin
        doc: 'Auction type'
      - id: non_availability_reason
        type: u1
        enum: non_availability_reason
        doc: 'Reason security halted'
      - id: exemption_situation
        type: u1
        enum: exemption_situation
        doc: 'Type of exemption'
      - id: block_oscilation_percentage
        type: decimal_s8_4
        doc: 'Price fluctuation on bid/ask spread midpoint for agreed blocks. Implied decimal with scale 1e-4'
      - id: high_limit_price
        type: decimal_s8_6
        doc: 'High limit price. Implied decimal with scale 1e-6'
      - id: low_limit_price
        type: decimal_s8_6
        doc: 'Low limit price. Implied decimal with scale 1e-6'
      - id: liquidative_value
        type: decimal_s8_6
        doc: 'Net Asset Value. Implied decimal with scale 1e-6'
      - id: static_range_type
        type: u1
        enum: static_range_type
        doc: 'Static range type'
      - id: order_static_range
        type: decimal_s8_6
        doc: 'Percentage of static range. Implied decimal with scale 1e-6'
      - id: block_static_range
        type: decimal_s8_6
        doc: 'Static range for parametrised blocks. Implied decimal with scale 1e-6'
  trade_market_post_transparency_information_topofbook_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Segment MIC Code'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
      - id: trd_match_id
        type: u4
        doc: 'System Trade Number'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade type'
      - id: last_px
        type: decimal_s8_6
        doc: 'Trade price. Implied decimal with scale 1e-6'
      - id: last_qty
        type: u4
        doc: 'Current trade volume'
      - id: gross_trade_amt
        type: decimal_s8_4
        doc: 'Premium / Trade amount. Implied decimal with scale 1e-4'
      - id: designation
        type: u1
        enum: designation
        doc: 'Trade situation'
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'Market Mechanism'
      - id: algo_flag
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: buyer_bolsa_code
        type: u1
        enum: buyer_bolsa_code
        doc: 'Stock Exchange code of the buyer'
      - id: settl_date
        type: epoch_date
        doc: 'Settlement date'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
  trade_trade_amendment_or_cancellation_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Segment MIC Code'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
      - id: trd_match_id
        type: u4
        doc: 'System Trade Number'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade type'
      - id: last_px
        type: decimal_s8_6
        doc: 'Trade price. Implied decimal with scale 1e-6'
      - id: last_qty
        type: u4
        doc: 'Current trade volume'
      - id: gross_trade_amt
        type: decimal_s8_4
        doc: 'Premium / Trade amount. Implied decimal with scale 1e-4'
      - id: designation
        type: u1
        enum: designation
        doc: 'Trade situation'
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'Market Mechanism'
      - id: algo_flag
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: buyer_bolsa_code
        type: u1
        enum: buyer_bolsa_code
        doc: 'Stock Exchange code of the buyer'
      - id: settl_date
        type: epoch_date
        doc: 'Settlement date'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: last_change_flag
        type: u1_nullable
        doc: 'Indicates if this trade changes the instrument Last price. Nullable, No Value = 255'
      - id: bencrfpt_flag
        type: u1
        enum: bencrfpt_flag
        doc: 'Benchmark or Reference Price Indicator MMT'
      - id: trade_price_condition
        type: u1
        enum: trade_price_condition
        doc: 'MMT 3.8'
      - id: pre_trade_transparency_waiver
        type: u1
        enum: pre_trade_transparency_waiver
        doc: 'Pre-trade transparency waiver'
      - id: deferral_waiver
        type: u1
        enum: deferral_waiver
        doc: 'Deferral Waiver'
      - id: publish_date_and_time
        type: nanosecond_timestamp
        doc: 'Publication Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: trade_date
        type: nanosecond_timestamp
        doc: 'Trade date and time. Nanoseconds since Unix epoch'
      - id: trade_session_date
        type: epoch_date
        doc: 'Trade Session Date'
      - id: volume_float
        type: decimal_u8_6
        doc: 'Volume with decimal places. Implied decimal with scale 1e-6'
      - id: sicav_fund_counterparty_side
        type: u1
        enum: sicav_fund_counterparty_side
        doc: 'Indicates the side of the Counterparty member in a SICAV or Mutual Fund. Nullable, Not Applicable ='
      - id: amended_trade_type
        type: u1
        enum: amended_trade_type
        doc: 'Trade type of the amended/cancelled trade'
      - id: exec_ref_id
        type: u4
        doc: 'System Trade Number of the amended/cancelled trade'
      - id: amended_trade_date
        type: epoch_date
        doc: 'Date of the amended/cancelled trade'
  topofbook_retail_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: bid_orders_1
        type: u2
        doc: 'Buy number of orders'
      - id: bid_size_1
        type: u4
        doc: 'Buy volume'
      - id: bid_px_1
        type: decimal_s8_6_nullable
        doc: 'Buy price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_orders_1
        type: u2
        doc: 'Sell number of orders'
      - id: ask_size_1
        type: u4
        doc: 'Sell volume'
      - id: ask_px_1
        type: decimal_s8_6_nullable
        doc: 'Sell price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
  epoch_date:
    seq:
      - id: days
        type: s4
    instances:
      unix_seconds:
        value: days * 86400
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
  str_12_nullable:
    seq:
      - id: value
        size: 12
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "????????????"
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_s8_6_nullable:
    seq:
      - id: value
        type: decimal_s8_6
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808

enums:
  message_type:
    0x08:
      id: 'logon_response_message'
      doc: 'The Logon Response message is used by the Server to accept a new session. In this message the sequence number will always be 0'
    0x0b:
      id: 'logout_response_message'
      doc: 'The Logout message is used by the Server to notify the end of a session, whether it is solicited or unsolicited. It may also be the answer to a failed logon attempt (see Logon message)'
    0x30:
      id: 'heartbeat_message'
      doc: 'The Heartbeat message is used by the Server to indicate that the communication is active. In the Heartbeat message, the SequenceNumber of the previously received message will be repeated'
    0x0a:
      id: 'network_status_message'
      doc: 'Message sent by the server with information about the connectivity between the Server and the central systems. In the Network Status message, the SequenceNumber of the previously received message will be repeated'
    0x68:
      id: 'trading_session_status_message'
      doc: 'Sent by the server to inform about the session status in each Trading Mode'
    0x42:
      id: 'news_message'
      doc: 'Used by the Server to communicate a Market Surveillance or system-wide text message'
    0x78:
      id: 'security_list_cancellation_report_message'
      doc: 'Message sent by the server for cancelling previously defined securities'
    0x84:
      id: 'statistics_message'
      doc: 'Message sent by the server to inform about closing prices and other statistics'
    0x79:
      id: 'security_list_message'
      doc: 'Message sent by the server to provide the definition of one security. It shares the same layout as the Security List Update Report message, but with a different Message Type'
    0x80:
      id: 'security_list_update_report_message'
      doc: 'Message sent by the server for reporting updates, during the session, to the security definition'
    0x66:
      id: 'security_status_message'
      doc: 'Message sent by the server to inform on the status of one security'
    0x10:
      id: 'trade_market_post_transparency_information_topofbook_message'
      doc: 'Used by the server to communicate trade information related to trades resulting from order matching in channels C/D and E/F. It is also used in channels A/B when the trade is the result of order matching at the end of an auction period (where only top-of-book information is shown)'
    0x18:
      id: 'trade_trade_amendment_or_cancellation_message'
      doc: 'Sent by the server to inform about a trade produced due to any reason other than order matching, also to inform about trades produced due to order matching in a Dark pool. In this message, all fields with the suffix 2 refer to the sell order, and the ones without the suffix refer either to both legs or the buy order'
    0x91:
      id: 'topofbook_retail_message'
      doc: 'Specific message for the Retail Service. This message is sent through the UDP channels G/H'
  test_production_ind:
    0x54:
      id: 'test'
      doc: 'T: Test'
    0x50:
      id: 'production'
      doc: 'P: Production'
  logout_reason:
    0:
      id: 'termination_after_a_solicited_logout_request'
      doc: 'Termination After A Solicited Logout Request'
    1:
      id: 'end_of_session_termination_in_recovery_server_end_of_recovery_snapshot'
      doc: 'End Of Session Termination In Recovery Server End Of Recovery Snapshot'
    2:
      id: 'timeout_connection_lost'
      doc: 'Timeout Connection Lost'
    3:
      id: 'lack_of_heartbeat'
      doc: 'Lack Of Heartbeat'
    16:
      id: 'invalid_username_or_password'
      doc: 'Invalid Username Or Password'
    17:
      id: 'invalid_expected_sequence_number'
      doc: 'Invalid Expected Sequence Number'
    18:
      id: 'invalid_protocol_version'
      doc: 'Invalid Protocol Version'
    19:
      id: 'new_connection_from_user'
      doc: 'New Connection From User'
  network_status_value:
    1:
      id: 'connected'
      doc: 'Connected'
    2:
      id: 'not_connected_down_expected_up'
      doc: 'Not Connected Down Expected Up'
    3:
      id: 'not_connected_down_expected_down'
      doc: 'Not Connected Down Expected Down'
    4:
      id: 'in_process'
      doc: 'In Process'
  trading_session_id:
    100:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    101:
      id: 'fixing'
      doc: 'Fixing'
    102:
      id: 'block_trades'
      doc: 'Block Trades'
    103:
      id: 'special_operations'
      doc: 'Special Operations'
    104:
      id: 'positions_at_net_asset_value'
      doc: 'Positions At Net Asset Value'
    113:
      id: 'fixing_funds'
      doc: 'Fixing Funds'
    119:
      id: 'single_fixing'
      doc: 'Single Fixing'
  trading_session_sub_id:
    1:
      id: 'pre_trading_not_started'
      doc: 'Pre Trading Not Started'
    2:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    3:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    4:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    5:
      id: 'post_trading'
      doc: 'Post Trading'
    6:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    9:
      id: 'unscheduled_intraday_auction'
      doc: 'Unscheduled Intraday Auction'
    100:
      id: 'trading_period_at_closing_price_tal'
      doc: 'Trading Period At Closing Price Tal'
    101:
      id: 'end_of_closing_auction_beginning_of_tal'
      doc: 'End of closing auction and beginning of TAL period for instruments without extension'
    201:
      id: 'publication_of_previous_day_special_operations'
      doc: 'Publication Of Previous Day Special Operations'
    202:
      id: 'not_started'
      doc: 'Not Started'
    203:
      id: 'open'
      doc: 'Open'
    204:
      id: 'closed'
      doc: 'Closed'
  trad_ses_status:
    1:
      id: 'halted'
      doc: 'Halted'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'closed'
      doc: 'Closed'
    4:
      id: 'pre_open_not_started'
      doc: 'Pre Open Not Started'
    5:
      id: 'pre_close'
      doc: 'Pre Close'
    6:
      id: 'request_rejected'
      doc: 'Request Rejected'
  data_code:
    0x44:
      id: 'average_price'
      doc: 'Average Price'
    0x64:
      id: 'previous_forward_price'
      doc: 'Previous forward price'
    0x45:
      id: 'published_cash_amount'
      doc: 'Published cash amount'
    0x65:
      id: 'order_modality_cash_amount'
      doc: 'Order modality cash amount'
    0x66:
      id: 'end_of_session_indicator'
      doc: 'End of session indicator'
    0x47:
      id: 'first'
      doc: 'First'
    0x48:
      id: 'high'
      doc: 'High'
    0x68:
      id: 'maximum_bid'
      doc: 'Maximum Bid'
    0x4a:
      id: 'not_published_volume'
      doc: 'Not published volume'
    0x4d:
      id: 'last'
      doc: 'Last'
    0x4e:
      id: 'number_of_trades'
      doc: 'Number of trades'
    0x51:
      id: 'previous_closing_price'
      doc: 'Previous Closing Price'
    0x52:
      id: 'opening_volatility'
      doc: 'Opening volatility'
    0x56:
      id: 'published_volume'
      doc: 'Published volume'
    0x76:
      id: 'published_volume_order_modality'
      doc: 'Published volume order modality'
    0x57:
      id: 'volume_of_last_trade'
      doc: 'Volume of Last trade'
    0x5a:
      id: 'low'
      doc: 'Low'
    0x7a:
      id: 'minimum_ask'
      doc: 'Minimum Ask'
    0x6a:
      id: 'closing_price'
      doc: 'Closing price'
    0x6b:
      id: 'closing_yield'
      doc: 'Closing yield'
    0x6c:
      id: 'volatility'
      doc: 'Volatility'
    0x6d:
      id: 'delta'
      doc: 'Delta'
    0x6e:
      id: 'forward_price'
      doc: 'Forward price'
  liquid_instrument:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  admission_requested_by_issuer:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  trading_obligation:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  security_status:
    0x31:
      id: 'active'
      doc: 'Active'
    0x32:
      id: 'inactive_provissionaly_assumed'
      doc: 'Inactive Provissionaly Assumed'
  exercise_style:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
    0x42:
      id: 'bermudas'
      doc: 'Bermudas'
    0x4f:
      id: 'others'
      doc: 'Others'
  put_or_call:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4f:
      id: 'other'
      doc: 'Other'
  cp_reg_type:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  automatic_expiration:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  trading_scope:
    1:
      id: 'valencia'
      doc: 'Valencia'
    2:
      id: 'bilbao'
      doc: 'Bilbao'
    3:
      id: 'valencia_and_bilbao'
      doc: 'Valencia And Bilbao'
    4:
      id: 'barcelona'
      doc: 'Barcelona'
    5:
      id: 'valencia_and_barcelona'
      doc: 'Valencia And Barcelona'
    6:
      id: 'bilbao_and_barcelona'
      doc: 'Bilbao And Barcelona'
    7:
      id: 'valencia_bilbao_and_barcelona'
      doc: 'Valencia Bilbao And Barcelona'
    8:
      id: 'madrid'
      doc: 'Madrid'
    9:
      id: 'valencia_and_madrid'
      doc: 'Valencia And Madrid'
  net_asset_value_indicator:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  reference_trading_venue:
    0x31:
      id: 'valencia'
      doc: 'Valencia'
    0x32:
      id: 'bilbao'
      doc: 'Bilbao'
    0x34:
      id: 'barcelona'
      doc: 'Barcelona'
    0x38:
      id: 'madrid'
      doc: 'Madrid'
  settlement_system:
    0x46:
      id: 'iberclear'
      doc: 'Iberclear'
    0x4c:
      id: 'iberclear_latibex'
      doc: 'Iberclear Latibex'
  investment_fund_class:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  nav_communication_term:
    0x31:
      id: 'd_1'
      doc: 'D 1'
    0x32:
      id: 'd_2'
      doc: 'D 2'
    0x33:
      id: 'd_3'
      doc: 'D 3'
  commodity_derivative_indicator:
    0x53:
      id: 'commodity_derivative'
      doc: 'Commodity Derivative'
    0x4e:
      id: 'non_derivative'
      doc: 'Non Derivative'
    0x44:
      id: 'derivative'
      doc: 'Derivative'
  double_volume_cap_reached:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  price_tick_rule:
    1:
      id: 'tick_rule_1'
      doc: '1/10^Numdeci'
    2:
      id: 'tick_rule_2'
      doc: 'P < 50: 1/10^Numdeci; P >= 50: 5/10^Numdeci'
    3:
      id: 'tick_rule_3'
      doc: '5/10^Numdeci'
    4:
      id: 'tick_rule_4'
      doc: 'P < 10: 1/10^Numdeci; 10 <= P > 50: 5/10^Numdeci; 50 <= P > 100: 1/10^(Numdeci-1); P >= 100: 5/10^(Numdeci-1)'
    5:
      id: 'tick_rule_5'
      doc: 'According Tick Size Table in ESMA RTS-11. Tick size depends on Average daily number of transactions (ADNT)'
    6:
      id: 'tick_rule_6'
      doc: 'According Tick Size Table in ESMA RTS-11. ADNT is assumed to be always 0.'
    7:
      id: 'tick_rule_7'
      doc: 'According Tick Size Table in ESMA RTS-11. ADNT is assumed to be always above 9000'
  retail_service_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  self_match_prevention:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  bonus_warrants_with_active_bonus:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  security_trading_status:
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    19:
      id: 'not_traded_on_this_segment'
      doc: 'Not Traded On This Segment'
    20:
      id: 'unknown_or_invalid'
      doc: 'Unknown Or Invalid'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    26:
      id: 'postclose_ready_to_trade_in_tal'
      doc: 'Postclose Ready To Trade In Tal'
    23:
      id: 'fast_market'
      doc: 'Fast Market'
    100:
      id: 'extraordinary_market_conditions'
      doc: 'Extraordinary Market Conditions'
  auction_origin:
    0:
      id: 'no_auction'
      doc: 'No Auction'
    100:
      id: 'manual_auction'
      doc: 'Manual Auction'
    101:
      id: 'opening_auction_is_extended'
      doc: 'Opening Auction Is Extended'
    102:
      id: 'closing_auction_is_extended'
      doc: 'Closing Auction Is Extended'
    103:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    200:
      id: 'other'
      doc: 'Other'
  non_availability_reason:
    0:
      id: 'not_halted'
      doc: 'Not Halted'
    100:
      id: 'halted_by_regulator'
      doc: 'Halted By Regulator'
    101:
      id: 'halted_by_market_surveillance'
      doc: 'Halted By Market Surveillance'
    102:
      id: 'knockout'
      doc: 'Knockout'
    103:
      id: 'knockin_pending'
      doc: 'Knockin Pending'
  exemption_situation:
    0x30:
      id: 'specialists_non_exempted'
      doc: 'Specialists Non Exempted'
    0x31:
      id: 'specialists_exempted_in_the_buy_side'
      doc: 'Specialists Exempted In The Buy Side'
    0x32:
      id: 'specialists_exempted_in_the_sell_side'
      doc: 'Specialists Exempted In The Sell Side'
    0x33:
      id: 'specialists_exempted_in_both_sides_buy_and_sell'
      doc: 'Specialists Exempted In Both Sides Buy And Sell'
  static_range_type:
    0x50:
      id: 'percentage'
      doc: 'Percentage'
    0x54:
      id: 'price'
      doc: 'Price'
  trade_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x58:
      id: 'cancellation'
      doc: 'Cancellation'
    0x54:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x48:
      id: 'block_trade'
      doc: 'Block Trade'
    0x31:
      id: 'communicated_application'
      doc: 'Communicated Application'
    0x32:
      id: 'authorised_application_trades'
      doc: 'Authorised Application Trades'
    0x33:
      id: 'authorised_application_corporate_interest'
      doc: 'Authorised Application Corporate Interest'
    0x34:
      id: 'authorised_application_execution_of_contracts'
      doc: 'Authorised Application Execution Of Contracts'
    0x35:
      id: 'authorised_application_other_causes'
      doc: 'Authorised Application Other Causes'
    0x36:
      id: 'validation_communicated'
      doc: 'Validation Communicated'
    0x37:
      id: 'authorised_validation_trades'
      doc: 'Authorised validation (trades)'
    0x38:
      id: 'authorised_validation_corporate_interest'
      doc: 'Authorised validation (corporate interest)'
    0x39:
      id: 'authorised_validation_execution_of_contracts'
      doc: 'Authorised validation (execution of contracts)'
    0x30:
      id: 'authorised_validation_other_causes'
      doc: 'Authorised validation (other causes)'
    0x41:
      id: 'transaction_between_members_communicated'
      doc: 'Transaction between members (communicated)'
    0x42:
      id: 'transaction_between_members_trades'
      doc: 'Transaction between members (trades)'
    0x43:
      id: 'transaction_between_members_corporate_interest'
      doc: 'Transaction between members (corporate interest)'
    0x46:
      id: 'transaction_between_members_execution_of_contracts'
      doc: 'Transaction between members (execution of contracts)'
    0x47:
      id: 'transaction_between_members_other_causes'
      doc: 'Transaction between members (other causes)'
    0x49:
      id: 'application_to_cater_for_a_linked_position'
      doc: 'Application to cater for a linked position'
    0x4a:
      id: 'transaction_to_cater_for_a_linked_position'
      doc: 'Transaction to cater for a linked position'
    0x45:
      id: 'transaction_of_exercise_of_options'
      doc: 'Transaction of exercise of options'
    0x4e:
      id: 'public_share_bid_offer_type_transaction'
      doc: 'Public share bid offer type transaction'
    0x4f:
      id: 'public_share_ask_offer_type_transaction'
      doc: 'Public share Ask offer type transaction'
    0x50:
      id: 'public_share_subscription_offer_type_transaction'
      doc: 'Public share subscription offer type transaction'
    0x4c:
      id: 'special_trades_delta_type'
      doc: 'Special trades delta type'
    0x61:
      id: 'net_asset_value_special_trade_d_plus_1'
      doc: 'Net asset value special trade D+1'
    0x62:
      id: 'net_asset_value_special_trade_d_plus_2'
      doc: 'Net asset value special trade D+2'
    0x63:
      id: 'net_asset_value_special_trade_d_plus_3'
      doc: 'Net asset value special trade D+3'
    0x44:
      id: 'application_without_ccp'
      doc: 'Application (without CCP)'
    0x4b:
      id: 'transaction_without_ccp'
      doc: 'Transaction (without CCP)'
    0x64:
      id: 'investment_fund_d_plus_1'
      doc: 'Investment Fund D + 1'
    0x65:
      id: 'investment_fund_d_plus_2'
      doc: 'Investment Fund D + 2'
    0x66:
      id: 'investment_fund_d_plus_3'
      doc: 'Investment Fund D + 3'
    0x57:
      id: 'vwap'
      doc: 'VWAP'
  designation:
    0x31:
      id: 'trade_during_open_market'
      doc: 'Trade During Open Market'
    0x32:
      id: 'trade_during_opening_auction'
      doc: 'Trade During Opening Auction'
    0x33:
      id: 'trade_during_closing_auction'
      doc: 'Trade During Closing Auction'
    0x34:
      id: 'trade_during_volatility_auction'
      doc: 'Trade During Volatility Auction'
    0x35:
      id: 'trade_during_manual_auction'
      doc: 'Trade During Manual Auction'
    0x36:
      id: 'trade_during_opening_auction_extension'
      doc: 'Trade During Opening Auction Extension'
    0x37:
      id: 'trade_during_closing_auction_extension'
      doc: 'Trade During Closing Auction Extension'
    0x38:
      id: 'trade_during_tal_period'
      doc: 'Trade During Tal Period'
    0x43:
      id: 'trade_in_spain_at_mid_dark_book'
      doc: 'Trade In Spain At Mid Dark Book'
  market_mechanism:
    0x30:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x34:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x31:
      id: 'off_book_messaging_trading'
      doc: 'Off Book Messaging Trading'
    0x35:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  algo_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  buyer_bolsa_code:
    0x33:
      id: 'valencia'
      doc: 'Valencia'
    0x34:
      id: 'barcelona'
      doc: 'Barcelona'
    0x35:
      id: 'bilbao'
      doc: 'Bilbao'
    0x36:
      id: 'madrid'
      doc: 'Madrid'
  transaction_category:
    0x20:
      id: 'normal_category'
      doc: 'Normal Category'
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
  last_change_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  bencrfpt_flag:
    0x20:
      id: 'normal_trade'
      doc: 'Normal Trade'
    0x36:
      id: 'benchmark_trade_benc'
      doc: 'Benchmark Trade Benc'
    0x33:
      id: 'reference_price_trade_rfpt'
      doc: 'Reference Price Trade Rfpt'
    0x43:
      id: 'contingency_trade_cont'
      doc: 'Contingency Trade Cont'
    0x4d:
      id: 'benc_cont'
      doc: 'Benc Cont'
  trade_price_condition:
    0x20:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
    0x35:
      id: 'non_price_forming_trade_formerly_defined_as_a_technical_trade_npft'
      doc: 'Non Price Forming Trade Formerly Defined As A Technical Trade Npft'
    0x36:
      id: 'trade_not_contributing_to_price_discovery_tncp'
      doc: 'Trade not Contributing to the Price Discovery Process (formerly defined as a Technical Trade) "TNCP" to be discontinued as of 1st January 2024'
  pre_trade_transparency_waiver:
    0x30:
      id: 'negotiated_trade_in_liquid_financial_instruments_nliq'
      doc: 'Negotiated Trade In Liquid Financial Instruments Nliq'
    0x31:
      id: 'negotiated_trade_in_illiquid_financial_instruments_oilq'
      doc: 'Negotiated Trade In Illiquid Financial Instruments Oilq'
    0x32:
      id: 'negotiated_trade_other_than_current_market_price_pric'
      doc: 'Negotiated Trade Subject to Conditions Other Than The Current Market Price "PRIC"'
  deferral_waiver:
    0x20:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
  sicav_fund_counterparty_side:
    0x31:
      id: 'buyer'
      doc: 'Buyer'
    0x32:
      id: 'seller'
      doc: 'Seller'
  amended_trade_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x58:
      id: 'cancellation'
      doc: 'Cancellation'
    0x54:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x48:
      id: 'block_trade'
      doc: 'Block Trade'
    0x31:
      id: 'communicated_application'
      doc: 'Communicated Application'
    0x32:
      id: 'authorised_application_trades'
      doc: 'Authorised Application Trades'
    0x33:
      id: 'authorised_application_corporate_interest'
      doc: 'Authorised Application Corporate Interest'
    0x34:
      id: 'authorised_application_execution_of_contracts'
      doc: 'Authorised Application Execution Of Contracts'
    0x35:
      id: 'authorised_application_other_causes'
      doc: 'Authorised Application Other Causes'
    0x36:
      id: 'validation_communicated'
      doc: 'Validation Communicated'
    0x37:
      id: 'authorised_validation_trades'
      doc: 'Authorised validation (trades)'
    0x38:
      id: 'authorised_validation_corporate_interest'
      doc: 'Authorised validation (corporate interest)'
    0x39:
      id: 'authorised_validation_execution_of_contracts'
      doc: 'Authorised validation (execution of contracts)'
    0x30:
      id: 'authorised_validation_other_causes'
      doc: 'Authorised validation (other causes)'
    0x41:
      id: 'transaction_between_members_communicated'
      doc: 'Transaction between members (communicated)'
    0x42:
      id: 'transaction_between_members_trades'
      doc: 'Transaction between members (trades)'
    0x43:
      id: 'transaction_between_members_corporate_interest'
      doc: 'Transaction between members (corporate interest)'
    0x46:
      id: 'transaction_between_members_execution_of_contracts'
      doc: 'Transaction between members (execution of contracts)'
    0x47:
      id: 'transaction_between_members_other_causes'
      doc: 'Transaction between members (other causes)'
    0x49:
      id: 'application_to_cater_for_a_linked_position'
      doc: 'Application to cater for a linked position'
    0x4a:
      id: 'transaction_to_cater_for_a_linked_position'
      doc: 'Transaction to cater for a linked position'
    0x45:
      id: 'transaction_of_exercise_of_options'
      doc: 'Transaction of exercise of options'
    0x4e:
      id: 'public_share_bid_offer_type_transaction'
      doc: 'Public share bid offer type transaction'
    0x4f:
      id: 'public_share_ask_offer_type_transaction'
      doc: 'Public share Ask offer type transaction'
    0x50:
      id: 'public_share_subscription_offer_type_transaction'
      doc: 'Public share subscription offer type transaction'
    0x4c:
      id: 'special_trades_delta_type'
      doc: 'Special trades delta type'
    0x61:
      id: 'net_asset_value_special_trade_d_plus_1'
      doc: 'Net asset value special trade D+1'
    0x62:
      id: 'net_asset_value_special_trade_d_plus_2'
      doc: 'Net asset value special trade D+2'
    0x63:
      id: 'net_asset_value_special_trade_d_plus_3'
      doc: 'Net asset value special trade D+3'
    0x44:
      id: 'application_without_ccp'
      doc: 'Application (without CCP)'
    0x4b:
      id: 'transaction_without_ccp'
      doc: 'Transaction (without CCP)'
    0x64:
      id: 'investment_fund_d_plus_1'
      doc: 'Investment Fund D + 1'
    0x65:
      id: 'investment_fund_d_plus_2'
      doc: 'Investment Fund D + 2'
    0x66:
      id: 'investment_fund_d_plus_3'
      doc: 'Investment Fund D + 3'
    0x57:
      id: 'vwap'
      doc: 'VWAP'

