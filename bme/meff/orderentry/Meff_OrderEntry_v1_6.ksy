# ---------------------------------------------------------------------
# Kaitai struct definition for: Bme Meff OrderEntry BmeGate v1.6
#
# Protocol:
#   Organization: Bolsas y Mercados Españoles
#   Protocol: MEFF Order Entry
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
  id: bme_meff_orderentry_bmegate_v1_6
  title: Bme Meff OrderEntry BmeGate v1.6
  license: GPL-3.0
  endian: le

doc: 'Bolsas y Mercados Españoles MEFF MEFF Order Entry BmeGate v1.6'
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
            'message_type::logon_message': logon_message
            'message_type::reject_message': reject_message
            'message_type::trading_session_status_message': trading_session_status_message
            'message_type::news_message': news_message
            'message_type::security_list_cancellation_report_message': security_list_cancellation_report_message
            'message_type::statistics_message': statistics_message
            'message_type::security_list_message': security_list_message
            'message_type::security_list_update_report_message': security_list_update_report_message
            'message_type::security_status_message': security_status_message
            'message_type::family_status_message': family_status_message
            'message_type::order_cancellation_market_member_message': order_cancellation_market_member_message
            'message_type::quote_cancellation_market_member_message': quote_cancellation_market_member_message
            'message_type::indication_of_interest_message': indication_of_interest_message
            'message_type::order_and_quote_client_data_message': order_and_quote_client_data_message
            'message_type::delta_protection_parameters_message': delta_protection_parameters_message
            'message_type::simple_new_order_message': simple_new_order_message
            'message_type::simple_new_order_with_client_data_message': simple_new_order_with_client_data_message
            'message_type::simple_order_modification_message': simple_order_modification_message
            'message_type::simple_order_modification_with_client_data_message': simple_order_modification_with_client_data_message
            'message_type::order_cancellation_request_message': order_cancellation_request_message
            'message_type::new_quote_message': new_quote_message
            'message_type::quote_modification_request_message': quote_modification_request_message
            'message_type::quote_cancellation_request_message': quote_cancellation_request_message
            'message_type::mass_orderquote_cancellation_message': mass_orderquote_cancellation_message
            'message_type::order_and_quote_client_data_parameters_ack_nack_message': order_and_quote_client_data_parameters_ack_nack_message
            'message_type::delta_protection_parameters_ack_nack_message': delta_protection_parameters_ack_nack_message
            'message_type::simple_order_status_message': simple_order_status_message
            'message_type::quote_status_message': quote_status_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::mass_orderquote_cancellation_completion_message': mass_orderquote_cancellation_completion_message
            'message_type::mass_orderquote_cancellation_reject_message': mass_orderquote_cancellation_reject_message
            'message_type::business_message_reject_message': business_message_reject_message
            'message_type::execution_private_information_2_legs_message': execution_private_information_2_legs_message
            'message_type::trade_trade_amendment_or_cancellation_1_leg_buy_private_information_message': trade_trade_amendment_or_cancellation_1_leg_buy_private_information_message
            'message_type::trade_trade_amendment_or_cancellation_1_leg_sell_private_information_message': trade_trade_amendment_or_cancellation_1_leg_sell_private_information_message
            'message_type::trade_trade_amendment_or_cancellation_2_legs_private_information_message': trade_trade_amendment_or_cancellation_2_legs_private_information_message
            'message_type::execution_private_information_1_leg_buy_order_entry_message': execution_private_information_1_leg_buy_order_entry_message
            'message_type::execution_private_information_1_leg_sell_order_entry_message': execution_private_information_1_leg_sell_order_entry_message
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
        doc: 'Session Date. Days since Unix epoch'
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
  logon_message:
    seq:
      - id: username
        type: str
        size: 7
        encoding: ASCII
        doc: 'Identifier of the user as assigned by BME'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'User password'
      - id: software_name
        type: str
        size: 25
        encoding: ASCII
        doc: 'Descriptive string of the software name used'
      - id: expected_sequence_number
        type: u4
        doc: 'Requested sequence number'
      - id: subscriptions
        type: u1
        doc: 'Bit mask: 0: Snapshot mode (only relevant in the Market and Order channel) 1: Public orders (only relevant in the Market & Order channel) 2: Public trades (only relevant in the Market & Order channel) 3: RFQ information (only relevant in the Market & Order channel) and Indications of Interest (relevant in the Market & Order channel and in the Order channel) 4: Security List (only relevant in the Order channel) 5: Trading Session Status and News (only relevant in the Order channel) 6: Security Status / Family Status (only relevant in the Order channel) 7: Statistics (only relevant in the Order channel)'
      - id: protocol_version
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identification of the binary protocol version'
  reject_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: session_reject_reason
        type: u1
        enum: session_reject_reason
        doc: 'Code indicating the rejection motive'
      - id: text_c_58
        type: str
        size: 58
        encoding: ASCII
        doc: 'Explanation of rejection'
      - id: msg_rejected_reference
        size: 7
        doc: 'Provides the seven first bytes of the message being rejected'
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
        doc: 'Underlying code. Nullable, Not Specified = ??'
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
        doc: 'Expiration date. Days since Unix epoch'
      - id: issue_date
        type: epoch_date
        doc: 'Date security issued. Days since Unix epoch'
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
        doc: 'Exercise price. Only present for warrants. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Number of shares for each security. Implied decimal with scale 1e-4'
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
        doc: 'Last Trading Day. Days since Unix epoch'
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
        type: u1_nullable
        doc: 'Indicates whether the security admits self- match prevention. Nullable, No Value = 255'
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
        doc: 'xRolling reference financing buyer rate. Nullable, Not Applicable ='
      - id: x_rolling_buyer_markup
        type: decimal_s8_4
        doc: 'xRolling buyer rate markup. Implied decimal with scale 1e-4'
      - id: x_rolling_reference_seller_rate
        type: u1
        enum: x_rolling_reference_seller_rate
        doc: 'xRolling reference financing seller rate. Nullable, Not Applicable ='
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
        doc: 'Underlying code. Nullable, Not Specified = ??'
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
        doc: 'Expiration date. Days since Unix epoch'
      - id: issue_date
        type: epoch_date
        doc: 'Date security issued. Days since Unix epoch'
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
        doc: 'Exercise price. Only present for warrants. Implied decimal with scale 1e-6'
      - id: strike_value
        type: decimal_s8_4
        doc: 'Trading Unit. Number of shares for each security. Implied decimal with scale 1e-4'
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
        doc: 'Last Trading Day. Days since Unix epoch'
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
        type: u1_nullable
        doc: 'Indicates whether the security admits self- match prevention. Nullable, No Value = 255'
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
        doc: 'xRolling reference financing buyer rate. Nullable, Not Applicable ='
      - id: x_rolling_buyer_markup
        type: decimal_s8_4
        doc: 'xRolling buyer rate markup. Implied decimal with scale 1e-4'
      - id: x_rolling_reference_seller_rate
        type: u1
        enum: x_rolling_reference_seller_rate
        doc: 'xRolling reference financing seller rate. Nullable, Not Applicable ='
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
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
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
        doc: 'Underlying code. Nullable, Not Specified = ??'
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
  order_cancellation_market_member_message:
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
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
  quote_cancellation_market_member_message:
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
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: secondary_order_id_2
        type: u4
        doc: 'System Order Number'
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
      - id: ioi_qlty_ind
        type: u1
        enum: ioi_qlty_ind
        doc: 'Request type'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'Trading mode'
  order_and_quote_client_data_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: client_data_reference
        type: str
        size: 15
        encoding: ASCII
        doc: 'Free to use by clients'
  delta_protection_parameters_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Underlying code. Nullable, Not Specified = ??'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'Derivative type. Nullable, Not Specified = ?'
      - id: delta_protection_time
        type: u1_nullable
        doc: 'Number of seconds for Delta Protection control. Valid values: 0-60 (between 1 and 60 seconds; zero when the trader is not interested in delta protection). Nullable, No Value = 0'
      - id: delta_protection_volume
        type: u4
        doc: 'Total maximum volume during DeltaProtectionTime'
  simple_new_order_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'GTD orders are not supported'
  simple_new_order_with_client_data_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'GTD orders are not supported'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: client_data_reference
        type: str
        size: 15
        encoding: ASCII
        doc: 'Free to use by clients'
  simple_order_modification_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  simple_order_modification_with_client_data_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: client_data_reference
        type: str
        size: 15
        encoding: ASCII
        doc: 'Free to use by clients'
  order_cancellation_request_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
  new_quote_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: bid_size_1
        type: u4
        doc: 'Buy volume'
      - id: bid_px_1
        type: decimal_s8_6_nullable
        doc: 'Buy price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_size_1
        type: u4
        doc: 'Sell volume'
      - id: ask_px_1
        type: decimal_s8_6_nullable
        doc: 'Sell price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
  quote_modification_request_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: bid_px_1
        type: decimal_s8_6_nullable
        doc: 'Buy price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
      - id: ask_px_1
        type: decimal_s8_6_nullable
        doc: 'Sell price. Implied decimal with scale 1e-6. Nullable, Market Orders = -9223372036854775808'
  quote_cancellation_request_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  mass_orderquote_cancellation_message:
    seq:
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Underlying code. Nullable, Not Specified = ??'
      - id: security_code
        type: u4_nullable
        doc: 'Instrument (or Book) code. Nullable, Not Specified = 0'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'Derivative type. Nullable, Not Specified = ?'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: order_or_quote_cancel
        type: u1
        enum: order_or_quote_cancel
        doc: 'Cancellation of orders and/or quotes indicator'
  order_and_quote_client_data_parameters_ack_nack_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: status
        type: u1_nullable
        doc: 'Request accepted or rejected. Nullable, No Value = 255'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: client_data_reference
        type: str
        size: 15
        encoding: ASCII
        doc: 'Free to use by clients'
  delta_protection_parameters_ack_nack_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: status
        type: u1_nullable
        doc: 'Request accepted or rejected. Nullable, No Value = 255'
      - id: security_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Underlying code. Nullable, Not Specified = ??'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'Derivative type. Nullable, Not Specified = ?'
      - id: delta_protection_time
        type: u1_nullable
        doc: 'Number of seconds for Delta Protection control. Valid values: 0-60 (between 1 and 60 seconds; zero when the trader is not interested in delta protection). Nullable, No Value = 0'
      - id: delta_protection_volume
        type: u4
        doc: 'Total maximum volume during DeltaProtectionTime'
  simple_order_status_message:
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
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: side
        type: u1
        enum: side
        doc: 'Side. Nullable, No Value = ?'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ord_rej_reason
        type: u1
        enum: ord_rej_reason
        doc: 'When OrdStatus = 4/8 it contains the reason for Cancellation/Reject. When OrdStatus # 4/8 it may contain additional information on the status of the order'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Confirmation type'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  quote_status_message:
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
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: secondary_order_id_2
        type: u4
        doc: 'System Order Number'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: priority_2
        type: u4
        doc: 'Priority'
      - id: price_2
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty_2
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ord_rej_reason
        type: u1
        enum: ord_rej_reason
        doc: 'When OrdStatus = 4/8 it contains the reason for Cancellation/Reject. When OrdStatus # 4/8 it may contain additional information on the status of the order'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Confirmation type'
      - id: order_id_2
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id_2
        type: u4
        doc: 'History number'
      - id: order_qty_2
        type: u4
        doc: 'Total order volume'
      - id: ord_status_2
        type: u1
        enum: ord_status_2
        doc: 'Order Status'
      - id: ord_rej_reason_2
        type: u1
        enum: ord_rej_reason_2
        doc: 'When OrdStatus = 4/8 it contains the reason for Cancellation/Reject. When OrdStatus # 4/8 it may contain additional information on the status of the order'
      - id: exec_type_2
        type: u1
        enum: exec_type_2
        doc: 'Confirmation type'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  order_cancel_reject_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: cxl_rej_response_to
        type: u1
        enum: cxl_rej_response_to
        doc: 'Type of message responded to'
      - id: cxl_rej_reason
        type: u1
        enum: cxl_rej_reason
        doc: 'Rejection motive'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
  mass_orderquote_cancellation_completion_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: trading_unit
        type: u1
        doc: 'Trading unit ID in the central systems'
      - id: order_or_quote_cancel
        type: u1
        enum: order_or_quote_cancel
        doc: 'Cancellation of orders and/or quotes indicator'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
  mass_orderquote_cancellation_reject_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: trading_unit
        type: u1
        doc: 'Trading unit ID in the central systems'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'Rejection motive'
  business_message_reject_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Message sequence number'
      - id: transaction_date_and_time
        type: nanosecond_timestamp
        doc: 'Transaction Date and Time in nanoseconds since 1-jan-1970 UTC. Nanoseconds since Unix epoch'
      - id: ref_msg_type
        type: u1
        doc: 'Type of message responded to'
      - id: business_reject_reason
        type: u1
        enum: business_reject_reason
        doc: 'Reason for rejection'
      - id: text_c_65
        type: str
        size: 65
        encoding: ASCII
        doc: 'Explanation of rejection. When BusinessRejectReason = 31, the first two characters of this string will contain the specific sponsored access reject code as specified in "Sponsored Access User Manual"'
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
  execution_private_information_2_legs_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: secondary_order_id_2
        type: u4
        doc: 'System Order Number'
      - id: entry_date_2
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority_2
        type: u4
        doc: 'Priority'
      - id: price_2
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty_2
        type: u4
        doc: 'Visible pending volume'
      - id: order_id_2
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id_2
        type: u4
        doc: 'History number'
      - id: order_qty_2
        type: u4
        doc: 'Total order volume'
      - id: ord_status_2
        type: u1
        enum: ord_status_2
        doc: 'Order Status'
      - id: ccp_code_2
        type: u1
        enum: ccp_code_2
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator_2
        type: u1
        enum: aggressor_indicator_2
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id_2
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id_2
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  trade_trade_amendment_or_cancellation_1_leg_buy_private_information_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
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
        doc: 'Publication Date and Time in nanoseconds since 1-jan- 1970 UTC. Nanoseconds since Unix epoch'
      - id: trade_date
        type: nanosecond_timestamp
        doc: 'Trade date and time. Nanoseconds since Unix epoch'
      - id: trade_session_date
        type: epoch_date
        doc: 'Trade Session Date. Days since Unix epoch'
      - id: amended_trade_type
        type: u1
        enum: amended_trade_type
        doc: 'Trade type of the amended/cancelled trade'
      - id: exec_ref_id
        type: u4
        doc: 'System Trade Number of the amended/cancelled trade'
      - id: amended_trade_date
        type: epoch_date
        doc: 'Date of the amended/cancelled trade. Days since Unix epoch'
      - id: broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Broker'
      - id: broker_trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Broker Trader'
      - id: broker_text
        type: str
        size: 15
        encoding: ASCII
        doc: 'Broker Text'
      - id: cancel_pre_amendment
        type: u1_nullable
        doc: 'CancelPreAmendment flag indicator. Nullable, No Value = 255'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Member'
      - id: trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trader'
      - id: sub_member
        type: str
        size: 1
        encoding: ASCII
        doc: 'Submember code'
      - id: cross_id
        type: u4
        doc: 'Cross Trade Unique Identifier'
      - id: ccv
        type: str
        size: 20
        encoding: ASCII
        doc: 'Securities Account code in CSD'
      - id: order_security_code
        type: u4
        doc: 'Order instrument (or Book) code'
      - id: external_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'External Member'
      - id: risk_reduction
        type: u1_nullable
        doc: '“Risk reducing” indicator for Commodity derivatives. Nullable, No Value = 255'
  trade_trade_amendment_or_cancellation_1_leg_sell_private_information_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
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
        doc: 'Publication Date and Time in nanoseconds since 1-jan- 1970 UTC. Nanoseconds since Unix epoch'
      - id: trade_date
        type: nanosecond_timestamp
        doc: 'Trade date and time. Nanoseconds since Unix epoch'
      - id: trade_session_date
        type: epoch_date
        doc: 'Trade Session Date. Days since Unix epoch'
      - id: amended_trade_type
        type: u1
        enum: amended_trade_type
        doc: 'Trade type of the amended/cancelled trade'
      - id: exec_ref_id
        type: u4
        doc: 'System Trade Number of the amended/cancelled trade'
      - id: amended_trade_date
        type: epoch_date
        doc: 'Date of the amended/cancelled trade. Days since Unix epoch'
      - id: broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Broker'
      - id: broker_trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Broker Trader'
      - id: broker_text
        type: str
        size: 15
        encoding: ASCII
        doc: 'Broker Text'
      - id: cancel_pre_amendment
        type: u1_nullable
        doc: 'CancelPreAmendment flag indicator. Nullable, No Value = 255'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Member'
      - id: trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trader'
      - id: sub_member
        type: str
        size: 1
        encoding: ASCII
        doc: 'Submember code'
      - id: cross_id
        type: u4
        doc: 'Cross Trade Unique Identifier'
      - id: ccv
        type: str
        size: 20
        encoding: ASCII
        doc: 'Securities Account code in CSD'
      - id: order_security_code
        type: u4
        doc: 'Order instrument (or Book) code'
      - id: external_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'External Member'
      - id: risk_reduction
        type: u1_nullable
        doc: '“Risk reducing” indicator for Commodity derivatives. Nullable, No Value = 255'
  trade_trade_amendment_or_cancellation_2_legs_private_information_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
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
        doc: 'Publication Date and Time in nanoseconds since 1-jan- 1970 UTC. Nanoseconds since Unix epoch'
      - id: trade_date
        type: nanosecond_timestamp
        doc: 'Trade date and time. Nanoseconds since Unix epoch'
      - id: trade_session_date
        type: epoch_date
        doc: 'Trade Session Date. Days since Unix epoch'
      - id: amended_trade_type
        type: u1
        enum: amended_trade_type
        doc: 'Trade type of the amended/cancelled trade'
      - id: exec_ref_id
        type: u4
        doc: 'System Trade Number of the amended/cancelled trade'
      - id: amended_trade_date
        type: epoch_date
        doc: 'Date of the amended/cancelled trade. Days since Unix epoch'
      - id: broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Broker'
      - id: broker_trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Broker Trader'
      - id: broker_text
        type: str
        size: 15
        encoding: ASCII
        doc: 'Broker Text'
      - id: cancel_pre_amendment
        type: u1_nullable
        doc: 'CancelPreAmendment flag indicator. Nullable, No Value = 255'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id
        type: u4
        doc: 'Mifid II ClientID'
      - id: account
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic'
      - id: alloc_text
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text'
      - id: last_capacity
        type: u1
        enum: last_capacity
        doc: 'Last Capacity'
      - id: self_match_prevention_id
        type: u2
        doc: 'Self Match Prevention Id'
      - id: persistence
        type: u1
        enum: persistence
        doc: 'Persistence type'
      - id: self_match_prevention_type
        type: u1
        enum: self_match_prevention_type
        doc: 'Self Match Prevention Type'
      - id: member
        type: str
        size: 4
        encoding: ASCII
        doc: 'Member'
      - id: trader
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trader'
      - id: sub_member
        type: str
        size: 1
        encoding: ASCII
        doc: 'Submember code'
      - id: cross_id
        type: u4
        doc: 'Cross Trade Unique Identifier'
      - id: ccv
        type: str
        size: 20
        encoding: ASCII
        doc: 'Securities Account code in CSD'
      - id: order_security_code
        type: u4
        doc: 'Order instrument (or Book) code'
      - id: external_member
        type: str
        size: 4
        encoding: ASCII
        doc: 'External Member'
      - id: risk_reduction
        type: u1_nullable
        doc: '“Risk reducing” indicator for Commodity derivatives. Nullable, No Value = 255'
      - id: secondary_order_id_2
        type: u4
        doc: 'System Order Number'
      - id: entry_date_2
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority_2
        type: u4
        doc: 'Priority'
      - id: price_2
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty_2
        type: u4
        doc: 'Visible pending volume'
      - id: order_id_2
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id_2
        type: u4
        doc: 'History number'
      - id: order_qty_2
        type: u4
        doc: 'Total order volume'
      - id: ord_status_2
        type: u1
        enum: ord_status_2
        doc: 'Order Status'
      - id: ccp_code_2
        type: u1
        enum: ccp_code_2
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator_2
        type: u1
        enum: aggressor_indicator_2
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id_2
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id_2
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
      - id: algorithmic_trade_indicator_2
        type: u1_nullable
        doc: 'Algorithmic flag indicator. Nullable, No Value = 255'
      - id: client_id_2
        type: u4
        doc: 'Mifid II ClientID'
      - id: account_2
        type: str
        size: 5
        encoding: ASCII
        doc: 'Account'
      - id: dea_flag_2
        type: u1_nullable
        doc: 'Direct Electronic Access indicator. Nullable, No Value = 255'
      - id: decisor_id_2
        type: u4
        doc: 'MIFID II DecisorID'
      - id: executor_id_2
        type: u4
        doc: 'Mifid II ExecutorID'
      - id: liquidity_provision_activity_2
        type: u1_nullable
        doc: 'Liquidity Provision Activity Flag. Nullable, No Value = 255'
      - id: give_in_member_2
        type: str
        size: 4
        encoding: ASCII
        doc: 'Give-in member'
      - id: firm_mnemonic_2
        type: str
        size: 10
        encoding: ASCII
        doc: 'Firm Mnemonic 2'
      - id: alloc_text_2
        type: str
        size: 18
        encoding: ASCII
        doc: 'Alloc Text 2'
      - id: last_capacity_2
        type: u1
        enum: last_capacity_2
        doc: 'Last Capacity 2'
      - id: self_match_prevention_id_2
        type: u2
        doc: 'Self Match Prevention Id 2'
      - id: persistence_2
        type: u1
        enum: persistence_2
        doc: 'Persistence type'
      - id: self_match_prevention_type_2
        type: u1
        enum: self_match_prevention_type_2
        doc: 'Self Match Prevention Type 2'
      - id: member_2
        type: str
        size: 4
        encoding: ASCII
        doc: 'Member'
      - id: trader_2
        type: str
        size: 3
        encoding: ASCII
        doc: 'Trader'
      - id: sub_member_2
        type: str
        size: 1
        encoding: ASCII
        doc: 'Submember code'
      - id: cross_id_2
        type: u4
        doc: 'Cross Trade Unique Identifier'
      - id: ccv_2
        type: str
        size: 20
        encoding: ASCII
        doc: 'Securities Account code in CSD'
      - id: order_security_code_2
        type: u4
        doc: 'Order instrument (or Book) code'
      - id: external_member_2
        type: str
        size: 4
        encoding: ASCII
        doc: 'External Member 2'
      - id: risk_reduction_2
        type: u1_nullable
        doc: '“Risk reducing” indicator for Commodity derivatives. Nullable, No Value = 255'
  execution_private_information_1_leg_buy_order_entry_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
  execution_private_information_1_leg_sell_order_entry_message:
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
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: strategy_trd_match_id
        type: u4
        doc: 'System Trade Number of the time-spread or strategy'
      - id: secondary_order_id
        type: u4
        doc: 'System Order Number'
      - id: entry_date
        type: epoch_date
        doc: 'System order entry date (when System Order Number was assigned). Days since Unix epoch'
      - id: priority
        type: u4
        doc: 'Priority'
      - id: price
        type: decimal_s8_6
        doc: 'Limit price. Implied decimal with scale 1e-6'
      - id: display_qty
        type: u4
        doc: 'Visible pending volume'
      - id: order_id
        type: u4
        doc: 'Application Order ID (unique at security level)'
      - id: secondary_exec_id
        type: u4
        doc: 'History number'
      - id: order_qty
        type: u4
        doc: 'Total order volume'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order Status'
      - id: ccp_code
        type: u1
        enum: ccp_code
        doc: 'CCP Code. Nullable, Not Applicable = 0'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'Passive or aggressive indicator. Nullable, Not Applicable ='
      - id: request_id
        type: u4
        doc: 'Request ID (for application feedback)'
      - id: client_data_id
        type: u2_nullable
        doc: 'Client Data ID (to be used as a shortcode in orders and quotes). Valid values: 1-65535 (in response messages, 0 means no ClientDataID used). Nullable, No Value = 0'
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0
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
    0x41:
      id: 'logon_message'
      doc: 'The Logon message is used to start a session by the client application'
    0x35:
      id: 'logout_message'
      doc: 'The Logout message is used by the client application to request the end of a session'
    0x0d:
      id: 'reject_message'
      doc: 'It may be sent by the server to inform about the rejection of an unsupported or syntactically incorrect message. In the Reject message, the SequenceNumber of the previously received message will be repeated'
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
    0x89:
      id: 'family_status_message'
      doc: 'Message sent by the server in the Derivatives environment to inform about the status a Family of products'
    0x01:
      id: 'order_cancellation_market_member_message'
      doc: 'Used by the Server to communicate information order cancellation. The same message is used in Full-Depth data feeds (for order cancellations of any user), in the Order Entry Server (for cancellations of user orders) and in the Market & Order Server (for order cancellations of any user)'
    0x05:
      id: 'quote_cancellation_market_member_message'
      doc: 'Used by the Server to communicate information about quote cancellation. The same message is used in Full-Depth data feeds (for quote cancellations of any user), in the Order Entry Server (for cancellations of user quotes) and in the Market & Order Server (for quote cancellations of any user)'
    0x36:
      id: 'indication_of_interest_message'
      doc: 'Used by the Server to notify an indication of interest on a specific instrument. This functionality is available in Fixed Income and Derivatives'
    0x6f:
      id: 'order_and_quote_client_data_message'
      doc: 'Sent by the client to set default attributes for subsequent orders and quotes. Please note that in Fixed Income it is possible to enter orders on behalf of other members (AccountMember), based on the corresponding brokerage permissions'
    0x86:
      id: 'delta_protection_parameters_message'
      doc: 'Sent by the client in Derivatives to set attributes for delta protection'
    0x44:
      id: 'simple_new_order_message'
      doc: 'Message sent by the client to enter a new order'
    0x45:
      id: 'simple_new_order_with_client_data_message'
      doc: 'Message sent by the client to enter a new order and, at the same time, the values for the Client Data parmeters. Note that no ClientDataID may be assigned'
    0x47:
      id: 'simple_order_modification_message'
      doc: 'Message sent by the client to modify an order. The field OrderID must contain the client reference of the order that is to be modified'
    0x48:
      id: 'simple_order_modification_with_client_data_message'
      doc: 'Message sent by the client to modify an order. The field OrderID must contain the client reference of the order that is to be modified'
    0x46:
      id: 'order_cancellation_request_message'
      doc: 'Message sent by the client to cancel an order. The field OrderID must contain a reference to the order that is to be cancelled'
    0x53:
      id: 'new_quote_message'
      doc: 'Message sent by the client application to create a new quote. A new quote by the same user on the same SecurityCode and with the same ClientDataID cancels the previous one'
    0x61:
      id: 'quote_modification_request_message'
      doc: 'Message sent by the client to modify a quote. Field ClientDataID is required in RF to identify a quote'
    0x5a:
      id: 'quote_cancellation_request_message'
      doc: 'Message sent by the client to cancel a quote'
    0x71:
      id: 'mass_orderquote_cancellation_message'
      doc: 'Message sent by the client to request the cancellation of multiple orders and or quotes, based on the specified selection criteria'
    0x87:
      id: 'order_and_quote_client_data_parameters_ack_nack_message'
      doc: 'Sent by the server to confirm an Order and Quote Client Data Parameters message'
    0x88:
      id: 'delta_protection_parameters_ack_nack_message'
      doc: 'Sent by the server to confirm a Delta Protection Parameters message'
    0x02:
      id: 'simple_order_status_message'
      doc: 'Sent by the server to inform about the order status. Please note that the first fields of this message are the same as the ones for Order Market Pre- Transparency Information (Msg Type = 0x03) (see section 5.4.12)'
    0x06:
      id: 'quote_status_message'
      doc: 'Sent by the server to inform about the status of a Quote'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Sent by the server to inform about the rejection of a Simple order modification (MsgType = 0x47) or an Order cancellation request (MsgType = 0x46)'
    0x72:
      id: 'mass_orderquote_cancellation_completion_message'
      doc: 'Message reporting the completion of a valid mass order cancellation request. More than one message may be sent for a single RequestID'
    0x73:
      id: 'mass_orderquote_cancellation_reject_message'
      doc: 'Message reporting the rejection of a mass order cancellation request. More than one message may be sent for a single RequestID'
    0x6a:
      id: 'business_message_reject_message'
      doc: 'It may be sent by the server to inform about the rejection of a supported message that is syntactically correct in an unsupported situation'
    0x17:
      id: 'execution_private_information_2_legs_message'
      doc: 'Sent by the server to inform about a trade where two orders of the user are involved both as Buyer and Seller'
    0x1a:
      id: 'trade_trade_amendment_or_cancellation_1_leg_buy_private_information_message'
      doc: 'Sent by the server to inform about a trade produced due to any reason other than order matching, also to inform about trades produced due to order matching in a Dark pool. The user is involved in the trade as Buyer. It is also sent to inform about the amendment or cancellation of whatever origin trade where the user is involved as Buyer. Shares the same layout as the next message'
    0x1c:
      id: 'trade_trade_amendment_or_cancellation_1_leg_sell_private_information_message'
      doc: 'Sent by the server to inform about a trade produced due to any reason other than order matching, also to inform about trades produced due to order matching in a Dark pool. The user is involved in the trade as Seller'
    0x1e:
      id: 'trade_trade_amendment_or_cancellation_2_legs_private_information_message'
      doc: 'Sent by the server to inform about a trade produced due to any reason other than order matching, also to inform about trades produced due to order matching in a Dark pool. The user is involved in the trade both as Buyer and Seller'
    0x12:
      id: 'execution_private_information_1_leg_buy_order_entry_message'
      doc: 'Sent by the server to inform about a trade where the user is involved as Buyer. Shares the same layout as the next message'
    0x14:
      id: 'execution_private_information_1_leg_sell_order_entry_message'
      doc: 'Sent by the server to inform about a trade where the user is involved as Seller'
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
  session_reject_reason:
    11:
      id: 'invalid_msg_type'
      doc: 'Invalid Msg Type'
    30:
      id: 'wrong_message_size'
      doc: 'Wrong Message Size'
    31:
      id: 'throttle_limit_exceeded'
      doc: 'Throttle Limit Exceeded'
    33:
      id: 'invalid_client_session_status'
      doc: 'Invalid Client Session Status'
    99:
      id: 'other'
      doc: 'Other'
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
      id: 'market'
      doc: 'M: Market (Default value). Value to be used in FLEX xRolling with a closed expiry date and no possibility to modify it.'
    0x31:
      id: 'by_buyer'
      doc: 'By Buyer'
    0x32:
      id: 'by_seller'
      doc: 'By Seller'
    0x41:
      id: 'by_both'
      doc: 'A: By both'
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
  ioi_qlty_ind:
    0x48:
      id: 'high_rfq_requested'
      doc: 'High Rfq Requested'
    0x4d:
      id: 'medium_order_requested'
      doc: 'Medium Order Requested'
  algorithmic_trade_indicator:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  dea_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  liquidity_provision_activity:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  last_capacity:
    0x44:
      id: 'dealing_on_own_account'
      doc: 'Dealing On Own Account'
    0x4d:
      id: 'matched_principal'
      doc: 'Matched Principal'
    0x41:
      id: 'any_other_trading_capacity_blanco'
      doc: 'Any Other Trading Capacity Blanco'
  persistence:
    0x43:
      id: 'cancel_on_disconnection'
      doc: 'Cancel On Disconnection'
    0x50:
      id: 'persist_on_disconnection'
      doc: 'Persist On Disconnection'
  self_match_prevention_type:
    0x20:
      id: 'na_or_default_behaviour_aggressive_order_is_rejected'
      doc: 'Na Or Default Behaviour Aggressive Order Is Rejected'
    0x31:
      id: 'reject_aggressive_order'
      doc: 'Reject Aggressive Order'
    0x32:
      id: 'cancel_pasive_order'
      doc: 'Cancel Pasive Order'
    0x33:
      id: 'cancel_both_passive_and_aggressive_order'
      doc: 'Cancel Both Passive And Aggressive Order'
    0x34:
      id: 'no_order_cancelled'
      doc: 'no order gets cancelled, both aggressive and passive orders remain (only valid for SpainAtMid Direct orders)'
  product_type:
    0x45:
      id: 'strategy'
      doc: 'Strategy'
    0x46:
      id: 'future'
      doc: 'Future'
    0x4f:
      id: 'option'
      doc: 'Option'
    0x52:
      id: 'roll_over'
      doc: 'Roll-over'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day (0)'
    0x32:
      id: 'at_opening'
      doc: 'At Opening (2)'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'IOC (3)'
    0x34:
      id: 'fill_or_kill'
      doc: 'FOK (4)'
  order_or_quote_cancel:
    0x4e:
      id: 'orders_only'
      doc: 'Orders Only'
    0x51:
      id: 'quotes_only'
      doc: 'Quotes Only'
    0x54:
      id: 'total_cancellation_orders_and_quotes'
      doc: 'Total Cancellation Orders And Quotes'
  status:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  ord_status:
    0x30:
      id: 'pending_no_volume_filled'
      doc: 'Pending No Volume Filled'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x31:
      id: 'parcially_filled'
      doc: 'Parcially Filled'
    0x32:
      id: 'totally_filled'
      doc: 'Totally Filled'
    0x34:
      id: 'cancelled_not_filled'
      doc: 'Cancelled Not Filled'
    0x50:
      id: 'cancelled_partially_filled'
      doc: 'Cancelled Partially Filled'
    0x41:
      id: 'non_working_order_pending_validation'
      doc: 'Non Working Order Pending Validation'
    0x53:
      id: 'non_working_order_pending_activation'
      doc: 'Non Working Order Pending Activation'
    0x43:
      id: 'expired'
      doc: 'Expired'
  ord_rej_reason:
    0x31:
      id: 'by_trader'
      doc: 'By Trader'
    0x33:
      id: 'by_supervisor'
      doc: 'By Supervisor'
    0x34:
      id: 'volume_modification_incorrect_new_volume_total_volume_filled'
      doc: 'Volume Modification Incorrect New Volume Total Volume Filled'
    0x35:
      id: 'not_executed_immediately'
      doc: 'Not Executed Immediately'
    0x36:
      id: 'security_not_current_or_not_tradeable_for_this_member'
      doc: 'Security Not Current Or Not Tradeable For This Member'
    0x37:
      id: 'by_limits'
      doc: 'By Limits'
    0x38:
      id: 'cancelled_by_market_status'
      doc: 'Cancelled By Market Status'
    0x39:
      id: 'invalid_data'
      doc: 'Invalid Data'
    0x42:
      id: 'price_filters'
      doc: 'Price Filters'
    0x43:
      id: 'volume_filters'
      doc: 'Volume Filters'
    0x44:
      id: 'clearing_member_status'
      doc: 'Clearing Member Status'
    0x45:
      id: 'disconnection_of_the_client_application'
      doc: 'Disconnection Of The Client Application'
    0x46:
      id: 'quote_parameters_missing'
      doc: 'Quote Parameters Missing'
    0x47:
      id: 'by_permissions'
      doc: 'By Permissions'
    0x48:
      id: 'quote_or_cl_ord_id_incorrect'
      doc: 'Quote Or Cl Ord Id Incorrect'
    0x49:
      id: 'delta_protection_number_of_contracts'
      doc: 'Delta Protection Number Of Contracts'
    0x4a:
      id: 'delta_protection_maximum_absolute_delta'
      doc: 'Delta Protection Maximum Absolute Delta'
    0x4b:
      id: 'delta_protection_m_ximum_accumulate_delta'
      doc: 'Delta Protection Máximum Accumulate Delta'
    0x4f:
      id: 'by_volatility_auction_filters'
      doc: 'By Volatility Auction Filters'
    0x51:
      id: 'quote_cancelled_by_substitution'
      doc: 'Quote Cancelled By Substitution'
    0x57:
      id: 'not_prices_for_processing_the_order'
      doc: 'Not Prices For Processing The Order'
    0x58:
      id: 'by_end_of_validity_of_the_order'
      doc: 'By End Of Validity Of The Order'
    0x5a:
      id: 'other'
      doc: 'Other'
    0x62:
      id: 'by_minimum_trading_volume'
      doc: 'By Minimum Trading Volume'
    0x63:
      id: 'price_not_according_to_the_size_typology'
      doc: 'Price Not According To The Size Typology'
    0x64:
      id: 'the_order_volumemust_be_a_multiple_of_the_trading_lot_size'
      doc: 'The Order Volumemust Be A Multiple Of The Trading Lot Size'
    0x65:
      id: 'order_rejected_for_triggering_auction'
      doc: 'Order Rejected For Triggering Auction'
    0x67:
      id: 'incorrect_price_or_triggered_price'
      doc: 'Incorrect Price Or Triggered Price'
    0x68:
      id: 'incorrect_volume'
      doc: 'Incorrect Volume'
    0x69:
      id: 'incorrect_date'
      doc: 'Incorrect Date'
    0x6b:
      id: 'by_contract_status'
      doc: 'By Contract Status'
    0x6c:
      id: 'by_intraday_futures_trading_limit'
      doc: 'By Intraday Futures Trading Limit'
    0x6d:
      id: 'kill_button'
      doc: 'Kill Button'
    0x6e:
      id: 'by_hft_filter_limit_maximum_number_of_contracts_matched'
      doc: 'By Hft Filter Limit Maximum Number Of Contracts Matched'
    0x6f:
      id: 'by_self_match_prevention'
      doc: 'By Self Match Prevention'
    0x70:
      id: 'auction_price_order_cancelled_at_the_end_of_the_auction'
      doc: 'Auction Price Order Cancelled At The End Of The Auction'
    0x78:
      id: 'invalid_ork_fields'
      doc: 'Invalid Ork Fields'
    0x4c:
      id: 'priority_change_due_to_change_in_price'
      doc: 'Priority change due to change in price'
    0x4d:
      id: 'priority_change_due_to_volume_increase'
      doc: 'Priority change due to volume increase'
    0x4e:
      id: 'priority_change_due_to_new_client_account_capacity'
      doc: 'Priority change due to new Client/Account/Capacity'
    0x50:
      id: 'priority_change_due_to_both_price_change_and_volume_increase'
      doc: 'Priority change due to both price change and volume increase'
    0x52:
      id: 'priority_change_due_to_both_price_and_client_account'
      doc: 'Priority change due to both price and client/account'
    0x53:
      id: 'priority_change_due_to_both_volume_increase_and_client_account'
      doc: 'Priority change due to both volume increase and client/account'
    0x54:
      id: 'modification_without_priority_change'
      doc: 'Modification without priority change'
    0x55:
      id: 'stop_order_triggered_at_the_close_order_activation'
      doc: 'Stop order triggered, at-the-close order activation'
    0x56:
      id: 'not_a_member_of_pit'
      doc: 'Not a member of pit'
    0x59:
      id: 'new_volume_shown'
      doc: 'New volume shown'
    0x71:
      id: 'not_executed_due_to_exceded_volume_cap'
      doc: 'Not executed due to exceded Volume Cap'
  exec_type:
    0x41:
      id: 'new_order_confirmation'
      doc: 'New Order Confirmation'
    0x42:
      id: 'order_cancellation'
      doc: 'Order Cancellation'
    0x43:
      id: 'order_refresh_due_to_change_of_book'
      doc: 'Order Refresh Due To Change Of Book'
    0x4d:
      id: 'order_modification'
      doc: 'Order Modification'
    0x47:
      id: 'order_modification_deleting_intermediated_member'
      doc: 'Order Modification Deleting Intermediated Member'
    0x46:
      id: 'order_modification_changing_intermediated_member'
      doc: 'Order Modification Changing Intermediated Member'
    0x52:
      id: 'order_refresh'
      doc: 'Order Refresh'
    0x44:
      id: 'stop_order_triggered_at_the_close_order_activation'
      doc: 'Stop Order Triggered At The Close Order Activation'
    0x38:
      id: 'order_rejection'
      doc: 'Order Rejection'
    0x4e:
      id: 'order_pending_validation'
      doc: 'Order Pending Validation'
    0x50:
      id: 'order_modification_pending_validation'
      doc: 'Order Modification Pending Validation'
    0x56:
      id: 'order_refresh_due_to_new_display_qty'
      doc: 'Order Refresh Due To New Display Qty'
    0x49:
      id: 'beginning_of_day_order_refresh'
      doc: 'Beginning Of Day Order Refresh'
    0x58:
      id: 'expired_order'
      doc: 'Expired Order'
    0x57:
      id: 'order_status'
      doc: 'Order Status'
  ord_status_2:
    0x30:
      id: 'pending_no_volume_filled'
      doc: 'Pending No Volume Filled'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x31:
      id: 'parcially_filled'
      doc: 'Parcially Filled'
    0x32:
      id: 'totally_filled'
      doc: 'Totally Filled'
    0x34:
      id: 'cancelled_not_filled'
      doc: 'Cancelled Not Filled'
    0x50:
      id: 'cancelled_partially_filled'
      doc: 'Cancelled Partially Filled'
    0x41:
      id: 'non_working_order_pending_validation'
      doc: 'Non Working Order Pending Validation'
    0x53:
      id: 'non_working_order_pending_activation'
      doc: 'Non Working Order Pending Activation'
  ord_rej_reason_2:
    0x31:
      id: 'by_trader'
      doc: 'By Trader'
    0x33:
      id: 'by_supervisor'
      doc: 'By Supervisor'
    0x34:
      id: 'volume_modification_incorrect_new_volume_total_volume_filled'
      doc: 'Volume Modification Incorrect New Volume Total Volume Filled'
    0x35:
      id: 'not_executed_immediately'
      doc: 'Not Executed Immediately'
    0x36:
      id: 'security_not_current_or_not_tradeable_for_this_member'
      doc: 'Security Not Current Or Not Tradeable For This Member'
    0x37:
      id: 'by_limits'
      doc: 'By Limits'
    0x38:
      id: 'cancelled_by_market_status'
      doc: 'Cancelled By Market Status'
    0x39:
      id: 'invalid_data'
      doc: 'Invalid Data'
    0x42:
      id: 'price_filters'
      doc: 'Price Filters'
    0x43:
      id: 'volume_filters'
      doc: 'Volume Filters'
    0x44:
      id: 'clearing_member_status'
      doc: 'Clearing Member Status'
    0x45:
      id: 'disconnection_of_the_client_application'
      doc: 'Disconnection Of The Client Application'
    0x46:
      id: 'quote_parameters_missing'
      doc: 'Quote Parameters Missing'
    0x47:
      id: 'by_permissions'
      doc: 'By Permissions'
    0x48:
      id: 'quote_or_cl_ord_id_incorrect'
      doc: 'Quote Or Cl Ord Id Incorrect'
    0x49:
      id: 'delta_protection_number_of_contracts'
      doc: 'Delta Protection Number Of Contracts'
    0x4a:
      id: 'delta_protection_maximum_absolute_delta'
      doc: 'Delta Protection Maximum Absolute Delta'
    0x4b:
      id: 'delta_protection_m_ximum_accumulate_delta'
      doc: 'Delta Protection Máximum Accumulate Delta'
    0x4f:
      id: 'by_volatility_auction_filters'
      doc: 'By Volatility Auction Filters'
    0x51:
      id: 'quote_cancelled_by_substitution'
      doc: 'Quote Cancelled By Substitution'
    0x57:
      id: 'not_prices_for_processing_the_order'
      doc: 'Not Prices For Processing The Order'
    0x58:
      id: 'by_end_of_validity_of_the_order'
      doc: 'By End Of Validity Of The Order'
    0x5a:
      id: 'other'
      doc: 'Other'
    0x62:
      id: 'by_minimum_trading_volume'
      doc: 'By Minimum Trading Volume'
    0x63:
      id: 'price_not_according_to_the_size_typology'
      doc: 'Price Not According To The Size Typology'
    0x64:
      id: 'the_order_volumemust_be_a_multiple_of_the_trading_lot_size'
      doc: 'The Order Volumemust Be A Multiple Of The Trading Lot Size'
    0x65:
      id: 'order_rejected_for_triggering_auction'
      doc: 'Order Rejected For Triggering Auction'
    0x67:
      id: 'incorrect_price_or_triggered_price'
      doc: 'Incorrect Price Or Triggered Price'
    0x68:
      id: 'incorrect_volume'
      doc: 'Incorrect Volume'
    0x69:
      id: 'incorrect_date'
      doc: 'Incorrect Date'
    0x6b:
      id: 'by_contract_status'
      doc: 'By Contract Status'
    0x6c:
      id: 'by_intraday_futures_trading_limit'
      doc: 'By Intraday Futures Trading Limit'
    0x6d:
      id: 'kill_button'
      doc: 'Kill Button'
    0x6e:
      id: 'by_hft_filter_limit_maximum_number_of_contracts_matched'
      doc: 'By Hft Filter Limit Maximum Number Of Contracts Matched'
    0x6f:
      id: 'by_self_match_prevention'
      doc: 'By Self Match Prevention'
    0x70:
      id: 'auction_price_order_cancelled_at_the_end_of_the_auction'
      doc: 'Auction Price Order Cancelled At The End Of The Auction'
    0x78:
      id: 'invalid_ork_fields'
      doc: 'Invalid Ork Fields'
    0x4c:
      id: 'priority_change_due_to_change_in_price'
      doc: 'Priority change due to change in price'
    0x4d:
      id: 'priority_change_due_to_volume_increase'
      doc: 'Priority change due to volume increase'
    0x4e:
      id: 'priority_change_due_to_new_client_account_capacity'
      doc: 'Priority change due to new Client/Account/Capacity'
    0x50:
      id: 'priority_change_due_to_both_price_change_and_volume_increase'
      doc: 'Priority change due to both price change and volume increase'
    0x52:
      id: 'priority_change_due_to_both_price_and_client_account'
      doc: 'Priority change due to both price and client/account'
    0x53:
      id: 'priority_change_due_to_both_volume_increase_and_client_account'
      doc: 'Priority change due to both volume increase and client/account'
    0x54:
      id: 'modification_without_priority_change'
      doc: 'Modification without priority change'
    0x55:
      id: 'stop_order_triggered_at_the_close_order_activation'
      doc: 'Stop order triggered, at-the-close order activation'
    0x56:
      id: 'not_a_member_of_pit'
      doc: 'Not a member of pit'
    0x59:
      id: 'new_volume_shown'
      doc: 'New volume shown'
    0x71:
      id: 'not_executed_due_to_exceded_volume_cap'
      doc: 'Not executed due to exceded Volume Cap'
  exec_type_2:
    0x41:
      id: 'new_order_confirmation'
      doc: 'New Order Confirmation'
    0x42:
      id: 'order_cancellation'
      doc: 'Order Cancellation'
    0x4d:
      id: 'order_modification'
      doc: 'Order Modification'
    0x52:
      id: 'order_refresh'
      doc: 'Order Refresh'
    0x38:
      id: 'order_rejection'
      doc: 'Order Rejection'
    0x58:
      id: 'expired_order'
      doc: 'Expired Order'
    0x57:
      id: 'order_status'
      doc: 'Order Status'
  cxl_rej_response_to:
    0x31:
      id: 'simple_order_modification'
      doc: 'Simple Order Modification'
    0x32:
      id: 'order_cancellation_request'
      doc: 'Order Cancellation Request'
  cxl_rej_reason:
    0x31:
      id: 'by_trader'
      doc: 'By Trader'
    0x33:
      id: 'by_supervisor'
      doc: 'By Supervisor'
    0x34:
      id: 'volume_modification_incorrect_new_volume_total_volume_filled'
      doc: 'Volume Modification Incorrect New Volume Total Volume Filled'
    0x35:
      id: 'not_executed_immediately'
      doc: 'Not Executed Immediately'
    0x36:
      id: 'security_not_current_or_not_tradeable_for_this_member'
      doc: 'Security Not Current Or Not Tradeable For This Member'
    0x37:
      id: 'by_limits'
      doc: 'By Limits'
    0x38:
      id: 'cancelled_by_market_status'
      doc: 'Cancelled By Market Status'
    0x39:
      id: 'invalid_data'
      doc: 'Invalid Data'
    0x42:
      id: 'price_filters'
      doc: 'Price Filters'
    0x43:
      id: 'volume_filters'
      doc: 'Volume Filters'
    0x44:
      id: 'clearing_member_status'
      doc: 'Clearing Member Status'
    0x45:
      id: 'disconnection_of_the_client_application'
      doc: 'Disconnection Of The Client Application'
    0x46:
      id: 'quote_parameters_missing'
      doc: 'Quote Parameters Missing'
    0x47:
      id: 'by_permissions'
      doc: 'By Permissions'
    0x48:
      id: 'quote_or_cl_ord_id_incorrect'
      doc: 'Quote Or Cl Ord Id Incorrect'
    0x49:
      id: 'delta_protection_number_of_contracts'
      doc: 'Delta Protection Number Of Contracts'
    0x4a:
      id: 'delta_protection_maximum_absolute_delta'
      doc: 'Delta Protection Maximum Absolute Delta'
    0x4b:
      id: 'delta_protection_m_ximum_accumulate_delta'
      doc: 'Delta Protection Máximum Accumulate Delta'
    0x4f:
      id: 'by_volatility_auction_filters'
      doc: 'By Volatility Auction Filters'
    0x51:
      id: 'quote_cancelled_by_substitution'
      doc: 'Quote Cancelled By Substitution'
    0x57:
      id: 'not_prices_for_processing_the_order'
      doc: 'Not Prices For Processing The Order'
    0x58:
      id: 'by_end_of_validity_of_the_order'
      doc: 'By End Of Validity Of The Order'
    0x5a:
      id: 'other'
      doc: 'Other'
    0x62:
      id: 'by_minimum_trading_volume'
      doc: 'By Minimum Trading Volume'
    0x63:
      id: 'price_not_according_to_the_size_typology'
      doc: 'Price Not According To The Size Typology'
    0x64:
      id: 'the_order_volumemust_be_a_multiple_of_the_trading_lot_size'
      doc: 'The Order Volumemust Be A Multiple Of The Trading Lot Size'
    0x65:
      id: 'order_rejected_for_triggering_auction'
      doc: 'Order Rejected For Triggering Auction'
    0x67:
      id: 'incorrect_price_or_triggered_price'
      doc: 'Incorrect Price Or Triggered Price'
    0x68:
      id: 'incorrect_volume'
      doc: 'Incorrect Volume'
    0x69:
      id: 'incorrect_date'
      doc: 'Incorrect Date'
    0x6b:
      id: 'by_contract_status'
      doc: 'By Contract Status'
    0x6c:
      id: 'by_intraday_futures_trading_limit'
      doc: 'By Intraday Futures Trading Limit'
    0x6d:
      id: 'kill_button'
      doc: 'Kill Button'
    0x6e:
      id: 'by_hft_filter_limit_maximum_number_of_contracts_matched'
      doc: 'By Hft Filter Limit Maximum Number Of Contracts Matched'
    0x6f:
      id: 'by_self_match_prevention'
      doc: 'By Self Match Prevention'
    0x70:
      id: 'auction_price_order_cancelled_at_the_end_of_the_auction'
      doc: 'Auction Price Order Cancelled At The End Of The Auction'
    0x78:
      id: 'invalid_ork_fields'
      doc: 'Invalid Ork Fields'
  mass_cancel_reject_reason:
    0x47:
      id: 'no_permission'
      doc: 'No Permission'
    0x38:
      id: 'cancelled_because_of_market_state'
      doc: 'Cancelled Because Of Market State'
    0x39:
      id: 'invalid_data'
      doc: 'Invalid Data'
  business_reject_reason:
    0:
      id: 'other'
      doc: 'Other'
    3:
      id: 'unsupported_message_type'
      doc: 'Unsupported Message Type'
    30:
      id: 'invalid_client_data_id'
      doc: 'Invalid Client Data Id'
    31:
      id: 'sponsored_access'
      doc: 'Sponsored Access'
    32:
      id: 'quote_operation_rejected'
      doc: 'Quote Operation Rejected'
    33:
      id: 'invalid_security'
      doc: 'Invalid Security'
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
  ccp_code:
    0x31:
      id: 'bme_clearing_others_to_be_defined'
      doc: 'Bme Clearing… Others To Be Defined'
  aggressor_indicator:
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x41:
      id: 'aggresive'
      doc: 'Aggresive'
  ccp_code_2:
    0x31:
      id: 'bme_clearing_others_to_be_defined'
      doc: 'Bme Clearing… Others To Be Defined'
  aggressor_indicator_2:
    0x50:
      id: 'passive'
      doc: 'Passive'
    0x41:
      id: 'aggressive'
      doc: 'Aggressive'
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
  cancel_pre_amendment:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  risk_reduction:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  algorithmic_trade_indicator_2:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  dea_flag_2:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  liquidity_provision_activity_2:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  last_capacity_2:
    0x44:
      id: 'dealing_on_own_account'
      doc: 'Dealing On Own Account'
    0x4d:
      id: 'matched_principal'
      doc: 'Matched Principal'
    0x41:
      id: 'any_other_trading_capacity_blanco'
      doc: 'Any Other Trading Capacity Blanco'
  persistence_2:
    0x43:
      id: 'cancel_on_disconnection'
      doc: 'Cancel On Disconnection'
    0x50:
      id: 'persist_on_disconnection'
      doc: 'Persist On Disconnection'
  self_match_prevention_type_2:
    0x20:
      id: 'na_or_default_behaviour_aggressive_order_is_rejected'
      doc: 'Na Or Default Behaviour Aggressive Order Is Rejected'
    0x31:
      id: 'reject_aggressive_order'
      doc: 'Reject Aggressive Order'
    0x32:
      id: 'cancel_pasive_order'
      doc: 'Cancel pasive order'
    0x33:
      id: 'cancel_both_passive_and_aggressive_order'
      doc: 'Cancel Both Passive And Aggressive Order'
    0x34:
      id: 'no_order_cancelled'
      doc: 'no order gets cancelled, both aggressive and passive orders remain (only valid for SpainAtMid Direct orders)'
  risk_reduction_2:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'

