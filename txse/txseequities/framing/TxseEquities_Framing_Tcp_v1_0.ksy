# ---------------------------------------------------------------------
# Kaitai struct definition for: Txse TxseEquities Framing Tcp v1.0
#
# Protocol:
#   Organization: Texas Stock Exchange
#   Protocol: 
#   Encoding: Transmission Control Protocol
#   Version: 1.0
#   Date: 6/12/2026
#   Specification: RAKE.pdf
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
  id: txse_txseequities_framing_tcp_v1_0
  title: Txse TxseEquities Framing Tcp v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities Tcp v1.0'
doc-ref: https://www.txse.com

seq:
  - id: rake_tcp_message
    type: rake_tcp_message_struct
    repeat: eos
    doc: 'Rake Tcp Message'

types:
  rake_tcp_message_struct:
    seq:
      - id: rake_message_header
        type: rake_message_header
        doc: 'Rake Tcp per-message header carrying the frame length and packet-level dispatch byte'
      - id: payload
        size: rake_message_header.message_length + 2 - 3
        type:
          switch-on: rake_message_header.packet_type
          cases:
            'packet_type::logon_request_packet': logon_request_packet
            'packet_type::tcp_unsequenced_message': tcp_unsequenced_message
            'packet_type::debug_message': debug_message
            'packet_type::logon_response_message': logon_response_message
            'packet_type::tcp_sequenced_message': tcp_sequenced_message
  rake_message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of rake message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
  logon_request_packet:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session'
      - id: sender_comp
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique id of the sender, assigned by exchange'
      - id: token
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Assigned by exchange'
      - id: next_sequence_number
        type: u8
        doc: '1-based numbering. Use 0 to skip currently stored messages; use 1 to replay all messages; otherwise send the next sequence number expected to receive from the Exchange to recover from a disconnection'
  tcp_unsequenced_message:
    seq:
      - id: message_type
        type: u1
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: unsequenced_message
        size: _parent.rake_message_header.message_length - 2
        doc: 'Raw unsequenced message bytes'
  debug_message:
    seq:
      - id: text
        type: str
        size: _parent.rake_message_header.message_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  logon_response_message:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session'
      - id: next_sequence_number
        type: u8
        doc: '1-based numbering. Use 0 to skip currently stored messages; use 1 to replay all messages; otherwise send the next sequence number expected to receive from the Exchange to recover from a disconnection'
      - id: highest_known_sequence_number
        type: u8
        doc: 'The highest sequence number the server knows at the time of logon'
      - id: logon_response_code
        type: u1
        enum: logon_response_code
        doc: 'Success or failure code from a Logon Request'
      - id: number_stream_ids
        type: u1
        doc: 'The total number of stream ids that will be used in this trading session'
      - id: instance
        type: u4
        doc: 'Informational only. A unique ID for this RAKE server instance. Differs between primary and backup; a change on successive intra-day connections indicates the server has been restarted'
  tcp_sequenced_message:
    seq:
      - id: stream_id
        type: u1
        doc: 'The internal exchange stream id that created this message'
      - id: message_type
        type: u1
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: sequenced_message
        size: _parent.rake_message_header.message_length - 3
        doc: 'Raw sequenced message bytes'

enums:
  packet_type:
    53:
      id: 'logon_request_packet'
      doc: 'Rake Tcp Logon Request Message'
    55:
      id: 'member_heartbeat_packet'
      doc: 'Rake Tcp Client Heartbeat Packet'
    54:
      id: 'tcp_unsequenced_message'
      doc: 'Rake Tcp Unsequenced Message'
    48:
      id: 'debug_message'
      doc: 'Rake Tcp Debug Packet'
    52:
      id: 'end_of_session_message'
      doc: 'Rake Tcp End Of Session Message'
    49:
      id: 'logon_response_message'
      doc: 'Rake Tcp Logon Response Message'
    51:
      id: 'server_heartbeat_message'
      doc: 'Rake Tcp Server Heartbeat Message'
    50:
      id: 'tcp_sequenced_message'
      doc: 'Rake Tcp Sequenced Message'
  logon_response_code:
    0:
      id: 'success'
      doc: 'Logon Success'
    1:
      id: 'incorrect_sender_comp'
      doc: 'Incorrect Sender Comp Id'
    2:
      id: 'incorrect_session'
      doc: 'Incorrect Session Id'
    3:
      id: 'invalid_next_sequence'
      doc: 'The sequence number requested is larger than the largest known sequence, or is less than 0'
    4:
      id: 'invalid_configuration'
      doc: 'The RAKE server is configured incorrectly for the login request specified'
    5:
      id: 'incorrect_token'
      doc: 'Incorrect security token'

