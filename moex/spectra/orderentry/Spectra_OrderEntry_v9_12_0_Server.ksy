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
  id: moex_spectra_orderentry_twime_v9_12_0_server
  title: Moex Spectra OrderEntry Twime v9.12.0
  license: MIT-0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market TWIME Spectra Order Entry Twime v9.12.0'
doc-ref: https://ftp.moex.com/pub/TWIME/Spectra/

seq:
  - id: server_message
    type: server_message_struct
    repeat: eos
    doc: 'One Sbe message sent by the gateway: the unit the Tcp stream repeats'

types:
  server_message_struct:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Message body length, message id, message scheme id and message scheme version'
      - id: server_payload
        size: sbe_header.block_length + 8 - 8
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::establishment_ack_message': establishment_ack_message
            'template_id::establishment_reject_message': establishment_reject_message
            'template_id::terminate_message': terminate_message
            'template_id::retransmission_message': retransmission_message
            'template_id::sequence_message': sequence_message
            'template_id::flood_reject_message': flood_reject_message
            'template_id::session_reject_message': session_reject_message
            'template_id::business_message_reject_message': business_message_reject_message
            'template_id::new_order_single_response_message': new_order_single_response_message
            'template_id::new_order_iceberg_response_message': new_order_iceberg_response_message
            'template_id::order_cancel_response_message': order_cancel_response_message
            'template_id::order_replace_response_message': order_replace_response_message
            'template_id::order_mass_cancel_response_message': order_mass_cancel_response_message
            'template_id::execution_single_report_message': execution_single_report_message
            'template_id::execution_multileg_report_message': execution_multileg_report_message
            'template_id::empty_book_message': empty_book_message
            'template_id::system_event_message': system_event_message
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
  establishment_ack_message:
    seq:
      - id: request_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'RequestTimestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: keepalive_interval
        type: u4
        doc: 'KeepaliveInterval'
      - id: next_seq_no
        type: u8_nullable
        doc: 'NextSeqNo. Nullable, No Value = 18446744073709551615'
      - id: block_extension
        size: _parent.sbe_header.block_length - 20
        doc: 'Bytes the stated block holds beyond the 20 this version reads'
  establishment_reject_message:
    seq:
      - id: request_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'RequestTimestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: establishment_reject_code
        type: u1
        enum: establishment_reject_code
        doc: 'EstablishmentRejectCode'
      - id: block_extension
        size: _parent.sbe_header.block_length - 9
        doc: 'Bytes the stated block holds beyond the 9 this version reads'
  terminate_message:
    seq:
      - id: termination_code
        type: u1
        enum: termination_code
        doc: 'TerminationCode'
      - id: block_extension
        size: _parent.sbe_header.block_length - 1
        doc: 'Bytes the stated block holds beyond the 1 this version reads'
  retransmission_message:
    seq:
      - id: next_seq_no
        type: u8_nullable
        doc: 'NextSeqNo. Nullable, No Value = 18446744073709551615'
      - id: request_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'RequestTimestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
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
  flood_reject_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: queue_size
        type: u4_nullable
        doc: 'QueueSize. Nullable, No Value = 4294967295'
      - id: penalty_remain
        type: u4_nullable
        doc: 'PenaltyRemain. Nullable, No Value = 4294967295'
      - id: block_extension
        size: _parent.sbe_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  session_reject_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: ref_tag_id
        type: u4_nullable
        doc: 'RefTagID. Nullable, No Value = 4294967295'
      - id: session_reject_reason
        type: u1
        enum: session_reject_reason
        doc: 'SessionRejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 13
        doc: 'Bytes the stated block holds beyond the 13 this version reads'
  business_message_reject_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ord_rej_reason
        type: s4_nullable
        doc: 'OrdRejReason. Nullable, No Value = 2147483647'
      - id: block_extension
        size: _parent.sbe_header.block_length - 20
        doc: 'Bytes the stated block holds beyond the 20 this version reads'
  new_order_single_response_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: expire_date
        type: nanosecond_timestamp_nullable
        doc: 'ExpireDate. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 74
        doc: 'Bytes the stated block holds beyond the 74 this version reads'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: day
        type: b1
        doc: 'Day'
      - id: ioc
        type: b1
        doc: 'IOC'
      - id: otc
        type: b1
        doc: 'OTC'
      - id: pos_transfer
        type: b1
        doc: 'PosTransfer'
      - id: collateral
        type: b1
        doc: 'Collateral'
      - id: unused_bits_6_to_9
        type: b4
        doc: '4 unused bits'
      - id: dont_check_limits
        type: b1
        doc: 'DontCheckLimits'
      - id: unused_bits_11_to_13
        type: b3
        doc: '3 unused bits'
      - id: due_to_cross_cancel
        type: b1
        doc: 'DueToCrossCancel'
      - id: unused_bits_15_to_19
        type: b5
        doc: '5 unused bits'
      - id: fok
        type: b1
        doc: 'FOK'
      - id: replace
        type: b1
        doc: 'Replace'
      - id: cancel
        type: b1
        doc: 'Cancel'
      - id: mass_cancel
        type: b1
        doc: 'MassCancel'
      - id: unused_bits_24_to_25
        type: b2
        doc: '2 unused bits'
      - id: clearing
        type: b1
        doc: 'Clearing'
      - id: negotiated
        type: b1
        doc: 'Negotiated'
      - id: multileg
        type: b1
        doc: 'Multileg'
      - id: unused_bit_29
        type: b1
        doc: '1 unused bit'
      - id: cross_trade
        type: b1
        doc: 'CrossTrade'
      - id: unused_bit_31
        type: b1
        doc: '1 unused bit'
      - id: negotiated_match_by_ref
        type: b1
        doc: 'NegotiatedMatchByRef'
      - id: cod
        type: b1
        doc: 'COD'
      - id: unused_bits_34_to_37
        type: b4
        doc: '4 unused bits'
      - id: uks
        type: b1
        doc: 'UKS'
      - id: ncc_request
        type: b1
        doc: 'NCCRequest'
      - id: ncc
        type: b1
        doc: 'NCC'
      - id: liq_netting_rf
        type: b1
        doc: 'LiqNettingRF'
      - id: active_side
        type: b1
        doc: 'ActiveSide'
      - id: passive_side
        type: b1
        doc: 'PassiveSide'
      - id: unused_bits_44_to_45
        type: b2
        doc: '2 unused bits'
      - id: synthetic
        type: b1
        doc: 'Synthetic'
      - id: unused_bit_47
        type: b1
        doc: '1 unused bit'
      - id: iceberg
        type: b1
        doc: 'Iceberg'
      - id: unused_bits_49_to_53
        type: b5
        doc: '5 unused bits'
      - id: disclosed_iceberg
        type: b1
        doc: 'DisclosedIceberg'
      - id: unused_bits_55_to_60
        type: b6
        doc: '6 unused bits'
      - id: boc
        type: b1
        doc: 'BOC'
      - id: unused_bit_62
        type: b1
        doc: '1 unused bit'
      - id: during_discrete_auction
        type: b1
        doc: 'DuringDiscreteAuction'
      - id: reserved_64
        type: b1
        doc: '1 reserved bit'
  flags_2:
    meta:
      bit-endian: le
    seq:
      - id: zero
        type: b1
        doc: 'Zero'
      - id: reserved_2_to_64
        type: b63
        doc: '63 reserved bits'
  new_order_iceberg_response_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: expire_date
        type: nanosecond_timestamp_nullable
        doc: 'ExpireDate. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: display_order_id
        type: s8_nullable
        doc: 'DisplayOrderID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'DisplayQty. Nullable, No Value = 4294967295'
      - id: display_variance_qty
        type: u4_nullable
        doc: 'DisplayVarianceQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 90
        doc: 'Bytes the stated block holds beyond the 90 this version reads'
  order_cancel_response_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: block_extension
        size: _parent.sbe_header.block_length - 52
        doc: 'Bytes the stated block holds beyond the 52 this version reads'
  order_replace_response_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: prev_order_id
        type: s8_nullable
        doc: 'PrevOrderID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: compliance_id
        type: u1
        enum: compliance_id
        doc: 'ComplianceID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 69
        doc: 'Bytes the stated block holds beyond the 69 this version reads'
  order_mass_cancel_response_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: total_affected_orders
        type: s4_nullable
        doc: 'TotalAffectedOrders. Nullable, No Value = 2147483647'
      - id: block_extension
        size: _parent.sbe_header.block_length - 20
        doc: 'Bytes the stated block holds beyond the 20 this version reads'
  execution_single_report_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: trd_match_id
        type: s8_nullable
        doc: 'TrdMatchID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: last_px
        type: decimal_s8_5
        doc: 'LastPx. Implied decimal with scale 1e-5'
      - id: last_qty
        type: u4_nullable
        doc: 'LastQty. Nullable, No Value = 4294967295'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: block_extension
        size: _parent.sbe_header.block_length - 77
        doc: 'Bytes the stated block holds beyond the 77 this version reads'
  execution_multileg_report_message:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'ClOrdID. Nullable, No Value = 18446744073709551615'
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: s8_nullable
        doc: 'OrderID. Nullable, No Value = 9223372036854775807'
      - id: trd_match_id
        type: s8_nullable
        doc: 'TrdMatchID. Nullable, No Value = 9223372036854775807'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: flags_2
        type: flags_2
        doc: 'Flags2Set bit set'
      - id: last_px
        type: decimal_s8_5
        doc: 'LastPx. Implied decimal with scale 1e-5'
      - id: leg_price
        type: decimal_s8_5
        doc: 'LegPrice. Implied decimal with scale 1e-5'
      - id: last_qty
        type: u4_nullable
        doc: 'LastQty. Nullable, No Value = 4294967295'
      - id: order_qty
        type: u4_nullable
        doc: 'OrderQty. Nullable, No Value = 4294967295'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: cl_ord_link_id
        type: s4_nullable
        doc: 'ClOrdLinkID. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4_nullable
        doc: 'SecurityID. Nullable, No Value = 2147483647'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: block_extension
        size: _parent.sbe_header.block_length - 85
        doc: 'Bytes the stated block holds beyond the 85 this version reads'
  empty_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: block_extension
        size: _parent.sbe_header.block_length - 12
        doc: 'Bytes the stated block holds beyond the 12 this version reads'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: event_id
        type: s8_nullable
        doc: 'EventId. Nullable, No Value = 9223372036854775807'
      - id: trading_session_id
        type: s4_nullable
        doc: 'TradingSessionID. Nullable, No Value = 2147483647'
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
        doc: 'TradSesEvent'
      - id: block_extension
        size: _parent.sbe_header.block_length - 21
        doc: 'Bytes the stated block holds beyond the 21 this version reads'
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
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0

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

