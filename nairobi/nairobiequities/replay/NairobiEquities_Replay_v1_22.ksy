# ---------------------------------------------------------------------
# Kaitai struct definition for: Nairobi NairobiEquities Replay Mitch v1.22
#
# Protocol:
#   Organization: Nairobi Securities Exchange
#   Protocol: Nairobi Equities Replay
#   Encoding: Millennium Itch
#   Version: 1.22
#   Date: 11/24/2020
#   Specification: Equities-Market-Data-Feed-MITCH-UDP_v1.22.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: nairobi_nairobiequities_replay_mitch_v1_22
  title: Nairobi NairobiEquities Replay Mitch v1.22
  license: MIT-0
  endian: le

doc: 'Nairobi Securities Exchange Nairobi Securities Exchange Equities Nairobi Equities Replay Mitch v1.22'
doc-ref: https://www.nse.co.ke/dataservices/api-specification-documents/

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
        doc: 'Nairobi Mitch Unit Header, defining the length of a unit, its message count, market data group and first sequence number'
      - id: message
        type: message
        repeat: expr
        repeat-expr: unit_header.message_count
        doc: 'One Mitch message: its message header and payload'
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
        doc: 'Sequence number of the first payload message; zero in a unit header carrying unsequenced messages, other than a heartbeat'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Nairobi Mitch Tcp Message Header'
      - id: payload
        size: message_header.message_length - 3
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
            'message_type::off_book_trade_message': off_book_trade_message
            'message_type::trade_break_message': trade_break_message
            'message_type::trade_correction_message': trade_correction_message
            'message_type::recovery_trade_message': recovery_trade_message
            'message_type::auction_info_message': auction_info_message
            'message_type::statistics_message': statistics_message
            'message_type::extended_statistics_message': extended_statistics_message
            'message_type::consolidated_statistics_message': consolidated_statistics_message
            'message_type::index_message': index_message
            'message_type::aon_info_message': aon_info_message
            'message_type::news_message': news_message
            'message_type::update_price_point_message': update_price_point_message
            'message_type::delete_price_point_message': delete_price_point_message
            'message_type::top_of_book_message': top_of_book_message
  message_header:
    seq:
      - id: message_length
        type: u2
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
        doc: 'Status of the login request. The document names this field Status'
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
        doc: 'Status of the replay request. The document names this field Status'
  time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Number of seconds since midnight. Midnight will be in terms of the local time for the server (i.e. not UTC). Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Start or end of day'
  symbol_directory_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: symbol_status
        type: u1
        enum: symbol_status
        doc: 'Status of the instrument. This field will contain a space if the instrument is active'
      - id: identification_number
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number (e.g. ISIN, CUSIP, etc.)'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to'
      - id: expiration_date
        type: yyyymmdd_ascii_date
        doc: 'Date an instrument expires or matures. This field will contain only spaces if the instrument is not a derivative or fixed income instrument'
      - id: underlying
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the underlying instrument. This field will contain only spaces if the instrument is not a derivative'
      - id: strike_price
        type: decimal_s4_4
        doc: 'Strike price of an option. The price will be zero if the instrument is not an option. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Call or put. This field will contain a space if the instrument is not an option'
      - id: issuer
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer of the instrument. This field will contain all spaces if the instrument is not an equity or fixed income instrument'
      - id: issue_date
        type: yyyymmdd_ascii_date
        doc: 'Date instrument was issued. This field will contain all spaces if the instrument is not a fixed income instrument'
      - id: coupon
        type: decimal_s4_4
        doc: 'Rate of interest applied to the face value. This is a percentage field (e.g. 0.05 represents 5%). The price will be zero if the instrument is not a fixed income instrument. Implied decimal with scale 1e-4'
      - id: symbol_directory_flags
        type: symbol_directory_flags
        doc: 'Instrument flags of the Symbol Directory message, which the document labels Flags'
      - id: sub_book_flags
        type: sub_book_flags
        doc: 'Order books a message relates to, one bit per book. The document labels this field Sub Book, the label it also gives the single valued order book code of the trade and statistics messages; the two are different encodings'
      - id: corporate_action
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pipe separated field. Identifies the type of Corporate Actions applicable on the instrument for the current Trading day'
      - id: issued_quantity
        type: decimal_s8_8
        doc: 'Issued Quantity of the instrument. Implied decimal with scale 1e-8'
  symbol_directory_flags:
    meta:
      bit-endian: le
    seq:
      - id: inverse_order_book
        type: b1
        doc: 'Inverse order book'
      - id: reserved_17
        type: b7
        doc: 'Not defined'
  sub_book_flags:
    meta:
      bit-endian: le
    seq:
      - id: regular
        type: b1
        doc: 'Regular order book'
      - id: off_book
        type: b1
        doc: 'Off-Book order book'
      - id: block_trade
        type: b1
        doc: 'Block Trade order book'
      - id: odd_lot
        type: b1
        doc: 'Odd Lot order book'
      - id: early_settlement
        type: b1
        doc: 'Early Settlement order book'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board order book'
      - id: auction
        type: b1
        doc: 'Auction order book'
      - id: all_or_none
        type: b1
        doc: 'All or None order book'
  symbol_status_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading session that applies to the instrument'
      - id: symbol_status_flags
        type: symbol_status_flags
        doc: 'Flags of the Symbol Status message, which the document labels Flags and reserves for future use'
      - id: halt_reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the trading halt. This field will contain only spaces if Trading Status is not "H"'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason for the session change'
      - id: new_end_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'New session end time specified in terms of local time for server (i.e. not UTC). The field will contain only spaces if Session Change Reason is "0" or "9"'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
  symbol_status_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_07
        type: b8
        doc: 'Reserved for future use'
  add_order_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Flags of the Add Order message, which the document labels Flags'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Type of settlement. Only valid when Order Book is Block Trade (4)'
      - id: interest_rate
        type: decimal_s4_4
        doc: 'Gives the interest rate for a Repo order. Only valid when Order Book is Block Trade (4). Implied decimal with scale 1e-4'
      - id: term
        type: u1
        doc: 'Gives the term of settlement of the 2nd leg of the Repo. Only valid when Order Book is Block Trade (4)'
  add_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_03
        type: b4
        doc: 'Not defined'
      - id: market_order
        type: b1
        doc: 'Market order'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board order book'
      - id: reserved_67
        type: b2
        doc: 'Not defined'
  add_attributed_order_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: attribution
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of firm that submitted the order'
      - id: add_attributed_order_flags
        type: add_attributed_order_flags
        doc: 'Flags of the Add Attributed Order message, which the document labels Flags'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
  add_attributed_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_04
        type: b5
        doc: 'Not defined'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board order book'
      - id: reserved_67
        type: b2
        doc: 'Not defined'
  order_deleted_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
  order_modified_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: new_quantity
        type: u4
        doc: 'New displayed quantity of the order'
      - id: new_price
        type: decimal_s4_4
        doc: 'New limit price of the order. Implied decimal with scale 1e-4'
      - id: order_modified_flags
        type: order_modified_flags
        doc: 'Flags of the Order Modified message, which the document labels Flags'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Type of settlement. Only valid when Order Book is Block Trade (4)'
      - id: interest_rate
        type: decimal_s4_4
        doc: 'Gives the interest rate for a Repo order. Only valid when Order Book is Block Trade (4). Implied decimal with scale 1e-4'
      - id: term
        type: u1
        doc: 'Gives the term of settlement of the 2nd leg of the Repo. Only valid when Order Book is Block Trade (4)'
  order_modified_flags:
    meta:
      bit-endian: le
    seq:
      - id: priority_flag
        type: b1
        doc: 'Whether the order retained its time priority'
      - id: reserved_17
        type: b7
        doc: 'Not defined'
  order_book_clear_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: book_type
        type: u1
        enum: book_type
        doc: 'Type of book to be cleared'
  order_executed_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: buy_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the buy order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: sell_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the sell order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
  order_executed_with_price_size_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: display_quantity
        type: u4
        doc: 'Displayed quantity of the order after the execution'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: printable
        type: u1
        enum: printable
        doc: 'Whether the trade should update time and sales and statistics displays'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: buy_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the buy order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: sell_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the sell order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
  trade_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: buy_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the buy order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: sell_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the sell order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
  auction_trade_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
  off_book_trade_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: off_book_trade_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of off-book trade'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time off-book trade was executed. The time is specified in terms of the local time for the server (i.e. not UTC)'
      - id: trade_date
        type: yyyymmdd_ascii_date
        doc: 'Date off-book trade was executed'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
  trade_break_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'On-book or off-book trade'
  trade_correction_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: buy_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the buy order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: sell_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the sell order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
  recovery_trade_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction'
      - id: off_book_trade_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of off-book trade'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time off-book trade was executed. The time is specified in terms of the local time for the server (i.e. not UTC)'
      - id: trade_date
        type: yyyymmdd_ascii_date
        doc: 'Date off-book trade was executed'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'Action on the trade'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: buy_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the buy order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: sell_firm
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifier of the firm which submitted the sell order. Required only if the ''Publish Firms'' is enabled for the order book in which the execution occurred'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Converted price of the executed volatility of the options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Converted volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: underlying_reference_price
        type: decimal_s8_8
        doc: 'Underlying Reference Price related to converted value calculated upon an options instrument trade execution. Implied decimal with scale 1e-8'
      - id: auction_trade_type
        type: u1
        enum: auction_trade_type
        doc: 'Denotes the type of the auction trade being disseminated. For regular trades this field will be unset'
  auction_info_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: paired_quantity
        type: u4
        doc: 'Quantity that will be matched at the indicative price'
      - id: imbalance_quantity
        type: u4
        doc: 'Quantity that is eligible to be matched at the indicative price but will not be matched'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Direction of the imbalance'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction'
  statistics_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: statistic_type
        type: u1
        enum: statistic_type
        doc: 'Type of statistic'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'How the price was determined'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
  extended_statistics_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: high_price
        type: decimal_s4_4
        doc: 'High price for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_s4_4
        doc: 'Low price for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-4'
      - id: vwap
        type: decimal_s4_4
        doc: 'VWAP for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'Volume for the sub book. Will be set to a negative value if the value is not set or withdrawn. The document types the field as an unsigned integer'
      - id: turnover
        type: decimal_s8_8
        doc: 'Turnover for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: trades
        type: u4
        doc: 'Number of trades for the sub book. Will be set to a negative value if the value is not set or withdrawn. The document types the field as an unsigned integer'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book the status relates to'
      - id: notional_exposure
        type: decimal_s8_8
        doc: 'Notional exposure related to the options trade executions. Implied decimal with scale 1e-8'
      - id: notional_delta_exposure
        type: decimal_s8_8
        doc: 'Notional exposure updated by the delta of the option based on trade executions. Implied decimal with scale 1e-8'
      - id: daily_foreign_buy_value
        type: decimal_s8_8
        doc: 'Total foreign buy trade value for the day for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: daily_foreign_sell_value
        type: decimal_s8_8
        doc: 'Total foreign sell trade value for the day for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: market_capitalization
        type: decimal_s8_8
        doc: 'Market Capitalization of the instrument. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
  consolidated_statistics_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: statistics_type
        type: u1
        enum: statistics_type
        doc: 'Level the statistics relate to'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: volume
        type: u4
        doc: 'Volume for the sub book. Will be set to a negative value if the value is not set or withdrawn. The document types the field as an unsigned integer'
      - id: turnover
        type: decimal_s8_8
        doc: 'Turnover for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: trades
        type: u4
        doc: 'Number of trades for the sub book. Will be set to a negative value if the value is not set or withdrawn. The document types the field as an unsigned integer'
      - id: daily_foreign_buy_value
        type: decimal_s8_8
        doc: 'Total foreign buy trade value for the day for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: daily_foreign_sell_value
        type: decimal_s8_8
        doc: 'Total foreign sell trade value for the day for the sub book. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
      - id: market_capitalization
        type: decimal_s8_8
        doc: 'Market Capitalization of the instrument. Will be set to a negative value if the value is not set or withdrawn. Implied decimal with scale 1e-8'
  index_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: index_value
        type: decimal_s4_4
        doc: 'Index value. Implied decimal with scale 1e-4'
      - id: update_type
        type: u1
        enum: update_type
        doc: 'Type of index value'
      - id: perctg_diff_from_closing
        type: decimal_s4_4
        doc: 'Percentage difference of the current Index value compared to the Previous Closing index value. This will be set to 0 when the Index Type is Previous Close (2); the document means Update Type. Implied decimal with scale 1e-4'
  aon_info_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: aon_status
        type: u1
        enum: aon_status
        doc: 'Status of the auction'
      - id: date
        type: yyyymmdd_ascii_date
        doc: 'Date the auction is being held. This field will contain only spaces if the instrument contains an AON Status of ''Inactive'' or ''Cancelled'''
  news_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the announcement was published. The time is specified in terms of the local time for the server (i.e. not UTC)'
      - id: urgency
        type: u1
        enum: urgency
        doc: 'Urgency of the announcement'
      - id: headline
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Headline or subject of announcement'
      - id: text
        type: str
        size: 750
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text of the announcement'
      - id: instruments
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pipe separated list of symbols of the instruments announcement relates to'
      - id: underlyings
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pipe separated list of symbols of the underlyings announcement relates to'
  update_price_point_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price_point_sub_book_flags
        type: price_point_sub_book_flags
        doc: 'Order books of an Update Price Point, Delete Price Point or Top of Book message, one bit per book. The document labels this field Sub book or Sub Book; it defines no bit 1 or bit 7, and its bit 6 is Default Auction'
      - id: price_point_action
        type: u1
        enum: price_point_action
        doc: 'Action on the price point. The document names this field Action'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price_level
        type: u1
        doc: 'Price Level of the order. A smaller number will denote a more marketable price point. A Price Level of 0 will denote market orders'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: splits
        type: u4
        doc: 'Number of orders that contribute to this price point. Only the orders with a visible portion will be considered'
      - id: update_price_point_flags
        type: update_price_point_flags
        doc: 'Flags of the Update Price Point message, which the document labels Flags'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
  price_point_sub_book_flags:
    meta:
      bit-endian: le
    seq:
      - id: regular
        type: b1
        doc: 'Regular order book'
      - id: reserved_11
        type: b1
        doc: 'Not defined'
      - id: block_trade
        type: b1
        doc: 'Block Trade order book'
      - id: odd_lot
        type: b1
        doc: 'Odd Lot order book'
      - id: early_settlement
        type: b1
        doc: 'Early Settlement order book'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board order book'
      - id: default_auction
        type: b1
        doc: 'Default Auction order book'
      - id: reserved_7
        type: b1
        doc: 'Not defined'
  update_price_point_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_03
        type: b4
        doc: 'Not defined'
      - id: market_order
        type: b1
        doc: 'Market order'
      - id: reserved_57
        type: b3
        doc: 'Not defined'
  delete_price_point_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price_point_sub_book_flags
        type: price_point_sub_book_flags
        doc: 'Order books of an Update Price Point, Delete Price Point or Top of Book message, one bit per book. The document labels this field Sub book or Sub Book; it defines no bit 1 or bit 7, and its bit 6 is Default Auction'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price_level
        type: u1
        doc: 'Price Level of the order. A smaller number will denote a more marketable price point. A Price Level of 0 will denote market orders'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
  top_of_book_message:
    seq:
      - id: nanosecond
        type: nanosecond_offset
        doc: 'Nanoseconds offset from the last Time message. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument''s symbol'
      - id: price_point_sub_book_flags
        type: price_point_sub_book_flags
        doc: 'Order books of an Update Price Point, Delete Price Point or Top of Book message, one bit per book. The document labels this field Sub book or Sub Book; it defines no bit 1 or bit 7, and its bit 6 is Default Auction'
      - id: top_of_book_action
        type: u1
        enum: top_of_book_action
        doc: 'Action on the top of book. The document names this field Action'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: price
        type: decimal_s4_4
        doc: 'Limit price of the order. Implied decimal with scale 1e-4'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: market_order_quantity
        type: u4
        doc: 'Cumulative visible size of market orders'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
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
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to login to the Replay or Snapshot channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request to the Replay or Snapshot channel.'
    0x03:
      id: 'replay_request_message'
      doc: 'Used by the client to request a retransmission of messages on the Replay channel.'
    0x04:
      id: 'replay_response_message'
      doc: 'Used by the server to respond to a retransmission request on the Replay channel.'
    0x05:
      id: 'logout_request_message'
      doc: 'Used by the client to logout of the Replay or Snapshot channel.'
    0x54:
      id: 'time_message'
      doc: 'Sent by the server for every second for which at least one application message is generated; its time is the reference for the nanosecond offsets of every other application message.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x52:
      id: 'symbol_directory_message'
      doc: 'Used to disseminate information (e.g. symbol, segment, ISIN, underlying, etc.) on each instrument.'
    0x48:
      id: 'symbol_status_message'
      doc: 'Indicates the trading session (e.g. pre-opening, regular trading, etc.) that currently applies to an instrument.'
    0x41:
      id: 'add_order_message'
      doc: 'Sent to indicate that an anonymous limit or market order is added to the order book.'
    0x46:
      id: 'add_attributed_order_message'
      doc: 'Indicates that an attributable limit order is added to the order book. The identity of the submitting firm is included in the message.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Sent to indicate that the remainder of a displayed order is cancelled.'
    0x55:
      id: 'order_modified_message'
      doc: 'Indicates that the displayed quantity or price of a displayed order has been updated, and whether the order has retained or lost its time priority.'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument.'
    0x45:
      id: 'order_executed_message'
      doc: 'Indicates that the displayed portion of an order is fully or partially filled at its displayed price. The executed quantity is included in the message.'
    0x43:
      id: 'order_executed_with_price_size_message'
      doc: 'Sent if a displayed order is fully or partially filled at a price that is different from its displayed price, with an indication of whether the trade should update time and sales and statistics displays.'
    0x50:
      id: 'trade_message'
      doc: 'Sent if the non-displayed portion of an iceberg order or a reserve order is fully or partially filled, or if the negotiated non-disclosed order in the block trade order book is executed.'
    0x51:
      id: 'auction_trade_message'
      doc: 'Sent to report details of an auction (e.g. opening, closing, intra-day, etc.).'
    0x78:
      id: 'off_book_trade_message'
      doc: 'Sent to report the details of an off-book trade.'
    0x42:
      id: 'trade_break_message'
      doc: 'Sent to indicate that a previously reported trade is cancelled.'
    0x60:
      id: 'trade_correction_message'
      doc: 'Sent to report the correction of the executed quantity of a trade.'
    0x76:
      id: 'recovery_trade_message'
      doc: 'Sent on the Snapshot channel to retransmit the trades published on the Real-Time channel.'
    0x49:
      id: 'auction_info_message'
      doc: 'Indicative auction information for an instrument; the document labels the message type Indicative Auction Info.'
    0x77:
      id: 'statistics_message'
      doc: 'Sent to disseminate the opening, closing and previous closing prices of an instrument.'
    0x80:
      id: 'extended_statistics_message'
      doc: 'Sent to disseminate the high, low, VWAP, volume, turnover and other statistics of an instrument for a sub book.'
    0x64:
      id: 'consolidated_statistics_message'
      doc: 'Sent to disseminate the volume, turnover and trades of a market, sector or instrument type.'
    0x62:
      id: 'index_message'
      doc: 'Sent to disseminate the value of an index.'
    0x65:
      id: 'aon_info_message'
      doc: 'Sent to disseminate the details of an All or None auction.'
    0x75:
      id: 'news_message'
      doc: 'Sent to disseminate an announcement.'
    0x73:
      id: 'update_price_point_message'
      doc: 'Communicates the addition of a new price point or a size update to an already published price point.'
    0x72:
      id: 'delete_price_point_message'
      doc: 'Communicates the removal of a price point.'
    0x71:
      id: 'top_of_book_message'
      doc: 'Communicates the best price and cumulative visible size of a side of an order book.'
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
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x64:
      id: 'unsupported_message_type'
      doc: 'Unsupported Message Type'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  symbol_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x61:
      id: 'inactive'
      doc: 'Inactive'
    0x20:
      id: 'active'
      doc: 'Active'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x20:
      id: 'not_an_option'
      doc: 'Not An Option'
  trading_status:
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x54:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x61:
      id: 'opening_auction_call'
      doc: 'Opening Auction Call'
    0x62:
      id: 'post_close'
      doc: 'Post Close'
    0x63:
      id: 'market_close'
      doc: 'Market Close'
    0x64:
      id: 'closing_auction_call'
      doc: 'Closing Auction Call'
    0x65:
      id: 're_opening_auction_call'
      doc: 'Re Opening Auction Call'
    0x6c:
      id: 'pause'
      doc: 'Pause'
    0x6e:
      id: 'order_entry'
      doc: 'Order Entry'
    0x70:
      id: 'auction_initiation'
      doc: 'Auction Initiation'
    0x71:
      id: 'start_of_auction_call'
      doc: 'Start Of Auction Call'
    0x72:
      id: 'end_of_auction_call'
      doc: 'End Of Auction Call'
    0x73:
      id: 'start_of_aon_order_entry'
      doc: 'Start Of Aon Order Entry'
    0x74:
      id: 'end_of_aon_order_entry'
      doc: 'End Of Aon Order Entry'
    0x75:
      id: 'closing_price_cross'
      doc: 'Closing Price Cross'
    0x76:
      id: 'reserved_for_backward_compatibility'
      doc: 'Reserved For Backward Compatibility'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x79:
      id: 'pre_trading'
      doc: 'Pre Trading'
    0x7a:
      id: 'closing_price_publication'
      doc: 'Closing Price Publication'
    0x6f:
      id: 'intraday_auction_call'
      doc: 'Intraday Auction Call'
    0x30:
      id: 'auction_execution'
      doc: 'Auction Execution'
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
      id: 'market_order_extension'
      doc: 'Market Order Extension'
    4:
      id: 'price_monitoring_extension'
      doc: 'Price Monitoring Extension'
    5:
      id: 'circuit_breaker_tripped'
      doc: 'Circuit Breaker Tripped'
    9:
      id: 'unavailable'
      doc: 'Unavailable'
  sub_book:
    1:
      id: 'regular'
      doc: 'Regular'
    2:
      id: 'off_book'
      doc: 'Off Book'
    3:
      id: 'odd_lot'
      doc: 'Odd Lot'
    4:
      id: 'block_trade'
      doc: 'Block Trade'
    5:
      id: 'all_or_none'
      doc: 'All Or None'
    6:
      id: 'early_settlement'
      doc: 'Early Settlement'
    7:
      id: 'auction'
      doc: 'Auction'
    9:
      id: 'bulletin_board'
      doc: 'Bulletin Board'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  settlement_type:
    0x31:
      id: 'cash_t_plus_0'
      doc: 'Cash T Plus 0'
    0x32:
      id: 'early_settle_t_plus_1'
      doc: 'Early Settle T Plus 1'
    0x33:
      id: 't_plus_2'
      doc: 'T Plus 2'
    0x34:
      id: 'regular_t_plus_3'
      doc: 'Regular T Plus 3'
  priority_flag:
    0:
      id: 'priority_lost'
      doc: 'Priority Lost'
    1:
      id: 'priority_retained'
      doc: 'Priority Retained'
  book_type:
    0x30:
      id: 'mbp_mbo_statistics'
      doc: 'Mbp Mbo Statistics'
    0x31:
      id: 'top_of_book'
      doc: 'Top Of Book'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  auction_type:
    0x41:
      id: 're_opening_auction'
      doc: 'Re Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x4b:
      id: 'intra_day_auction'
      doc: 'Intra Day Auction'
    0x20:
      id: 'not_an_auction_trade'
      doc: 'Not An Auction Trade'
  trade_type:
    0x54:
      id: 'on_book_trade'
      doc: 'On Book Trade'
    0x4e:
      id: 'off_book_trade'
      doc: 'Off Book Trade'
  action_type:
    0x43:
      id: 'cancelled_trade'
      doc: 'Cancelled Trade'
    0x4e:
      id: 'trade'
      doc: 'Trade'
    0x41:
      id: 'amend_trade'
      doc: 'Amend Trade'
  auction_trade_type:
    0x42:
      id: 'bulk_trade'
      doc: 'Bulk Trade'
    0x53:
      id: 'supplementary_trade'
      doc: 'Supplementary Trade'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders_for_auction'
      doc: 'Insufficient Orders For Auction'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
  statistic_type:
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x50:
      id: 'previous_close'
      doc: 'Previous Close'
  open_close_indicator:
    0x41:
      id: 'auction_trade'
      doc: 'Auction Trade'
    0x42:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x43:
      id: 'mid_point'
      doc: 'Mid Point'
    0x44:
      id: 'last_regular_trade'
      doc: 'Last Regular Trade'
    0x45:
      id: 'last_auction'
      doc: 'Last Auction'
    0x46:
      id: 'manual'
      doc: 'Manual'
    0x48:
      id: 'vwap'
      doc: 'Vwap'
    0x49:
      id: 'previous_close'
      doc: 'Previous Close'
    0x54:
      id: 'theoretical_price'
      doc: 'Theoretical Price'
    0x55:
      id: 'best_bid'
      doc: 'Best Bid'
    0x56:
      id: 'best_offer'
      doc: 'Best Offer'
    0x57:
      id: 'none'
      doc: 'None'
    0x58:
      id: 'vwap_of_last_n_trades'
      doc: 'Vwap Of Last N Trades'
    0x59:
      id: 'reference_price'
      doc: 'Reference Price'
    0x5a:
      id: 'price_unavailable'
      doc: 'Price Unavailable'
  statistics_type:
    0:
      id: 'market'
      doc: 'Market'
    1:
      id: 'sector'
      doc: 'Sector'
    2:
      id: 'instrument_type'
      doc: 'Instrument Type'
  update_type:
    0:
      id: 'intra_day'
      doc: 'Intra Day'
    1:
      id: 'closing'
      doc: 'Closing'
    2:
      id: 'previous_close'
      doc: 'Previous Close'
    3:
      id: 'indicative'
      doc: 'Indicative'
    4:
      id: 'high'
      doc: 'High'
    5:
      id: 'low'
      doc: 'Low'
  aon_status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x43:
      id: 'completed'
      doc: 'Completed'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'inactive'
      doc: 'Inactive'
    0x58:
      id: 'cancelled'
      doc: 'Cancelled'
  urgency:
    0x30:
      id: 'regular'
      doc: 'Regular'
    0x31:
      id: 'high_priority'
      doc: 'High Priority'
    0x32:
      id: 'low_priority'
      doc: 'Low Priority'
  price_point_action:
    0x30:
      id: 'add'
      doc: 'Add'
    0x31:
      id: 'change'
      doc: 'Change'
  top_of_book_action:
    0x31:
      id: 'update'
      doc: 'Update'
    0x32:
      id: 'delete_field'
      doc: 'Delete'

