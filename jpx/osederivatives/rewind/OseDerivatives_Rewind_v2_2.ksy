# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx OseDerivatives Rewind Itch v2.2
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Rewind
#   Encoding: Itch
#   Version: 2.2
#   Date: 10/31/2025
#   Specification: J-GATE3.0_ITCH_Connectivity_Manual_V2.2.pdf
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
  id: jpx_osederivatives_rewind_itch_v2_2
  title: Jpx OseDerivatives Rewind Itch v2.2
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Osaka Securities Exchange Rewind Itch v2.2'

seq:
  - id: session
    type: str
    size: 10
    encoding: ASCII
    pad-right: 0x20
    doc: 'Same as Session in the packet header, only the session number of the current day can be set'
  - id: sequence_number
    type: u8
    doc: 'The sequence number of the first data message being requested for resend'
  - id: requested_message_count
    type: u2
    doc: 'The number of data messages being requested for resend'

