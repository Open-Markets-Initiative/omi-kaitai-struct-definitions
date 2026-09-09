# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseFo Recovery Binary v6.9
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Mtbt Tick Data Recovery
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
  id: nse_nsefo_recovery_binary_v6_9_client
  title: Nse NseFo Recovery Binary v6.9
  license: GPL-3.0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE Futures & Options Mtbt Tick Data Recovery Binary v6.9'
doc-ref: https://www.nseindia.com/static/trade/platform-services-neat-trading-system-protocols

seq:
  - id: client_message
    type: client_message_struct
    doc: 'Client request. First field is always Message Type and must be read/interpreted first'

types:
  client_message_struct:
    seq:
      - id: client_message_type
        type: u1
        enum: client_message_type
        doc: 'cMsgType. Code identifying message type [1, Char]'
      - id: client_payload
        type:
          switch-on: client_message_type
          cases:
            'client_message_type::tick_data_recovery_request_message': tick_data_recovery_request_message
  tick_data_recovery_request_message:
    seq:
      - id: stream_id
        type: s2
        doc: 'Unique Stream Reference'
      - id: start_sequence_number
        type: u4
        doc: 'Requested Message Sequence Number'
      - id: end_sequence_number
        type: u4
        doc: 'Requested Message Sequence Number'

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

