# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax OnyxFutures HeaderOnly Mach v1.0
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Headers Only
#   Encoding: Mach
#   Version: 1.0
#   Date: 6/26/2020
#   Specification: TcpSessionMgmt_eSesM_v1.0.a.updated.pdf.pdf
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
  id: miax_onyxfutures_headeronly_mach_v1_0
  title: Miax OnyxFutures HeaderOnly Mach v1.0
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Futures Onyx Headers Only Mach v1.0'
doc-ref: https://www.miaxequities.com/interface-specifications/pearl-equities

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this data packet'
      - id: packet_length
        type: u2
        doc: 'Length of the packet. This includes the header and application data'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'protocol packet type'
      - id: session_number
        type: u1
        doc: 'The Session this packet was generated from'
      - id: payload
        type:
          switch-on: packet_type
          cases:
            'packet_type::application_message': application_message
  application_message:
    seq:
      - id: message_type
        type: u1
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.packet_length - 13
        doc: 'Raw message data'

enums:
  packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'

