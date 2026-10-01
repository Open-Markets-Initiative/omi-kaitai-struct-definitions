# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq BxEquities Drop AsciiDrop v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Drop
#   Encoding: Ascii Drop
#   Version: 2.2
#   Date: 04/23/2018
#   Specification: NQBXDROP2.2.pdf
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
  id: nasdaq_bxequities_drop_asciidrop_v2_2_client
  title: Nasdaq BxEquities Drop AsciiDrop v2.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq BX Drop AsciiDrop v2.2'
doc-ref: https://www.nasdaqtrader.com/content/technicalsupport/specifications/tradingproducts/NQBXDROP2.2.pdf

seq:
  - id: client_packet_header
    type: client_packet_header_struct
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

types:
  client_packet_header_struct:
    seq:
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type'
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
      doc: 'B Bought'
    0x53:
      id: 'sold'
      doc: 'S Sold'
    0x54:
      id: 'sold_short'
      doc: 'T Sold Short'
    0x45:
      id: 'sold_short_exempt'
      doc: 'E Sold Short Exempt'
  capacity:
    0x41:
      id: 'agency'
      doc: 'A Agency'
    0x50:
      id: 'principal'
      doc: 'P Principal'
    0x52:
      id: 'riskless'
      doc: 'R Riskless'
  liquidity_code:
    0x41:
      id: 'added_liquidity'
      doc: 'A Added Liquidity'
    0x52:
      id: 'reduced_liquidity'
      doc: 'R Reduced Liquidity'
    0x4a:
      id: 'nondisplayed_and_added_liquidity'
      doc: 'J Nondisplayed And Added Liquidity'
    0x58:
      id: 'routed'
      doc: 'X Routed'
    0x44:
      id: 'dot_routed'
      doc: 'D Dot Routed'
    0x46:
      id: 'opening_trade_on_nyse'
      doc: 'F Opening Trade On Nyse'
    0x47:
      id: 'on_close_order_on_nyse'
      doc: 'G On Close Order On Nyse'
    0x59:
      id: 're_routed_by_nyse'
      doc: 'Y Re Routed By Nyse'
    0x53:
      id: 'odd_lot_executions_on_nyse'
      doc: 'S Odd Lot Executions On Nyse'
    0x55:
      id: 'added_liquidity_on_nyse'
      doc: 'U Added Liquidity On Nyse'
    0x45:
      id: 'nyse_other'
      doc: 'E Nyse Other'
    0x50:
      id: 'routed_to_psx'
      doc: 'P Routed To Psx'
    0x54:
      id: 'opening_trade_on_arca'
      doc: 'T Opening Trade On Arca'
    0x5a:
      id: 'on_close_order_on_arca'
      doc: 'Z On Close Order On Arca'
    0x51:
      id: 'routed_to_nasdaq'
      doc: 'Q Routed To Nasdaq'
    0x6d:
      id: 'removed_liquidity_at_a_midpoint'
      doc: 'M Removed Liquidity At A Midpoint'
    0x6b:
      id: 'added_liquidity_via_a_midpoint_order'
      doc: 'K Added Liquidity Via A Midpoint Order'
    0x6a:
      id: 'rpi_retail_price_improving_order_provides_liquidity'
      doc: 'J Rpi Retail Price Improving Order Provides Liquidity'
    0x72:
      id: 'rmo_retail_order_removes_rpi_liquidity'
      doc: 'R Rmo Retail Order Removes Rpi Liquidity'
    0x74:
      id: 'rmo_retail_order_removes_price_improving_nondisplayed_liquidity_other_than_rpi_liquidity'
      doc: 'T Rmo Retail Order Removes Price Improving Nondisplayed Liquidity Other Than Rpi Liquidity'
    0x71:
      id: 'rmo_retail_order_removes_non_rpi_midpoint_liquidity'
      doc: 'Q Rmo Retail Order Removes Non Rpi Midpoint Liquidity'
    0x37:
      id: 'displayed_liquidityadding_order_improves_the_nbbo'
      doc: '7 Displayed Liquidityadding Order Improves The Nbbo'
    0x38:
      id: 'displayed_liquidityadding_order_sets_the_bxbbo_while_joining_the_nbbo'
      doc: '8 Displayed Liquidityadding Order Sets The Bxbbo While Joining The Nbbo'
    0x70:
      id: 'removed_price_improving_nondisplayed_liquidity'
      doc: 'P Removed Price Improving Nondisplayed Liquidity'
    0x4e:
      id: 'passive_midpoint_execution'
      doc: 'N Passive Midpoint Execution'
  clearing_code:
    0x51:
      id: 'qsr'
      doc: 'Q Qsr'

