# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures MulticastDepthOfBook Pitch v1.2.19
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 1.2.19
#   Date: 1/5/2026
#   Specification: CBOE_FUTURES_EXCHANGE_MULTICAST_PITCH_SPECIFICATION.pdf
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
  id: cboe_cfefutures_multicastdepthofbook_pitch_v1_2_19
  title: Cboe CfeFutures MulticastDepthOfBook Pitch v1.2.19
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Multicast Depth Of Book Pitch v1.2.19'
doc-ref: http://markets.cboe.com/us/futures/support/technical

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
            'message_type::time_reference_message': time_reference_message
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::futures_instrument_definition_message': futures_instrument_definition_message
            'message_type::futures_variance_symbol_mapping_message': futures_variance_symbol_mapping_message
            'message_type::price_limits_message': price_limits_message
            'message_type::add_order_long_message': add_order_long_message
            'message_type::add_order_short_message': add_order_short_message
            'message_type::order_executed_message': order_executed_message
            'message_type::reduce_size_long_message': reduce_size_long_message
            'message_type::reduce_size_short_message': reduce_size_short_message
            'message_type::modify_order_long_message': modify_order_long_message
            'message_type::modify_order_short_message': modify_order_short_message
            'message_type::delete_order_message': delete_order_message
            'message_type::trade_long_message': trade_long_message
            'message_type::trade_short_message': trade_short_message
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
            'message_type::trade_break_message': trade_break_message
            'message_type::settlement_message': settlement_message
            'message_type::open_interest_message': open_interest_message
            'message_type::end_of_day_summary_message': end_of_day_summary_message
            'message_type::trading_status_message': trading_status_message
            'message_type::end_of_session_message': end_of_session_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_reference_message:
    seq:
      - id: midnight_reference
        type: second_timestamp
        doc: 'Midnight Central Time reference time for subsequent Time messages, expressed as number of whole seconds since the Epoch (Midnight January 1, 1970 UTC). Seconds since Unix epoch'
      - id: time_reference
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Central Time. Seconds since Midnight epoch'
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
  time_message:
    seq:
      - id: time_reference
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Central Time. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (Midnight January 1, 1970 UTC)'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  futures_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: unit_timestamp
        type: u4
        doc: 'Unit timestamp expressed as number of whole seconds since the Epoch (Midnight, January 1, 1970 UTC)'
      - id: report_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol for product or underlying security'
      - id: futures_flags
        type: futures_flags
        doc: 'Futures Flags bitfields'
      - id: expiration_date
        type: u4
        doc: 'Expiration Date of Instrument'
      - id: contract_size
        type: u2
        doc: 'Contract size of Instrument. Contract sizes less than 1 are represented with a 0 value; refer to the product specification for the contract size'
      - id: listing_state
        type: u1
        enum: listing_state
        doc: 'Listing State Values'
      - id: price_increment
        type: decimal_u8_4
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-4'
      - id: num_future_leg
        type: u1
        doc: 'Values greater than 0 indicate this is a spread instrument'
      - id: leg_offset
        type: u1
        doc: 'Leg definitions, if any, begin at this offset from the beginning of the message. Possible values are 0 (no legs present) or 45 (spread instrument)'
      - id: reserved_1
        type: u1
        doc: 'Reserved. Value will always be zero'
      - id: contract_date
        type: u4
        doc: 'Populated for single leg instruments only. Zero-filled for spread instruments. The date that should be used in describing the future''s third party symbol and the measurement period of the contract'
      - id: future_leg
        type: future_leg
        repeat: expr
        repeat-expr: num_future_leg
        doc: 'Future Leg'
  futures_flags:
    meta:
      bit-endian: le
    seq:
      - id: variance
        type: b1
        doc: 'Set for a Variance Future, clear for a Standard Future'
      - id: reserved_flags_7
        type: b7
        doc: 'Reserved 1-7 Bits'
  future_leg:
    seq:
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy, negative for sell)'
      - id: leg_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of leg'
  futures_variance_symbol_mapping_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: unit_timestamp
        type: u4
        doc: 'Unit timestamp expressed as number of whole seconds since the Epoch (Midnight, January 1, 1970 UTC)'
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: futures_symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Twelve character textual definition of the symbol where the first six characters contain the product symbol, left justified, and padded on the right with spaces, and the right most six characters are the expiration date in YYMMDD format'
      - id: accrued_day_variance
        type: decimal_s8_12
        doc: 'Accrued day variance as of the start of the trading day (signed 64-bit decimal with twelve implied decimal places). Implied decimal with scale 1e-12'
      - id: num_final_returns
        type: u2
        doc: 'Number of S&P 500 Index returns used in the Final Settlement Value calculation'
      - id: num_elapsed_returns
        type: u2
        doc: 'Number of elapsed S&P 500 Index returns including the current day'
  price_limits_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: upper_price_limit
        type: decimal_u8_4
        doc: 'Upper price limit. Implied decimal with scale 1e-4'
      - id: lower_price_limit
        type: decimal_u8_4
        doc: 'Lower price limit. Implied decimal with scale 1e-4'
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
        doc: 'Side Indicator Values'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
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
        doc: 'Side Indicator Values'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
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
        doc: 'Number of contracts executed'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Values'
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
        doc: 'Number of contracts canceled'
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
        doc: 'Number of contracts canceled'
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
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
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
        doc: 'Side Indicator Values'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Values'
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
        doc: 'Side Indicator Values'
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Values'
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
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  settlement_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: settlement_price
        type: decimal_u8_4
        doc: 'Settlement Price. Implied decimal with scale 1e-4'
      - id: issue
        type: u1
        enum: issue
        doc: 'Issue Values'
  open_interest_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: open_interest
        type: u4
        doc: 'Open Interest for this symbol'
  end_of_day_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: open_interest
        type: u4
        doc: 'Open Interest for this symbol'
      - id: high_price
        type: decimal_u8_4
        doc: 'The higher of highest bid price and highest trade price for the day. Block and ECRP trades (Trade Condition=B or E) do not update High Price. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'The lower of lowest offer price and lowest trade price for the day. Block and ECRP trades (Trade Condition=B or E) do not update Low Price. Implied decimal with scale 1e-4'
      - id: open_price
        type: decimal_u8_4
        doc: 'The first trade on the day (in any session) will set the Open Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition=B or E) do not update Open Price. Implied decimal with scale 1e-4'
      - id: close_price
        type: decimal_u8_4
        doc: 'The last trade on the day (in any session) will set the Close Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition=B or E) do not update Close Price. Implied decimal with scale 1e-4'
      - id: total_volume
        type: u4
        doc: 'Total number of contracts traded for the day, including block and ECRP trades'
      - id: block_volume
        type: u4
        doc: 'Total number of block and derived contracts traded for the day'
      - id: ecrp_volume
        type: u4
        doc: 'Total number of contracts traded for the day'
      - id: summary_flags
        type: summary_flags
        doc: 'Summary Flags bitfields'
  summary_flags:
    meta:
      bit-endian: le
    seq:
      - id: high_price_valid
        type: b1
        doc: 'Set if High Price is a valid value'
      - id: high_price_is_bid
        type: b1
        doc: 'Set if High Price was set by the highest bid (rather than a trade)'
      - id: low_price_valid
        type: b1
        doc: 'Set if Low Price is a valid value'
      - id: low_price_is_offer
        type: b1
        doc: 'Set if Low Price was set by the lowest offer (rather than a trade)'
      - id: open_close_valid
        type: b1
        doc: 'Set if both Open Price and Close Price fields contain valid values'
      - id: reserved_flags_3
        type: b3
        doc: 'Reserved 5-7 Bits'
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
        doc: 'Six character, base 62 symbol'
      - id: reserved_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status Values'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  end_of_session_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
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
  decimal_s8_12:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000000.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0xb1:
      id: 'time_reference_message'
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed. It is sent whenever the system starts up and when the system crosses a midnight boundary.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the CFE book in the unit specified in the Sequenced Unit Header message header.'
    0xbb:
      id: 'futures_instrument_definition_message'
      doc: 'The Futures Instrument Definition message can be sent as a sequenced message or an un-sequenced message. It is sent as a sequenced message when the system starts up at the beginning of a trading session or an the instrument is created or modified during a trading day.'
    0xfa:
      id: 'futures_variance_symbol_mapping_message'
      doc: 'The Futures Variance Symbol Mapping message is used to disseminate symbol reference data for S&P 500 Variance Futures (VA Futures) symbols.'
    0xbe:
      id: 'price_limits_message'
      doc: 'The Price Limits message is sent out at the start of a session for products subject to price limits per the contract specifications.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when an order on the CFE book is executed in whole or in part.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the CFE book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the CFE book is partially reduced.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions that occur off of the CFE book (such as ECRP/Block trades). Trade messages are necessary to calculate CFE execution data.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions that occur off of the CFE book (such as ECRP/Block trades). Trade messages are necessary to calculate CFE execution data.'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block.'
    0xbd:
      id: 'transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on CFE is broken.'
    0xb9:
      id: 'settlement_message'
      doc: 'Settlement messages are used to provide information concerning indicative, approved, or corrected daily and final settlement prices for CFE products.'
    0xd3:
      id: 'open_interest_message'
      doc: 'The Open Interest message is sent to communicate a symbol''s open interest, usually for the prior trading date.'
    0xba:
      id: 'end_of_day_summary_message'
      doc: 'The End of Day Summary message is sent immediately after trading ends for a symbol. No more Market Update messages will follow an End of Day Summary message for a particular symbol.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a Futures contract.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  listing_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x49:
      id: 'inactive'
      doc: 'Inactive'
    0x54:
      id: 'test'
      doc: 'Test'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  trade_condition:
    0x20:
      id: 'normal_trade'
      doc: 'Normal Trade'
    0x4f:
      id: 'opening_trade'
      doc: 'Opening Trade'
    0x53:
      id: 'spread_trade'
      doc: 'Spread Trade'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x45:
      id: 'ecrp_trade'
      doc: 'Ecrp Trade'
    0x44:
      id: 'derived'
      doc: 'Derived'
  issue:
    0x69:
      id: 'periodic_indicative_settlement'
      doc: 'Periodic Indicative Settlement'
    0x49:
      id: 'indicative_settlement'
      doc: 'Indicative Settlement'
    0x53:
      id: 'initial_settlement'
      doc: 'Initial Settlement'
    0x52:
      id: 'reissued_settlement'
      doc: 'Reissued Settlement'
  trading_status:
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x51:
      id: 'queuing'
      doc: 'Queuing'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x48:
      id: 'halted'
      doc: 'Halted'

