# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures MulticastDepthOfBook Pitch v1.1.12
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 1.1.12
#   Date: 1/12/2021
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
  id: cboe_cfefutures_multicastdepthofbook_pitch_v1_1_12
  title: Cboe CfeFutures MulticastDepthOfBook Pitch v1.1.12
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Multicast Depth Of Book Pitch v1.1.12'
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
            'message_type::transaction_begin': transaction_begin
            'message_type::transaction_end': transaction_end
            'message_type::trade_break_message': trade_break_message
            'message_type::settlement_message': settlement_message
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
      - id: epoch
        type: u4
        doc: 'Number of whole seconds Since Epoch: 1.1.1970'
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
        type: u1
        enum: futures_flags
        doc: 'Bit 0 – Variance (1: Variance Future, 0: Standard Future)'
      - id: expiration_date
        type: u4
        doc: 'Expiration Date of Instrument'
      - id: contract_size
        type: u2
        doc: 'Contract size of Instrument'
      - id: listing_state
        type: u1
        enum: listing_state
        doc: 'A = Active , I = Inactive, T = Test'
      - id: price_increment
        type: decimal_u8_4
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-4'
      - id: leg_count
        type: u1
        doc: 'Values greater than 0 indicate this is a spread instrument'
      - id: leg_offset
        type: u1
        doc: 'Leg definitions, if any, begin at this offset from the beginning of the message. Possible values are 0 (no legs present) or 41 (spread instrument)'
      - id: variance_block_offset
        type: u1
        doc: 'Variance Future parameter block begins at this offset from the beginning of the message. Possible values are 0 (no Variance Block) or 41 (Variance Block present)'
      - id: contract_date
        type: u4
        doc: 'The date that should be used in describing the future''s third party symbol and the measurement period of the contract'
      - id: future_block
        type:
          switch-on: futures_flags
          cases:
            'futures_flags::standard': standard
            'futures_flags::variance': variance
  standard:
    seq:
      - id: future_leg
        type: future_leg
        repeat: expr
        repeat-expr: _parent.leg_count
        doc: 'Future Leg'
  future_leg:
    seq:
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for bid-side, negative for ask-side)'
      - id: leg_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of leg'
  variance:
    seq:
      - id: realized_variance
        type: decimal_s8_8
        doc: 'Realized Variance to date (signed 64-bit decimal with 8 implied decimal places). Implied decimal with scale 1e-8'
      - id: num_expected_prices
        type: u2
        doc: 'Number of expected SP500 prices to be used for calculating returns during the life of the contract'
      - id: num_elapsed_returns
        type: u2
        doc: 'Number of returns elapsed as of the beginning of the trading day'
      - id: previous_settlement
        type: decimal_u8_4
        doc: 'Previous day Settlement Value. Implied decimal with scale 1e-4'
      - id: discount_factor
        type: decimal_s8_16
        doc: 'Discount Factor (signed 64-bit decimal with 16 implied decimal places). Implied decimal with scale 1e-16'
      - id: initial_strike
        type: decimal_u8_4
        doc: 'Initial strike. Implied decimal with scale 1e-4'
      - id: previous_armvm
        type: decimal_s8_6
        doc: 'ARMVM that was used to adjust the previous day settlement price (signed 64-bit decimal value with 6 implied decimal places). Implied decimal with scale 1e-6'
      - id: fed_funds_rate
        type: decimal_s8_6
        doc: 'Fed Funds rate of prior day (signed 64-bit number with 6 implied decimal places). Implied decimal with scale 1e-6'
      - id: future_leg
        type: future_leg
        repeat: expr
        repeat-expr: _parent.leg_count
        doc: 'Future Leg'
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
      - id: long_quantity
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: long_price
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
      - id: short_quantity
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: short_price
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
        doc: 'Number of shares/contracts executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities) (Space): Normal Trade S: Spread trade'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_long_quantity
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
      - id: canceled_short_quantity
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
      - id: long_quantity
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: long_price
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
      - id: short_quantity
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: short_price
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
      - id: long_quantity
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: long_price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities) (Space): Normal Trade S: Spread trade'
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
      - id: short_quantity
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62 symbol'
      - id: short_price
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Options Only (byte not sent in Equities) (Space): Normal Trade S: Spread trade'
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
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
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
        doc: 'S = Initial Settlement, R = Re-issued Settlement'
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
        doc: 'Prior Trade Date Open Interest for this symbol'
      - id: high_price
        type: decimal_u8_4
        doc: 'The higher of highest bid price and highest trade price for the day. Block and ECRP trades (Trade Condition = B or E) do not update High Price. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'The lower of lowest offer price and lowest trade price for the day. Block and ECRP trades (Trade Condition = B or E) do not update Low Price. Implied decimal with scale 1e-4'
      - id: open_price
        type: decimal_u8_4
        doc: 'The first trade on the day (in any session) will set the Open Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition = B or E) do not update Open Price. Implied decimal with scale 1e-4'
      - id: close_price
        type: decimal_u8_4
        doc: 'The last trade on the day (in any session) will set the Close Price for the day (valid only if Total Volume > 0). Block and ECRP trades (Trade Condition = B or E) do not update Close Price. Implied decimal with scale 1e-4'
      - id: total_volume
        type: u4
        doc: 'Total number of contracts traded for the day, including block and ECRP trades'
      - id: block_volume
        type: u4
        doc: 'Total number of block contracts traded for the day'
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
        doc: 'Set if high price valid value'
      - id: high_price_is_bid
        type: b1
        doc: 'Set if high price was set by the highest bid'
      - id: low_price_valid
        type: b1
        doc: 'Set if low price is a valid value'
      - id: low_price_is_offer
        type: b1
        doc: 'Set if low price was set by the lowest offer'
      - id: offer_close_valid
        type: b1
        doc: 'Set if open price and close price contain valid values'
      - id: unused_3
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_16:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000000000000.0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
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
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed. It is sent whenever the system starts up and when the system crosses a midnight boundary. All subsequent Time messages for the same unit will the use the last Midnight Reference until another Time Reference message is received for that unit.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is sent whenever the source time for a unit passes over a second boundary.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day.'
    0xbb:
      id: 'futures_instrument_definition_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cfe book is executed in whole or in part.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
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
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0xbc:
      id: 'transaction_begin'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block.'
    0xbd:
      id: 'transaction_end'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cfe is broken.'
    0xb9:
      id: 'settlement_message'
      doc: 'Settlement messages are normally sent once per day per instrument after settlement prices have been calculated for all applicable instruments on a given business date.'
    0xba:
      id: 'end_of_day_summary_message'
      doc: 'The End of Day Summary is sent out right after trading ends for a symbol. No more Market Update messages will follow an End of Day Summary for a particular symbol.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security. A Trading Status message will be sent whenever a security''s trading status changes.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  futures_flags:
    0:
      id: 'standard'
      doc: 'Standard Block Flag'
    1:
      id: 'variance'
      doc: 'Variance Block Flag'
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
  issue:
    0x53:
      id: 'initial_settlement'
      doc: 'Initial Settlement'
    0x52:
      id: 'reissued_settlement'
      doc: 'Reissued Settlement'
    0x49:
      id: 'indicative_settlement'
      doc: 'Indicative Settlement'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'exchange_specific_suspension'
      doc: 'Exchange Specific Suspension'
    0x54:
      id: 'trading'
      doc: 'Trading'

