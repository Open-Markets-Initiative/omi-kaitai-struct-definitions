# ---------------------------------------------------------------------
# Kaitai struct definition for: B3 B3Derivatives BinaryEntryPoint Sbe v8.3
#
# Protocol:
#   Organization: Brasil, Bolsa, Balcão
#   Protocol: Binary Entry Point
#   Encoding: Simple Binary Encoding
#   Version: 8.3
#   Date: 2/20/2025
#   Specification: BinaryEntryPoint-MessageReference-8.3.3-enUS.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: b3_b3derivatives_binaryentrypoint_sbe_v8_3
  title: B3 B3Derivatives BinaryEntryPoint Sbe v8.3
  license: GPL-3.0
  endian: le

doc: 'Brasil, Bolsa, Balcão B3 Derivatives Binary Entry Point Sbe v8.3'
doc-ref: https://www.b3.com.br/en_us/solutions/platforms/puma-trading-system/for-developers-and-vendors/entrypoint

seq:
  - id: simple_open_frame
    type: simple_open_frame_struct
    repeat: eos
    doc: 'Simple Open Frame'

types:
  simple_open_frame_struct:
    seq:
      - id: simple_open_framing_header
        type: simple_open_framing_header
        doc: 'Simple Open Framing Header'
      - id: message_header
        type: message_header
        doc: 'B3 Sbe message header — message identifiers and length of message root'
      - id: payload
        size: simple_open_framing_header.message_length - 12
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::negotiate_message': negotiate_message
            'template_id::negotiate_response_message': negotiate_response_message
            'template_id::negotiate_reject_message': negotiate_reject_message
            'template_id::establish_message': establish_message
            'template_id::establish_ack_message': establish_ack_message
            'template_id::establish_reject_message': establish_reject_message
            'template_id::terminate_message': terminate_message
            'template_id::not_applied_message': not_applied_message
            'template_id::sequence_message': sequence_message
            'template_id::retransmit_request_message': retransmit_request_message
            'template_id::retransmission_message': retransmission_message
            'template_id::retransmit_reject_message': retransmit_reject_message
            'template_id::simple_new_order_message': simple_new_order_message
            'template_id::simple_modify_order_message': simple_modify_order_message
            'template_id::new_order_single_message': new_order_single_message
            'template_id::order_cancel_replace_request_message': order_cancel_replace_request_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::new_order_cross_message': new_order_cross_message
            'template_id::execution_report_new_message': execution_report_new_message
            'template_id::execution_report_modify_message': execution_report_modify_message
            'template_id::execution_report_cancel_message': execution_report_cancel_message
            'template_id::execution_report_trade_message': execution_report_trade_message
            'template_id::execution_report_reject_message': execution_report_reject_message
            'template_id::execution_report_forward_message': execution_report_forward_message
            'template_id::business_message_reject_message': business_message_reject_message
            'template_id::security_definition_request_message': security_definition_request_message
            'template_id::security_definition_response_message': security_definition_response_message
            'template_id::quote_request_message': quote_request_message
            'template_id::quote_status_report_message': quote_status_report_message
            'template_id::quote_message': quote_message
            'template_id::quote_cancel_message': quote_cancel_message
            'template_id::quote_request_reject_message': quote_request_reject_message
            'template_id::position_maintenance_cancel_request_message': position_maintenance_cancel_request_message
            'template_id::position_maintenance_request_message': position_maintenance_request_message
            'template_id::position_maintenance_report_message': position_maintenance_report_message
            'template_id::allocation_instruction_message': allocation_instruction_message
            'template_id::allocation_report_message': allocation_report_message
            'template_id::order_mass_action_request_message': order_mass_action_request_message
            'template_id::order_mass_action_report_message': order_mass_action_report_message
  simple_open_framing_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Overall message length including framing and SBE headers'
      - id: encoding_type
        type: u2
        doc: 'Identifier of the encoding used in the message payload'
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
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
  negotiate_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: timestamp
        type: u8
        doc: 'timestamp'
      - id: entering_firm
        type: u4
        doc: 'enteringFirm'
      - id: onbehalf_firm
        type: u4
        doc: 'onbehalfFirm'
      - id: credentials
        type: credentials
        doc: 'credentials data struct'
      - id: client_ip
        type: client_ip
        doc: 'clientIP data struct'
      - id: client_app_name
        type: client_app_name
        doc: 'clientAppName data struct'
      - id: client_app_version
        type: client_app_version
        doc: 'clientAppVersion data struct'
  credentials:
    seq:
      - id: len_credentials_data
        type: u1
        doc: 'Length of credentials data'
      - id: credentials_data
        type: str
        size: len_credentials_data
        encoding: ASCII
        doc: 'Credentials data in ASCII'
  client_ip:
    seq:
      - id: len_client_ip_data
        type: u1
        doc: 'Length of client system information'
      - id: client_ip_data
        type: str
        size: len_client_ip_data
        encoding: ASCII
        doc: 'Client system information'
  client_app_name:
    seq:
      - id: len_client_app_name_data
        type: u1
        doc: 'Length of client system information'
      - id: client_app_name_data
        type: str
        size: len_client_app_name_data
        encoding: ASCII
        doc: 'Client system information'
  client_app_version:
    seq:
      - id: len_client_app_version_data
        type: u1
        doc: 'Length of client system information'
      - id: client_app_version_data
        type: str
        size: len_client_app_version_data
        encoding: ASCII
        doc: 'Client system information'
  negotiate_response_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: entering_firm
        type: u4
        doc: 'enteringFirm'
      - id: semantic_version
        type: semantic_version
        doc: 'NegotiateResponseMessage'
  semantic_version:
    seq:
      - id: major_number
        type: u1
        doc: 'majorNumber'
      - id: minor_number
        type: u1
        doc: 'minorNumber'
      - id: patch_number
        type: u1
        doc: 'patchNumber'
      - id: build_number
        type: u1
        doc: 'buildNumber'
  negotiate_reject_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: entering_firm_optional
        type: u4
        doc: 'enteringFirm'
      - id: negotiation_reject_code
        type: u1
        enum: negotiation_reject_code
        doc: 'negotiationRejectCode'
      - id: offset_25_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: current_session_ver_id
        type: u8
        doc: 'currentSessionVerID'
  establish_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: timestamp
        type: u8
        doc: 'timestamp'
      - id: keep_alive_interval
        type: u8
        doc: 'keepAliveInterval'
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
      - id: cancel_on_disconnect_type
        type: u1
        enum: cancel_on_disconnect_type
        doc: 'cancelOnDisconnectType'
      - id: offset_33_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: cod_timeout_window
        type: u8
        doc: 'codTimeoutWindow'
      - id: credentials
        type: credentials
        doc: 'credentials data struct'
  establish_ack_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: keep_alive_interval
        type: u8
        doc: 'keepAliveInterval'
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
      - id: last_incoming_seq_no
        type: u4
        doc: 'lastIncomingSeqNo'
  establish_reject_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: establishment_reject_code
        type: u1
        enum: establishment_reject_code
        doc: 'establishmentRejectCode'
      - id: offset_21_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: last_incoming_seq_no_optional
        type: u4
        doc: 'lastIncomingSeqNo'
  terminate_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: session_ver_id
        type: u8
        doc: 'sessionVerID'
      - id: termination_code
        type: u1
        enum: termination_code
        doc: 'terminationCode'
  not_applied_message:
    seq:
      - id: from_seq_no
        type: u4
        doc: 'fromSeqNo'
      - id: count
        type: u4
        doc: 'count'
  sequence_message:
    seq:
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
  retransmit_request_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: timestamp
        type: u8
        doc: 'timestamp'
      - id: from_seq_no
        type: u4
        doc: 'fromSeqNo'
      - id: count
        type: u4
        doc: 'count'
  retransmission_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
      - id: count
        type: u4
        doc: 'count'
  retransmit_reject_message:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: request_timestamp
        type: u8
        doc: 'requestTimestamp'
      - id: retransmit_reject_code
        type: u1
        enum: retransmit_reject_code
        doc: 'retransmitRejectCode'
  simple_new_order_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: mm_protection_reset_boolean
        type: u1
        enum: mm_protection_reset_boolean
        doc: 'mmProtectionReset'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: self_trade_prevention_instruction
        type: u1
        enum: self_trade_prevention_instruction
        doc: 'selfTradePreventionInstruction'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: simple_ordtype
        type: u1
        enum: simple_ordtype
        doc: 'ordType'
      - id: time_in_force_simple
        type: u1
        enum: time_in_force_simple
        doc: 'timeInForce'
      - id: routing_instruction
        type: u1_nullable
        doc: 'routingInstruction. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: memo
        type: memo
        doc: 'memo data struct'
  inbound_business_header:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'sendingTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: market_segment_id
        type: u1
        doc: 'marketSegmentID'
      - id: padding
        type: str
        size: 1
        encoding: ASCII
        doc: 'padding'
  investor_id:
    seq:
      - id: prefix
        type: u2
        doc: 'prefix'
      - id: document
        type: u4
        doc: 'document'
  memo:
    seq:
      - id: len_memo_data
        type: u1
        doc: 'Length of free format text field defined by client'
      - id: memo_data
        type: str
        size: len_memo_data
        encoding: ASCII
        doc: 'Free ASCII format text field defined by client'
  simple_modify_order_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: mm_protection_reset_boolean
        type: u1
        enum: mm_protection_reset_boolean
        doc: 'mmProtectionReset'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: self_trade_prevention_instruction
        type: u1
        enum: self_trade_prevention_instruction
        doc: 'selfTradePreventionInstruction'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: simple_ordtype
        type: u1
        enum: simple_ordtype
        doc: 'ordType'
      - id: time_in_force_simple
        type: u1
        enum: time_in_force_simple
        doc: 'timeInForce'
      - id: routing_instruction
        type: u1_nullable
        doc: 'routingInstruction. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: order_id_optional
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: memo
        type: memo
        doc: 'memo data struct'
  new_order_single_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: mm_protection_reset_boolean
        type: u1
        enum: mm_protection_reset_boolean
        doc: 'mmProtectionReset'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: self_trade_prevention_instruction
        type: u1
        enum: self_trade_prevention_instruction
        doc: 'selfTradePreventionInstruction'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: routing_instruction
        type: u1_nullable
        doc: 'routingInstruction. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: executing_trader_optional
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: custodian_info
        type: custodian_info
        doc: 'NewOrderSingleMessage'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  custodian_info:
    seq:
      - id: custodian
        type: u4
        doc: 'custodian'
      - id: custody_account
        type: u4
        doc: 'custodyAccount'
      - id: custody_allocation_type
        type: u4
        doc: 'custodyAllocationType'
  desk_id:
    seq:
      - id: len_desk_id_data
        type: u1
        doc: 'Length of trading desk identification'
      - id: desk_id_data
        type: str
        size: len_desk_id_data
        encoding: ASCII
        doc: 'Trading desk identification in ASCII format'
  order_cancel_replace_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: mm_protection_reset_boolean
        type: u1
        enum: mm_protection_reset_boolean
        doc: 'mmProtectionReset'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: self_trade_prevention_instruction
        type: u1
        enum: self_trade_prevention_instruction
        doc: 'selfTradePreventionInstruction'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force_optional
        type: u1
        enum: time_in_force_optional
        doc: 'timeInForce. Nullable, No Value = 0'
      - id: routing_instruction
        type: u1_nullable
        doc: 'routingInstruction. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: order_id_optional
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: executing_trader_optional
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: account_type
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 0'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: custodian_info
        type: custodian_info
        doc: 'NewOrderSingleMessage'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  order_cancel_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: offset_18_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: order_id_optional
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: single_cancel_restatement_reason
        type: u1_nullable
        doc: 'execRestatementReason. Nullable, No Value = 0'
      - id: offset_54_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader_optional
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  new_order_cross_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: offset_18_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: crossid
        type: u8
        doc: 'crossID'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader_optional
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price
        type: decimal_s8_4
        doc: 'price. Implied decimal with scale 1e-4'
      - id: crossed_indicator
        type: u2_nullable
        doc: 'crossedIndicator. Nullable, No Value = 0'
      - id: cross_type
        type: u1_nullable
        doc: 'crossType. Nullable, No Value = 0'
      - id: cross_prioritization
        type: u1_nullable
        doc: 'crossPrioritization. Nullable, No Value = 255'
      - id: max_sweep_qty
        type: u8_nullable
        doc: 'maxSweepQty. Nullable, No Value = 0'
      - id: cross_sides_groups
        type: cross_sides_groups
        doc: 'noSides Block'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  cross_sides_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: cross_sides_group
        type: cross_sides_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noSides'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  cross_sides_group:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: offset_1_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: account
        type: u4
        doc: 'account'
      - id: entering_firm_optional
        type: u4
        doc: 'enteringFirm'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
  execution_report_new_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'ordStatus'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: account
        type: u4
        doc: 'account'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: market_segment_received_time
        type: nanosecond_timestamp_nullable
        doc: 'marketSegmentReceivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: protection_price
        type: decimal_s8_4_nullable
        doc: 'protectionPrice. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: working_indicator
        type: u1
        enum: working_indicator
        doc: 'workingIndicator'
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
        doc: 'multiLegReportingType. Nullable, No Value = 0'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: crossid_optional
        type: u8
        doc: 'crossID'
      - id: received_time
        type: nanosecond_timestamp_nullable
        doc: 'receivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: offset_152_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: ordtagid_optional
        type: u1_nullable
        doc: 'ordTagID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: cross_type
        type: u1_nullable
        doc: 'crossType. Nullable, No Value = 0'
      - id: cross_prioritization
        type: u1_nullable
        doc: 'crossPrioritization. Nullable, No Value = 255'
      - id: mm_protection_reset_boolean_optional
        type: u1_nullable
        doc: 'mmProtectionReset. Nullable, No Value = 255'
      - id: offset_165_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  outbound_business_header:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'sendingTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: event_indicator
        type: u1
        doc: 'eventIndicator'
      - id: market_segment_id_optional
        type: u1
        doc: 'marketSegmentID'
  execution_report_modify_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'ordStatus'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: account
        type: u4
        doc: 'account'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: cum_qty
        type: u8
        doc: 'cumQty'
      - id: market_segment_received_time
        type: nanosecond_timestamp_nullable
        doc: 'marketSegmentReceivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: protection_price
        type: decimal_s8_4_nullable
        doc: 'protectionPrice. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: working_indicator
        type: u1
        enum: working_indicator
        doc: 'workingIndicator'
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
        doc: 'multiLegReportingType. Nullable, No Value = 0'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: received_time
        type: nanosecond_timestamp_nullable
        doc: 'receivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: offset_168_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: ordtagid_optional
        type: u1_nullable
        doc: 'ordTagID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: mm_protection_reset_boolean_optional
        type: u1_nullable
        doc: 'mmProtectionReset. Nullable, No Value = 255'
      - id: offset_179_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  execution_report_cancel_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'ordStatus'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: cum_qty
        type: u8
        doc: 'cumQty'
      - id: account
        type: u4
        doc: 'account'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: market_segment_received_time
        type: nanosecond_timestamp_nullable
        doc: 'marketSegmentReceivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: working_indicator
        type: u1
        enum: working_indicator
        doc: 'workingIndicator'
      - id: exec_restatement_reason
        type: u1_nullable
        doc: 'execRestatementReason. Nullable, No Value = 0'
      - id: offset_100_padding_4
        size: 4
        doc: '4 bytes padding'
      - id: mass_action_report_id_optional
        type: u8
        doc: 'massActionReportID'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: received_time
        type: nanosecond_timestamp_nullable
        doc: 'receivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: offset_164_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: ordtagid_optional
        type: u1_nullable
        doc: 'ordTagID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: action_requested_from_session_id
        type: u4
        doc: 'actionRequestedFromSessionID'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  execution_report_trade_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'ordStatus'
      - id: clordid_optional
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: account
        type: u4
        doc: 'account'
      - id: last_qty
        type: u8
        doc: 'lastQty'
      - id: last_px
        type: decimal_s8_4
        doc: 'lastPx. Implied decimal with scale 1e-4'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: cum_qty
        type: u8
        doc: 'cumQty'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'aggressorIndicator'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'execType'
      - id: order_category
        type: u1
        enum: order_category
        doc: 'orderCategory. Nullable, No Value = 0'
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
        doc: 'multiLegReportingType. Nullable, No Value = 0'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: contra_broker
        type: u4
        doc: 'contraBroker'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: tot_no_related_sym
        type: u1
        doc: 'totNoRelatedSym'
      - id: offset_119_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: secondary_exec_id
        type: u8
        doc: 'secondaryExecID'
      - id: exec_ref_id
        type: u8
        doc: 'execRefID'
      - id: crossid_optional
        type: u8
        doc: 'crossID'
      - id: crossed_indicator
        type: u2_nullable
        doc: 'crossedIndicator. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: trading_session_id
        type: u1_nullable
        doc: 'tradingSessionID. Nullable, No Value = 0'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'tradingSessionSubID. Nullable, No Value = 0'
      - id: security_trading_status
        type: u1_nullable
        doc: 'securityTradingStatus. Nullable, No Value = 0'
      - id: cross_type
        type: u1_nullable
        doc: 'crossType. Nullable, No Value = 0'
      - id: cross_prioritization
        type: u1_nullable
        doc: 'crossPrioritization. Nullable, No Value = 255'
      - id: offset_159_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: implied_event_id
        type: implied_event_id
        doc: 'ExecutionReport_TradeMessage'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  implied_event_id:
    seq:
      - id: event_id
        type: u4
        doc: 'eventID'
      - id: no_related_trades
        type: u2
        doc: 'noRelatedTrades'
  execution_report_reject_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: cxl_rej_response_to
        type: u1
        enum: cxl_rej_response_to
        doc: 'cxlRejResponseTo'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id_optional
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: ord_rej_reason
        type: u4
        enum: ord_rej_reason
        doc: 'ordRejReason'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: order_id_optional
        type: u8
        doc: 'orderID'
      - id: origclordid
        type: u8
        doc: 'origClOrdID'
      - id: account
        type: u4
        doc: 'account'
      - id: ordtype
        type: u1
        enum: ordtype
        doc: 'ordType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: expire_date
        type: u2
        doc: 'expireDate'
      - id: order_qty_optional
        type: u8
        doc: 'orderQty'
      - id: price_optional
        type: decimal_s8_4_nullable
        doc: 'price. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: stop_px
        type: decimal_s8_4_nullable
        doc: 'stopPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: min_qty
        type: u8
        doc: 'minQty'
      - id: max_floor
        type: u8
        doc: 'maxFloor'
      - id: crossid_optional
        type: u8
        doc: 'crossID'
      - id: crossed_indicator
        type: u2_nullable
        doc: 'crossedIndicator. Nullable, No Value = 0'
      - id: received_time
        type: nanosecond_timestamp_nullable
        doc: 'receivedTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: offset_146_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: ordtagid_optional
        type: u1_nullable
        doc: 'ordTagID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: strategy_id
        type: s4_nullable
        doc: 'strategyID. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
      - id: text
        type: text
        doc: 'text data struct'
  text:
    seq:
      - id: len_text_data
        type: u1
        doc: 'Length of free format text string generated by exchange'
      - id: text_data
        type: str
        size: len_text_data
        encoding: ASCII
        doc: 'Free ASCII format text string generated by exchange'
  execution_report_forward_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'ordStatus'
      - id: clordid_optional
        type: u8
        doc: 'clOrdID'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: account
        type: u4
        doc: 'account'
      - id: last_qty
        type: u8
        doc: 'lastQty'
      - id: last_px
        type: decimal_s8_4
        doc: 'lastPx. Implied decimal with scale 1e-4'
      - id: exec_id
        type: u8
        doc: 'execID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: cum_qty
        type: u8
        doc: 'cumQty'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: contra_broker
        type: u4
        doc: 'contraBroker'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: aggressor_indicator
        type: u1
        enum: aggressor_indicator
        doc: 'aggressorIndicator'
      - id: settltype_optional
        type: u1
        enum: settltype_optional
        doc: 'settlType. Nullable, No Value = 0'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: days_to_settlement_optional
        type: u2
        doc: 'daysToSettlement'
      - id: offset_118_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: secondary_exec_id
        type: u8
        doc: 'secondaryExecID'
      - id: exec_ref_id
        type: u8
        doc: 'execRefID'
      - id: fixed_rate_percentage_8_optional
        type: decimal_s8_8_nullable
        doc: 'fixedRate. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: trading_session_id
        type: u1_nullable
        doc: 'tradingSessionID. Nullable, No Value = 0'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'tradingSessionSubID. Nullable, No Value = 0'
      - id: security_trading_status
        type: u1_nullable
        doc: 'securityTradingStatus. Nullable, No Value = 0'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  business_message_reject_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: ref_msg_type
        type: u1
        enum: ref_msg_type
        doc: 'refMsgType'
      - id: offset_19_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: ref_seq_num
        type: u4
        doc: 'refSeqNum'
      - id: business_reject_ref_id
        type: u8
        doc: 'businessRejectRefID'
      - id: business_reject_reason
        type: u4
        doc: 'businessRejectReason'
      - id: memo
        type: memo
        doc: 'memo data struct'
      - id: text
        type: text
        doc: 'text data struct'
  security_definition_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: security_req_id
        type: u8
        doc: 'securityReqID'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: legs_groups
        type: legs_groups
        doc: 'noLegs Block'
  legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: legs_group
        type: legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noLegs'
  legs_group:
    seq:
      - id: leg_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Multileg instrument''s individual security’s Symbol. See Symbol (55) field for description'
      - id: leg_ratio_qty
        type: decimal_s8_7
        doc: 'The ratio of quantity for this individual leg relative to the entire multileg security. Implied decimal with scale 1e-7'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg (multileg security). See Side (54) field for description and values. Nullable, No Value = 0'
      - id: padding_1
        size: 1
        doc: '1 bytes padding'
  security_definition_response_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: offset_18_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: security_req_id
        type: u8
        doc: 'securityReqID'
      - id: security_id_optional
        type: u8_nullable
        doc: 'securityID. Nullable, No Value = 0'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'securityResponseType'
      - id: security_strategy_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityStrategyType'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'symbol'
      - id: security_response_id
        type: u8
        doc: 'securityResponseID'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
  quote_request_message:
    seq:
      - id: bidirectional_business_header
        type: bidirectional_business_header
        doc: 'BidirectionalBusinessHeader'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: quote_id_optional
        type: u8
        doc: 'quoteID'
      - id: trade_id_optional
        type: u4
        doc: 'tradeID'
      - id: contra_broker
        type: u4
        doc: 'contraBroker'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: price_8
        type: decimal_s8_8
        doc: 'price. Implied decimal with scale 1e-8'
      - id: settltype
        type: u1
        enum: settltype
        doc: 'settlType'
      - id: execute_underlying_trade
        type: u1
        enum: execute_underlying_trade
        doc: 'executeUnderlyingTrade. Nullable, No Value = 0'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: fixed_rate_percentage_8
        type: decimal_s8_8
        doc: 'fixedRate. Implied decimal with scale 1e-8'
      - id: days_to_settlement
        type: u2
        doc: 'daysToSettlement'
      - id: sides_groups
        type: sides_groups
        doc: 'noSides Block'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  bidirectional_business_header:
    seq:
      - id: session_id
        type: u4
        doc: 'sessionID'
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'sendingTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: event_indicator
        type: u1
        doc: 'eventIndicator'
      - id: market_segment_id_optional
        type: u1
        doc: 'marketSegmentID'
      - id: padding
        type: str
        size: 1
        encoding: ASCII
        doc: 'padding'
  sides_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: sides_group
        type: sides_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noSides'
  sides_group:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: account
        type: u4
        doc: 'account'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
  quote_status_report_message:
    seq:
      - id: bidirectional_business_header
        type: bidirectional_business_header
        doc: 'BidirectionalBusinessHeader'
      - id: quote_reject_reason
        type: u4
        enum: quote_reject_reason
        doc: 'quoteRejectReason'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: quote_id
        type: u8
        doc: 'quoteID'
      - id: trade_id_optional
        type: u4
        doc: 'tradeID'
      - id: contra_broker
        type: u4
        doc: 'contraBroker'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: quote_status
        type: u1
        enum: quote_status
        doc: 'quoteStatus'
      - id: quote_status_response_to
        type: u1
        enum: quote_status_response_to
        doc: 'quoteStatusResponseTo. Nullable, No Value = 0'
      - id: account
        type: u4
        doc: 'account'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'side. Nullable, No Value = 0'
      - id: settltype_optional
        type: u1
        enum: settltype_optional
        doc: 'settlType. Nullable, No Value = 0'
      - id: price_8_optional
        type: decimal_s8_8_nullable
        doc: 'price. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: fixed_rate_percentage_8_optional
        type: decimal_s8_8_nullable
        doc: 'fixedRate. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: execute_underlying_trade
        type: u1
        enum: execute_underlying_trade
        doc: 'executeUnderlyingTrade. Nullable, No Value = 0'
      - id: days_to_settlement_optional
        type: u2
        doc: 'daysToSettlement'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
      - id: text
        type: text
        doc: 'text data struct'
  quote_message:
    seq:
      - id: bidirectional_business_header
        type: bidirectional_business_header
        doc: 'BidirectionalBusinessHeader'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: quote_id
        type: u8
        doc: 'quoteID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: price_8_optional
        type: decimal_s8_8_nullable
        doc: 'price. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: settltype
        type: u1
        enum: settltype
        doc: 'settlType'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: fixed_rate_percentage_8
        type: decimal_s8_8
        doc: 'fixedRate. Implied decimal with scale 1e-8'
      - id: execute_underlying_trade
        type: u1
        enum: execute_underlying_trade
        doc: 'executeUnderlyingTrade. Nullable, No Value = 0'
      - id: days_to_settlement
        type: u2
        doc: 'daysToSettlement'
      - id: trading_sub_account
        type: u4_nullable
        doc: 'tradingSubAccount. Nullable, No Value = 0'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  quote_cancel_message:
    seq:
      - id: bidirectional_business_header
        type: bidirectional_business_header
        doc: 'BidirectionalBusinessHeader'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: quote_req_id_optional
        type: u8
        doc: 'quoteReqID'
      - id: quote_id_optional
        type: u8
        doc: 'quoteID'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: executing_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  quote_request_reject_message:
    seq:
      - id: bidirectional_business_header
        type: bidirectional_business_header
        doc: 'BidirectionalBusinessHeader'
      - id: quote_request_reject_reason
        type: u4
        doc: 'quoteRequestRejectReason'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: quote_id_optional
        type: u8
        doc: 'quoteID'
      - id: trade_id_optional
        type: u4
        doc: 'tradeID'
      - id: contra_broker
        type: u4
        doc: 'contraBroker'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: settltype_optional
        type: u1
        enum: settltype_optional
        doc: 'settlType. Nullable, No Value = 0'
      - id: price_8_optional
        type: decimal_s8_8_nullable
        doc: 'price. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: order_qty_optional
        type: u8
        doc: 'orderQty'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: executing_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'executingTrader'
      - id: fixed_rate_percentage_8_optional
        type: decimal_s8_8_nullable
        doc: 'fixedRate. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: days_to_settlement_optional
        type: u2
        doc: 'daysToSettlement'
      - id: sides_groups
        type: sides_groups
        doc: 'noSides Block'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
      - id: text
        type: text
        doc: 'text data struct'
  position_maintenance_cancel_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: pos_req_id
        type: u8
        doc: 'posReqID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: orig_pos_req_ref_id
        type: u8
        doc: 'origPosReqRefID'
      - id: pos_maint_rpt_ref_id
        type: u8
        doc: 'posMaintRptRefID'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
  position_maintenance_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: pos_req_id
        type: u8
        doc: 'posReqID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: threshold_amount
        type: decimal_s8_4_nullable
        doc: 'thresholdAmount. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: pos_trans_type
        type: u1
        enum: pos_trans_type
        doc: 'posTransType'
      - id: clearing_business_date
        type: u2
        doc: 'clearingBusinessDate'
      - id: contrary_instruction_indicator
        type: u1
        enum: contrary_instruction_indicator
        doc: 'contraryInstructionIndicator'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: long_qty
        type: u8
        doc: 'longQty'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  position_maintenance_report_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: pos_req_id_optional
        type: u8
        doc: 'posReqID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: pos_maint_rpt_id
        type: u8
        doc: 'posMaintRptID'
      - id: pos_trans_type
        type: u1
        enum: pos_trans_type
        doc: 'posTransType'
      - id: pos_maint_action
        type: u1
        enum: pos_maint_action
        doc: 'posMaintAction'
      - id: pos_maint_status
        type: u1
        enum: pos_maint_status
        doc: 'posMaintStatus'
      - id: trade_id_optional
        type: u4
        doc: 'tradeID'
      - id: orig_pos_req_ref_id
        type: u8
        doc: 'origPosReqRefID'
      - id: account_type
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 0'
      - id: clearing_business_date
        type: u2
        doc: 'clearingBusinessDate'
      - id: threshold_amount
        type: decimal_s8_4_nullable
        doc: 'thresholdAmount. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: account
        type: u4
        doc: 'account'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: pos_maint_result
        type: u4
        doc: 'posMaintResult'
      - id: contrary_instruction_indicator
        type: u1
        enum: contrary_instruction_indicator
        doc: 'contraryInstructionIndicator'
      - id: positions_groups
        type: positions_groups
        doc: 'noPositions Block'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
      - id: text
        type: text
        doc: 'text data struct'
  positions_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: positions_group
        type: positions_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noPositions'
  positions_group:
    seq:
      - id: pos_type
        type: u1
        enum: pos_type
        doc: 'Used to identify the type of quantity'
      - id: long_qty_optional
        type: u8
        doc: 'Long Quantity'
      - id: short_qty
        type: u8
        doc: 'Short Quantity'
  allocation_instruction_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: alloc_id
        type: u8
        doc: 'allocID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: alloc_trans_type
        type: u1
        enum: alloc_trans_type
        doc: 'allocTransType'
      - id: alloc_type
        type: u1
        enum: alloc_type
        doc: 'allocType'
      - id: alloc_no_orders_type
        type: u1
        enum: alloc_no_orders_type
        doc: 'allocNoOrdersType'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: trade_date_optional
        type: u2
        doc: 'tradeDate'
      - id: individual_alloc_id
        type: u8
        doc: 'individualAllocID'
      - id: alloc_account
        type: u4
        doc: 'allocAccount'
      - id: alloc_qty
        type: u8
        doc: 'allocQty'
      - id: desk_id
        type: desk_id
        doc: 'deskID data struct'
      - id: memo
        type: memo
        doc: 'memo data struct'
  allocation_report_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: alloc_id
        type: u8
        doc: 'allocID'
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: alloc_report_id
        type: u8
        doc: 'allocReportID'
      - id: alloc_trans_type
        type: u1
        enum: alloc_trans_type
        doc: 'allocTransType'
      - id: alloc_report_type
        type: u1
        enum: alloc_report_type
        doc: 'allocReportType'
      - id: alloc_no_orders_type
        type: u1
        enum: alloc_no_orders_type
        doc: 'allocNoOrdersType'
      - id: alloc_rej_code
        type: u4
        doc: 'allocRejCode'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: alloc_status
        type: u1
        enum: alloc_status
        doc: 'allocStatus'
      - id: trade_date_optional
        type: u2
        doc: 'tradeDate'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: sender_location
        type: str
        size: 10
        encoding: ASCII
        doc: 'senderLocation'
      - id: entering_trader
        type: str
        size: 5
        encoding: ASCII
        doc: 'enteringTrader'
  order_mass_action_request_message:
    seq:
      - id: inbound_business_header
        type: inbound_business_header
        doc: 'InboundBusinessHeader'
      - id: mass_action_type
        type: u1
        enum: mass_action_type
        doc: 'massActionType'
      - id: mass_action_scope
        type: u1_nullable
        doc: 'massActionScope. Nullable, No Value = 0'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: mass_cancel_restatement_reason
        type: u1_nullable
        doc: 'execRestatementReason. Nullable, No Value = 0'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'side. Nullable, No Value = 0'
      - id: offset_31_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'asset'
      - id: security_id_optional
        type: u8_nullable
        doc: 'securityID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
  order_mass_action_report_message:
    seq:
      - id: outbound_business_header
        type: outbound_business_header
        doc: 'OutboundBusinessHeader'
      - id: mass_action_type
        type: u1
        enum: mass_action_type
        doc: 'massActionType'
      - id: mass_action_scope
        type: u1_nullable
        doc: 'massActionScope. Nullable, No Value = 0'
      - id: clordid
        type: u8
        doc: 'clOrdID'
      - id: mass_action_report_id
        type: u8
        doc: 'massActionReportID'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'transactTime. Nanoseconds since Unix epoch'
      - id: mass_action_response
        type: u1
        enum: mass_action_response
        doc: 'massActionResponse'
      - id: mass_action_reject_reason
        type: u1_nullable
        doc: 'massActionRejectReason. Nullable, No Value = 255'
      - id: mass_cancel_restatement_reason
        type: u1_nullable
        doc: 'execRestatementReason. Nullable, No Value = 0'
      - id: ordtagid
        type: u1
        doc: 'ordTagID'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'side. Nullable, No Value = 0'
      - id: offset_49_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'asset'
      - id: security_id_optional
        type: u8_nullable
        doc: 'securityID. Nullable, No Value = 0'
      - id: investor_id
        type: investor_id
        doc: 'SimpleNewOrderMessage'
      - id: text
        type: text
        doc: 'text data struct'
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
        value: value.time == 0
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_4_nullable:
    seq:
      - id: value
        type: decimal_s8_4
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s8_8_nullable:
    seq:
      - id: value
        type: decimal_s8_8
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  decimal_s8_7:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000.0

