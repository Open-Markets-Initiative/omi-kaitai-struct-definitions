# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Lse Analytics Gtp v26.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Analytics
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
  id: lseg_lse_analytics_gtp_v26_2
  title: Lseg Lse Analytics Gtp v26.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange London Stock Exchange Analytics Gtp v26.2'
doc-ref: https://www.lseg.com/areas-expertise/technology/group-technology/group-ticker-plant

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
        doc: 'Start or end of day event code'
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
      - id: reserved_11
        size: 11
        doc: 'Reserved for future use'
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
        doc: 'Not Applicable to LSE. Implied decimal with scale 1e-4'
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
        doc: 'New time the session will end. The field will contain only spaces if Session Change Reason is ''0'' or the Session Change Reason is not present. New End Time will be in terms of the local time on the server (i.e., not UTC)'
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
        doc: 'Most Recent Bid/Ask spread at the time of publication of the message. If the value is set to zero, this means, either: 1) No sell/buy liquidity 2) Order book is locked or crossed 3) No orders on order book. Implied decimal with scale 1e-8'
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
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types, except strategy instruments, on the real-time channels.'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes. When sent in the recovery channel, used to indicate the current trading status of an instrument.'
    0x61:
      id: 'analytics_message'
      doc: 'Analytics Message is used to disseminate additional statistics including order book activity statistics.'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  source_venue:
    1:
      id: 'london_stock_exchange'
      doc: 'London Stock Exchange'
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

