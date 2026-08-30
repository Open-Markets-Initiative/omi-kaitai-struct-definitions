# ---------------------------------------------------------------------
# Kaitai struct definition for: Coinbase CoinbaseDerivatives OrdersApi Sbe v1.8
#
# Protocol:
#   Organization: Coinbase
#   Protocol: Orders Api
#   Encoding: Simple Binary Encoding
#   Version: 1.8
#   Date: 9/5/2025
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
  id: coinbase_coinbasederivatives_ordersapi_sbe_v1_8
  title: Coinbase CoinbaseDerivatives OrdersApi Sbe v1.8
  license: GPL-3.0
  endian: le

doc: 'Coinbase Coinbase Derivatives Orders Api Sbe v1.8'
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
        size: message_header.message_length - 32
        type:
          switch-on: message_header.schema_id
          cases:
            'schema_id::session': session_message
            'schema_id::order': order_message
      - id: padding
        size: message_header.message_length - _io.pos
        doc: 'Tcp sbe alignment padding'
  message_header:
    seq:
      - id: protocol_id
        type: u1
        doc: 'Coinbase protocol identifier'
      - id: flags
        type: flags
        doc: 'NewOrderFlags bit set'
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
        type: nanosecond_timestamp
        doc: 'UTC timestamp of when the message was sent, nanoseconds since Unix epoch (January 1st, 1970, 00:00:00 GMT). Nanoseconds since Unix epoch'
      - id: block_length
        type: u2
        doc: 'Length of the root of the message contained before repeating groups or variable-length fields'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        enum: schema_id
        doc: 'Identifier of the schema publishing the message'
      - id: version
        type: u2
        doc: 'Schema version'
  flags:
    seq:
      - id: post_only
        type: b1
        doc: 'postOnly'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  session_message:
    seq:
      - id: session_payload
        type:
          switch-on: _parent.message_header.template_id
          cases:
            'template_id::session_logon_message': logon_message
            'template_id::session_logon_conf_message': logon_conf_message
            'template_id::session_logout_message': logout_message
            'template_id::session_logged_out_message': logged_out_message
            'template_id::session_heartbeat_message': heartbeat_message
            'template_id::session_test_request_message': test_request_message
            'template_id::session_resend_request_message': resend_request_message
            'template_id::session_gap_fill_message': gap_fill_message
            'template_id::reject_message': reject_message
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
      - id: gap_fill_padding
        type: u4
        doc: 'padding'
  reject_message:
    seq:
      - id: ref_sequence_number
        type: u4
        doc: 'refSequenceNumber'
      - id: reject_reason
        type: s4
        enum: reject_reason
        doc: 'reason'
      - id: details
        type: str
        size: 64
        encoding: ASCII
        doc: 'details'
  order_message:
    seq:
      - id: order_payload
        type:
          switch-on: _parent.message_header.template_id
          cases:
            'template_id::session_resend_request_message': ping_message
            'template_id::session_gap_fill_message': pong_message
            'template_id::instrument_info_request_message': instrument_info_request_message
            'template_id::instrument_info_message': instrument_info_message
            'template_id::set_account_message': set_account_message
            'template_id::set_trader_message': set_trader_message
            'template_id::set_ack_message': set_ack_message
            'template_id::new_order_message': new_order_message
            'template_id::new_ioc_order_message': new_ioc_order_message
            'template_id::reject_message': order_entered_message
            'template_id::replace_order_message': replace_order_message
            'template_id::obsolete_stream_order_message': obsolete_stream_order_message
            'template_id::order_reject_message': order_reject_message
            'template_id::order_replaced_message': order_replaced_message
            'template_id::cancel_order_message': cancel_order_message
            'template_id::order_canceled_message': order_canceled_message
            'template_id::cancel_order_reject_message': cancel_order_reject_message
            'template_id::mass_cancel_order_message': mass_cancel_order_message
            'template_id::mass_cancel_order_ack_message': mass_cancel_order_ack_message
            'template_id::mass_cancel_order_reject_message': mass_cancel_order_reject_message
            'template_id::unlock_trading_message': unlock_trading_message
            'template_id::unlock_trading_ack_message': unlock_trading_ack_message
            'template_id::unlock_trading_reject_message': unlock_trading_reject_message
            'template_id::order_filled_message': order_filled_message
            'template_id::spread_order_filled_message': spread_order_filled_message
            'template_id::last_exec_id_request_message': last_exec_id_request_message
            'template_id::last_exec_id_message': last_exec_id_message
            'template_id::event_resend_request_message': event_resend_request_message
            'template_id::event_resend_complete_message': event_resend_complete_message
            'template_id::event_resend_reject_message': event_resend_reject_message
            'template_id::reset_options_fill_protection_message': reset_options_fill_protection_message
            'template_id::reset_options_fill_protection_ack_message': reset_options_fill_protection_ack_message
            'template_id::reset_options_fill_protection_reject_message': reset_options_fill_protection_reject_message
  ping_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: request_time
        type: nanosecond_timestamp
        doc: 'requestTime. Nanoseconds since Unix epoch'
      - id: data
        type: data
        doc: 'data data struct'
  data:
    seq:
      - id: len_data_value
        type: u1
      - id: data_value
        size: len_data_value
  pong_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: request_time
        type: nanosecond_timestamp
        doc: 'requestTime. Nanoseconds since Unix epoch'
      - id: server_time
        type: nanosecond_timestamp
        doc: 'serverTime. Nanoseconds since Unix epoch'
      - id: trading_instrument_status
        type: s1
        enum: trading_instrument_status
        doc: 'status'
      - id: data
        type: data
        doc: 'data data struct'
  instrument_info_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  instrument_info_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'securityType'
      - id: instrument_status
        type: u1
        enum: instrument_status
        doc: 'status'
      - id: is_last_message
        type: s1
        enum: is_last_message
        doc: 'isLastMessage'
      - id: reserved_byte
        type: s1
        doc: 'reserved'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        doc: 'symbol'
  set_account_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        doc: 'account'
  set_trader_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: trader
        type: str
        size: 16
        encoding: ASCII
        doc: 'trader'
  set_ack_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  new_order_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: limit_price
        type: decimal_s8_9
        doc: 'limitPrice. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: flags
        type: flags
        doc: 'NewOrderFlags bit set'
      - id: good_til_date
        type: u2_nullable
        doc: 'goodTilDate. Nullable, No Value = 0'
  new_ioc_order_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: limit_price
        type: decimal_s8_9
        doc: 'limitPrice. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
      - id: min_qty
        type: s4_nullable
        doc: 'minQty. Nullable, No Value = -2147483648'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
  order_entered_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
  replace_order_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: new_limit_price
        type: decimal_s8_9_nullable
        doc: 'newLimitPrice. Implied decimal with scale 1e-9. Nullable, No Value = -9223372036854775808'
      - id: new_quantity
        type: s4_nullable
        doc: 'newQuantity. Nullable, No Value = -2147483648'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: good_til_date
        type: u2_nullable
        doc: 'goodTilDate. Nullable, No Value = 0'
      - id: time_in_force
        type: s1_nullable
        doc: 'timeInForce. Nullable, No Value = 128'
  obsolete_stream_order_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: last_processed_fill_id
        type: s8_nullable
        doc: 'lastProcessedFillId. Nullable, No Value = -9223372036854775808'
      - id: limit_price
        type: decimal_s8_9
        doc: 'limitPrice. Implied decimal with scale 1e-9'
      - id: quantity
        type: s4
        doc: 'quantity'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
  order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id_optional
        type: s8_nullable
        doc: 'orderId. Nullable, No Value = -9223372036854775808'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'rejectReason'
      - id: order_reject_details
        type: str
        size: 47
        encoding: ASCII
        doc: 'details'
  order_replaced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: total_filled
        type: s4
        doc: 'totalFilled'
      - id: available_qty
        type: s4
        doc: 'availableQty'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
  cancel_order_message:
    seq:
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
  order_canceled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: receive_time
        type: nanosecond_timestamp
        doc: 'receiveTime. Nanoseconds since Unix epoch'
      - id: total_filled
        type: s4
        doc: 'totalFilled'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'cancelReason'
  cancel_order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id_optional
        type: s8_nullable
        doc: 'orderId. Nullable, No Value = -9223372036854775808'
      - id: cancel_order_reject_reason
        type: u1
        enum: cancel_order_reject_reason
        doc: 'rejectReason'
      - id: cancel_order_reject_details
        type: str
        size: 31
        encoding: ASCII
        doc: 'details'
  mass_cancel_order_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: limit_price
        type: decimal_s8_9
        doc: 'limitPrice. Implied decimal with scale 1e-9'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: side
        type: s1
        enum: side
        doc: 'side'
      - id: current_session_only
        type: s1
        enum: current_session_only
        doc: 'currentSessionOnly'
      - id: request_trading_lock
        type: s1
        enum: request_trading_lock
        doc: 'requestTradingLock'
  mass_cancel_order_ack_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: canceled_count
        type: s4
        doc: 'canceledCount'
      - id: only_current_session
        type: s1
        enum: only_current_session
        doc: 'onlyCurrentSession'
      - id: trading_lock_applied
        type: s1
        enum: trading_lock_applied
        doc: 'tradingLockApplied'
  mass_cancel_order_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: error_message
        type: str
        size: 32
        encoding: ASCII
        doc: 'errorMessage'
  unlock_trading_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: current_session_only
        type: s1
        enum: current_session_only
        doc: 'currentSessionOnly'
  unlock_trading_ack_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: num_users_affected
        type: s4
        doc: 'numUsersAffected'
  unlock_trading_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: error_message
        type: str
        size: 32
        encoding: ASCII
        doc: 'errorMessage'
  order_filled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: filled_vwap
        type: decimal_s8_9
        doc: 'filledVwap. Implied decimal with scale 1e-9'
      - id: total_filled
        type: s4
        doc: 'totalFilled'
      - id: available_qty
        type: s4
        doc: 'availableQty'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: s4
        doc: 'fillQty'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: is_aggressor
        type: s1
        enum: is_aggressor
        doc: 'isAggressor'
  spread_order_filled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: exec_id
        type: s8
        doc: 'execId'
      - id: match_id
        type: s8
        doc: 'matchId'
      - id: client_order_id
        type: s8
        doc: 'clientOrderId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: order_id
        type: s8
        doc: 'orderId'
      - id: filled_vwap
        type: decimal_s8_9
        doc: 'filledVwap. Implied decimal with scale 1e-9'
      - id: total_filled
        type: s4
        doc: 'totalFilled'
      - id: available_qty
        type: s4
        doc: 'availableQty'
      - id: fill_price
        type: decimal_s8_9
        doc: 'fillPrice. Implied decimal with scale 1e-9'
      - id: leg_1_fill_price
        type: decimal_s8_9
        doc: 'leg1FillPrice. Implied decimal with scale 1e-9'
      - id: leg_2_fill_price
        type: decimal_s8_9
        doc: 'leg2FillPrice. Implied decimal with scale 1e-9'
      - id: fill_qty
        type: s4
        doc: 'fillQty'
      - id: instrument_id
        type: s4
        doc: 'instrumentId'
      - id: is_aggressor
        type: s1
        enum: is_aggressor
        doc: 'isAggressor'
  last_exec_id_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  last_exec_id_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: last_exec_id
        type: s8
        doc: 'lastExecId'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
  event_resend_request_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: begin_exec_id
        type: s8
        doc: 'beginExecId'
      - id: end_exec_id
        type: s8
        doc: 'endExecId'
  event_resend_complete_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: resent_event_count
        type: s4
        doc: 'resentEventCount'
  event_resend_reject_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: resend_reject_reason
        type: s1
        enum: resend_reject_reason
        doc: 'rejectReason'
      - id: details_string_55
        type: str
        size: 55
        encoding: ASCII
        doc: 'details'
  reset_options_fill_protection_message:
    seq:
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: product_id
        type: s4
        doc: 'productId'
  reset_options_fill_protection_ack_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: product_id
        type: s4
        doc: 'productId'
  reset_options_fill_protection_reject_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'timestamp. Nanoseconds since Unix epoch'
      - id: correlation_id
        type: s8
        doc: 'correlationId'
      - id: error_message
        type: str
        size: 32
        encoding: ASCII
        doc: 'errorMessage'
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808

