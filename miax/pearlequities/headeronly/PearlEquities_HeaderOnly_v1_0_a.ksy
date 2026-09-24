# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlEquities HeaderOnly ESesM v1.0.a
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Headers Only
#   Encoding: Extended Session Management
#   Version: 1.0.a
#   Date: 6/26/2020
#   Specification: tcp_session_mgmt_esesm_v1.0.a.pdf
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
  id: miax_pearlequities_headeronly_esesm_v1_0_a
  title: Miax PearlEquities HeaderOnly ESesM v1.0.a
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Equities Headers Only ESesM v1.0.a'
doc-ref: https://www.miaxequities.com/interface-specifications/pearl-equities

seq:
  - id: esesm_tcp_packet
    type: esesm_tcp_packet_struct
    repeat: eos
    doc: 'ESesM Tcp Packet'

types:
  esesm_tcp_packet_struct:
    seq:
      - id: esesm_packet_header
        type: esesm_packet_header
        doc: 'ESesM packet header'
      - id: esesm_payload
        size: esesm_packet_header.esesm_packet_length + 2 - 3
        type:
          switch-on: esesm_packet_header.esesm_packet_type
          cases:
            'esesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'esesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'esesm_packet_type::login_request': login_request
            'esesm_packet_type::login_response': login_response
            'esesm_packet_type::synchronization_complete': synchronization_complete
            'esesm_packet_type::retransmission_request': retransmission_request
            'esesm_packet_type::logout_request': logout_request
            'esesm_packet_type::goodbye_packet': goodbye_packet
            'esesm_packet_type::test_packet': test_packet
  esesm_packet_header:
    seq:
      - id: esesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: esesm_packet_type
        type: u1
        enum: esesm_packet_type
        doc: 'ESesM protocol packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this sequenced data packet'
      - id: matching_engine_id
        type: u1
        doc: 'Matching Engine that originated the packet'
      - id: sequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'ESesM sequenced message type'
      - id: sequenced_message
        size-eos: true
        doc: 'Raw sequenced message bytes'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'ESesM unsequenced message type'
      - id: unsequenced_message
        size-eos: true
        doc: 'Raw unsequenced message bytes'
  login_request:
    seq:
      - id: esesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol version'
      - id: username
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX during initial setup'
      - id: computer_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX Futures Exchange during initial setup'
      - id: application_protocol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Miax Application Protocol'
      - id: requested_trading_session_id
        type: u1
        doc: 'Specifies the session the client would like to log into, or zero to log into the currently active session'
      - id: requested_sequence_number
        type: u8
        doc: 'Specifies client requested sequence number'
  login_response:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Login Status'
      - id: trading_session_id
        type: u1
        doc: 'The current trading session ID of the corresponding Matching Engine'
      - id: highest_sequence_number
        type: u8
        doc: 'the highest sequence number that the server currently has for the client'
  synchronization_complete:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
  retransmission_request:
    seq:
      - id: start_sequence_number
        type: u8
        doc: 'Sequence number of the first packet to be retransmitted'
      - id: end_sequence_number
        type: u8
        doc: 'Sequence number of the last packet to be retransmitted'
  logout_request:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  goodbye_packet:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  test_packet:
    seq:
      - id: test_text
        type: str
        size: _parent.esesm_packet_header.esesm_packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'

enums:
  esesm_packet_type:
    0x73:
      id: 'sequenced_data_packet'
      doc: 'ESesM sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'ESesM unsequenced data packet'
    0x6c:
      id: 'login_request'
      doc: 'ESesM Login Request'
    0x72:
      id: 'login_response'
      doc: 'ESesM Login Response'
    0x63:
      id: 'synchronization_complete'
      doc: 'ESesM Synchronization Complete'
    0x61:
      id: 'retransmission_request'
      doc: 'ESesM Retransmission Request'
    0x58:
      id: 'logout_request'
      doc: 'ESesM Logout Request'
    0x47:
      id: 'goodbye_packet'
      doc: 'ESesM Logout Request'
    0x75:
      id: 'trading_session_update'
      doc: 'ESesM Trading Session Update'
    0x30:
      id: 'server_heartbeat'
      doc: 'ESesM Server Heartbeat'
    0x31:
      id: 'client_heartbeat'
      doc: 'ESesM Client Heartbeat'
    0x54:
      id: 'test_packet'
      doc: 'ESesM Test Packet'
  login_status:
    0x20:
      id: 'successful'
      doc: 'Successful'
    0x53:
      id: 'invalid_trading_session_requested'
      doc: 'Invalid trading session requested for the Matching Engine'
    0x55:
      id: 'no_active_trading_session_exists'
      doc: 'No active trading session exists for the Matching Engine, Matching Engine unavailable'
    0x58:
      id: 'rejected'
      doc: 'Invalid Username/Computer ID combination'
    0x4e:
      id: 'invalid_start_sequence_number_requested'
      doc: 'Invalid start sequence number requested'
    0x49:
      id: 'incompatible_session_protocol_version'
      doc: 'Incompatible Session protocol version'
    0x41:
      id: 'incompatible_application_protocol_version'
      doc: 'Incompatible application protocol version'
    0x4c:
      id: 'request_rejected_because_client_already_logged_in'
      doc: 'Request rejected because client already logged in'
  logout_reason:
    0x20:
      id: 'graceful_logout'
      doc: 'Graceful Logout'
    0x42:
      id: 'bad_packet'
      doc: 'Bad SesM packet'
    0x4c:
      id: 'timed_out'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'

