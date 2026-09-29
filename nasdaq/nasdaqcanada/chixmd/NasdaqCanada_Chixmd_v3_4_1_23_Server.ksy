# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NasdaqCanada Chixmd Itch v3.4.1.23
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: CHIXMD Market Data
#   Encoding: Itch
#   Version: 3.4.1.23
#   Date: 10/08/2025
#   Specification: Nasdaq Canada Market Data Specification - CHIXMD 3.4 V1.23.pdf
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
  id: nasdaq_nasdaqcanada_chixmd_itch_v3_4_1_23_server
  title: Nasdaq NasdaqCanada Chixmd Itch v3.4.1.23
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Canada CHIXMD Market Data Itch v3.4.1.23'
doc-ref:
  - https://www.nasdaq.com/products/north-american-markets/canada/connectivity
  - https://www.nasdaq.com/docs/2026/01/20/Nasdaq%20Canada%20Market%20Data%20Specification%20-%20CHIXMD%203.4%20V1.23.pdf

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
        doc: 'The session currently logged into'
      - id: sequence_number
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The next sequence number you can expect to receive'
      - id: comma
        type: str
        size: 1
        encoding: ASCII
        doc: 'Separator'
      - id: messages_total
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The current total number of messages on the feed'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
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
            'message_type::add_order_message': add_order_message
            'message_type::long_form_add_order_message': long_form_add_order_message
            'message_type::order_execution_message': order_execution_message
            'message_type::long_form_order_execution_message': long_form_order_execution_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::long_form_order_cancel_message': long_form_order_cancel_message
            'message_type::trade_message': trade_message
            'message_type::long_form_trade_message': long_form_trade_message
            'message_type::broken_trade_message': broken_trade_message
            'message_type::system_event_message': system_event_message
            'message_type::stock_status_message': stock_status_message
  sequenced_message_header:
    seq:
      - id: timestamp
        type: millisecond_ascii_timestamp
        doc: 'Milliseconds past midnight local time the message was generated. Milliseconds since Midnight epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  add_order_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'B = Buy Order; S = Sell Order'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered because part of the order may trade before being posted to the book)'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The display price of the order. Implied decimal with scale 1e-4'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
  long_form_add_order_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'B = Buy Order; S = Sell Order'
      - id: long_shares
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered because part of the order may trade before being posted to the book)'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: long_price
        type: str
        size: 19
        encoding: ASCII
        pad-right: 0x20
        doc: 'The display price of the order. Long form price: 12 whole number places followed by 7 implied decimal digits. Implied decimal with scale 1e-7'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
  order_execution_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: executed_shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares executed on this trade'
      - id: trade_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique trade reference number'
      - id: contra_order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference key of the contra-order that was executed'
      - id: trade_attribute
        type: u1
        enum: trade_attribute
        doc: 'C = Market On Close'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number of the contra order or 001 for anonymous'
  long_form_order_execution_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: long_executed_shares
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The number of shares executed on this trade'
      - id: trade_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique trade reference number'
      - id: contra_order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference key of the contra-order that was executed'
      - id: trade_attribute
        type: u1
        enum: trade_attribute
        doc: 'C = Market On Close'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number of the contra order or 001 for anonymous'
  order_cancel_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: canceled_shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of shares cancelled'
  long_form_order_cancel_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: long_canceled_shares
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of shares cancelled'
  trade_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'B = Buy Order; S = Sell Order'
      - id: shares
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered because part of the order may trade before being posted to the book)'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: price
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The display price of the order. Implied decimal with scale 1e-4'
      - id: trade_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique trade reference number'
      - id: contra_order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference key of the contra-order that was executed'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number of the contra order or 001 for anonymous'
      - id: trade_attribute
        type: u1
        enum: trade_attribute
        doc: 'C = Market On Close'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'I = Internal; B = Basis; C = Contingent; V = VWAP; X = Intentional Cross; D = Derivative Related; N = Net Asset Value'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'T = Cash Today; D = Delayed Delivery'
  long_form_trade_message:
    seq:
      - id: order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique order reference number'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'B = Buy Order; S = Sell Order'
      - id: long_shares
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Total number of shares being added to the book (may be less than the number of shares entered because part of the order may trade before being posted to the book)'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: long_price
        type: str
        size: 19
        encoding: ASCII
        pad-right: 0x20
        doc: 'The display price of the order. Long form price: 12 whole number places followed by 7 implied decimal digits. Implied decimal with scale 1e-7'
      - id: trade_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique trade reference number'
      - id: contra_order_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The reference key of the contra-order that was executed'
      - id: broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number or 001 for anonymous'
      - id: contra_broker
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The three digit numeric TSX Broker Number of the contra order or 001 for anonymous'
      - id: trade_attribute
        type: u1
        enum: trade_attribute
        doc: 'C = Market On Close'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'I = Internal; B = Basis; C = Contingent; V = VWAP; X = Intentional Cross; D = Derivative Related; N = Net Asset Value'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'T = Cash Today; D = Delayed Delivery'
  broken_trade_message:
    seq:
      - id: trade_reference
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Day unique trade reference number'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System event code, see Event Code values'
  stock_status_message:
    seq:
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol right padded with spaces'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'H = Halted, T = Trading'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'T = TSX, V = Venture, C = CSE, N = Neo'
      - id: board_lot_size
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Board Lot Size in Shares'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'CAD = Canadian Dollars, USD = US Dollars'
      - id: gef_eligible
        type: u1
        enum: gef_eligible
        doc: 'Y = GEF Eligible, N = Not GEF Eligible'
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
  reject_reason_code:
    0x41:
      id: 'invalid_username_or_password'
      doc: 'Invalid username/password'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid session'
  message_type:
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that CXC or CX2 has accepted a visible order into the book. It includes a day-unique Order Reference key assigned to the order. The issuing of an Add Order Message is not necessarily always for a new order (see Modification of Existing Orders). Not applicable to CXD.'
    0x61:
      id: 'long_form_add_order_message'
      doc: 'An Add Order Message indicates that CXC or CX2 has accepted a visible order into the book. It includes a day-unique Order Reference key assigned to the order. The issuing of an Add Order Message is not necessarily always for a new order (see Modification of Existing Orders). Not applicable to CXD. Long form messages are used when either the price or size is larger than the standard messages can permit.'
    0x45:
      id: 'order_execution_message'
      doc: 'An Order Execution Message is sent whenever an order on the book is executed in whole or in part. Not applicable to CXD.'
    0x65:
      id: 'long_form_order_execution_message'
      doc: 'An Order Execution Message is sent whenever an order on the book is executed in whole or in part. Not applicable to CXD. Long form messages are used when either the price or size is larger than the standard messages can permit.'
    0x58:
      id: 'order_cancel_message'
      doc: 'An Order Cancel Message is sent whenever an order on the book is fully canceled, its quantity revised down or when a pegged order is re-priced. Not applicable to CXD.'
    0x78:
      id: 'long_form_order_cancel_message'
      doc: 'An Order Cancel Message is sent whenever an order on the book is fully canceled, its quantity revised down or when a pegged order is re-priced. Not applicable to CXD. Long form messages are used when either the price or size is larger than the standard messages can permit.'
    0x50:
      id: 'trade_message'
      doc: 'A Trade Message is sent when a trade occurs against order quantity not visible on the book (i.e. a fully or partially hidden order). They do not affect the book. The Order Reference is always 0 and the Buy/Sell indicator B.'
    0x70:
      id: 'long_form_trade_message'
      doc: 'A Trade Message is sent when a trade occurs against order quantity not visible on the book (i.e. a fully or partially hidden order). They do not affect the book. The Order Reference is always 0 and the Buy/Sell indicator B. Long form messages are used when either the price or size is larger than the standard messages can permit.'
    0x42:
      id: 'broken_trade_message'
      doc: 'A Broken Trade message is sent whenever an execution is broken. A Broken Trade is final; once a trade is broken it cannot be reinstated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to indicate a market state event.'
    0x48:
      id: 'stock_status_message'
      doc: 'This message indicates the current trading status of a stock. At the start of day, the feed will send out a stock status message for each of the symbols trading on CXC, CX2 and CXD. Subsequently, stock status messages will be sent when a stock is halted or is released for trading.'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  trade_attribute:
    0x42:
      id: 'bypass'
      doc: 'Bypass Intentional Crosses Only Trade Message'
    0x43:
      id: 'market_on_close_or_cxd_conditional'
      doc: 'Market On Close On The Order Execution Message Cxd Conditional On The Trade Message'
    0x4c:
      id: 'melo'
      doc: 'Melo Trade Message'
    0x50:
      id: 'cxd_pure_stream'
      doc: 'Cxd Pure Stream Trade Message'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x56:
      id: 'vwap'
      doc: 'Vwap'
    0x58:
      id: 'intentional_cross'
      doc: 'Intentional Cross'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x4e:
      id: 'net_asset_value'
      doc: 'Net Asset Value'
  settlement_terms:
    0x54:
      id: 'cash_today'
      doc: 'Cash Today'
    0x44:
      id: 'delayed_delivery'
      doc: 'Delayed Delivery'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'First Message Of The Day'
    0x53:
      id: 'start_of_nasdaq_canada_trading_session'
      doc: 'Start Of Nasdaq Canada Trading Session'
    0x51:
      id: 'start_of_primary_market_trading_session'
      doc: 'Start Of Primary Market Trading Session'
    0x4d:
      id: 'end_of_primary_market_trading_session'
      doc: 'End Of Primary Market Trading Session Indicates That Pegged Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours Nasdaq Canada Is Closed And Not Accepting Orders It Is Still Possible To Receive Broken Trade Messages And Order Cancel Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages Last Message Of The Day'
    0x57:
      id: 'market_wide_circuit_breaker_halt'
      doc: 'Trading Halted Due To Market Wide Circuit Breaker'
    0x52:
      id: 'market_wide_circuit_breaker_resumption'
      doc: 'Trading Resumed Following Market Wide Circuit Breaker'
  trading_state:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x54:
      id: 'trading'
      doc: 'Trading'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsx_venture'
      doc: 'Tsx Venture'
    0x43:
      id: 'cse'
      doc: 'Cse'
    0x4e:
      id: 'neo'
      doc: 'Neo'
  gef_eligible:
    0x59:
      id: 'gef_eligible'
      doc: 'Gef Eligible'
    0x4e:
      id: 'not_gef_eligible'
      doc: 'Not Gef Eligible'

