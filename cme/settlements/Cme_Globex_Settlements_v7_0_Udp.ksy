# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex Settlements Sbe v7.0
#
# Protocol:
#   Organization: CME Group
#   Protocol: Settlements
#   Encoding: Simple Binary Encoding
#   Version: 7.0
#   Date: 12/03/2018
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
  id: cme_globex_settlements_sbe_v7_0_udp
  title: Cme Globex Settlements Sbe v7.0
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Settlements Sbe v7.0'
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
            'template_id::md_incremental_refresh_settle': md_incremental_refresh_settle
            'template_id::md_incremental_refresh_voi': md_incremental_refresh_voi
            'template_id::md_incremental_refresh_high_low': md_incremental_refresh_high_low
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
  md_incremental_refresh_settle:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Event processing time (UTC), sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: incremental_refresh_settle_groups
        type: incremental_refresh_settle_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_settle_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_settle_group
        type: incremental_refresh_settle_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  incremental_refresh_settle_group:
    seq:
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_entry_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Indicates the type of price'
      - id: product_guid
        type: u8_nullable
        doc: 'Product GUID. Nullable, No Value = 18446744073709551615'
      - id: clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Clearing Product Code'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Security Exchange'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of data blocks'
      - id: put_or_call
        type: u1_nullable
        doc: 'Put or call indicator. Nullable, No Value = 255'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8_nullable
        doc: 'Underlying Product GUID. Nullable, No Value = 18446744073709551615'
      - id: underlying_clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying Clearing Product Code'
      - id: underlying_security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlying Security Type'
      - id: underlying_security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Underlying Security Exchange'
      - id: underlying_maturity_month_year
        type: underlying_maturity_month_year
        doc: 'Number of data blocks'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contract name, symbol'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: security_id
        type: u4_nullable
        doc: 'Security ID. Nullable, No Value = 4294967295'
      - id: formatted_last_px
        type: formatted_last_px
        doc: 'Number of data blocks'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Price in Globex decimal format. Sent only for the instruments listed on Globex. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Business date corresponding to a statistic entry. Nullable, No Value = 65535'
      - id: md_statistic_desc
        type: str
        size: 40
        encoding: ASCII
        doc: 'An optional textual description for a statistic'
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
  strike_price:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = -9223372036854775808'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = -128'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
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
  formatted_last_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = -9223372036854775808'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = -128'
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
      - id: intraday
        type: b1
        doc: 'Intraday'
      - id: cabinet
        type: b1
        doc: 'Cabinet'
      - id: reserved_bits
        type: b1
        doc: 'ReservedBits'
      - id: unused_settl_price_type_6
        type: b1
        doc: 'Unused SettlPriceType 6'
      - id: null_value
        type: b1
        doc: 'NullValue'
  md_incremental_refresh_voi:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Event processing time (UTC), sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: incremental_refresh_voi_groups
        type: incremental_refresh_voi_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_voi_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_voi_group
        type: incremental_refresh_voi_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks'
  incremental_refresh_voi_group:
    seq:
      - id: product_guid
        type: u8_nullable
        doc: 'Product GUID. Nullable, No Value = 18446744073709551615'
      - id: clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Clearing Product Code'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Security Exchange'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of data blocks'
      - id: put_or_call
        type: u1_nullable
        doc: 'Put or call indicator. Nullable, No Value = 255'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8_nullable
        doc: 'Underlying Product GUID. Nullable, No Value = 18446744073709551615'
      - id: underlying_clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying Clearing Product Code'
      - id: underlying_security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlying Security Type'
      - id: underlying_security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Underlying Security Exchange'
      - id: underlying_maturity_month_year
        type: underlying_maturity_month_year
        doc: 'Number of data blocks'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contract name, symbol'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: security_id
        type: u4_nullable
        doc: 'Security ID. Nullable, No Value = 4294967295'
      - id: cleared_volume
        type: u4_nullable
        doc: 'Cleared volume reported for prior trading session referenced in Tag 5796 TradingReferenceDate. Nullable, No Value = 4294967295'
      - id: open_interest_qty
        type: u4_nullable
        doc: 'Open interest reported for prior trading session referenced in Tag 5796 TradingReferenceDate. Nullable, No Value = 4294967295'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'Estimated vs Actual flag'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Business date corresponding to a statistic entry. Nullable, No Value = 65535'
  md_incremental_refresh_high_low:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Event processing time (UTC), sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: incremental_refresh_high_low_groups
        type: incremental_refresh_high_low_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_high_low_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_high_low_group
        type: incremental_refresh_high_low_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks'
  incremental_refresh_high_low_group:
    seq:
      - id: product_guid
        type: u8_nullable
        doc: 'Product GUID. Nullable, No Value = 18446744073709551615'
      - id: clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Clearing Product Code'
      - id: security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Type'
      - id: security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Security Exchange'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'Number of data blocks'
      - id: put_or_call
        type: u1_nullable
        doc: 'Put or call indicator. Nullable, No Value = 255'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8_nullable
        doc: 'Underlying Product GUID. Nullable, No Value = 18446744073709551615'
      - id: underlying_clearing_product_code
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying Clearing Product Code'
      - id: underlying_security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlying Security Type'
      - id: underlying_security_exchange
        type: str
        size: 8
        encoding: ASCII
        doc: 'Underlying Security Exchange'
      - id: underlying_maturity_month_year
        type: underlying_maturity_month_year
        doc: 'Number of data blocks'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Contract name, symbol'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: security_id
        type: u4_nullable
        doc: 'Security ID. Nullable, No Value = 4294967295'
      - id: low_px
        type: low_px
        doc: 'Number of data blocks'
      - id: low_px_ind
        type: u1
        enum: low_px_ind
        doc: 'Low price origin indicator'
      - id: high_px
        type: high_px
        doc: 'Number of data blocks'
      - id: high_px_ind
        type: u1
        enum: high_px_ind
        doc: 'High price origin indicator'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Business date corresponding to a statistic entry. Nullable, No Value = 65535'
  low_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = -9223372036854775808'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = -128'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
  high_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa. Nullable, No Value = -9223372036854775808'
      - id: exponent
        type: s1
        doc: 'exponent. Nullable, No Value = -128'
    instances:
      real:
        value: 'mantissa * (exponent == 9 ? 1000000000.0 : exponent == 8 ? 100000000.0 : exponent == 7 ? 10000000.0 : exponent == 6 ? 1000000.0 : exponent == 5 ? 100000.0 : exponent == 4 ? 10000.0 : exponent == 3 ? 1000.0 : exponent == 2 ? 100.0 : exponent == 1 ? 10.0 : exponent == 0 ? 1.0 : exponent == -1 ? 0.1 : exponent == -2 ? 0.01 : exponent == -3 ? 0.001 : exponent == -4 ? 0.0001 : exponent == -5 ? 0.00001 : exponent == -6 ? 0.000001 : exponent == -7 ? 0.0000001 : exponent == -8 ? 0.00000001 : exponent == -9 ? 0.000000001 : 1.0)'
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
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
    401:
      id: 'md_incremental_refresh_settle'
      doc: 'MDIncrementalRefreshSettle'
    402:
      id: 'md_incremental_refresh_voi'
      doc: 'MDIncrementalRefreshVOI'
    403:
      id: 'md_incremental_refresh_high_low'
      doc: 'MDIncrementalRefreshHighLow'
    407:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
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
  put_or_call:
    0:
      id: 'put'
      doc: 'Put Option'
    1:
      id: 'call'
      doc: 'Call Option'
  open_close_settl_flag:
    3:
      id: 'estimated'
      doc: 'Estimated values'
    4:
      id: 'actual_adjusted'
      doc: 'Actual adjusted values'
  low_px_ind:
    0x41:
      id: 'ask'
      doc: 'Ask'
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x54:
      id: 'trade'
      doc: 'Trade'
  high_px_ind:
    0x41:
      id: 'ask'
      doc: 'Ask'
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x54:
      id: 'trade'
      doc: 'Trade'

