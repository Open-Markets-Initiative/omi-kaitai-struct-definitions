# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx MtbtNdal Tbt v1.5
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Multicast Tick By Tick Data Feed
#   Encoding: Tbt
#   Version: 1.5
#   Date: 10/13/2025
#   Specification: NDAL_NSEIXMTBTAPIv1_20260324142257.pdf
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
  id: nse_nseix_mtbtndal_tbt_v1_5
  title: Nse NseIx MtbtNdal Tbt v1.5
  license: MIT-0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE International Exchange Multicast Tick By Tick Data Feed Tbt v1.5'
doc-ref: https://www.nseix.com/markets/market_data/realtime_data

seq:
  - id: stream_header
    type: stream_header_struct
    doc: 'STREAM_HEADER'
  - id: message
    type: message_struct
    size: stream_header.message_length - 8
    doc: 'STREAM_DATA. First field is always Message Type and must be read/interpreted first'

types:
  stream_header_struct:
    seq:
      - id: message_length
        type: s2
        doc: 'Total size of the packet including Stream Header and Stream Data [2, Short]'
      - id: stream_id
        type: s2
        doc: 'Identifies a particular stream'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the packet for this Stream Id. For Equity Derivative (FO) segment, this field is unsigned int [4, Uint]'
  message_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'cMsgType. Code identifying message type [1, Char]'
      - id: payload
        size: _root.stream_header.message_length - 8 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::contract_information_message': contract_information_message
            'message_type::spread_contract_information_message': spread_contract_information_message
            'message_type::new_order_message': new_order_message
            'message_type::order_modification_message': order_modification_message
            'message_type::order_cancellation_message': order_cancellation_message
            'message_type::trade_message': trade_message
            'message_type::new_spread_order_message': new_spread_order_message
            'message_type::spread_order_modification_message': spread_order_modification_message
            'message_type::spread_order_cancellation_message': spread_order_cancellation_message
            'message_type::spread_trade_message': spread_trade_message
            'message_type::market_status_message': market_status_message
            'message_type::indicative_price_and_quantity_message': indicative_price_and_quantity_message
            'message_type::market_statistics_information_message': market_statistics_information_message
            'message_type::open_interest_message': open_interest_message
            'message_type::heartbeat_message': heartbeat_message
  contract_information_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: contract_stream_id
        type: s2
        doc: 'Availability of this contract on a particular stream'
      - id: token_number
        type: s4
        doc: 'Unique identifier for contract'
      - id: instrument
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security instrument, e.g. FUTIDX, FUTSTK; commodity instrument, e.g. FUTCOM'
      - id: symbol
        type: str
        size: 10
        encoding: ASCII
        doc: 'Contract Symbol'
      - id: expiry_date
        type: dos_second_timestamp
        doc: 'Expiry date of contract in seconds from 01-Jan-1980 00:00:00. Seconds since Dos epoch'
      - id: strike_price
        type: decimal_s4_4_nullable
        doc: 'Strike Price of Contract (In Cents), divided by 10000 for converting into USD; zero for a futures contract. Implied decimal with scale 1e-4. Nullable, Futures Contract = 0'
      - id: option_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Option Type for the contract'
      - id: low_price_range
        type: s4
        doc: 'Minimum price at which an order can be placed without causing a price freeze; divided by 10000 for all contracts except INRUSD, which is divided by 100'
      - id: high_price_range
        type: s4
        doc: 'Maximum price at which an order can be placed without causing a price freeze; divided by 10000 for all contracts except INRUSD, which is divided by 100'
      - id: daily_contract_indicator
        type: u1
        enum: daily_contract_indicator
        doc: 'Indicates whether the contract is categorized as a Daily contract'
  spread_contract_information_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: contract_stream_id
        type: s2
        doc: 'Availability of this contract on a particular stream'
      - id: token_1
        type: s4
        doc: 'Token No. of First Spread Contract'
      - id: token_2
        type: s4
        doc: 'Token No. of Second Spread Contract'
      - id: day_low_price_diff_range
        type: decimal_s4_4
        doc: 'Day low price difference range for the combination, which may be changed intraday; divided by 10000 to get the actual price. Implied decimal with scale 1e-4'
      - id: day_high_price_diff_range
        type: decimal_s4_4
        doc: 'Day high price difference range for the combination, which may be changed intraday; divided by 10000 to get the actual price. Implied decimal with scale 1e-4'
      - id: operating_range_low_price_diff_range
        type: decimal_s4_4
        doc: 'Minimum price difference at which the spread order could be placed without being rejected by the system, which may be changed intraday and flexed; divided by 10000 to get the actual price. Implied decimal with scale 1e-4'
      - id: operating_range_high_price_diff_range
        type: decimal_s4_4
        doc: 'Maximum price difference at which the spread order could be placed without being rejected by the system, which may be changed intraday and flexed; divided by 10000 to get the actual price. Implied decimal with scale 1e-4'
  new_order_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  order_modification_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  order_cancellation_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  trade_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: buy_order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number for Buy-Side Order'
      - id: sell_order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number for Sell-Side Order'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: trade_price
        type: decimal_s4_4
        doc: 'Trade Price (In cents), at which the trade took place, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
  new_spread_order_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_order_modification_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_order_cancellation_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type Values'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), at which the order is placed, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_trade_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: buy_order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number for Buy-Side Order'
      - id: sell_order_id
        type: floating_point_integer
        doc: 'Day Unique Order Reference Number for Sell-Side Order'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: trade_price
        type: decimal_s4_4
        doc: 'Trade Price (In cents), at which the trade took place, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  market_status_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: instrument
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security instrument, e.g. FUTIDX, FUTSTK; commodity instrument, e.g. FUTCOM'
      - id: status
        type: s2
        enum: status
        doc: 'Market status'
      - id: session_indicator
        type: s2
        enum: session_indicator
        doc: 'Trading session'
  indicative_price_and_quantity_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: identifier
        type: u1
        enum: identifier
        doc: 'Whether the open price or the close price is being determined'
      - id: indicative_price
        type: decimal_s4_4
        doc: 'Indicative open or close price, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: indicative_quantity
        type: s4
        doc: 'Indicative equilibrium quantity which shall be traded at the indicative open or close price'
  market_statistics_information_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: opening_price
        size: 8
        doc: 'Contract open price for the day'
      - id: trade_high_price
        size: 8
        doc: 'Contract high price for the day'
      - id: trade_low_price
        size: 8
        doc: 'Contract low price for the day'
      - id: closing_price
        size: 8
        doc: 'Contract close price for the day'
      - id: last_traded_price
        size: 8
        doc: 'Contract last traded price for the day'
      - id: previous_close_price
        size: 8
        doc: 'Contract previous day''s close price'
      - id: settlement_price
        size: 8
        doc: 'Contract settlement price for the day; zero for the USAIDR instrument'
      - id: total_traded_quantity
        type: s4
        doc: 'Volume traded today for the contract'
      - id: total_traded_value
        type: floating_point_integer
        doc: 'Total traded value for the contract; divided by 10000 to get the value in USD, and by 100000 to get it in lakhs of USD'
      - id: statistics_open_interest
        type: s4
        doc: 'Contract open interest; zero for the USAIDR instrument'
      - id: change_in_open_interest
        type: s4
        doc: 'Contract change in open interest; zero for the USAIDR instrument'
      - id: session_indicator
        type: s2
        enum: session_indicator
        doc: 'Trading session'
  open_interest_message:
    seq:
      - id: timestamp
        type: dos_nanosecond_timestamp
        doc: 'Time in nanoseconds from 01-Jan-1980 00:00:00. Nanoseconds since Dos epoch'
      - id: token
        type: s4
        doc: 'Unique Contract Identifier'
      - id: open_interest
        type: s4
        doc: 'Contract open interest'
  heartbeat_message:
    seq:
      - id: last_sequence_no
        type: s4
        doc: 'Last sent data sequence no. of the stream'
  dos_nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      unix_seconds:
        value: time / 1000000000 + 315532800
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  dos_second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      unix_seconds:
        value: time + 315532800
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s4_4_nullable:
    seq:
      - id: value
        type: decimal_s4_4
    instances:
      is_null:
        value: value.mantissa == 0
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>

