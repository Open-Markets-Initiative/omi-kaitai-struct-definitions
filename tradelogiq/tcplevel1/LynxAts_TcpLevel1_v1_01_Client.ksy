# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq TcpLevel1 Itch v1.01
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Lynx Tcp Level 1
#   Encoding: Itch
#   Version: 1.01
#   Date: 01/30/2022
#   Specification: TradelogiQ-Level-1-ITCH-5.0-Specification-v1.01.pdf
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
  id: tradelogiq_lynxats_tcplevel1_itch_v1_01_client
  title: Tradelogiq TcpLevel1 Itch v1.01
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Lynx ATS Lynx Tcp Level 1 Itch v1.01'

seq:
  - id: client_soup_tcp_packet
    type: client_soup_tcp_packet_struct
    repeat: eos
    doc: 'Soup Tcp Packet sent by the client'

types:
  client_soup_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Tradelogiq SoupTcp Client Packet Header'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Number of bytes after this field until the next packet'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying the packet the client sends'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username, case-insensitive and padded on the right with spaces'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password, case-insensitive and padded on the right with spaces'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies session to log onto. All blanks to log onto the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number the client wants to receive upon connection or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 1
        doc: 'Data defined by a higher protocol'

enums:
  client_packet_type:
    0x4c:
      id: 'login_request_packet'
      doc: 'Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'Logout Request Packet'
  server_packet_type:
    0x41:
      id: 'login_accepted_packet'
      doc: 'Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'Server Heartbeat Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'Not Authorized, invalid user or password'
    0x53:
      id: 'session_not_available'
      doc: 'Session invalid or not available'
  message_type:
    0x57:
      id: 'quote_message'
      doc: 'Tradelogiq''s BBO will broadcast real-time updates every time Tradelogiq''s top of book changes.'
    0x54:
      id: 'trade_report_message'
      doc: 'Relays all transactions available from or reported by Tradelogiq''s two trading books for the current business day.'
    0x4e:
      id: 'trade_bust_message'
      doc: 'If trade is cancelled or busted during the day Trade Bust Message will be sent.'
    0x4d:
      id: 'trade_correction_message'
      doc: 'Trade amendments during the day will send this message.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message is used to signal a market or a data feed handler event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At start of each trading day, OSI disseminates stock directory messages for supported securities.'
    0x72:
      id: 'extended_stock_directory_message'
      doc: 'Extended Stock Directory are for Special stock symbols eg warrants debentures rights.'
    0x48:
      id: 'stock_status_message'
      doc: 'This message indicates the current trading status of a stock.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'The Start If Day Message Is The First Message Sent Out In A Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicate That Tradelogiq Order Books Are Open And Ready To Start Accepting Order'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Order Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Tradelogiq Order Books Are Now Closed And Will Not Accept New Orders'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Day'
    0x42:
      id: 'trading_halted'
      doc: 'Trading Halted Due To Market Wide Circuit Breaker'
    0x52:
      id: 'trading_resumed'
      doc: 'Trading Resumed Following Market Wide Circuit Breaker'
  market:
    0x74:
      id: 'tsx'
      doc: 'Tsx'
    0x76:
      id: 'venture'
      doc: 'Venture'
    0x63:
      id: 'cnsx'
      doc: 'Cnsx'
    0x71:
      id: 'nasdaq_canada'
      doc: 'Nasdaq Canada'
    0x6f:
      id: 'omega'
      doc: 'Omega'
    0x7a:
      id: 'aequitas'
      doc: 'Aequitas'
  shortable:
    0x45:
      id: 'short_exempt'
      doc: 'Short Exempt'
    0x53:
      id: 'shortable'
      doc: 'Shortable'
    0x4e:
      id: 'not_shortable'
      doc: 'Not Shortable'
  dividend_indicator:
    0x41:
      id: 'annual'
      doc: 'Annual'
    0x53:
      id: 'semi_annual'
      doc: 'Semi Annual'
    0x51:
      id: 'quarterly'
      doc: 'Quarterly'
    0x4d:
      id: 'monthly'
      doc: 'Monthly'
  frequency:
    0x41:
      id: 'annual'
      doc: 'Annual'
    0x53:
      id: 'semi_annual'
      doc: 'Semi Annual'
    0x51:
      id: 'quarterly'
      doc: 'Quarterly'
    0x4d:
      id: 'monthly'
      doc: 'Monthly'
  security_type:
    0x64:
      id: 'debentures'
      doc: 'Debentures'
    0x72:
      id: 'rights'
      doc: 'Rights'
    0x6e:
      id: 'notes'
      doc: 'Notes'
    0x77:
      id: 'warrants'
      doc: 'Warrants'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading'

