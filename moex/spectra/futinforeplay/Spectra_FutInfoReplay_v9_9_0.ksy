# ---------------------------------------------------------------------
# Kaitai struct definition for: Moex Spectra FutInfoReplay Simba v9.9.0
#
# Protocol:
#   Organization: Moscow Exchange
#   Protocol: SIMBA Spectra Futures Instrument Replay
#   Encoding: SIMBA
#   Version: 9.9.0
#   Date: 07/16/2026
#   Specification: MOEX Spectra SIMBA Market Data (SBE) (9.9.0).pdf
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
  id: moex_spectra_futinforeplay_simba_v9_9_0
  title: Moex Spectra FutInfoReplay Simba v9.9.0
  license: GPL-3.0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market SIMBA Spectra Futures Instrument Replay Simba v9.9.0'
doc-ref: https://ftp.moex.com/pub/SIMBA/Spectra/

seq:
  - id: market_data_packet_header
    type: market_data_packet_header_struct
    doc: 'MarketDataDummyMessage'
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Moex Simba Market Data Message'

types:
  market_data_packet_header_struct:
    seq:
      - id: msg_seq_num
        type: u4
        doc: 'MsgSeqNum'
      - id: msg_size
        type: u2
        doc: 'MsgSize'
      - id: msg_flags
        type: msg_flags
        doc: 'Message flags, least significant bit first, as the schema''s MsgFlagsSet declares them'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'SendingTime. Nanoseconds since Unix epoch'
  msg_flags:
    meta:
      bit-endian: le
    seq:
      - id: last_fragment
        type: b1
        doc: 'LastFragment'
      - id: start_of_snapshot
        type: b1
        doc: 'StartOfSnapshot'
      - id: end_of_snapshot
        type: b1
        doc: 'EndOfSnapshot'
      - id: incremental_packet
        type: b1
        doc: 'IncrementalPacket'
      - id: poss_dup_flag
        type: b1
        doc: 'PossDupFlag'
      - id: reserved_bits
        type: b11
        doc: 'Bits the schema''s MsgFlagsSet leaves unused'
  message_struct:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Root block length, message template id, message schema id and schema version'
      - id: payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::sequence_reset_message': sequence_reset_message
            'template_id::security_definition_message': security_definition_message
            'template_id::trading_session_status_message': trading_session_status_message
            'template_id::discrete_auction_message': discrete_auction_message
            'template_id::security_group_status_message': security_group_status_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Message template identifier'
      - id: schema_id
        type: u2
        doc: 'Message schema identifier'
      - id: version
        type: u2
        doc: 'Message schema version'
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'NewSeqNo'
      - id: block_extension
        size: _parent.sbe_header.block_length - 4
        doc: 'Bytes the stated block holds beyond the 4 this version reads'
  security_definition_message:
    seq:
      - id: tot_num_reports
        type: u4
        doc: 'TotNumReports'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Symbol'
      - id: security_id
        type: s4
        doc: 'SecurityID'
      - id: security_alt_id
        type: str
        size: 25
        encoding: ASCII
        doc: 'SecurityAltID'
      - id: security_alt_id_source
        type: u1
        enum: security_alt_id_source
        doc: 'SecurityAltIDSource'
      - id: security_type
        type: str
        size: 4
        encoding: ASCII
        doc: 'SecurityType'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFICode'
      - id: strike_price
        type: decimal_s8_5_nullable
        doc: 'StrikePrice. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: contract_multiplier
        type: s4_nullable
        doc: 'ContractMultiplier. Nullable, No Value = -2147483648'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'SecurityTradingStatus'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency'
      - id: market_segment_id
        type: u1
        enum: market_segment_id
        doc: 'MarketSegmentID'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'TradingSessionID'
      - id: exchange_trading_session_id_int_32_null_optional
        type: s4_nullable
        doc: 'ExchangeTradingSessionID. Nullable, No Value = -2147483648'
      - id: volatility
        type: decimal_s8_5_nullable
        doc: 'Volatility. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: high_limit_px
        type: decimal_s8_5_nullable
        doc: 'HighLimitPx. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: low_limit_px
        type: decimal_s8_5_nullable
        doc: 'LowLimitPx. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment
        type: decimal_s8_5_nullable
        doc: 'MinPriceIncrement. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment_amount
        type: decimal_s8_5_nullable
        doc: 'MinPriceIncrementAmount. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: initial_margin_on_buy
        type: decimal_s8_2_nullable
        doc: 'InitialMarginOnBuy. Implied decimal with scale 1e-2. Nullable, No Value = 9223372036854775807'
      - id: initial_margin_on_sell
        type: decimal_s8_2_nullable
        doc: 'InitialMarginOnSell. Implied decimal with scale 1e-2. Nullable, No Value = 9223372036854775807'
      - id: initial_margin_syntetic
        type: decimal_s8_2_nullable
        doc: 'InitialMarginSyntetic. Implied decimal with scale 1e-2. Nullable, No Value = 9223372036854775807'
      - id: theor_price
        type: decimal_s8_5_nullable
        doc: 'TheorPrice. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: theor_price_limit
        type: decimal_s8_5_nullable
        doc: 'TheorPriceLimit. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: underlying_qty
        type: decimal_s8_5_nullable
        doc: 'UnderlyingQty. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'UnderlyingCurrency'
      - id: flags
        type: flags
        doc: 'FlagsSet bit set'
      - id: min_price_increment_amount_curr
        type: decimal_s8_5_nullable
        doc: 'MinPriceIncrementAmountCurr. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: settl_price_open
        type: decimal_s8_5_nullable
        doc: 'SettlPriceOpen. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: valuation_method
        type: str
        size: 4
        encoding: ASCII
        doc: 'ValuationMethod'
      - id: risk_free_rate
        size: 8
        doc: 'RiskFreeRate. Nullable, No Value = NaN'
      - id: fixed_spot_discount
        size: 8
        doc: 'FixedSpotDiscount. Nullable, No Value = NaN'
      - id: projected_spot_discount
        size: 8
        doc: 'ProjectedSpotDiscount. Nullable, No Value = NaN'
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'SettlCurrency'
      - id: negative_prices
        type: u1
        enum: negative_prices
        doc: 'NegativePrices'
      - id: derivative_contract_multiplier
        type: s4_nullable
        doc: 'DerivativeContractMultiplier. Nullable, No Value = -2147483648'
      - id: interest_rate_risk_up
        size: 8
        doc: 'InterestRateRiskUp. Nullable, No Value = NaN'
      - id: interest_rate_risk_down
        size: 8
        doc: 'InterestRateRiskDown. Nullable, No Value = NaN'
      - id: risk_free_rate_2
        size: 8
        doc: 'RiskFreeRate2. Nullable, No Value = NaN'
      - id: interest_rate_2_risk_up
        size: 8
        doc: 'InterestRate2RiskUp. Nullable, No Value = NaN'
      - id: interest_rate_2_risk_down
        size: 8
        doc: 'InterestRate2RiskDown. Nullable, No Value = NaN'
      - id: settl_price
        type: decimal_s8_5_nullable
        doc: 'SettlPrice. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: trade_mode_id
        type: s4
        doc: 'TradeModeID'
      - id: group_mask_int_64
        type: s8
        doc: 'GroupMask'
      - id: section_id_int_32
        type: s4
        doc: 'SectionID'
      - id: base_contract_id_int_32
        type: s4
        doc: 'BaseContractID'
      - id: trade_period_access
        type: trade_period_access
        doc: 'TradePeriodAccessSet bit set'
      - id: high_limit_px_weekend
        type: decimal_s8_5_nullable
        doc: 'HighLimitPxWeekend. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: low_limit_px_weekend
        type: decimal_s8_5_nullable
        doc: 'LowLimitPxWeekend. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: clearing_settl_price
        type: decimal_s8_5_nullable
        doc: 'ClearingSettlPrice. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: block_extension
        size: _parent.sbe_header.block_length - 342
        doc: 'Bytes the stated block holds beyond the 342 this version reads'
      - id: security_definition_message_no_m_d_feed_types_groups
        type: security_definition_message_no_m_d_feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: security_definition_message_no_underlyings_groups
        type: security_definition_message_no_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: security_definition_message_no_legs_groups
        type: security_definition_message_no_legs_groups
        doc: 'NoLegs Block'
      - id: security_definition_message_no_instr_attrib_groups
        type: security_definition_message_no_instr_attrib_groups
        doc: 'NoInstrAttrib Block'
      - id: security_definition_message_no_events_groups
        type: security_definition_message_no_events_groups
        doc: 'NoEvents Block'
      - id: security_desc
        type: security_desc
        doc: 'SecurityDesc data struct'
      - id: quotation_list
        type: quotation_list
        doc: 'QuotationList data struct'
  flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_flags_set_0
        type: b1
        doc: 'Unused FlagsSet 0'
      - id: unused_flags_set_1
        type: b1
        doc: 'Unused FlagsSet 1'
      - id: unused_flags_set_2
        type: b1
        doc: 'Unused FlagsSet 2'
      - id: unused_flags_set_3
        type: b1
        doc: 'Unused FlagsSet 3'
      - id: anonymous_trading
        type: b1
        doc: 'AnonymousTrading'
      - id: private_trading
        type: b1
        doc: 'PrivateTrading'
      - id: unused_flags_set_6
        type: b1
        doc: 'Unused FlagsSet 6'
      - id: unused_flags_set_7
        type: b1
        doc: 'Unused FlagsSet 7'
      - id: multi_leg
        type: b1
        doc: 'MultiLeg'
      - id: unused_flags_set_9
        type: b1
        doc: 'Unused FlagsSet 9'
      - id: unused_flags_set_10
        type: b1
        doc: 'Unused FlagsSet 10'
      - id: unused_flags_set_11
        type: b1
        doc: 'Unused FlagsSet 11'
      - id: unused_flags_set_12
        type: b1
        doc: 'Unused FlagsSet 12'
      - id: unused_flags_set_13
        type: b1
        doc: 'Unused FlagsSet 13'
      - id: unused_flags_set_14
        type: b1
        doc: 'Unused FlagsSet 14'
      - id: unused_flags_set_15
        type: b1
        doc: 'Unused FlagsSet 15'
      - id: unused_flags_set_16
        type: b1
        doc: 'Unused FlagsSet 16'
      - id: unused_flags_set_17
        type: b1
        doc: 'Unused FlagsSet 17'
      - id: collateral
        type: b1
        doc: 'Collateral'
      - id: intraday_exercise
        type: b1
        doc: 'IntradayExercise'
      - id: reserved_44
        type: b44
        doc: '44 reserved bits'
  trade_period_access:
    meta:
      bit-endian: le
    seq:
      - id: day_session
        type: b1
        doc: 'DaySession'
      - id: evening_session
        type: b1
        doc: 'EveningSession'
      - id: weekend_session
        type: b1
        doc: 'WeekendSession'
      - id: morning_session
        type: b1
        doc: 'MorningSession'
      - id: reserved_60
        type: b60
        doc: '60 reserved bits'
  security_definition_message_no_m_d_feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: security_definition_message_no_m_d_feed_types_group
        type: security_definition_message_no_m_d_feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoMDFeedTypes'
  group_size:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group_uint_8
        type: u1
        doc: 'numInGroup'
  security_definition_message_no_m_d_feed_types_group:
    seq:
      - id: md_feed_type
        type: str
        size: 25
        encoding: ASCII
        doc: 'Feed type'
      - id: market_depth
        type: u4_nullable
        doc: 'Order-book depth. Nullable, No Value = 4294967295'
      - id: md_book_type
        type: u4_nullable
        doc: 'Order-book type. Nullable, No Value = 4294967295'
      - id: block_extension
        size: _parent.group_size.block_length - 33
        doc: 'Bytes the stated block holds beyond the 33 this version reads'
  security_definition_message_no_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: security_definition_message_no_underlyings_group
        type: security_definition_message_no_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoUnderlyings'
  security_definition_message_no_underlyings_group:
    seq:
      - id: underlying_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Underlying asset code'
      - id: underlying_board
        type: str
        size: 4
        encoding: ASCII
        doc: 'Underlying board code'
      - id: underlying_security_id
        type: s4_nullable
        doc: 'Futures instrument ID. Nullable, No Value = -2147483648'
      - id: underlying_future_id
        type: s4_nullable
        doc: 'ID of the base futures instrument, applicable to options only. Nullable, No Value = -2147483648'
      - id: block_extension
        size: _parent.group_size.block_length - 37
        doc: 'Bytes the stated block holds beyond the 37 this version reads'
  security_definition_message_no_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: security_definition_message_no_legs_group
        type: security_definition_message_no_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoLegs'
  security_definition_message_no_legs_group:
    seq:
      - id: leg_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Multileg instrument''s individual security''s Symbol'
      - id: leg_security_id
        type: s4
        doc: 'Multileg instrument''s individual security''s SecurityID'
      - id: leg_ratio_qty
        type: s4
        doc: 'The ratio of quantity for this individual leg relative to the entire multileg security'
      - id: block_extension
        size: _parent.group_size.block_length - 33
        doc: 'Bytes the stated block holds beyond the 33 this version reads'
  security_definition_message_no_instr_attrib_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: security_definition_message_no_instr_attrib_group
        type: security_definition_message_no_instr_attrib_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoInstrAttrib'
  security_definition_message_no_instr_attrib_group:
    seq:
      - id: instr_attrib_type
        type: s4
        doc: 'Code to represent the type of instrument attribute'
      - id: instr_attrib_value
        type: str
        size: 31
        encoding: ASCII
        doc: 'Attribute value appropriate to tag 87-InstrAttribType'
      - id: block_extension
        size: _parent.group_size.block_length - 35
        doc: 'Bytes the stated block holds beyond the 35 this version reads'
  security_definition_message_no_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: security_definition_message_no_events_group
        type: security_definition_message_no_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoEvents'
  security_definition_message_no_events_group:
    seq:
      - id: event_type
        type: s4
        doc: 'Code to represent the type of event'
      - id: event_date
        type: yyyymmdd_date
        doc: 'Date of event'
      - id: event_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Time of event'
      - id: block_extension
        size: _parent.group_size.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
  security_desc:
    seq:
      - id: len_security_desc_data
        type: u2
      - id: security_desc_data
        type: str
        size: len_security_desc_data
        encoding: ASCII
        if: len_security_desc_data > 0
  quotation_list:
    seq:
      - id: len_quotation_list_data
        type: u2
      - id: quotation_list_data
        type: str
        size: len_quotation_list_data
        encoding: ASCII
        if: len_quotation_list_data > 0
  trading_session_status_message:
    seq:
      - id: trad_ses_open_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TradSesOpenTime'
      - id: trad_ses_close_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TradSesCloseTime'
      - id: trading_session_id
        type: u1
        enum: trading_session_id
        doc: 'TradingSessionID'
      - id: exchange_trading_session_id_int_32_null_optional
        type: s4_nullable
        doc: 'ExchangeTradingSessionID. Nullable, No Value = -2147483648'
      - id: trad_ses_status
        type: u1
        enum: trad_ses_status
        doc: 'TradSesStatus'
      - id: market_segment_id
        type: u1
        enum: market_segment_id
        doc: 'MarketSegmentID'
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
        doc: 'TradSesEvent'
      - id: trade_period_id
        type: s8
        doc: 'TradePeriodID'
      - id: settl_sess_begin
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'SettlSessBegin'
      - id: clr_sess_begin
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'ClrSessBegin'
      - id: block_extension
        size: _parent.sbe_header.block_length - 48
        doc: 'Bytes the stated block holds beyond the 48 this version reads'
  discrete_auction_message:
    seq:
      - id: trad_ses_open_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TradSesOpenTime'
      - id: trad_ses_close_time_from
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TradSesCloseTimeFrom'
      - id: trad_ses_close_time_till
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TradSesCloseTimeTill'
      - id: auction_id
        type: s8
        doc: 'AuctionID'
      - id: exchange_trading_session_id_int_32
        type: s4
        doc: 'ExchangeTradingSessionID'
      - id: event_id_open
        type: s4
        doc: 'EventIDOpen'
      - id: event_id_close
        type: s4
        doc: 'EventIDClose'
      - id: trade_period_id
        type: s8
        doc: 'TradePeriodID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 52
        doc: 'Bytes the stated block holds beyond the 52 this version reads'
      - id: discrete_auction_message_no_underlyings_groups
        type: discrete_auction_message_no_underlyings_groups
        doc: 'NoUnderlyings Block'
  discrete_auction_message_no_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: discrete_auction_message_no_underlyings_group
        type: discrete_auction_message_no_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoUnderlyings'
  discrete_auction_message_no_underlyings_group:
    seq:
      - id: underlying_symbol_text
        type: underlying_symbol_text
        doc: 'UnderlyingSymbolText data struct'
  underlying_symbol_text:
    seq:
      - id: len_underlying_symbol_text_data
        type: u2
      - id: underlying_symbol_text_data
        type: str
        size: len_underlying_symbol_text_data
        encoding: ASCII
        if: len_underlying_symbol_text_data > 0
  security_group_status_message:
    seq:
      - id: security_group_id
        type: s8_nullable
        doc: 'SecurityGroupID. Nullable, No Value = -9223372036854775808'
      - id: halt_type
        type: u1
        enum: halt_type
        doc: 'HaltType'
      - id: trade_mode_mask
        type: s4_nullable
        doc: 'TradeModeMask. Nullable, No Value = -2147483648'
      - id: group_mask_int_64_null_optional
        type: s8_nullable
        doc: 'GroupMask. Nullable, No Value = -9223372036854775808'
      - id: section_id_int_32_null_optional
        type: s4_nullable
        doc: 'SectionID. Nullable, No Value = -2147483648'
      - id: base_contract_id_int_32_null_optional
        type: s4_nullable
        doc: 'BaseContractID. Nullable, No Value = -2147483648'
      - id: security_trading_status
        type: u1
        enum: security_trading_status
        doc: 'SecurityTradingStatus'
      - id: status_change_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'TransactTime'
      - id: block_extension
        size: _parent.sbe_header.block_length - 38
        doc: 'Bytes the stated block holds beyond the 38 this version reads'
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
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0
  decimal_s8_5_nullable:
    seq:
      - id: value
        type: decimal_s8_5
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0
  decimal_s8_2_nullable:
    seq:
      - id: value
        type: decimal_s8_2
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  yyyymmddhhmmssmmm_timestamp:
    seq:
      - id: packed
        type: s8
    instances:
      year:
        value: packed / 10000000000000
      month:
        value: packed / 100000000000 % 100
      day:
        value: packed / 1000000000 % 100
      hour:
        value: packed / 10000000 % 100
      minute:
        value: packed / 100000 % 100
      second:
        value: packed / 1000 % 100
      millisecond:
        value: packed % 1000
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808

