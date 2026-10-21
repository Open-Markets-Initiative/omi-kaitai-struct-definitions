# ---------------------------------------------------------------------
# Kaitai struct definition for: Euronext Optiq MarketDataGateway Sbe v4.2
#
# Protocol:
#   Organization: Euronext
#   Protocol: Market Data Gateway
#   Encoding: Simple Binary Encoding
#   Version: 4.2
#   Date: 1/1/2022
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
  id: euronext_optiq_marketdatagateway_sbe_v4_2
  title: Euronext Optiq MarketDataGateway Sbe v4.2
  license: GPL-3.0
  endian: le

doc: 'Euronext Euronext Optiq Market Data Gateway Sbe v4.2'
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
    meta:
      bit-endian: le
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
      - id: block_extension
        size: _parent.message_header.block_length - 10
        doc: 'Bytes the stated block holds beyond the 10 this version reads'
  end_of_day_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: session_trading_day
        type: u2
        doc: 'sessionTradingDay'
      - id: block_extension
        size: _parent.message_header.block_length - 10
        doc: 'Bytes the stated block holds beyond the 10 this version reads'
  health_status_message:
    seq:
      - id: md_seq_num
        type: u8
        doc: 'mDSeqNum'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'eventTime. Nanoseconds since Unix epoch'
      - id: block_extension
        size: _parent.message_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 30
        doc: 'Bytes the stated block holds beyond the 30 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 23
        doc: 'Bytes the stated block holds beyond the 23 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 40
        doc: 'Bytes the stated block holds beyond the 40 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 30
        doc: 'Bytes the stated block holds beyond the 30 this version reads'
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
      - id: mmt_modification_indicator_optional
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
      - id: block_extension
        size: _parent.message_header.block_length - 404
        doc: 'Bytes the stated block holds beyond the 404 this version reads'
      - id: not_used_groups
        type: not_used_groups
        doc: 'NotUsedGroup1 Block'
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
  not_used_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'groupSizeEncoding'
      - id: not_used_group
        size: group_size_encoding.block_length_short
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
      - id: block_extension
        size: _parent.message_header.block_length - 10
        doc: 'Bytes the stated block holds beyond the 10 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 33
        doc: 'Bytes the stated block holds beyond the 33 this version reads'
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
      - id: reserved_10
        type: b10
        doc: '10 reserved bits'
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
      - id: block_extension
        size: _parent.message_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 15
        doc: 'Bytes the stated block holds beyond the 15 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 409
        doc: 'Bytes the stated block holds beyond the 409 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 13
        doc: 'Bytes the stated block holds beyond the 13 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 9
        doc: 'Bytes the stated block holds beyond the 9 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 126
        doc: 'Bytes the stated block holds beyond the 126 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 52
        doc: 'Bytes the stated block holds beyond the 52 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 17
        doc: 'Bytes the stated block holds beyond the 17 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 183
        doc: 'Bytes the stated block holds beyond the 183 this version reads'
      - id: contract_emm_properties_groups
        type: contract_emm_properties_groups
        doc: 'ContractEMMProperties Block'
  order_type_rules:
    meta:
      bit-endian: le
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
    meta:
      bit-endian: le
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 27
        doc: 'Bytes the stated block holds beyond the 27 this version reads'
  strategy_authorized:
    meta:
      bit-endian: le
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
      - id: reserved_16
        type: b16
        doc: '16 reserved bits'
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
      - id: block_extension
        size: _parent.message_header.block_length - 115
        doc: 'Bytes the stated block holds beyond the 115 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 1
        doc: 'Bytes the stated block holds beyond the 1 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 18
        doc: 'Bytes the stated block holds beyond the 18 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 49
        doc: 'Bytes the stated block holds beyond the 49 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 75
        doc: 'Bytes the stated block holds beyond the 75 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 8
        doc: 'Bytes the stated block holds beyond the 8 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 101
        doc: 'Bytes the stated block holds beyond the 101 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 217
        doc: 'Bytes the stated block holds beyond the 217 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 385
        doc: 'Bytes the stated block holds beyond the 385 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 656
        doc: 'Bytes the stated block holds beyond the 656 this version reads'
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
      - id: block_extension
        size: _parent.group_size_encoding.block_length_short - 2
        doc: 'Bytes the stated block holds beyond the 2 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 148
        doc: 'Bytes the stated block holds beyond the 148 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 109
        doc: 'Bytes the stated block holds beyond the 109 this version reads'
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
      - id: block_extension
        size: _parent.message_header.block_length - 22
        doc: 'Bytes the stated block holds beyond the 22 this version reads'
  start_of_snapshot_message:
    seq:
      - id: last_md_seq_num
        type: u8_nullable
        doc: 'lastMDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: snapshot_time
        type: u8
        doc: 'snapshotTime'
      - id: block_extension
        size: _parent.message_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  end_of_snapshot_message:
    seq:
      - id: last_md_seq_num
        type: u8_nullable
        doc: 'lastMDSeqNum. Nullable, No Value = 18446744073709551615'
      - id: snapshot_time
        type: u8
        doc: 'snapshotTime'
      - id: block_extension
        size: _parent.message_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
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
        value: value.time == -1
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
  str_16_nullable:
    seq:
      - id: value
        size: 16
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
      doc: 'Instrument_Book_Retransmission_End'
    10:
      id: 'trade_retransmission_start'
      doc: 'Trade_Retransmission_Start'
    11:
      id: 'trade_retransmission_end'
      doc: 'Trade_Retransmission_End'
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
    254:
      id: 'clear_book'
      doc: 'Clear_Book'
  action_type:
    1:
      id: 'new_order'
      doc: 'NewOrder'
    2:
      id: 'deletion_of_identified_order'
      doc: 'DeletionOfIdentifiedOrder'
    3:
      id: 'deletion_of_all_orders_by_side'
      doc: 'DeletionOfAllOrdersBySide'
    4:
      id: 'modification_of_existing_order_without_loss_of_priority'
      doc: 'ModificationOfExistingOrderWithoutLossOfPriority'
    5:
      id: 'retransmission_of_all_orders'
      doc: 'RetransmissionOfAllOrders'
    6:
      id: 'modification_of_existing_order_with_loss_of_priority'
      doc: 'ModificationOfExistingOrderWithLossOfPriority'
    7:
      id: 'rfq_answercreation'
      doc: 'RFQ_Answer_creation'
    8:
      id: 'rfq_answerdeletion'
      doc: 'RFQ_Answer_deletion_'
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
  mmt_market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: 'Central_Limit_Order_Book'
    2:
      id: 'quote_driven_market'
      doc: 'Quote_Driven_Market'
    3:
      id: 'dark_order_book'
      doc: 'Dark_Order_Book'
    4:
      id: 'off_bookincluding_voiceor_messaging_trading'
      doc: 'Off_Book_including_Voice_or_Messaging_Trading'
    5:
      id: 'periodic_auctionequal_uncrossing'
      doc: 'Periodic_Auction_equal_Uncrossing'
    6:
      id: 'requestfor_quotes'
      doc: 'Request_for_Quotes'
  mmt_trading_mode:
    0x31:
      id: 'undefined_auctionequal_uncrossing'
      doc: 'Undefined_Auction_equal_Uncrossing'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous_Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At_Market_Close_Trading'
    0x34:
      id: 'outof_main_session_trading'
      doc: 'Out_of_Main_Session_Trading'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'Trade_Reporting_On_Exchange'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'Trade_Reporting_Off_Exchange'
    0x37:
      id: 'trade_reporting_systematic_internaliser'
      doc: 'Trade_Reporting_Systematic_Internaliser'
    0x49:
      id: 'scheduled_intraday_auctionequal_uncrossing'
      doc: 'Scheduled_Intraday_Auction_equal_Uncrossing'
    0x4b:
      id: 'scheduled_closing_auctionequal_uncrossing'
      doc: 'Scheduled_Closing_Auction_equal_Uncrossing'
    0x4f:
      id: 'scheduled_opening_auctionequal_uncrossing'
      doc: 'Scheduled_Opening_Auction_equal_Uncrossing'
    0x55:
      id: 'unscheduled_auctionequal_uncrossing'
      doc: 'Unscheduled_Auction_equal_Uncrossing'
  mmt_off_book_automated_indicator:
    0x4d:
      id: 'off_book_non_automated'
      doc: 'Off_Book_Non_Automated'
    0x51:
      id: 'off_book_automated'
      doc: 'Off_Book_Automated'
    0x2d:
      id: 'unspecifiedordoesnotapply'
      doc: 'Unspecified_or_does_not_apply'
  transaction_type:
    1:
      id: 'plain_vanilla_trade'
      doc: 'Plain_Vanilla_Trade'
    2:
      id: 'dark_trade'
      doc: 'Dark_Trade'
    3:
      id: 'benchmark_trade'
      doc: 'Benchmark_Trade'
    4:
      id: 'technical_trade'
      doc: 'Technical_Trade'
    5:
      id: 'giveup_givein_trade'
      doc: 'Giveup_Givein_Trade'
    6:
      id: 'ex_cumdividend_trade'
      doc: 'Ex_Cum_dividend_Trade'
    7:
      id: 'trade_with_condition'
      doc: 'Trade_With_Condition'
    15:
      id: 'summary_report'
      doc: 'Summary_Report'
  effective_date_indicator:
    0:
      id: 'sellerdeclarationisreceivedonthecurtradingsessionday'
      doc: 'Seller_declaration_is_received_on_the_cur_trading_session_day'
    1:
      id: 'sellerdeclarationreceivedbeforethecurtradingsessionday'
      doc: 'Seller_declaration_received_before_the_cur_trading_session_day'
  block_trade_code:
    0x42:
      id: 'block_trade'
      doc: 'Block_Trade'
    0x4e:
      id: 'regulartradeor_negotiateddeal'
      doc: 'Regular_trade_or_Negotiated_deal'
    0x2d:
      id: 'undefined'
      doc: 'Undefined'
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
  trading_period_optional:
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
  optiq_segment:
    1:
      id: 'equities'
      doc: 'Equities'
    2:
      id: 'funds'
      doc: 'Funds'
    3:
      id: 'fixed_income'
      doc: 'Fixed_Income'
    4:
      id: 'warrantsand_certificates'
      doc: 'Warrants_and_Certificates'
    5:
      id: 'boursede_luxembourg'
      doc: 'Bourse_de_Luxembourg'
    6:
      id: 'options'
      doc: 'Options'
    7:
      id: 'futures'
      doc: 'Futures'
    8:
      id: 'commodities'
      doc: 'Commodities'
    9:
      id: 'indices'
      doc: 'Indices'
    10:
      id: 'trade_reportingand_publication'
      doc: 'Trade_Reporting_and_Publication'
    14:
      id: 'block'
      doc: 'Block'
    11:
      id: 'index_derivatives'
      doc: 'Index_Derivatives'
    12:
      id: 'equity_derivatives'
      doc: 'Equity_Derivatives'
    13:
      id: 'financial_derivatives'
      doc: 'Financial_Derivatives'
    15:
      id: 'forex'
      doc: 'Forex'
    16:
      id: 'ibf'
      doc: 'IBF'
  guarantee_indicator:
    0:
      id: 'thisinstrumentisnotguaranteed'
      doc: 'This_instrument_is_not_guaranteed'
    1:
      id: 'thisinstrumentisguaranteed'
      doc: 'This_instrument_is_guaranteed'
    2:
      id: 'thisinstrumentisnotclearable'
      doc: 'This_instrument_is_not_clearable'
    8:
      id: 'guaranteed_cleared_borrowing_lending_service'
      doc: 'Guaranteed_Cleared_Borrowing_Lending_Service'
  trading_currency_indicator:
    0:
      id: 'changeratenotappliedtothetradedprice'
      doc: 'Change_rate_not_applied_to_the_traded_price'
    1:
      id: 'changerateappliedtothetradedprice'
      doc: 'Change_rate_applied_to_the_traded_price'
  strike_currency_indicator:
    0:
      id: 'changeratenotappliedtothestrikeprice'
      doc: 'Change_rate_not_applied_to_the_strike_price'
    1:
      id: 'changerateappliedtothestrikeprice'
      doc: 'Change_rate_applied_to_the_strike_price'
  inst_unit_exp:
    1:
      id: 'units'
      doc: 'Units'
    2:
      id: 'percentageof_nominal_excluding_accrued_interest_clean'
      doc: 'Percentage_of_Nominal_Excluding_Accrued_Interest_Clean'
    3:
      id: 'basis_points'
      doc: 'Basis_Points'
    5:
      id: 'percentageof_nominal_including_accrued_interest_dirty'
      doc: 'Percentage_of_Nominal_Including_Accrued_Interest_Dirty'
    7:
      id: 'yield_field'
      doc: 'Yield'
    8:
      id: 'kilograms'
      doc: 'Kilograms'
    9:
      id: 'ounces'
      doc: 'Ounces'
  tax_code:
    0:
      id: 'noteligibleto_pea_thestockhasneverbeena_monorystock'
      doc: 'Not_eligible_to_PEA___The_stock_has_never_been_a_Monory_stock'
    3:
      id: 'eligibleto_pea'
      doc: 'Eligible_to_PEA'
    9:
      id: 'notprovided'
      doc: 'Not_provided'
  type_of_market_admission:
    0x41:
      id: 'instrumentstradedontheprimarymarket'
      doc: 'Instruments_traded_on_the_primary_market'
    0x42:
      id: 'instrumentstradedonthesecondarymarket'
      doc: 'Instruments_traded_on_the_secondary_market'
    0x43:
      id: 'instrumentstradedonthe_new_market'
      doc: 'Instruments_traded_on_the_New_Market'
    0x44:
      id: 'nonregulatedmarketinstrumentstradedonthefreemarket'
      doc: 'Non_regulated_market_instruments_traded_on_the_free_market'
    0x45:
      id: 'nonregulatedmarket_alternext'
      doc: 'Non_regulated_market_Alternext'
    0x46:
      id: 'nonlisted'
      doc: 'Non_listed'
    0x47:
      id: 'regulated_market_nonequities'
      doc: 'Regulated_Market_Non_equities'
    0x48:
      id: 'regulated_market_equities_segment_a'
      doc: 'Regulated_Market_Equities_Segment_A'
    0x49:
      id: 'regulated_market_equities_segment_b'
      doc: 'Regulated_Market_Equities_Segment_B'
    0x4a:
      id: 'regulated_market_equities_segment_c'
      doc: 'Regulated_Market_Equities_Segment_C'
    0x4b:
      id: 'regulated_market_allsecurities_special_segment'
      doc: 'Regulated_Market_All_securities_Special_Segment'
    0x4c:
      id: 'regulated_market_equities_otherinstruments'
      doc: 'Regulated_Market_Equities_Other_instruments'
    0x53:
      id: 'opcvmsicom_inonlisted_french_investment_funds'
      doc: 'OPCVM_SICOMI_non_listed_French_Investment_Funds'
    0x36:
      id: 'off_market'
      doc: 'Off_Market'
    0x37:
      id: 'gold_currenciesand_indices'
      doc: 'Gold_Currencies_and_Indices'
    0x39:
      id: 'foreign'
      doc: 'Foreign'
  repo_indicator:
    0:
      id: 'instrneithereligiblefor_sr_dor_loanand_lending_mkt'
      doc: 'Instr_neither_eligible_for_SRD_or_Loan_and_Lending_Mkt'
    1:
      id: 'instreligiblefor_sr_dandfor_loanand_lending_market'
      doc: 'Instr_eligible_for_SRD_and_for_Loan_and_Lending_Market'
    2:
      id: 'instreligibleforthe_sr_dlongonly'
      doc: 'Instr_eligible_for_the_SRD_long_only'
    3:
      id: 'instreligiblefor_loanand_lending_mktandfor_sr_dlongonly'
      doc: 'Instr_eligible_for_Loan_and_Lending_Mkt_and_for_SRD_long_only'
    4:
      id: 'easytoborrow_instreligiblefor_sr_dandfor_loanand_lending_mkt'
      doc: 'Easytoborrow_Instr_eligible_for_SRD_and_for_Loan_and_Lending_Mkt'
    5:
      id: 'instreligibleforthe_loanand_lending_market'
      doc: 'Instr_eligible_for_the_Loan_and_Lending_Market'
    8:
      id: 'nonsignificant'
      doc: 'Non_significant'
  market_model:
    1:
      id: 'order_driven'
      doc: 'Order_Driven'
    2:
      id: 'quote_driven'
      doc: 'Quote_Driven'
    3:
      id: 'ipo'
      doc: 'IPO'
    4:
      id: 'primary_market'
      doc: 'Primary_Market'
    5:
      id: 'rfq'
      doc: 'RFQ'
    6:
      id: 'conditional_uncrossing'
      doc: 'Conditional_Uncrossing'
  anonymous:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  index_level_type:
    0:
      id: 'indicative_index'
      doc: 'Indicative_Index'
    1:
      id: 'official_opening_index'
      doc: 'Official_Opening_Index'
    2:
      id: 'real_time_index'
      doc: 'RealTime_Index'
    3:
      id: 'automatic_indicative_index'
      doc: 'Automatic_Indicative_Index'
    4:
      id: 'preliminary_reference_index'
      doc: 'Preliminary_Reference_Index'
    5:
      id: 'closing_reference_index'
      doc: 'Closing_Reference_Index'
    6:
      id: 'confirmed_reference_index'
      doc: 'Confirmed_Reference_Index'
    7:
      id: 'options_liquidation_index'
      doc: 'Options_Liquidation_Index'
  index_price_code:
    0:
      id: 'only_index'
      doc: 'Only_Index'
    1:
      id: 'indexand_session_high'
      doc: 'Index_and_Session_High'
    2:
      id: 'indexand_session_low'
      doc: 'Index_and_Session_Low'
    3:
      id: 'indexand_session_highand_lowtypicallyfirstprice'
      doc: 'Index_and_Session_High_and_Low__typically_first_price_'
    4:
      id: 'only_session_high'
      doc: 'Only_Session_High'
    5:
      id: 'only_session_low'
      doc: 'Only_Session_Low'
    6:
      id: 'previous_day_close'
      doc: 'Previous_Day_Close'
  stats_update_type:
    5:
      id: 'daily_high'
      doc: 'Daily_High'
    6:
      id: 'daily_low'
      doc: 'Daily_Low'
    7:
      id: 'yearly_high'
      doc: 'Yearly_High'
    8:
      id: 'yearly_low'
      doc: 'Yearly_Low'
    9:
      id: 'lifetime_high'
      doc: 'Lifetime_High'
    10:
      id: 'lifetime_low'
      doc: 'Lifetime_Low'
    14:
      id: 'variation_last_price'
      doc: 'Variation_Last_Price'
    15:
      id: 'open_price'
      doc: 'Open_Price'
    16:
      id: 'trade_count'
      doc: 'Trade_Count'
    17:
      id: 'last_traded_price'
      doc: 'Last_Traded_Price'
    18:
      id: 'percent_variation_previous_close'
      doc: 'Percent_Variation_Previous_Close'
    19:
      id: 'off_book_cumul_qty'
      doc: 'Off_Book_Cumul_Qty'
    21:
      id: 'on_book_auction_cumul_qty'
      doc: 'On_Book_Auction_Cumul_Qty'
    22:
      id: 'on_book_continuous_cumul_qty'
      doc: 'On_Book_Continuous_Cumul_Qty'
    23:
      id: 'onand_off_book_cumul_qty'
      doc: 'On_and_Off_Book_Cumul_Qty'
  exchange_code:
    0x41:
      id: 'amsterdam_equity_derivatives'
      doc: 'Amsterdam_Equity_Derivatives'
    0x42:
      id: 'brussels_equity_derivatives'
      doc: 'Brussels_Equity_Derivatives'
    0x43:
      id: 'paris_equity_underlyings'
      doc: 'Paris_Equity_Underlyings'
    0x44:
      id: 'brussels_cash_underlyings'
      doc: 'Brussels_Cash_Underlyings'
    0x46:
      id: 'brussels_index_derivatives'
      doc: 'Brussels_Index_Derivatives'
    0x47:
      id: 'amsterdam_cash_underlyings'
      doc: 'Amsterdam_Cash_Underlyings'
    0x48:
      id: 'lisbon_cash_underlyings'
      doc: 'Lisbon_Cash_Underlyings'
    0x4a:
      id: 'paris_index_derivatives'
      doc: 'Paris_Index_Derivatives'
    0x4b:
      id: 'amsterdam_index_derivatives'
      doc: 'Amsterdam_Index_Derivatives'
    0x4d:
      id: 'lisbon_index_derivatives'
      doc: 'Lisbon_Index_Derivatives'
    0x50:
      id: 'paris_equity_derivatives'
      doc: 'Paris_Equity_Derivatives'
    0x52:
      id: 'amsterdam_commodities_derivatives'
      doc: 'Amsterdam_Commodities_Derivatives'
    0x53:
      id: 'lisbon_equity_derivatives'
      doc: 'Lisbon_Equity_Derivatives'
    0x59:
      id: 'paris_commodities_derivatives'
      doc: 'Paris_Commodities_Derivatives'
    0x5a:
      id: 'amsterdam_currency_derivatives'
      doc: 'Amsterdam_Currency_Derivatives'
    0x4e:
      id: 'oslo_index_derivatives'
      doc: 'Oslo_Index_Derivatives'
    0x4f:
      id: 'oslo_equity_derivatives'
      doc: 'Oslo_Equity_Derivatives'
    0x4c:
      id: 'oslo_cash_underlying'
      doc: 'Oslo_Cash_Underlying'
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
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  exer_style:
    0:
      id: 'european'
      doc: 'European'
    1:
      id: 'american'
      doc: 'American'
    2:
      id: 'asian'
      doc: 'Asian'
    3:
      id: 'bermudan'
      doc: 'Bermudan'
    4:
      id: 'other'
      doc: 'Other'
  contract_type:
    0x46:
      id: 'future'
      doc: 'Future'
    0x4f:
      id: 'option'
      doc: 'Option'
    0x55:
      id: 'underlying'
      doc: 'Underlying'
  underlying_type:
    0x43:
      id: 'commodity'
      doc: 'Commodity'
    0x46:
      id: 'future'
      doc: 'Future'
    0x49:
      id: 'index'
      doc: 'Index'
    0x53:
      id: 'stock'
      doc: 'Stock'
    0x58:
      id: 'exchange_rate'
      doc: 'Exchange_Rate'
  contract_trading_type:
    1:
      id: 'tradedasanoutright'
      doc: 'Traded_as_an_outright'
    2:
      id: 'nottradedbutlistedincontractdata_tradersmaysubscribeto'
      doc: 'Not_traded_but_listed_in_contract_data_Traders_may_subscribe_to'
    3:
      id: 'tradedasasimpleintercommodityspread'
      doc: 'Traded_as_a_simple_intercommodity_spread'
    4:
      id: 'tradedasanintercommodityspread'
      doc: 'Traded_as_an_intercommodity_spread'
  underlying_subtype:
    0:
      id: 'basket'
      doc: 'Basket'
    1:
      id: 'dividend'
      doc: 'Dividend'
    2:
      id: 'etf'
      doc: 'ETF'
    3:
      id: 'share'
      doc: 'Share'
    4:
      id: 'dividend_index'
      doc: 'Dividend_Index'
    5:
      id: 'equity_index'
      doc: 'Equity_Index'
    6:
      id: 'trf_index'
      doc: 'TRF_Index'
    7:
      id: 'volatility_index'
      doc: 'Volatility_Index'
    8:
      id: 'future_on_commodities'
      doc: 'Future_On_Commodities'
    9:
      id: 'fx_cross_rates'
      doc: 'FX_Cross_Rates'
    10:
      id: 'fx_emerging_markets'
      doc: 'FX_Emerging_Markets'
    11:
      id: 'fx_majors'
      doc: 'FX_Majors'
    12:
      id: 'agricultural'
      doc: 'Agricultural'
    13:
      id: 'environmental'
      doc: 'Environmental'
    14:
      id: 'freight'
      doc: 'Freight'
    15:
      id: 'fertilizer'
      doc: 'Fertilizer'
    16:
      id: 'industrialproducts'
      doc: 'Industrial_products'
    17:
      id: 'inflation'
      doc: 'Inflation'
    18:
      id: 'multi_commodity_exotic'
      doc: 'Multi_Commodity_Exotic'
    19:
      id: 'metals'
      doc: 'Metals'
    20:
      id: 'energy'
      doc: 'Energy'
    21:
      id: 'officialeconomicstatistics'
      doc: 'Official_economic_statistics'
    22:
      id: 'other_c_10'
      doc: 'Other_C10'
    23:
      id: 'other'
      doc: 'Other'
    24:
      id: 'paper'
      doc: 'Paper'
    25:
      id: 'polypropylene'
      doc: 'Polypropylene'
  trading_policy:
    1:
      id: 'price_explicit_time'
      doc: 'Price_Explicit_Time'
    2:
      id: 'price_pro_rata'
      doc: 'Price_Pro_Rata'
  derivatives_market_model:
    0:
      id: 'no_synthetic_quote'
      doc: 'NoSyntheticQuote'
    1:
      id: 'spontaneous_implied_matching'
      doc: 'SpontaneousImpliedMatching'
    2:
      id: 'event_driven_implied_matching'
      doc: 'EventDrivenImpliedMatching'
  reference_price_origin_in_opening_call:
    1:
      id: 'internal_field'
      doc: 'Internal'
    2:
      id: 'external'
      doc: 'External'
    3:
      id: 'external_bbo'
      doc: 'External_BBO'
    4:
      id: 'opening_call_price'
      doc: 'Opening_Call_Price'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'Mid_BBO_or_Fair_Value'
    6:
      id: 'fair_value'
      doc: 'Fair_Value'
    7:
      id: 'future_market_price'
      doc: 'Future_Market_Price'
  reference_price_origin_in_continuous:
    1:
      id: 'internal_field'
      doc: 'Internal'
    2:
      id: 'external'
      doc: 'External'
    3:
      id: 'external_bbo'
      doc: 'External_BBO'
    4:
      id: 'opening_call_price'
      doc: 'Opening_Call_Price'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'Mid_BBO_or_Fair_Value'
    6:
      id: 'fair_value'
      doc: 'Fair_Value'
    7:
      id: 'future_market_price'
      doc: 'Future_Market_Price'
  reference_price_origin_in_trading_interruption:
    1:
      id: 'internal_field'
      doc: 'Internal'
    2:
      id: 'external'
      doc: 'External'
    3:
      id: 'external_bbo'
      doc: 'External_BBO'
    4:
      id: 'opening_call_price'
      doc: 'Opening_Call_Price'
    5:
      id: 'mid_bb_oor_fair_value'
      doc: 'Mid_BBO_or_Fair_Value'
    6:
      id: 'fair_value'
      doc: 'Fair_Value'
    7:
      id: 'future_market_price'
      doc: 'Future_Market_Price'
  pricing_algorithm:
    0:
      id: 'standard'
      doc: 'Standard'
    1:
      id: 'total_return_future'
      doc: 'Total_Return_Future'
    2:
      id: 'market_on_close'
      doc: 'Market_On_Close'
  dynamic_collar_logic:
    0:
      id: 'not_active'
      doc: 'Not_Active'
    2:
      id: 'no_haltwith_reject'
      doc: 'No_Halt_with_Reject'
    3:
      id: 'haltwith_acceptation'
      doc: 'Halt_with_Acceptation'
  derivatives_instrument_type:
    0:
      id: 'call_option'
      doc: 'CallOption'
    1:
      id: 'put_option'
      doc: 'PutOption'
    2:
      id: 'strategy'
      doc: 'Strategy'
    3:
      id: 'individual_future'
      doc: 'IndividualFuture'
    4:
      id: 'underlying'
      doc: 'Underlying'
  expiry_cycle_type:
    1:
      id: 'daily'
      doc: 'Daily'
    2:
      id: 'weekly'
      doc: 'Weekly'
    3:
      id: 'monthly'
      doc: 'Monthly'
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
  quote_update_type:
    1:
      id: 'best_bid'
      doc: 'Best_Bid'
    2:
      id: 'best_offer'
      doc: 'Best_Offer'
    5:
      id: 'cancel_bid'
      doc: 'Cancel_Bid'
    6:
      id: 'cancel_offer'
      doc: 'Cancel_Offer'
  option_type:
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  efficient_mmt_market_mechanism:
    1:
      id: 'central_limit_order_book'
      doc: 'Central_Limit_Order_Book'
    2:
      id: 'quote_driven_market'
      doc: 'Quote_Driven_Market'
    3:
      id: 'dark_order_book'
      doc: 'Dark_Order_Book'
    4:
      id: 'off_bookincluding_voiceor_messaging_trading'
      doc: 'Off_Book_including_Voice_or_Messaging_Trading'
    5:
      id: 'periodic_auctionequal_uncrossing'
      doc: 'Periodic_Auction_equal_Uncrossing'
    6:
      id: 'requestfor_quotes'
      doc: 'Request_for_Quotes'
    7:
      id: 'other'
      doc: 'Other'
  efficient_mmt_trading_mode:
    0x31:
      id: 'undefined_auctionequal_uncrossing'
      doc: 'Undefined_Auction_equal_Uncrossing'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous_Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At_Market_Close_Trading'
    0x34:
      id: 'outof_main_session_trading'
      doc: 'Out_of_Main_Session_Trading'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'Trade_Reporting_On_Exchange'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'Trade_Reporting_Off_Exchange'
    0x37:
      id: 'trade_reporting_systematic_internaliser'
      doc: 'Trade_Reporting_Systematic_Internaliser'
    0x49:
      id: 'scheduled_intraday_auctionequal_uncrossing'
      doc: 'Scheduled_Intraday_Auction_equal_Uncrossing'
    0x4b:
      id: 'scheduled_closing_auctionequal_uncrossing'
      doc: 'Scheduled_Closing_Auction_equal_Uncrossing'
    0x4f:
      id: 'scheduled_opening_auctionequal_uncrossing'
      doc: 'Scheduled_Opening_Auction_equal_Uncrossing'
    0x55:
      id: 'unscheduled_auctionequal_uncrossing'
      doc: 'Unscheduled_Auction_equal_Uncrossing'
  efficient_mmt_transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark_Trade'
    0x52:
      id: 'rpri'
      doc: 'RPRI'
    0x59:
      id: 'xfph'
      doc: 'XFPH'
    0x5a:
      id: 'tpac'
      doc: 'TPAC'
    0x2d:
      id: 'noneapply'
      doc: 'None_apply'
  efficient_mmt_negotiation_indicator:
    0x31:
      id: 'nliq'
      doc: 'NLIQ'
    0x32:
      id: 'oilq'
      doc: 'OILQ'
    0x33:
      id: 'pric'
      doc: 'PRIC'
    0x34:
      id: 'ilqd'
      doc: 'ILQD'
    0x35:
      id: 'size'
      doc: 'SIZE'
    0x36:
      id: 'ilqd_size'
      doc: 'ILQD_SIZE'
    0x4e:
      id: 'negotiated_trade'
      doc: 'Negotiated_Trade'
    0x2d:
      id: 'no_negotiated_trade'
      doc: 'No_Negotiated_Trade'
  efficient_mmt_agency_cross_trade_indicator:
    0x58:
      id: 'actx'
      doc: 'ACTX'
    0x2d:
      id: 'no_agency_cross_trade'
      doc: 'No_Agency_Cross_Trade'
  efficient_mmt_modification_indicator:
    0x41:
      id: 'amnd'
      doc: 'AMND'
    0x43:
      id: 'canc'
      doc: 'CANC'
    0x2d:
      id: 'new_trade'
      doc: 'New_Trade'
  efficient_mmt_benchmark_indicator:
    0x42:
      id: 'benc'
      doc: 'BENC'
    0x53:
      id: 'rfpt'
      doc: 'RFPT'
    0x2d:
      id: 'no_benchmarkor_reference_price_trade'
      doc: 'No_Benchmark_or_Reference_Price_Trade'
  efficient_mmt_special_dividend_indicator:
    0x45:
      id: 'sdiv'
      doc: 'SDIV'
    0x2d:
      id: 'no_special_dividend_trade'
      doc: 'No_Special_Dividend_Trade'
  efficient_mmt_off_book_automated_indicator:
    0x4d:
      id: 'off_book_non_automated'
      doc: 'Off_Book_Non_Automated'
    0x51:
      id: 'off_book_automated'
      doc: 'Off_Book_Automated'
    0x2d:
      id: 'unspecifiedordoesnotapply'
      doc: 'Unspecified_or_does_not_apply'
  efficient_mmt_contributionto_price:
    0x4a:
      id: 'tncp'
      doc: 'TNCP'
    0x4e:
      id: 'pndg'
      doc: 'PNDG'
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'Plain_Vanilla_Trade'
    0x54:
      id: 'npft'
      doc: 'NPFT'
  efficient_mmt_algorithmic_indicator:
    0x48:
      id: 'algo'
      doc: 'ALGO'
    0x2d:
      id: 'no_algorithmic_trade'
      doc: 'No_Algorithmic_Trade'
  efficient_mmt_publication_mode:
    0x31:
      id: 'non_immediate_publication'
      doc: 'Non_Immediate_Publication'
    0x32:
      id: 'lrgs'
      doc: 'LRGS'
    0x33:
      id: 'ilqd'
      doc: 'ILQD'
    0x34:
      id: 'size'
      doc: 'SIZE'
    0x35:
      id: 'ilqd_size'
      doc: 'ILQD_SIZE'
    0x36:
      id: 'ilqd_lrgs'
      doc: 'ILQD_LRGS'
    0x2d:
      id: 'immediate_publication'
      doc: 'Immediate_Publication'
  efficient_mmt_post_trade_deferral:
    0x31:
      id: 'lmtf'
      doc: 'LMTF'
    0x32:
      id: 'datf'
      doc: 'DATF'
    0x33:
      id: 'volo'
      doc: 'VOLO'
    0x34:
      id: 'fwaf'
      doc: 'FWAF'
    0x35:
      id: 'idaf'
      doc: 'IDAF'
    0x36:
      id: 'volw'
      doc: 'VOLW'
    0x37:
      id: 'fulf'
      doc: 'FULF'
    0x38:
      id: 'fula'
      doc: 'FULA'
    0x39:
      id: 'fulv'
      doc: 'FULV'
    0x56:
      id: 'fulj'
      doc: 'FULJ'
    0x57:
      id: 'coaf'
      doc: 'COAF'
    0x2d:
      id: 'not_applicable'
      doc: 'Not_Applicable'
  efficient_mmt_duplicative_indicator:
    0x31:
      id: 'dupl'
      doc: 'DUPL'
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique_Trade_Report'
  opened_closed_fund:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
  gross_of_cdsc_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  tax_description_attaching_to_a_dividend:
    0x44:
      id: 'deducedat_source'
      doc: 'Deduced_at_Source'
  payment_frequency:
    1:
      id: 'annual'
      doc: 'Annual'
    2:
      id: 'semi_annual'
      doc: 'Semi_Annual'
    3:
      id: 'quarterly'
      doc: 'Quarterly'
    4:
      id: 'monthly'
      doc: 'Monthly'
    5:
      id: 'bi_monthly'
      doc: 'Bi_Monthly'
    6:
      id: 'daily'
      doc: 'Daily'
    7:
      id: 'migration_na'
      doc: 'Migration_NA'
    8:
      id: 'other'
      doc: 'Other'
  instrument_category:
    1:
      id: 'equities'
      doc: 'Equities'
    2:
      id: 'fixed_income'
      doc: 'Fixed_Income'
    3:
      id: 'warrants_and_certificates'
      doc: 'Warrants_And_Certificates'
    6:
      id: 'trackers'
      doc: 'Trackers'
    7:
      id: 'futures'
      doc: 'Futures'
    10:
      id: 'options'
      doc: 'Options'
    11:
      id: 'indices'
      doc: 'Indices'
    12:
      id: 'euronext_funds_services'
      doc: 'Euronext_Funds_Services'
    14:
      id: 'inav_indicative_net_asset_value'
      doc: 'iNAV_Indicative_Net_Asset_Value'
    15:
      id: 'fund'
      doc: 'Fund'
    254:
      id: 'miscellaneous'
      doc: 'Miscellaneous'
  security_condition:
    0x4f:
      id: 'normal'
      doc: 'Normal'
    0x44:
      id: 'ex_dividend'
      doc: 'Ex_Dividend'
    0x43:
      id: 'ex_cap'
      doc: 'Ex_Cap'
    0x52:
      id: 'ex_rights'
      doc: 'Ex_Rights'
    0x45:
      id: 'ex_entitlement'
      doc: 'Ex_Entitlement'
    0x53:
      id: 'dealingstemporarilysuspended'
      doc: 'Dealings_temporarily_suspended'
    0x4e:
      id: 'not_listed'
      doc: 'Not_Listed'

