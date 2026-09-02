# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Cqs Snapshot Cta v2.1.Hft
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: 
#   Encoding: Consolidated Tape Association
#   Version: 2.1.Hft
#   Date: 06/06/2025
#   Specification: CQS_Pillar_Snapshot_Specification.pdf
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
  id: siac_cqs_snapshot_cta_v2_1_hft
  title: Siac Cqs Snapshot Cta v2.1.Hft
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Consolidated Quotation System Cta v2.1.Hft'
doc-ref: https://www.ctaplan.com/tech-specs

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Cqs Snapshot packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'Repeating message block'
  - id: block_pad_byte
    type: u1
    if: _io.pos % 2 != 0
    doc: 'Block Pad Byte'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Designates The Cqs Binary Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data Of The Transmission Block'
      - id: deliveryflag
        type: u1
        enum: deliveryflag
        doc: 'Used to identify all messages associated with a specific Snapshot request'
      - id: lastseqnum
        type: u4
        doc: 'It indicates the as-of Message Sequence Number for the Symbol published on the Production Output line'
      - id: totpubseqrollover
        type: u1
        doc: 'Indicates the number of times the sequence number has previously rolled over for the Real-Time Output line on which the symbol resides'
      - id: sip_block_timestamp
        type: sip_block_timestamp
        doc: 'Cqs packet timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 Bits Of The 32 Bit Sum Of All Bytes In The Block Excluding The Block Checksum Field'
  sip_block_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  message_struct:
    seq:
      - id: message_length
        type: u2
        doc: 'The Total Length Of The Message In Bytes'
      - id: message_category
        type: u1
        enum: message_category
        doc: 'Category byte; paired with Message Type to identify the terminal message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Per-message type code; paired with Message Category to identify the terminal message'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8le
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
  deliveryflag:
    1:
      id: 'first_block'
      doc: 'First Block of Snapshot sequence'
    2:
      id: 'intermediate_block'
      doc: 'Intermediate Block of Snapshot sequence'
    3:
      id: 'last_block'
      doc: 'Last Block of Snapshot sequence'
    4:
      id: 'only_one_block'
      doc: 'Only one Block in Snapshot sequence'
  message_category:
    0x52:
      id: 'snapshot'
      doc: 'Snapshot Messages'

