# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v2.1
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vender Feed
#   Version: 2.1
#   Date: 01/23/2019
#   Specification: Mx.Sola.Multicast.Hsvf.v.2.1.pdf
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
  id: tmx_mx_solamulticast_hsvf_v2_1
  title: Tmx Mx SolaMulticast Hsvf v2.1
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Multicast Hsvf v2.1'

seq:
  - id: hsvf_stx
    type: u1
    doc: 'Start of Hsvf message'
  - id: messageheader
    type: messageheader_struct
    doc: 'Hsvf Udp Market Data Packet Header'
  - id: message_body
    type:
      switch-on: messageheader.message_type
      cases:
        '"LI"': login_message
        '"RT"': retransmission_request_message
        '"ER"': error_message
  - id: hsvf_etx
    type: u1
    doc: 'End of Hsvf message'

types:
  messageheader_struct:
    seq:
      - id: sequence_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Sequence numbers will range from ascii decimal 000000001 to 999999999'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Identifies the type of message being sent'
  login_message:
    seq:
      - id: user
        type: str
        size: 16
        encoding: ASCII
        doc: 'Participant logging in'
      - id: pwd
        type: str
        size: 16
        encoding: ASCII
        doc: 'Participant password'
      - id: timestamp
        type: str
        size: 6
        encoding: ASCII
        doc: 'Time submitted'
      - id: protocol
        type: str
        size: 2
        encoding: ASCII
        doc: 'Value(s) supported: D4, D5'
  retransmission_request_message:
    seq:
      - id: line
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specific address and port on which market is disseminated based on a list of CPUs and Market Depth Setting'
      - id: start
        type: str
        size: 9
        encoding: ASCII
        doc: 'Starting message number'
      - id: end
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ending message number'
  error_message:
    seq:
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'Error Code'
      - id: error_msg
        type: str
        size: 80
        encoding: ASCII
        doc: 'Error Message'

