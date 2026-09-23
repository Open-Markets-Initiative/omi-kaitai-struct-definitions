# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 1.0
#   Date: 08/09/2006
#   Specification: Nasdaq TotalView ITCH (1.0).pdf
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
  id: nasdaq_nsmequities_totalview_itch_v1_0_client
  title: Nasdaq NsmEquities TotalView Itch v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v1.0'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: client_packet_type
    type: u1
    enum: client_packet_type_enum
    doc: 'Code identifying this packet type'
  - id: client_payload
    type:
      switch-on: client_packet_type
      cases:
        'client_packet_type_enum::debug_packet': debug_packet
        'client_packet_type_enum::login_request_packet': login_request_packet
        'client_packet_type_enum::unsequenced_data_packet': unsequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
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
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message
        size-eos: true
        doc: 'Raw unsequenced message bytes'

enums:
  client_packet_type_enum:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SoupTcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupTcp Logout Request Packet'
  server_packet_type_enum:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupTcp Server Heartbeat Packet'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'System Event Messages signal events that affect the entire NASDAQ system.'
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the NASDAQ system and added onto the book. It includes a session-unique Order Reference Number assigned by NASDAQ to the order, all other fields were specified by the party who entered the order. You will not receive an Add Order Message when a non-displayed order is added to the book.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part. The execution price is always the limit price of the order already on the book.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of being canceled in whole or in part.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message provides information about execution events that involve orders not visible on the NASDAQ book. A Trade Message is transmitted each time a hidden order is executed in whole or in part.'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade message is sent whenever an execution on NASDAQ is broken.'
  event_code:
    0x53:
      id: 'start_of_session'
      doc: 'This Is Always The First Message Sent In Any Session It Indicates That The Nasdaq System Is Open And Ready To Start Accepting Orders'
    0x45:
      id: 'end_of_session'
      doc: 'This Is Always The Last Message Sent In Any Session It Indicates That The Nasdaq System Is Now Closed And Will Not Generate Any New Messages In This Session All Orders That Remain Open In This Session Are Now Dead And Should Be Purged From The Book'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  display:
    0x59:
      id: 'displayed'
      doc: 'Displayed In Nasdaq'

