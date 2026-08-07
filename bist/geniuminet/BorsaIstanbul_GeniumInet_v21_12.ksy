# ---------------------------------------------------------------------
# Kaitai struct definition for: Bist BorsaIstanbul GeniumInet Itch v21.12
#
# Protocol:
#   Organization: Borsa İstanbul A.Ş.
#   Protocol: Genium Inet
#   Encoding: Itch
#   Version: 21.12
#   Date: 2/28/2025
#   Specification: bistech-itch-protocol-specification.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: bist_borsaistanbul_geniuminet_itch_v21_12
  title: Bist BorsaIstanbul GeniumInet Itch v21.12
  license: GPL-3.0
  endian: be

doc: 'Borsa İstanbul A.Ş. Borsa Istanbul Genium Inet Itch v21.12'
doc-ref: https://www.borsaistanbul.com/en/technical-resources/technical-documents

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
            'message_type::combination_order_book_leg': combination_order_book_leg
            'message_type::tick_size_table_entry': tick_size_table_entry
            'message_type::short_sell_status': short_sell_status
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::add_order_no_mpid_attribution': add_order_no_mpid_attribution
            'message_type::add_order_with_mpid_attribution': add_order_with_mpid_attribution
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_replace_message': order_replace_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_book_flush_message': order_book_flush_message
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
      - id: second
        type: second_timestamp
        doc: 'Unix seconds. Seconds since Unix epoch'
  order_book_directory:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
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
        doc: 'Human-readable long name of security'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code identifying security'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial product type of the order book'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: decimals_in_price
        type: u2
        doc: 'Number of decimals used in price for this order book. A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents an odd lot for the order book. A value of 0 indicates that this lot type is undefined for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represents a round lot for the issue'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents a block lot for the order book. A value of 0 indicates that this lot type is undefined for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: number_of_legs
        type: u1
        doc: 'Number of legs. Only applicable for combination instruments'
      - id: underlying_order_book_id
        type: u4
        doc: 'Order book ID of underlying instrument. Only applicable for derivative instruments except for combinations'
      - id: strike_price
        type: s4
        doc: 'Only applicable for derivative instruments'
      - id: expiration_date
        type: u4
        doc: 'Date of order expiration. Only applicable for derivative instruments. Valid format is YYYYMMDD'
      - id: decimals_in_strike_price
        type: u2
        doc: 'Number of decimals used in Strike Price for this order book. Only applicable for derivative instruments'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option type. A value of 0 indicates that Put or Call is undefined for the order book'
      - id: ranking_type
        type: u1
        enum: ranking_type
        doc: 'Specifies what ranking type should be used. 1 = Price Time'
  combination_order_book_leg:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: combination_order_book_id
        type: u4
        doc: 'Denotes the primary identifier of the combination order book'
      - id: leg_order_book_id
        type: u4
        doc: 'Order book ID of the leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side of the combination'
      - id: leg_ratio
        type: u4
        doc: 'Leg ratio'
  tick_size_table_entry:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the given price range'
      - id: price_from
        type: s4
        doc: 'Start of price range for this entry'
      - id: price_to
        type: s4
        doc: 'End of price range for this entry. Zero (0) means infinity'
  short_sell_status:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'Specifies Short Sell status and what Short Sell validation rule should be used'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'The system supports the following event codes on a daily basis'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order Book State'
  add_order_no_mpid_attribution:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: ranking_sequence_number
        type: u4
        doc: 'Transaction-based and sequential number starting from 1. Used only in ranking logic with ranking time. Does not show order book position'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4
        doc: 'The display price of the new order. If bit 31 is set (MIN_INT), this represents a market order'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
      - id: ranking_time
        type: nanosecond_timestamp
        doc: 'Ranking timestamp, in nanoseconds. Nanoseconds since Unix epoch'
  order_attributes:
    seq:
      - id: reserved_13
        type: b13
        doc: 'Reserved'
      - id: bait_implied_order
        type: b1
        doc: 'Bait/implied order'
      - id: reserved_2
        type: b2
        doc: 'Reserved'
  add_order_with_mpid_attribution:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: reserved_4
        size: 4
        doc: 'Reserved'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4
        doc: 'The display price of the new order. If bit 31 is set (MIN_INT), this represents a market order'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type'
      - id: participant_id
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market participant identifier associated with the entered order'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination order book executions and the trades in the constituent order books together'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        type: u8
        doc: 'Assigned by the system to each match executed'
      - id: combo_group_id
        type: u4
        doc: 'Used to group combination order book executions and the trades in the constituent order books together'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
      - id: trade_price
        type: s4
        doc: 'Execution price'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Whether the trade occurred at the cross'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the trade should be included in trade tickers and volume calculations'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: new_order_book_position
        type: u4
        doc: 'New rank within order book. Superseded by ranking time/ranking sequence number logic; not shown in current ranking logic'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4
        doc: 'The display price of the new order. If bit 31 is set (MIN_INT), this represents a market order'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. Only unique per order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
  order_book_flush_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
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
        doc: 'Used to group combination order book executions and the trades in the constituent order books together'
      - id: side
        type: u1
        enum: side
        doc: 'Buy or sell order'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. Orders with an undisclosed quantity will have this field set to 0'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: trade_price
        type: s4
        doc: 'Execution price'
      - id: reserved_14
        size: 14
        doc: 'Reserved'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the trade should be included in trade tickers and volume calculations'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Whether the trade occurred at the cross'
  equilibrium_price_update:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. Expired Order book IDs may be reused for new instruments'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the bid side'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the ask side'
      - id: equilibrium_price
        type: s4
        doc: 'Equilibrium Price. If bit 31 is set (MIN_INT) it means that no price is available'
      - id: best_bid_price
        type: s4
        doc: 'Best Bid Price'
      - id: best_ask_price
        type: s4
        doc: 'Best Ask Price'
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
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one ITCH message is being generated. Contains the number of seconds since the start of 1970-01-01 00:00:00 UTC, also called Unix Time.'
    0x52:
      id: 'order_book_directory'
      doc: 'At the start of each trading day, Order book directory messages are disseminated for all active securities, including halted securities. Intra-day transmissions may occur when new order books are added or updates to existing order books occur.'
    0x4d:
      id: 'combination_order_book_leg'
      doc: 'Provides a mapping between a combination order book and one of the combination leg order books. One message is generated per leg that the combination consists of.'
    0x4c:
      id: 'tick_size_table_entry'
      doc: 'Contains information on a tick size for a price range. Together, all Tick Size messages with the same order book ID form a complete Tick Size Table.'
    0x56:
      id: 'short_sell_status'
      doc: 'Indicates the short sell rules of an order book. Sent for order books which might have short sell allowing prior to the start of system. If an order book is absent from this message, clients should assume that the order book has no short selling rules at the start-of-day reference data messages. If short sell rules change during the day for an order book, this message will be re-sent for that order book.'
    0x53:
      id: 'system_event_message'
      doc: 'Used to signal a market or data feed handler event.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on order book state changes.'
    0x41:
      id: 'add_order_no_mpid_attribution'
      doc: 'Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for unattributed orders. The message includes an Order ID that is unique per order book and side.'
    0x46:
      id: 'add_order_with_mpid_attribution'
      doc: 'Note: This message is not used, it remains in the ITCH specification for future reference and is not applicable for BIST markets. Would be generated for attributed orders and quotations entered into the Genium INET Trading system.'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent whenever an order on the book is executed in whole or in part. Modify Order messages always include the Order ID, Order book ID and Side of the Add Order to which the update applies.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'Sent in the relatively rare event that an order on the book is executed in whole or in part with a price different than the initial display price. Combination orders on the book that execute will always be represented by this message, with the Printable flag set to N; leg trades are published with the Trade message and are printable.'
    0x55:
      id: 'order_replace_message'
      doc: 'Note: This message is not used, it remains in the ITCH specification for future reference and is not applicable for BIST markets. A replace of an existing order would be represented by an Order Delete Message followed by an Order Add Message but the original order ID would remain. This message would be sent whenever an order on the book has been cancel-replaced. The Side and Order book ID remain the same as the original order.'
    0x44:
      id: 'order_delete_message'
      doc: 'Sent whenever an order on the book is being deleted. There will be no remaining quantity, so the order should be removed from the book. Normally, no Order Delete message is sent when an order is completely filled.'
    0x59:
      id: 'order_book_flush_message'
      doc: 'Sent whenever an order book is flushed. All remaining orders are no longer accessible and should be removed from the book. Markets by order dissemination may be disabled during auctions by configuration; in such cases every existing order of the order book is removed by this message immediately prior to the auction. Owners of these orders must not interpret this as order cancellations, and should use the private order flow to determine the state of their orders.'
    0x50:
      id: 'trade_message'
      doc: 'Designed to provide execution details for normal match events involving non-displayable order types. Also used to publish individual cross trades. Since no Add Order Message is generated when a non-displayed order is initially received, the Order Executed message cannot be used for all matches; the Trade Message reports a match for a non-displayable order in the book. Trade Messages should be included in trade tickers as well as volume and other market statistics.'
    0x5a:
      id: 'equilibrium_price_update'
      doc: 'Used when auctions occur. Provides the changes in equilibrium price. Markets by order dissemination may be disabled during auctions by configuration.'
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
    18:
      id: 'certificate'
      doc: 'Certificate'
  put_or_call:
    0:
      id: 'undefined'
      doc: 'Undefined'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  ranking_type:
    1:
      id: 'price_time'
      doc: 'Price Time'
  leg_side:
    0x42:
      id: 'as_defined'
      doc: 'As Defined'
    0x43:
      id: 'opposite'
      doc: 'Opposite'
  short_sale_restriction:
    0:
      id: 'no_restrictions'
      doc: 'Short Selling Is Allowed With No Price Validation'
    1:
      id: 'short_selling_not_allowed'
      doc: 'Short Selling Not Allowed'
    2:
      id: 'short_selling_allowed_with_up_tick_rule'
      doc: 'Short Selling Allowed With Up Tick Rule'
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
    0x4e:
      id: 'no'
      doc: 'Trade Occurred At Continuous Market'
    0x59:
      id: 'yes'
      doc: 'Trade Occurred At The Cross'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'

