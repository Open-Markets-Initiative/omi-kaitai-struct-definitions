# ---------------------------------------------------------------------
# Kaitai struct definition for: Nse NseCd Snapshot Binary v7.1
#
# Protocol:
#   Organization: National Stock Exchange of India Ltd
#   Protocol: Mtbt Order Book Snapshot Recovery
#   Encoding: Binary
#   Version: 7.1
#   Date: 9/1/2026
#   Specification: MTBT_CUR_NNF_PROTOCOL_7.1_20260902170936.pdf
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
  id: nse_nsecd_snapshot_binary_v7_1_client
  title: Nse NseCd Snapshot Binary v7.1
  license: GPL-3.0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE Currency Derivatives Mtbt Order Book Snapshot Recovery Binary v7.1'
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
            'client_message_type::order_book_snapshot_recovery_request_message': order_book_snapshot_recovery_request_message
  order_book_snapshot_recovery_request_message:
    seq:
      - id: stream_id
        type: s2
        doc: 'Unique Stream Reference'
      - id: start_sequence_number
        type: u4
        doc: 'The value of this field should be zero'
      - id: end_sequence_number
        type: u4
        doc: 'The value of this field should be zero'

enums:
  trans_code:
    10501:
      id: 'order_book_snapshot'
      doc: 'Transcode carried by every Mtbt order book snapshot buffer'
  message_type:
    0x4e:
      id: 'new_order_message'
      doc: 'Outstanding normal order in the order book at the last snapshot refresh.'
    0x47:
      id: 'new_spread_order_message'
      doc: 'Outstanding spread order in the order book at the last snapshot refresh.'
  order_type:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  client_message_type:
    0x4f:
      id: 'order_book_snapshot_recovery_request_message'
      doc: 'Sent to the Orderbook Snapshot Recovery Server to request the order book snapshot.'
  response_message_type:
    0x42:
      id: 'order_book_snapshot_recovery_response_message'
      doc: 'Sent by the Orderbook Snapshot Recovery Server to indicate whether the request was processed successfully.'
  request_status:
    0x53:
      id: 'success'
      doc: 'Success'
    0x45:
      id: 'error'
      doc: 'Error'

