# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo Mtbt Binary v6.9
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Multicast Tick By Tick
#   Encoding: Binary
#   Version: 6.9
#   Date: 4/1/2026
#   Specification: MTBT_FO_NNF_PROTOCOL_6_9_20260717161139.pdf
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
  id: nse_nsefo_mtbt_binary_v6_9
  title: Nse NseFo Mtbt Binary v6.9
  license: GPL-3.0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE Futures & Options Multicast Tick By Tick Binary v6.9'
doc-ref: https://www.nseindia.com/market-data/market-data-fo

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
        doc: 'Identifies a particular stream [2, Short]'
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
            'message_type::order_message': order_message
            'message_type::order_message_x4d': order_message
            'message_type::order_message_x58': order_message
            'message_type::trade_message': trade_message
            'message_type::spread_order_message': spread_order_message
            'message_type::spread_order_message_x48': spread_order_message
            'message_type::spread_order_message_x4a': spread_order_message
            'message_type::spread_trade_message': spread_trade_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::heartbeat_message': heartbeat_message
  order_message:
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
        doc: 'Price of the order (In Paise), in multiples of the tick size. Divide by 100 to convert into Rupees. Implied decimal with scale 1e-2'
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
        doc: 'Trade Price (In Paise), in multiples of the tick size. Divide by 100 to convert into Rupees. Implied decimal with scale 1e-2'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
  spread_order_message:
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
        doc: 'Price of the order (In Paise), in multiples of the tick size. Divide by 100 to convert into Rupees. Implied decimal with scale 1e-2'
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
        doc: 'Trade Price (In Paise), in multiples of the tick size. Divide by 100 to convert into Rupees. Implied decimal with scale 1e-2'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
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
        doc: 'Trade Price (In Paise), in multiples of the tick size. Divide by 100 to convert into Rupees. Implied decimal with scale 1e-2'
      - id: trade_quantity
        type: s4
        doc: 'Trade Quantity'
  heartbeat_message:
    seq:
      - id: last_sequence_no
        type: u4
        doc: 'Last sent data sequence number of the Stream'
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
      id: 'order_message'
      doc: 'Sent for every new order request, modification request, or cancellation request. All new order requests are sent including the active orders. Modifications and cancellations must be handled at the client end on the basis of Order Id and not on Price.'
    0x4d:
      id: 'order_message_x4d'
      doc: 'Sent for every new order request, modification request, or cancellation request. All new order requests are sent including the active orders. Modifications and cancellations must be handled at the client end on the basis of Order Id and not on Price.'
    0x58:
      id: 'order_message_x58'
      doc: 'Sent for every new order request, modification request, or cancellation request. All new order requests are sent including the active orders. Modifications and cancellations must be handled at the client end on the basis of Order Id and not on Price.'
    0x54:
      id: 'trade_message'
      doc: 'Sent whenever an order in the order book gets executed fully or partially. Either Buy Order Id or Sell Order Id can be zero, in which case that Order Id should be ignored.'
    0x47:
      id: 'spread_order_message'
      doc: 'FO and CD segments only. Sent for every new spread order request, modification request, or cancellation request. All new spread order requests are sent including the active orders.'
    0x48:
      id: 'spread_order_message_x48'
      doc: 'FO and CD segments only. Sent for every new spread order request, modification request, or cancellation request. All new spread order requests are sent including the active orders.'
    0x4a:
      id: 'spread_order_message_x4a'
      doc: 'FO and CD segments only. Sent for every new spread order request, modification request, or cancellation request. All new spread order requests are sent including the active orders.'
    0x4b:
      id: 'spread_trade_message'
      doc: 'FO and CD segments only. Sent whenever a spread order in the order book gets executed fully or partially. Either Buy Order Id or Sell Order Id can be zero, in which case that Order Id should be ignored.'
    0x43:
      id: 'trade_cancel_message'
      doc: 'CM and FO segments only. Sent whenever a Trade gets cancelled.'
    0x5a:
      id: 'heartbeat_message'
      doc: 'Sent when there is no data available for a few seconds, on all Streams. The sequence number field in the Global Header will have the value 0 (zero) for this message.'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'

