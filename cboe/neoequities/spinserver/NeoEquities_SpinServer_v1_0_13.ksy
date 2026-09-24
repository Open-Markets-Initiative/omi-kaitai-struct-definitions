# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe NeoEquities SpinServer Pitch v1.0.13
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Spin Server
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
  id: cboe_neoequities_spinserver_pitch_v1_0_13
  title: Cboe NeoEquities SpinServer Pitch v1.0.13
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Canada NEO Spin Server Pitch v1.0.13'
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
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
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
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
            'message_type::instrument_definition_request_message': instrument_definition_request_message
            'message_type::instrument_definition_response_message': instrument_definition_response_message
            'message_type::trade_replay_request_message': trade_replay_request_message
            'message_type::trade_replay_response_message': trade_replay_response_message
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
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'Number of Add Order and Single Side Update messages which will be contained in this spin'
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: instrument_count
        type: u4
        doc: 'Number of Instrument Directory messages which will be contained in this spin'
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'
  trade_replay_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  trade_replay_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: trade_count
        type: u8
        doc: 'Number of Trade, Trade Break, and Trade Correction messages which will be contained in this spin'
      - id: status
        type: u1
        enum: status
        doc: 'Accepted or reason for reject'

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The first message the Member process sends to the Spin Server after connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format is identical to the GRP Login message.'
    0x02:
      id: 'login_response_message'
      doc: 'Sent by the Spin Server to a Member''s process in response to a Login message. The Status field reflects an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'Sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'Used by a Member''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'Sent in response to a Member''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'Indicates that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the Member''s copy of the book to make it current.'
    0x84:
      id: 'instrument_definition_request_message'
      doc: 'Used by a Member''s process to request transmission of this unit''s Instrument Directory messages.'
    0x85:
      id: 'instrument_definition_response_message'
      doc: 'Indicates whether a spin will be sent in response to a Member''s Instrument Definition Request message.'
    0x86:
      id: 'instrument_definition_finished_message'
      doc: 'Indicates that all messages for the spin requested have been sent. An Instrument Definition Finished message is only sent if an Instrument Definition Request was not rejected.'
    0x87:
      id: 'trade_replay_request_message'
      doc: 'Used by a Member''s process to request transmission of this unit''s Trade, Trade Break, and Trade Correction messages. Note Order Executed messages will be converted to Trade messages.'
    0x88:
      id: 'trade_replay_response_message'
      doc: 'Indicates whether a spin will be sent in response to a Member''s Trade Replay Request message.'
    0x89:
      id: 'trade_replay_finished_message'
      doc: 'Indicates that all messages for the spin requested have been sent. A Trade Replay Finished message is only sent if a Trade Replay Request message was not rejected.'
  status:
    0x41:
      id: 'accepted_login_accepted'
      doc: 'Accepted Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x53:
      id: 'invalid_session_spin_already_in_progress'
      doc: 'Invalid Session Spin Already In Progress'

