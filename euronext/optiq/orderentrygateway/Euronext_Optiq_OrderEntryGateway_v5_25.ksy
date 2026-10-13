# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq OrderEntryGateway Sbe v5.25
#
# Protocol:
#   Organization: Euronext
#   Protocol: Order Entry Gateway
#   Encoding: Simple Binary Encoding
#   Version: 5.25
#   Date: 5/16/2023
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
  id: euronext_optiq_orderentrygateway_sbe_v5_25
  title: Euronext Optiq OrderEntryGateway Sbe v5.25
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Order Entry Gateway Sbe v5.25'
doc-ref: https://connect2.euronext.com

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Optiq Tcp Message'

types:
  message_struct:
    seq:
      - id: frame_header
        type: frame_header
        doc: 'Optiq length prefix, read before the message it frames'
      - id: message_header
        type: message_header
        doc: 'Optiq Sbe message header — message identifiers and length of message root'
      - id: payload
        size: frame_header.frame - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::new_order_message': new_order_message
            'template_id::ack_message': ack_message
            'template_id::fill_message': fill_message
            'template_id::kill_message': kill_message
            'template_id::cancel_replace_message': cancel_replace_message
            'template_id::reject_message': reject_message
            'template_id::quotes_message': quotes_message
            'template_id::quote_ack_message': quote_ack_message
            'template_id::quote_request_message': quote_request_message
            'template_id::cancel_request_message': cancel_request_message
            'template_id::mass_cancel_message': mass_cancel_message
            'template_id::mass_cancel_ack_message': mass_cancel_ack_message
            'template_id::open_order_request_message': open_order_request_message
            'template_id::ownership_request_ack_message': ownership_request_ack_message
            'template_id::ownership_request_message': ownership_request_message
            'template_id::trade_bust_notification_message': trade_bust_notification_message
            'template_id::collar_breach_confirmation_message': collar_breach_confirmation_message
            'template_id::price_input_message': price_input_message
            'template_id::liquidity_provider_command_message': liquidity_provider_command_message
            'template_id::ask_for_quote_message': ask_for_quote_message
            'template_id::request_for_execution_message': request_for_execution_message
            'template_id::rfq_notification_message': rfq_notification_message
            'template_id::rfq_matching_status_message': rfq_matching_status_message
            'template_id::rfqlp_matching_status_message': rfqlp_matching_status_message
            'template_id::user_notification_message': user_notification_message
            'template_id::mm_sign_in_message': mm_sign_in_message
            'template_id::mm_sign_in_ack_message': mm_sign_in_ack_message
            'template_id::instrument_synchronization_list_message': instrument_synchronization_list_message
            'template_id::synchronization_time_message': synchronization_time_message
            'template_id::security_definition_request_message': security_definition_request_message
            'template_id::security_definition_ack_message': security_definition_ack_message
            'template_id::mm_protection_request_message': mm_protection_request_message
            'template_id::mm_protection_ack_message': mm_protection_ack_message
            'template_id::new_wholesale_order_message': new_wholesale_order_message
            'template_id::wholesale_order_ack_message': wholesale_order_ack_message
            'template_id::request_for_implied_execution_message': request_for_implied_execution_message
            'template_id::cross_order_message': cross_order_message
            'template_id::rfq_audit_message': rfq_audit_message
            'template_id::wave_for_liquidity_message': wave_for_liquidity_message
            'template_id::wave_for_liquidity_notification_message': wave_for_liquidity_notification_message
            'template_id::clear_book_message': clear_book_message
            'template_id::logon_message': logon_message
            'template_id::logon_ack_message': logon_ack_message
            'template_id::logon_reject_message': logon_reject_message
            'template_id::logout_message': logout_message
            'template_id::technical_reject_message': technical_reject_message
            'template_id::declaration_entry_message': declaration_entry_message
            'template_id::declaration_entry_ack_message': declaration_entry_ack_message
            'template_id::declaration_notice_message': declaration_notice_message
            'template_id::declaration_cancel_and_refusal_message': declaration_cancel_and_refusal_message
            'template_id::fund_price_input_message': fund_price_input_message
            'template_id::fund_price_input_ack_message': fund_price_input_ack_message
            'template_id::declaration_entry_reject_message': declaration_entry_reject_message
  frame_header:
    seq:
      - id: frame
        type: u2
        doc: 'Total bytes of packet including this header'
  message_header:
    seq:
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
  new_order_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: order_px_optional
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: lp_role_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: execution_instruction
        type: execution_instruction
        doc: 'ExecutionInstruction_set bit set'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
      - id: non_executing_client_id
        type: u2_nullable
        doc: 'nonExecutingClientID. Nullable, No Value = 65535'
      - id: ioi_id_optional
        type: s8_nullable
        doc: 'iOIID. Nullable, No Value = -9223372036854775808'
      - id: free_text_groups
        type: free_text_groups
        doc: 'FreeTextSection Block'
      - id: mifid_short_codes_groups
        type: mifid_short_codes_groups
        doc: 'MiFIDShortcodes Block'
      - id: order_optional_fields_groups
        type: order_optional_fields_groups
        doc: 'OptionalFields Block'
      - id: order_clearing_fields_groups
        type: order_clearing_fields_groups
        doc: 'ClearingFields Block'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
      - id: other_not_used_groups
        type: other_not_used_groups
        doc: 'NotUsedGroup2 Block'
      - id: additional_infos_groups
        type: additional_infos_groups
        doc: 'AdditionalInfos Block'
  execution_instruction:
    meta:
      bit-endian: le
    seq:
      - id: stp_resting_order
        type: b1
        doc: 'STPRestingOrder'
      - id: stp_incoming_order
        type: b1
        doc: 'STPIncomingOrder'
      - id: disclosed_quantity_randomization
        type: b1
        doc: 'DisclosedQuantityRandomization'
      - id: disabled_cancel_on_disconnect_indicator
        type: b1
        doc: 'DisabledCancelOnDisconnectIndicator'
      - id: rfq_answer
        type: b1
        doc: 'RFQAnswer'
      - id: rfq_confirmation
        type: b1
        doc: 'RFQConfirmation'
      - id: conditional_order
        type: b1
        doc: 'ConditionalOrder'
      - id: stp_both_orders
        type: b1
        doc: 'STPBothOrders'
  dark_execution_instruction:
    meta:
      bit-endian: le
    seq:
      - id: dark_indicator
        type: b1
        doc: 'DarkIndicator'
      - id: deferred_trade_indicator
        type: b1
        doc: 'DeferredTradeIndicator'
      - id: displayed_order_interaction
        type: b1
        doc: 'DisplayedOrderInteraction'
      - id: sweep_order_indicator
        type: b1
        doc: 'SweepOrderIndicator'
      - id: minimum_quantity_type
        type: b1
        doc: 'MinimumQuantityType'
      - id: reserved_3
        type: b3
        doc: '3 reserved bits'
  mifid_indicators:
    meta:
      bit-endian: le
    seq:
      - id: dea_indicator
        type: b1
        doc: 'DEAIndicator'
      - id: investment_algo_indicator
        type: b1
        doc: 'InvestmentAlgoIndicator'
      - id: execution_algo_indicator
        type: b1
        doc: 'ExecutionAlgoIndicator'
      - id: commodity_derivative_indicator
        type: b1
        doc: 'CommodityDerivativeIndicator'
      - id: deferral_indicator
        type: b1
        doc: 'DeferralIndicator'
      - id: frmaramplp
        type: b1
        doc: 'FRMARAMPLP'
      - id: reserved_2
        type: b2
        doc: '2 reserved bits'
  free_text_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: new_order_message_free_text_section_group
        type: new_order_message_free_text_section_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'FreeTextSection'
  group_size_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  new_order_message_free_text_section_group:
    seq:
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
  mifid_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mifid_short_codes_group
        type: mifid_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MiFIDShortcodes'
  mifid_short_codes_group:
    seq:
      - id: investment_decision_w_firm_short_code
        type: s4_nullable
        doc: 'investmentDecisionWFirmShortCode. Nullable, No Value = -2147483648'
      - id: non_executing_broker_short_code
        type: s4_nullable
        doc: 'nonExecutingBrokerShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
  order_optional_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_optional_fields_group
        type: order_optional_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFields'
  order_optional_fields_group:
    seq:
      - id: stop_px
        type: s8_nullable
        doc: 'stopPx. Nullable, No Value = -9223372036854775808'
      - id: undisclosed_price
        type: s8_nullable
        doc: 'undisclosedPrice. Nullable, No Value = -9223372036854775808'
      - id: disclosed_qty
        type: u8_nullable
        doc: 'disclosedQty. Nullable, No Value = 18446744073709551615'
      - id: min_order_qty
        type: u8_nullable
        doc: 'minOrderQty. Nullable, No Value = 18446744073709551615'
      - id: quote_req_id_optional
        type: u8_nullable
        doc: 'quoteReqID. Nullable, No Value = 18446744073709551615'
      - id: order_expiration_time
        type: u4_nullable
        doc: 'orderExpirationTime. Nullable, No Value = 4294967295'
      - id: order_expiration_date
        type: u2_nullable
        doc: 'orderExpirationDate. Nullable, No Value = 65535'
      - id: peg_offset
        type: s1_nullable
        doc: 'pegOffset. Nullable, No Value = -128'
      - id: trading_session
        type: trading_session
        doc: 'TradingSessionValidity_set bit set. Nullable, No Value = 255'
      - id: undisclosed_iceberg_type
        type: u1_nullable
        doc: 'undisclosedIcebergType. Nullable, No Value = 255'
      - id: stop_triggered_time_in_force
        type: u1_nullable
        doc: 'stopTriggeredTimeInForce. Nullable, No Value = 255'
  trading_session:
    meta:
      bit-endian: le
    seq:
      - id: unused_trading_session_validityset_0
        type: b1
        doc: 'Unused TradingSessionValidity_set 0'
      - id: session_1
        type: b1
        doc: 'Session1'
      - id: session_2
        type: b1
        doc: 'Session2'
      - id: session_3
        type: b1
        doc: 'Session3'
      - id: session_4
        type: b1
        doc: 'Session4'
      - id: reserved_3
        type: b3
        doc: '3 reserved bits'
  order_clearing_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_clearing_fields_group
        type: order_clearing_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingFields'
  order_clearing_fields_group:
    seq:
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: client_id
        type: str_8_nullable
        doc: 'clientID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: account_type_cross
        type: u1_nullable
        doc: 'accountTypeCross. Nullable, No Value = 255'
      - id: trading_capacity_cross
        type: u1_nullable
        doc: 'tradingCapacityCross. Nullable, No Value = 255'
  open_close:
    meta:
      bit-endian: le
    seq:
      - id: field_actively_used
        type: b1
        doc: 'FieldActivelyUsed'
      - id: leg_1
        type: b1
        doc: 'Leg1'
      - id: leg_2
        type: b1
        doc: 'Leg2'
      - id: leg_3
        type: b1
        doc: 'Leg3'
      - id: leg_4
        type: b1
        doc: 'Leg4'
      - id: leg_5
        type: b1
        doc: 'Leg5'
      - id: leg_6
        type: b1
        doc: 'Leg6'
      - id: leg_7
        type: b1
        doc: 'Leg7'
      - id: leg_8
        type: b1
        doc: 'Leg8'
      - id: leg_9
        type: b1
        doc: 'Leg9'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
  not_used_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: not_used_group
        size: group_size_encoding.block_length_short
  other_not_used_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: other_not_used_group
        size: group_size_encoding.block_length_short
  additional_infos_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: additional_infos_group
        type: additional_infos_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'AdditionalInfos'
  additional_infos_group:
    seq:
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
  ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: ack_type
        type: u1
        enum: ack_type
        doc: 'ackType'
      - id: ack_phase
        type: u1_nullable
        doc: 'ackPhase. Nullable, No Value = 255'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: order_priority
        type: u8_nullable
        doc: 'orderPriority. Nullable, No Value = 18446744073709551615'
      - id: order_px_optional
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_qty_optional
        type: u8_nullable
        doc: 'orderQty. Nullable, No Value = 18446744073709551615'
      - id: ack_qualifiers
        type: ack_qualifiers
        doc: 'AckQualifiers_set bit set'
      - id: mifid_fields_groups
        type: mifid_fields_groups
        doc: 'MiFIDFields Block'
  ack_qualifiers:
    meta:
      bit-endian: le
    seq:
      - id: dark_indicator
        type: b1
        doc: 'DarkIndicator'
      - id: queue_indicator
        type: b1
        doc: 'QueueIndicator'
      - id: request_with_client_order_id
        type: b1
        doc: 'RequestWithClientOrderID'
      - id: use_of_cross_partition
        type: b1
        doc: 'UseOfCrossPartition'
      - id: internal_1
        type: b1
        doc: 'Internal1'
      - id: internal_2
        type: b1
        doc: 'Internal2'
      - id: execution_upon_entry_flag_enabled
        type: b1
        doc: 'ExecutionUponEntryFlagEnabled'
      - id: executed_upon_entry_flag
        type: b1
        doc: 'ExecutedUponEntryFlag'
  mifid_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mifid_fields_group
        type: mifid_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MiFIDFields'
  mifid_fields_group:
    seq:
      - id: execution_within_firm_short_code_optional
        type: s4_nullable
        doc: 'executionWithinFirmShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: mifid_indicators_optional
        type: mifid_indicators_optional
        doc: 'MiFIDIndicators_set bit set. Nullable, No Value = 255'
  mifid_indicators_optional:
    meta:
      bit-endian: le
    seq:
      - id: dea_indicator
        type: b1
        doc: 'DEAIndicator'
      - id: investment_algo_indicator
        type: b1
        doc: 'InvestmentAlgoIndicator'
      - id: execution_algo_indicator
        type: b1
        doc: 'ExecutionAlgoIndicator'
      - id: commodity_derivative_indicator
        type: b1
        doc: 'CommodityDerivativeIndicator'
      - id: deferral_indicator
        type: b1
        doc: 'DeferralIndicator'
      - id: frmaramplp
        type: b1
        doc: 'FRMARAMPLP'
      - id: reserved_2
        type: b2
        doc: '2 reserved bits'
  fill_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: trade_time
        type: u8
        doc: 'tradeTime'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'tradeType'
      - id: trade_qualifier
        type: trade_qualifier
        doc: 'TradeQualifier_set bit set'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: last_traded_px
        type: s8
        doc: 'lastTradedPx'
      - id: last_shares
        type: u8
        doc: 'lastShares'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: execution_phase
        type: u1
        enum: execution_phase
        doc: 'executionPhase'
      - id: lis_transaction_id
        type: u4_nullable
        doc: 'lISTransactionID. Nullable, No Value = 4294967295'
      - id: escb_membership
        type: u1_nullable
        doc: 'eSCBMembership. Nullable, No Value = 255'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
      - id: fill_optional_field_groups
        type: fill_optional_field_groups
        doc: 'OptionalFieldsFill Block'
      - id: fill_strategy_field_groups
        type: fill_strategy_field_groups
        doc: 'StrategyFields Block'
      - id: mifid_fields_groups
        type: mifid_fields_groups
        doc: 'MiFIDFields Block'
      - id: fill_derivatives_field_groups
        type: fill_derivatives_field_groups
        doc: 'OptionalFieldsDerivatives Block'
  trade_qualifier:
    meta:
      bit-endian: le
    seq:
      - id: uncrossing_trade
        type: b1
        doc: 'UncrossingTrade'
      - id: first_trade_price
        type: b1
        doc: 'FirstTradePrice'
      - id: passive_order
        type: b1
        doc: 'PassiveOrder'
      - id: aggressive_order
        type: b1
        doc: 'AggressiveOrder'
      - id: trade_creation_by_market_operations
        type: b1
        doc: 'TradeCreationByMarketOperations'
      - id: nav_trade_expressed_in_bps
        type: b1
        doc: 'NAVTradeExpressedInBps'
      - id: nav_trade_expressed_in_price_currency
        type: b1
        doc: 'NAVTradeExpressedInPriceCurrency'
      - id: deferred_publication
        type: b1
        doc: 'DeferredPublication'
  fill_optional_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: fill_optional_field_group
        type: fill_optional_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFieldsFill'
  fill_optional_field_group:
    seq:
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: other_leg_last_px
        type: s8_nullable
        doc: 'otherLegLastPx. Nullable, No Value = -9223372036854775808'
      - id: package_id
        type: str_12_nullable
        doc: 'packageID. Nullable, No Value = 0'
      - id: underlying_instrument_id
        type: u4_nullable
        doc: 'underlyingInstrumentID. Nullable, No Value = 4294967295'
  fill_strategy_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: fill_strategy_field_group
        type: fill_strategy_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StrategyFields'
  fill_strategy_field_group:
    seq:
      - id: leg_last_px
        type: s8_nullable
        doc: 'legLastPx. Nullable, No Value = -9223372036854775808'
      - id: leg_last_qty
        type: u8_nullable
        doc: 'legLastQty. Nullable, No Value = 18446744073709551615'
      - id: leg_instrument_id
        type: u4_nullable
        doc: 'legInstrumentID. Nullable, No Value = 4294967295'
      - id: leg_side_optional
        type: u1_nullable
        doc: 'legSide. Nullable, No Value = 255'
      - id: execution_id_optional
        type: u4_nullable
        doc: 'executionID. Nullable, No Value = 4294967295'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
  fill_derivatives_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: fill_derivatives_field_group
        type: fill_derivatives_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFieldsDerivatives'
  fill_derivatives_field_group:
    seq:
      - id: evaluated_price
        type: s8_nullable
        doc: 'evaluatedPrice. Nullable, No Value = -9223372036854775808'
      - id: message_price_notation
        type: u1_nullable
        doc: 'messagePriceNotation. Nullable, No Value = 255'
      - id: final_symbol_index
        type: u4_nullable
        doc: 'finalSymbolIndex. Nullable, No Value = 4294967295'
      - id: final_execution_id
        type: u4_nullable
        doc: 'finalExecutionID. Nullable, No Value = 4294967295'
  kill_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: kill_reason
        type: u2
        enum: kill_reason
        doc: 'killReason'
      - id: ack_qualifiers_optional
        type: ack_qualifiers_optional
        doc: 'AckQualifiers_set bit set. Nullable, No Value = 255'
      - id: mifid_fields_groups
        type: mifid_fields_groups
        doc: 'MiFIDFields Block'
  ack_qualifiers_optional:
    meta:
      bit-endian: le
    seq:
      - id: dark_indicator
        type: b1
        doc: 'DarkIndicator'
      - id: queue_indicator
        type: b1
        doc: 'QueueIndicator'
      - id: request_with_client_order_id
        type: b1
        doc: 'RequestWithClientOrderID'
      - id: use_of_cross_partition
        type: b1
        doc: 'UseOfCrossPartition'
      - id: internal_1
        type: b1
        doc: 'Internal1'
      - id: internal_2
        type: b1
        doc: 'Internal2'
      - id: execution_upon_entry_flag_enabled
        type: b1
        doc: 'ExecutionUponEntryFlagEnabled'
      - id: executed_upon_entry_flag
        type: b1
        doc: 'ExecutedUponEntryFlag'
  cancel_replace_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: order_px_optional
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: lp_role_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: execution_instruction
        type: execution_instruction
        doc: 'ExecutionInstruction_set bit set'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
      - id: free_text_groups
        type: free_text_groups
        doc: 'FreeTextSection Block'
      - id: cancel_replace_optional_field_groups
        type: cancel_replace_optional_field_groups
        doc: 'OptionalFields Block'
      - id: cancel_replace_clearing_fields_groups
        type: cancel_replace_clearing_fields_groups
        doc: 'ClearingFields Block'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
      - id: other_not_used_groups
        type: other_not_used_groups
        doc: 'NotUsedGroup2 Block'
      - id: additional_infos_groups
        type: additional_infos_groups
        doc: 'AdditionalInfos Block'
  cancel_replace_optional_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: cancel_replace_optional_field_group
        type: cancel_replace_optional_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFields'
  cancel_replace_optional_field_group:
    seq:
      - id: stop_px
        type: s8_nullable
        doc: 'stopPx. Nullable, No Value = -9223372036854775808'
      - id: peg_offset
        type: s1_nullable
        doc: 'pegOffset. Nullable, No Value = -128'
      - id: undisclosed_price
        type: s8_nullable
        doc: 'undisclosedPrice. Nullable, No Value = -9223372036854775808'
      - id: disclosed_qty
        type: u8_nullable
        doc: 'disclosedQty. Nullable, No Value = 18446744073709551615'
      - id: order_expiration_time
        type: u4_nullable
        doc: 'orderExpirationTime. Nullable, No Value = 4294967295'
      - id: order_expiration_date
        type: u2_nullable
        doc: 'orderExpirationDate. Nullable, No Value = 65535'
      - id: trading_session
        type: trading_session
        doc: 'TradingSessionValidity_set bit set. Nullable, No Value = 255'
      - id: stop_triggered_time_in_force
        type: u1_nullable
        doc: 'stopTriggeredTimeInForce. Nullable, No Value = 255'
      - id: undisclosed_iceberg_type
        type: u1_nullable
        doc: 'undisclosedIcebergType. Nullable, No Value = 255'
  cancel_replace_clearing_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: cancel_replace_clearing_fields_group
        type: cancel_replace_clearing_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingFields'
  cancel_replace_clearing_fields_group:
    seq:
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: client_id
        type: str_8_nullable
        doc: 'clientID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
  reject_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id_optional
        type: str_8_nullable
        doc: 'firmID. Nullable, No Value = 0'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: rejected_message
        type: u1_nullable
        doc: 'rejectedMessage. Nullable, No Value = 255'
      - id: error_code
        type: u2
        doc: 'errorCode'
      - id: rejected_message_id
        type: u2_nullable
        doc: 'rejectedMessageID. Nullable, No Value = 65535'
      - id: ack_qualifiers_optional
        type: ack_qualifiers_optional
        doc: 'AckQualifiers_set bit set. Nullable, No Value = 255'
      - id: collar_fields_groups
        type: collar_fields_groups
        doc: 'CollarFields Block'
      - id: mifid_fields_groups
        type: mifid_fields_groups
        doc: 'MiFIDFields Block'
  collar_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: collar_fields_group
        type: collar_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'CollarFields'
  collar_fields_group:
    seq:
      - id: collar_rej_type
        type: u1_nullable
        doc: 'collarRejType. Nullable, No Value = 255'
      - id: breached_collar_price
        type: s8_nullable
        doc: 'breachedCollarPrice. Nullable, No Value = -9223372036854775808'
  quotes_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: lp_role
        type: u1
        enum: lp_role
        doc: 'lPRole'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: rfe_answer
        type: u1
        doc: 'rFEAnswer'
      - id: execution_instruction_optional
        type: execution_instruction_optional
        doc: 'ExecutionInstruction_set bit set. Nullable, No Value = 255'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
      - id: mifid_short_codes_groups
        type: mifid_short_codes_groups
        doc: 'MiFIDShortcodes Block'
      - id: clearing_dataset_groups
        type: clearing_dataset_groups
        doc: 'ClearingDataset Block'
      - id: quotes_rep_groups
        type: quotes_rep_groups
        doc: 'QuotesRep Block'
  execution_instruction_optional:
    meta:
      bit-endian: le
    seq:
      - id: stp_resting_order
        type: b1
        doc: 'STPRestingOrder'
      - id: stp_incoming_order
        type: b1
        doc: 'STPIncomingOrder'
      - id: disclosed_quantity_randomization
        type: b1
        doc: 'DisclosedQuantityRandomization'
      - id: disabled_cancel_on_disconnect_indicator
        type: b1
        doc: 'DisabledCancelOnDisconnectIndicator'
      - id: rfq_answer
        type: b1
        doc: 'RFQAnswer'
      - id: rfq_confirmation
        type: b1
        doc: 'RFQConfirmation'
      - id: conditional_order
        type: b1
        doc: 'ConditionalOrder'
      - id: stp_both_orders
        type: b1
        doc: 'STPBothOrders'
  clearing_dataset_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: clearing_dataset_group
        type: clearing_dataset_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingDataset'
  clearing_dataset_group:
    seq:
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: client_id
        type: str_8_nullable
        doc: 'clientID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
  quotes_rep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: quotes_rep_group
        type: quotes_rep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'QuotesRep'
  quotes_rep_group:
    seq:
      - id: bid_size
        type: u8_nullable
        doc: 'bidSize. Nullable, No Value = 18446744073709551615'
      - id: bid_px
        type: s8_nullable
        doc: 'bidPx. Nullable, No Value = -9223372036854775808'
      - id: offer_size
        type: u8_nullable
        doc: 'offerSize. Nullable, No Value = 18446744073709551615'
      - id: offer_px
        type: s8_nullable
        doc: 'offerPx. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
  quote_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: lp_role
        type: u1
        enum: lp_role
        doc: 'lPRole'
      - id: execution_within_firm_short_code_optional
        type: s4_nullable
        doc: 'executionWithinFirmShortCode. Nullable, No Value = -2147483648'
      - id: ack_qualifiers_optional
        type: ack_qualifiers_optional
        doc: 'AckQualifiers_set bit set. Nullable, No Value = 255'
      - id: quote_acks_groups
        type: quote_acks_groups
        doc: 'QuoteAcks Block'
  quote_acks_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: quote_acks_group
        type: quote_acks_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'QuoteAcks'
  quote_acks_group:
    seq:
      - id: bid_order_id
        type: u8_nullable
        doc: 'bidOrderID. Nullable, No Value = 18446744073709551615'
      - id: offer_order_id
        type: u8_nullable
        doc: 'offerOrderID. Nullable, No Value = 18446744073709551615'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: buy_revision_flag
        type: u1_nullable
        doc: 'buyRevisionFlag. Nullable, No Value = 255'
      - id: sell_revision_flag
        type: u1_nullable
        doc: 'sellRevisionFlag. Nullable, No Value = 255'
      - id: bid_error_code
        type: u2_nullable
        doc: 'bidErrorCode. Nullable, No Value = 65535'
      - id: offer_error_code
        type: u2_nullable
        doc: 'offerErrorCode. Nullable, No Value = 65535'
  quote_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: firm_id_publication
        type: u1_nullable
        doc: 'firmIDPublication. Nullable, No Value = 255'
      - id: end_client
        type: str_11_nullable
        doc: 'endClient. Nullable, No Value = 0'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: min_order_qty
        type: u8_nullable
        doc: 'minOrderQty. Nullable, No Value = 18446744073709551615'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
  cancel_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
      - id: other_not_used_groups
        type: other_not_used_groups
        doc: 'NotUsedGroup2 Block'
  mass_cancel_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: instrument_group_code
        type: str_2_nullable
        doc: 'instrumentGroupCode. Nullable, No Value = 0'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: contract_id
        type: u4_nullable
        doc: 'contractID. Nullable, No Value = 4294967295'
      - id: maturity
        type: str_8_nullable
        doc: 'maturity. Nullable, No Value = 0'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: option_type
        type: u1_nullable
        doc: 'optionType. Nullable, No Value = 255'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
      - id: target_execution_within_firm_short_code
        type: s4_nullable
        doc: 'targetExecutionWithinFirmShortCode. Nullable, No Value = -2147483648'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
      - id: other_not_used_groups
        type: other_not_used_groups
        doc: 'NotUsedGroup2 Block'
  mass_cancel_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oeg_in_from_me
        type: u8
        doc: 'oEGINFromME'
      - id: oeg_out_to_member
        type: u8
        doc: 'oEGOUTToMember'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: total_affected_orders
        type: s4
        doc: 'totalAffectedOrders'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: instrument_group_code
        type: str_2_nullable
        doc: 'instrumentGroupCode. Nullable, No Value = 0'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: contract_id
        type: u4_nullable
        doc: 'contractID. Nullable, No Value = 4294967295'
      - id: maturity
        type: str_8_nullable
        doc: 'maturity. Nullable, No Value = 0'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: option_type
        type: u1_nullable
        doc: 'optionType. Nullable, No Value = 255'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
      - id: ack_qualifiers_optional
        type: ack_qualifiers_optional
        doc: 'AckQualifiers_set bit set. Nullable, No Value = 255'
      - id: target_execution_within_firm_short_code
        type: s4_nullable
        doc: 'targetExecutionWithinFirmShortCode. Nullable, No Value = -2147483648'
      - id: mifid_fields_groups
        type: mifid_fields_groups
        doc: 'MiFIDFields Block'
  open_order_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
  ownership_request_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: total_affected_orders
        type: s4
        doc: 'totalAffectedOrders'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
  ownership_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: order_category
        type: u1_nullable
        doc: 'orderCategory. Nullable, No Value = 255'
  trade_bust_notification_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: last_traded_px
        type: s8
        doc: 'lastTradedPx'
      - id: last_shares
        type: u8
        doc: 'lastShares'
      - id: lis_transaction_id
        type: u4_nullable
        doc: 'lISTransactionID. Nullable, No Value = 4294967295'
      - id: parent_exec_id
        type: u4_nullable
        doc: 'parentExecID. Nullable, No Value = 4294967295'
      - id: parent_symbol_index
        type: u4_nullable
        doc: 'parentSymbolIndex. Nullable, No Value = 4294967295'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
      - id: parent_trade_unique_identifier
        type: str_16_nullable
        doc: 'parentTradeUniqueIdentifier. Nullable, No Value = 0'
  collar_breach_confirmation_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: order_id_optional
        type: u8_nullable
        doc: 'orderID. Nullable, No Value = 18446744073709551615'
      - id: orig_client_order_id
        type: s8_nullable
        doc: 'origClientOrderID. Nullable, No Value = -9223372036854775808'
  price_input_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: input_price_type
        type: u1
        enum: input_price_type
        doc: 'inputPriceType'
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
  liquidity_provider_command_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: lp_action_code
        type: u1
        enum: lp_action_code
        doc: 'lPActionCode'
  ask_for_quote_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: afq_reason
        type: u1
        enum: afq_reason
        doc: 'aFQReason'
  request_for_execution_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
  rfq_notification_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: rfq_update_type
        type: u1
        enum: rfq_update_type
        doc: 'rFQUpdateType'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: end_client
        type: str_11_nullable
        doc: 'endClient. Nullable, No Value = 0'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: min_order_qty
        type: u8_nullable
        doc: 'minOrderQty. Nullable, No Value = 18446744073709551615'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
  rfq_matching_status_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: potential_matching_px
        type: s8_nullable
        doc: 'potentialMatchingPX. Nullable, No Value = -9223372036854775808'
      - id: potential_matching_qty
        type: u8
        doc: 'potentialMatchingQty'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: number_of_lps
        type: u1_nullable
        doc: 'numberOfLPs. Nullable, No Value = 255'
      - id: recipient_type
        type: u1
        enum: recipient_type
        doc: 'recipientType'
  rfqlp_matching_status_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: potential_matching_qty
        type: u8
        doc: 'potentialMatchingQty'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
  user_notification_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: execution_within_firm_short_code_optional
        type: s4_nullable
        doc: 'executionWithinFirmShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: family_id
        type: str_8_nullable
        doc: 'familyID. Nullable, No Value = 0'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: user_status
        type: u1
        enum: user_status
        doc: 'userStatus'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: order_size_limit
        type: u8_nullable
        doc: 'orderSizeLimit. Nullable, No Value = 18446744073709551615'
      - id: order_amount_limit
        type: u8_nullable
        doc: 'orderAmountLimit. Nullable, No Value = 18446744073709551615'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
  mm_sign_in_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: logical_access_id
        type: u4
        doc: 'logicalAccessID'
      - id: oe_partition_id
        type: u2
        doc: 'oEPartitionID'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
  mm_sign_in_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: logical_access_id
        type: u4
        doc: 'logicalAccessID'
      - id: oe_partition_id
        type: u2
        doc: 'oEPartitionID'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
  instrument_synchronization_list_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: resynchronization_id
        type: u2
        doc: 'resynchronizationID'
      - id: instrument_synchronization_groups
        type: instrument_synchronization_groups
        doc: 'InstrumentSynchronizationSection Block'
  instrument_synchronization_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: instrument_synchronization_group
        type: instrument_synchronization_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'InstrumentSynchronizationSection'
  instrument_synchronization_group:
    seq:
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
  synchronization_time_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: resynchronization_id
        type: u2
        doc: 'resynchronizationID'
      - id: last_book_in_time
        type: u8
        doc: 'lastBookInTime'
  security_definition_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: security_req_id
        type: s8
        doc: 'securityReqID'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: strategy_code
        type: u1
        enum: strategy_code
        doc: 'strategyCode'
      - id: strategy_legs_groups
        type: strategy_legs_groups
        doc: 'StrategyLegs Block'
  strategy_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: strategy_legs_group
        type: strategy_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StrategyLegs'
  strategy_legs_group:
    seq:
      - id: leg_symbol_index
        type: u4
        doc: 'legSymbolIndex'
      - id: leg_ratio
        type: u4
        doc: 'legRatio'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'legSecurityType'
      - id: leg_put_or_call
        type: u1_nullable
        doc: 'legPutOrCall. Nullable, No Value = 255'
      - id: leg_price_optional
        type: s8_nullable
        doc: 'legPrice. Nullable, No Value = -9223372036854775808'
      - id: leg_strike_price
        type: s8_nullable
        doc: 'legStrikePrice. Nullable, No Value = -9223372036854775808'
      - id: leg_last_trading_date
        type: str_8_nullable
        doc: 'legLastTradingDate. Nullable, No Value = 0'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'legSide'
  security_definition_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: security_req_id
        type: s8
        doc: 'securityReqID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
  mm_protection_request_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: request_type
        type: u1
        enum: request_type
        doc: 'requestType'
      - id: mmp_request_groups
        type: mmp_request_groups
        doc: 'MMPSection Block'
  mmp_request_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mmp_request_group
        type: mmp_request_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MMPSection'
  mmp_request_group:
    seq:
      - id: protection_type
        type: u1
        enum: protection_type
        doc: 'protectionType'
      - id: protection_threshold
        type: u8_nullable
        doc: 'protectionThreshold. Nullable, No Value = 18446744073709551615'
      - id: breach_action
        type: u1_nullable
        doc: 'breachAction. Nullable, No Value = 255'
  mm_protection_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: mmp_execution_type
        type: mmp_execution_type
        doc: 'MMPExecutionType_set bit set'
      - id: mmp_ack_groups
        type: mmp_ack_groups
        doc: 'MMPSection2 Block'
  mmp_execution_type:
    meta:
      bit-endian: le
    seq:
      - id: notification
        type: b1
        doc: 'Notification'
      - id: acknowledgement
        type: b1
        doc: 'Acknowledgement'
      - id: pull
        type: b1
        doc: 'Pull'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  mmp_ack_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: mmp_ack_group
        type: mmp_ack_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MMPSection2'
  mmp_ack_group:
    seq:
      - id: protection_type_optional
        type: u1_nullable
        doc: 'protectionType. Nullable, No Value = 255'
      - id: protection_threshold
        type: u8_nullable
        doc: 'protectionThreshold. Nullable, No Value = 18446744073709551615'
      - id: breach_action
        type: u1_nullable
        doc: 'breachAction. Nullable, No Value = 255'
      - id: current_mmp_position
        type: s8_nullable
        doc: 'currentMMPPosition. Nullable, No Value = -9223372036854775808'
      - id: breach_status
        type: u1_nullable
        doc: 'breachStatus. Nullable, No Value = 255'
  new_wholesale_order_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: wholesale_trade_type
        type: u1
        enum: wholesale_trade_type
        doc: 'wholesaleTradeType'
      - id: lis_transaction_id
        type: u4_nullable
        doc: 'lISTransactionID. Nullable, No Value = 4294967295'
      - id: strategy_code_optional
        type: u1
        enum: strategy_code_optional
        doc: 'strategyCode. Nullable, No Value = 0'
      - id: price
        type: s8
        doc: 'price'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: wholesale_side
        type: u1
        enum: wholesale_side
        doc: 'wholesaleSide'
      - id: escb_membership
        type: u1_nullable
        doc: 'eSCBMembership. Nullable, No Value = 255'
      - id: message_price_notation
        type: u1_nullable
        doc: 'messagePriceNotation. Nullable, No Value = 255'
      - id: wholesale_legs_groups
        type: wholesale_legs_groups
        doc: 'WholesaleLegsRep Block'
      - id: wholesale_client_groups
        type: wholesale_client_groups
        doc: 'WholesaleClientRep Block'
  wholesale_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: wholesale_legs_group
        type: wholesale_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'WholesaleLegsRep'
  wholesale_legs_group:
    seq:
      - id: leg_symbol_index
        type: u4
        doc: 'legSymbolIndex'
      - id: leg_price
        type: s8
        doc: 'legPrice'
      - id: bid_quantity
        type: u8_nullable
        doc: 'bidQuantity. Nullable, No Value = 18446744073709551615'
      - id: offer_quantity
        type: u8_nullable
        doc: 'offerQuantity. Nullable, No Value = 18446744073709551615'
      - id: leg_side_optional
        type: u1_nullable
        doc: 'legSide. Nullable, No Value = 255'
      - id: leg_strike_price
        type: s8_nullable
        doc: 'legStrikePrice. Nullable, No Value = -9223372036854775808'
      - id: leg_ratio_optional
        type: u4_nullable
        doc: 'legRatio. Nullable, No Value = 4294967295'
      - id: leg_put_or_call
        type: u1_nullable
        doc: 'legPutOrCall. Nullable, No Value = 255'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'legSecurityType'
      - id: leg_last_trading_date
        type: str_8_nullable
        doc: 'legLastTradingDate. Nullable, No Value = 0'
  wholesale_client_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: wholesale_client_group
        type: wholesale_client_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'WholesaleClientRep'
  wholesale_client_group:
    seq:
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: non_executing_client_id
        type: u2_nullable
        doc: 'nonExecutingClientID. Nullable, No Value = 65535'
      - id: investment_decision_w_firm_short_code
        type: s4_nullable
        doc: 'investmentDecisionWFirmShortCode. Nullable, No Value = -2147483648'
      - id: non_executing_broker_short_code
        type: s4_nullable
        doc: 'nonExecutingBrokerShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: trading_capacity_optional
        type: u1_nullable
        doc: 'tradingCapacity. Nullable, No Value = 255'
  wholesale_order_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time_optional
        type: u8_nullable
        doc: 'sendingTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: wholesale_trade_type
        type: u1
        enum: wholesale_trade_type
        doc: 'wholesaleTradeType'
      - id: lis_transaction_id
        type: u4_nullable
        doc: 'lISTransactionID. Nullable, No Value = 4294967295'
      - id: strategy_code_optional
        type: u1
        enum: strategy_code_optional
        doc: 'strategyCode. Nullable, No Value = 0'
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: wholesale_side
        type: u1
        enum: wholesale_side
        doc: 'wholesaleSide'
      - id: escb_membership
        type: u1_nullable
        doc: 'eSCBMembership. Nullable, No Value = 255'
      - id: response_type
        type: u1
        enum: response_type
        doc: 'responseType'
      - id: error_code
        type: u2
        doc: 'errorCode'
      - id: ack_qualifiers
        type: ack_qualifiers
        doc: 'AckQualifiers_set bit set'
      - id: wholesale_ack_legs_groups
        type: wholesale_ack_legs_groups
        doc: 'WholesaleAckLegsRep Block'
      - id: wholesale_ack_clearing_groups
        type: wholesale_ack_clearing_groups
        doc: 'WholesaleAckClearingRep Block'
  wholesale_ack_legs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: wholesale_ack_legs_group
        type: wholesale_ack_legs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'WholesaleAckLegsRep'
  wholesale_ack_legs_group:
    seq:
      - id: leg_symbol_index
        type: u4
        doc: 'legSymbolIndex'
      - id: leg_bid_order_id
        type: u8_nullable
        doc: 'legBidOrderID. Nullable, No Value = 18446744073709551615'
      - id: leg_offer_order_id
        type: u8_nullable
        doc: 'legOfferOrderID. Nullable, No Value = 18446744073709551615'
      - id: leg_side_optional
        type: u1_nullable
        doc: 'legSide. Nullable, No Value = 255'
      - id: leg_error_code
        type: u2_nullable
        doc: 'legErrorCode. Nullable, No Value = 65535'
  wholesale_ack_clearing_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: wholesale_ack_clearing_group
        type: wholesale_ack_clearing_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'WholesaleAckClearingRep'
  wholesale_ack_clearing_group:
    seq:
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: investment_decision_w_firm_short_code
        type: s4_nullable
        doc: 'investmentDecisionWFirmShortCode. Nullable, No Value = -2147483648'
      - id: non_executing_broker_short_code
        type: s4_nullable
        doc: 'nonExecutingBrokerShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: non_executing_client_id
        type: u2_nullable
        doc: 'nonExecutingClientID. Nullable, No Value = 65535'
  request_for_implied_execution_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
  cross_order_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: order_px
        type: s8
        doc: 'orderPx'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: non_executing_client_id
        type: u2_nullable
        doc: 'nonExecutingClientID. Nullable, No Value = 65535'
      - id: order_actor_type
        type: u1
        enum: order_actor_type
        doc: 'orderActorType'
      - id: message_price_notation
        type: u1_nullable
        doc: 'messagePriceNotation. Nullable, No Value = 255'
      - id: free_text_groups
        type: free_text_groups
        doc: 'FreeTextSection Block'
      - id: mifid_short_codes_groups
        type: mifid_short_codes_groups
        doc: 'MiFIDShortcodes Block'
      - id: cross_clearing_fields_groups
        type: cross_clearing_fields_groups
        doc: 'ClearingFieldsX Block'
      - id: cross_strategy_fields_groups
        type: cross_strategy_fields_groups
        doc: 'StrategyFields Block'
  cross_clearing_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: cross_clearing_fields_group
        type: cross_clearing_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingFieldsX'
  cross_clearing_fields_group:
    seq:
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: clearing_instruction
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: trading_capacity_optional
        type: u1_nullable
        doc: 'tradingCapacity. Nullable, No Value = 255'
  cross_strategy_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: cross_strategy_fields_group
        type: cross_strategy_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StrategyFields'
  cross_strategy_fields_group:
    seq:
      - id: leg_last_px
        type: s8_nullable
        doc: 'legLastPx. Nullable, No Value = -9223372036854775808'
      - id: leg_last_qty
        type: u8_nullable
        doc: 'legLastQty. Nullable, No Value = 18446744073709551615'
      - id: leg_instrument_id
        type: u4_nullable
        doc: 'legInstrumentID. Nullable, No Value = 4294967295'
  rfq_audit_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oeg_in_from_me
        type: u8
        doc: 'oEGINFromME'
      - id: oeg_out_to_member
        type: u8
        doc: 'oEGOUTToMember'
      - id: quote_req_id
        type: u8
        doc: 'quoteReqID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: rfq_counterparts_groups
        type: rfq_counterparts_groups
        doc: 'RFQCounterparts Block'
  rfq_counterparts_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: rfq_counterparts_group
        type: rfq_counterparts_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'RFQCounterparts'
  rfq_counterparts_group:
    seq:
      - id: order_origin
        type: u1_nullable
        doc: 'orderOrigin. Nullable, No Value = 255'
      - id: order_price
        type: s8_nullable
        doc: 'orderPrice. Nullable, No Value = -9223372036854775808'
      - id: last_traded_quantity
        type: u8_nullable
        doc: 'lastTradedQuantity. Nullable, No Value = 18446744073709551615'
      - id: dark_execution_instruction_optional
        type: dark_execution_instruction_optional
        doc: 'DarkExecutionInstruction_set bit set. Nullable, No Value = 255'
      - id: minimum_order_quantity
        type: u8_nullable
        doc: 'minimumOrderQuantity. Nullable, No Value = 18446744073709551615'
  dark_execution_instruction_optional:
    meta:
      bit-endian: le
    seq:
      - id: dark_indicator
        type: b1
        doc: 'DarkIndicator'
      - id: deferred_trade_indicator
        type: b1
        doc: 'DeferredTradeIndicator'
      - id: displayed_order_interaction
        type: b1
        doc: 'DisplayedOrderInteraction'
      - id: sweep_order_indicator
        type: b1
        doc: 'SweepOrderIndicator'
      - id: minimum_quantity_type
        type: b1
        doc: 'MinimumQuantityType'
      - id: reserved_3
        type: b3
        doc: '3 reserved bits'
  wave_for_liquidity_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: ioi_id
        type: s8
        doc: 'iOIID'
      - id: ioi_transaction_type
        type: u1
        enum: ioi_transaction_type
        doc: 'iOITransactionType'
      - id: original_ioiid
        type: s8_nullable
        doc: 'originalIOIID. Nullable, No Value = -9223372036854775808'
      - id: target_counterparties
        type: target_counterparties
        doc: 'TargetCounterparties_set bit set'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: ioi_side
        type: u1
        enum: ioi_side
        doc: 'iOISide'
      - id: order_quantity
        type: u8_nullable
        doc: 'orderQuantity. Nullable, No Value = 18446744073709551615'
      - id: ioi_quantity
        type: u1
        enum: ioi_quantity
        doc: 'iOIQuantity'
      - id: ioi_quality_indication
        type: u1_nullable
        doc: 'iOIQualityIndication. Nullable, No Value = 255'
  target_counterparties:
    meta:
      bit-endian: le
    seq:
      - id: euronext_data_driven
        type: b1
        doc: 'EuronextDataDriven'
      - id: interest_lists
        type: b1
        doc: 'InterestLists'
      - id: holdings
        type: b1
        doc: 'Holdings'
      - id: buy_side
        type: b1
        doc: 'BuySide'
      - id: sell_side
        type: b1
        doc: 'SellSide'
      - id: quality_of_sell_side_counterparty
        type: b1
        doc: 'QualityOfSellSideCounterparty'
      - id: local_community_of_specialist_ams
        type: b1
        doc: 'LocalCommunityOfSpecialistAMS'
      - id: local_community_of_specialist_par
        type: b1
        doc: 'LocalCommunityOfSpecialistPAR'
      - id: local_community_of_specialist_bru
        type: b1
        doc: 'LocalCommunityOfSpecialistBRU'
      - id: local_community_of_specialist_lis
        type: b1
        doc: 'LocalCommunityOfSpecialistLIS'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
  wave_for_liquidity_notification_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: oeg_in_from_member
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_time_to_me
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: oeg_in_from_me_optional
        type: u8_nullable
        doc: 'oEGINFromME. Nullable, No Value = 18446744073709551615'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: ioi_id_optional
        type: s8_nullable
        doc: 'iOIID. Nullable, No Value = -9223372036854775808'
      - id: exchange_ioi_id_optional
        type: s8_nullable
        doc: 'exchangeIOIID. Nullable, No Value = -9223372036854775808'
      - id: ioi_type
        type: u1
        enum: ioi_type
        doc: 'iOIType'
      - id: original_ioiid
        type: s8_nullable
        doc: 'originalIOIID. Nullable, No Value = -9223372036854775808'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: ioi_side
        type: u1
        enum: ioi_side
        doc: 'iOISide'
      - id: order_quantity
        type: u8_nullable
        doc: 'orderQuantity. Nullable, No Value = 18446744073709551615'
      - id: ioi_quantity
        type: u1
        enum: ioi_quantity
        doc: 'iOIQuantity'
      - id: ioi_quality_indication
        type: u1_nullable
        doc: 'iOIQualityIndication. Nullable, No Value = 255'
      - id: error_code_optional
        type: u2_nullable
        doc: 'errorCode. Nullable, No Value = 65535'
  clear_book_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
  logon_message:
    seq:
      - id: logical_access_id
        type: u4
        doc: 'logicalAccessID'
      - id: oe_partition_id
        type: u2
        doc: 'oEPartitionID'
      - id: last_msg_seq_num_optional
        type: u4_nullable
        doc: 'lastMsgSeqNum. Nullable, No Value = 4294967295'
      - id: software_provider
        type: str_8_nullable
        doc: 'softwareProvider. Nullable, No Value = 0'
      - id: queueing_indicator
        type: u1
        doc: 'queueingIndicator'
  logon_ack_message:
    seq:
      - id: exchange_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'exchangeID'
      - id: last_cl_msg_seq_num
        type: u4
        doc: 'lastClMsgSeqNum'
  logon_reject_message:
    seq:
      - id: exchange_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'exchangeID'
      - id: logon_reject_code
        type: u1
        enum: logon_reject_code
        doc: 'logonRejectCode'
      - id: last_cl_msg_seq_num
        type: u4
        doc: 'lastClMsgSeqNum'
      - id: last_msg_seq_num
        type: u4
        doc: 'lastMsgSeqNum'
  logout_message:
    seq:
      - id: log_out_reason_code
        type: u1
        enum: log_out_reason_code
        doc: 'logOutReasonCode'
  technical_reject_message:
    seq:
      - id: oeg_out_to_member_optional
        type: u8_nullable
        doc: 'oEGOUTToMember. Nullable, No Value = 18446744073709551615'
      - id: rejected_client_message_sequence_number
        type: u4_nullable
        doc: 'rejectedClientMessageSequenceNumber. Nullable, No Value = 4294967295'
      - id: rejected_message
        type: u1_nullable
        doc: 'rejectedMessage. Nullable, No Value = 255'
      - id: error_code
        type: u2
        doc: 'errorCode'
      - id: rejected_message_id
        type: u2_nullable
        doc: 'rejectedMessageID. Nullable, No Value = 65535'
  declaration_entry_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: quantity_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: execution_within_firm_short_code
        type: s4
        doc: 'executionWithinFirmShortCode'
      - id: client_identification_shortcode
        type: s4_nullable
        doc: 'clientIdentificationShortcode. Nullable, No Value = -2147483648'
      - id: mi_cof_secondary_listing
        type: str_4_nullable
        doc: 'mICofSecondaryListing. Nullable, No Value = 0'
      - id: centralisation_date
        type: str_10_nullable
        doc: 'centralisationDate. Nullable, No Value = 0'
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: account_type_cross
        type: u1_nullable
        doc: 'accountTypeCross. Nullable, No Value = 255'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: trading_capacity_cross
        type: u1_nullable
        doc: 'tradingCapacityCross. Nullable, No Value = 255'
      - id: settlement_period
        type: u1
        doc: 'settlementPeriod'
      - id: settlement_flag
        type: u1
        doc: 'settlementFlag'
      - id: guarantee_flag
        type: u1
        enum: guarantee_flag
        doc: 'guaranteeFlag'
      - id: mifid_indicators
        type: mifid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: transaction_price_type
        type: u1_nullable
        doc: 'transactionPriceType. Nullable, No Value = 255'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: principal_code_cross
        type: str_8_nullable
        doc: 'principalCodeCross. Nullable, No Value = 0'
      - id: start_time_vwap
        type: u4_nullable
        doc: 'startTimeVwap. Nullable, No Value = 4294967295'
      - id: end_time_vwap
        type: u4_nullable
        doc: 'endTimeVwap. Nullable, No Value = 4294967295'
      - id: gross_trade_amount
        type: s8_nullable
        doc: 'grossTradeAmount. Nullable, No Value = -9223372036854775808'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: account_number_cross
        type: str_12_nullable
        doc: 'accountNumberCross. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: free_text_cross
        type: str_18_nullable
        doc: 'freeTextCross. Nullable, No Value = 0'
      - id: investment_decision_w_firm_short_code
        type: s4_nullable
        doc: 'investmentDecisionWFirmShortCode. Nullable, No Value = -2147483648'
      - id: client_identification_short_code_cross
        type: s4_nullable
        doc: 'clientIdentificationShortCodeCross. Nullable, No Value = -2147483648'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
  declaration_entry_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: declaration_id_optional
        type: u8_nullable
        doc: 'declarationID. Nullable, No Value = 18446744073709551615'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: mi_cof_secondary_listing
        type: str_4_nullable
        doc: 'mICofSecondaryListing. Nullable, No Value = 0'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: pre_matching_type
        type: u1_nullable
        doc: 'preMatchingType. Nullable, No Value = 255'
      - id: waiver_indicator
        type: waiver_indicator
        doc: 'WaiverIndicator_set bit set. Nullable, No Value = 255'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
  waiver_indicator:
    meta:
      bit-endian: le
    seq:
      - id: lrgs
        type: b1
        doc: 'LRGS'
      - id: rfpt
        type: b1
        doc: 'RFPT'
      - id: nliq
        type: b1
        doc: 'NLIQ'
      - id: oilq
        type: b1
        doc: 'OILQ'
      - id: pric
        type: b1
        doc: 'PRIC'
      - id: size
        type: b1
        doc: 'SIZE'
      - id: ilqd
        type: b1
        doc: 'ILQD'
      - id: omf
        type: b1
        doc: 'OMF'
  declaration_notice_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: client_order_id_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: declaration_status
        type: u1
        enum: declaration_status
        doc: 'declarationStatus'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: side_optional
        type: u1_nullable
        doc: 'side. Nullable, No Value = 255'
      - id: quantity_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: pre_matching_type
        type: u1_nullable
        doc: 'preMatchingType. Nullable, No Value = 255'
      - id: trade_time_optional
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: mi_cof_secondary_listing
        type: str_4_nullable
        doc: 'mICofSecondaryListing. Nullable, No Value = 0'
      - id: centralisation_date
        type: str_10_nullable
        doc: 'centralisationDate. Nullable, No Value = 0'
      - id: clearing_firm_id
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: account_type_cross
        type: u1_nullable
        doc: 'accountTypeCross. Nullable, No Value = 255'
      - id: trading_capacity_optional
        type: u1_nullable
        doc: 'tradingCapacity. Nullable, No Value = 255'
      - id: trading_capacity_cross
        type: u1_nullable
        doc: 'tradingCapacityCross. Nullable, No Value = 255'
      - id: settlement_flag_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: settlement_period_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: guarantee_flag_optional
        type: u1_nullable
        doc: 'guaranteeFlag. Nullable, No Value = 255'
      - id: transaction_price_type
        type: u1_nullable
        doc: 'transactionPriceType. Nullable, No Value = 255'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: principal_code_cross
        type: str_8_nullable
        doc: 'principalCodeCross. Nullable, No Value = 0'
      - id: start_time_vwap
        type: u4_nullable
        doc: 'startTimeVwap. Nullable, No Value = 4294967295'
      - id: end_time_vwap
        type: u4_nullable
        doc: 'endTimeVwap. Nullable, No Value = 4294967295'
      - id: gross_trade_amount
        type: s8_nullable
        doc: 'grossTradeAmount. Nullable, No Value = -9223372036854775808'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: account_number_cross
        type: str_12_nullable
        doc: 'accountNumberCross. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: free_text_cross
        type: str_18_nullable
        doc: 'freeTextCross. Nullable, No Value = 0'
      - id: waiver_indicator
        type: waiver_indicator
        doc: 'WaiverIndicator_set bit set. Nullable, No Value = 255'
      - id: previous_day_indicator
        type: u1_nullable
        doc: 'previousDayIndicator. Nullable, No Value = 255'
      - id: miscellaneous_fee_amount
        type: s8_nullable
        doc: 'miscellaneousFeeAmount. Nullable, No Value = -9223372036854775808'
      - id: ccpid
        type: u1_nullable
        doc: 'cCPID. Nullable, No Value = 255'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
      - id: other_not_used_groups
        type: other_not_used_groups
        doc: 'NotUsedGroup2 Block'
  declaration_cancel_and_refusal_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'actionType'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
  fund_price_input_message:
    seq:
      - id: cl_msg_seq_num
        type: u4
        doc: 'clMsgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'sendingTime. Nanoseconds since Unix epoch'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: price
        type: s8
        doc: 'price'
      - id: bypass_indicator
        type: u1_nullable
        doc: 'bypassIndicator. Nullable, No Value = 255'
  fund_price_input_ack_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: price
        type: s8
        doc: 'price'
      - id: bypass_indicator
        type: u1_nullable
        doc: 'bypassIndicator. Nullable, No Value = 255'
  declaration_entry_reject_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: mi_cof_secondary_listing
        type: str_4_nullable
        doc: 'mICofSecondaryListing. Nullable, No Value = 0'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: error_code
        type: u2
        doc: 'errorCode'
      - id: rejected_message
        type: u1_nullable
        doc: 'rejectedMessage. Nullable, No Value = 255'
      - id: rejected_message_id
        type: u2_nullable
        doc: 'rejectedMessageID. Nullable, No Value = 65535'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  str_18_nullable:
    seq:
      - id: value
        size: 18
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
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
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
  str_8_nullable:
    seq:
      - id: value
        size: 8
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_12_nullable:
    seq:
      - id: value
        size: 12
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_16_nullable:
    seq:
      - id: value
        size: 16
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_11_nullable:
    seq:
      - id: value
        size: 11
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_2_nullable:
    seq:
      - id: value
        size: 2
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
  str_10_nullable:
    seq:
      - id: value
        size: 10
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

