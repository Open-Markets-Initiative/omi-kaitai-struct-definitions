# ---------------------------------------------------------------------
# Kaitai struct definition for: Currenex OrderService Cbp v26
#
# Protocol:
#   Organization: Currenex
#   Protocol: Order Service
#   Encoding: Currenex Binary Protocol
#   Version: 26
#   Date: 4/6/2024
#   Specification: OUCH-Spec.pdf
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
  id: currenex_currenexforex_orderservice_cbp_v26
  title: Currenex OrderService Cbp v26
  license: GPL-3.0
  endian: be

doc: 'Currenex Currenex Forex Order Service Cbp v26'
doc-ref: https://www.currenex.com/support

seq:
  - id: soh
    type: u1
    doc: 'Start of Currenex message'
  - id: message_header
    type: message_header_struct
    doc: 'Currenex Market Data Message Header'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::logon': logon
        'message_type::logout': logout
        'message_type::heartbeat': heartbeat
        'message_type::instrument_info_request': instrument_info_request
        'message_type::instrument_info': instrument_info
        'message_type::new_order_request': new_order_request
        'message_type::new_order_ack': new_order_ack
        'message_type::order_cancel_request': order_cancel_request
        'message_type::order_cancel_reject': order_cancel_reject
        'message_type::order_replace_or_cancel_request': order_replace_or_cancel_request
        'message_type::order_replace_or_cancel_ack': order_replace_or_cancel_ack
        'message_type::order_canceled_or_expired': order_canceled_or_expired
        'message_type::trade': trade
        'message_type::pending_fill': pending_fill
        'message_type::pending_fill_cancel': pending_fill_cancel
        'message_type::trade_pending': trade_pending
        'message_type::resend_request': resend_request
        'message_type::gap_fill': gap_fill
  - id: etx
    type: u1
    doc: 'End of Currenex message'

types:
  message_header_struct:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Directional session based sequence number'
      - id: timestamp
        type: u4
        doc: 'Time in milliseconds since midnight GMT'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The type of message being sent'
  logon:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User session login id'
      - id: password
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User password'
      - id: session_id
        type: s4
        doc: 'Unique session ID assigned by server'
  logout:
    seq:
      - id: user_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'User session login id'
      - id: session_id
        type: s4
        doc: 'Unique session ID assigned by server'
      - id: reason
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Logout reason code'
  heartbeat:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID assigned by server'
  instrument_info_request:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID assigned by server'
  instrument_info:
    seq:
      - id: session_id
        type: s4
        doc: 'Unique session ID assigned by server'
      - id: instrument_index
        type: s2
        doc: 'Numeric instrument identifier'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument Type'
      - id: instrument_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument code string'
      - id: settlement_date
        type: s8
        doc: 'Epoch ms settlement date'
  new_order_request:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: instrument_index
        type: s2
        doc: 'Numeric instrument identifier'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy,S=Sell'
      - id: order_amt
        type: s8
        doc: 'Order amount (scaled)'
      - id: min_amt
        type: s8
        doc: 'Minimum fill amount'
      - id: price
        type: s4
        doc: 'Limit price (scaled)'
      - id: show_amt
        type: s8
        doc: 'Displayed iceberg amount'
      - id: expire_type
        type: u1
        enum: expire_type
        doc: 'Expire Type'
  new_order_ack:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_id
        type: s8
        doc: 'Assigned server order ID'
      - id: ack_status
        type: u1
        enum: ack_status
        doc: 'New Order acknowledge type'
      - id: error_code
        type: s2
        doc: 'Reject error code'
  order_cancel_request:
    seq:
      - id: new_cl_order_id
        type: s4
        doc: 'Cancel request client order ID'
      - id: prev_cl_order_id
        type: s4
        doc: 'Original client order ID'
      - id: instrument_index
        type: s2
        doc: 'Numeric instrument identifier'
  order_cancel_reject:
    seq:
      - id: new_cl_order_id
        type: s4
        doc: 'Cancel request client order ID'
      - id: prev_cl_order_id
        type: s4
        doc: 'Original client order ID'
      - id: error_code
        type: s2
        doc: 'Reject error code'
  order_replace_or_cancel_request:
    seq:
      - id: new_cl_order_id
        type: s4
        doc: 'Cancel request client order ID'
      - id: orig_cl_order_id
        type: s4
        doc: 'Original client order ID'
      - id: order_amt
        type: s8
        doc: 'Order amount (scaled)'
      - id: price
        type: s4
        doc: 'Limit price (scaled)'
      - id: instrument_index
        type: s2
        doc: 'Numeric instrument identifier'
  order_replace_or_cancel_ack:
    seq:
      - id: new_cl_order_id
        type: s4
        doc: 'Cancel request client order ID'
      - id: prev_cl_order_id
        type: s4
        doc: 'Original client order ID'
      - id: status
        type: u1
        enum: status
        doc: 'P=Replaced,C=Cancelled,R=Rejected'
      - id: error_code
        type: s2
        doc: 'Reject error code'
  order_canceled_or_expired:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_id
        type: s8
        doc: 'Assigned server order ID'
      - id: status
        type: u1
        enum: status
        doc: 'P=Replaced,C=Cancelled,R=Rejected'
      - id: type_field
        type: s2
        enum: type_field
        doc: 'Type'
  trade:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_id
        type: s8
        doc: 'Assigned server order ID'
      - id: instrument_index
        type: s2
        doc: 'Numeric instrument identifier'
      - id: side
        type: u1
        enum: side
        doc: 'B=Buy,S=Sell'
      - id: fill_amt
        type: s8
        doc: 'Filled amount'
      - id: fill_rate
        type: s4
        doc: 'Filled rate'
      - id: exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker code'
      - id: execution_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade identifier'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution Type'
      - id: settle_date
        type: s8
        doc: 'Settlement timestamp ms'
      - id: trade_date
        type: s8
        doc: 'Trade date timestamp ms'
      - id: transact_time
        type: s8
        doc: 'Transaction timestamp ms'
      - id: leaves_amt
        type: s8
        doc: 'Remaining amount'
      - id: aggressor_flag
        type: u1
        enum: aggressor_flag
        doc: 'Aggressor Flag'
  pending_fill:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_id
        type: s8
        doc: 'Assigned server order ID'
      - id: trade_link_id
        type: s4
        doc: 'Link between pending fill and trade'
      - id: fill_amt
        type: s8
        doc: 'Filled amount'
      - id: fill_rate
        type: s4
        doc: 'Filled rate'
      - id: aggressor_flag
        type: u1
        enum: aggressor_flag
        doc: 'Aggressor Flag'
      - id: exec_broker
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Broker code'
  pending_fill_cancel:
    seq:
      - id: cl_order_id
        type: s4
        doc: 'Client order ID'
      - id: order_id
        type: s8
        doc: 'Assigned server order ID'
      - id: trade_link_id
        type: s4
        doc: 'Link between pending fill and trade'
  trade_pending:
    seq:
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution Type'
      - id: settle_date
        type: s8
        doc: 'Settlement timestamp ms'
      - id: trade_date
        type: s8
        doc: 'Trade date timestamp ms'
      - id: transact_time
        type: s8
        doc: 'Transaction timestamp ms'
      - id: leaves_amt
        type: s8
        doc: 'Remaining amount'
      - id: aggressor_flag
        type: u1
        enum: aggressor_flag
        doc: 'Aggressor Flag'
  resend_request:
    seq:
      - id: begin_seq_no
        type: s4
        doc: 'First sequence number to resend'
  gap_fill:
    seq:
      - id: new_seq_no
        type: s4
        doc: 'Next expected message sequence number'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'Reason Code'

