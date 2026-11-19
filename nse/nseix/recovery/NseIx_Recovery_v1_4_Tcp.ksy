# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseIx Recovery Tbt v1.4
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Mtbt Tick Data Recovery
#   Encoding: Tbt
#   Version: 1.4
#   Date: 1/28/2026
#   Specification: NSEIFSCMTBTAPIv1_4_2_20260324142815.pdf
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
  id: nse_nseix_recovery_tbt_v1_4_tcp
  title: Nse NseIx Recovery Tbt v1.4
  license: MIT-0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE International Exchange Mtbt Tick Data Recovery Tbt v1.4'
doc-ref: https://www.nseix.com/technology/tradingprotocol

seq:
  - id: stream_packet
    type: stream_packet_struct
    repeat: eos
    doc: 'Mtbt Tcp Packet. One STREAM_DATA message per packet, same framing as the multicast feed'

types:
  stream_packet_struct:
    seq:
      - id: stream_header
        type: stream_header
        doc: 'STREAM_HEADER'
      - id: message
        type: message
        doc: 'STREAM_DATA. First field is always Message Type and must be read/interpreted first'
  stream_header:
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
  message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'cMsgType. Code identifying message type [1, Char]'
      - id: payload
        size-eos: true
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
            'message_type::market_status_message': market_status_message
            'message_type::indicative_price_and_quantity_message': indicative_price_and_quantity_message
            'message_type::heartbeat_message': heartbeat_message
            'message_type::tick_data_recovery_response_message': tick_data_recovery_response_message
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Order side: ''B'' - Buy Order, ''S'' - Sell Order'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order (In cents), in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
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
        doc: 'Name of the instrument for which the status change message is being sent, e.g. FUTIDX, OPTIDX'
      - id: status
        type: s2
        enum: status
        doc: '''0'' Preopen, ''1'' Open, ''2'' Closed, ''3'' Preopen-end, ''4'' PreClose, ''5'' PreClose-end'
      - id: session_indc
        type: s2
        enum: session_indc
        doc: '''1'' T Session, ''2'' T+1 Session'
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
        doc: 'Whether the open price or the close price is being determined: ''O'' Indicative open price, ''C'' Indicative close price'
      - id: indicative_price
        type: decimal_s4_4
        doc: 'Indicative open or close price, in multiples of the tick size; divided by 10000 for converting into USD. Implied decimal with scale 1e-4'
      - id: indicative_quantity
        type: s4
        doc: 'Indicative equilibrium quantity which shall be traded at the indicative open or close price'
  heartbeat_message:
    seq:
      - id: last_sequence_no
        type: s4
        doc: 'Last sent data sequence no. of the Stream'
  tick_data_recovery_response_message:
    seq:
      - id: request_status
        type: u1
        enum: request_status
        doc: 'Request Status'
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
  floating_point_integer:
    seq:
      - id: value
        type: f8
    instances:
      integer:
        value: value.as<s8>
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x4e:
      id: 'new_order_message'
      doc: 'Sent for every new order request, including the active orders (section 6.1).'
    0x4d:
      id: 'order_modification_message'
      doc: 'Sent for every order modification request (section 6.1). When the original Order Id is not found, the message is treated as a new order.'
    0x58:
      id: 'order_cancellation_message'
      doc: 'Sent for every order cancellation request (section 6.1). When the original Order Id is not found, the message is ignored.'
    0x54:
      id: 'trade_message'
      doc: 'Sent whenever an order in the order book gets executed fully or partially (section 6.2). Either Buy Order ID or Sell Order ID can be zero, in which case that Order ID should be ignored; both are never zero at the same time.'
    0x47:
      id: 'new_spread_order_message'
      doc: 'Sent for every new spread order request, including the active orders (section 6.3).'
    0x48:
      id: 'spread_order_modification_message'
      doc: 'Sent for every spread order modification request (section 6.3).'
    0x4a:
      id: 'spread_order_cancellation_message'
      doc: 'Sent for every spread order cancellation request (section 6.3).'
    0x4b:
      id: 'spread_trade_message'
      doc: 'Sent whenever a spread order in the order book gets executed fully or partially (section 6.4). Buy Order ID or Sell Order ID can be zero, in which case that Order ID should be ignored.'
    0x53:
      id: 'market_status_message'
      doc: 'Sent whenever the status of the market is changed to preopen, preopen-end, open, closed, preclose and preclose-end, for both T and T+1 sessions (section 6.5).'
    0x50:
      id: 'indicative_price_and_quantity_message'
      doc: 'Indicative equilibrium price and quantity, sent for contracts with pre-open and pre-close sessions, only between the preopen or preclose and the preopen end or preclose end statuses, when the indicative price and quantity are determined or updated during order collection (section 6.6).'
    0x5a:
      id: 'heartbeat_message'
      doc: 'Sent when there is no data available for a few seconds; the sequence number field in the Stream Header will have the value 0 (zero) (section 9).'
    0x59:
      id: 'tick_data_recovery_response_message'
      doc: 'First message sent by the Recovery Server, indicating whether the request was processed successfully; the Stream Header''s sequence number is zero.'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  status:
    0:
      id: 'preopen'
      doc: 'Preopen'
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'preopen_end'
      doc: 'Preopen End'
    4:
      id: 'pre_close'
      doc: 'Pre Close'
    5:
      id: 'pre_close_end'
      doc: 'Pre Close End'
  session_indc:
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
      doc: 'Sent to the Recovery Server on Tcp whenever tick data is missed, with no header; when only one tick is missed Start and End Sequence Number are the same.'

