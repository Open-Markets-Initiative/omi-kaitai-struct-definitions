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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nse_nseix_recovery_tbt_v1_4_client
  title: Nse NseIx Recovery Tbt v1.4
  license: MIT-0
  endian: le

doc: 'National Stock Exchange of India Ltd NSE International Exchange Mtbt Tick Data Recovery Tbt v1.4'
doc-ref: https://www.nseix.com/technology/tradingprotocol

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
        size-eos: true
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
        type: s4
        doc: 'Requested Message Sequence Number'
      - id: end_sequence_number
        type: s4
        doc: 'Requested Message Sequence Number'

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

