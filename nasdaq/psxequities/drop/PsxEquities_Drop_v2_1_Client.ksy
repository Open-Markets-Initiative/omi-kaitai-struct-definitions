# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PsxEquities Drop AsciiDrop v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Drop
#   Encoding: Ascii Drop
#   Version: 2.1
#   Date: 06/04/2015
#   Specification: psxdrop21.pdf
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
  id: nasdaq_psxequities_drop_asciidrop_v2_1_client
  title: Nasdaq PsxEquities Drop AsciiDrop v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PSX Drop AsciiDrop v2.1'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/TradingProducts/psxdrop21.pdf

seq:
  - id: client_frame
    type: client_frame_struct
    repeat: eos
    doc: 'One SoupTcp packet sent by the client, closed by a line feed'

types:
  client_frame_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'SoupTcp Packet Header sent by the client'
      - id: client_payload
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
      - id: soup_lf
        type: u1
        doc: 'Terminating line feed character'
  client_packet_header:
    seq:
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size-eos: true
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
      - id: unsequenced_message
        size-eos: true
        doc: 'Raw unsequenced message bytes'

enums:
  client_packet_type:
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
  server_packet_type:
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
    0x41:
      id: 'new_order_accepted_message'
      doc: 'New order accepted.'
    0x45:
      id: 'existing_order_executed_message'
      doc: 'Existing order executed.'
    0x58:
      id: 'existing_order_canceled_message'
      doc: 'Existing order canceled.'
    0x42:
      id: 'previous_execution_broken_message'
      doc: 'Previous execution broken.'
    0x55:
      id: 'existing_order_replaced_message'
      doc: 'Existing order replaced.'
  buy_sell:
    0x42:
      id: 'bought'
      doc: 'B = Bought'
    0x53:
      id: 'sold'
      doc: 'S = Sold'
    0x54:
      id: 'sold_short'
      doc: 'T = Sold Short'
    0x45:
      id: 'sold_short_exempt'
      doc: 'E = Sold Short Exempt'
  capacity:
    0x41:
      id: 'agency'
      doc: 'A = Agency'
    0x50:
      id: 'principal'
      doc: 'P = Principal'
    0x52:
      id: 'riskless'
      doc: 'R = Riskless'
  liquidity_flag:
    0x41:
      id: 'added'
      doc: 'A = Added'
    0x52:
      id: 'removed'
      doc: 'R = Removed'
    0x56:
      id: 'displayed_added_liquidity_with_original_order_size_of_greater_than_or_equal_to_2000_shares'
      doc: 'V = Displayed added liquidity with original order size of greater than or equal to 2,000 shares'
    0x58:
      id: 'routed'
      doc: 'X = Routed'
    0x44:
      id: 'dot'
      doc: 'D = DOT'
    0x46:
      id: 'added_or_opening_trade_on_nyse'
      doc: 'F = Added or Opening Trade (on NYSE)'
    0x47:
      id: 'odd_lot_or_on_close_order_on_nyse'
      doc: 'G = Odd Lot or On-Close order (on NYSE)'
    0x4f:
      id: 'opening_cross'
      doc: 'O = Opening Cross'
    0x4d:
      id: 'opening_cross_imbalance_only'
      doc: 'M = Opening Cross (imbalance-only)'
    0x43:
      id: 'closing_cross'
      doc: 'C = Closing Cross'
    0x4c:
      id: 'closing_cross_imbalance_only'
      doc: 'L = Closing Cross (imbalance-only)'
    0x48:
      id: 'halt_ipo_cross'
      doc: 'H = Halt/IPO Cross'
    0x4b:
      id: 'halt_cross'
      doc: 'K = Halt Cross'
    0x4a:
      id: 'non_displayed_and_added_liquidity'
      doc: 'J = Non-displayed and added liquidity'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Y = Re-Routed by NYSE'
    0x53:
      id: 'odd_lot_execution_on_nyse'
      doc: 'S = Odd Lot Execution (on NYSE)'
    0x55:
      id: 'added_liquidity_on_nyse'
      doc: 'U = Added Liquidity (On NYSE)'
    0x42:
      id: 'routed_to_bx'
      doc: 'B = Routed to BX'
    0x45:
      id: 'nyse_other'
      doc: 'E = NYSE Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'P = Routed to PSX'
    0x54:
      id: 'opening_trade_on_arca'
      doc: 'T = Opening Trade (on ARCA)'
    0x5a:
      id: 'on_close_order_on_arca'
      doc: 'Z = On-Close order (on ARCA)'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'm = Removed liquidity at a midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'k = Added liquidity via a midpoint order'
  clearing_code:
    0x51:
      id: 'qsr'
      doc: 'Q = QSR'

