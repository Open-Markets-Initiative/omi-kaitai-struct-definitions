# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg TradeEcho Mifid2PostTrade Gtp v24.4
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: MiFID II Post Trade
#   Encoding: Group Ticker Plant
#   Version: 24.4
#   Date: 4/24/2024
#   Specification: gtp-002-technical-guide-tradecho-issue-24-4.pdf
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
  id: lseg_tradeecho_mifid2posttrade_gtp_v24_4
  title: Lseg TradeEcho Mifid2PostTrade Gtp v24.4
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange TRADEcho MiFID II Post Trade Gtp v24.4'
doc-ref: https://www.londonstockexchange.com/resources/equities-trading-resources/gtp-technical-specifications

seq:
  - id: unit_header
    type: unit_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: unit_header.message_count

types:
  unit_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message block including the header and all payload messages'
      - id: message_count
        type: u1
        doc: 'Number of payload messages that will follow the header'
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the payload messages relate to'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the first payload message'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Gtp Udp Message Header'
      - id: payload
        size: message_header.message_length - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::statistics_message': statistics_message
            'message_type::mifid_ii_trade_report_message': mifid_ii_trade_report_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Session transition event'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
  instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: isin
        type: str_12_nullable
        doc: 'ISIN Code of an instrument'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Allowed Book Type Flags'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: venue_instrument_id
        type: str_11_nullable
        doc: 'Instrument identifier used by the source venue'
      - id: tick_id
        type: str_2_nullable
        doc: 'Not Applicable to TRADEcho'
      - id: price_band_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: dynamic_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: static_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: segment
        type: str_6_nullable
        doc: 'Segment the instrument is assigned to'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
      - id: reserved_11
        size: 11
        doc: 'Reserved for future use'
      - id: currency
        type: str_3_nullable
        doc: 'Currency Code as per ISO 4217'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: average_daily_turnover
        type: decimal_s8_4
        doc: 'Average Daily Turnover as reported by the Source Venue. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
  allowed_book_types:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Unused'
      - id: si_quote_book
        type: b1
        doc: 'SI Quote Book'
      - id: off_book
        type: b1
        doc: 'SI Quote Book'
      - id: unused_5
        type: b5
        doc: 'Unused'
  instrument_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status of Symbol'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Session Change Reason'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'Not Applicable to TRADEcho'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order Book Type'
  statistics_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: volume
        type: decimal_u8_4
        doc: 'Cumulative volume of all trades for the trading day. Implied decimal with scale 1e-4'
      - id: volume_on_book_only
        type: decimal_u8_4
        doc: 'Cumulative volume for the trading day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: vwap
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: vwap_on_book_only
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: number_of_trades
        type: u4
        doc: 'Count of all trades for the day'
      - id: number_of_trades_on_book_only
        type: u4
        doc: 'Count of trades for the day excluding off-book trades'
      - id: turnover
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: turnover_on_book_only
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
  mifid_ii_trade_report_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: transaction_identification_code
        type: str_52_nullable
        doc: 'A unique trade identifier'
      - id: total_number_of_transactions
        type: u4
        doc: 'Total Number of Transactions of aggregated trade'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: mi_fid_price
        type: str_20_nullable
        doc: 'MiFID compliant Price field populated using either Price or Yield. Will be set to default value (20 spaces) if there is a pending price (PNDG)'
      - id: mi_fid_quantity
        type: str_20_nullable
        doc: 'Number of units of the financial instrument. {DECIMAL-18/17}'
      - id: mi_fid_trading_date_and_time
        type: str_27_nullable
        doc: 'Date and time when the transaction was executed/ agreed upon'
      - id: instrument_identification_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument Identification Code Type'
      - id: instrument_identification_code
        type: str_12_nullable
        doc: 'Instrument identification number (ISIN code)'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if the price is expressed in monetary value, in percentage or yield'
      - id: price_currency
        type: str_3_nullable
        doc: 'Currency Code as per ISO 4217'
      - id: notional_amount
        type: str_20_nullable
        doc: 'Notional value relevant to the security'
      - id: notional_currency
        type: str_3_nullable
        doc: 'Major currency in which the notional amount is denominated'
      - id: venue_of_execution
        type: str_4_nullable
        doc: 'Identification of the venue where the transaction was executed'
      - id: publication_date_and_time
        type: str_27_nullable
        doc: 'Date and time when the transaction was published'
      - id: benchmark_transaction_flag
        type: str_4_nullable
        doc: 'Benchmark Transaction Flag'
      - id: agency_cross_trade_flag
        type: str_4_nullable
        doc: 'Agency Cross Trade Flag'
      - id: non_price_forming_transactions_flag
        type: str_4_nullable
        doc: 'Non Price Forming Transactions Flag'
      - id: non_price_contribution_to_discovery
        type: str_4_nullable
        doc: 'Non Price Contribution to Discovery'
      - id: special_dividend_flag
        type: str_4_nullable
        doc: 'Special Dividend Flag'
      - id: pt_deferral_reason_flag
        type: str_4_nullable
        doc: 'PT Deferral Reason Flag'
      - id: reference_price_transaction_flag
        type: str_4_nullable
        doc: 'Reference Price Transaction Flag'
      - id: nt_liquidity_flag
        type: str_4_nullable
        doc: 'NT Liquidity Flag'
      - id: nt_price_conditions_flag
        type: str_4_nullable
        doc: 'NT Price Conditions Flag'
      - id: algo_transaction_flag
        type: str_4_nullable
        doc: 'Algo Transaction Flag'
      - id: pt_illiquid_flag
        type: str_4_nullable
        doc: 'PT Illiquid Flag'
      - id: price_improvement_flag
        type: str_4_nullable
        doc: 'Price Improvement Flag'
      - id: cancellation_flag
        type: str_4_nullable
        doc: 'Cancellation Flag'
      - id: amendment_flag
        type: str_4_nullable
        doc: 'Amendment Flag'
      - id: duplicate_flag
        type: str_4_nullable
        doc: 'Duplicate Flag'
      - id: exchange_for_physicals_flag
        type: str_4_nullable
        doc: 'Exchange For Physicals Flag'
      - id: limited_details_flag
        type: str_4_nullable
        doc: 'Limited Details Flag'
      - id: ld_full_details_flag
        type: str_4_nullable
        doc: 'LD Full Details Flag'
      - id: daily_aggregated_transaction_flag
        type: str_4_nullable
        doc: 'Daily Aggregated Transaction Flag'
      - id: da_full_details_flag
        type: str_4_nullable
        doc: 'DA Full Details Flag'
      - id: volume_omission_flag
        type: str_4_nullable
        doc: 'Volume Omission Flag'
      - id: vo_full_details_flag
        type: str_4_nullable
        doc: 'VO Full Details Flag'
      - id: four_weeks_aggregation_flag
        type: str_4_nullable
        doc: 'Four Weeks Aggregation Flag'
      - id: fa_full_details_flag
        type: str_4_nullable
        doc: 'FA Full Details Flag'
      - id: indefinite_aggregation_flag
        type: str_4_nullable
        doc: 'Indefinite Aggregation Flag'
      - id: volume_omission_for_sovereign_debt_flag
        type: str_4_nullable
        doc: 'Volume Omission For Sovereign Debt Flag'
      - id: consecutive_aggregation_flag
        type: str_4_nullable
        doc: 'Consecutive Aggregation Flag'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: venue_type
        type: u1
        enum: venue_type
        doc: 'Type sent by the venue'
      - id: venue_book_definition_id
        type: u1
        enum: venue_book_definition_id
        doc: 'Book Definition ID sent by the venue'
      - id: venue_measurement_unit_notation
        type: str_25_nullable
        doc: 'Notation of the Quantity in Measurement Unit'
      - id: quantity_in_measurement_unit
        type: str_20_nullable
        doc: 'The Quantity in Measurement Unit'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Identifies if the firm intends to clear the transaction. ESMA field for derivatives'
      - id: emission_allowance_type
        type: str_4_nullable
        doc: 'Emission Allowance Type'
      - id: venue_of_publication
        type: str_4_nullable
        doc: 'Identification of the regulatory regime under which the transaction was published. The value sent by the source venue is passed on'
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'Market Mechanism'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'Trading Mode'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction Category'
      - id: negotiation_indicator
        type: u1
        enum: negotiation_indicator
        doc: 'Negotiation Indicator'
      - id: agency_cross_indicator
        type: u1
        enum: agency_cross_indicator
        doc: 'Agency Cross Indicator'
      - id: modification_indicator
        type: u1
        enum: modification_indicator
        doc: 'Modification Indicator'
      - id: reference_price_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reference Price Indicator'
      - id: special_dividend_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Special Dividend Indicator'
      - id: off_book_automated_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Off Book Automated Indicator'
      - id: price_formation_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Price Formation Indicator'
      - id: algorithmic_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Algorithmic Indicator'
      - id: post_trade_deferral_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Post-Trade Deferral Reason'
      - id: deferral_enrichment_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Deferral/ Enrichment Type'
      - id: duplicative_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Duplicative Indicator'
      - id: third_country_trading_venue_of_execution
        type: str_4_nullable
        doc: 'Identification of the third-country trading venue where the transaction was executed'
      - id: portfolio_transaction_flag
        type: str_4_nullable
        doc: 'Portfolio Transaction Flag'
      - id: contingent_transaction_flag
        type: str_4_nullable
        doc: 'Contingent Transaction Flag'
      - id: price_conditions
        type: str_4_nullable
        doc: 'Missing Price (ESMA) / Price Conditions (FCA)'
      - id: market_closing_price_flag
        type: str_4_nullable
        doc: 'Market Closing Price Flag'
      - id: nt_large_in_scale_flag
        type: str_4_nullable
        doc: 'NT Large in Scale Flag'
      - id: nt_pre_trade_transparency_flag
        type: str_4_nullable
        doc: 'NT Pre-Trade Transparency Flag'
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
  str_12_nullable:
    seq:
      - id: value
        size: 12
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_11_nullable:
    seq:
      - id: value
        size: 11
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_2_nullable:
    seq:
      - id: value
        size: 2
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_3_nullable:
    seq:
      - id: value
        size: 3
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  str_52_nullable:
    seq:
      - id: value
        size: 52
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_20_nullable:
    seq:
      - id: value
        size: 20
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_27_nullable:
    seq:
      - id: value
        size: 27
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32
  str_25_nullable:
    seq:
      - id: value
        size: 25
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 32

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'Session transition is advertised via one system event message for all instruments allocated to the same multicast channel'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types (except strategy instruments) on the real time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'A specific instrument be subject to individual status change'
    0x77:
      id: 'statistics_message'
      doc: 'Contains a set of statistics that are updated frequently, usually as a result of executions'
    0x54:
      id: 'mifid_ii_trade_report_message'
      doc: 'Sent to report the MiFID compliant details of a privately negotiated trade'
  event_code:
    0x54:
      id: 'start_of_open'
      doc: 'Start Of Open'
    0x50:
      id: 'start_of_pre_close'
      doc: 'Start Of Pre Close'
  source_venue:
    11:
      id: 'trade_echo'
      doc: 'Trade Echo'
  trading_status:
    0x31:
      id: 'inactive_or_underlying_suspended'
      doc: 'Inactive Or Underlying Suspended'
    0x32:
      id: 'suspended'
      doc: 'Suspended'
    0x33:
      id: 'active'
      doc: 'Active'
    0x50:
      id: 'regulatory_halt'
      doc: 'Regulatory Halt'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
  order_book_type:
    1:
      id: 'si_quote_book'
      doc: 'Si Quote Book'
    2:
      id: 'off_book'
      doc: 'Off Book'
  venue_type:
    0:
      id: 'unspecified'
      doc: 'Unspecified'
    1:
      id: 'mtf'
      doc: 'Mtf'
    2:
      id: 'otf'
      doc: 'Otf'
    3:
      id: 'regulated_market'
      doc: 'Regulated Market'
  venue_book_definition_id:
    0:
      id: 'unspecified'
      doc: 'Unspecified'
    1:
      id: 'off_book'
      doc: 'Off Book'
  transaction_to_be_cleared:
    0x30:
      id: 'no_field'
      doc: 'No'
    0x31:
      id: 'yes_field'
      doc: 'Yes'
  market_mechanism:
    0x34:
      id: 'off_book'
      doc: 'Off Book'
  trading_mode:
    0x35:
      id: 'on_exchange'
      doc: 'On Exchange'
    0x36:
      id: 'off_exchange'
      doc: 'Off Exchange'
    0x37:
      id: 'systemic_internaliser'
      doc: 'Systemic Internaliser'
  transaction_category:
    0x52:
      id: 'trade_that_has_received_price_improvement'
      doc: 'Trade That Has Received Price Improvement'
    0x5a:
      id: 'package_trade_excluding_exchange_for_physicals'
      doc: 'Package Trade Excluding Exchange For Physicals'
    0x59:
      id: 'exchange_for_physicals_trade'
      doc: 'Exchange For Physicals Trade'
    0x47:
      id: 'rfmd_give_up_trade'
      doc: 'Rfmd Give Up Trade'
    0x48:
      id: 'rfmd_give_up_trade_give_and_exchange_for_physicals_trade'
      doc: 'Rfmd Give Up Trade Give And Exchange For Physicals Trade'
    0x2d:
      id: 'none'
      doc: 'None'
  negotiation_indicator:
    0x31:
      id: 'negotiated_trade_in_liquid_financial_instruments'
      doc: 'Negotiated Trade In Liquid Financial Instruments'
    0x32:
      id: 'negotiated_trade_in_illiquid_financial_instruments'
      doc: 'Negotiated Trade In Illiquid Financial Instruments'
    0x33:
      id: 'negotiated_trade_subject_to_conditions_other_than_the_current_market_price'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price'
    0x37:
      id: 'negotiated_trade_larger_than_lis_brought_onto_a_venue'
      doc: 'Negotiated Trade Larger Than Lis Brought Onto A Venue'
    0x38:
      id: 'negotiated_trade_with_pre_trade_transparency_waiver'
      doc: 'Negotiated Trade With Pre Trade Transparency Waiver'
    0x2d:
      id: 'not_a_negotiated_trade'
      doc: 'Not A Negotiated Trade'
  agency_cross_indicator:
    0x58:
      id: 'agency_cross_trade'
      doc: 'Agency Cross Trade'
    0x2d:
      id: 'no_agency_cross_trade'
      doc: 'No Agency Cross Trade'
  modification_indicator:
    0x43:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
    0x41:
      id: 'trade_amendment'
      doc: 'Trade Amendment'
    0x2d:
      id: 'new_trade'
      doc: 'New Trade'

