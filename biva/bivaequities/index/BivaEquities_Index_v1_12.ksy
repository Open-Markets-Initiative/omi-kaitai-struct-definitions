# ---------------------------------------------------------------------
# Kaitai struct definition for: Biva BivaEquities Index Itch v1.12
#
# Protocol:
#   Organization: Bolsa Institucional de Valores
#   Protocol: Index
#   Encoding: Itch
#   Version: 1.12
#   Date: 1/1/2022
#   Specification: BIVA_X-Stream_External_ITCH_Specification_v1.12.0.pdf
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
  id: biva_bivaequities_index_itch_v1_12
  title: Biva BivaEquities Index Itch v1.12
  license: GPL-3.0
  endian: be

doc: 'Bolsa Institucional de Valores Biva Equities Index Itch v1.12'
doc-ref: https://www.biva.mx/en/web/portal-en/technology

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_stamp_seconds_message': time_stamp_seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::price_tick_size_message': price_tick_size_message
            'message_type::quantity_tick_size_message': quantity_tick_size_message
            'message_type::orderbook_directory_message': orderbook_directory_message
            'message_type::orderbook_trading_action_message': orderbook_trading_action_message
            'message_type::orderbook_reference_price_message': orderbook_reference_price_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_stamp_seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight of the first day of the system cycle. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping Board level only'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event code'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
  price_tick_size_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Indicates the Tick Size Table id'
      - id: price_tick_size
        type: u4
        doc: 'Price tick size'
      - id: price_start
        type: u4
        doc: 'Start of price for this tick size'
  quantity_tick_size_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Indicates the Tick Size Table id'
      - id: quantity_tick_size
        type: u8
        doc: 'Quantity tick size'
      - id: quantity_start
        type: u8
        doc: 'Start of quantity for this tick size'
  orderbook_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Isin code'
      - id: sec_code
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping Board level only'
      - id: minimum_quantity
        type: u8
        doc: 'Minimum quantity'
      - id: quantity_tick_size_table_id
        type: u4
        doc: 'Quantity tick size table cross reference'
      - id: quantity_decimals
        type: u4
        doc: 'Quantity decimals'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price tick size table cross reference'
      - id: price_decimals
        type: u4
        doc: 'Price decimals'
      - id: delisting_or_maturity_date
        type: u4
        doc: 'Yyyymmdd, 0 represents no delisting date'
      - id: delisting_time
        type: u4
        doc: 'Hhmmss, ignore if delisting date is 0'
      - id: turnover_ratio
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'High, Medium or Low, blank if Opel-W'
      - id: quotation_basis
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quotation basis indicator, blank if not set'
      - id: instrument
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument name'
      - id: listing_type
        type: u1
        enum: listing_type
        doc: 'Regular or Sub-Rm securities'
      - id: listing_exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the security listing exchange'
  orderbook_trading_action_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state for orderbook'
      - id: trading_action_reason
        type: u1
        enum: trading_action_reason
        doc: 'Trading action reason'
  orderbook_reference_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: reference_price
        type: u4
        doc: 'The reference price, 0x7FFFFFFF when unavailable'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Reference price type'
      - id: reference_price_reason
        type: u1
        enum: reference_price_reason
        doc: 'Reference price reason'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000

enums:
  message_type:
    0x54:
      id: 'time_stamp_seconds_message'
      doc: 'Itch timestamp, number of seconds since midnight of the system start'
    0x53:
      id: 'system_event_message'
      doc: 'System event message'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Orderbook price tick table'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'Orderbook quantity tick table'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook directory'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'Trading action message'
    0x58:
      id: 'orderbook_reference_price_message'
      doc: 'Orderbook reference price message'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start Of Market Hours'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End Of Market Hours'
    0x56:
      id: 'scheduled_auction_starts'
      doc: 'Scheduled Auction Starts'
    0x55:
      id: 'scheduled_auction_closes'
      doc: 'Scheduled Auction Closes'
    0x50:
      id: 'start_of_post_close_session'
      doc: 'Start Of Post Close Session'
    0x54:
      id: 'end_of_post_close_session'
      doc: 'End Of Post Close Session'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  listing_type:
    0x52:
      id: 'regular_securities'
      doc: 'Regular Securities'
    0x53:
      id: 'sub_rm_securities'
      doc: 'Sub Rm Securities'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  trading_action_reason:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x48:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x41:
      id: 'continuous_auction_start'
      doc: 'Continuous Auction Start'
    0x42:
      id: 'continuous_auction_end'
      doc: 'Continuous Auction End'
    0x51:
      id: 'news_pending'
      doc: 'News Pending'
    0x53:
      id: 'static_price_band_breach'
      doc: 'Static Price Band Breach'
    0x4d:
      id: 'market_surveillance_suspension'
      doc: 'Market Surveillance Suspension'
    0x4f:
      id: 'suspension_by_market_of_origin'
      doc: 'Suspension By Market Of Origin'
    0x43:
      id: 'non_compliance'
      doc: 'Non Compliance'
    0x49:
      id: 'start_of_indication_of_interest'
      doc: 'Start Of Indication Of Interest'
    0x45:
      id: 'expired_security_is_unavailable_for_trading'
      doc: 'Expired Security Is Unavailable For Trading'
    0x4c:
      id: 'not_yet_available_for_trading'
      doc: 'Not Yet Available For Trading'
  price_type:
    0x43:
      id: 'close_price'
      doc: 'Close Price'
    0x52:
      id: 'reference_price'
      doc: 'Reference Price'
    0x49:
      id: 'inav'
      doc: 'Inav'
    0x56:
      id: 'vwap_or_ppp'
      doc: 'Vwap Or Ppp'
  reference_price_reason:
    0x20:
      id: 'none'
      doc: 'None'

