# ---------------------------------------------------------------------
# Kaitai struct definition for: Moex Spectra OrderEntry Twime v9.12.0
#
# Protocol:
#   Organization: Moscow Exchange
#   Protocol: TWIME Spectra Order Entry
#   Encoding: TWIME
#   Version: 9.12.0
#   Date: 10/19/2026
#   Specification: MOEX Spectra TWIME Order Entry (9.12.0).pdf
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
  id: moex_spectra_orderentry_twime_v9_12_0_client
  title: Moex Spectra OrderEntry Twime v9.12.0
  license: MIT-0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market TWIME Spectra Order Entry Twime v9.12.0'
doc-ref: https://ftp.moex.com/pub/TWIME/Spectra/

seq:
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'One Sbe message sent by the firm: the unit the Tcp stream repeats'

types:
  client_message_struct:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Message body length, message id, message scheme id and message scheme version'
      - id: client_payload
        size: sbe_header.block_length + 8 - 8
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::establish_message': establish_message
            'template_id::terminate_message': terminate_message
            'template_id::retransmit_request_message': retransmit_request_message
            'template_id::sequence_message': sequence_message
            'template_id::new_order_single_message': new_order_single_message
            'template_id::new_order_iceberg_message': new_order_iceberg_message
            'template_id::new_order_iceberg_x_message': new_order_iceberg_x_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::order_iceberg_cancel_request_message': order_iceberg_cancel_request_message
            'template_id::order_replace_request_message': order_replace_request_message
            'template_id::order_iceberg_replace_request_message': order_iceberg_replace_request_message
            'template_id::order_mass_cancel_request_message': order_mass_cancel_request_message
            'template_id::order_mass_cancel_by_bf_limit_request_message': order_mass_cancel_by_bf_limit_request_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Message body length'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Message ID'
      - id: schema_id
        type: u2
        doc: 'Message scheme ID'
      - id: version
        type: u2
        doc: 'Message scheme version'
  establish_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: keepalive_interval
        type: u4
        doc: 'KeepaliveInterval'
      - id: credentials
        type: str
        size: 20
        encoding: ASCII
        doc: 'Credentials'
      - id: block_extension
        size: _parent.sbe_header.block_length - 32
        doc: 'Bytes the stated block holds beyond the 32 this version reads'
  terminate_message:
    seq:
      - id: termination_code
        type: u1
        enum: termination_code
        doc: 'TerminationCode'
      - id: block_extension
        size: _parent.sbe_header.block_length - 1
        doc: 'Bytes the stated block holds beyond the 1 this version reads'
  retransmit_request_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: from_seq_no
        type: u8_nullable
        doc: 'FromSeqNo. Nullable, No Value = 18446744073709551615'
      - id: count
        type: u4_nullable
        doc: 'Count. Nullable, No Value = 4294967295'
      - id: block_extension
        size: _parent.sbe_header.block_length - 20
        doc: 'Bytes the stated block holds beyond the 20 this version reads'
  sequence_message:
    seq:
      - id: next_seq_no
        type: u8_nullable
        doc: 'NextSeqNo. Nullable, No Value = 18446744073709551615'
      - id: block_extension
        size: _parent.sbe_header.block_length - 8
        doc: 'Bytes the stated block holds beyond the 8 this version reads'
  new_order_single_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: expire_date
        type: nanosecond_timestamp_nullable
        doc: 'ExpireDate. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'TimeInForce'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 47
        doc: 'Bytes the stated block holds beyond the 47 this version reads'
  client_flags:
    meta:
      bit-endian: le
    seq:
      - id: dont_check_limits_client_flags
        type: b1
        doc: 'DontCheckLimits'
      - id: ncc_request_client_flags
        type: b1
        doc: 'NCCRequest'
      - id: reserved_3_to_8
        type: b6
        doc: '6 reserved bits'
  new_order_iceberg_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: expire_date
        type: nanosecond_timestamp_nullable
        doc: 'ExpireDate. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: display_variance_qty
        type: u4_nullable
        doc: 'DisplayVarianceQty. Nullable, No Value = 4294967295'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 54
        doc: 'Bytes the stated block holds beyond the 54 this version reads'
  new_order_iceberg_x_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: expire_date
        type: nanosecond_timestamp_nullable
        doc: 'ExpireDate. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: display_variance_qty
        type: u4_nullable
        doc: 'DisplayVarianceQty. Nullable, No Value = 4294967295'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'TimeInForce'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 55
        doc: 'Bytes the stated block holds beyond the 55 this version reads'
  order_cancel_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 28
        doc: 'Bytes the stated block holds beyond the 28 this version reads'
  order_iceberg_cancel_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 28
        doc: 'Bytes the stated block holds beyond the 28 this version reads'
  order_replace_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: mode
        type: u1
        enum: mode
        doc: 'Mode'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 46
        doc: 'Bytes the stated block holds beyond the 46 this version reads'
  order_iceberg_replace_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: client_flags
        type: client_flags
        doc: 'ClientFlagsSet bit set'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 41
        doc: 'Bytes the stated block holds beyond the 41 this version reads'
  order_mass_cancel_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: security_type
        type: security_type
        doc: 'SecurityTypeSet bit set'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: security_group
        type: str
        size: 25
        encoding: ASCII
        doc: 'SecurityGroup'
      - id: block_extension
        size: _parent.sbe_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
  security_type:
    meta:
      bit-endian: le
    seq:
      - id: future
        type: b1
        doc: 'Future'
      - id: option
        type: b1
        doc: 'Option'
      - id: multileg_security_type
        type: b1
        doc: 'Multileg'
      - id: reserved_4_to_8
        type: b5
        doc: '5 reserved bits'
  order_mass_cancel_by_bf_limit_request_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: account
        type: str
        size: 7
        encoding: ASCII
        doc: 'Account'
      - id: block_extension
        size: _parent.sbe_header.block_length - 15
        doc: 'Bytes the stated block holds beyond the 15 this version reads'
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 2147483647
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == 9223372036854775807

