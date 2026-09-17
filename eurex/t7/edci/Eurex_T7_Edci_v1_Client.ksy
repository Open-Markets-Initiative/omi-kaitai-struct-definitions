# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Edci Fbe v1
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Extended Derivatives Clearing Interface
#   Encoding: Flat Binary Encoding
#   Version: 1
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
  id: eurex_t7_edci_fbe_v1_client
  title: Eurex T7 Edci Fbe v1
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Extended Derivatives Clearing Interface Fbe v1'
doc-ref: https://www.eurex.com/ex-en/technology/t7

seq:
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'Eurex T7 Edci Message sent by the participant to Eurex'

types:
  client_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Eurex T7 Edci message header'
  message_header:
    seq:
      - id: body_len
        type: u4
        doc: 'body length field'
      - id: template_id
        type: u2
        doc: 'Template Id'

