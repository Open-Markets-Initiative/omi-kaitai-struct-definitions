# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCom Recovery Binary v6.9
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Mtbt Tick Data Recovery
#   Encoding: Binary
#   Version: 6.9
#   Date: 4/1/2026
#   Specification: MTBT_CO_NNF_PROTOCOL_6_9_20260717161039.pdf
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
  id: nse_nsecom_recovery_binary_v6_9_tcp
  title: Nse NseCom Recovery Binary v6.9
  license: GPL-3.0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE Commodity Derivatives Mtbt Tick Data Recovery Binary v6.9'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: stream_header
    type: stream_header_struct
    doc: 'STREAM_HEADER'
  - id: message
    type: message_struct
    doc: 'STREAM_DATA. First field is always Message Type and must be read/interpreted first'

types:
  stream_header_struct:
    seq:
      - id: message_length
        type: s2
        doc: 'Total size of the packet including Stream Header and Stream Data [2, Short]'
      - id: stream_id
        type: s2
        doc: 'Unique Stream Reference'
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
        type:
          switch-on: message_type
          cases:
            'message_type::new_order_message': new_order_message
            'message_type::order_modification_message': order_modification_message
            'message_type::order_cancellation_message': order_cancellation_message
            'message_type::trade_message': trade_message
            'message_type::new_spread_order_message': new_spread_order_message
            'message_type::spread_order_modification_message': spread_order_modification_message
            'message_type::spread_order_cancellation_message': spread_order_cancellation_message
            'message_type::spread_trade_message': spread_trade_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::heartbeat_message': heartbeat_message
            'message_type::tick_data_recovery_response_message': tick_data_recovery_response_message
  new_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  order_modification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  order_cancellation_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Trade Price (In Paise). Implied decimal with scale 1e-2'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
  new_spread_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_order_modification_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_order_cancellation_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Price of the order (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  spread_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Trade Price (In Paise). Implied decimal with scale 1e-2'
      - id: quantity
        type: s4
        doc: 'Quantity of the order'
  trade_cancel_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
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
        type: decimal_s4_2
        doc: 'Trade Price (In Paise). Implied decimal with scale 1e-2'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
  heartbeat_message:
    seq:
      - id: last_sequence_no
        type: u4
        doc: 'Last sent data sequence no. of the Stream'
  tick_data_recovery_response_message:
    seq:
      - id: request_status
        type: u1
        enum: request_status
        doc: 'Request Status'
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
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x4e:
      id: 'new_order_message'
      doc: 'For every new order request, this message is sent.'
    0x4d:
      id: 'order_modification_message'
      doc: 'For every order modification request, this message is sent.'
    0x58:
      id: 'order_cancellation_message'
      doc: 'For every order cancellation request, this message is sent.'
    0x54:
      id: 'trade_message'
      doc: 'This message is sent whenever an order in the order book gets executed fully or partially.'
    0x47:
      id: 'new_spread_order_message'
      doc: 'FO and CD segments only. For every new spread order request, this message is sent.'
    0x48:
      id: 'spread_order_modification_message'
      doc: 'FO and CD segments only. For every spread order modification request, this message is sent.'
    0x4a:
      id: 'spread_order_cancellation_message'
      doc: 'FO and CD segments only. For every spread order cancellation request, this message is sent.'
    0x4b:
      id: 'spread_trade_message'
      doc: 'FO and CD segments only. This message is sent whenever a spread order in the order book gets executed fully or partially.'
    0x43:
      id: 'trade_cancel_message'
      doc: 'For CM and FO segments only. This message is sent whenever a Trade gets cancelled.'
    0x5a:
      id: 'heartbeat_message'
      doc: 'Heartbeat message will be sent when there is no data available for a few seconds. Only applicable for UDP TBT multicast channels.'
    0x59:
      id: 'tick_data_recovery_response_message'
      doc: 'First message sent by the Recovery Server, indicating whether the request was processed successfully.'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  request_status:
    0x53:
      id: 'success'
      doc: 'Success'
    0x45:
      id: 'error'
      doc: 'Error'
  client_message_type:
    0x52:
      id: 'tick_data_recovery_request_message'
      doc: 'Sent to the Recovery Server whenever tick data is missed.'

