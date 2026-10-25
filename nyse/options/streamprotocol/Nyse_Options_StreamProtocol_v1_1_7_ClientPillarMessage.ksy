# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse Options StreamProtocol PillarStream v1.1.7
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Stream Protocol
#   Encoding: Pillar Stream Protocol
#   Version: 1.1.7
#   Date: 3/28/2025
#   Specification: NYSE_Pillar_Stream_Protocol_Specification.pdf
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
  id: nyse_options_streamprotocol_pillarstream_v1_1_7_clientpillarmessage
  title: Nyse Options StreamProtocol PillarStream v1.1.7
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Options Stream Protocol PillarStream v1.1.7'
doc-ref: https://www.nyse.com/connectivity/specs

seq:
  - id: client_message
    type:
      switch-on: peek_msg_type
      cases:
        'msg_type::login': login_message
        'msg_type::heartbeat': heartbeat
        'msg_type::open': open
        'msg_type::close': close
        'msg_type::seq_msg': client_seq_msg

instances:
  peek_msg_type:
    pos: 0
    type: u2
    enum: msg_type

types:
  login_message:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: username
        type: str
        size: 16
        encoding: ASCII
        doc: 'Pillar Username'
      - id: password
        type: str
        size: 32
        encoding: ASCII
        doc: 'User password in plain text'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market to login'
      - id: version
        type: str
        size: 20
        encoding: ASCII
        doc: 'Protocol version, should be 1.1'
  msg_header:
    seq:
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Pillar stream message type'
      - id: msg_length
        type: u2
        doc: 'Total message length, including this header'
  heartbeat:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
  open:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: start_seq
        type: u8
        doc: 'Start sequence number'
      - id: end_seq
        type: u8
        doc: 'End sequence (ignored for write request)'
      - id: access
        type: u1
        doc: 'Available access on the stream'
      - id: mode
        type: u1
        doc: 'Mode requested'
  stream_id:
    seq:
      - id: sess
        type: u4
        doc: '32 bit session id (env_id[31:24], sess_num[23:0])'
      - id: value_field
        type: u4
        doc: 'Stream identifier value (stream_type[31:24], user_id[23:8], sub_id[7:0])'
  close:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
  client_seq_msg:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Pillar Stream Message Header'
      - id: seq_msg_id
        type: seq_msg_id
        doc: 'Pillar Stream Sequenced Message Identifier'
      - id: reserved_4
        type: u4
        doc: '4 bytes reserved for future use'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Message timestamp. Nanoseconds since Unix epoch'
      - id: seq_msg_header
        type: seq_msg_header
        doc: 'Pillar Stream Sequenced Message Header'
      - id: client_sequenced_message
        size: seq_msg_header.seq_msg_length - 4
        doc: 'Raw sequenced message bytes sent by the member firm'
  seq_msg_id:
    seq:
      - id: stream_id
        type: stream_id
        doc: 'Pillar Stream Protocol Stream Identifier'
      - id: seq
        type: u8
        doc: 'Sequence number, starting from 1'
  seq_msg_header:
    seq:
      - id: seq_msg_type
        type: u2
        doc: 'Code identifying this message type'
      - id: seq_msg_length
        type: u2
        doc: 'Length of sequenced data message including this field'
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

enums:
  msg_type:
    0x0201:
      id: 'login'
      doc: 'Login'
    0x0202:
      id: 'login_response'
      doc: 'Login Response'
    0x0203:
      id: 'stream_avail'
      doc: 'Stream Avail'
    0x0204:
      id: 'heartbeat'
      doc: 'Heartbeat'
    0x0205:
      id: 'open'
      doc: 'Open'
    0x0206:
      id: 'open_response'
      doc: 'Open Response'
    0x0207:
      id: 'close'
      doc: 'Close'
    0x0208:
      id: 'close_response'
      doc: 'Close Response'
    0x0905:
      id: 'seq_msg'
      doc: 'Sequenced Message'
  status:
    0:
      id: 'request_processed_successfully'
      doc: 'Request processed successfully'
    18:
      id: 'not_logged_in'
      doc: 'Not logged in'
    24:
      id: 'invalid_login_details'
      doc: 'Invalid login details'
    27:
      id: 'already_logged_in'
      doc: 'Already logged in'
    28:
      id: 'heartbeat_timeout'
      doc: 'Heartbeat timeout'
    29:
      id: 'login_timed_out'
      doc: 'Login timed out'
    33:
      id: 'invalid_message'
      doc: 'Invalid message'
    54:
      id: 'no_stream_permission'
      doc: 'No stream permission'
    81:
      id: 'invalid_protocol_version'
      doc: 'Invalid protocol version'
    82:
      id: 'message_out_of_sequence'
      doc: 'Message out of sequence'
    84:
      id: 'invalid_stream'
      doc: 'Invalid stream'
    85:
      id: 'stream_not_open'
      doc: 'Stream not open'
    86:
      id: 'invalid_timestamp'
      doc: 'Invalid timestamp'
    89:
      id: 'denial_of_service'
      doc: 'Denial of service'
    90:
      id: 'write_permission_revoked'
      doc: 'Write permission revoked'
    93:
      id: 'invalid_multimessage'
      doc: 'Invalid Multi-message'

