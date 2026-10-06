# ---------------------------------------------------------------------
# Kaitai struct definition for: Bist BorsaIstanbul GeniumInet Glimpse v2.7
#
# Protocol:
#   Organization: Borsa İstanbul A.Ş.
#   Protocol: Genium Inet
#   Encoding: Glimpse
#   Version: 2.7
#   Date: 1/17/2025
#   Specification: bistech-glimpse-protocol-specification.pdf
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
  id: bist_borsaistanbul_geniuminet_glimpse_v2_7_server
  title: Bist BorsaIstanbul GeniumInet Glimpse v2.7
  license: GPL-3.0
  endian: be

doc: 'Borsa İstanbul A.Ş. Borsa Istanbul Genium Inet Glimpse v2.7'
doc-ref: https://www.borsaistanbul.com/en/technical-resources/technical-documents

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
            'sequenced_message_type::combination_order_book_leg': combination_order_book_leg
            'sequenced_message_type::tick_size_table_entry': tick_size_table_entry
            'sequenced_message_type::short_sell_status': short_sell_status
            'sequenced_message_type::order_book_state_message': order_book_state_message
            'sequenced_message_type::add_order_no_mpid_attribution': add_order_no_mpid_attribution
            'sequenced_message_type::add_order_with_mpid_attribution': add_order_with_mpid_attribution
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
      - id: reserved_2
        type: b2
        doc: 'Reserved'
      - id: bait_implied_order
        type: b1
        doc: 'Bait/implied order'
      - id: reserved_13
        type: b13
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
  end_of_snapshot_message:
    seq:
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Genium INET ITCH SoupBinTCP sequence number when the snapshot was taken. To be used when logging in to the SoupBinTCP ITCH feed. While GLIMPSE is a binary feed, the SoupBinTCP sequence number is represented using ASCII characters'
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
      doc: 'Sent every second for which at least one message is being generated. Contains the number of seconds since the start of 1970-01-01 00:00:00 UTC, also called Unix Time.'
    0x52:
      id: 'order_book_directory'
      doc: 'Order book directory messages are disseminated for all active securities, including halted securities, in the Genium INET Trading system.'
    0x4d:
      id: 'combination_order_book_leg'
      doc: 'A specialized directory message used when Combination order books are traded at the marketplace. It represents both standard combinations defined by the exchange, and tailor-made combinations created by members.'
    0x4c:
      id: 'tick_size_table_entry'
      doc: 'Contains information on a tick size for a price range. Together, all Tick Size messages with the same order book ID form a complete Tick Size Table.'
    0x56:
      id: 'short_sell_status'
      doc: 'Indicates the short sell rules of an order book. Sent for order books which might have short sell allowing prior to the start of system. If an order book is absent from this message, clients should assume that the order book has no short selling rules at the start-of-day reference data messages.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on order book state changes.'
    0x41:
      id: 'add_order_no_mpid_attribution'
      doc: 'Indicates that a new order has been accepted by the Genium INET Trading system and was added to the displayable book. Generated for unattributed orders. The message includes an Order ID that is unique per order book and side.'
    0x46:
      id: 'add_order_with_mpid_attribution'
      doc: 'Note: not applicable for BIST markets. Would be generated for attributed orders and quotations entered into the Genium INET Trading system.'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Returns the current ITCH sequence number to be used when connecting to the ITCH feed. To maintain a real-time order display, firms should begin to process real-time Genium INET ITCH messages beginning with the sequence number stated in this snapshot message. After transmission, the user will be logged out immediately by the system.'
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

