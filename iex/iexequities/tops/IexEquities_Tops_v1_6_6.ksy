# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexEquities Tops IexTp v1.6.6
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Top Of Book
#   Encoding: Investors Exchange Transport Protocol
#   Version: 1.6.6
#   Date: 10/19/2021
#   Specification: IEX TOPS Specification v1.66.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: iexequities_tops_v1_6_6
  title: Iex IexEquities Tops IexTp v1.6.6
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Equities Top Of Book IexTp v1.6.6'
doc-ref: https://www.iexexchange.io/resources/trading/documents

seq:
  - id: iextp_header
    type: iextp_header_struct
    doc: 'IexTp packet header'
  - id: messages
    repeat: expr
    repeat-expr: iextp_header.message_count
    type:
      switch-on: iextp_header.message_count
      cases:
        _: message

types:
  iextp_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Version of transport specification'
      - id: reserved
        size: 1
        doc: 'Reserved byte'
      - id: message_protocol_id
        type: u2
        doc: 'Unique identifier of the higher layer protocol'
      - id: channel_id
        type: u4
        doc: 'Identifies the stream of bytes sequenced messages'
      - id: session_id
        type: u4
        doc: 'Identifies the session'
      - id: payload_length
        type: u2
        doc: 'Byte length of the payload'
      - id: message_count
        type: u2
        doc: 'Number of messages in the payload'
      - id: stream_offset
        type: u8
        doc: 'Byte offset of the data stream'
      - id: first_message_sequence_number
        type: u8
        doc: 'Sequence of the first message in the segment'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of segment. Nanoseconds since Unix epoch'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'IexTp message header'
      - id: message_data
        size: message_header.message_length + 2 - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::security_directory_message': security_directory_message
            'message_type::trading_status_message': trading_status_message
            'message_type::retail_liquidity_indicator_message': retail_liquidity_indicator_message
            'message_type::operational_halt_status_message': operational_halt_status_message
            'message_type::short_sale_price_test_status_message': short_sale_price_test_status_message
            'message_type::quote_update_message': quote_update_message
            'message_type::trade_report_message': trade_report_message
            'message_type::official_price_message': official_price_message
            'message_type::trade_break_message': trade_break_message
            'message_type::auction_information_message': auction_information_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: system_event
        type: u1
        enum: system_event
        doc: 'System event identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
  security_directory_message:
    seq:
      - id: security_directory_flags
        type: security_directory_flags
        doc: 'Security Directory Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: round_lot_size
        type: u4
        doc: 'Number of shares that represent a round lot'
      - id: adjusted_poc_price
        type: decimal_s8_4
        doc: 'Corporate action adjusted previous official closing price. Implied decimal with scale 1e-4'
      - id: luld_tier
        type: u1
        enum: luld_tier
        doc: 'Indicates which Limit Up-Limit Down price band calculation parameter is to be used'
  security_directory_flags:
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: etp
        type: b1
        doc: 'Symbol is an ETP'
      - id: when_issued
        type: b1
        doc: 'Symbol is a when issued security'
      - id: test_security
        type: b1
        doc: 'Symbol is a test security'
  trading_status_message:
    seq:
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading status identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the trading status change'
  retail_liquidity_indicator_message:
    seq:
      - id: retail_liquidity_indicator
        type: u1
        enum: retail_liquidity_indicator
        doc: 'Retail Liquidity Indicator identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
  operational_halt_status_message:
    seq:
      - id: operational_halt_status
        type: u1
        enum: operational_halt_status
        doc: 'Operational halt status identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
  short_sale_price_test_status_message:
    seq:
      - id: short_sale_price_test_status
        type: u1
        enum: short_sale_price_test_status
        doc: 'Reg. SHO short sale price test restriction status'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: detail
        type: u1
        enum: detail
        doc: 'Detail of the Reg. SHO short sale price test restriction status'
  quote_update_message:
    seq:
      - id: quote_update_flags
        type: quote_update_flags
        doc: 'Quote Update Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: bid_size
        type: u4
        doc: 'Aggregate quoted best bid size'
      - id: bid_price
        type: decimal_s8_4
        doc: 'Best quoted bid price. Implied decimal with scale 1e-4'
      - id: ask_price
        type: decimal_s8_4
        doc: 'Best quoted ask price. Implied decimal with scale 1e-4'
      - id: ask_size
        type: u4
        doc: 'Aggregate quoted best ask size'
  quote_update_flags:
    seq:
      - id: unused_6
        type: b6
        doc: 'Unused'
      - id: market_session
        type: b1
        doc: 'Market Session Flag'
      - id: symbol_availability
        type: b1
        doc: 'Symbol is halted, paused, or otherwise not available for trading on IEX'
  trade_report_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Trade volume'
      - id: price
        type: decimal_s8_4
        doc: 'Trade price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier'
  sale_condition_flags:
    seq:
      - id: unused_3
        type: b3
        doc: 'Unused'
      - id: singleprice_cross_trade
        type: b1
        doc: 'Trade resulting from a single-price cross'
      - id: trade_through_exempt
        type: b1
        doc: 'Trade is not subject to Rule 611'
      - id: odd_lot
        type: b1
        doc: 'Odd Lot'
      - id: extended_hours
        type: b1
        doc: 'Extended Hours Trade'
      - id: intermarket_sweep
        type: b1
        doc: 'Intermarket Sweep Order'
  official_price_message:
    seq:
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Price type identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: official_price
        type: decimal_s8_4
        doc: 'Official opening or closing price, as specified. Implied decimal with scale 1e-4'
  trade_break_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Trade volume'
      - id: price
        type: decimal_s8_4
        doc: 'Trade price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier'
  auction_information_message:
    seq:
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type identifier'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: paired_shares
        type: u4
        doc: 'Number of shares paired at the Reference Price using orders on the Auction Book'
      - id: reference_price
        type: decimal_s8_4
        doc: 'Clearing price at or within the Reference Price Range using orders on the Auction Book. Implied decimal with scale 1e-4'
      - id: indicative_clearing_price
        type: decimal_s8_4
        doc: 'Clearing price using Eligible Auction Orders. Implied decimal with scale 1e-4'
      - id: imbalance_shares
        type: u4
        doc: 'Number of unpaired shares at the Reference Price using orders on the Auction Book'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Side of the unpaired shares at the Reference Price using orders on the Auction Book'
      - id: extension_number
        type: str
        size: 1
        encoding: ASCII
        doc: 'Number of extensions an auction received'
      - id: scheduled_auction_time
        type: second_timestamp
        doc: 'Projected time of the auction match. Seconds since Unix epoch'
      - id: auction_book_clearing_price
        type: decimal_s8_4
        doc: 'Clearing price using orders on the Auction Book. Implied decimal with scale 1e-4'
      - id: collar_reference_price
        type: decimal_s8_4
        doc: 'Reference priced used for the auction collar, if any. Implied decimal with scale 1e-4'
      - id: lower_auction_collar
        type: decimal_s8_4
        doc: 'Lower threshold price of the auction collar, if any. Implied decimal with scale 1e-4'
      - id: upper_auction_collar
        type: decimal_s8_4
        doc: 'Upper threshold price of the auction collar, if any. Implied decimal with scale 1e-4'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The System Event Message is used to indicate events that apply to the market or the data feed'
    0x44:
      id: 'security_directory_message'
      doc: 'The System Event Message is used to indicate events that apply to the market or the data feed.'
    0x48:
      id: 'trading_status_message'
      doc: 'The Trading Status Message is used to indicate the current trading status of a security.'
    0x49:
      id: 'retail_liquidity_indicator_message'
      doc: 'broadcasts a real-time Retail Liquidity Indicator Message each time there is an update to IEX''s eligible retail liquidity interest during the trading day'
    0x4f:
      id: 'operational_halt_status_message'
      doc: 'The Exchange may suspend trading of one or more securities on IEX for operational reasons and indicates such operational halt using the Operational Halt Status Message.'
    0x50:
      id: 'short_sale_price_test_status_message'
      doc: 'The Short Sale Price Test Message is used to indicate when a short sale price test restriction is in effect for a security.'
    0x51:
      id: 'quote_update_message'
      doc: 'Tops broadcasts a real-time Quote Update Message each time IEX''s best bid or offer quotation is updated during the trading day'
    0x54:
      id: 'trade_report_message'
      doc: 'Trade Report Messages are sent when an order on the IEX Order Book is executed in whole or in part'
    0x58:
      id: 'official_price_message'
      doc: 'Official Price Messages are sent for each IEX-listed security to indicate the IEX Official Opening Price and IEX Official Closing Price.'
    0x42:
      id: 'trade_break_message'
      doc: 'Trade Break Messages are sent when an execution on IEX is broken on that same trading day'
    0x41:
      id: 'auction_information_message'
      doc: 'Broadcasts an Auction Information Message every one second between the Lock-in Time and the auction match for Opening and Closing Auctions, and during the Display Only Period for IPO, Halt, and Volatility Auctions.'
  system_event:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside Of Heartbeat Messages On The Lower Level Protocol The Start Of Day Message Is The First Message Sent In Any Trading Session'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This Message Indicates That Iex Is Open And Ready To Start Accepting Orders'
    0x52:
      id: 'start_of_regular_market_hours'
      doc: 'This Message Indicates That Day And Gtx Orders As Well As Market Orders And Pegged Orders Are Available For Execution On Iex'
    0x4d:
      id: 'end_of_regular_market_hours'
      doc: 'This Message Indicates That Day Orders Market Orders And Pegged Orders Are No Longer Accepted By Iex'
    0x45:
      id: 'end_of_system_hours'
      doc: 'This Message Indicates That Iex Is Now Closed And Will Not Accept Any New Orders During This Trading Session'
    0x43:
      id: 'end_of_messages'
      doc: 'This Is Always The Last Message Sent In Any Trading Session'
  luld_tier:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'tier_1_nms_stock'
      doc: 'Tier 1 Nms Stock'
    2:
      id: 'tier_2_nms_stock'
      doc: 'Tier 2 Nms Stock'
  trading_status:
    0x48:
      id: 'trading_halted_across_all_us_equity_markets'
      doc: 'Trading Halted Across All Us Equity Markets'
    0x4f:
      id: 'trading_halt_released_into_an_order_acceptance_period_on_iex'
      doc: 'Trading Halt Released Into An Order Acceptance Period On Iex'
    0x50:
      id: 'trading_paused_and_order_acceptance_period_on_iex'
      doc: 'Trading Paused And Order Acceptance Period On Iex'
    0x54:
      id: 'trading_on_iex'
      doc: 'Trading On Iex'
  retail_liquidity_indicator:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x41:
      id: 'buy_interest'
      doc: 'Buy Interest'
    0x42:
      id: 'sell_interest'
      doc: 'Sell Interest'
    0x43:
      id: 'buy_and_sell_interest'
      doc: 'Buy And Sell Interest'
  operational_halt_status:
    0x4f:
      id: 'iex_specific_operational_trading_halt'
      doc: 'Iex Specific Operational Trading Halt'
    0x4e:
      id: 'not_operationally_halted_on_iex'
      doc: 'Not Operationally Halted On Iex'
  short_sale_price_test_status:
    0:
      id: 'not_in_effect'
      doc: 'Not In Effect'
    1:
      id: 'in_effect'
      doc: 'In Effect'
  detail:
    0x20:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x41:
      id: 'activated'
      doc: 'Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In The Security'
    0x43:
      id: 'continued'
      doc: 'Short Sale Price Test Restriction Remains In Effect From Prior Day'
    0x44:
      id: 'deactivated'
      doc: 'Short Sale Price Test Restriction Deactivated'
    0x4e:
      id: 'not_available'
      doc: 'Not Available'
  price_type:
    0x51:
      id: 'iex_official_opening_price'
      doc: 'Iex Official Opening Price'
    0x4d:
      id: 'iex_official_closing_price'
      doc: 'Iex Official Closing Price'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
    0x48:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x56:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
  imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4e:
      id: 'none'
      doc: 'No Imbalance'

