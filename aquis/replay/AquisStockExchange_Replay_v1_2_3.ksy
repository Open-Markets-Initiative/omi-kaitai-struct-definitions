# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis Replay Amd v1.2.3
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Replay
#   Encoding: Aquis Market Data Protocol
#   Version: 1.2.3
#   Date: 4/23/2024
#   Specification: Aquis Stock Exchange Multicast Market Data Specification v1.2.3 (2024).pdf
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
  id: aquis_aquisstockexchange_replay_amd_v1_2_3
  title: Aquis Replay Amd v1.2.3
  license: GPL-3.0
  endian: le

doc: 'Aquis Exchange Aquis Stock Exchange Replay Amd v1.2.3'
doc-ref: https://www.aquisexchange.com/aquis-stock-exchange

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
        doc: 'As assigned by AQSE for the recipient'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'As assigned by AQSE for the recipient'
  replay_request_message:
    seq:
      - id: begin_seq_no
        type: u4
        doc: 'Stream seqNo of first message requested'
      - id: end_seq_no
        type: u4
        doc: 'Stream seqNo of last message requested'
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
      doc: 'AQSE will send a Replay Response message to the recipient to acknowledge a successful Login or to report problems with a Resend Request.'
  response_code:
    0:
      id: 'login_successful'
      doc: 'Login successful'
    1:
      id: 'bad_begin_seq_no'
      doc: 'Bad beginSeqNo in Resend Request'
    2:
      id: 'bad_end_seq_no'
      doc: 'Bad endSeqNo in Resend Request'

