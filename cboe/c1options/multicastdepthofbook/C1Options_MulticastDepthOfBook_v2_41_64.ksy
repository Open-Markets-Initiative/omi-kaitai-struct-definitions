# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options MulticastDepthOfBook Pitch v2.41.64
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 2.41.64
#   Date: 01/12/2026
#   Specification: US_EQUITIES_OPTIONS_MULTICAST_PITCH_SPECIFICATION.pdf
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
  id: cboe_c1options_multicastdepthofbook_pitch_v2_41_64
  title: Cboe C1Options MulticastDepthOfBook Pitch v2.41.64
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Multicast Depth Of Book Pitch v2.41.64'
doc-ref: http://markets.cboe.com/us/options/support/technical

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
            'message_type::ox_time_reference_message': ox_time_reference_message
            'message_type::ox_time_message': ox_time_message
            'message_type::ox_unit_clear_message': ox_unit_clear_message
            'message_type::ox_transaction_begin_message': ox_transaction_begin_message
            'message_type::ox_transaction_end_message': ox_transaction_end_message
            'message_type::ox_add_order_long_message': ox_add_order_long_message
            'message_type::ox_add_order_short_message': ox_add_order_short_message
            'message_type::ox_add_order_expanded_message': ox_add_order_expanded_message
            'message_type::ox_order_executed_message': ox_order_executed_message
            'message_type::ox_order_executed_at_price_size_message': ox_order_executed_at_price_size_message
            'message_type::ox_reduce_size_long_message': ox_reduce_size_long_message
            'message_type::ox_reduce_size_short_message': ox_reduce_size_short_message
            'message_type::ox_modify_order_long_message': ox_modify_order_long_message
            'message_type::ox_modify_order_short_message': ox_modify_order_short_message
            'message_type::ox_delete_order_message': ox_delete_order_message
            'message_type::ox_trade_long_message': ox_trade_long_message
            'message_type::ox_trade_short_message': ox_trade_short_message
            'message_type::ox_trade_expanded_message': ox_trade_expanded_message
            'message_type::ox_trade_break_message': ox_trade_break_message
            'message_type::ox_end_of_session': ox_end_of_session
            'message_type::ox_symbol_mapping_message': ox_symbol_mapping_message
            'message_type::ox_trading_status_message': ox_trading_status_message
            'message_type::ox_width_update_message': ox_width_update_message
            'message_type::ox_options_auction_update_message': ox_options_auction_update_message
            'message_type::ox_auction_summary_message': ox_auction_summary_message
            'message_type::ox_auction_notification_message': ox_auction_notification_message
            'message_type::ox_auction_cancel_message': ox_auction_cancel_message
            'message_type::ox_auction_trade_message': ox_auction_trade_message
            'message_type::ox_soq_strike_range_update_message': ox_soq_strike_range_update_message
            'message_type::ox_constituent_symbol_mapping_message': ox_constituent_symbol_mapping_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  ox_time_reference_message:
    seq:
      - id: midnight_reference
        type: second_timestamp
        doc: 'Midnight Eastern Time reference time for subsequent Time messages, expressed as number of whole seconds since the Epoch (Midnight January 1, 1970 UTC). Seconds since Unix epoch'
      - id: time_reference
        type: u4
        doc: 'Number of whole seconds from midnight Eastern time'
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
  ox_time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Eastern Time. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'C1 Options Only. Number of whole seconds since the Epoch (midnight January 1, 1970 UTC)'
  ox_unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  ox_transaction_begin_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  ox_transaction_end_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  ox_add_order_long_message:
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
        doc: 'Order Side'
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
        doc: 'Add Flags'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_3
        type: b3
        doc: 'Reserved Bits 0-2'
      - id: aon
        type: b1
        doc: 'Options Only. 0 = Order is a firm quote, 1 = Order is AON (All or None)'
      - id: reserved_4
        type: b4
        doc: 'Reserved Bits 4-7'
  ox_add_order_short_message:
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
        doc: 'Order Side'
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
        doc: 'Add Flags'
  ox_add_order_expanded_message:
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
        doc: 'Order Side'
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
        doc: 'Add Flags'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified the Executing Firm ID of firm attributed to this quote. Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer Indicator'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional user specified value attributed to this quote. Space filled otherwise'
      - id: reserved_5
        size: 5
        doc: 'Reserved'
  ox_order_executed_message:
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade Condition'
  ox_order_executed_at_price_size_message:
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade Condition'
  ox_reduce_size_long_message:
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
  ox_reduce_size_short_message:
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
  ox_modify_order_long_message:
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
        doc: 'Modify Flags'
  modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Order is displayed in the Cboe SIP quote'
      - id: priority
        type: b1
        doc: 'Maintain Priority'
      - id: reserved_flags
        type: b6
        doc: 'Reserved 2-7 Bits'
  ox_modify_order_short_message:
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
        doc: 'Modify Flags'
  ox_delete_order_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  ox_trade_long_message:
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
        doc: 'Order Side'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade Condition'
  ox_trade_short_message:
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
        doc: 'Order Side'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade Condition'
  ox_trade_expanded_message:
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
        doc: 'Order Side'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade Condition'
  ox_trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  ox_end_of_session:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  ox_symbol_mapping_message:
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
        doc: 'Symbol Condition'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying right padded with spaces'
  ox_trading_status_message:
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
        doc: 'Trading Status'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        type: u1
        enum: gth_trading_status
        doc: 'C1 Only. GTH Trading Status'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  ox_width_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying right padded with spaces'
      - id: width_type
        type: u1
        enum: width_type
        doc: 'Width Type'
      - id: multiplier
        type: decimal_u4_1
        doc: 'Width multiplier. Implied decimal with scale 1e-1'
  ox_options_auction_update_message:
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
        doc: 'Auction Type'
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
        doc: 'Collared VMIM price computed on the combined queuing book and the continuous book. Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_u8_4
        doc: 'Uncollared VMIM price computed on the queuing book only. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: u1
        enum: opening_condition
        doc: 'Opening Condition'
      - id: composite_market_bid_price
        type: decimal_u8_4
        doc: 'Bid Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_u8_4
        doc: 'Offer Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
  ox_auction_summary_message:
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
        doc: 'Auction Type'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_contracts
        type: u4
        doc: 'Cumulative number of shares/contracts executed during the auction or CMC matching'
  ox_auction_notification_message:
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
        doc: 'Auction Type'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
        doc: 'Customer Indicator'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified the Executing Firm ID of firm attributed to this quote. Space filled otherwise'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional user specified value attributed to this quote. Space filled otherwise'
  ox_auction_cancel_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  ox_auction_trade_message:
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
  ox_soq_strike_range_update_message:
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
  ox_constituent_symbol_mapping_message:
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
        doc: 'Symbol Condition'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying right padded with spaces'
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
    0xb1:
      id: 'ox_time_reference_message'
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed. It is sent whenever the system starts up and when the system crosses a midnight boundary.'
    0x20:
      id: 'ox_time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second'
    0x97:
      id: 'ox_unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header'
    0xbc:
      id: 'ox_transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block.'
    0xbd:
      id: 'ox_transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed.'
    0x21:
      id: 'ox_add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book'
    0x22:
      id: 'ox_add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book'
    0x2f:
      id: 'ox_add_order_expanded_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. Expanded version accommodates larger symbol sizes possible through the ISRA plan.'
    0x23:
      id: 'ox_order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part'
    0x24:
      id: 'ox_order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id'
    0x25:
      id: 'ox_reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced'
    0x26:
      id: 'ox_reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced'
    0x27:
      id: 'ox_modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x28:
      id: 'ox_modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'ox_delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book'
    0x2a:
      id: 'ox_trade_long_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers'
    0x2b:
      id: 'ox_trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers'
    0x30:
      id: 'ox_trade_expanded_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. Expanded version accommodates larger symbol sizes possible through the ISRA plan.'
    0x2c:
      id: 'ox_trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken'
    0x2d:
      id: 'ox_end_of_session'
      doc: 'The End of Session message is sent for each unit when the unit shuts down'
    0x2e:
      id: 'ox_symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced and are sent continuously through the day at variable rates as bandwidth allows.'
    0x31:
      id: 'ox_trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security'
    0xd2:
      id: 'ox_width_update_message'
      doc: 'The Width Update message is used to communicate opening quote width multiplier. This message will be sent in the event that the exchange decides to change the quote width multiplier on a per underlying basis.'
    0xd1:
      id: 'ox_options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information and Composite Market bid and offer prices during Opening and Re-Opening (halt) auctions on the Cboe Options Exchange.'
    0x96:
      id: 'ox_auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction, including Opening and Re-Opening on the Cboe Options Exchange'
    0xad:
      id: 'ox_auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of an auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'ox_auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancelation of an earlier Auction Notification message.'
    0xaf:
      id: 'ox_auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from an options auction.'
    0x9d:
      id: 'ox_soq_strike_range_update_message'
      doc: 'The SOQ Strike Range Update message is only available on the C1 Exchange. This message disseminates the minimum and maximum strike prices of the strike price range used to calculate the Special Opening Quote (SOQ) on a Volatility Settlement date.'
    0x9e:
      id: 'ox_constituent_symbol_mapping_message'
      doc: 'The Constituent Symbol Mapping message is only available on the C1 Exchange. This message is used to communicate which options series are Constituent Series in a Volatility Settlement Special Opening Quote (SOQ).'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  customer_indicator:
    0x4e:
      id: 'non_customer'
      doc: 'Non Customer'
    0x43:
      id: 'customer'
      doc: 'Customer'
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
  auction_type:
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
    0x56:
      id: 'volatility_opening'
      doc: 'Volatility Opening'
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

