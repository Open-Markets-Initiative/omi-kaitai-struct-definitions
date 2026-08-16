# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex Streamlined Sbe v5.9
#
# Protocol:
#   Organization: CME Group
#   Protocol: Streamlined Market Data
#   Encoding: Simple Binary Encoding
#   Version: 5.9
#   Date: 4/04/2018
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
  id: cme_globex_streamlined_sbe_v5_9_udp
  title: Cme Globex Streamlined Sbe v5.9
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Streamlined Market Data Sbe v5.9'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/SBE+-+Streamlined+Market+Data

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
        doc: 'Template ID and length of message root'
      - id: payload
        size: message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::admin_login': admin_login
            'template_id::admin_logout': admin_logout
            'template_id::md_incremental_refresh_eris_reference_data_and_daily_statistics': md_incremental_refresh_eris_reference_data_and_daily_statistics
            'template_id::md_news_indices': md_news_indices
            'template_id::md_incremental_refresh_trade_blocks_340': md_incremental_refresh_trade_blocks_340
            'template_id::quote_request': quote_request
            'template_id::md_instrument_definition_indices': md_instrument_definition_indices
            'template_id::md_incremental_refresh_indices': md_incremental_refresh_indices
            'template_id::md_incremental_refresh_trade_blocks_349': md_incremental_refresh_trade_blocks_349
            'template_id::md_incremental_refresh_eris_351': md_incremental_refresh_eris_351
            'template_id::md_incremental_refresh_eris_353': md_incremental_refresh_eris_353
            'template_id::md_incremental_refresh_ot_c_356': md_incremental_refresh_ot_c_356
            'template_id::md_instrument_definition_eris': md_instrument_definition_eris
            'template_id::md_incremental_refresh_trade_blocks_365': md_incremental_refresh_trade_blocks_365
            'template_id::md_incremental_refresh_ot_c_366': md_incremental_refresh_ot_c_366
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
  md_incremental_refresh_eris_reference_data_and_daily_statistics:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: eris_reference_data_groups
        type: eris_reference_data_groups
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
  eris_reference_data_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_reference_data_group
        type: eris_reference_data_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group_8
        type: u1
  eris_reference_data_group:
    seq:
      - id: md_update_action_char
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data update action'
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data entry'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_decimal_optional
        type: md_entry_px_decimal_optional
        doc: 'Number of entries in Market Data message'
      - id: open_close_settl_flag
        type: s1_nullable
        doc: 'Indicates whether the price is preliminary or previous day. Nullable, No Value = 127'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: cal_fut_px_optional
        type: cal_fut_px_optional
        doc: 'Number of entries in Market Data message'
      - id: reference_id_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'For future use'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 18446744073709551615'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_26
        type: str
        size: 26
        encoding: ASCII
        doc: 'Indicates the product code for the instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: coupon_rate_optional
        type: coupon_rate_optional
        doc: 'Number of entries in Market Data message'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trade referenced in this message in YYYYMMDD format (expressed in local time at place of trade). Returned only in trade and trade cancel execution reports. Nullable, No Value = 65535'
      - id: fair_coupon_pct
        type: fair_coupon_pct
        doc: 'Number of entries in Market Data message'
      - id: leg_purchase_rate
        type: leg_purchase_rate
        doc: 'Number of entries in Market Data message'
      - id: fixed_npv
        type: fixed_npv
        doc: 'Number of entries in Market Data message'
      - id: float_npv
        type: float_npv
        doc: 'Number of entries in Market Data message'
      - id: npv
        type: npv
        doc: 'Number of entries in Market Data message'
      - id: accrued_coupons
        type: accrued_coupons
        doc: 'Number of entries in Market Data message'
      - id: daily_incremental_eris_pai
        type: daily_incremental_eris_pai
        doc: 'Number of entries in Market Data message'
      - id: eris_pai
        type: eris_pai
        doc: 'Number of entries in Market Data message'
      - id: fed_funds_rate
        type: fed_funds_rate
        doc: 'Number of entries in Market Data message'
      - id: min_price_increment_optional
        type: min_price_increment_optional
        doc: 'Number of entries in Market Data message'
      - id: fixed_payment
        type: fixed_payment
        doc: 'Number of entries in Market Data message'
      - id: floating_payment
        type: floating_payment
        doc: 'Number of entries in Market Data message'
      - id: next_fixed_payment_date
        type: u2_nullable
        doc: 'The date the next fixed payment will be made. Nullable, No Value = 65535'
      - id: next_fixed_payment_amount
        type: next_fixed_payment_amount
        doc: 'Number of entries in Market Data message'
      - id: next_floating_payment_amount
        type: next_floating_payment_amount
        doc: 'Number of entries in Market Data message'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates the business date for previous settlement price. Nullable, No Value = 65535'
      - id: previous_eris_pai
        type: previous_eris_pai
        doc: 'Number of entries in Market Data message'
      - id: fed_funds_date
        type: u2_nullable
        doc: 'The date that the for which the fed funds date was published. Nullable, No Value = 65535'
      - id: accrual_days
        type: u4_nullable
        doc: 'How many days have passed since settlement price was last calculated. Nullable, No Value = 4294967295'
      - id: nominal
        type: u8_nullable
        doc: 'This is the notional value used to calculate NPV and Fixed and Floating Payment amounts. Nullable, No Value = 18446744073709551615'
      - id: leg_credit_rating
        type: str
        size: 6
        encoding: ASCII
        doc: 'Description of Float Rate'
      - id: leg_contract_multiplier
        type: leg_contract_multiplier
        doc: 'Number of entries in Market Data message'
      - id: next_floating_payment_date
        type: u2_nullable
        doc: 'The date the next floating payment will be made. Nullable, No Value = 65535'
      - id: p_v_01
        type: p_v_01
        doc: 'Number of entries in Market Data message'
      - id: d_v_01
        type: d_v_01
        doc: 'Number of entries in Market Data message'
      - id: settlement_npv
        type: settlement_npv
        doc: 'Number of entries in Market Data message'
      - id: final_settlement_futures_price
        type: final_settlement_futures_price
        doc: 'Number of entries in Market Data message'
      - id: security_description
        type: str
        size: 30
        encoding: ASCII
        doc: 'Ticker symbol. Common, &amp;quot;human understood&amp;quot; representation of the security'
      - id: eris_security_alt_id_groups
        type: eris_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
      - id: incremental_refresh_eris_related_instruments_groups
        type: incremental_refresh_eris_related_instruments_groups
        doc: 'NoRelatedInstruments Block'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
  md_entry_px_decimal_optional:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  settl_price_type:
    seq:
      - id: final_daily
        type: b1
        doc: 'FinalDaily'
      - id: actual
        type: b1
        doc: 'Actual'
      - id: rounded
        type: b1
        doc: 'Rounded'
      - id: reserved_bits
        type: b1
        doc: 'ReservedBits'
      - id: unused_settl_price_type_4
        type: b1
        doc: 'Unused SettlPriceType 4'
      - id: unused_settl_price_type_5
        type: b1
        doc: 'Unused SettlPriceType 5'
      - id: unused_settl_price_type_6
        type: b1
        doc: 'Unused SettlPriceType 6'
      - id: null_value
        type: b1
        doc: 'NullValue'
  cal_fut_px_optional:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  coupon_rate_optional:
    seq:
      - id: mantissa_32
        type: s4
        doc: 'mantissa. Nullable, No Value = 2147483647'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa_32 * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  fair_coupon_pct:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  leg_purchase_rate:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  fixed_npv:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  float_npv:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  npv:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  accrued_coupons:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  daily_incremental_eris_pai:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  eris_pai:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  fed_funds_rate:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  min_price_increment_optional:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  fixed_payment:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  floating_payment:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  next_fixed_payment_amount:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  next_floating_payment_amount:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  previous_eris_pai:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  leg_contract_multiplier:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  p_v_01:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  d_v_01:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  settlement_npv:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  final_settlement_futures_price:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  eris_security_alt_id_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_security_alt_id_group
        type: eris_security_alt_id_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in AltID group'
  eris_security_alt_id_group:
    seq:
      - id: security_alt_id_50
        type: str
        size: 26
        encoding: ASCII
        doc: 'Expanded instrument description'
      - id: security_alt_id_source_optional
        type: str_1_nullable
        doc: 'Identifies class or source of the SecurityAltID (455) value. Nullable, No Value = 0'
  incremental_refresh_eris_related_instruments_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_eris_related_instruments_group
        type: incremental_refresh_eris_related_instruments_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of related instruments group'
  incremental_refresh_eris_related_instruments_group:
    seq:
      - id: related_instrument_type
        type: u1_nullable
        doc: 'The type of instrument relationship. Nullable, No Value = 255'
      - id: related_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Related instrument Symbol'
      - id: related_security_group
        type: str
        size: 26
        encoding: ASCII
        doc: 'Instrument Symbol Suffix for T+1 (Next Trading day)'
  events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: events_group
        type: events_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of repeating EventType entries'
  events_group:
    seq:
      - id: event_type_optional
        type: u1_nullable
        doc: 'Code to represent the type of event. Nullable, No Value = 255'
      - id: event_time_optional
        type: u8_nullable
        doc: 'Time of event. This is number of days since unix epoch. Nullable, No Value = 18446744073709551615'
  md_news_indices:
    seq:
      - id: headline
        type: str
        size: 50
        encoding: ASCII
        doc: 'The headline of a News message'
      - id: orig_time
        type: nanosecond_timestamp_nullable
        doc: 'Time of message origination expressed as number of nanoseconds since unix epoch. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: md_feed_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed'
      - id: news_indices_related_sym_groups
        type: news_indices_related_sym_groups
        doc: 'NoRelatedSym Block'
      - id: lines_of_text_groups
        type: lines_of_text_groups
        doc: 'NoLinesOfText Block'
  news_indices_related_sym_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: news_indices_related_sym_group
        type: news_indices_related_sym_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Specifies the number of repeating symbols specified'
  news_indices_related_sym_group:
    seq:
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
  lines_of_text_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: lines_of_text_group
        type: lines_of_text_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Identifies number of lines of text body'
  lines_of_text_group:
    seq:
      - id: text_500
        type: str
        size: 500
        encoding: ASCII
        doc: 'This general purpose text field could contain any post-trade instructions used by customers based on mutual understanding with their clearing firm. If incoming value is greater than max length then take the right most fifty bytes. No validation is done for valid values and this is a pass through to clearing. After any right justification if applicable the incoming value is flipped back in the execution report and also becomes an attribute of the order'
  md_incremental_refresh_trade_blocks_340:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages
        type: u2
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799)'
      - id: trade_blocks_original_groups
        type: trade_blocks_original_groups
        doc: 'NoMDEntries Block'
  trade_blocks_original_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_original_group
        type: trade_blocks_original_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  trade_blocks_original_group:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update Action'
      - id: security_id
        type: u8_nullable
        doc: 'Unique security ID. Nullable, No Value = 18446744073709551615'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Price of the Market Data Entry. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 18446744073709551615'
      - id: number_of_orders
        type: s4_nullable
        doc: 'The total number of real orders per instrument that participated in a match step within a match event. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade Entry ID per Instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. If there is no value present, then there is no aggressor. Nullable, No Value = 255'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'SecuritySubType for CDS only'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of entries in Market Data message'
      - id: security_exchange_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size'
      - id: unit_of_measure_currency_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the ISO Currency code if it is a currency product'
      - id: unit_of_measure_qty_optional
        type: decimal_s8_7_nullable
        doc: 'This field contains the notional value for each instrument. The notional value is equivalent to the corresponding premium-quoted contract. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: price_type
        type: u2_nullable
        doc: 'Valid price types for intraday trade. Nullable, No Value = 65535'
      - id: trd_type
        type: u1_nullable
        doc: 'Valid trade types for intraday trade. Nullable, No Value = 255'
      - id: md_entry_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Market data entry identifier to map multiple prices of a single trade'
      - id: put_or_call
        type: u1_nullable
        doc: 'Indicates whether an option instrument is a put or call. Nullable, No Value = 255'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'Strike Price for an option instrument. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: restructuring_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'A category of CDS credit event in which the underlying bond experiences a restructuring'
      - id: seniority
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specifies which issue (underlying bond) will receive payment priority in the event of a default'
      - id: reference_id_100
        type: str
        size: 100
        encoding: ASCII
        doc: 'For future use'
      - id: strategy_link_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies the multileg strategy (e.g. spread) to which the trade belongs. This links together trade legs executed as part of a strategy during a single match event'
      - id: leg_ref_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'Used to correlate leg instrument definitions with their executions. Cross referenced to Tag 1788'
      - id: trade_blocks_underlyings_groups
        type: trade_blocks_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: trade_blocks_party_ids_groups
        type: trade_blocks_party_ids_groups
        doc: 'NoPartyIDs Block'
      - id: trade_blocks_original_legs_groups
        type: trade_blocks_original_legs_groups
        doc: 'NoLegs Block'
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
  trade_blocks_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_underlyings_group
        type: trade_blocks_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of underlying legs that make up the security'
  trade_blocks_underlyings_group:
    seq:
      - id: underlying_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Underlying Security''s symbol'
      - id: underlying_maturity_month_year
        type: underlying_maturity_month_year
        doc: 'Number of underlying legs that make up the security'
      - id: underlying_security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Underlying Security''s SecurityType'
      - id: underlying_security_exchange_string_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Underlying Security''s SecurityExchange'
  underlying_maturity_month_year:
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
  trade_blocks_party_ids_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_party_ids_group
        type: trade_blocks_party_ids_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of party roles'
  trade_blocks_party_ids_group:
    seq:
      - id: party_id
        type: str
        size: 50
        encoding: ASCII
        doc: 'Party identifier/code'
      - id: party_role
        type: str
        size: 2
        encoding: ASCII
        doc: 'Identifies the type or role of the PartyID specified'
  trade_blocks_original_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_original_legs_group
        type: trade_blocks_original_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of legs (repeating groups)'
  trade_blocks_original_legs_group:
    seq:
      - id: leg_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'This tag contains the instrument group of the requested security definition. Must be present when tag 555-NoLegs is present. Also must be first tag in repeating group. Multileg instrument''s individual security''s Symbol'
      - id: leg_security_id
        type: u8_nullable
        doc: 'Multileg instrument''s individual security''s SecurityID. Nullable, No Value = 18446744073709551615'
      - id: leg_security_group
        type: str
        size: 12
        encoding: ASCII
        doc: 'Leg equivalent of body tag 1151-SecurityGroup (i.e. leg ''product code'')'
      - id: leg_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'Used to correlate leg instrument definitions with their executions.Cross referenced in Tag 654'
      - id: leg_security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Identifies the type of leg instrument'
      - id: leg_maturity_month_year
        type: leg_maturity_month_year
        doc: 'Number of legs (repeating groups)'
      - id: leg_maturity_date
        type: u2_nullable
        doc: 'Multileg instrument''s individual security''s leg MaturityDate. Nullable, No Value = 65535'
      - id: leg_strike_price_pricenull
        type: decimal_s8_7_nullable
        doc: 'Multileg instrument''s individual security''s StrikePrice. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: leg_unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Multileg instrument''s individual security''s leg UnitOfMeasure'
      - id: leg_unit_of_measure_qty_pricenull
        type: decimal_s8_7_nullable
        doc: 'Multileg instrument''s individual security''s leg UnitOfMeasureQty. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: leg_security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Multileg instrument''s individual security''s leg SecurityExchange'
      - id: leg_ratio_qty_u_int_16_null
        type: u2_nullable
        doc: 'The ratio of quantity for this individual leg relative to the entire multileg security. Nullable, No Value = 65535'
      - id: leg_side
        type: u1_nullable
        doc: 'The side of this individual leg (multileg security). Nullable, No Value = 255'
      - id: leg_put_or_call
        type: u1_nullable
        doc: 'Multileg instrument''s individual security''s leg option put or call. Nullable, No Value = 255'
      - id: leg_unit_of_measure_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the currency of the unit of measure. Conditionally required when LegUnitOfMeasure(999) = Ccy'
  leg_maturity_month_year:
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
  quote_request:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: quote_req_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Quote request ID defined by the exchange'
      - id: quote_request_related_sym_groups
        type: quote_request_related_sym_groups
        doc: 'NoRelatedSym Block'
  quote_request_related_sym_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: quote_request_related_sym_group
        type: quote_request_related_sym_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Specifies the number of repeating symbols specified'
  quote_request_related_sym_group:
    seq:
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: order_qty
        type: u8_nullable
        doc: 'Quantity Requested. Nullable, No Value = 18446744073709551615'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: security_group_26
        type: str
        size: 26
        encoding: ASCII
        doc: 'Indicates the product code for the instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: security_type_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the type of instrument'
      - id: quote_type
        type: u1_nullable
        doc: 'Type of quote requested. A tradable quote can trade against other orders and quotes upon acceptance. Nullable, No Value = 255'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
  md_instrument_definition_indices:
    seq:
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: product
        type: s1
        doc: 'Indicates the type of product the instrument is associated with in the message'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the currency for the instrument traded'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Included on the message when a modification or deletion occurs'
      - id: md_feed_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed'
      - id: appl_id
        type: u2_nullable
        doc: 'This value indicates the channel ID as defined in the XML configuration file. Nullable, No Value = 65535'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
  inst_attrib_groups:
    seq:
      - id: group_size_encoding
        type: group_size_encoding
        doc: 'Repeating group dimensions'
      - id: inst_attrib_group
        type: inst_attrib_group
        repeat: expr
        repeat-expr: group_size_encoding.num_in_group
        doc: 'Number of repeating InstrAttribType entries'
  group_size_encoding:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u2
  inst_attrib_group:
    seq:
      - id: inst_attrib_type
        type: u1
        doc: 'Code to represent the type of instrument attribute'
      - id: inst_attrib_value
        type: str
        size: 100
        encoding: ASCII
        doc: 'Attribute value appropriate to the InstrAttribType (871) field'
  md_incremental_refresh_indices:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: md_feed_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: incremental_refresh_indices_groups
        type: incremental_refresh_indices_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_indices_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_indices_group
        type: incremental_refresh_indices_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  incremental_refresh_indices_group:
    seq:
      - id: md_entry_type_indices
        type: u1
        enum: md_entry_type_indices
        doc: 'Indicates Market Data Entry Type'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_decimal
        type: md_entry_px_decimal
        doc: 'Number of entries in Market Data message'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 18446744073709551615'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: open_close_settl_flag
        type: s1_nullable
        doc: 'Indicates whether the price is preliminary or previous day. Nullable, No Value = 127'
      - id: yield_type
        type: str
        size: 8
        encoding: ASCII
        doc: 'Type of yield'
      - id: yield_field
        type: yield_field
        doc: 'Number of entries in Market Data message'
      - id: net_chg_prev_day
        type: net_chg_prev_day
        doc: 'Number of entries in Market Data message'
      - id: net_pct_chg
        type: net_pct_chg
        doc: 'Number of entries in Market Data message'
      - id: percent_trading
        type: percent_trading
        doc: 'Number of entries in Market Data message'
      - id: md_entry_code
        type: u1_nullable
        doc: 'List of conditions describing a index value. Nullable, No Value = 255'
      - id: md_entry_date
        type: s4_nullable
        doc: 'Indicates Market Data Entry Date. Nullable, No Value = 2147483647'
      - id: md_entry_time
        type: s4_nullable
        doc: 'Indicates Market Data Entry Timestamp. Nullable, No Value = 2147483647'
      - id: reference_id_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'For future use'
  md_entry_px_decimal:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  yield_field:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  net_chg_prev_day:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  net_pct_chg:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  percent_trading:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  md_incremental_refresh_trade_blocks_349:
    seq:
      - id: transact_time_optional
        type: nanosecond_timestamp_nullable
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Not present for EFP (828=2) and EFR (828=11) transactions. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages
        type: u2
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799)'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trade referenced in this message in YYYYMMDD format (expressed in local time at place of trade). Returned only in trade and trade cancel execution reports. Nullable, No Value = 65535'
      - id: trade_blocks_legacy_groups
        type: trade_blocks_legacy_groups
        doc: 'NoMDEntries Block'
  trade_blocks_legacy_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_legacy_group
        type: trade_blocks_legacy_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  trade_blocks_legacy_group:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update Action'
      - id: security_id
        type: u8_nullable
        doc: 'Unique security ID. Nullable, No Value = 18446744073709551615'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Price of the Market Data Entry. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: md_entry_size
        doc: 'Number of entries in Market Data message'
      - id: number_of_orders
        type: s4_nullable
        doc: 'The total number of real orders per instrument that participated in a match step within a match event. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade Entry ID per Instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. If there is no value present, then there is no aggressor. Nullable, No Value = 255'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'SecuritySubType for CDS only'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of entries in Market Data message'
      - id: security_exchange_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size'
      - id: unit_of_measure_currency_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the ISO Currency code if it is a currency product'
      - id: unit_of_measure_qty_optional
        type: decimal_s8_7_nullable
        doc: 'This field contains the notional value for each instrument. The notional value is equivalent to the corresponding premium-quoted contract. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: price_type
        type: u2_nullable
        doc: 'Valid price types for intraday trade. Nullable, No Value = 65535'
      - id: trd_type
        type: u1_nullable
        doc: 'Valid trade types for intraday trade. Nullable, No Value = 255'
      - id: md_entry_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Market data entry identifier to map multiple prices of a single trade'
      - id: put_or_call
        type: u1_nullable
        doc: 'Indicates whether an option instrument is a put or call. Nullable, No Value = 255'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'Strike Price for an option instrument. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: restructuring_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'A category of CDS credit event in which the underlying bond experiences a restructuring'
      - id: seniority
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specifies which issue (underlying bond) will receive payment priority in the event of a default'
      - id: reference_id_100
        type: str
        size: 100
        encoding: ASCII
        doc: 'For future use'
      - id: strategy_link_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies the multileg strategy (e.g. spread) to which the trade belongs. This links together trade legs executed as part of a strategy during a single match event'
      - id: leg_ref_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'Used to correlate leg instrument definitions with their executions. Cross referenced to Tag 1788'
      - id: trade_blocks_underlyings_groups
        type: trade_blocks_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: trade_blocks_party_ids_groups
        type: trade_blocks_party_ids_groups
        doc: 'NoPartyIDs Block'
      - id: trade_blocks_original_legs_groups
        type: trade_blocks_original_legs_groups
        doc: 'NoLegs Block'
  md_entry_size:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  md_incremental_refresh_eris_351:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: eris_original_groups
        type: eris_original_groups
        doc: 'NoMDEntries Block'
  eris_original_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_original_group
        type: eris_original_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  eris_original_group:
    seq:
      - id: md_update_action_char
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data update action'
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data entry'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_decimal
        type: md_entry_px_decimal
        doc: 'Number of entries in Market Data message'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 18446744073709551615'
      - id: cal_fut_px
        type: cal_fut_px
        doc: 'Number of entries in Market Data message'
      - id: md_entry_position_no
        type: s4_nullable
        doc: 'Position in the book. Nullable, No Value = 2147483647'
      - id: number_of_orders
        type: s4_nullable
        doc: 'The total number of real orders per instrument that participated in a match step within a match event. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade Entry ID per Instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. If there is no value present, then there is no aggressor. Nullable, No Value = 255'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_26
        type: str
        size: 26
        encoding: ASCII
        doc: 'Indicates the product code for the instrument'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: reference_id_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'For future use'
      - id: eris_security_alt_id_groups
        type: eris_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
  cal_fut_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  md_incremental_refresh_eris_353:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: eris_groups
        type: eris_groups
        doc: 'NoMDEntries Block'
  eris_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_group
        type: eris_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  eris_group:
    seq:
      - id: md_update_action_char
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data update action'
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data entry'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_decimal
        type: md_entry_px_decimal
        doc: 'Number of entries in Market Data message'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Quantity or volume represented by the Market Data Entry. Nullable, No Value = 18446744073709551615'
      - id: cal_fut_px
        type: cal_fut_px
        doc: 'Number of entries in Market Data message'
      - id: md_entry_position_no
        type: s4_nullable
        doc: 'Position in the book. Nullable, No Value = 2147483647'
      - id: number_of_orders
        type: s4_nullable
        doc: 'The total number of real orders per instrument that participated in a match step within a match event. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade Entry ID per Instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. If there is no value present, then there is no aggressor. Nullable, No Value = 255'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_26
        type: str
        size: 26
        encoding: ASCII
        doc: 'Indicates the product code for the instrument'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: reference_id_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'For future use'
      - id: md_quote_type
        type: u1_nullable
        doc: 'Identifies the type of quote. 0=Indicative, 1=Tradeable. Nullable, No Value = 255'
      - id: eris_security_alt_id_groups
        type: eris_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
  md_incremental_refresh_ot_c_356:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trade referenced in this message in YYYYMMDD format (expressed in local time at place of trade). Returned only in trade and trade cancel execution reports. Nullable, No Value = 65535'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: otc_original_groups
        type: otc_original_groups
        doc: 'NoMDEntries Block'
  otc_original_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: otc_original_group
        type: otc_original_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  otc_original_group:
    seq:
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data entry'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px_optional
        type: decimal_s8_7_nullable
        doc: 'Price of the Market Data Entry. Implied decimal with scale 1e-7. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: md_entry_size
        doc: 'Number of entries in Market Data message'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of entries in Market Data message'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: restructuring_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'A category of CDS credit event in which the underlying bond experiences a restructuring'
      - id: seniority
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specifies which issue (underlying bond) will receive payment priority in the event of a default'
      - id: notional_percentage_outstanding
        type: decimal_s4_4_nullable
        doc: 'Indicates the notional percentage of the deal that is still outstanding based on the remaining components of the index. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: put_or_call
        type: u1_nullable
        doc: 'Indicates whether an option instrument is a put or call. Nullable, No Value = 255'
      - id: strike_price_decimal
        type: strike_price_decimal
        doc: 'Number of entries in Market Data message'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size'
      - id: unit_of_measure_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the ISO Currency code if it is a currency product'
      - id: unit_of_measure_qty_decimal
        type: unit_of_measure_qty_decimal
        doc: 'Number of entries in Market Data message'
      - id: md_entry_date
        type: s4_nullable
        doc: 'Indicates Market Data Entry Date. Nullable, No Value = 2147483647'
      - id: open_close_settl_flag
        type: s1_nullable
        doc: 'Indicates whether the price is preliminary or previous day. Nullable, No Value = 127'
      - id: price_type
        type: u2_nullable
        doc: 'Valid price types for intraday trade. Nullable, No Value = 65535'
      - id: settl_date
        type: u2_nullable
        doc: 'Indicates date of settlement. Nullable, No Value = 65535'
      - id: quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Condition describing a quote'
      - id: market_sector
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies the market in which a product trades. For e.g. CDS, Dairy'
      - id: sector_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of related products. For e.g. High Yield, Cheese'
      - id: sector_sub_group
        type: str
        size: 26
        encoding: ASCII
        doc: 'A further qualification of Sector Group For e.g. North American'
      - id: product_complex
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies an entire suite of products for a given market'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'SecuritySubType for CDS only'
      - id: vol_type
        type: u2_nullable
        doc: 'Volume types for end of day volume. Nullable, No Value = 65535'
      - id: reference_id_100
        type: str
        size: 100
        encoding: ASCII
        doc: 'For future use'
      - id: otc_underlyings_groups
        type: otc_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: otc_security_alt_id_groups
        type: otc_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
  strike_price_decimal:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  unit_of_measure_qty_decimal:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  otc_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: otc_underlyings_group
        type: otc_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of underlying legs that make up the security'
  otc_underlyings_group:
    seq:
      - id: underlying_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Underlying Security''s symbol'
      - id: underlying_maturity_month_year
        type: underlying_maturity_month_year
        doc: 'Number of underlying legs that make up the security'
      - id: underlying_security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Underlying Security''s SecurityType'
      - id: underlying_security_exchange_security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Underlying Security''s SecurityExchange and it can be used to identify the underlying security'
  otc_security_alt_id_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: otc_security_alt_id_group
        type: otc_security_alt_id_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in AltID group'
  otc_security_alt_id_group:
    seq:
      - id: security_alt_i_d_string_length_50
        type: str
        size: 50
        encoding: ASCII
        doc: 'Expanded instrument description'
      - id: security_alt_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies class or source of the SecurityAltID (455) value'
  md_instrument_definition_eris:
    seq:
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_type_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Identifies the type of instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the currency for the instrument traded'
      - id: min_price_increment
        type: min_price_increment
        doc: 'MDInstrumentDefinitionEris'
      - id: security_update_action
        type: u1
        enum: security_update_action
        doc: 'Included on the message when a modification or deletion occurs'
      - id: rate_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'Rate type for the swap and spread'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies user-defined instruments. If the tag is not present, the instrument is not user-defined'
      - id: appl_id
        type: u2_nullable
        doc: 'This value indicates the channel ID as defined in the XML configuration file. Nullable, No Value = 65535'
      - id: eris_feed_types_groups
        type: eris_feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: eris_security_alt_id_groups
        type: eris_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
      - id: eris_legs_groups
        type: eris_legs_groups
        doc: 'NoLegs Block'
  min_price_increment:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  eris_feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_feed_types_group
        type: eris_feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of feed type repeating group entries'
  eris_feed_types_group:
    seq:
      - id: md_feed_type_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed. This value will always be EBX for Eris'
      - id: market_depth
        type: u1_nullable
        doc: 'Indicated the level on the book traded. Nullable, No Value = 255'
  eris_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: eris_legs_group
        type: eris_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of legs (repeating groups)'
  eris_legs_group:
    seq:
      - id: leg_benchmark_curve_name
        type: str
        size: 5
        encoding: ASCII
        doc: 'Required for Floating Rate Leg. Floating rate reference'
      - id: rate_descriptor
        type: str
        size: 8
        encoding: ASCII
        doc: 'Rate Descriptor'
      - id: previous_fixing_date
        type: u2_nullable
        doc: 'Issue date for one leg of a multi-issue trade. It is the previous fixing date on the float leg. Nullable, No Value = 65535'
      - id: leg_pay_frequencey
        type: str
        size: 3
        encoding: ASCII
        doc: 'Payment frequency of fixed and floating rates expresses as a period'
      - id: previous_fixing_rate
        type: previous_fixing_rate
        doc: 'Number of legs (repeating groups)'
      - id: leg_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'This tag contains the instrument group of the requested security definition. Must be present when tag 555-NoLegs is present. Also must be first tag in repeating group. Multileg instrument''s individual security''s Symbol'
      - id: leg_ratio_qty_int_32_null
        type: s4_nullable
        doc: 'The ratio of quantity for this individual leg relative to the entire multi-leg instrument. Nullable, No Value = 2147483647'
      - id: leg_side
        type: u1_nullable
        doc: 'The side of this individual leg (multileg security). Nullable, No Value = 255'
      - id: leg_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Currency associated with a particular Leg''s quantity'
      - id: leg_security_type_4
        type: str
        size: 8
        encoding: ASCII
        doc: 'Identifies the type of instrument'
      - id: leg_security_group
        type: str
        size: 12
        encoding: ASCII
        doc: 'Leg equivalent of body tag 1151-SecurityGroup (i.e. leg ''product code'')'
      - id: leg_date_offset
        type: s1_nullable
        doc: 'Float reset date offset, specified when LegType = FLOAT. Nullable, No Value = 127'
      - id: interpolation_factor
        type: interpolation_factor
        doc: 'Number of legs (repeating groups)'
      - id: eris_security_alt_id_groups
        type: eris_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
  previous_fixing_rate:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  interpolation_factor:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  md_incremental_refresh_trade_blocks_365:
    seq:
      - id: transact_time_optional
        type: nanosecond_timestamp_nullable
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Not present for EFP (828=2) and EFR (828=11) transactions. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages
        type: u2
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799)'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trade referenced in this message in YYYYMMDD format (expressed in local time at place of trade). Returned only in trade and trade cancel execution reports. Nullable, No Value = 65535'
      - id: trade_blocks_groups
        type: trade_blocks_groups
        doc: 'NoMDEntries Block'
  trade_blocks_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_group
        type: trade_blocks_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  trade_blocks_group:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update Action'
      - id: security_id
        type: u8_nullable
        doc: 'Unique security ID. Nullable, No Value = 18446744073709551615'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Price of the Market Data Entry. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: md_entry_size
        doc: 'Number of entries in Market Data message'
      - id: number_of_orders
        type: s4_nullable
        doc: 'The total number of real orders per instrument that participated in a match step within a match event. Nullable, No Value = 2147483647'
      - id: trade_id
        type: s4
        doc: 'Unique Trade Entry ID per Instrument and Trading Date'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. If there is no value present, then there is no aggressor. Nullable, No Value = 255'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'SecuritySubType for CDS only'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of entries in Market Data message'
      - id: security_exchange_4
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size'
      - id: unit_of_measure_currency_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the ISO Currency code if it is a currency product'
      - id: unit_of_measure_qty_decimal_optional
        type: unit_of_measure_qty_decimal_optional
        doc: 'Number of entries in Market Data message'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: price_type
        type: u2_nullable
        doc: 'Valid price types for intraday trade. Nullable, No Value = 65535'
      - id: trd_type
        type: u1_nullable
        doc: 'Valid trade types for intraday trade. Nullable, No Value = 255'
      - id: md_entry_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Market data entry identifier to map multiple prices of a single trade'
      - id: put_or_call
        type: u1_nullable
        doc: 'Indicates whether an option instrument is a put or call. Nullable, No Value = 255'
      - id: strike_price_decimal_optional
        type: strike_price_decimal_optional
        doc: 'Number of entries in Market Data message'
      - id: restructuring_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'A category of CDS credit event in which the underlying bond experiences a restructuring'
      - id: seniority
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specifies which issue (underlying bond) will receive payment priority in the event of a default'
      - id: reference_id_100
        type: str
        size: 100
        encoding: ASCII
        doc: 'For future use'
      - id: strategy_link_id
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies the multileg strategy (e.g. spread) to which the trade belongs. This links together trade legs executed as part of a strategy during a single match event'
      - id: leg_ref_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'Used to correlate leg instrument definitions with their executions. Cross referenced to Tag 1788'
      - id: trade_blocks_underlyings_groups
        type: trade_blocks_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: trade_blocks_party_ids_groups
        type: trade_blocks_party_ids_groups
        doc: 'NoPartyIDs Block'
      - id: trade_blocks_legs_groups
        type: trade_blocks_legs_groups
        doc: 'NoLegs Block'
  unit_of_measure_qty_decimal_optional:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  strike_price_decimal_optional:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  trade_blocks_legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trade_blocks_legs_group
        type: trade_blocks_legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of legs (repeating groups)'
  trade_blocks_legs_group:
    seq:
      - id: leg_symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'This tag contains the instrument group of the requested security definition. Must be present when tag 555-NoLegs is present. Also must be first tag in repeating group. Multileg instrument''s individual security''s Symbol'
      - id: leg_security_id
        type: u8_nullable
        doc: 'Multileg instrument''s individual security''s SecurityID. Nullable, No Value = 18446744073709551615'
      - id: leg_security_group
        type: str
        size: 12
        encoding: ASCII
        doc: 'Leg equivalent of body tag 1151-SecurityGroup (i.e. leg ''product code'')'
      - id: leg_id
        type: str
        size: 17
        encoding: ASCII
        doc: 'Used to correlate leg instrument definitions with their executions.Cross referenced in Tag 654'
      - id: leg_security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Identifies the type of leg instrument'
      - id: leg_maturity_month_year
        type: leg_maturity_month_year
        doc: 'Number of legs (repeating groups)'
      - id: leg_maturity_date
        type: u2_nullable
        doc: 'Multileg instrument''s individual security''s leg MaturityDate. Nullable, No Value = 65535'
      - id: leg_strike_price_decimal_64_null
        type: leg_strike_price_decimal_64_null
        doc: 'Number of legs (repeating groups)'
      - id: leg_unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Multileg instrument''s individual security''s leg UnitOfMeasure'
      - id: leg_unit_of_measure_qty_decimal_64_null
        type: leg_unit_of_measure_qty_decimal_64_null
        doc: 'Number of legs (repeating groups)'
      - id: leg_security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Multileg instrument''s individual security''s leg SecurityExchange'
      - id: leg_ratio_qty_u_int_16_null
        type: u2_nullable
        doc: 'The ratio of quantity for this individual leg relative to the entire multileg security. Nullable, No Value = 65535'
      - id: leg_side
        type: u1_nullable
        doc: 'The side of this individual leg (multileg security). Nullable, No Value = 255'
      - id: leg_put_or_call
        type: u1_nullable
        doc: 'Multileg instrument''s individual security''s leg option put or call. Nullable, No Value = 255'
      - id: leg_unit_of_measure_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the currency of the unit of measure. Conditionally required when LegUnitOfMeasure(999) = Ccy'
  leg_strike_price_decimal_64_null:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  leg_unit_of_measure_qty_decimal_64_null:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = 9223372036854775807'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = 127'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  md_incremental_refresh_ot_c_366:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2_nullable
        doc: 'Indicates date of trade referenced in this message in YYYYMMDD format (expressed in local time at place of trade). Returned only in trade and trade cancel execution reports. Nullable, No Value = 65535'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: batch_total_messages_optional
        type: u2_nullable
        doc: 'Total number of messages contained within batch which is defined by match event indicator (5799). Nullable, No Value = 65535'
      - id: otc_groups
        type: otc_groups
        doc: 'NoMDEntries Block'
  otc_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: otc_group
        type: otc_group
        repeat: expr
        repeat-expr: group_size.num_in_group_8
        doc: 'Number of entries in Market Data message'
  otc_group:
    seq:
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of Market Data entry'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number per Index update'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Price of the Market Data Entry. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: md_entry_size
        doc: 'Number of entries in Market Data message'
      - id: symbol
        type: str
        size: 50
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_group_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Product code'
      - id: security_type
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates type of security'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of entries in Market Data message'
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market used to help identify an instrument'
      - id: product_optional
        type: u1_nullable
        doc: 'Identifies the type of product. Nullable, No Value = 255'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity date of instrument. Nullable, No Value = 65535'
      - id: coupon_rate
        type: decimal_s4_4_nullable
        doc: 'Coupon Rate of the Swap. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: restructuring_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'A category of CDS credit event in which the underlying bond experiences a restructuring'
      - id: seniority
        type: str
        size: 2
        encoding: ASCII
        doc: 'Specifies which issue (underlying bond) will receive payment priority in the event of a default'
      - id: notional_percentage_outstanding
        type: decimal_s4_4_nullable
        doc: 'Indicates the notional percentage of the deal that is still outstanding based on the remaining components of the index. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
      - id: put_or_call
        type: u1_nullable
        doc: 'Indicates whether an option instrument is a put or call. Nullable, No Value = 255'
      - id: strike_price_decimal_optional
        type: strike_price_decimal_optional
        doc: 'Number of entries in Market Data message'
      - id: unit_of_measure
        type: str
        size: 5
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size'
      - id: unit_of_measure_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Indicates the ISO Currency code if it is a currency product'
      - id: unit_of_measure_qty_decimal_optional
        type: unit_of_measure_qty_decimal_optional
        doc: 'Number of entries in Market Data message'
      - id: md_entry_date
        type: s4_nullable
        doc: 'Indicates Market Data Entry Date. Nullable, No Value = 2147483647'
      - id: open_close_settl_flag
        type: s1_nullable
        doc: 'Indicates whether the price is preliminary or previous day. Nullable, No Value = 127'
      - id: price_type
        type: u2_nullable
        doc: 'Valid price types for intraday trade. Nullable, No Value = 65535'
      - id: settl_date
        type: u2_nullable
        doc: 'Indicates date of settlement. Nullable, No Value = 65535'
      - id: quote_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Condition describing a quote'
      - id: market_sector
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies the market in which a product trades. For e.g. CDS, Dairy'
      - id: sector_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'Group of related products. For e.g. High Yield, Cheese'
      - id: sector_sub_group
        type: str
        size: 26
        encoding: ASCII
        doc: 'A further qualification of Sector Group For e.g. North American'
      - id: product_complex
        type: str
        size: 26
        encoding: ASCII
        doc: 'Identifies an entire suite of products for a given market'
      - id: security_sub_type
        type: str
        size: 2
        encoding: ASCII
        doc: 'SecuritySubType for CDS only'
      - id: vol_type
        type: u2_nullable
        doc: 'Volume types for end of day volume. Nullable, No Value = 65535'
      - id: reference_id_100
        type: str
        size: 100
        encoding: ASCII
        doc: 'For future use'
      - id: otc_underlyings_groups
        type: otc_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: otc_security_alt_id_groups
        type: otc_security_alt_id_groups
        doc: 'NoSecurityAltID Block'
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == 127
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
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
  decimal_s8_9:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000000.0
  decimal_s8_9_nullable:
    seq:
      - id: value
        type: decimal_s8_9
    instances:
      is_null:
        value: value.mantissa == 9223372036854775807

