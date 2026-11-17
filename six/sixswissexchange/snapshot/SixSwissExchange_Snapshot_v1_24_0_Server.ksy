# ---------------------------------------------------------------------
# Kaitai struct definition for: Six SixSwissExchange Snapshot Glimpse v1.24.0
#
# Protocol:
#   Organization: SIX Swiss Exchange
#   Protocol: SIX Swiss Exchange IMI Orderbook Snapshot Recovery Service
#   Encoding: Glimpse
#   Version: 1.24.0
#   Date: 1/21/2025
#   Specification: SSX-IMI-TRD-SPEC-1.24.0E.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: six_sixswissexchange_snapshot_glimpse_v1_24_0_server
  title: Six SixSwissExchange Snapshot Glimpse v1.24.0
  license: MIT-0
  endian: be

doc: 'SIX Swiss Exchange SIX Swiss Exchange SIX Swiss Exchange IMI Orderbook Snapshot Recovery Service Glimpse v1.24.0'

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
      - id: debug_text
        type: str
        size: _parent.server_packet_header.packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
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
            'sequenced_message_type::quantity_tick_size_message': quantity_tick_size_message
            'sequenced_message_type::price_tick_size_message': price_tick_size_message
            'sequenced_message_type::orderbook_directory_message': orderbook_directory_message
            'sequenced_message_type::orderbook_trading_action_message': orderbook_trading_action_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::indicative_price_quantity_message': indicative_price_quantity_message
            'sequenced_message_type::glimpse_snapshot_message': glimpse_snapshot_message
  time_stamp_seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight Central European Time (CET) or Central European Summer Time (CEST). Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping (board level only); left blank if at system level'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code'
      - id: orderbook
        type: u4
        doc: 'Identifies whether the event applies to a single Orderbook within the Group; 0 if the event applies at Group level'
  quantity_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: quantity_tick_table_id
        type: u4
        doc: 'Indicates the Tick Size Table Id'
      - id: quantity_tick_size
        type: u4
        doc: 'Quantity Tick Size'
      - id: quantity_start
        type: u4
        doc: 'Start of Quantity for this Tick Size'
  price_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: price_tick_table_id
        type: u4
        doc: 'Indicates the Tick Size Table Id'
      - id: price_tick_size
        type: u4
        doc: 'Price Tick Size'
      - id: price_start
        type: u4
        doc: 'Start of Price for this Tick Size'
  orderbook_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies whether the event applies to a single Orderbook within the Group; 0 if the event applies at Group level'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Indicates U (''per unit'' price type) or P (price as percentage)'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code'
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
        doc: 'Id for symbol grouping (board level only); left blank if at system level'
      - id: minimum_quantity
        type: u4
        doc: 'Minimum Quantity'
      - id: quantity_tick_table_id
        type: u4
        doc: 'Indicates the Tick Size Table Id'
      - id: price_tick_table_id
        type: u4
        doc: 'Indicates the Tick Size Table Id'
      - id: price_decimals
        type: u4
        doc: 'Price Decimals'
      - id: delisting_date
        type: yyyymmdd_date_nullable
        doc: 'YYYYMMDD; 0 represents no delisting date. Nullable, No Delisting Date = 0'
      - id: delisting_time
        type: hhmmss_time
        doc: 'HHMMSS; ignore if delisting date is 0'
      - id: qod_price_decimals
        type: u4_nullable
        doc: 'Price Decimals for QOD book; 0x7FFFFFFF if the security has no QOD book. Nullable, No QOD Book = 2147483647'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIC of the SIX trading venue of the security'
      - id: reference_exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIC of the primary listing venue of the security; spaces unless an ETF multi-currency security trades in QOD'
  orderbook_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Identifies whether the event applies to a single Orderbook within the Group; 0 if the event applies at Group level'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state for Orderbook'
      - id: book_condition
        type: u1
        enum: book_condition
        doc: 'Shows the SIX Swiss Exchange book condition'
  add_order_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'The day unique reference number assigned to the new order'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: 'Buy or Sell; blank if reference price update'
      - id: order_quantity
        type: u4
        doc: 'The total quantity of the order being added to the book; zero indicates a reference price update'
      - id: orderbook
        type: u4
        doc: 'Identifies whether the event applies to a single Orderbook within the Group; 0 if the event applies at Group level'
      - id: order_price
        type: u4_nullable
        doc: 'The price of the new order. Nullable, Market Order = 2147483647'
  indicative_price_quantity_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp Seconds Message. Nanoseconds since Second epoch'
      - id: theoretical_opening_quantity
        type: u8
        doc: 'The total quantity eligible to be matched at the current Theoretical Opening Price'
      - id: orderbook
        type: u4
        doc: 'Identifies whether the event applies to a single Orderbook within the Group; 0 if the event applies at Group level'
      - id: best_bid
        type: u4_nullable
        doc: 'The current best buy price. Nullable, Market Order = 2147483647'
      - id: best_offer
        type: u4_nullable
        doc: 'The current best sell price. Nullable, Market Order = 2147483647'
      - id: theoretical_opening_price
        type: u4_nullable
        doc: 'The current theoretical opening price for this Orderbook. Nullable, Market Order = 2147483647'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross type code'
  glimpse_snapshot_message:
    seq:
      - id: sequence_number
        type: u8
        doc: 'The sequence number that must be used in the Login Request (Requested Sequence Number) when reconnecting to the IMI real-time feed'
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == 0
  hhmmss_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000 % 100
      minute:
        value: time / 100 % 100
      second:
        value: time % 100
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 2147483647

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
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'time_stamp_seconds_message'
      doc: 'Timestamp of seconds since midnight, used in combination with the nanoseconds timestamp of each message'
    0x53:
      id: 'system_event_message'
      doc: 'Sent as a result of trade events at the system, group and Orderbook level'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'Shows the Quantity Tick (Category) of a Security'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Shows the Price Tick (Category) of a Security'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Provides the basic reference data for the active Orderbooks for a specific OBM partition'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'Sent as a result of an Orderbook state or condition change'
    0x41:
      id: 'add_order_message'
      doc: 'A new order has been accepted and added to the book; an Order Number and Quantity of zero carries the reference price'
    0x49:
      id: 'indicative_price_quantity_message'
      doc: 'Sent during non-automatic matching periods telling the users what would happen if the book was uncrossed now'
    0x47:
      id: 'glimpse_snapshot_message'
      doc: 'The last message of the GLIMPSE snapshot'
  event_code:
    0x41:
      id: 'break_field'
      doc: 'Break. State changes to Break'
    0x42:
      id: 'resumption_after_break'
      doc: 'Resumption after Break. State changes to Trading'
    0x43:
      id: 'end_of_messages'
      doc: 'End of messages. Last message sent'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End of System Hours. The Exchange is closed and will not accept any new orders'
    0x49:
      id: 'start_of_accepting'
      doc: 'Start of Accepting. State changes to Accepting'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End of Market Hours. State changes to Post Trading'
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of messages. This is the first IMI message sent'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start of Market Hours. State changes to Trading'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start of System Hours. State changes to Pre-opening'
    0x55:
      id: 'auction_closes'
      doc: 'Auction closes. State changes to Trading-At-Last or Post Trading'
    0x56:
      id: 'auction_starts'
      doc: 'Auction starts. State changes to Closing Auction'
    0x54:
      id: 'start_of_trading_at_last'
      doc: 'Start of Trading-At-Last'
    0x4c:
      id: 'end_of_trading_at_last'
      doc: 'End of Trading-At-Last. State changes to Post-Trading'
    0x20:
      id: 'synchronized_with_group'
      doc: 'Blank: sent for an Orderbook that is synchronized with its group level'
  price_type:
    0x55:
      id: 'per_unit'
      doc: '''per unit'' price type'
    0x50:
      id: 'percentage'
      doc: 'Price as percentage'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
    0x4d:
      id: 'swiss_at_mid_order_book_suspended'
      doc: 'SwissAtMid order book suspended'
    0x45:
      id: 'swiss_ebbo_order_book_suspended'
      doc: 'Swiss EBBO order book suspended'
    0x4f:
      id: 'swiss_ebbo_and_swiss_at_mid_order_books_suspended'
      doc: 'Swiss EBBO and SwissAtMid order books suspended'
    0x55:
      id: 'underlying_condition'
      doc: 'Underlying condition'
    0x51:
      id: 'quote_on_demand_order_book_suspended'
      doc: 'Quote on Demand (QOD) order book suspended'
    0x43:
      id: 'clob_suspended_and_qod_order_book_in_trading'
      doc: 'CLOB suspended and QOD order book in trading'
    0x4c:
      id: 'lp_bid_only_active'
      doc: '"LP Bid only" active'
    0x50:
      id: 'lp_bid_only_active_and_qod_order_book_suspended'
      doc: '"LP Bid only" active and QOD order book suspended'
  book_condition:
    0x44:
      id: 'delay_auction'
      doc: 'Delay Auction'
    0x48:
      id: 'stop_trading'
      doc: 'Stop Trading'
    0x4a:
      id: 'stop_trading_with_non_opening'
      doc: 'Stop Trading with Non Opening'
    0x4c:
      id: 'delay_auction_with_non_opening'
      doc: 'Delay Auction with Non Opening'
    0x4e:
      id: 'normal_trading'
      doc: 'Normal trading'
    0x50:
      id: 'non_opening'
      doc: 'Non-Opening'
    0x31:
      id: 'lp_bid_only_reason_us_withholding_tax'
      doc: '"LP Bid only" reason: Instrument is subject to US Withholding Tax according to IRC Section 871(m)'
    0x32:
      id: 'lp_bid_only_reason_issuer_sold_out'
      doc: '"LP Bid only" reason: Issuer has no size (sold-out) and can only buy back the instrument'
    0x33:
      id: 'lp_bid_only_reason_issuer_business_policy'
      doc: '"LP Bid only" reason: Based on the business policy requirements of the issuer'
    0x34:
      id: 'lp_bid_only_reason_successor_product'
      doc: '"LP Bid only" reason: Issuer offers a successor product which is regarded more attractive for investors'
    0x35:
      id: 'lp_bid_only_reason_product_worthless'
      doc: '"LP Bid only" reason: Product is worthless'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'reference_price_update'
      doc: 'Blank if reference price update'
  cross_type:
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    0x4f:
      id: 'pre_opening_auction'
      doc: 'Pre-Opening Auction'