enums:
  message_type:
    0x41:
      id: 'logon'
      doc: 'Client initiates a session by submitting a Logon message'
    0x42:
      id: 'logout'
      doc: 'Terminate a session by sending a Logout message'
    0x43:
      id: 'heartbeat'
      doc: 'Keep-alive ping sent every three seconds; client must respond'
    0x45:
      id: 'instrument_info_request'
      doc: 'Request list of supported instruments'
    0x44:
      id: 'instrument_info'
      doc: 'Definition of a currency or metal instrument'
    0x4c:
      id: 'new_order_request'
      doc: 'Submit a new order request'
    0x4d:
      id: 'new_order_ack'
      doc: 'Acknowledge new order'
    0x4e:
      id: 'order_cancel_request'
      doc: 'Request cancellation of an order'
    0x4f:
      id: 'order_cancel_reject'
      doc: 'Rejection of Order Cancel Request'
    0x50:
      id: 'order_replace_or_cancel_request'
      doc: 'Replace or cancel an order'
    0x51:
      id: 'order_replace_or_cancel_ack'
      doc: 'Acknowledge replace/cancel'
    0x52:
      id: 'order_canceled_or_expired'
      doc: 'Unsolicited cancellation/expiry notice'
    0x54:
      id: 'trade'
      doc: 'Trade execution notification'
    0x55:
      id: 'pending_fill'
      doc: 'Notification of expected fill'
    0x56:
      id: 'pending_fill_cancel'
      doc: 'Notification of pending fill cancellation'
    0x74:
      id: 'trade_pending'
      doc: 'Trade notification linked to pending fill'
    0x32:
      id: 'resend_request'
      doc: 'Request retransmission of missed messages'
    0x34:
      id: 'gap_fill'
      doc: 'Skip non-resendable or unavailable messages'
  instrument_type:
    0x31:
      id: 'foreign_exchange'
      doc: 'Foreign Exchange'
    0x32:
      id: 'cash_metals'
      doc: 'Cash Metals'
  order_type:
    0x46:
      id: 'limit'
      doc: 'Limit'
    0x5a:
      id: 'iceberg'
      doc: 'Iceberg'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  expire_type:
    0x47:
      id: 'gtc'
      doc: 'Gtc'
    0x49:
      id: 'ioc'
      doc: 'Ioc'
  ack_status:
    0x52:
      id: 'rejected'
      doc: 'Rejected'
    0x43:
      id: 'confirmed'
      doc: 'Confirmed'
  status:
    0x52:
      id: 'rejected'
      doc: 'Rejected'
    0x50:
      id: 'replaced'
      doc: 'Replaced'
    0x43:
      id: 'cancelled'
      doc: 'Cancelled'
    0x45:
      id: 'expired'
      doc: 'Expired'
  type_field:
    0:
      id: 'user'
      doc: 'User'
    1:
      id: 'system'
      doc: 'System'
    2:
      id: 'below_min'
      doc: 'Below Min'
  exec_type:
    0x31:
      id: 'new_trade'
      doc: 'New Trade'
  aggressor_flag:
    0x31:
      id: 'aggressor'
      doc: 'Aggressor'
    0x32:
      id: 'not_aggressor'
      doc: 'Not Aggressor'
  reason_code:
    0x31:
      id: 'not_resendable'
      doc: 'Not Resendable'
    0x32:
      id: 'not_available'
      doc: 'Not Available'

