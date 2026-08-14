# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq OrderEntryGateway Sbe v1.3
#
# Protocol:
#   Organization: Euronext
#   Protocol: Order Entry Gateway
#   Encoding: Simple Binary Encoding
#   Version: 1.3
#   Date: 8/20/2020
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: euronext_optiq_orderentrygateway_sbe_v1_3
  title: Euronext Optiq OrderEntryGateway Sbe v1.3
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Order Entry Gateway Sbe v1.3'
doc-ref: https://connect2.euronext.com

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Optiq Tcp Message'

types:
  message_struct:
    seq:
      - id: frame
        type: u2
        doc: 'Total bytes of packet including this header'
      - id: message_header
        type: message_header
        doc: 'Optiq Sbe message header — message identifiers and length of message root'
      - id: payload
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
            'template_id::user_notification_message': user_notification_message
            'template_id::declaration_entry_message': declaration_entry_message
            'template_id::declaration_entry_ack_message': declaration_entry_ack_message
            'template_id::declaration_notice_message': declaration_notice_message
            'template_id::declaration_cancel_and_refusal_message': declaration_cancel_and_refusal_message
            'template_id::fund_price_input_message': fund_price_input_message
            'template_id::fund_price_input_ack_message': fund_price_input_ack_message
            'template_id::declaration_entry_reject_message': declaration_entry_reject_message
            'template_id::instrument_synchronization_list_message': instrument_synchronization_list_message
            'template_id::synchronization_time_message': synchronization_time_message
            'template_id::logon_message': logon_message
            'template_id::logon_ack_message': logon_ack_message
            'template_id::logon_reject_message': logon_reject_message
            'template_id::logout_message': logout_message
            'template_id::technical_reject_message': technical_reject_message
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
        doc: 'orderSide'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: order_px
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
      - id: mi_fid_indicators
        type: mi_fid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
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
  execution_instruction:
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
      - id: reserved_2
        type: b2
        doc: '2 reserved bits'
  dark_execution_instruction:
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
  mi_fid_indicators:
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
      - id: reserved_3
        type: b3
        doc: '3 reserved bits'
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
      - id: reserved_4
        type: b4
        doc: '4 reserved bits'
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
  open_close:
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
        doc: 'orderSide. Nullable, No Value = 255'
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
      - id: order_px
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_qty_optional
        type: u8_nullable
        doc: 'orderQty. Nullable, No Value = 18446744073709551615'
      - id: ack_qualifiers
        type: ack_qualifiers
        doc: 'AckQualifiers_set bit set'
  ack_qualifiers:
    seq:
      - id: dark_indicator
        type: b1
        doc: 'DarkIndicator'
      - id: queue_indicator
        type: b1
        doc: 'QueueIndicator'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
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
        doc: 'orderSide'
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
      - id: fill_optional_field_groups
        type: fill_optional_field_groups
        doc: 'OptionalFieldsFill Block'
      - id: fill_strategy_field_groups
        type: fill_strategy_field_groups
        doc: 'StrategyFields Block'
  trade_qualifier:
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
      - id: unused_trade_qualifierset_7
        type: b1
        doc: 'Unused TradeQualifier_set 7'
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
      - id: leg_side
        type: u1_nullable
        doc: 'legSide. Nullable, No Value = 255'
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
      - id: order_px
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
        doc: 'orderSide'
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
      - id: mi_fid_indicators
        type: mi_fid_indicators
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
      - id: collar_fields_groups
        type: collar_fields_groups
        doc: 'CollarFields Block'
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
      - id: mi_fid_indicators
        type: mi_fid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: rfe_answer
        type: u1
        doc: 'rFEAnswer'
      - id: mifid_short_codes_groups
        type: mifid_short_codes_groups
        doc: 'MiFIDShortcodes Block'
      - id: clearing_dataset_groups
        type: clearing_dataset_groups
        doc: 'ClearingDataset Block'
      - id: quotes_rep_groups
        type: quotes_rep_groups
        doc: 'QuotesRep Block'
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
        doc: 'orderSide. Nullable, No Value = 255'
      - id: firm_id_publication
        type: u1
        doc: 'firmIDPublication'
      - id: end_client
        type: str_11_nullable
        doc: 'endClient. Nullable, No Value = 0'
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
        doc: 'orderSide'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
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
        doc: 'orderSide. Nullable, No Value = 255'
      - id: lp_role_optional
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
        doc: 'orderSide. Nullable, No Value = 255'
      - id: lp_role_optional
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
      - id: lp_role_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: total_affected_orders
        type: s4
        doc: 'totalAffectedOrders'
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
      - id: lp_role_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
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
        doc: 'orderSide. Nullable, No Value = 255'
      - id: end_client
        type: str_11_nullable
        doc: 'endClient. Nullable, No Value = 0'
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
        doc: 'orderSide'
      - id: number_of_lps
        type: u1_nullable
        doc: 'numberOfLPs. Nullable, No Value = 255'
      - id: recipient_type
        type: u1
        enum: recipient_type
        doc: 'recipientType'
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
        doc: 'orderSide'
      - id: quantity
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
      - id: mi_fid_indicators
        type: mi_fid_indicators
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
  waiver_indicator:
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
        doc: 'orderSide. Nullable, No Value = 255'
      - id: quantity
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
    39:
      id: 'user_notification_message'
      doc: 'UserNotificationMessage'
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
    50:
      id: 'instrument_synchronization_list_message'
      doc: 'InstrumentSynchronizationListMessage'
    51:
      id: 'synchronization_time_message'
      doc: 'SynchronizationTimeMessage'
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
  emm:
    1:
      id: 'cashand_derivative_central_order_book'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'nav_trading_facility'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'derivatives_wholesales'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cash_on_exchange_offbook'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'euronextoffexchangetradereports'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'derivatives_on_exchange_offbook'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'etfmtfnav_central_order_book'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'not_applicable'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side:
    1:
      id: 'buy'
      doc: 'CancelReplaceOrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'CancelReplaceOrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_type:
    1:
      id: 'market'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'limit'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'stopmarketor_stopmarketonquote'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'stoplimitor_stoplimitonquote'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'primary_peg'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'markettolimit'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'market_peg'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'mid_point_peg'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'average_price'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'iceberg'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0:
      id: 'day'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'good_till_cancel'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'validfor_uncrossing'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'immediateor_cancel'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'fillor_kill'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'goodtill_time'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'goodtill_date'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'validfor_closing_uncrossing'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'validfor_session'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_capacity:
    1:
      id: 'dealingonownaccount'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'matchedprincipal'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'anyothercapacity'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type:
    1:
      id: 'client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'liquidity_provider'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'related_party'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'structured_product_market_maker'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lp_role_optional:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  undisclosed_iceberg_type:
    1:
      id: 'limit'
      doc: 'UndisclosedIcebergType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'peg_mid_point'
      doc: 'UndisclosedIcebergType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'peg_primary'
      doc: 'UndisclosedIcebergType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'peg_market'
      doc: 'UndisclosedIcebergType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  stop_triggered_time_in_force:
    0:
      id: 'day'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'good_till_cancel'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'goodtill_date'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  technical_origin:
    1:
      id: 'indextradingarbitrage'
      doc: 'TechnicalOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'portfoliostrategy'
      doc: 'TechnicalOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'unwindorder'
      doc: 'TechnicalOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'otherordersdefault'
      doc: 'TechnicalOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'crossmargining'
      doc: 'TechnicalOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  clearing_instruction:
    0:
      id: 'processnormallyformerly_systematicposting'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'manualmode'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'automaticpostingmode'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'automaticgiveupmode'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4008:
      id: 'automaticandaccountauthorization'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4009:
      id: 'manualandaccountauthorization'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4010:
      id: 'giveuptosinglefirm'
      doc: 'ClearingInstruction_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type_cross:
    1:
      id: 'client'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'liquidity_provider'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'related_party'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'structured_product_market_maker'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side_optional:
    1:
      id: 'buy'
      doc: 'MassCancelAckOrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'MassCancelAckOrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ack_type:
    0:
      id: 'new_order_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'replace_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_creation_by_market_operations'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'stop_triggered_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'collar_confirmation_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'refilled_iceberg_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'mtl_second_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'knock_in_by_issuer_kibi_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'knock_out_by_issuer_kobi_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'payment_after_knock_out_pako_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'price_input_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'rfq_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'bid_only_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'offer_only_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'iceberg_transformedto_limit'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ownership_request_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'vfuvfc_triggered_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'open_order_request_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ack_phase:
    1:
      id: 'continuous_trading_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'call_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'halt_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'closed_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'trading_at_last_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'reserved'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'suspended'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trade_type:
    1:
      id: 'conventional_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'largein_scale_li_s_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'basis_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'largein_scale_li_s_package_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'guaranteed_cross_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'against_actual_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'asset_allocation_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'exchangefor_swap_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'exchangefor_physical_trade_cash_leg'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'strategy_leg_conventional_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'strategy_leg_largein_scale_li_s_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'strategy_leg_basis_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'strategy_leg_guaranteed_cross_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'strategy_leg_against_actual_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'strategy_leg_asset_allocation_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'strategy_leg_exchange_for_swap_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'strategy_leg_exchange_for_physical_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'bo_b_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'atom_x_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'trade_cancellation'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'outof_market_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'delta_neutral_trade_underlying_cash_leg'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'market_vwap_operation_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'euronext_fund_service_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'secondary_listing_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'requestfor_cross_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'requestforcrossstrategy_leg_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'trade_publication'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'dark_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'delta_neutral_trade_underlying_future_leg'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'total_traded_volume'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'etfmtfnav_tradepriceinbp'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'etfmtfnav_dark_tradepriceinbp'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'guaranteed_cross_negotiateddeal_nliq'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'guaranteed_cross_negotiateddeal_oilq'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'largein_scale_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  execution_phase:
    1:
      id: 'continuous_trading_phase'
      doc: 'ExecutionPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'uncrossing_phase'
      doc: 'ExecutionPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'trading_at_last_phase'
      doc: 'ExecutionPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'continuous_uncrossing_phase'
      doc: 'ExecutionPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'ipo'
      doc: 'ExecutionPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_side:
    1:
      id: 'buy'
      doc: 'LegSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'LegSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  kill_reason:
    1:
      id: 'order_cancelledby_client'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_expired'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_cancelledby_market_operations'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'order_eliminateddueto_corporate_event'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'doneforday'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'cancelled_mt_linanempty_order_book'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'cancelledby_stp'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'remainingquantitykilled_ioc'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'beginningof_pako_period'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'order_cancelleddueto_cancel_on_disconnect_mechanism'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'rf_qexpired'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'rf_qpartiallyorfullymatchedwithothercounterparts'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'rf_qcancelledbytheissuer'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'rfq_notmatchedduetoissuerordersfeatures'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'quotecancelleddueto_knock_out'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'ordercancelledduetoa_killcommand'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type_optional:
    1:
      id: 'client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'liquidity_provider'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'related_party'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'structured_product_market_maker'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  emm_optional:
    1:
      id: 'cashand_derivative_central_order_book'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'nav_trading_facility'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'derivatives_wholesales'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cash_on_exchange_offbook'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'euronextoffexchangetradereports'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'derivatives_on_exchange_offbook'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'etfmtfnav_central_order_book'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'not_applicable'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  collar_rej_type:
    1:
      id: 'lowdynamiccollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'highdynamiccollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lp_role:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  buy_revision_flag:
    0:
      id: 'new_field'
      doc: 'BuyRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'replacement'
      doc: 'BuyRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancellation'
      doc: 'BuyRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  sell_revision_flag:
    0:
      id: 'new_field'
      doc: 'SellRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'replacement'
      doc: 'SellRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancellation'
      doc: 'SellRevisionIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  option_type:
    1:
      id: 'call'
      doc: 'OptionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'put'
      doc: 'OptionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  input_price_type:
    1:
      id: 'valuation_price'
      doc: 'InputPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'alternative_indicative_price_aip'
      doc: 'InputPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lp_action_code:
    1:
      id: 'knock_in_by_issuer_kibi'
      doc: 'LPActionCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'knock_out_by_issuer_kobi'
      doc: 'LPActionCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'payment_after_knock_out_pako'
      doc: 'LPActionCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'bid_only'
      doc: 'LPActionCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'offer_only'
      doc: 'LPActionCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  afq_reason:
    1:
      id: 'quotecancelledbythe_liquidity_provider'
      doc: 'AFQReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'quotecancelledby_market_control'
      doc: 'AFQReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'noquote_mminutesbeforeanuncrossing'
      doc: 'AFQReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'noquote_ssecondsbeforeanuncrossing'
      doc: 'AFQReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'quotecompletelymatched'
      doc: 'AFQReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  rfq_update_type:
    1:
      id: 'new_field'
      doc: 'RFQUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'cancelledbythe_rf_qissuer'
      doc: 'RFQUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'expired'
      doc: 'RFQUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'partiallyor_fully_matched'
      doc: 'RFQUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  recipient_type:
    1:
      id: 'rfq_issuer'
      doc: 'RecipientType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'rf_qrecipient_lp'
      doc: 'RecipientType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  user_status:
    1:
      id: 'trader_algo_suspended'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'trader_algo_suspension_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'trader_algo_killed'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'trader_algo_kill_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'firm_suspended'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'firm_suspension_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'firm_killed'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'firm_kill_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'dea_suspended'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'dea_suspension_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'dea_killed'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'dea_kill_cleared'
      doc: 'UserStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  operation_type:
    1:
      id: 'declarationofatradeoutsidethebook'
      doc: 'OperationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'fundorderquantity'
      doc: 'OperationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'declarationofa_vwa_ptransaction'
      doc: 'OperationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fundordercashamount'
      doc: 'OperationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'declarationofatradeona_secondarylistingplace'
      doc: 'OperationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_capacity_cross:
    1:
      id: 'dealingonownaccount'
      doc: 'TradingCapacityCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'matchedprincipal'
      doc: 'TradingCapacityCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'anyothercapacity'
      doc: 'TradingCapacityCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  guarantee_flag:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'clearedand_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  transaction_price_type:
    1:
      id: 'plain_vanilla_trade'
      doc: 'TransactionPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'non_price_forming_trade'
      doc: 'TransactionPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'trade_not_contributingto_price_discovery_process'
      doc: 'TransactionPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'dark_trade'
      doc: 'TransactionPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pre_matching_type:
    1:
      id: 'notprematched'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'prematchedforthenextfixing'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'prematchedforthesecondnextfixing'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'prematchedforthethirdnextfixing'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'prematchedforthefourthnextfixing'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'prematchedforthefifthnextfixing'
      doc: 'PreMatchingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  declaration_status:
    1:
      id: 'new_waitingfor_counterparty_confirmation'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'confirmedby_counterparty'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'refusedby_counterparty'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'pending_cancellation'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cancelled'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'time_out'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'filled'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'restated'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'expirationofapendingdeclaration'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'eliminationofapendingdeclaration'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'eliminationofaprematcheddeclarationfollowinga_ce'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'eliminationofaprematcheddeclarationby_moc'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'pre_matched'
      doc: 'DeclarationStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_capacity_optional:
    1:
      id: 'dealingonownaccount'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'matchedprincipal'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'anyothercapacity'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  guarantee_flag_optional:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'clearedand_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  action_type:
    1:
      id: 'declaration_cancellation_request'
      doc: 'ActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'declaration_refusal'
      doc: 'ActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'trade_cancellation_request'
      doc: 'ActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  logon_reject_code:
    1:
      id: 'unknown_connection_identifier'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'systemunavailable'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'invalidsequencenumber'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'clientsessionalreadyloggedon'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'clientsessiondisabled'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'invalid_queueing_indicator'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'invalid_logonformat'
      doc: 'LogonRejectCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  log_out_reason_code:
    0:
      id: 'regular_logout'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'end_of_day'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'toomanyunknownmessages'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'excessive_numberof_messages'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'excessive_amountof_datain_bytes'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'excessive_numberof_messages_amountof_datain_bytes'
      doc: 'LogOutReasonCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

