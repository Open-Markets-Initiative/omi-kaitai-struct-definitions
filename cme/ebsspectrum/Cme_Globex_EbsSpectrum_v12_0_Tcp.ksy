# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex EbsSpectrum Sbe v12.0
#
# Protocol:
#   Organization: CME Group
#   Protocol: Ebs Spectrum Market Data
#   Encoding: Simple Binary Encoding
#   Version: 12.0
#   Date: 4/8/2022
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
  id: cme_globex_ebsspectrum_sbe_v12_0_tcp
  title: Cme Globex EbsSpectrum Sbe v12.0
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Ebs Spectrum Market Data Sbe v12.0'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/EBS+Spectrum+Market+Data

seq:
  - id: technical_header
    type: technical_header_struct
    doc: 'Cme Technical Header'
  - id: tcp_message
    type: tcp_message_struct
    repeat: eos
    doc: 'Cme Market Data Message'

types:
  technical_header_struct:
    seq:
      - id: encoding_type
        type: u2
        doc: 'Encoding Type'
      - id: message_sequence_number
        type: u4
        doc: 'Packet Sequence Number'
      - id: tcp_sending_time
        type: u8
        doc: 'Packet Sending Time'
  tcp_message_struct:
    seq:
      - id: tcp_message_size
        type: u2
        doc: 'Message Size'
      - id: message_header
        type: message_header
        doc: 'Template ID and length of message root'
      - id: payload
        size: tcp_message_size - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::md_incremental_refresh_spectrum': md_incremental_refresh_spectrum
            'template_id::md_incremental_refresh_ticker': md_incremental_refresh_ticker
            'template_id::md_snapshot_refresh_spectrum': md_snapshot_refresh_spectrum
            'template_id::md_snapshot_refresh_ticker': md_snapshot_refresh_ticker
            'template_id::global_day_roll': global_day_roll
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
  md_incremental_refresh_spectrum:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Publication event time, sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'EventIndicator bit set'
      - id: incremental_refresh_spectrum_groups
        type: incremental_refresh_spectrum_groups
        doc: 'NoMDEntries Block'
  match_event_indicator:
    seq:
      - id: unused_event_indicator_0
        type: b1
        doc: 'Unused EventIndicator 0'
      - id: unused_event_indicator_1
        type: b1
        doc: 'Unused EventIndicator 1'
      - id: unused_event_indicator_2
        type: b1
        doc: 'Unused EventIndicator 2'
      - id: unused_event_indicator_3
        type: b1
        doc: 'Unused EventIndicator 3'
      - id: unused_event_indicator_4
        type: b1
        doc: 'Unused EventIndicator 4'
      - id: unused_event_indicator_5
        type: b1
        doc: 'Unused EventIndicator 5'
      - id: recovery_message
        type: b1
        doc: 'RecoveryMessage'
      - id: end_of_event
        type: b1
        doc: 'EndOfEvent'
  incremental_refresh_spectrum_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_spectrum_group
        type: incremental_refresh_spectrum_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  group_size:
    seq:
      - id: block_length
        type: u2
      - id: num_in_group
        type: u1
  incremental_refresh_spectrum_group:
    seq:
      - id: md_entry_type_spectrum_entry_type
        type: u1
        enum: md_entry_type_spectrum_entry_type
        doc: 'Market Data entry type, identifies the element'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Financial instrument long name'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique instrument symbol'
      - id: instrument_guid
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: s4
        doc: 'SecurityID as referenced in MDP3 and Ilink3 protocols'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: u8_nullable
        doc: 'Market Data entry size. Nullable, No Value = 18446744073709551615'
      - id: md_entry_time
        type: nanosecond_timestamp
        doc: 'Time of the last market event that contributed to element calculation or publication. Nanoseconds since Unix epoch'
  md_incremental_refresh_ticker:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Publication event time, sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'EventIndicator bit set'
      - id: incremental_refresh_ticker_groups
        type: incremental_refresh_ticker_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_ticker_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_ticker_group
        type: incremental_refresh_ticker_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_ticker_group:
    seq:
      - id: md_entry_type_ticker_entry_type
        type: u1
        enum: md_entry_type_ticker_entry_type
        doc: 'Market Data entry type, identifies the element'
      - id: security_id
        type: s4
        doc: 'SecurityID as referenced in MDP3 and Ilink3 protocols'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique instrument symbol'
      - id: instrument_guid
        type: u8
        doc: 'External unique instrument ID'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Financial instrument long name'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: u8_nullable
        doc: 'Market Data entry size. Nullable, No Value = 18446744073709551615'
      - id: md_entry_time
        type: nanosecond_timestamp
        doc: 'Time of the last market event that contributed to element calculation or publication. Nanoseconds since Unix epoch'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'Previous day elements, Global or Regional, will contain the value 4 - entry from previous business date'
      - id: trading_session_id
        type: u1_nullable
        doc: 'The associated region market hours considered for the calculation of the element. The element is calculated from market events occurring during the region''s open-close hours. Nullable, No Value = 255'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. Nullable, No Value = 255'
  md_snapshot_refresh_spectrum:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Publication event time, sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'EventIndicator bit set'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Financial instrument long name'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique instrument symbol'
      - id: instrument_guid
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: s4
        doc: 'SecurityID as referenced in MDP3 and Ilink3 protocols'
      - id: snapshot_refresh_spectrum_groups
        type: snapshot_refresh_spectrum_groups
        doc: 'NoMDEntries Block'
  snapshot_refresh_spectrum_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_refresh_spectrum_group
        type: snapshot_refresh_spectrum_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_refresh_spectrum_group:
    seq:
      - id: md_entry_type_spectrum_entry_type
        type: u1
        enum: md_entry_type_spectrum_entry_type
        doc: 'Market Data entry type, identifies the element'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: u8_nullable
        doc: 'Market Data entry size. Nullable, No Value = 18446744073709551615'
      - id: md_entry_time
        type: nanosecond_timestamp
        doc: 'Time of the last market event that contributed to element calculation or publication. Nanoseconds since Unix epoch'
  md_snapshot_refresh_ticker:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Publication event time, sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'EventIndicator bit set'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Financial instrument long name'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Unique instrument symbol'
      - id: instrument_guid
        type: u8
        doc: 'External unique instrument ID'
      - id: security_id
        type: s4
        doc: 'SecurityID as referenced in MDP3 and Ilink3 protocols'
      - id: snapshot_refresh_ticker_groups
        type: snapshot_refresh_ticker_groups
        doc: 'NoMDEntries Block'
  snapshot_refresh_ticker_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_refresh_ticker_group
        type: snapshot_refresh_ticker_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_refresh_ticker_group:
    seq:
      - id: md_entry_type_ticker_entry_type
        type: u1
        enum: md_entry_type_ticker_entry_type
        doc: 'Market Data entry type, identifies the element'
      - id: md_entry_px
        type: decimal_s8_9_nullable
        doc: 'Market Data entry price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size
        type: u8_nullable
        doc: 'Market Data entry size. Nullable, No Value = 18446744073709551615'
      - id: md_entry_time
        type: nanosecond_timestamp
        doc: 'Time of the last market event that contributed to element calculation or publication. Nanoseconds since Unix epoch'
      - id: open_close_settl_flag
        type: u1
        enum: open_close_settl_flag
        doc: 'Previous day elements, Global or Regional, will contain the value 4 - entry from previous business date'
      - id: trading_session_id
        type: u1_nullable
        doc: 'The associated region market hours considered for the calculation of the element. The element is calculated from market events occurring during the region''s open-close hours. Nullable, No Value = 255'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is aggressor of the trade. Nullable, No Value = 255'
  global_day_roll:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Publication event time, sent in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_trading_event
        type: u1
        enum: security_trading_event
        doc: 'Signals the start of the next Global day or a Global day roll'
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

