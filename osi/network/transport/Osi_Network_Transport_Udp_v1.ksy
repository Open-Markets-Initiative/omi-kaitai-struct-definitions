# ---------------------------------------------------------------------
# Kaitai struct definition for: Osi Network Transport Udp v1
#
# Protocol:
#   Organization: Open Systems Interconnection
#   Protocol: Transport
#   Encoding: User Datagram Protocol
#   Version: 1
#   Date: 10/5/2026
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
  id: osi_network_transport_udp_v1
  title: Osi Network Transport Udp v1
  license: GPL-3.0
  endian: be

doc: 'Open Systems Interconnection Network Transport Udp v1'
doc-ref: https://www.rfc-editor.org/rfc/rfc768

seq:
  - id: udp_source_port
    type: u2
    doc: 'Port the datagram is sent from'
  - id: udp_destination_port
    type: u2
    doc: 'Port the datagram is sent to; a market data feed''s channel'
  - id: udp_length
    type: u2
    doc: 'Bytes of the datagram, header and payload'
  - id: udp_checksum
    type: u2
    doc: 'One''s complement checksum; 0 when not computed'
  - id: udp_payload
    size: udp_length - 8

