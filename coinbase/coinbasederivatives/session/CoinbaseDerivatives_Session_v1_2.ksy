# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase CoinbaseDerivatives Session Tcp v1.2
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Session Layer
#   Encoding: Tcp
#   Version: 1.2
#   Date: 7/27/2020
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: coinbasederivatives_session_v1_2
  title: Coinbase CoinbaseDerivatives Session Tcp v1.2
  license: GPL-3.0
  endian: le

doc: 'Coinbase Coinbase Derivatives Session Layer Tcp v1.2'
doc-ref: https://docs.cdp.coinbase.com/derivatives/introduction/downloads

seq:
  - id: sbe_message
    type: sbe_message_struct
    repeat: eos
    doc: 'Coinbase Sbe Message'

types:
  sbe_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Coinbase Orders Api Sbe message header — FIX session fields plus standard SBE header'
      - id: payload
        size: message_header.message_length - 37
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::logon_message': logon_message
            'template_id::logon_conf_message': logon_conf_message
            'template_id::logout_message': logout_message
            'template_id::logged_out_message': logged_out_message
            'template_id::heartbeat_message': heartbeat_message
            'template_id::test_request_message': test_request_message
            'template_id::resend_request_message': resend_request_message
            'template_id::gap_fill_message': gap_fill_message
            'template_id::reject_message': reject_message
      - id: padding
        type: u4
        doc: 'padding'
  message_header:
    seq:
      - id: protocol_id
        type: u1
        doc: 'Coinbase protocol identifier'
      - id: flags
        type: flags
        doc: 'Uint8 bit set carrying the isResend indicator'
      - id: flags_2
        type: flags
        doc: 'Uint8 bit set carrying the isResend indicator'
      - id: message_length
        type: u2
        doc: 'Total message length in bytes including this header'
      - id: sequence_number
        type: u4
        doc: 'Outbound sequence number per session'
      - id: last_processed_seq_no
        type: u4
        doc: 'Highest sequence number the sender has processed from the counterparty'
      - id: reserved
        type: u4
        doc: 'Reserved for future use'
      - id: send_time_epoch_nanos
        type: s8
        doc: 'sendTimeEpochNanos. Nanoseconds since Unix epoch'
      - id: block_length
        type: u2
        doc: 'Length of the root of the message contained before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema publishing the message'
      - id: version
        type: u2
        doc: 'Schema version'
  flags:
    seq:
      - id: is_resend
        type: b1
        doc: 'Possibly resent message indicator (Bit 0)'
      - id: reserved_bits
        type: b7
        doc: 'Bits reserved for future use'
  logon_message:
    seq:
      - id: username
        type: str
        size: 16
        encoding: ASCII
        doc: 'username'
      - id: password
        type: str
        size: 32
        encoding: ASCII
        doc: 'password'
      - id: reset_seq_num
        type: s1
        enum: reset_seq_num
        doc: 'resetSeqNum'
  logon_conf_message:
    seq:
      - id: heartbeat_interval_seconds
        type: s4
        doc: 'heartbeatIntervalSeconds'
  logout_message:
    seq:
      - id: reason_string_64
        type: str
        size: 64
        encoding: ASCII
        doc: 'reason'
  logged_out_message:
    seq:
      - id: reason_string_64
        type: str
        size: 64
        encoding: ASCII
        doc: 'reason'
  heartbeat_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  test_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  resend_request_message:
    seq:
      - id: from_sequence_number
        type: u4
        doc: 'fromSequenceNumber'
      - id: to_sequence_number
        type: u4
        doc: 'toSequenceNumber'
  gap_fill_message:
    seq:
      - id: new_sequence_number
        type: u4
        doc: 'newSequenceNumber'
      - id: padding
        type: u4
        doc: 'padding'
  reject_message:
    seq:
      - id: ref_sequence_number
        type: u4
        doc: 'refSequenceNumber'
      - id: reason_reject_reason
        type: s4
        enum: reason_reject_reason
        doc: 'reason'
      - id: details
        type: str
        size: 64
        encoding: ASCII
        doc: 'details'

enums:
  template_id:
    100:
      id: 'logon_message'
      doc: 'LogonMessage'
    200:
      id: 'logon_conf_message'
      doc: 'LogonConfMessage'
    101:
      id: 'logout_message'
      doc: 'LogoutMessage'
    201:
      id: 'logged_out_message'
      doc: 'LoggedOutMessage'
    10:
      id: 'heartbeat_message'
      doc: 'HeartbeatMessage'
    11:
      id: 'test_request_message'
      doc: 'TestRequestMessage'
    102:
      id: 'resend_request_message'
      doc: 'ResendRequestMessage'
    202:
      id: 'gap_fill_message'
      doc: 'GapFillMessage'
    210:
      id: 'reject_message'
      doc: 'RejectMessage'
  reset_seq_num:
    0:
      id: 'false'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reason_reject_reason:
    1:
      id: 'invalid_schema_id'
      doc: 'RejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'invalid_template_id'
      doc: 'RejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'invalid_block_length'
      doc: 'RejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_field_value'
      doc: 'RejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

