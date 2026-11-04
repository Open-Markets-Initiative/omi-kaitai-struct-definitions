# ---------------------------------------------------------------------
# Kaitai struct definition for: A2X TcpHeader Atp v1
#
# Protocol:
#   Organization: A2X Markets
#   Protocol: Tcp Headers
#   Encoding: Aquis Trading Protocol
#   Version: 1
#   Date: 8/1/2017
#   Specification: Unknown
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
  id: a2x_a2xequities_tcpheader_atp_v1
  title: A2X TcpHeader Atp v1
  license: MIT-0
  endian: le

doc: 'A2X Markets A2X Equities Tcp Headers Atp v1'
doc-ref: https://www.a2x.co.za/?page_id=531

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'A2X Atp Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'A2X Atp message header'
      - id: payload
        size: message_header.length - 7
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of message including this header'
      - id: msg_type
        type: u1
        doc: 'Message type'
      - id: msg_seq_no
        type: u4
        doc: 'Message sequence number from the user or A2X'