enums:
  message_type:
    0x63:
      id: 'contract_information_message'
      doc: 'Beginning of day contract master information, sent before the market opens on Stream Id no. 99, for contracts valid in the NSE IX market.'
    0x64:
      id: 'spread_contract_information_message'
      doc: 'Information about the spread contracts valid in the NSE IX market, sent on Stream Id no. 99.'
    0x4e:
      id: 'new_order_message'
      doc: 'For every new order request, this message is sent. All new order requests are sent, including the active orders.'
    0x4d:
      id: 'order_modification_message'
      doc: 'For every order modification request, this message is sent. Modifications must be handled on the basis of Order Id and not on Price; one whose original Order Id is not found should be treated as a New Order.'
    0x58:
      id: 'order_cancellation_message'
      doc: 'For every order cancellation request, this message is sent. Cancellations must be handled on the basis of Order Id and not on Price; one whose original Order Id is not found should be ignored.'
    0x54:
      id: 'trade_message'
      doc: 'Sent whenever an order in the order book gets executed fully or partially. Either Buy Order ID or Sell Order ID can be zero, in which case that Order ID should be ignored; both are never zero at the same time.'
    0x47:
      id: 'new_spread_order_message'
      doc: 'For every new spread order request, this message is sent. All new spread order requests are sent, including the active orders.'
    0x48:
      id: 'spread_order_modification_message'
      doc: 'For every spread order modification request, this message is sent.'
    0x4a:
      id: 'spread_order_cancellation_message'
      doc: 'For every spread order cancellation request, this message is sent.'
    0x4b:
      id: 'spread_trade_message'
      doc: 'Sent whenever a spread order in the order book gets executed fully or partially. Either Buy Order ID or Sell Order ID can be zero, in which case that Order ID should be ignored.'
    0x53:
      id: 'market_status_message'
      doc: 'Sent whenever the status of the market is changed to pre-open, pre-open end, open, closed, pre-close or pre-close end, for both T and T+1 sessions.'
    0x50:
      id: 'indicative_price_and_quantity_message'
      doc: 'Indicative equilibrium price and quantity, sent for contracts with pre-open and pre-close sessions, only between the pre-open or pre-close and the pre-open end or pre-close end statuses, when the indicative price and quantity are determined or updated during order collection.'
    0x66:
      id: 'market_statistics_information_message'
      doc: 'End of session market statistics (Bhavcopy), sent on Stream Id no. 99.'
    0x6f:
      id: 'open_interest_message'
      doc: 'Open interest of the contracts traded, sent during trading hours on Stream Id no. 99.'
    0x5a:
      id: 'heartbeat_message'
      doc: 'Sent when there is no data available for a few seconds. The sequence number field in the Stream Header will have the value 0 (zero) for this message.'
  daily_contract_indicator:
    0x44:
      id: 'daily_contract'
      doc: 'Daily Contract'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  status:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'pre_open_end'
      doc: 'Pre Open End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
  session_indicator:
    1:
      id: 't_session'
      doc: 'T Session'
    2:
      id: 't_1_session'
      doc: 'T 1 Session'
  identifier:
    0x4f:
      id: 'indicative_open_price'
      doc: 'Indicative Open Price'
    0x43:
      id: 'indicative_close_price'
      doc: 'Indicative Close Price'

