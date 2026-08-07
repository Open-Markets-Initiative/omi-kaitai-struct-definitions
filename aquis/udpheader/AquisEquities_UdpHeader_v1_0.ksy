# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis AquisEquities UdpHeader Amd v1.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Udp Headers
#   Encoding: Aquis Market Data Protocol
#   Version: 1.0
#   Date: 8/1/2025
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: aquis_aquisequities_udpheader_amd_v1_0
  title: Aquis AquisEquities UdpHeader Amd v1.0
  license: GPL-3.0
  endian: be

doc: 'Aquis Exchange Aquis Equities Udp Headers Amd v1.0'
doc-ref: https://www.aquis.eu/technologies

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Aquis udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Aquis Amd Message'

types:
  packet_header_struct:
    seq:
      - id: message_count
        type: u1
        doc: 'Number of messages in this packet'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis market data message header'
      - id: payload
        size-eos: true
  message_header:
    seq:
      - id: msg_type
        type: u1
        doc: 'Message type identifier'
      - id: msg_length
        type: u1
        doc: 'Length of market data message, including header'
      - id: seq_no
        type: u4
        doc: 'Sequence number of this message in the market data stream for the current trading day'

