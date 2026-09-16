# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx OseDerivatives GeniumInet Itch v5.0.6
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Genium Inet
#   Encoding: Itch
#   Version: 5.0.6
#   Date: 5/8/2024
#   Specification: ITCH_ProtSpec_OSE_va70.pdf
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
  id: jpx_osederivatives_geniuminet_itch_v5_0_6
  title: Jpx OseDerivatives GeniumInet Itch v5.0.6
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Osaka Securities Exchange Genium Inet Itch v5.0.6'

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
            'message_type::order_book_directory': order_book_directory
            'message_type::combination_orderbook_leg': combination_orderbook_leg
            'message_type::tick_size_table_entry': tick_size_table_entry
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::add_order_no_mpid': add_order_no_mpid
            'message_type::add_order_with_mpid': add_order_with_mpid
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_replace_message': order_replace_message
            'message_type::order_delete_message': order_delete_message
            'message_type::trade_message': trade_message
            'message_type::equilibrium_price_update': equilibrium_price_update
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
      - id: seconds
        type: second_timestamp
        doc: 'Unix time (seconds since 1970-01-01 00:00:00 UTC). Seconds since Unix epoch'
  order_book_directory:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security short name'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human-readable long name'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Product type'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: decimals_in_price
        type: u2
        doc: 'Number of decimals in price (256=fractions)'
      - id: decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Odd lot size'
      - id: round_lot_size
        type: u4
        doc: 'Round lot size'
      - id: block_lot_size
        type: u4
        doc: 'Block lot size'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: number_of_legs
        type: u1
        doc: 'Only for combination instruments'
      - id: underlying_orderbook_id
        type: u4
        doc: 'Underlying instrument ID'
      - id: strike_price
        type: s4
        doc: 'Derivative strike price'
      - id: expiration_date
        type: u4
        doc: 'Date of expiration'
      - id: decimals_in_strike_price
        type: u2
        doc: 'Decimals in Strike Price'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: '1=Call, 2=Put'
  combination_orderbook_leg:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: combination_orderbook_id
        type: u4
        doc: 'Identifier of combo orderbook'
      - id: leg_orderbook_id
        type: u4
        doc: 'Orderbook ID of Leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg Side'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
  tick_size_table_entry:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the range'
      - id: price_from
        type: s4
        doc: 'Start of price range'
      - id: price_to
        type: s4
        doc: 'End of price range'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'O=Start of Messages, C=End of Messages'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order Book State'
  add_order_no_mpid:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: order_book_position
        type: u4
        doc: 'Rank within orderbook'
      - id: quantity
        type: u8
        doc: 'Visible quantity'
      - id: price
        type: s4
        doc: 'Display price'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
  order_attributes:
    meta:
      bit-endian: le
    seq:
      - id: force
        type: b1
        doc: 'Force'
      - id: short_sell
        type: b1
        doc: 'Short Sell'
      - id: market_bid
        type: b1
        doc: 'Market Bid'
      - id: price_stabilization
        type: b1
        doc: 'Price Stabilization'
      - id: override_crossing
        type: b1
        doc: 'Override Crossing'
      - id: undisclosed
        type: b1
        doc: 'Undisclosed'
      - id: unused
        type: b10
        doc: 'Unused'
  add_order_with_mpid:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: order_book_position
        type: u4
        doc: 'Rank within orderbook'
      - id: quantity
        type: u8
        doc: 'Visible quantity'
      - id: price
        type: s4
        doc: 'Display price'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
      - id: participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market participant identifier'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination executions'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Owner ID (blank for anonymous markets)'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty ID (blank for anonymous markets)'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination executions'
      - id: owner_participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Owner ID (blank for anonymous markets)'
      - id: counterparty_participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty ID (blank for anonymous markets)'
      - id: trade_price
        type: s4
        doc: 'Execution price'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Y=Yes, N=No'
      - id: printable
        type: u1
        enum: printable
        doc: 'Y=Printable, N=Non-printable'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: new_orderbook_position
        type: u4
        doc: 'New rank within orderbook'
      - id: quantity
        type: u8
        doc: 'Visible quantity'
      - id: price
        type: s4
        doc: 'Display price'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the new order'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
  trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination executions'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy, S=Sell'
      - id: quantity
        type: u8
        doc: 'Visible quantity'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: trade_price
        type: s4
        doc: 'Execution price'
      - id: owner_participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Owner ID (blank for anonymous markets)'
      - id: counterparty_participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty ID (blank for anonymous markets)'
      - id: printable
        type: u1
        enum: printable
        doc: 'Y=Printable, N=Non-printable'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Y=Yes, N=No'
  equilibrium_price_update:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Primary identifier of an order book'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the bid side'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the ask side'
      - id: equilibrium_price
        type: s4
        doc: 'Equilibrium Price'
      - id: reserved_24
        size: 24
        doc: 'Reserved'
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

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one ITCH message is being generated'
    0x52:
      id: 'order_book_directory'
      doc: 'Disseminated for all active securities at start of day or intra-day.'
    0x4d:
      id: 'combination_orderbook_leg'
      doc: 'Mapping between a combination orderbook and its leg orderbooks.'
    0x4c:
      id: 'tick_size_table_entry'
      doc: 'Information on a tick size for a price range.'
    0x53:
      id: 'system_event_message'
      doc: 'Signals a market or data feed handler event.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on state changes.'
    0x41:
      id: 'add_order_no_mpid'
      doc: 'New order accepted (unattributed).'
    0x46:
      id: 'add_order_with_mpid'
      doc: 'New order accepted (attributed).'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'Sent when an order is executed at a price different than the initial display price.'
    0x55:
      id: 'order_replace_message'
      doc: 'Sent whenever an existing order on the book has been modified. Note: Specification says this message is not used, but remains for future reference.'
    0x44:
      id: 'order_delete_message'
      doc: 'Sent whenever an order on the book is being deleted. There will be no remaining quantity.'
    0x50:
      id: 'trade_message'
      doc: 'Execution details for normal match events involving non-displayable order types or cross trades.'
    0x5a:
      id: 'equilibrium_price_update'
      doc: 'Provides changes in equilibrium price during auctions.'
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
      id: 'combination'
      doc: 'Combination'
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
  put_or_call:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  leg_side:
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
    0x4e:
      id: 'no_field'
      doc: 'Trade Occurred At Continuous Market'
    0x59:
      id: 'yes_field'
      doc: 'Trade Occurred At The Cross'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Nonprintable Ignore For Tickersvolume'
    0x59:
      id: 'printable'
      doc: 'Printable'

