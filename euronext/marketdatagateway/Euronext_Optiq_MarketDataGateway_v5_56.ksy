# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq MarketDataGateway Sbe v5.56
#
# Protocol:
#   Organization: Euronext
#   Protocol: Market Data Gateway
#   Encoding: Simple Binary Encoding
#   Version: 5.56
#   Date: 6/4/2025
#   Specification: optiq-mdg-messages-interface-specification-euronext-cash-and-derivatives-markets-external-v53561-tc
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
  id: euronext_optiq_marketdatagateway_sbe_v5_56
  title: Euronext Optiq MarketDataGateway Sbe v5.56
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Market Data Gateway Sbe v5.56'
doc-ref: https://connect2.euronext.com/en/membership/resources/it-documentation

seq:
  - id: market_data_packet_header
    type: market_data_packet_header_struct
    doc: 'Optiq Udp Market Data Packet Header'
  - id: optiq_message
    type: optiq_message_struct
    repeat: eos
    doc: 'Optiq Udp Message'

types:
  market_data_packet_header_struct:
    seq:
      - id: packet_time
        type: nanosecond_timestamp
        doc: 'Time when the packet is pushed to the clients. Nanoseconds since Unix epoch'
      - id: packet_sequence_number
        type: u4
        doc: 'Each channel has its own PSN sequence'
      - id: packet_flags
        type: packet_flags
        doc: 'Packet Flags'
      - id: channel_id
        type: u2
        doc: 'Identifies the channel'
  packet_flags:
    seq:
      - id: compression
        type: b1
        doc: 'body of the packet is compressed'
      - id: mdg_restart_count
        type: b3
        doc: 'Will be set to 0 every morning and incremented for each restart of MDG in the same day'
      - id: psn_high_weight
        type: b3
        doc: 'Packet Sequence Number goes over (2^32)-1. They are PSN high weight bits'
      - id: has_start_of_day_snapshot
        type: b1
        doc: 'Packet contains Start Of Day Snapshot'
      - id: has_end_of_day_snapshot
        type: b1
        doc: 'Packet contains End Of Day Snapshot'
      - id: has_status_message
        type: b1
        doc: 'Packet contains a Health Status (1103) message, Start Of Day (1101) message or End Of Day (1102) message'
      - id: reserved_bits
        type: b6
        doc: 'Bits Reserved for future use'
  optiq_message_struct:
    seq:
      - id: frame
        type: u2
        doc: 'Total bytes of packet including this header'
      - id: message_header
        type: message_header
        doc: 'Optiq Sbe message header — message identifiers and length of message root'
      - id: payload
        size: frame - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::start_of_day_message': start_of_day_message
            'template_id::end_of_day_message': end_of_day_message
            'template_id::health_status_message': health_status_message
            'template_id::technical_notification_message': technical_notification_message
            'template_id::market_update_message': market_update_message
            'template_id::order_update_message': order_update_message
            'template_id::price_update_message': price_update_message
            'template_id::full_trade_information_message': full_trade_information_message
            'template_id::market_status_change_message': market_status_change_message
            'template_id::timetable_message': timetable_message
            'template_id::standing_data_message': standing_data_message
            'template_id::real_time_index_message': real_time_index_message
            'template_id::statistics_message': statistics_message
            'template_id::index_summary_message': index_summary_message
            'template_id::strategy_standing_data_message': strategy_standing_data_message
            'template_id::contract_standing_data_message': contract_standing_data_message
            'template_id::outright_standing_data_message': outright_standing_data_message
            'template_id::long_order_update_message': long_order_update_message
            'template_id::lis_package_structure_message': lis_package_structure_message
            'template_id::apa_quotes_message': apa_quotes_message
            'template_id::apa_standing_data_message': apa_standing_data_message
            'template_id::apa_full_trade_information_message': apa_full_trade_information_message
            'template_id::bf_instrument_reference_message': bf_instrument_reference_message
            'template_id::bf_trade_message': bf_trade_message
            'template_id::bfnav_message': bfnav_message
            'template_id::bf_instrument_suspension_message': bf_instrument_suspension_message
            'template_id::start_of_snapshot_message': start_of_snapshot_message
            'template_id::end_of_snapshot_message': end_of_snapshot_message
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
  start_of_day_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: session_trading_day
        type: u2
        doc: 'sessionTradingDay'
  end_of_day_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: session_trading_day
        type: u2
        doc: 'sessionTradingDay'
  health_status_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
  technical_notification_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: technical_notification_type
        type: u1
        enum: technical_notification_type
        doc: 'technicalNotificationType'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: retransmission_start_time
        type: nanosecond_timestamp_nullable
        doc: 'retransmissionStartTime. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: retransmission_end_time
        type: nanosecond_timestamp_nullable
        doc: 'retransmissionEndTime. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
  market_update_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: market_updates_groups
        type: market_updates_groups
        doc: 'Updates Block'
  market_updates_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: market_updates_group
        type: market_updates_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Updates'
  group_size_encoding:
    seq:
      - id: block_length_short
        type: u1
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  market_updates_group:
    seq:
      - id: update_type
        type: u1
        enum: update_type
        doc: 'updateType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: number_of_orders
        type: u2_nullable
        doc: 'numberOfOrders. Nullable, No Value = 65535'
      - id: price
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: quantity_optional
        type: u8_nullable
        doc: 'quantity. Nullable, No Value = 18446744073709551615'
  order_update_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: order_updates_groups
        type: order_updates_groups
        doc: 'Orders Block'
  order_updates_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: order_updates_group
        type: order_updates_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Orders'
  order_updates_group:
    seq:
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'actionType'
      - id: order_priority
        type: u8_nullable
        doc: 'orderPriority. Nullable, No Value = 18446744073709551615'
      - id: previous_priority
        type: u8_nullable
        doc: 'previousPriority. Nullable, No Value = 18446744073709551615'
      - id: order_type
        type: u1_nullable
        doc: 'orderType. Nullable, No Value = 255'
      - id: order_px
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_side
        type: u1_nullable
        doc: 'orderSide. Nullable, No Value = 255'
      - id: order_quantity
        type: u8_nullable
        doc: 'orderQuantity. Nullable, No Value = 18446744073709551615'
      - id: peg_offset
        type: s1_nullable
        doc: 'pegOffset. Nullable, No Value = -128'
  price_update_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: price_updates_groups
        type: price_updates_groups
        doc: 'Prices Block'
  price_updates_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: price_updates_group
        type: price_updates_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Prices'
  price_updates_group:
    seq:
      - id: price_type
        type: u1
        enum: price_type
        doc: 'priceType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: price
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
      - id: price_qualifier
        type: u1_nullable
        doc: 'priceQualifier. Nullable, No Value = 255'
  full_trade_information_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        doc: 'tradingDateTime'
      - id: publication_date_time
        type: str_27_nullable
        doc: 'publicationDateTime. Nullable, No Value = 0'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'tradeType'
      - id: mifid_instrument_id_type_optional
        type: str_4_nullable
        doc: 'mifidInstrumentIdType. Nullable, No Value = 0'
      - id: mifid_instrument_id_optional
        type: str_12_nullable
        doc: 'mifidInstrumentID. Nullable, No Value = 0'
      - id: mifid_execution_id
        type: str
        size: 52
        encoding: ASCII
        doc: 'mifidExecutionID'
      - id: mifid_price_optional
        type: str_20_nullable
        doc: 'mifidPrice. Nullable, No Value = 0'
      - id: mifid_quantity
        type: str
        size: 20
        encoding: ASCII
        doc: 'mifidQuantity'
      - id: mifid_price_notation
        type: str_4_nullable
        doc: 'mifidPriceNotation. Nullable, No Value = 0'
      - id: mifid_currency
        type: str_3_nullable
        doc: 'mifidCurrency. Nullable, No Value = 0'
      - id: mifid_qty_in_msrmt_unit_notation
        type: str_25_nullable
        doc: 'miFIDQtyinMsrmtUnitNotation. Nullable, No Value = 0'
      - id: mifid_quantity_measurement_unit
        type: str_20_nullable
        doc: 'mifidQuantityMeasurementUnit. Nullable, No Value = 0'
      - id: mifid_notional_amount
        type: str_20_nullable
        doc: 'miFIDNotionalAmount. Nullable, No Value = 0'
      - id: notional_currency
        type: str_3_nullable
        doc: 'notionalCurrency. Nullable, No Value = 0'
      - id: mifid_clearing_flag
        type: str_5_nullable
        doc: 'miFIDClearingFlag. Nullable, No Value = 0'
      - id: mmt_market_mechanism
        type: u1_nullable
        doc: 'mMTMarketMechanism. Nullable, No Value = 255'
      - id: mmt_trading_mode
        type: u1
        enum: mmt_trading_mode
        doc: 'mMTTradingMode. Nullable, No Value = 0'
      - id: mmt_transaction_category
        type: str_4_nullable
        doc: 'mMTTransactionCategory. Nullable, No Value = 0'
      - id: mmt_negotiation_indicator
        type: str_4_nullable
        doc: 'mMTNegotiationIndicator. Nullable, No Value = 0'
      - id: mmt_agency_cross_trade_indicator
        type: str_4_nullable
        doc: 'mMTAgencyCrossTradeIndicator. Nullable, No Value = 0'
      - id: mmt_modification_indicator_char_4_optional
        type: str_4_nullable
        doc: 'mMTModificationIndicator. Nullable, No Value = 0'
      - id: mmt_benchmark_indicator
        type: str_4_nullable
        doc: 'mMTBenchmarkIndicator. Nullable, No Value = 0'
      - id: mmt_special_dividend_indicator
        type: str_4_nullable
        doc: 'mMTSpecialDividendIndicator. Nullable, No Value = 0'
      - id: mmt_off_book_automated_indicator
        type: u1
        enum: mmt_off_book_automated_indicator
        doc: 'mMTOffBookAutomatedIndicator. Nullable, No Value = 0'
      - id: mmt_contributionto_price
        type: str_4_nullable
        doc: 'mMTContributiontoPrice. Nullable, No Value = 0'
      - id: mmt_algorithmic_indicator
        type: str_4_nullable
        doc: 'mMTAlgorithmicIndicator. Nullable, No Value = 0'
      - id: mmt_publication_mode
        type: str_4_nullable
        doc: 'mMTPublicationMode. Nullable, No Value = 0'
      - id: mmt_post_trade_deferral
        type: str_4_nullable
        doc: 'mMTPostTradeDeferral. Nullable, No Value = 0'
      - id: mmt_duplicative_indicator
        type: str_4_nullable
        doc: 'mMTDuplicativeIndicator. Nullable, No Value = 0'
      - id: trade_qualifier
        type: trade_qualifier
        doc: 'TradeQualifier_set bit set'
      - id: transaction_type
        type: u1_nullable
        doc: 'transactionType. Nullable, No Value = 255'
      - id: effective_date_indicator
        type: u1_nullable
        doc: 'effectiveDateIndicator. Nullable, No Value = 255'
      - id: block_trade_code
        type: u1
        enum: block_trade_code
        doc: 'blockTradeCode. Nullable, No Value = 0'
      - id: trade_reference
        type: str_30_nullable
        doc: 'tradeReference. Nullable, No Value = 0'
      - id: original_report_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'originalReportTimestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: transparency_indicator
        type: u1_nullable
        doc: 'transparencyIndicator. Nullable, No Value = 255'
      - id: currency_coefficient
        type: u4_nullable
        doc: 'currencyCoefficient. Nullable, No Value = 4294967295'
      - id: price_multiplier
        type: u4_nullable
        doc: 'priceMultiplier. Nullable, No Value = 4294967295'
      - id: price_multiplier_decimals
        type: u1_nullable
        doc: 'priceMultiplierDecimals. Nullable, No Value = 255'
      - id: venue
        type: str
        size: 11
        encoding: ASCII
        doc: 'venue'
      - id: start_time_vwap
        type: u4_nullable
        doc: 'startTimeVwap. Nullable, No Value = 4294967295'
      - id: end_time_vwap
        type: u4_nullable
        doc: 'endTimeVwap. Nullable, No Value = 4294967295'
      - id: mifid_emission_allowance_type
        type: str_4_nullable
        doc: 'miFIDEmissionAllowanceType. Nullable, No Value = 0'
      - id: market_of_reference_mic
        type: str_4_nullable
        doc: 'marketOfReferenceMIC. Nullable, No Value = 0'
      - id: evaluated_price
        type: s8_nullable
        doc: 'evaluatedPrice. Nullable, No Value = -9223372036854775808'
      - id: message_price_notation
        type: u1_nullable
        doc: 'messagePriceNotation. Nullable, No Value = 255'
      - id: settlement_date
        type: u2_nullable
        doc: 'settlementDate. Nullable, No Value = 65535'
      - id: repo_settlement_date
        type: u2_nullable
        doc: 'repoSettlementDate. Nullable, No Value = 65535'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
      - id: missing_price
        type: str_4_nullable
        doc: 'missingPrice. Nullable, No Value = 0'
      - id: mmt_pre_trade_transparency_waiver_relatedto_sizeand_scale
        type: str_4_nullable
        doc: 'mMTPreTradeTransparencyWaiverRelatedtoSizeandScale. Nullable, No Value = 0'
      - id: mmt_portfolio_transaction_indicator
        type: str_4_nullable
        doc: 'mMTPortfolioTransactionIndicator. Nullable, No Value = 0'
      - id: mmt_contingent_transaction_indicator
        type: str_4_nullable
        doc: 'mMTContingentTransactionIndicator. Nullable, No Value = 0'
      - id: mmt_publication_mode_illiquid
        type: str_4_nullable
        doc: 'mMTPublicationModeIlliquid. Nullable, No Value = 0'
      - id: mmt_publication_mode_size_specific
        type: str_4_nullable
        doc: 'mMTPublicationModeSizeSpecific. Nullable, No Value = 0'
      - id: venueof_publication
        type: str_4_nullable
        doc: 'venueofPublication. Nullable, No Value = 0'
      - id: post_trade_deferral_flags
        type: str_4_nullable
        doc: 'postTradeDeferralFlags. Nullable, No Value = 0'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
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
      - id: deferred_publication
        type: b1
        doc: 'DeferredPublication'
  not_used_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
  market_status_change_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: market_states_groups
        type: market_states_groups
        doc: 'MarketStates Block'
  market_states_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: market_states_group
        type: market_states_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'MarketStates'
  market_states_group:
    seq:
      - id: change_type
        type: u1
        enum: change_type
        doc: 'changeType'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: book_state
        type: u1_nullable
        doc: 'bookState. Nullable, No Value = 255'
      - id: status_reason
        type: u1_nullable
        doc: 'statusReason. Nullable, No Value = 255'
      - id: phase_qualifier
        type: phase_qualifier
        doc: 'PhaseQualifier_set bit set'
      - id: trading_period_optional
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
        type: nanosecond_timestamp_nullable
        doc: 'scheduledEventTime. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: instrument_state
        type: u1_nullable
        doc: 'instrumentState. Nullable, No Value = 255'
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
      - id: unused_phase_qualifierset_8
        type: b1
        doc: 'Unused PhaseQualifier_set 8'
      - id: quoting_period
        type: b1
        doc: 'QuotingPeriod'
      - id: execution_prevention_across_all_firms
        type: b1
        doc: 'ExecutionPreventionAcrossAllFirms'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  timetable_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: pattern_id
        type: u2_nullable
        doc: 'patternID. Nullable, No Value = 65535'
      - id: symbol_index_optional
        type: u4_nullable
        doc: 'symbolIndex. Nullable, No Value = 4294967295'
      - id: timetables_groups
        type: timetables_groups
        doc: 'Timetables Block'
  timetables_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: timetables_group
        type: timetables_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Timetables'
  timetables_group:
    seq:
      - id: phase_time
        type: nanosecond_timestamp
        doc: 'phaseTime. Nanoseconds since Unix epoch'
      - id: phase_id
        type: u1
        enum: phase_id
        doc: 'phaseId'
      - id: phase_qualifier
        type: phase_qualifier
        doc: 'PhaseQualifier_set bit set'
      - id: trading_period
        type: u1
        enum: trading_period
        doc: 'tradingPeriod'
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
  standing_data_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: optiq_segment
        type: u1
        enum: optiq_segment
        doc: 'optiqSegment'
      - id: partition_id
        type: u2
        doc: 'partitionID'
      - id: full_instrument_name
        type: str_102_nullable
        doc: 'fullInstrumentName. Nullable, No Value = 0'
      - id: instrument_name
        type: str
        size: 18
        encoding: ASCII
        doc: 'instrumentName'
      - id: instrument_trading_code
        type: str_15_nullable
        doc: 'instrumentTradingCode. Nullable, No Value = 0'
      - id: instrument_group_code
        type: str
        size: 2
        encoding: ASCII
        doc: 'instrumentGroupCode'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'iSINCode'
      - id: price_decimals
        type: u1
        doc: 'priceDecimals'
      - id: quantity_decimals
        type: u1_nullable
        doc: 'quantityDecimals. Nullable, No Value = 255'
      - id: amount_decimals
        type: u1_nullable
        doc: 'amountDecimals. Nullable, No Value = 255'
      - id: ratio_decimals
        type: u1
        doc: 'ratioDecimals'
      - id: cfi
        type: str
        size: 6
        encoding: ASCII
        doc: 'cFI'
      - id: instrument_event_date
        type: u2
        doc: 'instrumentEventDate'
      - id: strike_price
        type: s8_nullable
        doc: 'strikePrice. Nullable, No Value = -9223372036854775808'
      - id: dark_eligibility
        type: u1_nullable
        doc: 'darkEligibility. Nullable, No Value = 255'
      - id: dark_lis_threshold
        type: u8_nullable
        doc: 'darkLISThreshold. Nullable, No Value = 18446744073709551615'
      - id: dark_min_quantity
        type: u4_nullable
        doc: 'darkMinQuantity. Nullable, No Value = 4294967295'
      - id: date_of_last_trade
        type: u2_nullable
        doc: 'dateOfLastTrade. Nullable, No Value = 65535'
      - id: depositary_list
        type: str_20_nullable
        doc: 'depositaryList. Nullable, No Value = 0'
      - id: main_depositary
        type: str_5_nullable
        doc: 'mainDepositary. Nullable, No Value = 0'
      - id: first_settlement_date
        type: u2_nullable
        doc: 'firstSettlementDate. Nullable, No Value = 65535'
      - id: guarantee_indicator
        type: u1_nullable
        doc: 'guaranteeIndicator. Nullable, No Value = 255'
      - id: icb
        type: str_16_nullable
        doc: 'iCB. Nullable, No Value = 0'
      - id: issuing_country
        type: str_3_nullable
        doc: 'issuingCountry. Nullable, No Value = 0'
      - id: last_adjusted_closing_price
        type: s8_nullable
        doc: 'lastAdjustedClosingPrice. Nullable, No Value = -9223372036854775808'
      - id: lot_size_optional
        type: u8_nullable
        doc: 'lotSize. Nullable, No Value = 18446744073709551615'
      - id: maturity_date_optional
        type: str_8_nullable
        doc: 'maturityDate. Nullable, No Value = 0'
      - id: maximum_decimals_in_quantity
        type: u1_nullable
        doc: 'maximumDecimalsInQuantity. Nullable, No Value = 255'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'mIC'
      - id: mic_list
        type: str_20_nullable
        doc: 'mICList. Nullable, No Value = 0'
      - id: country_of_exchange_optional
        type: str_3_nullable
        doc: 'countryOfExchange. Nullable, No Value = 0'
      - id: mnemonic
        type: str_5_nullable
        doc: 'mnemonic. Nullable, No Value = 0'
      - id: underlying_mic
        type: str_4_nullable
        doc: 'underlyingMIC. Nullable, No Value = 0'
      - id: underlying_isin_code
        type: str_12_nullable
        doc: 'underlyingISINCode. Nullable, No Value = 0'
      - id: trading_currency_optional
        type: str_3_nullable
        doc: 'tradingCurrency. Nullable, No Value = 0'
      - id: currency_coefficient
        type: u4_nullable
        doc: 'currencyCoefficient. Nullable, No Value = 4294967295'
      - id: trading_currency_indicator
        type: u1_nullable
        doc: 'tradingCurrencyIndicator. Nullable, No Value = 255'
      - id: strike_currency_indicator
        type: u1_nullable
        doc: 'strikeCurrencyIndicator. Nullable, No Value = 255'
      - id: number_instrument_circulating
        type: u8_nullable
        doc: 'numberInstrumentCirculating. Nullable, No Value = 18446744073709551615'
      - id: par_value
        type: u8_nullable
        doc: 'parValue. Nullable, No Value = 18446744073709551615'
      - id: quantity_notation
        type: str_3_nullable
        doc: 'quantityNotation. Nullable, No Value = 0'
      - id: inst_unit_exp
        type: u1_nullable
        doc: 'instUnitExp. Nullable, No Value = 255'
      - id: settlement_delay
        type: str_2_nullable
        doc: 'settlementDelay. Nullable, No Value = 0'
      - id: strike_currency
        type: str_3_nullable
        doc: 'strikeCurrency. Nullable, No Value = 0'
      - id: tax_code
        type: u1_nullable
        doc: 'taxCode. Nullable, No Value = 255'
      - id: type_of_corporate_event
        type: str_2_nullable
        doc: 'typeOfCorporateEvent. Nullable, No Value = 0'
      - id: type_of_market_admission
        type: u1
        enum: type_of_market_admission
        doc: 'typeOfMarketAdmission. Nullable, No Value = 0'
      - id: repo_indicator
        type: u1_nullable
        doc: 'repoIndicator. Nullable, No Value = 255'
      - id: issue_price
        type: s8_nullable
        doc: 'issuePrice. Nullable, No Value = -9223372036854775808'
      - id: nominal_currency
        type: str_3_nullable
        doc: 'nominalCurrency. Nullable, No Value = 0'
      - id: issue_price_decimals
        type: u1_nullable
        doc: 'issuePriceDecimals. Nullable, No Value = 255'
      - id: strike_price_decimals
        type: u1_nullable
        doc: 'strikePriceDecimals. Nullable, No Value = 255'
      - id: liquid_instrument_indicator
        type: u1_nullable
        doc: 'liquidInstrumentIndicator. Nullable, No Value = 255'
      - id: market_of_reference_mic
        type: str_4_nullable
        doc: 'marketOfReferenceMIC. Nullable, No Value = 0'
      - id: icb_code
        type: str_8_nullable
        doc: 'iCBCode. Nullable, No Value = 0'
      - id: threshold_lis_post_trade_60mn
        type: u8_nullable
        doc: 'thresholdLISPostTrade60mn. Nullable, No Value = 18446744073709551615'
      - id: threshold_lis_post_trade_120mn
        type: u8_nullable
        doc: 'thresholdLISPostTrade120mn. Nullable, No Value = 18446744073709551615'
      - id: threshold_lis_post_trade_eod
        type: u8_nullable
        doc: 'thresholdLISPostTradeEOD. Nullable, No Value = 18446744073709551615'
      - id: long_mnemonic
        type: str_6_nullable
        doc: 'longMnemonic. Nullable, No Value = 0'
      - id: max_order_amount_call
        type: u8_nullable
        doc: 'maxOrderAmountCall. Nullable, No Value = 18446744073709551615'
      - id: max_order_amount_continuous
        type: u8_nullable
        doc: 'maxOrderAmountContinuous. Nullable, No Value = 18446744073709551615'
      - id: max_order_quantity_call
        type: u8_nullable
        doc: 'maxOrderQuantityCall. Nullable, No Value = 18446744073709551615'
      - id: max_order_quantity_continuous
        type: u8_nullable
        doc: 'maxOrderQuantityContinuous. Nullable, No Value = 18446744073709551615'
      - id: pool_factor
        type: u4_nullable
        doc: 'poolFactor. Nullable, No Value = 4294967295'
      - id: emm_pattern_rep_groups
        type: emm_pattern_rep_groups
        doc: 'EMMPatternRep Block'
  emm_pattern_rep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: emm_pattern_rep_group
        type: emm_pattern_rep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'EMMPatternRep'
  emm_pattern_rep_group:
    seq:
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: pattern_id
        type: u2_nullable
        doc: 'patternID. Nullable, No Value = 65535'
      - id: tick_size_index_id
        type: u2_nullable
        doc: 'tickSizeIndexID. Nullable, No Value = 65535'
      - id: market_model
        type: u1_nullable
        doc: 'marketModel. Nullable, No Value = 255'
      - id: lot_size_optional
        type: u8_nullable
        doc: 'lotSize. Nullable, No Value = 18446744073709551615'
      - id: inst_unit_exp
        type: u1_nullable
        doc: 'instUnitExp. Nullable, No Value = 255'
      - id: anonymous
        type: u1_nullable
        doc: 'anonymous. Nullable, No Value = 255'
  real_time_index_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: index_level
        type: s8
        doc: 'indexLevel'
      - id: pctg_of_capitalization
        type: u8_nullable
        doc: 'pctgOfCapitalization. Nullable, No Value = 18446744073709551615'
      - id: prct_varfrom_prev_close
        type: s8
        doc: 'prctVarfromPrevClose'
      - id: num_traded_instruments
        type: u2_nullable
        doc: 'numTradedInstruments. Nullable, No Value = 65535'
      - id: index_level_type
        type: u1
        enum: index_level_type
        doc: 'indexLevelType'
      - id: index_price_code
        type: u1
        enum: index_price_code
        doc: 'indexPriceCode'
  statistics_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: new_stats_groups
        type: new_stats_groups
        doc: 'NewStats Block'
  new_stats_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: new_stats_group
        type: new_stats_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'NewStats'
  new_stats_group:
    seq:
      - id: stats_update_type
        type: u1
        enum: stats_update_type
        doc: 'statsUpdateType'
      - id: stats_update_value
        type: s8_nullable
        doc: 'statsUpdateValue. Nullable, No Value = -9223372036854775808'
  index_summary_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: opening_level
        type: s8
        doc: 'openingLevel'
      - id: opening_time
        type: nanosecond_timestamp
        doc: 'openingTime. Nanoseconds since Unix epoch'
      - id: confirmed_reference_level
        type: s8_nullable
        doc: 'confirmedReferenceLevel. Nullable, No Value = -9223372036854775808'
      - id: confirmed_reference_time
        type: nanosecond_timestamp_nullable
        doc: 'confirmedReferenceTime. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: closing_reference_level
        type: s8
        doc: 'closingReferenceLevel'
      - id: closing_reference_time
        type: u8
        doc: 'closingReferenceTime'
      - id: prct_varfrom_prev_close
        type: s8
        doc: 'prctVarfromPrevClose'
      - id: high_level
        type: s8
        doc: 'highLevel'
      - id: high_time
        type: nanosecond_timestamp
        doc: 'highTime. Nanoseconds since Unix epoch'
      - id: low_level
        type: s8
        doc: 'lowLevel'
      - id: low_time
        type: nanosecond_timestamp
        doc: 'lowTime. Nanoseconds since Unix epoch'
      - id: liquidation_level
        type: s8_nullable
        doc: 'liquidationLevel. Nullable, No Value = -9223372036854775808'
      - id: liquidation_time
        type: u8_nullable
        doc: 'liquidationTime. Nullable, No Value = 18446744073709551615'
  strategy_standing_data_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: derivatives_instrument_trading_code
        type: str
        size: 18
        encoding: ASCII
        doc: 'derivativesInstrumentTradingCode'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'exchangeCode'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'maturityDate'
      - id: strategy_code
        type: u1
        enum: strategy_code
        doc: 'strategyCode'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: cfi_optional
        type: str_6_nullable
        doc: 'cFI. Nullable, No Value = 0'
      - id: strategy_standing_data_groups
        type: strategy_standing_data_groups
        doc: 'StrategyStandingDatarep1 Block'
  strategy_standing_data_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: strategy_standing_data_group
        type: strategy_standing_data_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'StrategyStandingDatarep1'
  strategy_standing_data_group:
    seq:
      - id: leg_symbol_index
        type: u4
        doc: 'legSymbolIndex'
      - id: leg_price
        type: s8_nullable
        doc: 'legPrice. Nullable, No Value = -9223372036854775808'
      - id: leg_ratio
        type: u4
        doc: 'legRatio'
      - id: leg_buy_sell
        type: u1
        enum: leg_buy_sell
        doc: 'legBuySell'
  contract_standing_data_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: optiq_segment
        type: u1
        enum: optiq_segment
        doc: 'optiqSegment'
      - id: partition_id
        type: u2
        doc: 'partitionID'
      - id: contract_event_date
        type: u2_nullable
        doc: 'contractEventDate. Nullable, No Value = 65535'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'exchangeCode'
      - id: exer_style
        type: u1_nullable
        doc: 'exerStyle. Nullable, No Value = 255'
      - id: contract_name
        type: str
        size: 60
        encoding: ASCII
        doc: 'contractName'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'contractType. Nullable, No Value = 0'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'underlyingType'
      - id: price_decimals_optional
        type: u1_nullable
        doc: 'priceDecimals. Nullable, No Value = 255'
      - id: quantity_decimals
        type: u1_nullable
        doc: 'quantityDecimals. Nullable, No Value = 255'
      - id: amount_decimals
        type: u1_nullable
        doc: 'amountDecimals. Nullable, No Value = 255'
      - id: ratio_decimals_optional
        type: u1_nullable
        doc: 'ratioDecimals. Nullable, No Value = 255'
      - id: main_depositary
        type: str_5_nullable
        doc: 'mainDepositary. Nullable, No Value = 0'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'mIC'
      - id: country_of_exchange
        type: str
        size: 3
        encoding: ASCII
        doc: 'countryOfExchange'
      - id: product_code
        type: str
        size: 4
        encoding: ASCII
        doc: 'productCode'
      - id: underlying_mic
        type: str_4_nullable
        doc: 'underlyingMIC. Nullable, No Value = 0'
      - id: underlying_isin_code
        type: str_12_nullable
        doc: 'underlyingISINCode. Nullable, No Value = 0'
      - id: underlying_expiry
        type: u4_nullable
        doc: 'underlyingExpiry. Nullable, No Value = 4294967295'
      - id: order_type_rules
        type: order_type_rules
        doc: 'OrderTypeRules_set bit set'
      - id: settlement_method
        type: str_1_nullable
        doc: 'settlementMethod. Nullable, No Value = 0'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'tradingCurrency'
      - id: strike_price_decimals_ratio
        type: u1_nullable
        doc: 'strikePriceDecimalsRatio. Nullable, No Value = 255'
      - id: mm_protections
        type: mm_protections
        doc: 'MMProtections_set bit set'
      - id: contract_trading_type
        type: u1
        enum: contract_trading_type
        doc: 'contractTradingType'
      - id: inst_unit_exp
        type: u1_nullable
        doc: 'instUnitExp. Nullable, No Value = 255'
      - id: underlying_subtype
        type: u1_nullable
        doc: 'underlyingSubtype. Nullable, No Value = 255'
      - id: mother_stock_isin
        type: str_12_nullable
        doc: 'motherStockISIN. Nullable, No Value = 0'
      - id: settlement_tick_size
        type: u8_nullable
        doc: 'settlementTickSize. Nullable, No Value = 18446744073709551615'
      - id: edsp_tick_size
        type: u8_nullable
        doc: 'eDSPTickSize. Nullable, No Value = 18446744073709551615'
      - id: underlying_symbol_index
        type: u4_nullable
        doc: 'underlyingSymbolIndex. Nullable, No Value = 4294967295'
      - id: trading_policy
        type: u1_nullable
        doc: 'tradingPolicy. Nullable, No Value = 255'
      - id: reference_spread_table_id
        type: u2_nullable
        doc: 'referenceSpreadTableID. Nullable, No Value = 65535'
      - id: derivatives_market_model
        type: u1_nullable
        doc: 'derivativesMarketModel. Nullable, No Value = 255'
      - id: trading_unit
        type: u8_nullable
        doc: 'tradingUnit. Nullable, No Value = 18446744073709551615'
      - id: reference_price_origin_in_opening_call
        type: u1_nullable
        doc: 'referencePriceOriginInOpeningCall. Nullable, No Value = 255'
      - id: reference_price_origin_in_continuous
        type: u1_nullable
        doc: 'referencePriceOriginInContinuous. Nullable, No Value = 255'
      - id: reference_price_origin_in_trading_interruption
        type: u1_nullable
        doc: 'referencePriceOriginInTradingInterruption. Nullable, No Value = 255'
      - id: collar_expansion_factor
        type: u1_nullable
        doc: 'collarExpansionFactor. Nullable, No Value = 255'
      - id: mifidii_liquid_flag
        type: u1
        doc: 'mIFIDIILiquidFlag'
      - id: pricing_algorithm
        type: u1
        enum: pricing_algorithm
        doc: 'pricingAlgorithm'
      - id: lot_multiplier
        type: u8_nullable
        doc: 'lotMultiplier. Nullable, No Value = 18446744073709551615'
      - id: contract_emm_properties_groups
        type: contract_emm_properties_groups
        doc: 'ContractEMMProperties Block'
  order_type_rules:
    seq:
      - id: market
        type: b1
        doc: 'Market'
      - id: limit
        type: b1
        doc: 'Limit'
      - id: stop_stop_loss
        type: b1
        doc: 'StopStopLoss'
      - id: stop_limit
        type: b1
        doc: 'StopLimit'
      - id: market_on_open_moo
        type: b1
        doc: 'MarketOnOpenMOO'
      - id: trade_at_settlement
        type: b1
        doc: 'TradeAtSettlement'
      - id: reserved_10
        type: b10
        doc: '10 reserved bits'
  mm_protections:
    seq:
      - id: delta
        type: b1
        doc: 'Delta'
      - id: volume
        type: b1
        doc: 'Volume'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
  contract_emm_properties_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: contract_emm_properties_group
        type: contract_emm_properties_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'ContractEMMProperties'
  contract_emm_properties_group:
    seq:
      - id: emm_optional
        type: u1_nullable
        doc: 'eMM. Nullable, No Value = 255'
      - id: tick_size_index_id
        type: u2_nullable
        doc: 'tickSizeIndexID. Nullable, No Value = 65535'
      - id: pattern_id
        type: u2_nullable
        doc: 'patternID. Nullable, No Value = 65535'
      - id: lot_size_optional
        type: u8_nullable
        doc: 'lotSize. Nullable, No Value = 18446744073709551615'
      - id: strategy_authorized
        type: strategy_authorized
        doc: 'StrategyAuthorized_set bit set. Nullable, No Value = 18446744073709551615'
      - id: dynamic_collar_logic
        type: u1_nullable
        doc: 'dynamicCollarLogic. Nullable, No Value = 255'
      - id: collar_max_unhalt_nb
        type: u1_nullable
        doc: 'collarMaxUnhaltNb. Nullable, No Value = 255'
      - id: collar_unhalt_delay
        type: u4_nullable
        doc: 'collarUnhaltDelay. Nullable, No Value = 4294967295'
  strategy_authorized:
    seq:
      - id: jelly_roll
        type: b1
        doc: 'JellyRoll'
      - id: butterfly
        type: b1
        doc: 'Butterfly'
      - id: call_or_put_cabinet
        type: b1
        doc: 'CallOrPutCabinet'
      - id: spread
        type: b1
        doc: 'Spread'
      - id: calendar_spread
        type: b1
        doc: 'CalendarSpread'
      - id: diagonal_calendar_spread
        type: b1
        doc: 'DiagonalCalendarSpread'
      - id: guts
        type: b1
        doc: 'Guts'
      - id: two_by_one_ratio_spread
        type: b1
        doc: 'TwoByOneRatioSpread'
      - id: iron_butterfly
        type: b1
        doc: 'IronButterfly'
      - id: combo
        type: b1
        doc: 'Combo'
      - id: strangle
        type: b1
        doc: 'Strangle'
      - id: ladder
        type: b1
        doc: 'Ladder'
      - id: strip
        type: b1
        doc: 'Strip'
      - id: straddle_calendar_spread
        type: b1
        doc: 'StraddleCalendarSpread'
      - id: pack
        type: b1
        doc: 'Pack'
      - id: diagonal_straddle_calendar_spread
        type: b1
        doc: 'DiagonalStraddleCalendarSpread'
      - id: simple_inter_commodity_spread
        type: b1
        doc: 'SimpleInterCommoditySpread'
      - id: conversion_reversal
        type: b1
        doc: 'ConversionReversal'
      - id: straddle
        type: b1
        doc: 'Straddle'
      - id: volatility_trade
        type: b1
        doc: 'VolatilityTrade'
      - id: condor
        type: b1
        doc: 'Condor'
      - id: box_field
        type: b1
        doc: 'Box'
      - id: bundle
        type: b1
        doc: 'Bundle'
      - id: reduced_tick_spread
        type: b1
        doc: 'ReducedTickSpread'
      - id: ladder_versus_underlying
        type: b1
        doc: 'LadderVersusUnderlying'
      - id: butterfly_versus_underlying
        type: b1
        doc: 'ButterflyVersusUnderlying'
      - id: call_spread_versus_put_versus_underlying
        type: b1
        doc: 'CallSpreadVersusPutVersusUnderlying'
      - id: call_or_put_spread_versus_underlying
        type: b1
        doc: 'CallOrPutSpreadVersusUnderlying'
      - id: call_or_put_calendar_spread_versus_underlying
        type: b1
        doc: 'CallOrPutCalendarSpreadVersusUnderlying'
      - id: call_put_diagonal_calendar_spread_versus_underlying
        type: b1
        doc: 'CallPutDiagonalCalendarSpreadVersusUnderlying'
      - id: guts_versus_underlying
        type: b1
        doc: 'GutsVersusUnderlying'
      - id: two_by_one_call_or_put_ratio_spread_versus_underlying
        type: b1
        doc: 'TwoByOneCallOrPutRatioSpreadVersusUnderlying'
      - id: iron_butterfly_versus_underlying
        type: b1
        doc: 'IronButterflyVersusUnderlying'
      - id: combo_versus_underlying
        type: b1
        doc: 'ComboVersusUnderlying'
      - id: strangle_versus_underlying
        type: b1
        doc: 'StrangleVersusUnderlying'
      - id: exchange_for_physical
        type: b1
        doc: 'ExchangeForPhysical'
      - id: straddle_calendar_spread_versus_underlying
        type: b1
        doc: 'StraddleCalendarSpreadVersusUnderlying'
      - id: put_spread_versus_call_versus_underlying
        type: b1
        doc: 'PutSpreadVersusCallVersusUnderlying'
      - id: diagonal_straddle_calendar_spread_versus_underlying
        type: b1
        doc: 'DiagonalStraddleCalendarSpreadVersusUnderlying'
      - id: synthetic
        type: b1
        doc: 'Synthetic'
      - id: straddle_versus_underlying
        type: b1
        doc: 'StraddleVersusUnderlying'
      - id: condor_versus_underlying
        type: b1
        doc: 'CondorVersusUnderlying'
      - id: buy_write
        type: b1
        doc: 'BuyWrite'
      - id: iron_condor_versus_underlying
        type: b1
        doc: 'IronCondorVersusUnderlying'
      - id: iron_condor
        type: b1
        doc: 'IronCondor'
      - id: call_spread_versus_sell_a_put
        type: b1
        doc: 'CallSpreadVersusSellAPut'
      - id: put_spread_versus_sell_a_call
        type: b1
        doc: 'PutSpreadVersusSellACall'
      - id: put_straddle_versus_sell_a_call_or_a_put
        type: b1
        doc: 'PutStraddleVersusSellACallOrAPut'
      - id: ics_one_sided_combination_same_expiry
        type: b1
        doc: 'ICSOneSidedCombinationSameExpiry'
      - id: ics_two_sided_combination_same_expiry
        type: b1
        doc: 'ICSTwoSidedCombinationSameExpiry'
      - id: ratio_inter_contract_spread
        type: b1
        doc: 'RatioInterContractSpread'
      - id: call_spread_versus_put_or_put_spread_versus_call
        type: b1
        doc: 'CallSpreadVersusPutOrPutSpreadVersusCall'
      - id: ratio_spread_option
        type: b1
        doc: 'RatioSpreadOption'
      - id: reserved_11
        type: b11
        doc: '11 reserved bits'
  outright_standing_data_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: instrument_event_date
        type: u2
        doc: 'instrumentEventDate'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'iSINCode'
      - id: cfi_optional
        type: str_6_nullable
        doc: 'cFI. Nullable, No Value = 0'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        doc: 'maturityDate'
      - id: lot_size
        type: u8
        doc: 'lotSize'
      - id: strike_price
        type: s8_nullable
        doc: 'strikePrice. Nullable, No Value = -9223372036854775808'
      - id: last_trading_date
        type: u2_nullable
        doc: 'lastTradingDate. Nullable, No Value = 65535'
      - id: days_to_expiry
        type: u2_nullable
        doc: 'daysToExpiry. Nullable, No Value = 65535'
      - id: derivatives_instrument_trading_code_optional
        type: str_18_nullable
        doc: 'derivativesInstrumentTradingCode. Nullable, No Value = 0'
      - id: derivatives_instrument_type
        type: u1_nullable
        doc: 'derivativesInstrumentType. Nullable, No Value = 255'
      - id: expiry_cycle_type
        type: u1_nullable
        doc: 'expiryCycleType. Nullable, No Value = 255'
      - id: underlying_derivatives_instrument_trading_code
        type: str_18_nullable
        doc: 'underlyingDerivativesInstrumentTradingCode. Nullable, No Value = 0'
      - id: underlying_symbol_index
        type: u4_nullable
        doc: 'underlyingSymbolIndex. Nullable, No Value = 4294967295'
      - id: trading_unit
        type: u8_nullable
        doc: 'tradingUnit. Nullable, No Value = 18446744073709551615'
      - id: lot_multiplier
        type: u8_nullable
        doc: 'lotMultiplier. Nullable, No Value = 18446744073709551615'
      - id: expiration_date
        type: u2_nullable
        doc: 'expirationDate. Nullable, No Value = 65535'
      - id: outright_rep_groups
        type: outright_rep_groups
        doc: 'OutrightRep Block'
  outright_rep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: outright_rep_group
        type: outright_rep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'OutrightRep'
  outright_rep_group:
    seq:
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
  long_order_update_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: long_order_updates_groups
        type: long_order_updates_groups
        doc: 'Orders Block'
  long_order_updates_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: long_order_updates_group
        type: long_order_updates_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Orders'
  long_order_updates_group:
    seq:
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: action_type
        type: u1
        enum: action_type
        doc: 'actionType'
      - id: order_priority
        type: u8_nullable
        doc: 'orderPriority. Nullable, No Value = 18446744073709551615'
      - id: previous_priority
        type: u8_nullable
        doc: 'previousPriority. Nullable, No Value = 18446744073709551615'
      - id: order_type
        type: u1_nullable
        doc: 'orderType. Nullable, No Value = 255'
      - id: order_px
        type: s8_nullable
        doc: 'orderPx. Nullable, No Value = -9223372036854775808'
      - id: order_side
        type: u1_nullable
        doc: 'orderSide. Nullable, No Value = 255'
      - id: order_quantity
        type: u8_nullable
        doc: 'orderQuantity. Nullable, No Value = 18446744073709551615'
      - id: peg_offset
        type: s1_nullable
        doc: 'pegOffset. Nullable, No Value = -128'
      - id: firm_id
        type: str
        size: 8
        encoding: ASCII
        doc: 'firmID'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'accountType'
  lis_package_structure_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: contract_symbol_index
        type: u4
        doc: 'contractSymbolIndex'
      - id: mifid_execution_id
        type: str
        size: 52
        encoding: ASCII
        doc: 'mifidExecutionID'
      - id: strategy_code
        type: u1
        enum: strategy_code
        doc: 'strategyCode'
      - id: package_components_groups
        type: package_components_groups
        doc: 'PackageComponents Block'
  package_components_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: package_components_group
        type: package_components_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'PackageComponents'
  package_components_group:
    seq:
      - id: leg_symbol_index
        type: u4
        doc: 'legSymbolIndex'
      - id: leg_ratio
        type: u4
        doc: 'legRatio'
      - id: leg_last_px
        type: s8_nullable
        doc: 'legLastPx. Nullable, No Value = -9223372036854775808'
      - id: leg_last_qty
        type: u8_nullable
        doc: 'legLastQty. Nullable, No Value = 18446744073709551615'
  apa_quotes_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: mifid_instrument_id_type
        type: str
        size: 4
        encoding: ASCII
        doc: 'mifidInstrumentIdType'
      - id: mifid_instrument_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'mifidInstrumentID'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        doc: 'mIC'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'currency'
      - id: lei_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'lEICode'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: quote_update_type
        type: u1
        enum: quote_update_type
        doc: 'quoteUpdateType'
      - id: mifid_price
        type: str
        size: 20
        encoding: ASCII
        doc: 'mifidPrice'
      - id: mifid_quantity
        type: str
        size: 20
        encoding: ASCII
        doc: 'mifidQuantity'
      - id: apa_origin
        type: str_4_nullable
        doc: 'aPAOrigin. Nullable, No Value = 0'
  apa_standing_data_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: mifid_instrument_id_type
        type: str
        size: 4
        encoding: ASCII
        doc: 'mifidInstrumentIdType'
      - id: mifid_instrument_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'mifidInstrumentID'
      - id: full_instrument_name
        type: str_102_nullable
        doc: 'fullInstrumentName. Nullable, No Value = 0'
      - id: cfi_optional
        type: str_6_nullable
        doc: 'cFI. Nullable, No Value = 0'
      - id: notional_currency
        type: str_3_nullable
        doc: 'notionalCurrency. Nullable, No Value = 0'
      - id: second_notional_currency
        type: str_3_nullable
        doc: 'secondNotionalCurrency. Nullable, No Value = 0'
      - id: price_multiplier
        type: u4_nullable
        doc: 'priceMultiplier. Nullable, No Value = 4294967295'
      - id: price_multiplier_decimals
        type: u1_nullable
        doc: 'priceMultiplierDecimals. Nullable, No Value = 255'
      - id: underlying_isin_code
        type: str_12_nullable
        doc: 'underlyingISINCode. Nullable, No Value = 0'
      - id: underlying_index_name
        type: str_25_nullable
        doc: 'underlyingIndexName. Nullable, No Value = 0'
      - id: underlying_index_term
        type: str_8_nullable
        doc: 'underlyingIndexTerm. Nullable, No Value = 0'
      - id: option_type
        type: u1_nullable
        doc: 'optionType. Nullable, No Value = 255'
      - id: strike_price
        type: s8_nullable
        doc: 'strikePrice. Nullable, No Value = -9223372036854775808'
      - id: strike_price_decimals
        type: u1_nullable
        doc: 'strikePriceDecimals. Nullable, No Value = 255'
      - id: exer_style
        type: u1_nullable
        doc: 'exerStyle. Nullable, No Value = 255'
      - id: maturity_date_optional
        type: str_8_nullable
        doc: 'maturityDate. Nullable, No Value = 0'
      - id: expiry_date
        type: str_8_nullable
        doc: 'expiryDate. Nullable, No Value = 0'
      - id: settlement_method
        type: str_1_nullable
        doc: 'settlementMethod. Nullable, No Value = 0'
  apa_full_trade_information_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: emm
        type: u1
        enum: emm
        doc: 'eMM'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: trading_date_time
        type: str
        size: 27
        encoding: ASCII
        doc: 'tradingDateTime'
      - id: publication_date_time
        type: str_27_nullable
        doc: 'publicationDateTime. Nullable, No Value = 0'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'tradeType'
      - id: mifid_instrument_id_type_optional
        type: str_4_nullable
        doc: 'mifidInstrumentIdType. Nullable, No Value = 0'
      - id: mifid_instrument_id_optional
        type: str_12_nullable
        doc: 'mifidInstrumentID. Nullable, No Value = 0'
      - id: mifid_transaction_id
        type: str
        size: 52
        encoding: ASCII
        doc: 'miFIDTransactionID'
      - id: mifid_price_optional
        type: str_20_nullable
        doc: 'mifidPrice. Nullable, No Value = 0'
      - id: mifid_quantity
        type: str
        size: 20
        encoding: ASCII
        doc: 'mifidQuantity'
      - id: mifid_price_notation
        type: str_4_nullable
        doc: 'mifidPriceNotation. Nullable, No Value = 0'
      - id: mifid_currency
        type: str_3_nullable
        doc: 'mifidCurrency. Nullable, No Value = 0'
      - id: mifid_qty_in_msrmt_unit_notation
        type: str_25_nullable
        doc: 'miFIDQtyinMsrmtUnitNotation. Nullable, No Value = 0'
      - id: mifid_quantity_measurement_unit
        type: str_20_nullable
        doc: 'mifidQuantityMeasurementUnit. Nullable, No Value = 0'
      - id: mifid_notional_amount
        type: str_20_nullable
        doc: 'miFIDNotionalAmount. Nullable, No Value = 0'
      - id: notional_currency
        type: str_3_nullable
        doc: 'notionalCurrency. Nullable, No Value = 0'
      - id: mifid_clearing_flag
        type: str_5_nullable
        doc: 'miFIDClearingFlag. Nullable, No Value = 0'
      - id: efficient_mmt_market_mechanism
        type: u1_nullable
        doc: 'efficientMMTMarketMechanism. Nullable, No Value = 255'
      - id: efficient_mmt_trading_mode
        type: u1
        enum: efficient_mmt_trading_mode
        doc: 'efficientMMTTradingMode. Nullable, No Value = 0'
      - id: efficient_mmt_transaction_category
        type: u1
        enum: efficient_mmt_transaction_category
        doc: 'efficientMMTTransactionCategory. Nullable, No Value = 0'
      - id: efficient_mmt_negotiation_indicator
        type: u1
        enum: efficient_mmt_negotiation_indicator
        doc: 'efficientMMTNegotiationIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_agency_cross_trade_indicator
        type: u1
        enum: efficient_mmt_agency_cross_trade_indicator
        doc: 'efficientMMTAgencyCrossTradeIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_modification_indicator
        type: u1
        enum: efficient_mmt_modification_indicator
        doc: 'efficientMMTModificationIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_benchmark_indicator
        type: u1
        enum: efficient_mmt_benchmark_indicator
        doc: 'efficientMMTBenchmarkIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_special_dividend_indicator
        type: u1
        enum: efficient_mmt_special_dividend_indicator
        doc: 'efficientMMTSpecialDividendIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_off_book_automated_indicator
        type: u1
        enum: efficient_mmt_off_book_automated_indicator
        doc: 'efficientMMTOffBookAutomatedIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_contributionto_price
        type: u1
        enum: efficient_mmt_contributionto_price
        doc: 'efficientMMTContributiontoPrice. Nullable, No Value = 0'
      - id: efficient_mmt_algorithmic_indicator
        type: u1
        enum: efficient_mmt_algorithmic_indicator
        doc: 'efficientMMTAlgorithmicIndicator. Nullable, No Value = 0'
      - id: efficient_mmt_publication_mode
        type: u1
        enum: efficient_mmt_publication_mode
        doc: 'efficientMMTPublicationMode. Nullable, No Value = 0'
      - id: efficient_mmt_post_trade_deferral
        type: u1
        enum: efficient_mmt_post_trade_deferral
        doc: 'efficientMMTPostTradeDeferral. Nullable, No Value = 0'
      - id: efficient_mmt_duplicative_indicator
        type: u1
        enum: efficient_mmt_duplicative_indicator
        doc: 'efficientMMTDuplicativeIndicator. Nullable, No Value = 0'
      - id: trade_reference
        type: str_30_nullable
        doc: 'tradeReference. Nullable, No Value = 0'
      - id: original_report_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'originalReportTimestamp. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: price_multiplier
        type: u4_nullable
        doc: 'priceMultiplier. Nullable, No Value = 4294967295'
      - id: price_multiplier_decimals
        type: u1_nullable
        doc: 'priceMultiplierDecimals. Nullable, No Value = 255'
      - id: venue
        type: str
        size: 11
        encoding: ASCII
        doc: 'venue'
      - id: mifid_emission_allowance_type
        type: str_4_nullable
        doc: 'miFIDEmissionAllowanceType. Nullable, No Value = 0'
      - id: long_trade_reference
        type: str_52_nullable
        doc: 'longTradeReference. Nullable, No Value = 0'
      - id: apa_origin
        type: str_4_nullable
        doc: 'aPAOrigin. Nullable, No Value = 0'
      - id: trade_unique_identifier
        type: str_16_nullable
        doc: 'tradeUniqueIdentifier. Nullable, No Value = 0'
  bf_instrument_reference_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: optiq_segment
        type: u1
        enum: optiq_segment
        doc: 'optiqSegment'
      - id: isin_code_optional
        type: str_12_nullable
        doc: 'iSINCode. Nullable, No Value = 0'
      - id: sedol_code
        type: str_7_nullable
        doc: 'sEDOLCode. Nullable, No Value = 0'
      - id: long_issuer_name
        type: str_250_nullable
        doc: 'longIssuerName. Nullable, No Value = 0'
      - id: long_instrument_name
        type: str_250_nullable
        doc: 'longInstrumentName. Nullable, No Value = 0'
      - id: currency_optional
        type: str_3_nullable
        doc: 'currency. Nullable, No Value = 0'
      - id: date_of_initial_listing
        type: u2_nullable
        doc: 'dateOfInitialListing. Nullable, No Value = 65535'
      - id: share_amount_in_issue
        type: s8_nullable
        doc: 'shareAmountInIssue. Nullable, No Value = -9223372036854775808'
      - id: opened_closed_fund
        type: u1
        enum: opened_closed_fund
        doc: 'openedClosedFund. Nullable, No Value = 0'
      - id: last_nav_price
        type: s8_nullable
        doc: 'lastNAVPrice. Nullable, No Value = -9223372036854775808'
      - id: gross_of_cdsc_indicator
        type: u1
        enum: gross_of_cdsc_indicator
        doc: 'grossOfCDSCIndicator. Nullable, No Value = 0'
      - id: coupon
        type: s8_nullable
        doc: 'coupon. Nullable, No Value = -9223372036854775808'
      - id: maturity_date_optional
        type: str_8_nullable
        doc: 'maturityDate. Nullable, No Value = 0'
      - id: closing_price
        type: s8_nullable
        doc: 'closingPrice. Nullable, No Value = -9223372036854775808'
      - id: mic_optional
        type: str_4_nullable
        doc: 'mIC. Nullable, No Value = 0'
      - id: gross_dividend_payable_per_unit
        type: s8_nullable
        doc: 'grossDividendPayablePerUnit. Nullable, No Value = -9223372036854775808'
      - id: dividend_currency
        type: str_3_nullable
        doc: 'dividendCurrency. Nullable, No Value = 0'
      - id: dividend_record_date
        type: u2_nullable
        doc: 'dividendRecordDate. Nullable, No Value = 65535'
      - id: dividend_rate
        type: u8_nullable
        doc: 'dividendRate. Nullable, No Value = 18446744073709551615'
      - id: ex_dividend_date
        type: u2_nullable
        doc: 'exDividendDate. Nullable, No Value = 65535'
      - id: dividend_payment_date
        type: u2_nullable
        doc: 'dividendPaymentDate. Nullable, No Value = 65535'
      - id: tax_description_attaching_to_a_dividend
        type: u1
        enum: tax_description_attaching_to_a_dividend
        doc: 'taxDescriptionAttachingToADividend. Nullable, No Value = 0'
      - id: next_meeting
        type: str_8_nullable
        doc: 'nextMeeting. Nullable, No Value = 0'
      - id: gross_dividend_in_euros
        type: s8_nullable
        doc: 'grossDividendInEuros. Nullable, No Value = -9223372036854775808'
      - id: issue_date
        type: u2_nullable
        doc: 'issueDate. Nullable, No Value = 65535'
      - id: issuing_country
        type: str_3_nullable
        doc: 'issuingCountry. Nullable, No Value = 0'
      - id: cfi_optional
        type: str_6_nullable
        doc: 'cFI. Nullable, No Value = 0'
      - id: payment_frequency
        type: u1_nullable
        doc: 'paymentFrequency. Nullable, No Value = 255'
      - id: minimum_amount
        type: s8_nullable
        doc: 'minimumAmount. Nullable, No Value = -9223372036854775808'
      - id: instrument_category
        type: u1
        enum: instrument_category
        doc: 'instrumentCategory'
      - id: security_condition
        type: u1
        enum: security_condition
        doc: 'securityCondition. Nullable, No Value = 0'
      - id: mifid_price_notation
        type: str_4_nullable
        doc: 'mifidPriceNotation. Nullable, No Value = 0'
      - id: price_index_level_decimals
        type: u1_nullable
        doc: 'priceIndexLevelDecimals. Nullable, No Value = 255'
      - id: quantity_decimals
        type: u1_nullable
        doc: 'quantityDecimals. Nullable, No Value = 255'
      - id: amount_decimals
        type: u1_nullable
        doc: 'amountDecimals. Nullable, No Value = 255'
      - id: ratio_multiplier_decimals
        type: u1_nullable
        doc: 'ratioMultiplierDecimals. Nullable, No Value = 255'
      - id: interest_payment_date_rep_groups
        type: interest_payment_date_rep_groups
        doc: 'InterestPaymentDateRep Block'
  interest_payment_date_rep_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: interest_payment_date_rep_group
        type: interest_payment_date_rep_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'InterestPaymentDateRep'
  interest_payment_date_rep_group:
    seq:
      - id: interest_payment_date
        type: u2_nullable
        doc: 'interestPaymentDate. Nullable, No Value = 65535'
  bf_trade_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: mifid_transaction_id
        type: str
        size: 52
        encoding: ASCII
        doc: 'miFIDTransactionID'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: bid_offer_date_time
        type: u8_nullable
        doc: 'bidOfferDateTime. Nullable, No Value = 18446744073709551615'
      - id: mmt_modification_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'mMTModificationIndicator'
      - id: price
        type: s8_nullable
        doc: 'price. Nullable, No Value = -9223372036854775808'
      - id: bid_price
        type: s8_nullable
        doc: 'bidPrice. Nullable, No Value = -9223372036854775808'
      - id: offer_price
        type: s8_nullable
        doc: 'offerPrice. Nullable, No Value = -9223372036854775808'
      - id: quantity
        type: u8
        doc: 'quantity'
      - id: mmt_agency_cross_trade_indicator
        type: str_4_nullable
        doc: 'mMTAgencyCrossTradeIndicator. Nullable, No Value = 0'
      - id: mmt_benchmark_indicator
        type: str_4_nullable
        doc: 'mMTBenchmarkIndicator. Nullable, No Value = 0'
      - id: mmt_special_dividend_indicator
        type: str_4_nullable
        doc: 'mMTSpecialDividendIndicator. Nullable, No Value = 0'
      - id: mmt_trading_mode
        type: u1
        enum: mmt_trading_mode
        doc: 'mMTTradingMode. Nullable, No Value = 0'
      - id: mifid_price_notation
        type: str_4_nullable
        doc: 'mifidPriceNotation. Nullable, No Value = 0'
      - id: quantity_notation
        type: str_3_nullable
        doc: 'quantityNotation. Nullable, No Value = 0'
      - id: notional_amount_traded
        type: s8_nullable
        doc: 'notionalAmountTraded. Nullable, No Value = -9223372036854775808'
      - id: trading_currency_optional
        type: str_3_nullable
        doc: 'tradingCurrency. Nullable, No Value = 0'
  bfnav_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: bid_offer_date_time
        type: u8_nullable
        doc: 'bidOfferDateTime. Nullable, No Value = 18446744073709551615'
      - id: mifid_transaction_id
        type: str
        size: 52
        encoding: ASCII
        doc: 'miFIDTransactionID'
      - id: mmt_modification_indicator
        type: str
        size: 4
        encoding: ASCII
        doc: 'mMTModificationIndicator'
      - id: nav_price
        type: s8_nullable
        doc: 'nAVPrice. Nullable, No Value = -9223372036854775808'
      - id: event_time_optional
        type: u8_nullable
        doc: 'eventTime. Nullable, No Value = 18446744073709551615'
      - id: nav_bid_price
        type: s8_nullable
        doc: 'nAVBidPrice. Nullable, No Value = -9223372036854775808'
      - id: nav_offer_price
        type: s8_nullable
        doc: 'nAVOfferPrice. Nullable, No Value = -9223372036854775808'
  bf_instrument_suspension_message:
    seq:
      - id: md_seq_num_optional
        type: u8_nullable
        doc: 'mDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: rebroadcast_indicator
        type: u1
        doc: 'rebroadcastIndicator'
      - id: symbol_index
        type: u4
        doc: 'symbolIndex'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: security_condition
        type: u1
        enum: security_condition
        doc: 'securityCondition. Nullable, No Value = 0'
  start_of_snapshot_message:
    seq:
      - id: last_md_seq_num
        type: u8_nullable
        doc: 'lastMDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: snapshot_time
        type: u8
        doc: 'snapshotTime'
  end_of_snapshot_message:
    seq:
      - id: last_md_seq_num
        type: u8_nullable
        doc: 'lastMDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: snapshot_time
        type: u8
        doc: 'snapshotTime'
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
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 18446744073709551615
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
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
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
  str_27_nullable:
    seq:
      - id: value
        size: 27
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
  str_12_nullable:
    seq:
      - id: value
        size: 12
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_20_nullable:
    seq:
      - id: value
        size: 20
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_3_nullable:
    seq:
      - id: value
        size: 3
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_25_nullable:
    seq:
      - id: value
        size: 25
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_5_nullable:
    seq:
      - id: value
        size: 5
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_30_nullable:
    seq:
      - id: value
        size: 30
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
  str_102_nullable:
    seq:
      - id: value
        size: 102
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_15_nullable:
    seq:
      - id: value
        size: 15
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_8_nullable:
    seq:
      - id: value
        size: 8
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
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  str_18_nullable:
    seq:
      - id: value
        size: 18
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_52_nullable:
    seq:
      - id: value
        size: 52
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_7_nullable:
    seq:
      - id: value
        size: 7
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_250_nullable:
    seq:
      - id: value
        size: 250
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0

