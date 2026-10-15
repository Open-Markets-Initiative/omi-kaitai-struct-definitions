# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase Deribit OrdersApi Sbe v1.4
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Orders Api
#   Encoding: Simple Binary Encoding
#   Version: 1.4
#   Date: 8/4/2026
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
  id: coinbase_deribit_ordersapi_sbe_v1_4
  title: Coinbase Deribit OrdersApi Sbe v1.4
  license: GPL-3.0
  endian: le

doc: 'Coinbase Deribit Orders Api Sbe v1.4'
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
        doc: 'Coinbase Deribit Orders Api Sbe message header — FIX session fields plus message type and version'
      - id: payload
        size: message_header.message_length - 32
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
            'template_id::new_order_request_message': new_order_request_message
            'template_id::amend_order_request_message': amend_order_request_message
            'template_id::cancel_order_request_message': cancel_order_request_message
            'template_id::cancel_order_by_id_request_message': cancel_order_by_id_request_message
            'template_id::mass_quote_request_message': mass_quote_request_message
            'template_id::mass_cancel_request_message': mass_cancel_request_message
            'template_id::mass_quote_cancel_request_message': mass_quote_cancel_request_message
            'template_id::get_mass_quote_mmp_status_request_message': get_mass_quote_mmp_status_request_message
            'template_id::get_orders_mmp_status_request_message': get_orders_mmp_status_request_message
            'template_id::new_order_response_message': new_order_response_message
            'template_id::new_order_reject_message': new_order_reject_message
            'template_id::amend_order_response_message': amend_order_response_message
            'template_id::amend_order_reject_message': amend_order_reject_message
            'template_id::cancel_order_response_message': cancel_order_response_message
            'template_id::cancel_order_reject_message': cancel_order_reject_message
            'template_id::mass_quote_response_message': mass_quote_response_message
            'template_id::mass_quote_reject_message': mass_quote_reject_message
            'template_id::mass_cancel_response_message': mass_cancel_response_message
            'template_id::mass_cancel_reject_message': mass_cancel_reject_message
            'template_id::get_mass_quote_mmp_status_response_message': get_mass_quote_mmp_status_response_message
            'template_id::get_mass_quote_mmp_status_reject_message': get_mass_quote_mmp_status_reject_message
            'template_id::get_orders_mmp_status_response_message': get_orders_mmp_status_response_message
            'template_id::get_orders_mmp_status_reject_message': get_orders_mmp_status_reject_message
            'template_id::order_filled_message': order_filled_message
            'template_id::orders_canceled_message': orders_canceled_message
            'template_id::order_placed_message': order_placed_message
            'template_id::mass_quote_orders_placed_message': mass_quote_orders_placed_message
            'template_id::mass_quote_mmp_triggered_message': mass_quote_mmp_triggered_message
            'template_id::orders_mmp_triggered_message': orders_mmp_triggered_message
            'template_id::mass_quote_mmp_unfrozen_message': mass_quote_mmp_unfrozen_message
            'template_id::orders_mmp_unfrozen_message': orders_mmp_unfrozen_message
      - id: padding
        size: 0
        doc: 'Tcp sbe alignment padding'
  message_header:
    seq:
      - id: protocol_id
        type: u1
        doc: 'Coinbase Deribit protocol identifier'
      - id: session_flags
        type: session_flags
        doc: 'Uint8 bit set carrying the isResend indicator'
      - id: message_length
        type: u2
        doc: 'Total message length in bytes including this header'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Identifier of the message type'
      - id: schema_version
        type: u2
        doc: 'schemaVersion'
      - id: sequence_number
        type: s8
        doc: 'Outbound sequence number per session'
      - id: last_processed_seq_no
        type: s8
        doc: 'Highest sequence number the sender has processed from the counterparty'
      - id: send_time_ns
        type: nanosecond_timestamp
        doc: 'UTC timestamp of when the message was sent from the gateway, nanoseconds since Unix epoch (January 1st, 1970, 00:00:00 GMT). Nanoseconds since Unix epoch'
  session_flags:
    meta:
      bit-endian: le
    seq:
      - id: is_resend
        type: b1
        doc: 'Possibly resent message indicator'
      - id: reserved_bits
        type: b7
        doc: 'Bits reserved for future use'
  logon_message:
    seq:
      - id: client_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'clientId'
      - id: secret
        type: str
        size: 48
        encoding: ASCII
        doc: 'secret'
      - id: reset_seq_num
        type: s1
        enum: reset_seq_num
        doc: 'resetSeqNum'
      - id: schema_version
        type: u2
        doc: 'schemaVersion'
  logon_conf_message:
    seq:
      - id: heartbeat_interval_seconds
        type: s4
        doc: 'heartbeatIntervalSeconds'
      - id: schema_version
        type: u2
        doc: 'schemaVersion'
  logout_message:
    seq:
      - id: reason
        type: reason
        doc: 'reason data struct'
  reason:
    seq:
      - id: len_reason_data
        type: u1
      - id: reason_data
        type: str
        size: len_reason_data
        encoding: ASCII
        if: len_reason_data > 0
  logged_out_message:
    seq:
      - id: reason
        type: reason
        doc: 'reason data struct'
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
        type: s8
        doc: 'fromSequenceNumber'
      - id: to_sequence_number
        type: s8
        doc: 'toSequenceNumber'
  gap_fill_message:
    seq:
      - id: new_sequence_number
        type: s8
        doc: 'newSequenceNumber'
  reject_message:
    seq:
      - id: ref_sequence_number
        type: s8
        doc: 'refSequenceNumber'
      - id: reason_reject_reason
        type: s1
        enum: reason_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  details:
    seq:
      - id: len_details_data
        type: u1
      - id: details_data
        type: str
        size: len_details_data
        encoding: ASCII
        if: len_details_data > 0
  new_order_request_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: show_qty
        type: show_qty
        doc: 'NewOrderRequestMessage'
      - id: self_match_prevention_id
        type: s8_nullable
        doc: 'selfMatchPreventionId. Nullable, No Value = -9223372036854775808'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: time_in_force
        type: s1
        doc: 'timeInForce'
      - id: flags_order_flags
        type: flags_order_flags
        doc: 'OrderFlags bit set'
      - id: self_trading_mode
        type: s1
        enum: self_trading_mode
        doc: 'selfTradingMode'
  quantity:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  show_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  flags_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: cancel_on_disconnect
        type: b1
        doc: 'cancelOnDisconnect'
      - id: post_only
        type: b1
        doc: 'postOnly'
      - id: post_only_reject
        type: b1
        doc: 'postOnlyReject'
      - id: market_limit
        type: b1
        doc: 'marketLimit'
      - id: mmp
        type: b1
        doc: 'mmp'
      - id: reset_mmp
        type: b1
        doc: 'resetMmp'
      - id: reserved_10
        type: b10
        doc: '10 reserved bits'
  amend_order_request_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: show_qty
        type: show_qty
        doc: 'NewOrderRequestMessage'
      - id: flags_replace_order_flags
        type: flags_replace_order_flags
        doc: 'ReplaceOrderFlags bit set'
  flags_replace_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_replace_order_flags_0
        type: b1
        doc: 'Unused ReplaceOrderFlags 0'
      - id: post_only
        type: b1
        doc: 'postOnly'
      - id: post_only_reject
        type: b1
        doc: 'postOnlyReject'
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
  cancel_order_request_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
  cancel_order_by_id_request_message:
    seq:
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
  mass_quote_request_message:
    seq:
      - id: quote_id
        type: s8
        doc: 'quoteId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: self_match_prevention_id
        type: s8_nullable
        doc: 'selfMatchPreventionId. Nullable, No Value = -9223372036854775808'
      - id: flags_mass_quote_flags
        type: flags_mass_quote_flags
        doc: 'MassQuoteFlags bit set'
      - id: mass_quote_request_message_quotes_groups
        type: mass_quote_request_message_quotes_groups
        doc: 'quotes Block'
  flags_mass_quote_flags:
    meta:
      bit-endian: le
    seq:
      - id: reset_mmp
        type: b1
        doc: 'resetMmp'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  mass_quote_request_message_quotes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_request_message_quotes_group
        type: mass_quote_request_message_quotes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'quotes'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u2
        doc: 'numInGroup'
  mass_quote_request_message_quotes_group:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: bid_price_optional
        type: decimal_s8_9_nullable
        doc: 'bidPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: ask_price_optional
        type: decimal_s8_9_nullable
        doc: 'askPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: bid_qty
        type: bid_qty
        doc: 'quotes'
      - id: ask_qty
        type: ask_qty
        doc: 'quotes'
      - id: bid_flags
        type: bid_flags
        doc: 'OrderFlags bit set'
      - id: ask_flags
        type: ask_flags
        doc: 'OrderFlags bit set'
  bid_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  ask_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  bid_flags:
    meta:
      bit-endian: le
    seq:
      - id: cancel_on_disconnect
        type: b1
        doc: 'cancelOnDisconnect'
      - id: post_only
        type: b1
        doc: 'postOnly'
      - id: post_only_reject
        type: b1
        doc: 'postOnlyReject'
      - id: market_limit
        type: b1
        doc: 'marketLimit'
      - id: mmp
        type: b1
        doc: 'mmp'
      - id: reset_mmp
        type: b1
        doc: 'resetMmp'
      - id: reserved_10
        type: b10
        doc: '10 reserved bits'
  ask_flags:
    meta:
      bit-endian: le
    seq:
      - id: cancel_on_disconnect
        type: b1
        doc: 'cancelOnDisconnect'
      - id: post_only
        type: b1
        doc: 'postOnly'
      - id: post_only_reject
        type: b1
        doc: 'postOnlyReject'
      - id: market_limit
        type: b1
        doc: 'marketLimit'
      - id: mmp
        type: b1
        doc: 'mmp'
      - id: reset_mmp
        type: b1
        doc: 'resetMmp'
      - id: reserved_10
        type: b10
        doc: '10 reserved bits'
  mass_cancel_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: currency_pair_id
        type: s8
        doc: 'currencyPairId'
      - id: instrument_id_optional
        type: s8_nullable
        doc: 'instrumentId. Nullable, No Value = -9223372036854775808'
      - id: product_type
        type: s1
        enum: product_type
        doc: 'productType'
      - id: side
        type: s1
        enum: side
        doc: 'side'
  mass_quote_cancel_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
  get_mass_quote_mmp_status_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
  get_orders_mmp_status_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: currency_pair_id
        type: s8
        doc: 'currencyPairId'
  new_order_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: visible_qty
        type: visible_qty
        doc: 'NewOrderResponseMessage'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: status
        type: s1
        enum: status
        doc: 'status'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'cancelReason'
      - id: new_order_response_message_fills_groups
        type: new_order_response_message_fills_groups
        doc: 'fills Block'
      - id: new_order_response_message_legs_groups
        type: new_order_response_message_legs_groups
        doc: 'legs Block'
  total_filled:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  visible_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  new_order_response_message_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: new_order_response_message_fills_group
        type: new_order_response_message_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'fills'
  new_order_response_message_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  fill_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  new_order_response_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: new_order_response_message_legs_group
        type: new_order_response_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  new_order_response_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  new_order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: reason_order_reject_reason
        type: s1
        enum: reason_order_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  amend_order_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: visible_qty
        type: visible_qty
        doc: 'NewOrderResponseMessage'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: status
        type: s1
        enum: status
        doc: 'status'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'cancelReason'
      - id: amend_order_response_message_fills_groups
        type: amend_order_response_message_fills_groups
        doc: 'fills Block'
      - id: amend_order_response_message_legs_groups
        type: amend_order_response_message_legs_groups
        doc: 'legs Block'
  amend_order_response_message_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: amend_order_response_message_fills_group
        type: amend_order_response_message_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'fills'
  amend_order_response_message_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  amend_order_response_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: amend_order_response_message_legs_group
        type: amend_order_response_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  amend_order_response_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  amend_order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: reason_order_reject_reason
        type: s1
        enum: reason_order_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  cancel_order_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
  cancel_order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id_optional
        type: s8_nullable
        doc: 'orderId. Nullable, No Value = -9223372036854775808'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: reason_cancel_order_reject_reason
        type: s1
        enum: reason_cancel_order_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  mass_quote_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: quote_id
        type: s8
        doc: 'quoteId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: mass_quote_response_message_quotes_groups
        type: mass_quote_response_message_quotes_groups
        doc: 'quotes Block'
      - id: mass_quote_response_message_bid_fills_groups
        type: mass_quote_response_message_bid_fills_groups
        doc: 'bidFills Block'
      - id: mass_quote_response_message_ask_fills_groups
        type: mass_quote_response_message_ask_fills_groups
        doc: 'askFills Block'
      - id: mass_quote_response_message_legs_groups
        type: mass_quote_response_message_legs_groups
        doc: 'legs Block'
  mass_quote_response_message_quotes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_response_message_quotes_group
        type: mass_quote_response_message_quotes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'quotes'
  mass_quote_response_message_quotes_group:
    seq:
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: bid_order_id
        type: s8
        doc: 'bidOrderId'
      - id: ask_order_id
        type: s8
        doc: 'askOrderId'
      - id: bid_price
        type: decimal_s8_9
        doc: 'bidPrice. Implied decimal with scale 1e-9'
      - id: ask_price
        type: decimal_s8_9
        doc: 'askPrice. Implied decimal with scale 1e-9'
      - id: bid_qty
        type: bid_qty
        doc: 'quotes'
      - id: ask_qty
        type: ask_qty
        doc: 'quotes'
      - id: bid_filled_qty
        type: bid_filled_qty
        doc: 'quotes'
      - id: ask_filled_qty
        type: ask_filled_qty
        doc: 'quotes'
      - id: bid_status
        type: s1
        enum: bid_status
        doc: 'bidStatus'
      - id: ask_status
        type: s1
        enum: ask_status
        doc: 'askStatus'
      - id: bid_reject_reason
        type: s1
        enum: bid_reject_reason
        doc: 'bidRejectReason'
      - id: ask_reject_reason
        type: s1
        enum: ask_reject_reason
        doc: 'askRejectReason'
  bid_filled_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  ask_filled_qty:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  mass_quote_response_message_bid_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_response_message_bid_fills_group
        type: mass_quote_response_message_bid_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'bidFills'
  mass_quote_response_message_bid_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  mass_quote_response_message_ask_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_response_message_ask_fills_group
        type: mass_quote_response_message_ask_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'askFills'
  mass_quote_response_message_ask_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  mass_quote_response_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_response_message_legs_group
        type: mass_quote_response_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  mass_quote_response_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  mass_quote_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: quote_id
        type: s8
        doc: 'quoteId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: reason_mass_quote_reject_reason
        type: s1
        enum: reason_mass_quote_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  mass_cancel_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: total_order_count
        type: s4
        doc: 'totalOrderCount'
  mass_cancel_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: reason_mass_cancel_reject_reason
        type: s1
        enum: reason_mass_cancel_reject_reason
        doc: 'reason'
      - id: details
        type: details
        doc: 'details data struct'
  get_mass_quote_mmp_status_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: frozen_until_time
        type: s8_nullable
        doc: 'frozenUntilTime. Nullable, No Value = -9223372036854775808'
  get_mass_quote_mmp_status_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: reason_mmp_status_reject_reason
        type: s1
        enum: reason_mmp_status_reject_reason
        doc: 'reason'
  get_orders_mmp_status_response_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: currency_pair_id
        type: s8
        doc: 'currencyPairId'
      - id: frozen_until_time
        type: s8_nullable
        doc: 'frozenUntilTime. Nullable, No Value = -9223372036854775808'
  get_orders_mmp_status_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: reason_mmp_status_reject_reason
        type: s1
        enum: reason_mmp_status_reject_reason
        doc: 'reason'
  order_filled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: order_filled_message_fills_groups
        type: order_filled_message_fills_groups
        doc: 'fills Block'
      - id: order_filled_message_legs_groups
        type: order_filled_message_legs_groups
        doc: 'legs Block'
  order_filled_message_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_filled_message_fills_group
        type: order_filled_message_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'fills'
  order_filled_message_fills_group:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: flags_fill_flags
        type: flags_fill_flags
        doc: 'FillFlags bit set'
  flags_fill_flags:
    meta:
      bit-endian: le
    seq:
      - id: is_quote
        type: b1
        doc: 'isQuote'
      - id: is_fully_filled
        type: b1
        doc: 'isFullyFilled'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
  order_filled_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_filled_message_legs_group
        type: order_filled_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  order_filled_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  orders_canceled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: flags_multi_part_event_flags
        type: flags_multi_part_event_flags
        doc: 'MultiPartEventFlags bit set'
      - id: orders_canceled_message_orders_groups
        type: orders_canceled_message_orders_groups
        doc: 'orders Block'
  flags_multi_part_event_flags:
    meta:
      bit-endian: le
    seq:
      - id: is_last_message
        type: b1
        doc: 'isLastMessage'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  orders_canceled_message_orders_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: orders_canceled_message_orders_group
        type: orders_canceled_message_orders_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'orders'
  orders_canceled_message_orders_group:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'cancelReason'
      - id: flags_cancel_flags
        type: flags_cancel_flags
        doc: 'CancelFlags bit set'
  flags_cancel_flags:
    meta:
      bit-endian: le
    seq:
      - id: is_quote
        type: b1
        doc: 'isQuote'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  order_placed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: visible_qty
        type: visible_qty
        doc: 'NewOrderResponseMessage'
      - id: status
        type: s1
        enum: status
        doc: 'status'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'cancelReason'
      - id: padding_3
        size: 3
        doc: 'padding3'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_placed_message_fills_groups
        type: order_placed_message_fills_groups
        doc: 'fills Block'
      - id: order_placed_message_legs_groups
        type: order_placed_message_legs_groups
        doc: 'legs Block'
  order_placed_message_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_placed_message_fills_group
        type: order_placed_message_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'fills'
  order_placed_message_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  order_placed_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_placed_message_legs_group
        type: order_placed_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  order_placed_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  mass_quote_orders_placed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: mass_quote_orders_placed_message_orders_groups
        type: mass_quote_orders_placed_message_orders_groups
        doc: 'orders Block'
      - id: mass_quote_orders_placed_message_fills_groups
        type: mass_quote_orders_placed_message_fills_groups
        doc: 'fills Block'
      - id: mass_quote_orders_placed_message_legs_groups
        type: mass_quote_orders_placed_message_legs_groups
        doc: 'legs Block'
  mass_quote_orders_placed_message_orders_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_orders_placed_message_orders_group
        type: mass_quote_orders_placed_message_orders_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'orders'
  mass_quote_orders_placed_message_orders_group:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: instrument_id
        type: s8
        doc: 'instrumentId'
      - id: price
        type: decimal_s8_9
        doc: 'price. Implied decimal with scale 1e-9'
      - id: quantity
        type: quantity
        doc: 'NewOrderRequestMessage'
      - id: total_filled
        type: total_filled
        doc: 'NewOrderResponseMessage'
      - id: visible_qty
        type: visible_qty
        doc: 'NewOrderResponseMessage'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: status
        type: s1
        enum: status
        doc: 'status'
      - id: cancel_reason
        type: s1
        enum: cancel_reason
        doc: 'cancelReason'
  mass_quote_orders_placed_message_fills_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_orders_placed_message_fills_group
        type: mass_quote_orders_placed_message_fills_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'fills'
  mass_quote_orders_placed_message_fills_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: order_id_fill_id
        type: s8
        doc: 'orderId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
  mass_quote_orders_placed_message_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mass_quote_orders_placed_message_legs_group
        type: mass_quote_orders_placed_message_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'legs'
  mass_quote_orders_placed_message_legs_group:
    seq:
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: fill_id
        type: s8
        doc: 'instrumentId'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: fill_qty
        doc: 'fills'
      - id: leg_side
        type: s1
        enum: leg_side
        doc: 'legSide'
  mass_quote_mmp_triggered_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: frozen_until
        type: nanosecond_timestamp
        doc: 'frozenUntil. Nanoseconds since Unix epoch'
      - id: quantity_level
        size: 8
        doc: 'quantityLevel'
      - id: vega_level
        size: 8
        doc: 'vegaLevel'
      - id: delta_level
        size: 8
        doc: 'deltaLevel'
      - id: trigger
        type: s1
        enum: trigger
        doc: 'trigger'
  orders_mmp_triggered_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: currency_pair_id
        type: s8
        doc: 'currencyPairId'
      - id: frozen_until
        type: nanosecond_timestamp
        doc: 'frozenUntil. Nanoseconds since Unix epoch'
      - id: quantity_level
        size: 8
        doc: 'quantityLevel'
      - id: vega_level
        size: 8
        doc: 'vegaLevel'
      - id: delta_level
        size: 8
        doc: 'deltaLevel'
      - id: trigger
        type: s1
        enum: trigger
        doc: 'trigger'
  mass_quote_mmp_unfrozen_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: mmp_group_id
        type: s8
        doc: 'mmpGroupId'
      - id: correlation_id_optional
        type: s8_nullable
        doc: 'correlationId. Nullable, No Value = -9223372036854775808'
  orders_mmp_unfrozen_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8_nullable
        doc: 'execId. Nullable, No Value = -9223372036854775808'
      - id: currency_pair_id
        type: s8
        doc: 'currencyPairId'
      - id: correlation_id_optional
        type: s8_nullable
        doc: 'correlationId. Nullable, No Value = -9223372036854775808'
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
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808

