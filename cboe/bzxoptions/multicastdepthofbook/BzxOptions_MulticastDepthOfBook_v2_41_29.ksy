# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxOptions MulticastDepthOfBook Pitch v2.41.29
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 2.41.29
#   Date: 4/20/2022
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
  id: cboe_bzxoptions_multicastdepthofbook_pitch_v2_41_29
  title: Cboe BzxOptions MulticastDepthOfBook Pitch v2.41.29
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Options Multicast Depth Of Book Pitch v2.41.29'
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
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::transaction_begin': transaction_begin
            'message_type::transaction_end': transaction_end
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
            'message_type::end_of_session': end_of_session
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::trading_status_message': trading_status_message
            'message_type::width_update': width_update
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
        doc: 'Number of whole seconds from midnight Eastern Time. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_begin:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_end:
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
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
  add_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Order is displayed in the Cboe SIP quote'
      - id: reserved_bit_1
        type: b1
        doc: 'Reserved 1 Bit'
      - id: reserved_bit_2
        type: b1
        doc: 'Reserved 1 Bit'
      - id: aon
        type: b1
        doc: 'All or none'
      - id: reserved_flags
        type: b4
        doc: 'Reserved 4-7 Bits'
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
        doc: 'Order Side'
      - id: quantity_short
        type: u2
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
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
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified the Executing Broker of firm attributed to this quote'
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
        doc: 'Options Trade Condition Codes'
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
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Trade Condition Codes'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity
        type: u4
        doc: 'Instrument quantity canceled'
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
        doc: 'Instrument quantity canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: modify_order_flags
        type: modify_order_flags
        doc: 'Modify Order Flags'
  modify_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Order is displayed in the Cboe SIP quote'
      - id: priority
        type: b1
        doc: 'Maintain Priority'
      - id: modify_reserved_flags
        type: b6
        doc: 'Reserved 2-7 Bits'
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
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: modify_order_flags
        type: modify_order_flags
        doc: 'Modify Order Flags'
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
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Trade Condition Codes'
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
        doc: 'Order Side'
      - id: quantity_short
        type: u2
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Trade Condition Codes'
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
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Trade Condition Codes'
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  end_of_session:
    seq:
      - id: timestamp
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
        doc: 'Symbol Condition'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying right padded with spaces'
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
        doc: 'Symbol'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: reserved_3
        size: 3
        doc: 'Reserved'
  width_update:
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying right padded with spaces'
      - id: multiplier
        type: decimal_u4_1
        doc: 'Width multiplier. Implied decimal with scale 1e-1'
  auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: reference_price
        type: u8
        doc: 'Collared price at which the periodic auction would trade'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Opening Condition Values'
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
      - id: symbol_extended
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_summary_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Auction Opening Type'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_contracts
        type: u4
        doc: 'Cumulative number of shares/contracts executed during the auction or CMC match'
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
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header'
    0xbc:
      id: 'transaction_begin'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block.'
    0xbd:
      id: 'transaction_end'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. Expanded version accommodates larger symbol sizes possible through the ISRA plan.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever an open order is completely canceled. The Order Id refers to the Order Id of the original Add Order message.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0x30:
      id: 'trade_expanded_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken.'
    0x2d:
      id: 'end_of_session'
      doc: 'The End of Session message is sent for each unit when the unit shuts down'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A symbol mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a complex instrument.'
    0xd2:
      id: 'width_update'
      doc: 'The Width Update message is used to communicate opening quote width multiplier'
    0xd1:
      id: 'auction_update_message'
      doc: 'On the BYX Exchange, Auction Update messages will be sent out at a randomized time between the start of an auction period and the end of the auction period minus 1 millisecond to inform participants that a Periodic Auction is taking place'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction of a complex instrument. An Opening or Re-Opening Auction Summary message for each complex instrument is sent at the conclusion of its Opening or Re-Opening auction and represents Cboe opening price.'
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
  trade_condition:
    0x61:
      id: 'single_leg_auction_non_iso'
      doc: 'Single Leg Auction Non Iso'
    0x62:
      id: 'single_leg_auction_iso'
      doc: 'Single Leg Auction Iso'
    0x63:
      id: 'single_leg_cross_non_iso'
      doc: 'Single Leg Cross Non Iso'
    0x64:
      id: 'single_leg_cross_iso'
      doc: 'Single Leg Cross Iso'
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
    0x49:
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
  auction_type:
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
    0x56:
      id: 'volatility_opening'
      doc: 'Volatility Opening'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
    0x4d:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'

