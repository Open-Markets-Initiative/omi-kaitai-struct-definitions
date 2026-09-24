# ---------------------------------------------------------------------
# Kaitai struct definition for: Odx OdxSecurityToken Pts Itch v1.2
#
# Protocol:
#   Organization: Osaka Digital Exchange
#   Protocol: Proprietary Trading System
#   Encoding: Itch
#   Version: 1.2
#   Date: 4/6/2026
#   Specification: ODX_PTS_ITCH (Security Token)_v1.2.pdf
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
  id: odx_odxsecuritytoken_pts_itch_v1_2_client
  title: Odx OdxSecurityToken Pts Itch v1.2
  license: GPL-3.0
  endian: be

doc: 'Osaka Digital Exchange Odx Security Token Proprietary Trading System Itch v1.2'

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
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
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
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
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'timestamp_seconds_message'
      doc: 'Reflects the number of seconds past midnight.'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal data feed, system and market events.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'The Price Tick Size Message is used to communicate tick size information for a given price range.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'The Orderbook Directory Message is used to disseminate orderbook information for all active orderbooks.'
    0x48:
      id: 'trading_state_message'
      doc: 'The Trading State Message is used to indicate the current trading state of an orderbook.'
    0x41:
      id: 'order_added_message'
      doc: 'An Order Added Message is generated each time a new order is accepted by the ODX PTS execution system.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'An Order Executed with Price Message is sent whenever an order on the book is executed in whole or in part with a specific trade price.'
    0x44:
      id: 'order_deleted_message'
      doc: 'An Order Deleted Message is sent whenever an order on the book is cancelled.'
    0x55:
      id: 'order_replaced_message'
      doc: 'An Order Replaced Message is sent whenever an order on the book is replaced.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order Book State Message is used to communicate the state of an orderbook.'
    0x5a:
      id: 'equilibrium_price_update_message'
      doc: 'The Equilibrium Price Update Message is used to communicate the equilibrium price of an orderbook during an auction period.'
  system_event:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  restriction_of_market_order:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  attention_flag:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  termination_flag:
    0x59:
      id: 'true_field'
      doc: 'True'
    0x4e:
      id: 'false_field'
      doc: 'False'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  occurred_as_cross:
    0x59:
      id: 'trade_occurred_at_the_cross'
      doc: 'Trade Occurred At The Cross'

