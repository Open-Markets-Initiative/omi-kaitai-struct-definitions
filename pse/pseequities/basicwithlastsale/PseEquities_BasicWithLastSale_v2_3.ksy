# ---------------------------------------------------------------------
# Kaitai struct definition for: Pse PseEquities BasicWithLastSale Itch v2.3
#
# Protocol:
#   Organization: Philippine Stock Exchange
#   Protocol: Pse Equities Itch Basic With Last Sale
#   Encoding: Itch
#   Version: 2.3
#   Date: 10/5/2018
#   Specification: PSE_Equities_Feed_Specification_v2.3.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: pse_pseequities_basicwithlastsale_itch_v2_3
  title: Pse PseEquities BasicWithLastSale Itch v2.3
  license: MIT-0
  endian: be

doc: 'Philippine Stock Exchange Philippine Stock Exchange Equities Pse Equities Itch Basic With Last Sale Itch v2.3'
doc-ref: https://www.pse.com.ph/data-products/

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
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
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_stamp_seconds_message': time_stamp_seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::trading_schedule_message': trading_schedule_message
            'message_type::price_tick_size_message': price_tick_size_message
            'message_type::quantity_tick_size_message': quantity_tick_size_message
            'message_type::orderbook_directory_message': orderbook_directory_message
            'message_type::orderbook_restrictions_message': orderbook_restrictions_message
            'message_type::orderbook_trading_action_message': orderbook_trading_action_message
            'message_type::trade_message': trade_message
            'message_type::trade_with_broker_id_message': trade_with_broker_id_message
            'message_type::bbo_quotation_message': bbo_quotation_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_stamp_seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping (Board level only)'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
  trading_schedule_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping (Board level only)'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: scheduled_time
        type: second_timestamp
        doc: 'Number of seconds past midnight that the event is scheduled. Seconds since Midnight epoch'
  price_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Indicates the Tick Size Table id'
      - id: tick_size_integer_4
        type: u4
        doc: 'Price Tick Size'
      - id: price_start
        type: u4
        doc: 'Start of Price for this Tick Size'
  quantity_tick_size_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: tick_size_table_id
        type: u4
        doc: 'Indicates the Tick Size Table id'
      - id: tick_size_integer_8
        type: u8
        doc: 'Quantity Tick Size'
      - id: quantity_start
        type: u8
        doc: 'Start of Quantity for this Tick Size'
  orderbook_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Indicates ''per unit'' price type or price as percentage'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code'
      - id: sec_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: group
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Id for symbol grouping (Board level only)'
      - id: lot_size
        type: u8
        doc: 'Lot size for the orderbook'
      - id: quantity_tick_size_table_id
        type: u4
        doc: 'Quantity Tick Size Table'
      - id: price_tick_size_table_id
        type: u4
        doc: 'Price Tick Size Table Id'
      - id: price_decimals
        type: u4
        doc: 'Decimals for price fields across all messages for this orderbook'
      - id: delisting_date
        type: yyyymmdd_date_nullable
        doc: 'YYYYMMDD. Nullable, No Delisting Date = 0'
      - id: delisting_time
        type: hhmmss_time
        doc: 'HHMMSS'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument Type'
      - id: shares
        type: u8
        doc: 'The number of shares outstanding'
      - id: product_code
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code for the orderbook'
  orderbook_restrictions_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: short_sell_eligible
        type: u1
        enum: short_sell_eligible
        doc: 'Short Sell Eligible'
      - id: high_collar
        type: u4_nullable
        doc: 'Maximum allowed price via static limit. Nullable, No Limit = 2147483647'
      - id: low_collar
        type: u4_nullable
        doc: 'Minimum allowed price via static limit. Nullable, No Limit = 2147483647'
      - id: cb_limit_up
        type: u4_nullable
        doc: 'Circuit breaker maximum movement allowed up as a percentage from the Last Traded Price (dynamic limit). Nullable, No Limit = 0'
      - id: cb_limit_down
        type: u4_nullable
        doc: 'Circuit breaker maximum movement allowed down as a percentage from the Last Traded Price (dynamic limit). Nullable, No Limit = 0'
      - id: cb_limit_decimals
        type: u4
        enum: cb_limit_decimals
        doc: 'Decimals to apply to the CB Limit Up % and CB Limit Down % values'
  orderbook_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Current trading state for orderbook'
      - id: reason
        type: u1
        enum: reason
        doc: 'Refer to reason in table below'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u8
        doc: 'The number of shares executed'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected in volume calculations'
      - id: execution_price
        type: u4
        doc: 'The price at which the execution occurred'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: trade_indicator
        type: u1
        enum: trade_indicator
        doc: 'Indicates the type of trade'
  trade_with_broker_id_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: executed_quantity
        type: u8
        doc: 'The number of shares executed'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected in volume calculations'
      - id: execution_price
        type: u4
        doc: 'The price at which the execution occurred'
      - id: match_number
        type: u8
        doc: 'The day unique match identifier'
      - id: trade_indicator
        type: u1
        enum: trade_indicator
        doc: 'Indicates the type of trade'
      - id: buy_broker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker identifier of the buy side of the trade'
      - id: sell_broker_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker identifier of the sell side of the trade'
  bbo_quotation_message:
    seq:
      - id: timestamp
        type: nanosecond_offset
        doc: 'Nanoseconds since last Time Stamp seconds message. Nanoseconds since Second epoch'
      - id: orderbook
        type: u4
        doc: 'Used to identify if the event applies to a single orderbook within the Group'
      - id: best_bid_price
        type: u4_nullable
        doc: 'Best Bid price for the orderbook, or reference price update. Nullable, No Bid Depth = 2147483647'
      - id: best_bid_size
        type: u8_nullable
        doc: 'Aggregated number of visible shares at the best bid price. Nullable, Reference Price Update = 9223372036854775807'
      - id: best_offer_price
        type: u4_nullable
        doc: 'Best Offer price for the orderbook. Nullable, No Offer Depth = 2147483647'
      - id: best_offer_size
        type: u8_nullable
        doc: 'Aggregated number of visible shares at the best offer price. Nullable, Reference Price Update = 9223372036854775807'
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == 0
  hhmmss_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000 % 100
      minute:
        value: time / 100 % 100
      second:
        value: time % 100
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 2147483647
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 9223372036854775807

