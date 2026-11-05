# ---------------------------------------------------------------------
# Kaitai struct definition for: Aix AixMarket GeniumInet Glimpse v1.0
#
# Protocol:
#   Organization: Astana International Exchange
#   Protocol: Genium Inet
#   Encoding: Glimpse
#   Version: 1.0
#   Date: 9/26/2025
#   Specification: new_GLIMPSE_ProtSpec_AIX_v1.docx.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: aix_aixmarket_geniuminet_glimpse_v1_0_server
  title: Aix AixMarket GeniumInet Glimpse v1.0
  license: MIT-0
  endian: be

doc: 'Astana International Exchange Astana International Exchange Genium Inet Glimpse v1.0'
doc-ref: https://www.aixkz.com/en/pages/aix-specifications

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
            'sequenced_message_type::order_book_directory_message': order_book_directory_message
            'sequenced_message_type::tick_size_table_entry_message': tick_size_table_entry_message
            'sequenced_message_type::short_sell_status_message': short_sell_status_message
            'sequenced_message_type::order_book_state_message': order_book_state_message
            'sequenced_message_type::add_order_message': add_order_message
            'sequenced_message_type::end_of_snapshot_message': end_of_snapshot_message
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
        doc: 'Denotes the primary identifier of an order book'
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
        doc: 'Financial product type'
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
        enum: number_of_decimals_in_nominal_value
        doc: 'This value defines the number of decimals in Nominal Value'
      - id: odd_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents an odd lot for the order book'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represents a round lot for the issue'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of securities that represents an odd lot for the order book'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: reserved_1
        size: 1
        doc: 'Reserved'
      - id: underlying_order_book_id
        type: u4
        doc: 'Order book ID of underlying instrument'
      - id: strike_price
        type: s4_nullable
        doc: 'Strike Price. Nullable, No Value = -2147483648'
      - id: expiration_date
        type: yyyymmdd_date
        doc: 'Date of expiration'
      - id: number_of_decimals_in_strike_price
        type: u2
        enum: number_of_decimals_in_strike_price
        doc: 'Number of decimals used in Strike Price for this order book'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option type'
      - id: ranking_type
        type: u1
        enum: ranking_type
        doc: 'Specify what ranking type should be used'
  tick_size_table_entry_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the given price range'
      - id: price_from
        type: s4_nullable
        doc: 'Start of price range for this entry. Nullable, No Value = -2147483648'
      - id: price_to
        type: s4_nullable
        doc: 'End of price range for this entry. Nullable, No Value = -2147483648. Nullable, Infinity = 0'
  short_sell_status_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'Specify Short Sell status and what Short Sell validation rule that should be used'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of Order book State'
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
        doc: 'Denotes the primary identifier of an order book'
      - id: side
        type: u1
        enum: side
        doc: '"B" = buy order. "S" = sell order'
      - id: ranking_sequence_number
        type: u4
        doc: 'Transaction-based and sequential number starting from 1'
      - id: quantity
        type: u8
        doc: 'The visible quantity of the order'
      - id: price
        type: s4_nullable
        doc: 'The display price of the new order. Nullable, No Value = -2147483648'
      - id: order_attributes
        type: u2
        enum: order_attributes
        doc: 'Order attributes'
      - id: lot_type
        type: u1
        enum: lot_type
        doc: 'Lot type'
      - id: ranking_time
        type: nanosecond_timestamp
        doc: 'Ranking timestamp - Nanosecond. Nanoseconds since Unix epoch'
  end_of_snapshot_message:
    seq:
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'AIX ITCH SoupBinTCP sequence number when the snapshot was taken'
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
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
      doc: 'This message is sent every second for which at least one message is being generated.'
    0x52:
      id: 'order_book_directory_message'
      doc: 'Order book directory messages are disseminated for all active securities, including halted securities, in the AIX Trading system.'
    0x4c:
      id: 'tick_size_table_entry_message'
      doc: 'This message contains information on a tick size for a price range.'
    0x56:
      id: 'short_sell_status_message'
      doc: 'A Short Sell Status Message indicates the short sell rules of an order book.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'The Order book state message relays information on state changes.'
    0x41:
      id: 'add_order_message'
      doc: 'An Add Order Message indicates that a new order has been accepted by the AIX Trading system and was added to the displayable book.'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'The end of snapshot message returns the current ITCH sequence number to be used when connecting to the ITCH feed.'
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
      id: 'synthetic_box_leg_reference'
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
    18:
      id: 'certificate'
      doc: 'Certificate'
  number_of_decimals_in_nominal_value:
    0: 'zero_decimals'
    1: 'one_decimals'
    2: 'two_decimals'
    3: 'three_decimals'
    4: 'four_decimals'
    5: 'five_decimals'
    6: 'six_decimals'
    7: 'seven_decimals'
    8: 'eight_decimals'
    9: 'nine_decimals'
  number_of_decimals_in_strike_price:
    0: 'zero_decimals'
    1: 'one_decimals'
    2: 'two_decimals'
    3: 'three_decimals'
    4: 'four_decimals'
    5: 'five_decimals'
    6: 'six_decimals'
    7: 'seven_decimals'
    8: 'eight_decimals'
    9: 'nine_decimals'
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
  short_sale_restriction:
    0:
      id: 'no_restrictions'
      doc: 'No Restrictions'
    1:
      id: 'security_is_not_shortable'
      doc: 'Security Is Not Shortable'
    2:
      id: 'security_not_shortable_at_or_below_the_best_bid'
      doc: 'Security Not Shortable At Or Below The Best Bid'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  order_attributes:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
  lot_type:
    2:
      id: 'round_lot'
      doc: 'Round Lot'

