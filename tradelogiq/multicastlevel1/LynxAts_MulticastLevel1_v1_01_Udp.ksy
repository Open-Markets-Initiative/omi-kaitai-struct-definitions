# ---------------------------------------------------------------------
# Kaitai struct definition for: Tradelogiq MulticastLevel1 Itch v1.01
#
# Protocol:
#   Organization: Tradelogiq Markets Inc.
#   Protocol: Lynx Multicast Level 1
#   Encoding: Itch
#   Version: 1.01
#   Date: 01/30/2022
#   Specification: TradelogiQ-Level-1-ITCH-5.0-Specification-v1.01.pdf
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
  id: tradelogiq_lynxats_multicastlevel1_itch_v1_01_udp
  title: Tradelogiq MulticastLevel1 Itch v1.01
  license: GPL-3.0
  endian: be

doc: 'Tradelogiq Markets Inc. Lynx ATS Lynx Multicast Level 1 Itch v1.01'

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
            'message_type::quote_message': quote_message
            'message_type::trade_report_message': trade_report_message
            'message_type::trade_bust_message': trade_bust_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::system_event_message': system_event_message
            'message_type::stock_directory_message': stock_directory_message
            'message_type::extended_stock_directory_message': extended_stock_directory_message
            'message_type::stock_status_message': stock_status_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'The length in bytes of the message contained in this message block'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  quote_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Identifier for which BBO quotation message is being generated'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: best_bid_price
        type: decimal_u8_4
        doc: 'Denotes best bid price on Tradelogiq''s books either OMEGA or LYNX. Implied decimal with scale 1e-4'
      - id: best_bid_size
        type: u4
        doc: 'Denotes the total number of shares available for display on Tradelogiq''s order books at the best bid price'
      - id: best_ask_price
        type: decimal_u8_4
        doc: 'Denotes best ask price on Tradelogiq''s order books either OMEGA or LYNX. Implied decimal with scale 1e-4'
      - id: best_ask_size
        type: u4
        doc: 'Denotes the total number of shares available for display on Tradelogiq''s order books at the best ask price'
  trade_report_message:
    seq:
      - id: conditions
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade condition codes, W for Bypass, X for Internal Cross and E for Odd Lot. Note: Field may be blank'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Identifier for which BBO quotation message is being generated'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: trade_id
        type: u4
        doc: 'Indicates the internal number of the given trade transaction'
      - id: trade_price
        type: decimal_u8_4
        doc: 'The price associated with the trade transaction being reported. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Number of shares on the trade transaction'
      - id: buy_broker
        type: u2
        doc: 'Buy Side Broker Number or 1 for Anonymous'
      - id: sell_broker
        type: u2
        doc: 'Sell Side Broker Number or 1 for Anonymous'
  trade_bust_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Identifier for which BBO quotation message is being generated'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: trade_id
        type: u4
        doc: 'Indicates the internal number of the given trade transaction'
  trade_correction_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: stock_symbol
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Identifier for which BBO quotation message is being generated'
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
  system_event_message:
    seq:
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See Below For codes'
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
  stock_status_message:
    seq:
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'The current trading state for the issue'
      - id: stock
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol on Omega ATS and Lynx ATS'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason the security is halted. Note: Field may be blank'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
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

enums:
  message_type:
    0x57:
      id: 'quote_message'
      doc: 'Tradelogiq''s BBO will broadcast real-time updates every time Tradelogiq''s top of book changes.'
    0x54:
      id: 'trade_report_message'
      doc: 'Relays all transactions available from or reported by Tradelogiq''s two trading books for the current business day.'
    0x4e:
      id: 'trade_bust_message'
      doc: 'If trade is cancelled or busted during the day Trade Bust Message will be sent.'
    0x4d:
      id: 'trade_correction_message'
      doc: 'Trade amendments during the day will send this message.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message is used to signal a market or a data feed handler event.'
    0x52:
      id: 'stock_directory_message'
      doc: 'At start of each trading day, OSI disseminates stock directory messages for supported securities.'
    0x72:
      id: 'extended_stock_directory_message'
      doc: 'Extended Stock Directory are for Special stock symbols eg warrants debentures rights.'
    0x48:
      id: 'stock_status_message'
      doc: 'This message indicates the current trading status of a stock.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'The Start If Day Message Is The First Message Sent Out In A Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicate That Tradelogiq Order Books Are Open And Ready To Start Accepting Order'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Order Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This Message Is Intended To Indicate That Market Hours Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It Indicates That Tradelogiq Order Books Are Now Closed And Will Not Accept New Orders'
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
      id: 'venture'
      doc: 'Venture'
    0x63:
      id: 'cnsx'
      doc: 'Cnsx'
    0x71:
      id: 'nasdaq_canada'
      doc: 'Nasdaq Canada'
    0x6f:
      id: 'omega'
      doc: 'Omega'
    0x7a:
      id: 'aequitas'
      doc: 'Aequitas'
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

