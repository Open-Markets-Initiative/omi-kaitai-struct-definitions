# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx TsxAlpha QuantumFeedLevel1Recovery Xmt v2.1
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Quantum Feed Level 1 Recovery
#   Encoding: eXtreme Message Transfer
#   Version: 2.1
#   Date: 10/20/2020
#   Specification: Alpha Level 1 QuantumFeed Business Message Specification (2.1.0).pdf
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
  id: tmx_tsxalpha_quantumfeedlevel1recovery_xmt_v2_1_client
  title: Tmx TsxAlpha QuantumFeedLevel1Recovery Xmt v2.1
  license: GPL-3.0
  endian: le

doc: 'TMX Group TSX Alpha Exchange Quantum Feed Level 1 Recovery Xmt v2.1'
doc-ref: https://www.tmxwebstore.com/products/binary-feeds-quantumfeeds

seq:
  - id: client_frame
    type: client_frame_struct
    repeat: eos
    doc: 'One XMT frame with no trailer'

types:
  client_frame_struct:
    seq:
      - id: frame_header
        type: frame_header
        doc: 'XMT frame prefix and outer header'
      - id: client_body
        size: frame_header.message_length + 5 - 11
        type:
          switch-on: peek_msg_type
          cases:
            'msg_type::heartbeat': heartbeat_body
            'msg_type::login_request': login_request
            'msg_type::logout': logout
            'msg_type::replay_request': replay_request
    instances:
      peek_msg_type:
        pos: _io.pos + 2
        type: u1
        enum: msg_type
  frame_header:
    seq:
      - id: start_of_frame
        type: u1
        doc: 'Start of Frame'
      - id: protocol_name
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol Name'
      - id: protocol_version
        type: str
        size: 1
        encoding: ASCII
        doc: 'Protocol major version number'
      - id: message_length
        type: u2
        doc: 'Length of message from Header to Body inclusive'
      - id: session_id
        type: u4
        doc: 'Constant Session Id'
      - id: ack_required_poss_dup
        type: u1
        enum: ack_required_poss_dup
        doc: 'Ack Required Poss Dup'
      - id: num_body
        type: u1
        doc: 'Num Body'
  heartbeat_body:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: hb_interval
        type: u2
        doc: 'Heartbeat interval in milliseconds (1 to 65536)'
      - id: admin_body
        type: admin_body
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
  body_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of this message'
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Msg Type'
  admin_body:
    seq:
      - id: source_id
        type: u1
        enum: source_id
        doc: 'Source Id of the Business message'
      - id: stream_id
        type: u2
        doc: 'Stream Id per Source Id of the Business message'
      - id: sequence_0
        type: u1
        doc: 'Reserved for future expansion, Value is 0'
      - id: sequence_1
        type: u4
        doc: 'Sequence per Stream Id of the Business message'
  login_request:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: hb_interval
        type: u2
        doc: 'Heartbeat interval in milliseconds (1 to 65536)'
      - id: replay_win_size
        type: u2
        doc: 'Maximum number of messages, in thousands, allowed in the replay window'
      - id: replay_win_num
        type: u2
        doc: 'Maximum number of replay requests allowed in the window'
      - id: credits
        type: u2
        doc: 'Reserved for future use. Value is 0'
  logout:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
  replay_request:
    seq:
      - id: body_header
        type: body_header
        doc: 'Xmt Body Header'
      - id: admin_id
        type: u1
        doc: 'Admin ID for short window (1 to 255). Note: 0 is not allowed as a value'
      - id: replay_session_id
        type: u4
        doc: 'Session ID of the source to replay the message'
      - id: replay_range
        type: replay_range
        repeat: expr
        repeat-expr: _parent.frame_header.num_body
  replay_range:
    seq:
      - id: source_id
        type: u1
        enum: source_id
        doc: 'Source Id of the Business message'
      - id: stream_id
        type: u2
        doc: 'Stream Id per Source Id of the Business message'
      - id: sequence_0
        type: u1
        doc: 'Reserved for future expansion, Value is 0'
      - id: sequence_1_start
        type: u4
        doc: 'Starting sequence per stream ID'
      - id: sequence_1_end
        type: u4
        doc: 'Ending sequence per stream ID'

