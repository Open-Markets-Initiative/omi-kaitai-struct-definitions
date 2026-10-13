# ---------------------------------------------------------------------
# Kaitai struct definition for: Iex IexOptions Session Sbe v1.01
#
# Protocol:
#   Organization: Investors Exchange
#   Protocol: Session
#   Encoding: Simple Binary Encoding
#   Version: 1.01
#   Date: 7/17/2026
#   Specification: IEX Options Binary Session Protocol Specification v1.01
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
  id: iex_iexoptions_session_sbe_v1_01_server
  title: Iex IexOptions Session Sbe v1.01
  license: GPL-3.0
  endian: le

doc: 'Investors Exchange IEX Options Session Sbe v1.01'
doc-ref: https://www.iexexchange.io/options

seq:
  - id: server_sbe_message
    type: server_sbe_message_struct
    repeat: eos
    doc: 'Iex Options length-framed Sbe Message sent by Iex Options to the User'

types:
  server_sbe_message_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Number of bytes after this field until the next packet'
      - id: message_header
        type: message_header
        doc: 'Iex Options Sbe message header — message identifiers and length of message root'
      - id: server_payload
        size: packet_length - 10
        type:
          switch-on: message_header.schema_id
          cases:
            'schema_id::session': server_session_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Length of the message root before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        enum: schema_id
        doc: 'Identifier of the schema publishing the message (10000 market data, 20000 session, 20001 order entry business)'
      - id: version
        type: u2
        doc: 'Schema version'
  server_session_message:
    seq:
      - id: server_session_payload
        type:
          switch-on: _parent.message_header.template_id
          cases:
            'template_id::login_response_message': login_response_message
            'template_id::gateway_heartbeat_message': gateway_heartbeat_message
            'template_id::terminate_message': terminate_message
            'template_id::sequenced_message_header_message': sequenced_message_header_message
            'template_id::subsession_join_response_message': subsession_join_response_message
            'template_id::subsession_leave_response_message': subsession_leave_response_message
  login_response_message:
    seq:
      - id: logon_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'logonId'
      - id: status
        type: u1
        enum: status
        doc: 'status'
  gateway_heartbeat_message:
    seq:
      - id: keep_alive
        type: u1
        enum: keep_alive
        doc: 'keepAlive'
      - id: sub_sessions_groups
        type: sub_sessions_groups
        doc: 'SubSessions Block'
  sub_sessions_groups:
    seq:
      - id: session_info_group_encoding
        type: session_info_group_encoding
        doc: 'sessionInfoGroupEncoding'
      - id: sub_sessions_group
        type: sub_sessions_group
        repeat: expr
        repeat-expr: session_info_group_encoding.num_in_group
        doc: 'SubSessions'
  session_info_group_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  sub_sessions_group:
    seq:
      - id: subsession_type
        type: s1
        enum: subsession_type
        doc: 'subsessionType'
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: joined
        type: u1
        enum: joined
        doc: 'joined'
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
  terminate_message:
    seq:
      - id: reason
        type: u1
        enum: reason
        doc: 'reason'
  sequenced_message_header_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: sequence
        type: u4
        doc: 'sequence'
      - id: timestamp
        type: u8
        doc: 'timestamp'
  subsession_join_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: status
        type: u1
        enum: status
        doc: 'status'
  subsession_leave_response_message:
    seq:
      - id: subsession_id
        type: u8
        doc: 'subsessionId'
      - id: reason
        type: u1
        enum: reason
        doc: 'reason'

