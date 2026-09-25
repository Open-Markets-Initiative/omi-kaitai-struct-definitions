# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Itch v2.0.a
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Itch
#   Version: 2.0.a
#   Date: 02/15/2007
#   Specification: Nasdaq TotalView ITCH (2.0a).pdf
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
  id: nasdaq_nsmequities_totalview_itch_v2_0_a_udp
  title: Nasdaq NsmEquities TotalView Itch v2.0.a
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Itch v2.0.a'
doc-ref: https://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of the multicast session the payload relates to'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
      - id: count
        type: u2le
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.length - 9
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::trade_message': trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::stock_halt_status_message': stock_halt_status_message
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of data message not including this field'
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight Eastern the message was generated. Milliseconds since Midnight epoch'
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
        size: 6
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
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The limit price of the order. Implied decimal with scale 1e-4'
      - id: display
        type: u1
        enum: display
        doc: 'Attributable orders will have an extra 4 bytes added to the end of this message, revealing the MMID of the firm that entered this order'
      - id: mmid
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The MMID of the firm entering the Attributable order. Optional: present only if the Display field is set to "A"'
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
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares executed'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
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
        size: 6
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
        size: 6
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
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The limit price of the order. Implied decimal with scale 1e-4'
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
  broken_trade_message:
    seq:
      - id: match_number
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The NASDAQ generated day-unique Match Number of this execution. The match number is also referenced in the Trade Break Message'
  stock_halt_status_message:
    seq:
      - id: stock
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: stock_halted
        type: u1
        enum: stock_halted
        doc: 'Indicates if the stock symbol is halted on NASDAQ system'
  millisecond_ascii_timestamp:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.to_i / 3600000 % 24
      minute:
        value: text.to_i / 60000 % 60
      second:
        value: text.to_i / 1000 % 60
      millisecond:
        value: text.to_i % 1000

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
      doc: 'An Add Order Message indicates that a new order has been accepted by the NASDAQ system and added onto the displayable book. It includes a day-unique Order Reference Number assigned by NASDAQ to the order. The Add Order message is a variable length message, 42 or 46 bytes: the MMID field is present only if the Display field equals "A" (attributed).'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part. The execution price is always equal to the limit price of the order as indicated in the Add Order Message.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of being canceled in whole or in part.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message provides information about execution events that involve orders not visible on the NASDAQ book. A Trade Message is transmitted each time a hidden order is executed in whole or in part.'
    0x42:
      id: 'broken_trade_message'
      doc: 'The Broken Trade message is sent whenever an execution on NASDAQ is broken.'
    0x48:
      id: 'stock_halt_status_message'
      doc: 'Prior to the start of system hours, NASDAQ will send out a Stock Halt Status spin. After the start of system hours, NASDAQ will use this message to relay trading status changes for an individual security.'
  event_code:
    0x53:
      id: 'start_of_day'
      doc: 'This Is Always The First Message Sent In Any Trading Day It Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x45:
      id: 'end_of_day'
      doc: 'It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today All Orders That Remain Open In This Session Are Now Dead And Can Be Purged From The Book It Is Still Possible To Receive Broken Trade Messages And Order Cancel Messages After The End Of Day'
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
      doc: 'Displayed In The Quote'
    0x41:
      id: 'attributable'
      doc: 'Attributable Order The Mmid Follows'
  stock_halted:
    0x54:
      id: 'halted'
      doc: 'True Stock Is Halted'
    0x46:
      id: 'trading'
      doc: 'False Stock Is Trading Normally'

