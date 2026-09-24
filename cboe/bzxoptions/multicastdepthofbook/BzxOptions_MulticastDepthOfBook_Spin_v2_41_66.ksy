# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxOptions MulticastDepthOfBook Spin v2.41.66
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Spin
#   Version: 2.41.66
#   Date: 04/01/2026
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
  id: cboe_bzxoptions_multicastdepthofbook_spin_v2_41_66
  title: Cboe BzxOptions MulticastDepthOfBook Spin v2.41.66
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Options Multicast Depth Of Book Spin v2.41.66'
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
        doc: 'Spin is available which is current through this sequence number'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
            'message_type::instrument_definition_request_message': instrument_definition_request_message
            'message_type::instrument_definition_response_message': instrument_definition_response_message
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
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Cboe'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '(space filled)'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by Cboe'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'Number of Add Order messages which will be contained in this spin'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: instrument_count
        type: u4
        doc: 'Number of Symbol Mapping and Complex Instrument Definition messages (if applicable) which will be contained in this spin'
      - id: instrument_definition_response_status
        type: u1
        enum: instrument_definition_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject'
  time_message:
    seq:
      - id: time
        type: u4
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day, derived by converting the current Eastern wall clock time (HH:MM:SS) to seconds'
  unit_clear_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
  transaction_begin_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
  transaction_end_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
  add_order_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Add Flags bit field used in Add Order Long, Add Order Short, and Add Order Expanded messages'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: reserved_3
        type: b3
        doc: 'Bits 0-2 Reserved (Bit 0 set to 1)'
      - id: aon
        type: b1
        doc: 'Options only. 0 = Firm quote, 1 = AON (All or None)'
      - id: reserved_4
        type: b4
        doc: 'Reserved'
  add_order_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Add Flags bit field used in Add Order Long, Add Order Short, and Add Order Expanded messages'
  add_order_expanded_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Add Flags bit field used in Add Order Long, Add Order Short, and Add Order Expanded messages'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, the Executing Firm ID of firm attributed to this quote. Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer Indicator. Space means N/A on C2 Options'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional user specified value attributed to this quote. Space filled otherwise'
      - id: reserved_5
        size: 5
        doc: 'Reserved'
  order_executed_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of contracts executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition. See Options Trade Condition Codes'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of contracts executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of contracts remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition. See Options Trade Condition Codes'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_long
        type: u4
        doc: 'Number of contracts canceled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_short
        type: u2
        doc: 'Number of contracts canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order Long and Modify Order Short messages'
  modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: '0 = Order is not aggregated in the SIP quote, 1 = Order is aggregated in the SIP quote'
      - id: maintain_priority
        type: b1
        doc: '0 = Reset priority, 1 = Maintain priority'
      - id: reserved_6
        type: b6
        doc: 'Reserved'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order Long and Modify Order Short messages'
  delete_order_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Trade Condition. See Options Trade Condition Codes'
  trade_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Trade Condition. See Options Trade Condition Codes'
  trade_expanded_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Trade Condition. See Options Trade Condition Codes'
  trade_break_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  end_of_session_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
  auction_summary_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
      - id: contracts
        type: u4
        doc: 'Cumulative number of contracts executed during the auction or CMC matching'
  auction_notification_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
        doc: 'Cumulative number of contracts executed during the auction or CMC matching'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer Indicator. Space means N/A on C2 Options'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, the Executing Firm ID of firm attributed to this quote. Space filled otherwise'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
      - id: client_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optional user specified value attributed to this quote. Space filled otherwise'
  auction_cancel_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  auction_trade_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
        doc: 'Cumulative number of contracts executed during the auction or CMC matching'
  soq_strike_range_update_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
    0x01:
      id: 'login_message'
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'The Spin Image Available message is sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'The Spin Request message is used by a user''s process to request transmission of a spin of the unit''s order book. See Options Specific Symbol Processing for more complete details regarding Sequence specification as well as buffering requirements.'
    0x82:
      id: 'spin_response_message'
      doc: 'The Spin Response message is sent in response to a user''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'The Spin Finished message is sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request message was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the member''s copy of the book to make it current.'
    0x84:
      id: 'instrument_definition_request_message'
      doc: 'The Instrument Definition Request message is used by a user''s process to request transmission of this unit''s Symbol Mappings and Complex Instrument Definitions. Refer to Options Specific Symbol Processing for more complete details regarding Sequence specification as well as buffering requirements.'
    0x85:
      id: 'instrument_definition_response_message'
      doc: 'The Instrument Definition Response message is sent in response to a user''s Instrument Definition Request message indicating whether a spin will be sent.'
    0x86:
      id: 'instrument_definition_finished_message'
      doc: 'The Instrument Definition Finished message is sent to indicate that all Symbol Mapping and Complex Instrument Definition messages for this unit have been sent. An Instrument Definition Finished message is only sent if an Instrument Definition Request message was not rejected.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit. The Time field is the number of seconds relative to midnight Eastern Time.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day. It would also be distributed in certain recovery events such as a data center fail-over.'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block.'
    0xbd:
      id: 'transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order Id assigned by Cboe to the order.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. The Short variant is used when the price can be represented by a Binary Short Price and the quantity by an unsigned 16-bit integer.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. The Expanded variant accommodates larger symbol sizes possible through the ISRA plan and includes additional attribution fields.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part. The execution will always be at the displayed price of the resting order.'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced. The Short variant is used when the canceled quantity can be represented by an unsigned 16-bit integer.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. The Short variant is used when the price can be represented by a Binary Short Price and the quantity by an unsigned 16-bit integer.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. The Short variant is used when the price can be represented by a Binary Short Price and the quantity by an unsigned 16-bit integer.'
    0x30:
      id: 'trade_expanded_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. The Expanded variant accommodates larger symbol sizes possible through the ISRA plan.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken. Trade breaks are rare, but can occur in the event of an erroneous execution.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down for the trading day. This message is used as the signal that processing for the day is complete.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced and are sent continuously through the day at variable rates as bandwidth allows.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of an options contract. A Trading Status message will be sent whenever a security''s trading status changes. The Trading Status field will be used to represent the status of the RTH (9:30 a.m. ET - 4:15 p.m. ET) and Curb sessions. The GTH Trading Status field will be used to represent the status of series that trade during the GTH session. The GTH session runs from 8:15 p.m. to 9:25 a.m. ET for GTH-eligible Products (C1 only).'
    0xd2:
      id: 'width_update_message'
      doc: 'The Width Update message is used to communicate opening quote width multiplier. This message will be sent in the event that the exchange decides to change the quote width multiplier on a per underlying basis.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information and Composite Market bid and offer prices during Opening and Re-Opening (halt) auctions on the Cboe Options Exchange.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction, including Opening and Re-Opening on the Cboe Options Exchange.'
    0xad:
      id: 'auction_notification_message'
      doc: 'C1 and EDGX Options Only. Auction Notification messages are used to disseminate order details of an auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'C1 and EDGX Options Only. Auction Cancel messages are used to disseminate the cancelation of an earlier Auction Notification message.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'C1 and EDGX Options Only. Auction Trade messages are used to disseminate executions resulting from an options auction.'
    0x9d:
      id: 'soq_strike_range_update_message'
      doc: 'C1 Only. The SOQ Strike Range Update message disseminates the minimum and maximum strike prices of the strike price range used to calculate the Special Opening Quote (SOQ) on a Volatility Settlement date.'
    0x9e:
      id: 'constituent_symbol_mapping_message'
      doc: 'C1 Only. The Constituent Symbol Mapping message is used to communicate which options series are Constituent Series in a Volatility Settlement Special Opening Quote (SOQ).'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  spin_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_requested_is_greater_than_sequence_available_by_the_next_spin'
      doc: 'Out Of Range Sequence Requested Is Greater Than Sequence Available By The Next Spin'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  instrument_definition_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_must_be_0'
      doc: 'Out Of Range Sequence Must Be 0'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
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
      id: 'curb_trading_c_1_only'
      doc: 'Curb Trading C 1 Only'
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
    0x4f:
      id: 'opening_auction_c_1_only'
      doc: 'Opening Auction C 1 Only'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x47:
      id: 'gth_opening_c_1_only'
      doc: 'Gth Opening C 1 Only'
    0x48:
      id: 'halt_auction_or_halt_re_opening'
      doc: 'Halt Auction Or Halt Re Opening'
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
    0x4d:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'
    0x56:
      id: 'volatility_auction_or_volatility_opening'
      doc: 'Volatility Auction Or Volatility Opening'
    0x50:
      id: 'periodic_auction_byx_only'
      doc: 'Periodic Auction Byx Only'
    0x42:
      id: 'bats_auction_mechanism_bam_edgx_only_or_aim_c_1_only'
      doc: 'Bats Auction Mechanism Bam Edgx Only Or Aim C 1 Only'
    0x53:
      id: 'solicitation_auction_mechanism_c_1_only'
      doc: 'Solicitation Auction Mechanism C 1 Only'
    0x54:
      id: 'step_up_mechanism_sum'
      doc: 'Step Up Mechanism Sum'
    0x41:
      id: 'sum_all_or_none'
      doc: 'Sum All Or None'
  opening_condition:
    0x4f:
      id: 'would_open'
      doc: 'Would Open'
    0x51:
      id: 'need_quote_to_open'
      doc: 'Need Quote To Open'
    0x42:
      id: 'need_more_buyers_c_1_only'
      doc: 'Need More Buyers C 1 Only'
    0x53:
      id: 'need_more_sellers_c_1_only'
      doc: 'Need More Sellers C 1 Only'
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

