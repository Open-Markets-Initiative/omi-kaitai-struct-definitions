# ---------------------------------------------------------------------
# Kaitai struct definition for: Bme Meff Retail BmeGate v1.6
#
# Protocol:
#   Organization: Bolsas y Mercados Españoles
#   Protocol: MEFF Retail Top Of Book
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
  id: bme_meff_retail_bmegate_v1_6
  title: Bme Meff Retail BmeGate v1.6
  license: GPL-3.0
  endian: le

doc: 'Bolsas y Mercados Españoles MEFF MEFF Retail Top Of Book BmeGate v1.6'
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
            'message_type::family_status_message': family_status_message
            'message_type::trade_market_post_transparency_information_topofbook_message': trade_market_post_transparency_information_topofbook_message
            'message_type::trade_trade_amendment_or_cancellation_message': trade_trade_amendment_or_cancellation_message
            'message_type::indication_of_interest_message': indication_of_interest_message
            'message_type::rfq_market_pre_transparency_information_message': rfq_market_pre_transparency_information_message
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
        type: str
        size: 1
        encoding: ASCII
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
        type: u4
        doc: 'Instrument (or Book) code'
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
        type: u4
        doc: 'Instrument (or Book) code'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: data_count
        type: u1
        doc: 'Number of data values'
      - id: data_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Data field code'
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
        type: u4
        doc: 'Instrument (or Book) code'
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
        doc: 'Underlying code'
      - id: family_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Family of instruments code'
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
        type: u1
        enum: liquid_instrument
        doc: 'Liquid Instrument'
      - id: admission_requested_by_issuer
        type: u1
        enum: admission_requested_by_issuer
        doc: 'Security request for admission to trading by the issuer'
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
        type: u1
        enum: trading_obligation
        doc: 'Trading obligation'
      - id: sec_description
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying security description'
      - id: underlying_asset
        type: str
        size: 22
        encoding: ASCII
        doc: 'Underlying Asset'
      - id: security_sub_type
        type: str
        size: 12
        encoding: ASCII
        doc: 'Strategy type'
      - id: maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity'
      - id: strike_price
        type: decimal_s8_6
        doc: 'Exercise price. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Implied decimal with scale 1e-4'
      - id: opt_attribute
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security version number, provided to support versioning of securities as a result of corporate actions or events'
      - id: min_price_increment
        type: decimal_s8_6
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-6'
      - id: unit_of_measure
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unif of Measure'
      - id: settl_method
        type: u1
        enum: settl_method
        doc: 'Settlement Method'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise Style (Options)'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether the contract is a put or a call'
      - id: flexible_indicator
        type: u1
        enum: flexible_indicator
        doc: 'Flexible Expiry Indicator'
      - id: last_trading_day
        type: epoch_date
        doc: 'Last Trading Day'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: adjustments_rule
        type: u1
        enum: adjustments_rule
        doc: 'Adjustments rule'
      - id: maximum_order_size
        type: decimal_s8_4
        doc: 'Nominal limit cap above which orders are not permitted. Implied decimal with scale 1e-4'
      - id: self_match_prevention
        type: u1
        enum: self_match_prevention
        doc: 'Indicates whether the security admits self- match prevention'
      - id: commodity_derivative_indicator
        type: u1
        enum: commodity_derivative_indicator
        doc: 'Commodity Derivative Indicator'
      - id: stock_when_underlying_is_dividend
        type: str
        size: 22
        encoding: ASCII
        doc: 'Stock when Underlying is a Dividend'
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
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Base currency'
      - id: quoted_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Quoted currency'
      - id: maturity_month_year_increment_units
        type: u1
        enum: maturity_month_year_increment_units
        doc: 'MaturityMonthYear Increment Units'
      - id: start_maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity Interval Initial Date'
      - id: end_maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity Interval End Date'
      - id: maturity_month_year_increment
        type: u1
        doc: 'Number of MaturityMonthYear Increment Units'
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
      - id: underlying_security_issuer_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying Security Issuer LEI'
      - id: x_rolling_closing_type
        type: u1
        enum: x_rolling_closing_type
        doc: 'xRolling Closing Type'
      - id: x_rolling_reference_buyer_rate
        type: u1
        enum: x_rolling_reference_buyer_rate
        doc: 'xRolling reference financing buyer rate'
      - id: x_rolling_buyer_markup
        type: decimal_s8_4
        doc: 'xRolling buyer rate markup. Implied decimal with scale 1e-4'
      - id: x_rolling_reference_seller_rate
        type: u1
        enum: x_rolling_reference_seller_rate
        doc: 'xRolling reference financing seller rate'
      - id: x_rolling_seller_markup
        type: decimal_s8_4
        doc: 'xRolling reference financing seller rate. Implied decimal with scale 1e-4'
      - id: x_rolling_dividend_percentage
        type: decimal_s8_4
        doc: 'xRolling Dividend payment percentage. Implied decimal with scale 1e-4'
      - id: x_rolling_dividend_pay_date_diff
        type: u2
        doc: 'xRolling Dividend Payment Date difference'
      - id: leg_symbol_1
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_1
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_1
        type: u1
        enum: leg_side_1
        doc: 'Side in strategy or time spread'
      - id: leg_price_1
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_2
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_2
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_2
        type: u1
        enum: leg_side_2
        doc: 'Side in strategy or time spread'
      - id: leg_price_2
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_3
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_3
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_3
        type: u1
        enum: leg_side_3
        doc: 'Side in strategy or time spread'
      - id: leg_price_3
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_4
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_4
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_4
        type: u1
        enum: leg_side_4
        doc: 'Side in strategy or time spread'
      - id: leg_price_4
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_5
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_5
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_5
        type: u1
        enum: leg_side_5
        doc: 'Side in strategy or time spread'
      - id: leg_price_5
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
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
        type: u4
        doc: 'Instrument (or Book) code'
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
        doc: 'Underlying code'
      - id: family_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Family of instruments code'
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
        type: u1
        enum: liquid_instrument
        doc: 'Liquid Instrument'
      - id: admission_requested_by_issuer
        type: u1
        enum: admission_requested_by_issuer
        doc: 'Security request for admission to trading by the issuer'
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
        type: u1
        enum: trading_obligation
        doc: 'Trading obligation'
      - id: sec_description
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying security description'
      - id: underlying_asset
        type: str
        size: 22
        encoding: ASCII
        doc: 'Underlying Asset'
      - id: security_sub_type
        type: str
        size: 12
        encoding: ASCII
        doc: 'Strategy type'
      - id: maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity'
      - id: strike_price
        type: decimal_s8_6
        doc: 'Exercise price. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Implied decimal with scale 1e-4'
      - id: opt_attribute
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security version number, provided to support versioning of securities as a result of corporate actions or events'
      - id: min_price_increment
        type: decimal_s8_6
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-6'
      - id: unit_of_measure
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unif of Measure'
      - id: settl_method
        type: u1
        enum: settl_method
        doc: 'Settlement Method'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Exercise Style (Options)'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether the contract is a put or a call'
      - id: flexible_indicator
        type: u1
        enum: flexible_indicator
        doc: 'Flexible Expiry Indicator'
      - id: last_trading_day
        type: epoch_date
        doc: 'Last Trading Day'
      - id: number_of_decimals
        type: u1
        doc: 'Number of Decimals'
      - id: order_number_of_decimals
        type: u1
        doc: 'Number of Decimals in Order Entry'
      - id: adjustments_rule
        type: u1
        enum: adjustments_rule
        doc: 'Adjustments rule'
      - id: maximum_order_size
        type: decimal_s8_4
        doc: 'Nominal limit cap above which orders are not permitted. Implied decimal with scale 1e-4'
      - id: self_match_prevention
        type: u1
        enum: self_match_prevention
        doc: 'Indicates whether the security admits self- match prevention'
      - id: commodity_derivative_indicator
        type: u1
        enum: commodity_derivative_indicator
        doc: 'Commodity Derivative Indicator'
      - id: stock_when_underlying_is_dividend
        type: str
        size: 22
        encoding: ASCII
        doc: 'Stock when Underlying is a Dividend'
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
      - id: base_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Base currency'
      - id: quoted_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Quoted currency'
      - id: maturity_month_year_increment_units
        type: u1
        enum: maturity_month_year_increment_units
        doc: 'MaturityMonthYear Increment Units'
      - id: start_maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity Interval Initial Date'
      - id: end_maturity_month_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Maturity Interval End Date'
      - id: maturity_month_year_increment
        type: u1
        doc: 'Number of MaturityMonthYear Increment Units'
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
      - id: underlying_security_issuer_lei
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying Security Issuer LEI'
      - id: x_rolling_closing_type
        type: u1
        enum: x_rolling_closing_type
        doc: 'xRolling Closing Type'
      - id: x_rolling_reference_buyer_rate
        type: u1
        enum: x_rolling_reference_buyer_rate
        doc: 'xRolling reference financing buyer rate'
      - id: x_rolling_buyer_markup
        type: decimal_s8_4
        doc: 'xRolling buyer rate markup. Implied decimal with scale 1e-4'
      - id: x_rolling_reference_seller_rate
        type: u1
        enum: x_rolling_reference_seller_rate
        doc: 'xRolling reference financing seller rate'
      - id: x_rolling_seller_markup
        type: decimal_s8_4
        doc: 'xRolling reference financing seller rate. Implied decimal with scale 1e-4'
      - id: x_rolling_dividend_percentage
        type: decimal_s8_4
        doc: 'xRolling Dividend payment percentage. Implied decimal with scale 1e-4'
      - id: x_rolling_dividend_pay_date_diff
        type: u2
        doc: 'xRolling Dividend Payment Date difference'
      - id: leg_symbol_1
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_1
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_1
        type: u1
        enum: leg_side_1
        doc: 'Side in strategy or time spread'
      - id: leg_price_1
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_2
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_2
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_2
        type: u1
        enum: leg_side_2
        doc: 'Side in strategy or time spread'
      - id: leg_price_2
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_3
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_3
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_3
        type: u1
        enum: leg_side_3
        doc: 'Side in strategy or time spread'
      - id: leg_price_3
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_4
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_4
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_4
        type: u1
        enum: leg_side_4
        doc: 'Side in strategy or time spread'
      - id: leg_price_4
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
      - id: leg_symbol_5
        type: str
        size: 22
        encoding: ASCII
        doc: 'Symbol in strategy or time spread'
      - id: leg_ratio_qty_5
        type: u4
        doc: 'Ratio in strategy or time spread'
      - id: leg_side_5
        type: u1
        enum: leg_side_5
        doc: 'Side in strategy or time spread'
      - id: leg_price_5
        type: decimal_s8_6
        doc: 'Price in strategy or time spread. Implied decimal with scale 1e-6'
  security_status_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4
        doc: 'Instrument (or Book) code'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
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
  family_status_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Underlying code'
      - id: family_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Family of instruments code'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'Security Trading Status'
      - id: non_availability_reason
        type: u1
        enum: non_availability_reason
        doc: 'Reason security halted'
  trade_market_post_transparency_information_topofbook_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4
        doc: 'Instrument (or Book) code'
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
        type: u1
        enum: algo_flag
        doc: 'Algorithmic flag indicator'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
  trade_trade_amendment_or_cancellation_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4
        doc: 'Instrument (or Book) code'
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
        type: u1
        enum: algo_flag
        doc: 'Algorithmic flag indicator'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
      - id: last_change_flag
        type: u1
        enum: last_change_flag
        doc: 'Indicates if this trade changes the instrument Last price'
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
        type: u4
        doc: 'Instrument (or Book) code'
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
        doc: 'Side'
      - id: ioi_qty
        type: u4
        doc: 'Requested indicative volume'
      - id: ioi_price
        type: decimal_s8_6
        doc: 'Requested indicative price. Implied decimal with scale 1e-6'
      - id: ioi_qlty_ind
        type: u1
        enum: ioi_qlty_ind
        doc: 'Request type'
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
        type: u4
        doc: 'Instrument (or Book) code'
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
        type: decimal_s8_6
        doc: 'Buy price. Implied decimal with scale 1e-6'
      - id: ask_orders_1
        type: u2
        doc: 'Sell number of orders'
      - id: ask_size_1
        type: u4
        doc: 'Sell volume'
      - id: ask_px_1
        type: decimal_s8_6
        doc: 'Sell price. Implied decimal with scale 1e-6'
      - id: bid_orders_2
        type: u2
        doc: 'Buy number of orders level 2'
      - id: bid_size_2
        type: u4
        doc: 'Buy volume level 2'
      - id: bid_px_2
        type: decimal_s8_6
        doc: 'Buy price level 2. Implied decimal with scale 1e-6'
      - id: ask_orders_2
        type: u2
        doc: 'Sell number of orders level 2'
      - id: ask_size_2
        type: u4
        doc: 'Sell volume level 2'
      - id: ask_px_2
        type: decimal_s8_6
        doc: 'Sell price level 2. Implied decimal with scale 1e-6'
      - id: bid_orders_3
        type: u2
        doc: 'Buy number of orders level 3'
      - id: bid_size_3
        type: u4
        doc: 'Buy volume level 3'
      - id: bid_px_3
        type: decimal_s8_6
        doc: 'Buy price level 3. Implied decimal with scale 1e-6'
      - id: ask_orders_3
        type: u2
        doc: 'Sell number of orders level 3'
      - id: ask_size_3
        type: u4
        doc: 'Sell volume level 3'
      - id: ask_px_3
        type: decimal_s8_6
        doc: 'Sell price level 3. Implied decimal with scale 1e-6'
      - id: bid_orders_4
        type: u2
        doc: 'Buy number of orders level 4'
      - id: bid_size_4
        type: u4
        doc: 'Buy volume level 4'
      - id: bid_px_4
        type: decimal_s8_6
        doc: 'Buy price level 4. Implied decimal with scale 1e-6'
      - id: ask_orders_4
        type: u2
        doc: 'Sell number of orders level 4'
      - id: ask_size_4
        type: u4
        doc: 'Sell volume level 4'
      - id: ask_px_4
        type: decimal_s8_6
        doc: 'Sell price level 4. Implied decimal with scale 1e-6'
      - id: bid_orders_5
        type: u2
        doc: 'Buy number of orders level 5'
      - id: bid_size_5
        type: u4
        doc: 'Buy volume level 5'
      - id: bid_px_5
        type: decimal_s8_6
        doc: 'Buy price level 5. Implied decimal with scale 1e-6'
      - id: ask_orders_5
        type: u2
        doc: 'Sell number of orders level 5'
      - id: ask_size_5
        type: u4
        doc: 'Sell volume level 5'
      - id: ask_px_5
        type: decimal_s8_6
        doc: 'Sell price level 5. Implied decimal with scale 1e-6'
  topofbook_retail_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: security_code
        type: u4
        doc: 'Instrument (or Book) code'
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
        type: decimal_s8_6
        doc: 'Buy price. Implied decimal with scale 1e-6'
      - id: ask_orders_1
        type: u2
        doc: 'Sell number of orders'
      - id: ask_size_1
        type: u4
        doc: 'Sell volume'
      - id: ask_px_1
        type: decimal_s8_6
        doc: 'Sell price. Implied decimal with scale 1e-6'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0

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
      doc: 'Message sent by the server to inform about closing prices and other statistics. Le n'
    0x79:
      id: 'security_list_message'
      doc: 'T Le y n'
    0x80:
      id: 'security_list_update_report_message'
      doc: 'Message sent by the server for reporting updates, during the session, to the security definition. T Le y n'
    0x66:
      id: 'security_status_message'
      doc: 'Message sent by the server to inform on the status of one security'
    0x89:
      id: 'family_status_message'
      doc: 'Message sent by the server in the Derivatives environment to inform about the status a Family of products'
    0x10:
      id: 'trade_market_post_transparency_information_topofbook_message'
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
    0x91:
      id: 'topofbook_retail_message'
      doc: 'Specific message for the Retail Service. This message is sent through the UDP channels G/H'
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
    105:
      id: 'normal_hours'
      doc: 'Normal Hours'
    106:
      id: 'delta_and_basis_trade'
      doc: 'Delta And Basis Trade'
    107:
      id: 'bono_hours'
      doc: 'Bono Hours'
    108:
      id: 'cross_trades_normal_hours'
      doc: 'Cross Trades Normal Hours'
    109:
      id: 'cross_trades_bono_hours'
      doc: 'Cross Trades Bono Hours'
    115:
      id: 'rfq_ibex_futures_hours'
      doc: 'Rfq Ibex Futures Hours'
    116:
      id: 'rfq_normal_hours'
      doc: 'Rfq Normal Hours'
    117:
      id: 'rfq_bono_hours'
      doc: 'Rfq Bono Hours'
    118:
      id: 'x_rolling_on_stocks'
      doc: 'X Rolling On Stocks'
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
  liquid_instrument:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
    255:
      id: 'undefined'
      doc: 'Undefined'
  admission_requested_by_issuer:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
    255:
      id: 'undefined'
      doc: 'Undefined'
  trading_obligation:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
    255:
      id: 'undefined'
      doc: 'Undefined'
  settl_method:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x50:
      id: 'physical'
      doc: 'Physical'
  exercise_style:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
    0x56:
      id: 'european_automatic'
      doc: 'European Automatic'
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
  flexible_indicator:
    0x59:
      id: 'flexible'
      doc: 'Flexible'
    0x4e:
      id: 'standard'
      doc: 'Standard'
  adjustments_rule:
    0x45:
      id: 'extraordinary_dividend_adjustments_only'
      doc: 'Extraordinary Dividend Adjustments Only'
    0x54:
      id: 'total'
      doc: 'Total'
  self_match_prevention:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
    255:
      id: 'undefined'
      doc: 'Undefined'
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
  maturity_month_year_increment_units:
    0x30:
      id: 'months'
      doc: 'Months'
    0x31:
      id: 'days'
      doc: 'Days'
    0x32:
      id: 'weeks'
      doc: 'Weeks'
    0x33:
      id: 'years'
      doc: 'Years'
  x_rolling_closing_type:
    0x4d:
      id: 'market_default_value_value_to_be_used_in_flex_x_rolling_with_a_closed_expiry_date_and_no_possibility_to_modify_it'
      doc: 'Market Default Value Value To Be Used In Flex X Rolling With A Closed Expiry Date And No Possibility To Modify It'
    0x31:
      id: 'by_buyer'
      doc: 'By Buyer'
    0x32:
      id: 'by_seller'
      doc: 'By Seller'
  x_rolling_reference_buyer_rate:
    0x53:
      id: 'str_default_value_for_non_flex_x_rolling'
      doc: '€ Str Default Value For Non Flex X Rolling'
    0x46:
      id: 'fis_analitics'
      doc: 'Fis Analitics'
    0x4d:
      id: 'meff_rate'
      doc: 'Meff Rate'
    0x30:
      id: 'zero'
      doc: 'Zero'
    0x20:
      id: 'na_used_in_flex_in_the_financing_leg'
      doc: 'Na Used In Flex In The Financing Leg'
  x_rolling_reference_seller_rate:
    0x53:
      id: 'str'
      doc: '€ Str'
    0x46:
      id: 'fis_analitics'
      doc: 'Fis Analitics'
    0x4d:
      id: 'meff_rate_default_value_for_non_flex_x_rolling'
      doc: 'Meff Rate Default Value For Non Flex X Rolling'
    0x30:
      id: 'cero'
      doc: 'Cero'
    0x20:
      id: 'na_used_in_flex_in_the_financing_leg'
      doc: 'Na Used In Flex In The Financing Leg'
  leg_side_1:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  leg_side_2:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  leg_side_3:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  leg_side_4:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  leg_side_5:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
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
  trade_type:
    0x48:
      id: 'cross_trade_during_trading_hours'
      doc: 'Cross Trade During Trading Hours'
    0x4c:
      id: 'delta'
      doc: 'Delta'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'strategy_trades_time_spread_futures_and_strategies'
      doc: 'Strategy Trades Time Spread Futures And Strategies'
    0x53:
      id: 'components_of_trade_r'
      doc: 'Components Of Trade R'
    0x57:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x58:
      id: 'countertrade'
      doc: 'Countertrade'
    0x33:
      id: 'rfq'
      doc: 'Rfq'
    0x34:
      id: 'rfq_x_rolling'
      doc: 'Rfq X Rolling'
    0x36:
      id: 'rfq_x_rolling_during_auction'
      doc: 'Rfq X Rolling During Auction'
    0x38:
      id: 'rfq_x_rolling_amendment'
      doc: 'Rfq X Rolling Amendment'
    0x39:
      id: 'rfq_x_rolling_during_auction_amendment'
      doc: 'Rfq X Rolling During Auction Amendment'
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
    255:
      id: 'undefined'
      doc: 'Undefined'
  transaction_category:
    0x20:
      id: 'normal_category'
      doc: 'Normal Category'
    0x59:
      id: 'exchange_for_physicals_xfph'
      doc: 'Exchange For Physicals Xfph'
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
    255:
      id: 'undefined'
      doc: 'Undefined'
  bencrfpt_flag:
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
  pre_trade_transparency_waiver:
    0x20:
      id: 'negotiated_trade_nego'
      doc: 'Negotiated Trade Nego'
  deferral_waiver:
    0x20:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
    0x36:
      id: 'non_immediate_publication_deferral_for_large_in_scale_lrgs'
      doc: 'Non Immediate Publication Deferral For Large In Scale Lrgs'
    0x37:
      id: 'non_immediate_publication_deferral_for_illiquid_instrument_ilqd'
      doc: 'Non Immediate Publication Deferral For Illiquid Instrument Ilqd'
    0x38:
      id: 'non_immediate_publication_deferral_for_size_specific_size_rts_2'
      doc: 'Non Immediate Publication Deferral For Size Specific Size Rts 2'
  post_deferral_publication_type:
    0x20:
      id: 'not_applicable_no_relevant_deferral_or_enrichment_type'
      doc: 'Not Applicable No Relevant Deferral Or Enrichment Type'
    0x38:
      id: 'full_details_of_earlier_daily_aggregated_trade_datf'
      doc: 'Full Details Of Earlier Daily Aggregated Trade Datf'
  amended_trade_type:
    0x48:
      id: 'cross_trade_during_trading_hours'
      doc: 'Cross Trade During Trading Hours'
    0x4c:
      id: 'delta'
      doc: 'Delta'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x52:
      id: 'strategy_trades_time_spread_futures_and_strategies'
      doc: 'Strategy Trades Time Spread Futures And Strategies'
    0x53:
      id: 'components_of_trade_r'
      doc: 'Components Of Trade R'
    0x57:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x58:
      id: 'countertrade'
      doc: 'Countertrade'
    0x33:
      id: 'rfq'
      doc: 'Rfq'
    0x34:
      id: 'rfq_x_rolling'
      doc: 'Rfq X Rolling'
    0x36:
      id: 'rfq_x_rolling_during_auction'
      doc: 'Rfq X Rolling During Auction'
    0x38:
      id: 'rfq_x_rolling_amendment'
      doc: 'Rfq X Rolling Amendment'
    0x39:
      id: 'rfq_x_rolling_during_auction_amendment'
      doc: 'Rfq X Rolling During Auction Amendment'
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
    0x3f:
      id: 'notspecified'
      doc: 'Notspecified'
  ioi_qlty_ind:
    0x48:
      id: 'high_rfq_requested'
      doc: 'High Rfq Requested'
    0x4d:
      id: 'medium_order_requested'
      doc: 'Medium Order Requested'

