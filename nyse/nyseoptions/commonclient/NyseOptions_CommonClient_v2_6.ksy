# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseOptions CommonClient Pillar v2.6
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Common Client
#   Encoding: Pillar
#   Version: 2.6
#   Date: 8/3/2022
#   Specification: Pillar_Options_Common_Client_Specification.pdf
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
# The Binary Data Compiler technologies used to produce this file
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
  id: nyseoptions_commonclient_v2_6
  title: Nyse NyseOptions CommonClient Pillar v2.6
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Options Common Client Pillar v2.6'
doc-ref: https://www.nyse.com/market-data/real-time

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Pillar common client udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msgs
    doc: 'Pillar message'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
      - id: number_msgs
        type: u1
        doc: 'The number of messages in this packet'
      - id: seq_num
        type: u4
        doc: 'The message sequence number of the first message in this packet'
      - id: send_time
        type: send_time
        doc: 'The time when this packet was published to the multicast channel. nanoseconds since Unix epoch'
  send_time:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds since Jan 1, 1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'The nanosecond offset from the Send Time'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Pillar message header'
      - id: payload
        size: message_header.message_size - 4
        doc: 'Raw message bytes'
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'The size of this message in bytes'
      - id: message_type
        type: u2
        doc: 'The type of this message'
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
  delivery_flag:
    1:
      id: 'heartbeat'
      doc: 'Pillar Heartbeat Message'
    10:
      id: 'pillar_failover'
      doc: 'Pillar Failover'
    11:
      id: 'original_message'
      doc: 'Original Message'
    12:
      id: 'sequence_number_reset_message'
      doc: 'Sequence Number Reset Message'
    13:
      id: 'one_retransmission_packet'
      doc: 'Only one packet in retransmission sequence'
    15:
      id: 'retransmission_sequence_message'
      doc: 'Part of a retransmission sequence'
    17:
      id: 'one_refresh_packet'
      doc: 'One packet in Refresh sequence'
    18:
      id: 'refresh_sequence_start'
      doc: 'Start of Refresh sequence'
    19:
      id: 'refresh_sequence_message'
      doc: 'Part of a Refresh sequence'
    20:
      id: 'refresh_sequence_end'
      doc: 'End of Refresh Sequence'
    21:
      id: 'message_unavailable'
      doc: 'Message Unavailable'

