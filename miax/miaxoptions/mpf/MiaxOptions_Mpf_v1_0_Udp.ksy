# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions Mpf Mach v1.0
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: MIAX Product Feed
#   Encoding: Mach
#   Version: 1.0
#   Date: 08/21/2018
#   Specification: MIAX Product Feed v1.0_C.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: miax_miaxoptions_mpf_mach_v1_0_udp
  title: Miax MiaxOptions Mpf Mach v1.0
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Options MIAX Product Feed Mach v1.0'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-options/interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: mach_packet_header
        type: mach_packet_header
        doc: 'Mach packet header (12 bytes)'
      - id: payload
        size: mach_packet_header.packet_length - 12
        type:
          switch-on: mach_packet_header.packet_type
          cases:
            'packet_type::application_message': application_message
  mach_packet_header:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: packet_length
        type: u2
        doc: 'Length of the packet, including the header and application data'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Mach protocol packet type'
      - id: session_number
        type: u1
        doc: 'The Session this packet was generated from'
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.mach_packet_header.packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::index_value_message': index_value_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  index_value_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this index value was calculated. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index or Settlement Symbol'
      - id: value_field
        type: decimal_u4_2
        doc: 'Index or Settlement Value. Implied decimal with scale 1e-2'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_u4_2:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 100.0

enums:
  packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message; Sequence Number is set to 0'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    0x31:
      id: 'system_time_message'
      doc: 'This is the message format that will be used to disseminate the “seconds” part of the timestamp that is applicable to all messages that are sent in the current second.'
    0x49:
      id: 'index_value_message'
      doc: 'This is the message format that will be used to disseminate current index value. The index value may be the index cash value or the index settlement value, as identified by the Index Symbol.'
  sesm_packet_type:
    0x73:
      id: 'sequenced_data_packet'
      doc: 'SesM sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SesM unsequenced data packet'
    0x6c:
      id: 'login_request'
      doc: 'SesM Login Request'
    0x72:
      id: 'login_response'
      doc: 'SesM Login Response'
    0x63:
      id: 'synchronization_complete'
      doc: 'SesM Synchronization Complete'
    0x61:
      id: 'retransmission_request'
      doc: 'SesM Retransmission Request'
    0x58:
      id: 'logout_request'
      doc: 'SesM Logout Request'
    0x47:
      id: 'goodbye_packet'
      doc: 'SesM Logout Request'
    0x75:
      id: 'trading_session_update'
      doc: 'SesM Trading Session Update'
    0x30:
      id: 'server_heartbeat'
      doc: 'SesM Server Heartbeat'
    0x31:
      id: 'client_heartbeat'
      doc: 'SesM Client Heartbeat'
    0x54:
      id: 'test_packet'
      doc: 'SesM Test Packet'
  unsequenced_message_type:
    0x52:
      id: 'refresh_request_message'
      doc: 'Sent by the firm over the MPF Retransmission Interface (SesM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Options over the MPF Retransmission Interface (SesM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request. Note: MIAX Options PDF assigns Response Type "R" (uppercase) to this message, colliding with the Request Type "R" byte; lowercase "r" is used here to match the Pearl convention for case-distinct discrimination.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Options over the MPF Retransmission Interface (SesM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x73:
      id: 'symbol_definition_refresh'
      doc: 'Symbol Definition Refresh'
    0x49:
      id: 'index_update_refresh'
      doc: 'Index Update Refresh'
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

