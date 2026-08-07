# ---------------------------------------------------------------------
# Kaitai struct definition for: Aquis AquisEquities TcpHeader Atp v1.0
#
# Protocol:
#   Organization: Aquis Exchange
#   Protocol: Tcp Headers
#   Encoding: Aquis Trading Protocol
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
  id: aquis_aquisequities_tcpheader_atp_v1_0
  title: Aquis AquisEquities TcpHeader Atp v1.0
  license: GPL-3.0
  endian: le

doc: 'Aquis Exchange Aquis Equities Tcp Headers Atp v1.0'
doc-ref: https://www.aquis.eu/technologies

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Aquis Atp Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Aquis Atp message header'
      - id: payload
        size: message_header.msg_length - 7
  message_header:
    seq:
      - id: msg_length
        type: u2
        doc: 'Length of message including this header'
      - id: msg_type
        type: u1
        doc: 'Atp Message type'
      - id: msg_seq_no
        type: u4
        doc: 'Message sequence number, from the user or Aquis'

