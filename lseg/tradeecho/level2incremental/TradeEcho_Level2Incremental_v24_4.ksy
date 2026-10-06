# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg TradeEcho Level2Incremental Gtp v24.4
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Level 2 Incremental
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
  id: lseg_tradeecho_level2incremental_gtp_v24_4
  title: Lseg TradeEcho Level2Incremental Gtp v24.4
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange TRADEcho Level 2 Incremental Gtp v24.4'
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
            'message_type::order_delete_message': order_delete_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::systematic_internaliser_quotes_message': systematic_internaliser_quotes_message
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
        type: u1
        enum: side
        doc: 'Side'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order Book Type'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: previous_price
        type: decimal_s8_8
        doc: 'Price of the order that was deleted from the book. Implied decimal with scale 1e-8'
      - id: previous_quantity
        type: decimal_u8_8
        doc: 'Quantity of the order that was deleted from the book. Implied decimal with scale 1e-8'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Not Applicable to TRADEcho. Nanoseconds since Unix epoch'
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
        doc: 'Order Book Type'
  systematic_internaliser_quotes_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: size
        type: decimal_u8_8
        doc: 'Displayed Size of the order. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied price if instrument trades in yield. Implied decimal with scale 1e-8'
      - id: yield_field
        type: decimal_s8_8
        doc: 'Yield, if the instrument trades in yield. Implied decimal with scale 1e-8'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order Book Type'
      - id: participant
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of trading participant that submitted the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Book Type'
      - id: reserved_10
        size: 10
        doc: 'Reserved field'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217'
      - id: venue_of_publication
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the regulatory regime under which the transaction was published. The value sent by the source venue is passed on'
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
    0x44:
      id: 'order_delete_message'
      doc: 'Sent to instruct recipients to delete an order from the retrospective order book'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument'
    0x47:
      id: 'systematic_internaliser_quotes_message'
      doc: 'Publishing systematic internaliser quotes'
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
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  order_type:
    0:
      id: 'si_quote'
      doc: 'Si Quote'

