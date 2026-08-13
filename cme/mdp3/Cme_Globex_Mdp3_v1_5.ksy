# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex Mdp3 Sbe v1.5
#
# Protocol:
#   Organization: CME Group
#   Protocol: Market Data Platform 3
#   Encoding: Simple Binary Encoding
#   Version: 1.5
#   Date: 8/06/2014
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
  id: cme_globex_mdp3_sbe_v1_5
  title: Cme Globex Mdp3 Sbe v1.5
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Market Data Platform 3 Sbe v1.5'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+MDP+3.0+Market+Data

seq:
  - id: binary_packet_header
    type: binary_packet_header_struct
    doc: 'Cme Mdp Packet Header'
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Cme Market Data Message'

types:
  binary_packet_header_struct:
    seq:
      - id: packet_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Packet Sending Time. Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message Root'
      - id: payload
        size: message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::channel_reset': channel_reset
            'template_id::admin_login': admin_login
            'template_id::admin_logout': admin_logout
            'template_id::md_instrument_definition_future': md_instrument_definition_future
            'template_id::md_instrument_definition_spread': md_instrument_definition_spread
            'template_id::security_status': security_status
            'template_id::md_incremental_refresh_book': md_incremental_refresh_book
            'template_id::md_incremental_refresh_daily_statistics': md_incremental_refresh_daily_statistics
            'template_id::md_incremental_refresh_limits_banding': md_incremental_refresh_limits_banding
            'template_id::md_incremental_refresh_session_statistics': md_incremental_refresh_session_statistics
            'template_id::md_incremental_refresh_trade': md_incremental_refresh_trade
            'template_id::md_incremental_refresh_volume': md_incremental_refresh_volume
            'template_id::snapshot_full_refresh': snapshot_full_refresh
            'template_id::quote_request': quote_request
            'template_id::md_instrument_definition_option': md_instrument_definition_option
            'template_id::md_incremental_refresh_trade_summary': md_incremental_refresh_trade_summary
  message_header:
    seq:
      - id: block_length
        type: u2
      - id: template_id
        type: u2
        enum: template_id
      - id: schema_id
        type: u2
      - id: version
        type: u2
  channel_reset:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: channel_reset_groups
        type: channel_reset_groups
        doc: 'NoMDEntries Block'
  match_event_indicator:
    seq:
      - id: last_trade_msg
        type: b1
        doc: 'LastTradeMsg'
      - id: last_volume_msg
        type: b1
        doc: 'LastVolumeMsg'
      - id: last_quote_msg
        type: b1
        doc: 'LastQuoteMsg'
      - id: last_stats_msg
        type: b1
        doc: 'LastStatsMsg'
      - id: last_implied_msg
        type: b1
        doc: 'LastImpliedMsg'
      - id: recovery_msg
        type: b1
        doc: 'RecoveryMsg'
      - id: reserved
        type: b1
        doc: 'Reserved'
      - id: end_of_event
        type: b1
        doc: 'EndOfEvent'
  channel_reset_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: channel_reset_group
        type: channel_reset_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  channel_reset_group:
    seq:
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
  admin_login:
    seq:
      - id: heart_bt_int
        type: s1
        doc: 'Heartbeat interval (seconds)'
  admin_logout:
    seq:
      - id: text
        type: str
        size: 180
        encoding: ASCII
        doc: 'Free format text string. May include logout confirmation or reason for logout'
  md_instrument_definition_future:
    seq:
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: tot_num_reports_optional
        type: u4_nullable
        doc: 'Total number of instruments in the Replay loop. Used on Replay Feed only. Nullable, No Value = 4294967295'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the instrument was last added, modified or deleted. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current state of the instrument. In Security Definition message this tag is available in the Instrument Replay feed only. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: underlying_product
        type: u1
        doc: 'Product complex'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Exchange used to identify a security'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group Code'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'The underlying asset code also known as Product Code'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO standard instrument categorization code'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'MDInstrumentDefinitionFuture'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies currency used for price'
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies currency used for settlement, if different from trading currency'
      - id: match_algorithm
        type: str
        size: 1
        encoding: ASCII
        doc: 'Matching algorithm'
      - id: min_trade_vol
        type: u4
        doc: 'The minimum trading volume for a security'
      - id: max_trade_vol
        type: u4
        doc: 'The maximum trading volume for a security'
      - id: min_price_increment
        type: decimal_s8_7
        doc: 'Minimum constant tick for the instrument, sent only if instrument is non-VTT (Variable Tick table) eligible. Implied decimal with scale 1e-7'
      - id: display_factor
        type: decimal_s8_7
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-7'
      - id: main_fraction
        type: u1_nullable
        doc: 'Price Denominator of Main Fraction. Nullable, No Value = 255'
      - id: sub_fraction
        type: u1_nullable
        doc: 'Price Denominator of Sub Fraction. Nullable, No Value = 255'
      - id: price_display_format
        type: u1_nullable
        doc: 'Number of decimals in fractional display price. Nullable, No Value = 255'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: unit_of_measure_qty
        type: decimal_s8_7_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_7_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: open_interest_qty
        type: s4_nullable
        doc: 'The total open interest for the market at the close of the prior trading session. Nullable, No Value = 2147483647'
      - id: cleared_volume
        type: s4_nullable
        doc: 'The total cleared volume of instrument traded during the prior trading session. Nullable, No Value = 2147483647'
      - id: high_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable high limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable low limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_7_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: decay_quantity
        type: s4_nullable
        doc: 'Indicates the quantity that a contract will decay daily by once the decay start date is reached. Nullable, No Value = 2147483647'
      - id: decay_start_date
        type: u2_nullable
        doc: 'Indicates the date at which a decaying contract will begin to decay. Nullable, No Value = 65535'
      - id: original_contract_size
        type: s4_nullable
        doc: 'Fixed contract value assigned to each product. Nullable, No Value = 2147483647'
      - id: contract_multiplier
        type: s4_nullable
        doc: 'Number of deliverable units per instrument, e.g., peak days in maturity month or number of calendar days in maturity month. Nullable, No Value = 2147483647'
      - id: contract_multiplier_unit
        type: s1_nullable
        doc: 'Indicates the type of multiplier being applied to the product. Optionally used in combination with tag 231-ContractMultiplier. Nullable, No Value = 127'
      - id: flow_schedule_type
        type: s1_nullable
        doc: 'The schedule according to which the electricity is delivered in a physical contract, or priced in a financial contract. Specifies whether the contract is defined according to the Easter Peak, Eastern Off-Peak, Western Peak or Western Off-Peak. Nullable, No Value = 127'
      - id: min_price_increment_amount
        type: decimal_s8_7_nullable
        doc: 'Monetary value equivalent to the minimum price fluctuation. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: m_d_instrument_definition_future_27_no_events_groups
        type: m_d_instrument_definition_future_27_no_events_groups
        doc: 'NoEvents Block'
      - id: m_d_instrument_definition_future_27_no_m_d_feed_types_groups
        type: m_d_instrument_definition_future_27_no_m_d_feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: m_d_instrument_definition_future_27_no_inst_attrib_groups
        type: m_d_instrument_definition_future_27_no_inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: m_d_instrument_definition_future_27_no_lot_type_rules_groups
        type: m_d_instrument_definition_future_27_no_lot_type_rules_groups
        doc: 'NoLotTypeRules Block'
  maturity_month_year:
    seq:
      - id: year
        type: u2_nullable
        doc: 'YYYY. Nullable, No Value = 65535'
      - id: month
        type: u1_nullable
        doc: 'MM. Nullable, No Value = 255'
      - id: day
        type: u1_nullable
        doc: 'DD. Nullable, No Value = 255'
      - id: week
        type: u1_nullable
        doc: 'WW. Nullable, No Value = 255'
  settl_price_type:
    seq:
      - id: final_field
        type: b1
        doc: 'Final'
      - id: actual
        type: b1
        doc: 'Actual'
      - id: rounded
        type: b1
        doc: 'Rounded'
      - id: intraday
        type: b1
        doc: 'Intraday'
      - id: reserved_bits
        type: b1
        doc: 'ReservedBits'
      - id: unused_settl_price_type_5
        type: b1
        doc: 'Unused SettlPriceType 5'
      - id: unused_settl_price_type_6
        type: b1
        doc: 'Unused SettlPriceType 6'
      - id: null_value
        type: b1
        doc: 'NullValue'
  m_d_instrument_definition_future_27_no_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_future_27_no_events_group
        type: m_d_instrument_definition_future_27_no_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating EventType entries'
  m_d_instrument_definition_future_27_no_events_group:
    seq:
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Code to represent the type of event'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'Date and Time of instument Activation or Expiration event sent as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  m_d_instrument_definition_future_27_no_m_d_feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_future_27_no_m_d_feed_types_group
        type: m_d_instrument_definition_future_27_no_m_d_feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating FeedType entries'
  m_d_instrument_definition_future_27_no_m_d_feed_types_group:
    seq:
      - id: md_feed_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed. GBX- Real Book, GBI-Implied Book'
      - id: market_depth
        type: s1
        doc: 'Book depth'
  m_d_instrument_definition_future_27_no_inst_attrib_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_future_27_no_inst_attrib_group
        type: m_d_instrument_definition_future_27_no_inst_attrib_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating InstrAttribType entries'
  m_d_instrument_definition_future_27_no_inst_attrib_group:
    seq:
      - id: inst_attrib_value
        type: inst_attrib_value
        doc: 'InstAttribValue bit set'
  inst_attrib_value:
    seq:
      - id: electronic_match_eligible
        type: b1
        doc: 'ElectronicMatchEligible'
      - id: order_cross_eligible
        type: b1
        doc: 'OrderCrossEligible'
      - id: block_trade_eligible
        type: b1
        doc: 'BlockTradeEligible'
      - id: efp_eligible
        type: b1
        doc: 'EFPEligible'
      - id: ebf_eligible
        type: b1
        doc: 'EBFEligible'
      - id: efs_eligible
        type: b1
        doc: 'EFSEligible'
      - id: efr_eligible
        type: b1
        doc: 'EFREligible'
      - id: otc_eligible
        type: b1
        doc: 'OTCEligible'
      - id: ilink_indicative_mass_quoting_eligible
        type: b1
        doc: 'iLinkIndicativeMassQuotingEligible'
      - id: negative_strike_eligible
        type: b1
        doc: 'NegativeStrikeEligible'
      - id: negative_price_outright_eligible
        type: b1
        doc: 'NegativePriceOutrightEligible'
      - id: is_fractional
        type: b1
        doc: 'IsFractional'
      - id: volatility_quoted_option
        type: b1
        doc: 'VolatilityQuotedOption'
      - id: rfq_cross_eligible
        type: b1
        doc: 'RFQCrossEligible'
      - id: zero_price_outright_eligible
        type: b1
        doc: 'ZeroPriceOutrightEligible'
      - id: decaying_product_eligibility
        type: b1
        doc: 'DecayingProductEligibility'
      - id: variable_product_eligibility
        type: b1
        doc: 'VariableProductEligibility'
      - id: daily_product_eligibility
        type: b1
        doc: 'DailyProductEligibility'
      - id: gt_orders_eligibility
        type: b1
        doc: 'GTOrdersEligibility'
      - id: implied_matching_eligibility
        type: b1
        doc: 'ImpliedMatchingEligibility'
      - id: reserved_12
        type: b12
        doc: '12 reserved bits'
  m_d_instrument_definition_future_27_no_lot_type_rules_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_future_27_no_lot_type_rules_group
        type: m_d_instrument_definition_future_27_no_lot_type_rules_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries'
  m_d_instrument_definition_future_27_no_lot_type_rules_group:
    seq:
      - id: lot_type
        type: s1
        doc: 'This tag is required to interpret the value in tag 1231-MinLotSize'
      - id: min_lot_size
        type: decimal_s4_4_nullable
        doc: 'Minimum quantity accepted for order entry. If tag 1093-LotType=4, this value is the minimum quantity for order entry expressed in the applicable units, specified in tag 996-UnitOfMeasure, e.g. megawatts. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
  md_instrument_definition_spread:
    seq:
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: tot_num_reports_optional
        type: u4_nullable
        doc: 'Total number of instruments in the Replay loop. Used on Replay Feed only. Nullable, No Value = 4294967295'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the instrument was last added, modified or deleted. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current state of the instrument. In Security Definition message this tag is available in the Instrument Replay feed only. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: underlying_product_optional
        type: u1_nullable
        doc: 'Product complex. Nullable, No Value = 255'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Exchange used to identify a security'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group Code'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'The underlying asset code also known as Product Code'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO standard instrument categorization code'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'MDInstrumentDefinitionFuture'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies currency used for price'
      - id: security_sub_type
        type: str
        size: 5
        encoding: ASCII
        doc: 'Strategy type'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: match_algorithm
        type: str
        size: 1
        encoding: ASCII
        doc: 'Matching algorithm'
      - id: min_trade_vol
        type: u4
        doc: 'The minimum trading volume for a security'
      - id: max_trade_vol
        type: u4
        doc: 'The maximum trading volume for a security'
      - id: min_price_increment
        type: decimal_s8_7
        doc: 'Minimum constant tick for the instrument, sent only if instrument is non-VTT (Variable Tick table) eligible. Implied decimal with scale 1e-7'
      - id: display_factor
        type: decimal_s8_7
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-7'
      - id: price_display_format
        type: u1_nullable
        doc: 'Number of decimals in fractional display price. Nullable, No Value = 255'
      - id: price_ratio
        type: decimal_s8_7_nullable
        doc: 'Used for price calculation in spread and leg pricing. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: tick_rule
        type: s1_nullable
        doc: 'Tick Rule. Nullable, No Value = 127'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: trading_reference_price
        type: decimal_s8_7_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: open_interest_qty
        type: s4_nullable
        doc: 'The total open interest for the market at the close of the prior trading session. Nullable, No Value = 2147483647'
      - id: cleared_volume
        type: s4_nullable
        doc: 'The total cleared volume of instrument traded during the prior trading session. Nullable, No Value = 2147483647'
      - id: high_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable high limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable low limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_7_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: main_fraction
        type: u1_nullable
        doc: 'Price Denominator of Main Fraction. Nullable, No Value = 255'
      - id: sub_fraction
        type: u1_nullable
        doc: 'Price Denominator of Sub Fraction. Nullable, No Value = 255'
      - id: m_d_instrument_definition_spread_29_no_events_groups
        type: m_d_instrument_definition_spread_29_no_events_groups
        doc: 'NoEvents Block'
      - id: m_d_instrument_definition_spread_29_no_m_d_feed_types_groups
        type: m_d_instrument_definition_spread_29_no_m_d_feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: m_d_instrument_definition_spread_29_no_inst_attrib_groups
        type: m_d_instrument_definition_spread_29_no_inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: m_d_instrument_definition_spread_29_no_lot_type_rules_groups
        type: m_d_instrument_definition_spread_29_no_lot_type_rules_groups
        doc: 'NoLotTypeRules Block'
      - id: m_d_instrument_definition_spread_29_no_legs_groups
        type: m_d_instrument_definition_spread_29_no_legs_groups
        doc: 'NoLegs Block'
  m_d_instrument_definition_spread_29_no_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_spread_29_no_events_group
        type: m_d_instrument_definition_spread_29_no_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating EventType entries'
  m_d_instrument_definition_spread_29_no_events_group:
    seq:
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Code to represent the type of event'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'Date and Time of instument Activation or Expiration event sent as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  m_d_instrument_definition_spread_29_no_m_d_feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_spread_29_no_m_d_feed_types_group
        type: m_d_instrument_definition_spread_29_no_m_d_feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of FeedType entries'
  m_d_instrument_definition_spread_29_no_m_d_feed_types_group:
    seq:
      - id: md_feed_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed. GBX- Real Book, GBI-Implied Book'
      - id: market_depth
        type: s1
        doc: 'Book depth'
  m_d_instrument_definition_spread_29_no_inst_attrib_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_spread_29_no_inst_attrib_group
        type: m_d_instrument_definition_spread_29_no_inst_attrib_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of InstrAttribType entries'
  m_d_instrument_definition_spread_29_no_inst_attrib_group:
    seq:
      - id: inst_attrib_value
        type: inst_attrib_value
        doc: 'InstAttribValue bit set'
  m_d_instrument_definition_spread_29_no_lot_type_rules_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_spread_29_no_lot_type_rules_group
        type: m_d_instrument_definition_spread_29_no_lot_type_rules_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries'
  m_d_instrument_definition_spread_29_no_lot_type_rules_group:
    seq:
      - id: lot_type
        type: s1
        doc: 'This tag is required to interpret the value in tag 1231-MinLotSize'
      - id: min_lot_size
        type: decimal_s4_4_nullable
        doc: 'Minimum quantity accepted for order entry. If tag 1093-LotType=4, this value is the minimum quantity for order entry expressed in the applicable units, specified in tag 996-UnitOfMeasure, e.g. megawatts. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
  m_d_instrument_definition_spread_29_no_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_spread_29_no_legs_group
        type: m_d_instrument_definition_spread_29_no_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Leg entries'
  m_d_instrument_definition_spread_29_no_legs_group:
    seq:
      - id: leg_security_id
        type: s4
        doc: 'Leg Security ID'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side'
      - id: leg_ratio_qty
        type: s1
        doc: 'Leg ratio of quantity for this individual leg relative to the entire multi-leg instrument'
      - id: leg_price
        type: decimal_s8_7_nullable
        doc: 'Price for the future leg of a UDS Covered instrument. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: leg_option_delta
        type: decimal_s4_4_nullable
        doc: 'Delta used to calculate the quantity of futures used to cover the option or option strategy. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
  security_status:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group Code'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'The underlying asset code also known as Product Code'
      - id: security_id_optional
        type: s4_nullable
        doc: 'If this tag is present, 35=f message is sent for the instrument. Nullable, No Value = 2147483647'
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Identifies the trading status applicable to the instrument or Security Group. Nullable, No Value = 255'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Identifies the reason for the status change'
      - id: security_trading_event
        type: u1
        enum: security_trading_event
        doc: 'Identifies an additional event or a rule related to the status'
  md_incremental_refresh_book:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_book_32_no_m_d_entries_groups
        type: m_d_incremental_refresh_book_32_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  m_d_incremental_refresh_book_32_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_book_32_no_m_d_entries_group
        type: m_d_incremental_refresh_book_32_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  m_d_incremental_refresh_book_32_no_m_d_entries_group:
    seq:
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level
        type: u1
        doc: 'Aggregate book level'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_entry_type_book
        type: u1
        enum: md_entry_type_book
        doc: 'Market Data entry type'
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
  md_incremental_refresh_daily_statistics:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_groups
        type: m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_group
        type: m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  m_d_incremental_refresh_daily_statistics_33_no_m_d_entries_group:
    seq:
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates trade session date corresponding to a statistic entry. Nullable, No Value = 65535'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_entry_type_daily_statistics
        type: u1
        enum: md_entry_type_daily_statistics
        doc: 'Market Data entry type'
      - id: padding_7
        size: 7
        doc: '7 bytes padding'
  md_incremental_refresh_limits_banding:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_limits_banding_34_no_m_d_entries_groups
        type: m_d_incremental_refresh_limits_banding_34_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  m_d_incremental_refresh_limits_banding_34_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_limits_banding_34_no_m_d_entries_group
        type: m_d_incremental_refresh_limits_banding_34_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  m_d_incremental_refresh_limits_banding_34_no_m_d_entries_group:
    seq:
      - id: high_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable high limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable low limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_7_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
  md_incremental_refresh_session_statistics:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_session_statistics_35_no_m_d_entries_groups
        type: m_d_incremental_refresh_session_statistics_35_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  m_d_incremental_refresh_session_statistics_35_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_session_statistics_35_no_m_d_entries_group
        type: m_d_incremental_refresh_session_statistics_35_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  m_d_incremental_refresh_session_statistics_35_no_m_d_entries_group:
    seq:
      - id: md_entry_px
        type: decimal_s8_7
        doc: 'Market Data entry price. Implied decimal with scale 1e-7'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: open_close_settl_flag
        type: u1_nullable
        doc: 'Flag describing IOP and Open Price entries. Nullable, No Value = 255'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_entry_type_statistics
        type: u1
        enum: md_entry_type_statistics
        doc: 'Market Data entry type'
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
  md_incremental_refresh_trade:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_trade_36_no_m_d_entries_groups
        type: m_d_incremental_refresh_trade_36_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  m_d_incremental_refresh_trade_36_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_trade_36_no_m_d_entries_group
        type: m_d_incremental_refresh_trade_36_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  m_d_incremental_refresh_trade_36_no_m_d_entries_group:
    seq:
      - id: md_entry_px
        type: decimal_s8_7
        doc: 'Market Data entry price. Implied decimal with scale 1e-7'
      - id: md_entry_size
        type: s4
        doc: 'Trade quantity'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade ID per instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates aggressor side in the trade, if value is 0 then there is no aggressor. Nullable, No Value = 255'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  md_incremental_refresh_volume:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: incremental_refresh_volume_groups
        type: incremental_refresh_volume_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_volume_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_volume_group
        type: incremental_refresh_volume_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_volume_group:
    seq:
      - id: md_entry_size
        type: s4
        doc: 'Trade quantity'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: padding_3
        size: 3
        doc: '3 bytes padding'
  snapshot_full_refresh:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'Sequence number of the last Incremental feed packet processed. This value is used to synchronize the snapshot loop with the real-time feed'
      - id: tot_num_reports
        type: u4
        doc: 'Total number of messages replayed in the loop'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the instrument was last added, modified or deleted. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current state of the instrument. In Security Definition message this tag is available in the Instrument Replay feed only. Nullable, No Value = 255'
      - id: high_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable high limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable low limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_7_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: snapshot_full_refresh_38_no_m_d_entries_groups
        type: snapshot_full_refresh_38_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  snapshot_full_refresh_38_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_full_refresh_38_no_m_d_entries_group
        type: snapshot_full_refresh_38_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_full_refresh_38_no_m_d_entries_group:
    seq:
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: number_of_orders
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level_optional
        type: s1_nullable
        doc: 'Aggregate book position. Nullable, No Value = 127'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates trade session date corresponding to a statistic entry. Nullable, No Value = 65535'
      - id: open_close_settl_flag
        type: u1_nullable
        doc: 'Flag describing IOP and Open Price entries. Nullable, No Value = 255'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Market Data entry type'
  quote_request:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: quote_req_id
        type: str
        size: 23
        encoding: ASCII
        doc: 'Quote Request ID defined by the exchange'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_3
        size: 3
        doc: '3 bytes padding'
      - id: related_sym_groups
        type: related_sym_groups
        doc: 'NoRelatedSym Block'
  related_sym_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: related_sym_group
        type: related_sym_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Indicates the number of repeating symbols specified'
  related_sym_group:
    seq:
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: order_qty
        type: s4_nullable
        doc: 'Quantity requested. Nullable, No Value = 2147483647'
      - id: quote_type
        type: s1
        doc: 'Type of quote requested'
      - id: side
        type: s1_nullable
        doc: 'Side requested. Nullable, No Value = 127'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  md_instrument_definition_option:
    seq:
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: tot_num_reports_optional
        type: u4_nullable
        doc: 'Total number of instruments in the Replay loop. Used on Replay Feed only. Nullable, No Value = 4294967295'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Timestamp of when the instrument was last added, modified or deleted. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current state of the instrument. In Security Definition message this tag is available in the Instrument Replay feed only. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Last Security update action on Incremental feed, ''D'' or ''M'' is used when a mid-week deletion or modification (i.e. extension) occurs'
      - id: underlying_product
        type: u1
        doc: 'Product complex'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Exchange used to identify a security'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group Code'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'The underlying asset code also known as Product Code'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO standard instrument categorization code'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Indicates whether an option instrument is a put or call'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'MDInstrumentDefinitionFuture'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies currency used for price'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'Strike Price for an option instrument. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: strike_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency in which the StrikePrice is denominated'
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies currency used for settlement, if different from trading currency'
      - id: min_cab_price
        type: decimal_s8_7_nullable
        doc: 'Defines cabinet price for outright options products. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: match_algorithm
        type: str
        size: 1
        encoding: ASCII
        doc: 'Matching algorithm'
      - id: min_trade_vol
        type: u4
        doc: 'The minimum trading volume for a security'
      - id: max_trade_vol
        type: u4
        doc: 'The maximum trading volume for a security'
      - id: min_price_increment_optional
        type: decimal_s8_7_nullable
        doc: 'Minimum constant tick for the instrument. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment_amount
        type: decimal_s8_7_nullable
        doc: 'Monetary value equivalent to the minimum price fluctuation. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: display_factor
        type: decimal_s8_7
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-7'
      - id: tick_rule
        type: s1_nullable
        doc: 'Tick Rule. Nullable, No Value = 127'
      - id: main_fraction
        type: u1_nullable
        doc: 'Price Denominator of Main Fraction. Nullable, No Value = 255'
      - id: sub_fraction
        type: u1_nullable
        doc: 'Price Denominator of Sub Fraction. Nullable, No Value = 255'
      - id: price_display_format
        type: u1_nullable
        doc: 'Number of decimals in fractional display price. Nullable, No Value = 255'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: unit_of_measure_qty
        type: decimal_s8_7_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_7_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: cleared_volume
        type: s4_nullable
        doc: 'The total cleared volume of instrument traded during the prior trading session. Nullable, No Value = 2147483647'
      - id: open_interest_qty
        type: s4_nullable
        doc: 'The total open interest for the market at the close of the prior trading session. Nullable, No Value = 2147483647'
      - id: low_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable low limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: high_limit_price
        type: decimal_s8_7_nullable
        doc: 'Allowable high limit price for the trading day. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: m_d_instrument_definition_option_41_no_events_groups
        type: m_d_instrument_definition_option_41_no_events_groups
        doc: 'NoEvents Block'
      - id: m_d_instrument_definition_option_41_no_m_d_feed_types_groups
        type: m_d_instrument_definition_option_41_no_m_d_feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: m_d_instrument_definition_option_41_no_inst_attrib_groups
        type: m_d_instrument_definition_option_41_no_inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: m_d_instrument_definition_option_41_no_lot_type_rules_groups
        type: m_d_instrument_definition_option_41_no_lot_type_rules_groups
        doc: 'NoLotTypeRules Block'
      - id: m_d_instrument_definition_option_41_no_underlyings_groups
        type: m_d_instrument_definition_option_41_no_underlyings_groups
        doc: 'NoUnderlyings Block'
  m_d_instrument_definition_option_41_no_events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_option_41_no_events_group
        type: m_d_instrument_definition_option_41_no_events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of EventType entries'
  m_d_instrument_definition_option_41_no_events_group:
    seq:
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Code to represent the type of event'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'Date and Time of instument Activation or Expiration event sent as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  m_d_instrument_definition_option_41_no_m_d_feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_option_41_no_m_d_feed_types_group
        type: m_d_instrument_definition_option_41_no_m_d_feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of FeedType entries'
  m_d_instrument_definition_option_41_no_m_d_feed_types_group:
    seq:
      - id: md_feed_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed. GBX- Real Book, GBI-Implied Book'
      - id: market_depth
        type: s1
        doc: 'Book depth'
  m_d_instrument_definition_option_41_no_inst_attrib_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_option_41_no_inst_attrib_group
        type: m_d_instrument_definition_option_41_no_inst_attrib_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of InstrAttribType entries'
  m_d_instrument_definition_option_41_no_inst_attrib_group:
    seq:
      - id: inst_attrib_value
        type: inst_attrib_value
        doc: 'InstAttribValue bit set'
  m_d_instrument_definition_option_41_no_lot_type_rules_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_option_41_no_lot_type_rules_group
        type: m_d_instrument_definition_option_41_no_lot_type_rules_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries'
  m_d_instrument_definition_option_41_no_lot_type_rules_group:
    seq:
      - id: lot_type
        type: s1
        doc: 'This tag is required to interpret the value in tag 1231-MinLotSize'
      - id: min_lot_size
        type: decimal_s4_4_nullable
        doc: 'Minimum quantity accepted for order entry. If tag 1093-LotType=4, this value is the minimum quantity for order entry expressed in the applicable units, specified in tag 996-UnitOfMeasure, e.g. megawatts. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
  m_d_instrument_definition_option_41_no_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_instrument_definition_option_41_no_underlyings_group
        type: m_d_instrument_definition_option_41_no_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of underlying instruments'
  m_d_instrument_definition_option_41_no_underlyings_group:
    seq:
      - id: underlying_security_id
        type: s4
        doc: 'Unique Instrument ID as qualified by the exchange per tag 305-UnderlyingSecurityIDSource'
      - id: underlying_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying Instrument Symbol (Contract Name)'
  md_incremental_refresh_trade_summary:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
      - id: m_d_incremental_refresh_trade_summary_42_no_m_d_entries_groups
        type: m_d_incremental_refresh_trade_summary_42_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
      - id: m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_groups
        type: m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_groups
        doc: 'NoOrderIDEntries Block'
  m_d_incremental_refresh_trade_summary_42_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: m_d_incremental_refresh_trade_summary_42_no_m_d_entries_group
        type: m_d_incremental_refresh_trade_summary_42_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Trade Summary entries'
  m_d_incremental_refresh_trade_summary_42_no_m_d_entries_group:
    seq:
      - id: md_entry_px
        type: decimal_s8_7
        doc: 'Market Data entry price. Implied decimal with scale 1e-7'
      - id: md_entry_size
        type: s4
        doc: 'Trade quantity'
      - id: security_id
        type: s4
        doc: 'Unique instrument ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates aggressor side in the trade, if value is 0 then there is no aggressor. Nullable, No Value = 255'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: padding_6
        size: 6
        doc: '6 bytes padding'
  m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_groups:
    seq:
      - id: group_size_8_byte
        type: group_size_8_byte
        doc: '8 Byte aligned repeating group dimensions'
      - id: m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_group
        type: m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_group
        repeat: expr
        repeat-expr: group_size_8_byte.num_in_group
        doc: 'Number of OrderID entries'
  group_size_8_byte:
    seq:
      - id: block_length
        type: u2
      - id: padding_5
        size: 5
        doc: '5 bytes padding'
      - id: num_in_group
        type: u1
  m_d_incremental_refresh_trade_summary_42_no_order_i_d_entries_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique order identifier as assigned by the exchange'
      - id: last_qty
        type: s4
        doc: 'Quantity bought or sold on this last fill'
      - id: padding_4
        size: 4
        doc: '4 bytes padding'
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
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
  decimal_s8_7:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000.0
  decimal_s8_7_nullable:
    seq:
      - id: value
        type: decimal_s8_7
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 2147483647
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == 127
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s4_4_nullable:
    seq:
      - id: value
        type: decimal_s4_4
    instances:
      is_null:
        value: value.mantissa == 2147483647

