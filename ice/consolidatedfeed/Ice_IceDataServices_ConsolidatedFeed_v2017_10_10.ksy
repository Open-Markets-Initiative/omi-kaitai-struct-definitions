# ---------------------------------------------------------------------
# Kaitai struct definition for: Ice ConsolidatedFeed Ctf v2017.10.10
#
# Protocol:
#   Organization: Intercontinental Exchange
#   Protocol: ConsolidatedFeed
#   Encoding: Consolidated Ticker Feed
#   Version: 2017.10.10
#   Date: 10/10/2017
#   Specification: CTF_Wire_Protocol_2017-10-10.pdf
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
  id: ice_icedataservices_consolidatedfeed_ctf_v2017_10_10
  title: Ice ConsolidatedFeed Ctf v2017.10.10
  license: GPL-3.0
  endian: be

doc: 'Intercontinental Exchange ICE Data Services ConsolidatedFeed Ctf v2017.10.10'

seq:
  - id: frame_start
    type: u1
    doc: 'Marks the beginning of any frame, fixed at 0x04 (2.2.1)'
  - id: frame_header
    type: frame_header_struct
    doc: 'The Protocol Signature and Length fields, which together form the header of the frame (section 2)'
  - id: payload
    size: frame_header.length
    doc: 'The token=value pairs: Param fields (token=value) separated by Delim fields (|), as many bytes as the Length states (2.2.4, 2.2.5)'
  - id: frame_end
    type: u1
    doc: 'Marks the end of the frame, 0x03 (2.2.6)'

types:
  frame_header_struct:
    seq:
      - id: protocol_signature
        type: u1
        doc: 'Indicates what processing rules apply to the payload; its current value is 0x20 (2.2.2)'
      - id: length
        type: u4
        doc: 'Total number of bytes in the payload, excluding the header and framing characters (2.2.3)'

