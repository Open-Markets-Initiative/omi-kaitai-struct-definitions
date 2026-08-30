# ---------------------------------------------------------------------
# Kaitai struct definition for: OtcMarkets LinkAts Headers Link v1
#
# Protocol:
#   Organization: OTC Markets Group
#   Protocol: 
#   Encoding: Otc Link
#   Version: 1
#   Date: 12/11/2019
#   Specification: OTC Markets Multicast Data Feeds -v4.3.pdf
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
  id: otcmarkets_linkats_headers_link_v1
  title: OtcMarkets LinkAts Headers Link v1
  license: GPL-3.0
  endian: be

doc: 'OTC Markets Group OTC Link ATS Link v1'
doc-ref: https://www.otcmarkets.com/market-data/technical-and-user-documentation

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.messages

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'Size of packet in bytes'
      - id: seq_num
        type: u4
        doc: 'Channel specific Sequence number of packet'
      - id: packet_flag
        type: packet_flag
        doc: 'Packet Flags'
      - id: messages
        type: u1
        doc: 'Number of messages in packet'
      - id: packet_milli
        type: millisecond_timestamp
        doc: 'Milliseconds since local time midnight (EST/EDT). Milliseconds since Midnight epoch'
  packet_flag:
    seq:
      - id: heartbeat
        type: b1
        doc: 'A Heartbeat is sent if no business level message has been published for more than a second'
      - id: seq_num_reset
        type: b1
        doc: 'indicates that the channel sequence numbers are being reset to 1'
      - id: reserved_4
        type: b4
        doc: 'Reserved 4'
      - id: replay
        type: b1
        doc: 'Packet contains replay messages'
      - id: test
        type: b1
        doc: 'Packet contains test messages'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Otc Udp Message Header'
      - id: payload
        size-eos: true
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Size of message in bytes'
      - id: message_type
        type: u1
        doc: 'Code identifying this message type'
  millisecond_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000

