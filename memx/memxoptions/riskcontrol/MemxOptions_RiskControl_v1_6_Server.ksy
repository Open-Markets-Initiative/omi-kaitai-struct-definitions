# ---------------------------------------------------------------------
# Kaitai struct definition for: Memx MemxOptions RiskControl Sbe v1.6
#
# Protocol:
#   Organization: The Members Exchange
#   Protocol: Risk Control
#   Encoding: Simple Binary Encoding
#   Version: 1.6
#   Date: 11/15/23
#   Specification: Risk Control for US Options SBE-v1_6.pdf
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
  id: memx_memxoptions_riskcontrol_sbe_v1_6_server
  title: Memx MemxOptions RiskControl Sbe v1.6
  license: GPL-3.0
  endian: be

doc: 'The Members Exchange Memx Options Risk Control Sbe v1.6'
doc-ref: https://memxtrading.com/

seq:
  - id: common_header
    type: common_header_struct
    doc: 'Tcp Common Header'
  - id: server_data
    size: common_header.message_length
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::login_accepted': login_accepted_message
        'message_type::login_rejected': login_rejected_message
        'message_type::start_of_session': start_of_session_message
        'message_type::replay_begin': replay_begin_message
        'message_type::replay_rejected': replay_rejected_message
        'message_type::replay_complete': replay_complete_message
        'message_type::stream_begin': stream_begin_message
        'message_type::stream_rejected': stream_rejected_message
        'message_type::stream_complete': stream_complete_message
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: message_length
        type: u2
        doc: 'Total bytes following the header (does not include this header)'
  login_accepted_message:
    seq:
      - id: supported_request_mode
        type: u1
        enum: supported_request_mode
        doc: 'The request mode that this connection supports'
  login_rejected_message:
    seq:
      - id: login_reject_code
        type: u1
        enum: login_reject_code
        doc: 'The code for the rejection type'
  start_of_session_message:
    seq:
      - id: session_id
        type: u8
        doc: 'The identifier for the session for which data is desired'
  replay_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: pending_message_count
        type: u4
        doc: 'The number of messages to be delivered in this replay'
  replay_rejected_message:
    seq:
      - id: replay_reject_code
        type: u1
        enum: replay_reject_code
        doc: 'The code for the rejection type'
  replay_complete_message:
    seq:
      - id: message_count
        type: u8
        doc: 'The number of messages which were sent in the replay'
  stream_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number'
      - id: max_sequence_number
        type: u8
        doc: 'The maximum sequence number currently published on this stream'
  stream_rejected_message:
    seq:
      - id: stream_reject_code
        type: u1
        enum: stream_reject_code
        doc: 'The code for the rejection type'
  stream_complete_message:
    seq:
      - id: total_sequence_count
        type: u8
        doc: 'The count of messages that were sent on this stream'
  sequenced_message:
    seq:
      - id: server_sbe_message
        type: server_sbe_message
        doc: 'Sbe message sent by Memx to the firm'
  server_sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: server_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::active_risk_threshold_state_message': active_risk_threshold_state_message
            'template_id::active_risk_threshold_change_rej_message': active_risk_threshold_change_rej_message
            'template_id::active_risk_acknowledged_message': active_risk_acknowledged_message
            'template_id::active_risk_acknowledge_rej_message': active_risk_acknowledge_rej_message
            'template_id::active_risk_quantity_update_notification_message': active_risk_quantity_update_notification_message
            'template_id::cp_volume_threshold_state_message': cp_volume_threshold_state_message
            'template_id::cp_executed_notional_threshold_state_message': cp_executed_notional_threshold_state_message
            'template_id::cp_total_executions_threshold_state_message': cp_total_executions_threshold_state_message
            'template_id::cp_percent_outstanding_contracts_threshold_state_message': cp_percent_outstanding_contracts_threshold_state_message
            'template_id::cp_breach_count_threshold_state_message': cp_breach_count_threshold_state_message
            'template_id::manual_cp_breach_trigger_pending_message': manual_cp_breach_trigger_pending_message
            'template_id::manual_cp_breach_trigger_done_message': manual_cp_breach_trigger_done_message
            'template_id::risk_threshold_update_rej_message': risk_threshold_update_rej_message
            'template_id::passive_risk_threshold_notification_message': passive_risk_threshold_notification_message
            'template_id::single_order_allow_iso_orders_state_message': single_order_allow_iso_orders_state_message
            'template_id::single_order_allow_orders_in_crossed_market_state_message': single_order_allow_orders_in_crossed_market_state_message
            'template_id::single_order_max_notional_threshold_state_message': single_order_max_notional_threshold_state_message
            'template_id::single_order_max_contracts_threshold_state_message': single_order_max_contracts_threshold_state_message
            'template_id::risk_settings_query_done_message': risk_settings_query_done_message
            'template_id::risk_settings_query_rej_message': risk_settings_query_rej_message
            'template_id::manual_cp_breach_trigger_rej_message': manual_cp_breach_trigger_rej_message
            'template_id::breach_clear_rej_message': breach_clear_rej_message
            'template_id::breach_cleared_message': breach_cleared_message
            'template_id::cp_gross_notional_threshold_state_message': cp_gross_notional_threshold_state_message
            'template_id::cp_market_order_gross_notional_threshold_state_message': cp_market_order_gross_notional_threshold_state_message
            'template_id::cp_net_notional_threshold_state_message': cp_net_notional_threshold_state_message
            'template_id::cp_market_order_net_notional_threshold_state_message': cp_market_order_net_notional_threshold_state_message
            'template_id::cp_duplicate_order_threshold_state_message': cp_duplicate_order_threshold_state_message
            'template_id::cp_order_rate_threshold_state_message': cp_order_rate_threshold_state_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Memx Udp Message Type'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
  active_risk_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlier'
      - id: efid
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID'
      - id: threshold_quantity
        type: u4
        doc: 'ThresholdQuantity'
      - id: unacked_quantity
        type: u4
        doc: 'UnackedQuantity'
      - id: block_extension
        size: _parent.sbe_header.block_length - 38
        doc: 'Bytes the stated block holds beyond the 38 this version reads'
  active_risk_threshold_change_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: threshold_quantity
        type: u4
        doc: 'ThresholdQuantity'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 36
        doc: 'Bytes the stated block holds beyond the 36 this version reads'
  active_risk_acknowledged_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlier'
      - id: efid
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID'
      - id: quantity
        type: u4
        doc: 'Quantity'
      - id: unacked_quantity
        type: u4
        doc: 'UnackedQuantity'
      - id: block_extension
        size: _parent.sbe_header.block_length - 38
        doc: 'Bytes the stated block holds beyond the 38 this version reads'
  active_risk_acknowledge_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlier'
      - id: efid
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID'
      - id: threshold_quantity
        type: u4
        doc: 'ThresholdQuantity'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 36
        doc: 'Bytes the stated block holds beyond the 36 this version reads'
  active_risk_quantity_update_notification_message:
    seq:
      - id: sending_time
        type: u8
        doc: 'SendingTime'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: order_id
        type: u8
        doc: 'OrderID'
      - id: trd_match_id
        type: u8
        doc: 'TrdMatchID'
      - id: efid
        type: str
        size: 4
        encoding: ASCII
        doc: 'EFID'
      - id: underlier
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlier'
      - id: option_security_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'OptionSecurityID'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: last_px
        type: decimal_u8_8
        doc: 'LastPx. Implied decimal with scale 1e-8'
      - id: last_qty
        type: u4
        doc: 'LastQty'
      - id: unacked_quantity
        type: u4
        doc: 'UnackedQuantity'
      - id: block_extension
        size: _parent.sbe_header.block_length - 67
        doc: 'Bytes the stated block holds beyond the 67 this version reads'
  cp_volume_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: volume
        type: u8
        doc: 'Volume'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 44
        doc: 'Bytes the stated block holds beyond the 44 this version reads'
  cp_executed_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: price_in_dollars
        type: u8
        doc: 'PriceInDollars'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 44
        doc: 'Bytes the stated block holds beyond the 44 this version reads'
  cp_total_executions_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: total_executions
        type: u4
        doc: 'TotalExecutions'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  cp_percent_outstanding_contracts_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: percent
        type: s4
        doc: 'Percent'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 38
        doc: 'Bytes the stated block holds beyond the 38 this version reads'
  cp_breach_count_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: count
        type: u4
        doc: 'Count'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  manual_cp_breach_trigger_pending_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: breach_id
        type: u8
        doc: 'BreachID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  manual_cp_breach_trigger_done_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: breach_id
        type: u8
        doc: 'BreachID'
      - id: total_affected_orders
        type: u4
        doc: 'TotalAffectedOrders'
      - id: block_extension
        size: _parent.sbe_header.block_length - 44
        doc: 'Bytes the stated block holds beyond the 44 this version reads'
  risk_threshold_update_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: risk_type
        type: u1
        enum: risk_type
        doc: 'RiskType'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 23
        doc: 'Bytes the stated block holds beyond the 23 this version reads'
  passive_risk_threshold_notification_message:
    seq:
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: rule_type
        type: u1
        enum: rule_type
        doc: 'RuleType'
      - id: latest_percentage
        type: u1
        doc: 'LatestPercentage'
      - id: breach_id_optional
        type: u8_nullable
        doc: 'BreachID. Nullable, No Value = 18446744073709551615'
      - id: transact_time
        type: u8
        doc: 'TransactTime'
      - id: block_extension
        size: _parent.sbe_header.block_length - 30
        doc: 'Bytes the stated block holds beyond the 30 this version reads'
  single_order_allow_iso_orders_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: allow_iso_orders
        type: u1
        enum: allow_iso_orders
        doc: 'AllowISOOrders'
      - id: block_extension
        size: _parent.sbe_header.block_length - 33
        doc: 'Bytes the stated block holds beyond the 33 this version reads'
  single_order_allow_orders_in_crossed_market_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: allow_orders
        type: u1
        enum: allow_orders
        doc: 'AllowOrders'
      - id: block_extension
        size: _parent.sbe_header.block_length - 33
        doc: 'Bytes the stated block holds beyond the 33 this version reads'
  single_order_max_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: max_notional_in_dollars
        type: u8
        doc: 'MaxNotionalInDollars'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  single_order_max_contracts_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: max_contracts
        type: u4
        doc: 'MaxContracts'
      - id: block_extension
        size: _parent.sbe_header.block_length - 36
        doc: 'Bytes the stated block holds beyond the 36 this version reads'
  risk_settings_query_done_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: number_msgs_sent
        type: u4
        doc: 'NumberMsgsSent'
      - id: block_extension
        size: _parent.sbe_header.block_length - 24
        doc: 'Bytes the stated block holds beyond the 24 this version reads'
  risk_settings_query_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 22
        doc: 'Bytes the stated block holds beyond the 22 this version reads'
  manual_cp_breach_trigger_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 34
        doc: 'Bytes the stated block holds beyond the 34 this version reads'
  breach_clear_rej_message:
    seq:
      - id: clordid
        type: str
        size: 20
        encoding: ASCII
        doc: 'ClOrdID'
      - id: breach_id_optional
        type: u8_nullable
        doc: 'BreachID. Nullable, No Value = 18446744073709551615'
      - id: reject_reason
        type: u2
        enum: reject_reason
        doc: 'RejectReason'
      - id: block_extension
        size: _parent.sbe_header.block_length - 30
        doc: 'Bytes the stated block holds beyond the 30 this version reads'
  breach_cleared_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: breach_id_optional
        type: u8_nullable
        doc: 'BreachID. Nullable, No Value = 18446744073709551615'
      - id: block_extension
        size: _parent.sbe_header.block_length - 28
        doc: 'Bytes the stated block holds beyond the 28 this version reads'
  cp_gross_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: price_in_dollars
        type: u8
        doc: 'PriceInDollars'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  cp_market_order_gross_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: price_in_dollars
        type: u8
        doc: 'PriceInDollars'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  cp_net_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: price_in_dollars
        type: u8
        doc: 'PriceInDollars'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  cp_market_order_net_notional_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: price_in_dollars
        type: u8
        doc: 'PriceInDollars'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  cp_duplicate_order_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: max_dup_orders
        type: u4
        doc: 'MaxDupOrders'
      - id: use_order_price_in_dup_check
        type: u1
        enum: use_order_price_in_dup_check
        doc: 'UseOrderPriceInDupCheck'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 41
        doc: 'Bytes the stated block holds beyond the 41 this version reads'
  cp_order_rate_threshold_state_message:
    seq:
      - id: clordid_optional
        type: str_20_nullable
        doc: 'ClOrdID. Nullable, No Value = 0'
      - id: underlier_optional
        type: str_6_nullable
        doc: 'Underlier. Nullable, No Value = 0'
      - id: efid_optional
        type: str_4_nullable
        doc: 'EFID. Nullable, No Value = 0'
      - id: risk_group_id
        type: u2_nullable
        doc: 'RiskGroupID. Nullable, No Value = 65535'
      - id: max_order_msgs
        type: u4
        doc: 'MaxOrderMsgs'
      - id: period_in_milli_seconds
        type: u4
        doc: 'PeriodInMilliSeconds'
      - id: block_extension
        size: _parent.sbe_header.block_length - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
  str_20_nullable:
    seq:
      - id: value
        size: 20
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615