enums:
  template_id:
    1103:
      id: 'health_status_message'
      doc: 'HealthStatusMessage'
    1101:
      id: 'start_of_day_message'
      doc: 'StartOfDayMessage'
    1102:
      id: 'end_of_day_message'
      doc: 'EndOfDayMessage'
    1106:
      id: 'technical_notification_message'
      doc: 'TechnicalNotificationMessage'
    1001:
      id: 'market_update_message'
      doc: 'MarketUpdateMessage'
    1002:
      id: 'order_update_message'
      doc: 'OrderUpdateMessage'
    1003:
      id: 'price_update_message'
      doc: 'PriceUpdateMessage'
    1004:
      id: 'full_trade_information_message'
      doc: 'FullTradeInformationMessage'
    1005:
      id: 'market_status_change_message'
      doc: 'MarketStatusChangeMessage'
    1006:
      id: 'timetable_message'
      doc: 'TimetableMessage'
    1007:
      id: 'standing_data_message'
      doc: 'StandingDataMessage'
    1008:
      id: 'real_time_index_message'
      doc: 'RealTimeIndexMessage'
    1009:
      id: 'statistics_message'
      doc: 'StatisticsMessage'
    1011:
      id: 'index_summary_message'
      doc: 'IndexSummaryMessage'
    1012:
      id: 'strategy_standing_data_message'
      doc: 'StrategyStandingDataMessage'
    1013:
      id: 'contract_standing_data_message'
      doc: 'ContractStandingDataMessage'
    1014:
      id: 'outright_standing_data_message'
      doc: 'OutrightStandingDataMessage'
    1015:
      id: 'long_order_update_message'
      doc: 'LongOrderUpdateMessage'
    1016:
      id: 'lis_package_structure_message'
      doc: 'LISPackageStructureMessage'
    1026:
      id: 'apa_quotes_message'
      doc: 'APAQuotesMessage'
    1027:
      id: 'apa_standing_data_message'
      doc: 'APAStandingDataMessage'
    1028:
      id: 'apa_full_trade_information_message'
      doc: 'APAFullTradeInformationMessage'
    1201:
      id: 'bf_instrument_reference_message'
      doc: 'BFInstrumentReferenceMessage'
    1202:
      id: 'bf_trade_message'
      doc: 'BFTradeMessage'
    1203:
      id: 'bfnav_message'
      doc: 'BFNAVMessage'
    1204:
      id: 'bf_instrument_suspension_message'
      doc: 'BFInstrumentSuspensionMessage'
    2101:
      id: 'start_of_snapshot_message'
      doc: 'StartOfSnapshotMessage'
    2102:
      id: 'end_of_snapshot_message'
      doc: 'EndOfSnapshotMessage'
  technical_notification_type:
    1:
      id: 'instrument_book_retransmission_end'
      doc: 'TechnicalNotificationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'trade_retransmission_start'
      doc: 'TechnicalNotificationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'trade_retransmission_end'
      doc: 'TechnicalNotificationType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    15:
      id: 'delta_neutral_contingency_leg'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'not_applicable'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    254:
      id: 'clear_book'
      doc: 'MarketDataUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  action_type:
    1:
      id: 'new_order'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'deletion_of_identified_order'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'deletion_of_all_orders_by_side'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'modification_of_existing_order_without_loss_of_priority'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'retransmission_of_all_orders'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'modification_of_existing_order_with_loss_of_priority'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'rfq_answercreation'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'rfq_answerdeletion'
      doc: 'MarketDataActionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  order_side:
    1:
      id: 'buy'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cross'
      doc: 'OrderSide_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  price_qualifier:
    1:
      id: 'last_adjusted_closing_price'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'last_traded_price'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'volume_weighted_average_price'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'closing_uncrossing_price'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'valuation_price'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'averageof_bbo'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'averageof_best_bid'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'updatedby_market_operations'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'closing_priceof_reference_market'
      doc: 'PriceQualifier_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  mmt_market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'quote_driven_market'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'dark_order_book'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'off_bookincluding_voiceor_messaging_trading'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'periodic_auctionequal_uncrossing'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'requestfor_quotes'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'hybrid_system'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'any_other_excluding_hybrid'
      doc: 'MMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mmt_trading_mode:
    0x31:
      id: 'undefined_auctionequal_uncrossing'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'continuous_trading'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'at_market_close_trading'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'outof_main_session_trading'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'trade_reporting_systematic_internaliser'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'scheduled_intraday_auctionequal_uncrossing'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'scheduled_closing_auctionequal_uncrossing'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'scheduled_opening_auctionequal_uncrossing'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'unscheduled_auctionequal_uncrossing'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'on_demand_auctionequal_frequent_batched_auction'
      doc: 'MMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mmt_off_book_automated_indicator:
    0x4d:
      id: 'off_book_non_automated'
      doc: 'MMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'off_book_automated'
      doc: 'MMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'unspecifiedordoesnotapply'
      doc: 'MMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  transaction_type:
    1:
      id: 'plain_vanilla_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'dark_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'benchmark_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'technical_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'giveup_givein_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'ex_cumdividend_trade'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'trade_with_condition'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'summary_report'
      doc: 'TransactionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  effective_date_indicator:
    0:
      id: 'sellerdeclarationisreceivedonthecurtradingsessionday'
      doc: 'EffectiveDateIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'sellerdeclarationreceivedbeforethecurtradingsessionday'
      doc: 'EffectiveDateIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  block_trade_code:
    0x42:
      id: 'block_trade'
      doc: 'BlockTradeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'regulartradeor_negotiateddeal'
      doc: 'BlockTradeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'undefined'
      doc: 'BlockTradeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  trading_period_optional:
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
  session:
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
    21:
      id: 'reserved_future_limit_interruption_protection'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'suspended_waiting_for_market_operations'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'trading_ended'
      doc: 'InstrumentState_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
    9:
      id: 'listednottraded'
      doc: 'EMM_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'delta_neutral_contingency_leg'
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
  optiq_segment:
    1:
      id: 'equities'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'funds'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fixed_income'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'warrantsand_certificates'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'boursede_luxembourg'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'options'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'futures'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'commodities'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'indices'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'trade_reportingand_publication'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'block'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'index_derivatives'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'equity_derivatives'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'financial_derivatives'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'forex'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'ibf'
      doc: 'OptiqSegment_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  guarantee_indicator:
    0:
      id: 'thisinstrumentisnotguaranteed'
      doc: 'GuaranteeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'thisinstrumentisguaranteed'
      doc: 'GuaranteeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'thisinstrumentisnotclearable'
      doc: 'GuaranteeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'guaranteed_cleared_borrowing_lending_service'
      doc: 'GuaranteeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_currency_indicator:
    0:
      id: 'changeratenotappliedtothetradedprice'
      doc: 'TradingCurrencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'changerateappliedtothetradedprice'
      doc: 'TradingCurrencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  strike_currency_indicator:
    0:
      id: 'changeratenotappliedtothestrikeprice'
      doc: 'StrikeCurrencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'changerateappliedtothestrikeprice'
      doc: 'StrikeCurrencyIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  inst_unit_exp:
    1:
      id: 'units'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'percentageof_nominal_excluding_accrued_interest_clean'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'basis_points'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'percentage_mixed'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'percentageof_nominal_including_accrued_interest_dirty'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'percentageof_par_value'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'yield_field'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'kilograms'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'ounces'
      doc: 'InstrumentUnitExpression_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  tax_code:
    0:
      id: 'noteligibleto_pea_thestockhasneverbeena_monorystock'
      doc: 'TaxCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'eligibleto_pea'
      doc: 'TaxCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'notprovided'
      doc: 'TaxCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  type_of_market_admission:
    0x41:
      id: 'instrumentstradedontheprimarymarket'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'instrumentstradedonthesecondarymarket'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'instrumentstradedonthe_new_market'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'nonregulatedmarketinstrumentstradedonthefreemarket'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'nonregulatedmarket_alternext'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'nonlisted'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'regulated_market_nonequities'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'regulated_market_equities_segment_a'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'regulated_market_equities_segment_b'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'regulated_market_equities_segment_c'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'regulated_market_allsecurities_special_segment'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4c:
      id: 'regulated_market_equities_otherinstruments'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'opcvmsicom_inonlisted_french_investment_funds'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'off_market'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'gold_currenciesand_indices'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x39:
      id: 'foreign'
      doc: 'TypeOfMarketAdmission_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  repo_indicator:
    0:
      id: 'instrneithereligiblefor_sr_dor_loanand_lending_mkt'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'instreligiblefor_sr_dandfor_loanand_lending_market'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'instreligibleforthe_sr_dlongonly'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'instreligiblefor_loanand_lending_mktandfor_sr_dlongonly'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'easytoborrow_instreligiblefor_sr_dandfor_loanand_lending_mkt'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'instreligibleforthe_loanand_lending_market'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'nonsignificant'
      doc: 'RepoIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  market_model:
    1:
      id: 'order_driven'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'quote_driven'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'ipo'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'primary_market'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'rfq'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'conditional_uncrossing'
      doc: 'MarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  anonymous:
    0:
      id: 'no_field'
      doc: 'Anonymous_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'yes_field'
      doc: 'Anonymous_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  index_level_type:
    0:
      id: 'indicative_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'official_opening_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'real_time_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'automatic_indicative_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'preliminary_reference_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'closing_reference_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'confirmed_reference_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'options_liquidation_index'
      doc: 'IndexLevelType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  index_price_code:
    0:
      id: 'only_index'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'indexand_session_high'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'indexand_session_low'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'indexand_session_highand_lowtypicallyfirstprice'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'only_session_high'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'only_session_low'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'previous_day_close'
      doc: 'IndexPriceCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  stats_update_type:
    5:
      id: 'daily_high'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'daily_low'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'yearly_high'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'yearly_low'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'lifetime_high'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'lifetime_low'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'variation_last_price'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'open_price'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'trade_count'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'last_traded_price'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'percent_variation_previous_close'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'off_book_cumul_qty'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'on_book_auction_cumul_qty'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'on_book_continuous_cumul_qty'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'onand_off_book_cumul_qty'
      doc: 'StatsUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exchange_code:
    0x41:
      id: 'amsterdam_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'brussels_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'paris_equity_underlyings'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'brussels_cash_underlyings'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'brussels_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'amsterdam_cash_underlyings'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'lisbon_cash_underlyings'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'paris_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'amsterdam_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'lisbon_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'paris_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'amsterdam_commodities_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'lisbon_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'paris_commodities_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'amsterdam_currency_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'oslo_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'oslo_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4c:
      id: 'oslo_cash_underlying'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'milan_cash_underlying'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'milan_index_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'milan_equity_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'milan_interest_rate_derivatives'
      doc: 'ExchangeCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  strategy_code:
    0x41:
      id: 'jelly_roll'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'butterfly'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'callor_put_cabinet'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'calendar_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'diagonal_calendar_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'guts'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'twoby_one_ratio_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'iron_butterfly'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'combo'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'strangle'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4c:
      id: 'ladder'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'strip'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'straddle_calendar_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'pack'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'diagonal_straddle_calendar_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'simple_inter_commodity_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'conversion_reversal'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'straddle'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x56:
      id: 'volatility_trade'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'condor'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'box_field'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'bundle'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'reduced_tick_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x61:
      id: 'ladderversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x62:
      id: 'butterflyversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x63:
      id: 'call_spreadversus_putversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x64:
      id: 'callor_put_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x65:
      id: 'callor_put_calendar_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x66:
      id: 'call_put_diagonal_calendar_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x67:
      id: 'gutsversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x68:
      id: 'twoby_one_callor_put_ratio_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x69:
      id: 'iron_butterflyversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x6a:
      id: 'comboversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x6b:
      id: 'strangleversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x6d:
      id: 'exchangefor_physical'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x6e:
      id: 'straddle_calendar_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x70:
      id: 'put_spreadversus_callversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x71:
      id: 'diagonal_straddle_calendar_spreadversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x72:
      id: 'synthetic'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x73:
      id: 'straddleversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x74:
      id: 'condorversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x75:
      id: 'buy_write'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x76:
      id: 'iron_condorversus_underlying'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x77:
      id: 'iron_condor'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x78:
      id: 'call_spreadversus_sella_put'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x79:
      id: 'put_spreadversus_sella_call'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x7a:
      id: 'put_straddleversus_sella_callora_put'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'ic_sonesidedcombinationsameexpiry'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'ic_stwosidedcombinationsameexpiry'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x6c:
      id: 'ratio_inter_contract_spread'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'call_spreadversus_put_or_put_spreadversus_call'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'ratio_spread_option'
      doc: 'StrategyCode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'LegBuyorSell_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'sell'
      doc: 'LegBuyorSell_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exer_style:
    0:
      id: 'european'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'american'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'asian'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'bermudan'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'other'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'periodic'
      doc: 'ExerciseStyle_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contract_type:
    0x46:
      id: 'future'
      doc: 'ContractType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'option'
      doc: 'ContractType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'underlying'
      doc: 'ContractType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  underlying_type:
    0x41:
      id: 'basketwith_commodity'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'basket'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'commodity'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'depositary_receipt'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'future'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x47:
      id: 'currency_leveraged_index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x48:
      id: 'other'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'bonds'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'stock_dividend'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4c:
      id: 'leveraged_index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'interest_rate'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'other_derivative'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'commodity_index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'commodity_leveraged_index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'right'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'stock'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'credit'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'fund'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x56:
      id: 'currency'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'stock_warrant'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x58:
      id: 'exchange_rate'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'security_leveraged_index'
      doc: 'UnderlyingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  contract_trading_type:
    0:
      id: 'not_applicable'
      doc: 'ContractTradingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'tradedasanoutright'
      doc: 'ContractTradingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'nottradedbutlistedincontractdata_tradersmaysubscribeto'
      doc: 'ContractTradingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'tradedasasimpleintercommodityspread'
      doc: 'ContractTradingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'tradedasanintercommodityspread'
      doc: 'ContractTradingType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  underlying_subtype:
    0:
      id: 'basket'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'dividend'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'etf'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'share'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'dividend_index'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'equity_index'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'trf_index'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'volatility_index'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'future_on_commodities'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'fx_cross_rates'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'fx_emerging_markets'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'fx_majors'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'agricultural'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'environmental'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'freight'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'fertilizer'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'industrialproducts'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'inflation'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'multi_commodity_exotic'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'metals'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'energy'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'officialeconomicstatistics'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'other_c_10'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'other'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    24:
      id: 'paper'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    25:
      id: 'polypropylene'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    26:
      id: 'bonds_basket'
      doc: 'UnderlyingSubtype_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trading_policy:
    1:
      id: 'price_explicit_time'
      doc: 'TradingPolicy_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'price_pro_rata'
      doc: 'TradingPolicy_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  derivatives_market_model:
    0:
      id: 'no_synthetic_quote'
      doc: 'DerivativesMarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'spontaneous_implied_matching'
      doc: 'DerivativesMarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'event_driven_implied_matching'
      doc: 'DerivativesMarketModel_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reference_price_origin_in_opening_call:
    1:
      id: 'internal_field'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'external'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'external_bbo'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'opening_call_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'future_market_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reference_price_origin_in_continuous:
    1:
      id: 'internal_field'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'external'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'external_bbo'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'opening_call_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'future_market_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reference_price_origin_in_trading_interruption:
    1:
      id: 'internal_field'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'external'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'external_bbo'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'opening_call_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fair_value'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'future_market_price'
      doc: 'ReferencePriceOrigin_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  pricing_algorithm:
    0:
      id: 'standard'
      doc: 'PricingAlgorithm_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'total_return_future'
      doc: 'PricingAlgorithm_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'market_on_close'
      doc: 'PricingAlgorithm_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'standardwith_negative_prices'
      doc: 'PricingAlgorithm_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  dynamic_collar_logic:
    0:
      id: 'not_active'
      doc: 'DynamicCollarLogic_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'no_haltwith_reject'
      doc: 'DynamicCollarLogic_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'haltwith_acceptation'
      doc: 'DynamicCollarLogic_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  derivatives_instrument_type:
    0:
      id: 'call_option'
      doc: 'DerivativesInstrumentType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'put_option'
      doc: 'DerivativesInstrumentType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'strategy'
      doc: 'DerivativesInstrumentType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'individual_future'
      doc: 'DerivativesInstrumentType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'underlying'
      doc: 'DerivativesInstrumentType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  expiry_cycle_type:
    1:
      id: 'daily'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'weekly'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'monthly'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'quarterly'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'half_yearly'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'yearly'
      doc: 'ExpiryCycleType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
  quote_update_type:
    1:
      id: 'best_bid'
      doc: 'QuoteUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'best_offer'
      doc: 'QuoteUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'cancel_bid'
      doc: 'QuoteUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'cancel_offer'
      doc: 'QuoteUpdateType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  option_type:
    1:
      id: 'call'
      doc: 'OptionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'put'
      doc: 'OptionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'other'
      doc: 'OptionType_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'quote_driven_market'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'dark_order_book'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'off_bookincluding_voiceor_messaging_trading'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'periodic_auctionequal_uncrossing'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'requestfor_quotes'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'other'
      doc: 'EfficientMMTMarketMechanism_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_trading_mode:
    0x31:
      id: 'undefined_auctionequal_uncrossing'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'continuous_trading'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'at_market_close_trading'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'outof_main_session_trading'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'trade_reporting_systematic_internaliser'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x49:
      id: 'scheduled_intraday_auctionequal_uncrossing'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4b:
      id: 'scheduled_closing_auctionequal_uncrossing'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4f:
      id: 'scheduled_opening_auctionequal_uncrossing'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x55:
      id: 'unscheduled_auctionequal_uncrossing'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'on_demand_auctionequal_frequent_batched_auction'
      doc: 'EfficientMMTTradingMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'EfficientMMTTransactionCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'rpri'
      doc: 'EfficientMMTTransactionCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'xfph'
      doc: 'EfficientMMTTransactionCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x5a:
      id: 'tpac'
      doc: 'EfficientMMTTransactionCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'noneapply'
      doc: 'EfficientMMTTransactionCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_negotiation_indicator:
    0x31:
      id: 'nliq'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'oilq'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'pric'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'ilqd'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'size'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'ilqd_size'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'negotiated_trade'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'no_negotiated_trade'
      doc: 'EfficientMMTNegotiationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_agency_cross_trade_indicator:
    0x58:
      id: 'actx'
      doc: 'EfficientMMTAgencyCrossTradeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'no_agency_cross_trade'
      doc: 'EfficientMMTAgencyCrossTradeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_modification_indicator:
    0x41:
      id: 'amnd'
      doc: 'EfficientMMTModificationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'canc'
      doc: 'EfficientMMTModificationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'new_trade'
      doc: 'EfficientMMTModificationIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_benchmark_indicator:
    0x42:
      id: 'benc'
      doc: 'EfficientMMTBenchmarkIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'rfpt'
      doc: 'EfficientMMTBenchmarkIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'no_benchmarkor_reference_price_trade'
      doc: 'EfficientMMTBenchmarkIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_special_dividend_indicator:
    0x45:
      id: 'sdiv'
      doc: 'EfficientMMTSpecialDividendIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'no_special_dividend_trade'
      doc: 'EfficientMMTSpecialDividendIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_off_book_automated_indicator:
    0x4d:
      id: 'off_book_non_automated'
      doc: 'EfficientMMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x51:
      id: 'off_book_automated'
      doc: 'EfficientMMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'unspecifiedordoesnotapply'
      doc: 'EfficientMMTOffBookAutomatedIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_contributionto_price:
    0x4a:
      id: 'tncp'
      doc: 'EfficientMMTContributiontoPrice_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'pndg'
      doc: 'EfficientMMTContributiontoPrice_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'EfficientMMTContributiontoPrice_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x54:
      id: 'npft'
      doc: 'EfficientMMTContributiontoPrice_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_algorithmic_indicator:
    0x48:
      id: 'algo'
      doc: 'EfficientMMTAlgorithmicIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'no_algorithmic_trade'
      doc: 'EfficientMMTAlgorithmicIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_publication_mode:
    0x31:
      id: 'non_immediate_publication'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'lrgs'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'ilqd'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'size'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'ilqd_size'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'ilqd_lrgs'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'immediate_publication'
      doc: 'EfficientMMTPublicationMode_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_post_trade_deferral:
    0x31:
      id: 'lmtf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'datf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'volo'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'fwaf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'idaf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'volw'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'fulf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'fula'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x39:
      id: 'fulv'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x56:
      id: 'fulj'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x57:
      id: 'coaf'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'not_applicable'
      doc: 'EfficientMMTPostTradeDeferral_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  efficient_mmt_duplicative_indicator:
    0x31:
      id: 'dupl'
      doc: 'EfficientMMTDuplicativeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x2d:
      id: 'unique_trade_report'
      doc: 'EfficientMMTDuplicativeIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  opened_closed_fund:
    0x4f:
      id: 'open'
      doc: 'OpenedClosedFund_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'closed'
      doc: 'OpenedClosedFund_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  gross_of_cdsc_indicator:
    0x4e:
      id: 'no_field'
      doc: 'GrossofCDSCIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x59:
      id: 'yes_field'
      doc: 'GrossofCDSCIndicator_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  tax_description_attaching_to_a_dividend:
    0x44:
      id: 'deducedat_source'
      doc: 'TaxDescriptionAttachingtoaDividend_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  payment_frequency:
    1:
      id: 'annual'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'semi_annual'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'quarterly'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'monthly'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'bi_monthly'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'daily'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'migration_na'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'other'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'no_coupon'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'at_maturity'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'triannual'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'capitalization'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'imm_dates'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'bimestrial'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'weekly'
      doc: 'PaymentFrequency_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instrument_category:
    1:
      id: 'equities'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'fixed_income'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'warrants_and_certificates'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'trackers'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'futures'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'options'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'indices'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'euronext_funds_services'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'inav_indicative_net_asset_value'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'fund'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'forex'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    254:
      id: 'miscellaneous'
      doc: 'InstrumentCategory_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_condition:
    0x4f:
      id: 'normal'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'ex_dividend'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'ex_cap'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'ex_rights'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'ex_entitlement'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x53:
      id: 'dealingstemporarilysuspended'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4e:
      id: 'not_listed'
      doc: 'SecurityCondition_enum Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

