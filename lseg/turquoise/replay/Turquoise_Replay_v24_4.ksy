# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Turquoise Replay Gtp v24.4
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Replay
#   Encoding: Group Ticker Plant
#   Version: 24.4
#   Date: 4/24/2024
#   Specification: gtp-002-technical-guide-turquoise-issue-24-4.pdf
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
  id: lseg_turquoise_replay_gtp_v24_4
  title: Lseg Turquoise Replay Gtp v24.4
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Turquoise Replay Gtp v24.4'
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
        doc: 'Sequence number of the first payload message'
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
            'message_type::replay_request_message': replay_request_message
            'message_type::login_response_message': login_response_message
            'message_type::replay_response_message': replay_response_message
            'message_type::replay_and_recovery_complete_message': replay_and_recovery_complete_message
            'message_type::system_event_message': system_event_message
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::add_order_incremental_message': add_order_incremental_message
            'message_type::order_modify_message': order_modify_message
            'message_type::order_delete_message': order_delete_message
            'message_type::top_of_book_message': top_of_book_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::trade_message': trade_message
            'message_type::trade_cross_message': trade_cross_message
            'message_type::statistics_message': statistics_message
            'message_type::statistics_update_message': statistics_update_message
            'message_type::mifid_ii_trade_message': mifid_ii_trade_message
            'message_type::mi_fid_ii_trade_cross_message': mi_fid_ii_trade_cross_message
            'message_type::trade_summary_message': trade_summary_message
            'message_type::analytics_message': analytics_message
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
  replay_request_message:
    seq:
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u4
        doc: 'Number of messages to be resent'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
  login_response_message:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Status of the login request'
  replay_response_message:
    seq:
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u4
        doc: 'Number of messages to be resent'
      - id: replay_status
        type: u1
        enum: replay_status
        doc: 'Status of the replay request'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
  replay_and_recovery_complete_message:
    seq:
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
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
        doc: 'Event Code'
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
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of an instrument'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Allowed Book Types Flags'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: venue_instrument_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'MTF symbol used by the source venue. It will contain the suffixes as specified in the table below:'
      - id: tick_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The tick structure applicable for the instrument'
      - id: price_band_tolerances
        type: decimal_s8_8
        doc: 'Price Band Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: dynamic_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Dynamic Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: static_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Static Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
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
      - id: average_daily_turnover_adt
        type: decimal_s8_4
        doc: 'Not Applicable to Turquoise. Implied decimal with scale 1e-4'
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
      - id: unused_3
        type: b3
        doc: 'Unused'
      - id: electronic_order_book
        type: b1
        doc: 'Electronic Order Book'
      - id: unused_4
        type: b4
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason the trading session changed'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'New time the session will end. The field will contain only spaces if Session Change Reason is "0" or the Session Change Reason is not present. New End Time will be in terms of the local time on the server (i.e., not UTC)'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
  add_order_incremental_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Side'
      - id: size
        type: decimal_u8_8
        doc: 'Displayed Size of the order. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
      - id: participant
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to Turquoise'
      - id: order_type
        type: u1
        doc: 'Type of the order'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to Turquoise'
  order_modify_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Side'
      - id: order_modify_flags
        type: order_modify_flags
        doc: 'Order Modify Flags'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
      - id: new_quantity
        type: decimal_u8_8
        doc: 'New displayed quantity of the order. Implied decimal with scale 1e-8'
      - id: new_price
        type: decimal_s8_8
        doc: 'New price of the order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: previous_price
        type: decimal_s8_8
        doc: 'Previous price of the order. Implied decimal with scale 1e-8'
      - id: previous_quantity
        type: decimal_u8_8
        doc: 'Previous displayed quantity of the order. Implied decimal with scale 1e-8'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
  order_modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: priority_flag
        type: b1
        doc: 'Priority Flag'
      - id: unused_7
        type: b7
        doc: 'Unused'
  order_delete_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Side'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: previous_price
        type: decimal_s8_8
        doc: 'Previous price of the order. Implied decimal with scale 1e-8'
      - id: previous_quantity
        type: decimal_u8_8
        doc: 'Previous displayed quantity of the order. Implied decimal with scale 1e-8'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
  top_of_book_message:
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
      - id: retail_lp
        type: b1
        doc: 'Retail LP'
      - id: unused_5
        type: b5
        doc: 'Reserved'
  order_book_clear_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
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
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: executed_size
        type: decimal_u8_8
        doc: 'Total executed quantity. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
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
        doc: 'Not Applicable to Turquoise'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
      - id: hidden_execution_indicator
        type: u1
        enum: hidden_execution_indicator
        doc: 'For Turquoise Lit Order Book, 1[2] will be sent for execution of visible[hidden] quantities. For Turquoise Plato Order Book, it will always be set to 2 (Hidden)'
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
      - id: unused_7
        type: b7
        doc: 'Unused'
  trade_cross_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: executed_size
        type: decimal_u8_8
        doc: 'Total executed quantity. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique ID of the BTF Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the BTF Order:'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
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
  statistics_update_message:
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
      - id: statistic_type
        type: u2
        enum: statistic_type
        doc: 'The statistic that is disseminated with this message instance:'
      - id: statistic_price
        type: decimal_s8_8
        doc: 'The value of price type statistics. Implied decimal with scale 1e-8'
      - id: statistic_size
        type: decimal_u8_8
        doc: 'The value of size type statistics. Implied decimal with scale 1e-8'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Not Applicable to Turquoise'
      - id: imbalance_quantity
        type: decimal_u8_8
        doc: 'Not Applicable to Turquoise. Implied decimal with scale 1e-8'
      - id: auction_info
        type: u1
        enum: auction_info
        doc: 'Populated if the Statistic Type is 1:'
      - id: opening_closing_price_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not Applicable to Turquoise'
  mifid_ii_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: transaction_identification_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique trade identifier. The value will be right aligned'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Not Applicable to Turquoise'
      - id: mi_fid_price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'MiFID compliant Price field populated using executed price'
      - id: mi_fid_quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument. {DECIMAL-18/17}'
      - id: trading_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed/agreed upon'
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
        doc: 'Price Notation'
      - id: price_major_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major currency in which the price is expressed (applicable if the price is expressed as monetary value)'
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
      - id: pt_ref_price_waiver_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Ref Price Waiver Flag'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: market_closing_price_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Closing Price Flag'
      - id: pt_algo_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Algo Trade'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Cancellation Flag'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Amendment Flag'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future use'
      - id: reserved_20
        size: 20
        doc: 'Reserved for future use'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: trade_qualifier
        type: u1
        enum: trade_qualifier
        doc: 'Qualifier of the trade'
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
        type: u1
        enum: reference_price_indicator
        doc: 'Reference Price Indicator'
      - id: special_dividend_indicator
        type: u1
        enum: special_dividend_indicator
        doc: 'Special Dividend Indicator'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'Off Book Automated Indicator'
      - id: price_formation_indicator
        type: u1
        enum: price_formation_indicator
        doc: 'Price Formation Indicator'
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        doc: 'Algorithmic Indicator'
      - id: post_trade_deferral_reason
        type: u1
        enum: post_trade_deferral_reason
        doc: 'Post-Trade Deferral Reason'
      - id: deferral_enrichment_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Deferral/ Enrichment Type'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'Duplicative Indicator'
  mi_fid_ii_trade_cross_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: transaction_identification_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique trade identifier. The value will be right aligned'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique ID of the BTF Order'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the BTF Order:'
      - id: mi_fid_price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'MiFID compliant Price field populated using executed price'
      - id: mi_fid_quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument. {DECIMAL-18/17}'
      - id: trading_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed/agreed upon'
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
        doc: 'Price Notation'
      - id: price_major_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major currency in which the price is expressed (applicable if the price is expressed as monetary value)'
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
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: nt_pre_trade_waiver_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'NT Pre-Trade Waiver Flag'
      - id: pt_algo_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Algo Trade'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Cancellation Flag'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'PT Amendment Flag'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future use'
      - id: reserved_20
        size: 20
        doc: 'Reserved for future use'
      - id: third_reserved_4
        size: 4
        doc: 'Reserved for future use'
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
        type: u1
        enum: reference_price_indicator
        doc: 'Reference Price Indicator'
      - id: special_dividend_indicator
        type: u1
        enum: special_dividend_indicator
        doc: 'Special Dividend Indicator'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'Off Book Automated Indicator'
      - id: price_formation_indicator
        type: u1
        enum: price_formation_indicator
        doc: 'Price Formation Indicator'
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        doc: 'Algorithmic Indicator'
      - id: post_trade_deferral_reason
        type: u1
        enum: post_trade_deferral_reason
        doc: 'Post-Trade Deferral Reason'
      - id: deferral_enrichment_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Deferral/ Enrichment Type'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'Duplicative Indicator'
  trade_summary_message:
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
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Transaction execution timestamp as reported by the upstream system. Nanoseconds since Unix epoch'
      - id: far_price
        type: decimal_s8_8
        doc: 'Far price is the highest price at which volume is depleted as part of the Matching Engine event in case of an aggressing buy order, or the lowest price at which volume is depleted in case of an aggressing sell order. Implied decimal with scale 1e-8'
      - id: total_executed_quantity
        type: decimal_u8_8
        doc: 'Total quantity executed. Implied decimal with scale 1e-8'
      - id: total_hidden_executed_quantity
        type: decimal_u8_8
        doc: 'Total hidden order quantity executed (hidden quantity). Implied decimal with scale 1e-8'
      - id: deleted_order_quantity
        type: decimal_u8_8
        doc: 'Order Quantity deleted due to Self Execution Prevention (SEP) during an execution. Implied decimal with scale 1e-8'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Side'
      - id: best_bid_size
        type: decimal_s8_8
        doc: 'Aggregated size of all orders at the best buy price available on the book at execution completion. Implied decimal with scale 1e-8'
      - id: best_bid_price
        type: decimal_s8_8
        doc: 'Price of best visible bid available on the book at execution completion. Implied decimal with scale 1e-8'
      - id: best_offer_size
        type: decimal_s8_8
        doc: 'Aggregated size of all orders at the best sell price available on the book at execution completion. Implied decimal with scale 1e-8'
      - id: best_offer_price
        type: decimal_s8_8
        doc: 'Price of best visible bid available on the book at execution completion. Implied decimal with scale 1e-8'
  analytics_message:
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
      - id: start_time
        type: nanosecond_timestamp
        doc: 'Time the calculation of the statistics on this message began. Nanoseconds since Unix epoch'
      - id: end_time
        type: nanosecond_timestamp
        doc: 'Time the calculation of the statistics on this message ended. Nanoseconds since Unix epoch'
      - id: buy_order_count
        type: u4
        doc: 'Number of buy orders received within the calculation window'
      - id: sell_order_count
        type: u4
        doc: 'Number of sell orders received within the calculation window'
      - id: buy_order_size
        type: decimal_u8_4
        doc: 'Cumulative quantity of all buy orders received within the calculation window. Implied decimal with scale 1e-4'
      - id: sell_order_size
        type: decimal_u8_4
        doc: 'Cumulative quantity of all sell orders received within the calculation window. Implied decimal with scale 1e-4'
      - id: buy_order_cancellations
        type: u4
        doc: 'Number of buy orders cancelled by clients within the calculation window'
      - id: sell_order_cancellations
        type: u4
        doc: 'Number of sell orders cancelled by clients within the calculation window'
      - id: buy_limit_order_cancellations
        type: u4
        doc: 'Number of buy limit orders cancelled by clients within the calculation window'
      - id: buy_market_order_cancellations
        type: u4
        doc: 'Number of buy market orders cancelled by clients within the calculation window'
      - id: sell_limit_order_cancellations
        type: u4
        doc: 'Number of sell limit orders cancelled by clients within the calculation window'
      - id: sell_market_order_cancellations
        type: u4
        doc: 'Number of sell market orders cancelled by clients within the calculation window'
      - id: bid_ask_spread
        type: decimal_s8_8
        doc: 'Most Recent Bid/Ask spread at the time of publication of the message. Implied decimal with scale 1e-8'
      - id: vwap_buy
        type: decimal_s8_8
        doc: 'Volume Weighted Average Price for trades triggered by an aggressing buy order. Calculated within the calculation window for trades executed in continuous trading. Implied decimal with scale 1e-8'
      - id: vwap_sell
        type: decimal_s8_8
        doc: 'Volume Weighted Average Price for trades triggered by an aggressing sell order. Calculated within the calculation window for trades executed in continuous trading. Implied decimal with scale 1e-8'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the replay or recovery channel.'
    0x03:
      id: 'replay_request_message'
      doc: 'Used by the client to request a retransmission of messages on the replay channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request to the replay or recovery channel.'
    0x04:
      id: 'replay_response_message'
      doc: 'Used by the server to respond to a retransmission request on the replay channel.'
    0x83:
      id: 'replay_and_recovery_complete_message'
      doc: 'Used by the server to indicate the successful completion of servicing a message replay or a recovery request.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types, except strategy instruments, on the real-time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes'
    0x46:
      id: 'add_order_incremental_message'
      doc: 'Sent to instruct recipients to add a new displayable order to the retrospective order book'
    0x55:
      id: 'order_modify_message'
      doc: 'Sent to instruct recipients to update an order''s price and/or size on the retrospective order book'
    0x44:
      id: 'order_delete_message'
      doc: 'Sent to instruct recipients to delete an order from the retrospective order book'
    0x69:
      id: 'top_of_book_message'
      doc: 'Used to update the level 1 service following any change to the consolidated Best Bid and Offer'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument'
    0x50:
      id: 'trade_message'
      doc: 'Sent to indicate trades executed on supported markets'
    0x71:
      id: 'trade_cross_message'
      doc: 'Sent to indicate a cross trade execution'
    0x77:
      id: 'statistics_message'
      doc: 'Contains a set of statistics that are updated frequently, usually as a result of executions'
    0x6a:
      id: 'statistics_update_message'
      doc: 'Contains a set of statistics that are not updated frequently'
    0x51:
      id: 'mifid_ii_trade_message'
      doc: 'Sent to represent different types of MiFID compliant trades published by markets'
    0x56:
      id: 'mi_fid_ii_trade_cross_message'
      doc: 'Sent to indicate a MiFID compliant cross trade'
    0x57:
      id: 'trade_summary_message'
      doc: 'Trade Summary message is used to disseminate results of multi and single fill trade events'
    0x61:
      id: 'analytics_message'
      doc: 'Used to disseminate additional statistics including order book activity statistics'
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
  replay_status:
    0x41:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x44:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x55:
      id: 'replay_unavailable'
      doc: 'Replay Unavailable'
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4a:
      id: 'halted_matching_partition_suspended'
      doc: 'Halted Matching Partition Suspended'
    0x4b:
      id: 'halted_system_suspended'
      doc: 'Halted System Suspended'
    0x50:
      id: 'halted_regulatory_halt'
      doc: 'Halted Regulatory Halt'
    0x54:
      id: 'regular_trading_start_of_trqb_session'
      doc: 'Regular Trading Start Of Trqb Session'
    0x74:
      id: 'end_of_regular_trading_end_of_trqb_session'
      doc: 'End Of Regular Trading End Of Trqb Session'
    0x63:
      id: 'closed'
      doc: 'Closed'
    0x32:
      id: 'suspended'
      doc: 'Suspended'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  source_venue:
    5:
      id: 'turquoise_lit_order_book'
      doc: 'Turquoise Lit Order Book'
    6:
      id: 'turquoise_plato_order_book'
      doc: 'Turquoise Plato Order Book'
    12:
      id: 'turquoise_plato_lit_auctions_order_book'
      doc: 'Turquoise Plato Lit Auctions Order Book'
    14:
      id: 'turquoise_lit_order_book_14'
      doc: 'Turquoise Lit Order Book'
    15:
      id: 'turquoise_plato_order_book_15'
      doc: 'Turquoise Plato Order Book'
    16:
      id: 'turquoise_plato_lit_auctions_order_book_16'
      doc: 'Turquoise Plato Lit Auctions Order Book'
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
    3:
      id: 'electronic'
      doc: 'Electronic'
  trade_type:
    0:
      id: 'regular'
      doc: 'Regular'
    2:
      id: 'auction_trade'
      doc: 'Auction Trade'
    9:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
  auction_type:
    0x4c:
      id: 'frequent_lit_auctions'
      doc: 'Frequent Lit Auctions'
  hidden_execution_indicator:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'visible'
      doc: 'Visible'
    2:
      id: 'hidden'
      doc: 'Hidden'
  trade_qualifier:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x54:
      id: 'trade_at_last'
      doc: 'Trade At Last'
  cross_type:
    6:
      id: 'internal_btf'
      doc: 'Internal Btf'
    8:
      id: 'committed_btf'
      doc: 'Committed Btf'
  statistic_type:
    1:
      id: 'indicative_auction_uncrossing_data'
      doc: 'Indicative Auction Uncrossing Data'
    4:
      id: 'trade_high_on_book'
      doc: 'Trade High On Book'
    5:
      id: 'trade_low_on_book'
      doc: 'Trade Low On Book'
    6:
      id: 'trade_high_all_trades'
      doc: 'Trade High All Trades'
    7:
      id: 'trade_low_all_trades'
      doc: 'Trade Low All Trades'
    8:
      id: 'fifty_two_week_trade_high_all_trades'
      doc: 'Fifty Two Week Trade High All Trades'
    9:
      id: 'fifty_two_week_trade_low_all_trades'
      doc: 'Fifty Two Week Trade Low All Trades'
  auction_info:
    0x4d:
      id: 'call_market'
      doc: 'Call Market'
  market_mechanism:
    0x31:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x33:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x35:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  trading_mode:
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    0x50:
      id: 'on_demand_auction'
      doc: 'On Demand Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
  transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x2d:
      id: 'none'
      doc: 'None'
  negotiation_indicator:
    0x38:
      id: 'negotiated_trade_with_pretrade_transparency_waiver'
      doc: 'Negotiated Trade With Pretrade Transparency Waiver'
    0x2d:
      id: 'not_a_negotiated_trade'
      doc: 'Not A Negotiated Trade'
  agency_cross_indicator:
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
    0x53:
      id: 'reference_price_trade'
      doc: 'Reference Price Trade'
    0x31:
      id: 'market_closing_price_trade'
      doc: 'Market Closing Price Trade'
    0x2d:
      id: 'not_a_reference_price_trade'
      doc: 'Not A Reference Price Trade'
  special_dividend_indicator:
    0x2d:
      id: 'no_special_dividend_trade'
      doc: 'No Special Dividend Trade'
  off_book_automated_indicator:
    0x2d:
      id: 'unspecified_or_does_not_apply'
      doc: 'Unspecified Or Does Not Apply'
  price_formation_indicator:
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
  algorithmic_indicator:
    0x48:
      id: 'algorithmic_trade'
      doc: 'Algorithmic Trade'
    0x2d:
      id: 'not_an_algorithmic_trade'
      doc: 'Not An Algorithmic Trade'
  post_trade_deferral_reason:
    0x2d:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
  duplicative_indicator:
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique Trade Report'

