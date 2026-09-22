# ---------------------------------------------------------------------
# Kaitai struct definition for: Sgx TitanDt DepthOfBook Itch v1.4
#
# Protocol:
#   Organization: Singapore Exchange
#   Protocol: Depth Of Book
#   Encoding: Itch
#   Version: 1.4
#   Date: 5/10/2016
#   Specification: Titan_ITCH_and_GLIMPSE_Protocol_Specifications.pdf
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
  id: sgx_titandt_depthofbook_itch_v1_4
  title: Sgx TitanDt DepthOfBook Itch v1.4
  license: GPL-3.0
  endian: be

doc: 'Singapore Exchange SGX Titan Depth Of Book Itch v1.4'
doc-ref: https://www.sgx.com/securities/technical-information

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::seconds_message': seconds_message
            'message_type::order_book_directory_message': order_book_directory_message
            'message_type::combination_order_book_directory_message': combination_order_book_directory_message
            'message_type::tick_size_table_entry_message': tick_size_table_entry_message
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_replace_message': order_replace_message
            'message_type::order_delete_message': order_delete_message
            'message_type::trade_message': trade_message
            'message_type::equilibrium_price_update_message': equilibrium_price_update_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Unix time. Seconds since Unix epoch'
  order_book_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument short name'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human readable long name of Instrument series'
      - id: reserved_12
        size: 12
        doc: 'Reserved'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial product of the Order Book'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'Number of decimals used in price for this Order Book'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: reserved_4_a
        size: 4
        doc: 'Reserved'
      - id: reserved_4_b
        size: 4
        doc: 'Reserved'
      - id: reserved_4_c
        size: 4
        doc: 'Reserved'
      - id: nominal_value
        type: u8
        doc: 'Nominal Value'
  combination_order_book_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument short name'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human readable long name of Instrument series'
      - id: reserved_12
        size: 12
        doc: 'Reserved'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial product of the Order Book'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'Number of decimals used in price for this Order Book'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: reserved_4_a
        size: 4
        doc: 'Reserved'
      - id: reserved_4_b
        size: 4
        doc: 'Reserved'
      - id: reserved_4_c
        size: 4
        doc: 'Reserved'
      - id: nominal_value
        type: u8
        doc: 'Nominal Value'
      - id: leg_1_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg Symbol'
      - id: leg_1_side
        type: u1
        enum: leg_1_side
        doc: 'Leg side'
      - id: leg_1_ratio
        type: u4
        doc: 'Leg ratio'
      - id: leg_2_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg Symbol'
      - id: leg_2_side
        type: u1
        enum: leg_2_side
        doc: 'Leg side'
      - id: leg_2_ratio
        type: u4
        doc: 'Leg ratio'
      - id: leg_3_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg Symbol'
      - id: leg_3_side
        type: u1
        enum: leg_3_side
        doc: 'Leg side'
      - id: leg_3_ratio
        type: u4
        doc: 'Leg ratio'
      - id: leg_4_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg Symbol'
      - id: leg_4_side
        type: u1
        enum: leg_4_side
        doc: 'Leg side'
      - id: leg_4_ratio
        type: u4
        doc: 'Leg ratio'
  tick_size_table_entry_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the given price range'
      - id: price_from
        type: s4_nullable
        doc: 'Start of price range for this entry. Nullable, No Price = -2147483648'
      - id: price_to
        type: s4_nullable
        doc: 'End of price range for this entry. Nullable, No Price = -2147483648'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System event code'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order Book State'
  add_order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: order_book_position
        type: u4
        doc: 'Rank within the Order Book'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. Nullable, Market Order = -2147483648'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
  order_attributes:
    seq:
      - id: reserved_bits_15_to_16
        type: b2
        doc: 'Reserved'
      - id: bait_implied_order
        type: b1
        doc: 'Bait or implied order'
      - id: reserved_bits_1_to_13
        type: b13
        doc: 'Reserved'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Groups Combination Order Book executions with constituent trades'
      - id: reserved_7_a
        size: 7
        doc: 'Reserved'
      - id: reserved_7_b
        size: 7
        doc: 'Reserved'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Groups Combination Order Book executions with constituent trades'
      - id: reserved_7_a
        size: 7
        doc: 'Reserved'
      - id: reserved_7_b
        size: 7
        doc: 'Reserved'
      - id: trade_price
        type: s4_nullable
        doc: 'Trade Price. Nullable, No Price = -2147483648'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Whether the trade occurred at the cross'
      - id: printable
        type: u1
        enum: printable
        doc: 'Whether the trade should be included in trade tickers'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: new_order_book_position
        type: u4
        doc: 'New Rank within Order Book'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. Nullable, Market Order = -2147483648'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
  trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Groups Combination Order Book executions with constituent trades'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: trade_price
        type: s4_nullable
        doc: 'Trade Price. Nullable, No Price = -2147483648'
      - id: reserved_7_a
        size: 7
        doc: 'Reserved'
      - id: reserved_7_b
        size: 7
        doc: 'Reserved'
      - id: printable
        type: u1
        enum: printable
        doc: 'Whether the trade should be included in trade tickers'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Whether the trade occurred at the cross'
  equilibrium_price_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an Order Book'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the bid side'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the ask side'
      - id: equilibrium_price
        type: s4_nullable
        doc: 'Equilibrium Price. Nullable, No Price = -2147483648'
      - id: best_bid_price
        type: s4_nullable
        doc: 'Best Bid Price. Nullable, No Price = -2147483648'
      - id: best_ask_price
        type: s4_nullable
        doc: 'Best Ask Price. Nullable, No Price = -2147483648'
      - id: best_bid_quantity
        type: u8
        doc: 'Best Bid Quantity'
      - id: best_ask_quantity
        type: u8
        doc: 'Best Ask Quantity'
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
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one Itch message is generated'
    0x52:
      id: 'order_book_directory_message'
      doc: 'Disseminated at the start of each trading day for all active instruments'
    0x4d:
      id: 'combination_order_book_directory_message'
      doc: 'Specialized directory message used when Combination Order Books are traded'
    0x4c:
      id: 'tick_size_table_entry_message'
      doc: 'Contains information on a tick size for a price range'
    0x53:
      id: 'system_event_message'
      doc: 'Signals a market or data feed handler event'
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on state changes'
    0x41:
      id: 'add_order_message'
      doc: 'A new order has been accepted and added to the displayable book'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent whenever an order on the book is executed in whole or in part'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'Sent when an order executes at a price different than the initial display price'
    0x55:
      id: 'order_replace_message'
      doc: 'Sent whenever an order on the book has been replaced'
    0x44:
      id: 'order_delete_message'
      doc: 'Sent whenever an order on the book is being deleted'
    0x50:
      id: 'trade_message'
      doc: 'Provides execution details for match events involving non displayable order types'
    0x5a:
      id: 'equilibrium_price_update_message'
      doc: 'Provides the changes in equilibrium price during auctions'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'forward'
      doc: 'Forward'
    3:
      id: 'future'
      doc: 'Future'
    4:
      id: 'fra'
      doc: 'Fra'
    5:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    8:
      id: 'interest_rate_swap'
      doc: 'Interest Rate Swap'
    9:
      id: 'repo'
      doc: 'Repo'
    10:
      id: 'synthetic_box_leg_or_reference'
      doc: 'Synthetic Box Leg Or Reference'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
    12:
      id: 'guarantee'
      doc: 'Guarantee'
    13:
      id: 'otc_general'
      doc: 'Otc General'
    14:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    15:
      id: 'security_lending'
      doc: 'Security Lending'
  leg_1_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  leg_2_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  leg_3_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  leg_4_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  lot_type:
    2:
      id: 'round_lot'
      doc: 'Round Lot'
  occurred_at_cross:
    0x59:
      id: 'trade_occurred_at_the_cross'
      doc: 'Trade Occurred At The Cross'
    0x4e:
      id: 'trade_occurred_at_continuous_market'
      doc: 'Trade Occurred At Continuous Market'
  printable:
    0x59:
      id: 'printable'
      doc: 'Printable'
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'

