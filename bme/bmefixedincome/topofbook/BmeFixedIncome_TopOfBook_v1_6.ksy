# ---------------------------------------------------------------------
# Kaitai struct definition for: Bme BmeFixedIncome TopOfBook BmeGate v1.6
#
# Protocol:
#   Organization: Bolsas y Mercados Españoles
#   Protocol: BME Fixed Income Top Of Book
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
  id: bme_bmefixedincome_topofbook_bmegate_v1_6
  title: Bme BmeFixedIncome TopOfBook BmeGate v1.6
  license: GPL-3.0
  endian: le

doc: 'Bolsas y Mercados Españoles BME Fixed Income BME Fixed Income Top Of Book BmeGate v1.6'
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
            'message_type::trade_market_post_transparency_information_top_of_book_message': trade_market_post_transparency_information_top_of_book_message
            'message_type::trade_trade_amendment_or_cancellation_message': trade_trade_amendment_or_cancellation_message
            'message_type::indication_of_interest_message': indication_of_interest_message
            'message_type::rfq_market_pre_transparency_information_message': rfq_market_pre_transparency_information_message
            'message_type::top_of_book_message': top_of_book_message
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
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security Status'
      - id: coupon_payment_date
        type: epoch_date
        doc: 'Coupon Payment Date'
      - id: min_price_increment
        type: decimal_s8_6
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-6'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: coupon_rate
        type: decimal_s8_4
        doc: 'Coupon Rate. Implied decimal with scale 1e-4'
      - id: issuer
        type: str_12_nullable
        doc: 'Issuer. Nullable, Not Specified = ????????????'
      - id: trading_scope_b_1
        type: u1
        doc: 'Trading Scope'
      - id: first_trading_date
        type: epoch_date
        doc: 'First Trading Date'
      - id: settlement_system
        type: u1
        enum: settlement_system
        doc: 'Settlement System'
      - id: maturity
        type: decimal_s8_6
        doc: 'Maturity Price. Implied decimal with scale 1e-6'
      - id: coupon_periodicity
        type: u1
        doc: 'Coupon Periodicity in Number of Months'
      - id: benchmark
        type: u1_nullable
        doc: 'Benchmark. Nullable, No Value = 255'
      - id: strippable
        type: u1_nullable
        doc: 'Strippable. Nullable, No Value = 255'
      - id: volume_issued
        type: decimal_s8_4
        doc: 'Volume Issued. Implied decimal with scale 1e-4'
      - id: alive_volume
        type: decimal_s8_4
        doc: 'Alive Volume. Implied decimal with scale 1e-4'
      - id: coupon_type
        type: u1
        enum: coupon_type
        doc: 'Coupon Type. Nullable, Not Applicable ='
      - id: coupon_quotation
        type: u1_nullable
        doc: 'Coupon Quotation. Nullable, No Value = 255'
      - id: accrued_interest_calculation_procedure
        type: u1
        enum: accrued_interest_calculation_procedure
        doc: 'Accrued Interest Calculation Procedure'
      - id: next_redemption_date
        type: epoch_date
        doc: 'Next Redemption Date'
      - id: type_of_redemption
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type Of Redemption'
      - id: facial
        type: decimal_s8_4
        doc: 'Facial. Implied decimal with scale 1e-4'
      - id: calculation_method
        type: u1
        enum: calculation_method
        doc: 'Calculation Method'
      - id: date_last_coupon_was_paid
        type: epoch_date
        doc: 'Date Last Coupon Was Paid'
      - id: bond_seniority
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bond Seniority'
      - id: interest_accrual_date
        type: epoch_date
        doc: 'Start date for the coupon yield'
      - id: start_date
        type: epoch_date
        doc: 'Value date'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Price Type'
      - id: spread_to_index
        type: decimal_s8_4
        doc: 'Spread To Index. Implied decimal with scale 1e-4'
      - id: benchmark_curve_points_units
        type: str
        size: 4
        encoding: ASCII
        doc: 'Benchmark Curve Point for Index term'
      - id: benchmark_curve_points_value
        type: u1
        doc: 'Benchmark Curve Point for Index term'
      - id: benchmark_security_id
        type: str
        size: 25
        encoding: ASCII
        doc: 'Benchmark Security ID'
      - id: accrued_interest_rate_r_8
        type: decimal_s8_4
        doc: 'Accrued Interest Rate. Implied decimal with scale 1e-4'
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
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security Status'
      - id: coupon_payment_date
        type: epoch_date
        doc: 'Coupon Payment Date'
      - id: min_price_increment
        type: decimal_s8_6
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-6'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: coupon_rate
        type: decimal_s8_4
        doc: 'Coupon Rate. Implied decimal with scale 1e-4'
      - id: issuer
        type: str_12_nullable
        doc: 'Issuer. Nullable, Not Specified = ????????????'
      - id: trading_scope_b_1
        type: u1
        doc: 'Trading Scope'
      - id: first_trading_date
        type: epoch_date
        doc: 'First Trading Date'
      - id: settlement_system
        type: u1
        enum: settlement_system
        doc: 'Settlement System'
      - id: maturity
        type: decimal_s8_6
        doc: 'Maturity Price. Implied decimal with scale 1e-6'
      - id: coupon_periodicity
        type: u1
        doc: 'Coupon Periodicity in Number of Months'
      - id: benchmark
        type: u1_nullable
        doc: 'Benchmark. Nullable, No Value = 255'
      - id: strippable
        type: u1_nullable
        doc: 'Strippable. Nullable, No Value = 255'
      - id: volume_issued
        type: decimal_s8_4
        doc: 'Volume Issued. Implied decimal with scale 1e-4'
      - id: alive_volume
        type: decimal_s8_4
        doc: 'Alive Volume. Implied decimal with scale 1e-4'
      - id: coupon_type
        type: u1
        enum: coupon_type
        doc: 'Coupon Type. Nullable, Not Applicable ='
      - id: coupon_quotation
        type: u1_nullable
        doc: 'Coupon Quotation. Nullable, No Value = 255'
      - id: accrued_interest_calculation_procedure
        type: u1
        enum: accrued_interest_calculation_procedure
        doc: 'Accrued Interest Calculation Procedure'
      - id: next_redemption_date
        type: epoch_date
        doc: 'Next Redemption Date'
      - id: type_of_redemption
        type: str
        size: 2
        encoding: ASCII
        doc: 'Type Of Redemption'
      - id: facial
        type: decimal_s8_4
        doc: 'Facial. Implied decimal with scale 1e-4'
      - id: calculation_method
        type: u1
        enum: calculation_method
        doc: 'Calculation Method'
      - id: date_last_coupon_was_paid
        type: epoch_date
        doc: 'Date Last Coupon Was Paid'
      - id: bond_seniority
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bond Seniority'
      - id: interest_accrual_date
        type: epoch_date
        doc: 'Start date for the coupon yield'
      - id: start_date
        type: epoch_date
        doc: 'Value date'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Price Type'
      - id: spread_to_index
        type: decimal_s8_4
        doc: 'Spread To Index. Implied decimal with scale 1e-4'
      - id: benchmark_curve_points_units
        type: str
        size: 4
        encoding: ASCII
        doc: 'Benchmark Curve Point for Index term'
      - id: benchmark_curve_points_value
        type: u1
        doc: 'Benchmark Curve Point for Index term'
      - id: benchmark_security_id
        type: str
        size: 25
        encoding: ASCII
        doc: 'Benchmark Security ID'
      - id: accrued_interest_rate_r_8
        type: decimal_s8_4
        doc: 'Accrued Interest Rate. Implied decimal with scale 1e-4'
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
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Security Trading Status'
      - id: non_availability_reason
        type: u1
        enum: non_availability_reason
        doc: 'Reason security halted'
      - id: high_limit_price
        type: decimal_s8_6
        doc: 'High limit price. Implied decimal with scale 1e-6'
      - id: low_limit_price
        type: decimal_s8_6
        doc: 'Low limit price. Implied decimal with scale 1e-6'
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
  trade_market_post_transparency_information_top_of_book_message:
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
      - id: alt_last_px
        type: decimal_s8_6
        doc: 'Trade yield or percent of par. Implied decimal with scale 1e-6'
      - id: accrued_interest_amt
        type: decimal_s8_4
        doc: 'Accrued Interest amount. Implied decimal with scale 1e-4'
      - id: accrued_interest_rate_p_8
        type: decimal_s8_6
        doc: 'Interest rate of coupon. Implied decimal with scale 1e-6'
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
      - id: alt_last_px
        type: decimal_s8_6
        doc: 'Trade yield or percent of par. Implied decimal with scale 1e-6'
      - id: accrued_interest_amt
        type: decimal_s8_4
        doc: 'Accrued Interest amount. Implied decimal with scale 1e-4'
      - id: accrued_interest_rate_p_8
        type: decimal_s8_6
        doc: 'Interest rate of coupon. Implied decimal with scale 1e-6'
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
      - id: benc_rfpt_flag
        type: u1
        enum: benc_rfpt_flag
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
      - id: post_deferral_publication_type
        type: u1
        enum: post_deferral_publication_type
        doc: 'Post-deferral publication type'
      - id: publish_date_and_time
        type: nanosecond_timestamp
        doc: 'Publication Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: trade_date
        type: nanosecond_timestamp
        doc: 'Trade date and time. Nanoseconds since Unix epoch'
      - id: trade_session_date
        type: epoch_date
        doc: 'Trade Session Date'
      - id: settl_date_2
        type: epoch_date
        doc: 'Settlement date of the second leg'
      - id: end_cash
        type: decimal_s8_4
        doc: 'Amount to be settled at the end of the Repo Trade. Implied decimal with scale 1e-4'
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
  indication_of_interest_message:
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
      - id: ioiid
        type: u4
        doc: 'RFQ identifier'
      - id: ioi_trans_type
        type: u1
        enum: ioi_trans_type
        doc: 'Message type'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: ioi_qty
        type: u4
        doc: 'Requested indicative volume'
      - id: ioi_price
        type: decimal_s8_6
        doc: 'Requested indicative price. Implied decimal with scale 1e-6'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
  rfq_market_pre_transparency_information_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: rfqid
        type: u4
        doc: 'RFQ identifier'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: mid_buy_price
        type: decimal_s8_6
        doc: 'Mid price of buying RFQs. Implied decimal with scale 1e-6'
      - id: mid_buy_volume
        type: u4
        doc: 'Mid volume of buying RFQs'
      - id: buy_rf_qs_number
        type: u2
        doc: 'Number of buying RFQs'
      - id: mid_sell_price
        type: decimal_s8_6
        doc: 'Mid price of selling RFQs. Implied decimal with scale 1e-6'
      - id: mid_sell_volume
        type: u4
        doc: 'Mid volume of selling RFQs'
      - id: sell_rf_qs_number
        type: u2
        doc: 'Number of selling RFQs'
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
      - id: bid_orders_2
        type: u2
        doc: 'Buy number of orders level 2'
      - id: bid_size_2
        type: u4
        doc: 'Buy volume level 2'
      - id: bid_px_2
        type: decimal_s8_6_nullable
        doc: 'Buy price level 2. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_orders_2
        type: u2
        doc: 'Sell number of orders level 2'
      - id: ask_size_2
        type: u4
        doc: 'Sell volume level 2'
      - id: ask_px_2
        type: decimal_s8_6_nullable
        doc: 'Sell price level 2. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: bid_orders_3
        type: u2
        doc: 'Buy number of orders level 3'
      - id: bid_size_3
        type: u4
        doc: 'Buy volume level 3'
      - id: bid_px_3
        type: decimal_s8_6_nullable
        doc: 'Buy price level 3. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_orders_3
        type: u2
        doc: 'Sell number of orders level 3'
      - id: ask_size_3
        type: u4
        doc: 'Sell volume level 3'
      - id: ask_px_3
        type: decimal_s8_6_nullable
        doc: 'Sell price level 3. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: bid_orders_4
        type: u2
        doc: 'Buy number of orders level 4'
      - id: bid_size_4
        type: u4
        doc: 'Buy volume level 4'
      - id: bid_px_4
        type: decimal_s8_6_nullable
        doc: 'Buy price level 4. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_orders_4
        type: u2
        doc: 'Sell number of orders level 4'
      - id: ask_size_4
        type: u4
        doc: 'Sell volume level 4'
      - id: ask_px_4
        type: decimal_s8_6_nullable
        doc: 'Sell price level 4. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: bid_orders_5
        type: u2
        doc: 'Buy number of orders level 5'
      - id: bid_size_5
        type: u4
        doc: 'Buy volume level 5'
      - id: bid_px_5
        type: decimal_s8_6_nullable
        doc: 'Buy price level 5. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_orders_5
        type: u2
        doc: 'Sell number of orders level 5'
      - id: ask_size_5
        type: u4
        doc: 'Sell volume level 5'
      - id: ask_px_5
        type: decimal_s8_6_nullable
        doc: 'Sell price level 5. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
  top_of_book_message:
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
      - id: alt_bid_px_1
        type: decimal_s8_6
        doc: 'Alternate buy price 1. Implied decimal with scale 1e-6'
      - id: ask_orders_1
        type: u2
        doc: 'Sell number of orders'
      - id: ask_size_1
        type: u4
        doc: 'Sell volume'
      - id: ask_px_1
        type: decimal_s8_6_nullable
        doc: 'Sell price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: alt_sell_px_1
        type: decimal_s8_6
        doc: 'Alternate sell price 1. Implied decimal with scale 1e-6'
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
      id: 'trade_market_post_transparency_information_top_of_book_message'
      doc: 'Used by the server to communicate trade information related to trades resulting from order matching in channels C/D and E/F. It is also used in channels A/B when the trade is the result of order matching at the end of an auction period (where only top-of-book information is shown)'
    0x18:
      id: 'trade_trade_amendment_or_cancellation_message'
      doc: 'Sent by the server to inform about a trade produced due to any reason other than order matching, also to inform about trades produced due to order matching in a Dark pool. In this message, all fields with the suffix 2 refer to the sell order, and the ones without the suffix refer either to both legs or the buy order'
    0x36:
      id: 'indication_of_interest_message'
      doc: 'Used by the Server to notify an indication of interest on a specific instrument. This functionality is available in Fixed Income and Derivatives'
    0x85:
      id: 'rfq_market_pre_transparency_information_message'
      doc: 'Used by the server to communicate price information about RFQs. The contents of the RFQID field match those of the field IOIID in the corresponding Indication of Interest message'
    0x82:
      id: 'top_of_book_message'
      doc: 'Used by the UDP Servers to communicate Top-of-book price information during auctions. When there is an indicative match price, the fields BidPx1 and AskPx1 will have the same value'
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
    102:
      id: 'block_trades'
      doc: 'Block Trades'
    111:
      id: 'repo_cross_trades_within_the_member_and_repo_block_trading'
      doc: 'Repo Cross Trades Within The Member And Repo Block Trading'
    114:
      id: 'rfq'
      doc: 'Rfq'
  trading_session_sub_id:
    1:
      id: 'pre_trading_not_started'
      doc: 'Pre Trading Not Started'
    3:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    5:
      id: 'post_trading'
      doc: 'Post Trading'
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
  settlement_system:
    0x41:
      id: 'iberclear_cade'
      doc: 'Iberclear Cade'
    0x44:
      id: 'dlt_bme'
      doc: 'Dlt Bme'
    0x4f:
      id: 'other'
      doc: 'Other'
  benchmark:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  strippable:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  coupon_type:
    0x46:
      id: 'fixed_field'
      doc: 'Fixed'
    0x56:
      id: 'variable'
      doc: 'Variable'
  coupon_quotation:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  accrued_interest_calculation_procedure:
    0x31:
      id: 'real_base'
      doc: 'Real Base'
  calculation_method:
    0x30:
      id: 'thirty_360_us_nasd'
      doc: '30/360 (US-NASD)'
    0x31:
      id: 'actual_actual'
      doc: 'Actual Actual'
    0x32:
      id: 'actual_360'
      doc: 'Actual 360'
    0x33:
      id: 'actual_365'
      doc: 'Actual 365'
    0x34:
      id: 'thirty_360_european'
      doc: '30/360 (European)'
    0x35:
      id: 'if_days_to_maturity_365_actual_360_else_actual_365'
      doc: 'If Days To Maturity 365 Actual 360 Else Actual 365'
  price_type:
    0x31:
      id: 'price'
      doc: 'Price'
    0x32:
      id: 'rate'
      doc: 'Rate'
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
      id: 'post_close_ready_to_trade_in_tal'
      doc: 'Post Close Ready To Trade In Tal'
    23:
      id: 'fast_market'
      doc: 'Fast Market'
    100:
      id: 'extraordinary_market_conditions'
      doc: 'Extraordinary Market Conditions'
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
      id: 'knock_out'
      doc: 'Knock Out'
    103:
      id: 'knock_in_pending'
      doc: 'Knock In Pending'
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
    0x4b:
      id: 'block_trade'
      doc: 'Block Trade'
    0x58:
      id: 'cancellation'
      doc: 'Cancellation'
    0x54:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x51:
      id: 'application'
      doc: 'Application'
    0x41:
      id: 'block_trade_with_settlement_date_equal_to_session_date'
      doc: 'Block Trade With Settlement Date Equal To Session Date'
    0x42:
      id: 'application_with_settlement_date_equal_to_session_date'
      doc: 'Application With Settlement Date Equal To Session Date'
    0x43:
      id: 'repo_block_trade'
      doc: 'Repo Block Trade'
    0x44:
      id: 'repo_application'
      doc: 'Repo Application'
    0x45:
      id: 'repo_block_trade_with_start_date_equal_to_session_date'
      doc: 'Repo Block Trade With Start Date Equal To Session Date'
    0x46:
      id: 'repo_application_with_start_date_equal_to_session_date'
      doc: 'Repo Application With Start Date Equal To Session Date'
    0x33:
      id: 'rfq'
      doc: 'Rfq'
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
    0x31:
      id: 'off_book_messaging_trading'
      doc: 'Off Book Messaging Trading'
    0x36:
      id: 'request_for_quotes'
      doc: 'Request For Quotes'
  algo_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  transaction_category:
    0x20:
      id: 'normal_category'
      doc: 'Normal Category'
    0x5a:
      id: 'package_trade_excluding_exchange_for_physicals_tpac'
      doc: 'Package Trade Excluding Exchange For Physicals Tpac'
  last_change_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  benc_rfpt_flag:
    0x20:
      id: 'normal_trade'
      doc: 'Normal Trade'
    0x36:
      id: 'benchmark_trade_benc'
      doc: 'Benchmark Trade Benc'
  trade_price_condition:
    0x20:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
    0x35:
      id: 'non_price_forming_trade_formerly_defined_as_a_technical_trade_npft'
      doc: 'Non Price Forming Trade Formerly Defined As A Technical Trade Npft'
    0x5a:
      id: 'price_is_not_applicable_noap'
      doc: 'Price Is Not Applicable Noap'
  pre_trade_transparency_waiver:
    0x20:
      id: 'negotiated_trade_nego'
      doc: 'Negotiated Trade Nego'
  deferral_waiver:
    0x20:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
    0x41:
      id: 'non_immediate_publication_deferral_for_medium_size_liquid_market_mlf_1'
      doc: 'Non Immediate Publication Deferral For Medium Size Liquid Market Mlf 1'
    0x42:
      id: 'non_immediate_publication_deferral_for_medium_size_illiquid_market_mif_2'
      doc: 'Non Immediate Publication Deferral For Medium Size Illiquid Market Mif 2'
    0x43:
      id: 'non_immediate_publication_deferral_for_large_size_liquid_market_llf_3'
      doc: 'Non Immediate Publication Deferral For Large Size Liquid Market Llf 3'
    0x44:
      id: 'non_immediate_publication_deferral_for_large_size_illiquid_market_lif_4'
      doc: 'Non Immediate Publication Deferral For Large Size Illiquid Market Lif 4'
    0x45:
      id: 'non_immediate_publication_deferral_for_very_large_size_liquid_market_vlf_5'
      doc: 'Non Immediate Publication Deferral For Very Large Size Liquid Market Vlf 5'
    0x46:
      id: 'non_immediate_publication_deferral_for_very_large_size_illiquid_market_vif_5'
      doc: 'Non Immediate Publication Deferral For Very Large Size Illiquid Market Vif 5'
    0x47:
      id: 'deferral_for_etcs_etns_sfps_emission_allowances_deff'
      doc: 'Non-Immediate Publication: Deferral for ETCs, ETNs, SFPs, Emission Allowances "DEFF"'
  post_deferral_publication_type:
    0x20:
      id: 'not_applicable_no_relevant_deferral_or_enrichment_type'
      doc: 'Not Applicable No Relevant Deferral Or Enrichment Type'
  amended_trade_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4b:
      id: 'block_trade'
      doc: 'Block Trade'
    0x58:
      id: 'cancellation'
      doc: 'Cancellation'
    0x54:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x51:
      id: 'application'
      doc: 'Application'
    0x41:
      id: 'block_trade_with_settlement_date_equal_to_session_date'
      doc: 'Block Trade With Settlement Date Equal To Session Date'
    0x42:
      id: 'application_with_settlement_date_equal_to_session_date'
      doc: 'Application With Settlement Date Equal To Session Date'
    0x43:
      id: 'repo_block_trade'
      doc: 'Repo Block Trade'
    0x44:
      id: 'repo_application'
      doc: 'Repo Application'
    0x45:
      id: 'repo_block_trade_with_start_date_equal_to_session_date'
      doc: 'Repo Block Trade With Start Date Equal To Session Date'
    0x46:
      id: 'repo_application_with_start_date_equal_to_session_date'
      doc: 'Repo Application With Start Date Equal To Session Date'
    0x33:
      id: 'rfq'
      doc: 'Rfq'
  ioi_trans_type:
    0x4e:
      id: 'new_field'
      doc: 'New'
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x52:
      id: 'replace'
      doc: 'Replace'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x37:
      id: 'undisclosed'
      doc: 'Undisclosed'