enums:
  message_type:
    0x54:
      id: 'time_stamp_seconds_message'
      doc: 'Time Stamp - Seconds Message.'
    0x53:
      id: 'system_event_message'
      doc: 'System Event Message.'
    0x73:
      id: 'trading_schedule_message'
      doc: 'Trading Schedule Message.'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Tick Size Table.'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'Tick Size Table.'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook Directory Message.'
    0x6b:
      id: 'orderbook_restrictions_message'
      doc: 'Orderbook Restrictions Message.'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'Stock Trading Action Message.'
    0x50:
      id: 'trade_message'
      doc: 'Trade Message.'
    0x70:
      id: 'trade_with_broker_id_message'
      doc: 'Trade (with Broker ID) Message.'
    0x4f:
      id: 'bbo_quotation_message'
      doc: 'BBO Quotation Message.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. This is the first message sent.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start of System Hours. The Pre-Open Session commences.'
    0x52:
      id: 'pre_open_no_cancellation_period'
      doc: 'Pre-Open No Cancellation period.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start of Market Hours. The Pre-Open uncross occurs, and continuous trading begins.'
    0x41:
      id: 'scheduled_break_begins'
      doc: 'The scheduled Break in trading begins.'
    0x42:
      id: 'scheduled_break_ends'
      doc: 'The scheduled Break in trading ends.'
    0x4c:
      id: 'pre_close_commences'
      doc: 'Pre-Close commences.'
    0x4a:
      id: 'pre_close_no_cancellation_period'
      doc: 'Pre-Close No Cancellation period.'
    0x50:
      id: 'trading_at_last'
      doc: 'Trading At Last. The Closing Auction uncross occurs, and traders can then enter limit orders for execution at the determined closing price.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End Of Market Hours.'
    0x45:
      id: 'end_of_trading'
      doc: 'End Of Trading. It indicates that the Exchange is closed.'
    0x43:
      id: 'end_of_system_messages'
      doc: 'End of System Messages. Last message sent.'
  price_type:
    0x55:
      id: 'per_unit'
      doc: '''per unit'' price type'
    0x50:
      id: 'percentage'
      doc: 'price as percentage'
  instrument_type:
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x45:
      id: 'etf'
      doc: 'ETF'
    0x44:
      id: 'pdr'
      doc: 'PDR'
    0x49:
      id: 'index'
      doc: 'Index'
  short_sell_eligible:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  cb_limit_decimals:
    0: 'zero_decimals'
    1: 'one_decimals'
    2: 'two_decimals'
    3: 'three_decimals'
    4: 'four_decimals'
    5: 'five_decimals'
    6: 'six_decimals'
    7: 'seven_decimals'
    8: 'eight_decimals'
    9: 'nine_decimals'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  reason:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x53:
      id: 'suspended_by_market_control'
      doc: 'Suspended By Market Control'
    0x46:
      id: 'frozen_due_to_circuit_breaker'
      doc: 'Frozen due to circuit breaker (dynamic limit)'
    0x48:
      id: 'halted'
      doc: 'Halted (intraday auction)'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'Non Printable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  trade_indicator:
    0x20:
      id: 'regular_trade'
      doc: 'regular trade'
    0x43:
      id: 'intentional_cross_trade'
      doc: 'intentional cross trade (the same user simultaneously entered both sides of the trade)'
    0x42:
      id: 'block_sale'
      doc: 'block sale'
    0x4d:
      id: 'manual_trade'
      doc: 'manual trade (market control)'

