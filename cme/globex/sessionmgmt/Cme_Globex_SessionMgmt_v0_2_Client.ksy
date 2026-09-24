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
  id: cme_globex_sessionmgmt_sbe_v0_2_client
  title: Cme Globex SessionMgmt Sbe v0.2
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Session Management Sbe v0.2'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+MDP+3.0+Market+Data

seq:
  - id: client_technical_header
    type: client_technical_header_struct
    doc: 'Cme Technical Header sent by the subscriber to Cme'
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'Cme Session Message sent by the subscriber to Cme'

types:
  client_technical_header_struct:
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
  client_message_struct:
    seq:
      - id: message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: client_payload
        size: message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::negotiate': negotiate
            'template_id::terminate': terminate
            'template_id::market_data_request': market_data_request
            'template_id::security_list_request': security_list_request
            'template_id::security_status_request': security_status_request
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
  negotiate:
    seq:
      - id: hmac_signature
        type: str
        size: 32
        encoding: ASCII
        doc: 'Contains the HMAC signature'
      - id: access_key_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contains the AccessKeyID assigned to this session on this port'
      - id: uuid
        type: u8
        doc: 'Session Identifier defined as type long uInt64, recommended to use timestamp as number of microseconds since Unix epoch'
      - id: request_timestamp
        type: nanosecond_timestamp
        doc: 'Time of request, recommended to use timestamp as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: session
        type: str
        size: 5
        encoding: ASCII
        doc: 'Session ID'
      - id: firm
        type: str
        size: 5
        encoding: ASCII
        doc: 'Firm ID'
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
  market_data_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: market_data_request_security_groups
        type: market_data_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: market_data_request_related_symbol_groups
        type: market_data_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  market_data_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: market_data_request_security_group
        type: market_data_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  market_data_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  market_data_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: market_data_request_related_symbol_group
        type: market_data_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  market_data_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  security_list_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: security_list_request_security_groups
        type: security_list_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: security_list_request_related_symbol_groups
        type: security_list_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  security_list_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_list_request_security_group
        type: security_list_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  security_list_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  security_list_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_list_request_related_symbol_group
        type: security_list_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  security_list_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
  security_status_request:
    seq:
      - id: md_req_id
        type: u4
        doc: 'Unique identifier for Market Data Request. Must be unique per session so it can be referenced in Request Ack or Request Reject responses from the exchange'
      - id: subscription_req_type
        type: u1
        enum: subscription_req_type
        doc: 'Subscription Request Type indicates to the type of response expected'
      - id: security_status_request_security_groups
        type: security_status_request_security_groups
        doc: 'NoSecurityGroups Block'
      - id: security_status_request_related_symbol_groups
        type: security_status_request_related_symbol_groups
        doc: 'NoRelatedSym Block'
  security_status_request_security_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_status_request_security_group
        type: security_status_request_security_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of SecurityGroups specified in subscription request. Should be equal 0, when subscription is requested for all groups on the segment or individual Security IDs are listed in the criteria for subscription'
  security_status_request_security_group:
    seq:
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
  security_status_request_related_symbol_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_status_request_related_symbol_group
        type: security_status_request_related_symbol_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of instruments requested. When NoSecurityGroups > 0 specified in the request, the NoRelatedSym should be equal 0'
  security_status_request_related_symbol_group:
    seq:
      - id: security_id
        type: s4
        doc: 'Security ID'
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

