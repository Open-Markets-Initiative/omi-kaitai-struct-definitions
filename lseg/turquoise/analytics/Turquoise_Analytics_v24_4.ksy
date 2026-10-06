# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Turquoise Analytics Gtp v24.4
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Analytics
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
  id: lseg_turquoise_analytics_gtp_v24_4
  title: Lseg Turquoise Analytics Gtp v24.4
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Turquoise Analytics Gtp v24.4'
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
    0x61:
      id: 'analytics_message'
      doc: 'Used to disseminate additional statistics including order book activity statistics'
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

