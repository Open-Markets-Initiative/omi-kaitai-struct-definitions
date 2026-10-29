# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxeEquities MulticastDepthOfBook Pitch v6.20
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 6.20
#   Date: 8/14/2017
#   Specification: BATS_Europe_MC_PITCH_Specification.pdf
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
  id: cboe_cxeequities_multicastdepthofbook_pitch_v6_20
  title: Cboe CxeEquities MulticastDepthOfBook Pitch v6.20
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe CXE Multicast Depth Of Book Pitch v6.20'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: packet_header
    type: packet_header_struct
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
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Message Count messages to follow'
      - id: message_count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::add_order_long_message': add_order_long_message
            'message_type::add_order_short_message': add_order_short_message
            'message_type::add_order_expanded_message': add_order_expanded_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_at_price_size_message': order_executed_at_price_size_message
            'message_type::reduce_size_long_message': reduce_size_long_message
            'message_type::reduce_size_short_message': reduce_size_short_message
            'message_type::modify_order_long_message': modify_order_long_message
            'message_type::modify_order_short_message': modify_order_short_message
            'message_type::delete_order_message': delete_order_message
            'message_type::trade_long_message': trade_long_message
            'message_type::trade_short_message': trade_short_message
            'message_type::trade_extended_message': trade_extended_message
            'message_type::trade_unknown_symbol_message': trade_unknown_symbol_message
            'message_type::end_of_session_message': end_of_session_message
            'message_type::trading_status_message': trading_status_message
            'message_type::statistics_message': statistics_message
            'message_type::auction_update_message': auction_update_message
            'message_type::auction_summary_message': auction_summary_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds from midnight London time. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  add_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  add_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares being added to the book (may be less than the number entered)'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  add_order_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributes this quote to a particular participant'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: si_quote
        type: b1
        doc: '‘SI Quote’ indicator. If set, indicates this Add represents an ”SI Quote”'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares
        type: u4
        doc: 'Number of shares executed'
      - id: execution_id
        type: u8
        doc: 'Bats generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break Message'
      - id: execution_flags
        type: execution_flags
        doc: 'Execution Flags'
  execution_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level 2'
      - id: ex_cum_dividend
        type: u1
        enum: ex_cum_dividend
        doc: 'MMT Level 3.6'
      - id: algorithmic_trade
        type: u1
        enum: algorithmic_trade
        doc: 'MMT Level 3.9'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares
        type: u4
        doc: 'Number of shares executed'
      - id: remaining_shares
        type: u4
        doc: 'Number of shares remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Bats generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break Message'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_flags
        type: execution_flags
        doc: 'Execution Flags'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: cancelled_shares_long
        type: u4
        doc: 'Number of shares cancelled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: cancelled_shares_short
        type: u2
        doc: 'Number of shares cancelled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify (may be less than the number of shares entered)'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: shares_short
        type: u2
        doc: 'Number of shares associated with this order after this modify (may be less than the number of shares entered)'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  delete_order_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order S = Sell Order'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify (may be less than the number of shares entered)'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Bats generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break Message'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
  trade_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level 2'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'MMT Level 3.1'
      - id: benchmark_reference_price_indicator
        type: u1
        enum: benchmark_reference_price_indicator
        doc: 'MMT Level 3.5'
      - id: algorithmic_trade
        type: u1
        enum: algorithmic_trade
        doc: 'MMT Level 3.9'
  trade_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order S = Sell Order'
      - id: shares_short
        type: u2
        doc: 'Number of shares associated with this order after this modify (may be less than the number of shares entered)'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Bats generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break Message'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
  trade_extended_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: shares_extended
        type: u8
        doc: 'Number of shares executed'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Bats generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_timestamp
        type: u8
        doc: 'Date/Time on which the trade occurred, encoded as the number of nanoseconds since the January 1st 1970 UTC (also known as the Unix epoch)'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable. This will contain the MIC representing the venue on which the trade occurred, where applicable. e.g. for Bats NT trades, this shall be BATE or CHIX as applicable. This will contain SINT if the trade occurred on a Systematic Internaliser or XOFF if OTC. Bats LIS trades have the value LISX'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: bats_trade_timing_indicator
        type: u1
        enum: bats_trade_timing_indicator
        doc: '‘1’ The trade was reported to Bats ‘late’, ‘2’ The trade was reported to Bats out of the Main Session, ‘3’The trade was reported to Bats late and out of the Main Session ‘-’ otherwise. NOTE:2and3are not valid values on the Trade Reporting Facility'
      - id: extended_trade_flags
        type: extended_trade_flags
        doc: 'Extended Trade Flags'
  extended_trade_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level 2'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'MMT Level 3.1'
      - id: negotiated_trade
        type: u1
        enum: negotiated_trade
        doc: 'MMT Level 3.2'
      - id: crossing_trade
        type: u1
        enum: crossing_trade
        doc: 'MMT Level 3.3'
      - id: modification_indicator
        type: u1
        enum: modification_indicator
        doc: 'MMT Level 3.4'
      - id: benchmark_reference_price_indicator
        type: u1
        enum: benchmark_reference_price_indicator
        doc: 'MMT Level 3.5'
      - id: special_dividend
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MMT Level 3.6'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'MMT Level 3.7'
      - id: price_formation_discovery_process
        type: u1
        enum: price_formation_discovery_process
        doc: 'MMT Level 3.8'
      - id: algorithmic_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MMT Level 3.9'
      - id: publication_mode_deferral_reason
        type: u1
        enum: publication_mode_deferral_reason
        doc: 'MMT Level 4.1'
      - id: deferral_or_enrichement_type
        type: u1
        enum: deferral_or_enrichement_type
        doc: 'MMT Level 4.2'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'MMT Level 5'
  trade_unknown_symbol_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: shares_extended
        type: u8
        doc: 'Number of shares executed'
      - id: symbol_long
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol in ISIN'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Bats generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_timestamp
        type: u8
        doc: 'Date/Time on which the trade occurred, encoded as the number of nanoseconds since the January 1st 1970 UTC (also known as the Unix epoch)'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable. This will contain the MIC representing the venue on which the trade occurred, where applicable. e.g. for Bats NT trades, this shall be BATE or CHIX as applicable. This will contain SINT if the trade occurred on a Systematic Internaliser or XOFF if OTC. Bats LIS trades have the value LISX'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: bats_trade_timing_indicator
        type: u1
        enum: bats_trade_timing_indicator
        doc: '‘1’ The trade was reported to Bats ‘late’, ‘2’ The trade was reported to Bats out of the Main Session, ‘3’The trade was reported to Bats late and out of the Main Session ‘-’ otherwise. NOTE:2and3are not valid values on the Trade Reporting Facility'
      - id: extended_trade_flags
        type: extended_trade_flags
        doc: 'Extended Trade Flags'
  end_of_session_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: status
        type: u1
        enum: status
        doc: 'T = Trading R = Off-Book Reporting C = Closed S = Suspension N = No Reference Price V = Volatility Interruption O = Opening Auction E = Closing Auction H = Halt M = Market Order Imbalance Extension P = Price Monitoring Extension'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  statistics_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: statistic_type
        type: u1
        enum: statistic_type
        doc: 'C = Closing Price H = High Price L = Low Price O = Opening Price P = Previous Closing Price'
      - id: price_determination
        type: u1
        enum: price_determination
        doc: '0 = Normal 1 = Manual (Price override by Market Supervision)'
  auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Opening Auction C = Closing Auction H = Halt Auction V = Volatility Auction P = Periodic Auction'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Reference price used in tie-breaker situations. Implied decimal with scale 1e-4'
      - id: indicative_price
        type: decimal_u8_4
        doc: 'Price at which the auction would match if executed at the time of the message. Implied decimal with scale 1e-4'
      - id: indicative_shares
        type: u4
        doc: 'Number of shares at the Indicative Price'
      - id: outside_tolerance
        type: u1
        enum: outside_tolerance
        doc: 'Indicates whether the price on this update is outside the Bats EBBO collar: O = Outside tolerance I = Inside tolerance - = Not specified'
      - id: includes_primary
        type: u1
        enum: includes_primary
        doc: 'Indicates whether the Bats EBBO used to collar this update includes the Primary Market quotes: P = Includes Primary N = Excludes Primary - = Not specified'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Opening Auction C = Closing Auction H = Halt Auction V = Volatility Auction P = Periodic Auction'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify (may be less than the number of shares entered)'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'Time'
    0x97:
      id: 'unit_clear_message'
      doc: 'Unit Clear'
    0x40:
      id: 'add_order_long_message'
      doc: 'Add Order — Long'
    0x22:
      id: 'add_order_short_message'
      doc: 'Add Order — Short'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'Add Order — Expanded'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size — Long'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size — Short'
    0x27:
      id: 'modify_order_long_message'
      doc: 'Modify Order — Long'
    0x28:
      id: 'modify_order_short_message'
      doc: 'Modify Order — Short'
    0x29:
      id: 'delete_order_message'
      doc: 'Delete Order'
    0x41:
      id: 'trade_long_message'
      doc: 'Trade — Long'
    0x2b:
      id: 'trade_short_message'
      doc: 'Trade — Short'
    0x32:
      id: 'trade_extended_message'
      doc: 'Trade — Extended'
    0x35:
      id: 'trade_unknown_symbol_message'
      doc: 'Trade — Unknown Symbol'
    0x2d:
      id: 'end_of_session_message'
      doc: 'End of Session'
    0x31:
      id: 'trading_status_message'
      doc: 'Trading Status'
    0x34:
      id: 'statistics_message'
      doc: 'Statistics Message'
    0xac:
      id: 'auction_update_message'
      doc: 'Auction Update Message'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary Message'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  market_mechanism:
    0x31:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x32:
      id: 'quote_driven_market'
      doc: 'Quote Driven Market'
    0x33:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x34:
      id: 'off_book'
      doc: 'Off Book'
    0x35:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x36:
      id: 'request_for_quotes_7_any_other_including_hybrid'
      doc: 'Request For Quotes 7 Any Other Including Hybrid'
  trading_mode:
    0x31:
      id: 'undefined_auction'
      doc: 'Undefined Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
    0x34:
      id: 'out_of_main_session'
      doc: 'Out Of Main Session'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'Trade Reporting On Exchange'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'Trade Reporting Off Exchange'
    0x37:
      id: 'trade_reporting_systematic_internalizer'
      doc: 'Trade Reporting Systematic Internalizer'
    0x4f:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    0x4b:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
  ex_cum_dividend:
    0x45:
      id: 'ex_cum_special_dividend_if_optionally_set_by_reporting_party'
      doc: 'Ex Cum Special Dividend If Optionally Set By Reporting Party'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  algorithmic_trade:
    0x48:
      id: 'algorithmic_trade'
      doc: 'Algorithmic Trade'
    0x2d:
      id: 'non_algorithmic_trade'
      doc: 'Non Algorithmic Trade'
  transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x52:
      id: 'trade_that_has_received_price_improvement'
      doc: 'Trade That Has Received Price Improvement'
    0x5a:
      id: 'packaged_trade'
      doc: 'Packaged Trade'
    0x59:
      id: 'exchange_for_physicals_trade'
      doc: 'Exchange For Physicals Trade'
    0x2d:
      id: 'none_of_the_above_apply'
      doc: 'None Of The Above Apply'
  benchmark_reference_price_indicator:
    0x42:
      id: 'benchmark_trade_if_optionally_set_by_reporting_party'
      doc: 'Benchmark Trade If Optionally Set By Reporting Party'
    0x53:
      id: 'reference_price_trade'
      doc: 'Reference Price Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  bats_trade_timing_indicator:
    0x31:
      id: 'the_trade_was_reported_to_bats_late'
      doc: 'The Trade Was Reported To Bats Late'
    0x32:
      id: 'the_trade_was_reported_to_bats_out_of_the_main_session'
      doc: 'The Trade Was Reported To Bats Out Of The Main Session'
    0x33:
      id: 'the_trade_was_reported_to_bats_late_and_out_of_the_main_session'
      doc: 'The Trade Was Reported To Bats Late And Out Of The Main Session'
    0x2d:
      id: 'otherwise_note_2and_3are_not_valid_values_on_the_trade_reporting_facility'
      doc: 'Otherwise Note 2and 3are Not Valid Values On The Trade Reporting Facility'
  negotiated_trade:
    0x31:
      id: 'negotiated_trade_in_liquid_financial_instruments'
      doc: 'Negotiated Trade In Liquid Financial Instruments'
    0x32:
      id: 'negotiated_trade_in_illiquid_financial_instruments'
      doc: 'Negotiated Trade In Illiquid Financial Instruments'
    0x33:
      id: 'negotiated_trade_subject_to_conditions_other_than_the_current_market_price'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price'
    0x4e:
      id: 'negotiated_trade_where_none_of_the_above_apply'
      doc: 'Negotiated Trade Where None Of The Above Apply'
    0x34:
      id: 'pre_trade_transparency_waiver_for_illiquid_instrument_on_an_si'
      doc: 'Pre Trade Transparency Waiver For Illiquid Instrument On An Si'
    0x35:
      id: 'pre_trade_transparency_waiver_for_above_standard_market_size_on_an_si_6_pre_trade_transparency_waivers_for_illiquid_instrument_on_an_si_and_above_standard_market_size_on_an_si'
      doc: 'Pre Trade Transparency Waiver For Above Standard Market Size On An Si 6 Pre Trade Transparency Waivers For Illiquid Instrument On An Si And Above Standard Market Size On An Si'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  crossing_trade:
    0x58:
      id: 'crossing_trade'
      doc: 'Crossing Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  modification_indicator:
    0x41:
      id: 'indicates_a_modification_of_a_previously_reported_trade'
      doc: 'Indicates A Modification Of A Previously Reported Trade'
    0x43:
      id: 'indicates_a_cancellation_of_a_previously_reported_trade'
      doc: 'Indicates A Cancellation Of A Previously Reported Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  off_book_automated_indicator:
    0x51:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  price_formation_discovery_process:
    0x50:
      id: 'standard_trade_for_the_specified_market_mechanism_or_trading_mode'
      doc: 'Standard Trade For The Specified Market Mechanism Or Trading Mode'
    0x54:
      id: 'non_price_forming_trade_formerly_known_as_technical_trade'
      doc: 'Non Price Forming Trade Formerly Known As Technical Trade'
    0x4a:
      id: 'trade_not_contributing_to_price_discovery_process_formerly_technical_trade_n_price_is_currently_not_available_but_pending'
      doc: 'Trade Not Contributing To Price Discovery Process Formerly Technical Trade N Price Is Currently Not Available But Pending'
  publication_mode_deferral_reason:
    0x31:
      id: 'trade_report_reported_late_without_permitted_deferral'
      doc: 'Trade Report Reported Late Without Permitted Deferral'
    0x32:
      id: 'deferral_trade_for_large_in_scale'
      doc: 'Deferral Trade For Large In Scale'
    0x33:
      id: 'deferral_trade_for_illiquid_instrument'
      doc: 'Deferral Trade For Illiquid Instrument'
    0x34:
      id: 'deferral_trade_for_size_specific_5_deferral_trade_for_illiquid_instrument_and_size_specific_6_deferral_trade_for_illiquid_instrument_and_large_in_scale'
      doc: 'Deferral Trade For Size Specific 5 Deferral Trade For Illiquid Instrument And Size Specific 6 Deferral Trade For Illiquid Instrument And Large In Scale'
    0x2d:
      id: 'not_specified_immediate_publication'
      doc: 'Not Specified Immediate Publication'
  deferral_or_enrichement_type:
    0x31:
      id: 'limited_details_trade'
      doc: 'Limited Details Trade'
    0x32:
      id: 'daily_aggregated_trade'
      doc: 'Daily Aggregated Trade'
    0x33:
      id: 'volume_omission_trade'
      doc: 'Volume Omission Trade'
    0x34:
      id: 'four_weeks_aggregation_trade'
      doc: 'Four Weeks Aggregation Trade'
    0x35:
      id: 'indefinite_aggregation_trade'
      doc: 'Indefinite Aggregation Trade'
    0x36:
      id: 'volume_omission_trade_eligible_for_subsequent_enrichment_in_aggregated_form'
      doc: 'Volume Omission Trade Eligible For Subsequent Enrichment In Aggregated Form'
    0x37:
      id: 'full_details_of_earlier_limited_details_trade'
      doc: 'Full Details Of Earlier Limited Details Trade'
    0x38:
      id: 'full_details_of_earlier_daily_aggregated_trade'
      doc: 'Full Details Of Earlier Daily Aggregated Trade'
    0x39:
      id: 'full_details_of_earlier_volume_omission_trade'
      doc: 'Full Details Of Earlier Volume Omission Trade'
    0x56:
      id: 'full_details_of_four_weeks_aggregation_trade'
      doc: 'Full Details Of Four Weeks Aggregation Trade'
    0x57:
      id: 'full_details_of_earlier_volume_omission_trade_eligible_for_subsequent_enrichment_in_aggregated_form'
      doc: 'Full Details Of Earlier Volume Omission Trade Eligible For Subsequent Enrichment In Aggregated Form'
    0x2d:
      id: 'not_applicable'
      doc: 'Not Applicable'
  duplicative_indicator:
    0x31:
      id: 'duplicative_trade_report'
      doc: 'Duplicative Trade Report'
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique Trade Report'
  status:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x52:
      id: 'off_book_reporting'
      doc: 'Off Book Reporting'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x53:
      id: 'suspension'
      doc: 'Suspension'
    0x4e:
      id: 'no_reference_price'
      doc: 'No Reference Price'
    0x56:
      id: 'volatility_interruption'
      doc: 'Volatility Interruption'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x45:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x4d:
      id: 'market_order_imbalance_extension'
      doc: 'Market Order Imbalance Extension'
    0x50:
      id: 'price_monitoring_extension'
      doc: 'Price Monitoring Extension'
  statistic_type:
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
    0x48:
      id: 'high_price'
      doc: 'High Price'
    0x4c:
      id: 'low_price'
      doc: 'Low Price'
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x50:
      id: 'previous_closing_price'
      doc: 'Previous Closing Price'
  price_determination:
    0x30:
      id: 'normal'
      doc: 'Normal'
    0x31:
      id: 'manual_price_override_by_market_supervision'
      doc: 'Manual Price Override By Market Supervision'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x56:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  outside_tolerance:
    0x4f:
      id: 'outside_tolerance'
      doc: 'Outside Tolerance'
    0x49:
      id: 'inside_tolerance'
      doc: 'Inside Tolerance'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  includes_primary:
    0x50:
      id: 'includes_primary'
      doc: 'Includes Primary'
    0x4e:
      id: 'excludes_primary'
      doc: 'Excludes Primary'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'

