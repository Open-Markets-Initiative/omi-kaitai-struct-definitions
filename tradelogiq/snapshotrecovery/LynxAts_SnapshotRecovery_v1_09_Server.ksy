# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq SnapshotRecovery Itch v1.09
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Lynx Snapshot Recovery
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
  id: tradelogiq_lynxats_snapshotrecovery_itch_v1_09_server
  title: Tradelogiq SnapshotRecovery Itch v1.09
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Lynx ATS Lynx Snapshot Recovery Itch v1.09'

seq:
  - id: server_soup_tcp_packet
    type: server_soup_tcp_packet_struct
    repeat: eos
    doc: 'Soup Tcp Packet sent by the server'

types:
  server_soup_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Tradelogiq SoupTcp Server Packet Header'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Number of bytes after this field until the next packet'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying the packet the server sends'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Why the login was rejected'
  sequenced_data_packet:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: payload
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::extended_stock_directory_message': extended_stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::add_order_message': add_order_message
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Start-Of-Messages opens the spin and End-Of-Messages closes it'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
  stock_directory_message:
    seq:
      - id: market
        type: u1
        enum: market
        doc: 'Indicates the listing market of security'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol on Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: board_lot_size
        type: u4
        doc: 'Indicates a board lot size'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: shortable
        type: u1
        enum: shortable
        doc: 'Indicates the short status of a security'
      - id: dividend_indicator
        type: u1
        enum: dividend_indicator
        doc: 'Dividend frequency of the security'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates currency for the symbol'
  extended_stock_directory_message:
    seq:
      - id: market
        type: u1
        enum: market
        doc: 'Indicates the listing market of security'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol on Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: board_lot_size
        type: u4
        doc: 'Indicates a board lot size'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: shortable
        type: u1
        enum: shortable
        doc: 'Indicates the short status of a security'
      - id: frequency
        type: u1
        enum: frequency
        doc: 'Dividend frequency of the security'
      - id: reserved_9
        size: 9
        doc: 'Reserved for future use'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates currency for the symbol'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Instrument class of the security'
      - id: expiry_date
        type: yyyymmdd_ascii_date
        doc: 'Date of expiry in the format YYYYMMDD'
      - id: description
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Description of Security'
      - id: reserved_3
        size: 3
        doc: 'Reserved'
  stock_trading_action_message:
    seq:
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'The current trading state for the issue'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason the security is halted. Note: Field may be blank'
  add_order_message:
    seq:
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Side of order'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u4
        doc: 'Unique reference number assigned to the new order'
      - id: shares
        type: u4
        doc: 'Total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
      - id: exec_broker_id
        type: u2
        doc: 'Firm number or ''1'' for anonymous orders'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

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

