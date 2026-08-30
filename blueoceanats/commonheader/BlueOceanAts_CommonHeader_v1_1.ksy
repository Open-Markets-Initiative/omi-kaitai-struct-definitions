# ---------------------------------------------------------------------
# Kaitai struct definition for: BlueOceanAts CommonHeader Udp v1.1
#
# Protocol:
#   Organization: Blue Ocean Technologies
#   Protocol: Common Header
#   Encoding: Udp
#   Version: 1.1
#   Date: 1/1/2024
#   Specification: Blue Ocean ATS UDP Protocol.pdf
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
  id: blueoceanats_commonheader_udp_v1_1
  title: BlueOceanAts CommonHeader Udp v1.1
  license: GPL-3.0
  endian: be

doc: 'Blue Ocean Technologies Common Header Udp v1.1'
doc-ref: https://blueocean-tech.io/trading-updates

seq:
  - id: common_header
    type: common_header_struct
    doc: 'The header every datagram opens with, naming the message type, the data session and the sequence the payload starts at'
  - id: sequenced_messages
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The kind of datagram that follows the header, a heartbeat, a session shutdown or a sequenced message'
      - id: header_length
        type: u1
        doc: 'Total bytes in this header'
      - id: session_id
        type: u8
        doc: 'Identifier of the data session the datagram belongs to; heartbeats on the session report it as active'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message in the datagram; on a heartbeat or a session shutdown it is instead the highest sequence published so far, zero before any message is published'
  sequenced_message:
    seq:
      - id: num_message
        type: u2
        doc: 'Number of messages in this packet'
      - id: message
        type: message
        repeat: expr
        repeat-expr: num_message
        doc: 'One element of the message list, its length followed by that many bytes of payload'
  message:
    seq:
      - id: message_length
        type: u2
        doc: 'Number of bytes in the following message'
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: payload
        size: sbe_header.block_length
        doc: 'Raw message bytes'
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Blue Ocean Udp Block length'
      - id: template_id
        type: u1
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'

enums:
  message_type:
    0:
      id: 'heartbeat_message'
      doc: 'Sent periodically to say the data session is active and connectivity is unbroken, and to expose loss when traffic is quiet; it carries no payload and does not advance the sequence'
    1:
      id: 'session_shutdown_message'
      doc: 'Replaces the heartbeat once no further sequenced messages will be sent for the session; repeated so every client sees it, carries no payload and does not advance the sequence'
    2:
      id: 'sequenced_message'
      doc: 'Carries one or more business messages, the message count followed by that many length prefixed payloads'

