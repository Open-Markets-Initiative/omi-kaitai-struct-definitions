# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options ComplexOptionsFutures Pitch v1.0.0
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Complex Options Futures
#   Encoding: Pitch
#   Version: 1.0.0
#   Date: 09/16/2026
#   Specification: technical-specifications-cboe-titanium-us-options-complex-multicast-futures-options-order-type-pitch-specification.pdf
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
  id: cboe_c1options_complexoptionsfutures_pitch_v1_0_0
  title: Cboe C1Options ComplexOptionsFutures Pitch v1.0.0
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Complex Options Futures Pitch v1.0.0'
doc-ref: https://www.cboe.com/us/options/support/technical/

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
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
            'message_type::complex_options_futures_instrument_definition_message': complex_options_futures_instrument_definition_message
            'message_type::symbol_mapping_message': symbol_mapping_message
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
            'message_type::trade_futures_options_message': trade_futures_options_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::trading_status_message': trading_status_message
            'message_type::options_auction_update_message': options_auction_update_message
            'message_type::auction_summary_message': auction_summary_message
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
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Eastern Time. Seconds since Midnight epoch'
      - id: epoch_time
        type: u4
        doc: 'Number of whole seconds since the Epoch (midnight January 1, 1970 UTC)'
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
  complex_options_futures_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: complex_instrument_underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Underlying right padded with spaces'
      - id: complex_instrument_type
        type: u1
        enum: complex_instrument_type
        doc: 'Complex Option Type F = One leg is a futures leg'
      - id: reserved_3
        size: 3
        doc: 'Reserved'
      - id: leg_count
        type: u1
        doc: 'The number of legs in the complex instrument. The maximum number of legs is 16'
      - id: futures_price_leg_count
        type: u1
        doc: 'The number of futures leg prices. This must match the number of futures legs'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: futures_price_leg_count
        doc: 'The following fields repeat Leg Count times for multi-leg strategies. Leg Index is zero-based'
      - id: futures_price_leg
        type: futures_price_leg
        repeat: expr
        repeat-expr: futures_price_leg_count
        doc: 'The following fields repeat Futures Leg Price Count times. Futures Price Leg Index is zero-based'
  complex_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option or Futures Symbol of leg, right padded with spaces'
      - id: leg_ratio
        type: s4
        doc: 'Leg ratio (positive for buy-side, negative for sell-side). This is the number of contracts'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'O=Leg is an Option instrument F=Leg is an Futures instrument'
  futures_price_leg:
    seq:
      - id: leg_index
        type: u1
        doc: 'The Leg Index the future price corresponds to. Leg Index is zero-based'
      - id: futures_leg_price
        type: decimal_s8_4
        doc: 'Futures leg price. Implied decimal with scale 1e-4'
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
        doc: 'N = Normal C = Closing Only'
      - id: underlying
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol of underlying equity right padded with spaces. All spaces if not available or not applicable'
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
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: signed_price_short
        type: decimal_s2_2
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-2'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified.If specified the Executing Broker of firm attributed to this quote. Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'N = Non-Customer C = Customer'
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
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Instrument quantity executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'N = Future Options auto electronic trade - Electronic execution of a multi leg future/options order traded on the complex book M = Future Options auction trade - Electronic execution of a multi leg future/options order traded in a two sided auction P = Future Options cross - Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
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
        doc: 'Instrument quantity executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of contracts remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'N = Future Options auto electronic trade - Electronic execution of a multi leg future/options order traded on the complex book M = Future Options auction trade - Electronic execution of a multi leg future/options order traded in a two sided auction P = Future Options cross - Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
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
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
      - id: signed_price_short
        type: decimal_s2_2
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-2'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
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
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'N = Future Options auto electronic trade - Electronic execution of a multi leg future/options order traded on the complex book M = Future Options auction trade - Electronic execution of a multi leg future/options order traded in a two sided auction P = Future Options cross - Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
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
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: signed_price_short
        type: decimal_s2_2
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'N = Future Options auto electronic trade - Electronic execution of a multi leg future/options order traded on the complex book M = Future Options auction trade - Electronic execution of a multi leg future/options order traded in a two sided auction P = Future Options cross - Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
  trade_futures_options_message:
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
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: total_price
        type: decimal_s8_4
        doc: 'The total execution price of the order. This is the total execution price of the order including all the option legs and the futures leg. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'N = Future Options auto electronic trade - Electronic execution of a multi leg future/options order traded on the complex book M = Future Options auction trade - Electronic execution of a multi leg future/options order traded in a two sided auction P = Future Options cross - Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
  auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'C=Complex Auction (COA) B=Complex AIM'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy S=Sell'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'N = Non-Customer C = Customer'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified.If specified the Executing Broker of firm attributed to this quote. Space filled otherwise'
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
        doc: 'Cboe generated day-unique execution identifier of this execution'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_symbol_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Symbol right padded with spaces'
      - id: reserved_2
        size: 2
        doc: 'Reserved'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'H=Halted L=Curb Trading Q=Quote-Only T=RTH Trading'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: gth_trading_status
        type: u1
        enum: gth_trading_status
        doc: 'H=Halted Q=Quote-Only T=Trading'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved'
  options_auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'C=Complex Auction (COA) B=Complex AIM'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: buy_contracts
        type: u4
        doc: 'Cumulative Buy interest at the Indicative Price'
      - id: sell_contracts
        type: u4
        doc: 'Cumulative Sell interest at the Indicative Price'
      - id: indicative_price
        type: decimal_s8_4
        doc: 'SNBBO Collared Volume Maximizing Imbalance Minimizing Price computed on combined Auction-Only and Continuous Book (if any). This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_s8_4
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not used for Complex series. Will contain zero value'
      - id: composite_market_bid_price
        type: decimal_s8_4
        doc: 'Not used for Complex series. Will contain zero value. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_s8_4
        doc: 'Not used for complex series. Will contain zero value. Implied decimal with scale 1e-4'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'C=Complex Auction (COA) B=Complex AIM'
      - id: signed_price_long
        type: decimal_s8_4
        doc: 'The limit order price. This is the price of the option legs only and does not include the futures leg price. Implied decimal with scale 1e-4'
      - id: quantity_long
        type: u4
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
  end_of_session_message:
    seq:
      - id: timestamp
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s2_2:
    seq:
      - id: mantissa
        type: s2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. The Time field is the number of seconds relative to midnight Eastern Time. All subsequent time offset fields for the same unit will use the new Time value as the base until another Time message is received for the same unit. The Time message will also include the Epoch Time field, which is the current time represented as the number of whole seconds since the Epoch (midnight January 1, 1970). A given trading day may span multiple calendar days. Market data recipients must prepare for a crossing of the midnight ET boundary. At such time, a new Time Reference message will be sent and the Time field in subsequent Time messages will reset to reflect the number of seconds from the most recent midnight ET time.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe complex book in the unit specified in the Sequenced Unit Header.'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block. All PITCH messages corresponding to such an event would be included between a Transaction Begin and Transaction End. It is important to note that any PITCH Message Type may be included in a transaction block and there is no guarantee that the messages apply to the same price level or even the same Symbol. Transaction Begin messages do not alter the book and can be ignored if messages are being used solely to build a book. Feed processors can use a transaction block as a trigger to postpone publishing a quote update until the end of the transaction block.'
    0xbd:
      id: 'transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed. Transaction End messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0xfc:
      id: 'complex_options_futures_instrument_definition_message'
      doc: 'A Complex Options Futures Instrument Definition message represents a complex instrument that is available to place orders. It is sent as a sequenced message the first time a Complex Options Futures Instrument Definition message is sent for a symbol. These messages will also be sent continuously through the day as an unsequenced message (sequence = 0) at variable rates as bandwidth allows. The Time offset field should be ignored on an unsequenced Complex Options Futures Instrument Definition message. The Complex Options Futures Instrument Definition message will contain two or more repeating groups of leg definitions. There is a limit of 16 leg definitions, one of which is a futures leg.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A Symbol Mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol and Underlying. These messages are not sequenced (sequence = 0) and are sent continuously through the day at variable rates as bandwidth allows.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe complex book. It includes a day-specific Order Id assigned by Cboe to the complex order.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe complex book. It includes a day-specific Order Id assigned by Cboe to the complex order.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe complex book. It includes a day-specific Order Id assigned by Cboe to the complex order.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible complex order on the Cboe complex book is executed in whole or in part. The execution price equals the limit order price found in the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id. Note even if there are single leg to complex order executions, this feed will only contain the order execution for the complex order. Any single leg execution information is available on the standard PITCH feed.'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Execution at Price/Size messages are sent when a complex order on the Cboe complex book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id. If the Remaining Quantity field contains a 0 the complex order should be completely removed from the complex book. Order Execution at Price/Size messages may also be sent in the event the existing size for Order Id is not equal to Executed Quantity + Remaining Quantity. In this case the complex order should be prioritized the same as a new complex order.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a complex order on the Cboe complex book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a complex order on the Cboe complex book is partially reduced.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open complex order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "no ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open complex order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "no ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book. The Order Id refers to the Order Id of the original Add Order message. An order that is deleted from the book may return to the book later under certain circumstances. Therefore, a Delete Order message does not indicate that a given Order Id will not be sent again on a subsequent Add Order message.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book. A Trade message can also be sent when an auction executes against a non-displayed order, such as a contra response. Trade messages are necessary to calculate Cboe execution-based data. Trade messages do not alter the complex book and can be ignored if messages are being used solely to build a complex book. No Add Order message is sent for complex auction orders, and thus, no order modification messages may be sent when complex auctions are executed. Instead, a Trade message is sent whenever a complex auction is executed in whole or in part. A complete view of all Cboe complex executions can be built by combining all Order Executed messages and Trade messages.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book. A Trade message can also be sent when an auction executes against a non-displayed order, such as a contra response. Trade messages are necessary to calculate Cboe execution-based data. Trade messages do not alter the complex book and can be ignored if messages are being used solely to build a complex book. No Add Order message is sent for complex auction orders, and thus, no order modification messages may be sent when complex auctions are executed. Instead, a Trade message is sent whenever a complex auction is executed in whole or in part. A complete view of all Cboe complex executions can be built by combining all Order Executed messages and Trade messages.'
    0xfd:
      id: 'trade_futures_options_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book. A Trade message can also be sent when an auction executes against a non-displayed order, such as a contra response. Trade messages are necessary to calculate Cboe execution-based data. Trade messages do not alter the complex book and can be ignored if messages are being used solely to build a complex book. No Add Order message is sent for complex auction orders, and thus, no order modification messages may be sent when complex auctions are executed. Instead, a Trade message is sent whenever a complex auction is executed in whole or in part. A complete view of all Cboe complex executions can be built by combining all Order Executed messages and Trade messages.'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of a complex auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancellation of the original complex auction, a user modification request to change the complex auction price or increase the original complex auction quantity, a fading of the NBBO or to cancel any remaining complex auction quantity from the original Auction Notification following the complex auction termination. A user request to modify the complex auction price or to increase the original complex auction quantity will result in a cancellation of the complex auction followed by a new Auction Notification message. Auction Cancel messages will not be issued for complex auction quantity decrements.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from a complex auction.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a complex instrument. A Trading Status message will be sent whenever a complex instrument trading status changes. A Trading Status message will be sent for all complex instruments as they transition through various trading states. Starting at 7:30 a.m. ET, Cboe will send a Trading Status of Q once orders can be accepted for queuing in preparation for the RTH open. At or after 9:30 a.m. ET, Cboe will send a Trading Status of T as series are open for trading. Cboe will send a Trading Status of L as SPX or VIX series transition from RTH trading to Curb trading. A Trading Status message will also be sent: for a Regulatory Halt Q=Quotingperiod in any series where the underlying has experienced a Regulatory Halt as well as the T=Trading resumption for the same series. for instruments that are in a Q=Quoting period for auctions. The Trading Status field will be used to represent the status of the RTH (9:30 a.m. ET - 4:15 p.m. ET) and Curb sessions. The GTH Trading Status field will be used to represent the status of series that trade during the GTH session. The GTH session runs from 8:15 p.m. to 9:25 a.m. ET for SPX and VIX series.'
    0xd1:
      id: 'options_auction_update_message'
      doc: 'Options Auction Update messages are used to disseminate price and size information during the Opening and Re-Opening (halt) process for complex instruments. The Options Auction Update messages are sent every 5 seconds during an opening period. Refer to the Cboe Options Complex Book Process specification for more information.'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction of a complex instrument. An Opening or Re-Opening Auction Summary message for each complex instrument is sent at the conclusion of its Opening or Re-Opening auction and represents Cboe opening price. Refer to the Cboe Options Complex Book Process specification for more information. The Auction Summary message has the following format:'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  complex_instrument_type:
    0x46:
      id: 'one_leg_is_a_futures_leg'
      doc: 'One Leg Is A Futures Leg'
  leg_security_type:
    0x4f:
      id: 'leg_is_an_option_instrument'
      doc: 'Leg Is An Option Instrument'
    0x46:
      id: 'leg_is_an_futures_instrument'
      doc: 'Leg Is An Futures Instrument'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
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
    0x4e:
      id: 'future_options_auto_electronic_trade'
      doc: 'Electronic execution of a multi leg future/options order traded on the complex book'
    0x4d:
      id: 'future_options_auction_trade'
      doc: 'Electronic execution of a multi leg future/options order traded in a two sided auction'
    0x50:
      id: 'future_options_cross'
      doc: 'Electronic execution of a multi leg future/options order traded in a two sided crossing mechanism that does not go through an exposure period'
  auction_type:
    0x43:
      id: 'complex_auction_coa'
      doc: 'Complex Auction Coa'
    0x42:
      id: 'complex_aim'
      doc: 'Complex Aim'
    0x47:
      id: 'gth_opening'
      doc: 'Gth Opening'
    0x4f:
      id: 'rth_opening'
      doc: 'Rth Opening'
    0x48:
      id: 'halt_re_opening'
      doc: 'Halt Re Opening'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
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
    0x54:
      id: 'trading'
      doc: 'Trading'

