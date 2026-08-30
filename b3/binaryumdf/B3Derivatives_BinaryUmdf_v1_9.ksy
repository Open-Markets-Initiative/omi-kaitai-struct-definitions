# ---------------------------------------------------------------------
# Kaitai struct definition for: B3 B3Derivatives BinaryUmdf Sbe v1.9
#
# Protocol:
#   Organization: Brasil, Bolsa, Balcão
#   Protocol: Binary Unified Market Data Feed
#   Encoding: Simple Binary Encoding
#   Version: 1.9
#   Date: 8/10/2024
#   Specification: BinaryUMDF-MessageReference-v.1.9.0-enUS.pdf
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
  id: b3_b3derivatives_binaryumdf_sbe_v1_9
  title: B3 B3Derivatives BinaryUmdf Sbe v1.9
  license: GPL-3.0
  endian: le

doc: 'Brasil, Bolsa, Balcão B3 Derivatives Binary Unified Market Data Feed Sbe v1.9'
doc-ref: https://www.b3.com.br/en_us/solutions/platforms/puma-trading-system/for-developers-and-vendors/binary-umdf

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'B3 Mdp Packet Header'
  - id: message
    type: message_struct
    repeat: eos
    doc: 'B3 Market Data Message'

types:
  packet_header_struct:
    seq:
      - id: channel_id
        type: u1
        doc: 'B3 Channel Id'
      - id: reserved
        type: u1
        doc: 'Packet Reserved Field'
      - id: sequence_version
        type: u2
        doc: 'Packet Sequence Version'
      - id: sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Packet Sending Time. Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: framing_header
        type: framing_header
        doc: 'B3 Sbe framing header'
      - id: message_header
        type: message_header
        doc: 'B3 Sbe message header — message identifiers and length of message root'
      - id: payload
        size: framing_header.message_length - 12
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::sequence_2_message': sequence_message
            'template_id::empty_book_9_message': empty_book_message
            'template_id::channel_reset_11_message': channel_reset_11_message
            'template_id::security_status_3_message': security_status_3_message
            'template_id::security_group_phase_10_message': security_group_phase_10_message
            'template_id::security_definition_message': security_definition_message
            'template_id::news_5_message': news_5_message
            'template_id::opening_price_15_message': opening_price_15_message
            'template_id::theoretical_opening_price_16_message': theoretical_opening_price_16_message
            'template_id::closing_price_17_message': closing_price_17_message
            'template_id::auction_imbalance_19_message': auction_imbalance_19_message
            'template_id::quantity_band_21_message': quantity_band_21_message
            'template_id::price_band_22_message': price_band_22_message
            'template_id::high_price_24_message': high_price_24_message
            'template_id::low_price_25_message': low_price_25_message
            'template_id::last_trade_price_27_message': last_trade_price_27_message
            'template_id::settlement_price_28_message': settlement_price_28_message
            'template_id::open_interest_29_message': open_interest_29_message
            'template_id::snapshot_full_refresh_header_30_message': snapshot_full_refresh_header_30_message
            'template_id::order_mb_o_50_message': order_mb_o_50_message
            'template_id::delete_order_mb_o_51_message': delete_order_mb_o_51_message
            'template_id::mass_delete_orders_mb_o_52_message': mass_delete_orders_mb_o_52_message
            'template_id::trade_53_message': trade_53_message
            'template_id::forward_trade_54_message': forward_trade_54_message
            'template_id::execution_summary_55_message': execution_summary_55_message
            'template_id::execution_statistics_56_message': execution_statistics_56_message
            'template_id::trade_bust_57_message': trade_bust_57_message
            'template_id::snapshot_full_refresh_orders_mb_o_71_message': snapshot_full_refresh_orders_mb_o_71_message
  framing_header:
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
  sequence_message:
    seq:
      - id: next_seq_no
        type: u4
        doc: 'nextSeqNo'
  empty_book_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_9_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
  match_event_indicator_match_event_indicator:
    seq:
      - id: unused_match_event_indicator_0
        type: b1
        doc: 'Unused MatchEventIndicator 0'
      - id: unused_match_event_indicator_1
        type: b1
        doc: 'Unused MatchEventIndicator 1'
      - id: unused_match_event_indicator_2
        type: b1
        doc: 'Unused MatchEventIndicator 2'
      - id: unused_match_event_indicator_3
        type: b1
        doc: 'Unused MatchEventIndicator 3'
      - id: implied
        type: b1
        doc: 'Implied'
      - id: recovery_msg
        type: b1
        doc: 'RecoveryMsg'
      - id: unused_match_event_indicator_6
        type: b1
        doc: 'Unused MatchEventIndicator 6'
      - id: end_of_event
        type: b1
        doc: 'EndOfEvent'
  channel_reset_11_message:
    seq:
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_1_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
  security_status_3_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'securityTradingStatus'
      - id: security_trading_event
        type: u1_nullable
        doc: 'securityTradingEvent. Nullable, No Value = 255'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: offset_14_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: trad_ses_open_time
        type: nanosecond_timestamp_nullable
        doc: 'tradSesOpenTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: transact_time
        type: u8
        doc: 'transactTime'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  security_group_phase_10_message:
    seq:
      - id: security_group
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityGroup'
      - id: offset_3_padding_5
        size: 5
        doc: '5 bytes padding'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        doc: 'tradingSessionSubID'
      - id: security_trading_event
        type: u1_nullable
        doc: 'securityTradingEvent. Nullable, No Value = 255'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: offset_14_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: trad_ses_open_time
        type: nanosecond_timestamp_nullable
        doc: 'tradSesOpenTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: transact_time
        type: u8
        doc: 'transactTime'
  security_definition_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'securityExchange'
      - id: security_id_source
        type: u1
        enum: security_id_source
        doc: 'securityIDSource'
      - id: security_group
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityGroup'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'symbol'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'securityUpdateAction'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'securityType'
      - id: security_sub_type
        type: u2
        doc: 'securitySubType'
      - id: tot_no_related_sym
        type: u4
        doc: 'totNoRelatedSym'
      - id: min_price_increment
        type: decimal_s8_8_nullable
        doc: 'minPriceIncrement. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: strike_price
        type: decimal_s8_4_nullable
        doc: 'strikePrice. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: contract_multiplier
        type: decimal_s8_8_nullable
        doc: 'contractMultiplier. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: price_divisor
        type: decimal_s8_8_nullable
        doc: 'priceDivisor. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: security_validity_timestamp
        type: s8
        doc: 'securityValidityTimestamp'
      - id: no_shares_issued
        type: u8
        doc: 'noSharesIssued'
      - id: clearing_house_id
        type: u8
        doc: 'clearingHouseID'
      - id: min_order_qty
        type: s8
        doc: 'minOrderQty'
      - id: max_order_qty
        type: s8
        doc: 'maxOrderQty'
      - id: min_lot_size
        type: s8
        doc: 'minLotSize'
      - id: min_trade_vol
        type: s8
        doc: 'minTradeVol'
      - id: corporate_action_event_id
        type: u4
        doc: 'corporateActionEventId'
      - id: issue_date
        type: s4
        doc: 'issueDate'
      - id: maturity_date
        type: s4_nullable
        doc: 'maturityDate. Nullable, No Value = 0'
      - id: country_of_issue
        type: str_2_nullable
        doc: 'countryOfIssue. Nullable, No Value = 0'
      - id: start_date
        type: s4_nullable
        doc: 'startDate. Nullable, No Value = 0'
      - id: end_date
        type: s4_nullable
        doc: 'endDate. Nullable, No Value = 0'
      - id: settl_type
        type: u2_nullable
        doc: 'settlType. Nullable, No Value = 65535'
      - id: settl_date
        type: s4_nullable
        doc: 'settlDate. Nullable, No Value = 0'
      - id: dated_date
        type: s4_nullable
        doc: 'datedDate. Nullable, No Value = 0'
      - id: isin_number
        type: str_12_nullable
        doc: 'isinNumber. Nullable, No Value = 0'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'asset'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'cfiCode'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'SecurityDefinition_12Message'
      - id: contract_settl_month
        type: contract_settl_month
        doc: 'SecurityDefinition_12Message'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'currency'
      - id: strike_currency
        type: str_3_nullable
        doc: 'strikeCurrency. Nullable, No Value = 0'
      - id: settl_currency
        type: str_3_nullable
        doc: 'settlCurrency. Nullable, No Value = 0'
      - id: security_strategy_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'securityStrategyType'
      - id: lot_type
        type: u1_nullable
        doc: 'lotType. Nullable, No Value = 255'
      - id: tick_size_denominator
        type: u1_nullable
        doc: 'tickSizeDenominator. Nullable, No Value = 255'
      - id: product
        type: u1
        enum: product
        doc: 'product'
      - id: exercise_style
        type: u1_nullable
        doc: 'exerciseStyle. Nullable, No Value = 255'
      - id: put_or_call
        type: u1_nullable
        doc: 'putOrCall. Nullable, No Value = 255'
      - id: price_type_price_type_optional
        type: u1_nullable
        doc: 'priceType. Nullable, No Value = 0'
      - id: market_segment_id
        type: u1
        doc: 'marketSegmentID'
      - id: governance_indicator
        type: u1_nullable
        doc: 'governanceIndicator. Nullable, No Value = 255'
      - id: security_match_type
        type: u1_nullable
        doc: 'securityMatchType. Nullable, No Value = 255'
      - id: last_fragment
        type: u1_nullable
        doc: 'lastFragment. Nullable, No Value = 255'
      - id: multi_leg_model
        type: u1_nullable
        doc: 'multiLegModel. Nullable, No Value = 255'
      - id: multi_leg_price_method
        type: u1_nullable
        doc: 'multiLegPriceMethod. Nullable, No Value = 255'
      - id: min_cross_qty
        type: s8
        doc: 'minCrossQty'
      - id: implied_market_indicator
        type: u1_nullable
        doc: 'impliedMarketIndicator. Nullable, No Value = 255'
      - id: underlyings_groups
        type: underlyings_groups
        doc: 'noUnderlyings Block'
      - id: legs_groups
        type: legs_groups
        doc: 'noLegs Block'
      - id: instr_attribs_groups
        type: instr_attribs_groups
        doc: 'noInstrAttribs Block'
      - id: security_desc
        type: security_desc
        doc: 'securityDesc data struct'
  maturity_month_year:
    seq:
      - id: year
        type: u2
        doc: 'year'
      - id: month
        type: u1
        doc: 'month'
      - id: day
        type: u1
        doc: 'day'
      - id: week
        type: u1
        doc: 'week'
  contract_settl_month:
    seq:
      - id: year
        type: u2
        doc: 'year'
      - id: month
        type: u1
        doc: 'month'
      - id: day
        type: u1
        doc: 'day'
      - id: week
        type: u1
        doc: 'week'
  underlyings_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: underlyings_group
        type: underlyings_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noUnderlyings'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  underlyings_group:
    seq:
      - id: underlying_security_id
        type: u8
        doc: 'Underlying instrument''s security ID'
      - id: underlying_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying instrument''s ticker symbol'
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
      - id: leg_security_id
        type: u8
        doc: 'Leg''s security ID'
      - id: leg_ratio_qty
        type: decimal_s8_7
        doc: 'Ratio of quantity for this leg relative to the entire security. Implied decimal with scale 1e-7'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'Leg''s security type'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Side of this leg'
      - id: leg_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Leg symbol'
  instr_attribs_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: instr_attribs_group
        type: instr_attribs_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noInstrAttribs'
  instr_attribs_group:
    seq:
      - id: instr_attrib_type
        type: u1
        enum: instr_attrib_type
        doc: 'Code to represent the type of instrument attributes'
      - id: instr_attrib_value
        type: u1
        enum: instr_attrib_value
        doc: 'Attribute value appropriate to the InstrAttribType (871) field'
  security_desc:
    seq:
      - id: len_security_desc_data
        type: u1
        doc: 'Length in bytes of the security description text'
      - id: security_desc_data
        type: str
        size: len_security_desc_data
        encoding: ASCII
        doc: 'textual description for the financial instrument'
  news_5_message:
    seq:
      - id: security_id_optional
        type: u8_nullable
        doc: 'Security Id as defined by B3. For the Security Id list, see the Security Definition message in the market data feed. Nullable, No Value = 0'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: news_source
        type: u1
        enum: news_source
        doc: 'newsSource'
      - id: language_code
        type: str_2_nullable
        doc: 'languageCode. Nullable, No Value = 0'
      - id: part_count
        type: u2
        doc: 'partCount'
      - id: part_number
        type: u2
        doc: 'partNumber'
      - id: news_id
        type: u8
        doc: 'newsID'
      - id: orig_time
        type: nanosecond_timestamp_nullable
        doc: 'origTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: total_text_length
        type: u4
        doc: 'totalTextLength'
      - id: headline
        type: headline
        doc: 'headline data struct'
      - id: text
        type: text
        doc: 'text data struct'
      - id: url_link
        type: url_link
        doc: 'uRLLink data struct'
  headline:
    seq:
      - id: len_headline_data
        type: u2
        doc: 'Length of a string, in bytes. For instance, the string ''Ação'', converted to UTF-8, has 6 bytes, so length = 6'
      - id: headline_data
        type: u1
        doc: 'Bytes of the string, encoded in UTF-8'
  text:
    seq:
      - id: len_text_data
        type: u2
        doc: 'Length of a string, in bytes. For instance, the string ''Ação'', converted to UTF-8, has 6 bytes, so length = 6'
      - id: text_data
        type: u1
        doc: 'Bytes of the string, encoded in UTF-8'
  url_link:
    seq:
      - id: len_url_link_data
        type: u2
        doc: 'Length of a string, in bytes. For instance, the string ''Ação'', converted to UTF-8, has 6 bytes, so length = 6'
      - id: url_link_data
        type: u1
        doc: 'Bytes of the string, encoded in UTF-8'
  opening_price_15_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'openCloseSettlFlag'
      - id: offset_11_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: net_chg_prev_day
        type: decimal_s8_8_nullable
        doc: 'netChgPrevDay. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  theoretical_opening_price_16_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_corporate_offset_price_optional
        type: decimal_s8_4_nullable
        doc: 'mDEntryPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: md_entry_size_quantity_optional
        type: s8_nullable
        doc: 'mDEntrySize. Nullable, No Value = -9223372036854775808'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  closing_price_17_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'openCloseSettlFlag'
      - id: offset_10_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: md_corporate_price
        type: decimal_s8_8
        doc: 'mDEntryPx. Implied decimal with scale 1e-8'
      - id: last_trade_date
        type: u2_nullable
        doc: 'lastTradeDate. Nullable, No Value = 0'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  auction_imbalance_19_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: imbalance_condition
        type: imbalance_condition
        doc: 'ImbalanceCondition bit set'
      - id: md_entry_size_quantity_optional
        type: s8_nullable
        doc: 'mDEntrySize. Nullable, No Value = -9223372036854775808'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  imbalance_condition:
    seq:
      - id: unused_imbalance_condition_0
        type: b1
        doc: 'Unused ImbalanceCondition 0'
      - id: unused_imbalance_condition_1
        type: b1
        doc: 'Unused ImbalanceCondition 1'
      - id: unused_imbalance_condition_2
        type: b1
        doc: 'Unused ImbalanceCondition 2'
      - id: unused_imbalance_condition_3
        type: b1
        doc: 'Unused ImbalanceCondition 3'
      - id: unused_imbalance_condition_4
        type: b1
        doc: 'Unused ImbalanceCondition 4'
      - id: unused_imbalance_condition_5
        type: b1
        doc: 'Unused ImbalanceCondition 5'
      - id: unused_imbalance_condition_6
        type: b1
        doc: 'Unused ImbalanceCondition 6'
      - id: unused_imbalance_condition_7
        type: b1
        doc: 'Unused ImbalanceCondition 7'
      - id: imbalance_more_buyers
        type: b1
        doc: 'ImbalanceMoreBuyers'
      - id: imbalance_more_sellers
        type: b1
        doc: 'ImbalanceMoreSellers'
      - id: reserved_6
        type: b6
        doc: '6 reserved bits'
  quantity_band_21_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_9_padding_3
        size: 3
        doc: '3 bytes padding'
      - id: avg_daily_traded_qty
        type: s8
        doc: 'avgDailyTradedQty'
      - id: max_trade_vol
        type: s8
        doc: 'maxTradeVol'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  price_band_22_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: price_band_type
        type: u1_nullable
        doc: 'priceBandType. Nullable, No Value = 255'
      - id: price_limit_type
        type: u1_nullable
        doc: 'priceLimitType. Nullable, No Value = 255'
      - id: price_band_midpoint_price_type
        type: u1_nullable
        doc: 'priceBandMidpointPriceType. Nullable, No Value = 255'
      - id: low_limit_price
        type: decimal_s8_4_nullable
        doc: 'lowLimitPrice. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: high_limit_price
        type: decimal_s8_4_nullable
        doc: 'highLimitPrice. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: trading_reference_price
        type: decimal_s8_8_nullable
        doc: 'tradingReferencePrice. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  high_price_24_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  low_price_25_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  last_trade_price_27_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: trade_condition
        type: trade_condition
        doc: 'TradeCondition bit set'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: md_entry_buyer
        type: u4
        doc: 'mDEntryBuyer'
      - id: md_entry_seller
        type: u4
        doc: 'mDEntrySeller'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: seller_days
        type: u2
        doc: 'sellerDays'
      - id: md_entry_interest_rate
        type: decimal_s8_4_nullable
        doc: 'mDEntryInterestRate. Implied decimal with scale 1e-4. Nullable, No Value = 0'
      - id: trd_sub_type
        type: u1_nullable
        doc: 'trdSubType. Nullable, No Value = 0'
      - id: padding_3
        size: 3
        doc: '3 bytes padding'
  trade_condition:
    seq:
      - id: opening_price
        type: b1
        doc: 'OpeningPrice'
      - id: crossed
        type: b1
        doc: 'Crossed'
      - id: last_trade_at_the_same_price
        type: b1
        doc: 'LastTradeAtTheSamePrice'
      - id: out_of_sequence
        type: b1
        doc: 'OutOfSequence'
      - id: unused_trade_condition_4
        type: b1
        doc: 'Unused TradeCondition 4'
      - id: unused_trade_condition_5
        type: b1
        doc: 'Unused TradeCondition 5'
      - id: trade_on_behalf
        type: b1
        doc: 'TradeOnBehalf'
      - id: unused_trade_condition_7
        type: b1
        doc: 'Unused TradeCondition 7'
      - id: unused_trade_condition_8
        type: b1
        doc: 'Unused TradeCondition 8'
      - id: unused_trade_condition_9
        type: b1
        doc: 'Unused TradeCondition 9'
      - id: unused_trade_condition_10
        type: b1
        doc: 'Unused TradeCondition 10'
      - id: unused_trade_condition_11
        type: b1
        doc: 'Unused TradeCondition 11'
      - id: unused_trade_condition_12
        type: b1
        doc: 'Unused TradeCondition 12'
      - id: regular_trade
        type: b1
        doc: 'RegularTrade'
      - id: block_trade
        type: b1
        doc: 'BlockTrade'
      - id: unused_trade_condition_15
        type: b1
        doc: 'Unused TradeCondition 15'
  settlement_price_28_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_9_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'openCloseSettlFlag'
      - id: price_type_price_type
        type: u1
        enum: price_type_price_type
        doc: 'priceType'
      - id: settl_price_type
        type: u1
        enum: settl_price_type
        doc: 'settlPriceType'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: padding_1
        size: 1
        doc: '1 bytes padding'
  open_interest_29_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_9_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  snapshot_full_refresh_header_30_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'lastMsgSeqNumProcessed'
      - id: tot_num_reports
        type: u4
        doc: 'totNumReports'
      - id: tot_num_bids
        type: u4
        doc: 'totNumBids'
      - id: tot_num_offers
        type: u4
        doc: 'totNumOffers'
      - id: tot_num_stats
        type: u2
        doc: 'totNumStats'
      - id: offset_26_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: last_rpt_seq
        type: u4
        doc: 'lastRptSeq'
  order_mb_o_50_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'mDEntryType'
      - id: offset_11_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_corporate_offset_price_optional
        type: decimal_s8_4_nullable
        doc: 'mDEntryPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: md_entry_position_no
        type: u4
        doc: 'mDEntryPositionNo'
      - id: entering_firm
        type: u4
        doc: 'enteringFirm'
      - id: md_insert_timestamp
        type: nanosecond_timestamp
        doc: 'mDInsertTimestamp. Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
  delete_order_mb_o_51_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: offset_9_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'mDEntryType'
      - id: offset_11_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_entry_position_no
        type: u4
        doc: 'mDEntryPositionNo'
      - id: md_entry_size_quantity_optional
        type: s8_nullable
        doc: 'mDEntrySize. Nullable, No Value = -9223372036854775808'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  mass_delete_orders_mb_o_52_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'mDUpdateAction'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'mDEntryType'
      - id: offset_11_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_entry_position_no
        type: u4
        doc: 'mDEntryPositionNo'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  trade_53_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: trade_condition
        type: trade_condition
        doc: 'TradeCondition bit set'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: md_entry_buyer
        type: u4
        doc: 'mDEntryBuyer'
      - id: md_entry_seller
        type: u4
        doc: 'mDEntrySeller'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: trd_sub_type
        type: u1_nullable
        doc: 'trdSubType. Nullable, No Value = 0'
      - id: offset_43_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  forward_trade_54_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: trade_condition
        type: trade_condition
        doc: 'TradeCondition bit set'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: md_entry_buyer
        type: u4
        doc: 'mDEntryBuyer'
      - id: md_entry_seller
        type: u4
        doc: 'mDEntrySeller'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: seller_days
        type: u2
        doc: 'sellerDays'
      - id: md_entry_interest_rate
        type: decimal_s8_4_nullable
        doc: 'mDEntryInterestRate. Implied decimal with scale 1e-4. Nullable, No Value = 0'
      - id: trd_sub_type
        type: u1_nullable
        doc: 'trdSubType. Nullable, No Value = 0'
      - id: padding_3
        size: 3
        doc: '3 bytes padding'
  execution_summary_55_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: offset_8_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'aggressorSide'
      - id: offset_11_padding_1
        size: 1
        doc: '1 bytes padding'
      - id: last_px
        type: decimal_s8_4
        doc: 'lastPx. Implied decimal with scale 1e-4'
      - id: fill_qty
        type: s8
        doc: 'fillQty'
      - id: traded_hidden_qty
        type: s8
        doc: 'tradedHiddenQty'
      - id: cxl_qty
        type: s8
        doc: 'cxlQty'
      - id: aggressor_time
        type: nanosecond_timestamp
        doc: 'aggressorTime. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
  execution_statistics_56_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: trade_volume
        type: s8
        doc: 'tradeVolume'
      - id: vwap_px
        type: decimal_s8_4_nullable
        doc: 'vwapPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: net_chg_prev_day
        type: decimal_s8_8_nullable
        doc: 'netChgPrevDay. Implied decimal with scale 1e-8. Nullable, No Value = -9223372036854775808'
      - id: number_of_trades
        type: u4
        doc: 'numberOfTrades'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  trade_bust_57_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: match_event_indicator_match_event_indicator
        type: match_event_indicator_match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'tradingSessionID'
      - id: offset_10_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: md_future_price
        type: decimal_s8_4
        doc: 'mDEntryPx. Implied decimal with scale 1e-4'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: trade_id
        type: u4
        doc: 'tradeID'
      - id: trade_date
        type: u2
        doc: 'tradeDate'
      - id: offset_34_padding_2
        size: 2
        doc: '2 bytes padding'
      - id: md_entry_timestamp
        type: nanosecond_timestamp
        doc: 'mDEntryTimestamp. Nanoseconds since Unix epoch'
      - id: rpt_seq
        type: u4
        doc: 'rptSeq'
  snapshot_full_refresh_orders_mb_o_71_message:
    seq:
      - id: security_id
        type: u8
        doc: 'securityID'
      - id: snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_groups
        type: snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_groups
        doc: 'noMDEntries Block'
  snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'GroupSizeEncoding'
      - id: snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_group
        type: snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'noMDEntries'
  snapshot_full_refresh_orders_mb_o_71_message_no_m_d_entries_group:
    seq:
      - id: md_corporate_offset_price_optional
        type: decimal_s8_4_nullable
        doc: 'mDEntryPx. Implied decimal with scale 1e-4. Nullable, No Value = -9223372036854775808'
      - id: md_entry_size_quantity
        type: s8
        doc: 'mDEntrySize'
      - id: md_entry_position_no
        type: u4
        doc: 'mDEntryPositionNo'
      - id: entering_firm
        type: u4
        doc: 'enteringFirm'
      - id: md_insert_timestamp
        type: nanosecond_timestamp
        doc: 'mDInsertTimestamp. Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        doc: 'secondaryOrderID'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'mDEntryType'
      - id: match_event_indicator_match_event_indicator_optional
        type: match_event_indicator_match_event_indicator_optional
        doc: 'MatchEventIndicator bit set. Nullable, No Value = 255'
  match_event_indicator_match_event_indicator_optional:
    seq:
      - id: unused_match_event_indicator_0
        type: b1
        doc: 'Unused MatchEventIndicator 0'
      - id: unused_match_event_indicator_1
        type: b1
        doc: 'Unused MatchEventIndicator 1'
      - id: unused_match_event_indicator_2
        type: b1
        doc: 'Unused MatchEventIndicator 2'
      - id: unused_match_event_indicator_3
        type: b1
        doc: 'Unused MatchEventIndicator 3'
      - id: implied
        type: b1
        doc: 'Implied'
      - id: recovery_msg
        type: b1
        doc: 'RecoveryMsg'
      - id: unused_match_event_indicator_6
        type: b1
        doc: 'Unused MatchEventIndicator 6'
      - id: end_of_event
        type: b1
        doc: 'EndOfEvent'
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
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 0
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
  str_2_nullable:
    seq:
      - id: value
        size: 2
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  str_12_nullable:
    seq:
      - id: value
        size: 12
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
  decimal_s8_7:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000.0
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808

