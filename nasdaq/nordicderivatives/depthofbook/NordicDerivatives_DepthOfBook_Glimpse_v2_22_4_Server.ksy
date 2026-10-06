# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicDerivatives DepthOfBook Glimpse v2.22.4
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Genium INET Depth Of Book
#   Encoding: Glimpse
#   Version: 2.22.4
#   Date: 8/16/2017
#   Specification: Nasdaq Nordic Genium INET GLIMPSE Protocol Specification (a2.22.4).pdf
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
  id: nasdaq_nordicderivatives_depthofbook_glimpse_v2_22_4_server
  title: Nasdaq NordicDerivatives DepthOfBook Glimpse v2.22.4
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Derivatives Genium INET Depth Of Book Glimpse v2.22.4'
doc-ref: https://www.nasdaq.com/products/european-markets/genium-inet-protocol-specifications

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: _parent.server_packet_header.packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::seconds_message': seconds_message
            'sequenced_message_type::order_book_directory': order_book_directory
            'sequenced_message_type::combination_order_book_directory': combination_order_book_directory
            'sequenced_message_type::tick_size_table_entry': tick_size_table_entry
            'sequenced_message_type::order_book_state_message': order_book_state_message
            'sequenced_message_type::add_order_no_mpid_attribution': add_order_no_mpid_attribution
            'sequenced_message_type::add_order_mpid_attribution': add_order_mpid_attribution
            'sequenced_message_type::end_of_snapshot_message': end_of_snapshot_message
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
        doc: 'This value defines the number of decimals used in price for this order book. NOTE: A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals in Nominal Value'
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
        doc: 'This value defines the number of decimals used in price for this order book. NOTE: A value of 256 means that the instrument is traded in fractions (each fraction is 1/256)'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals in Nominal Value'
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
        type: s4_nullable
        doc: 'Start of price range for this entry. Nullable, No Price = -2147483648'
      - id: price_to
        type: s4_nullable
        doc: 'End of price range for this entry. Zero (0) means infinity. Nullable, No Price = -2147483648'
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
      - id: exchange_order_type
        type: exchange_order_type
        doc: 'Additional order attributes. Applicable types may be defined by the marketplace. The field is a bit map, multiple values may be set simultaneously; 0 = Not applicable'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot Type. Values: 0 = Undefined, 1 = Odd Lot, 2 = Round Lot, 3 = Block Lot, 4 = All or None Lot'
  exchange_order_type:
    seq:
      - id: reserved_bits_14_to_16
        type: b3
        doc: 'Reserved, values 8192 and above are not stated'
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
  add_order_mpid_attribution:
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
      - id: exchange_order_type
        type: exchange_order_type
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
  end_of_snapshot_message:
    seq:
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Genium INET ITCH SoupBinTCP sequence number when the snapshot was taken. To be used when logging in to the SoupBinTCP ITCH feed. NOTE: While GLIMPSE is a binary feed, the SoupBinTCP uses ASCII characters to represent the sequence number'
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
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one message is being generated. The message contains the number of seconds since the start of 1970-01-01 00:00:00 UTC, also called Unix Time'
    0x52:
      id: 'order_book_directory'
      doc: 'At the start of each trading day, Order book directory messages are disseminated for all active securities, including halted securities, in the Genium INET Trading system. Intra-day transmissions of this message may occur when new order books are added to the system; updates to existing order books may also be represented by intra-day Order book Directory messages'
    0x4d:
      id: 'combination_order_book_directory'
      doc: 'Specialized directory message used when Combination order books are traded in the marketplace. It represents both standard combinations defined by the exchange and tailor-made combinations created by members. Intra-day transmissions may occur when new combination order books are added, typically for tailor-made combinations'
    0x4c:
      id: 'tick_size_table_entry'
      doc: 'Contains information on a tick size for a price range. Together, all Tick Size messages with the same order book ID form a complete Tick Size Table. The number of decimals in prices are given by the Order Book Directory message for this order book'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order book state message relays information on state changes'
    0x41:
      id: 'add_order_no_mpid_attribution'
      doc: 'Add Order Message. Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for unattributed orders'
    0x46:
      id: 'add_order_mpid_attribution'
      doc: 'Add Order Message. Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for attributed orders and quotations'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Returns the current ITCH sequence number to be used when connecting to the ITCH feed. To maintain a real-time order display, firms should begin to process real-time Genium INET ITCH messages beginning with the sequence number stated in this snapshot message + 1'
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
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
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

