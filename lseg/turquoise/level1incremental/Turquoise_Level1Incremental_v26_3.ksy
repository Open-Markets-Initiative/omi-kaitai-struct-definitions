# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Turquoise Level1Incremental Gtp v26.3
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Level 1 Incremental
#   Encoding: Group Ticker Plant
#   Version: 26.3
#   Date: 03/03/2026
#   Specification: gtp-002-technical-guide-turquoise-issue-26-3.pdf
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
  id: lseg_turquoise_level1incremental_gtp_v26_3
  title: Lseg Turquoise Level1Incremental Gtp v26.3
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Turquoise Level 1 Incremental Gtp v26.3'
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
            'message_type::top_of_book_message': top_of_book_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::trade_message': trade_message
            'message_type::trade_cross_message': trade_cross_message
            'message_type::statistics_message': statistics_message
            'message_type::statistics_update_message': statistics_update_message
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
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
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
      - id: security_exchange
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217'
      - id: partition_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trading System''s partition in which the instrument is traded'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: average_daily_turnover_adt
        type: decimal_s8_4
        doc: 'Not Applicable to Turquoise. Implied decimal with scale 1e-4'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: fourth_reserved_8
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
        doc: 'Current trading status of the instrument'
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
        doc: 'Execution timestamp as reported by the supported market. Nanoseconds since Unix epoch'
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
        doc: 'Executed price. Implied decimal with scale 1e-8'
      - id: venue_of_execution
        type: u1
        doc: 'Not Applicable to Turquoise'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: reserved_4
        size: 4
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
        doc: 'Execution timestamp as reported by the supported market. Nanoseconds since Unix epoch'
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
        doc: 'Executed price. Implied decimal with scale 1e-8'
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
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types, except strategy instruments, on the real-time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes'
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
    0x47:
      id: 'scheduled_level_1_only_auction'
      doc: 'Scheduled Level 1 Only Auction'
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

