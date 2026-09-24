# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe MatchNow MulticastTrades Pitch v1.0.14
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Trades
#   Encoding: Pitch
#   Version: 1.0.14
#   Date: 02/09/2026
#   Specification: Cboe Canada Equities Multicast PITCH Specification (2026-05-28).pdf
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
  id: cboe_matchnow_multicasttrades_pitch_v1_0_14
  title: Cboe MatchNow MulticastTrades Pitch v1.0.14
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Canada MATCHNow Multicast Trades Pitch v1.0.14'
doc-ref: https://www.cboe.com/ca/equities/support/technical/

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
            'message_type::unit_clear_message': unit_clear_message
            'message_type::trading_status_message': trading_status_message
            'message_type::trade_message': trade_message
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
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: listing_exchange
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange codes of the listing exchange'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current trading status code'
      - id: reserved_3
        size: 3
        doc: 'Reserved (undefined)'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: quantity
        type: u4
        doc: 'Incremental number of shares executed or reported (see Trade Condition)'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the trade. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'MATCHNow generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message (Trade Condition ''X'')'
      - id: buy_broker_number
        type: u2
        doc: 'Broker number of the buyer of the trade (or 1 for anonymous)'
      - id: sell_broker_number
        type: u2
        doc: 'Broker number of the seller of the trade (or 1 for anonymous)'
      - id: total_volume
        type: u4
        doc: 'Total number of shares traded in this symbol during the current trading session (may decrease if the Trade Condition field indicates a trade break)'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade condition code'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade flags'
      - id: reserved_2
        type: u2
        doc: 'Reserved (undefined)'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: conditional
        type: b1
        doc: '0 = Regular Trade, 1 = Conditional Trade'
      - id: odd_lot
        type: b1
        doc: '0 = Regular Trade, 1 = Odd Lot Trade'
      - id: unused_6
        type: b6
        doc: 'Reserved'
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
      doc: 'Instructs feed recipients to clear all orders for the Cboe Canada order book in the unit specified in the Sequenced Unit Header. Distributed in rare recovery events such as a data center fail-over.'
    0x43:
      id: 'trading_status_message'
      doc: 'Indicates the current trading status of a security in the MATCHNow system (9:30 a.m. - 4:00 p.m. ET). Sequenced Trading Status messages are sent upon system startup for all active securities with Trading Status = S (suspended).'
    0x42:
      id: 'trade_message'
      doc: 'Sends the trade price, trade quantity, execution id, and trade condition of a trade as well as the cumulative volume for the trading session. A Trade message will be sent for each execution, but not every Trade message indicates a trade. Trade Condition = X (Trade Break) is sent whenever an execution is broken.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'Sent for each unit when the unit shuts down. No additional sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  trading_status:
    0x41:
      id: 'accepting'
      doc: 'Accepting'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x53:
      id: 'trading_suspended'
      doc: 'Trading Suspended'
    0x54:
      id: 'trading'
      doc: 'Trading'
  trade_condition:
    0x20:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x58:
      id: 'trade_break'
      doc: 'Trade Break'

