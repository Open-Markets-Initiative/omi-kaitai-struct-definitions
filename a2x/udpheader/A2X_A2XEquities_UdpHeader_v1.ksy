# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X A2XEquities UdpHeader Amd v1
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: Udp Headers
#   Encoding: Aquis Market Data Protocol
#   Version: 1
#   Date: 9/1/2017
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
  id: a2x_a2xequities_udpheader_amd_v1
  title: A2X A2XEquities UdpHeader Amd v1
  license: GPL-3.0
  endian: be

doc: 'A2X Markets A2X Equities Udp Headers Amd v1'
doc-ref: https://www.a2x.co.za/?page_id=734/#a2xtech

seq:
  - id: num_message
    type: u1
    doc: 'number of messages in this packet'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: num_message

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'A2X message header'
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

