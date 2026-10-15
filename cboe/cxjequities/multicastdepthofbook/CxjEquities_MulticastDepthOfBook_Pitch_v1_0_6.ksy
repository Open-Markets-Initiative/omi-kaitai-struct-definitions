# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CxjEquities MulticastDepthOfBook Pitch v1.0.6
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 1.0.6
#   Date: 02/25/2025
#   Specification: CXJ Multicast PITCH Specification.pdf
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
  id: cboe_cxjequities_multicastdepthofbook_pitch_v1_0_6
  title: Cboe CxjEquities MulticastDepthOfBook Pitch v1.0.6
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Japan Multicast Depth Of Book Pitch v1.0.6'
doc-ref: https://www.cboe.com/jp/equities/support/technical/

seq:
  - id: packet_header
    type: packet_header_struct
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
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Message Count messages to follow'
      - id: message_count
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
            'message_type::unit_clear_message': unit_clear_message
            'message_type::trading_status_message': trading_status_message
            'message_type::add_order_message': add_order_message
            'message_type::order_executed_message': order_executed_message
            'message_type::reduce_size_message': reduce_size_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::trade_message': trade_message
            'message_type::trade_break_message': trade_break_message
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
  unit_clear_message:
    seq:
      - id: reserved_4
        type: u4
        doc: 'Reserved (undefined)'
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
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
      - id: trading_status_flags
        type: trading_status_flags
        doc: 'Trading status flags'
  trading_status_flags:
    meta:
      bit-endian: le
    seq:
      - id: short_sell_price_check
        type: b1
        doc: '0 = Short sell price check not in effect, 1 = Short sell price check in effect'
      - id: unused_7
        type: b7
        doc: 'Unused'
  add_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Side of the order'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the order. Implied decimal with scale 1e-4'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  order_executed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares executed'
      - id: execution_id
        type: u8
        doc: 'Cboe Japan generated day-unique execution identifier of this execution'
      - id: contra_order_id
        type: u8
        doc: 'Order Id of the contra order to this execution. The contra order id may not have been previously sent in an Add Order message'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'The tick direction of this trade'
  reduce_size_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: cancelled_quantity
        type: u4
        doc: 'Number of shares cancelled'
  modify_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the order. Implied decimal with scale 1e-4'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  delete_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: quantity
        type: u4
        doc: 'Number of shares being added to the book'
      - id: price
        type: decimal_u8_4
        doc: 'The display price of the order. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe Japan generated day-unique execution identifier of this execution'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: contra_order_id
        type: u8
        doc: 'Order Id of the contra order to this execution. The contra order id may not have been previously sent in an Add Order message'
  trade_break_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since epoch. Nanoseconds since Unix epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe Japan generated day-unique execution identifier of this execution'
  end_of_session_message:
    seq:
      - id: reserved_4
        type: u4
        doc: 'Reserved (undefined)'
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x97:
      id: 'unit_clear_message'
      doc: 'Instructs feed recipients to clear all orders for the Cboe Japan book in the unit specified in the Sequenced Unit Header. It would be distributed in rare recovery events such as a datacenter fail-over.'
    0x50:
      id: 'trading_status_message'
      doc: 'Used to indicate the current trading status of a security. A Trading Status message will be sent whenever trading status changes for a security.'
    0x51:
      id: 'add_order_message'
      doc: 'Represents a newly accepted order on the Cboe Japan book. It includes a day-specific Order Id assigned by Cboe Japan to the order.'
    0x52:
      id: 'order_executed_message'
      doc: 'Sent when a visible order on the Cboe Japan book is executed in whole or in part. The execution price equals the order price found in the original Add Order message or the order price in the latest Modify Order message referencing the Order Id.'
    0x39:
      id: 'reduce_size_message'
      doc: 'Sent when a visible order on the Cboe Japan book is partially reduced.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x3c:
      id: 'delete_order_message'
      doc: 'Sent whenever a booked order is cancelled or leaves the order book. The Order Id refers to the Order Id of the original Add Order message.'
    0x53:
      id: 'trade_message'
      doc: 'Sent when there is an execution against any non-displayed portion of an iceberg order. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0x3e:
      id: 'trade_break_message'
      doc: 'Sent whenever an execution on Cboe Japan is cancelled.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'Sent for each unit when the unit shuts down. No additional sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  trading_status:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x68:
      id: 'halted_in_pre_open'
      doc: 'Halted In Pre Open'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  tick_direction:
    0x2d:
      id: 'lower_than_previous_last_sale'
      doc: 'Lower Than Previous Last Sale'
    0x2b:
      id: 'higher_than_previous_last_sale'
      doc: 'Higher Than Previous Last Sale'
    0x30:
      id: 'no_change_from_or_since_tse_previous_close_or_first_tse_trade_of_an_ipo'
      doc: 'No Change From Or Since Tse Previous Close Or First Tse Trade Of An Ipo'
    0x44:
      id: 'same_as_previous_last_sale_and_most_recent_price_change_was_downward'
      doc: 'Same As Previous Last Sale And Most Recent Price Change Was Downward'
    0x55:
      id: 'same_as_previous_last_sale_and_most_recent_price_change_was_upward'
      doc: 'Same As Previous Last Sale And Most Recent Price Change Was Upward'