enums:
  template_id:
    1:
      id: 'login_request_message'
      doc: 'LoginRequestMessage'
    2:
      id: 'login_response_message'
      doc: 'LoginResponseMessage'
    3:
      id: 'gateway_heartbeat_message'
      doc: 'GatewayHeartbeatMessage'
    4:
      id: 'client_heartbeat_message'
      doc: 'ClientHeartbeatMessage'
    5:
      id: 'logout_request_message'
      doc: 'LogoutRequestMessage'
    6:
      id: 'terminate_message'
      doc: 'TerminateMessage'
    7:
      id: 'sequenced_message_header_message'
      doc: 'SequencedMessageHeaderMessage'
    8:
      id: 'subsession_join_message'
      doc: 'SubsessionJoinMessage'
    9:
      id: 'subsession_join_response_message'
      doc: 'SubsessionJoinResponseMessage'
    10:
      id: 'subsession_leave_message'
      doc: 'SubsessionLeaveMessage'
    11:
      id: 'subsession_leave_response_message'
      doc: 'SubsessionLeaveResponseMessage'
  schema_id:
    20000:
      id: 'session'
      doc: 'Sbe Schema Id for iex.options.boe.session'
  status:
    0:
      id: 'success'
      doc: 'Success'
    1:
      id: 'session_level_reject'
      doc: 'SessionLevelReject'
    2:
      id: 'logout_requested'
      doc: 'LogoutRequested'
    3:
      id: 'unknown'
      doc: 'Unknown'
    4:
      id: 'invalid_logon_id'
      doc: 'InvalidLogonId'
    5:
      id: 'invalid_token'
      doc: 'InvalidToken'
    6:
      id: 'already_logged_in'
      doc: 'AlreadyLoggedIn'
    7:
      id: 'login_timeout'
      doc: 'LoginTimeout'
    8:
      id: 'invalid_packet_length'
      doc: 'InvalidPacketLength'
    9:
      id: 'invalid_message'
      doc: 'InvalidMessage'
    10:
      id: 'join_revoked'
      doc: 'JoinRevoked'
    11:
      id: 'heartbeat_timeout'
      doc: 'HeartbeatTimeout'
    12:
      id: 'message_out_of_sequence'
      doc: 'MessageOutOfSequence'
    13:
      id: 'invalid_subsession_id'
      doc: 'InvalidSubsessionId'
    14:
      id: 'subsession_not_joined'
      doc: 'SubsessionNotJoined'
    15:
      id: 'denial_of_service'
      doc: 'DenialOfService'
    16:
      id: 'invalid_argument'
      doc: 'InvalidArgument'
    17:
      id: 'already_joined'
      doc: 'AlreadyJoined'
  keep_alive:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  subsession_type:
    0:
      id: 'client_to_gateway'
      doc: 'ClientToGateway'
    1:
      id: 'gateway_to_client'
      doc: 'GatewayToClient'
    2:
      id: 'reference_data'
      doc: 'ReferenceData'
  joined:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  reason:
    0:
      id: 'success'
      doc: 'Success'
    1:
      id: 'session_level_reject'
      doc: 'SessionLevelReject'
    2:
      id: 'logout_requested'
      doc: 'LogoutRequested'
    3:
      id: 'unknown'
      doc: 'Unknown'
    4:
      id: 'invalid_logon_id'
      doc: 'InvalidLogonId'
    5:
      id: 'invalid_token'
      doc: 'InvalidToken'
    6:
      id: 'already_logged_in'
      doc: 'AlreadyLoggedIn'
    7:
      id: 'login_timeout'
      doc: 'LoginTimeout'
    8:
      id: 'invalid_packet_length'
      doc: 'InvalidPacketLength'
    9:
      id: 'invalid_message'
      doc: 'InvalidMessage'
    10:
      id: 'join_revoked'
      doc: 'JoinRevoked'
    11:
      id: 'heartbeat_timeout'
      doc: 'HeartbeatTimeout'
    12:
      id: 'message_out_of_sequence'
      doc: 'MessageOutOfSequence'
    13:
      id: 'invalid_subsession_id'
      doc: 'InvalidSubsessionId'
    14:
      id: 'subsession_not_joined'
      doc: 'SubsessionNotJoined'
    15:
      id: 'denial_of_service'
      doc: 'DenialOfService'
    16:
      id: 'invalid_argument'
      doc: 'InvalidArgument'
    17:
      id: 'already_joined'
      doc: 'AlreadyJoined'

