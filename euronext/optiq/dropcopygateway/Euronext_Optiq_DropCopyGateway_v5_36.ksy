# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq DropCopyGateway Sbe v5.36
#
# Protocol:
#   Organization: Euronext
#   Protocol: Drop Copy Gateway
#   Encoding: Simple Binary Encoding
#   Version: 5.36
#   Date: 1/1/2024
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
  id: euronext_optiq_dropcopygateway_sbe_v5_36
  title: Euronext Optiq DropCopyGateway Sbe v5.36
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Drop Copy Gateway Sbe v5.36'
doc-ref: https://connect2.euronext.com/en/membership/resources/it-documentation

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
      - id: session
        type: u1
        enum: session
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
    meta:
      bit-endian: le
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
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
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
      - id: account_type_internal
        type: u1
        enum: account_type_internal
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
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: book_out_time_optional
        type: u8_nullable
        doc: 'bookOUTTime. Nullable, No Value = 18446744073709551615'
      - id: client_order_id_optional
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
      - id: execution_instruction
        type: execution_instruction
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: lp_role_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: mi_fid_indicators
        type: mi_fid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: oegin_from_member_optional
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oegout_time_to_me_optional
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
      - id: order_side
        type: u1
        enum: order_side
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
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'timeInForce'
      - id: displayed_qty
        type: u8_nullable
        doc: 'displayedQty. Nullable, No Value = 18446744073709551615'
      - id: cross_order_indicator
        type: u1
        doc: 'crossOrderIndicator'
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: execution_id_optional
        type: u4_nullable
        doc: 'executionID. Nullable, No Value = 4294967295'
      - id: execution_phase_optional
        type: u1_nullable
        doc: 'executionPhase. Nullable, No Value = 255'
      - id: last_shares_optional
        type: u8_nullable
        doc: 'lastShares. Nullable, No Value = 18446744073709551615'
      - id: last_traded_px_optional
        type: s8_nullable
        doc: 'lastTradedPx. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u8
        doc: 'leavesQty'
      - id: trade_qualifier_optional
        type: trade_qualifier_optional
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
      - id: error_code_optional
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
  mi_fid_indicators:
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
  trade_qualifier_optional:
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
      - id: block_length_short
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
      - id: clearing_firm_id_optional
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
      - id: clearing_instruction_optional
        type: u2_nullable
        doc: 'clearingInstruction. Nullable, No Value = 65535'
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
      - id: trading_capacity_optional
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
      - id: execution_id_optional
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: client_order_id
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
      - id: oegin_from_member_optional
        type: u8_nullable
        doc: 'oEGINFromMember. Nullable, No Value = 18446744073709551615'
      - id: oegout_time_to_me
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
      - id: error_code
        type: u2
        doc: 'errorCode'
      - id: mi_fid_indicators_optional
        type: mi_fid_indicators_optional
        doc: 'MiFIDIndicators_set bit set. Nullable, No Value = 255'
      - id: oe_session_id_optional
        type: u8_nullable
        doc: 'oESessionID. Nullable, No Value = 18446744073709551615'
      - id: order_side_optional
        type: u1_nullable
        doc: 'orderSide. Nullable, No Value = 255'
      - id: time_in_force_optional
        type: u1_nullable
        doc: 'timeInForce. Nullable, No Value = 255'
      - id: d_c_short_order_reject_message_modifiable_short_codes_groups
        type: d_c_short_order_reject_message_modifiable_short_codes_groups
        doc: 'ModifiableShortCodes Block'
      - id: d_c_short_order_reject_message_short_codes_details_modifiable_groups
        type: d_c_short_order_reject_message_short_codes_details_modifiable_groups
        doc: 'ShortCodesDetailsModifiable Block'
  mi_fid_indicators_optional:
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
      - id: execution_id
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: last_traded_px
        type: s8
        doc: 'lastTradedPx'
      - id: last_shares
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
      - id: price
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'orderSide'
      - id: book_out_time
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
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: last_shares
        type: u8
        doc: 'lastShares'
      - id: last_traded_px
        type: s8
        doc: 'lastTradedPx'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: mi_fid_indicators
        type: mi_fid_indicators
        doc: 'MiFIDIndicators_set bit set'
      - id: clearing_firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'clearingFirmID'
      - id: trading_capacity
        type: u1
        enum: trading_capacity
        doc: 'tradingCapacity'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: execution_phase
        type: u1
        enum: execution_phase
        doc: 'executionPhase'
      - id: trade_qualifier
        type: trade_qualifier
        doc: 'TradeQualifier_set bit set'
      - id: counterpart_firm_id
        type: str_8_nullable
        doc: 'counterpartFirmID. Nullable, No Value = 0'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'orderType'
      - id: time_in_force_optional
        type: u1_nullable
        doc: 'timeInForce. Nullable, No Value = 255'
      - id: clearing_instruction_optional
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
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: lp_role_optional
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
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
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
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
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: execution_instruction_optional
        type: execution_instruction_optional
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
      - id: rfe_answer_optional
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
      - id: rfe_answer_optional
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
      - id: clearing_firm_id_optional
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
      - id: clearing_instruction_optional
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
      - id: book_out_time
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
      - id: oe_session_id
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: client_order_id
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
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
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
      - id: cross_order_indicator
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
      - id: clearing_firm_id_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
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
      - id: client_order_id
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
      - id: error_code
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: client_order_id
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
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: cross_order_indicator
        type: u1
        doc: 'crossOrderIndicator'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: publication_time
        type: u8_nullable
        doc: 'publicationTime. Nullable, No Value = 18446744073709551615'
      - id: session_optional
        type: u1_nullable
        doc: 'session. Nullable, No Value = 255'
      - id: trade_type
        type: u1_nullable
        doc: 'tradeType. Nullable, No Value = 255'
      - id: settlement_period_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_optional
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
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
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
      - id: oe_partition_id
        type: u2
        doc: 'oEPartitionID'
      - id: logical_access_id
        type: u4
        doc: 'logicalAccessID'
      - id: book_in
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
      - id: clearing_firm_id_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: client_order_id
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: event_id
        type: u8
        doc: 'eventId'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: price
        type: s8
        doc: 'price'
      - id: quantity
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: client_order_id
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
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
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
      - id: clearing_firm_id_optional
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
      - id: execution_id
        type: u4
        doc: 'executionID'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: price_optional
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: publication_time
        type: u8_nullable
        doc: 'publicationTime. Nullable, No Value = 18446744073709551615'
      - id: session_optional
        type: u1_nullable
        doc: 'session. Nullable, No Value = 255'
      - id: exec_phase
        type: u1_nullable
        doc: 'execPhase. Nullable, No Value = 255'
      - id: transparency_indicator
        type: u1_nullable
        doc: 'transparencyIndicator. Nullable, No Value = 255'
      - id: trade_qualifier
        type: trade_qualifier
        doc: 'TradeQualifier_set bit set'
      - id: settlement_period_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_optional
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
      - id: order_side
        type: u1
        enum: order_side
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
      - id: client_id
        type: str_8_nullable
        doc: 'clientID. Nullable, No Value = 0'
      - id: technical_origin
        type: u1_nullable
        doc: 'technicalOrigin. Nullable, No Value = 255'
      - id: open_close
        type: open_close
        doc: 'OpenClose_set bit set. Nullable, No Value = 65535'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: trade_qualifier_optional
        type: trade_qualifier_optional
        doc: 'TradeQualifier_set bit set. Nullable, No Value = 255'
      - id: account_type_internal_optional
        type: u1_nullable
        doc: 'accountTypeInternal. Nullable, No Value = 255'
      - id: lp_role_optional
        type: u1_nullable
        doc: 'lPRole. Nullable, No Value = 255'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: clearing_firm_id_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: trader_id
        type: str_16_nullable
        doc: 'traderID. Nullable, No Value = 0'
      - id: original_investor_id
        type: str_16_nullable
        doc: 'originalInvestorID. Nullable, No Value = 0'
      - id: cross_order_indicator_optional
        type: u1_nullable
        doc: 'crossOrderIndicator. Nullable, No Value = 255'
      - id: clearing_instruction
        type: u2
        enum: clearing_instruction
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
      - id: oe_partition_id_optional
        type: u2_nullable
        doc: 'oEPartitionID. Nullable, No Value = 65535'
      - id: logical_access_id_optional
        type: u4_nullable
        doc: 'logicalAccessID. Nullable, No Value = 4294967295'
      - id: book_in_optional
        type: u8_nullable
        doc: 'bookIn. Nullable, No Value = 18446744073709551615'
      - id: account_type_optional
        type: u1_nullable
        doc: 'accountType. Nullable, No Value = 255'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: clearing_firm_id_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: principal_code
        type: str_8_nullable
        doc: 'principalCode. Nullable, No Value = 0'
      - id: cross_order_indicator_optional
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
      - id: book_in
        type: u8
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
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
      - id: price
        type: s8
        doc: 'price'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: side
        type: u1
        enum: side
        doc: 'side'
      - id: cross_order_indicator
        type: u1
        doc: 'crossOrderIndicator'
      - id: trade_time
        type: u8_nullable
        doc: 'tradeTime. Nullable, No Value = 18446744073709551615'
      - id: entering_counterparty
        type: str_8_nullable
        doc: 'enteringCounterparty. Nullable, No Value = 0'
      - id: session_optional
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
      - id: oe_partition_id
        type: u2
        doc: 'oEPartitionID'
      - id: logical_access_id
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
      - id: clearing_firm_id_optional
        type: str_8_nullable
        doc: 'clearingFirmID. Nullable, No Value = 0'
      - id: clearing_account
        type: str_16_nullable
        doc: 'clearingAccount. Nullable, No Value = 0'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
      - id: client_order_id
        type: s8
        doc: 'clientOrderID'
      - id: free_text
        type: str_18_nullable
        doc: 'freeText. Nullable, No Value = 0'
      - id: settlement_period_optional
        type: u1_nullable
        doc: 'settlementPeriod. Nullable, No Value = 255'
      - id: settlement_flag_optional
        type: u1_nullable
        doc: 'settlementFlag. Nullable, No Value = 255'
      - id: guarantee_flag_optional
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
        doc: 'bookIn'
      - id: book_out_time
        type: u8
        doc: 'bookOUTTime'
      - id: client_order_id
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
      - id: oe_session_id
        type: u8
        doc: 'oESessionID'
      - id: oegin_from_member
        type: u8
        doc: 'oEGINFromMember'
      - id: oegout_time_to_me
        type: u8
        doc: 'oEGOUTTimeToME'
      - id: order_id
        type: u8
        doc: 'orderID'
      - id: order_qty
        type: u8
        doc: 'orderQty'
      - id: order_side_optional
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
      - id: d_c_quote_request_message_non_modifiable_short_codes_groups
        type: d_c_quote_request_message_non_modifiable_short_codes_groups
        doc: 'NonModifiableShortCodes Block'
      - id: d_c_quote_request_message_short_codes_details_non_modifiable_groups
        type: d_c_quote_request_message_short_codes_details_non_modifiable_groups
        doc: 'ShortCodesDetailsNonModifiable Block'
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
        size: 8
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
  str_18_nullable:
    seq:
      - id: value
        size: 18
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
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
        size: 12
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
  str_11_nullable:
    seq:
      - id: value
        size: 11
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

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
    14:
      id: 'quote_advertisement'
      doc: 'Quote_Advertisement'
    15:
      id: 'delta_neutral_contingency_leg'
      doc: 'Delta_Neutral_Contingency_Leg'
    17:
      id: 'ers'
      doc: 'ERS'
    99:
      id: 'not_applicable'
      doc: 'Not_Applicable'
  phase_id:
    1:
      id: 'inaccessible'
      doc: 'Inaccessible'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'call'
      doc: 'Call'
    4:
      id: 'uncrossing'
      doc: 'Uncrossing'
    5:
      id: 'continuous'
      doc: 'Continuous'
    7:
      id: 'continuous_uncrossing'
      doc: 'Continuous_Uncrossing'
  trading_group_state:
    0:
      id: 'scheduled'
      doc: 'Scheduled'
    1:
      id: 'halted'
      doc: 'Halted'
  instrument_state:
    1:
      id: 'scheduled'
      doc: 'Scheduled'
    2:
      id: 'suspendeddueto_underlying'
      doc: 'Suspended_due_to_Underlying'
    3:
      id: 'suspended_kobi'
      doc: 'Suspended_KOBI'
    4:
      id: 'suspended_kobe'
      doc: 'Suspended_KOBE'
    5:
      id: 'suspended_new_listing'
      doc: 'Suspended_New_Listing'
    6:
      id: 'suspendedby_mo'
      doc: 'Suspended_by_MO'
    7:
      id: 'suspended_technical'
      doc: 'Suspended_Technical'
    8:
      id: 'reserved_dynamic_collars'
      doc: 'Reserved_Dynamic_Collars'
    9:
      id: 'reserved_static_collars'
      doc: 'Reserved_Static_Collars'
    10:
      id: 'reserved_waiting_for_lp'
      doc: 'Reserved_Waiting_For_LP'
    11:
      id: 'reserved_lp_limit'
      doc: 'Reserved_LP_Limit'
    12:
      id: 'instrument_deletion'
      doc: 'Instrument_Deletion'
    13:
      id: 'suspended_waitingfor_bbo'
      doc: 'Suspended_Waiting_for_BBO'
    14:
      id: 'suspended_waitingfor_tradable_state'
      doc: 'Suspended_Waiting_for_Tradable_State'
    15:
      id: 'random_uncrossing_period'
      doc: 'Random_Uncrossing_Period'
    16:
      id: 'expired'
      doc: 'Expired'
    17:
      id: 'uncrossing'
      doc: 'Uncrossing'
    18:
      id: 'reserveddueto_leg'
      doc: 'Reserved_due_to_Leg'
    19:
      id: 'suspendeddueto_leg'
      doc: 'Suspended_due_to_Leg'
    20:
      id: 'reserved_waitingfor_valid_assigned_broker_price'
      doc: 'Reserved_Waiting_for_Valid_Assigned_Broker_Price'
    21:
      id: 'reserved_future_limit_interruption_protection'
      doc: 'Reserved_Future_Limit_Interruption_Protection'
    22:
      id: 'suspended_waiting_for_market_operations'
      doc: 'Suspended_Waiting_For_Market_Operations'
  change_type:
    0:
      id: 'status_changes'
      doc: 'Status_Changes'
    1:
      id: 'scheduled_event_notification'
      doc: 'Scheduled_Event_Notification'
    2:
      id: 'status_changeand_scheduled_event_notification'
      doc: 'Status_Change_and_Scheduled_Event_Notification'
  book_state:
    1:
      id: 'inaccessible'
      doc: 'Inaccessible'
    2:
      id: 'closed'
      doc: 'Closed'
    3:
      id: 'call'
      doc: 'Call'
    4:
      id: 'uncrossing'
      doc: 'Uncrossing'
    5:
      id: 'continuous'
      doc: 'Continuous'
    6:
      id: 'halted'
      doc: 'Halted'
    7:
      id: 'continuous_uncrossing'
      doc: 'Continuous_Uncrossing'
    8:
      id: 'suspended'
      doc: 'Suspended'
    9:
      id: 'reserved'
      doc: 'Reserved'
    10:
      id: 'random_uncrossing_period'
      doc: 'Random_Uncrossing_Period'
  status_reason:
    0:
      id: 'scheduled'
      doc: 'Scheduled'
    4:
      id: 'collars_breach'
      doc: 'Collars_Breach'
    7:
      id: 'automatic_reopening'
      doc: 'Automatic_Reopening'
    8:
      id: 'no_liquidity_provider'
      doc: 'No_Liquidity_Provider'
    11:
      id: 'knock_inby_issuer'
      doc: 'KnockIn_by_Issuer'
    12:
      id: 'knock_outby_exchange'
      doc: 'KnockOut_by_Exchange'
    13:
      id: 'knock_outby_issuer'
      doc: 'KnockOut_by_Issuer'
    15:
      id: 'actionby_market_operations'
      doc: 'Action_by_Market_Operations'
    16:
      id: 'waitingfor_tradable_state'
      doc: 'Waiting_for_Tradable_State'
    20:
      id: 'new_listing'
      doc: 'New_Listing'
    21:
      id: 'dueto_underlying'
      doc: 'Due_to_Underlying'
    22:
      id: 'outsideof_l_pquotes'
      doc: 'Outside_of_LP_quotes'
    23:
      id: 'technical'
      doc: 'Technical'
    24:
      id: 'dueto_leg'
      doc: 'Due_to_Leg'
    25:
      id: 'dueto_main_market'
      doc: 'Due_to_Main_Market'
  trading_period:
    1:
      id: 'opening'
      doc: 'Opening'
    2:
      id: 'standard'
      doc: 'Standard'
    3:
      id: 'closing'
      doc: 'Closing'
  trading_side:
    1:
      id: 'bid_only'
      doc: 'Bid_Only'
    2:
      id: 'offer_only'
      doc: 'Offer_Only'
    3:
      id: 'pako'
      doc: 'PAKO'
    4:
      id: 'both_sides'
      doc: 'Both_Sides'
  price_limits:
    1:
      id: 'price_limits_enabled_normal'
      doc: 'Price_Limits_Enabled___Normal'
    2:
      id: 'price_limits_enabled_wide'
      doc: 'Price_Limits_Enabled___Wide'
    3:
      id: 'price_limits_enabled_widest'
      doc: 'Price_Limits_Enabled___Widest'
    4:
      id: 'price_limits_disabled'
      doc: 'Price_Limits_Disabled'
  quote_spread_multiplier:
    1:
      id: 'quote_spread_multiplier_1'
      doc: 'Quote_Spread_Multiplier_1'
    2:
      id: 'quote_spread_multiplier_2'
      doc: 'Quote_Spread_Multiplier_2'
    3:
      id: 'quote_spread_multiplier_3'
      doc: 'Quote_Spread_Multiplier_3'
  order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'Order_EntryCancelModify_Disabled'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'Order_EntryCancelModify_Enabled'
    2:
      id: 'canceland_modify_only'
      doc: 'Cancel_and_Modify_Only'
    3:
      id: 'cancel_only'
      doc: 'Cancel_Only'
  session:
    0:
      id: 'session_0'
      doc: 'Session_0'
    1:
      id: 'session_1'
      doc: 'Session_1'
    2:
      id: 'session_2'
      doc: 'Session_2'
    3:
      id: 'session_3'
      doc: 'Session_3'
    4:
      id: 'session_4'
      doc: 'Session_4'
    5:
      id: 'session_5'
      doc: 'Session_5'
    6:
      id: 'session_6'
      doc: 'Session_6'
    7:
      id: 'session_7'
      doc: 'Session_7'
    8:
      id: 'session_8'
      doc: 'Session_8'
    9:
      id: 'session_9'
      doc: 'Session_9'
  scheduled_event:
    0:
      id: 'cancel_previously_scheduled_event'
      doc: 'Cancel_Previously_Scheduled_Event'
    1:
      id: 'reopening'
      doc: 'Reopening'
    3:
      id: 'resumptionoftrading'
      doc: 'Resumption_of_trading'
    4:
      id: 'closed'
      doc: 'Closed'
    5:
      id: 'expiry'
      doc: 'Expiry'
    6:
      id: 'wholesale_largein_scale_li_stradesopenextension'
      doc: 'Wholesale_Large_in_Scale_LiS_trades_open_extension'
    7:
      id: 'wholesale_basistradesopenextension'
      doc: 'Wholesale_Basis_trades_open_extension'
    8:
      id: 'wholesale_against_actualstradesopenextension'
      doc: 'Wholesale_Against_Actuals_trades_open_extension'
    9:
      id: 'wholesale_largein_scale_li_s_packagetradesopenextension'
      doc: 'Wholesale_Large_in_Scale_LiS_Package_trades_open_extension'
    10:
      id: 'wholesale_exchange_for_swapstradesopenextension'
      doc: 'Wholesale_Exchange_For_Swaps_trades_open_extension'
    11:
      id: 'wholesale_trades_open_extension'
      doc: 'Wholesale_Trades_Open_Extension'
    12:
      id: 'suspension'
      doc: 'Suspension'
    13:
      id: 'collars_normal'
      doc: 'Collars_Normal'
    14:
      id: 'collars_wide'
      doc: 'Collars_Wide'
    15:
      id: 'pre_expiry'
      doc: 'Pre_Expiry'
    16:
      id: 'closing_price'
      doc: 'Closing_Price'
  trading_group_order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'Order_EntryCancelModify_Disabled'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'Order_EntryCancelModify_Enabled'
    2:
      id: 'canceland_modify_only'
      doc: 'Cancel_and_Modify_Only'
    3:
      id: 'cancel_only'
      doc: 'Cancel_Only'
  instrument_order_entry_qualifier:
    0:
      id: 'order_entry_cancel_modify_disabled'
      doc: 'Order_EntryCancelModify_Disabled'
    1:
      id: 'order_entry_cancel_modify_enabled'
      doc: 'Order_EntryCancelModify_Enabled'
    2:
      id: 'canceland_modify_only'
      doc: 'Cancel_and_Modify_Only'
    3:
      id: 'cancel_only'
      doc: 'Cancel_Only'
  price_limit_style:
    0:
      id: 'opening_call_price'
      doc: 'OpeningCallPrice'
    1:
      id: 'fair_value'
      doc: 'FairValue'
    2:
      id: 'future_market_price'
      doc: 'FutureMarketPrice'
    3:
      id: 'option_market_price'
      doc: 'OptionMarketPrice'
  price_type:
    2:
      id: 'official_daily'
      doc: 'Official_Daily'
    4:
      id: 'official_market_close'
      doc: 'Official_Market_Close'
    6:
      id: 'official_expiry'
      doc: 'Official_Expiry'
    7:
      id: 'provisional_intraday'
      doc: 'Provisional_Intraday'
    8:
      id: 'official_intraday'
      doc: 'Official_Intraday'
    9:
      id: 'official_ydsp'
      doc: 'Official_YDSP'
    10:
      id: 'na_vfortheinstrumentseligibletothe_nav_trading_facility'
      doc: 'NAV_for_the_instruments_eligible_to_the_NAV_Trading_Facility'
    12:
      id: 'adjusted_closing_price'
      doc: 'Adjusted_Closing_Price'
    13:
      id: 'subscription_price'
      doc: 'Subscription_Price'
    14:
      id: 'indicative_matching_price'
      doc: 'Indicative_Matching_Price'
    19:
      id: 'min_price_outof_session_trades'
      doc: 'Min_Price_Out_of_Session_Trades'
    20:
      id: 'max_price_outof_session_trades'
      doc: 'Max_Price_Out_of_Session_Trades'
    21:
      id: 'min_price_outof_session_block_trades'
      doc: 'Min_Price_Out_of_Session_Block_Trades'
    22:
      id: 'max_price_outof_session_block_trades'
      doc: 'Max_Price_Out_of_Session_Block_Trades'
    23:
      id: 'valuation_price'
      doc: 'Valuation_Price'
    24:
      id: 'fund_subscription'
      doc: 'Fund_Subscription'
    25:
      id: 'fund_redemption'
      doc: 'Fund_Redemption'
    26:
      id: 'uncrossing_price'
      doc: 'Uncrossing_Price'
    27:
      id: 'last_traded_price'
      doc: 'Last_Traded_Price'
    28:
      id: 'aip'
      doc: 'AIP'
    30:
      id: 'net_asset_value'
      doc: 'Net_Asset_Value'
    31:
      id: 'external_reference_price'
      doc: 'External_Reference_Price'
    33:
      id: 'closing_price'
      doc: 'Closing_Price'
    34:
      id: 'life_time_lowest_price'
      doc: 'Life_Time_Lowest_Price'
    35:
      id: 'life_time_highest_price'
      doc: 'Life_Time_Highest_Price'
    36:
      id: 'daily_lowest_price'
      doc: 'Daily_Lowest_Price'
    37:
      id: 'daily_highest_price'
      doc: 'Daily_Highest_Price'
    38:
      id: 'breached_dynamic_collar'
      doc: 'Breached_Dynamic_Collar'
    39:
      id: 'breached_static_collar'
      doc: 'Breached_Static_Collar'
  imbalance_qty_side:
    0:
      id: 'noimbalance'
      doc: 'No_imbalance'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  order_event_type:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'modify'
      doc: 'Modify'
    3:
      id: 'fill'
      doc: 'Fill'
    4:
      id: 'cancel'
      doc: 'Cancel'
    5:
      id: 'reject'
      doc: 'Reject'
    6:
      id: 'trigger'
      doc: 'Trigger'
    7:
      id: 'refill'
      doc: 'Refill'
    8:
      id: 'mtl'
      doc: 'MTL'
    9:
      id: 'vfa_vfc'
      doc: 'VFA_VFC'
    10:
      id: 'collar_breach'
      doc: 'CollarBreach'
    11:
      id: 'gtcgtd_reload'
      doc: 'GTC_GTD_Reload'
    12:
      id: 'open_order_request'
      doc: 'Open_Order_Request'
    13:
      id: 'expired_reload'
      doc: 'Expired_Reload'
    14:
      id: 'killedby_corporate_event_reload'
      doc: 'Killed_by_Corporate_Event_Reload'
    15:
      id: 'ownership_request'
      doc: 'Ownership_Request'
    18:
      id: 'implicit_field'
      doc: 'Implicit'
    19:
      id: 'routed'
      doc: 'Routed'
    20:
      id: 'routed_new'
      doc: 'Routed_New'
    21:
      id: 'routed_fill'
      doc: 'Routed_Fill'
    22:
      id: 'routed_cancel'
      doc: 'Routed_Cancel'
    23:
      id: 'move_darkto_cob'
      doc: 'Move_Dark_to_COB'
  account_type_internal:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    3:
      id: 'retail_liquidity_provider'
      doc: 'Retail_Liquidity_Provider'
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
    9:
      id: 'managed_client'
      doc: 'Managed_Client'
    10:
      id: 'foreign'
      doc: 'Foreign'
    11:
      id: 'managed_foreign'
      doc: 'Managed_Foreign'
    12:
      id: 'liquidity_contract'
      doc: 'Liquidity_Contract'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'Undertaking_for_Collective_Investment'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
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
    18:
      id: 'reload_ack'
      doc: 'Reload_Ack'
    21:
      id: 'rfie_ack'
      doc: 'RFIE_Ack'
    22:
      id: 'cross_order_ack'
      doc: 'Cross_Order_Ack'
    23:
      id: 'move_darkto_co_bas_limit'
      doc: 'Move_Dark_to_COB_as_Limit'
    24:
      id: 'move_darkto_co_bas_market'
      doc: 'Move_Dark_to_COB_as_Market'
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
  order_side:
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
    12:
      id: 'implied'
      doc: 'Implied'
    13:
      id: 'posttrade_implied'
      doc: 'Post_trade_Implied'
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
    10:
      id: 'good_till_month_gtm'
      doc: 'Good_Till_Month__GTM_'
  execution_phase_optional:
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
    45:
      id: 'trade_reversal'
      doc: 'Trade_Reversal'
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
    18:
      id: 'ordercancelleddueto_static_collars'
      doc: 'Order_cancelled_due_to_Static_Collars'
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
    31:
      id: 'order_cancelledduetobreachof_ownership_limit'
      doc: 'Order_Cancelled_due_to_breach_of_Ownership_Limit'
    32:
      id: 'order_cancelledduetobreachof_credit_limit'
      doc: 'Order_Cancelled_due_to_breach_of_Credit_Limit'
    33:
      id: 'order_cancelledupon_cs_drequest'
      doc: 'Order_Cancelled_upon_CSD_request'
    34:
      id: 'order_cancelledduetobreachof_short_selling_limit'
      doc: 'Order_Cancelled_due_to_breach_of_Short_Selling_Limit'
    35:
      id: 'order_cancelleddueto_instrumentnotbeing_eligiblefor_margin'
      doc: 'Order_Cancelled_due_to_Instrument_not_being_Eligible_for_Margin'
    36:
      id: 'order_cancelledduetoapotentialtradeoutside_fs_plimits'
      doc: 'Order_Cancelled_due_to_a_potential_trade_outside_FSP_limits'
    37:
      id: 'remaining_rfc_quantity_cancelled'
      doc: 'Remaining_RFC_Quantity_Cancelled'
    38:
      id: 'order_cancelledduetoanincorrect_reactor_response'
      doc: 'Order_Cancelled_due_to_an_incorrect_Reactor_Response'
    39:
      id: 'order_cancelleddueto_instrumentnot_eligiblefor_short_selling'
      doc: 'Order_Cancelled_due_to_Instrument_not_Eligible_for_ShortSelling'
    40:
      id: 'order_cancelledduetobreachof_short_sell_price_check'
      doc: 'Order_Cancelled_due_to_breach_of_ShortSell_Price_Check'
    41:
      id: 'ordercancelleddueto_order_price_control_collarbreach'
      doc: 'Order_cancelled_due_to_Order_Price_Control_Collar_breach'
    42:
      id: 'ordercancelleddueto_execution_prevention_across_all_firms'
      doc: 'Order_cancelled_due_to_Execution_Prevention_Across_All_Firms'
    43:
      id: 'cancelleddueto_breachof_me_psetbyaclearingriskmanager'
      doc: 'Cancelled_due_to_Breach_of_MEP_set_by_a_clearing_risk_manager'
    44:
      id: 'cancelleddueto_breachof_me_psetbyamemberriskmanager'
      doc: 'Cancelled_due_to_Breach_of_MEP_set_by_a_member_risk_manager'
  collar_rej_type:
    1:
      id: 'lowdynamiccollar'
      doc: 'Low_dynamic_collar'
    2:
      id: 'highdynamiccollar'
      doc: 'High_dynamic_collar'
  counterparty_reason_type:
    1:
      id: 'internal_matching_service'
      doc: 'Internal_Matching_Service'
    2:
      id: 'internal_clearing_service'
      doc: 'Internal_Clearing_Service'
    3:
      id: 'primary_market_modelandnotbroadcasttothe_clearing_house'
      doc: 'Primary_Market_Model_and_not_broadcast_to_the_Clearing_House'
    4:
      id: 'public_auctions_market_vpu'
      doc: 'Public_Auctions_Market_VPU'
    5:
      id: 'nonclearableinstrument'
      doc: 'Non_clearable_instrument'
    6:
      id: 'firm_id_publication_rfq'
      doc: 'Firm_ID_Publication_RFQ'
    7:
      id: 'bilateral_settlement'
      doc: 'Bilateral_Settlement_'
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
  order_sweep_reason:
    1:
      id: 'dvc_breached'
      doc: 'DVC_Breached'
  stop_triggered_time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel'
      doc: 'Good_Till_Cancel'
    3:
      id: 'immediateor_cancel'
      doc: 'Immediate_or_Cancel'
    6:
      id: 'goodtill_date'
      doc: 'Good_till_Date'
    10:
      id: 'good_till_month_gtm'
      doc: 'Good_Till_Month__GTM_'
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
  clearing_instruction_optional:
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
    9:
      id: 'managed_client'
      doc: 'Managed_Client'
    10:
      id: 'foreign'
      doc: 'Foreign'
    11:
      id: 'managed_foreign'
      doc: 'Managed_Foreign'
    12:
      id: 'liquidity_contract'
      doc: 'Liquidity_Contract'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'Undertaking_for_Collective_Investment'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
  market_phase_flag:
    1:
      id: 'continuoustradingonlydefault'
      doc: 'Continuous_trading_only__default_'
    2:
      id: 'trading_at_last_ta_ltradingonly'
      doc: 'Trading_At_Last__TAL__trading_only'
    3:
      id: 'both'
      doc: 'Both'
  margin_trading_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  leg_side:
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
  original_short_code_type:
    1:
      id: 'original_ewfsc'
      doc: 'Original_EWFSC'
    2:
      id: 'original_cisc'
      doc: 'Original_CISC'
    3:
      id: 'original_invsc'
      doc: 'Original_INVSC'
    4:
      id: 'original_nbsc'
      doc: 'Original_NBSC'
  short_code_role:
    1:
      id: 'executing_firm'
      doc: 'Executing_Firm'
    3:
      id: 'client_id'
      doc: 'Client_ID'
    12:
      id: 'executing_trader'
      doc: 'Executing_Trader'
    17:
      id: 'contra_firm'
      doc: 'Contra_Firm'
    26:
      id: 'correspondent_broker'
      doc: 'Correspondent_Broker'
    122:
      id: 'investment_decision_maker'
      doc: 'Investment_Decision_Maker'
  short_code_role_qualifier:
    22:
      id: 'algorithm'
      doc: 'Algorithm'
    23:
      id: 'firmor_legal_entity'
      doc: 'Firm_or_Legal_Entity'
    24:
      id: 'natural_person'
      doc: 'Natural_Person'
  event_short_code_type:
    1:
      id: 'event_ewfsc'
      doc: 'Event_EWFSC'
    2:
      id: 'event_cisc'
      doc: 'Event_CISC'
  order_side_optional:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'cross'
      doc: 'Cross'
  time_in_force_optional:
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
    10:
      id: 'good_till_month_gtm'
      doc: 'Good_Till_Month__GTM_'
  update_type:
    1:
      id: 'best_bid'
      doc: 'Best_Bid'
    2:
      id: 'best_offer'
      doc: 'Best_Offer'
    3:
      id: 'new_bid'
      doc: 'New_Bid'
    4:
      id: 'new_offer'
      doc: 'New_Offer'
    5:
      id: 'updated_bid'
      doc: 'Updated_Bid'
    6:
      id: 'updated_offer'
      doc: 'Updated_Offer'
    7:
      id: 'total_traded_volume'
      doc: 'Total_Traded_Volume'
    8:
      id: 'implied_bid'
      doc: 'Implied_Bid'
    9:
      id: 'implied_offer'
      doc: 'Implied_Offer'
    10:
      id: 'requestfor_quote'
      doc: 'Request_for_Quote'
    11:
      id: 'requestfor_quote_bid'
      doc: 'Request_for_Quote_Bid'
    12:
      id: 'requestfor_size'
      doc: 'Request_for_Size'
    13:
      id: 'requestfor_quote_offer'
      doc: 'Request_for_Quote_Offer'
    14:
      id: 'high_dynamic_collar'
      doc: 'High_Dynamic_Collar'
    15:
      id: 'low_dynamic_collar'
      doc: 'Low_Dynamic_Collar'
    16:
      id: 'new_bid_rlp'
      doc: 'New_Bid_RLP'
    17:
      id: 'new_offer_rlp'
      doc: 'New_Offer_RLP'
    18:
      id: 'updated_bid_rlp'
      doc: 'Updated_Bid_RLP'
    19:
      id: 'updated_offer_rlp'
      doc: 'Updated_Offer_RLP'
    24:
      id: 'conventional_trade'
      doc: 'Conventional_Trade'
    25:
      id: 'requestfor_cross_rfc_queued'
      doc: 'Request_for_Cross_RFC_Queued'
    26:
      id: 'requestfor_cross_rfc'
      doc: 'Request_for_Cross_RFC'
    27:
      id: 'largein_scale_li_s_trade'
      doc: 'Large_in_Scale_LiS_Trade'
    28:
      id: 'basis_trade'
      doc: 'Basis_Trade'
    29:
      id: 'largein_scale_li_s_package_trade'
      doc: 'Large_in_Scale_LiS_Package_Trade'
    30:
      id: 'guaranteed_cross_trade'
      doc: 'Guaranteed_Cross_Trade'
    31:
      id: 'against_actual_trade'
      doc: 'Against_Actual_Trade'
    32:
      id: 'asset_allocation_trade'
      doc: 'Asset_Allocation_Trade'
    34:
      id: 'exchangefor_swap_trade'
      doc: 'Exchange_for_Swap_Trade'
    35:
      id: 'dark_trade'
      doc: 'Dark_Trade'
    36:
      id: 'exchangefor_physical_trade_cash_leg'
      doc: 'Exchange_for_Physical_Trade_Cash_Leg'
    37:
      id: 'strategy_leg_conventional_trade'
      doc: 'Strategy_Leg_Conventional_Trade'
    38:
      id: 'strategy_leg_largein_scale_li_s_trade'
      doc: 'Strategy_Leg_Large_in_Scale_LiS_Trade'
    39:
      id: 'strategy_leg_basis_trade'
      doc: 'Strategy_Leg_Basis_Trade'
    40:
      id: 'strategy_leg_guaranteed_cross_trade'
      doc: 'Strategy_Leg_Guaranteed_Cross_Trade'
    41:
      id: 'strategy_leg_against_actual_trade'
      doc: 'Strategy_Leg_Against_Actual_Trade'
    42:
      id: 'strategy_leg_asset_allocation_trade'
      doc: 'Strategy_Leg_Asset_Allocation_Trade'
    44:
      id: 'strategy_leg_exchange_for_swap_trade'
      doc: 'Strategy_Leg_Exchange_For_Swap_Trade'
    45:
      id: 'strategy_leg_exchange_for_physical_trade'
      doc: 'Strategy_Leg_Exchange_For_Physical_Trade'
    46:
      id: 'bo_b_trade'
      doc: 'BoB_Trade'
    48:
      id: 'atom_x_trade'
      doc: 'AtomX_Trade'
    50:
      id: 'trade_cancellation'
      doc: 'Trade_Cancellation'
    51:
      id: 'outof_market_trade'
      doc: 'Out_of_Market_Trade'
    52:
      id: 'delta_neutral_trade_underlying_cash_leg'
      doc: 'Delta_Neutral_Trade_Underlying_Cash_Leg'
    53:
      id: 'delta_neutral_trade_underlying_future_leg'
      doc: 'Delta_Neutral_Trade_Underlying_Future_Leg'
    54:
      id: 'euronext_fund_service_trade'
      doc: 'Euronext_Fund_Service_Trade'
    55:
      id: 'secondary_listing_trade'
      doc: 'Secondary_Listing_Trade'
    56:
      id: 'requestfor_cross_trade'
      doc: 'Request_for_Cross_Trade'
    57:
      id: 'requestfor_cross_strategy_leg_trade'
      doc: 'Request_for_Cross_Strategy_Leg_Trade'
    58:
      id: 'new_bid_with_liquidity_provider'
      doc: 'New_Bid_With_Liquidity_Provider'
    59:
      id: 'new_offer_with_liquidity_provider'
      doc: 'New_Offer_With_Liquidity_Provider'
    60:
      id: 'updated_bid_with_liquidity_provider'
      doc: 'Updated_Bid_With_Liquidity_Provider'
    61:
      id: 'updated_offer_with_liquidity_provider'
      doc: 'Updated_Offer_With_Liquidity_Provider'
    63:
      id: 'low_static_collar'
      doc: 'Low_Static_Collar'
    64:
      id: 'high_static_collar'
      doc: 'High_Static_Collar'
    65:
      id: 'market_vwap_operation_trade'
      doc: 'Market_VWAP_Operation_Trade'
    66:
      id: 'requestfor_size_bid'
      doc: 'Request_for_Size_Bid'
    67:
      id: 'requestfor_size_offer'
      doc: 'Request_for_Size_Offer'
    70:
      id: 'low_lp_collar'
      doc: 'Low_LP_Collar'
    71:
      id: 'high_lp_collar'
      doc: 'High_LP_Collar'
    72:
      id: 'etfmtfnav_tradepriceinbp'
      doc: 'ETF_MTF_NAV_Trade_price_in_bp'
    73:
      id: 'etfmtfnav_dark_tradepriceinbp'
      doc: 'ETF_MTF_NAV_Dark_Trade_price_in_bp'
    74:
      id: 'new_bidon_wholesale_rfc'
      doc: 'New_Bid_on_Wholesale_RFC'
    75:
      id: 'new_offeron_wholesale_rfc'
      doc: 'New_Offer_on_Wholesale_RFC'
    76:
      id: 'updated_bidon_wholesale_rfc'
      doc: 'Updated_Bid_on_Wholesale_RFC'
    77:
      id: 'updated_offeron_wholesale_rfc'
      doc: 'Updated_Offer_on_Wholesale_RFC'
    78:
      id: 'clear_wholesale_rfc'
      doc: 'Clear_Wholesale_RFC'
    79:
      id: 'guaranteed_cross_negotiateddeal_nliq'
      doc: 'Guaranteed_Cross_Negotiated_deal_NLIQ'
    80:
      id: 'guaranteed_cross_negotiateddeal_oilq'
      doc: 'Guaranteed_Cross_Negotiated_deal_OILQ'
    81:
      id: 'largein_scale_trade'
      doc: 'Large_in_Scale_Trade'
    82:
      id: 'largein_scale_tradeinbasispoints'
      doc: 'Large_in_Scale_Trade_in_basis_points'
    83:
      id: 'largein_scale_package_tradeinbasispoints'
      doc: 'Large_in_Scale_Package_Trade_in_basis_points'
    84:
      id: 'strategy_leg_largein_scale_tradeinbasispoints'
      doc: 'Strategy_Leg_Large_in_Scale_Trade_in_basis_points'
    86:
      id: 'new_bid_rfq_answer'
      doc: 'New_Bid_RFQ_Answer'
    87:
      id: 'new_offer_rfq_answer'
      doc: 'New_Offer_RFQ_Answer'
    88:
      id: 'updated_bid_rfq_answer'
      doc: 'Updated_Bid_RFQ_Answer'
    89:
      id: 'updated_offer_rfq_answer'
      doc: 'Updated_Offer_RFQ_Answer'
    90:
      id: 'bid_execution_summary'
      doc: 'Bid_Execution_Summary'
    91:
      id: 'aqs_expansion_factor'
      doc: 'AQS_Expansion_Factor'
    92:
      id: 'collars_expansion_factor'
      doc: 'Collars_Expansion_Factor'
    93:
      id: 'collars_enabled'
      doc: 'Collars_Enabled'
    94:
      id: 'collars_disabled'
      doc: 'Collars_Disabled'
    95:
      id: 'dcrp_inter_month_spread'
      doc: 'DCRP_Inter_Month_Spread'
    96:
      id: 'fsp_reference_price'
      doc: 'FSP_Reference_Price_'
    97:
      id: 'offer_execution_summary'
      doc: 'Offer_Execution_Summary'
    98:
      id: 'fsp_triggered'
      doc: 'FSP_Triggered'
    99:
      id: 'mid_point_bbo'
      doc: 'MidPoint_BBO'
    100:
      id: 'conventional_trade_provisionalprice'
      doc: 'Conventional_Trade___Provisional_price'
    101:
      id: 'high_order_price_control_collar'
      doc: 'High_Order_Price_Control_Collar'
    102:
      id: 'low_order_price_control_collar'
      doc: 'Low_Order_Price_Control_Collar'
    103:
      id: 'order_price_control_collar_reference_price'
      doc: 'Order_Price_Control_Collar_Reference_Price'
    104:
      id: 'issuing_or_tender_offer_trade'
      doc: 'Issuing_Or_Tender_Offer_Trade'
    105:
      id: 'rfq_trade'
      doc: 'RFQ_Trade'
    106:
      id: 'flip_spread'
      doc: 'FLIP_Spread'
    107:
      id: 'flip_reference_price'
      doc: 'FLIP_Reference_Price'
    252:
      id: 'static_collar_reference_price'
      doc: 'Static_Collar_Reference_Price'
    253:
      id: 'dynamic_collar_reference_price'
      doc: 'Dynamic_Collar_Reference_Price'
    254:
      id: 'clear_book'
      doc: 'Clear_Book'
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
  declaration_event_type:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'confirmed'
      doc: 'Confirmed'
    3:
      id: 'canceled'
      doc: 'Canceled'
    4:
      id: 'matched'
      doc: 'Matched'
    5:
      id: 'rejected'
      doc: 'Rejected'
    6:
      id: 'refused'
      doc: 'Refused'
    7:
      id: 'expired'
      doc: 'Expired'
    8:
      id: 'eliminatedbythe_system'
      doc: 'Eliminated_by_the_System'
    9:
      id: 'declaration_createdby_mo'
      doc: 'Declaration_Created_by_MO'
    10:
      id: 'cancelled_upon_cs_drequest'
      doc: 'Cancelled_Upon_CSD_request'
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
  declaration_kill_reason:
    1:
      id: 'canceledby_entering_firm'
      doc: 'Canceled_by_Entering_Firm'
    2:
      id: 'refusedby_counterpart'
      doc: 'Refused_by_Counterpart'
    3:
      id: 'canceledby_mo'
      doc: 'Canceled_by_MO'
    4:
      id: 'expired'
      doc: 'Expired'
    5:
      id: 'eliminatedbythe_system'
      doc: 'Eliminated_by_the_System'
    6:
      id: 'cancelled_upon_cs_drequest'
      doc: 'Cancelled_Upon_CSD_request'
  session_optional:
    0:
      id: 'session_0'
      doc: 'Session_0'
    1:
      id: 'session_1'
      doc: 'Session_1'
    2:
      id: 'session_2'
      doc: 'Session_2'
    3:
      id: 'session_3'
      doc: 'Session_3'
    4:
      id: 'session_4'
      doc: 'Session_4'
    5:
      id: 'session_5'
      doc: 'Session_5'
    6:
      id: 'session_6'
      doc: 'Session_6'
    7:
      id: 'session_7'
      doc: 'Session_7'
    8:
      id: 'session_8'
      doc: 'Session_8'
    9:
      id: 'session_9'
      doc: 'Session_9'
  guarantee_flag_optional:
    1:
      id: 'clearedbutnot_guaranteed'
      doc: 'Cleared_but_not_Guaranteed'
    2:
      id: 'clearedand_guaranteed'
      doc: 'Cleared_and_Guaranteed'
  exec_phase:
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
  transparency_indicator:
    0:
      id: 'lit_regular_trade'
      doc: 'LitRegular_Trade'
    1:
      id: 'dark_tradeand_immediate_publication'
      doc: 'Dark_Trade_and_Immediate_Publication'
    2:
      id: 'dark_tradeand_deferred_publication'
      doc: 'Dark_Trade_and_Deferred_Publication'
  account_type_internal_optional:
    1:
      id: 'client'
      doc: 'Client'
    2:
      id: 'house'
      doc: 'House'
    3:
      id: 'retail_liquidity_provider'
      doc: 'Retail_Liquidity_Provider'
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
    9:
      id: 'managed_client'
      doc: 'Managed_Client'
    10:
      id: 'foreign'
      doc: 'Foreign'
    11:
      id: 'managed_foreign'
      doc: 'Managed_Foreign'
    12:
      id: 'liquidity_contract'
      doc: 'Liquidity_Contract'
    13:
      id: 'undertakingfor_collective_investment'
      doc: 'Undertaking_for_Collective_Investment'
    14:
      id: 'omega_client'
      doc: 'Omega_Client'
    15:
      id: 'ceres_client'
      doc: 'Ceres_Client'
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
  rfq_status:
    0:
      id: 'alive'
      doc: 'Alive'
    1:
      id: 'confirmed'
      doc: 'Confirmed'
    2:
      id: 'canceled'
      doc: 'Canceled'
    3:
      id: 'expired'
      doc: 'Expired'

