# ---------------------------------------------------------------------
# Kaitai struct definition for: Odx OdxEquities TcpPts Itch v2.2
#
# Protocol:
#   Organization: Osaka Digital Exchange
#   Protocol: Tcp Proprietary Trading System
#   Encoding: Itch
#   Version: 2.2
#   Date: 4/6/2026
#   Specification: ODX_PTS_ITCH_Equities_v2.2.pdf
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
  id: odx_odxequities_tcppts_itch_v2_2_server
  title: Odx OdxEquities TcpPts Itch v2.2
  license: MIT-0
  endian: be

doc: 'Osaka Digital Exchange Odx Equities Tcp Proprietary Trading System Itch v2.2'

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
            'sequenced_message_type::seconds_message': seconds_message
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::price_tick_size_message': price_tick_size_message
            'sequenced_message_type::orderbook_directory_message': orderbook_directory_message
            'sequenced_message_type::trading_state_message': trading_state_message
            'sequenced_message_type::short_selling_price_restriction_state_message': short_selling_price_restriction_state_message
            'sequenced_message_type::order_added_message': order_added_message
            'sequenced_message_type::order_executed_message': order_executed_message
            'sequenced_message_type::order_deleted_message': order_deleted_message
            'sequenced_message_type::order_replaced_message': order_replaced_message
  seconds_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since midnight. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier Blank if system wide event'
      - id: system_event
        type: u1
        enum: system_event
        doc: 'System event code'
  price_tick_size_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price tick size table identifier'
      - id: price_tick_size
        type: decimal_u4_1
        doc: 'Price tick size. Implied decimal with scale 1e-1'
      - id: price_start
        type: decimal_u4_1
        doc: 'Start of price range for this price tick size. Implied decimal with scale 1e-1'
  orderbook_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 digit Quick code'
      - id: orderbook_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'International Securities Identification Number (ISIN)'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier Blank if system wide event'
      - id: round_lot_size
        type: u4
        doc: 'Number of shares that represent a round lot'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price tick size table identifier'
      - id: price_decimals
        type: u4
        doc: 'Number of decimal places in price fields Value is 1'
      - id: upper_price_limit
        type: decimal_u4_1
        doc: 'Maximum tradable price. Implied decimal with scale 1e-1'
      - id: lower_price_limit
        type: decimal_u4_1
        doc: 'Minimum tradable price. Implied decimal with scale 1e-1'
  trading_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 digit Quick code'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier Blank if system wide event'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state'
  short_selling_price_restriction_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: orderbook_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 digit Quick code'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier Blank if system wide event'
      - id: short_selling_state
        type: u1
        enum: short_selling_state
        doc: 'Current short selling price restriction state'
  order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order Zero indicates a reference price message'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Side of the order Ignore if reference price message'
      - id: quantity
        type: u4
        doc: 'Total number of shares added to the book Ignore if reference price message'
      - id: orderbook_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 digit Quick code'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook group identifier Blank if system wide event'
      - id: price
        type: decimal_u4_1
        doc: 'Price of the order For a reference price message, a value of 214,748,3647 (7FFFFFFF hex) denotes no reference price available. Implied decimal with scale 1e-1'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order Zero indicates a reference price message'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: match_number
        type: u8
        doc: 'Reference number of the match'
  order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: order_number
        type: u8
        doc: 'Reference number of the accepted order Zero indicates a reference price message'
  order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Number of nanoseconds since last Timestamp Seconds Message. Nanoseconds since Second epoch'
      - id: original_order_number
        type: u8
        doc: 'Reference number of the original order'
      - id: new_order_number
        type: u8
        doc: 'Reference number of the replaced order'
      - id: quantity
        type: u4
        doc: 'Total number of shares added to the book Ignore if reference price message'
      - id: price
        type: decimal_u4_1
        doc: 'Price of the order For a reference price message, a value of 214,748,3647 (7FFFFFFF hex) denotes no reference price available. Implied decimal with scale 1e-1'
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
  decimal_u4_1:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10.0

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
      id: 'seconds_message'
      doc: 'Reflects the number of seconds past midnight'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal data feed, system and market events'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'The Price Tick Size Message is used to communicate tick size information for a given price range'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'The Orderbook Directory Message is used to disseminate orderbook information for all active orderbooks'
    0x48:
      id: 'trading_state_message'
      doc: 'The Trading State Message is used to indicate the current trading state of an orderbook'
    0x59:
      id: 'short_selling_price_restriction_state_message'
      doc: 'The Short Selling Price Restriction State Message is used to indicate the current short selling price restriction state of an orderbook'
    0x41:
      id: 'order_added_message'
      doc: 'An Order Added Message is generated each time a new order is accepted by the ODX PTS execution system'
    0x45:
      id: 'order_executed_message'
      doc: 'An Order Executed Message is sent whenever an order on the book is executed in whole or in part'
    0x44:
      id: 'order_deleted_message'
      doc: 'An Order Deleted Message is sent whenever an order on the book is cancelled'
    0x55:
      id: 'order_replaced_message'
      doc: 'An Order Replaced Message is sent whenever an order on the book is replaced'
  system_event:
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
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  short_selling_state:
    0x30:
      id: 'no_price_restriction'
      doc: 'No Price Restriction'
    0x31:
      id: 'price_restriction_in_effect'
      doc: 'Price Restriction In Effect'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

