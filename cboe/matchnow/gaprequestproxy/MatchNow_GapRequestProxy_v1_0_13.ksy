# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe MatchNow GapRequestProxy Pitch v1.0.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Gap Request Proxy
#   Encoding: Pitch
#   Version: 1.0.13
#   Date: 10/27/2025
#   Specification: Cboe Canada Equities Multicast PITCH Specification (2025-12-06).pdf
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
  id: cboe_matchnow_gaprequestproxy_pitch_v1_0_13
  title: Cboe MatchNow GapRequestProxy Pitch v1.0.13
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Canada MATCHNow Gap Request Proxy Pitch v1.0.13'
doc-ref: https://www.cboe.com/ca/equities/support/technical/

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
        type: u2
        doc: 'Count of messages requested'
      - id: unit
        type: u1
        doc: 'Unit that the gap is requested for'
      - id: sequence
        type: u4
        doc: 'Sequence of first message (lowest sequence in range)'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::gap_request_message': gap_request_message
            'message_type::gap_response_message': gap_response_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by Cboe Canada'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Cboe Canada'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '(space filled)'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by Cboe Canada'
  login_response_message:
    seq:
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'
  gap_request_message:
    seq:
      - id: unit
        type: u1
        doc: 'Unit that the gap is requested for'
      - id: sequence
        type: u4
        doc: 'Sequence of first message (lowest sequence in range)'
      - id: count
        type: u2
        doc: 'Count of messages requested'
  gap_response_message:
    seq:
      - id: unit
        type: u1
        doc: 'Unit that the gap is requested for'
      - id: sequence
        type: u4
        doc: 'Sequence of first message (lowest sequence in range)'
      - id: count
        type: u2
        doc: 'Count of messages requested'
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The first message the Member process sends to the GRP after connection to the GRP is established. Failure to login before sending any other message type will result in the connection being dropped by the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'Sent by the GRP to the Member process in response to a Login message. The Status field reflects an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x03:
      id: 'gap_request_message'
      doc: 'Used by a Member''s process to request retransmission of a sequenced message (or messages) by one of Cboe Canada''s gap servers.'
    0x04:
      id: 'gap_response_message'
      doc: 'Sent by the GRP in response to a Gap Request message. The Unit and Sequence fields will match the values supplied in the Gap Request message. A Gap Response message, with a Status of Accepted or reason for failure, will be sent for each Gap Request message received by the GRP.'
  status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
    0x4f:
      id: 'out_of_range_ahead_of_sequence_or_too_far_behind'
      doc: 'Out Of Range Ahead Of Sequence Or Too Far Behind'
    0x44:
      id: 'daily_gap_request_allocation_exhausted'
      doc: 'Daily Gap Request Allocation Exhausted'
    0x4d:
      id: 'minute_gap_request_allocation_exhausted'
      doc: 'Minute Gap Request Allocation Exhausted'
    0x43:
      id: 'count_request_limit_for_one_gap_request_exceeded'
      doc: 'Count Request Limit For One Gap Request Exceeded'
    0x49:
      id: 'invalid_unit_specified_in_request'
      doc: 'Invalid Unit Specified In Request'
    0x55:
      id: 'unit_is_currently_unavailable'
      doc: 'Unit Is Currently Unavailable'

