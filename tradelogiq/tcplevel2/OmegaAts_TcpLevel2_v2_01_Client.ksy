# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq TcpLevel2 Itch v2.01
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Omega Tcp Level 2
#   Encoding: Itch
#   Version: 2.01
#   Date: 01/13/2026
#   Specification: TMI-Level-2-ITCH-5.0-Specification-v2.01.pdf
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
  id: tradelogiq_omegaats_tcplevel2_itch_v2_01_client
  title: Tradelogiq TcpLevel2 Itch v2.01
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Omega ATS Omega Tcp Level 2 Itch v2.01'

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
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At the start of each trading day, Tradelogiq disseminates stock directory messages for all supported securities.'
    0x72:
      id: 'extended_stock_directory_message'
      doc: 'Extended Stock Directory messages carry the additional reference data of bonds, debentures, rights, notes and warrants.'
    0x48:
      id: 'stock_trading_action_message'
      doc: 'Tradelogiq uses this administrative message to indicate the current trading status of a security.'
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by Omega ATS or Lynx ATS and was added to the visible order book.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed at a display price different from the original.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being cancelled.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order on the book has been cancelled and replaced.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for normal match events involving non-displayed order types.'
    0x51:
      id: 'cross_trade_message'
      doc: 'Cross trades are only accepted on Omega ATS.'
    0x42:
      id: 'trade_bust_message'
      doc: 'The Trade Bust message is sent whenever an execution on Omega ATS or Lynx ATS is cancelled.'
    0x4d:
      id: 'trade_amend_message'
      doc: 'The Trade Amend/Correction message is sent whenever an execution on Omega ATS or Lynx ATS is amended.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Timestamp Messages The Start Of Day Message Is The First Message Sent Out In A Trading Day'
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
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  midpoint_book_trade:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes Represents Midpoint Book Trade On Lynx Ats'
  cross_type:
    0x44:
      id: 'derivatives_cross'
      doc: 'Derivatives Cross'
    0x49:
      id: 'internal_cross'
      doc: 'Internal Cross'
    0x4d:
      id: 'intentional_cross'
      doc: 'Intentional Cross'
    0x4e:
      id: 'net_asset_value_cross'
      doc: 'Net Asset Value Nav Cross'
  bypass:
    0x59:
      id: 'bypass'
      doc: 'Bypass'
    0x4e:
      id: 'non_bypass'
      doc: 'Non Bypass'
  settlement_type:
    0x30:
      id: 'regular_settlement'
      doc: 'Regular Settlement'
    0x31:
      id: 'cash'
      doc: 'Cash T 0'
    0x32:
      id: 'next_day'
      doc: 'Next Day T 1'
    0x33:
      id: 'delayed_delivery'
      doc: 'Delayed Delivery'