enums:
  template_id:
    312:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
    315:
      id: 'admin_login'
      doc: 'AdminLogin'
    316:
      id: 'admin_logout'
      doc: 'AdminLogout'
    333:
      id: 'md_incremental_refresh_eris_reference_data_and_daily_statistics'
      doc: 'MDIncrementalRefreshErisReferenceDataAndDailyStatistics'
    339:
      id: 'md_news_indices'
      doc: 'MDNewsIndices'
    340:
      id: 'md_incremental_refresh_trade_blocks_340'
      doc: 'MDIncrementalRefreshTradeBlocks'
    345:
      id: 'quote_request'
      doc: 'QuoteRequest'
    347:
      id: 'md_instrument_definition_indices'
      doc: 'MDInstrumentDefinitionIndices'
    348:
      id: 'md_incremental_refresh_indices'
      doc: 'MDIncrementalRefreshIndices'
    349:
      id: 'md_incremental_refresh_trade_blocks_349'
      doc: 'MDIncrementalRefreshTradeBlocks'
    351:
      id: 'md_incremental_refresh_eris_351'
      doc: 'MDIncrementalRefreshEris'
    353:
      id: 'md_incremental_refresh_eris_353'
      doc: 'MDIncrementalRefreshEris'
    356:
      id: 'md_incremental_refresh_ot_c_356'
      doc: 'MDIncrementalRefreshOTC'
    363:
      id: 'md_instrument_definition_eris'
      doc: 'MDInstrumentDefinitionEris'
    365:
      id: 'md_incremental_refresh_trade_blocks_365'
      doc: 'MDIncrementalRefreshTradeBlocks'
    366:
      id: 'md_incremental_refresh_ot_c_366'
      doc: 'MDIncrementalRefreshOTC'
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
  md_entry_type_indices:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x32:
      id: 'trade'
      doc: 'Trade'
    0x33:
      id: 'index_value'
      doc: 'Index Value'
    0x34:
      id: 'opening_value'
      doc: 'Opening Value'
    0x35:
      id: 'closing_price'
      doc: 'Closing Price'
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x37:
      id: 'session_high_price'
      doc: 'Session High Price'
    0x38:
      id: 'session_low_price'
      doc: 'Session Low Price'
    0x65:
      id: 'trade_volume'
      doc: 'Trade Volume'
  md_entry_code:
    1:
      id: 'indicative'
      doc: 'Indicative'
    2:
      id: 'pre_market'
      doc: 'PreMarket'
    3:
      id: 'preliminary_close'
      doc: 'PreliminaryClose'
    4:
      id: 'session_close'
      doc: 'SessionClose'
    5:
      id: 'close'
      doc: 'Close'

