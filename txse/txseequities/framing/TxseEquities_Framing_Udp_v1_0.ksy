# ---------------------------------------------------------------------
# Kaitai struct definition for: Txse TxseEquities Framing Udp v1.0
#
# Protocol:
#   Organization: Texas Stock Exchange
#   Protocol: 
#   Encoding: User Datagram Protocol
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
  id: txse_txseequities_framing_udp_v1_0
  title: Txse TxseEquities Framing Udp v1.0
  license: GPL-3.0
  endian: le

doc: 'Texas Stock Exchange Txse Equities Udp v1.0'
doc-ref: https://www.txse.com

seq:
  - id: udp_header
    type: udp_header_struct
    doc: 'Rake Udp packet header'
  - id: udp_sequenced_message
    type: udp_sequenced_message_struct
    repeat: expr
    repeat-expr: udp_header.message_count
    doc: 'Each individual message has a length, a stream id, a message type, and an application payload'

types:
  udp_header_struct:
    seq:
      - id: session
        type: u8
        doc: 'The currently active trading session. Changes daily and matches the trading session fields on other protocols'
      - id: sequence
        type: u8
        doc: 'The message sequence number of the first message in the payload. Members should increment their message sequence based on the number of messages in the payload'
      - id: message_count
        type: u2
        doc: 'The number of messages in the payload'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Enum RakeUdpPacketType. Identifies the Rake Udp packet variant. Informational only'
  udp_sequenced_message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message, exclusive of the length field itself. Note: inclusive of the streamId byte'
      - id: stream_id
        type: u1
        doc: 'The internal Exchange StreamID that created this message'
      - id: message_type
        type: u1
        doc: 'Higher-level protocol message type code identifying the payload that follows. Interpretation is protocol-specific'
      - id: payload
        size: message_length - 2
        doc: 'Raw application payload bytes carried by a Udp Sequenced Message'

enums:
  packet_type:
    0:
      id: 'sequenced_data'
      doc: 'Sequenced data packet.'
    1:
      id: 'heartbeat'
      doc: 'Heartbeat only. Sequence is set to the next expected sequence and the message count is 0.'
    2:
      id: 'start_of_session'
      doc: 'First packet of the session. Both the sequence and message count are 0. May repeat multiple times.'
    3:
      id: 'end_of_session'
      doc: 'Last packet of the session. Sequence is the highest known for the session; count is 0. Repeats at some small interval. No payload data is sent after the first EOS packet.'
    4:
      id: 'gap_fill_request'
      doc: 'Reserved for future use.'
    5:
      id: 'gap_fill_response'
      doc: 'Reserved for future use.'

