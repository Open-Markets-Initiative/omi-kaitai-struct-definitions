# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx OseDerivatives GeniumInet Glimpse v2.2
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Genium Inet
#   Encoding: Glimpse
#   Version: 2.2
#   Date: 10/31/2025
#   Specification: J-GATE3.0_ITCH_Connectivity_Manual_V2.2.pdf
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
  id: jpx_osederivatives_geniuminet_glimpse_v2_2_server
  title: Jpx OseDerivatives GeniumInet Glimpse v2.2
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Osaka Securities Exchange Genium Inet Glimpse v2.2'

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
            'sequenced_message_type::series_information_basic_message': series_information_basic_message
            'sequenced_message_type::series_information_basic_combination_message': series_information_basic_combination_message
            'sequenced_message_type::tick_size_data_message': tick_size_data_message
            'sequenced_message_type::system_event_data_message': system_event_data_message
            'sequenced_message_type::trading_status_data_message': trading_status_data_message
            'sequenced_message_type::new_order_message': new_order_message
            'sequenced_message_type::execution_notice_message': execution_notice_message
            'sequenced_message_type::execution_notice_with_trade_information_message': execution_notice_with_trade_information_message
            'sequenced_message_type::deleted_order_message': deleted_order_message
            'sequenced_message_type::ep_message': ep_message
            'sequenced_message_type::snapshot_completion_message': snapshot_completion_message
  seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'UNIX time, the time elapsed since January 1 1970 00:00:00 GMT. Seconds since Unix epoch'
  series_information_basic_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'A series name is set'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'A 9-digit code is set'
      - id: reserved_12
        size: 12
        doc: 'Reserved item'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'A product type is set'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'A trading currency is set, fixed at JPY'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'The decimal value for a trading instrument is set'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'Fixed at 0'
      - id: odd_lot_size
        type: u4
        doc: 'Fixed at 0'
      - id: round_lot_size
        type: u4
        doc: 'Fixed at 1'
      - id: block_lot_size
        type: u4
        doc: 'Fixed at 0'
      - id: nominal_value
        type: u8
        doc: 'Fixed at 0'
      - id: number_of_legs
        type: u1
        doc: '0 is set for Normal Series; number of legs is set for combination series'
      - id: underlying_order_book_id
        type: u4
        doc: 'The underlying code is set; 0 is set for combination series'
      - id: strike_price
        type: s4_nullable
        doc: 'Strike Price is set; if the case is futures, 0 is set. Nullable, No Value = -2147483648'
      - id: expiration_date
        type: u4
        doc: 'Expiration date is set'
      - id: number_of_decimals_in_strike_price
        type: u2
        doc: 'Number of decimals in strike price is set'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Distinction of Put or Call is set; if the case is futures or combination series, 0 is set'
  series_information_basic_combination_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: combination_order_book_id
        type: u4
        doc: 'A series ID of Combination trading instrument is set'
      - id: leg_order_book_id
        type: u4
        doc: 'Series ID of the leg is set'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The buy or sell side of Leg is set'
      - id: leg_ratio
        type: u4
        doc: 'Ratio of leg is set'
  tick_size_data_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: tick_size
        type: u8
        doc: 'A tick size that is between the values in Price From and Price to is set'
      - id: price_from
        type: s4_nullable
        doc: 'The smallest value within the price range to which the applicable order price applies is set. Nullable, No Value = -2147483648'
      - id: price_to
        type: s4_nullable
        doc: 'The largest value within the price range to which the applicable order price applies is set. Nullable, No Value = -2147483648'
  system_event_data_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'An event code is set'
  trading_status_data_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Status data is set'
  new_order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'An order number is set, unique for each order book and sell/buy side'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: side
        type: u1
        enum: side
        doc: 'Sell or Buy is set'
      - id: order_book_position
        type: u4
        doc: 'Order priority is set'
      - id: quantity
        type: u8
        doc: 'A new order quantity is set'
      - id: price
        type: s4_nullable
        doc: 'A new order price is set. Nullable, No Value = -2147483648'
      - id: order_attributes
        type: u2
        doc: 'Item not used'
      - id: lot_type
        type: u1
        doc: 'Fixed at 2'
  execution_notice_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'An order number is set, unique for each order book and sell/buy side'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: side
        type: u1
        enum: side
        doc: 'Sell or Buy is set'
      - id: executed_quantity
        type: u8
        doc: 'An executed quantity is set'
      - id: match_id
        type: u8
        doc: 'An ExecutionEventNumber is set'
      - id: combo_group_id
        type: u4
        doc: 'In the case of a combination series execution a combo group ID is set, otherwise 0 is set'
      - id: reserved_7_a
        size: 7
        doc: 'Reserved item, fixed to space'
      - id: reserved_7_b
        size: 7
        doc: 'Reserved item, fixed to space'
  execution_notice_with_trade_information_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'An order number is set, unique for each order book and sell/buy side'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: side
        type: u1
        enum: side
        doc: 'Sell or Buy is set'
      - id: executed_quantity
        type: u8
        doc: 'An executed quantity is set'
      - id: match_id
        type: u8
        doc: 'An ExecutionEventNumber is set'
      - id: combo_group_id
        type: u4
        doc: 'In the case of a combination series execution a combo group ID is set, otherwise 0 is set'
      - id: reserved_7_a
        size: 7
        doc: 'Reserved item, fixed to space'
      - id: reserved_7_b
        size: 7
        doc: 'Reserved item, fixed to space'
      - id: trade_price
        type: s4_nullable
        doc: 'An execution price is set. Nullable, No Value = -2147483648'
      - id: occurred_at_cross
        type: u1
        enum: occurred_at_cross
        doc: 'Identification flag for auction'
      - id: printable
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Item not used'
  deleted_order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'An order number is set, unique for each order book and sell/buy side'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: side
        type: u1
        enum: side
        doc: 'Sell or Buy is set'
  ep_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'A timestamp is set in nanoseconds. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'A series ID is set'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Total bid order quantity at the EP is set'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Total ask order quantity at the EP is set'
      - id: equilibrium_price
        type: s4_nullable
        doc: 'The EP is set. Nullable, No Value = -2147483648'
      - id: reserved_4_a
        size: 4
        doc: 'Reserved item, if any value is set ignore it'
      - id: reserved_4_b
        size: 4
        doc: 'Reserved item, if any value is set ignore it'
      - id: reserved_8_a
        size: 8
        doc: 'Reserved item, if any value is set ignore it'
      - id: reserved_8_b
        size: 8
        doc: 'Reserved item, if any value is set ignore it'
  snapshot_completion_message:
    seq:
      - id: sequence
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number of the multicast data to be received just after snapshot data is received'
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
      doc: 'Provides data on the seconds when each message is disseminated.'
    0x52:
      id: 'series_information_basic_message'
      doc: 'Provides detailed data about the series that can be traded on a given business day.'
    0x4d:
      id: 'series_information_basic_combination_message'
      doc: 'Provides detailed data about the legs of combination trading instruments that can be traded on a given trading day.'
    0x4c:
      id: 'tick_size_data_message'
      doc: 'Provides the tick size of a trading instrument.'
    0x53:
      id: 'system_event_data_message'
      doc: 'Provides system event update data.'
    0x4f:
      id: 'trading_status_data_message'
      doc: 'Provides the trading status data of a trading instrument.'
    0x41:
      id: 'new_order_message'
      doc: 'Provides quote data related to a new order.'
    0x45:
      id: 'execution_notice_message'
      doc: 'Provides an execution notice. The Order ID of the order which is already in the order book is set.'
    0x43:
      id: 'execution_notice_with_trade_information_message'
      doc: 'Provides an execution notice with trade information.'
    0x44:
      id: 'deleted_order_message'
      doc: 'Provided when an order is deleted and does not exist in the order book.'
    0x5a:
      id: 'ep_message'
      doc: 'Provides the equilibrium price for the order reception hours.'
    0x47:
      id: 'snapshot_completion_message'
      doc: 'Sent after completing the transmission of snapshot data.'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    3:
      id: 'futures'
      doc: 'Futures'
    11:
      id: 'combination_series'
      doc: 'Combination Series'
  put_or_call:
    0:
      id: 'futures_or_combination_series'
      doc: 'Futures Or Combination Series'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  leg_side:
    0x42:
      id: 'buy_if_on_buy_side_sell_if_on_sell_side'
      doc: 'Buy If On Buy Side Sell If On Sell Side'
    0x43:
      id: 'sell_if_on_buy_side_buy_if_on_sell_side'
      doc: 'Sell If On Buy Side Buy If On Sell Side'
  event_code:
    0x4f:
      id: 'start_of_message_transmission'
      doc: 'Start Of Message Transmission'
    0x43:
      id: 'end_of_message_transmission'
      doc: 'End Of Message Transmission'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  occurred_at_cross:
    0x59:
      id: 'execution_through_auction'
      doc: 'Execution Through Auction'
    0x4e:
      id: 'execution_through_zaraba'
      doc: 'Execution Through Zaraba'