enums:
  template_id:
    100:
      id: 'session_logon_message'
      doc: 'LogonMessage'
    200:
      id: 'session_logon_conf_message'
      doc: 'LogonConfMessage'
    101:
      id: 'session_logout_message'
      doc: 'LogoutMessage'
    201:
      id: 'session_logged_out_message'
      doc: 'LoggedOutMessage'
    10:
      id: 'session_heartbeat_message'
      doc: 'HeartbeatMessage'
    11:
      id: 'session_test_request_message'
      doc: 'TestRequestMessage'
    102:
      id: 'session_resend_request_message'
      doc: 'ResendRequestMessage'
    202:
      id: 'session_gap_fill_message'
      doc: 'GapFillMessage'
    210:
      id: 'reject_message'
      doc: 'RejectMessage'
    103:
      id: 'instrument_info_request_message'
      doc: 'InstrumentInfoRequestMessage'
    203:
      id: 'instrument_info_message'
      doc: 'InstrumentInfoMessage'
    105:
      id: 'set_account_message'
      doc: 'SetAccountMessage'
    106:
      id: 'set_trader_message'
      doc: 'SetTraderMessage'
    205:
      id: 'set_ack_message'
      doc: 'SetAckMessage'
    110:
      id: 'new_order_message'
      doc: 'NewOrderMessage'
    111:
      id: 'new_ioc_order_message'
      doc: 'NewIocOrderMessage'
    120:
      id: 'replace_order_message'
      doc: 'ReplaceOrderMessage'
    121:
      id: 'obsolete_stream_order_message'
      doc: 'ObsoleteStreamOrderMessage'
    221:
      id: 'order_reject_message'
      doc: 'OrderRejectMessage'
    220:
      id: 'order_replaced_message'
      doc: 'OrderReplacedMessage'
    130:
      id: 'cancel_order_message'
      doc: 'CancelOrderMessage'
    230:
      id: 'order_canceled_message'
      doc: 'OrderCanceledMessage'
    233:
      id: 'cancel_order_reject_message'
      doc: 'CancelOrderRejectMessage'
    131:
      id: 'mass_cancel_order_message'
      doc: 'MassCancelOrderMessage'
    231:
      id: 'mass_cancel_order_ack_message'
      doc: 'MassCancelOrderAckMessage'
    232:
      id: 'mass_cancel_order_reject_message'
      doc: 'MassCancelOrderRejectMessage'
    132:
      id: 'unlock_trading_message'
      doc: 'UnlockTradingMessage'
    234:
      id: 'unlock_trading_ack_message'
      doc: 'UnlockTradingAckMessage'
    235:
      id: 'unlock_trading_reject_message'
      doc: 'UnlockTradingRejectMessage'
    240:
      id: 'order_filled_message'
      doc: 'OrderFilledMessage'
    241:
      id: 'spread_order_filled_message'
      doc: 'SpreadOrderFilledMessage'
    150:
      id: 'last_exec_id_request_message'
      doc: 'LastExecIdRequestMessage'
    250:
      id: 'last_exec_id_message'
      doc: 'LastExecIdMessage'
    152:
      id: 'event_resend_request_message'
      doc: 'EventResendRequestMessage'
    252:
      id: 'event_resend_complete_message'
      doc: 'EventResendCompleteMessage'
    253:
      id: 'event_resend_reject_message'
      doc: 'EventResendRejectMessage'
    160:
      id: 'reset_options_fill_protection_message'
      doc: 'ResetOptionsFillProtectionMessage'
    260:
      id: 'reset_options_fill_protection_ack_message'
      doc: 'ResetOptionsFillProtectionAckMessage'
    261:
      id: 'reset_options_fill_protection_reject_message'
      doc: 'ResetOptionsFillProtectionRejectMessage'
  schema_id:
    1100:
      id: 'session'
      doc: 'Sbe Schema Id for fairx.gateway.sbe.codec.session'
    1101:
      id: 'order'
      doc: 'Sbe Schema Id for cb.dcm.gateway.sbe.codec.order'
  reset_seq_num:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reject_reason:
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
  trading_instrument_status:
    0:
      id: 'ok'
      doc: 'TradingSystemStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'temporarily_unavailable'
      doc: 'TradingSystemStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'back_pressured'
      doc: 'TradingSystemStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_type:
    0:
      id: 'futures'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'options'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_status:
    1:
      id: 'pre_open'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'pre_open_no_cancel'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'ready_to_trade'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'trading_halt'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'close'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'post_close'
      doc: 'InstrumentStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  is_last_message:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    1:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0:
      id: 'day'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'good_till_date'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_reject_reason:
    1:
      id: 'error'
      doc: 'OrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'invalid_instrument'
      doc: 'OrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cl_ord_id_in_use'
      doc: 'OrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'validation_failure'
      doc: 'OrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'unknown_order'
      doc: 'OrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_reason:
    0:
      id: 'expired'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'canceled_by_user'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'self_match_prevention'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'client_disconnect'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'price_limit'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'admin_cancel'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'mass_cancel'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'stream_replaced'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'active_limit_exceeded'
      doc: 'CancelReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_order_reject_reason:
    1:
      id: 'error'
      doc: 'CancelOrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unknown_order'
      doc: 'CancelOrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_filled'
      doc: 'CancelOrderRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  current_session_only:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  request_trading_lock:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  only_current_session:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_lock_applied:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  is_aggressor:
    0:
      id: 'false_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'Bool Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  resend_reject_reason:
    1:
      id: 'begin_exec_id_too_small'
      doc: 'ResendRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'end_exec_id_too_large'
      doc: 'ResendRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'resend_already_in_progress'
      doc: 'ResendRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'too_many_resend_requests'
      doc: 'ResendRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'server_error'
      doc: 'ResendRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

