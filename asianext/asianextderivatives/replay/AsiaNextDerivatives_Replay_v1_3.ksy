# ---------------------------------------------------------------------
# Kaitai struct definition for: AsiaNext AsiaNextDerivatives Replay Amd v1.3
#
# Protocol:
#   Organization: AsiaNext
#   Protocol: Market Data Replay
#   Encoding: Aquis Market Data Protocol
#   Version: 1.3
#   Date: 11/6/2026
#   Specification: AsiaNext-Market-Data-Technical-Specification-v1.3.pdf
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
  id: asianext_asianextderivatives_replay_amd_v1_3
  title: AsiaNext AsiaNextDerivatives Replay Amd v1.3
  license: MIT-0
  endian: le

doc: 'AsiaNext AsiaNext Derivatives Market Data Replay Amd v1.3'
doc-ref: https://www.asianext.com/tech/

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Aquis Amd Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis market data message header'
      - id: payload
        size: message_header.msg_length - 6
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::login_message': login_message
            'msg_type::replay_request_message': replay_request_message
            'msg_type::replay_response_message': replay_response_message
  message_header:
    seq:
      - id: msg_type
        type: u1
        enum: msg_type
        doc: 'Message type identifier'
      - id: msg_length
        type: u1
        doc: 'Length of market data message, including header'
      - id: seq_no
        type: u4
        doc: 'Sequence number of this message in the market data stream for the current trading day'
  login_message:
    seq:
      - id: username
        type: str
        size: 10
        encoding: ASCII
        doc: 'As assigned by AsiaNext for the recipient'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'As assigned by AsiaNext for the recipient'
  replay_request_message:
    seq:
      - id: begin_seq_no
        type: u4
        doc: 'Stream seqNo of first message requested, 0 for the earliest available'
      - id: end_seq_no
        type: u4
        doc: 'Stream seqNo of last message requested, 0 for the last available'
  replay_response_message:
    seq:
      - id: response_code
        type: u1
        enum: response_code
        doc: 'Replay response code'

enums:
  msg_type:
    13:
      id: 'login_message'
      doc: 'If a recipient wishes to use the message replay service, they must first be authenticated by sending a Login message to the relevant replay server.'
    14:
      id: 'replay_request_message'
      doc: 'The recipient sends a Replay Request message to request a particular message or range of messages from the replay server.'
    15:
      id: 'replay_response_message'
      doc: 'AsiaNext will send a Replay Response message to the recipient to acknowledge a successful Login or to report problems with a Resend Request.'
  response_code:
    0:
      id: 'login_successful'
      doc: 'Login Successful'
    1:
      id: 'bad_begin_seq_no_in_resend_request'
      doc: 'Bad Begin Seq No In Resend Request'
    2:
      id: 'bad_end_seq_no_in_resend_request'
      doc: 'Bad End Seq No In Resend Request'
    3:
      id: 'max_replay_quota_encountered'
      doc: 'Max replay quota encountered. Please indicate smaller range in request'

