# ---------------------------------------------------------------------
# Kaitai struct definition for: Siac Opra Headers Udp v1
#
# Protocol:
#   Organization: The Securities Industry Automation Corporation
#   Protocol: Headers
#   Encoding: User Datagram Protocol
#   Version: 1
#   Date: 8/3/2022
#   Specification: Unknown
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
  id: siac_opra_headers_udp_v1
  title: Siac Opra Headers Udp v1
  license: GPL-3.0
  endian: be

doc: 'The Securities Industry Automation Corporation Options Price Reporting Authority Headers Udp v1'
doc-ref: https://www.opraplan.com/document-library

seq:
  - id: block_header
    type: block_header_struct
    doc: 'Opra packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: block_header.messages_in_block
    doc: 'Opra Obi Block Data containing messages'
  - id: block_pad_byte
    type: u1
    if: _io.pos % 2 != 0
    doc: 'Block Pad Byte'

types:
  block_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'Designates The Opra Binary Version'
      - id: block_size
        type: u2
        doc: 'Size In Bytes Of Entire Transmission Block'
      - id: data_feed_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Data Feed Indicator'
      - id: retransmission_indicator
        type: u1
        enum: retransmission_indicator
        doc: 'Retransmission Indicator'
      - id: session_indicator
        type: u1
        doc: 'Session Indicator'
      - id: block_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: messages_in_block
        type: u1
        doc: 'The Number Of Messages Contained In The Block Data Of The Transmission Block'
      - id: block_timestamp
        type: block_timestamp
        doc: 'Opra packet timestamp. Nanoseconds since Unix epoch'
      - id: block_checksum
        type: u2
        doc: 'Lower 16 Bits Of The 32 Bit Sum Of All Bytes In The Block Excluding The Block Checksum Field'
  block_timestamp:
    seq:
      - id: seconds
        type: u4
        doc: 'Contains The Number Seconds From Epoch 111970000000 Utc'
      - id: nanoseconds
        type: u4
        doc: 'The Nanosecond Portion Of The Time Currently Rounded To The Nearest Microsecond'
  message_struct:
    seq:
      - id: participant_id
        type: u1
        enum: participant_id
        doc: 'ASCII character that identifies the Participant or Processor that initiated the message'
      - id: message_category
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: payload
        type:
          switch-on: message_category
          cases:
            '"C"': administrative_message
            '"H"': control_message
  administrative_message:
    seq:
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message type'
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
      - id: len_message_data
        type: u2
        doc: 'Represents the length of the Message Data field'
      - id: message_data
        type: str
        size: len_message_data
        encoding: ASCII
        doc: 'Represents the Message Data field'
  control_message:
    seq:
      - id: control_message_type
        type: u1
        enum: control_message_type
        doc: 'Control Message Type'
      - id: message_indicator
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message identifier'
      - id: transaction_id
        type: u4
        doc: 'Reserved for Internal Use only'
      - id: participant_reference_number
        type: u4
        doc: 'The PRN is for optional use by the Participant'
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
  retransmission_indicator:
    0x20:
      id: 'not_retransmitted'
      doc: 'Not a retransmitted message'
    0x56:
      id: 'retransmitted'
      doc: 'Retransmission of the block'
  participant_id:
    0x41:
      id: 'amex'
      doc: 'NYSE American'
    0x42:
      id: 'box_field'
      doc: 'Boston Options Exchange'
    0x43:
      id: 'cboe'
      doc: 'Cboe Options Exchange'
    0x44:
      id: 'emerald'
      doc: 'MIAX EMERALD'
    0x45:
      id: 'edgx'
      doc: 'Cboe EDGX Options'
    0x48:
      id: 'gemx'
      doc: 'Nasdaq GEMX'
    0x49:
      id: 'ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'mrx'
      doc: 'Nasdaq MRX'
    0x4d:
      id: 'miax'
      doc: 'Miami International Securities Exchange'
    0x4e:
      id: 'nyse'
      doc: 'NYSE ARCA'
    0x4f:
      id: 'opra'
      doc: 'Options Price Reporting Authority'
    0x50:
      id: 'pearl'
      doc: 'MIAX PEARL'
    0x51:
      id: 'nasd'
      doc: 'NASDAQ Options Market'
    0x54:
      id: 'bx'
      doc: 'NASDAQ BX Options'
    0x55:
      id: 'memx'
      doc: 'Members Options Exchange'
    0x57:
      id: 'c2'
      doc: 'Cboe C2 Options'
    0x58:
      id: 'phlx'
      doc: 'NASDAQ PHLX'
    0x5a:
      id: 'bats'
      doc: 'Cboe BZX Options Exchange'
  control_message_type:
    0x43:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x45:
      id: 'start_of_summary'
      doc: 'Start Of Summary'
    0x46:
      id: 'end_of_summary'
      doc: 'End Of Summary'
    0x4a:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4b:
      id: 'reset_block_sequence_number'
      doc: 'Reset Block Sequence Number'
    0x4c:
      id: 'start_of_open_interest'
      doc: 'Start Of Open Interest'
    0x4d:
      id: 'end_of_open_interest'
      doc: 'End Of Open Interest'
    0x4e:
      id: 'line_integrity'
      doc: 'Line Integrity'
    0x50:
      id: 'disaster_recovery_data_center_activation'
      doc: 'Disaster Recovery Data Center Activation'

