# ---------------------------------------------------------------------
# Kaitai struct definition for: Osi Network Internet Ip v4
#
# Protocol:
#   Organization: Open Systems Interconnection
#   Protocol: Internet
#   Encoding: Internet Protocol
#   Version: 4
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
  id: osi_network_internet_ip_v4
  title: Osi Network Internet Ip v4
  license: GPL-3.0
  endian: be

doc: 'Open Systems Interconnection Network Internet Ip v4'
doc-ref: https://www.rfc-editor.org/rfc/rfc791

seq:
  - id: version_and_header_length
    type: version_and_header_length_struct
    doc: 'The version and the header length, most significant bit first'
  - id: type_of_service
    type: type_of_service_struct
    doc: 'Differentiated services and congestion notification, most significant bit first'
  - id: len_ip_packet
    type: u2
    doc: 'Bytes of the packet, header and payload'
  - id: identification
    type: u2
    doc: 'Identifies the fragments of one datagram'
  - id: fragmentation
    type: fragmentation_struct
    doc: 'Fragmentation flags and offset, most significant bit first'
  - id: time_to_live
    type: u1
    doc: 'Hops the packet may still take'
  - id: ip_protocol
    type: u1
    enum: ip_protocol_enum
    doc: 'The protocol the packet carries'
  - id: ip_header_checksum
    type: u2
    doc: 'One''s complement checksum of the header'
  - id: source_address
    type: u4
    doc: 'Address the packet is sent from'
  - id: destination_address
    type: u4
    doc: 'Address the packet is sent to; a multicast group for a market data feed'
  - id: ip_options
    size: version_and_header_length.ip_header_length * 4 - 20
    doc: 'Header options, when the header is longer than 20 bytes'
  - id: ip_payload
    size-eos: true

types:
  version_and_header_length_struct:
    seq:
      - id: ip_header_length
        type: b4
        doc: 'Header length in 32 bit words, 5 to 15'
      - id: ip_version
        type: b4
        doc: 'Internet Protocol version, 4'
  type_of_service_struct:
    seq:
      - id: congestion_notification
        type: b2
        doc: 'Explicit congestion notification'
      - id: differentiated_services
        type: b6
        doc: 'Differentiated services code point'
  fragmentation_struct:
    seq:
      - id: fragment_offset
        type: b13
        doc: 'The fragment''s position in the datagram, in 8 byte units'
      - id: more_fragments
        type: b1
        doc: 'More fragments of the datagram follow'
      - id: dont_fragment
        type: b1
        doc: 'The datagram may not be fragmented'
      - id: ip_reserved
        type: b1
        doc: 'Reserved, zero'

enums:
  ip_protocol_enum:
    1:
      id: 'icmp'
      doc: 'Internet Control Message Protocol'
    2:
      id: 'igmp'
      doc: 'Internet Group Management Protocol'
    6:
      id: 'tcp'
      doc: 'Transmission Control Protocol'
    17:
      id: 'udp'
      doc: 'User Datagram Protocol'

