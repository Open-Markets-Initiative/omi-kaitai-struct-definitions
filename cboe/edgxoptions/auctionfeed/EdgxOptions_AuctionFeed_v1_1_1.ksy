# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions AuctionFeed Pitch v1.1.1
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Auction Feed
#   Encoding: Pitch
#   Version: 1.1.1
#   Date: 12/6/2018
#   Specification: US_Options_Auction_Feed_Specification.pdf
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
  id: cboe_edgxoptions_auctionfeed_pitch_v1_1_1
  title: Cboe EdgxOptions AuctionFeed Pitch v1.1.1
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Auction Feed Pitch v1.1.1'
doc-ref: http://markets.cboe.com/us/options/support/technical

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
        doc: 'Sequence Number of the first message to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::end_of_session_message': end_of_session_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Eastern Time. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: price
        type: decimal_u8_4
        doc: 'This will reflect the NBBO price of the opposite side of the auction at the time of entry. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Customer Indicator'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker (optional) of firm attributed to this quote'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
  auction_cancel_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  auction_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: execution_id
        type: u8
        doc: 'Day specific identifier assigned to this execution'
      - id: price
        type: decimal_u8_4
        doc: 'This will reflect the NBBO price of the opposite side of the auction at the time of entry. Implied decimal with scale 1e-4'
      - id: contracts
        type: u4
        doc: 'Number of contracts available in the auction'
  symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol'
      - id: symbol_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol Condition'
  end_of_session_message:
    seq:
      - id: timestamp
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is sent whenever the source time for a unit passes over a second boundary.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header. This message will be sent at startup each day.'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of an auction. Auctions will be available for a defined period of time known as the exposure period.'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancelation of the original order, a user modification request to change the price or increase the original order quantity, or a fading of the NBBO.'
    0xaf:
      id: 'auction_trade_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancelation of the original order, a user modification request to change the price or increase the original order quantity, or a fading of the NBBO.'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'A symbol mapping message is used to map the 6 character multicast feed symbol field to an OSI symbol.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The Width Update message is used to communicate opening quote width multiplier. This message will be sent at the beginning of the day for all underlyings and in the event that the exchange decides to change the quote width multiplier on a per underlying basis.'
  auction_type:
    0x42:
      id: 'bats_auction_mechanism'
      doc: 'Bats Auction Mechanism'
    0x54:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  customer_indicator:
    0x4e:
      id: 'non_customer'
      doc: 'Non Customer'
    0x43:
      id: 'customer'
      doc: 'Customer'

