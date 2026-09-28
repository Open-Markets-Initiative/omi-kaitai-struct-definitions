# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicDerivatives DepthOfBook Itch v2.22.4
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Genium INET Depth Of Book
#   Encoding: Itch
#   Version: 2.22.4
#   Date: 8/16/2017
#   Specification: Nasdaq Nordic Genium INET ITCH Protocol Specification (a2.22.4).pdf
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
  id: nasdaq_nordicderivatives_depthofbook_itch_v2_22_4
  title: Nasdaq NordicDerivatives DepthOfBook Itch v2.22.4
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Derivatives Genium INET Depth Of Book Itch v2.22.4'
doc-ref: https://www.nasdaq.com/products/european-markets/genium-inet-protocol-specifications

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
            'message_type::combination_order_book_directory': combination_order_book_directory
            'message_type::tick_size_table_entry': tick_size_table_entry
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::stressed_market_message': stressed_market_message
            'message_type::exceptional_market_message': exceptional_market_message
            'message_type::add_order_no_mpid_attribution': add_order_no_mpid_attribution
            'message_type::add_order_with_mpid_attribution': add_order_with_mpid_attribution
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_replace_message': order_replace_message
            'message_type::order_delete_message': order_delete_message
            'message_type::trade_message': trade_message
            'message_type::equilibrium_price_update': equilibrium_price_update
            'message_type::quote_request_message': quote_request_message
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
  order_book_directory:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
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
        doc: 'Financial product of the order book'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'Number of decimals used in price for this order book. NOTE: A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent an odd lot for the order book. NOTE: A value of 0 indicates that this lot type is undefined for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represents a round lot for the issue'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents an odd lot for the order book (the document repeats the Odd Lot Size wording for this block lot field). NOTE: A value of 0 indicates that this lot type is undefined for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
  combination_order_book_directory:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
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
        doc: 'Financial product of the order book'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'Number of decimals used in price for this order book. NOTE: A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'Number of decimals in Nominal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represent an odd lot for the order book. NOTE: A value of 0 indicates that this lot type is undefined for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represents a round lot for the issue'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents an odd lot for the order book (the document repeats the Odd Lot Size wording for this block lot field). NOTE: A value of 0 indicates that this lot type is undefined for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: leg_1_symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Leg Symbol'
      - id: leg_1_side
        type: u1
        enum: leg_1_side
        doc: 'Leg side. Values: B = As Defined, C = Opposite'
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
        doc: 'Leg side. Values: B = As Defined, C = Opposite'
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
        doc: 'Leg side. Values: B = As Defined, C = Opposite'
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
        doc: 'Leg side. Values: B = As Defined, C = Opposite'
      - id: leg_4_ratio
        type: u4
        doc: 'Leg ratio'
  tick_size_table_entry:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: tick_size
        type: s8
        doc: 'Tick Size for the given price range'
      - id: price_from
        type: s4
        doc: 'Start of price range for this entry'
      - id: price_to
        type: s4
        doc: 'End of price range for this entry. Zero (0) means infinity'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'The system supports the following event codes on a daily basis: O = Start of Messages. Outside of time stamp messages, the start of day message is the first message sent in any trading day. C = End of Messages. This is always the last message sent in any trading day'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order Book State'
  stressed_market_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: stressed_market
        type: u1
        enum: stressed_market
        doc: 'Values: Y = Yes, stressed market is active. N = No, stressed market is not active'
  exceptional_market_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: exceptional_market
        type: u1
        enum: exceptional_market
        doc: 'Values: Y = Yes, exceptional market is active. N = No, exceptional market is not active'
  add_order_no_mpid_attribution:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: order_book_position
        type: u4
        doc: 'Rank within order book. See Appendix A, How to Build an Order Book View'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. NOTE: Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. See Data Types for field processing notes. Nullable, Market Order = -2147483648'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace. The field is a bit map, multiple values may be set simultaneously; 0 = Not applicable'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type. Values: 0 = Undefined, 1 = Odd Lot, 2 = Round Lot, 3 = Block Lot, 4 = All or None Lot'
  order_attributes:
    seq:
      - id: reserved_bits_15_to_16
        type: b2
        doc: 'Reserved, values 16384 and above are not stated'
      - id: bait_implied_order
        type: b1
        doc: 'Bait/implied order (value 8192)'
      - id: convert_to_aggressive
        type: b1
        doc: 'Convert to aggressive, if locked market (value 4096)'
      - id: firm_color_disabled
        type: b1
        doc: 'Firm color disabled (value 2048)'
      - id: fill_and_kill_immediately
        type: b1
        doc: 'Fill-and-kill immediately (value 1024)'
      - id: reserved_bits_7_to_10
        type: b4
        doc: 'Reserved, values 64 through 512 are not stated'
      - id: undisclosed
        type: b1
        doc: 'Undisclosed (value 32)'
      - id: override_crossing
        type: b1
        doc: 'Override Crossing (value 16)'
      - id: price_stabilization
        type: b1
        doc: 'Price Stabilization (value 8)'
      - id: market_bid
        type: b1
        doc: 'Market Bid (value 4)'
      - id: short_sell
        type: b1
        doc: 'Short Sell (value 2)'
      - id: force
        type: b1
        doc: 'Force (value 1)'
  add_order_with_mpid_attribution:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: order_book_position
        type: u4
        doc: 'Rank within order book. See Appendix A, How to Build an Order Book View'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. NOTE: Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. See Data Types for field processing notes. Nullable, Market Order = -2147483648'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace. The field is a bit map, multiple values may be set simultaneously; 0 = Not applicable'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type. Values: 0 = Undefined, 1 = Odd Lot, 2 = Round Lot, 3 = Block Lot, 4 = All or None Lot'
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
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, owner. NOTE: Will be set to blank (space) for anonymous markets'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, counterparty. NOTE: Will be set to blank (space) for anonymous markets'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: executed_quantity
        type: u8
        doc: 'The quantity being executed'
      - id: match_id
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, owner. NOTE: Will be set to blank (space) for anonymous markets'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, counterparty. NOTE: Will be set to blank (space) for anonymous markets'
      - id: trade_price
        type: s4
        doc: 'Trade price'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Values: Y = Yes, trade occurred at the cross. N = No, trade occurred at continuous market'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the trade should be included in trade tickers and volume calculations. Values: N = non-printable, Y = printable'
  order_replace_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: new_order_book_position
        type: u4
        doc: 'New Rank within order book. See Appendix A, How to Build an Order Book View'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. NOTE: Orders with an undisclosed quantity will have this field set to 0'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. See Data Types for field processing notes. Nullable, Market Order = -2147483648'
      - id: order_attributes
        type: order_attributes
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace. The field is a bit map, multiple values may be set simultaneously; 0 = Not applicable'
  order_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'The identifier assigned to the new order. NOTE: The number is only unique per Order book and side'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
  trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: match_id
        size: 12
        doc: 'Assigned by the system to each match executed'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. NOTE: Orders with an undisclosed quantity will have this field set to 0'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: trade_price
        type: s4
        doc: 'Trade price'
      - id: participant_id_owner
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, owner. NOTE: Will be set to blank (space) for anonymous markets'
      - id: participant_id_counterparty
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID, counterparty. NOTE: Will be set to blank (space) for anonymous markets'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the trade should be included in trade tickers and volume calculations. Values: N = non-printable, Y = printable'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Values: Y = Yes, trade occurred at the cross. N = No, trade occurred at continuous market'
  equilibrium_price_update:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the bid side'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the ask side'
      - id: equilibrium_price
        type: s4_nullable
        doc: 'Equilibrium Price. Nullable, No Price = -2147483648'
      - id: reserved_4_a
        size: 4
        doc: 'Reserved'
      - id: reserved_4_b
        size: 4
        doc: 'Reserved'
      - id: reserved_8_a
        size: 8
        doc: 'Reserved'
      - id: reserved_8_b
        size: 8
        doc: 'Reserved'
  quote_request_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Timestamp - Nanoseconds. Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book. NOTE: Expired Order book IDs may be reused for new instruments'
      - id: reserved_7
        size: 7
        doc: 'Reserved'
      - id: reserved_5
        size: 5
        doc: 'Reserved'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: side
        type: u1
        enum: side
        doc: 'The type of order. Values: B = buy order, S = sell order'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order. NOTE: Orders with an undisclosed quantity will have this field set to 0'
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
      doc: 'This message is sent every second for which at least one ITCH message is being generated. The message contains the number of seconds since the start of 1970-01-01 00:00:00 UTC, also called Unix Time'
    0x52:
      id: 'order_book_directory'
      doc: 'At the start of each trading day, Order book directory messages are disseminated for all active securities, including halted securities, in the Genium INET Trading system. Intra-day transmissions of this message may occur when new order books are added to the system; updates to existing order books may also be represented by intra-day Order book Directory messages'
    0x4d:
      id: 'combination_order_book_directory'
      doc: 'Specialized directory message used when Combination order books are traded in the marketplace. It represents both standard combinations defined by the exchange and tailor-made combinations created by members. Intra-day transmissions may occur when new combination order books are added, typically for tailor-made combinations'
    0x4c:
      id: 'tick_size_table_entry'
      doc: 'Contains information on a tick size for a price range. Together, all Tick Size messages with the same order book ID form a complete Tick Size Table. The number of decimals in prices are given by the Order Book Directory message for this order book'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order book state message relays information on state changes'
    0x4b:
      id: 'stressed_market_message'
      doc: 'The Stressed Market Message is sent whenever the Stressed Market state has changed'
    0x58:
      id: 'exceptional_market_message'
      doc: 'The Exceptional Market Message is sent whenever the Exceptional Market state has changed'
    0x41:
      id: 'add_order_no_mpid_attribution'
      doc: 'Add Order Message. Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for unattributed orders'
    0x46:
      id: 'add_order_with_mpid_attribution'
      doc: 'Add Order Message. Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for attributed orders and quotations'
    0x45:
      id: 'order_executed_message'
      doc: 'Sent whenever an order on the book is executed in whole or in part. Multiple Order Executed Messages on the same order are cumulative'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'Sent in the relatively rare event that an order on the book is executed in whole or in part with a price different than the initial display price. Combination orders on the book that execute are always represented by this message, with the Printable flag set to N'
    0x55:
      id: 'order_replace_message'
      doc: 'Sent whenever an existing order on the book has been modified through an alter action. The Side, Order book ID and attribution (if any) remain the same as the original order. NOTE: The Order Replace Message is not used, it remains in the ITCH specification for future reference'
    0x44:
      id: 'order_delete_message'
      doc: 'Sent whenever an order on the book is being deleted. Order Deletes are also sent when an order with an undisclosed quantity is fully filled, when orders are suspended due to connection loss, and for all existing orders prior to an auction where market by order dissemination is disabled'
    0x50:
      id: 'trade_message'
      doc: 'Provides execution details for normal match events involving non-displayable order types, and is also used to publish individual cross trades'
    0x5a:
      id: 'equilibrium_price_update'
      doc: 'Used when auctions occur. The message provides the changes in equilibrium price. If any Price field has bit 31 set (the highest bit, MIN_INT) while all other bits are zero (decimal -2147483648), this means that no price is available'
    0x71:
      id: 'quote_request_message'
      doc: 'Used to publish Quote Requests from clients'
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
      doc: 'Synthetic Box Leg Reference'
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
    16:
      id: 'non_deliverable_rolling_spot'
      doc: 'Non Deliverable Rolling Spot'
    17:
      id: 'strip'
      doc: 'Strip'
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
      doc: 'Start Of Messages Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages This Is Always The Last Message Sent In Any Trading Day'
  stressed_market:
    0x59:
      id: 'yes_field'
      doc: 'Yes Stressed Market Is Active'
    0x4e:
      id: 'no_field'
      doc: 'No Stressed Market Is Not Active'
  exceptional_market:
    0x59:
      id: 'yes_field'
      doc: 'Yes Exceptional Market Is Active'
    0x4e:
      id: 'no_field'
      doc: 'No Exceptional Market Is Not Active'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order In The Quote Request Message Buy Quote Requested'
    0x53:
      id: 'sell'
      doc: 'Sell Order In The Quote Request Message Sell Quote Requested'
    0x43:
      id: 'request_for_cross'
      doc: 'Request For Cross Stated For The Quote Request Message Only'
    0x20:
      id: 'blank'
      doc: 'Space Set In The Trade Message For Anonymous Markets In The Quote Request Message Doublesided Quote Requested'
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
      doc: 'Yes Trade Occurred At The Cross'
    0x4e:
      id: 'no_field'
      doc: 'No Trade Occurred At Continuous Market'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'

