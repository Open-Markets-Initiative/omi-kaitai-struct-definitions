# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg TradeEcho Mifid2PostTradeRecovery Gtp v27.2.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: MiFID II Post Trade Recovery
#   Encoding: Group Ticker Plant
#   Version: 27.2.2
#   Date: 01/27/2026
#   Specification: gtp-002-technical-guide-tradecho-mifid-post-trade-reporting-issue-27-2-2.pdf
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
  id: lseg_tradeecho_mifid2posttraderecovery_gtp_v27_2_2
  title: Lseg TradeEcho Mifid2PostTradeRecovery Gtp v27.2.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange TRADEcho MiFID II Post Trade Recovery Gtp v27.2.2'
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session. Blank if not applicable'
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
        doc: 'Defines the order-book types that are allowed for the instrument'
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
      - id: security_exchange
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to TRADEcho'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217. For additional currencies supported refer to the Additional Field Values section of this document'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: average_daily_turnover_adt
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
      - id: unused_2
        type: b2
        doc: 'Reserved for future use'
      - id: offbook
        type: b1
        doc: 'Off-book trading is allowed for the instrument'
      - id: unused_5
        type: b5
        doc: 'Reserved for future use'
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session. Blank if not applicable'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason for the session change'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'Not Applicable to TRADEcho'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book type the status applies to'
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
        doc: 'A unique trade identifier. The value will be right aligned'
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
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The trade price, limited to a precision of {DECIMAL-19/18}. Will be set to default value (20 spaces) if there is a pending price (PNDG). In case of transactions under ESMA jurisdiction, will be set to default value (20 spaces) if price is not available (NOAP)'
      - id: quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of units of the financial instrument or the number of derivative contracts in the trade, limited to a precision of {DECIMAL-19/18}. Will be set to default value (20 spaces) if quantity is not available. In case of transactions under FCA jurisdiction, will be set to default value (20 spaces) if the traded security is a bond'
      - id: trading_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed or agreed upon. If a trade is cancelled or amended, this field will contain the trading date and time of the original trade. Blank for aggregated publications: DATF, FWAF, IDAF, COAF, AGFW'
      - id: instrument_identification_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of the instrument identification code'
      - id: instrument_identification_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number (UPI or ISIN code)'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if the price is expressed in monetary value, in percentage or yield. Will be set to default value (4 spaces) if not available'
      - id: price_major_currency_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major currency in which the price is expressed (applicable if the price is expressed as monetary value). Currency Code as per ISO 4217. Price Major Currency (FCA 2017/587) / Price Currency (ESMA, FCA 2017/583)'
      - id: notional_amount
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Notional value relevant to the security, limited to a precision of {DECIMAL-19/18}'
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
        doc: 'Identification of the venue where the transaction was executed. XOFF = OTC, SINT = Systematic Internaliser, or the MIC corresponding to the relevant RM/MTF/OTF'
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
        doc: 'BENC when the trade is a benchmark trade'
      - id: agency_cross_trade_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ACTX when the trade is an agency cross trade'
      - id: non_price_forming_transactions_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NPFT when the trade is a non-price forming trade'
      - id: non_price_contribution_to_discovery
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'TNCP when the trade does not contribute to the price discovery process'
      - id: special_dividend_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SDIV when the trade is a special dividend trade'
      - id: pt_deferral_reason_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Post trade deferral reason, SIZE or LRGS'
      - id: reference_price_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'RFPT when the trade is a reference price trade'
      - id: nt_liquidity_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Negotiated trade liquidity indication, NLIQ or OILQ'
      - id: nt_price_conditions_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PRIC when the negotiated trade is subject to conditions other than the current market price'
      - id: algo_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ALGO when the trade is an algorithmic trade'
      - id: pt_illiquid_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ILQD when publication is deferred for an illiquid instrument'
      - id: price_improvement_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'RPRI when the trade has received price improvement'
      - id: cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'CANC when the trade is a cancellation'
      - id: amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'AMND when the trade is an amendment'
      - id: duplicate_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'DUPL when the trade report is duplicative'
      - id: exchange_for_physicals_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Package or exchange for physicals trade, TPAC or XFPH'
      - id: limited_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'LMTF when the trade is a limited details trade'
      - id: ld_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FULF for full details of an earlier limited details trade'
      - id: daily_aggregated_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'DATF when the trade is a daily aggregated trade'
      - id: da_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FULA for full details of an earlier daily aggregated trade'
      - id: volume_omission_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'VOLO when the trade is a volume omission trade'
      - id: vo_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FULV for full details of an earlier volume omission trade'
      - id: four_weeks_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FWAF when the trade is a four weeks aggregation trade'
      - id: fa_full_details_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'FULJ for full details of an earlier four weeks aggregation trade'
      - id: indefinite_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'IDAF when the trade is an indefinite aggregation trade'
      - id: volume_omission_for_sovereign_debt_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'VOLW for a volume omission trade eligible for subsequent enrichment in aggregated form'
      - id: consecutive_aggregation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'COAF for full details in aggregated form of an earlier volume omission trade'
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
      - id: notation_of_the_quantity_in_measurement_unit
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indication of measurement units used to represent the value in the Quantity in Measurement Unit'
      - id: quantity_in_measurement_unit
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Quantity in Measurement Unit, limited to a precision of IEEE 754 Double Standard'
      - id: transaction_to_be_cleared
        type: u1
        enum: transaction_to_be_cleared
        doc: 'Identifies if the firm intends to clear the transaction. ESMA field for derivatives. Blank if not applicable'
      - id: emission_allowance_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Emission Allowance Type. Blank if not applicable'
      - id: venue_of_publication
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the regulatory regime under which the transaction was published. The value sent by the source venue is passed on. ECHO = UK APA Regulation, ECEU = EU APA Regulation, or the MIC corresponding to the relevant RM/MTF/OTF'
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'Market mechanism on which the transaction was executed'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'Trading mode in which the transaction was executed'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Transaction category short code'
      - id: negotiation_indicator
        type: u1
        enum: negotiation_indicator
        doc: 'Negotiation indicator short code'
      - id: agency_cross_indicator
        type: u1
        enum: agency_cross_indicator
        doc: 'Agency cross indicator short code'
      - id: modification_indicator
        type: u1
        enum: modification_indicator
        doc: 'Modification indicator short code'
      - id: reference_price_indicator
        type: u1
        enum: reference_price_indicator
        doc: 'Reference price indicator short code'
      - id: special_dividend_indicator
        type: u1
        enum: special_dividend_indicator
        doc: 'Special dividend indicator short code'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'Off book automated indicator'
      - id: price_formation_indicator
        type: u1
        enum: price_formation_indicator
        doc: 'Price formation indicator short code'
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        doc: 'Algorithmic indicator short code'
      - id: post_trade_deferral_reason
        type: u1
        enum: post_trade_deferral_reason
        doc: 'Post trade deferral reason short code'
      - id: deferral_enrichment_type
        type: u1
        enum: deferral_enrichment_type
        doc: 'Deferral or enrichment type short code'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'Duplicative indicator short code'
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
        doc: 'PORT when the trade is a portfolio trade'
      - id: contingent_transaction_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'CONT when the trade is a contingent trade'
      - id: missing_price_price_conditions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Missing Price (ESMA) / Price Conditions (FCA), PNDG or NOAP'
      - id: market_closing_price_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'CLSE for a benchmark transaction executed at the market closing price'
      - id: nt_large_in_scale_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NTLS for a negotiated trade larger than LIS brought onto a venue'
      - id: nt_pre_trade_transparency_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NETW for a negotiated trade with a pre trade transparency waiver'
      - id: effective_date_of_the_contract
        type: iso_date
        doc: 'Start date of the contract. Blank if not applicable'
      - id: maturity_date_of_the_contract
        type: iso_date
        doc: 'Termination date of the financial instrument''s contract. Blank if not applicable'
      - id: spread
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The spread on the floating leg, limited to a precision of IEEE 754 Double Standard. Blank if not applicable'
      - id: upfront_payment
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The upfront payment exchanged as part of CDS transactions, limited to a precision of {DECIMAL-19/18}. Blank if not applicable'
      - id: lei_of_clearing_house
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing house which the transaction will be cleared through. Blank if not applicable'
      - id: matched_principal_trade_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MTCH when the trade is a matched principal trade'
      - id: esma_standard_deferral_flags
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ESMA standard deferral flag'
      - id: negotiation_trade_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NEGO when the trade is a negotiation trade'
      - id: esma_supplementary_deferral_flags
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'ESMA supplementary deferral flag'
      - id: trading_system
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of trading system on which the transaction was executed. Blank if not specified in the underlying trade report or Venue of Execution is populated with SINT or XOFF'
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
  iso_date:
    seq:
      - id: text
        type: str
        size: 10
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(5, 7).to_i
      day:
        value: text.substring(8, 10).to_i

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
      doc: 'Broadcast at the start and end of day on TRADEcho. Session transition is advertised via one system event message for all instruments allocated to the same multicast channel'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a limited set of data for all configured instrument types on the real-time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'Should a specific instrument be subject to individual status change, such as suspension or halt, this will be communicated by the instrument status message'
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
    2:
      id: 'offbook'
      doc: 'Offbook'
  source_venue:
    11:
      id: 'trad_echo'
      doc: 'Trad Echo'
  recovery_type:
    0:
      id: 'instrument_directory'
      doc: 'Instrument Directory'
    1:
      id: 'order_book_not_applicable_to_mi_fid_ii_post_trade'
      doc: 'Order Book Not Applicable To Mi Fid Ii Post Trade'
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
      id: 'inactive'
      doc: 'Inactive'
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
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x54:
      id: 'start_of_open'
      doc: 'Start Of Open'
    0x50:
      id: 'start_of_pre_close'
      doc: 'Start Of Pre Close'
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
  order_book_type:
    2:
      id: 'offbook'
      doc: 'Offbook'
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
      id: 'on_book'
      doc: 'On Book'
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
    0x31:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x32:
      id: 'quote_driven_market'
      doc: 'Quote Driven Market'
    0x33:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x34:
      id: 'off_book'
      doc: 'Off Book'
    0x35:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x36:
      id: 'request_for_quotes'
      doc: 'Request For Quotes'
    0x37:
      id: 'any_other_including_hybrid'
      doc: 'Any Other Including Hybrid'
    0x38:
      id: 'hybrid_market'
      doc: 'Hybrid Market'
    0x39:
      id: 'other_market'
      doc: 'Other Market'
  trading_mode:
    0x31:
      id: 'undefined_auction'
      doc: 'Undefined Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
    0x34:
      id: 'out_of_main_session_trading'
      doc: 'Out Of Main Session Trading'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'Trade Reporting On Exchange'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'Trade Reporting Off Exchange'
    0x37:
      id: 'trade_reporting_systemic_internaliser'
      doc: 'Trade Reporting Systemic Internaliser'
    0x4f:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    0x4b:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
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
      id: 'rfmd_give_up_trade_and_exchange_for_physicals_trade'
      doc: 'Rfmd Give Up Trade And Exchange For Physicals Trade'
    0x2d:
      id: 'none_apply'
      doc: 'None Apply'
  negotiation_indicator:
    0x4e:
      id: 'negotiation_trade'
      doc: 'Negotiation Trade'
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
    0x4d:
      id: 'matched_principal_trade'
      doc: 'Matched Principal Trade'
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
  reference_price_indicator:
    0x42:
      id: 'benchmark_trade'
      doc: 'Benchmark Trade'
    0x53:
      id: 'reference_price_trade'
      doc: 'Reference Price Trade'
    0x4f:
      id: 'benchmark_trade_and_portfolio_transaction_and_contingent_transaction'
      doc: 'Benchmark Trade And Portfolio Transaction And Contingent Transaction'
    0x4e:
      id: 'portfolio_transaction_and_contingent_transaction'
      doc: 'Portfolio Transaction And Contingent Transaction'
    0x4d:
      id: 'benchmark_trade_and_contingent_transaction'
      doc: 'Benchmark Trade And Contingent Transaction'
    0x59:
      id: 'benchmark_trade_and_portfolio_transaction'
      doc: 'Benchmark Trade And Portfolio Transaction'
    0x43:
      id: 'contingent_transaction'
      doc: 'Contingent Transaction'
    0x50:
      id: 'portfolio_transaction'
      doc: 'Portfolio Transaction'
    0x31:
      id: 'market_closing_price'
      doc: 'Market Closing Price'
    0x32:
      id: 'market_closing_price_and_portfolio_transaction'
      doc: 'Market Closing Price And Portfolio Transaction'
    0x36:
      id: 'reference_price_trade_and_market_closing_price'
      doc: 'Reference Price Trade And Market Closing Price'
    0x2d:
      id: 'not_a_reference_price_trade'
      doc: 'Not A Reference Price Trade'
  special_dividend_indicator:
    0x45:
      id: 'special_dividend_trade'
      doc: 'Special Dividend Trade'
    0x2d:
      id: 'no_special_dividend_trade'
      doc: 'No Special Dividend Trade'
  off_book_automated_indicator:
    0x4d:
      id: 'off_book_non_automated'
      doc: 'Off Book Non Automated'
    0x51:
      id: 'off_book_automated'
      doc: 'Off Book Automated'
    0x2d:
      id: 'unspecified_or_does_not_apply'
      doc: 'Unspecified Or Does Not Apply'
  price_formation_indicator:
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
    0x54:
      id: 'non_price_forming_trade'
      doc: 'Non Price Forming Trade'
    0x4a:
      id: 'trade_not_contributing_to_price_discovery'
      doc: 'Trade Not Contributing To Price Discovery'
    0x4e:
      id: 'pending_price'
      doc: 'Pending Price'
    0x5a:
      id: 'price_is_not_applicable'
      doc: 'Price Is Not Applicable'
  algorithmic_indicator:
    0x48:
      id: 'algorithmic_trade'
      doc: 'Algorithmic Trade'
    0x2d:
      id: 'not_an_algorithmic_trade'
      doc: 'Not An Algorithmic Trade'
  post_trade_deferral_reason:
    0x32:
      id: 'non_immediate_publication_deferral_for_large_in_scale'
      doc: 'Non Immediate Publication Deferral For Large In Scale'
    0x33:
      id: 'non_immediate_publication_deferral_for_illiquid_instrument'
      doc: 'Non Immediate Publication Deferral For Illiquid Instrument'
    0x34:
      id: 'non_immediate_publication_deferral_for_size_specific'
      doc: 'Non Immediate Publication Deferral For Size Specific'
    0x35:
      id: 'non_immediate_publication_deferrals_of_illiquid_instrument_and_size_specific'
      doc: 'Non Immediate Publication Deferrals Of Illiquid Instrument And Size Specific'
    0x36:
      id: 'non_immediate_publication_deferrals_of_illiquid_instrument_and_large_in_scale'
      doc: 'Non Immediate Publication Deferrals Of Illiquid Instrument And Large In Scale'
    0x41:
      id: 'non_immediate_publication_deferral_for_medium_size_liquid_market'
      doc: 'Non Immediate Publication Deferral For Medium Size Liquid Market'
    0x42:
      id: 'non_immediate_publication_deferral_for_medium_size_illiquid_market'
      doc: 'Non Immediate Publication Deferral For Medium Size Illiquid Market'
    0x43:
      id: 'non_immediate_publication_deferral_for_large_size_liquid_market'
      doc: 'Non Immediate Publication Deferral For Large Size Liquid Market'
    0x44:
      id: 'non_immediate_publication_deferral_for_large_size_illiquid_market'
      doc: 'Non Immediate Publication Deferral For Large Size Illiquid Market'
    0x45:
      id: 'non_immediate_publication_deferral_for_very_large_size_liquid_market'
      doc: 'Non Immediate Publication Deferral For Very Large Size Liquid Market'
    0x46:
      id: 'non_immediate_publication_deferral_for_very_large_size_illiquid_market'
      doc: 'Non Immediate Publication Deferral For Very Large Size Illiquid Market'
    0x47:
      id: 'non_immediate_publication_deferral_for_et_cs_et_ns_sf_ps_emission_allowances'
      doc: 'Non Immediate Publication Deferral For Et Cs Et Ns Sf Ps Emission Allowances'
    0x2d:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
  deferral_enrichment_type:
    0x31:
      id: 'limited_details_trade'
      doc: 'Limited Details Trade'
    0x32:
      id: 'daily_aggregated_trade'
      doc: 'Daily Aggregated Trade'
    0x33:
      id: 'volume_omission_trade'
      doc: 'Volume Omission Trade'
    0x34:
      id: 'four_weeks_aggregation_trade'
      doc: 'Four Weeks Aggregation Trade'
    0x35:
      id: 'indefinite_aggregation_trade'
      doc: 'Indefinite Aggregation Trade'
    0x36:
      id: 'volume_omission_trade_eligible_for_subsequent_enrichment_in_aggregated_form'
      doc: 'Volume Omission Trade Eligible For Subsequent Enrichment In Aggregated Form'
    0x37:
      id: 'full_details_of_earlier_limited_details_trade'
      doc: 'Full Details Of Earlier Limited Details Trade'
    0x38:
      id: 'full_details_of_earlier_daily_aggregated_trade'
      doc: 'Full Details Of Earlier Daily Aggregated Trade'
    0x39:
      id: 'full_details_of_earlier_volume_omission_trade'
      doc: 'Full Details Of Earlier Volume Omission Trade'
    0x56:
      id: 'full_details_of_earlier_four_weeks_aggregation_trade'
      doc: 'Full Details Of Earlier Four Weeks Aggregation Trade'
    0x57:
      id: 'full_details_in_aggregated_form_of_earlier_volume_omission_trade'
      doc: 'Full Details In Aggregated Form Of Earlier Volume Omission Trade'
    0x4a:
      id: 'volume_omission_for_sovereign_bonds_trade'
      doc: 'Volume Omission For Sovereign Bonds Trade'
    0x4c:
      id: 'full_details_of_earlier_volume_omission_sovereign_bond_trade'
      doc: 'Full Details Of Earlier Volume Omission Sovereign Bond Trade'
    0x4b:
      id: 'four_weeks_aggregation_for_sovereign_bonds_trade'
      doc: 'Four Weeks Aggregation For Sovereign Bonds Trade'
    0x4d:
      id: 'full_details_of_earlier_aggregated_sovereign_bond_trade'
      doc: 'Full Details Of Earlier Aggregated Sovereign Bond Trade'
    0x2d:
      id: 'not_applicable_or_no_relevant_enrichment_type'
      doc: 'Not Applicable Or No Relevant Enrichment Type'
  duplicative_indicator:
    0x31:
      id: 'duplicative_trade_report'
      doc: 'Duplicative Trade Report'
    0x32:
      id: 'intra_group_trade'
      doc: 'Intra Group Trade'
    0x33:
      id: 'duplicative_trade_report_and_intra_group_trade'
      doc: 'Duplicative Trade Report And Intra Group Trade'
    0x34:
      id: 'cross_border_duplicative_trade_report'
      doc: 'Cross Border Duplicative Trade Report'
    0x35:
      id: 'duplicative_trade_report_and_cross_border_duplicative_trade_report'
      doc: 'Duplicative Trade Report And Cross Border Duplicative Trade Report'
    0x36:
      id: 'duplicative_trade_report_and_intra_group_trade_and_cross_border_duplicative_trade_report'
      doc: 'Duplicative Trade Report And Intra Group Trade And Cross Border Duplicative Trade Report'
    0x37:
      id: 'intra_group_trade_and_cross_border_duplicative_trade_report'
      doc: 'Intra Group Trade And Cross Border Duplicative Trade Report'
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique Trade Report'