enums:
  ack_required_poss_dup:
    0x41:
      id: 'ack_required'
      doc: 'Receiver needs to ack'
    0x44:
      id: 'poss_dup'
      doc: 'Possible duplicates'
  msg_type:
    0x30:
      id: 'heartbeat'
      doc: 'The Heartbeat message is sent by either side during idle periods for the opposite side to detect whether the session is still alive.'
    0x31:
      id: 'login_request'
      doc: 'Login Request is used to establish a connection-oriented session for exchanging messages.'
    0x32:
      id: 'login_response'
      doc: 'A successful login results in a Login Response to send back to the originator of the request.'
    0x33:
      id: 'logout'
      doc: 'A Logout message is sent to notify the other side that the sending side is leaving the session.'
    0x34:
      id: 'ack'
      doc: 'Ack message is typically used when the implementation of the protocol requires acknowledgements or responses of requests/messages; for example, Replay Request or a synchronous transaction.'
    0x35:
      id: 'replay_request'
      doc: 'A request to replay the transmission of previously sent messages.'
    0x36:
      id: 'sequence_jump'
      doc: 'Sequence Jump is used to advance the sequence number from the current to the new sequence to indicate that certain messages are to be resent, are no longer available, or are not deterministic in a failure or disaster situation.'
    0x39:
      id: 'reject'
      doc: 'Reject is used in response to the request message, when it fails validation or is not allowed in certain states.'
    0x4a:
      id: 'symbol_status_message'
      doc: 'Symbol Status messages contain information regarding equity, debenture, or trading Instruments for the current trading day for the Alpha market. One message is disseminated for each valid symbol at the beginning of each trading day.'
    0x73:
      id: 'trade_message'
      doc: 'A Trade message is generated each time a trade occurs.'
    0x74:
      id: 'trade_cancelled_message'
      doc: 'A Trade Cancelled message is generated each time a trade is cancelled.'
    0x76:
      id: 'stock_status_message'
      doc: 'A Stock Status message is disseminated in response to a change in stock status from the Trading Engine. It contains information regarding the current state of the stock.'
    0x77:
      id: 'equity_quote_message'
      doc: 'An Equity Quote message contains the latest Bid and Ask information for a symbol.'
  source_id:
    0x30:
      id: 'non_source_related'
      doc: '“0” for non-source-related.'
    0x51:
      id: 'tsx'
      doc: 'Q for TSX'
    0x56:
      id: 'tsx_venture'
      doc: 'V for TSX Venture'
    0x41:
      id: 'alpha'
      doc: 'A for Alpha'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsxv'
      doc: 'Tsxv'
  product_type:
    0x42:
      id: 'debenture'
      doc: 'Debenture'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4d:
      id: 'mutual_fund'
      doc: 'Mutual Fund'
    0x46:
      id: 'etf'
      doc: 'Etf'
  currency:
    0x55:
      id: 'usd'
      doc: 'Usd'
    0x43:
      id: 'cad'
      doc: 'Cad'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  bypass:
    0x59:
      id: 'the_order_is_a_bypass'
      doc: 'The Order Is A Bypass'
    0x4e:
      id: 'the_order_is_not_a_bypass'
      doc: 'The Order Is Not A Bypass'
  settlement_terms:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'nn'
      doc: 'Nn'
    0x4d:
      id: 'ms_derivativesrelated_contingent_equity_trade'
      doc: 'Ms Derivativesrelated Contingent Equity Trade'
    0x54:
      id: 'ct_cash_today'
      doc: 'Ct Cash Today'
    0x44:
      id: 'if_there_is_a_valid_settlement_date_associated_with_the_order'
      doc: 'If There Is A Valid Settlement Date Associated With The Order'
    0x20:
      id: 'no_settlement_terms'
      doc: 'No Settlement Terms'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
    0x20:
      id: 'default_trade_was_not_a_cross'
      doc: 'Default Trade Was Not A Cross'
  opening_trade:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  reason_code:
    1:
      id: 'do_not_resend'
      doc: 'Do not resend.'
    2:
      id: 'no_longer_available'
      doc: 'No longer available.'
    3:
      id: 'disaster'
      doc: 'Disaster.'
  reject_code:
    0:
      id: 'information'
      doc: 'Information.'
    1:
      id: 'warning'
      doc: 'Warning.'
    2:
      id: 'critical'
      doc: 'Critical.'
    3:
      id: 'fatal'
      doc: 'Fatal.'
  reject_subcode:
    1:
      id: 'invalid_syntax'
      doc: 'Invalid syntax.'
    2:
      id: 'invalid_session_states_or_conditions'
      doc: 'Invalid session states/conditions.'
    3:
      id: 'invalid_values'
      doc: 'Invalid values.'
    4:
      id: 'function_not_implemented'
      doc: 'Function not implemented.'
    5:
      id: 'function_not_allowed'
      doc: 'Function not allowed.'
    6:
      id: 'function_temporarily_not_available_but_retryable'
      doc: 'Function temporarily not available, but retryable.'
    7:
      id: 'message_temporarily_not_available_but_retryable'
      doc: 'Message temporarily not available, but retryable.'
    8:
      id: 'duplicate_request_or_message'
      doc: 'Duplicate request/message.'
    9:
      id: 'others_see_message'
      doc: 'Others, see Message.'

