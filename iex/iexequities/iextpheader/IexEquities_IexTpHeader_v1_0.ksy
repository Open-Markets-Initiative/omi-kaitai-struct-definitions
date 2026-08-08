# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexEquities IexTpHeader Udp v1.0
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: IexTp Header
#   Encoding: User Datagram Protocol
#   Version: 1.0
#   Date: 9/20/2015
#   Specification: IEX Transport Specification.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: iex_iexequities_iextpheader_udp_v1_0
  title: Iex IexEquities IexTpHeader Udp v1.0
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Equities IexTp Header Udp v1.0'
doc-ref: https://iextrading.com/trading/market-data/

seq:
  - id: iextp_header
    type: iextp_header_struct
    doc: 'IexTp packet header'
  - id: messages
    repeat: expr
    repeat-expr: iextp_header.message_count
    type:
      switch-on: iextp_header.message_count
      cases:
        _: message

types:
  iextp_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Version of transport specification'
      - id: reserved
        size: 1
        doc: 'Reserved byte'
      - id: message_protocol_id
        type: u2
        doc: 'Unique identifier of the higher layer protocol'
      - id: channel_id
        type: u4
        doc: 'Identifies the stream of bytes sequenced messages'
      - id: session_id
        type: u4
        doc: 'Identifies the session'
      - id: payload_length
        type: u2
        doc: 'Byte length of the payload'
      - id: message_count
        type: u2
        doc: 'Number of messages in the payload'
      - id: stream_offset
        type: u8
        doc: 'Byte offset of the data stream'
      - id: first_message_sequence_number
        type: u8
        doc: 'Sequence of the first message in the segment'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of segment. Nanoseconds since Unix epoch'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'IexTp message header'
      - id: message_data
        size: message_header.message_length - 1
        doc: 'Raw message bytes'
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
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

