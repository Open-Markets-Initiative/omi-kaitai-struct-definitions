# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxaEquities MulticastTopOfBook Spin v1.0.10
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Top Of Book
#   Encoding: Spin
#   Version: 1.0.10
#   Date: 03/21/2025
#   Specification: CXA_Multicast_TOP_Specification.pdf
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
  id: cboe_cxaequities_multicasttopofbook_spin_v1_0_10
  title: Cboe CxaEquities MulticastTopOfBook Spin v1.0.10
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Australia Multicast Top Of Book Spin v1.0.10'
doc-ref: https://www.cboe.com/market_data_services/document_library

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
            'message_type::trading_status_message': trading_status_message
            'message_type::single_side_update_message': single_side_update_message
            'message_type::two_side_update_message': two_side_update_message
            'message_type::calculated_value_message': calculated_value_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by CXA'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by CXA'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Space filled'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by CXA'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'For TOP this is always zero'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  trading_status_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status of the session for the symbol'
      - id: market_id_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code (right padded with spaces)'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  single_side_update_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the update'
      - id: price
        type: decimal_u8_7
        doc: 'Price of the update. Implied decimal with scale 1e-7'
      - id: quantity
        type: u4
        doc: 'Number of shares on the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  two_side_update_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: bid_price
        type: decimal_u8_7
        doc: 'Bid price. Implied decimal with scale 1e-7'
      - id: bid_quantity
        type: u4
        doc: 'Number of shares on the bid side of the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
      - id: ask_price
        type: decimal_u8_7
        doc: 'Ask price. Implied decimal with scale 1e-7'
      - id: ask_quantity
        type: u4
        doc: 'Number of shares on the ask side of the inside book. May be zero if only undisclosed orders exist on the inside book'
      - id: second_reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  calculated_value_message:
    seq:
      - id: timestamp
        type: u8
        doc: 'Nanoseconds since epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: value_category
        type: u1
        enum: value_category
        doc: 'Category of the calculated value'
      - id: value_field
        type: decimal_u8_7
        doc: 'The calculated value. Implied decimal with scale 1e-7'
      - id: value_timestamp
        type: u8
        doc: 'Timestamp when the calculated value was generated in nanoseconds since epoch'
  decimal_u8_7:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000000.0

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'First message sent to the Spin Server by the client process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. Identical format to the GRP Login message.'
    0x02:
      id: 'login_response_message'
      doc: 'Sent by the Spin Server to the client process in response to a Login message. The Status field reflects an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'Sent once per second by the Spin Server, indicating through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'Used by a client''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'Sent by the Spin Server in response to a client''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'Sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt, any buffered multicast messages should be applied to the client''s copy of the book to make it current.'
    0x3b:
      id: 'trading_status_message'
      doc: 'Indicates the current trading status of a security. Included in a spin response so the client can populate trading state for each symbol.'
    0xe4:
      id: 'single_side_update_message'
      doc: 'Carries the current inside price and quantity for a single side of a symbol. Included in a spin response so the client can populate the top-of-book state.'
    0xe5:
      id: 'two_side_update_message'
      doc: 'Carries the current inside prices and quantities for both sides of a symbol. Included in a spin response so the client can populate the top-of-book state.'
    0xe3:
      id: 'calculated_value_message'
      doc: 'Carries the latest calculated market value for a specified symbol. Included in a spin response so the client can populate the latest index, iNAV, or closing price value.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorised_invalid_username_password'
      doc: 'Not Authorised Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  spin_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_requested_is_greater_than_sequence_available_by_the_next_spin'
      doc: 'Out Of Range Sequence Requested Is Greater Than Sequence Available By The Next Spin'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  trading_status:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x41:
      id: 'premarket'
      doc: 'Premarket'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x4d:
      id: 'moc_trading'
      doc: 'Moc Trading'
    0x50:
      id: 'postmarket'
      doc: 'Postmarket'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x53:
      id: 'trading_suspended'
      doc: 'Trading Suspended'
    0x4f:
      id: 'pre_open'
      doc: 'Pre Open'
    0x45:
      id: 'pre_close'
      doc: 'Pre Close'
  side:
    0x42:
      id: 'bid_side'
      doc: 'Bid Side'
    0x53:
      id: 'ask_side'
      doc: 'Ask Side'
  value_category:
    0x31:
      id: 'closing_price'
      doc: 'Closing Price'
    0x32:
      id: 'i_nav_values_etf'
      doc: 'I Nav Values Etf'
    0x33:
      id: 'index_values'
      doc: 'Index Values'
    0x34:
      id: 'eod_nav_from_issuer'
      doc: 'Eod Nav From Issuer'