enums:
  template_id:
    1:
      id: 'sequence_reset_1_message'
      doc: 'SequenceReset_1Message'
    2:
      id: 'sequence_2_message'
      doc: 'Sequence_2Message'
    9:
      id: 'empty_book_9_message'
      doc: 'EmptyBook_9Message'
    11:
      id: 'channel_reset_11_message'
      doc: 'ChannelReset_11Message'
    3:
      id: 'security_status_3_message'
      doc: 'SecurityStatus_3Message'
    10:
      id: 'security_group_phase_10_message'
      doc: 'SecurityGroupPhase_10Message'
    12:
      id: 'security_definition_message'
      doc: 'SecurityDefinition_12Message'
    5:
      id: 'news_5_message'
      doc: 'News_5Message'
    15:
      id: 'opening_price_15_message'
      doc: 'OpeningPrice_15Message'
    16:
      id: 'theoretical_opening_price_16_message'
      doc: 'TheoreticalOpeningPrice_16Message'
    17:
      id: 'closing_price_17_message'
      doc: 'ClosingPrice_17Message'
    19:
      id: 'auction_imbalance_19_message'
      doc: 'AuctionImbalance_19Message'
    21:
      id: 'quantity_band_21_message'
      doc: 'QuantityBand_21Message'
    22:
      id: 'price_band_22_message'
      doc: 'PriceBand_22Message'
    24:
      id: 'high_price_24_message'
      doc: 'HighPrice_24Message'
    25:
      id: 'low_price_25_message'
      doc: 'LowPrice_25Message'
    27:
      id: 'last_trade_price_27_message'
      doc: 'LastTradePrice_27Message'
    28:
      id: 'settlement_price_28_message'
      doc: 'SettlementPrice_28Message'
    29:
      id: 'open_interest_29_message'
      doc: 'OpenInterest_29Message'
    30:
      id: 'snapshot_full_refresh_header_30_message'
      doc: 'SnapshotFullRefresh_Header_30Message'
    50:
      id: 'order_mb_o_50_message'
      doc: 'Order_MBO_50Message'
    51:
      id: 'delete_order_mb_o_51_message'
      doc: 'DeleteOrder_MBO_51Message'
    52:
      id: 'mass_delete_orders_mb_o_52_message'
      doc: 'MassDeleteOrders_MBO_52Message'
    53:
      id: 'trade_53_message'
      doc: 'Trade_53Message'
    54:
      id: 'forward_trade_54_message'
      doc: 'ForwardTrade_54Message'
    55:
      id: 'execution_summary_55_message'
      doc: 'ExecutionSummary_55Message'
    56:
      id: 'execution_statistics_56_message'
      doc: 'ExecutionStatistics_56Message'
    57:
      id: 'trade_bust_57_message'
      doc: 'TradeBust_57Message'
    71:
      id: 'snapshot_full_refresh_orders_mb_o_71_message'
      doc: 'SnapshotFullRefresh_Orders_MBO_71Message'
  trading_session_id:
    1:
      id: 'regular_trading_session'
      doc: 'TradingSessionID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'non_regular_trading_session'
      doc: 'TradingSessionID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_trading_status:
    2:
      id: 'pause'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'close'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'open'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'forbidden'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'unknown_or_invalid'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'reserved'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'final_closing_call'
      doc: 'SecurityTradingStatus Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_trading_event:
    4:
      id: 'trading_session_change'
      doc: 'SecurityTradingEvent Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'security_status_change'
      doc: 'SecurityTradingEvent Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'security_rejoins_security_group_status'
      doc: 'SecurityTradingEvent Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
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
      id: 'forbidden'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'unknown_or_invalid'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    21:
      id: 'reserved'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'final_closing_call'
      doc: 'TradingSessionSubID Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_id_source:
    0x34:
      id: 'isin'
      doc: 'SecurityIDSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'exchange_symbol'
      doc: 'SecurityIDSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_update_action:
    0x41:
      id: 'add'
      doc: 'SecurityUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'delete_field'
      doc: 'SecurityUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4d:
      id: 'modify'
      doc: 'SecurityUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_type:
    1:
      id: 'cash'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'corp'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cs'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'dterm'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'etf'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'forward'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'fut'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'index'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'indexopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'mleg'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'opt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'optexer'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'ps'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'secloan'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'sopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'spot'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  lot_type:
    1:
      id: 'odd_lot'
      doc: 'LotType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'round_lot'
      doc: 'LotType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'block_lot'
      doc: 'LotType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  product:
    2:
      id: 'commodity'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'corporate'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'currency'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'equity'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'government'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'index'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'economic_indicator'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'multileg'
      doc: 'Product Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exercise_style:
    0:
      id: 'european'
      doc: 'ExerciseStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'american'
      doc: 'ExerciseStyle Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  put_or_call:
    0:
      id: 'put'
      doc: 'PutOrCall Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'call'
      doc: 'PutOrCall Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_type_price_type_optional:
    1:
      id: 'percentage'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'pu'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fixed_amount'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  governance_indicator:
    0:
      id: 'no_field'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'n_1'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'n_2'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'nm'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'ma'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'mb'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'm_2'
      doc: 'GovernanceIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  security_match_type:
    8:
      id: 'issuing_buy_back_auction'
      doc: 'SecurityMatchType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  last_fragment:
    0:
      id: 'false_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'true_value'
      doc: 'Boolean Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  multi_leg_model:
    0:
      id: 'predefined'
      doc: 'MultiLegModel Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'user_defined'
      doc: 'MultiLegModel Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  multi_leg_price_method:
    0:
      id: 'net_price'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'reversed_net_price'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'yield_difference'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'individual'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'contract_weighted_average_price'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'multiplied_price'
      doc: 'MultiLegPriceMethod Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  implied_market_indicator:
    0:
      id: 'not_implied'
      doc: 'ImpliedMarketIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'implied'
      doc: 'ImpliedMarketIndicator Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_security_type:
    1:
      id: 'cash'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'corp'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cs'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'dterm'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'etf'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'fopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'forward'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'fut'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'index'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'indexopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'mleg'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'opt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'optexer'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'ps'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'secloan'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'sopt'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'spot'
      doc: 'SecurityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  leg_side:
    1:
      id: 'buy'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'Side Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instr_attrib_type:
    24:
      id: 'trade_type_eligibility'
      doc: 'InstrAttribType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    34:
      id: 'gtd_gtc_eligibility'
      doc: 'InstrAttribType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  instr_attrib_value:
    1:
      id: 'electronic_match_or_gtd_gtc_eligible'
      doc: 'InstrAttribValue Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'order_cross_eligible'
      doc: 'InstrAttribValue Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'block_trade_eligible'
      doc: 'InstrAttribValue Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'flag_rfq_for_cross_eligible'
      doc: 'InstrAttribValue Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'negotiated_quote_eligible'
      doc: 'InstrAttribValue Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  news_source:
    0:
      id: 'other'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'dcm'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'bbmnet'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'market_surveillance'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'internet'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'dpr_ve'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'mkt_ops_fx_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'mkt_ops_derivatives_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'over_the_counter_news_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'electronic_purchase_exchange'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'cblc_news_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'bovespa_index_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'bovespa_institutional_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'mkt_ops_equities_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'bovespa_companies_agency'
      doc: 'NewsSource Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  md_update_action:
    0:
      id: 'new_field'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'change'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'delete_field'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'delete_thru'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'delete_from'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'overlay'
      doc: 'MDUpdateAction Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  open_close_settl_flag:
    0:
      id: 'daily'
      doc: 'OpenCloseSettlFlag Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'session'
      doc: 'OpenCloseSettlFlag Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'expected_entry'
      doc: 'OpenCloseSettlFlag Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'entry_from_previous_business_day'
      doc: 'OpenCloseSettlFlag Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'theoretical_price'
      doc: 'OpenCloseSettlFlag Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_band_type:
    1:
      id: 'hard_limit'
      doc: 'PriceBandType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'auction_limits'
      doc: 'PriceBandType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'rejection_band'
      doc: 'PriceBandType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'static_limits'
      doc: 'PriceBandType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_limit_type:
    0:
      id: 'price_unit'
      doc: 'PriceLimitType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'ticks'
      doc: 'PriceLimitType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'percentage'
      doc: 'PriceLimitType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_band_midpoint_price_type:
    0:
      id: 'last_traded_price'
      doc: 'PriceBandMidpointPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'complementary_last_price'
      doc: 'PriceBandMidpointPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'theoretical_price'
      doc: 'PriceBandMidpointPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  trd_sub_type:
    101:
      id: 'multi_asset_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'leg_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'midpoint_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'block_book_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'rf_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'rlp_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'tac_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'taa_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'sweep_trade'
      doc: 'TrdSubType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  price_type_price_type:
    1:
      id: 'percentage'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'pu'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'fixed_amount'
      doc: 'PriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  settl_price_type:
    1:
      id: 'final_field'
      doc: 'SettlPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'theoretical'
      doc: 'SettlPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'updated'
      doc: 'SettlPriceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'offer'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'trade'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'index_value'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'opening_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'closing_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'settlement_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x37:
      id: 'session_high_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'session_low_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x39:
      id: 'execution_statistics'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'imbalance'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x42:
      id: 'trade_volume'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'open_interest'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x4a:
      id: 'empty_book'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x63:
      id: 'security_trading_state_phase'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x67:
      id: 'price_band'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x68:
      id: 'quantity_band'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x44:
      id: 'composite_underlying_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x73:
      id: 'execution_summary'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x76:
      id: 'volatility_price'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x75:
      id: 'trade_bust'
      doc: 'MDEntryType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  aggressor_side:
    0:
      id: 'no_aggressor'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'buy'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'sell'
      doc: 'AggressorSide Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'

