# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq DropCopyGateway Sbe v6.65
#
# Protocol:
#   Organization: Euronext
#   Protocol: Drop Copy Gateway
#   Encoding: Simple Binary Encoding
#   Version: 6.65
#   Date: 2/25/2026
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
  id: euronext_optiq_dropcopygateway_sbe_v6_65
  title: Euronext Optiq DropCopyGateway Sbe v6.65
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Drop Copy Gateway Sbe v6.65'
doc-ref: https://connect2.euronext.com/en/membership/resources/it-documentation

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
            'template_id::dc_market_status_change_message': dc_market_status_change_message
            'template_id::dc_price_update_message': dc_price_update_message
            'template_id::dc_long_order_message': long_order_message
            'template_id::dc_short_order_reject_message': dc_short_order_reject_message
            'template_id::dc_short_trade_cancellation_message': dc_short_trade_cancellation_message
            'template_id::dc_static_collars_message': dc_static_collars_message
            'template_id::dc_trade_bust_notification_message': trade_bust_notification_message
            'template_id::dc_quote_message': dc_quote_message
            'template_id::dcafqrfe_message': dcafqrfe_message
            'template_id::dc_declaration_new_message': dc_declaration_new_message
            'template_id::dc_short_declaration_reject_message': dc_short_declaration_reject_message
            'template_id::dc_short_declaration_cancel_message': dc_short_declaration_cancel_message
            'template_id::dc_short_trade_declaration_message': dc_short_trade_declaration_message
            'template_id::dc_short_trade_declaration_cancellation_message': dc_short_trade_declaration_cancellation_message
            'template_id::dc_trade_bust_declaration_message': dc_trade_bust_declaration_message
            'template_id::dc_trade_message': dc_trade_message
            'template_id::dc_short_declaration_fill_message': dc_short_declaration_fill_message
            'template_id::dc_quote_request_message': dc_quote_request_message
            'template_id::dc_clear_book_message': dc_clear_book_message
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
  dc_market_status_change_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: phase_id
        type: u1
        enum: phase_id
        doc: 'phaseId'
      - id: trading_group_state
        type: u1
        enum: trading_group_state
        doc: 'tradingGroupState'
      - id: instrument_state
        type: u1
        enum: instrument_state
        doc: 'instrumentState'
      - id: change_type
        type: u1
        enum: change_type
        doc: 'changeType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: event_time
        type: u8
        doc: 'eventTime'
      - id: book_state
        type: u1
        enum: book_state
        doc: 'bookState'
      - id: status_reason
        type: u1
        enum: status_reason
        doc: 'statusReason'
      - id: phase_qualifier
        type: phase_qualifier
        doc: 'PhaseQualifier_set bit set'
      - id: trading_period
        type: u1_nullable
        doc: 'tradingPeriod. Nullable, No Value = 255'
      - id: trading_side
        type: u1_nullable
        doc: 'tradingSide. Nullable, No Value = 255'
      - id: price_limits
        type: u1_nullable
        doc: 'priceLimits. Nullable, No Value = 255'
      - id: quote_spread_multiplier
        type: u1_nullable
        doc: 'quoteSpreadMultiplier. Nullable, No Value = 255'
      - id: order_entry_qualifier
        type: u1_nullable
        doc: 'orderEntryQualifier. Nullable, No Value = 255'
      - id: session_sessionenum
        type: u1
        enum: session_sessionenum
        doc: 'session'
      - id: scheduled_event
        type: u1_nullable
        doc: 'scheduledEvent. Nullable, No Value = 255'
      - id: scheduled_event_time
        type: u8_nullable
        doc: 'scheduledEventTime. Nullable, No Value = 18446744073709551615'
      - id: trading_group_order_entry_qualifier
        type: u1_nullable
        doc: 'tradingGroupOrderEntryQualifier. Nullable, No Value = 255'
      - id: instrument_order_entry_qualifier
        type: u1_nullable
        doc: 'instrumentOrderEntryQualifier. Nullable, No Value = 255'
      - id: phase_time
        type: u8_nullable
        doc: 'phaseTime. Nullable, No Value = 18446744073709551615'
      - id: contract_symbol_index
        type: u4_nullable
        doc: 'contractSymbolIndex. Nullable, No Value = 4294967295'
      - id: price_limit_style
        type: u1_nullable
        doc: 'priceLimitStyle. Nullable, No Value = 255'
  phase_qualifier:
    seq:
      - id: no_qualifier
        type: b1
        doc: 'NoQualifier'
      - id: call_bbo_only
        type: b1
        doc: 'CallBBOOnly'
      - id: trading_at_last
        type: b1
        doc: 'TradingAtLast'
      - id: random_uncrossing
        type: b1
        doc: 'RandomUncrossing'
      - id: suspended
        type: b1
        doc: 'Suspended'
      - id: wholesale_allowed
        type: b1
        doc: 'WholesaleAllowed'
      - id: stressed_market_conditions
        type: b1
        doc: 'StressedMarketConditions'
      - id: exceptional_market_conditions
        type: b1
        doc: 'ExceptionalMarketConditions'
      - id: price_improvement_only
        type: b1
        doc: 'PriceImprovementOnly'
      - id: quoting_period
        type: b1
        doc: 'QuotingPeriod'
      - id: execution_prevention_across_all_firms
        type: b1
        doc: 'ExecutionPreventionAcrossAllFirms'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  dc_price_update_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: event_time
        type: u8
        doc: 'eventTime'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'priceType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: price_int_64t_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_uint_64t_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: imbalance_qty
        type: u8_nullable
        doc: 'imbalanceQty. Nullable, No Value = 18446744073709551615'
      - id: imbalance_qty_side
        type: u1_nullable
        doc: 'imbalanceQtySide. Nullable, No Value = 255'
  long_order_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: order_event_type
        type: u1
        enum: order_event_type
        doc: 'orderEventType'
      - id: account_type_internal_account_type_internalenum
        type: u1
        enum: account_type_internal_account_type_internalenum
        doc: 'accountTypeInternal'
      - id: ack_phase
        type: u1_nullable
        doc: 'ackPhase. Nullable, No Value = 255'
      - id: ack_qualifiers
        type: ack_qualifiers
        doc: 'AckQualifiers_set bit set. Nullable, No Value = 255'
      - id: ack_type
        type: u1_nullable
        doc: 'ackType. Nullable, No Value = 255'
      - id: book_in_uint_64t_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_uint_64t_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: client_order_i_d_int_64t_optional
        type: s8_nullable
        doc: 'clientOrderID. Nullable, No Value = -9223372036854775808'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: execution_instruction_execution_instructionset
        type: execution_instruction_execution_instructionset
        doc: 'ExecutionInstruction_set bit set'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: indicative_auction_price
        type: s8_nullable
        doc: 'indicativeAuctionPrice. Nullable, No Value = -9223372036854775808'
      - id: indicative_auction_volume
        type: u8_nullable
        doc: 'indicativeAuctionVolume. Nullable, No Value = 18446744073709551615'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: lp_role_lp_roleenum_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: mi_fid_indicators_mi_fid_indicatorsset
        type: mi_fid_indicators_mi_fid_indicatorsset
        doc: 'MiFIDIndicators_set bit set'
      - id: oegin_from_member_uint_64t_optional
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oegout_time_to_m_e_uint_64t_optional
        type: u8_nullable
        doc: 'oEGOUTTimeToME. Nullable, No Value = 18446744073709551615'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: order_priority
        type: u8_nullable
        doc: 'orderPriority. Nullable, No Value = 18446744073709551615'
      - id: order_px
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: order_side_order_sideenum
        type: u1
        enum: order_side_order_sideenum
        doc: 'orderSide'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: orig_client_order_id
        type: s8
        doc: 'origClientOrderID'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: time_in_force_time_in_forceenum
        type: u1
        enum: time_in_force_time_in_forceenum
        doc: 'timeInForce'
      - id: displayed_qty
        type: u8_nullable
        doc: 'displayedQty. Nullable, No Value = 18446744073709551615'
      - id: cross_order_indicator_unsignedchar
        type: u1
        doc: 'crossOrderIndicator'
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: execution_i_d_uint_32t_optional
        type: u4_nullable
        doc: 'executionID. Nullable, No Value = 4294967295'
      - id: execution_phase_execution_phaseenum_optional
        type: u1_nullable
        doc: 'executionPhase. Nullable, No Value = 255'
      - id: last_shares_uint_64t_optional
        type: u8_nullable
        doc: 'lastShares. Nullable, No Value = 18446744073709551615'
      - id: last_traded_px_int_64t_optional
        type: s8_nullable
        doc: 'lastTradedPx. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: trade_qualifier_trade_qualifierset_optional
        type: trade_qualifier_trade_qualifierset_optional
        doc: 'TradeQualifier_set bit set. Nullable, No Value = 255'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: trade_type
        type: u1_nullable
        doc: 'tradeType. Nullable, No Value = 255'
      - id: kill_reason
        type: u2_nullable
        doc: 'killReason. Nullable, No Value = 65535'
      - id: breached_collar_price
        type: s8_nullable
        doc: 'breachedCollarPrice. Nullable, No Value = -9223372036854775808'
      - id: collar_rej_type
        type: u1_nullable
        doc: 'collarRejType. Nullable, No Value = 255'
      - id: rejected_message
        type: u1_nullable
        doc: 'rejectedMessage. Nullable, No Value = 255'
      - id: error_code_uint_16t_optional
        type: u2_nullable
        doc: 'errorCode. Nullable, No Value = 65535'
      - id: stop_queue_priority
        type: u8_nullable
        doc: 'stopQueuePriority. Nullable, No Value = 18446744073709551615'
      - id: counterparty_reason_type
        type: u1_nullable
        doc: 'counterpartyReasonType. Nullable, No Value = 255'
      - id: quote_indicator
        type: u1
        doc: 'quoteIndicator'
      - id: lis_transaction_id
        type: u4_nullable
        doc: 'lISTransactionID. Nullable, No Value = 4294967295'
      - id: wholesale_trade_type
        type: u1_nullable
        doc: 'wholesaleTradeType. Nullable, No Value = 255'
      - id: escb_membership
        type: u1_nullable
        doc: 'eSCBMembership. Nullable, No Value = 255'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
      - id: order_tolerable_price
        type: s8_nullable
        doc: 'orderTolerablePrice. Nullable, No Value = -9223372036854775808'
      - id: order_sweep_reason
        type: u1_nullable
        doc: 'orderSweepReason. Nullable, No Value = 255'
      - id: long_order_free_text_section_groups
        type: long_order_free_text_section_groups
        doc: 'FreeTextSection Block'
      - id: long_order_optional_fields_groups
        type: long_order_optional_fields_groups
        doc: 'OptionalFields Block'
      - id: long_order_clearing_fields_groups
        type: long_order_clearing_fields_groups
        doc: 'ClearingFields Block'
      - id: long_order_non_modifiable_opt_fields_groups
        type: long_order_non_modifiable_opt_fields_groups
        doc: 'NonModifiableOptFields Block'
      - id: long_order_non_modifiable_short_codes_groups
        type: long_order_non_modifiable_short_codes_groups
        doc: 'NonModifiableShortCodes Block'
      - id: long_order_modifiable_short_codes_groups
        type: long_order_modifiable_short_codes_groups
        doc: 'ModifiableShortCodes Block'
      - id: long_order_commercial_fields_groups
        type: long_order_commercial_fields_groups
        doc: 'CommercialFields Block'
      - id: long_order_modifiable_commercial_investor_field_groups
        type: long_order_modifiable_commercial_investor_field_groups
        doc: 'ModifiableCommercialInvestorField Block'
      - id: long_order_non_modifiable_commercial_investor_field_groups
        type: long_order_non_modifiable_commercial_investor_field_groups
        doc: 'NonModifiableCommercialInvestorField Block'
      - id: long_order_extended_clearing_account_groups
        type: long_order_extended_clearing_account_groups
        doc: 'ExtendedClearingAccount Block'
      - id: long_order_strategy_fields_groups
        type: long_order_strategy_fields_groups
        doc: 'StrategyFields Block'
      - id: long_order_optional_fields_derivatives_groups
        type: long_order_optional_fields_derivatives_groups
        doc: 'OptionalFieldsDerivatives Block'
      - id: long_order_additional_infos_groups
        type: long_order_additional_infos_groups
        doc: 'AdditionalInfos Block'
      - id: long_order_short_codes_details_non_modifiable_groups
        type: long_order_short_codes_details_non_modifiable_groups
        doc: 'ShortCodesDetailsNonModifiable Block'
      - id: long_order_short_codes_details_modifiable_groups
        type: long_order_short_codes_details_modifiable_groups
        doc: 'ShortCodesDetailsModifiable Block'
  ack_qualifiers:
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
      - id: dark_stp_indicator
        type: b1
        doc: 'DarkSTPIndicator'
      - id: dark_passive_order_indicator
        type: b1
        doc: 'DarkPassiveOrderIndicator'
      - id: unused_dark_execution_instructionset_7
        type: b1
        doc: 'Unused DarkExecutionInstruction_set 7'
  execution_instruction_execution_instructionset:
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
  mi_fid_indicators_mi_fid_indicatorsset:
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
  trade_qualifier_trade_qualifierset_optional:
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
  long_order_free_text_section_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_free_text_section_group
        type: long_order_free_text_section_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'FreeTextSection'
  group_size_encoding:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  long_order_free_text_section_group:
    seq:
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
  long_order_optional_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_optional_fields_group
        type: long_order_optional_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFields'
  long_order_optional_fields_group:
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
      - id: session_4
        type: b1
        doc: 'Session4'
      - id: reserved_3
        type: b3
        doc: '3 reserved bits'
  long_order_clearing_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_clearing_fields_group
        type: long_order_clearing_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingFields'
  long_order_clearing_fields_group:
    seq:
      - id: clearing_firm_i_d_char_8_optional
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
      - id: clearing_instruction_clearing_instructionenum_optional
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
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
  long_order_non_modifiable_opt_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_non_modifiable_opt_fields_group
        type: long_order_non_modifiable_opt_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NonModifiableOptFields'
  long_order_non_modifiable_opt_fields_group:
    seq:
      - id: trading_capacity_trading_capacityenum_optional
        type: u1_nullable
        doc: 'tradingCapacity. Nullable, No Value = 255'
      - id: minimum_order_quantity
        type: u8_nullable
        doc: 'minimumOrderQuantity. Nullable, No Value = 18446744073709551615'
      - id: account_type_cross
        type: u1_nullable
        doc: 'accountTypeCross. Nullable, No Value = 255'
  long_order_non_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_non_modifiable_short_codes_group
        type: long_order_non_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NonModifiableShortCodes'
  long_order_non_modifiable_short_codes_group:
    seq:
      - id: original_client_id_short_code
        type: s4_nullable
        doc: 'originalClientIDShortCode. Nullable, No Value = -2147483648'
      - id: original_exec_w_firm_short_code
        type: s4_nullable
        doc: 'originalExecWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_invest_decis_w_firm_short_code
        type: s4_nullable
        doc: 'originalInvestDecisWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_non_exec_broker_short_code
        type: s4_nullable
        doc: 'originalNonExecBrokerShortCode. Nullable, No Value = -2147483648'
  long_order_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_modifiable_short_codes_group
        type: long_order_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ModifiableShortCodes'
  long_order_modifiable_short_codes_group:
    seq:
      - id: event_client_id_short_code
        type: s4_nullable
        doc: 'eventClientIDShortCode. Nullable, No Value = -2147483648'
      - id: event_exec_w_firm_short_code
        type: s4_nullable
        doc: 'eventExecWFirmShortCode. Nullable, No Value = -2147483648'
  long_order_commercial_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_commercial_fields_group
        type: long_order_commercial_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'CommercialFields'
  long_order_commercial_fields_group:
    seq:
      - id: market_phase_flag
        type: u1_nullable
        doc: 'marketPhaseFlag. Nullable, No Value = 255'
      - id: margin_trading_flag
        type: u1_nullable
        doc: 'marginTradingFlag. Nullable, No Value = 255'
      - id: access_flag
        type: u1_nullable
        doc: 'accessFlag. Nullable, No Value = 255'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: sender_location_id
        type: str_11_nullable
        doc: 'senderLocationID. Nullable, No Value = 0'
      - id: desk_id
        type: str_11_nullable
        doc: 'deskID. Nullable, No Value = 0'
  long_order_modifiable_commercial_investor_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_modifiable_commercial_investor_field_group
        type: long_order_modifiable_commercial_investor_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ModifiableCommercialInvestorField'
  long_order_modifiable_commercial_investor_field_group:
    seq:
      - id: event_investor_id
        type: str_16_nullable
        doc: 'eventInvestorID. Nullable, No Value = 0'
  long_order_non_modifiable_commercial_investor_field_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_non_modifiable_commercial_investor_field_group
        type: long_order_non_modifiable_commercial_investor_field_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NonModifiableCommercialInvestorField'
  long_order_non_modifiable_commercial_investor_field_group:
    seq:
      - id: original_investor_id
        type: str_16_nullable
        doc: 'originalInvestorID. Nullable, No Value = 0'
  long_order_extended_clearing_account_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_extended_clearing_account_group
        type: long_order_extended_clearing_account_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ExtendedClearingAccount'
  long_order_extended_clearing_account_group:
    seq:
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
  long_order_strategy_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_strategy_fields_group
        type: long_order_strategy_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StrategyFields'
  long_order_strategy_fields_group:
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
      - id: execution_i_d_uint_32t_optional
        type: u4_nullable
        doc: 'executionID. Nullable, No Value = 4294967295'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
  long_order_optional_fields_derivatives_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_optional_fields_derivatives_group
        type: long_order_optional_fields_derivatives_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OptionalFieldsDerivatives'
  long_order_optional_fields_derivatives_group:
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
  long_order_additional_infos_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_additional_infos_group
        type: long_order_additional_infos_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'AdditionalInfos'
  long_order_additional_infos_group:
    seq:
      - id: long_client_id
        type: str_16_nullable
        doc: 'longClientID. Nullable, No Value = 0'
  long_order_short_codes_details_non_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_short_codes_details_non_modifiable_group
        type: long_order_short_codes_details_non_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsNonModifiable'
  long_order_short_codes_details_non_modifiable_group:
    seq:
      - id: original_short_code_type
        type: u1_nullable
        doc: 'originalShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  long_order_short_codes_details_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_short_codes_details_modifiable_group
        type: long_order_short_codes_details_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsModifiable'
  long_order_short_codes_details_modifiable_group:
    seq:
      - id: event_short_code_type
        type: u1_nullable
        doc: 'eventShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  dc_short_order_reject_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: order_event_type
        type: u1
        enum: order_event_type
        doc: 'orderEventType'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oegin_from_member_uint_64t_optional
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: breached_collar_price
        type: s8_nullable
        doc: 'breachedCollarPrice. Nullable, No Value = -9223372036854775808'
      - id: collar_rej_type
        type: u1_nullable
        doc: 'collarRejType. Nullable, No Value = 255'
      - id: rejected_message
        type: u1_nullable
        doc: 'rejectedMessage. Nullable, No Value = 255'
      - id: error_code_uint_16t
        type: u2
        doc: 'errorCode'
      - id: mi_fid_indicators_mi_fid_indicatorsset_optional
        type: mi_fid_indicators_mi_fid_indicatorsset_optional
        doc: 'MiFIDIndicators_set bit set. Nullable, No Value = 255'
      - id: oe_session_i_d_uint_64t_optional
        type: u8_nullable
        doc: 'oESessionID. Nullable, No Value = 18446744073709551615'
      - id: order_side_order_sideenum_optional
        type: u1_nullable
        doc: 'orderSide. Nullable, No Value = 255'
      - id: time_in_force_time_in_forceenum_optional
        type: u1_nullable
        doc: 'timeInForce. Nullable, No Value = 255'
      - id: d_c_short_order_reject_message_modifiable_short_codes_groups
        type: d_c_short_order_reject_message_modifiable_short_codes_groups
        doc: 'ModifiableShortCodes Block'
      - id: d_c_short_order_reject_message_short_codes_details_modifiable_groups
        type: d_c_short_order_reject_message_short_codes_details_modifiable_groups
        doc: 'ShortCodesDetailsModifiable Block'
  mi_fid_indicators_mi_fid_indicatorsset_optional:
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
  d_c_short_order_reject_message_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_short_order_reject_message_modifiable_short_codes_group
        type: d_c_short_order_reject_message_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ModifiableShortCodes'
  d_c_short_order_reject_message_modifiable_short_codes_group:
    seq:
      - id: event_client_id_short_code
        type: s4_nullable
        doc: 'eventClientIDShortCode. Nullable, No Value = -2147483648'
      - id: event_exec_w_firm_short_code
        type: s4_nullable
        doc: 'eventExecWFirmShortCode. Nullable, No Value = -2147483648'
  d_c_short_order_reject_message_short_codes_details_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_short_order_reject_message_short_codes_details_modifiable_group
        type: d_c_short_order_reject_message_short_codes_details_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsModifiable'
  d_c_short_order_reject_message_short_codes_details_modifiable_group:
    seq:
      - id: event_short_code_type
        type: u1_nullable
        doc: 'eventShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  dc_short_trade_cancellation_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: execution_i_d_uint_32t
        type: u4
        doc: 'executionID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: last_traded_px_int_64t
        type: s8
        doc: 'lastTradedPx'
      - id: last_shares_uint_64t
        type: u8
        doc: 'lastShares'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
  dc_static_collars_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: d_c_static_collars_message_static_collarsrep_groups
        type: d_c_static_collars_message_static_collarsrep_groups
        doc: 'StaticCollarsrep Block'
  d_c_static_collars_message_static_collarsrep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_static_collars_message_static_collarsrep_group
        type: d_c_static_collars_message_static_collarsrep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StaticCollarsrep'
  d_c_static_collars_message_static_collarsrep_group:
    seq:
      - id: update_type
        type: u1
        enum: update_type
        doc: 'updateType'
      - id: price_int_64t
        type: s8
        doc: 'price'
  trade_bust_notification_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: order_side_order_sideenum
        type: u1
        enum: order_side_order_sideenum
        doc: 'orderSide'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: book_in_time
        type: u8
        doc: 'bookINTime'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_i_d_uint_32t
        type: u4
        doc: 'executionID'
      - id: last_shares_uint_64t
        type: u8
        doc: 'lastShares'
      - id: last_traded_px_int_64t
        type: s8
        doc: 'lastTradedPx'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: mi_fid_indicators_mi_fid_indicatorsset
        type: mi_fid_indicators_mi_fid_indicatorsset
        doc: 'MiFIDIndicators_set bit set'
      - id: clearing_firm_i_d_char_8
        type: str
        size: 8
        encoding: ASCII
        doc: 'clearingFirmID'
      - id: trading_capacity_trading_capacityenum
        type: u1
        enum: trading_capacity_trading_capacityenum
        doc: 'tradingCapacity'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: execution_phase_execution_phaseenum
        type: u1
        enum: execution_phase_execution_phaseenum
        doc: 'executionPhase'
      - id: trade_qualifier_trade_qualifierset
        type: trade_qualifier_trade_qualifierset
        doc: 'TradeQualifier_set bit set'
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force_time_in_forceenum_optional
        type: u1_nullable
        doc: 'timeInForce. Nullable, No Value = 255'
      - id: clearing_instruction_clearing_instructionenum_optional
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: account_number
        type: str_12_nullable
        doc: 'accountNumber. Nullable, No Value = 0'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: lp_role_lp_roleenum_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: original_invest_decis_w_firm_short_code
        type: s4_nullable
        doc: 'originalInvestDecisWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_non_exec_broker_short_code
        type: s4_nullable
        doc: 'originalNonExecBrokerShortCode. Nullable, No Value = -2147483648'
      - id: event_client_id_short_code
        type: s4_nullable
        doc: 'eventClientIDShortCode. Nullable, No Value = -2147483648'
      - id: event_exec_w_firm_short_code
        type: s4_nullable
        doc: 'eventExecWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_client_id_short_code
        type: s4_nullable
        doc: 'originalClientIDShortCode. Nullable, No Value = -2147483648'
      - id: original_exec_w_firm_short_code
        type: s4_nullable
        doc: 'originalExecWFirmShortCode. Nullable, No Value = -2147483648'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
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
      - id: trade_bust_notification_short_codes_details_non_modifiable_groups
        type: trade_bust_notification_short_codes_details_non_modifiable_groups
        doc: 'ShortCodesDetailsNonModifiable Block'
      - id: trade_bust_notification_short_codes_details_modifiable_groups
        type: trade_bust_notification_short_codes_details_modifiable_groups
        doc: 'ShortCodesDetailsModifiable Block'
  trade_qualifier_trade_qualifierset:
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
  trade_bust_notification_short_codes_details_non_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: trade_bust_notification_short_codes_details_non_modifiable_group
        type: trade_bust_notification_short_codes_details_non_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsNonModifiable'
  trade_bust_notification_short_codes_details_non_modifiable_group:
    seq:
      - id: original_short_code_type
        type: u1_nullable
        doc: 'originalShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  trade_bust_notification_short_codes_details_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: trade_bust_notification_short_codes_details_modifiable_group
        type: trade_bust_notification_short_codes_details_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsModifiable'
  trade_bust_notification_short_codes_details_modifiable_group:
    seq:
      - id: event_short_code_type
        type: u1_nullable
        doc: 'eventShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  dc_quote_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: trading_capacity_trading_capacityenum
        type: u1
        enum: trading_capacity_trading_capacityenum
        doc: 'tradingCapacity'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: lp_role_lp_roleenum
        type: u1
        enum: lp_role_lp_roleenum
        doc: 'lPRole'
      - id: mi_fid_indicators_mi_fid_indicatorsset
        type: mi_fid_indicators_mi_fid_indicatorsset
        doc: 'MiFIDIndicators_set bit set'
      - id: rfe_answer_unsignedchar
        type: u1
        doc: 'rFEAnswer'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: execution_instruction_execution_instructionset_optional
        type: execution_instruction_execution_instructionset_optional
        doc: 'ExecutionInstruction_set bit set. Nullable, No Value = 255'
      - id: stpid
        type: u2_nullable
        doc: 'sTPID. Nullable, No Value = 65535'
      - id: d_c_quote_message_bid_quoterep_groups
        type: d_c_quote_message_bid_quoterep_groups
        doc: 'BidQuoterep Block'
      - id: d_c_quote_message_offer_quoterep_groups
        type: d_c_quote_message_offer_quoterep_groups
        doc: 'OfferQuoterep Block'
      - id: d_c_quote_message_clearing_dataset_groups
        type: d_c_quote_message_clearing_dataset_groups
        doc: 'ClearingDataset Block'
      - id: d_c_quote_message_non_modifiable_short_codes_groups
        type: d_c_quote_message_non_modifiable_short_codes_groups
        doc: 'NonModifiableShortCodes Block'
      - id: d_c_quote_message_modifiable_short_codes_groups
        type: d_c_quote_message_modifiable_short_codes_groups
        doc: 'ModifiableShortCodes Block'
  execution_instruction_execution_instructionset_optional:
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
  d_c_quote_message_bid_quoterep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_message_bid_quoterep_group
        type: d_c_quote_message_bid_quoterep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'BidQuoterep'
  d_c_quote_message_bid_quoterep_group:
    seq:
      - id: bid_size
        type: u8_nullable
        doc: 'bidSize. Nullable, No Value = 18446744073709551615'
      - id: bid_px
        type: s8_nullable
        doc: 'bidPx. Nullable, No Value = -9223372036854775808'
      - id: bid_quote_priority
        type: u8_nullable
        doc: 'bidQuotePriority. Nullable, No Value = 18446744073709551615'
      - id: bid_order_id
        type: u8_nullable
        doc: 'bidOrderID. Nullable, No Value = 18446744073709551615'
      - id: buy_revision_flag
        type: u1_nullable
        doc: 'buyRevisionFlag. Nullable, No Value = 255'
      - id: bid_error_code
        type: u2_nullable
        doc: 'bidErrorCode. Nullable, No Value = 65535'
      - id: bid_oe_session_id
        type: u8_nullable
        doc: 'bidOESessionID. Nullable, No Value = 18446744073709551615'
      - id: rfe_answer_unsignedchar_optional
        type: u1_nullable
        doc: 'rFEAnswer. Nullable, No Value = 255'
      - id: bid_leaves_quantity
        type: u8_nullable
        doc: 'bidLeavesQuantity. Nullable, No Value = 18446744073709551615'
      - id: bid_previous_size
        type: u8_nullable
        doc: 'bidPreviousSize. Nullable, No Value = 18446744073709551615'
      - id: bid_previous_px
        type: s8_nullable
        doc: 'bidPreviousPx. Nullable, No Value = -9223372036854775808'
  d_c_quote_message_offer_quoterep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_message_offer_quoterep_group
        type: d_c_quote_message_offer_quoterep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OfferQuoterep'
  d_c_quote_message_offer_quoterep_group:
    seq:
      - id: offer_size
        type: u8_nullable
        doc: 'offerSize. Nullable, No Value = 18446744073709551615'
      - id: offer_px
        type: s8_nullable
        doc: 'offerPx. Nullable, No Value = -9223372036854775808'
      - id: offer_quote_priority
        type: u8_nullable
        doc: 'offerQuotePriority. Nullable, No Value = 18446744073709551615'
      - id: offer_order_id
        type: u8_nullable
        doc: 'offerOrderID. Nullable, No Value = 18446744073709551615'
      - id: sell_revision_flag
        type: u1_nullable
        doc: 'sellRevisionFlag. Nullable, No Value = 255'
      - id: offer_error_code
        type: u2_nullable
        doc: 'offerErrorCode. Nullable, No Value = 65535'
      - id: offer_oe_session_id
        type: u8_nullable
        doc: 'offerOESessionID. Nullable, No Value = 18446744073709551615'
      - id: rfe_answer_unsignedchar_optional
        type: u1_nullable
        doc: 'rFEAnswer. Nullable, No Value = 255'
      - id: offer_leaves_quantity
        type: u8_nullable
        doc: 'offerLeavesQuantity. Nullable, No Value = 18446744073709551615'
      - id: offer_previous_size
        type: u8_nullable
        doc: 'offerPreviousSize. Nullable, No Value = 18446744073709551615'
      - id: offer_previous_px
        type: s8_nullable
        doc: 'offerPreviousPx. Nullable, No Value = -9223372036854775808'
  d_c_quote_message_clearing_dataset_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_message_clearing_dataset_group
        type: d_c_quote_message_clearing_dataset_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ClearingDataset'
  d_c_quote_message_clearing_dataset_group:
    seq:
      - id: clearing_firm_i_d_char_8_optional
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
      - id: clearing_instruction_clearing_instructionenum_optional
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
  d_c_quote_message_non_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_message_non_modifiable_short_codes_group
        type: d_c_quote_message_non_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NonModifiableShortCodes'
  d_c_quote_message_non_modifiable_short_codes_group:
    seq:
      - id: original_client_id_short_code
        type: s4_nullable
        doc: 'originalClientIDShortCode. Nullable, No Value = -2147483648'
      - id: original_exec_w_firm_short_code
        type: s4_nullable
        doc: 'originalExecWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_invest_decis_w_firm_short_code
        type: s4_nullable
        doc: 'originalInvestDecisWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_non_exec_broker_short_code
        type: s4_nullable
        doc: 'originalNonExecBrokerShortCode. Nullable, No Value = -2147483648'
  d_c_quote_message_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_message_modifiable_short_codes_group
        type: d_c_quote_message_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ModifiableShortCodes'
  d_c_quote_message_modifiable_short_codes_group:
    seq:
      - id: event_client_id_short_code
        type: s4_nullable
        doc: 'eventClientIDShortCode. Nullable, No Value = -2147483648'
      - id: event_exec_w_firm_short_code
        type: s4_nullable
        doc: 'eventExecWFirmShortCode. Nullable, No Value = -2147483648'
  dcafqrfe_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: afq_reason
        type: u1_nullable
        doc: 'aFQReason. Nullable, No Value = 255'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: afq_indicator
        type: u1
        doc: 'aFQIndicator'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
  dc_declaration_new_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: message_sending_time
        type: u8
        doc: 'messageSendingTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: declaration_event_type
        type: u1
        enum: declaration_event_type
        doc: 'declarationEventType'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: declaration_status
        type: u1
        enum: declaration_status
        doc: 'declarationStatus'
      - id: price_int_64t_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_uint_64t_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: cross_order_indicator_unsignedchar
        type: u1
        doc: 'crossOrderIndicator'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: investor_id
        type: str_16_nullable
        doc: 'investorID. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: settlement_period_unsignedchar
        type: u1
        doc: 'settlementPeriod'
      - id: settlement_flag_unsignedchar
        type: u1
        doc: 'settlementFlag'
      - id: guarantee_flag_guarantee_flagenum
        type: u1
        enum: guarantee_flag_guarantee_flagenum
        doc: 'guaranteeFlag'
      - id: transaction_price_type
        type: u1_nullable
        doc: 'transactionPriceType. Nullable, No Value = 255'
  dc_short_declaration_reject_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: message_sending_time
        type: u8
        doc: 'messageSendingTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: declaration_event_type
        type: u1
        enum: declaration_event_type
        doc: 'declarationEventType'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: error_code_uint_16t
        type: u2
        doc: 'errorCode'
      - id: rejected_message_id
        type: u2
        doc: 'rejectedMessageID'
  dc_short_declaration_cancel_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: message_sending_time
        type: u8
        doc: 'messageSendingTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: declaration_event_type
        type: u1
        enum: declaration_event_type
        doc: 'declarationEventType'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: declaration_kill_reason
        type: u1
        enum: declaration_kill_reason
        doc: 'declarationKillReason'
  dc_short_trade_declaration_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: execution_i_d_uint_32t
        type: u4
        doc: 'executionID'
      - id: cross_order_indicator_unsignedchar
        type: u1
        doc: 'crossOrderIndicator'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: publication_time
        type: u8_nullable
        doc: 'publicationTime. Nullable, No Value = 18446744073709551615'
      - id: session_sessionenum_optional
        type: u1_nullable
        doc: 'session. Nullable, No Value = 255'
      - id: trade_type
        type: u1_nullable
        doc: 'tradeType. Nullable, No Value = 255'
      - id: settlement_period_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_guarantee_flagenum_optional
        type: u1_nullable
        doc: 'guaranteeFlag. Nullable, No Value = 255'
      - id: d_c_short_trade_declaration_message_short_trade_declarations_groups
        type: d_c_short_trade_declaration_message_short_trade_declarations_groups
        doc: 'ShortTradeDeclarations Block'
  d_c_short_trade_declaration_message_short_trade_declarations_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_short_trade_declaration_message_short_trade_declarations_group
        type: d_c_short_trade_declaration_message_short_trade_declarations_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortTradeDeclarations'
  d_c_short_trade_declaration_message_short_trade_declarations_group:
    seq:
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: price_int_64t_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_uint_64t_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_partition_i_d_uint_16t
        type: u2
        doc: 'oEPartitionID'
      - id: logical_access_i_d_uint_32t
        type: u4
        doc: 'logicalAccessID'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: investor_id
        type: str_16_nullable
        doc: 'investorID. Nullable, No Value = 0'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
  dc_short_trade_declaration_cancellation_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_i_d_uint_32t
        type: u4
        doc: 'executionID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: price_int_64t
        type: s8
        doc: 'price'
      - id: quantity_uint_64t
        type: u8
        doc: 'quantity'
  dc_trade_bust_declaration_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: message_sending_time
        type: u8
        doc: 'messageSendingTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: declaration_event_type
        type: u1
        enum: declaration_event_type
        doc: 'declarationEventType'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: declaration_status
        type: u1
        enum: declaration_status
        doc: 'declarationStatus'
      - id: price_int_64t_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_uint_64t_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: investor_id
        type: str_16_nullable
        doc: 'investorID. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
  dc_trade_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: execution_i_d_uint_32t
        type: u4
        doc: 'executionID'
      - id: quantity_uint_64t
        type: u8
        doc: 'quantity'
      - id: price_int_64t_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: publication_time
        type: u8_nullable
        doc: 'publicationTime. Nullable, No Value = 18446744073709551615'
      - id: session_sessionenum_optional
        type: u1_nullable
        doc: 'session. Nullable, No Value = 255'
      - id: exec_phase
        type: u1_nullable
        doc: 'execPhase. Nullable, No Value = 255'
      - id: transparency_indicator
        type: u1_nullable
        doc: 'transparencyIndicator. Nullable, No Value = 255'
      - id: trade_qualifier_trade_qualifierset
        type: trade_qualifier_trade_qualifierset
        doc: 'TradeQualifier_set bit set'
      - id: settlement_period_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_guarantee_flagenum_optional
        type: u1_nullable
        doc: 'guaranteeFlag. Nullable, No Value = 255'
      - id: counterparty_reason_type
        type: u1_nullable
        doc: 'counterpartyReasonType. Nullable, No Value = 255'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: trade_type
        type: u1_nullable
        doc: 'tradeType. Nullable, No Value = 255'
      - id: d_c_trade_message_matched_orders_groups
        type: d_c_trade_message_matched_orders_groups
        doc: 'MatchedOrders Block'
      - id: d_c_trade_message_matched_declarations_groups
        type: d_c_trade_message_matched_declarations_groups
        doc: 'MatchedDeclarations Block'
  d_c_trade_message_matched_orders_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_trade_message_matched_orders_group
        type: d_c_trade_message_matched_orders_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MatchedOrders'
  d_c_trade_message_matched_orders_group:
    seq:
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: order_side_order_sideenum
        type: u1
        enum: order_side_order_sideenum
        doc: 'orderSide'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force_time_in_forceenum
        type: u1
        enum: time_in_force_time_in_forceenum
        doc: 'timeInForce'
      - id: order_px
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: client_id
        type: str_8_nullable
        doc: 'clientID. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_partition_i_d_uint_16t_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: logical_access_i_d_uint_32t_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: book_in_uint_64t_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: trade_qualifier_trade_qualifierset_optional
        type: trade_qualifier_trade_qualifierset_optional
        doc: 'TradeQualifier_set bit set. Nullable, No Value = 255'
      - id: account_type_internal_account_type_internalenum_optional
        type: u1_nullable
        doc: 'accountTypeInternal. Nullable, No Value = 255'
      - id: lp_role_lp_roleenum_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: original_investor_id
        type: str_16_nullable
        doc: 'originalInvestorID. Nullable, No Value = 0'
      - id: cross_order_indicator_unsignedchar_optional
        type: u1_nullable
        doc: 'crossOrderIndicator. Nullable, No Value = 255'
      - id: clearing_instruction_clearing_instructionenum
        type: u2
        enum: clearing_instruction_clearing_instructionenum
        doc: 'clearingInstruction'
  d_c_trade_message_matched_declarations_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_trade_message_matched_declarations_group
        type: d_c_trade_message_matched_declarations_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MatchedDeclarations'
  d_c_trade_message_matched_declarations_group:
    seq:
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_partition_i_d_uint_16t_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: logical_access_i_d_uint_32t_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: book_in_uint_64t_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: account_type_account_typeenum_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: cross_order_indicator_unsignedchar_optional
        type: u1_nullable
        doc: 'crossOrderIndicator. Nullable, No Value = 255'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: investor_id
        type: str_16_nullable
        doc: 'investorID. Nullable, No Value = 0'
  dc_short_declaration_fill_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: message_sending_time
        type: u8
        doc: 'messageSendingTime'
      - id: book_in_uint_64t
        type: u8
        doc: 'bookIn'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: operation_type
        type: u1
        enum: operation_type
        doc: 'operationType'
      - id: declaration_event_type
        type: u1
        enum: declaration_event_type
        doc: 'declarationEventType'
      - id: declaration_status
        type: u1
        enum: declaration_status
        doc: 'declarationStatus'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: declaration_id
        type: u8
        doc: 'declarationID'
      - id: price_int_64t
        type: s8
        doc: 'price'
      - id: quantity_uint_64t
        type: u8
        doc: 'quantity'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: cross_order_indicator_unsignedchar
        type: u1
        doc: 'crossOrderIndicator'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: session_sessionenum_optional
        type: u1_nullable
        doc: 'session. Nullable, No Value = 255'
      - id: trade_type
        type: u1_nullable
        doc: 'tradeType. Nullable, No Value = 255'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_partition_i_d_uint_16t
        type: u2
        doc: 'oEPartitionID'
      - id: logical_access_i_d_uint_32t
        type: u4
        doc: 'logicalAccessID'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: investor_id
        type: str_16_nullable
        doc: 'investorID. Nullable, No Value = 0'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: clearing_firm_i_d_char_8_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: account_type_account_typeenum
        type: u1
        enum: account_type_account_typeenum
        doc: 'accountType'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: settlement_period_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_unsignedchar_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_guarantee_flagenum_optional
        type: u1_nullable
        doc: 'guaranteeFlag. Nullable, No Value = 255'
  dc_quote_request_message:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'msgSeqNum'
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: book_in
        type: u8
        doc: 'bookIN'
      - id: book_out_time_uint_64t
        type: u8
        doc: 'bookOUTTime'
      - id: client_order_i_d_int_64t
        type: s8
        doc: 'clientOrderID'
      - id: dark_execution_instruction
        type: dark_execution_instruction
        doc: 'DarkExecutionInstruction_set bit set'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: end_client
        type: str_11_nullable
        doc: 'endClient. Nullable, No Value = 0'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: firm_id_publication
        type: u1
        doc: 'firmIDPublication'
      - id: oe_session_i_d_uint_64t
        type: u8
        doc: 'oESessionID'
      - id: oegin_from_member_uint_64t
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_m_e_uint_64t
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: order_side_order_sideenum_optional
        type: u1_nullable
        doc: 'orderSide. Nullable, No Value = 255'
      - id: rfq_status
        type: u1
        enum: rfq_status
        doc: 'rFQStatus'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: min_order_qty
        type: u8_nullable
        doc: 'minOrderQty. Nullable, No Value = 18446744073709551615'
      - id: sequence_time
        type: u8_nullable
        doc: 'sequenceTime. Nullable, No Value = 18446744073709551615'
      - id: rfq_type
        type: u1_nullable
        doc: 'rFQType. Nullable, No Value = 255'
      - id: d_c_quote_request_message_non_modifiable_short_codes_groups
        type: d_c_quote_request_message_non_modifiable_short_codes_groups
        doc: 'NonModifiableShortCodes Block'
      - id: d_c_quote_request_message_short_codes_details_non_modifiable_groups
        type: d_c_quote_request_message_short_codes_details_non_modifiable_groups
        doc: 'ShortCodesDetailsNonModifiable Block'
      - id: d_c_quote_request_message_rf_q_optional_fields_groups
        type: d_c_quote_request_message_rf_q_optional_fields_groups
        doc: 'RFQOptionalFields Block'
  d_c_quote_request_message_non_modifiable_short_codes_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_request_message_non_modifiable_short_codes_group
        type: d_c_quote_request_message_non_modifiable_short_codes_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NonModifiableShortCodes'
  d_c_quote_request_message_non_modifiable_short_codes_group:
    seq:
      - id: original_client_id_short_code
        type: s4_nullable
        doc: 'originalClientIDShortCode. Nullable, No Value = -2147483648'
      - id: original_exec_w_firm_short_code
        type: s4_nullable
        doc: 'originalExecWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_invest_decis_w_firm_short_code
        type: s4_nullable
        doc: 'originalInvestDecisWFirmShortCode. Nullable, No Value = -2147483648'
      - id: original_non_exec_broker_short_code
        type: s4_nullable
        doc: 'originalNonExecBrokerShortCode. Nullable, No Value = -2147483648'
  d_c_quote_request_message_short_codes_details_non_modifiable_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_request_message_short_codes_details_non_modifiable_group
        type: d_c_quote_request_message_short_codes_details_non_modifiable_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ShortCodesDetailsNonModifiable'
  d_c_quote_request_message_short_codes_details_non_modifiable_group:
    seq:
      - id: original_short_code_type
        type: u1_nullable
        doc: 'originalShortCodeType. Nullable, No Value = 255'
      - id: short_code_role
        type: u1_nullable
        doc: 'shortCodeRole. Nullable, No Value = 255'
      - id: short_code_role_qualifier
        type: u1_nullable
        doc: 'shortCodeRoleQualifier. Nullable, No Value = 255'
  d_c_quote_request_message_rf_q_optional_fields_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: d_c_quote_request_message_rf_q_optional_fields_group
        type: d_c_quote_request_message_rf_q_optional_fields_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'RFQOptionalFields'
  d_c_quote_request_message_rf_q_optional_fields_group:
    seq:
      - id: limit_matching_price
        type: s8_nullable
        doc: 'limitMatchingPrice. Nullable, No Value = -9223372036854775808'
      - id: minimum_number_of_l_ps
        type: u1_nullable
        doc: 'minimumNumberOfLPs. Nullable, No Value = 255'
      - id: expiration_delay
        type: u2_nullable
        doc: 'expirationDelay. Nullable, No Value = 65535'
  dc_clear_book_message:
    seq:
      - id: produce_time
        type: u8
        doc: 'produceTime'
      - id: consume_time
        type: u8
        doc: 'consumeTime'
      - id: sequence_time
        type: u8_nullable
        doc: 'sequenceTime. Nullable, No Value = 18446744073709551615'
      - id: book_in_time
        type: u8
        doc: 'bookINTime'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: clear_book_origin
        type: u1_nullable
        doc: 'clearBookOrigin. Nullable, No Value = 255'
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  str_8_nullable:
    seq:
      - id: value
        type: str
        size: 8
        encoding: ASCII
    instances:
      is_null:
        value: value == "0"
  str_16_nullable:
    seq:
      - id: value
        type: str
        size: 16
        encoding: ASCII
    instances:
      is_null:
        value: value == "0"
  str_18_nullable:
    seq:
      - id: value
        type: str
        size: 18
        encoding: ASCII
    instances:
      is_null:
        value: value == "0"
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
  str_12_nullable:
    seq:
      - id: value
        type: str
        size: 12
        encoding: ASCII
    instances:
      is_null:
        value: value == "0"
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  str_11_nullable:
    seq:
      - id: value
        type: str
        size: 11
        encoding: ASCII
    instances:
      is_null:
        value: value == "0"