enums:
  template_id:
    302:
      id: 'admin_heartbeat'
      doc: 'AdminHeartbeat'
    303:
      id: 'md_incremental_refresh_spectrum'
      doc: 'MDIncrementalRefreshSpectrum'
    304:
      id: 'md_incremental_refresh_ticker'
      doc: 'MDIncrementalRefreshTicker'
    305:
      id: 'md_snapshot_refresh_spectrum'
      doc: 'MDSnapshotRefreshSpectrum'
    306:
      id: 'md_snapshot_refresh_ticker'
      doc: 'MDSnapshotRefreshTicker'
    307:
      id: 'global_day_roll'
      doc: 'GlobalDayRoll'
  md_entry_type_spectrum_entry_type:
    0x39:
      id: 'vwap'
      doc: 'Volume weighted average traded price'
    0x74:
      id: 'twap'
      doc: 'Average traded price'
  md_entry_type_ticker_entry_type:
    0x6b:
      id: 'touch_high'
      doc: 'Touch High'
    0x6c:
      id: 'touch_low'
      doc: 'Touch Low'
    0x6d:
      id: 'open_best_bid'
      doc: 'Open Best Bid'
    0x6e:
      id: 'open_best_offer'
      doc: 'Open Best Offer'
    0x6f:
      id: 'close_best_bid'
      doc: 'Close Best Bid'
    0x70:
      id: 'close_best_offer'
      doc: 'Close Best Offer'
    0x71:
      id: 'market_high'
      doc: 'Market High'
    0x72:
      id: 'market_low'
      doc: 'Market Low'
    0x77:
      id: 'market_best_offer'
      doc: 'Market Best Offer'
    0x78:
      id: 'market_best_bid'
      doc: 'Market Best Bid'
    0x79:
      id: 'paid'
      doc: 'Paid'
    0x7a:
      id: 'given'
      doc: 'Given'
  open_close_settl_flag:
    0:
      id: 'current_day'
      doc: 'Current day entry'
    4:
      id: 'previous_day'
      doc: 'Element entry from previous business day'
  trading_session_id:
    0:
      id: 'gl'
      doc: 'Global'
    1:
      id: 'sy'
      doc: 'Sydney'
    2:
      id: 'tk'
      doc: 'Tokyo'
    3:
      id: 'hk'
      doc: 'Hong Kong/ Singapore'
    4:
      id: 'ln'
      doc: 'London'
    5:
      id: 'ny'
      doc: 'New York'
  aggressor_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  security_trading_event:
    4:
      id: 'global_day_roll'
      doc: 'Global Day has been rolled and daily elements were reset'

