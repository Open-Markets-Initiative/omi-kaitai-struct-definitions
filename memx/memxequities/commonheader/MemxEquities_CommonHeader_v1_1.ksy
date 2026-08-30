# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxEquities CommonHeader Udp v1.1
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Common Header
#   Encoding: User Datagram Protocol
#   Version: 1.1
#   Date: 2025-10-23
#   Specification: MEMX-UDP-v1_1.pdf
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
  id: memx_memxequities_commonheader_udp_v1_1
  title: Memx MemxEquities CommonHeader Udp v1.1
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Equities Common Header Udp v1.1'
doc-ref: https://info.memxtrading.com/equities-trading-resources/

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Memx Udp Common Header'
  - id: sequenced_messages
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Memx Udp Message Type'
      - id: header_length
        type: u1
        doc: 'Total bytes in this header'
      - id: session_id
        type: u8
        doc: 'session identifier'
      - id: sequence_number
        type: u8
        doc: 'Sequence Number'
  sequenced_message:
    seq:
      - id: num_message
        type: u2
        doc: 'Number of messages in this packet'
      - id: message
        type: message
        repeat: expr
        repeat-expr: num_message
        doc: 'Memx Udp Message'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Number of bytes in the following message'

enums:
  message_type:
    0:
      id: 'heartbeat_message'
      doc: 'Memx Udp Heartbeat Message'
    1:
      id: 'session_shutdown_message'
      doc: 'Memx Udp Session Shutdown Message'
    2:
      id: 'sequenced_message'
      doc: 'Memx Udp Sequenced Message'

