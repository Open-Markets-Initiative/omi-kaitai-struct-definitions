# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures OofMulticastDepthOfBook Pitch v1.0.8
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: OOF Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 1.0.8
#   Date: 01/05/2026
#   Specification: technical-specifications-cboe-titanium-cboe-futures-exchange-oof-multicast-depth-of-book-pitch-specification.pdf
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
  id: cboe_cfefutures_oofmulticastdepthofbook_pitch_v1_0_8
  title: Cboe CfeFutures OofMulticastDepthOfBook Pitch v1.0.8
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange OOF Multicast Depth Of Book Pitch v1.0.8'
doc-ref: https://www.cboe.com/us/futures/support/technical/

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
            'message_type::time_reference_message': time_reference_message
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
            'message_type::oof_symbol_mapping_message': oof_symbol_mapping_message
            'message_type::complex_instrument_definition_expanded_message': complex_instrument_definition_expanded_message
            'message_type::trading_status_message': trading_status_message
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
            'message_type::trade_break_message': trade_break_message
            'message_type::settlement_message': settlement_message
            'message_type::end_of_day_summary_message': end_of_day_summary_message
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
        doc: 'Number of whole seconds elapsed since the start of the current Central Time calendar day, derived by converting the current Central wall clock time (HH:MM:SS) to seconds. On Daylight Saving Time transition days, Time reflects wall clock seconds and does not adjust for the UTC offset change. On a DST spring- forward day, the maximum value will be 82,799 (23 hours). On a DST fall-back day, values between 3,600 and 7,199 will appear twice. Recipients requiring unambiguous absolute timestamps should use Epoch Time (where available) or Midnight Reference in the Time Reference message. Seconds since Midnight epoch'
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
        doc: 'Number of whole seconds elapsed since the start of the current Central Time calendar day, derived by converting the current Central wall clock time (HH:MM:SS) to seconds. On Daylight Saving Time transition days, Time reflects wall clock seconds and does not adjust for the UTC offset change. On a DST spring- forward day, the maximum value will be 82,799 (23 hours). On a DST fall-back day, values between 3,600 and 7,199 will appear twice. Recipients requiring unambiguous absolute timestamps should use Epoch Time (where available) or Midnight Reference in the Time Reference message. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (Midnight January 1, 1970 UTC)'
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
  oof_symbol_mapping_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option symbol. Six character, base 62'
      - id: futures_product
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying futures contract product name'
      - id: futures_expiration
        type: u4
        doc: 'Underlying futures contract expiration date'
      - id: futures_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Cboe-formatted futures contract symbol. Six character, base 62'
      - id: strike_price
        type: decimal_u8_4
        doc: 'Option contract strike price. Implied decimal with scale 1e-4'
      - id: call_put_indicator
        type: u1
        enum: call_put_indicator
        doc: 'C = Call P = Put'
      - id: options_expiration
        type: u4
        doc: 'Options contract expiration date'
      - id: options_on_futures_name
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Textual symbol description comprising options product symbol, underlying futures expiration, put/call and the option strike price with two digits to the right of the decimal point. For example "UX1A/X4 C2000" represents the 20.00 strike Call option on the UX1A product with underlying futures expiration X4"'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: 'N = Normal C = Closing Only'
  complex_instrument_definition_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id. Six character, base 62'
      - id: complex_instrument_underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Underlying right padded with spaces'
      - id: complex_instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: '4 character field; each field describes a characteristic. Character 1: Complex Option Type O = All legs are options Characters 2-4: Reserved'
      - id: num_option_leg
        type: u1
        doc: 'The number of legs in the complex instrument. The maximum number of legs is 16'
      - id: option_leg
        type: option_leg
        repeat: expr
        repeat-expr: num_option_leg
        doc: 'The following fields repeat Leg Count times for multi-leg strategies. Leg Index is zero-based'
  option_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option Symbol of leg. Six character, base 62'
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy-side, negative for sell-side). For options this is the number of contracts, for equities this is the number of shares'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'O = Leg is an Option instrument'
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
        doc: 'Six character, base 62'
      - id: reserved_2
        type: u2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'H = Halted Q = Queuing T = Trading'
      - id: reserved_3
        size: 3
        doc: 'Reserved'
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
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62'
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
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62'
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
        doc: '(Space) = Normal trade O = Opening trade1 S = Spread trade1 1Sent for simple (non-spread) symbols only'
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
        doc: 'B = Buy Order S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: '(Space) = Normal trade O = Opening trade1 S = Spread trade1 1Sent for simple (non-spread) symbols only'
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
      - id: quantity_short
        type: u2
        doc: 'Number of contracts being added to the book (may be less than the number entered)'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Six character, base 62'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'CFE generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: '(Space) = Normal trade O = Opening trade1 S = Spread trade1 1Sent for simple (non-spread) symbols only'
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
        doc: 'Six character, base 62'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: settlement_price
        type: decimal_u8_4
        doc: 'Settlement Price. Implied decimal with scale 1e-4'
      - id: issue
        type: u1
        enum: issue
        doc: 'I = Indicative Settlement S = Initial Settlement R = Re-issued Settlement'
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
        doc: 'Six character, base 62'
      - id: trade_date
        type: u4
        doc: 'Current Trade Date'
      - id: open_interest
        type: u4
        doc: 'Prior Trade Date Open Interest for this symbol'
      - id: high_price
        type: decimal_u8_4
        doc: 'The higher of highest bid price and highest trade price for the day. Block trades (Trade Condition = B or E) do not update High Price. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'The lower of lowest offer price and lowest trade price for the day. Block trades (Trade Condition = B or E) do not update Low Price. Implied decimal with scale 1e-4'
      - id: open_price
        type: decimal_u8_4
        doc: 'The first trade on the day (in any session) will set the Open Price for the day (valid only if Total Volume > 0). Block trades (Trade Condition = B or E) do not update Open Price. Implied decimal with scale 1e-4'
      - id: close_price
        type: decimal_u8_4
        doc: 'The last trade on the day (in any session) will set the Close Price for the day (valid only if Total Volume > 0). Block trades (Trade Condition = B or E) do not update Close Price. Implied decimal with scale 1e-4'
      - id: total_volume
        type: u4
        doc: 'Total number of contracts traded for the day, including block trades'
      - id: block_volume
        type: u4
        doc: 'Total number of block contracts traded for the day'
      - id: ecrp_volume
        type: u4
        doc: 'Always zero'
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
      - id: reserved
        type: b3
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
      doc: 'The Time Reference message is used to provide a midnight reference point for recipients of the feed. It is sent whenever the system starts up and when the system crosses a midnight boundary. All subsequent Time messages for the same unit will the use the last Midnight Reference until another Time Reference message is received for that unit. The Time Reference message includes the Trade Date, so most other sequenced messages will not include that information. Time Reference messages will be included in a spin response.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. All subsequent Time Offset fields for the same unit will use the new Time message value as the base until another Time message is received for the same unit. The Time field is the number of seconds relative to midnight Central Time, which is provided in the Time Reference message. The Time message also includes the Epoch Time field, which is the current time represented as the number of whole seconds since the Epoch (Midnight January 1, 1970).'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the CFE book in the unit specified in the Sequenced Unit Header message header. It would be distributed in rare recovery events such as a data center fail-over.'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block. One example of where this might be used is when a single aggressive order executes against several resting orders. All PITCH messages corresponding to such an event would be included between a Transaction Begin message and Transaction End message. It is important to note that any PITCH Message Type may be included in a transaction block and there is no guarantee that the messages apply to the same price level or even the same Symbol. Transaction Begin messages do not alter the book and can be ignored if messages are being used solely to build a book. Feed processors can use a transaction block as a trigger to postpone publishing a quote update until the end of the transaction block. In the prior example of a single aggressive order executing against multiple resting orders, a top of book feed would be able to publish a single trade message and quote update resulting from multiple Order Executed messages once it finished processing all of the messages within the transaction block.'
    0xbd:
      id: 'transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed. Transaction End messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0xf9:
      id: 'oof_symbol_mapping_message'
      doc: 'An OOF Symbol Mapping message is used to map the 6 character multicast feed symbol field and options on futures name to the option contract and future underlying. The option contract is comprised of the strike price, put/call flag, options expiration date, and future underlying. The future underlying is comprised of the futures product and futures expiration date, which map to a futures symbol. This message can be sent either as a sequenced message or as an unsequenced message. It is sent as a sequenced message at system startup upon the beginning of a trading session or if an instrument is created or modified during a trading day. A new sequenced message may also be sent for a symbol that does not visibly change any attribute. A continuous loop of unsequenced symbol mapping messages (sequence = 0) is sent throughout the day at variable rates as bandwidth allows. The Time Offset field should be ignored on unsequenced messages. OOF Symbol Mapping messages are included in a spin response and will be disseminated before Complex Instrument Definition Expanded messages.'
    0x9a:
      id: 'complex_instrument_definition_expanded_message'
      doc: 'A Complex Instrument Definition Expanded message represents a complex instrument that is available to place orders. This message can be sent either as a sequenced message or as an unsequenced message. It is sent as a sequenced message at system startup upon the beginning of a trading session or if an instrument is created or modified during a trading day. A new sequenced message may also be sent for a symbol that does not visibly change any attribute. A continuous loop of unsequenced symbol mapping messages (sequence = 0) is sent throughout the day at variable rates as bandwidth allows. The Time Offset field should be ignored on unsequenced messages. The Complex Instrument Definition Expanded message will contain two or more repeating groups of leg definitions. There is a limit of 16 leg definitions. Complex Instrument Definition Expanded messages are included in a spin response.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a symbol. A Trading Status message will be sent for all symbols as they transition through various trading states. If a Trading Status message has not been received for a symbol, then the Trading Status for the symbol should be assumed to be H = Halted. The following summarizes the Trading Status values for options in the CFE system: H = Halted state. This state is used for Supervisory Halts initiated by the Trade Desk. Orders are not being accepted in this state. Q = Queuing state. This state is used when orders are being accepted for queuing. The Queuing state is used during the pre-open for all symbols. It is also used for spread instruments that may not be tradeable due to Threshold Width. T = Trading state. This state is used when the symbol is available for trading. CFE will send a Trading Status of Q once orders can be accepted for queuing in preparation for the open. At or after the opening time, CFE will send a Trading Status of T as symbols are opened for trading. Once trading is done for the day CFE will send a Trading Status of H indicating the symbol is Halted.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book. It includes a day- specific Order Id assigned by CFE to the order.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the CFE book. It includes a day- specific Order Id assigned by CFE to the order.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when an order on the CFE book is executed in whole or in part. The execution price equals the limit order price found in the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the CFE book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the CFE book is partially reduced.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "no ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "no ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book. The Order Id refers to the Order Id of the original Add Order message. An order that is deleted from the book may return to the book later under certain circumstances. Therefore, a Delete Order message does not indicate that a given Order Id will not be sent again on a subsequent Add Order message.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions that occur off of the CFE book (such as Block trades). Trade messages are necessary to calculate CFE execution data. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book. The Order Id sent in a Trade message is obfuscated and will not tie back to any real Order Id sent back via a FIX or BOE order entry session.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions that occur off of the CFE book (such as Block trades). Trade messages are necessary to calculate CFE execution data. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book. The Order Id sent in a Trade message is obfuscated and will not tie back to any real Order Id sent back via a FIX or BOE order entry session.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on CFE is broken. Trade breaks are rare and only affect applications that rely upon CFE execution-based data. A Trade Break message followed immediately be a new Trade message with the same Execution Id indicates that a trade correction has occurred. Applications that simply build a CFE book can ignore Trade Break messages.'
    0xb9:
      id: 'settlement_message'
      doc: 'Settlement messages are used to provide information concerning indicative, approved, or corrected daily and final settlement prices for CFE products. An indicative daily settlement price (Issue = I) is calculated by the system and sent immediately after an instrument closes trading but before the settlement price is approved. An approved settlement price (Issue = S) is sent once the CFE Trade Desk approves a settlement price for an instrument. If there is an error in the approved settlement price, then it may be re-issued (Issue = R).'
    0xba:
      id: 'end_of_day_summary_message'
      doc: 'The End of Day Summary message is sent out right after trading ends for a symbol. No more markdate data update messages will follow an End of Day Summary message for a particular symbol. A value of zero in the Total Volume field means that no volume traded on that symbol for the day. The Total Volume field reflects all contracts traded during the day. Block trades are included in the Total Volume field, but they are also reported separately to provide more detail. The Summary Flags field provides additional information on how to interpret the High Price and Low Price fields, especially in instruments that had no volume for the day and/or where 0 is a valid price (e.g. complex instruments). There are flags that indicate whether or not the High Price and Low Price fields are valid. If they are not valid, then there was no High (and/or Low) Price for the day. There are also flags that indicate whether the High Price was set by the highest bid and the Low Price was set by the lowest offer rather than a trade. All End of Day Summary message values will span the full trading day, including all extended hours trading and all trading segments.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  call_put_indicator:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  leg_security_type:
    0x4f:
      id: 'leg_is_an_option_instrument'
      doc: 'Leg Is An Option Instrument'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'queuing'
      doc: 'Queuing'
    0x54:
      id: 'trading'
      doc: 'Trading'
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
      doc: 'Sent for simple (non-spread) symbols only.'
    0x53:
      id: 'spread_trade'
      doc: 'Sent for simple (non-spread) symbols only.'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
  issue:
    0x49:
      id: 'indicative_settlement'
      doc: 'Indicative Settlement'
    0x53:
      id: 'initial_settlement'
      doc: 'Initial Settlement'
    0x52:
      id: 'reissued_settlement'
      doc: 'Reissued Settlement'

