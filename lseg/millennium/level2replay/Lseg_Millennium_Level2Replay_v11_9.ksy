# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Millennium Level2Replay Mitch v11.9
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: 
#   Encoding: Millennium Itch
#   Version: 11.9
#   Date: 8/28/2018
#   Specification: mit303issue119.pdf
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
  id: lseg_millennium_level2replay_mitch_v11_9
  title: Lseg Millennium Level2Replay Mitch v11.9
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Millennium Exchange Mitch v11.9'
doc-ref: https://docs.londonstockexchange.com/sites/default/files/documents/mit303issue119.pdf

seq:
  - id: tcp_unit
    type: tcp_unit_struct
    repeat: eos
    doc: 'One unit on the tcp stream: the unit header and its payload messages'

types:
  tcp_unit_struct:
    seq:
      - id: unit_header
        type: unit_header
      - id: message
        type: message
        repeat: expr
        repeat-expr: unit_header.message_count
  unit_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message block including the header and all payload messages'
      - id: message_count
        type: u1
        doc: 'Number of payload messages that will follow the header'
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the first payload message'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mitch Tcp Message Header'
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_request_message': login_request_message
            'message_type::login_response_message': login_response_message
            'message_type::replay_request_message': replay_request_message
            'message_type::replay_response_message': replay_response_message
            'message_type::time_message': time_message
            'message_type::system_event_message': system_event_message
            'message_type::symbol_directory_message': symbol_directory_message
            'message_type::symbol_status_message': symbol_status_message
            'message_type::add_order_message': add_order_message
            'message_type::add_attributed_order_message': add_attributed_order_message
            'message_type::order_deleted_message': order_deleted_message
            'message_type::order_modified_message': order_modified_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_size_message': order_executed_with_price_size_message
            'message_type::trade_message': trade_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::auction_info_message': auction_info_message
            'message_type::statistics_message': statistics_message
            'message_type::top_of_book_message': top_of_book_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_request_message:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'CompID assigned to the client'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password assigned to the CompID'
  login_response_message:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Status of the login request'
  replay_request_message:
    seq:
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u2
        doc: 'Number of messages to be resent'
  replay_response_message:
    seq:
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u2
        doc: 'Number of messages to be resent'
      - id: replay_status
        type: u1
        enum: replay_status
        doc: 'Status of the replay request'
  time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since midnight. Midnight will be in terms of the local time for the server (i.e. not UTC). Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  symbol_directory_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: symbol_status
        type: u1
        enum: symbol_status
        doc: 'This field will contain a space if the instrument is active'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number'
      - id: sedol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to'
      - id: underlying
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO Currency Code'
      - id: reserved_byte
        size: 1
        doc: 'Reserved field'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: previous_close_price
        type: s8
        doc: 'Previous Close Price of instrument'
  symbol_status_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: symbol_status_flags
        type: symbol_status_flags
        doc: 'Symbol Status Flags'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the manual session change or the trading halt'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Session Change Reason'
      - id: new_end_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'New time the session will end. Will only be stamped if the session change was not in the original schedule e.g. AESP auction call or unscheduled session'
      - id: book_type
        type: u1
        enum: book_type
        doc: 'Book Type'
  symbol_status_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'
  add_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
      - id: reserved_10
        size: 10
        doc: 'Reserved field'
  add_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: market_order
        type: b1
        doc: 'Market Order'
      - id: unused_1
        type: b1
        doc: 'Unused'
      - id: private_rfq
        type: b1
        doc: 'Private RFQ'
      - id: second_unused_1
        type: b1
        doc: 'Unused'
  add_attributed_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: attribution
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of firm that submitted the order'
      - id: add_attributed_order_flags
        type: add_attributed_order_flags
        doc: 'Add Attributed Order Flags'
  add_attributed_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: named_market_order
        type: b1
        doc: 'Named Market Order'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'
  order_deleted_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: order_deleted_flags
        type: order_deleted_flags
        doc: 'Order Deleted Flags'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
  order_deleted_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'
  order_modified_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: new_quantity
        type: u4
        doc: 'New displayed quantity of the order'
      - id: new_price
        type: s8
        doc: 'New limit price of the order'
      - id: order_modified_flags
        type: order_modified_flags
        doc: 'Order Modified Flags'
  order_modified_flags:
    meta:
      bit-endian: le
    seq:
      - id: priority_flag
        type: b1
        doc: 'Priority Flag'
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'
  order_book_clear_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: order_book_clear_flags
        type: order_book_clear_flags
        doc: 'Order Book Clear Flags'
  order_book_clear_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: private_rfq
        type: b1
        doc: 'Private RFQ'
      - id: unused_1
        type: b1
        doc: 'Unused'
  order_executed_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: trade_match_id
        type: u8
        doc: 'Unique identifier of the trade'
  order_executed_with_price_size_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: display_quantity
        type: u4
        doc: 'Displayed quantity of the order after the execution'
      - id: trade_match_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: printable
        type: u1
        enum: printable
        doc: 'Printable'
      - id: price
        type: s8
        doc: 'Limit price of the order'
  trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_match_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: cross_type
        type: u1_nullable
        doc: 'The type of the Cross/BTF Order. Nullable, No Value = 0'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Sub Book'
      - id: pt_mod_flags
        type: pt_mod_flags
        doc: 'Indicates a trade cancellation or amendment'
  pt_mod_flags:
    meta:
      bit-endian: le
    seq:
      - id: canc
        type: b1
        doc: 'Cancel'
      - id: amnd
        type: b1
        doc: 'Amended'
      - id: unused_6
        type: b6
        doc: 'Unused'
  auction_trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_match_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: pt_mod_flags
        type: pt_mod_flags
        doc: 'Indicates a trade cancellation or amendment'
  auction_info_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: paired_quantity
        type: u4
        doc: 'Quantity that will be matched at the indicative price'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: reserved_1
        size: 1
        doc: 'Reserved field'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
  statistics_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: statistic_type
        type: u1
        enum: statistic_type
        doc: 'Statistic Type'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: open_close_price_indicator
        type: u1
        enum: open_close_price_indicator
      - id: statistics_reserved
        type: statistics_reserved
        doc: 'Reserved for future use'
  statistics_reserved:
    meta:
      bit-endian: le
    seq:
      - id: unused_8
        type: b8
        doc: 'Unused'
  top_of_book_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument''s symbol'
      - id: buy_limit_price
        type: s8
        doc: 'Best bid price. Will contain zero if there are no visible limit orders on the buy side'
      - id: buy_limit_size
        type: u4
        doc: 'Cumulative visible size at best bid price. Will contain zero if there are no visible limit orders on the buy side'
      - id: sell_limit_price
        type: s8
        doc: 'Best offer price. Will contain zero if there are no visible limit orders on the sell side'
      - id: sell_limit_size
        type: u4
        doc: 'Cumulative visible size at best offer price. Will contain zero if there are no visible limit orders on the sell side'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the replay channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request.'
    0x03:
      id: 'replay_request_message'
      doc: 'Used by the client to request the retransmission of messages published on the multicast channel.'
    0x04:
      id: 'replay_response_message'
      doc: 'Used by the server to accept or reject a replay request.'
    0x05:
      id: 'logout_request_message'
      doc: 'Used by the client to log out of the replay channel.'
    0x54:
      id: 'time_message'
      doc: 'Sent by the server for every second for which at least one application message is generated.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x52:
      id: 'symbol_directory_message'
      doc: 'Used to disseminate information (symbol, segment, ISIN, underlying, etc.) on each instrument'
    0x48:
      id: 'symbol_status_message'
      doc: 'Indicates the trading session (pre-opening, regular trading, etc.) that currently applies to an instrument.'
    0x41:
      id: 'add_order_message'
      doc: 'Sent to indicate that an anonymous limit or market order is added to the order book.'
    0x46:
      id: 'add_attributed_order_message'
      doc: 'Indicates that a named order is added to the order book.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Sent to indicate that the remainder of a displayed order is cancelled.'
    0x55:
      id: 'order_modified_message'
      doc: 'Indicates that the displayed quantity or price of a displayed order has been updated.'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument.'
    0x45:
      id: 'order_executed_message'
      doc: 'Indicates that the displayed portion of an order is fully or partially filled at its displayed price.'
    0x43:
      id: 'order_executed_with_price_size_message'
      doc: 'Sent if a displayed order is fully or partially filled at a price that is different from its displayed price.'
    0x50:
      id: 'trade_message'
      doc: 'Sent if a non-display order is fully or partially filled.'
    0x51:
      id: 'auction_trade_message'
      doc: 'Sent to report details of an auction'
    0x49:
      id: 'auction_info_message'
      doc: '9 Used to disseminate the indicative auction price and the tradable quantity and imbalance at this price.'
    0x77:
      id: 'statistics_message'
      doc: 'Used to disseminate official Opening and Closing prices'
    0x71:
      id: 'top_of_book_message'
      doc: 'Used to disseminate top of book changes when the instrument is in a scheduled level 1 only auction.'
  login_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x61:
      id: 'comp_id_inactive_locked'
      doc: 'Comp Id Inactive Locked'
    0x62:
      id: 'login_limit_reached'
      doc: 'Login Limit Reached'
    0x63:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
    0x64:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
  replay_status:
    0x41:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x44:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    0x49:
      id: 'invalid_market_data_group'
      doc: 'Invalid Market Data Group'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x55:
      id: 'replay_unavailable'
      doc: 'Replay Unavailable'
    0x64:
      id: 'unsupported_message_type'
      doc: 'Unsupported Message Type'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  symbol_status:
    0x20:
      id: 'active'
      doc: 'Active'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x61:
      id: 'inactive'
      doc: 'Inactive'
    0x48:
      id: 'halt'
      doc: 'Halt'
  trading_status:
    0x20:
      id: 'active'
      doc: 'Active'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x54:
      id: 'regular_trading_start_of_trade_reporting'
      doc: 'Regular Trading Start Of Trade Reporting'
    0x61:
      id: 'opening_first_auction_call'
      doc: 'Opening First Auction Call'
    0x62:
      id: 'post_close'
      doc: 'Post Close'
    0x63:
      id: 'market_close_system_shutdown'
      doc: 'Market Close System Shutdown'
    0x64:
      id: 'closing_auction_call'
      doc: 'Closing Auction Call'
    0x65:
      id: 'aesp_auction_call'
      doc: 'Aesp Auction Call'
    0x66:
      id: 'resume_auction_call'
      doc: 'Resume Auction Call'
    0x6c:
      id: 'pause'
      doc: 'Pause'
    0x6d:
      id: 'pre_mandatory'
      doc: 'Pre Mandatory'
    0x6e:
      id: 'mandatory'
      doc: 'Mandatory'
    0x6f:
      id: 'post_mandatory'
      doc: 'Post Mandatory'
    0x71:
      id: 'edsp_auction_call'
      doc: 'Edsp Auction Call'
    0x72:
      id: 'periodic_auction_call'
      doc: 'Periodic Auction Call'
    0x74:
      id: 'end_trade_reporting'
      doc: 'End Trade Reporting'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x75:
      id: 'closing_price_crossing'
      doc: 'Closing Price Crossing'
    0x47:
      id: 'scheduled_level_1_only_auction'
      doc: 'Scheduled Level 1 Only Auction'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
    1:
      id: 'extended_by_market_ops'
      doc: 'Extended By Market Ops'
    2:
      id: 'shortened_by_market_ops'
      doc: 'Shortened By Market Ops'
    3:
      id: 'market_order_imbalance'
      doc: 'Market Order Imbalance'
    4:
      id: 'price_outside_range'
      doc: 'Price Outside Range'
    9:
      id: 'unavailable_recovery_service_only'
      doc: 'Unavailable Recovery Service Only'
  book_type:
    1:
      id: 'on_book'
      doc: 'On Book'
    2:
      id: 'off_book'
      doc: 'Off Book'
    3:
      id: 'private_rfq'
      doc: 'Private Rfq'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  cross_type:
    5:
      id: 'internal_cross'
      doc: 'Internal Cross'
    6:
      id: 'internal_btf'
      doc: 'Internal Btf'
    7:
      id: 'committed_cross'
      doc: 'Committed Cross'
    8:
      id: 'committed_btf'
      doc: 'Committed Btf'
  sub_book:
    0:
      id: 'regular_trades'
      doc: 'Regular Trades'
    11:
      id: 'rfq_trades'
      doc: 'Rfq Trades'
  auction_type:
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x41:
      id: 'aesp'
      doc: 'Aesp'
    0x42:
      id: 'edsp'
      doc: 'Edsp'
    0x45:
      id: 'resume_auction'
      doc: 'Resume Auction'
    0x46:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x47:
      id: 'scheduled_level_1_only_auction'
      doc: 'Scheduled Level 1 Only Auction'
  statistic_type:
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
  open_close_price_indicator:
    0x41:
      id: 'ut'
      doc: 'Ut'
    0x42:
      id: 'at'
      doc: 'At'
    0x43:
      id: 'mid_of_bbo'
      doc: 'Mid Of Bbo'
    0x44:
      id: 'last_at'
      doc: 'Last At'
    0x45:
      id: 'last_ut'
      doc: 'Last Ut'
    0x46:
      id: 'manual'
      doc: 'Manual'
    0x49:
      id: 'derived_from_previous_close'
      doc: 'Derived From Previous Close'