enums:
  last_fragment:
    0:
      id: 'fragment'
      doc: 'Not the last fragment of a fragmented message'
    1:
      id: 'last_fragment'
      doc: 'Last fragment of a fragmented message, or the message is not fragmented'
  incremental_packet:
    0:
      id: 'snapshot_packet'
      doc: 'Flag of the Snapshot packet'
    1:
      id: 'incremental_packet'
      doc: 'Flag of the Incremental packet'
  poss_dup_flag:
    0:
      id: 'online_updates'
      doc: 'Flag of broadcasting online updates'
    1:
      id: 'full_order_books'
      doc: 'Flag of broadcasting full order-books in the form of Incremental packages'
  template_id:
    1:
      id: 'heartbeat_message'
      doc: 'HeartbeatMessage'
    2:
      id: 'sequence_reset_message'
      doc: 'SequenceResetMessage'
    14:
      id: 'best_prices_message'
      doc: 'BestPricesMessage'
    4:
      id: 'empty_book_message'
      doc: 'EmptyBookMessage'
    15:
      id: 'order_update_message'
      doc: 'OrderUpdateMessage'
    16:
      id: 'order_execution_message'
      doc: 'OrderExecutionMessage'
    17:
      id: 'order_book_snapshot_message'
      doc: 'OrderBookSnapshotMessage'
    27:
      id: 'security_definition_message'
      doc: 'SecurityDefinitionMessage'
    28:
      id: 'security_status_message'
      doc: 'SecurityStatusMessage'
    10:
      id: 'security_definition_update_report_message'
      doc: 'SecurityDefinitionUpdateReportMessage'
    26:
      id: 'trading_session_status_message'
      doc: 'TradingSessionStatusMessage'
    24:
      id: 'discrete_auction_message'
      doc: 'DiscreteAuctionMessage'
    19:
      id: 'security_mass_status_message'
      doc: 'SecurityMassStatusMessage'
    22:
      id: 'security_group_status_message'
      doc: 'SecurityGroupStatusMessage'
    1000:
      id: 'logon_message'
      doc: 'LogonMessage'
    1001:
      id: 'logout_message'
      doc: 'LogoutMessage'
    1002:
      id: 'market_data_request_message'
      doc: 'MarketDataRequestMessage'
    1003:
      id: 'market_data_dummy_message'
      doc: 'MarketDataDummyMessage'
  security_alt_id_source:
    0x34:
      id: 'isin'
      doc: 'ISIN'
    0x38:
      id: 'exchange_symbol'
      doc: 'Exchange symbol'
  security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading halt'
    17:
      id: 'ready_to_trade'
      doc: 'Ready to trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not available for trading'
    19:
      id: 'not_traded_on_this_market'
      doc: 'Not traded on this market'
    20:
      id: 'unknown_or_invalid'
      doc: 'Unknown or Invalid status'
    21:
      id: 'pre_open'
      doc: 'Pre-open'
    119:
      id: 'discrete_auction_open'
      doc: 'Discrete auction started'
    121:
      id: 'discrete_auction_close'
      doc: 'Discrete auction ended'
    122:
      id: 'instrument_halt'
      doc: 'Instrument halt'
    123:
      id: 'close_position'
      doc: 'Ready to trade. Close position'
    124:
      id: 'discrete_auction_close_position'
      doc: 'Discrete auction. Close position'
  market_segment_id:
    0x44:
      id: 'derivatives'
      doc: 'Derivatives'
  trading_session_id:
    1:
      id: 'day'
      doc: 'Day session'
    3:
      id: 'morning'
      doc: 'Morning session'
    5:
      id: 'evening'
      doc: 'Evening session'
    100:
      id: 'weekend'
      doc: 'Weekend session'
  negative_prices:
    0:
      id: 'not_eligible'
      doc: 'Futures prices, price limits and options strikes are limited to be positive only'
    1:
      id: 'eligible'
      doc: 'Futures prices and options strikes are not limited'
  trad_ses_status:
    1:
      id: 'halted'
      doc: 'Session paused'
    2:
      id: 'open'
      doc: 'Session started'
    3:
      id: 'closed'
      doc: 'Session ended'
    4:
      id: 'pre_open'
      doc: 'Session initiated'
  trad_ses_event:
    0:
      id: 'trading_resumes'
      doc: 'Trading resumed after intraday clearing session'
    1:
      id: 'change_of_trading_session'
      doc: 'Start and end of trading session'
    3:
      id: 'change_of_trading_status'
      doc: 'Trading session status change'
  halt_type:
    0:
      id: 'empty_halts'
      doc: 'Empty all halts on client'
    1:
      id: 'session'
      doc: 'Session'
    2:
      id: 'section'
      doc: 'Section'
    3:
      id: 'section_and_trade_mode'
      doc: 'Section and trade mode'
    4:
      id: 'fut_base_contract'
      doc: 'Futures base contract'
    5:
      id: 'instruments_from_trade_mode'
      doc: 'Instruments from trade mode'
    6:
      id: 'instruments_from_trade_mode_and_fut_base_contract'
      doc: 'Instruments from trade mode and futures base contract'
    7:
      id: 'group_instruments'
      doc: 'Group instruments'
    8:
      id: 'group_instruments_and_fut_base_contract'
      doc: 'Group instruments and futures base contract'

