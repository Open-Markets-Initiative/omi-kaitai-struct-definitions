# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq MulticastLevel2 Itch v2.01
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Lynx Multicast Level 2
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
  id: tradelogiq_lynxats_multicastlevel2_itch_v2_01_udp
  title: Tradelogiq MulticastLevel2 Itch v2.01
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Lynx ATS Lynx Multicast Level 2 Itch v2.01'

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Tradelogiq Qtp Downstream Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
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
        doc: 'Indicates the session to which the packet belongs'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message in the packet'
      - id: message_count
        type: u2
        doc: 'The count of messages contained in this packet'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Tradelogiq Qtp Message Block Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::extended_stock_directory_message': extended_stock_directory_message
            'message_type::stock_trading_action_message': stock_trading_action_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_replace_message': order_replace_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::trade_message': trade_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::trade_bust_message': trade_bust_message
            'message_type::trade_amend_message': trade_amend_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'The length in bytes of the message contained in this message block'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Codes below'
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
  order_executed_message:
    seq:
      - id: marker
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Used to denote specialty markers'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u4
        doc: 'Unique reference number assigned to the new order'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: match_number
        type: u4
        doc: 'Day unique Match Number for this execution'
      - id: contra_broker_id
        type: u2
        doc: 'Broker number for contra side or ''1'' for anonymous'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  order_executed_with_price_message:
    seq:
      - id: marker
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Used to denote specialty markers'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u4
        doc: 'Unique reference number assigned to the new order'
      - id: executed_shares
        type: u4
        doc: 'The number of shares executed'
      - id: execution_price
        type: decimal_u4_4
        doc: 'The display price of this execution if different from the original. Implied decimal with scale 1e-4'
      - id: match_number
        type: u4
        doc: 'Day unique Match Number for this execution'
      - id: contra_broker_id
        type: u2
        doc: 'Broker number for contra side or ''1'' for anonymous'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  order_delete_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u4
        doc: 'Unique reference number assigned to the new order'
  order_replace_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: original_order_reference_number
        type: u4
        doc: 'The original reference number of the order being replaced'
      - id: new_order_reference_number
        type: u4
        doc: 'The order reference number for this order at time of replacement'
      - id: shares
        type: u4
        doc: 'Total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
  order_cancel_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: order_reference_number
        type: u4
        doc: 'Unique reference number assigned to the new order'
      - id: cancelled_shares
        type: u4
        doc: 'The number of shares to be removed from the display size of the order as the result of a cancellation'
  trade_message:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side of execution. Note: side will always be ''B'''
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: midpoint_book_trade
        type: u4
        enum: midpoint_book_trade
        doc: 'Yes represents Midpoint Book trade on Lynx ATS'
      - id: shares
        type: u4
        doc: 'Total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
      - id: match_number
        type: u4
        doc: 'Day unique Match Number for this execution'
      - id: buy_broker_id
        type: u2
        doc: 'Buy broker number or ''1'' for anonymous'
      - id: sell_broker_id
        type: u2
        doc: 'Sell broker number or ''1'' for anonymous'
  cross_trade_message:
    seq:
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The kind of cross being reported'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: shares
        type: u4
        doc: 'Total number of shares associated with the order being added to the book'
      - id: price
        type: decimal_u4_4
        doc: 'The display price of the new order. Implied decimal with scale 1e-4'
      - id: match_number
        type: u4
        doc: 'Day unique Match Number for this execution'
      - id: buy_broker_id
        type: u2
        doc: 'Buy broker number or ''1'' for anonymous'
      - id: sell_broker_id
        type: u2
        doc: 'Sell broker number or ''1'' for anonymous'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'Whether the cross bypassed the order book'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement terms of the cross'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
  trade_bust_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: match_number
        type: u4
        doc: 'Day unique Match Number for this execution'
  trade_amend_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: instrument_id
        type: u2
        doc: 'Internal instrument identifier for Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: original_trade_id
        type: u4
        doc: 'Original internal number of the given trade transaction'
      - id: original_trade_price
        type: decimal_u8_4
        doc: 'Original price associated with the trade transaction. Implied decimal with scale 1e-4'
      - id: original_trade_size
        type: u4
        doc: 'Trade Size reported on the original trade transaction'
      - id: corrected_trade_price
        type: decimal_u8_4
        doc: 'Price associated with the trade correction reported. Implied decimal with scale 1e-4'
      - id: corrected_trade_size
        type: u4
        doc: 'Number of shares with the trade correction'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
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

