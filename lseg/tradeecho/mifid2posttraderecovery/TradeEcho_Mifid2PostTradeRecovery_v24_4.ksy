# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg TradeEcho Mifid2PostTradeRecovery Gtp v24.4
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: MiFID II Post Trade Recovery
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
  id: lseg_tradeecho_mifid2posttraderecovery_gtp_v24_4
  title: Lseg TradeEcho Mifid2PostTradeRecovery Gtp v24.4
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange TRADEcho MiFID II Post Trade Recovery Gtp v24.4'
doc-ref: https://www.londonstockexchange.com/resources/equities-trading-resources/gtp-technical-specifications

seq:
  - id: tcp_unit
    type: tcp_unit_struct
    repeat: eos
    doc: 'One unit on the tcp stream: the unit header and its payload messages'

types:
  tcp_unit_struct:
    seq:
      - id: unit_header
        type: unit_header
        doc: 'Gtp Tcp Unit Header'
      - id: message
        type: message
        repeat: expr
        repeat-expr: unit_header.message_count
        doc: 'Gtp Tcp Message'
  unit_header:
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
        doc: 'Only valid if Recovery Type = 2 (Trades). If specified, the trades reported with an equal or higher sequence number will be sent'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Gtp Tcp Message Header'
      - id: payload
        size: message_header.message_length - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_request_message': login_request_message
            'message_type::recovery_request_message': recovery_request_message
            'message_type::login_response_message': login_response_message
            'message_type::recovery_response_message': recovery_response_message
            'message_type::replay_and_recovery_complete_message': replay_and_recovery_complete_message
            'message_type::system_event_message': system_event_message
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::statistics_snapshot_message': statistics_snapshot_message
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
  login_request_message:
    seq:
      - id: username
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'CompID assigned to the client'
  recovery_request_message:
    seq:
      - id: request_level
        type: u1
        enum: request_level
        doc: 'Defines the level of the request'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: group_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group/Segment ID if Request Level is 1. Blank if not'
      - id: request_order_book_type
        type: u1
        enum: request_order_book_type
        doc: 'Only considered if the Request Level is 0. If specified, only data related to the specified order book type is provided. If not specified, data for all available book types for the instrument are provided. For Recovery Type = 3 (Statistics) this has to be set to ''0'' = All'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: recovery_type
        type: u1
        enum: recovery_type
        doc: 'The type of messages to be replayed'
      - id: sequence_number
        type: u4
        doc: 'Only valid if Recovery Type = 2 (Trades). If specified, the trades reported with an equal or higher sequence number will be sent'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Recovery Response and Recovery Complete. The system will not validate uniqueness of the set value'
  login_response_message:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Status of the login request'
  recovery_response_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Only valid if Recovery Type = 2 (Trades). If specified, the trades reported with an equal or higher sequence number will be sent'
      - id: count
        type: u4
        doc: 'Number of messages to follow, not including any Replay and Recovery Complete messages. This will be zero if Status is not ''A'''
      - id: recovery_status
        type: u1
        enum: recovery_status
        doc: 'Status of the recovery request'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Recovery Response and Recovery Complete. The system will not validate uniqueness of the set value'
  replay_and_recovery_complete_message:
    seq:
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Recovery Response and Recovery Complete. The system will not validate uniqueness of the set value'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
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
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of an instrument'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Allowed Book Type Flags'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: venue_instrument_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identifier used by the source venue'
      - id: tick_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
      - id: reserved_11
        size: 11
        doc: 'Reserved for future use'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
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
  statistics_snapshot_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: volume
        type: decimal_u8_4
        doc: 'Cumulative volume of all trades for the trading day. Implied decimal with scale 1e-4'
      - id: volume_onbook_only
        type: decimal_u8_4
        doc: 'Cumulative volume for the trading day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: vwap
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: vwap_onbook_only
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: number_of_trades
        type: u4
        doc: 'Count of all trades for the day'
      - id: number_of_trades_onbook_only
        type: u4
        doc: 'Count of trades for the day excluding off-book trades'
      - id: turnover
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: turnover_onbook_only
        type: decimal_s8_4
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-4'
      - id: official_opening_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: official_closing_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_high_onbook_only
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_low_onbook_only
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_high
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_low
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: fifty_two_week_trade_high
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: fifty_two_week_trade_low
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: opening_price_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not Applicable to TRADEcho'
      - id: closing_price_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not Applicable to TRADEcho'
      - id: iau_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: iau_paired_size
        type: decimal_u8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: imbalance_quantity
        type: decimal_u8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: imbalance_direction
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not Applicable to TRADEcho'
      - id: best_closing_bid_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: best_closing_ask_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: best_closing_bid_size
        type: decimal_u8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: best_closing_ask_size
        type: decimal_u8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_high_off_book
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: trade_low_off_book
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: auction_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not Applicable to TRADEcho'
      - id: last_trade_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: last_trade_quantity
        type: decimal_u8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: last_trade_time
        type: nanosecond_timestamp
        doc: 'Not Applicable to TRADEcho. Nanoseconds since Unix epoch'
      - id: static_reference_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: dynamic_reference_price
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
  mifid_ii_trade_report_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: transaction_identification_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'MiFID compliant Price field populated using either Price or Yield. Will be set to default value (20 spaces) if there is a pending price (PNDG)'
      - id: mi_fid_quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument. {DECIMAL-18/17}'
      - id: mi_fid_trading_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed/ agreed upon'
      - id: instrument_identification_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument Identification Code Type'
      - id: instrument_identification_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number (ISIN code)'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if the price is expressed in monetary value, in percentage or yield'
      - id: price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217'
      - id: notional_amount
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Notional value relevant to the security'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major currency in which the notional amount is denominated'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the transaction was executed'
      - id: publication_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was published'
      - id: benchmark_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Benchmark Transaction Flag'
      - id: agency_cross_trade_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Agency Cross Trade Flag'
      - id: non_price_forming_transactions_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Non Price Forming Transactions Flag'
      - id: non_price_contribution_to_discovery
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Non Price Contribution to Discovery'
      - id: special_dividend_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Special Dividend Flag'
      - id: pt_deferral_reason_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Deferral Reason Flag'
      - id: reference_price_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference Price Transaction Flag'
      - id: nt_liquidity_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NT Liquidity Flag'
      - id: nt_price_conditions_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NT Price Conditions Flag'
      - id: algo_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Algo Transaction Flag'
      - id: pt_illiquid_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Illiquid Flag'
      - id: price_improvement_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price Improvement Flag'
      - id: cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cancellation Flag'
      - id: amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Amendment Flag'
      - id: duplicate_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Duplicate Flag'
      - id: exchange_for_physicals_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange For Physicals Flag'
      - id: limited_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Limited Details Flag'
      - id: ld_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'LD Full Details Flag'
      - id: daily_aggregated_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Daily Aggregated Transaction Flag'
      - id: da_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'DA Full Details Flag'
      - id: volume_omission_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Volume Omission Flag'
      - id: vo_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'VO Full Details Flag'
      - id: four_weeks_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Four Weeks Aggregation Flag'
      - id: fa_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FA Full Details Flag'
      - id: indefinite_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indefinite Aggregation Flag'
      - id: volume_omission_for_sovereign_debt_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Volume Omission For Sovereign Debt Flag'
      - id: consecutive_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
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
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Notation of the Quantity in Measurement Unit'
      - id: quantity_in_measurement_unit
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Quantity in Measurement Unit'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Identifies if the firm intends to clear the transaction. ESMA field for derivatives'
      - id: emission_allowance_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emission Allowance Type'
      - id: venue_of_publication
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
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
      - id: thirdcountry_trading_venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the third-country trading venue where the transaction was executed'
      - id: portfolio_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Portfolio Transaction Flag'
      - id: contingent_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contingent Transaction Flag'
      - id: price_conditions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Missing Price (ESMA) / Price Conditions (FCA)'
      - id: market_closing_price_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Closing Price Flag'
      - id: nt_large_in_scale_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NT Large in Scale Flag'
      - id: nt_pre_trade_transparency_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the replay or recovery channel.'
    0x81:
      id: 'recovery_request_message'
      doc: 'Used by the client to request data on the recovery channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request to the replay or recovery channel.'
    0x82:
      id: 'recovery_response_message'
      doc: 'Used by the server to respond to a snapshot request on the recovery channel.'
    0x83:
      id: 'replay_and_recovery_complete_message'
      doc: 'Used by the server to indicate the successful completion of servicing a message replay or a recovery request.'
    0x53:
      id: 'system_event_message'
      doc: 'Session transition is advertised via one system event message for all instruments allocated to the same multicast channel'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types (except strategy instruments) on the real time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'A specific instrument be subject to individual status change'
    0x6b:
      id: 'statistics_snapshot_message'
      doc: 'A snapshot of an instrument''s statistics that is used for recovery'
    0x54:
      id: 'mifid_ii_trade_report_message'
      doc: 'Sent to report the MiFID compliant details of a privately negotiated trade'
  request_level:
    0:
      id: 'instrument'
      doc: 'Instrument'
    1:
      id: 'group_segment'
      doc: 'Group Segment'
    2:
      id: 'multicast_channel'
      doc: 'Multicast Channel'
  request_order_book_type:
    0:
      id: 'all_books'
      doc: 'All Books'
    1:
      id: 'si_quote_book'
      doc: 'Si Quote Book'
    2:
      id: 'offbook'
      doc: 'Offbook'
  source_venue:
    11:
      id: 'trade_echo'
      doc: 'Trade Echo'
  recovery_type:
    0:
      id: 'instrument_directory'
      doc: 'Instrument Directory'
    1:
      id: 'order_book'
      doc: 'Order Book'
    2:
      id: 'all_trades'
      doc: 'All Trades'
    3:
      id: 'statistics'
      doc: 'Statistics'
    4:
      id: 'instrument_status'
      doc: 'Instrument Status'
    5:
      id: 'reserved'
      doc: 'Reserved'
    6:
      id: 'system_event'
      doc: 'System Event'
  login_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x61:
      id: 'comp_id_inactive_suspended'
      doc: 'Comp Id Inactive Suspended'
    0x62:
      id: 'login_limit_reached'
      doc: 'Login Limit Reached'
    0x63:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
    0x64:
      id: 'maximum_connections_limit_reached'
      doc: 'Maximum Connections Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
    0x66:
      id: 'invalid_comp_id_or_ip_address'
      doc: 'Invalid Comp Id Or Ip Address'
  recovery_status:
    0x41:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x61:
      id: 'invalid_group_or_instrument'
      doc: 'Invalid Group Or Instrument'
    0x62:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x64:
      id: 'invalid_recovery_type_or_request_level'
      doc: 'Invalid Recovery Type Or Request Level'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
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
  event_code:
    0x54:
      id: 'start_of_open'
      doc: 'Start Of Open'
    0x50:
      id: 'start_of_pre_close'
      doc: 'Start Of Pre Close'
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
      id: 'negotiated_trade_with_pretrade_transparency_waiver'
      doc: 'Negotiated Trade With Pretrade Transparency Waiver'
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

