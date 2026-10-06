# ---------------------------------------------------------------------
# Kaitai struct definition for: Jse Itac MarketData Mitch v4.07
#
# Protocol:
#   Organization: JSE Limited
#   Protocol: Market Data
#   Encoding: Millennium Itch
#   Version: 4.07
#   Date: 4/20/2026
#   Specification: JSE Volume 05 - Market Data Gateway MITCH-UDP (407).pdf
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
  id: jse_itac_marketdata_mitch_v4_07
  title: Jse Itac MarketData Mitch v4.07
  license: GPL-3.0
  endian: le

doc: 'JSE Limited Integrated Trading and Clearing Market Data Mitch v4.07'
doc-ref: https://www.jse.co.za/services/technologies/equity-market-trading-and-information-solution

seq:
  - id: unit_header
    type: unit_header_struct
    doc: 'Jse Mitch Udp Unit Header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: unit_header.message_count
    doc: 'Jse Mitch Udp Message'

types:
  unit_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message block including the header and all payload messages'
      - id: message_count
        type: u1
        doc: 'Number of payload messages that follow the header. Zero marks a heartbeat'
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: sequence_number
        type: u4
        doc: 'Sequence number the snapshot should be synchronised with'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Jse Mitch Udp Message Header'
      - id: payload
        size: message_header.message_length - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_request_message': login_request_message
            'message_type::replay_request_message': replay_request_message
            'message_type::snapshot_request_message': snapshot_request_message
            'message_type::login_response_message': login_response_message
            'message_type::replay_response_message': replay_response_message
            'message_type::snapshot_response_message': snapshot_response_message
            'message_type::snapshot_complete_message': snapshot_complete_message
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
            'message_type::recovery_trade_message': recovery_trade_message
            'message_type::auction_info_message': auction_info_message
            'message_type::statistics_message': statistics_message
            'message_type::extended_statistics_message': extended_statistics_message
            'message_type::news_message': news_message
            'message_type::top_of_book_message': top_of_book_message
            'message_type::indicative_quote_info_message': indicative_quote_info_message
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
  replay_request_message:
    seq:
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in the range to be retransmitted'
      - id: count
        type: u2
        doc: 'Number of messages to be resent'
  snapshot_request_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number the snapshot should be synchronised with'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the request relates to. Contains only spaces if it does not relate to a segment'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: sub_book_flags
        type: sub_book_flags
        doc: 'Order books a message relates to, as a bitmask. The document labels this field Sub Book, the same label it gives the single valued order book code on the trade and statistics messages; the two are different encodings. Bit 0 is the rightmost bit of the byte'
      - id: snapshot_type
        type: u1
        enum: snapshot_type
        doc: 'Type of snapshot being requested'
      - id: recover_from_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Sending time of the last processed trade in local server time for Trades, or the last received announcement for News. Ignored for any other snapshot type'
      - id: request_id
        type: u4
        doc: 'Optional identifier used by the client to track requests sent on the recovery channel'
  sub_book_flags:
    meta:
      bit-endian: le
    seq:
      - id: regular
        type: b1
        doc: 'Regular'
      - id: off_book
        type: b1
        doc: 'Off Book'
      - id: unused_3
        type: b3
        doc: 'Unused'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board'
      - id: negotiated_trades
        type: b1
        doc: 'Negotiated Trades'
      - id: fx_auction
        type: b1
        doc: 'FX Auction'
  login_response_message:
    seq:
      - id: status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Status of the login request'
  replay_response_message:
    seq:
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the replay request relates to'
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in the range to be retransmitted'
      - id: count
        type: u2
        doc: 'Number of messages to be resent'
      - id: status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Status of the login request'
  snapshot_response_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number the snapshot should be synchronised with'
      - id: order_count
        type: u4
        doc: 'Number of orders that will be transmitted. Zero if Status is not A, and ignored if Snapshot Type is not Order Book'
      - id: status
        type: str
        size: 1
        encoding: ASCII
        doc: 'Status of the login request'
      - id: snapshot_type
        type: u1
        enum: snapshot_type
        doc: 'Type of snapshot being requested'
      - id: request_id
        type: u4
        doc: 'Optional identifier used by the client to track requests sent on the recovery channel'
  snapshot_complete_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number the snapshot should be synchronised with'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the request relates to. Contains only spaces if it does not relate to a segment'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: sub_book_flags
        type: sub_book_flags
        doc: 'Order books a message relates to, as a bitmask. The document labels this field Sub Book, the same label it gives the single valued order book code on the trade and statistics messages; the two are different encodings. Bit 0 is the rightmost bit of the byte'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Indicated only when the message is sent as a book level complete and the Snapshot Type is Order Book or Statistics'
  time_message:
    seq:
      - id: seconds
        type: u4
        doc: 'Number of seconds since midnight, in local server time rather than Utc'
  system_event_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'The system event being signalled'
  symbol_directory_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: symbol_status
        type: u1
        enum: symbol_status
        doc: 'Status of the instrument. Contains a space when the instrument is active'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'International Securities Identifying Number'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the instrument'
      - id: tidm
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Tradable Instrument Display Mnemonic. The revision history records that this field is reclassified as reserved at release 7.8'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the request relates to. Contains only spaces if it does not relate to a segment'
      - id: previous_close_price
        type: s8
        doc: 'Previous close price of the instrument'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Date the instrument expires or matures. Contains only spaces if the instrument is not a derivative or fixed income instrument'
      - id: underlying
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of the underlying instrument. Contains only spaces if the instrument is not a derivative'
      - id: strike_price
        type: s8
        doc: 'Strike price of an option. Zero if the instrument is not an option'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Whether the instrument is a call or a put. Contains a space if the instrument is not an option'
      - id: issuer
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer of the instrument. Contains all spaces if the instrument is not a fixed income instrument'
      - id: issue_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Date the instrument was issued. Contains all spaces if the instrument is not a fixed income instrument'
      - id: coupon
        type: s8
        doc: 'Rate of interest applied to the face value, as a percentage where 0.05 represents five percent. Zero if the instrument is not a fixed income instrument'
      - id: symbol_directory_flags
        type: symbol_directory_flags
        doc: 'Instrument level flags carried on the Symbol Directory message'
      - id: sub_book_flags
        type: sub_book_flags
        doc: 'Order books a message relates to, as a bitmask. The document labels this field Sub Book, the same label it gives the single valued order book code on the trade and statistics messages; the two are different encodings. Bit 0 is the rightmost bit of the byte'
      - id: corporate_action
        type: str
        size: 189
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ex marker and annotation information associated with the instrument, if any'
      - id: leg_1_symbol
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        if: _parent.message_header.message_length > 332
        doc: 'Symbol of the leg 1 instrument. Contains only spaces if the instrument is not multi legged. Derivative market data groups only'
      - id: leg_2_symbol
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        if: _parent.message_header.message_length > 332
        doc: 'Symbol of the leg 2 instrument. Contains only spaces if the instrument is not multi legged. Derivative market data groups only'
      - id: contract_multiplier
        type: s8
        if: _parent.message_header.message_length > 332
        doc: 'Multiplier of the instrument. Zero if the instrument has no contract multiplier. Derivative market data groups only'
      - id: settlement_method
        type: u1
        enum: settlement_method
        if: _parent.message_header.message_length > 332
        doc: 'Settlement method of the underlying contract. Contains only spaces if the instrument has no settlement method. Derivative market data groups only'
      - id: instrument_sub_category
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
        if: _parent.message_header.message_length > 332
        doc: 'Instrument sub category the instrument belongs to. Derivative market data groups only'
      - id: exercise_style
        type: u1
        enum: exercise_style
        if: _parent.message_header.message_length > 332
        doc: 'Exercise style of an options instrument. Contains a space if the instrument is not an option. Derivative market data groups only'
  symbol_directory_flags:
    meta:
      bit-endian: le
    seq:
      - id: inverse_order_book
        type: b1
        doc: 'Inverse Order Book'
      - id: unused_7
        type: b7
        doc: 'Unused'
  symbol_status_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Indicated only when the message is sent as a book level complete and the Snapshot Type is Order Book or Statistics'
      - id: symbol_status_flags
        type: symbol_status_flags
        doc: 'Reserved for future use'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason code for the change in session. Contains only spaces if the reason is unknown'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Why the session changed'
      - id: new_end_time
        type: str
        size: 12
        encoding: ASCII
        doc: 'New session end time in local server time, formatted HH:MM:SS:sss. Contains only spaces when Session Change Reason is scheduled transition or unavailable'
      - id: book_type
        type: u1
        enum: book_type
        doc: 'Order book the status applies to'
  symbol_status_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_8
        type: b8
        doc: 'Unused'
  add_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Whether the order is a buy or a sell'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
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
        doc: 'Order level flags carried on the Add Order message'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier assigned to each request for quote in the system'
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
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board'
      - id: unused_2
        type: b2
        doc: 'Unused'
  add_attributed_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Whether the order is a buy or a sell'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: attribution
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of the firm that submitted the order'
      - id: add_attributed_order_flags
        type: add_attributed_order_flags
        doc: 'Order level flags carried on the Add Attributed Order message'
  add_attributed_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: regular
        type: b1
        doc: 'Regular'
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: bulletin_board
        type: b1
        doc: 'Bulletin Board'
      - id: unused_2
        type: b2
        doc: 'Unused'
  order_deleted_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
  order_modified_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
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
        doc: 'Whether the modified order retained its priority'
  order_modified_flags:
    meta:
      bit-endian: le
    seq:
      - id: priority_flag
        type: b1
        doc: 'Priority Flag'
      - id: unused_7
        type: b7
        doc: 'Unused'
  order_book_clear_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book to be cleared'
      - id: book_level
        type: u1
        enum: book_level
        doc: 'Whether the book being cleared is order by order or top of book'
  order_executed_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the trade was executed, derived from the instrument level parameter Security Exchange'
  order_executed_with_price_size_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
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
        doc: 'Whether the execution should be included in trade statistics'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the trade was executed, derived from the instrument level parameter Security Exchange'
  trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book to be cleared'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade level flags carried on the Trade message'
      - id: trade_sub_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of request for quote trade. Applicable only when Sub Book is negotiated trades'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the trade was executed, derived from the instrument level parameter Security Exchange'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been cancelled. Carries CANC when set'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been amended. Carries AMND when set'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: trade_condition_flag
        type: b1
        doc: 'Trade Condition Flag'
      - id: crossed_order_trade
        type: b1
        doc: 'Crossed Order Trade'
      - id: fx_auction_trade
        type: b1
        doc: 'FX Auction Trade'
      - id: unused_5
        type: b5
        doc: 'Unused'
  auction_trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction that produced the trade'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been cancelled. Carries CANC when set'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been amended. Carries AMND when set'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the trade was executed, derived from the instrument level parameter Security Exchange'
  off_book_trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: off_book_trade_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of off book trade'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the off book trade was agreed between the firms, in local server time'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Date the off book trade was agreed between the firms'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been cancelled. Carries CANC when set'
  recovery_trade_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: executed_quantity
        type: u4
        doc: 'Quantity executed'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction that produced the trade'
      - id: off_book_rfq_trade_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of off book or request for quote trade. Contains only spaces for on book trades'
      - id: trade_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the off book trade was agreed between the firms, in local server time'
      - id: trade_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'Date the off book trade was agreed between the firms'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'Whether the message reports a trade or the cancellation of one'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book to be cleared'
      - id: recovery_trade_flags
        type: recovery_trade_flags
        doc: 'Trade level flags carried on the Recovery Trade message'
      - id: last_opt_px
        type: s8
        doc: 'Converted price of the executed volatility of the options instrument. Blank for equity instruments'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
      - id: underlying_reference_price
        type: s8
        doc: 'Underlying reference price related to the converted value calculated upon an options instrument trade execution. Blank for equity instruments'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the trade was executed, derived from the instrument level parameter Security Exchange'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been cancelled. Carries CANC when set'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the trade represented by the message has been amended. Carries AMND when set'
  recovery_trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: trade_condition_flag
        type: b1
        doc: 'Trade Condition Flag'
      - id: crossed_order
        type: b1
        doc: 'Crossed Order'
      - id: unused_6
        type: b6
        doc: 'Unused'
  auction_info_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: paired_quantity
        type: u4
        doc: 'Quantity that will be matched at the indicative price'
      - id: reserved_4
        size: 4
        doc: 'Reserved field'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Direction of the imbalance, or that there are insufficient orders for the auction'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
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
        doc: 'Type of auction that produced the trade'
  statistics_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: statistic_type
        type: u1
        enum: statistic_type
        doc: 'Whether the price is an opening or a closing price'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'How the opening or closing price was derived'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book to be cleared'
  extended_statistics_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: high_price
        type: s8
        doc: 'High price of the instrument'
      - id: low_price
        type: s8
        doc: 'Low price of the instrument'
      - id: vwap
        type: s8
        doc: 'Volume weighted average price of the instrument'
      - id: volume
        type: u4
        doc: 'Volume of the instrument'
      - id: turnover
        type: decimal_s8_4
        doc: 'Turnover of the instrument, carrying four implied decimal places rather than eight. Implied decimal with scale 1e-4'
      - id: number_of_trades
        type: u4
        doc: 'Number of trades for this instrument'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: sub_book
        type: u1
        enum: sub_book
        doc: 'Order book to be cleared'
      - id: notional_exposure
        type: decimal_s8_4
        doc: 'Notional exposure, carrying four implied decimal places rather than eight. Implied decimal with scale 1e-4'
      - id: notional_delta_exposure
        type: decimal_s8_4
        doc: 'Notional exposure updated by the delta of the option based on trade executions, carrying four implied decimal places rather than eight. Implied decimal with scale 1e-4'
      - id: open_interest
        type: s8
        doc: 'Open interest of the specified instrument'
      - id: theoretical_price
        type: s8
        doc: 'Theoretical price of the options trade'
      - id: delta
        type: s8
        doc: 'Delta value of the options trade'
      - id: gamma
        type: s8
        doc: 'Gamma value of the options trade'
      - id: vega
        type: s8
        doc: 'Vega value of the options trade'
      - id: theta
        type: s8
        doc: 'Theta value of the options trade'
      - id: rho
        type: s8
        doc: 'Rho value of the options trade'
      - id: volatility
        type: s8
        doc: 'Converted volatility of the executed price of the options instrument. Blank for equity instruments'
  news_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Time the announcement was published, in local server time rather than Utc'
      - id: urgency
        type: u1
        enum: urgency
        doc: 'Priority of the announcement'
      - id: headline
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Headline or subject of the announcement'
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
        doc: 'Pipe separated list of the instruments the announcement was sent for'
      - id: underlyings
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pipe separated list of the symbols of the underlyings the announcement relates to'
  top_of_book_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: reserve_field
        type: u2
        doc: 'Reserved for future use'
      - id: sub_book_flags
        type: sub_book_flags
        doc: 'Order books a message relates to, as a bitmask. The document labels this field Sub Book, the same label it gives the single valued order book code on the trade and statistics messages; the two are different encodings. Bit 0 is the rightmost bit of the byte'
      - id: action
        type: u1
        enum: action
        doc: 'Whether the update revises or removes the price level'
      - id: side
        type: u1
        enum: side
        doc: 'Whether the order is a buy or a sell'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: market_order_quantity
        type: u4
        doc: 'Cumulative visible size of market orders'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: splits
        type: u4
        doc: 'Cumulative visible orders at the best price, including all market orders during auctions. Zero on a delete action'
  indicative_quote_info_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since the last Time message'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. Contains only spaces if it does not relate to an instrument and the Segment field is populated'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique identifier assigned to each request for quote in the system'
      - id: indicative_bid_price
        type: s8
        doc: 'Indicative price of the quotes on the buy side for the request for quote'
      - id: indicative_offer_price
        type: s8
        doc: 'Indicative price of the quotes on the sell side for the request for quote'
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Sent by the client to log in to the market data gateway.'
    0x03:
      id: 'replay_request_message'
      doc: 'Sent by the client on the replay channel to request retransmission of a range of messages.'
    0x81:
      id: 'snapshot_request_message'
      doc: 'Sent by the client on the recovery channel to request a snapshot of current state.'
    0x05:
      id: 'logout_request_message'
      doc: 'Sent by the client to log out of the market data gateway. Carries no fields beyond the message header.'
    0x02:
      id: 'login_response_message'
      doc: 'Sent by the server in response to a Login Request.'
    0x04:
      id: 'replay_response_message'
      doc: 'Sent by the server in response to a Replay Request.'
    0x82:
      id: 'snapshot_response_message'
      doc: 'Sent by the server in response to a Snapshot Request.'
    0x83:
      id: 'snapshot_complete_message'
      doc: 'Sent by the server to mark the end of a snapshot.'
    0x54:
      id: 'time_message'
      doc: 'Sent for every second in which at least one application message is generated. All subsequent messages carry a nanosecond offset from this time.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to signal the start and end of the trading day.'
    0x52:
      id: 'symbol_directory_message'
      doc: 'Disseminates the reference data of each instrument carried on the feed. The six fields from Leg 1 Symbol onward are published only on the derivative market data groups; on the equity market data groups the message ends after Corporate Action.'
    0x48:
      id: 'symbol_status_message'
      doc: 'Disseminates a change in the trading status of an instrument.'
    0x41:
      id: 'add_order_message'
      doc: 'Sent when an order is added to the order book.'
    0x46:
      id: 'add_attributed_order_message'
      doc: 'Sent when an order carrying the identity of the submitting firm is added to the order book.'
    0x44:
      id: 'order_deleted_message'
      doc: 'Sent when an order is removed from the order book.'
    0x55:
      id: 'order_modified_message'
      doc: 'Sent when the quantity or price of an order on the book changes.'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct the recipient to discard every order held for an instrument on the named book.'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent when an order on the book executes in full or in part at its display price.'
    0x43:
      id: 'order_executed_with_price_size_message'
      doc: 'Sent when an order on the book executes at a price other than its display price, or when the execution is not printable.'
    0x50:
      id: 'trade_message'
      doc: 'Sent for a trade that does not result from an order resting on a displayed order book.'
    0x51:
      id: 'auction_trade_message'
      doc: 'Sent for a trade that results from an auction uncrossing.'
    0x78:
      id: 'off_book_trade_message'
      doc: 'Sent for a trade agreed away from the order book and reported to the exchange.'
    0x76:
      id: 'recovery_trade_message'
      doc: 'Sent on the recovery channel in place of the individual trade messages, carrying every trade shape in one layout.'
    0x49:
      id: 'auction_info_message'
      doc: 'Disseminates the indicative price and paired quantity of an instrument in an auction call.'
    0x77:
      id: 'statistics_message'
      doc: 'Disseminates the opening or closing price of an instrument.'
    0x80:
      id: 'extended_statistics_message'
      doc: 'Disseminates the intraday statistics of an instrument. Values that are not set or have been withdrawn are negative, except Volume and Number of Trades which are zero.'
    0x75:
      id: 'news_message'
      doc: 'Carries an exchange announcement and the instruments it relates to.'
    0x71:
      id: 'top_of_book_message'
      doc: 'Disseminates the best price on one side of an instrument for recipients that do not maintain an order by order book.'
    0x69:
      id: 'indicative_quote_info_message'
      doc: 'Disseminates the indicative bid and offer of a request for quote.'
  snapshot_type:
    0:
      id: 'order_book'
      doc: 'Order Book'
    1:
      id: 'instrument_status'
      doc: 'Instrument Status'
    2:
      id: 'instrument'
      doc: 'Instrument'
    3:
      id: 'trades'
      doc: 'Trades'
    4:
      id: 'statistics'
      doc: 'Statistics'
    5:
      id: 'news'
      doc: 'News'
    8:
      id: 'top_of_book'
      doc: 'Top Of Book'
  trading_status:
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x54:
      id: 'regular_trading_or_start_trade_reporting'
      doc: 'Regular Trading Or Start Trade Reporting'
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
      id: 'volatility_auction_call'
      doc: 'Volatility Auction Call'
    0x45:
      id: 'end_of_day_volume_auction_call'
      doc: 'End Of Day Volume Auction Call'
    0x66:
      id: 're_opening_auction_call'
      doc: 'Re Opening Auction Call'
    0x6c:
      id: 'pause'
      doc: 'Pause'
    0x70:
      id: 'futures_close_out'
      doc: 'Futures Close Out'
    0x73:
      id: 'closing_price_cross'
      doc: 'Closing Price Cross'
    0x75:
      id: 'intra_day_auction_call'
      doc: 'Intra Day Auction Call'
    0x76:
      id: 'end_trade_reporting'
      doc: 'End Trade Reporting'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x79:
      id: 'start_of_trading'
      doc: 'Start Of Trading'
    0x7a:
      id: 'closing_price_publication'
      doc: 'Closing Price Publication'
    0x5a:
      id: 'fx_auction_call'
      doc: 'Fx Auction Call'
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
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x61:
      id: 'inactive'
      doc: 'Inactive'
  option_type:
    0x20:
      id: 'not_an_option'
      doc: 'Not An Option'
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
  settlement_method:
    0x20:
      id: 'no_settlement_method'
      doc: 'No Settlement Method'
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x50:
      id: 'physical'
      doc: 'Physical'
  exercise_style:
    0x20:
      id: 'not_an_option'
      doc: 'Not An Option'
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
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
    5:
      id: 'circuit_breaker_tripped'
      doc: 'Circuit Breaker Tripped'
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
    9:
      id: 'bulletin_board'
      doc: 'Bulletin Board'
    11:
      id: 'negotiated_trades'
      doc: 'Negotiated Trades'
    51:
      id: 'fx_auction'
      doc: 'Fx Auction'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  sub_book:
    1:
      id: 'regular'
      doc: 'Regular'
    2:
      id: 'off_book'
      doc: 'Off Book'
    9:
      id: 'bulletin_board'
      doc: 'Bulletin Board'
    11:
      id: 'negotiated_trades'
      doc: 'Negotiated Trades'
    51:
      id: 'fx_auction'
      doc: 'Fx Auction'
  book_level:
    0x30:
      id: 'market_by_order'
      doc: 'Market By Order'
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
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x41:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x45:
      id: 're_opening_auction'
      doc: 'Re Opening Auction'
    0x4b:
      id: 'intra_day_auction'
      doc: 'Intra Day Auction'
    0x4c:
      id: 'futures_close_out_auction'
      doc: 'Futures Close Out Auction'
    0x44:
      id: 'end_of_day_volume_auction_call'
      doc: 'End Of Day Volume Auction Call'
  action_type:
    0x43:
      id: 'cancelled_trade'
      doc: 'Cancelled Trade'
    0x4e:
      id: 'trade'
      doc: 'Trade'
  imbalance_direction:
    0x4f:
      id: 'insufficient_orders_for_auction'
      doc: 'Insufficient Orders For Auction'
  statistic_type:
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
  open_close_indicator:
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
    0x48:
      id: 'vwap'
      doc: 'Vwap'
    0x49:
      id: 'previous_close'
      doc: 'Previous Close'
    0x4a:
      id: 'zero'
      doc: 'Zero'
    0x4c:
      id: 'vwap_of_n_volume'
      doc: 'Vwap Of N Volume'
    0x55:
      id: 'best_bid'
      doc: 'Best Bid'
    0x56:
      id: 'best_offer'
      doc: 'Best Offer'
    0x59:
      id: 'reference_price'
      doc: 'Reference Price'
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
  action:
    0x31:
      id: 'update'
      doc: 'Update'
    0x32:
      id: 'delete_field'
      doc: 'Delete'