enums:
  message_type:
    0:
      id: 'heartbeat'
      doc: 'Memx Tcp Heartbeat'
    100:
      id: 'login_request'
      doc: 'Memx Tcp Login Request'
    101:
      id: 'replay_request'
      doc: 'Memx Tcp Replay Request'
    102:
      id: 'replay_all_request'
      doc: 'Memx Tcp Replay All Request'
    103:
      id: 'stream_request'
      doc: 'Memx Tcp Stream Request'
    104:
      id: 'unsequenced_message'
      doc: 'Memx Tcp Unsequenced Message'
    1:
      id: 'login_accepted'
      doc: 'Memx Tcp Login Accepted Message'
    2:
      id: 'login_rejected'
      doc: 'Memx Tcp Login Rejected Message'
    3:
      id: 'start_of_session'
      doc: 'Memx Tcp Start of Session Message'
    4:
      id: 'end_of_session'
      doc: 'Memx Tcp End of Session Message'
    5:
      id: 'replay_begin'
      doc: 'Memx Tcp Replay Begin Message'
    6:
      id: 'replay_rejected'
      doc: 'Memx Tcp Replay Rejected Message'
    7:
      id: 'replay_complete'
      doc: 'Memx Tcp Replay Complete Message'
    8:
      id: 'stream_begin'
      doc: 'Memx Tcp Stream Begin Message'
    9:
      id: 'stream_rejected'
      doc: 'Memx Tcp Stream Rejected Message'
    10:
      id: 'stream_complete'
      doc: 'Memx Tcp Stream Complete Message'
    11:
      id: 'sequenced_message'
      doc: 'Memx Tcp Sequenced Message'
  template_id:
    1:
      id: 'risk_settings_query_message'
      doc: 'RiskSettingsQueryMessage'
    2:
      id: 'active_risk_threshold_change_req_message'
      doc: 'ActiveRiskThresholdChangeReqMessage'
    3:
      id: 'active_risk_acknowledgement_req_message'
      doc: 'ActiveRiskAcknowledgementReqMessage'
    4:
      id: 'cp_volume_threshold_change_req_message'
      doc: 'CPVolumeThresholdChangeReqMessage'
    5:
      id: 'cp_executed_notional_threshold_change_req_message'
      doc: 'CPExecutedNotionalThresholdChangeReqMessage'
    6:
      id: 'cp_total_executions_threshold_change_req_message'
      doc: 'CPTotalExecutionsThresholdChangeReqMessage'
    7:
      id: 'cp_percent_outstanding_contracts_threshold_change_req_message'
      doc: 'CPPercentOutstandingContractsThresholdChangeReqMessage'
    8:
      id: 'cp_breach_count_threshold_change_req_message'
      doc: 'CPBreachCountThresholdChangeReqMessage'
    9:
      id: 'manual_cp_breach_trigger_req_message'
      doc: 'ManualCPBreachTriggerReqMessage'
    10:
      id: 'cp_clear_breach_req_message'
      doc: 'CPClearBreachReqMessage'
    11:
      id: 'single_order_allow_iso_orders_change_req_message'
      doc: 'SingleOrderAllowISOOrdersChangeReqMessage'
    12:
      id: 'single_order_allow_orders_in_crossed_market_change_req_message'
      doc: 'SingleOrderAllowOrdersInCrossedMarketChangeReqMessage'
    13:
      id: 'single_order_max_notional_change_req_message'
      doc: 'SingleOrderMaxNotionalChangeReqMessage'
    14:
      id: 'single_order_max_contracts_change_req_message'
      doc: 'SingleOrderMaxContractsChangeReqMessage'
    18:
      id: 'cp_gross_notional_threshold_change_req_message'
      doc: 'CPGrossNotionalThresholdChangeReqMessage'
    19:
      id: 'cp_market_order_gross_notional_threshold_change_req_message'
      doc: 'CPMarketOrderGrossNotionalThresholdChangeReqMessage'
    20:
      id: 'cp_net_notional_threshold_change_req_message'
      doc: 'CPNetNotionalThresholdChangeReqMessage'
    21:
      id: 'cp_market_order_net_notional_threshold_change_req_message'
      doc: 'CPMarketOrderNetNotionalThresholdChangeReqMessage'
    22:
      id: 'cp_duplicate_order_threshold_change_req_message'
      doc: 'CPDuplicateOrderThresholdChangeReqMessage'
    23:
      id: 'cp_order_rate_threshold_change_req_message'
      doc: 'CPOrderRateThresholdChangeReqMessage'
    30:
      id: 'active_risk_threshold_state_message'
      doc: 'ActiveRiskThresholdStateMessage'
    31:
      id: 'active_risk_threshold_change_rej_message'
      doc: 'ActiveRiskThresholdChangeRejMessage'
    32:
      id: 'active_risk_acknowledged_message'
      doc: 'ActiveRiskAcknowledgedMessage'
    33:
      id: 'active_risk_acknowledge_rej_message'
      doc: 'ActiveRiskAcknowledgeRejMessage'
    34:
      id: 'active_risk_quantity_update_notification_message'
      doc: 'ActiveRiskQuantityUpdateNotificationMessage'
    35:
      id: 'cp_volume_threshold_state_message'
      doc: 'CPVolumeThresholdStateMessage'
    36:
      id: 'cp_executed_notional_threshold_state_message'
      doc: 'CPExecutedNotionalThresholdStateMessage'
    37:
      id: 'cp_total_executions_threshold_state_message'
      doc: 'CPTotalExecutionsThresholdStateMessage'
    38:
      id: 'cp_percent_outstanding_contracts_threshold_state_message'
      doc: 'CPPercentOutstandingContractsThresholdStateMessage'
    39:
      id: 'cp_breach_count_threshold_state_message'
      doc: 'CPBreachCountThresholdStateMessage'
    40:
      id: 'manual_cp_breach_trigger_pending_message'
      doc: 'ManualCPBreachTriggerPendingMessage'
    41:
      id: 'manual_cp_breach_trigger_done_message'
      doc: 'ManualCPBreachTriggerDoneMessage'
    42:
      id: 'risk_threshold_update_rej_message'
      doc: 'RiskThresholdUpdateRejMessage'
    43:
      id: 'passive_risk_threshold_notification_message'
      doc: 'PassiveRiskThresholdNotificationMessage'
    44:
      id: 'single_order_allow_iso_orders_state_message'
      doc: 'SingleOrderAllowISOOrdersStateMessage'
    45:
      id: 'single_order_allow_orders_in_crossed_market_state_message'
      doc: 'SingleOrderAllowOrdersInCrossedMarketStateMessage'
    46:
      id: 'single_order_max_notional_threshold_state_message'
      doc: 'SingleOrderMaxNotionalThresholdStateMessage'
    47:
      id: 'single_order_max_contracts_threshold_state_message'
      doc: 'SingleOrderMaxContractsThresholdStateMessage'
    48:
      id: 'risk_settings_query_done_message'
      doc: 'RiskSettingsQueryDoneMessage'
    49:
      id: 'risk_settings_query_rej_message'
      doc: 'RiskSettingsQueryRejMessage'
    50:
      id: 'manual_cp_breach_trigger_rej_message'
      doc: 'ManualCPBreachTriggerRejMessage'
    51:
      id: 'breach_clear_rej_message'
      doc: 'BreachClearRejMessage'
    52:
      id: 'breach_cleared_message'
      doc: 'BreachClearedMessage'
    60:
      id: 'cp_gross_notional_threshold_state_message'
      doc: 'CPGrossNotionalThresholdStateMessage'
    61:
      id: 'cp_market_order_gross_notional_threshold_state_message'
      doc: 'CPMarketOrderGrossNotionalThresholdStateMessage'
    62:
      id: 'cp_net_notional_threshold_state_message'
      doc: 'CPNetNotionalThresholdStateMessage'
    63:
      id: 'cp_market_order_net_notional_threshold_state_message'
      doc: 'CPMarketOrderNetNotionalThresholdStateMessage'
    64:
      id: 'cp_duplicate_order_threshold_state_message'
      doc: 'CPDuplicateOrderThresholdStateMessage'
    65:
      id: 'cp_order_rate_threshold_state_message'
      doc: 'CPOrderRateThresholdStateMessage'
  send_cancels:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  allow_iso_orders:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  allow_orders:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  use_order_price_in_dup_check_optional:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  supported_request_mode:
    0x53:
      id: 'stream'
      doc: 'Stream Mode'
    0x52:
      id: 'replay'
      doc: 'Replay Mode'
    0x54:
      id: 'snapshot_mode'
      doc: 'Snapshot Mode'
  login_reject_code:
    0x54:
      id: 'malformed_token'
      doc: 'Malformed Token'
    0x55:
      id: 'token_type_unsupported'
      doc: 'Token type unsupported by this server'
    0x56:
      id: 'token_type_invalid'
      doc: 'Token type invalid on any server'
    0x41:
      id: 'authorization_failed'
      doc: 'Authorization failed'
  replay_reject_code:
    0x52:
      id: 'replay_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x41:
      id: 'replay_all_requests_are_not_allowed'
      doc: 'Replay all requests are not allowed by this server'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  stream_reject_code:
    0x52:
      id: 'stream_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server. Must use replay requests to receive data'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session ID on the request is not the active session'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'Start sequence number out of range'
  reject_reason:
    0:
      id: 'other'
      doc: 'Other'
    1:
      id: 'missing_cl_ord_id'
      doc: 'MissingClOrdID'
    2:
      id: 'invalid_cl_ord_id'
      doc: 'InvalidClOrdID'
    3:
      id: 'duplicate_cl_ord_id'
      doc: 'DuplicateClOrdID'
    4:
      id: 'missing_time_period'
      doc: 'MissingTimePeriod'
    5:
      id: 'invalid_time_period'
      doc: 'InvalidTimePeriod'
    6:
      id: 'missing_risk_group_id'
      doc: 'MissingRiskGroupID'
    7:
      id: 'invalid_risk_group_id'
      doc: 'InvalidRiskGroupID'
    8:
      id: 'missing_underlier'
      doc: 'MissingUnderlier'
    9:
      id: 'invalid_underlier'
      doc: 'InvalidUnderlier'
    10:
      id: 'missing_efid'
      doc: 'MissingEFID'
    11:
      id: 'invalid_efid'
      doc: 'InvalidEFID'
    12:
      id: 'missing_threshold'
      doc: 'MissingThreshold'
    13:
      id: 'invalid_threshold'
      doc: 'InvalidThreshold'
    14:
      id: 'missing_quantity'
      doc: 'MissingQuantity'
    15:
      id: 'invalid_quantity'
      doc: 'InvalidQuantity'
    16:
      id: 'missing_breach_id'
      doc: 'MissingBreachID'
    17:
      id: 'invalid_breach_id'
      doc: 'InvalidBreachID'
    18:
      id: 'missing_volume'
      doc: 'MissingVolume'
    19:
      id: 'invalid_volume'
      doc: 'InvalidVolume'
    20:
      id: 'missing_period_in_milli_seconds'
      doc: 'MissingPeriodInMilliSeconds'
    21:
      id: 'invalid_period_in_milli_seconds'
      doc: 'InvalidPeriodInMilliSeconds'
    22:
      id: 'missing_price_in_dollars'
      doc: 'MissingPriceInDollars'
    23:
      id: 'invalid_price_in_dollars'
      doc: 'InvalidPriceInDollars'
    24:
      id: 'missing_total_executions'
      doc: 'MissingTotalExecutions'
    25:
      id: 'invalid_total_executions'
      doc: 'InvalidTotalExecutions'
    26:
      id: 'missing_percent'
      doc: 'MissingPercent'
    27:
      id: 'invalid_percent'
      doc: 'InvalidPercent'
    28:
      id: 'missing_count'
      doc: 'MissingCount'
    29:
      id: 'invalid_count'
      doc: 'InvalidCount'
    30:
      id: 'missing_allow_iso_orders'
      doc: 'MissingAllowISOOrders'
    31:
      id: 'invalid_allow_iso_orders'
      doc: 'InvalidAllowISOOrders'
    32:
      id: 'missing_allow_orders'
      doc: 'MissingAllowOrders'
    33:
      id: 'invalid_allow_orders'
      doc: 'InvalidAllowOrders'
    34:
      id: 'missing_max_notional_in_dollars'
      doc: 'MissingMaxNotionalInDollars'
    35:
      id: 'invalid_max_notional_in_dollars'
      doc: 'InvalidMaxNotionalInDollars'
    36:
      id: 'missing_max_contracts'
      doc: 'MissingMaxContracts'
    37:
      id: 'invalid_max_contracts'
      doc: 'InvalidMaxContracts'
    38:
      id: 'over_confirm'
      doc: 'OverConfirm'
    39:
      id: 'invalid_risk_combination'
      doc: 'InvalidRiskCombination'
    40:
      id: 'unknown_risk_rule'
      doc: 'UnknownRiskRule'
    41:
      id: 'missing_max_dup_orders'
      doc: 'MissingMaxDupOrders'
    42:
      id: 'invalid_max_dup_orders'
      doc: 'InvalidMaxDupOrders'
    43:
      id: 'missing_max_order_msgs'
      doc: 'MissingMaxOrderMsgs'
    44:
      id: 'invalid_max_order_msgs'
      doc: 'InvalidMaxOrderMsgs'
    45:
      id: 'breach_in_progress'
      doc: 'BreachInProgress'
    46:
      id: 'number_of_breaches_forbid_clearing'
      doc: 'NumberOfBreachesForbidClearing'
    47:
      id: 'no_active_breaches'
      doc: 'NoActiveBreaches'
    100:
      id: 'exchange_closed'
      doc: 'ExchangeClosed'
    65535:
      id: 'null_value'
      doc: 'NullValue'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  risk_type:
    1:
      id: 'contract_volume'
      doc: 'ContractVolume'
    2:
      id: 'notional_executed'
      doc: 'NotionalExecuted'
    3:
      id: 'total_trades_executed'
      doc: 'TotalTradesExecuted'
    4:
      id: 'percent_executed'
      doc: 'PercentExecuted'
    5:
      id: 'number_of_breaches'
      doc: 'NumberOfBreaches'
    6:
      id: 'allow_iso_orders'
      doc: 'AllowISOOrders'
    7:
      id: 'allow_orders_in_crossed_market'
      doc: 'AllowOrdersInCrossedMarket'
    8:
      id: 'max_notional'
      doc: 'MaxNotional'
    9:
      id: 'max_contracts'
      doc: 'MaxContracts'
    10:
      id: 'gross_notional'
      doc: 'GrossNotional'
    11:
      id: 'market_order_gross_notional'
      doc: 'MarketOrderGrossNotional'
    12:
      id: 'net_notional'
      doc: 'NetNotional'
    13:
      id: 'market_order_net_notional'
      doc: 'MarketOrderNetNotional'
    14:
      id: 'duplicate_order'
      doc: 'DuplicateOrder'
    15:
      id: 'order_rate'
      doc: 'OrderRate'
    254:
      id: 'triggered_breach'
      doc: 'TriggeredBreach'
  rule_type:
    1:
      id: 'contract_volume'
      doc: 'ContractVolume'
    2:
      id: 'notional_executed'
      doc: 'NotionalExecuted'
    3:
      id: 'total_trades_executed'
      doc: 'TotalTradesExecuted'
    4:
      id: 'percent_executed'
      doc: 'PercentExecuted'
    5:
      id: 'number_of_breaches'
      doc: 'NumberOfBreaches'
    6:
      id: 'allow_iso_orders'
      doc: 'AllowISOOrders'
    7:
      id: 'allow_orders_in_crossed_market'
      doc: 'AllowOrdersInCrossedMarket'
    8:
      id: 'max_notional'
      doc: 'MaxNotional'
    9:
      id: 'max_contracts'
      doc: 'MaxContracts'
    10:
      id: 'gross_notional'
      doc: 'GrossNotional'
    11:
      id: 'market_order_gross_notional'
      doc: 'MarketOrderGrossNotional'
    12:
      id: 'net_notional'
      doc: 'NetNotional'
    13:
      id: 'market_order_net_notional'
      doc: 'MarketOrderNetNotional'
    14:
      id: 'duplicate_order'
      doc: 'DuplicateOrder'
    15:
      id: 'order_rate'
      doc: 'OrderRate'
    254:
      id: 'triggered_breach'
      doc: 'TriggeredBreach'
  use_order_price_in_dup_check:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'

