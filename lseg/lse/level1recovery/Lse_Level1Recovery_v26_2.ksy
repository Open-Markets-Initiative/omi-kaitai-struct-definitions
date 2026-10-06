# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Lse Level1Recovery Gtp v26.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Level 1 Recovery
#   Encoding: Group Ticker Plant
#   Version: 26.2
#   Date: 10/15/2025
#   Specification: gtp-002-technical-guide-london-stock-exchange-issue-26.2.pdf
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
  id: lseg_lse_level1recovery_gtp_v26_2
  title: Lseg Lse Level1Recovery Gtp v26.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange London Stock Exchange Level 1 Recovery Gtp v26.2'
doc-ref: https://www.lseg.com/areas-expertise/technology/group-technology/group-ticker-plant

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
            'message_type::instrument_status_message': instrument_status_message
            'message_type::top_of_book_message': top_of_book_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::trade_message': trade_message
            'message_type::instrument_directory_equities_message': instrument_directory_equities_message
            'message_type::statistics_snapshot_message': statistics_snapshot_message
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
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
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
        doc: 'Start or end of day event code'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
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
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason the trading session changed'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'New time the session will end. The field will contain only spaces if Session Change Reason is ''0'' or the Session Change Reason is not present. New End Time will be in terms of the local time on the server (i.e., not UTC)'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
  top_of_book_message:
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
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: bid_market_size
        type: decimal_u8_8
        doc: 'Aggregated size of all bid market orders. Value will be 0 if there are no market orders. Implied decimal with scale 1e-8'
      - id: bid_limit_price
        type: decimal_s8_8
        doc: 'Price of the best buy limit order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: bid_limit_size
        type: decimal_u8_8
        doc: 'Aggregated size of all orders at the best buy limit price. Implied decimal with scale 1e-8'
      - id: offer_market_size
        type: decimal_u8_8
        doc: 'Aggregated size of all offer market orders. Value will be 0 if there are no market orders. Implied decimal with scale 1e-8'
      - id: offer_limit_price
        type: decimal_s8_8
        doc: 'Price of the best sell limit order. Implied decimal with scale 1e-8'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: offer_limit_size
        type: decimal_u8_8
        doc: 'Aggregated size of all orders at the best sell limit price. Implied decimal with scale 1e-8'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
      - id: top_of_book_flags
        type: top_of_book_flags
        doc: 'Top of Book Flags'
  top_of_book_flags:
    meta:
      bit-endian: le
    seq:
      - id: bid_depth
        type: b1
        doc: 'Bid Depth'
      - id: offer_depth
        type: b1
        doc: 'Offer Depth'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  order_book_clear_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Execution timestamp as reported by the supported market. If a trade is cancelled or amended, this field will contain the transaction time of the original trade. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: executed_size
        type: decimal_u8_8
        doc: 'Total executed quantity. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier if Request Level is 0. Blank if not'
      - id: price
        type: decimal_s8_8
        doc: 'Executed price. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'The value in this field is only relevant when Trade Type is 1'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
      - id: hidden_execution_indicator
        type: u1
        enum: hidden_execution_indicator
        doc: 'For London Stock Exchange, during continuous trading and CPX session, 1[2] will be sent for execution of visible[hidden] quantities. For London Stock Exchange Auction Trades, 0 will be sent indicating ''Not Applicable'' (N/A)'
      - id: trade_qualifier
        type: u1
        enum: trade_qualifier
        doc: 'Qualifier of the trade'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancellation
        type: b1
        doc: 'Trade Cancellation'
      - id: trade_correction
        type: b1
        doc: 'Trade Correction'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  instrument_directory_equities_message:
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
        doc: 'ISIN code of the instrument'
      - id: sedol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'SEDOL code of the instrument'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Defines the order-book types that are allowed for the instrument'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: venue_instrument_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identifier used by the source venue'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code as per ISO 4217'
      - id: tick_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The tick structure applicable for the instrument'
      - id: previous_days_closing_price
        type: decimal_s8_8
        doc: 'Closing price reported for the previous trading day. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: dynamic_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Dynamic Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: static_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Static Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: first_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: expiration_date
        type: yyyymmdd_ascii_date
        doc: 'Expiration date of the instrument'
      - id: listing_start_date
        type: yyyymmdd_ascii_date
        doc: 'Listing start date of the instrument'
      - id: listing_end_date
        type: yyyymmdd_ascii_date
        doc: 'Listing end date of the instrument'
      - id: minimum_lot_minimum_execution_size
        type: decimal_u8_8
        doc: 'Indicates the minimum quantity/nominal value tradable on the market for a security. Implied decimal with scale 1e-8'
      - id: last_price_in_preceding_session
        type: decimal_s8_8
        doc: 'Last execution price in a session prior to the current trading day. Implied decimal with scale 1e-8'
      - id: last_price_in_preceding_session_date
        type: yyyymmdd_ascii_date
        doc: 'Last execution date in a session prior to current trading day'
      - id: third_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: ex_marker_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The value of an Ex-Marker pertaining to a tradable instrument'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Type of security'
      - id: country_of_register
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Country of Register'
      - id: exchange_market_size
        type: u8
        doc: 'The Exchange Market Size (EMS) is set to show the minimum size a market maker must quote in an individual security for all executable and non executable quotes'
      - id: minimum_peak_size_multiplier
        type: decimal_u8_8
        doc: 'Used to specify the minimum size of an iceberg peak for an instrument in conjunction with EMS. Implied decimal with scale 1e-8'
      - id: security_maximum_spread
        type: decimal_s8_8
        doc: 'This field informs Participants of the maximum spread allowable for an instrument when submitting quote messages, calculated as a percentage of mid-price. Implied decimal with scale 1e-8'
      - id: clearing_type
        type: u1
        enum: clearing_type
        doc: 'Indicates the settlement mode of the security'
      - id: strike_price
        type: decimal_s8_8
        doc: 'Strike Price (exercise price for warrants). Implied decimal with scale 1e-8'
      - id: security_exchange
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to LSE'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: fourth_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: fifth_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: partition_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trading System''s partition in which the instrument is traded'
      - id: sixth_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: seventh_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the instrument'
      - id: description
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Description of the instrument'
  allowed_book_types:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: firm_quote_book
        type: b1
        doc: 'Firm Quote Book'
      - id: offbook
        type: b1
        doc: 'Off-book'
      - id: electronic_order_book
        type: b1
        doc: 'Electronic Order Book'
      - id: private_rfq
        type: b1
        doc: 'Private RFQ'
      - id: unused_3
        type: b3
        doc: 'Reserved'
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
        doc: 'Mandatory field if Request Level = 1. Not considered for other Request Levels'
      - id: volume
        type: decimal_u8_4
        doc: 'Cumulative volume of all trades for the trading day. Implied decimal with scale 1e-4'
      - id: volume_onbook_only
        type: decimal_u8_4
        doc: 'Cumulative volume for the trading day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: vwap
        type: decimal_s8_4
        doc: 'Volume weighted average price for the day for all trades. Implied decimal with scale 1e-4'
      - id: vwap_onbook_only
        type: decimal_s8_4
        doc: 'Volume weighted average price for the day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: number_of_trades
        type: u4
        doc: 'Count of all trades for the day'
      - id: number_of_trades_onbook_only
        type: u4
        doc: 'Count of trades for the day excluding off-book trades'
      - id: turnover
        type: decimal_s8_4
        doc: 'Turnover of all trades for the day. Implied decimal with scale 1e-4'
      - id: turnover_onbook_only
        type: decimal_s8_4
        doc: 'Turnover for the day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: official_opening_price
        type: decimal_s8_8
        doc: 'Official Opening Price for the instrument. If the Opening Price is cleared manually by the venue ''-1'' will be stamped. Implied decimal with scale 1e-8'
      - id: official_closing_price
        type: decimal_s8_8
        doc: 'Official Closing Price for the instrument. If the Closing Price is cleared manually by the venue ''-1'' will be stamped. Implied decimal with scale 1e-8'
      - id: trade_high_onbook_only
        type: decimal_s8_8
        doc: 'Current trading day high price excluding off-book trades. Implied decimal with scale 1e-8'
      - id: trade_low_onbook_only
        type: decimal_s8_8
        doc: 'Current trading day low price excluding off-book trades. Implied decimal with scale 1e-8'
      - id: trade_high
        type: decimal_s8_8
        doc: 'Current trading day high price of all trades. Implied decimal with scale 1e-8'
      - id: trade_low
        type: decimal_s8_8
        doc: 'Current trading day low price of all trades. Implied decimal with scale 1e-8'
      - id: fifty_two_week_trade_high
        type: decimal_s8_8
        doc: '52-week high price of all trades. Implied decimal with scale 1e-8'
      - id: fifty_two_week_trade_low
        type: decimal_s8_8
        doc: '52-week low price of all trades. Implied decimal with scale 1e-8'
      - id: opening_price_indicator
        type: u1
        enum: opening_price_indicator
        doc: 'Please refer to Description in Statistics Update message for valid values. This will be blank if no Opening Price is contained within the snapshot'
      - id: closing_price_indicator
        type: u1
        enum: closing_price_indicator
        doc: 'Please refer to Description in Statistics Update message for valid values. This will be blank if no Closing Price is contained within the snapshot'
      - id: iau_price
        type: decimal_s8_8
        doc: 'Contains the last reported Indicative Auction Crossing Price. Implied decimal with scale 1e-8'
      - id: iau_paired_size
        type: decimal_u8_8
        doc: 'Quantity to be matched at the last reported indicative price. Implied decimal with scale 1e-8'
      - id: imbalance_quantity
        type: decimal_u8_8
        doc: 'Quantity that was eligible to be matched at the indicative price but was not matched at the last indicative price. Implied decimal with scale 1e-8'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Direction of the imbalance'
      - id: best_closing_bid_price
        type: decimal_s8_8
        doc: 'The best bid price at the time the instrument moves into closing auction session. Implied decimal with scale 1e-8'
      - id: best_closing_ask_price
        type: decimal_s8_8
        doc: 'The best offer price at the time the instrument moves into closing auction session. Implied decimal with scale 1e-8'
      - id: best_closing_bid_size
        type: decimal_u8_8
        doc: 'The best bid size at the time the instrument moves into closing auction session. Implied decimal with scale 1e-8'
      - id: best_closing_ask_size
        type: decimal_u8_8
        doc: 'The best offer size at the time the instrument moves into closing auction session. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: fourth_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'The value in this field is only relevant when Trade Type is 1'
      - id: last_trade_price
        type: decimal_s8_8
        doc: 'Executed price at which the instrument was last traded. If no relevant trades have taken place the value ''0'' will be populated. Implied decimal with scale 1e-8'
      - id: last_trade_quantity
        type: decimal_u8_8
        doc: 'Executed quantity of the trade which set the ''Last Trade Price''. If no relevant trades have taken place the value ''0'' will be populated. Implied decimal with scale 1e-8'
      - id: last_trade_time
        type: nanosecond_timestamp
        doc: 'Transaction time of the trade which set the ''Last Trade Price''. If no relevant trades have taken place the value ''0'' will be populated. Nanoseconds since Unix epoch'
      - id: static_reference_price
        type: decimal_s8_8
        doc: 'Reference Price as reported by the source venue. Implied decimal with scale 1e-8'
      - id: dynamic_reference_price
        type: decimal_s8_8
        doc: 'Reference Price as reported by the source venue. Implied decimal with scale 1e-8'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

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
      doc: 'Used by the server to respond to a snapshot request on the Snapshot channel.'
    0x83:
      id: 'replay_and_recovery_complete_message'
      doc: 'Used by the server to indicate the successful completion of servicing a message replay or a recovery request.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes. When sent in the recovery channel, used to indicate the current trading status of an instrument.'
    0x69:
      id: 'top_of_book_message'
      doc: 'Used to update the level 1 service following any change to the consolidated Best Bid and Offer.'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument.'
    0x50:
      id: 'trade_message'
      doc: 'Sent to indicate trades executed on supported markets.'
    0x52:
      id: 'instrument_directory_equities_message'
      doc: 'Used to disseminate reference data information of equity instruments.'
    0x6b:
      id: 'statistics_snapshot_message'
      doc: 'A snapshot of an instrument''s statistics that is used for recovery.'
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
      id: 'firm_quote_book'
      doc: 'Firm Quote Book'
    2:
      id: 'offbook'
      doc: 'Offbook'
    3:
      id: 'electronic_order_book'
      doc: 'Electronic Order Book'
    4:
      id: 'private_rfq'
      doc: 'Private Rfq'
  source_venue:
    1:
      id: 'london_stock_exchange'
      doc: 'London Stock Exchange'
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
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x4a:
      id: 'halt_matching_partition_suspended'
      doc: 'Halt Matching Partition Suspended'
    0x4b:
      id: 'halt_system_suspended'
      doc: 'Halt System Suspended'
    0x54:
      id: 'regular_trading_start_trade_reporting'
      doc: 'Regular Trading Start Trade Reporting'
    0x50:
      id: 'halt_regulatory'
      doc: 'Halt Regulatory'
    0x74:
      id: 'end_trade_reporting'
      doc: 'End Trade Reporting'
    0x61:
      id: 'opening_auction_call'
      doc: 'Opening Auction Call'
    0x62:
      id: 'post_close'
      doc: 'Post Close'
    0x63:
      id: 'closed'
      doc: 'Closed'
    0x64:
      id: 'closing_auction_call'
      doc: 'Closing Auction Call'
    0x65:
      id: 'aesp_auction_call'
      doc: 'Aesp Auction Call'
    0x66:
      id: 'resume_auction'
      doc: 'Resume Auction'
    0x6d:
      id: 'pre_mandatory'
      doc: 'Pre Mandatory'
    0x6e:
      id: 'mandatory'
      doc: 'Mandatory'
    0x6f:
      id: 'post_mandatory'
      doc: 'Post Mandatory'
    0x71:
      id: 'edsp_auction_call'
      doc: 'Edsp Auction Call'
    0x72:
      id: 'periodic_auction_call'
      doc: 'Periodic Auction Call'
    0x31:
      id: 'inactive'
      doc: 'Inactive'
    0x32:
      id: 'suspended'
      doc: 'Suspended'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x75:
      id: 'closing_price_crossing_session'
      doc: 'Closing Price Crossing Session'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
    1:
      id: 'extended_by_market_ops'
      doc: 'Extended By Market Ops'
    2:
      id: 'shortened_by_market_ops'
      doc: 'Shortened By Market Ops'
    3:
      id: 'market_order_imbalance'
      doc: 'Market Order Imbalance'
    4:
      id: 'price_outside_range'
      doc: 'Price Outside Range'
    5:
      id: 'aesp_circuit_breaker_tripped'
      doc: 'Aesp Circuit Breaker Tripped'
    9:
      id: 'unavailable'
      doc: 'Unavailable'
  order_book_type:
    1:
      id: 'firm_quote_book'
      doc: 'Firm Quote Book'
    2:
      id: 'offbook'
      doc: 'Offbook'
    3:
      id: 'electronic_order_book'
      doc: 'Electronic Order Book'
    4:
      id: 'private_rfq'
      doc: 'Private Rfq'
  trade_type:
    0:
      id: 'regular_or_continuous_trade'
      doc: 'Regular Or Continuous Trade'
    1:
      id: 'auction_trade_bulk'
      doc: 'Auction Trade Bulk'
    2:
      id: 'auction_trade_individual'
      doc: 'Auction Trade Individual'
    9:
      id: 'onbook_trade_cancellation'
      doc: 'Onbook Trade Cancellation'
    11:
      id: 'trade_correction'
      doc: 'Trade Correction'
    22:
      id: 'rfq_trade'
      doc: 'Rfq Trade'
    23:
      id: 'rfq_trade_cancellation'
      doc: 'Rfq Trade Cancellation'
    24:
      id: 'rfq_trade_correction'
      doc: 'Rfq Trade Correction'
  auction_type:
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x41:
      id: 'aesp'
      doc: 'Aesp'
    0x42:
      id: 'edsp'
      doc: 'Edsp'
    0x45:
      id: 'resume_auction'
      doc: 'Resume Auction'
    0x46:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  hidden_execution_indicator:
    0:
      id: 'na'
      doc: 'Na'
    1:
      id: 'visible'
      doc: 'Visible'
    2:
      id: 'hidden'
      doc: 'Hidden'
  trade_qualifier:
    0x20:
      id: 'na'
      doc: 'Na'
    0x43:
      id: 'closing_price_cross_cpx'
      doc: 'Closing Price Cross Cpx'
  security_type:
    1:
      id: 'international_equity'
      doc: 'International Equity'
    4:
      id: 'convertible_bond'
      doc: 'Convertible Bond'
    5:
      id: 'right'
      doc: 'Right'
    39:
      id: 'bonds'
      doc: 'Bonds'
    43:
      id: 'covered_warrants'
      doc: 'Covered Warrants'
    44:
      id: 'debenture'
      doc: 'Debenture'
    45:
      id: 'uk_equity'
      doc: 'Uk Equity'
    46:
      id: 'deposit_receipts'
      doc: 'Deposit Receipts'
    47:
      id: 'equity_warrants'
      doc: 'Equity Warrants'
    48:
      id: 'foreign_government_bonds'
      doc: 'Foreign Government Bonds'
    53:
      id: 'gilts'
      doc: 'Gilts'
    56:
      id: 'loan_stock'
      doc: 'Loan Stock'
    57:
      id: 'medium_term_loans'
      doc: 'Medium Term Loans'
    64:
      id: 'preference_shares'
      doc: 'Preference Shares'
    66:
      id: 'package_units'
      doc: 'Package Units'
    69:
      id: 'structured_products'
      doc: 'Structured Products'
  clearing_type:
    0:
      id: 'not_cleared'
      doc: 'Not Cleared'
    1:
      id: 'cleared'
      doc: 'Cleared'
  opening_price_indicator:
    0x41:
      id: 'ut'
      doc: 'Ut'
    0x42:
      id: 'at'
      doc: 'At'
    0x43:
      id: 'mid_of_bbo'
      doc: 'Mid Of Bbo'
    0x44:
      id: 'last_at'
      doc: 'Last At'
    0x45:
      id: 'last_ut'
      doc: 'Last Ut'
    0x46:
      id: 'manual'
      doc: 'Manual'
    0x49:
      id: 'previous_close'
      doc: 'Previous Close'
  closing_price_indicator:
    0x41:
      id: 'ut'
      doc: 'Ut'
    0x42:
      id: 'at'
      doc: 'At'
    0x43:
      id: 'mid_of_bbo'
      doc: 'Mid Of Bbo'
    0x44:
      id: 'last_at'
      doc: 'Last At'
    0x45:
      id: 'last_ut'
      doc: 'Last Ut'
    0x46:
      id: 'manual'
      doc: 'Manual'
    0x49:
      id: 'previous_close'
      doc: 'Previous Close'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders_for_auction'
      doc: 'Insufficient Orders For Auction'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'