enums:
  template_id:
    4:
      id: 'channel_reset'
      doc: 'ChannelReset'
    12:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
    15:
      id: 'admin_login'
      doc: 'AdminLogin'
    16:
      id: 'admin_logout'
      doc: 'AdminLogout'
    27:
      id: 'md_instrument_definition_future'
      doc: 'MDInstrumentDefinitionFuture'
    29:
      id: 'md_instrument_definition_spread'
      doc: 'MDInstrumentDefinitionSpread'
    30:
      id: 'security_status'
      doc: 'SecurityStatus'
    32:
      id: 'md_incremental_refresh_book'
      doc: 'MDIncrementalRefreshBook'
    33:
      id: 'md_incremental_refresh_daily_statistics'
      doc: 'MDIncrementalRefreshDailyStatistics'
    34:
      id: 'md_incremental_refresh_limits_banding'
      doc: 'MDIncrementalRefreshLimitsBanding'
    35:
      id: 'md_incremental_refresh_session_statistics'
      doc: 'MDIncrementalRefreshSessionStatistics'
    36:
      id: 'md_incremental_refresh_trade'
      doc: 'MDIncrementalRefreshTrade'
    37:
      id: 'md_incremental_refresh_volume'
      doc: 'MDIncrementalRefreshVolume'
    38:
      id: 'snapshot_full_refresh'
      doc: 'SnapshotFullRefresh'
    39:
      id: 'quote_request'
      doc: 'QuoteRequest'
    41:
      id: 'md_instrument_definition_option'
      doc: 'MDInstrumentDefinitionOption'
    42:
      id: 'md_incremental_refresh_trade_summary'
      doc: 'MDIncrementalRefreshTradeSummary'
  security_update_action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
    0x4d:
      id: 'modify'
      doc: 'Modify'
  md_security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading Halt'
    4:
      id: 'close'
      doc: 'Close'
    15:
      id: 'new_price_indication'
      doc: 'New Price Indication'
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    20:
      id: 'unknown_or_invalid'
      doc: 'Unknown or Invalid'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    24:
      id: 'pre_cross'
      doc: 'Pre Cross'
    25:
      id: 'cross'
      doc: 'Cross'
    26:
      id: 'post_close'
      doc: 'Post Close'
    103:
      id: 'no_change'
      doc: 'No Change'
  event_type:
    5:
      id: 'activation'
      doc: 'Activation'
    7:
      id: 'last_eligible_trade_date'
      doc: 'Last Eligible Trade Date'
  leg_side:
    1:
      id: 'buy_side'
      doc: 'Buy Side'
    2:
      id: 'sell_side'
      doc: 'Sell Side'
  security_trading_status:
    2:
      id: 'trading_halt'
      doc: 'Trading Halt'
    4:
      id: 'close'
      doc: 'Close'
    15:
      id: 'new_price_indication'
      doc: 'New Price Indication'
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    20:
      id: 'unknownor_invalid'
      doc: 'Unknown or Invalid'
    21:
      id: 'pre_open'
      doc: 'Pre Open'
    24:
      id: 'pre_cross'
      doc: 'Pre Cross'
    25:
      id: 'cross'
      doc: 'Cross'
    26:
      id: 'post_close'
      doc: 'Post Close'
    103:
      id: 'no_change'
      doc: 'No Change'
  halt_reason:
    0:
      id: 'group_schedule'
      doc: 'Group Schedule'
    1:
      id: 'surveillance_intervention'
      doc: 'Surveillance Intervention'
    2:
      id: 'market_event'
      doc: 'Market Event'
    3:
      id: 'instrument_activation'
      doc: 'Instrument Activation'
    4:
      id: 'instrument_expiration'
      doc: 'Instrument Expiration'
    5:
      id: 'unknown'
      doc: 'Unknown'
    6:
      id: 'recovery_in_process'
      doc: 'Recovery In Process'
  security_trading_event:
    0:
      id: 'no_event'
      doc: 'No Event'
    1:
      id: 'no_cancel'
      doc: 'No Cancel'
    4:
      id: 'reset_statistics'
      doc: 'Reset Statistics'
    5:
      id: 'implied_matching_on'
      doc: 'Implied Matching ON'
    6:
      id: 'implied_matching_off'
      doc: 'Implied Matching OFF'
  md_update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete_field'
      doc: 'Delete'
    3:
      id: 'delete_thru'
      doc: 'Delete Thru'
    4:
      id: 'delete_from'
      doc: 'Delete From'
    5:
      id: 'overlay'
      doc: 'Overlay'
  md_entry_type_book:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x45:
      id: 'implied_bid'
      doc: 'Implied Bid'
    0x46:
      id: 'implied_offer'
      doc: 'Implied Offer'
    0x4a:
      id: 'book_reset'
      doc: 'Book Reset'
  md_entry_type_daily_statistics:
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x42:
      id: 'cleared_volume'
      doc: 'Cleared Volume'
    0x43:
      id: 'open_interest'
      doc: 'Open Interest'
    0x57:
      id: 'fixing_price'
      doc: 'Fixing Price'
  open_close_settl_flag:
    0:
      id: 'daily_open_price'
      doc: 'Daily Open Price'
    5:
      id: 'indicative_opening_price'
      doc: 'Indicative Opening Price'
  md_entry_type_statistics:
    0x34:
      id: 'open_price'
      doc: 'Open Price'
    0x37:
      id: 'high_trade'
      doc: 'High Trade'
    0x38:
      id: 'low_trade'
      doc: 'Low Trade'
    0x4e:
      id: 'highest_bid'
      doc: 'Highest Bid'
    0x4f:
      id: 'lowest_offer'
      doc: 'Lowest Offer'
  aggressor_side:
    0:
      id: 'no_aggressor'
      doc: 'No Aggressor'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x32:
      id: 'trade'
      doc: 'Trade'
    0x34:
      id: 'opening_price'
      doc: 'Opening Price'
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x37:
      id: 'trading_session_high_price'
      doc: 'Trading Session High Price'
    0x38:
      id: 'trading_session_low_price'
      doc: 'Trading Session Low Price'
    0x42:
      id: 'trade_volume'
      doc: 'Trade Volume'
    0x43:
      id: 'open_interest'
      doc: 'Open Interest'
    0x45:
      id: 'implied_bid'
      doc: 'Implied Bid'
    0x46:
      id: 'implied_offer'
      doc: 'Implied Offer'
    0x4a:
      id: 'empty_book'
      doc: 'Empty Book'
    0x4e:
      id: 'session_high_bid'
      doc: 'Session High Bid'
    0x4f:
      id: 'session_low_offer'
      doc: 'Session Low Offer'
    0x57:
      id: 'fixing_price'
      doc: 'Fixing Price'
    0x65:
      id: 'electronic_volume'
      doc: 'Electronic Volume'
    0x67:
      id: 'threshold_limitsand_price_band_variation'
      doc: 'Threshold Limits and Price Band Variation'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put Option'
    1:
      id: 'call'
      doc: 'Call Option'

