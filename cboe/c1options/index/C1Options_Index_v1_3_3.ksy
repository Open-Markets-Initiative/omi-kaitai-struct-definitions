# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options Index Csm v1.3.3
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Streaming Market Index
#   Encoding: Csm
#   Version: 1.3.3
#   Date: 02/06/2018
#   Specification: Cboe Streaming Index v1.3.3.pdf
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
  id: cboe_c1options_index_csm_v1_3_3
  title: Cboe C1Options Index Csm v1.3.3
  license: MIT-0
  endian: be

doc: 'Chicago Board Options Exchange Cboe C1 Options Streaming Market Index Csm v1.3.3'
doc-ref: https://systems.cboe.com/Auth/CFN.aspx

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count

types:
  packet_header_struct:
    seq:
      - id: version
        type: u1
        doc: 'The version associated with the contents and format of this header. Currently, this will be a constant value of 1'
      - id: packet_length
        type: u2
        doc: 'Length of the packet including this length field and the version'
      - id: sending_time
        type: u8
        doc: 'The time that this packet was sent. It applies to all messages in this packet'
      - id: message_count
        type: u1
        doc: 'The number of messages in this packet'
      - id: first_msg_seq_num
        type: u4
        doc: 'The sequence number on the first message in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 8
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::index_value_message': index_value_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of the message in bytes'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'The Template ID is for decoding the message'
      - id: message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Code identifying this message type'
      - id: msg_seq_num
        type: u4
        doc: 'Message Sequence Number'
  index_value_message:
    seq:
      - id: symbol
        type: symbol
      - id: num_md_entries
        type: u1
        doc: 'Number of MDEntries in this message. Will not exceed 255'
      - id: md_entries
        type: md_entries
        repeat: expr
        repeat-expr: num_md_entries
        doc: 'The Following Fields Repeat NoMDEntries times'
  symbol:
    seq:
      - id: len_symbol_text
        type: u1
        doc: 'Index symbol'
      - id: symbol_text
        type: str
        size: len_symbol_text
        encoding: ASCII
        doc: 'Index symbol'
  md_entries:
    seq:
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Entry Type. See table: 10 – MD Entry Type'
      - id: md_entry_px
        type: md_entry_px
  md_entry_px:
    seq:
      - id: md_entry_px_exponent
        type: s1
        doc: 'Index value associated with MDEntryType'
      - id: md_entry_px_mantissa
        type: s4
        doc: 'Index value associated with MDEntryType'

enums:
  template_id:
    22:
      id: 'index_value_message'
      doc: 'Index value messages contain the values associated with a calculated index. They are transmitted when an index is calculated.'
    16:
      id: 'heartbeat_message'
      doc: 'This message contains only a standard header. The heartbeat will repeat at a regular interval.'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'ask'
      doc: 'Ask'
    0x33:
      id: 'index_value'
      doc: 'Index Value (Used only in Index Value messages)'

