# ---------------------------------------------------------------------
# Kaitai struct definition for: Asx AsxSecurities Trade Itch v2.0
#
# Protocol:
#   Organization: Australian Securities Exchange
#   Protocol: Asx Trade
#   Encoding: Itch
#   Version: 2.0
#   Date: 04/01/2015
#   Specification: asx_041177.pdf
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
  id: asx_asxsecurities_trade_itch_v2_0
  title: Asx AsxSecurities Trade Itch v2.0
  license: GPL-3.0
  endian: be

doc: 'Australian Securities Exchange Asx Securities Asx Trade Itch v2.0'

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
            'message_type::tick_size_message': tick_size_message
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::add_order_no_participant_id_message': add_order_no_participant_id_message
            'message_type::add_order_participant_id_message': add_order_participant_id_message
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
        doc: 'Unix time (number of seconds since 1970-01-01 00:00:00 UTC). Seconds since Unix epoch'
  order_book_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique instrument series name (ins_id_s in ASX Trade)'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information. May be blank and may not necessarily be unique across all series (long_ins_id_s in ASX Trade)'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code identifying the instrument'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial Product value'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'This value defines the number of decimals used in price for this order book'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals used in the nominal value for this order book'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent an odd lot for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the number of shares that represent a round lot for the order book'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent a block lot for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
  combination_order_book_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique instrument series name (ins_id_s in ASX Trade)'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information. May be blank and may not necessarily be unique across all series (long_ins_id_s in ASX Trade)'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code identifying the instrument'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial Product value'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'This value defines the number of decimals used in price for this order book'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals used in the nominal value for this order book'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent an odd lot for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the number of shares that represent a round lot for the order book'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent a block lot for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: leg_1_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique series name of the leg'
      - id: leg_1_side
        type: u1
        enum: leg_1_side
        doc: 'Leg 1, Side value'
      - id: leg_1_ratio
        type: u4
        doc: 'Relative numbers of contracts in comparison to other legs'
      - id: leg_2_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique series name of the leg'
      - id: leg_2_side
        type: u1
        enum: leg_2_side
        doc: 'Leg 2, Side value'
      - id: leg_2_ratio
        type: u4
        doc: 'Relative numbers of contracts in comparison to other legs'
      - id: leg_3_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique series name of the leg'
      - id: leg_3_side
        type: u1
        enum: leg_3_side
        doc: 'Leg 3, Side value'
      - id: leg_3_ratio
        type: u4
        doc: 'Relative numbers of contracts in comparison to other legs'
      - id: leg_4_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique series name of the leg'
      - id: leg_4_side
        type: u1
        enum: leg_4_side
        doc: 'Leg 4, Side value'
      - id: leg_4_ratio
        type: u4
        doc: 'Relative numbers of contracts in comparison to other legs'
  tick_size_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the given price range'
      - id: price_from
        type: decimal_s4_2
        doc: 'Start of price range for this entry. Implied decimal with scale 1e-2'
      - id: price_to
        type: decimal_s4_2
        doc: 'End of price range for this entry. Implied decimal with scale 1e-2'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event code value'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the session state'
  add_order_no_participant_id_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: order_book_position
        type: u4
        doc: 'Rank within the order book. See Building an Order Book View for details'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'The price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-2'
      - id: exchange_order_type
        type: exchange_order_type
        doc: 'Order Attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type value'
  exchange_order_type:
    seq:
      - id: reserved_2_bits
        type: b2
        doc: 'Reserved'
      - id: market_bid
        type: b1
        doc: 'Market Bid'
      - id: price_stabilisation
        type: b1
        doc: 'Price Stabilisation'
      - id: reserved_bit
        type: b1
        doc: 'Reserved bit'
      - id: undisclosed
        type: b1
        doc: 'Undisclosed'
      - id: reserved_10_bits
        type: b10
        doc: 'Reserved bit'
  add_order_participant_id_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: order_book_position
        type: u4
        doc: 'Rank within the order book. See Building an Order Book View for details'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'The price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-2'
      - id: exchange_order_type
        type: exchange_order_type
        doc: 'Order Attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type value'
      - id: participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier associated with the entered order'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: executed_quantity
        type: u8
        doc: 'The traded quantity'
      - id: match_id
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the owner of the order. Blank for anonymous instruments'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the counterparty to the execution. Blank for anonymous instruments'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: executed_quantity
        type: u8
        doc: 'The traded quantity'
      - id: match_id
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the owner of the order. Blank for anonymous instruments'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the counterparty to the execution. Blank for anonymous instruments'
      - id: trade_price
        type: decimal_s4_2
        doc: 'The traded price. Implied decimal with scale 1e-2'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Indicates if an order was executed in an auction'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be included in trade tickers and volume calculations'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: new_order_book_position
        type: u4
        doc: 'New rank within the order book'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: decimal_s4_2
        doc: 'The price of the new order. Refer to Data Types for field processing notes. Implied decimal with scale 1e-2'
      - id: exchange_order_type
        type: exchange_order_type
        doc: 'Order Attributes'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Note that the number is only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
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
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order being added'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: trade_price
        type: decimal_s4_2
        doc: 'The traded price. Implied decimal with scale 1e-2'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the owner of the order. Blank for anonymous instruments'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the counterparty to the execution. Blank for anonymous instruments'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be included in trade tickers and volume calculations'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Indicates if an order was executed in an auction'
  equilibrium_price_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book (instrument)'
      - id: bid_quantity
        type: u8
        doc: 'Total Bid Quantity available for execution'
      - id: ask_quantity
        type: u8
        doc: 'Total Ask Quantity available for execution'
      - id: equilibrium_price
        type: decimal_s4_2
        doc: 'The price at which matching will occur. Implied decimal with scale 1e-2'
      - id: best_bid_price
        type: decimal_s4_2
        doc: 'Best Bid Price. Implied decimal with scale 1e-2'
      - id: best_ask_price
        type: decimal_s4_2
        doc: 'Best Ask Price. Implied decimal with scale 1e-2'
      - id: best_bid_quantity
        type: u8
        doc: 'Quantity at Best Bid Price'
      - id: best_ask_quantity
        type: u8
        doc: 'Quantity at Best Ask Price'
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
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one ASX ITCH message is being generated. The message contains the number of seconds since the start of 1970-01-01 00:00:00 UTC, also called Unix Time.'
    0x52:
      id: 'order_book_directory_message'
      doc: 'At the start of each trading day, Order Book Directory messages are disseminated for all active instruments.'
    0x4d:
      id: 'combination_order_book_directory_message'
      doc: 'The Combination Order Book Directory is a specialised directory message used for combinations. It represents both standard combinations defined by ASX, and tailor-made combinations created by customers.'
    0x4c:
      id: 'tick_size_message'
      doc: 'This message contains information on a tick size for a price range. Together, all Tick Size messages with the same Order Book ID form a complete Tick Size Table. Each order book has a set of Tick Size Table Entries to define its tick size table.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order Book State message relays information on session state changes.'
    0x41:
      id: 'add_order_no_participant_id_message'
      doc: 'This message will be generated for anonymous instruments in ASX Trade'
    0x46:
      id: 'add_order_participant_id_message'
      doc: 'This message will be generated for non-anonymous instruments in ASX Trade'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order in the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent when an order in the book is executed in whole or in part with a price different than the initial display price.'
    0x55:
      id: 'order_replace_message'
      doc: 'This message is sent whenever an order in the book has been replaced. The remaining quantity from the original order is no longer accessible and must be removed.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order in the book is deleted. There will be no remaining quantity, so the order should be removed from the book.'
    0x50:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide details for executions in dark order books and reporting the individual legs of traded combinations.'
    0x5a:
      id: 'equilibrium_price_update_message'
      doc: 'This message is used when auctions occur. The message provides the changes in equilibrium (auction) price. Note that subtracting the Ask Quantity from the Bid Quantity will yield the Surplus Volume.'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    3:
      id: 'future'
      doc: 'Future'
    5:
      id: 'cash'
      doc: 'Cash'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
  leg_1_side:
    0x42:
      id: 'buy_leg'
      doc: 'Buy Leg'
    0x43:
      id: 'sell_leg'
      doc: 'Sell Leg'
  leg_2_side:
    0x42:
      id: 'buy_leg'
      doc: 'Buy Leg'
    0x43:
      id: 'sell_leg'
      doc: 'Sell Leg'
  leg_3_side:
    0x42:
      id: 'buy_leg'
      doc: 'Buy Leg'
    0x43:
      id: 'sell_leg'
      doc: 'Sell Leg'
    0x3f:
      id: 'not_defined'
      doc: 'No Leg 3 Present'
  leg_4_side:
    0x42:
      id: 'buy_leg'
      doc: 'Buy Leg'
    0x43:
      id: 'sell_leg'
      doc: 'Sell Leg'
    0x3f:
      id: 'not_defined'
      doc: 'No Leg 4 Present'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent Every Trading Day'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent Every Trading Day'
  side:
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x42:
      id: 'buy'
      doc: 'Buy Order'
  lot_type:
    0:
      id: 'undefined'
      doc: 'Undefined'
    1:
      id: 'odd_lot'
      doc: 'Odd Lot'
    2:
      id: 'round_lot'
      doc: 'Round Lot'
    3:
      id: 'block_lot'
      doc: 'Block Lot'
    4:
      id: 'all_or_none_lot'
      doc: 'All Or None Lot'
  occurred_at_cross:
    0x59:
      id: 'yes_field'
      doc: 'Order Executed In An Auction'
    0x4e:
      id: 'no_field'
      doc: 'Order Executed In Continuous Matching'
  printable:
    0x59:
      id: 'yes_field'
      doc: 'Include In Trade Tickers And Volume Calculations'
    0x4e:
      id: 'no_field'
      doc: 'Do Not Include In Trade Tickers And Volume Calculations'