enums:
  template_id:
    16001:
      id: 'dc_market_status_change_message'
      doc: 'DCMarketStatusChangeMessage'
    16003:
      id: 'dc_price_update_message'
      doc: 'DCPriceUpdateMessage'
    16006:
      id: 'dc_long_order_message'
      doc: 'DCLongOrderMessage'
    16010:
      id: 'dc_short_order_reject_message'
      doc: 'DCShortOrderRejectMessage'
    16016:
      id: 'dc_short_trade_cancellation_message'
      doc: 'DCShortTradeCancellationMessage'
    16018:
      id: 'dc_static_collars_message'
      doc: 'DCStaticCollarsMessage'
    16021:
      id: 'dc_trade_bust_notification_message'
      doc: 'DCTradeBustNotificationMessage'
    16050:
      id: 'dc_quote_message'
      doc: 'DCQuoteMessage'
    16051:
      id: 'dcafqrfe_message'
      doc: 'DCAFQRFEMessage'
    16052:
      id: 'dc_declaration_new_message'
      doc: 'DCDeclarationNewMessage'
    16053:
      id: 'dc_short_declaration_reject_message'
      doc: 'DCShortDeclarationRejectMessage'
    16054:
      id: 'dc_short_declaration_cancel_message'
      doc: 'DCShortDeclarationCancelMessage'
    16055:
      id: 'dc_short_trade_declaration_message'
      doc: 'DCShortTradeDeclarationMessage'
    16056:
      id: 'dc_short_trade_declaration_cancellation_message'
      doc: 'DCShortTradeDeclarationCancellationMessage'
    16057:
      id: 'dc_trade_bust_declaration_message'
      doc: 'DCTradeBustDeclarationMessage'
    16058:
      id: 'dc_trade_message'
      doc: 'DCTradeMessage'
    16059:
      id: 'dc_short_declaration_fill_message'
      doc: 'DCShortDeclarationFillMessage'
    16060:
      id: 'dc_quote_request_message'
      doc: 'DCQuoteRequestMessage'
    16061:
      id: 'dc_clear_book_message'
      doc: 'DCClearBookMessage'
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
    9:
      id: 'listednottraded'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'quote_advertisement'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'delta_neutral_contingency_leg'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'ers'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'not_applicable'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  phase_id:
    1:
      id: 'inaccessible'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'closed'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'call'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'uncrossing'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'continuous'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'continuous_uncrossing'
      doc: 'PhaseId_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_group_state:
    0:
      id: 'scheduled'
      doc: 'TradingGroupState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'halted'
      doc: 'TradingGroupState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_state:
    1:
      id: 'scheduled'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'suspendeddueto_underlying'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'suspended_kobi'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'suspended_kobe'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'suspended_new_listing'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'suspendedby_mo'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'suspended_technical'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'reserved_dynamic_collars'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'reserved_static_collars'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'reserved_waiting_for_lp'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'reserved_lp_limit'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'instrument_deletion'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'suspended_waitingfor_bbo'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'suspended_waitingfor_tradable_state'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'random_uncrossing_period'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'expired'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'uncrossing'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'reserveddueto_leg'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'suspendeddueto_leg'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'reserved_waitingfor_valid_assigned_broker_price'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'reserved_future_limit_interruption_protection'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'suspended_waiting_for_market_operations'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'trading_ended'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'reserved_waitingfor_assigned_broker'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'reserved_waiting_numberof_securitiesis_fulfilled'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'suspendeddueto_failover'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'closeddueto_restricted_session'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  change_type:
    0:
      id: 'status_changes'
      doc: 'MarketDataChangeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'scheduled_event_notification'
      doc: 'MarketDataChangeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'status_changeand_scheduled_event_notification'
      doc: 'MarketDataChangeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  book_state:
    1:
      id: 'inaccessible'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'closed'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'call'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'uncrossing'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'continuous'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'halted'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'continuous_uncrossing'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'suspended'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'reserved'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'random_uncrossing_period'
      doc: 'BookState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  status_reason:
    0:
      id: 'scheduled'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'collars_breach'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'automatic_reopening'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'no_liquidity_provider'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'knock_inby_issuer'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'knock_outby_exchange'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'knock_outby_issuer'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'actionby_market_operations'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'waitingfor_tradable_state'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'new_listing'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'dueto_underlying'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'outsideof_l_pquotes'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'technical'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'dueto_leg'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'dueto_main_market'
      doc: 'StatusReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_period:
    1:
      id: 'opening'
      doc: 'TradingPeriod_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'standard'
      doc: 'TradingPeriod_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'closing'
      doc: 'TradingPeriod_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_side:
    1:
      id: 'bid_only'
      doc: 'TradingSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'offer_only'
      doc: 'TradingSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'pako'
      doc: 'TradingSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'both_sides'
      doc: 'TradingSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_limits:
    1:
      id: 'price_limits_enabled_normal'
      doc: 'PriceLimits_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'price_limits_enabled_wide'
      doc: 'PriceLimits_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'price_limits_enabled_widest'
      doc: 'PriceLimits_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'price_limits_disabled'
      doc: 'PriceLimits_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  quote_spread_multiplier:
    1:
      id: 'quote_spread_multiplier_1'
      doc: 'QuoteSpreadMultiplier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'quote_spread_multiplier_2'
      doc: 'QuoteSpreadMultiplier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'quote_spread_multiplier_3'
      doc: 'QuoteSpreadMultiplier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'canceland_modify_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  session_sessionenum:
    0:
      id: 'session_0'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'session_1'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'session_2'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'session_3'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'session_4'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'session_5'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'session_6'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'session_7'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'session_8'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'session_9'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  scheduled_event:
    0:
      id: 'cancel_previously_scheduled_event'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'reopening'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'resumptionoftrading'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'closed'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'expiry'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'wholesale_largein_scale_li_stradesopenextension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'wholesale_basistradesopenextension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'wholesale_against_actualstradesopenextension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'wholesale_largein_scale_li_s_packagetradesopenextension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'wholesale_exchange_for_swapstradesopenextension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'wholesale_trades_open_extension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'suspension'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'collars_normal'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'collars_wide'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'pre_expiry'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'closing_price'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'endof_trading'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'order_cancel_only'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'restricted_trading'
      doc: 'ScheduledEvent_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_group_order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'canceland_modify_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'canceland_modify_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_only'
      doc: 'OrderEntryQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_limit_style:
    0:
      id: 'opening_call_price'
      doc: 'PriceLimitStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'fair_value'
      doc: 'PriceLimitStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'future_market_price'
      doc: 'PriceLimitStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'option_market_price'
      doc: 'PriceLimitStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_type:
    2:
      id: 'official_daily'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'official_market_close'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'official_expiry'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'provisional_intraday'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'official_intraday'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'official_ydsp'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'na_vfortheinstrumentseligibletothe_nav_trading_facility'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'adjusted_closing_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'subscription_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'indicative_matching_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'min_price_outof_session_trades'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'max_price_outof_session_trades'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'min_price_outof_session_block_trades'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'max_price_outof_session_block_trades'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'valuation_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'fund_subscription'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'fund_redemption'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'uncrossing_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'last_traded_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'aip'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'net_asset_value'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'external_reference_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'closing_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'life_time_lowest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'life_time_highest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'daily_lowest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'daily_highest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'breached_dynamic_collar'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'breached_static_collar'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'life_time_contract_highest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'life_time_contract_lowest_price'
      doc: 'MarketDataPriceType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  imbalance_qty_side:
    0:
      id: 'noimbalance'
      doc: 'ImbalanceQuantitySide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'buy'
      doc: 'ImbalanceQuantitySide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'ImbalanceQuantitySide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_event_type:
    1:
      id: 'new_field'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'modify'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fill'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancel'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'reject'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'trigger'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'refill'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'mtl'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'vfa_vfc'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'collar_breach'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'gtcgtd_reload'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'open_order_request'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'expired_reload'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'killedby_corporate_event_reload'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ownership_request'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'implicit_field'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'routed'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'routed_new'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'routed_fill'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'routed_cancel'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'move_darkto_cob'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'parked'
      doc: 'OrderEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type_internal_account_type_internalenum:
    1:
      id: 'client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'assigned_broker'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'liquidity_provider'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'related_party'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'structured_product_market_maker'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'managed_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'foreign'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'managed_foreign'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'liquidity_contract'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'omega_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ceres_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    8:
      id: 'random_uncrossing_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'uncrossing_phase'
      doc: 'AckPhase_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    18:
      id: 'reload_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'rfie_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'cross_order_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'move_darkto_co_bas_limit'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'move_darkto_co_bas_market'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'parkedduetoendof_session'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'auto_rfq_confirmation_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'avd_triggered_ack'
      doc: 'AckType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lp_role_lp_roleenum_optional:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'rfq_liquidity_provider'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_side_order_sideenum:
    1:
      id: 'buy'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cross'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    12:
      id: 'implied'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'posttrade_implied'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'auction_volume_discovery'
      doc: 'OrderType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force_time_in_forceenum:
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
    10:
      id: 'good_till_month_gtm'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  execution_phase_execution_phaseenum_optional:
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
    42:
      id: 'largein_scale_tradeinbasispoints'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    43:
      id: 'largein_scale_package_tradeinbasispoints'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    44:
      id: 'strategy_leg_largein_scale_tradeinbasispoints'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    45:
      id: 'trade_reversal'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    46:
      id: 'non_standard_settlement'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    47:
      id: 'repurchase_agreement_repo'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    48:
      id: 'exchange_granted_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    49:
      id: 'other'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    50:
      id: 'odd_lot'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'conventional_trade_provisionalprice'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'largein_scale_li_s_trade_provisionalprice'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'largein_scale_li_s_package_trade_provisionalprice'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'issuing_or_tender_offer_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'rfq_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'avd_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'strategy_leg_conventional_trade_provisionalprice'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'block_standard_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'block_nfc_auction_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'block_historical_trade'
      doc: 'TradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    18:
      id: 'ordercancelleddueto_static_collars'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'lp_ordercancelleddueto_rf_qexpiration'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'lp_ordercancelleddueto_rf_qcancellation'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'rfq_remainingquantitykilled'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'lp_ordercancelleddueto_rf_qconfirmation'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'ordercancelleddueto_market_maker_protection'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'ordercancelledbyclearingriskmanager'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'ordercancelledbymemberriskmanager'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'ordercancelleddueto_trade_price_validation'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'conditional_ordercancelleddueto_potential_matching'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'order_cancelledduetobreachof_ownership_limit'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'order_cancelledduetobreachof_credit_limit'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    33:
      id: 'order_cancelledupon_cs_drequest'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'order_cancelledduetobreachof_short_selling_limit'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'order_cancelleddueto_instrumentnotbeing_eligiblefor_margin'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'order_cancelledduetoapotentialtradeoutside_fs_plimits'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'remaining_rfc_quantity_cancelled'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'order_cancelledduetoanincorrect_reactor_response'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'order_cancelleddueto_instrumentnot_eligiblefor_short_selling'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'order_cancelledduetobreachof_short_sell_price_check'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'ordercancelleddueto_order_price_control_collarbreach'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'ordercancelleddueto_execution_prevention_across_all_firms'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    43:
      id: 'cancelleddueto_breachof_me_psetbyaclearingriskmanager'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    44:
      id: 'cancelleddueto_breachof_me_psetbyamemberriskmanager'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    45:
      id: 'auto_rf_qfullymatchedwithothercounterparts'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    46:
      id: 'order_cancelledduetoincompatibilitywith_uncrossing_price'
      doc: 'KillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  collar_rej_type:
    1:
      id: 'lowdynamiccollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'highdynamiccollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'lowstaticcollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'highstaticcollar'
      doc: 'CollarRejectionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  counterparty_reason_type:
    1:
      id: 'internal_matching_service'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'internal_clearing_service'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'primary_market_modelandnotbroadcasttothe_clearing_house'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'public_auctions_market_vpu'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'nonclearableinstrument'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'firm_id_publication_rfq'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'bilateral_settlement'
      doc: 'CounterpartyReasonType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  wholesale_trade_type:
    0:
      id: 'largein_scale_trade_formerly_block_trade'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'against_actual'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'exchange_for_swaps'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'block_standard'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'block_nfc_auction'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'block_historical'
      doc: 'WholesaleTradeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_sweep_reason:
    1:
      id: 'dvc_breached'
      doc: 'OrderSweepReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'instrumentnoteligiblefor_dark'
      doc: 'OrderSweepReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'nofullexecutionon_dob'
      doc: 'OrderSweepReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  stop_triggered_time_in_force:
    0:
      id: 'day'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'good_till_cancel'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'immediateor_cancel'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'goodtill_date'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'good_till_month_gtm'
      doc: 'TriggeredStopTimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  clearing_instruction_clearing_instructionenum_optional:
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
  trading_capacity_trading_capacityenum_optional:
    1:
      id: 'dealingonownaccount'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'matchedprincipal'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'anyothercapacity'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    5:
      id: 'assigned_broker'
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
    9:
      id: 'managed_client'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'foreign'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'managed_foreign'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'liquidity_contract'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'omega_client'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ceres_client'
      doc: 'AccountTypeCross_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  market_phase_flag:
    1:
      id: 'continuoustradingonlydefault'
      doc: 'MarketPhaseFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'trading_at_last_ta_ltradingonly'
      doc: 'MarketPhaseFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'both'
      doc: 'MarketPhaseFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  margin_trading_flag:
    0:
      id: 'false_field'
      doc: 'MarginTradingFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_field'
      doc: 'MarginTradingFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_side:
    1:
      id: 'buy'
      doc: 'LegSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'LegSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  message_price_notation:
    1:
      id: 'price'
      doc: 'MessagePriceNotation_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'spreadinbasispoints'
      doc: 'MessagePriceNotation_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'spread'
      doc: 'MessagePriceNotation_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  original_short_code_type:
    1:
      id: 'original_ewfsc'
      doc: 'OriginalShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'original_cisc'
      doc: 'OriginalShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'original_invsc'
      doc: 'OriginalShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'original_nbsc'
      doc: 'OriginalShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  short_code_role:
    1:
      id: 'executing_firm'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'client_id'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'executing_trader'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'contra_firm'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'correspondent_broker'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    122:
      id: 'investment_decision_maker'
      doc: 'ShortCodeRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  short_code_role_qualifier:
    22:
      id: 'algorithm'
      doc: 'ShortCodeRoleQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'firmor_legal_entity'
      doc: 'ShortCodeRoleQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'natural_person'
      doc: 'ShortCodeRoleQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  event_short_code_type:
    1:
      id: 'event_ewfsc'
      doc: 'EventShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'event_cisc'
      doc: 'EventShortCodeType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_side_order_sideenum_optional:
    1:
      id: 'buy'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cross'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force_time_in_forceenum_optional:
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
    10:
      id: 'good_till_month_gtm'
      doc: 'TimeInForce_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  update_type:
    1:
      id: 'best_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'best_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'new_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'new_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'updated_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'updated_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'total_traded_volume'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'implied_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'implied_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'requestfor_quote'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'requestfor_quote_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'requestfor_size'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'requestfor_quote_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'high_dynamic_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'low_dynamic_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'new_bid_rlp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'new_offer_rlp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'updated_bid_rlp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'updated_offer_rlp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'avd_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'conventional_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'requestfor_cross_rfc_queued'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'requestfor_cross_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'largein_scale_li_s_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    28:
      id: 'basis_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    29:
      id: 'largein_scale_li_s_package_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    30:
      id: 'guaranteed_cross_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    31:
      id: 'against_actual_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    32:
      id: 'asset_allocation_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'exchangefor_swap_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    35:
      id: 'dark_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    36:
      id: 'exchangefor_physical_trade_cash_leg'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    37:
      id: 'strategy_leg_conventional_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    38:
      id: 'strategy_leg_largein_scale_li_s_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    39:
      id: 'strategy_leg_basis_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    40:
      id: 'strategy_leg_guaranteed_cross_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    41:
      id: 'strategy_leg_against_actual_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    42:
      id: 'strategy_leg_asset_allocation_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    44:
      id: 'strategy_leg_exchange_for_swap_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    45:
      id: 'strategy_leg_exchange_for_physical_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    46:
      id: 'bo_b_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    48:
      id: 'atom_x_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    50:
      id: 'trade_cancellation'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    51:
      id: 'outof_market_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    52:
      id: 'delta_neutral_trade_underlying_cash_leg'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    53:
      id: 'delta_neutral_trade_underlying_future_leg'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    54:
      id: 'euronext_fund_service_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    55:
      id: 'secondary_listing_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    56:
      id: 'requestfor_cross_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    57:
      id: 'requestfor_cross_strategy_leg_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    58:
      id: 'new_bid_with_liquidity_provider'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    59:
      id: 'new_offer_with_liquidity_provider'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    60:
      id: 'updated_bid_with_liquidity_provider'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    61:
      id: 'updated_offer_with_liquidity_provider'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    63:
      id: 'low_static_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    64:
      id: 'high_static_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    65:
      id: 'market_vwap_operation_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    66:
      id: 'requestfor_size_bid'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    67:
      id: 'requestfor_size_offer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    70:
      id: 'low_lp_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    71:
      id: 'high_lp_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    72:
      id: 'etfmtfnav_tradepriceinbp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    73:
      id: 'etfmtfnav_dark_tradepriceinbp'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    74:
      id: 'new_bidon_wholesale_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    75:
      id: 'new_offeron_wholesale_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    76:
      id: 'updated_bidon_wholesale_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    77:
      id: 'updated_offeron_wholesale_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    78:
      id: 'clear_wholesale_rfc'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    79:
      id: 'guaranteed_cross_negotiateddeal_nliq'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    80:
      id: 'guaranteed_cross_negotiateddeal_oilq'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    81:
      id: 'largein_scale_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    82:
      id: 'largein_scale_tradeinbasispoints'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    83:
      id: 'largein_scale_package_tradeinbasispoints'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    84:
      id: 'strategy_leg_largein_scale_tradeinbasispoints'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    86:
      id: 'new_bid_rfq_answer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    87:
      id: 'new_offer_rfq_answer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    88:
      id: 'updated_bid_rfq_answer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    89:
      id: 'updated_offer_rfq_answer'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    90:
      id: 'bid_execution_summary'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    91:
      id: 'aqs_expansion_factor'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    92:
      id: 'collars_expansion_factor'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    93:
      id: 'collars_enabled'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    94:
      id: 'collars_disabled'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    95:
      id: 'dcrp_inter_month_spread'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    96:
      id: 'fsp_reference_price'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    97:
      id: 'offer_execution_summary'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    98:
      id: 'fsp_triggered'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'mid_point_bbo'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'conventional_trade_provisionalprice'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'high_order_price_control_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'low_order_price_control_collar'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'order_price_control_collar_reference_price'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'issuing_or_tender_offer_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'rfq_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'flip_spread'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'flip_reference_price'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'strategy_leg_conventional_trade_provisionalprice'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'block_standard_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'block_nfc_auction_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    111:
      id: 'block_historical_trade'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    252:
      id: 'static_collar_reference_price'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    253:
      id: 'dynamic_collar_reference_price'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    254:
      id: 'clear_book'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_capacity_trading_capacityenum:
    1:
      id: 'dealingonownaccount'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'matchedprincipal'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'anyothercapacity'
      doc: 'TradingCapacity_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  execution_phase_execution_phaseenum:
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
  account_type_account_typeenum:
    1:
      id: 'client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'assigned_broker'
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
    14:
      id: 'omega_client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ceres_client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lp_role_lp_roleenum:
    1:
      id: 'liquidity_provideror_market_maker'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'LPRole_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'rfq_liquidity_provider'
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
  declaration_event_type:
    1:
      id: 'new_field'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'confirmed'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'canceled'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'matched'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'rejected'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'refused'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'expired'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'eliminatedbythe_system'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'declaration_createdby_mo'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'cancelled_upon_cs_drequest'
      doc: 'DeclarationEventType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  side:
    1:
      id: 'buy'
      doc: 'Side_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'Side_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cross'
      doc: 'Side_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  guarantee_flag_guarantee_flagenum:
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
  declaration_kill_reason:
    1:
      id: 'canceledby_entering_firm'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'refusedby_counterpart'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'canceledby_mo'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'expired'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'eliminatedbythe_system'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'cancelled_upon_cs_drequest'
      doc: 'DeclarationKillReason_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  session_sessionenum_optional:
    0:
      id: 'session_0'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'session_1'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'session_2'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'session_3'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'session_4'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'session_5'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'session_6'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'session_7'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'session_8'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'session_9'
      doc: 'Session_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  guarantee_flag_guarantee_flagenum_optional:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'clearedand_guaranteed'
      doc: 'GuaranteeFlag_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_phase:
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
  transparency_indicator:
    0:
      id: 'lit_regular_trade'
      doc: 'TransparencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'dark_tradeand_immediate_publication'
      doc: 'TransparencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'dark_tradeand_deferred_publication'
      doc: 'TransparencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  account_type_internal_account_type_internalenum_optional:
    1:
      id: 'client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'retail_liquidity_provider'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'assigned_broker'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'liquidity_provider'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'related_party'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'structured_product_market_maker'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'managed_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'foreign'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'managed_foreign'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'liquidity_contract'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'omega_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ceres_client'
      doc: 'AccountTypeInternal_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  clearing_instruction_clearing_instructionenum:
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
  account_type_account_typeenum_optional:
    1:
      id: 'client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'house'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'ro'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'assigned_broker'
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
    14:
      id: 'omega_client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'ceres_client'
      doc: 'AccountType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  rfq_status:
    0:
      id: 'alive'
      doc: 'RFQStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'confirmed'
      doc: 'RFQStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'canceled'
      doc: 'RFQStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'expired'
      doc: 'RFQStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'automatically_confirmed'
      doc: 'RFQStatus_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  rfq_type:
    1:
      id: 'manual_rfq'
      doc: 'RFQType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'auto_rfq'
      doc: 'RFQType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  clear_book_origin:
    0:
      id: 'failover'
      doc: 'ClearBookOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cold_restart'
      doc: 'ClearBookOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

