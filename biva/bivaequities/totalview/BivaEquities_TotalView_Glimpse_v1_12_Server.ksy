# ---------------------------------------------------------------------
# Kaitai struct definition for: Biva BivaEquities TotalView Glimpse v1.12
#
# Protocol:
#   Organization: Bolsa Institucional de Valores
#   Protocol: Total View
#   Encoding: Glimpse
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
  id: biva_bivaequities_totalview_glimpse_v1_12_server
  title: Biva BivaEquities TotalView Glimpse v1.12
  license: GPL-3.0
  endian: be

doc: 'Bolsa Institucional de Valores Biva Equities Total View Glimpse v1.12'
doc-ref: https://www.biva.mx/en/web/portal-en/technology

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: u8
        doc: 'The Itch Total View sequence number when the Glimpse snapshot was taken'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::time_stamp_seconds_message': time_stamp_seconds_message
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::price_tick_size_message': price_tick_size_message
            'sequenced_message_type::quantity_tick_size_message': quantity_tick_size_message
            'sequenced_message_type::orderbook_directory_message': orderbook_directory_message
            'sequenced_message_type::participant_directory_message': participant_directory_message
            'sequenced_message_type::orderbook_trading_action_message': orderbook_trading_action_message
            'sequenced_message_type::orderbook_reference_price_message': orderbook_reference_price_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::indicative_price_quantity_message': indicative_price_quantity_message
            'sequenced_message_type::glimpse_snapshot_message': glimpse_snapshot_message
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
  participant_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: participant_id
        type: u4
        doc: 'Unique identifier for the market participant'
      - id: participant_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Company participant code'
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
  add_order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Unique reference number assigned to the new order, zero indicates a reference price update'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: 'Buy or Sell, blank if reference price update'
      - id: quantity
        type: u8
        doc: 'Total quantity of the order being added to the book'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: price
        type: u4
        doc: 'The price of the new order, 0x7FFFFFFF for a market order'
      - id: participant_id
        type: u4
        doc: 'Unique identifier for the market participant'
  indicative_price_quantity_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: theoretical_opening_quantity
        type: u8
        doc: 'Total quantity eligible to be matched at the current Theoretical Opening Price'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: best_bid
        type: u4
        doc: 'The current best buy price'
      - id: best_offer
        type: u4
        doc: 'The current best sell price'
      - id: theoretical_opening_price
        type: u4
        doc: 'The current opening price for this orderbook'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross type code'
  glimpse_snapshot_message:
    seq:
      - id: sequence_number
        type: u8
        doc: 'The Itch Total View sequence number when the Glimpse snapshot was taken'
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
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  sequenced_message_type:
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
    0x46:
      id: 'participant_directory_message'
      doc: 'Participant directory'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'Trading action message'
    0x58:
      id: 'orderbook_reference_price_message'
      doc: 'Orderbook reference price message'
    0x41:
      id: 'add_order_message'
      doc: 'Add order message'
    0x49:
      id: 'indicative_price_quantity_message'
      doc: 'Indicative price quantity message'
    0x47:
      id: 'glimpse_snapshot_message'
      doc: 'Glimpse snapshot message'
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
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  cross_type:
    0x4f:
      id: 'preopening_session'
      doc: 'Preopening Session'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'

