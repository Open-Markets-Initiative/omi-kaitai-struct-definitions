# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe NeoEquities CrossingFacility Pitch v1.0.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Crossing Facility
#   Encoding: Pitch
#   Version: 1.0.13
#   Date: 10/27/2025
#   Specification: Cboe Canada Equities Multicast PITCH Specification (2025-12-06).pdf
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
  id: cboe_neoequities_crossingfacility_pitch_v1_0_13
  title: Cboe NeoEquities CrossingFacility Pitch v1.0.13
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Canada NEO Crossing Facility Pitch v1.0.13'
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
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::trading_status_message': trading_status_message
            'message_type::trade_message': trade_message
            'message_type::trade_break_message': trade_break_message
            'message_type::trade_correction_message': trade_correction_message
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
  instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Defines the order book types allowed for the symbol. 0 means not allowed and 1 means allowed'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the symbol is assigned to (right padded with spaces)'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The possible values will be the ISO 4217 codes for currency'
      - id: lot_size
        type: u4
        doc: 'Indicates the minimum quantity/nominal value tradable on the market for a security'
      - id: full_name
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique long name assigned to the symbol'
      - id: active_market_maker
        type: u2
        doc: 'The active market maker broker id who will be carrying our market maker obligations for the instrument'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The security type of the instrument'
      - id: instrument_flags
        type: instrument_flags
        doc: 'Instrument flags'
      - id: previous_close
        type: decimal_u8_4
        doc: 'The previous day''s closing price. Implied decimal with scale 1e-4'
  allowed_book_types:
    meta:
      bit-endian: le
    seq:
      - id: unused_3
        type: b3
        doc: 'Reserved'
      - id: neol
        type: b1
        doc: 'NEO-L book allowed'
      - id: neon
        type: b1
        doc: 'NEO-N book allowed'
      - id: neod
        type: b1
        doc: 'NEO-D book allowed'
      - id: crossing_facility
        type: b1
        doc: 'Crossing Facility allowed'
      - id: sst
        type: b1
        doc: 'Special Settlement Term book allowed'
  instrument_flags:
    meta:
      bit-endian: le
    seq:
      - id: odd_lot_allowed
        type: b1
        doc: '0 = Not Allowed, 1 = Allowed'
      - id: closing_eligible
        type: b1
        doc: '0 = Not eligible, 1 = Eligible'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  trading_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book to which the trading status applies'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current trading status code'
      - id: trading_sub_status
        type: u1
        enum: trading_sub_status
        doc: 'Current trading sub-status code'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Reason code for a halt condition'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book to which the trading status applies'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: quantity
        type: u4
        doc: 'Incremental number of shares executed or reported'
      - id: price
        type: decimal_u8_4
        doc: 'The price of the trade. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe Canada NEO generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break and Trade Correction messages'
      - id: buy_broker_id
        type: u2
        doc: 'Trading participant identity of the buyer of the trade (or 1 for anonymous)'
      - id: sell_broker_id
        type: u2
        doc: 'Trading participant identity of the seller of the trade (or 1 for anonymous)'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the Cross order'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade flags'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement terms of the order'
      - id: settlement_date
        type: u4
        doc: 'The date the order would settle'
      - id: reserved_1
        type: u1
        doc: 'Reserved (undefined)'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: bypass
        type: b1
        doc: '0 = No Bypass, 1 = Bypass (always 0 if Cross Type is 0)'
      - id: auction
        type: b1
        doc: '0 = Not an Auction Trade, 1 = Auction Trade'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  trade_break_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book to which the trading status applies'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: original_quantity
        type: u4
        doc: 'Original number of shares executed or reported'
      - id: original_price
        type: decimal_u8_4
        doc: 'Original price of the execution. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe Canada NEO generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break and Trade Correction messages'
  trade_correction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book to which the trading status applies'
      - id: symbol
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol (right padded with spaces)'
      - id: original_quantity
        type: u4
        doc: 'Original number of shares executed or reported'
      - id: original_price
        type: decimal_u8_4
        doc: 'Original price of the execution. Implied decimal with scale 1e-4'
      - id: original_settlement_type
        type: u1
        doc: 'Original settlement terms of the order'
      - id: original_settlement_date
        type: u4
        doc: 'Original date the order would settle'
      - id: corrected_quantity
        type: u4
        doc: 'Corrected number of shares executed or reported'
      - id: corrected_price
        type: decimal_u8_4
        doc: 'Corrected price of the execution. Implied decimal with scale 1e-4'
      - id: corrected_settlement_type
        type: u1
        doc: 'Corrected settlement terms of the order'
      - id: corrected_settlement_date
        type: u4
        doc: 'Corrected date the order would settle'
      - id: execution_id
        type: u8
        doc: 'Cboe Canada NEO generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break and Trade Correction messages'
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
    0x60:
      id: 'instrument_directory_message'
      doc: 'Disseminates information for each symbol. A separate Trading Status message indicates the status of each symbol. If no Trading Status message is received for a symbol, it is assumed to be Suspended.'
    0x61:
      id: 'trading_status_message'
      doc: 'Indicates the current trading status of a security on the Cboe Canada NEO system. Sequenced Trading Status messages are sent upon system startup for all active securities with Trading Status = S (suspended).'
    0x67:
      id: 'trade_message'
      doc: 'Provides information about executions of orders not displayed on any Cboe Canada trading book. Trade messages may also provide information about displayed orders that are traded at a price other than their displayed price. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0x68:
      id: 'trade_break_message'
      doc: 'Sent whenever an execution on Cboe Canada NEO is cancelled. Applications that simply build a Cboe Canada NEO book can ignore Trade Break messages.'
    0x69:
      id: 'trade_correction_message'
      doc: 'Sent whenever an execution on Cboe Canada NEO is corrected. Applications that simply build a Cboe Canada NEO book can ignore Trade Correction messages.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'Sent for each unit when the unit shuts down. No additional sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
  security_type:
    1:
      id: 'equity'
      doc: 'Equity'
    2:
      id: 'debt'
      doc: 'Debt'
    3:
      id: 'closed_end_fund'
      doc: 'Closed End Fund'
    4:
      id: 'depositary_receipt'
      doc: 'Depositary Receipt'
    5:
      id: 'exchange_traded_fund'
      doc: 'Exchange Traded Fund'
    6:
      id: 'foreign_listed_security'
      doc: 'Foreign Listed Security'
    7:
      id: 'structured_product'
      doc: 'Structured Product'
    8:
      id: 'unit'
      doc: 'Unit'
    9:
      id: 'warrant'
      doc: 'Warrant'
    52:
      id: 'unlisted_security'
      doc: 'Unlisted Security'
  order_book_type:
    0:
      id: 'all_books'
      doc: 'All Books'
    3:
      id: 'neol'
      doc: 'Neol'
    4:
      id: 'neon'
      doc: 'Neon'
    5:
      id: 'neod'
      doc: 'Neod'
    6:
      id: 'crossing_facility'
      doc: 'Crossing Facility'
    7:
      id: 'sst'
      doc: 'Sst'
  trading_status:
    0x41:
      id: 'accepting'
      doc: 'Accepting'
    0x46:
      id: 'halted_full'
      doc: 'Halted Full'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4d:
      id: 'delayed_closing'
      doc: 'Delayed Closing'
    0x4f:
      id: 'preclose'
      doc: 'Preclose'
    0x50:
      id: 'post_close'
      doc: 'Post Close'
    0x53:
      id: 'trading_suspended'
      doc: 'Trading Suspended'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x58:
      id: 'extended_trading'
      doc: 'Extended Trading'
  trading_sub_status:
    0x20:
      id: 'none'
      doc: 'None'
    0x43:
      id: 'closing_offset'
      doc: 'Closing Offset'
    0x44:
      id: 'delayed'
      doc: 'Delayed'
    0x49:
      id: 'imbalance'
      doc: 'Imbalance'
    0x4f:
      id: 'halt_lift_schedule_for_opening'
      doc: 'Halt Lift Schedule For Opening'
    0x52:
      id: 'halt_lift_schedule_for_re_opening'
      doc: 'Halt Lift Schedule For Re Opening'
  halt_reason:
    0x20:
      id: 'none'
      doc: 'None'
    0x42:
      id: 'business'
      doc: 'Business'
    0x43:
      id: 'cease_trading_order'
      doc: 'Cease Trading Order'
    0x49:
      id: 'ipo'
      doc: 'Ipo'
    0x52:
      id: 'regulatory'
      doc: 'Regulatory'
    0x53:
      id: 'suspension'
      doc: 'Suspension'
  cross_type:
    0:
      id: 'none'
      doc: 'None'
    5:
      id: 'internal_cross'
      doc: 'Internal Cross'
    11:
      id: 'basis_cross'
      doc: 'Basis Cross'
    12:
      id: 'contingent_cross'
      doc: 'Contingent Cross'
    14:
      id: 'vwap_cross'
      doc: 'Vwap Cross'
    15:
      id: 'regular_cross'
      doc: 'Regular Cross'
    18:
      id: 'derivative_cross'
      doc: 'Derivative Cross'
    19:
      id: 'closing_price_publication'
      doc: 'Closing Price Publication'
    20:
      id: 'net_asset_value_nav'
      doc: 'Net Asset Value Nav'
  settlement_type:
    0:
      id: 'no_special_settlement_terms_specified'
      doc: 'No Special Settlement Terms Specified'
    1:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'future'
      doc: 'Future'
    11:
      id: 'nonnet'
      doc: 'Nonnet'

