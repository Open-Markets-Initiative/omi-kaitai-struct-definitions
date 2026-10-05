# ---------------------------------------------------------------------
# Kaitai struct definition for: Osi Network Transport Tcp v1
#
# Protocol:
#   Organization: Open Systems Interconnection
#   Protocol: Transport
#   Encoding: Transmission Control Protocol
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
  id: osi_network_transport_tcp_v1
  title: Osi Network Transport Tcp v1
  license: GPL-3.0
  endian: be

doc: 'Open Systems Interconnection Network Transport Tcp v1'
doc-ref: https://www.rfc-editor.org/rfc/rfc9293

seq:
  - id: tcp_source_port
    type: u2
    doc: 'Port the segment is sent from'
  - id: tcp_destination_port
    type: u2
    doc: 'Port the segment is sent to'
  - id: tcp_sequence_number
    type: u4
    doc: 'The stream position of the payload''s first byte'
  - id: acknowledgment_number
    type: u4
    doc: 'The next stream position the sender expects'
  - id: offset_and_flags
    type: offset_and_flags_struct
    doc: 'The header length and the control flags, most significant bit first'
  - id: window_size
    type: u2
    doc: 'Bytes the receiver will accept'
  - id: tcp_checksum
    type: u2
    doc: 'One''s complement checksum'
  - id: urgent_pointer
    type: u2
    doc: 'Offset of urgent data, when the Urg flag is set'
  - id: tcp_options
    size: offset_and_flags.data_offset * 4 - 20
    doc: 'Header options, when the header is longer than 20 bytes'
  - id: tcp_payload
    size-eos: true

types:
  offset_and_flags_struct:
    seq:
      - id: fin_flag
        type: b1
        doc: 'No more data from the sender: closes the connection'
      - id: syn_flag
        type: b1
        doc: 'Synchronize sequence numbers: opens the connection'
      - id: rst_flag
        type: b1
        doc: 'Reset the connection'
      - id: psh_flag
        type: b1
        doc: 'Push the data to the application'
      - id: ack_flag
        type: b1
        doc: 'The acknowledgment number is significant'
      - id: urg_flag
        type: b1
        doc: 'The urgent pointer is significant'
      - id: ece_flag
        type: b1
        doc: 'ECN echo'
      - id: cwr_flag
        type: b1
        doc: 'Congestion window reduced'
      - id: ns_flag
        type: b1
        doc: 'ECN nonce'
      - id: tcp_reserved
        type: b3
        doc: 'Reserved, zero'
      - id: data_offset
        type: b4
        doc: 'Header length in 32 bit words, 5 to 15'