enums:
  template_id:
    5000:
      id: 'establish_message'
      doc: 'EstablishMessage'
    5001:
      id: 'establishment_ack_message'
      doc: 'EstablishmentAckMessage'
    5002:
      id: 'establishment_reject_message'
      doc: 'EstablishmentRejectMessage'
    5003:
      id: 'terminate_message'
      doc: 'TerminateMessage'
    5004:
      id: 'retransmit_request_message'
      doc: 'RetransmitRequestMessage'
    5005:
      id: 'retransmission_message'
      doc: 'RetransmissionMessage'
    5006:
      id: 'sequence_message'
      doc: 'SequenceMessage'
    5007:
      id: 'flood_reject_message'
      doc: 'FloodRejectMessage'
    5008:
      id: 'session_reject_message'
      doc: 'SessionRejectMessage'
    5009:
      id: 'business_message_reject_message'
      doc: 'BusinessMessageRejectMessage'
    6000:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    6008:
      id: 'new_order_iceberg_message'
      doc: 'NewOrderIcebergMessage'
    6011:
      id: 'new_order_iceberg_x_message'
      doc: 'NewOrderIcebergXMessage'
    6006:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    6009:
      id: 'order_iceberg_cancel_request_message'
      doc: 'OrderIcebergCancelRequestMessage'
    6007:
      id: 'order_replace_request_message'
      doc: 'OrderReplaceRequestMessage'
    6010:
      id: 'order_iceberg_replace_request_message'
      doc: 'OrderIcebergReplaceRequestMessage'
    6004:
      id: 'order_mass_cancel_request_message'
      doc: 'OrderMassCancelRequestMessage'
    6005:
      id: 'order_mass_cancel_by_bf_limit_request_message'
      doc: 'OrderMassCancelByBFLimitRequestMessage'
    7015:
      id: 'new_order_single_response_message'
      doc: 'NewOrderSingleResponseMessage'
    7016:
      id: 'new_order_iceberg_response_message'
      doc: 'NewOrderIcebergResponseMessage'
    7017:
      id: 'order_cancel_response_message'
      doc: 'OrderCancelResponseMessage'
    7018:
      id: 'order_replace_response_message'
      doc: 'OrderReplaceResponseMessage'
    7007:
      id: 'order_mass_cancel_response_message'
      doc: 'OrderMassCancelResponseMessage'
    7019:
      id: 'execution_single_report_message'
      doc: 'ExecutionSingleReportMessage'
    7020:
      id: 'execution_multileg_report_message'
      doc: 'ExecutionMultilegReportMessage'
    7010:
      id: 'empty_book_message'
      doc: 'EmptyBookMessage'
    7014:
      id: 'system_event_message'
      doc: 'SystemEventMessage'
  termination_code:
    0:
      id: 'finished'
      doc: 'Finished'
    1:
      id: 'unspecified_error'
      doc: 'UnspecifiedError'
    2:
      id: 're_request_out_of_bounds'
      doc: 'ReRequestOutOfBounds'
    3:
      id: 're_request_in_progress'
      doc: 'ReRequestInProgress'
    4:
      id: 'too_fast_client'
      doc: 'TooFastClient'
    5:
      id: 'too_slow_client'
      doc: 'TooSlowClient'
    6:
      id: 'missed_heartbeat'
      doc: 'MissedHeartbeat'
    7:
      id: 'invalid_message'
      doc: 'InvalidMessage'
    8:
      id: 'tcp_failure'
      doc: 'TCPFailure'
    9:
      id: 'invalid_sequence_number'
      doc: 'InvalidSequenceNumber'
    10:
      id: 'server_shutdown'
      doc: 'ServerShutdown'
    11:
      id: 'sequence_reset'
      doc: 'SequenceReset'
  compliance_id:
    0x20:
      id: 'not_available'
      doc: 'NotAvailable'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x53:
      id: 'stop_loss'
      doc: 'StopLoss'
    0x52:
      id: 'algorithm'
      doc: 'Algorithm'
    0x41:
      id: 'autofollow'
      doc: 'Autofollow'
    0x44:
      id: 'margin_call'
      doc: 'MarginCall'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    3:
      id: 'ioc'
      doc: 'IOC'
    4:
      id: 'fok'
      doc: 'FOK'
    6:
      id: 'gtd'
      doc: 'GTD'
    122:
      id: 'boc'
      doc: 'BOC'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    89:
      id: 'all_orders'
      doc: 'AllOrders'
  mode:
    0:
      id: 'dont_change_order_qty'
      doc: 'DontChangeOrderQty'
    1:
      id: 'change_order_qty'
      doc: 'ChangeOrderQty'
    2:
      id: 'check_order_qty_and_cancel_order'
      doc: 'CheckOrderQtyAndCancelOrder'
    3:
      id: 'fix_style_replace'
      doc: 'FixStyleReplace'
  establishment_reject_code:
    0:
      id: 'unnegotiated'
      doc: 'Unnegotiated'
    1:
      id: 'already_established'
      doc: 'AlreadyEstablished'
    2:
      id: 'session_blocked'
      doc: 'SessionBlocked'
    3:
      id: 'keepalive_interval'
      doc: 'KeepaliveInterval'
    4:
      id: 'credentials'
      doc: 'Credentials'
    5:
      id: 'unspecified'
      doc: 'Unspecified'
    6:
      id: 'too_fast_reconnect'
      doc: 'TooFastReconnect'
  session_reject_reason:
    5:
      id: 'value_is_incorrect'
      doc: 'ValueIsIncorrect'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'system_is_unavailable'
      doc: 'SystemIsUnavailable'
    101:
      id: 'cl_ord_id_is_not_unique'
      doc: 'ClOrdIdIsNotUnique'
  trad_ses_event:
    101:
      id: 'session_data_ready'
      doc: 'SessionDataReady'
    105:
      id: 'clearing_started'
      doc: 'ClearingStarted'
    106:
      id: 'extension_of_limits_finished'
      doc: 'ExtensionOfLimitsFinished'
    108:
      id: 'broker_recalc_finished'
      doc: 'BrokerRecalcFinished'
    122:
      id: 'auction_finished'
      doc: 'AuctionFinished'
    123:
      id: 'auction_collect_order_started'
      doc: 'AuctionCollectOrderStarted'
    124:
      id: 'auction_collect_order_finished'
      doc: 'AuctionCollectOrderFinished'

