# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Millennium UdpUnitHeader Mitch v1.0
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Udp Unit Header
#   Encoding: Millennium Itch
#   Version: 1.0
#   Date: 1/1/2018
#   Specification: mit303issue119.pdf
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
  id: lseg_millennium_udpunitheader_mitch_v1_0
  title: Lseg Millennium UdpUnitHeader Mitch v1.0
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Millennium Exchange Udp Unit Header Mitch v1.0'
doc-ref: https://www.londonstockexchange.com/resources/trade-resources

seq:
  - id: unit_header
    type: unit_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: unit_header.message_count

types:
  unit_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message block including the header and all payload messages'
      - id: message_count
        type: u1
        doc: 'Number of payload messages that will follow the header'
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the payload messages relate to'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the first payload message'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mitch Udp Message Header'
      - id: payload
        size: message_header.message_length - 2
        doc: 'Raw bytes'
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        doc: 'Code identifying this message type'

