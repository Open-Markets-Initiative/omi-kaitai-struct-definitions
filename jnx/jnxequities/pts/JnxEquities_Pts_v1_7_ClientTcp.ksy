# ---------------------------------------------------------------------
# Kaitai struct definition for: Jnx JnxEquities Pts Itch v1.7
#
# Protocol:
#   Organization: Japannext Securities
#   Protocol: Proprietary Trading System
#   Encoding: Itch
#   Version: 1.7
#   Date: 11/01/2023
#   Specification: Japannext_PTS_ITCH_Equities_v1.7.pdf
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
  id: jnx_jnxequities_pts_itch_v1_7_clienttcp
  title: Jnx JnxEquities Pts Itch v1.7
  license: GPL-3.0
  endian: be

doc: 'Japannext Securities Japannext Equities Proprietary Trading System Itch v1.7'
doc-ref: https://www.japannext.co.jp/library

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_tcp_packet_header
        type: client_tcp_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_tcp_payload
        size: client_tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_tcp_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_tcp_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_tcp_packet_header.packet_length - 2
        doc: 'The unsequenced (client to server) message carried by the packet, opaque bytes unless an application source dispatches it'

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
      id: 'timestamp_seconds_message'
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal data feed, system and market events.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Price Tick Size Messages define a set of price tick size tables.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Messages provide information about orderbooks available in the Japannext PTS execution system.'
    0x48:
      id: 'trading_state_message'
      doc: 'Trading State Message indicates the current trading state of an orderbook.'
    0x59:
      id: 'short_selling_price_restriction_state_message'
      doc: 'Short Selling Price Restriction State Message indicates the current short selling price restriction state of an orderbook.'
    0x41:
      id: 'order_added_without_attributes_message'
      doc: 'Order Added Message will be generated for normal orders accepted by the system.'
    0x46:
      id: 'order_added_with_attributes_message'
      doc: 'Order Added with Attributes Message will be generated for orders with market specific attributes accepted by the system.'
    0x45:
      id: 'order_executed_message'
      doc: 'Order Executed Message is sent whenever an order in the book is executed in whole or part.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Order Deleted Message is sent whenever an order in the book has been canceled.'
    0x55:
      id: 'order_replaced_message'
      doc: 'Order Replaced Message is sent whenever an order in the book has been replaced.'
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
  order_type:
    0x51:
      id: 'dlp_order'
      doc: 'Dlp Order'
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Reflects the number of seconds past midnight that the Timestamp message was generated.'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal data feed, system and market events.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Price Tick Size Messages define a set of price tick size tables.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Messages provide information about orderbooks available in the Japannext PTS execution system.'
    0x48:
      id: 'trading_state_message'
      doc: 'Trading State Message indicates the current trading state of an orderbook.'
    0x59:
      id: 'short_selling_price_restriction_state_message'
      doc: 'Short Selling Price Restriction State Message indicates the current short selling price restriction state of an orderbook.'
    0x41:
      id: 'order_added_without_attributes_message'
      doc: 'Order Added Message will be generated for normal orders accepted by the system.'
    0x46:
      id: 'order_added_with_attributes_message'
      doc: 'Order Added with Attributes Message will be generated for orders with market specific attributes accepted by the system.'
    0x45:
      id: 'order_executed_message'
      doc: 'Order Executed Message is sent whenever an order in the book is executed in whole or part.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Order Deleted Message is sent whenever an order in the book has been canceled.'
    0x55:
      id: 'order_replaced_message'
      doc: 'Order Replaced Message is sent whenever an order in the book has been replaced.'

