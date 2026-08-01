# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Eti Fbe v1.0
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Enhanced Trading Interface
#   Encoding: Flat Binary Encoding
#   Version: 1.0
#   Date: 01/1/2015
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_eti_v1_0
  title: Eurex T7 Eti Fbe v1.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Trading Interface Fbe v1.0'
doc-ref: https://www.eurex.com/ex-en/technology/t7

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Eurex T7 Eti Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Coinbase Sbe Message'
      - id: payload
        size: message_header.body_len - 6
        doc: 'Raw message bytes'
  message_header:
    seq:
      - id: body_len
        type: u4
        doc: 'body length field'
      - id: template_id
        type: u2
        doc: 'Template Id'

