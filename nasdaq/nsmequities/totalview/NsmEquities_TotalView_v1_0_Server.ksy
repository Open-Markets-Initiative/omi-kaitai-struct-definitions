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
  id: nasdaq_nsmequities_totalview_itch_v1_0_server
  title: Nasdaq NsmEquities TotalView Itch v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v1.0'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: server_packet_header
    type: server_packet_header_struct
    doc: 'SoupTcp Packet Header sent by the server'
  - id: server_payload
    type:
      switch-on: server_packet_header.server_packet_type
      cases:
        'server_packet_type::debug_packet': debug_packet
        'server_packet_type::login_accepted_packet': login_accepted_packet
        'server_packet_type::login_rejected_packet': login_rejected_packet
        'server_packet_type::sequenced_data_packet': sequenced_data_packet
  - id: soup_lf
    type: u1
    doc: 'Terminating line feed character'

types:
  server_packet_header_struct:
    seq:
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_header
        type: sequenced_message_header
        doc: 'Time and type carried ahead of every sequenced Itch message'
      - id: sequenced_message
        type:
          switch-on: sequenced_message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::trade_message': trade_message
            'message_type::broken_trade_message': broken_trade_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Hundredths of a second past midnight Eastern the message was generated. Hundredths since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes'
  add_order_message:
    seq:
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique reference number assigned to this new order. Increasing, but not necessarily sequential'
      - id: side
        type: u1
        enum: side
        doc: '"B" = buy order. "S" = sell order'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The limit price of the order. 9 whole number places, a decimal point, and 10 decimal digits'
      - id: display
        type: u1
        enum: display
        doc: '"Y" = displayed in NASDAQ. The "S" value is no longer supported as of the NASDAQ/INET merger'
  order_executed_message:
    seq:
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique reference number assigned to this new order. Increasing, but not necessarily sequential'
      - id: executed_shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares executed'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the NASDAQ generated session-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
      - id: contra_broker_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The four-letter symbol of the firm that executed this order if the executing order was not entered directly on NASDAQ. Blank filled if an NASDAQ subscriber entered the executing order directly on NASDAQ'
  order_cancel_message:
    seq:
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique reference number assigned to this new order. Increasing, but not necessarily sequential'
      - id: canceled_shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares canceled'
  trade_message:
    seq:
      - id: order_reference_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique reference number assigned to this new order. Increasing, but not necessarily sequential'
      - id: side
        type: u1
        enum: side
        doc: '"B" = buy order. "S" = sell order'
      - id: shares
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered)'
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The limit price of the order. 9 whole number places, a decimal point, and 10 decimal digits'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the NASDAQ generated session-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
      - id: contra_broker_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The four-letter symbol of the firm that executed this order if the executing order was not entered directly on NASDAQ. Blank filled if an NASDAQ subscriber entered the executing order directly on NASDAQ'
  broken_trade_message:
    seq:
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the NASDAQ generated session-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'

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

