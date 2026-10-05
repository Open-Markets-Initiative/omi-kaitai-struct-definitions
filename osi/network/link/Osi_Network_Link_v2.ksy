# ---------------------------------------------------------------------
# Kaitai struct definition for: Osi Network Link Ethernet v2
#
# Protocol:
#   Organization: Open Systems Interconnection
#   Protocol: Link
#   Encoding: Ethernet
#   Version: 2
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
  id: osi_network_link_ethernet_v2
  title: Osi Network Link Ethernet v2
  license: GPL-3.0
  endian: be

doc: 'Open Systems Interconnection Network Link Ethernet v2'
doc-ref: https://standards.ieee.org/ieee/802.3/10422/

seq:
  - id: destination_mac
    size: 6
    doc: 'Hardware address the frame is sent to'
  - id: source_mac
    size: 6
    doc: 'Hardware address the frame is sent from'
  - id: ether_type
    type: u2
    enum: ether_type_enum
    doc: 'The protocol the frame carries'
  - id: vlan_tag
    type: vlan_tag_struct
    if: ether_type == ether_type_enum::vlan
    doc: 'IEEE 802.1Q tag: the frame''s VLAN and priority, then what the frame carries'
  - id: ethernet_payload
    size-eos: true

types:
  vlan_tag_struct:
    seq:
      - id: tag_control
        type: tag_control
        doc: '802.1Q tag control information, most significant bit first'
      - id: inner_ether_type
        type: u2
        doc: 'The protocol a tagged frame carries'
  tag_control:
    seq:
      - id: vlan_id
        type: b12
        doc: 'VLAN identifier'
      - id: drop_eligible
        type: b1
        doc: 'Drop eligible indicator'
      - id: vlan_priority
        type: b3
        doc: 'Priority code point'

enums:
  ether_type_enum:
    2048:
      id: 'ipv4'
      doc: 'Internet Protocol version 4 (0800)'
    2054:
      id: 'arp'
      doc: 'Address Resolution Protocol (0806)'
    33024:
      id: 'vlan'
      doc: 'IEEE 802.1Q VLAN tag (8100)'
    34525:
      id: 'ipv6'
      doc: 'Internet Protocol version 6 (86dd)'

