# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C2Options MulticastDepthOfBook Pitch v2.41.80
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 2.41.80
#   Date: 09/17/2026
#   Specification: Unknown
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
  id: cboe_c2options_multicastdepthofbook_pitch_v2_41_80
  title: Cboe C2Options MulticastDepthOfBook Pitch v2.41.80
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C2 Options Multicast Depth Of Book Pitch v2.41.80'
doc-ref: http://markets.cboe.com/us/options/support/technical/

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
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
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
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
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
            'message_type::trade_expanded_message': trade_expanded_message
            'message_type::trade_break_message': trade_break_message
            'message_type::end_of_session_message': end_of_session_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::trading_status_message': trading_status_message
            'message_type::width_update_message': width_update_message
            'message_type::options_auction_update_message': options_auction_update_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::soq_strike_range_update_message': soq_strike_range_update_message
            'message_type::constituent_symbol_mapping_message': constituent_symbol_mapping_message
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
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day, derived by converting the current Eastern wall clock time (HH:MM:SS) to seconds. On Daylight Saving Time transition days, Time reflects wall clock seconds and does not adjust for the UTC offset change. On a DST spring-forward day, the maximum value will be 82,799 (23 hours). On a DST fall-back day, values between 3,600 and 7,199 will appear twice. Recipients requiring unambiguous absolute timestamps should use Epoch Time (where available) or Midnight Reference in the Time Reference message. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_begin_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_end_message:
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags bit field used in Add Order messages. Bit 3 indicates AON (All or None) status (Options only)'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_3
        type: b3
        doc: 'Bits 0-2 Reserved (Bit 0 set to 1)'
      - id: aon
        type: b1
        doc: 'Options only. 0 = Order is a firm quote, 1 = Order is AON (All or None)'
      - id: reserved_4
        type: b4
        doc: 'Bits 4-7 Reserved'
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags bit field used in Add Order messages. Bit 3 indicates AON (All or None) status (Options only)'
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: expanded_symbol
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
        doc: 'Add Flags bit field used in Add Order messages. Bit 3 indicates AON (All or None) status (Options only)'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, MPID (equities) or Executing Firm ID (options) of firm attributed to this quote. Alternatively "RTAL" for retail specified orders (equities). Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'BZX/C1/EDGX Options Only (space filled on C2 Options and all equities markets). N = Non-Customer, C = Customer, R = Retail Priority order (EDGX Equities only)'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Options Only. Optional user specified value attributed to this quote. Space filled otherwise'
      - id: reserved_5
        size: 5
        doc: 'Options Only. Reserved'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities). See Options Trade Condition Codes on page 180 section for details about new codes'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of shares/contracts remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities). See Options Trade Condition Codes on page 180 section for details about new codes'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_long
        type: u4
        doc: 'Number of shares/contracts canceled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_short
        type: u2
        doc: 'Number of shares/contracts canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order messages. Bit 0 indicates whether the order is aggregated in the Cboe SIP quote; Bit 1 indicates whether priority is maintained or reset'
  modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: '0 = Order is not aggregated in the Cboe SIP quote, 1 = Order is aggregated in the Cboe SIP quote'
      - id: maintain_priority
        type: b1
        doc: '0 = Reset Priority, 1 = Maintain Priority'
      - id: reserved_6
        type: b6
        doc: 'Bits 2-7 Reserved'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order messages. Bit 0 indicates whether the order is aggregated in the Cboe SIP quote; Bit 1 indicates whether priority is maintained or reset'
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities). See Options Trade Condition Codes on page 180 section for details about new codes'
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
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
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities). See Options Trade Condition Codes on page 180 section for details about new codes'
  trade_expanded_message:
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
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: expanded_symbol
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
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities). See Options Trade Condition Codes on page 180 section for details about new codes'
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  end_of_session_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'N = Normal, C = Closing Only'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'H = Halted, L = Curb Trading (C1 Only), Q = Quote-Only, R = Opening Rotation, T = RTH Trading'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        type: u1
        enum: gth_trading_status
        doc: 'C1 Only. H = Halted, Q = Quote-Only, R = Opening Rotation, T = Trading'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  width_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces'
      - id: width_type
        type: u1
        enum: width_type
        doc: 'R = Regular, V = Volatility'
      - id: multiplier
        type: decimal_u4_1
        doc: 'Width multiplier. Implied decimal with scale 1e-1'
  options_auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: expanded_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening, V = Volatility Opening'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Collared VMIM price computed on the queuing book only. Implied decimal with scale 1e-4'
      - id: buy_contracts
        type: u4
        doc: 'Cumulative Buy contracts at the Reference Price and above'
      - id: sell_contracts
        type: u4
        doc: 'Cumulative Sell contracts at the Reference Price and below'
      - id: indicative_price
        type: decimal_u8_4
        doc: 'Collared VMIM price computed on the combined queueing book and the continuous book. Equal to Reference Price for options that do not have a GTH trading session. Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_u8_4
        doc: 'Uncollared VMIM price computed on the queuing book only. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: u1
        enum: opening_condition
        doc: 'O = Would open, Q = Need quote to open, B = Need more buyers (C1 Only), S = Need more sellers (C1 Only), C = Crossed Composite Market'
      - id: composite_market_bid_price
        type: decimal_u8_4
        doc: 'Bid Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_u8_4
        doc: 'Offer Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening, V = Volatility Opening'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_contracts
        type: u4
        doc: 'Cumulative number of shares/contracts executed during the auction or CMC matching'
  auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'G = GTH Opening (C1 Only), O = RTH Opening (C1 Only), H = Halt Re-Opening, V = Volatility Opening'
      - id: side
        type: u1
        enum: side
        doc: 'B or S'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'BZX/C1/EDGX Options Only (space filled on C2 Options and all equities markets). N = Non-Customer, C = Customer, R = Retail Priority order (EDGX Equities only)'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, MPID (equities) or Executing Firm ID (options) of firm attributed to this quote. Alternatively "RTAL" for retail specified orders (equities). Space filled otherwise'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Options Only. Optional user specified value attributed to this quote. Space filled otherwise'
  auction_cancel_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  auction_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
  soq_strike_range_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: soq_identifier
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dissemination symbol of the final SOQ right padded with spaces'
      - id: lower_strike_price
        type: decimal_u8_4
        doc: 'SOQ lower strike price. Implied decimal with scale 1e-4'
      - id: upper_strike_price
        type: decimal_u8_4
        doc: 'SOQ upper strike price. Implied decimal with scale 1e-4'
  constituent_symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'N = Normal, C = Closing Only'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces'
      - id: soq_identifier
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dissemination symbol of the final SOQ right padded with spaces'
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
  decimal_u4_1:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. The Time field is the number of seconds relative to midnight Eastern Time. All subsequent time offset fields for the same unit will use the new Time message value as the base until another Time message is received for the same unit.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header message. For Equities only, this message will be sent at startup each day. It would also be distributed in certain recovery events such as a data center fail-over.'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'Options Only. The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block. All PITCH messages corresponding to such an event would be included between a Transaction Begin message and Transaction End message. It is important to note that transaction blocks are currently used in US Options for symbol state transitions only, but may be expanded to other use cases with notice. Transaction Begin messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0xbd:
      id: 'transaction_end_message'
      doc: 'Options Only. The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed. Transaction End messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order Id assigned by Cboe to the order.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order Id assigned by Cboe to the order.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'The expanded version of the Add Order message has been made available to accommodate larger symbol sizes possible through the ISRA plan.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part. The execution price equals the limit order price found in the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id. If the Remaining Quantity field contains a 0 the order should be completely removed from the book. Order Executed at Price/Size messages may also be sent in cases where the Executed Quantity is greater than the current booked size for Order Id due to Exchange features that allow a portion of an order to be hidden while another portion is displayed.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "No Ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book. The Order Id refers to the Order Id of the original Add Order message. An order that is deleted from the book may return to the book later under certain circumstances. Therefore, a Delete Order message does not indicate that a given Order Id will not be sent again on a subsequent Add Order message.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. In options a Trade message can also be sent when an auction executes against a non-displayed order, such as a contra response. Trade messages are necessary to calculate Cboe execution-based data. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book. The Order ID of a hidden order is obfuscated by default in the Trade message, but may be optionally disseminated for a member''s own orders upon request.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. The Short variant uses a Binary Short Price and 2-byte Quantity.'
    0x30:
      id: 'trade_expanded_message'
      doc: 'The expanded version of the Trade message has been made available to accommodate larger symbol sizes possible through the ISRA plan.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken. Trade breaks are rare and only affect applications that rely upon Cboe execution-based data. Applications that simply build a Cboe book can ignore Trade Break messages.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'Options Only. A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced (sequence = 0) and are sent continuously through the day at variable rates as bandwidth allows. Members who consume the 5 Gig or 8 Gig-Shaped Multicast PITCH feeds will be able to receive the full list of symbols in approximately 5 minutes.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security. A Trading Status message will be sent whenever a security''s trading status changes. The Trading Status field will be used to represent the status of the RTH (9:30 a.m. ET - 4:15 p.m. ET) and Curb sessions. The GTH Trading Status field will be used to represent the status of series that trade during the GTH session. The GTH session runs from 8:15 p.m. to 9:25 a.m. ET for GTH-eligible Products (C1 Options Only).'
    0xd2:
      id: 'width_update_message'
      doc: 'Options Only. The Width Update message is used to communicate opening quote width multiplier. This message will be sent in the event that the exchange decides to change the quote width multiplier on a per underlying basis. For complete details on the opening collars see the US Options Opening Process Specification.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Only. Options Auction Update messages are used to disseminate price and size information and Composite Market bid and offer prices during Opening and Re-Opening (halt) auctions on the Cboe Options Exchange. Options Auction Update messages are sent every five seconds during an opening period provided that one of the field values has changed. When no values have changed, a message is sent once every 60 seconds. Refer to the Cboe Options Opening Process specification for more information.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction of a Cboe listed security on BZX, the results of an Opening or Re-Opening of any options series on C1, and for Periodic Auctions on BYX. Auction Summary messages are also used in support of Opening and Re-Openings on the Cboe Options Exchange, including those for both GTH and RTH sessions. These messages indicate the price and size executed in such an Opening or Re-Opening.'
    0xad:
      id: 'auction_notification_message'
      doc: 'C1 and EDGX Options Only. Auction Notification messages are used to disseminate order details of an auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'C1 and EDGX Options Only. Auction Cancel messages are used to disseminate the cancelation of an earlier Auction Notification message as a result of a user cancelation of the original order, a user modification request to change the price or increase the original order quantity, a fading of the NBBO or to cancel any remaining order quantity from the original Auction Notification messages following the auction termination. A user request to modify the order price or to increase the original order quantity will result in a cancelation of the auction followed by a new Auction Notification message. Auction Cancel messages will not be issued for order quantity decrements.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'C1 and EDGX Options Only. Auction Trade messages are used to disseminate executions resulting from an options auction.'
    0x9d:
      id: 'soq_strike_range_update_message'
      doc: 'C1 Only. The SOQ Strike Range Update message is only available on the C1 Exchange. This message disseminates the minimum and maximum strike prices of the strike price range used to calculate the Special Opening Quote (SOQ) on a Volatility Settlement date. In the event that multiple distinct SOQ calculations occur on the same day, the applicable SOQ is differentiated by the SOQ Identifier field, which is set to the CSMi symbol on which the final settlement SOQ value is disseminated.'
    0x9e:
      id: 'constituent_symbol_mapping_message'
      doc: 'C1 Only. The Constituent Symbol Mapping message is only available on the C1 Exchange. This message is used to communicate which options series (if any) are Constituent Series in a Volatility Settlement Special Opening Quote (SOQ). The message is identical to the Symbol Mapping message with the addition of the SOQ Identifier field, which is set to the CSMi symbol on which the final settlement SOQ value is disseminated. The Constituent Symbol Mapping message is sent as an unsequenced message with one message sent for each Constituent Series in a continuous loop as bandwidth allows.'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  aon:
    0:
      id: 'order_is_a_firm_quote'
      doc: 'Order Is A Firm Quote'
    1:
      id: 'order_is_aon_all_or_none'
      doc: 'Order Is Aon All Or None'
  customer_indicator:
    0x4e:
      id: 'non_customer'
      doc: 'Non Customer'
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x52:
      id: 'retail_priority_order'
      doc: 'Retail Priority Order'
  trade_condition:
    0x61:
      id: 'single_leg_auction_non_iso_cboe_auction_types_include_aim_sam'
      doc: 'Single Leg Auction Non Iso Cboe Auction Types Include Aim Sam'
    0x62:
      id: 'single_leg_auction_iso_cboe_auction_types_are_aim_iso_sam_iso'
      doc: 'Single Leg Auction Iso Cboe Auction Types Are Aim Iso Sam Iso'
    0x63:
      id: 'single_leg_cross_non_iso_cboe_auction_types_include_cust_to_cust_aim_qcc'
      doc: 'Single Leg Cross Non Iso Cboe Auction Types Include Cust To Cust Aim Qcc'
    0x64:
      id: 'single_leg_cross_iso_cboe_order_type_is_cust_to_cust_aim_iso'
      doc: 'Single Leg Cross Iso Cboe Order Type Is Cust To Cust Aim Iso'
    0x65:
      id: 'single_leg_floor_trade'
      doc: 'Single Leg Floor Trade'
    0x66:
      id: 'complex_to_complex_electronic_trade'
      doc: 'Complex To Complex Electronic Trade'
    0x67:
      id: 'complex_auction_trade'
      doc: 'Complex Auction Trade'
    0x68:
      id: 'complex_cross'
      doc: 'Complex Cross'
    0x6a:
      id: 'complex_electronic_trade_against_single_legs'
      doc: 'Complex Electronic Trade Against Single Legs'
    0x6b:
      id: 'complex_with_stock_options_auction_trade'
      doc: 'Complex With Stock Options Auction Trade'
    0x6d:
      id: 'complex_floor_trade_against_single_legs'
      doc: 'Complex Floor Trade Against Single Legs'
    0x6e:
      id: 'complex_with_stock_electronic_trade'
      doc: 'Complex With Stock Electronic Trade'
    0x6f:
      id: 'complex_with_stock_cross'
      doc: 'Complex With Stock Cross'
    0x70:
      id: 'complex_with_stock_floor_trade'
      doc: 'Complex With Stock Floor Trade'
    0x74:
      id: 'complex_floor_trade_of_proprietary_products_marked_as_combo_order'
      doc: 'Complex Floor Trade Of Proprietary Products Marked As Combo Order'
    0x75:
      id: 'multilateral_compression_trade_of_proprietary_products'
      doc: 'Multilateral Compression Trade Of Proprietary Products'
    0x76:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x6c:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
    0x4b:
      id: 'cabinet_order'
      doc: 'Cabinet Order'
    0x4d:
      id: 'future_options_auction_trade_electronic_execution_of_a_multi_leg_futureoptions_order_traded_in_a_two_sided_auction'
      doc: 'Future Options Auction Trade Electronic Execution Of A Multi Leg Futureoptions Order Traded In A Two Sided Auction'
    0x4e:
      id: 'future_options_auto_electronic_trade_electronic_execution_of_a_multi_leg_futureoptions_order_traded_on_the_complex_book_or_in_a_coa'
      doc: 'Future Options Auto Electronic Trade Electronic Execution Of A Multi Leg Futureoptions Order Traded On The Complex Book Or In A Coa'
    0x50:
      id: 'future_options_cross_electronic_execution_of_a_multi_leg_futureoptions_order_traded_in_a_two_sided_crossing_mechanism_that_does_not_go_through_an_exposure_period'
      doc: 'Future Options Cross Electronic Execution Of A Multi Leg Futureoptions Order Traded In A Two Sided Crossing Mechanism That Does Not Go Through An Exposure Period'
    0x4f:
      id: 'opening_trade'
      doc: 'Opening Trade'
    0x53:
      id: 'iso'
      doc: 'Iso'
  display:
    0:
      id: 'order_is_not_aggregated_in_the_cboe_sip_quote'
      doc: 'Order Is Not Aggregated In The Cboe Sip Quote'
    1:
      id: 'order_is_aggregated_in_the_cboe_sip_quote'
      doc: 'Order Is Aggregated In The Cboe Sip Quote'
  maintain_priority:
    0:
      id: 'reset_priority'
      doc: 'Reset Priority'
    1:
      id: 'maintain_priority'
      doc: 'Maintain Priority'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4c:
      id: 'curb_trading'
      doc: 'Curb Trading'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x52:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    0x54:
      id: 'rth_trading'
      doc: 'Rth Trading'
  gth_trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x52:
      id: 'opening_rotation'
      doc: 'Opening Rotation'
    0x54:
      id: 'trading'
      doc: 'Trading'
  width_type:
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'volatility'
      doc: 'Volatility'
    0x51:
      id: 'max_quote_width'
      doc: 'Max Quote Width'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x48:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
    0x4d:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'
    0x56:
      id: 'volitility_auction'
      doc: 'Volitility Auction'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  opening_condition:
    0x4f:
      id: 'would_open'
      doc: 'Would Open'
    0x51:
      id: 'need_quote_to_open'
      doc: 'Need Quote To Open'
    0x42:
      id: 'need_more_buyers'
      doc: 'Need More Buyers'
    0x53:
      id: 'need_more_sellers'
      doc: 'Need More Sellers'
    0x43:
      id: 'crossed_composite_market'
      doc: 'Crossed Composite Market'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

