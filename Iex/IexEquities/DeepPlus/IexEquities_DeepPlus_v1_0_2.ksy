# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Iex IexEquities DeepPlus v1.0.2
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: iexequities_deepplus_v1_0_2
  title: Iex IexEquities DeepPlus IexTp v1.0.2
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Equities DeepPlus IexTp v1.0.2'
doc-ref: https://www.iexexchange.io/resources/trading/documents

seq:
  - id: iextp_header
    type: iextp_header
    doc: 'IexTp packet header'
  - id: messages
    repeat: expr
    repeat-expr: iextp_header.message_count
    type:
      switch-on: iextp_header.message_count
      cases:
        _: message

types:
  iextp_header:
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
        type: u8
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
            'message_type::security_event_message': security_event_message
            'message_type::add_order_message': add_order_message
            'message_type::order_modify_message': order_modify_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_executed_message': order_executed_message
            'message_type::trade_message': trade_message
            'message_type::trade_break_message': trade_break_message
            'message_type::clear_book_message': clear_book_message
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
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
  security_directory_message:
    seq:
      - id: security_directory_flags
        type: security_directory_flags
        doc: 'Security Directory Flags'
      - id: timestamp
        type: s8
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
        type: s8
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
        type: s8
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
        type: s8
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
        type: s8
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
        type: s8
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
  security_event_message:
    seq:
      - id: security_event
        type: u1
        enum: security_event
        doc: 'Security event identifier'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
  add_order_message:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: order_id
        type: u8
        doc: 'Order ID of new order'
      - id: size
        type: u4
        doc: 'Quoted size'
      - id: price
        type: s8
        doc: 'Booking price on the IEX Order Book. Implied decimal with scale 1e-4'
  order_modify_message:
    seq:
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: order_id_reference
        type: u8
        doc: 'Order ID of the referenced order'
      - id: size
        type: u4
        doc: 'Quoted size'
      - id: price
        type: s8
        doc: 'Booking price on the IEX Order Book. Implied decimal with scale 1e-4'
  modify_flags:
    seq:
      - id: unused_7
        type: b7
        doc: 'Unused'
      - id: priority
        type: b1
        doc: 'Order Priority'
  order_delete_message:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: order_id_reference
        type: u8
        doc: 'Order ID of the referenced order'
  order_executed_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: order_id_reference
        type: u8
        doc: 'Order ID of the referenced order'
      - id: size
        type: u4
        doc: 'Quoted size'
      - id: price
        type: s8
        doc: 'Booking price on the IEX Order Book. Implied decimal with scale 1e-4'
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
  trade_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Quoted size'
      - id: price
        type: s8
        doc: 'Booking price on the IEX Order Book. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier'
  trade_break_message:
    seq:
      - id: sale_condition_flags
        type: sale_condition_flags
        doc: 'Sale Condition Flags'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'
      - id: size
        type: u4
        doc: 'Quoted size'
      - id: price
        type: s8
        doc: 'Booking price on the IEX Order Book. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'IEX Generated Identifier'
  clear_book_message:
    seq:
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: timestamp
        type: s8
        doc: 'Time stamp of the system event. Nanoseconds since Unix epoch'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security identifier'

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The System Event Message is used to indicate events that apply to the market or the data feed.'
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
    0x45:
      id: 'security_event_message'
      doc: 'The Security Event Message is used to indicate events that apply to a security'
    0x61:
      id: 'add_order_message'
      doc: 'A displayed order that has been added to the IEX Book'
    0x4d:
      id: 'order_modify_message'
      doc: 'A displayed order that had its Price, Size, or Priority component changed as a result of user or system action'
    0x52:
      id: 'order_delete_message'
      doc: 'A displayed order that was removed from the IEX Book'
    0x4c:
      id: 'order_executed_message'
      doc: 'A displayed order that was executed against'
    0x54:
      id: 'trade_message'
      doc: 'A non-displayed order on the book that executed against another non-displayed order on the book'
    0x42:
      id: 'trade_break_message'
      doc: 'Trade Break Messages are sent when an execution on IEX is broken on that same trading day'
    0x43:
      id: 'clear_book_message'
      doc: 'This message is used to indicate that the IEX Book for a symbol has been cleared of all orders'
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
    0x30:
      id: 'not_in_effect'
      doc: 'Not In Effect'
    0x31:
      id: 'in_effect'
      doc: 'In Effect'
  detail:
    0x20:
      id: 'no_price_test_in_place'
      doc: 'No Price Test In Place'
    0x41:
      id: 'short_sale_price_test_restriction_in_effect_due_to_an_intraday_price_drop_in_the_security'
      doc: 'Short Sale Price Test Restriction In Effect Due To An Intraday Price Drop In The Security'
    0x43:
      id: 'short_sale_price_test_restriction_remains_in_effect_from_prior_day'
      doc: 'Short Sale Price Test Restriction Remains In Effect From Prior Day'
    0x44:
      id: 'short_sale_price_test_restriction_deactivated'
      doc: 'Short Sale Price Test Restriction Deactivated'
    0x4e:
      id: 'not_available'
      doc: 'Not Available'
  security_event:
    0x4f:
      id: 'opening_process_complete'
      doc: 'Opening Process Complete'
    0x43:
      id: 'closing_process_complete'
      doc: 'Closing Process Complete'
  side:
    0x38:
      id: 'buy'
      doc: 'Buy'
    0x35:
      id: 'sell'
      doc: 'Sell'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: Investors Exchange
#   Version: 1.0.2
#   Date: 1/14/2025
#   Specification: IEX_DEEP+ Specification v1.02.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
