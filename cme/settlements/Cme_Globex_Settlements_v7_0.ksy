# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Cme Globex Settlements v7.0
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: cme_globex_settlements_v7_0
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
        type: u8
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
        type: u8
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
        type: u8
        doc: 'Product GUID'
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
        type: u1
        enum: put_or_call
        doc: 'Put or call indicator'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8
        doc: 'Underlying Product GUID'
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
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: u4
        doc: 'Security ID'
      - id: formatted_last_px
        type: formatted_last_px
        doc: 'Number of data blocks'
      - id: md_entry_px
        type: s8
        doc: 'Price in Globex decimal format. Sent only for the instruments listed on Globex. Implied decimal with scale 1e-9'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
      - id: trading_reference_date
        type: u2
        doc: 'Business date corresponding to a statistic entry'
      - id: md_statistic_desc
        type: str
        size: 40
        encoding: ASCII
        doc: 'An optional textual description for a statistic'
  maturity_month_year:
    seq:
      - id: year
        type: u2
        doc: 'YYYY'
      - id: month
        type: u1
        doc: 'MM'
      - id: day
        type: u1
        doc: 'DD'
      - id: week
        type: u1
        doc: 'WW'
  strike_price:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
  underlying_maturity_month_year:
    seq:
      - id: year
        type: u2
        doc: 'YYYY'
      - id: month
        type: u1
        doc: 'MM'
      - id: day
        type: u1
        doc: 'DD'
      - id: week
        type: u1
        doc: 'WW'
  formatted_last_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
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
        type: u8
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
        type: u8
        doc: 'Product GUID'
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
        type: u1
        enum: put_or_call
        doc: 'Put or call indicator'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8
        doc: 'Underlying Product GUID'
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
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: u4
        doc: 'Security ID'
      - id: cleared_volume
        type: u4
        doc: 'Cleared volume reported for prior trading session referenced in Tag 5796 TradingReferenceDate'
      - id: open_interest_qty
        type: u4
        doc: 'Open interest reported for prior trading session referenced in Tag 5796 TradingReferenceDate'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'Estimated vs Actual flag'
      - id: trading_reference_date
        type: u2
        doc: 'Business date corresponding to a statistic entry'
  md_incremental_refresh_high_low:
    seq:
      - id: transact_time
        type: u8
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
        type: u8
        doc: 'Product GUID'
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
        type: u1
        enum: put_or_call
        doc: 'Put or call indicator'
      - id: strike_price
        type: strike_price
        doc: 'Number of data blocks'
      - id: underlying_product_guid
        type: u8
        doc: 'Underlying Product GUID'
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
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: u4
        doc: 'Security ID'
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
        type: u2
        doc: 'Business date corresponding to a statistic entry'
  low_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'
  high_px:
    seq:
      - id: mantissa
        type: s8
        doc: 'mantissa'
      - id: exponent
        type: s1
        doc: 'exponent'

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
      id: 'new'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete'
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

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: CME Group
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