enums:
  template_id:
    1:
      id: 'new_order_message'
      doc: 'NewOrderMessage'
    3:
      id: 'ack_message'
      doc: 'AckMessage'
    4:
      id: 'fill_message'
      doc: 'FillMessage'
    5:
      id: 'kill_message'
      doc: 'KillMessage'
    6:
      id: 'cancel_replace_message'
      doc: 'CancelReplaceMessage'
    7:
      id: 'reject_message'
      doc: 'RejectMessage'
    8:
      id: 'quotes_message'
      doc: 'QuotesMessage'
    9:
      id: 'quote_ack_message'
      doc: 'QuoteAckMessage'
    10:
      id: 'quote_request_message'
      doc: 'QuoteRequestMessage'
    12:
      id: 'cancel_request_message'
      doc: 'CancelRequestMessage'
    13:
      id: 'mass_cancel_message'
      doc: 'MassCancelMessage'
    14:
      id: 'mass_cancel_ack_message'
      doc: 'MassCancelAckMessage'
    15:
      id: 'open_order_request_message'
      doc: 'OpenOrderRequestMessage'
    17:
      id: 'ownership_request_ack_message'
      doc: 'OwnershipRequestAckMessage'
    18:
      id: 'ownership_request_message'
      doc: 'OwnershipRequestMessage'
    19:
      id: 'trade_bust_notification_message'
      doc: 'TradeBustNotificationMessage'
    20:
      id: 'collar_breach_confirmation_message'
      doc: 'CollarBreachConfirmationMessage'
    28:
      id: 'price_input_message'
      doc: 'PriceInputMessage'
    32:
      id: 'liquidity_provider_command_message'
      doc: 'LiquidityProviderCommandMessage'
    33:
      id: 'ask_for_quote_message'
      doc: 'AskForQuoteMessage'
    34:
      id: 'request_for_execution_message'
      doc: 'RequestForExecutionMessage'
    35:
      id: 'rfq_notification_message'
      doc: 'RFQNotificationMessage'
    36:
      id: 'rfq_matching_status_message'
      doc: 'RFQMatchingStatusMessage'
    37:
      id: 'rfqlp_matching_status_message'
      doc: 'RFQLPMatchingStatusMessage'
    39:
      id: 'user_notification_message'
      doc: 'UserNotificationMessage'
    47:
      id: 'mm_sign_in_message'
      doc: 'MMSignInMessage'
    48:
      id: 'mm_sign_in_ack_message'
      doc: 'MMSignInAckMessage'
    50:
      id: 'instrument_synchronization_list_message'
      doc: 'InstrumentSynchronizationListMessage'
    51:
      id: 'synchronization_time_message'
      doc: 'SynchronizationTimeMessage'
    60:
      id: 'security_definition_request_message'
      doc: 'SecurityDefinitionRequestMessage'
    61:
      id: 'security_definition_ack_message'
      doc: 'SecurityDefinitionAckMessage'
    62:
      id: 'mm_protection_request_message'
      doc: 'MMProtectionRequestMessage'
    63:
      id: 'mm_protection_ack_message'
      doc: 'MMProtectionAckMessage'
    64:
      id: 'new_wholesale_order_message'
      doc: 'NewWholesaleOrderMessage'
    65:
      id: 'wholesale_order_ack_message'
      doc: 'WholesaleOrderAckMessage'
    66:
      id: 'request_for_implied_execution_message'
      doc: 'RequestForImpliedExecutionMessage'
    67:
      id: 'cross_order_message'
      doc: 'CrossOrderMessage'
    72:
      id: 'rfq_audit_message'
      doc: 'RFQAuditMessage'
    73:
      id: 'wave_for_liquidity_message'
      doc: 'WaveForLiquidityMessage'
    74:
      id: 'wave_for_liquidity_notification_message'
      doc: 'WaveForLiquidityNotificationMessage'
    75:
      id: 'clear_book_message'
      doc: 'ClearBookMessage'
    100:
      id: 'logon_message'
      doc: 'LogonMessage'
    101:
      id: 'logon_ack_message'
      doc: 'LogonAckMessage'
    102:
      id: 'logon_reject_message'
      doc: 'LogonRejectMessage'
    103:
      id: 'logout_message'
      doc: 'LogoutMessage'
    106:
      id: 'heartbeat_message'
      doc: 'HeartbeatMessage'
    107:
      id: 'test_request_message'
      doc: 'TestRequestMessage'
    108:
      id: 'technical_reject_message'
      doc: 'TechnicalRejectMessage'
    40:
      id: 'declaration_entry_message'
      doc: 'DeclarationEntryMessage'
    41:
      id: 'declaration_entry_ack_message'
      doc: 'DeclarationEntryAckMessage'
    42:
      id: 'declaration_notice_message'
      doc: 'DeclarationNoticeMessage'
    43:
      id: 'declaration_cancel_and_refusal_message'
      doc: 'DeclarationCancelAndRefusalMessage'
    44:
      id: 'fund_price_input_message'
      doc: 'FundPriceInputMessage'
    45:
      id: 'fund_price_input_ack_message'
      doc: 'FundPriceInputAckMessage'
    46:
      id: 'declaration_entry_reject_message'
      doc: 'DeclarationEntryRejectMessage'
  emm:
    1:
      id: 'cashand_derivative_central_order_book'
      doc: 'Cash_and_Derivative_Central_Order_Book'
    2:
      id: 'nav_trading_facility'
      doc: 'NAV_Trading_Facility'
    4:
      id: 'derivatives_wholesales'
      doc: 'Derivatives_Wholesales'
    5:
      id: 'cash_on_exchange_offbook'
      doc: 'Cash_On_Exchange_Off_book'
    6:
      id: 'euronextoffexchangetradereports'
      doc: 'Euronext_off_exchange_trade_reports'
    7:
      id: 'derivatives_on_exchange_offbook'
      doc: 'Derivatives_On_Exchange_Off_book'
    8:
      id: 'etfmtfnav_central_order_book'
      doc: 'ETF_MTF_NAV_Central_Order_Book'
    9:
      id: 'listednottraded'
      doc: 'Listed_not_traded'
    15:
      id: 'delta_neutral_contingency_leg'
      doc: 'Delta_Neutral_Contingency_Leg'
    99:
      id: 'not_applicable'
      doc: 'Not_Applicable'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'cross'
      doc: 'Cross'
  order_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'stopmarketor_stopmarketonquote'
      doc: 'Stop_market_or_Stop_market_on_quote'
    4:
      id: 'stoplimitor_stoplimitonquote'
      doc: 'Stop_limit_or_Stop_limit_on_quote'
    5:
      id: 'primary_peg'
      doc: 'Primary_Peg'
    6:
      id: 'markettolimit'
      doc: 'Market_to_limit'
    7:
      id: 'market_peg'
      doc: 'Market_Peg'
    8:
      id: 'mid_point_peg'
      doc: 'Mid_Point_Peg'
    9:
      id: 'average_price'
      doc: 'Average_Price'
    10:
      id: 'iceberg'
      doc: 'Iceberg'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel'
      doc: 'Good_Till_Cancel'
    2:
      id: 'validfor_uncrossing'
      doc: 'Valid_for_Uncrossing'
    3:
      id: 'immediateor_cancel'
      doc: 'Immediate_or_Cancel'
    4:
      id: 'fillor_kill'
      doc: 'Fill_or_Kill'
    5:
      id: 'goodtill_time'
      doc: 'Good_till_Time'
    6:
      id: 'goodtill_date'
      doc: 'Good_till_Date'
    7:
      id: 'validfor_closing_uncrossing'
      doc: 'Valid_for_Closing_Uncrossing'
    8:
      id: 'validfor_session'
      doc: 'Valid_for_Session'
  trading_capacity:
    1:
      id: 'dealingonownaccount'
      doc: 'Dealing_on_own_account'
    2:
      id: 'matchedprincipal'
      doc: 'Matched_principal'
    3:
      id: 'anyothercapacity'
      doc: 'Any_other_capacity'
  account_type:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    4:
      id: 'ro'
      doc: 'RO'
    5:
      id: 'assigned_broker'
      doc: 'Assigned_Broker'
    6:
      id: 'liquidity_provider'
      doc: 'Liquidity_Provider'
    7:
      id: 'related_party'
      doc: 'Related_Party'
    8:
      id: 'structured_product_market_maker'
      doc: 'Structured_Product_Market_Maker'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
  lp_role_optional:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'Liquidity_Provider_or_Market_Maker'
    3:
      id: 'retail_liquidity_provider'
      doc: 'Retail_Liquidity_Provider'
    12:
      id: 'rfq_liquidity_provider'
      doc: 'RFQ_Liquidity_Provider'
  undisclosed_iceberg_type:
    1:
      id: 'limit'
      doc: 'Limit'
    2:
      id: 'peg_mid_point'
      doc: 'Peg_Mid_Point'
    3:
      id: 'peg_primary'
      doc: 'Peg_Primary'
    4:
      id: 'peg_market'
      doc: 'Peg_Market'
  stop_triggered_time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel'
      doc: 'Good_Till_Cancel'
    6:
      id: 'goodtill_date'
      doc: 'Good_till_Date'
  technical_origin:
    1:
      id: 'indextradingarbitrage'
      doc: 'Index_trading_arbitrage'
    2:
      id: 'portfoliostrategy'
      doc: 'Portfolio_strategy'
    3:
      id: 'unwindorder'
      doc: 'Unwind_order'
    4:
      id: 'otherordersdefault'
      doc: 'Other_orders__default'
    5:
      id: 'crossmargining'
      doc: 'Cross_margining'
  clearing_instruction:
    0:
      id: 'processnormallyformerly_systematicposting'
      doc: 'Process_normally__formerly_Systematic_posting_'
    8:
      id: 'manualmode'
      doc: 'Manual_mode'
    9:
      id: 'automaticpostingmode'
      doc: 'Automatic_posting_mode'
    10:
      id: 'automaticgiveupmode'
      doc: 'Automatic_give_up_mode'
    4008:
      id: 'automaticandaccountauthorization'
      doc: 'Automatic_and_account_authorization'
    4009:
      id: 'manualandaccountauthorization'
      doc: 'Manual_and_account_authorization'
    4010:
      id: 'giveuptosinglefirm'
      doc: 'Give_up_to_single_firm'
  account_type_cross:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    4:
      id: 'ro'
      doc: 'RO'
    5:
      id: 'assigned_broker'
      doc: 'Assigned_Broker'
    6:
      id: 'liquidity_provider'
      doc: 'Liquidity_Provider'
    7:
      id: 'related_party'
      doc: 'Related_Party'
    8:
      id: 'structured_product_market_maker'
      doc: 'Structured_Product_Market_Maker'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
  trading_capacity_cross:
    1:
      id: 'dealingonownaccount'
      doc: 'Dealing_on_own_account'
    2:
      id: 'matchedprincipal'
      doc: 'Matched_principal'
    3:
      id: 'anyothercapacity'
      doc: 'Any_other_capacity'
  side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'cross'
      doc: 'Cross'
  ack_type:
    0:
      id: 'new_order_ack'
      doc: 'New_Order_Ack'
    1:
      id: 'replace_ack'
      doc: 'Replace_Ack'
    2:
      id: 'order_creation_by_market_operations'
      doc: 'Order_Creation_By_Market_Operations'
    3:
      id: 'stop_triggered_ack'
      doc: 'Stop_Triggered_Ack'
    4:
      id: 'collar_confirmation_ack'
      doc: 'Collar_Confirmation_Ack'
    5:
      id: 'refilled_iceberg_ack'
      doc: 'Refilled_Iceberg_Ack'
    6:
      id: 'mtl_second_ack'
      doc: 'MTL_Second_Ack'
    7:
      id: 'knock_in_by_issuer_kibi_ack'
      doc: 'KnockIn_By_Issuer_KIBI_Ack'
    8:
      id: 'knock_out_by_issuer_kobi_ack'
      doc: 'KnockOut_By_Issuer_KOBI_Ack'
    9:
      id: 'payment_after_knock_out_pako_ack'
      doc: 'Payment_After_KnockOut_PAKO_Ack'
    10:
      id: 'price_input_ack'
      doc: 'Price_Input_Ack'
    11:
      id: 'rfq_ack'
      doc: 'RFQ_Ack'
    12:
      id: 'bid_only_ack'
      doc: 'Bid_Only_Ack'
    13:
      id: 'offer_only_ack'
      doc: 'Offer_Only_Ack'
    14:
      id: 'iceberg_transformedto_limit'
      doc: 'Iceberg_Transformed_to_Limit'
    15:
      id: 'ownership_request_ack'
      doc: 'Ownership_Request_Ack'
    16:
      id: 'vfuvfc_triggered_ack'
      doc: 'VFU_VFC_Triggered_Ack'
    17:
      id: 'open_order_request_ack'
      doc: 'Open_Order_Request_Ack'
    21:
      id: 'rfie_ack'
      doc: 'RFIE_Ack'
    22:
      id: 'cross_order_ack'
      doc: 'Cross_Order_Ack'
  ack_phase:
    1:
      id: 'continuous_trading_phase'
      doc: 'Continuous_Trading_Phase'
    2:
      id: 'call_phase'
      doc: 'Call_Phase'
    3:
      id: 'halt_phase'
      doc: 'Halt_Phase'
    4:
      id: 'closed_phase'
      doc: 'Closed_Phase'
    5:
      id: 'trading_at_last_phase'
      doc: 'Trading_At_Last_Phase'
    6:
      id: 'reserved'
      doc: 'Reserved'
    7:
      id: 'suspended'
      doc: 'Suspended'
    8:
      id: 'random_uncrossing_phase'
      doc: 'Random_Uncrossing_Phase'
  trade_type:
    1:
      id: 'conventional_trade'
      doc: 'Conventional_Trade'
    2:
      id: 'largein_scale_li_s_trade'
      doc: 'Large_in_Scale_LiS_Trade'
    3:
      id: 'basis_trade'
      doc: 'Basis_Trade'
    4:
      id: 'largein_scale_li_s_package_trade'
      doc: 'Large_in_Scale_LiS_Package_Trade'
    5:
      id: 'guaranteed_cross_trade'
      doc: 'Guaranteed_Cross_Trade'
    6:
      id: 'against_actual_trade'
      doc: 'Against_Actual_Trade'
    7:
      id: 'asset_allocation_trade'
      doc: 'Asset_Allocation_Trade'
    9:
      id: 'exchangefor_swap_trade'
      doc: 'Exchange_for_Swap_Trade'
    10:
      id: 'exchangefor_physical_trade_cash_leg'
      doc: 'Exchange_for_Physical_Trade_Cash_Leg'
    11:
      id: 'strategy_leg_conventional_trade'
      doc: 'Strategy_Leg_Conventional_Trade'
    12:
      id: 'strategy_leg_largein_scale_li_s_trade'
      doc: 'Strategy_Leg_Large_in_Scale_LiS_Trade'
    13:
      id: 'strategy_leg_basis_trade'
      doc: 'Strategy_Leg_Basis_Trade'
    14:
      id: 'strategy_leg_guaranteed_cross_trade'
      doc: 'Strategy_Leg_Guaranteed_Cross_Trade'
    15:
      id: 'strategy_leg_against_actual_trade'
      doc: 'Strategy_Leg_Against_Actual_Trade'
    16:
      id: 'strategy_leg_asset_allocation_trade'
      doc: 'Strategy_Leg_Asset_Allocation_Trade'
    18:
      id: 'strategy_leg_exchange_for_swap_trade'
      doc: 'Strategy_Leg_Exchange_For_Swap_Trade'
    19:
      id: 'strategy_leg_exchange_for_physical_trade'
      doc: 'Strategy_Leg_Exchange_For_Physical_Trade'
    20:
      id: 'bo_b_trade'
      doc: 'BoB_Trade'
    22:
      id: 'atom_x_trade'
      doc: 'AtomX_Trade'
    24:
      id: 'trade_cancellation'
      doc: 'Trade_Cancellation'
    25:
      id: 'outof_market_trade'
      doc: 'Out_of_Market_Trade'
    26:
      id: 'delta_neutral_trade_underlying_cash_leg'
      doc: 'Delta_Neutral_Trade_Underlying_Cash_Leg'
    27:
      id: 'market_vwap_operation_trade'
      doc: 'Market_VWAP_Operation_Trade'
    28:
      id: 'euronext_fund_service_trade'
      doc: 'Euronext_Fund_Service_Trade'
    29:
      id: 'secondary_listing_trade'
      doc: 'Secondary_Listing_Trade'
    30:
      id: 'requestfor_cross_trade'
      doc: 'Request_for_Cross_Trade'
    31:
      id: 'requestforcrossstrategy_leg_trade'
      doc: 'Request_for_cross_strategy_Leg_Trade'
    32:
      id: 'trade_publication'
      doc: 'Trade_Publication'
    33:
      id: 'dark_trade'
      doc: 'Dark_Trade'
    34:
      id: 'delta_neutral_trade_underlying_future_leg'
      doc: 'Delta_Neutral_Trade_Underlying_Future_Leg'
    36:
      id: 'total_traded_volume'
      doc: 'Total_Traded_Volume'
    37:
      id: 'etfmtfnav_tradepriceinbp'
      doc: 'ETF_MTF_NAV_Trade_price_in_bp'
    38:
      id: 'etfmtfnav_dark_tradepriceinbp'
      doc: 'ETF_MTF_NAV_Dark_Trade_price_in_bp'
    39:
      id: 'guaranteed_cross_negotiateddeal_nliq'
      doc: 'Guaranteed_Cross_Negotiated_deal_NLIQ'
    40:
      id: 'guaranteed_cross_negotiateddeal_oilq'
      doc: 'Guaranteed_Cross_Negotiated_deal_OILQ'
    41:
      id: 'largein_scale_trade'
      doc: 'Large_in_Scale_Trade'
    42:
      id: 'largein_scale_tradeinbasispoints'
      doc: 'Large_in_Scale_Trade_in_basis_points'
    43:
      id: 'largein_scale_package_tradeinbasispoints'
      doc: 'Large_in_Scale_Package_Trade_in_basis_points'
    44:
      id: 'strategy_leg_largein_scale_tradeinbasispoints'
      doc: 'Strategy_Leg_Large_in_Scale_Trade_in_basis_points'
    46:
      id: 'non_standard_settlement'
      doc: 'Non_Standard_Settlement'
    47:
      id: 'repurchase_agreement_repo'
      doc: 'Repurchase_Agreement___Repo'
    48:
      id: 'exchange_granted_trade'
      doc: 'Exchange_Granted_Trade'
    49:
      id: 'other'
      doc: 'Other'
    50:
      id: 'odd_lot'
      doc: 'Odd_Lot'
    100:
      id: 'conventional_trade_provisionalprice'
      doc: 'Conventional_Trade___Provisional_price'
    101:
      id: 'largein_scale_li_s_trade_provisionalprice'
      doc: 'Large_in_Scale__LiS__Trade___Provisional_price'
    102:
      id: 'largein_scale_li_s_package_trade_provisionalprice'
      doc: 'Large_in_Scale__LiS__Package_Trade___Provisional_price'
    103:
      id: 'issuing_or_tender_offer_trade'
      doc: 'Issuing_Or_Tender_Offer_Trade'
    104:
      id: 'rfq_trade'
      doc: 'RFQ_Trade'
  execution_phase:
    1:
      id: 'continuous_trading_phase'
      doc: 'Continuous_Trading_Phase'
    2:
      id: 'uncrossing_phase'
      doc: 'Uncrossing_Phase'
    3:
      id: 'trading_at_last_phase'
      doc: 'Trading_At_Last_Phase'
    4:
      id: 'continuous_uncrossing_phase'
      doc: 'Continuous_Uncrossing_Phase'
    5:
      id: 'ipo'
      doc: 'IPO'
  leg_side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  message_price_notation:
    1:
      id: 'price'
      doc: 'Price'
    2:
      id: 'spreadinbasispoints'
      doc: 'Spread_in_basis_points'
    3:
      id: 'spread'
      doc: 'Spread'
  kill_reason:
    1:
      id: 'order_cancelledby_client'
      doc: 'Order_Cancelled_by_Client'
    2:
      id: 'order_expired'
      doc: 'Order_Expired'
    3:
      id: 'order_cancelledby_market_operations'
      doc: 'Order_Cancelled_by_Market_Operations'
    4:
      id: 'order_eliminateddueto_corporate_event'
      doc: 'Order_Eliminated_due_to_Corporate_Event'
    5:
      id: 'doneforday'
      doc: 'Done_for_day'
    6:
      id: 'cancelled_mt_linanempty_order_book'
      doc: 'Cancelled_MTL_in_an_empty_Order_Book'
    7:
      id: 'cancelledby_stp'
      doc: 'Cancelled_by_STP'
    8:
      id: 'remainingquantitykilled_ioc'
      doc: 'Remaining_quantity_killed_IOC'
    9:
      id: 'beginningof_pako_period'
      doc: 'Beginning_of_PAKO_Period'
    11:
      id: 'order_cancelleddueto_cancel_on_disconnect_mechanism'
      doc: 'Order_Cancelled_due_to_Cancel_On_Disconnect_Mechanism'
    12:
      id: 'rf_qexpired'
      doc: 'RFQ_expired_'
    13:
      id: 'rf_qpartiallyorfullymatchedwithothercounterparts'
      doc: 'RFQ_partially_or_fully_matched_with_other_counterparts'
    14:
      id: 'rf_qcancelledbytheissuer'
      doc: 'RFQ_cancelled_by_the_issuer'
    15:
      id: 'rfq_notmatchedduetoissuerordersfeatures'
      doc: 'RFQ_Not_matched_due_to_issuer_orders_features'
    16:
      id: 'quotecancelleddueto_knock_out'
      doc: 'Quote_cancelled_due_to_Knock_Out'
    17:
      id: 'ordercancelledduetoa_killcommand'
      doc: 'Order_cancelled_due_to_a_Kill_command'
    19:
      id: 'lp_ordercancelleddueto_rf_qexpiration'
      doc: 'LP_Order_cancelled_due_to_RFQ_expiration'
    20:
      id: 'lp_ordercancelleddueto_rf_qcancellation'
      doc: 'LP_Order_cancelled_due_to_RFQ_cancellation'
    21:
      id: 'rfq_remainingquantitykilled'
      doc: 'RFQ_Remaining_quantity_killed'
    22:
      id: 'lp_ordercancelleddueto_rf_qconfirmation'
      doc: 'LP_Order_cancelled_due_to_RFQ_confirmation'
    23:
      id: 'ordercancelleddueto_market_maker_protection'
      doc: 'Order_cancelled_due_to_Market_Maker_Protection'
    24:
      id: 'ordercancelledbyclearingriskmanager'
      doc: 'Order_cancelled_by_clearing_risk_manager'
    25:
      id: 'ordercancelledbymemberriskmanager'
      doc: 'Order_cancelled_by_member_risk_manager'
    26:
      id: 'ordercancelleddueto_trade_price_validation'
      doc: 'Order_cancelled_due_to_Trade_Price_Validation'
    30:
      id: 'conditional_ordercancelleddueto_potential_matching'
      doc: 'Conditional_Order_cancelled_due_to_Potential_Matching'
    36:
      id: 'order_cancelledduetoapotentialtradeoutside_fs_plimits'
      doc: 'Order_Cancelled_due_to_a_potential_trade_outside_FSP_limits'
    37:
      id: 'remaining_rfc_quantity_cancelled'
      doc: 'Remaining_RFC_Quantity_Cancelled'
    38:
      id: 'order_cancelledduetoanincorrect_reactor_response'
      doc: 'Order_Cancelled_due_to_an_incorrect_Reactor_Response'
    41:
      id: 'ordercancelleddueto_order_price_control_collarbreach'
      doc: 'Order_cancelled_due_to_Order_Price_Control_Collar_breach'
    42:
      id: 'ordercancelleddueto_execution_prevention_across_all_firms'
      doc: 'Order_cancelled_due_to_Execution_Prevention_Across_All_Firms'
  account_type_optional:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    4:
      id: 'ro'
      doc: 'RO'
    5:
      id: 'assigned_broker'
      doc: 'Assigned_Broker'
    6:
      id: 'liquidity_provider'
      doc: 'Liquidity_Provider'
    7:
      id: 'related_party'
      doc: 'Related_Party'
    8:
      id: 'structured_product_market_maker'
      doc: 'Structured_Product_Market_Maker'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
  emm_optional:
    1:
      id: 'cashand_derivative_central_order_book'
      doc: 'Cash_and_Derivative_Central_Order_Book'
    2:
      id: 'nav_trading_facility'
      doc: 'NAV_Trading_Facility'
    4:
      id: 'derivatives_wholesales'
      doc: 'Derivatives_Wholesales'
    5:
      id: 'cash_on_exchange_offbook'
      doc: 'Cash_On_Exchange_Off_book'
    6:
      id: 'euronextoffexchangetradereports'
      doc: 'Euronext_off_exchange_trade_reports'
    7:
      id: 'derivatives_on_exchange_offbook'
      doc: 'Derivatives_On_Exchange_Off_book'
    8:
      id: 'etfmtfnav_central_order_book'
      doc: 'ETF_MTF_NAV_Central_Order_Book'
    9:
      id: 'listednottraded'
      doc: 'Listed_not_traded'
    15:
      id: 'delta_neutral_contingency_leg'
      doc: 'Delta_Neutral_Contingency_Leg'
    99:
      id: 'not_applicable'
      doc: 'Not_Applicable'
  collar_rej_type:
    1:
      id: 'lowdynamiccollar'
      doc: 'Low_dynamic_collar'
    2:
      id: 'highdynamiccollar'
      doc: 'High_dynamic_collar'
  lp_role:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'Liquidity_Provider_or_Market_Maker'
    3:
      id: 'retail_liquidity_provider'
      doc: 'Retail_Liquidity_Provider'
    12:
      id: 'rfq_liquidity_provider'
      doc: 'RFQ_Liquidity_Provider'
  buy_revision_flag:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'replacement'
      doc: 'Replacement'
    2:
      id: 'cancellation'
      doc: 'Cancellation'
  sell_revision_flag:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'replacement'
      doc: 'Replacement'
    2:
      id: 'cancellation'
      doc: 'Cancellation'
  order_category:
    1:
      id: 'lit_order'
      doc: 'Lit_Order'
    2:
      id: 'lis_order'
      doc: 'LIS_Order'
    3:
      id: 'quote_request'
      doc: 'Quote_Request'
    4:
      id: 'rfqlp_answer'
      doc: 'RFQ_LP_Answer'
  option_type:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
    3:
      id: 'other'
      doc: 'Other'
  input_price_type:
    1:
      id: 'valuation_price'
      doc: 'Valuation_Price'
    2:
      id: 'alternative_indicative_price_aip'
      doc: 'Alternative_Indicative_Price_AIP'
  lp_action_code:
    1:
      id: 'knock_in_by_issuer_kibi'
      doc: 'Knock_In_By_Issuer_KIBI'
    2:
      id: 'knock_out_by_issuer_kobi'
      doc: 'Knock_Out_By_Issuer_KOBI'
    3:
      id: 'payment_after_knock_out_pako'
      doc: 'Payment_After_Knock_Out_PAKO'
    4:
      id: 'bid_only'
      doc: 'Bid_Only'
    5:
      id: 'offer_only'
      doc: 'Offer_Only'
  afq_reason:
    1:
      id: 'quotecancelledbythe_liquidity_provider'
      doc: 'Quote_cancelled_by_the_Liquidity_Provider'
    2:
      id: 'quotecancelledby_market_control'
      doc: 'Quote_cancelled_by_Market_Control'
    3:
      id: 'noquote_mminutesbeforeanuncrossing'
      doc: 'No_quote_M_minutes_before_an_uncrossing'
    4:
      id: 'noquote_ssecondsbeforeanuncrossing'
      doc: 'No_quote_S_seconds_before_an_uncrossing'
    5:
      id: 'quotecompletelymatched'
      doc: 'Quote_completely_matched'
  rfq_update_type:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'cancelledbythe_rf_qissuer'
      doc: 'Cancelled_by_the_RFQ_issuer'
    3:
      id: 'expired'
      doc: 'Expired'
    4:
      id: 'partiallyor_fully_matched'
      doc: 'Partially_or_Fully_Matched'
  recipient_type:
    1:
      id: 'rfq_issuer'
      doc: 'RFQ_Issuer'
    2:
      id: 'rf_qrecipient_lp'
      doc: 'RFQ_recipient__LP_'
  user_status:
    1:
      id: 'trader_algo_suspended'
      doc: 'Trader_Algo_Suspended'
    2:
      id: 'trader_algo_suspension_cleared'
      doc: 'Trader_Algo_Suspension_Cleared'
    3:
      id: 'trader_algo_killed'
      doc: 'Trader_Algo_Killed'
    4:
      id: 'trader_algo_kill_cleared'
      doc: 'Trader_Algo_Kill_Cleared'
    5:
      id: 'firm_suspended'
      doc: 'Firm_Suspended'
    6:
      id: 'firm_suspension_cleared'
      doc: 'Firm_Suspension_Cleared'
    7:
      id: 'firm_killed'
      doc: 'Firm_Killed'
    8:
      id: 'firm_kill_cleared'
      doc: 'Firm_Kill_Cleared'
    9:
      id: 'dea_suspended'
      doc: 'DEA_Suspended'
    10:
      id: 'dea_suspension_cleared'
      doc: 'DEA_Suspension_Cleared'
    11:
      id: 'dea_killed'
      doc: 'DEA_Killed'
    12:
      id: 'dea_kill_cleared'
      doc: 'DEA_Kill_Cleared'
    13:
      id: 'trader_algo_suspendedby_risk_manager'
      doc: 'Trader_Algo_Suspended_by_Risk_Manager'
    14:
      id: 'trader_algo_unsuspendedby_risk_manager'
      doc: 'Trader_Algo_Unsuspended_by_Risk_Manager'
    15:
      id: 'firm_suspendedby_risk_manager'
      doc: 'Firm_Suspended_by_Risk_Manager'
    16:
      id: 'firm_unsuspendedby_risk_manager'
      doc: 'Firm_Unsuspended_by_Risk_Manager'
    17:
      id: 'dea_suspendedby_risk_manager'
      doc: 'DEA_Suspended_by_Risk_Manager'
    18:
      id: 'dea_unsuspendedby_risk_manager'
      doc: 'DEA_Unsuspended_by_Risk_Manager'
    19:
      id: 'logical_access_suspendedby_risk_manager'
      doc: 'Logical_Access_Suspended_by_Risk_Manager'
    20:
      id: 'logical_access_unsuspendedby_risk_manager'
      doc: 'Logical_Access_Unsuspended_by_Risk_Manager'
    21:
      id: 'trader_algo_blockedby_risk_manager'
      doc: 'Trader_Algo_Blocked_by_Risk_Manager'
    22:
      id: 'trader_algo_unblockedby_risk_manager'
      doc: 'Trader_Algo_Unblocked_by_Risk_Manager'
    23:
      id: 'firm_blockedby_risk_manager'
      doc: 'Firm_Blocked_by_Risk_Manager'
    24:
      id: 'firm_unblockedby_risk_manager'
      doc: 'Firm_Unblocked_by_Risk_Manager'
    25:
      id: 'dea_blockedby_risk_manager'
      doc: 'DEA_Blocked_by_Risk_Manager'
    26:
      id: 'dea_unblockedby_risk_manager'
      doc: 'DEA_Unblocked_by_Risk_Manager'
    27:
      id: 'logical_access_blockedby_risk_manager'
      doc: 'Logical_Access_Blocked_by_Risk_Manager'
    28:
      id: 'logical_access_unblockedby_risk_manager'
      doc: 'Logical_Access_Unblocked_by_Risk_Manager'
    29:
      id: 'order_size_limit_activatedby_risk_manager'
      doc: 'Order_Size_Limit_Activated_by_Risk_Manager'
    30:
      id: 'order_size_limit_deactivatedby_risk_manager'
      doc: 'Order_Size_Limit_Deactivated_by_Risk_Manager'
    31:
      id: 'oal_activatedfora_firmby_risk_manager'
      doc: 'OAL_Activated_for_a_Firm_by_Risk_Manager'
    32:
      id: 'oal_deactivatedfora_firmby_risk_manager'
      doc: 'OAL_Deactivated_for_a_Firm_by_Risk_Manager'
    33:
      id: 'oal_activatedfora_logical_accessby_risk_manager'
      doc: 'OAL_Activated_for_a_Logical_Access_by_Risk_Manager'
    34:
      id: 'oal_deactivatedfora_logical_accessby_risk_manager'
      doc: 'OAL_Deactivated_for_a_Logical_Access_by_Risk_Manager'
  strategy_code:
    0x41:
      id: 'jelly_roll'
      doc: 'Jelly_Roll'
    0x42:
      id: 'butterfly'
      doc: 'Butterfly'
    0x43:
      id: 'callor_put_cabinet'
      doc: 'Call_or_Put_Cabinet'
    0x44:
      id: 'spread'
      doc: 'Spread'
    0x45:
      id: 'calendar_spread'
      doc: 'Calendar_Spread'
    0x46:
      id: 'diagonal_calendar_spread'
      doc: 'Diagonal_Calendar_Spread'
    0x47:
      id: 'guts'
      doc: 'Guts'
    0x48:
      id: 'twoby_one_ratio_spread'
      doc: 'Two_by_One_Ratio_Spread'
    0x49:
      id: 'iron_butterfly'
      doc: 'Iron_Butterfly'
    0x4a:
      id: 'combo'
      doc: 'Combo'
    0x4b:
      id: 'strangle'
      doc: 'Strangle'
    0x4c:
      id: 'ladder'
      doc: 'Ladder'
    0x4d:
      id: 'strip'
      doc: 'Strip'
    0x4e:
      id: 'straddle_calendar_spread'
      doc: 'Straddle_Calendar_Spread'
    0x4f:
      id: 'pack'
      doc: 'Pack'
    0x50:
      id: 'diagonal_straddle_calendar_spread'
      doc: 'Diagonal_Straddle_Calendar_Spread'
    0x51:
      id: 'simple_inter_commodity_spread'
      doc: 'Simple_Inter_Commodity_Spread'
    0x52:
      id: 'conversion_reversal'
      doc: 'Conversion_Reversal'
    0x53:
      id: 'straddle'
      doc: 'Straddle'
    0x56:
      id: 'volatility_trade'
      doc: 'Volatility_Trade'
    0x57:
      id: 'condor'
      doc: 'Condor'
    0x58:
      id: 'box_field'
      doc: 'Box'
    0x59:
      id: 'bundle'
      doc: 'Bundle'
    0x5a:
      id: 'reduced_tick_spread'
      doc: 'Reduced_Tick_Spread'
    0x61:
      id: 'ladderversus_underlying'
      doc: 'Ladder_versus_Underlying'
    0x62:
      id: 'butterflyversus_underlying'
      doc: 'Butterfly_versus_Underlying'
    0x63:
      id: 'call_spreadversus_putversus_underlying'
      doc: 'Call_Spread_versus_Put_versus_Underlying'
    0x64:
      id: 'callor_put_spreadversus_underlying'
      doc: 'Call_or_Put_Spread_versus_Underlying'
    0x65:
      id: 'callor_put_calendar_spreadversus_underlying'
      doc: 'Call_or_Put_Calendar_Spread_versus_Underlying'
    0x66:
      id: 'call_put_diagonal_calendar_spreadversus_underlying'
      doc: 'CallPut_Diagonal_Calendar_Spread_versus_Underlying'
    0x67:
      id: 'gutsversus_underlying'
      doc: 'Guts_versus_Underlying'
    0x68:
      id: 'twoby_one_callor_put_ratio_spreadversus_underlying'
      doc: 'Two_by_One_Call_or_Put_Ratio_Spread_versus_Underlying'
    0x69:
      id: 'iron_butterflyversus_underlying'
      doc: 'Iron_Butterfly_versus_Underlying'
    0x6a:
      id: 'comboversus_underlying'
      doc: 'Combo_versus_Underlying'
    0x6b:
      id: 'strangleversus_underlying'
      doc: 'Strangle_versus_Underlying'
    0x6d:
      id: 'exchangefor_physical'
      doc: 'Exchange_for_Physical'
    0x6e:
      id: 'straddle_calendar_spreadversus_underlying'
      doc: 'Straddle_Calendar_Spread_versus_Underlying'
    0x70:
      id: 'put_spreadversus_callversus_underlying'
      doc: 'Put_Spread_versus_Call_versus_Underlying'
    0x71:
      id: 'diagonal_straddle_calendar_spreadversus_underlying'
      doc: 'Diagonal_Straddle_Calendar_Spread_versus_Underlying'
    0x72:
      id: 'synthetic'
      doc: 'Synthetic'
    0x73:
      id: 'straddleversus_underlying'
      doc: 'Straddle_versus_Underlying'
    0x74:
      id: 'condorversus_underlying'
      doc: 'Condor_versus_Underlying'
    0x75:
      id: 'buy_write'
      doc: 'Buy_Write'
    0x76:
      id: 'iron_condorversus_underlying'
      doc: 'Iron_Condor_versus_Underlying'
    0x77:
      id: 'iron_condor'
      doc: 'Iron_Condor'
    0x78:
      id: 'call_spreadversus_sella_put'
      doc: 'Call_Spread_versus_Sell_a_Put'
    0x79:
      id: 'put_spreadversus_sella_call'
      doc: 'Put_Spread_versus_Sell_a_Call'
    0x7a:
      id: 'put_straddleversus_sella_callora_put'
      doc: 'Put_Straddle_versus_Sell_a_Call_or_a_Put'
  leg_security_type:
    0:
      id: 'future'
      doc: 'Future'
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'cash'
      doc: 'Cash'
  leg_put_or_call:
    1:
      id: 'call'
      doc: 'Call'
    0:
      id: 'put'
      doc: 'Put'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  request_type:
    1:
      id: 'set'
      doc: 'Set'
    2:
      id: 'get'
      doc: 'Get'
    3:
      id: 'adjust'
      doc: 'Adjust'
  protection_type:
    1:
      id: 'delta'
      doc: 'Delta'
    2:
      id: 'volume'
      doc: 'Volume'
  breach_action:
    0:
      id: 'ignore'
      doc: 'Ignore'
    1:
      id: 'pull'
      doc: 'Pull'
  protection_type_optional:
    1:
      id: 'delta'
      doc: 'Delta'
    2:
      id: 'volume'
      doc: 'Volume'
  wholesale_trade_type:
    0:
      id: 'largein_scale_trade_formerly_block_trade'
      doc: 'Large_in_Scale_Trade_Formerly_Block_Trade'
    1:
      id: 'against_actual'
      doc: 'Against_Actual'
    2:
      id: 'exchange_for_swaps'
      doc: 'Exchange_For_Swaps'
  strategy_code_optional:
    0x41:
      id: 'jelly_roll'
      doc: 'Jelly_Roll'
    0x42:
      id: 'butterfly'
      doc: 'Butterfly'
    0x43:
      id: 'callor_put_cabinet'
      doc: 'Call_or_Put_Cabinet'
    0x44:
      id: 'spread'
      doc: 'Spread'
    0x45:
      id: 'calendar_spread'
      doc: 'Calendar_Spread'
    0x46:
      id: 'diagonal_calendar_spread'
      doc: 'Diagonal_Calendar_Spread'
    0x47:
      id: 'guts'
      doc: 'Guts'
    0x48:
      id: 'twoby_one_ratio_spread'
      doc: 'Two_by_One_Ratio_Spread'
    0x49:
      id: 'iron_butterfly'
      doc: 'Iron_Butterfly'
    0x4a:
      id: 'combo'
      doc: 'Combo'
    0x4b:
      id: 'strangle'
      doc: 'Strangle'
    0x4c:
      id: 'ladder'
      doc: 'Ladder'
    0x4d:
      id: 'strip'
      doc: 'Strip'
    0x4e:
      id: 'straddle_calendar_spread'
      doc: 'Straddle_Calendar_Spread'
    0x4f:
      id: 'pack'
      doc: 'Pack'
    0x50:
      id: 'diagonal_straddle_calendar_spread'
      doc: 'Diagonal_Straddle_Calendar_Spread'
    0x51:
      id: 'simple_inter_commodity_spread'
      doc: 'Simple_Inter_Commodity_Spread'
    0x52:
      id: 'conversion_reversal'
      doc: 'Conversion_Reversal'
    0x53:
      id: 'straddle'
      doc: 'Straddle'
    0x56:
      id: 'volatility_trade'
      doc: 'Volatility_Trade'
    0x57:
      id: 'condor'
      doc: 'Condor'
    0x58:
      id: 'box_field'
      doc: 'Box'
    0x59:
      id: 'bundle'
      doc: 'Bundle'
    0x5a:
      id: 'reduced_tick_spread'
      doc: 'Reduced_Tick_Spread'
    0x61:
      id: 'ladderversus_underlying'
      doc: 'Ladder_versus_Underlying'
    0x62:
      id: 'butterflyversus_underlying'
      doc: 'Butterfly_versus_Underlying'
    0x63:
      id: 'call_spreadversus_putversus_underlying'
      doc: 'Call_Spread_versus_Put_versus_Underlying'
    0x64:
      id: 'callor_put_spreadversus_underlying'
      doc: 'Call_or_Put_Spread_versus_Underlying'
    0x65:
      id: 'callor_put_calendar_spreadversus_underlying'
      doc: 'Call_or_Put_Calendar_Spread_versus_Underlying'
    0x66:
      id: 'call_put_diagonal_calendar_spreadversus_underlying'
      doc: 'CallPut_Diagonal_Calendar_Spread_versus_Underlying'
    0x67:
      id: 'gutsversus_underlying'
      doc: 'Guts_versus_Underlying'
    0x68:
      id: 'twoby_one_callor_put_ratio_spreadversus_underlying'
      doc: 'Two_by_One_Call_or_Put_Ratio_Spread_versus_Underlying'
    0x69:
      id: 'iron_butterflyversus_underlying'
      doc: 'Iron_Butterfly_versus_Underlying'
    0x6a:
      id: 'comboversus_underlying'
      doc: 'Combo_versus_Underlying'
    0x6b:
      id: 'strangleversus_underlying'
      doc: 'Strangle_versus_Underlying'
    0x6d:
      id: 'exchangefor_physical'
      doc: 'Exchange_for_Physical'
    0x6e:
      id: 'straddle_calendar_spreadversus_underlying'
      doc: 'Straddle_Calendar_Spread_versus_Underlying'
    0x70:
      id: 'put_spreadversus_callversus_underlying'
      doc: 'Put_Spread_versus_Call_versus_Underlying'
    0x71:
      id: 'diagonal_straddle_calendar_spreadversus_underlying'
      doc: 'Diagonal_Straddle_Calendar_Spread_versus_Underlying'
    0x72:
      id: 'synthetic'
      doc: 'Synthetic'
    0x73:
      id: 'straddleversus_underlying'
      doc: 'Straddle_versus_Underlying'
    0x74:
      id: 'condorversus_underlying'
      doc: 'Condor_versus_Underlying'
    0x75:
      id: 'buy_write'
      doc: 'Buy_Write'
    0x76:
      id: 'iron_condorversus_underlying'
      doc: 'Iron_Condor_versus_Underlying'
    0x77:
      id: 'iron_condor'
      doc: 'Iron_Condor'
    0x78:
      id: 'call_spreadversus_sella_put'
      doc: 'Call_Spread_versus_Sell_a_Put'
    0x79:
      id: 'put_spreadversus_sella_call'
      doc: 'Put_Spread_versus_Sell_a_Call'
    0x7a:
      id: 'put_straddleversus_sella_callora_put'
      doc: 'Put_Straddle_versus_Sell_a_Call_or_a_Put'
  wholesale_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'cross'
      doc: 'Cross'
  trading_capacity_optional:
    1:
      id: 'dealingonownaccount'
      doc: 'Dealing_on_own_account'
    2:
      id: 'matchedprincipal'
      doc: 'Matched_principal'
    3:
      id: 'anyothercapacity'
      doc: 'Any_other_capacity'
  response_type:
    0:
      id: 'accept'
      doc: 'Accept'
    1:
      id: 'reject'
      doc: 'Reject'
  order_actor_type:
    1:
      id: 'initiator'
      doc: 'Initiator'
    2:
      id: 'reactor'
      doc: 'Reactor'
  order_origin:
    1:
      id: 'cob'
      doc: 'COB'
    2:
      id: 'lp_answer'
      doc: 'LP_Answer'
  ioi_transaction_type:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'cancel'
      doc: 'Cancel'
    3:
      id: 'replace'
      doc: 'Replace'
  ioi_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    4:
      id: 'undisclosed'
      doc: 'Undisclosed'
  ioi_quantity:
    1:
      id: 'small'
      doc: 'Small'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'large'
      doc: 'Large'
    4:
      id: 'undisclosed_quantity'
      doc: 'Undisclosed_Quantity'
  ioi_quality_indication:
    1:
      id: 'high'
      doc: 'High'
    2:
      id: 'low'
      doc: 'Low'
    3:
      id: 'medium'
      doc: 'Medium'
  ioi_type:
    1:
      id: 'ack'
      doc: 'Ack'
    2:
      id: 'reject'
      doc: 'Reject'
    3:
      id: 'new_ioi_notification'
      doc: 'New_IOI_Notification'
    4:
      id: 'ioi_reply_notification'
      doc: 'IOI_Reply_Notification'
    5:
      id: 'ioi_cancellation_notification'
      doc: 'IOI_Cancellation_Notification'
    6:
      id: 'ioi_replacement_notification'
      doc: 'IOI_Replacement_Notification'
  logon_reject_code:
    1:
      id: 'unknown_connection_identifier'
      doc: 'Unknown_Connection_Identifier'
    2:
      id: 'systemunavailable'
      doc: 'System_unavailable'
    3:
      id: 'invalidsequencenumber'
      doc: 'Invalid_sequence_number'
    4:
      id: 'clientsessionalreadyloggedon'
      doc: 'Client_session_already_logged_on'
    5:
      id: 'clientsessiondisabled'
      doc: 'Client_session_disabled'
    6:
      id: 'invalid_queueing_indicator'
      doc: 'Invalid_Queueing_Indicator'
    7:
      id: 'invalid_logonformat'
      doc: 'Invalid_Logon_format'
  log_out_reason_code:
    0:
      id: 'regular_logout'
      doc: 'Regular_Logout'
    1:
      id: 'end_of_day'
      doc: 'End_Of_Day'
    2:
      id: 'toomanyunknownmessages'
      doc: 'Too_many_unknown_messages'
    3:
      id: 'excessive_numberof_messages'
      doc: 'Excessive_Number_of_Messages'
    4:
      id: 'excessive_amountof_datain_bytes'
      doc: 'Excessive_Amount_of_Data_in_Bytes'
    5:
      id: 'excessive_numberof_messages_amountof_datain_bytes'
      doc: 'Excessive_Number_of_Messages_Amount_of_Data_in_Bytes'
  operation_type:
    1:
      id: 'declarationofatradeoutsidethebook'
      doc: 'Declaration_of_a_trade_outside_the_book'
    4:
      id: 'fundorderquantity'
      doc: 'Fund_order__quantity_'
    5:
      id: 'declarationofa_vwa_ptransaction'
      doc: 'Declaration_of_a_VWAP_transaction'
    6:
      id: 'fundordercashamount'
      doc: 'Fund_order__cash_amount_'
    7:
      id: 'declarationofatradeona_secondarylistingplace'
      doc: 'Declaration_of_a_trade_on_a_Secondary_listing_place'
  guarantee_flag:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'Cleared_but_not_Guaranteed'
    2:
      id: 'clearedand_guaranteed'
      doc: 'Cleared_and_Guaranteed'
  transaction_price_type:
    1:
      id: 'plain_vanilla_trade'
      doc: 'Plain_Vanilla_Trade'
    2:
      id: 'non_price_forming_trade'
      doc: 'Non_Price_Forming_Trade'
    3:
      id: 'trade_not_contributingto_price_discovery_process'
      doc: 'Trade_Not_Contributing_to_Price_Discovery_Process'
    4:
      id: 'dark_trade'
      doc: 'Dark_Trade'
  pre_matching_type:
    1:
      id: 'notprematched'
      doc: 'Not_prematched'
    2:
      id: 'prematchedforthenextfixing'
      doc: 'Prematched_for_the_next_fixing'
    3:
      id: 'prematchedforthesecondnextfixing'
      doc: 'Prematched_for_the_second_next_fixing'
    4:
      id: 'prematchedforthethirdnextfixing'
      doc: 'Prematched_for_the_third_next_fixing'
    5:
      id: 'prematchedforthefourthnextfixing'
      doc: 'Prematched_for_the_fourth_next_fixing'
    6:
      id: 'prematchedforthefifthnextfixing'
      doc: 'Prematched_for_the_fifth_next_fixing'
  declaration_status:
    1:
      id: 'new_waitingfor_counterparty_confirmation'
      doc: 'New_Waiting_for_Counterparty_Confirmation'
    2:
      id: 'confirmedby_counterparty'
      doc: 'Confirmed_by_Counterparty'
    3:
      id: 'refusedby_counterparty'
      doc: 'Refused_by_Counterparty'
    4:
      id: 'pending_cancellation'
      doc: 'Pending_Cancellation'
    5:
      id: 'cancelled'
      doc: 'Cancelled'
    6:
      id: 'time_out'
      doc: 'Time_Out'
    7:
      id: 'filled'
      doc: 'Filled'
    8:
      id: 'restated'
      doc: 'Restated'
    9:
      id: 'expirationofapendingdeclaration'
      doc: 'Expiration_of_a_pending_declaration'
    10:
      id: 'eliminationofapendingdeclaration'
      doc: 'Elimination_of_a_pending_declaration'
    11:
      id: 'eliminationofaprematcheddeclarationfollowinga_ce'
      doc: 'Elimination_of_a_prematched_declaration_following_a_CE'
    12:
      id: 'eliminationofaprematcheddeclarationby_moc'
      doc: 'Elimination_of_a_prematched_declaration_by_MOC'
    13:
      id: 'pre_matched'
      doc: 'Pre_Matched'
  guarantee_flag_optional:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'Cleared_but_not_Guaranteed'
    2:
      id: 'clearedand_guaranteed'
      doc: 'Cleared_and_Guaranteed'
  ccpid:
    1:
      id: 'lch_sa'
      doc: 'LCH_SA'
    2:
      id: 'bilateral_settlement'
      doc: 'Bilateral_Settlement'
    3:
      id: 'lch_limited'
      doc: 'LCH_Limited'
    5:
      id: 'sixx_clear'
      doc: 'SIX_X_Clear'
    6:
      id: 'euro_ccp'
      doc: 'EuroCCP'
    7:
      id: 'bilateral_gross_settlement'
      doc: 'Bilateral_Gross_Settlement'
    9:
      id: 'euronext_clearing'
      doc: 'Euronext_Clearing'
  action_type:
    1:
      id: 'declaration_cancellation_request'
      doc: 'Declaration_Cancellation_Request'
    2:
      id: 'declaration_refusal'
      doc: 'Declaration_Refusal'
    3:
      id: 'trade_cancellation_request'
      doc: 'Trade_Cancellation_Request'

