# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlEquities TopOfMarket Mach v1.1.a
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.1.a
#   Date: 11/05/2020
#   Specification: MIAX_PEARL_Equities_ToM_Feed_v1.1a.pdf
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
  id: miax_pearlequities_topofmarket_mach_v1_1_a
  title: Miax PearlEquities TopOfMarket Mach v1.1.a
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Equities Top Of Market Mach v1.1.a'
doc-ref: https://www.miaxequities.com/interface-specifications/pearl-equities

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this data packet'
      - id: mach_packet_length
        type: u2
        doc: 'Length of the packet. This includes the header and application data'
      - id: mach_packet_type
        type: u1
        enum: mach_packet_type
        doc: 'protocol packet type'
      - id: session_number
        type: u1
        doc: 'protocol packet type'
      - id: payload
        type:
          switch-on: mach_packet_type
          cases:
            'mach_packet_type::application_message': application_message
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.mach_packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::symbol_update_message': symbol_update_message
            'message_type::system_state_message': system_state_message
            'message_type::security_trading_status_notification_message': security_trading_status_notification_message
            'message_type::compact_top_of_market_best_bid_and_offer_message': compact_top_of_market_best_bid_and_offer_message
            'message_type::wide_top_of_market_best_bid_and_offer_message': wide_top_of_market_best_bid_and_offer_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_cancel_message': trade_cancel_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  symbol_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: ticker_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ticker symbol for the security in NASDAQ Integrated Platform format'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: test_security_indicator
        type: u1
        enum: test_security_indicator
        doc: '‘Y’ – Yes, ‘N’ – No'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: lot_size
        type: u2
        doc: 'Round Lot size in shares'
      - id: opening_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. Eg: 09:30:00'
      - id: closing_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. Eg: 16:00:00'
      - id: primary_market_code
        type: u1
        enum: primary_market_code
        doc: 'Primary Market Code Enum'
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: ToM1.0'
      - id: session_id
        type: u1
        doc: 'Current trading session identifier'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'System Status enum'
  security_trading_status_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status enums'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'Market State enum'
      - id: short_sale_restriction
        type: u1
        enum: short_sale_restriction
        doc: 'Current state of short sale restriction'
  compact_top_of_market_best_bid_and_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: bid_price
        type: decimal_u2_2
        doc: 'Displayed bid price. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'Aggregate size in shares at the displayed bid price'
      - id: offer_price
        type: decimal_u2_2
        doc: 'Displayed offer price. Implied decimal with scale 1e-2'
      - id: offer_size
        type: u2
        doc: 'Aggregate size in shares at the displayed offer price'
  wide_top_of_market_best_bid_and_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: bid_price
        type: decimal_u2_2
        doc: 'Displayed bid price. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'Aggregate size in shares at the displayed bid price'
      - id: offer_price
        type: decimal_u2_2
        doc: 'Displayed offer price. Implied decimal with scale 1e-2'
      - id: offer_size
        type: u2
        doc: 'Aggregate size in shares at the displayed offer price'
  last_sale_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'Trade correction number. Set to zero for new trades. Increments by 1 for each subsequent correction'
      - id: price
        type: decimal_u8_6
        doc: 'Execution price. Implied decimal with scale 1e-6'
      - id: size
        type: u4
        doc: 'Number of shares executed'
      - id: flags
        type: str
        size-eos: true
        encoding: ASCII
  trade_cancel_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds part of the time that applies to this message. Nanoseconds since Second epoch'
      - id: symbol_id
        type: u4
        doc: 'Symbol ID mapped to a given symbol. It is assigned per trading session and is valid for that session'
      - id: trade_id
        type: u8
        doc: 'Unique ID assigned by the Matching Engine'
      - id: correction_number
        type: u1
        doc: 'Trade correction number. Set to zero for new trades. Increments by 1 for each subsequent correction'
      - id: price
        type: decimal_u8_6
        doc: 'Execution price. Implied decimal with scale 1e-6'
      - id: size
        type: u4
        doc: 'Number of shares executed'
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  mach_packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    49:
      id: 'system_time_message'
      doc: 'This is the message format that will be used to disseminate the “seconds” part of the timestamp that is applicable to all messages that are sent in the current second.'
    1:
      id: 'symbol_update_message'
      doc: 'This is the message format that will be used to disseminate all security symbols traded on MIAX PEARL Equities for the current trading session. The Symbol ID sent in this message will be disseminated in Top of Market and Last Sale messages.'
    83:
      id: 'system_state_message'
      doc: 'This is the message format that will be used to notify firms of the state changes of the system. This is a notification that applies to all symbols on the feed. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    4:
      id: 'security_trading_status_notification_message'
      doc: 'This is the message format that will be used to notify firms of changes to the trading status of a particular security.'
    2:
      id: 'compact_top_of_market_best_bid_and_offer_message'
      doc: 'This is the message format that will be used to publish MIAX PEARL Best Bid and Offer (MPBBO) of a security with MPBBO values that can fit in this compact format. In the compact format both bid and offer prices have 2 decimal places and are limited to a maximum value of $655.35. Bid and Offer sizes are limited to 65,535 shares.'
    3:
      id: 'wide_top_of_market_best_bid_and_offer_message'
      doc: 'This is the message format that will be used to publish MIAX PEARL Best Bid and Offer (MPBBO) of a security with MPBBO values that will not fit in the compact format.'
    10:
      id: 'last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on MIAX PEARL Equities during the current trading session. It includes a Trade ID that is unique to the trade across the exchange for the trading day. Trade corrections will also be disseminated using the same message format.'
    11:
      id: 'trade_cancel_message'
      doc: 'This is the message format that will be used to disseminate canceled trades that are resulting from Trade cancellations on MIAX PEARL Equities during the current trading session.'
  test_security_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  primary_market_code:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x48:
      id: 'miax_pearl_equities'
      doc: 'Miax Pearl Equities'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'cboe_edga_exchange'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx_exchange'
      doc: 'Cboe Edgx Exchange'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
    0x4e:
      id: 'new_york_stock_exchange'
      doc: 'New York Stock Exchange'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x55:
      id: 'members_exchange'
      doc: 'Members Exchange'
    0x56:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x57:
      id: 'cboe_stock_exchange'
      doc: 'Cboe Stock Exchange'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x59:
      id: 'cboe_byx_exchange'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx_exchange'
      doc: 'Cboe Bzx Exchange'
  system_status:
    0x53:
      id: 'start'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end'
      doc: 'End Of System Hours'
    0x31:
      id: 'start_x31'
      doc: 'Start Of Test Session Sent Before Tests'
    0x32:
      id: 'end_x32'
      doc: 'End Of Test Session'
  trading_status:
    1:
      id: 'pre_open'
      doc: 'Pre Open'
    2:
      id: 'trading'
      doc: 'Trading'
    3:
      id: 'halt'
      doc: 'Halt'
    4:
      id: 'operational_halt'
      doc: 'Operational Halt'
    5:
      id: 'closed'
      doc: 'Closed'
  market_state:
    1:
      id: 'pre_opening'
      doc: 'Pre Opening'
    2:
      id: 'early_trading'
      doc: 'Early Trading Session Future Implementation'
    3:
      id: 'regular_trading'
      doc: 'Regular Trading Session'
    4:
      id: 'after_hours_trading'
      doc: 'After Hours Trading Session Future Implementation'
  short_sale_restriction:
    0x59:
      id: 'ssr_in_effect'
      doc: 'Short Sale Restriction Is In Effect'
    0x4e:
      id: 'ssr_not_in_effect'
      doc: 'Short Sale Restriction Is Not In Effect'

