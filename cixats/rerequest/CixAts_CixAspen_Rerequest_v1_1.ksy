# ---------------------------------------------------------------------
# Kaitai struct definition for: CixAts Rerequest Aspen v1.1
#
# Protocol:
#   Organization: CIX Trading Inc.
#   Protocol: CIX Udp Rerequest
#   Encoding: Aspen
#   Version: 1.1
#   Date: 9/15/2025
#   Specification: Market Data Recovery Feed Specification-1.1.pdf
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
  id: cixats_cixaspen_rerequest_aspen_v1_1
  title: CixAts Rerequest Aspen v1.1
  license: GPL-3.0
  endian: le

doc: 'CIX Trading Inc. CIX Aspen CIX Udp Rerequest Aspen v1.1'
doc-ref: https://www.thecix.ca/market-data

seq:
  - id: rerequest_header
    type: rerequest_header_struct
    doc: 'Aspen Udp rerequest header'

types:
  rerequest_header_struct:
    seq:
      - id: market_day_identifier
        type: str
        size: 9
        encoding: ASCII
        doc: 'Must match current Market Day Identifier'
      - id: feed_identifier
        type: u1
        enum: feed_identifier
        doc: 'Must match Feed Identifier of rerequest server'
      - id: sequence
        type: u8
        doc: 'Sequence number for the first requested message'
      - id: count
        type: u2
        doc: 'Number of messages requested'

enums:
  feed_identifier:
    0x41:
      id: 'aspen'
      doc: 'Aspen'
    0x56:
      id: 'aspen_vert'
      doc: 'Aspen Vert'
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint'
    0x42:
      id: 'aspen_uat'
      doc: 'Aspen Uat'
    0x57:
      id: 'aspen_vert_uat'
      doc: 'Aspen Vert Uat'
    0x4e:
      id: 'midpoint_uat'
      doc: 'Midpoint Uat'