enums:
  template_id:
    1:
      id: 'logon_message'
      doc: 'LogonMessage'
    2:
      id: 'logon_conf_message'
      doc: 'LogonConfMessage'
    4:
      id: 'logout_message'
      doc: 'LogoutMessage'
    5:
      id: 'logged_out_message'
      doc: 'LoggedOutMessage'
    10:
      id: 'heartbeat_message'
      doc: 'HeartbeatMessage'
    11:
      id: 'test_request_message'
      doc: 'TestRequestMessage'
    20:
      id: 'resend_request_message'
      doc: 'ResendRequestMessage'
    21:
      id: 'gap_fill_message'
      doc: 'GapFillMessage'
    30:
      id: 'reject_message'
      doc: 'RejectMessage'
    100:
      id: 'new_order_request_message'
      doc: 'NewOrderRequestMessage'
    110:
      id: 'amend_order_request_message'
      doc: 'AmendOrderRequestMessage'
    120:
      id: 'cancel_order_request_message'
      doc: 'CancelOrderRequestMessage'
    125:
      id: 'cancel_order_by_id_request_message'
      doc: 'CancelOrderByIdRequestMessage'
    130:
      id: 'mass_quote_request_message'
      doc: 'MassQuoteRequestMessage'
    140:
      id: 'mass_cancel_request_message'
      doc: 'MassCancelRequestMessage'
    145:
      id: 'mass_quote_cancel_request_message'
      doc: 'MassQuoteCancelRequestMessage'
    155:
      id: 'get_mass_quote_mmp_status_request_message'
      doc: 'GetMassQuoteMmpStatusRequestMessage'
    156:
      id: 'get_orders_mmp_status_request_message'
      doc: 'GetOrdersMmpStatusRequestMessage'
    200:
      id: 'new_order_response_message'
      doc: 'NewOrderResponseMessage'
    202:
      id: 'new_order_reject_message'
      doc: 'NewOrderRejectMessage'
    210:
      id: 'amend_order_response_message'
      doc: 'AmendOrderResponseMessage'
    212:
      id: 'amend_order_reject_message'
      doc: 'AmendOrderRejectMessage'
    220:
      id: 'cancel_order_response_message'
      doc: 'CancelOrderResponseMessage'
    222:
      id: 'cancel_order_reject_message'
      doc: 'CancelOrderRejectMessage'
    230:
      id: 'mass_quote_response_message'
      doc: 'MassQuoteResponseMessage'
    232:
      id: 'mass_quote_reject_message'
      doc: 'MassQuoteRejectMessage'
    240:
      id: 'mass_cancel_response_message'
      doc: 'MassCancelResponseMessage'
    242:
      id: 'mass_cancel_reject_message'
      doc: 'MassCancelRejectMessage'
    280:
      id: 'get_mass_quote_mmp_status_response_message'
      doc: 'GetMassQuoteMmpStatusResponseMessage'
    281:
      id: 'get_mass_quote_mmp_status_reject_message'
      doc: 'GetMassQuoteMmpStatusRejectMessage'
    282:
      id: 'get_orders_mmp_status_response_message'
      doc: 'GetOrdersMmpStatusResponseMessage'
    283:
      id: 'get_orders_mmp_status_reject_message'
      doc: 'GetOrdersMmpStatusRejectMessage'
    300:
      id: 'order_filled_message'
      doc: 'OrderFilledMessage'
    310:
      id: 'orders_canceled_message'
      doc: 'OrdersCanceledMessage'
    312:
      id: 'order_placed_message'
      doc: 'OrderPlacedMessage'
    314:
      id: 'mass_quote_orders_placed_message'
      doc: 'MassQuoteOrdersPlacedMessage'
    320:
      id: 'mass_quote_mmp_triggered_message'
      doc: 'MassQuoteMmpTriggeredMessage'
    322:
      id: 'orders_mmp_triggered_message'
      doc: 'OrdersMmpTriggeredMessage'
    324:
      id: 'mass_quote_mmp_unfrozen_message'
      doc: 'MassQuoteMmpUnfrozenMessage'
    326:
      id: 'orders_mmp_unfrozen_message'
      doc: 'OrdersMmpUnfrozenMessage'
  reset_seq_num:
    0:
      id: 'false_field'
      doc: 'FALSE'
    1:
      id: 'true_field'
      doc: 'TRUE'
  reason_reject_reason:
    1:
      id: 'invalid_schema_id'
      doc: 'INVALID_SCHEMA_ID'
    2:
      id: 'invalid_template_id'
      doc: 'INVALID_TEMPLATE_ID'
    3:
      id: 'invalid_block_length'
      doc: 'INVALID_BLOCK_LENGTH'
    4:
      id: 'invalid_field_value'
      doc: 'INVALID_FIELD_VALUE'
    5:
      id: 'message_disabled'
      doc: 'MESSAGE_DISABLED'
  side:
    1:
      id: 'buy'
      doc: 'BUY'
    0:
      id: 'both'
      doc: 'for use as mass cancel filter criteria'
  self_trading_mode:
    0:
      id: 'cancel_taker'
      doc: 'CANCEL_TAKER'
    1:
      id: 'cancel_maker'
      doc: 'CANCEL_MAKER'
  product_type:
    0:
      id: 'all'
      doc: 'ALL'
    1:
      id: 'options'
      doc: 'OPTIONS'
    2:
      id: 'futures'
      doc: 'FUTURES'
    3:
      id: 'combo_futures'
      doc: 'COMBO_FUTURES'
    4:
      id: 'combo_options'
      doc: 'COMBO_OPTIONS'
    5:
      id: 'spot'
      doc: 'SPOT'
  status:
    1:
      id: 'active'
      doc: 'ACTIVE'
    2:
      id: 'filled'
      doc: 'FILLED'
    3:
      id: 'canceled'
      doc: 'CANCELED'
    4:
      id: 'queued'
      doc: 'QUEUED'
  cancel_reason:
    0:
      id: 'unknown'
      doc: 'UNKNOWN'
    1:
      id: 'self_match_prevention'
      doc: 'SELF_MATCH_PREVENTION'
    2:
      id: 'time_in_force'
      doc: 'TIME_IN_FORCE'
    3:
      id: 'admin'
      doc: 'ADMIN'
    4:
      id: 'mm_protection'
      doc: 'MM_PROTECTION'
    5:
      id: 'liquidation'
      doc: 'LIQUIDATION'
    6:
      id: 'market_state_transition'
      doc: 'MARKET_STATE_TRANSITION'
    7:
      id: 'client_disconnect'
      doc: 'CLIENT_DISCONNECT'
    8:
      id: 'reduce_only'
      doc: 'REDUCE_ONLY'
    9:
      id: 'delivered'
      doc: 'Instrument status changed to DELIVERED'
    10:
      id: 'settlement'
      doc: 'Instrument entered settlement'
    11:
      id: 'book_deactivated'
      doc: 'Instrument status changed to INACTIVE'
    12:
      id: 'by_request'
      doc: 'BY_REQUEST'
    13:
      id: 'risk_check_timed_out'
      doc: 'RISK_CHECK_TIMED_OUT'
    14:
      id: 'mmp_group_deleted'
      doc: 'MMP_GROUP_DELETED'
    15:
      id: 'portfolio_locked'
      doc: 'PORTFOLIO_LOCKED'
    16:
      id: 'post_only'
      doc: 'post-only order would have crossed'
    17:
      id: 'qty_tick_size_rescale'
      doc: 'instrument qtyTickSize changed and this order''s quantity is not exactly representable under the new tick'
  leg_side:
    1:
      id: 'buy'
      doc: 'BUY'
    0:
      id: 'both'
      doc: 'for use as mass cancel filter criteria'
  reason_order_reject_reason:
    0:
      id: 'system_error'
      doc: 'SYSTEM_ERROR'
    1:
      id: 'invalid_instrument'
      doc: 'INVALID_INSTRUMENT'
    2:
      id: 'invalid_field'
      doc: 'INVALID_FIELD'
    3:
      id: 'insufficient_margin'
      doc: 'INSUFFICIENT_MARGIN'
    4:
      id: 'duplicate_client_order_id'
      doc: 'DUPLICATE_CLIENT_ORDER_ID'
    5:
      id: 'invalid_quantity'
      doc: 'INVALID_QUANTITY'
    6:
      id: 'invalid_price'
      doc: 'INVALID_PRICE'
    7:
      id: 'not_allowed_by_market_state'
      doc: 'NOT_ALLOWED_BY_MARKET_STATE'
    8:
      id: 'post_only'
      doc: 'POST_ONLY'
    9:
      id: 'too_many_open_orders'
      doc: 'exceeded max open orders for instrument/side'
    10:
      id: 'permission_error'
      doc: 'PERMISSION_ERROR'
    11:
      id: 'portfolio_not_found'
      doc: 'PORTFOLIO_NOT_FOUND'
    12:
      id: 'order_not_found'
      doc: 'for replaces and eng responses'
    13:
      id: 'mmp_not_configured'
      doc: 'MMP_NOT_CONFIGURED'
    14:
      id: 'mmp_max_quote_qty_exceeded'
      doc: 'MMP_MAX_QUOTE_QTY_EXCEEDED'
    15:
      id: 'mmp_group_frozen'
      doc: 'MMP_GROUP_FROZEN'
    16:
      id: 'invalid_margin_mode'
      doc: 'INVALID_MARGIN_MODE'
    17:
      id: 'in_liquidation'
      doc: 'Portfolio is in liquidation'
    18:
      id: 'risk_check_timed_out'
      doc: 'RISK_CHECK_TIMED_OUT'
    19:
      id: 'too_many_pending_replaces'
      doc: 'TOO_MANY_PENDING_REPLACES'
    20:
      id: 'iceberg_not_allowed'
      doc: 'ICEBERG_NOT_ALLOWED'
    21:
      id: 'invalid_allocations'
      doc: 'Block trade error'
    22:
      id: 'price_too_high'
      doc: 'price exceeds upper price band limit'
    23:
      id: 'price_too_low'
      doc: 'price exceeds lower price band limit'
    24:
      id: 'price_band_unavailable'
      doc: 'no price band or mark price available'
    25:
      id: 'rate_limit'
      doc: 'gateway rate limit exceeded'
    26:
      id: 'portfolio_locked'
      doc: 'Portfolio is locked'
    27:
      id: 'position_limit_exceeded'
      doc: 'future or options position size limit exceeded'
    28:
      id: 'order_size_limit_exceeded'
      doc: 'open order aggregate size limit exceeded'
    29:
      id: 'member_speed_bump_limit_exceeded'
      doc: 'member has too many live speed-bumped orders'
  reason_cancel_order_reject_reason:
    0:
      id: 'error'
      doc: 'ERROR'
    1:
      id: 'unknown_order'
      doc: 'UNKNOWN_ORDER'
    2:
      id: 'client_permission_error'
      doc: 'CLIENT_PERMISSION_ERROR'
    3:
      id: 'not_allowed_by_market_state'
      doc: 'NOT_ALLOWED_BY_MARKET_STATE'
    4:
      id: 'cancel_pending'
      doc: 'CANCEL_PENDING'
    5:
      id: 'in_liquidation'
      doc: 'IN_LIQUIDATION'
    6:
      id: 'invalid_instrument'
      doc: 'INVALID_INSTRUMENT'
    7:
      id: 'time_in_force'
      doc: 'TIME_IN_FORCE'
    8:
      id: 'speed_bump_converted_to_ioc'
      doc: 'SPEED_BUMP_CONVERTED_TO_IOC'
  bid_status:
    0:
      id: 'inactive'
      doc: 'no active quote in book (before or after update)'
    1:
      id: 'unmodified'
      doc: 'live in book with no change'
    2:
      id: 'qty_reduced'
      doc: 'QTY_REDUCED'
    3:
      id: 'updated'
      doc: 'live in book (possibly with fills)'
    4:
      id: 'filled'
      doc: 'fully filled'
    5:
      id: 'canceled_by_request'
      doc: 'existing quote/order was canceled by client request or because update was rejected'
    6:
      id: 'canceled_by_mmp'
      doc: 'quote was accepted then canceled because MMP was triggered'
    7:
      id: 'canceled_by_self_match'
      doc: 'quote was accepted then canceled due to self-match prevention'
    8:
      id: 'speed_bumped'
      doc: 'quote is speed bumped (pending in book)'
  ask_status:
    0:
      id: 'inactive'
      doc: 'no active quote in book (before or after update)'
    1:
      id: 'unmodified'
      doc: 'live in book with no change'
    2:
      id: 'qty_reduced'
      doc: 'QTY_REDUCED'
    3:
      id: 'updated'
      doc: 'live in book (possibly with fills)'
    4:
      id: 'filled'
      doc: 'fully filled'
    5:
      id: 'canceled_by_request'
      doc: 'existing quote/order was canceled by client request or because update was rejected'
    6:
      id: 'canceled_by_mmp'
      doc: 'quote was accepted then canceled because MMP was triggered'
    7:
      id: 'canceled_by_self_match'
      doc: 'quote was accepted then canceled due to self-match prevention'
    8:
      id: 'speed_bumped'
      doc: 'quote is speed bumped (pending in book)'
  bid_reject_reason:
    0:
      id: 'system_error'
      doc: 'SYSTEM_ERROR'
    1:
      id: 'invalid_instrument'
      doc: 'INVALID_INSTRUMENT'
    2:
      id: 'invalid_field'
      doc: 'INVALID_FIELD'
    3:
      id: 'insufficient_margin'
      doc: 'INSUFFICIENT_MARGIN'
    4:
      id: 'duplicate_client_order_id'
      doc: 'DUPLICATE_CLIENT_ORDER_ID'
    5:
      id: 'invalid_quantity'
      doc: 'INVALID_QUANTITY'
    6:
      id: 'invalid_price'
      doc: 'INVALID_PRICE'
    7:
      id: 'not_allowed_by_market_state'
      doc: 'NOT_ALLOWED_BY_MARKET_STATE'
    8:
      id: 'post_only'
      doc: 'POST_ONLY'
    9:
      id: 'too_many_open_orders'
      doc: 'exceeded max open orders for instrument/side'
    10:
      id: 'permission_error'
      doc: 'PERMISSION_ERROR'
    11:
      id: 'portfolio_not_found'
      doc: 'PORTFOLIO_NOT_FOUND'
    12:
      id: 'order_not_found'
      doc: 'for replaces and eng responses'
    13:
      id: 'mmp_not_configured'
      doc: 'MMP_NOT_CONFIGURED'
    14:
      id: 'mmp_max_quote_qty_exceeded'
      doc: 'MMP_MAX_QUOTE_QTY_EXCEEDED'
    15:
      id: 'mmp_group_frozen'
      doc: 'MMP_GROUP_FROZEN'
    16:
      id: 'invalid_margin_mode'
      doc: 'INVALID_MARGIN_MODE'
    17:
      id: 'in_liquidation'
      doc: 'Portfolio is in liquidation'
    18:
      id: 'risk_check_timed_out'
      doc: 'RISK_CHECK_TIMED_OUT'
    19:
      id: 'too_many_pending_replaces'
      doc: 'TOO_MANY_PENDING_REPLACES'
    20:
      id: 'iceberg_not_allowed'
      doc: 'ICEBERG_NOT_ALLOWED'
    21:
      id: 'invalid_allocations'
      doc: 'Block trade error'
    22:
      id: 'price_too_high'
      doc: 'price exceeds upper price band limit'
    23:
      id: 'price_too_low'
      doc: 'price exceeds lower price band limit'
    24:
      id: 'price_band_unavailable'
      doc: 'no price band or mark price available'
    25:
      id: 'rate_limit'
      doc: 'gateway rate limit exceeded'
    26:
      id: 'portfolio_locked'
      doc: 'Portfolio is locked'
    27:
      id: 'position_limit_exceeded'
      doc: 'future or options position size limit exceeded'
    28:
      id: 'order_size_limit_exceeded'
      doc: 'open order aggregate size limit exceeded'
    29:
      id: 'member_speed_bump_limit_exceeded'
      doc: 'member has too many live speed-bumped orders'
  ask_reject_reason:
    0:
      id: 'system_error'
      doc: 'SYSTEM_ERROR'
    1:
      id: 'invalid_instrument'
      doc: 'INVALID_INSTRUMENT'
    2:
      id: 'invalid_field'
      doc: 'INVALID_FIELD'
    3:
      id: 'insufficient_margin'
      doc: 'INSUFFICIENT_MARGIN'
    4:
      id: 'duplicate_client_order_id'
      doc: 'DUPLICATE_CLIENT_ORDER_ID'
    5:
      id: 'invalid_quantity'
      doc: 'INVALID_QUANTITY'
    6:
      id: 'invalid_price'
      doc: 'INVALID_PRICE'
    7:
      id: 'not_allowed_by_market_state'
      doc: 'NOT_ALLOWED_BY_MARKET_STATE'
    8:
      id: 'post_only'
      doc: 'POST_ONLY'
    9:
      id: 'too_many_open_orders'
      doc: 'exceeded max open orders for instrument/side'
    10:
      id: 'permission_error'
      doc: 'PERMISSION_ERROR'
    11:
      id: 'portfolio_not_found'
      doc: 'PORTFOLIO_NOT_FOUND'
    12:
      id: 'order_not_found'
      doc: 'for replaces and eng responses'
    13:
      id: 'mmp_not_configured'
      doc: 'MMP_NOT_CONFIGURED'
    14:
      id: 'mmp_max_quote_qty_exceeded'
      doc: 'MMP_MAX_QUOTE_QTY_EXCEEDED'
    15:
      id: 'mmp_group_frozen'
      doc: 'MMP_GROUP_FROZEN'
    16:
      id: 'invalid_margin_mode'
      doc: 'INVALID_MARGIN_MODE'
    17:
      id: 'in_liquidation'
      doc: 'Portfolio is in liquidation'
    18:
      id: 'risk_check_timed_out'
      doc: 'RISK_CHECK_TIMED_OUT'
    19:
      id: 'too_many_pending_replaces'
      doc: 'TOO_MANY_PENDING_REPLACES'
    20:
      id: 'iceberg_not_allowed'
      doc: 'ICEBERG_NOT_ALLOWED'
    21:
      id: 'invalid_allocations'
      doc: 'Block trade error'
    22:
      id: 'price_too_high'
      doc: 'price exceeds upper price band limit'
    23:
      id: 'price_too_low'
      doc: 'price exceeds lower price band limit'
    24:
      id: 'price_band_unavailable'
      doc: 'no price band or mark price available'
    25:
      id: 'rate_limit'
      doc: 'gateway rate limit exceeded'
    26:
      id: 'portfolio_locked'
      doc: 'Portfolio is locked'
    27:
      id: 'position_limit_exceeded'
      doc: 'future or options position size limit exceeded'
    28:
      id: 'order_size_limit_exceeded'
      doc: 'open order aggregate size limit exceeded'
    29:
      id: 'member_speed_bump_limit_exceeded'
      doc: 'member has too many live speed-bumped orders'
  reason_mass_quote_reject_reason:
    0:
      id: 'system_error'
      doc: 'SYSTEM_ERROR'
    1:
      id: 'invalid_mmp_group'
      doc: 'INVALID_MMP_GROUP'
    2:
      id: 'mmp_group_disabled'
      doc: 'MMP_GROUP_DISABLED'
    3:
      id: 'mmp_group_frozen'
      doc: 'MMP_GROUP_FROZEN'
    4:
      id: 'too_many_quotes'
      doc: 'TOO_MANY_QUOTES'
    5:
      id: 'invalid_instrument'
      doc: 'INVALID_INSTRUMENT'
    6:
      id: 'rate_limit'
      doc: 'gateway rate limit exceeded'
    7:
      id: 'portfolio_locked'
      doc: 'Portfolio is locked'
    8:
      id: 'duplicate_instrument'
      doc: 'the same instrument appears in more than one entry of a single mass quote'
  reason_mass_cancel_reject_reason:
    0:
      id: 'error'
      doc: 'ERROR'
    1:
      id: 'invalid_mmp_group'
      doc: 'INVALID_MMP_GROUP'
    2:
      id: 'client_permission_error'
      doc: 'CLIENT_PERMISSION_ERROR'
    3:
      id: 'not_allowed_by_market_state'
      doc: 'NOT_ALLOWED_BY_MARKET_STATE'
  reason_mmp_status_reject_reason:
    0:
      id: 'system_error'
      doc: 'SYSTEM_ERROR'
    1:
      id: 'invalid_mmp_group'
      doc: 'INVALID_MMP_GROUP'
  trigger:
    0:
      id: 'quantity'
      doc: 'QUANTITY'
    1:
      id: 'delta'
      doc: 'DELTA'
    2:
      id: 'vega'
      doc: 'VEGA'

