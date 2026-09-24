# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions Mpf Mach v1.1
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: MIAX Product Feed
#   Encoding: Mach
#   Version: 1.1
#   Date: 02/20/2019
#   Specification: MIAX_Product_Feed_v1.1_re.pdf
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
  id: miax_miaxoptions_mpf_mach_v1_1_tcp
  title: Miax MiaxOptions Mpf Mach v1.1
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Options MIAX Product Feed Mach v1.1'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-options/interface-specifications

seq:
  - id: sesm_tcp_packet
    type: sesm_tcp_packet_struct
    repeat: eos
    doc: 'SesM Tcp Packet'

types:
  sesm_tcp_packet_struct:
    seq:
      - id: sesm_packet_header
        type: sesm_packet_header
        doc: 'SesM packet header'
      - id: sesm_payload
        size: sesm_packet_header.sesm_packet_length + 2 - 3
        type:
          switch-on: sesm_packet_header.sesm_packet_type
          cases:
            'sesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'sesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'sesm_packet_type::login_request': login_request
            'sesm_packet_type::login_response': login_response
            'sesm_packet_type::synchronization_complete': synchronization_complete
            'sesm_packet_type::retransmission_request': retransmission_request
            'sesm_packet_type::logout_request': logout_request
            'sesm_packet_type::goodbye_packet': goodbye_packet
            'sesm_packet_type::test_packet': test_packet
  sesm_packet_header:
    seq:
      - id: sesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: sesm_packet_type
        type: u1
        enum: sesm_packet_type
        doc: 'SesM protocol packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: matching_engine_id
        type: u1
        doc: 'Matching Engine that originated the packet'
      - id: sequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market-data application message type carried over the SesM sequenced channel (matches the MACH UDP Message Type byte; Miax Options uses Ascii message codes)'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Market-data Refresh request/response discriminator carried over the SesM unsequenced channel (Request Type R, Response Type r, End of Refresh E)'
      - id: unsequenced_message
        size: _parent.sesm_packet_header.sesm_packet_length - 2 - 1
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::refresh_request_message': refresh_request_message
            'unsequenced_message_type::refresh_response_message': refresh_response_message
            'unsequenced_message_type::end_of_refresh_notification_message': end_of_refresh_notification_message
  refresh_request_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  refresh_response_message:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: application_message
        type: application_message
        size: _parent._parent.sesm_packet_header.sesm_packet_length - 12
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent._parent._parent.sesm_packet_header.sesm_packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::symbol_definition_message': symbol_definition_message
            'message_type::index_value_message': index_value_message
            'message_type::synthetic_future_value_message': synthetic_future_value_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  symbol_definition_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: synthetic_future_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Synthetic Future Symbol: The first 3 characters are the base symbol, followed by a single character expiration month code and a single digit expiration year code'
      - id: settlement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlement date of the Option associated with the Synthetic Future in YYYYMMDD format'
      - id: symbol_status
        type: u1
        enum: symbol_status
        doc: 'Indicates if this Synthetic Future symbol is going to get price updates on MIAX in the current session'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  index_value_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index or Settlement Symbol'
      - id: value_field
        type: decimal_u4_2
        doc: 'Index or Settlement Value. Implied decimal with scale 1e-2'
  synthetic_future_value_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: synthetic_future_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Synthetic Future Symbol: The first 3 characters are the base symbol, followed by a single character expiration month code and a single digit expiration year code'
      - id: value_field
        type: decimal_u4_2
        doc: 'Index or Settlement Value. Implied decimal with scale 1e-2'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  end_of_refresh_notification_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  login_request:
    seq:
      - id: sesm_version
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
        size: _parent.sesm_packet_header.sesm_packet_length - 2
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
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  test_packet:
    seq:
      - id: test_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
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
    0x73:
      id: 'symbol_definition_message'
      doc: 'This is the message format that will be used to disseminate all Synthetic Future symbol definitions for the current session.'
    0x49:
      id: 'index_value_message'
      doc: 'This is the message format that will be used to disseminate current index value. The index value may be the index cash value or the index settlement value, as identified by the Index Symbol.'
    0x5a:
      id: 'synthetic_future_value_message'
      doc: 'This is the message format that will be used to disseminate current Synthetic Future values. The specific Synthetic Future value is identified by the Synthetic Future Symbol.'
  symbol_status:
    0x41:
      id: 'active_future'
      doc: 'Active Future'
    0x49:
      id: 'inactive_future'
      doc: 'Inactive Future'
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
    0x49:
      id: 'index_update_refresh'
      doc: 'Index Update Refresh'
    0x5a:
      id: 'synthetic_future_values'
      doc: 'Synthetic Future Values'
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

