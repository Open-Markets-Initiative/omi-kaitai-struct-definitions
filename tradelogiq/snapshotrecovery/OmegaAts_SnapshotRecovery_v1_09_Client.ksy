# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq SnapshotRecovery Itch v1.09
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Omega Snapshot Recovery
#   Encoding: Itch
#   Version: 1.09
#   Date: 06/05/2025
#   Specification: Tradelogiq-SnapshotRecovery-Specifications-v1.09.pdf
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
  id: tradelogiq_omegaats_snapshotrecovery_itch_v1_09_client
  title: Tradelogiq SnapshotRecovery Itch v1.09
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Omega ATS Omega Snapshot Recovery Itch v1.09'

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
    0x53:
      id: 'system_event_message'
      doc: 'The spin consists of a Start-Of-Messages event, Add Order messages and an End-Of-Messages event, after which the Reallocation Server disconnects.'
    0x52:
      id: 'stock_directory_message'
      doc: 'A Requested Sequence Number of 1 returns the symbol spin, the Instrument Directory messages distributed early in the Tradelogiq start of day.'
    0x72:
      id: 'extended_stock_directory_message'
      doc: 'The symbol spin carries the Extended Stock Directory of bonds, debentures, rights, notes and warrants alongside the Stock Directory.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'If sequence 1 is used for the Sequenced Number field the reallocation server will return the symbol spin with the stock trading status messages before returning all open orders seen on the book.'
    0x41:
      id: 'add_order_message'
      doc: 'Only open orders are sent in the spin; the spin will not contain any message for an order which is no longer in the book.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages Event The First Message Of The Spin'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Tradelogiq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Tradelogiq Is Now Closed And Will Not Accept Any New Orders'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages Event After Which The Reallocation Server Disconnects'
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
      id: 'tsx_venture'
      doc: 'Tsx Venture'
    0x63:
      id: 'cse'
      doc: 'Cse'
    0x71:
      id: 'nasdaq_canada'
      doc: 'Nasdaq Canada'
    0x6f:
      id: 'omega_ats'
      doc: 'Omega Ats'
    0x7a:
      id: 'cboe_canada'
      doc: 'Cboe Canada'
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
    0x62:
      id: 'bonds'
      doc: 'Bonds'
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
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'

