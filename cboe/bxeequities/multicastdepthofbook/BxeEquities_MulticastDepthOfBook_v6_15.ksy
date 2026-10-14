# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities MulticastDepthOfBook Pitch v6.15
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 6.15
#   Date: 9/14/2016
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
  id: cboe_bxeequities_multicastdepthofbook_pitch_v6_15
  title: Cboe BxeEquities MulticastDepthOfBook Pitch v6.15
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe BXE Multicast Depth Of Book Pitch v6.15'
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
      - id: ex_cum_dividend
        type: u1
        enum: ex_cum_dividend
        doc: 'MMT Level 3.6'
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
        doc: 'The venue on which the trade executed, when applicable. This will contain the MIC representing the venue on which the trade occurred, where applicable. e.g. for Bats NT trades, this shall be BATE or CHIX as applicable. This will contain SINT if the trade occurred on a Systematic Internaliser or XOFF if OTC'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: extended_trade_flags
        type: extended_trade_flags
        doc: 'Extended Trade Flags'
  extended_trade_flags:
    seq:
      - id: bats_trade_timing_indicator
        type: u1
        enum: bats_trade_timing_indicator
        doc: 'MMT Level n/a'
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
      - id: benchmark_indicator
        type: u1
        enum: benchmark_indicator
        doc: 'MMT Level 3.5'
      - id: ex_cum_dividend
        type: u1
        enum: ex_cum_dividend
        doc: 'MMT Level 3.6'
      - id: publication_mode
        type: u1
        enum: publication_mode
        doc: 'MMT Level 4'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'MMT Level 3.7'
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
      id: 'ex_cum_dividend_if_optionally_set_by_reporting_party'
      doc: 'Ex Cum Dividend If Optionally Set By Reporting Party'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  transaction_category:
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x54:
      id: 'technical_trade'
      doc: 'Technical Trade'
    0x47:
      id: 'giveup_givein_trade'
      doc: 'Giveup Givein Trade'
    0x46:
      id: 'trade_with_conditions'
      doc: 'Trade With Conditions'
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
      id: 'otherwise_note_this_flag_is_not_defined_by_mmt'
      doc: 'Otherwise Note This Flag Is Not Defined By Mmt'
  negotiated_trade:
    0x4e:
      id: 'negotiated_trade'
      doc: 'Negotiated Trade'
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
  benchmark_indicator:
    0x42:
      id: 'benchmark_trade_if_optionally_set_by_reporting_party'
      doc: 'Benchmark Trade If Optionally Set By Reporting Party'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  publication_mode:
    0x31:
      id: 'trade_report_has_been_delayed_at_the_request_of_the_reporting_party'
      doc: 'Trade Report Has Been Delayed At The Request Of The Reporting Party'
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

