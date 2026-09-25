# ---------------------------------------------------------------------
# Kaitai struct definition for: Sgx TitanDt DepthOfBook Glimpse v1.4
#
# Protocol:
#   Organization: Singapore Exchange
#   Protocol: Depth Of Book
#   Encoding: Glimpse
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
  id: sgx_titandt_depthofbook_glimpse_v1_4_server
  title: Sgx TitanDt DepthOfBook Glimpse v1.4
  license: GPL-3.0
  endian: be

doc: 'Singapore Exchange SGX Titan Depth Of Book Glimpse v1.4'
doc-ref: https://www.sgx.com/securities/technical-information

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
        size: 1
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
            'sequenced_message_type::order_book_directory_message': order_book_directory_message
            'sequenced_message_type::combination_order_book_directory_message': combination_order_book_directory_message
            'sequenced_message_type::tick_size_table_entry_message': tick_size_table_entry_message
            'sequenced_message_type::order_book_state_message': order_book_state_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::end_of_snapshot_message': end_of_snapshot_message
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
  end_of_snapshot_message:
    seq:
      - id: itch_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Itch SoupBinTcp sequence number when the snapshot was taken'
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
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on state changes'
    0x41:
      id: 'add_order_message'
      doc: 'A new order has been accepted and added to the displayable book'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Returns the Itch sequence number to be used when connecting to the Itch feed'
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

