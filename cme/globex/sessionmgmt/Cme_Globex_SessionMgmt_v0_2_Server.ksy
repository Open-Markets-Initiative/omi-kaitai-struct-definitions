# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex SessionMgmt Sbe v0.2
#
# Protocol:
#   Organization: CME Group
#   Protocol: Session Management
#   Encoding: Simple Binary Encoding
#   Version: 0.2
#   Date: 3/10/2021
#   Specification: Unknown
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
  id: cme_globex_sessionmgmt_sbe_v0_2_server
  title: Cme Globex SessionMgmt Sbe v0.2
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Session Management Sbe v0.2'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+MDP+3.0+Market+Data

seq:
  - id: server_technical_header
    type: server_technical_header_struct
    doc: 'Cme Technical Header sent by Cme to the subscriber'
  - id: server_message
    type: server_message_struct
    repeat: eos
    doc: 'Cme Session Message sent by Cme to the subscriber'

types:
  server_technical_header_struct:
    seq:
      - id: encoding_type
        type: u2
        doc: 'Encoding Type'
      - id: message_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: sending_time
        type: u8
        doc: 'Packet Sending Time'
  server_message_struct:
    seq:
      - id: message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: server_payload
        size: message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::negotiation_reject': negotiation_reject
            'template_id::negotiation_response': negotiation_response
            'template_id::terminate': terminate
            'template_id::request_ack': request_ack
            'template_id::request_reject': request_reject
  message_header:
    seq:
      - id: block_length
        type: u2
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
  negotiation_reject:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: error_codes
        type: u1
        enum: error_codes
        doc: 'Error code for reject reason'
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
  negotiation_response:
    seq:
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: secret_key_secure_id_expiration
        type: u2_nullable
        doc: 'This indicates in how many days the HMAC secret key will expire. Nullable, No Value = 65535'
      - id: padding_4
        size: 4
        doc: '4 bytes padding'
  terminate:
    seq:
      - id: reason
        type: str
        size: 48
        encoding: ASCII
        doc: 'Reject reason details'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: error_codes
        type: u1
        enum: error_codes
        doc: 'Error code for reject reason'
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
  request_ack:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: md_req_id_status
        type: u1
        enum: md_req_id_status
        doc: 'Status of the request acknowledgement'
      - id: request_ack_security_groups
        type: request_ack_security_groups
        doc: 'NoSecurityGroups Block'
      - id: request_ack_related_symbol_groups
        type: request_ack_related_symbol_groups
        doc: 'NoRelatedSym Block'
  request_ack_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: request_ack_security_group
        type: request_ack_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups acknowledged'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  request_ack_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  request_ack_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: request_ack_related_symbol_group
        type: request_ack_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of securities acknowledged'
  request_ack_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  request_reject:
    seq:
      - id: md_req_id_optional
        type: u4_nullable
        doc: 'Unique identifier for Market Data Request. Nullable, No Value = 4294967295'
      - id: md_req_rej_reason
        type: u1
        enum: md_req_rej_reason
        doc: 'Market Data Request Reject reason code'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        doc: 'Reject reason details'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295

enums:
  template_id:
    200:
      id: 'negotiate'
      doc: 'Negotiate'
    201:
      id: 'negotiation_reject'
      doc: 'NegotiationReject'
    202:
      id: 'negotiation_response'
      doc: 'NegotiationResponse'
    203:
      id: 'terminate'
      doc: 'Terminate'
    205:
      id: 'market_data_request'
      doc: 'MarketDataRequest'
    206:
      id: 'request_ack'
      doc: 'RequestAck'
    207:
      id: 'request_reject'
      doc: 'RequestReject'
    208:
      id: 'security_list_request'
      doc: 'SecurityListRequest'
    209:
      id: 'security_status_request'
      doc: 'SecurityStatusRequest'
    210:
      id: 'subscriber_heartbeat'
      doc: 'SubscriberHeartbeat'
  error_codes:
    0:
      id: 'hmac_reject'
      doc: 'Failed authentication'
    1:
      id: 'invalid_value'
      doc: 'Failed required field validation'
    2:
      id: 'slow_connection'
      doc: 'Slow connection'
    3:
      id: 'other'
      doc: 'Unexpected request, see Reason field for details'
  subscription_req_type:
    0:
      id: 'snapshot'
      doc: 'Snapshot'
    1:
      id: 'snapshot_and_updates'
      doc: 'Snapshot and updates'
    2:
      id: 'unsubscribe'
      doc: 'Disable previous subscription'
  md_req_id_status:
    0:
      id: 'full_ack'
      doc: 'Requested subscription scope is fully acknowledged'
    1:
      id: 'partial_ack'
      doc: 'Requested subscription scope is partially acknowledged'
  md_req_rej_reason:
    0:
      id: 'unknown_security'
      doc: 'Unknown Security'
    1:
      id: 'unknown_message'
      doc: 'Unknown or Invalid Message'
    2:
      id: 'unsupported_scope'
      doc: 'Unsupported Scope'
    3:
      id: 'other'
      doc: 'Other'