enums:
  template_id:
    1:
      id: 'negotiate_message'
      doc: 'NegotiateMessage'
    2:
      id: 'negotiate_response_message'
      doc: 'NegotiateResponseMessage'
    3:
      id: 'negotiate_reject_message'
      doc: 'NegotiateRejectMessage'
    4:
      id: 'establish_message'
      doc: 'EstablishMessage'
    5:
      id: 'establish_ack_message'
      doc: 'EstablishAckMessage'
    6:
      id: 'establish_reject_message'
      doc: 'EstablishRejectMessage'
    7:
      id: 'terminate_message'
      doc: 'TerminateMessage'
    8:
      id: 'not_applied_message'
      doc: 'NotAppliedMessage'
    9:
      id: 'sequence_message'
      doc: 'SequenceMessage'
    12:
      id: 'retransmit_request_message'
      doc: 'RetransmitRequestMessage'
    13:
      id: 'retransmission_message'
      doc: 'RetransmissionMessage'
    14:
      id: 'retransmit_reject_message'
      doc: 'RetransmitRejectMessage'
    100:
      id: 'simple_new_order_message'
      doc: 'SimpleNewOrderMessage'
    101:
      id: 'simple_modify_order_message'
      doc: 'SimpleModifyOrderMessage'
    102:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    104:
      id: 'order_cancel_replace_request_message'
      doc: 'OrderCancelReplaceRequestMessage'
    105:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    106:
      id: 'new_order_cross_message'
      doc: 'NewOrderCrossMessage'
    200:
      id: 'execution_report_new_message'
      doc: 'ExecutionReport_NewMessage'
    201:
      id: 'execution_report_modify_message'
      doc: 'ExecutionReport_ModifyMessage'
    202:
      id: 'execution_report_cancel_message'
      doc: 'ExecutionReport_CancelMessage'
    203:
      id: 'execution_report_trade_message'
      doc: 'ExecutionReport_TradeMessage'
    204:
      id: 'execution_report_reject_message'
      doc: 'ExecutionReport_RejectMessage'
    205:
      id: 'execution_report_forward_message'
      doc: 'ExecutionReport_ForwardMessage'
    206:
      id: 'business_message_reject_message'
      doc: 'BusinessMessageRejectMessage'
    300:
      id: 'security_definition_request_message'
      doc: 'SecurityDefinitionRequestMessage'
    301:
      id: 'security_definition_response_message'
      doc: 'SecurityDefinitionResponseMessage'
    401:
      id: 'quote_request_message'
      doc: 'QuoteRequestMessage'
    402:
      id: 'quote_status_report_message'
      doc: 'QuoteStatusReportMessage'
    403:
      id: 'quote_message'
      doc: 'QuoteMessage'
    404:
      id: 'quote_cancel_message'
      doc: 'QuoteCancelMessage'
    405:
      id: 'quote_request_reject_message'
      doc: 'QuoteRequestRejectMessage'
    501:
      id: 'position_maintenance_cancel_request_message'
      doc: 'PositionMaintenanceCancelRequestMessage'
    502:
      id: 'position_maintenance_request_message'
      doc: 'PositionMaintenanceRequestMessage'
    503:
      id: 'position_maintenance_report_message'
      doc: 'PositionMaintenanceReportMessage'
    601:
      id: 'allocation_instruction_message'
      doc: 'AllocationInstructionMessage'
    602:
      id: 'allocation_report_message'
      doc: 'AllocationReportMessage'
    701:
      id: 'order_mass_action_request_message'
      doc: 'OrderMassActionRequestMessage'
    702:
      id: 'order_mass_action_report_message'
      doc: 'OrderMassActionReportMessage'
  negotiation_reject_code:
    0:
      id: 'unspecified'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'credentials'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'flowtype_not_supported'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'already_negotiated'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'session_blocked'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_sessionid'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_sessionverid'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_timestamp'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_firm'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'negotiate_not_allowed'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'duplicate_session_connection'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'authentication_in_progress'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'protocol_version_not_supported'
      doc: 'NegotiationRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_on_disconnect_type:
    0:
      id: 'do_not_cancel_on_disconnect_or_terminate'
      doc: 'CancelOnDisconnectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_on_disconnect_only'
      doc: 'CancelOnDisconnectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel_on_terminate_only'
      doc: 'CancelOnDisconnectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_on_disconnect_or_terminate'
      doc: 'CancelOnDisconnectType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  establishment_reject_code:
    0:
      id: 'unspecified'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'credentials'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unnegotiated'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'already_established'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'session_blocked'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_sessionid'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_sessionverid'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_timestamp'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_keepalive_interval'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_nextseqno'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'establish_attempts_exceeded'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'establish_not_allowed'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'duplicate_session_connection'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'authentication_in_progress'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'protocol_version_not_supported'
      doc: 'EstablishRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  termination_code:
    0:
      id: 'unspecified'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'finished'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unnegotiated'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'not_established'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'session_blocked'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'negotiation_in_progress'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'establish_in_progress'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'keepalive_interval_lapsed'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_sessionid'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'invalid_sessionverid'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'invalid_timestamp'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'invalid_nextseqno'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'unrecognized_message'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'invalid_sofh'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'decoding_error'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'terminate_not_allowed'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'terminate_in_progress'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'protocol_version_not_supported'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'backup_takeover_in_progress'
      doc: 'TerminationCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  retransmit_reject_code:
    0:
      id: 'out_of_range'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'invalid_session'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'request_limit_exceeded'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retransmit_in_progress'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'invalid_timestamp'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'invalid_fromseqno'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_count'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'throttle_reject'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'system_busy'
      doc: 'RetransmitRejectCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mm_protection_reset_boolean:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  self_trade_prevention_instruction:
    0:
      id: 'none'
      doc: 'SelfTradePreventionInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_aggressor_order'
      doc: 'SelfTradePreventionInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancel_resting_order'
      doc: 'SelfTradePreventionInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_both_orders'
      doc: 'SelfTradePreventionInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    0x31:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  simple_ordtype:
    0x31:
      id: 'market'
      doc: 'SimpleOrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'limit'
      doc: 'SimpleOrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force_simple:
    0x30:
      id: 'day'
      doc: 'SimpleTimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'SimpleTimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'fill_or_kill'
      doc: 'SimpleTimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  routing_instruction:
    1:
      id: 'retail_liquidity_taker'
      doc: 'RoutingInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'waived_priority'
      doc: 'RoutingInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'broker_only'
      doc: 'RoutingInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'broker_only_removal'
      doc: 'RoutingInstruction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ordtype:
    0x31:
      id: 'market'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'stop_loss'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'stop_limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'market_with_leftover_as_limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'rlp'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'pegged_midpoint'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'good_till_cancel'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'fill_or_kill'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'good_till_date'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'at_the_close'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'good_for_auction'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force_optional:
    0x30:
      id: 'day'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'good_till_cancel'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'fill_or_kill'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'good_till_date'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'at_the_close'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'good_for_auction'
      doc: 'TimeInForce Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type:
    38:
      id: 'remove_account_information'
      doc: 'AccountType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'regular_account'
      doc: 'AccountType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  single_cancel_restatement_reason:
    203:
      id: 'cancel_order_due_to_operational_error'
      doc: 'ExecRestatementReasonValidForSingleCancel Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  crossed_indicator:
    1001:
      id: 'structured_transaction'
      doc: 'CrossedIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1002:
      id: 'operational_error'
      doc: 'CrossedIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1003:
      id: 'twap_vwap'
      doc: 'CrossedIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cross_type:
    1:
      id: 'all_or_none_cross'
      doc: 'CrossType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cross_executed_against_book_from_client'
      doc: 'CrossType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cross_prioritization:
    0:
      id: 'none'
      doc: 'CrossPrioritization Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'buy_side_is_prioritized'
      doc: 'CrossPrioritization Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell_side_is_prioritized'
      doc: 'CrossPrioritization Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'partially_filled'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'filled'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'canceled'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'replaced'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'rejected'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'expired'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'restated'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'previous_final_state'
      doc: 'OrdStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  working_indicator:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  multi_leg_reporting_type:
    0x31:
      id: 'single_security'
      doc: 'MultiLegReportingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'individualleg_of_multileg_security'
      doc: 'MultiLegReportingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'multileg_security'
      doc: 'MultiLegReportingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mm_protection_reset_boolean_optional:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_restatement_reason:
    8:
      id: 'market_option'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'cancel_on_hard_disconnection'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'cancel_on_terminate'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'cancel_on_disconnect_and_terminate'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'self_trading_prevention'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'cancel_from_firmsoft'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'cancel_resting_order_on_self_trade'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    200:
      id: 'market_maker_protection'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    201:
      id: 'risk_management_cancellation'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    202:
      id: 'order_mass_action_from_client_request'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    203:
      id: 'cancel_order_due_to_operational_error'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    204:
      id: 'order_cancelled_due_to_operational_error'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    205:
      id: 'cancel_order_firmsoft_due_to_operational_error'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    206:
      id: 'order_cancelled_firmsoft_due_to_operational_error'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    207:
      id: 'mass_cancel_order_due_to_operational_error_request'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    208:
      id: 'mass_cancel_order_due_to_operational_error_effective'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    209:
      id: 'cancel_minimum_qty_block'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    210:
      id: 'cancel_remaining_from_sweep_cross'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    211:
      id: 'mass_cancel_on_behalf'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    212:
      id: 'mass_cancel_on_behalf_due_to_operational_error_effective'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    213:
      id: 'cancel_on_midpoint_broker_only_removal'
      doc: 'ExecRestatementReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  aggressor_indicator:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_type:
    0x46:
      id: 'trade'
      doc: 'ExecType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'trade_cancel'
      doc: 'ExecType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_category:
    0x42:
      id: 'result_of_options_exercise'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'result_of_assignment_from_an_options_exercise'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'result_of_automatic_options_exercise'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'result_of_midpoint_order'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'result_of_block_book_trade'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'result_of_trade_at_close'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'result_of_trade_at_average'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'implied_order'
      doc: 'OrderCategory Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_session_id:
    1:
      id: 'regular_day_session'
      doc: 'TradingSessionID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'non_regular_session'
      doc: 'TradingSessionID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_session_sub_id:
    2:
      id: 'pause'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'close'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'open'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'pre_close'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'pre_open'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'final_closing_call'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'no_open'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'ready_to_trade'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'forbidden'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'unknown_or_invalid'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'pre_open'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'final_closing_call'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'reserved'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_response_to:
    0:
      id: 'new_field'
      doc: 'CxlRejResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel'
      doc: 'CxlRejResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'replace'
      doc: 'CxlRejResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_rej_reason:
    000908:
      id: 'unable_to_send_fix_from_volatilityupdate_message'
      doc: 'Unable To Send Fix From Volatility Update Message'
    001003:
      id: 'orders_may_not_be_entered_while_the_market_is_closedpaused'
      doc: 'Orders May Not Be Entered While The Market Is Closedpaused'
    001007:
      id: 'fix_field_missing_or_incorrect'
      doc: 'Fix Field Missing Or Incorrect'
    001010:
      id: 'required_field_missing'
      doc: 'Required Field Missing'
    001011:
      id: 'fix_field_incorrect'
      doc: 'Fix Field Incorrect'
    001012:
      id: 'price_must_be_greater_than_zero'
      doc: 'Price Must Be Greater Than Zero'
    001013:
      id: 'invalid_order_qualifier'
      doc: 'Invalid Order Qualifier'
    001014:
      id: 'user_not_authorized_to_trade'
      doc: 'User Not Authorized To Trade'
    001016:
      id: 'required_field_missing_stop_orders_cannot_be_iocfak'
      doc: 'Required Field Missing Stop Orders Cannot Be Iocfak'
    001017:
      id: 'required_field_missing_display_quantity_orders_cannot_be_iocfok'
      doc: 'Required Field Missing Display Quantity Orders Cannot Be Iocfok'
    001018:
      id: 'required_field_missing_stop_orders_cannot_be_iocfok'
      doc: 'Required Field Missing Stop Orders Cannot Be Iocfok'
    002013:
      id: 'market_price_orders_not_supported_by_opposite_limit'
      doc: 'Market Price Orders Not Supported By Opposite Limit'
    002019:
      id: 'order_gtd_expire_date_is_before_the_current_or_next_if_not_currently_in_a_session_trading_session_end_date'
      doc: 'Order Gtd Expire Date Is Before The Current Or Next If Not Currently In A Session Trading Session End Date'
    002045:
      id: 'cannot_modify_order_because_order_does_not_exist'
      doc: 'Cannot Modify Order Because Order Does Not Exist'
    002046:
      id: 'disclosed_quantity_cannot_be_greater_than_total_or_remaining_quantity'
      doc: 'Disclosed Quantity Cannot Be Greater Than Total Or Remaining Quantity'
    002047:
      id: 'order_contract_is_unknown'
      doc: 'Order Contract Is Unknown'
    002048:
      id: 'the_order_was_submitted_with_a_different_sendercompid_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Sender Comp Id Than The Requesting Cancel'
    002049:
      id: 'the_order_was_submitted_with_a_different_clorderid_than_the_correlationclorderid_of_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Cl Order Id Than The Correlation Cl Order Id Of The Requesting Cancel'
    002050:
      id: 'the_order_was_submitted_with_a_different_clorderid_than_the_originalclorderid_of_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Cl Order Id Than The Original Cl Order Id Of The Requesting Cancel'
    002051:
      id: 'the_order_was_submitted_with_a_different_side_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Side Than The Requesting Cancel'
    002052:
      id: 'the_order_was_submitted_with_a_different_group_tag_55_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Group Tag 55 Than The Requesting Cancel'
    002053:
      id: 'the_order_was_submitted_with_a_different_security_type_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Security Type Than The Requesting Cancel'
    002054:
      id: 'the_order_was_submitted_with_a_different_account_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Account Than The Requesting Cancel'
    002055:
      id: 'the_order_was_submitted_with_a_different_quantity_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Quantity Than The Requesting Cancel'
    002056:
      id: 'the_order_was_submitted_with_a_different_traderid_than_the_requesting_cancel'
      doc: 'The Order Was Submitted With A Different Trader Id Than The Requesting Cancel'
    002057:
      id: 'attempt_to_cancel_an_order_with_a_different_firmid_than_the_original_order'
      doc: 'Attempt To Cancel An Order With A Different Firm Id Than The Original Order'
    002058:
      id: 'attempt_to_cancel_an_order_with_a_different_senderlocationid_than_the_original_order'
      doc: 'Attempt To Cancel An Order With A Different Sender Location Id Than The Original Order'
    002059:
      id: 'stop_price_maximini_must_be_smaller_than_or_equal_to_trigger_price'
      doc: 'Stop Price Maximini Must Be Smaller Than Or Equal To Trigger Price'
    002060:
      id: 'sell_order_stop_price_must_be_below_last_trade_price'
      doc: 'Sell Order Stop Price Must Be Below Last Trade Price'
    002061:
      id: 'buy_order_stop_price_must_be_above_last_trade_price'
      doc: 'Buy Order Stop Price Must Be Above Last Trade Price'
    002100:
      id: 'the_modify_was_submitted_on_a_different_product_than_the_original_order'
      doc: 'The Modify Was Submitted On A Different Product Than The Original Order'
    002101:
      id: 'attempt_to_modify_an_order_with_a_different_inflightfill_mitigation_status_than_first_modification'
      doc: 'Attempt To Modify An Order With A Different Inflightfill Mitigation Status Than First Modification'
    002102:
      id: 'attempt_to_modify_an_order_with_a_different_sendercompid_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Sender Comp Id Than The Original Order'
    002103:
      id: 'attempt_to_modify_an_order_with_a_different_traderid_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Trader Id Than The Original Order'
    002104:
      id: 'attempt_to_modify_an_order_with_a_different_accountid_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Account Id Than The Original Order'
    002105:
      id: 'attempt_to_modify_an_order_with_a_different_firmid_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Firm Id Than The Original Order'
    002106:
      id: 'attempt_to_modify_an_order_with_a_different_senderlocationid_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Sender Location Id Than The Original Order'
    002107:
      id: 'disclosed_quantity_is_not_allowed'
      doc: 'Disclosed Quantity Is Not Allowed'
    002108:
      id: 'account_or_give_up_firm_required_for_dma_customers'
      doc: 'Account Or Give Up Firm Required For Dma Customers'
    002109:
      id: 'disclosed_qty_cannot_be_less_than_disclosed_qty_min'
      doc: 'Disclosed Qty Cannot Be Less Than Disclosed Qty Min'
    002110:
      id: 'acct_type38_not_valid_for_tag_581_for_dma_customers'
      doc: 'Acct Type 38 Not Valid For Tag 581 For Dma Customers'
    002111:
      id: 'give_up_not_valid_for_fx_spot_contract'
      doc: 'Give Up Not Valid For Fx Spot Contract'
    002112:
      id: 'visibility_permission_not_granted_for_executing_traderentering_trader'
      doc: 'Visibility Permission Not Granted For Executing Trader Entering Trader'
    002113:
      id: 'executing_trader_doesnt_have_access_to_product_group'
      doc: 'Executing Trader Doesnt Have Access To Product Group'
    002114:
      id: 'attempt_to_modify_market_order_to_some_other_type'
      doc: 'Attempt To Modify Market Order To Some Other Type'
    002115:
      id: 'order_quantity_is_outside_of_the_allowable_range'
      doc: 'Order Quantity Is Outside Of The Allowable Range'
    002116:
      id: 'account_is_mandatory_for_fx_spot'
      doc: 'Account Is Mandatory For Fx Spot'
    002117:
      id: 'order_on_behalf_by_dma_customer_is_not_allowed'
      doc: 'Order On Behalf By Dma Customer Is Not Allowed'
    002118:
      id: 'attempt_to_modify_an_order_with_a_different_accounttype_than_the_original_order'
      doc: 'Attempt To Modify An Order With A Different Account Type Than The Original Order'
    002123:
      id: 'account_or_give_up_firm_required_for_equities'
      doc: 'Account Or Give Up Firm Required For Equities'
    002130:
      id: 'order_type_not_permitted_while_the_market_is_in_pre_open'
      doc: 'Order Type Not Permitted While The Market Is In Pre Open'
    002137:
      id: 'order_price_is_outside_limits'
      doc: 'Order Price Is Outside Limits'
    002138:
      id: 'qty_is_not_multiple_of_round_lot'
      doc: 'Qty Is Not Multiple Of Round Lot'
    002139:
      id: 'qty_is_greater_or_equal_than_maximum_trade_volume'
      doc: 'Qty Is Greater Or Equal Than Maximum Trade Volume'
    002179:
      id: 'order_price_is_outside_bands'
      doc: 'Order Price Is Outside Bands'
    002180:
      id: 'order_price_is_outside_auction_bands'
      doc: 'Order Price Is Outside Auction Bands'
    002181:
      id: 'trade_outside_of_short_term_volatility_bands'
      doc: 'Trade Outside Of Short Term Volatility Bands'
    002182:
      id: 'all_legs_must_have_same_lot_types'
      doc: 'All Legs Must Have Same Lot Types'
    002183:
      id: 'all_legs_must_have_same_tick_increment'
      doc: 'All Legs Must Have Same Tick Increment'
    002184:
      id: 'all_legs_must_have_same_step_of_quotation'
      doc: 'All Legs Must Have Same Step Of Quotation'
    002185:
      id: 'trade_price_is_outside_of_static_limits'
      doc: 'Trade Price Is Outside Of Static Limits'
    002186:
      id: 'cod_not_supported_for_gtc_gtd_orders'
      doc: 'Cod Not Supported For Gtc Gtd Orders'
    002187:
      id: 'order_not_bookable_at_this_time'
      doc: 'Order Not Bookable At This Time'
    002188:
      id: 'minimum_quantity_was_not_filled'
      doc: 'Minimum Quantity Was Not Filled'
    002189:
      id: 'order_attributes_not_allowed_to_trip_an_auction'
      doc: 'Order Attributes Not Allowed To Trip An Auction'
    002311:
      id: 'order_type_not_permitted_for_group'
      doc: 'Order Type Not Permitted For Group'
    002500:
      id: 'instrument_has_an_request_for_cross_in_progress'
      doc: 'Instrument Has An Request For Cross In Progress'
    002501:
      id: 'order_quantity_too_low'
      doc: 'Order Quantity Too Low'
    002502:
      id: 'crosstype_ineligible_for_instrument'
      doc: 'Cross Type Ineligible For Instrument'
    002503:
      id: 'rfq_for_cross_is_not_allowed_since_contract_is_not_rfq_for_cross_eligible'
      doc: 'Rfq For Cross Is Not Allowed Since Contract Is Not Rfq For Cross Eligible'
    002504:
      id: 'dma_crossorder_not_allowed'
      doc: 'Dma Cross Order Not Allowed'
    002505:
      id: 'cross_order_rejected_due_to_auction_trigger_validation'
      doc: 'Cross Order Rejected Due To Auction Trigger Validation'
    002506:
      id: 'trade_on_behalf_rejected'
      doc: 'Trade On Behalf Rejected'
    002600:
      id: 'market_maker_protection_in_effect_for_user_xxxxxxxx_and_group_xxxxxx'
      doc: 'Market Maker Protection In Effect For User Xxxxxxxx And Group Xxxxxx'
    003000:
      id: 'rfq_rejected_instrumentexchange_not_tradable'
      doc: 'Rfq Rejected Instrumentexchange Not Tradable'
    003001:
      id: 'rfq_rejected_instrumentexchange_not_known'
      doc: 'Rfq Rejected Instrumentexchange Not Known'
    003002:
      id: 'error_creating_contract'
      doc: 'Error Creating Contract'
    003010:
      id: 'business_reject_other'
      doc: 'Business Reject Other'
    003011:
      id: 'business_reject_unknown_id'
      doc: 'Business Reject Unknown Id'
    003012:
      id: 'business_reject_unknown_security'
      doc: 'Business Reject Unknown Security'
    003013:
      id: 'business_reject_unsupported_message_type'
      doc: 'Business Reject Unsupported Message Type'
    003014:
      id: 'business_reject_application_not_available'
      doc: 'Business Reject Application Not Available'
    003015:
      id: 'business_reject_required_field_missing'
      doc: 'Business Reject Required Field Missing'
    003016:
      id: 'contract_claims_to_be_a_spread_but_is_missing_one_or_more_legs'
      doc: 'Contract Claims To Be A Spread But Is Missing One Or More Legs'
    003017:
      id: 'fix_field_length_exceeds_max_length'
      doc: 'Fix Field Length Exceeds Max Length'
    003020:
      id: 'special_auction_permissions_order_entry_not_allowed'
      doc: 'Special Auction Permissions Order Entry Not Allowed'
    004000:
      id: 'engine_did_not_respond_to_fas_request'
      doc: 'Engine Did Not Respond To Fas Request'
    006001:
      id: 'termo_message_rejected_unknown_instrument'
      doc: 'Termo Message Rejected Unknown Instrument'
    006002:
      id: 'termo_message_rejected_exchange_security_closed'
      doc: 'Termo Message Rejected Exchange Security Closed'
    006003:
      id: 'termo_rejected_instrumentexchange_not_tradable'
      doc: 'Termo Rejected Instrumentexchange Not Tradable'
    006004:
      id: 'termo_message_rejected_limits_exceeded'
      doc: 'Termo Message Rejected Limits Exceeded'
    006005:
      id: 'termo_message_rejected_too_late_to_enter'
      doc: 'Termo Message Rejected Too Late To Enter'
    006006:
      id: 'termo_message_rejected_unknown_termo_quote'
      doc: 'Termo Message Rejected Unknown Termo Quote'
    006007:
      id: 'termo_message_rejected_duplicate_termo_quote'
      doc: 'Termo Message Rejected Duplicate Termo Quote'
    006008:
      id: 'termo_message_rejected_invalid_bidask_spread'
      doc: 'Termo Message Rejected Invalid Bidask Spread'
    006009:
      id: 'termo_message_rejected_invalid_price'
      doc: 'Termo Message Rejected Invalid Price'
    006010:
      id: 'termo_message_rejected_not_authorized_to_termo_quote_this_instrument'
      doc: 'Termo Message Rejected Not Authorized To Termo Quote This Instrument'
    006011:
      id: 'termo_message_rejected_pass'
      doc: 'Termo Message Rejected Pass'
    006012:
      id: 'fix_field_incorrect_006012'
      doc: 'Fix Field Incorrect'
    006013:
      id: 'not_a_valid_termo_instrument'
      doc: 'Not A Valid Termo Instrument'
    006014:
      id: 'values_dont_match_with_the_original_request'
      doc: 'Values Dont Match With The Original Request'
    006015:
      id: 'current_termo_request_status_does_not_allow_rejection'
      doc: 'Current Termo Request Status Does Not Allow Rejection'
    006016:
      id: 'current_termo_request_status_does_not_allow_acceptance'
      doc: 'Current Termo Request Status Does Not Allow Acceptance'
    006017:
      id: 'wrong_type_of_order_book_for_termo'
      doc: 'Wrong Type Of Order Book For Termo'
    006018:
      id: 'wrong_type_of_request_for_termo'
      doc: 'Wrong Type Of Request For Termo'
    006019:
      id: 'days_to_settlement_must_be_between_16_and_999'
      doc: 'Days To Settlement Must Be Between 16 And 999'
    006020:
      id: 'days_to_settlement_must_be_between_16_and_90'
      doc: 'Days To Settlement Must Be Between 16 And 90'
    006021:
      id: 'instrument_not_allowed_to_this_market'
      doc: 'Instrument Not Allowed To This Market'
    006022:
      id: 'instrument_not_allowed_to_this_market_006022'
      doc: 'Instrument Not Allowed To This Market'
    006023:
      id: 'termo_price_should_be_greater_than_zero'
      doc: 'Termo Price Should Be Greater Than Zero'
    006024:
      id: 'termo_messages_should_not_be_entered_when_market_is_paused'
      doc: 'Termo Messages Should Not Be Entered When Market Is Paused'
    006025:
      id: 'termo_messages_should_not_be_entered_when_market_is_pre_open'
      doc: 'Termo Messages Should Not Be Entered When Market Is Pre Open'
    006026:
      id: 'termo_messages_should_not_be_entered_when_market_is_pcp'
      doc: 'Termo Messages Should Not Be Entered When Market Is Pcp'
    006027:
      id: 'termo_messages_should_not_be_entered_when_market_is_no_cancel'
      doc: 'Termo Messages Should Not Be Entered When Market Is No Cancel'
    006028:
      id: 'termo_messages_should_not_be_entered_when_market_is_reserved'
      doc: 'Termo Messages Should Not Be Entered When Market Is Reserved'
    006029:
      id: 'termo_messages_should_not_be_entered_when_market_is_forbidden'
      doc: 'Termo Messages Should Not Be Entered When Market Is Forbidden'
    006030:
      id: 'termo_messages_should_not_be_entered_when_market_is_pre_close'
      doc: 'Termo Messages Should Not Be Entered When Market Is Pre Close'
    006031:
      id: 'termo_messages_should_not_be_entered_when_market_is_pre_open_006031'
      doc: 'Termo Messages Should Not Be Entered When Market Is Pre Open'
    006032:
      id: 'not_a_valid_termo_underlying_instrument'
      doc: 'Not A Valid Termo Underlying Instrument'
    006033:
      id: 'received_a_null_adminoperation'
      doc: 'Received A Null Admin Operation'
    006034:
      id: 'first_trade_of_day_for_underlying_termo_instrument'
      doc: 'First Trade Of Day For Underlying Termo Instrument'
    006035:
      id: 'termo_messages_should_not_be_entered_when_market_is_in_final_closing_call'
      doc: 'Termo Messages Should Not Be Entered When Market Is In Final Closing Call'
    006036:
      id: 'invalid_cash_trade_in_tvr'
      doc: 'Invalid Cash Trade In Tvr'
    006037:
      id: 'only_buy_entry_request_for_tvr_is_accepted'
      doc: 'Only Buy Entry Request For Tvr Is Accepted'
    006038:
      id: 'there_is_no_bid_and_ask_for_underlying_contract'
      doc: 'There Is No Bid And Ask For Underlying Contract'
    006039:
      id: 'invalid_price'
      doc: 'Invalid Price'
    006040:
      id: 'invalid_cash_trade_in_tvr_006040'
      doc: 'Invalid Cash Trade In Tvr'
    006041:
      id: 'invalid_cash_trade_in_tvr_006041'
      doc: 'Invalid Cash Trade In Tvr'
    006042:
      id: 'invalid_cash_trade_in_tvr_006042'
      doc: 'Invalid Cash Trade In Tvr'
    006043:
      id: 'invalid_cash_trade_in_tvr_006043'
      doc: 'Invalid Cash Trade In Tvr'
    006044:
      id: 'invalid_cash_trade_in_tvr_006044'
      doc: 'Invalid Cash Trade In Tvr'
    007000:
      id: 'order_rejected'
      doc: 'Order Rejected'
    007001:
      id: 'fok_order_unmatchable_in_market'
      doc: 'Fok Order Unmatchable In Market'
    007002:
      id: 'orders_may_not_be_entered_while_the_market_is_closed'
      doc: 'Orders May Not Be Entered While The Market Is Closed'
    007005:
      id: 'order_contract_is_unknown_007005'
      doc: 'Order Contract Is Unknown'
    007006:
      id: 'no_partial_match_found_for_this_fak_order'
      doc: 'No Partial Match Found For This Fak Order'
    007008:
      id: 'maximum_quantity_depth_for_any_one_price_group_max_may_not_exceed_integermax_value'
      doc: 'Maximum Quantity Depth For Any One Price Group Max May Not Exceed Integer Maxvalue'
    007009:
      id: 'contract_for_this_order_contract_is_past_expiration_date_and_may_no_longer_be_traded'
      doc: 'Contract For This Order Contract Is Past Expiration Date And May No Longer Be Traded'
    007010:
      id: 'invalid_spread_price'
      doc: 'Invalid Spread Price'
    007011:
      id: 'maximum_number_of_working_orders_for_this_contract_has_been_exceeded'
      doc: 'Maximum Number Of Working Orders For This Contract Has Been Exceeded'
    007012:
      id: 'order_would_overwrite_existing_order_on_book'
      doc: 'Order Would Overwrite Existing Order On Book'
    007013:
      id: 'order_group_does_not_match_group_of_contract'
      doc: 'Order Group Does Not Match Group Of Contract'
    007014:
      id: 'order_security_type_does_not_match_security_type_of_contract'
      doc: 'Order Security Type Does Not Match Security Type Of Contract'
    007015:
      id: 'order_modify_has_different_side_than_existing_order'
      doc: 'Order Modify Has Different Side Than Existing Order'
    007017:
      id: 'contract_is_not_eligible_for_electronic_matching'
      doc: 'Contract Is Not Eligible For Electronic Matching'
    007018:
      id: 'order_contract_is_not_gtc_or_gtd_eligible'
      doc: 'Order Contract Is Not Gtc Or Gtd Eligible'
    007020:
      id: 'no_trading_calendar_found_on_or_after_order_gtd_expire_date'
      doc: 'No Trading Calendar Found On Or After Order Gtd Expire Date'
    007021:
      id: 'tag_expiredate_432_beyond_instrument_expiration'
      doc: 'Tag Expire Date 432 Beyond Instrument Expiration'
    007022:
      id: 'tag_expiredate_432_beyond_uds_combo_earliest_leg_expiration'
      doc: 'Tag Expire Date 432 Beyond Uds Combo Earliest Leg Expiration'
    007024:
      id: 'order_cannot_be_modified_or_cancelled_while_the_market_is_in_no_cancel'
      doc: 'Order Cannot Be Modified Or Cancelled While The Market Is In No Cancel'
    007027:
      id: 'order_type_not_permitted_while_the_market_is_reserved'
      doc: 'Order Type Not Permitted While The Market Is Reserved'
    007028:
      id: 'order_session_date_is_in_the_past'
      doc: 'Order Session Date Is In The Past'
    007029:
      id: 'orders_may_not_be_entered_while_the_market_is_forbidden'
      doc: 'Orders May Not Be Entered While The Market Is Forbidden'
    007030:
      id: 'quote_rejected_exchange_security_is_forbidden'
      doc: 'Quote Rejected Exchange Security Is Forbidden'
    007031:
      id: 'orders_may_not_be_entered_while_the_market_is_preclosed'
      doc: 'Orders May Not Be Entered While The Market Is Preclosed'
    007032:
      id: 'quote_rejected_exchange_security_is_preclosed'
      doc: 'Quote Rejected Exchange Security Is Preclosed'
    007033:
      id: 'orders_may_not_be_entered_while_the_market_is_open'
      doc: 'Orders May Not Be Entered While The Market Is Open'
    007034:
      id: 'quote_rejected_exchange_security_is_forbidden_007034'
      doc: 'Quote Rejected Exchange Security Is Forbidden'
    007035:
      id: 'rfq_rejected_instrument_exchange_is_open'
      doc: 'Rfq Rejected Instrument Exchange Is Open'
    007036:
      id: 'time_in_force_59_not_valid_for_order_type_40'
      doc: 'Time In Force 59 Not Valid For Order Type 40'
    007037:
      id: 'good_for_auction_order_not_allowed'
      doc: 'Good For Auction Order Not Allowed'
    007038:
      id: 'on_close_order_not_allowed'
      doc: 'On Close Order Not Allowed'
    007039:
      id: 'duplicate_client_order_id_for_this_sessioncontract'
      doc: 'Duplicate Client Order Id For This Session Contract'
    007040:
      id: 'good_for_auction_order_cancel_not_allowed'
      doc: 'Good For Auction Order Cancel Not Allowed'
    007041:
      id: 'on_close_order_cancel_not_allowed'
      doc: 'On Close Order Cancel Not Allowed'
    007042:
      id: 'good_for_auction_order_modify_not_allowed'
      doc: 'Good For Auction Order Modify Not Allowed'
    007043:
      id: 'on_close_order_modify_not_allowed'
      doc: 'On Close Order Modify Not Allowed'
    007044:
      id: 'modify_of_order_participating_in_top_not_allowed'
      doc: 'Modify Of Order Participating In Top Not Allowed'
    007045:
      id: 'cancel_of_order_participating_in_top_not_allowed'
      doc: 'Cancel Of Order Participating In Top Not Allowed'
    007046:
      id: 'order_type_duration_combination_invalid_for_auction'
      doc: 'Order Type Duration Combination Invalid For Auction'
    007047:
      id: 'order_type_duration_combination_invalid'
      doc: 'Order Type Duration Combination Invalid'
    007048:
      id: 'quantity_attribute_not_allowed_on_order_during_auction'
      doc: 'Quantity Attribute Not Allowed On Order During Auction'
    007049:
      id: 'order_entry_was_unsuccessful_error_message_is_not_possible_to_send_orders_with_validity_type_market_on_auction_with_minimum_quantity'
      doc: 'Order Entry Was Unsuccessful Error Message Is Not Possible To Send Orders With Validity Type Market On Auction With Minimum Quantity'
    007050:
      id: 'max_floor_111_not_valid_for_time_in_force_59'
      doc: 'Max Floor 111 Not Valid For Time In Force 59'
    007055:
      id: 'spread_orders_may_not_be_entered_while_the_underlying_leg_market_is_in_non_trading_state'
      doc: 'Spread Orders May Not Be Entered While The Underlying Leg Market Is In Non Trading State'
    007056:
      id: 'orders_may_not_be_entered_while_the_market_is_in_final_closing_call'
      doc: 'Orders May Not Be Entered While The Market Is In Final Closing Call'
    007101:
      id: 'quote_rejected_unknown_instrument'
      doc: 'Quote Rejected Unknown Instrument'
    007102:
      id: 'quote_rejected_exchange_security_closed'
      doc: 'Quote Rejected Exchange Security Closed'
    007103:
      id: 'quote_rejected_quote_exceeds_limit'
      doc: 'Quote Rejected Quote Exceeds Limit'
    007104:
      id: 'quote_rejected_too_late_to_enter'
      doc: 'Quote Rejected Too Late To Enter'
    007105:
      id: 'quote_rejected_unknown_quote'
      doc: 'Quote Rejected Unknown Quote'
    007106:
      id: 'quote_rejected_duplicate_quote_in_same_message'
      doc: 'Quote Rejected Duplicate Quote In Same Message'
    007107:
      id: 'quote_rejected_invalid_bidask_spread'
      doc: 'Quote Rejected Invalid Bidask Spread'
    007108:
      id: 'quote_rejected_invalid_price'
      doc: 'Quote Rejected Invalid Price'
    007109:
      id: 'quote_rejected_not_authorized_to_quote_this_instrument'
      doc: 'Quote Rejected Not Authorized To Quote This Instrument'
    007110:
      id: 'quote_rejected_resting_cancelled_too_many_rejects'
      doc: 'Quote Rejected Resting Cancelled Too Many Rejects'
    007111:
      id: 'quote_rejected_duplicate_quote_different_id'
      doc: 'Quote Rejected Duplicate Quote Different Id'
    007112:
      id: 'quote_rejected_resting_cancelled_quote_exceeds_limit'
      doc: 'Quote Rejected Resting Cancelled Quote Exceeds Limit'
    007113:
      id: 'quote_rejected_resting_cancelled_duplicate_quote'
      doc: 'Quote Rejected Resting Cancelled Duplicate Quote'
    007114:
      id: 'quote_rejected_resting_cancelled_invalid_bidask_spread'
      doc: 'Quote Rejected Resting Cancelled Invalid Bidask Spread'
    007115:
      id: 'quote_rejected_resting_cancelled_invalid_price'
      doc: 'Quote Rejected Resting Cancelled Invalid Price'
    007116:
      id: 'quote_rejected_resting_cancelled_not_authorized_to_quote_this_instrument'
      doc: 'Quote Rejected Resting Cancelled Not Authorized To Quote This Instrument'
    007117:
      id: 'quote_rejected_unspecified_reason'
      doc: 'Quote Rejected Unspecified Reason'
    007118:
      id: 'quote_rejected_exchange_security_is_in_pre_open'
      doc: 'Quote Rejected Exchange Security Is In Pre Open'
    007119:
      id: 'quote_rejected_exchange_security_is_in_no_cancel'
      doc: 'Quote Rejected Exchange Security Is In No Cancel'
    007120:
      id: 'quote_rejected_exchange_security_is_reserved'
      doc: 'Quote Rejected Exchange Security Is Reserved'
    007121:
      id: 'contract_not_eligible_for_negotiated_quote'
      doc: 'Contract Not Eligible For Negotiated Quote'
    007122:
      id: 'rlp_order_rejected_participant_not_authorized'
      doc: 'Rlp Order Rejected Participant Not Authorized'
    007123:
      id: 'attempt_to_modify_the_order_type_fromto_rlp'
      doc: 'Attempt To Modify The Order Type Fromto Rlp'
    007124:
      id: 'invalid_field_for_order_with_order_type_tag_40_equals_w_rlp'
      doc: 'Invalid Field For Order With Order Type Tag 40 Equals W Rlp'
    007125:
      id: 'rlp_order_rejected_only_one_order_is_allowed_by_firm_and_side'
      doc: 'Rlp Order Rejected Only One Order Is Allowed By Firm And Side'
    007126:
      id: 'invalid_field_for_order_with_routing_instruction_tag_35487_equals_1_retail_liquidity_taker'
      doc: 'Invalid Field For Order With Routing Instruction Tag 35487 Equals 1 Retailliquiditytaker'
    007127:
      id: 'invalid_field_for_order_with_order_type_tag_40_equals_p_pegged'
      doc: 'Invalid Field For Order With Order Type Tag 40 Equals P Pegged'
    007128:
      id: 'qty_is_not_multiple_of_minimum_execution_quantity_for_pegged_order'
      doc: 'Qty Is Not Multiple Of Minimum Execution Quantity For Pegged Order'
    007129:
      id: 'account_is_mandatory_for_pegged_order'
      doc: 'Account Is Mandatory For Pegged Order'
    007130:
      id: 'pegged_order_can_not_be_sent_in_non_regular_session'
      doc: 'Pegged Order Can Not Be Sent In Non Regular Session'
    007131:
      id: 'attempt_to_modify_the_order_type_fromto_pegged'
      doc: 'Attempt To Modify The Order Type Fromto Pegged'
    007132:
      id: 'order_rejected_pegged_orders_are_not_allowed_for_this_contract'
      doc: 'Order Rejected Pegged Orders Are Not Allowed For This Contract'
    007133:
      id: 'order_rejected_routing_instruction_tag_35487_equals_broker_only_3_not_allowed_for_this_group'
      doc: 'Order Rejected Routinginstruction Tag 35487 Equals Brokeronly 3 Not Allowed For This Group'
    007134:
      id: 'order_rejected_only_pegged_order_with_routing_instruction_tag_35487_equals_broker_only_3_is_allowed_for_this_group'
      doc: 'Order Rejected Only Pegged Order With Routinginstruction Tag 35487 Equals Brokeronly 3 Is Allowed For This Group'
    007135:
      id: 'cross_order_suspended_for_the_participant_or_session'
      doc: 'Cross Order Suspended For The Participant Or Session'
    007136:
      id: 'order_quantity_is_outside_of_the_allowable_range_order_quantity_orderqty_contract_minimum_quantity_for_cross_mincrossqty'
      doc: 'Order Quantity Is Outside Of The Allowable Range Order Quantity Order Qty Contract Minimum Quantity For Cross Min Cross Qty'
    007137:
      id: 'bbt_messages_should_not_be_entered_when_market_is_paused'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Paused'
    007138:
      id: 'bbt_messages_should_not_be_entered_when_market_is_pre_open'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Pre Open'
    007139:
      id: 'bbt_messages_should_not_be_entered_when_market_is_pcp'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Pcp'
    007140:
      id: 'bbt_messages_should_not_be_entered_when_market_is_no_cancel'
      doc: 'Bbt Messages Should Not Be Entered When Market Is No Cancel'
    007141:
      id: 'bbt_messages_should_not_be_entered_when_market_is_reserved'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Reserved'
    007142:
      id: 'bbt_messages_should_not_be_entered_when_market_is_forbidden'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Forbidden'
    007143:
      id: 'bbt_messages_should_not_be_entered_when_market_is_pre_close'
      doc: 'Bbt Messages Should Not Be Entered When Market Is Pre Close'
    007144:
      id: 'invalid_field_for_bbt_order'
      doc: 'Invalid Field For Bbt Order'
    007145:
      id: 'for_cancel_on_behalf_must_be_informed_only_the_actiontargetsessionid_or_the_actiontargetgroupid'
      doc: 'For Cancel On Behalf Must Be Informed Only The Action Target Session Id Or The Action Target Group Id'
    007146:
      id: 'actiontargetgroupid_invalid_it_doesnt_exist_or_it_is_disabled'
      doc: 'Action Target Group Id Invalid It Doesnt Exist Or It Is Disabled'
    007147:
      id: 'fix_session_is_blocked_due_to_mass_cancel'
      doc: 'Fix Session Is Blocked Due To Mass Cancel'
    007148:
      id: 'actiontargetgroupid_must_be_informed'
      doc: 'Action Target Group Id Must Be Informed'
    007149:
      id: 'fix_session_doesnt_belong_to_the_actiontargetgroupid'
      doc: 'Fix Session Doesnt Belong To The Action Target Group Id'
    009999:
      id: 'technical_error_function_not_performed'
      doc: 'Technical Error Function Not Performed'
    008006:
      id: 'exercise_price_not_allowed'
      doc: 'Exercise Price Not Allowed'
    008007:
      id: 'no_positions_blocked'
      doc: 'No Positions Blocked'
    008008:
      id: 'quantity_doesnt_match_with_the_original_request_quantity_on_original_request_quantity_on_original_request'
      doc: 'Quantity Doesnt Match With The Original Request Quantity On Original Request Quantity On Original Request'
    008011:
      id: 'exercise_must_be_on_maturity_date'
      doc: 'Exercise Must Be On Maturity Date'
    008014:
      id: 'function_not_available_this_time'
      doc: 'Function Not Available This Time'
    008015:
      id: 'blocking_quantity_more_than_999999999'
      doc: 'Blocking Quantity More Than 999999999'
    008020:
      id: 'trade_does_not_belong_to_the_specified_firm_firm_id_xxx'
      doc: 'Trade Does Not Belong To The Specified Firm Firm Id Xxx'
    008021:
      id: 'blocking_qty_more_than_available_quantity'
      doc: 'Blocking Qty More Than Available Quantity'
    008022:
      id: 'there_arent_positions_available_to_exercise'
      doc: 'There Arent Positions Available To Exercise'
    008023:
      id: 'total_qty_must_be_the_sum_of_all_allocqty'
      doc: 'Total Qty Must Be The Sum Of All Alloc Qty'
    008024:
      id: 'trade_already_cancelled_or_does_not_exist_trade_id_xxx'
      doc: 'Trade Already Cancelled Or Does Not Exist Trade Id Xxx'
    008027:
      id: 'available_quantity_to_block_is_zero'
      doc: 'Available Quantity To Block Is Zero'
    008028:
      id: 'invalid_operation_for_contract_type'
      doc: 'Invalid Operation For Contract Type'
    008036:
      id: 'function_closed_or_suspended'
      doc: 'Function Closed Or Suspended'
    008039:
      id: 'exercise_price_outside_required_moneyness'
      doc: 'Exercise Price Outside Required Moneyness'
    008040:
      id: 'invalid_exercise_request_id_to_cancel'
      doc: 'Invalid Exercise Request Id To Cancel'
    008059:
      id: 'invalid_blocking_id_to_unblock'
      doc: 'Invalid Blocking Id To Unblock'
    008062:
      id: 'invalid_quantity_to_unblock'
      doc: 'Invalid Quantity To Unblock'
    008063:
      id: 'on_behalf_operation_not_allowed_during_ccr_recovery'
      doc: 'On Behalf Operation Not Allowed During Ccr Recovery'
    008065:
      id: 'problem_parsing_incoming_message'
      doc: 'Problem Parsing Incoming Message'
    008066:
      id: 'exercise_quantity_should_be_greater_than_zero'
      doc: 'Exercise Quantity Should Be Greater Than Zero'
    030002:
      id: 'system_initialization'
      doc: 'System Initialization'
    030003:
      id: 'line_busy'
      doc: 'Line Busy'
    030004:
      id: 'message_or_atributes_are_invalid'
      doc: 'Message Or Atributes Are Invalid'
    030005:
      id: 'internal_error'
      doc: 'Internal Error'
    030006:
      id: 'timeout_waiting_risk_evaluation'
      doc: 'Timeout Waiting Risk Evaluation'
    030007:
      id: 'timeout_waiting_risk_evaluation_low_priority'
      doc: 'Timeout Waiting Risk Evaluation Low Priority'
    030011:
      id: 'broker_negotiation_blocked'
      doc: 'Broker Negotiation Blocked'
    030012:
      id: 'broker_not_available'
      doc: 'Broker Not Available'
    030013:
      id: 'brokers_capture_account_not_found'
      doc: 'Brokers Capture Account Not Found'
    030014:
      id: 'brokers_segment_negotiation_blocked'
      doc: 'Brokers Segment Negotiation Blocked'
    030015:
      id: 'broker_segment_not_available'
      doc: 'Broker Segment Not Available'
    030016:
      id: 'brokers_segment_protected_mode_under_activation'
      doc: 'Brokers Segment Protected Mode Under Activation'
    030017:
      id: 'broker_pn_negotiation_blocked'
      doc: 'Broker Pn Negotiation Blocked'
    030018:
      id: 'broker_pn_not_available'
      doc: 'Broker Pn Not Available'
    030019:
      id: 'broker_pn_protected_mode_under_activation'
      doc: 'Broker Pn Protected Mode Under Activation'
    030021:
      id: 'account_negotiation_blocked'
      doc: 'Account Negotiation Blocked'
    030022:
      id: 'account_not_available'
      doc: 'Account Not Available'
    030023:
      id: 'accounts_protected_mode_under_activation'
      doc: 'Accounts Protected Mode Under Activation'
    030024:
      id: 'account_mandatory_on_dma_orders'
      doc: 'Account Mandatory On Dma Orders'
    030025:
      id: 'transient_account_is_hierarchically_blocked_on_protected_mode'
      doc: 'Transient Account Is Hierarchically Blocked On Protected Mode'
    030026:
      id: 'crossorders_or_crossforward_not_allowed_while_account_in_protected_mode'
      doc: 'Crossorders Or Crossforward Not Allowed While Account In Protected Mode'
    030027:
      id: 'transient_account_not_allowed_in_extended_hours'
      doc: 'Transient Account Not Allowed In Extended Hours'
    030031:
      id: 'document_negotiation_blocked'
      doc: 'Document Negotiation Blocked'
    030032:
      id: 'document_not_available'
      doc: 'Document Not Available'
    030033:
      id: 'documents_protected_mode_under_activation'
      doc: 'Documents Protected Mode Under Activation'
    030034:
      id: 'executor_document_cannot_use_default_broker_profile'
      doc: 'Executor Document Cannot Use Default Broker Profile'
    030035:
      id: 'document_in_blocked_profile'
      doc: 'Document In Blocked Profile'
    030036:
      id: 'crossorders_or_crossforward_not_allowed_while_document_in_protected_mode'
      doc: 'Crossorders Or Crossforward Not Allowed While Document In Protected Mode'
    030041:
      id: 'entering_trader_negotiation_blocked'
      doc: 'Entering Trader Negotiation Blocked'
    030042:
      id: 'entering_trader_not_available'
      doc: 'Entering Trader Not Available'
    030043:
      id: 'entering_trader_blocked_by_sfd_overflow'
      doc: 'Entering Trader Blocked By Sfd Overflow'
    030044:
      id: 'non_dma_orders_must_provide_account_while_in_brokers_protected_mode'
      doc: 'Non Dma Orders Must Provide Account While In Brokers Protected Mode'
    030045:
      id: 'entering_trader_not_authorized_to_trade_accountless_orders'
      doc: 'Entering Trader Not Authorized To Trade Accountless Orders'
    030046:
      id: 'entering_trader_cannot_trade_on_behalf_of_other_firms_account'
      doc: 'Entering Trader Cannot Trade On Behalf Of Other Firms Account'
    030050:
      id: 'symbol_not_available'
      doc: 'Symbol Not Available'
    030051:
      id: 'symbol_internal_data_corrupted'
      doc: 'Symbol Internal Data Corrupted'
    030052:
      id: 'fix_message_type_does_not_support_operations_on_such_symbol'
      doc: 'Fix Message Type Does Not Support Operations On Such Symbol'
    030053:
      id: 'symbols_underlying_not_found_for_risk_aggregation'
      doc: 'Symbols Underlying Not Found For Risk Aggregation'
    030054:
      id: 'symbols_risk_unit_matrix_not_available'
      doc: 'Symbols Risk Unit Matrix Not Available'
    030055:
      id: 'symbols_reference_price_missing_market_orders_not_allowed'
      doc: 'Symbols Reference Price Missing Market Orders Not Allowed'
    032056:
      id: 'symbols_calculated_price_invalid'
      doc: 'Symbols Calculated Price Invalid'
    030060:
      id: 'spreads_leg_not_available'
      doc: 'Spreads Leg Not Available'
    030061:
      id: 'spreads_leg_internal_data_corrupted'
      doc: 'Spreads Leg Internal Data Corrupted'
    030070:
      id: 'unexpected_internal_error_during_risk_evaluation'
      doc: 'Unexpected Internal Error During Risk Evaluation'
    030113:
      id: 'sfd_broker_pn_pn_document_aggregation_day_trade_cash_balance_stop_loss_not_configured'
      doc: 'Sfd Broker Pn Pn Document Aggregation Day Trade Cash Balance Stop Loss Not Configured'
    030114:
      id: 'sdp_broker_pn_pn_document_aggregation_order_exceeded_cash_settlement_exposure'
      doc: 'Sdp Broker Pn Pn Document Aggregation Order Exceeded Cash Settlement Exposure'
    030115:
      id: 'rmkt_broker_pn_pn_document_aggregation_order_quantity_exceeded_risk_increase'
      doc: 'Rmkt Broker Pn Pn Document Aggregation Order Quantity Exceeded Risk Increase'
    030116:
      id: 'sdp_broker_pn_pn_trader_aggregation_order_exceeded_cash_settlement_exposure'
      doc: 'Sdp Broker Pn Pn Trader Aggregation Order Exceeded Cash Settlement Exposure'
    030117:
      id: 'spvd_broker_pn_pn_document_aggregation_order_exceeded_potential_short_uncovered_balance'
      doc: 'Spvd Broker Pn Pn Document Aggregation Order Exceeded Potential Short Uncovered Balance'
    030118:
      id: 'spvd_broker_pn_pn_trader_aggregation_order_exceeded_potential_short_uncovered_balance'
      doc: 'Spvd Broker Pn Pn Trader Aggregation Order Exceeded Potential Short Uncovered Balance'
    030119:
      id: 'rmse_broker_pn_pn_document_aggregation_order_exceeded_risk_increase_at_extended_session'
      doc: 'Rmse Broker Pn Pn Document Aggregation Order Exceeded Risk Increase At Extended Session'
    030166:
      id: 'rmse_broker_order_exceeded_risk_increase_at_extended_session'
      doc: 'Rmse Broker Order Exceeded Risk Increase At Extended Session'
    030201:
      id: 'mkta_account_buy_not_allowed_for_symbols_market'
      doc: 'Mkta Account Buy Not Allowed For Symbols Market'
    030202:
      id: 'mkta_account_sell_not_allowed_for_symbols_market'
      doc: 'Mkta Account Sell Not Allowed For Symbols Market'
    030204:
      id: 'tmoc_account_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmoc Account Maximum Order Size Exceeded For Single Order'
    030205:
      id: 'tmov_account_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmov Account Maximum Order Size Exceeded For Single Order'
    030206:
      id: 'spci_account_order_quantity_exceeded_short_position_per_instrument'
      doc: 'Spci Account Order Quantity Exceeded Short Position Per Instrument'
    030207:
      id: 'spvi_account_order_quantity_exceeded_long_position_per_instrument'
      doc: 'Spvi Account Order Quantity Exceeded Long Position Per Instrument'
    030208:
      id: 'sdp_account_order_exceeded_cash_settlement_exposure'
      doc: 'Sdp Account Order Exceeded Cash Settlement Exposure'
    030210:
      id: 'rmkt_account_order_quantity_exceeded_risk_increase'
      doc: 'Rmkt Account Order Quantity Exceeded Risk Increase'
    030211:
      id: 'irmkt_account_order_quantity_exceeded_risk_increase_reducing_mode'
      doc: 'Irmkt Account Order Quantity Exceeded Risk Increase Reducing Mode'
    030212:
      id: 'spi_account_order_quantity_exceeded_long_and_short_position_reducing_mode'
      doc: 'Spi Account Order Quantity Exceeded Long And Short Position Reducing Mode'
    030213:
      id: 'std_account_termo_not_allowed_protected_mode_enabled'
      doc: 'Std Account Termo Not Allowed Protected Mode Enabled'
    030215:
      id: 'spvd_account_order_exceeded_potential_short_uncovered_balance'
      doc: 'Spvd Account Order Exceeded Potential Short Uncovered Balance'
    030300:
      id: 'mkta_document_buysell_symbols_market_not_configured'
      doc: 'Mkta Document Buy Sell Symbols Market Not Configured'
    030301:
      id: 'mkta_document_buy_not_allowed_for_symbols_market'
      doc: 'Mkta Document Buy Not Allowed For Symbols Market'
    030302:
      id: 'mkta_document_sell_not_allowed_for_symbols_market'
      doc: 'Mkta Document Sell Not Allowed For Symbols Market'
    030303:
      id: 'tmox_document_max'
      doc: 'Tmox Document Max'
    030304:
      id: 'tmoc_document_max_bid_quantity_exceeded_for_single_order'
      doc: 'Tmoc Document Max Bid Quantity Exceeded For Single Order'
    030305:
      id: 'tmov_document_max_offer_quantity_exceeded_for_single_order'
      doc: 'Tmov Document Max Offer Quantity Exceeded For Single Order'
    030306:
      id: 'spci_document_order_quantity_exceeded_max_bid_potential_balance'
      doc: 'Spci Document Order Quantity Exceeded Max Bid Potential Balance'
    030307:
      id: 'spvi_document_order_quantity_exceeded_max_offer_potential_balance'
      doc: 'Spvi Document Order Quantity Exceeded Max Offer Potential Balance'
    030308:
      id: 'sdp_document_order_exceeded_max_financial_potential_balance_due'
      doc: 'Sdp Document Order Exceeded Max Financial Potential Balance Due'
    030309:
      id: 'std_document_order_quantity_exceeded_max_operations_forward_balance'
      doc: 'Std Document Order Quantity Exceeded Max Operations Forward Balance'
    030310:
      id: 'rmkt'
      doc: 'Rmkt'
    030311:
      id: 'irmkt_document_order_quantity_exceeded_max_incremental_market_risk'
      doc: 'Irmkt Document Order Quantity Exceeded Max Incremental Market Risk'
    030312:
      id: 'spi_document_order_quantity_exceeded_previous_potencial_balance'
      doc: 'Spi Document Order Quantity Exceeded Previous Potencial Balance'
    030313:
      id: 'std_document_termo_not_allowed'
      doc: 'Std Document Termo Not Allowed'
    030314:
      id: 'sfd_document_day_trade_cash_balance_stop_loss_not_configured'
      doc: 'Sfd Document Day Trade Cash Balance Stop Loss Not Configured'
    030315:
      id: 'spvd_document_order_exceeded_potential_short_uncovered_balance'
      doc: 'Spvd Document Order Exceeded Potential Short Uncovered Balance'
    030316:
      id: 'rmse_document_order_exceeded_risk_increase_at_extended_session'
      doc: 'Rmse Document Order Exceeded Risk Increase At Extended Session'
    030317:
      id: 'rmse_document_order_exceeded_risk_increase_of_broker_at_extended_session'
      doc: 'Rmse Document Order Exceeded Risk Increase Of Broker At Extended Session'
    030400:
      id: 'mkta_entering_trader_buysell_symbols_market_not_configured'
      doc: 'Mkta Entering Trader Buy Sell Symbols Market Not Configured'
    030401:
      id: 'mkta_entering_trader_buy_not_allowed_for_symbols_market'
      doc: 'Mkta Entering Trader Buy Not Allowed For Symbols Market'
    030402:
      id: 'mkta_entering'
      doc: 'Mkta Entering'
    030403:
      id: 'tmox_entering_trader_max_bidoffer_quantity_not_configured'
      doc: 'Tmox Entering Trader Max Bid Offer Quantity Not Configured'
    030404:
      id: 'tmoc_entering_trader_max_bid_quantity_exceeded_for_single_order'
      doc: 'Tmoc Entering Trader Max Bid Quantity Exceeded For Single Order'
    030405:
      id: 'tmov_entering_trader_max_offer_quantity_exceeded_for_si'
      doc: 'Tmov Entering Trader Max Offer Quantity Exceeded For Si'
    030406:
      id: 'spci_entering_trader_order_quantity_exceeded_max_bid_potential_balance'
      doc: 'Spci Entering Trader Order Quantity Exceeded Max Bid Potential Balance'
    030407:
      id: 'spvi_entering_trader_order_quantity_exceeded_max_offer_potential_balance'
      doc: 'Spvi Entering Trader Order Quantity Exceeded Max Offer Potential Balance'
    030408:
      id: 'sdp_entering_trader_order_exceeded_max_financial_potential'
      doc: 'Sdp Entering Trader Order Exceeded Max Financial Potential'
    030415:
      id: 'spvd_trader_order_exceeded_potential_short_uncovered_balance'
      doc: 'Spvd Trader Order Exceeded Potential Short Uncovered Balance'
    030500:
      id: 'oms_unexpected_internal_error'
      doc: 'Oms Unexpected Internal Error'
    030501:
      id: 'oms_invalid_session_or_symbol'
      doc: 'Oms Invalid Session Or Symbol'
    030502:
      id: 'oms_clordid_cannot_be_empty'
      doc: 'Oms Cl Ord Id Cannot Be Empty'
    030503:
      id: 'oms_clordid_is_duplicated'
      doc: 'Oms Cl Ord Id Is Duplicated'
    030504:
      id: 'oms_clordid_not_found'
      doc: 'Oms Cl Ord Id Not Found'
    030505:
      id: 'oms_origclordid_cannot_be_empty'
      doc: 'Oms Orig Cl Ord Id Cannot Be Empty'
    030506:
      id: 'oms_crossid_cannot_be_empty'
      doc: 'Oms Cross Id Cannot Be Empty'
    030507:
      id: 'oms_clordid_is_duplicated_within_cross_order'
      doc: 'Oms Cl Ord Id Is Duplicated Within Cross Order'
    030508:
      id: 'oms_cross_order_modification_is_not_allowed'
      doc: 'Oms Cross Order Modification Is Not Allowed'
    030509:
      id: 'oms_orderid_not_found'
      doc: 'Oms Order Id Not Found'
    030510:
      id: 'oms_orderid_cannot_be_empty'
      doc: 'Oms Order Id Cannot Be Empty'
    030511:
      id: 'oms_quotereqid_cannot_be_empty'
      doc: 'Oms Quote Req Id Cannot Be Empty'
    030512:
      id: 'oms_quotereqid_is_duplicated'
      doc: 'Oms Quote Req Id Is Duplicated'
    030513:
      id: 'oms_quotereqid_not_found'
      doc: 'Oms Quote Req Id Not Found'
    030514:
      id: 'oms_quoteid_cannot_be_empty'
      doc: 'Oms Quote Id Cannot Be Empty'
    030521:
      id: 'oms_in'
      doc: 'Oms In'
    030522:
      id: 'oms'
      doc: 'Oms'
    030523:
      id: 'oms_entering_firm_modification_is_not_allowed'
      doc: 'Oms Entering Firm Modification Is Not Allowed'
    030524:
      id: 'oms_account_modification_on_dma_order_is_not_allowed'
      doc: 'Oms Account Modification On Dma Order Is Not Allowed'
    030525:
      id: 'oms_account_information_missing_on_non'
      doc: 'Oms Account Information Missing On Non'
    030526:
      id: 'oms_entering_trader'
      doc: 'Oms Entering Trader'
    030527:
      id: 'oms_received_execution_report_rejection_for_an_active_order'
      doc: 'Oms Received Execution Report Rejection For An Active Order'
    031011:
      id: 'broker_negotiation_blocked_031011'
      doc: 'Broker Negotiation Blocked'
    031012:
      id: 'broker_not_available_031012'
      doc: 'Broker Not Available'
    031013:
      id: 'brokers_capture_account_not_found_031013'
      doc: 'Brokers Capture Account Not Found'
    031014:
      id: 'brokers_segment_negotiation_blocked_031014'
      doc: 'Brokers Segment Negotiation Blocked'
    031015:
      id: 'broker_segment_not_available_031015'
      doc: 'Broker Segment Not Available'
    031016:
      id: 'brokers_segment_protected_mode_under_activation_031016'
      doc: 'Brokers Segment Protected Mode Under Activation'
    031021:
      id: 'account_negotiation_blocked_031021'
      doc: 'Account Negotiation Blocked'
    031022:
      id: 'account_not_available_031022'
      doc: 'Account Not Available'
    031023:
      id: 'accounts_protected_mode_under_activation_031023'
      doc: 'Accounts Protected Mode Under Activation'
    031024:
      id: 'account_mandatory_on_dma_orders_031024'
      doc: 'Account Mandatory On Dma Orders'
    031025:
      id: 'transient_account_is_hierarchically_blocked_on_protected_mode_031025'
      doc: 'Transient Account Is Hierarchically Blocked On Protected Mode'
    031026:
      id: 'crossorders_or_crossforward_not_allowed_while_account_in_protected_mode_031026'
      doc: 'Crossorders Or Crossforward Not Allowed While Account In Protected Mode'
    031027:
      id: 'transient_account_not_allowed_in_extended_hours_031027'
      doc: 'Transient Account Not Allowed In Extended Hours'
    031031:
      id: 'document_negotiation_blocked_031031'
      doc: 'Document Negotiation Blocked'
    031032:
      id: 'document_not_available_031032'
      doc: 'Document Not Available'
    031033:
      id: 'documents_protected_mode_under_activation_031033'
      doc: 'Documents Protected Mode Under Activation'
    031034:
      id: 'executor_document_cannot_use_default_broker_profile_031034'
      doc: 'Executor Document Cannot Use Default Broker Profile'
    031035:
      id: 'document_in_blocked_profile_031035'
      doc: 'Document In Blocked Profile'
    031036:
      id: 'crossorders_or_crossforward_not_allowed_while_document_in_protected_mode_031036'
      doc: 'Crossorders Or Crossforward Not Allowed While Document In Protected Mode'
    031041:
      id: 'entering_trader_negotiation_blocked_031041'
      doc: 'Entering Trader Negotiation Blocked'
    031042:
      id: 'entering_trader_not_available_031042'
      doc: 'Entering Trader Not Available'
    031043:
      id: 'entering_trader_blocked_by_sfd_overflow_031043'
      doc: 'Entering Trader Blocked By Sfd Overflow'
    031044:
      id: 'non_dma_orders_must_provide_account_while_in_brokers_protected_mode_031044'
      doc: 'Non Dma Orders Must Provide Account While In Brokers Protected Mode'
    031045:
      id: 'entering_trader_not_authorized_to_trade_accountless_orders_031045'
      doc: 'Entering Trader Not Authorized To Trade Accountless Orders'
    031046:
      id: 'entering_trader_cannot_trade_on_behalf_of_other_firms_account_031046'
      doc: 'Entering Trader Cannot Trade On Behalf Of Other Firms Account'
    031050:
      id: 'symbol_not_available_031050'
      doc: 'Symbol Not Available'
    031051:
      id: 'symbol_internal_data_corrupted_031051'
      doc: 'Symbol Internal Data Corrupted'
    031052:
      id: 'fix_message_type_does_not_support_operations_on_such_symbol_031052'
      doc: 'Fix Message Type Does Not Support Operations On Such Symbol'
    031053:
      id: 'symbols_underlying_not_found_for_risk_aggregation_031053'
      doc: 'Symbols Underlying Not Found For Risk Aggregation'
    031054:
      id: 'symbols_risk_unit_matrix_not_available_031054'
      doc: 'Symbols Risk Unit Matrix Not Available'
    031055:
      id: 'symbols_reference_price_missing_market_orders_not_allowed_031055'
      doc: 'Symbols Reference Price Missing Market Orders Not Allowed'
    031056:
      id: 'symbols_calculated_price_invalid_031056'
      doc: 'Symbols Calculated Price Invalid'
    031060:
      id: 'spreads_leg_not_available_031060'
      doc: 'Spreads Leg Not Available'
    031061:
      id: 'spreads_leg_internal_data_corrupted_031061'
      doc: 'Spreads Leg Internal Data Corrupted'
    031070:
      id: 'unexpected_internal_error_during_risk_evaluation_031070'
      doc: 'Unexpected Internal Error During Risk Evaluation'
    031201:
      id: 'mkta_account_buy_not_allowed_for_symbols_market_031201'
      doc: 'Mkta Account Buy Not Allowed For Symbols Market'
    031202:
      id: 'mkta_account_sell_not_allowed_for_symbols_market_031202'
      doc: 'Mkta Account Sell Not Allowed For Symbols Market'
    031204:
      id: 'tmoc_account_max_bid_quantity_exceeded_for_single_order'
      doc: 'Tmoc Account Max Bid Quantity Exceeded For Single Order'
    031205:
      id: 'tmov_account_max_offer_quantity_exceeded_for_single_order'
      doc: 'Tmov Account Max Offer Quantity Exceeded For Single Order'
    031206:
      id: 'spci_account_order_quantity_exceeded_max_bid_potential_balance'
      doc: 'Spci Account Order Quantity Exceeded Max Bid Potential Balance'
    031207:
      id: 'spvi_account_order_quantity_exceeded_max_offer_potential_balance'
      doc: 'Spvi Account Order Quantity Exceeded Max Offer Potential Balance'
    031208:
      id: 'sdp_account_order_exceeded_max_financial_potential_balance_due'
      doc: 'Sdp Account Order Exceeded Max Financial Potential Balance Due'
    031210:
      id: 'rmkt_account_order_quantity_exceeded_max_market_risk'
      doc: 'Rmkt Account Order Quantity Exceeded Max Market Risk'
    031211:
      id: 'irmkt_account_order_quantity_exceeded_max_incremental_market_risk'
      doc: 'Irmkt Account Order Quantity Exceeded Max Incremental Market Risk'
    031212:
      id: 'spi_account_order_quantity_exceeded_previous_potencial_balance'
      doc: 'Spi Account Order Quantity Exceeded Previous Potencial Balance'
    031213:
      id: 'std_account_termo_not_allowed_protected_mode_enabled_031213'
      doc: 'Std Account Termo Not Allowed Protected Mode Enabled'
    031215:
      id: 'spvd_account_order_exceeded_potential_short_uncovered_balance_031215'
      doc: 'Spvd Account Order Exceeded Potential Short Uncovered Balance'
    031300:
      id: 'mkta_document_buysell_symbols_market_not_configured_031300'
      doc: 'Mkta Document Buy Sell Symbols Market Not Configured'
    031301:
      id: 'mkta_document_buy_not_allowed_for_symbols_market_031301'
      doc: 'Mkta Document Buy Not Allowed For Symbols Market'
    031302:
      id: 'mkta_document_sell_not_allowed_for_symbols_market_031302'
      doc: 'Mkta Document Sell Not Allowed For Symbols Market'
    031303:
      id: 'tmox_document_maximum_order_size_not_configured'
      doc: 'Tmox Document Maximum Order Size Not Configured'
    031304:
      id: 'tmoc_document_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmoc Document Maximum Order Size Exceeded For Single Order'
    031305:
      id: 'tmov_document_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmov Document Maximum Order Size Exceeded For Single Order'
    031306:
      id: 'spci_document_order_quantity_exceeded_short_position_per_instrument'
      doc: 'Spci Document Order Quantity Exceeded Short Position Per Instrument'
    031307:
      id: 'spvi_document_order_quantity_exceeded_long_position_per_instrument'
      doc: 'Spvi Document Order Quantity Exceeded Long Position Per Instrument'
    031308:
      id: 'sdp_document_order_exceeded_cash_settlement_exposure'
      doc: 'Sdp Document Order Exceeded Cash Settlement Exposure'
    031309:
      id: 'std_document_order_quantity_exceeded_forward_contracts_exposure'
      doc: 'Std Document Order Quantity Exceeded Forward Contracts Exposure'
    031310:
      id: 'rmkt_document_order_quantity_exceeded_risk_increase'
      doc: 'Rmkt Document Order Quantity Exceeded Risk Increase'
    031311:
      id: 'irmkt_document_order_quantity_exceeded_risk_increase_reducing_mode'
      doc: 'Irmkt Document Order Quantity Exceeded Risk Increase Reducing Mode'
    031312:
      id: 'spi_document_order_quantity_exceeded_long_and_short_position_reducing_mode'
      doc: 'Spi Document Order Quantity Exceeded Long And Short Position Reducing Mode'
    031313:
      id: 'std_document_termo_not_allowed_protected_mode_enabled'
      doc: 'Std Document Termo Not Allowed Protected Mode Enabled'
    031314:
      id: 'sfd_document_day_trade_cash_balance_stop_loss_not_configured_031314'
      doc: 'Sfd Document Day Trade Cash Balance Stop Loss Not Configured'
    031315:
      id: 'spvd_document_order_exceeded_potential_short_uncovered_balance_031315'
      doc: 'Spvd Document Order Exceeded Potential Short Uncovered Balance'
    031316:
      id: 'rmse_document_order_exceeded_risk_increase_at_extended_session_031316'
      doc: 'Rmse Document Order Exceeded Risk Increase At Extended Session'
    031317:
      id: 'rmse_document_order_exceeded_risk_increase_of_broker_at_extended_session_031317'
      doc: 'Rmse Document Order Exceeded Risk Increase Of Broker At Extended Session'
    031400:
      id: 'mkta_entering_trader_buysell_symbols_market_not_configured_031400'
      doc: 'Mkta Entering Trader Buy Sell Symbols Market Not Configured'
    031401:
      id: 'mkta_entering_trader_buy_not_allowed_for_symbols_market_031401'
      doc: 'Mkta Entering Trader Buy Not Allowed For Symbols Market'
    031402:
      id: 'mkta_entering_trader_sell_not_allowed_for_symbols_market'
      doc: 'Mkta Entering Trader Sell Not Allowed For Symbols Market'
    031403:
      id: 'tmox_entering_trader_maximum_order_size_not_configured'
      doc: 'Tmox Entering Trader Maximum Order Size Not Configured'
    031404:
      id: 'tmoc_entering_trader_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmoc Entering Trader Maximum Order Size Exceeded For Single Order'
    031405:
      id: 'tmov_entering_trader_maximum_order_size_exceeded_for_single_order'
      doc: 'Tmov Entering Trader Maximum Order Size Exceeded For Single Order'
    031406:
      id: 'spci_entering_trader_order_quantity_exceeded_short_position_per_instrument'
      doc: 'Spci Entering Trader Order Quantity Exceeded Short Position Per Instrument'
    031407:
      id: 'spvi_entering_trader_order_quantity_exceeded_long_position_per_instrument'
      doc: 'Spvi Entering Trader Order Quantity Exceeded Long Position Per Instrument'
    031408:
      id: 'sdp_entering_trader_order_exceeded_cash_settlement_exposure'
      doc: 'Sdp Entering Trader Order Exceeded Cash Settlement Exposure'
    031500:
      id: 'oms_unexpected_internal_error_031500'
      doc: 'Oms Unexpected Internal Error'
    031501:
      id: 'oms_invalid_session_or_symbol_031501'
      doc: 'Oms Invalid Session Or Symbol'
    031502:
      id: 'oms_clordid_cannot_be_empty_031502'
      doc: 'Oms Cl Ord Id Cannot Be Empty'
    031503:
      id: 'oms_clordid_is_duplicated_031503'
      doc: 'Oms Cl Ord Id Is Duplicated'
    031504:
      id: 'oms_clordid_not_found_031504'
      doc: 'Oms Cl Ord Id Not Found'
    031505:
      id: 'oms_origclordid_cannot_be_empty_031505'
      doc: 'Oms Orig Cl Ord Id Cannot Be Empty'
    031506:
      id: 'oms_crossid_cannot_be_empty_031506'
      doc: 'Oms Cross Id Cannot Be Empty'
    031507:
      id: 'oms_clordid_is_duplicated_within_cross_order_031507'
      doc: 'Oms Cl Ord Id Is Duplicated Within Cross Order'
    031508:
      id: 'oms_cross_order_modification_is_not_allowed_031508'
      doc: 'Oms Cross Order Modification Is Not Allowed'
    031509:
      id: 'oms_orderid_not_found_031509'
      doc: 'Oms Order Id Not Found'
    031510:
      id: 'oms_orderid_cannot_be_empty_031510'
      doc: 'Oms Order Id Cannot Be Empty'
    031511:
      id: 'oms_quotereqid_cannot_be_empty_031511'
      doc: 'Oms Quote Req Id Cannot Be Empty'
    031512:
      id: 'oms_quotereqid_is_duplicated_031512'
      doc: 'Oms Quote Req Id Is Duplicated'
    031513:
      id: 'oms_quotereqid_not_found_031513'
      doc: 'Oms Quote Req Id Not Found'
    031514:
      id: 'oms_quoteid_cannot_be_empty_031514'
      doc: 'Oms Quote Id Cannot Be Empty'
    031521:
      id: 'oms_inflight_modification_is_not_allowed'
      doc: 'Oms In Flight Modification Is Not Allowed'
    031522:
      id: 'oms_side_modification_is_not_allowed'
      doc: 'Oms Side Modification Is Not Allowed'
    031523:
      id: 'oms_entering_firm_modification_is_not_allowed_031523'
      doc: 'Oms Entering Firm Modification Is Not Allowed'
    031524:
      id: 'oms_account_modification_on_dma_order_is_not_allowed_031524'
      doc: 'Oms Account Modification On Dma Order Is Not Allowed'
    031525:
      id: 'oms_account_information_missing_on_nondma_order'
      doc: 'Oms Account Information Missing On Non Dma Order'
    031526:
      id: 'oms_entering_trader_modification_on_nondma_order_is_not_allowed'
      doc: 'Oms Entering Trader Modification On Non Dma Order Is Not Allowed'
    031527:
      id: 'oms_received_execution_report_rejection_for_an_active_order_031527'
      doc: 'Oms Received Execution Report Rejection For An Active Order'
    032000:
      id: 'field_missing_or_incorrect'
      doc: 'Field Missing Or Incorrect'
    032001:
      id: 'line_not_available_or_busy'
      doc: 'Li Ne Not Available Or Busy'
    032002:
      id: 'line_internal_error'
      doc: 'Li Ne Internal Error'
    032003:
      id: 'line_recovering_or_starting_up'
      doc: 'Li Ne Recovering Or Starting Up'
    032004:
      id: 'internal_gateway_error_message_forwarding_failure'
      doc: 'Internal Gateway Error Message Forwarding Failure'
    032005:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    032006:
      id: 'duplicate_order'
      doc: 'Duplicate Order'
    032007:
      id: 'missing_account_field'
      doc: 'Missing Account Field'
    032008:
      id: 'unknown_account'
      doc: 'Unknown Account'
    032009:
      id: 'unknown_firmid_for_routing'
      doc: 'Unknown Firm Id For Routing'
    032010:
      id: 'duplicate_firmid'
      doc: 'Duplicate Firm Id'
    032011:
      id: 'duplicate_sender_location'
      doc: 'Duplicate Sender Location'
    032012:
      id: 'duplicate_entering_trader'
      doc: 'Duplicate Entering Trader'
    032013:
      id: 'firm_or_trader_is_missing_in_nondma_order'
      doc: 'Firm Or Trader Is Missing In Non Dma Order'
    032014:
      id: 'firm_or_account_is_missing_in_dma_order'
      doc: 'Firm Or Account Is Missing In Dma Order'
    032015:
      id: 'same_participants_on_both_sides_or_invalid_sides'
      doc: 'Same Participants On Both Sides Or Invalid Sides'
    032016:
      id: 'buy_side_and_sell_side_having_different_firmids'
      doc: 'Buy Side And Sell Side Having Different Firm I Ds'
    032017:
      id: 'buy_side_and_sell_side_trading_different_assets'
      doc: 'Buy Side And Sell Side Trading Different Assets'
    032018:
      id: 'invalid_price_032018'
      doc: 'Invalid Price'
    032019:
      id: 'line_overloaded'
      doc: 'Li Ne Overloaded'
    032020:
      id: 'line_administratively_blocked'
      doc: 'Li Ne Administratively Blocked'
    032021:
      id: 'invalid_price_032021'
      doc: 'Invalid Price'
    032022:
      id: 'system_overloaded'
      doc: 'System Overloaded'
    032023:
      id: 'system_error'
      doc: 'System Error'
    033000:
      id: 'throttle_limit_reached'
      doc: 'Throttle Limit Reached'
    033001:
      id: 'invalid_security_id'
      doc: 'Invalid Security Id'
    033002:
      id: 'unknown_market_segment_id'
      doc: 'Unknown Market Segment Id'
    033003:
      id: 'field_missing_or_incorrect_033003'
      doc: 'Field Missing Or Incorrect'
    033050:
      id: 'system_error_033050'
      doc: 'System Error'
  settltype_optional:
    0x30:
      id: 'buyers_discretion'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'sellers_discretion'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'mutual'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ref_msg_type:
    0:
      id: 'negotiate'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'negotiate_response'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'negotiate_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'establish'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'establish_ack'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'establish_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'terminate'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'not_applied'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'retransmit_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'retransmission'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'retransmit_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'sequence'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'business_message_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'simple_new_order'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'simple_modify_order'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'new_order_single'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'order_cancel_replace_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'order_cancel_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'new_order_cross'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'execution_report_new'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'execution_report_modify'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'execution_report_cancel'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'execution_report_trade'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'execution_report_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'execution_report_forward'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'security_definition_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'security_definition_response'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'order_mass_action_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'order_mass_action_report'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'quote_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'quote_status_report'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'quote'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'quote_cancel'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'quote_request_reject'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'position_maintenance_cancel_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'position_maintenance_request'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'position_maintenance_report'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'allocation_instruction'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'allocation_report'
      doc: 'MessageType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_side:
    0x31:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_response_type:
    1:
      id: 'accept_security_proposal_as_is'
      doc: 'SecurityResponseType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'reject_security_proposal'
      doc: 'SecurityResponseType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'accept_security_as_proposal_with_revisions'
      doc: 'SecurityResponseType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  settltype:
    0x30:
      id: 'buyers_discretion'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'sellers_discretion'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'mutual'
      doc: 'SettlType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  execute_underlying_trade:
    0x30:
      id: 'no_underlying_trade'
      doc: 'ExecuteUnderlyingTrade Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'underlying_opposing_trade'
      doc: 'ExecuteUnderlyingTrade Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  quote_reject_reason:
    009999:
      id: 'technical_error_function_not_performed'
      doc: 'Technical Error Function Not Performed'
    008006:
      id: 'exercise_price_not_allowed'
      doc: 'Exercise Price Not Allowed'
    008007:
      id: 'no_positions_blocked'
      doc: 'No Positions Blocked'
    008008:
      id: 'quantity_doesnt_match_with_the_original_request_quantity_on_original_request_quantity_on_original_request'
      doc: 'Quantity Doesnt Match With The Original Request Quantity On Original Request Quantity On Original Request'
    008011:
      id: 'exercise_must_be_on_maturity_date'
      doc: 'Exercise Must Be On Maturity Date'
    008014:
      id: 'function_not_available_this_time'
      doc: 'Function Not Available This Time'
    008015:
      id: 'blocking_quantity_more_than_999999999'
      doc: 'Blocking Quantity More Than 999999999'
    008020:
      id: 'trade_does_not_belong_to_the_specified_firm_firm_id_xxx'
      doc: 'Trade Does Not Belong To The Specified Firm Firm Id Xxx'
    008021:
      id: 'blocking_qty_more_than_available_quantity'
      doc: 'Blocking Qty More Than Available Quantity'
    008022:
      id: 'there_arent_positions_available_to_exercise'
      doc: 'There Arent Positions Available To Exercise'
    008023:
      id: 'total_qty_must_be_the_sum_of_all_allocqty'
      doc: 'Total Qty Must Be The Sum Of All Alloc Qty'
    008024:
      id: 'trade_already_cancelled_or_does_not_exist_trade_id_xxx'
      doc: 'Trade Already Cancelled Or Does Not Exist Trade Id Xxx'
    008027:
      id: 'available_quantity_to_block_is_zero'
      doc: 'Available Quantity To Block Is Zero'
    008028:
      id: 'invalid_operation_for_contract_type'
      doc: 'Invalid Operation For Contract Type'
    008036:
      id: 'function_closed_or_suspended'
      doc: 'Function Closed Or Suspended'
    008039:
      id: 'exercise_price_outside_required_moneyness'
      doc: 'Exercise Price Outside Required Moneyness'
    008040:
      id: 'invalid_exercise_request_id_to_cancel'
      doc: 'Invalid Exercise Request Id To Cancel'
    008059:
      id: 'invalid_blocking_id_to_unblock'
      doc: 'Invalid Blocking Id To Unblock'
    008062:
      id: 'invalid_quantity_to_unblock'
      doc: 'Invalid Quantity To Unblock'
    008063:
      id: 'on_behalf_operation_not_allowed_during_ccr_recovery'
      doc: 'On Behalf Operation Not Allowed During Ccr Recovery'
    008065:
      id: 'problem_parsing_incoming_message'
      doc: 'Problem Parsing Incoming Message'
    008066:
      id: 'exercise_quantity_should_be_greater_than_zero'
      doc: 'Exercise Quantity Should Be Greater Than Zero'
    008069:
      id: 'contrary_exercise_already_registered_for_this_position'
      doc: 'Contrary Exercise Already Registered For This Position'
    008070:
      id: 'inthemoney_contract_allows_contrary_exercise_to_not_exercise_automatically_only'
      doc: 'Inthemoney Contract Allows Contrary Exercise To Not Exercise Automatically Only'
    008071:
      id: 'atoutthemoney_contract_allows_contrary_exercise_to_exercise_automatically_only'
      doc: 'At Outthemoney Contract Allows Contrary Exercise To Exercise Automatically Only'
    008072:
      id: 'dma_is_not_allowed_to_request_contrary_exercise'
      doc: 'Dma Is Not Allowed To Request Contrary Exercise'
    008073:
      id: 'contrary_exercises_can_only_be_requested_by_default_link_or_position_owner_with_direct_access_on_absence_of_default_link'
      doc: 'Contrary Exercises Can Only Be Requested By Default Link Or Position Owner With Direct Access On Absence Of Default Link'
    008074:
      id: 'contrary_exercise_invalid_operation'
      doc: 'Contrary Exercise Invalid Operation'
    008075:
      id: 'threshold_must_not_be_informed'
      doc: 'Threshold Must Not Be Informed'
  quote_status:
    7:
      id: 'expired'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0:
      id: 'accepted'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'rejected'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'quote_not_found'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'pending'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'pass_field'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'canceled'
      doc: 'QuoteStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  quote_status_response_to:
    0x30:
      id: 'quote'
      doc: 'QuoteStatusResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'quote_request'
      doc: 'QuoteStatusResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'quote_cancel'
      doc: 'QuoteStatusResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'quote_request_reject'
      doc: 'QuoteStatusResponseTo Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side_optional:
    0x31:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pos_trans_type:
    1:
      id: 'exercise'
      doc: 'PosTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'automatic_exercise'
      doc: 'PosTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'exercise_not_automatic'
      doc: 'PosTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contrary_instruction_indicator:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pos_maint_action:
    0x31:
      id: 'new_field'
      doc: 'PosMaintAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'cancel'
      doc: 'PosMaintAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pos_maint_status:
    0x30:
      id: 'accepted'
      doc: 'PosMaintStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'rejected'
      doc: 'PosMaintStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'completed'
      doc: 'PosMaintStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x39:
      id: 'not_executed'
      doc: 'PosMaintStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pos_type:
    0x54:
      id: 'transaction_quantity'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'start_of_day_qty'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'option_exercise_qty'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'blocked_qty'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'uncovered_qty'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'covered_qty'
      doc: 'PosType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_trans_type:
    0x30:
      id: 'new_field'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'cancel'
      doc: 'AllocTransType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_type:
    0x38:
      id: 'request_to_intermediary'
      doc: 'AllocType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_no_orders_type:
    0x30:
      id: 'not_specified'
      doc: 'AllocNoOrdersType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_report_type:
    0x38:
      id: 'request_to_intermediary'
      doc: 'AllocReportType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  alloc_status:
    0x30:
      id: 'accepted'
      doc: 'AllocStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'rejected_by_intermediary'
      doc: 'AllocStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_action_type:
    2:
      id: 'release_orders_from_suspension'
      doc: 'MassActionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_orders'
      doc: 'MassActionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancel_and_suspend_orders'
      doc: 'MassActionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_action_scope:
    6:
      id: 'all_orders_for_a_trading_session'
      doc: 'MassActionScope Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_cancel_restatement_reason:
    202:
      id: 'order_mass_action_from_client_request'
      doc: 'ExecRestatementReasonValidForMassCancel Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    207:
      id: 'mass_cancel_order_due_to_operational_error_request'
      doc: 'ExecRestatementReasonValidForMassCancel Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_action_response:
    0x30:
      id: 'rejected'
      doc: 'MassActionResponse Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'accepted'
      doc: 'MassActionResponse Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_action_reject_reason:
    0:
      id: 'mass_action_not_supported'
      doc: 'MassActionRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_or_unknown_market_segment'
      doc: 'MassActionRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'MassActionRejectReason Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

