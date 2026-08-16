# ---------------------------------------------------------------------
# Kaitai struct definition for: Cme Globex Mdp3 Sbe v1.13
#
# Protocol:
#   Organization: CME Group
#   Protocol: Market Data Platform 3
#   Encoding: Simple Binary Encoding
#   Version: 1.13
#   Date: 4/11/2023
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
  id: cme_globex_mdp3_sbe_v1_13_tcp
  title: Cme Globex Mdp3 Sbe v1.13
  license: GPL-3.0
  endian: le

doc: 'CME Group CME Globex Market Data Platform 3 Sbe v1.13'
doc-ref: https://www.cmegroup.com/confluence/display/EPICSANDBOX/CME+MDP+3.0+Market+Data

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
            'template_id::channel_reset': channel_reset
            'template_id::admin_login': admin_login
            'template_id::admin_logout': admin_logout
            'template_id::security_status': security_status
            'template_id::md_incremental_refresh_volume': md_incremental_refresh_volume
            'template_id::quote_request': quote_request
            'template_id::md_incremental_refresh_book': md_incremental_refresh_book
            'template_id::md_incremental_refresh_order_book': md_incremental_refresh_order_book
            'template_id::md_incremental_refresh_trade_summary': md_incremental_refresh_trade_summary
            'template_id::md_incremental_refresh_daily_statistics': md_incremental_refresh_daily_statistics
            'template_id::md_incremental_refresh_limits_banding': md_incremental_refresh_limits_banding
            'template_id::md_incremental_refresh_session_statistics': md_incremental_refresh_session_statistics
            'template_id::snapshot_full_refresh': snapshot_full_refresh
            'template_id::snapshot_full_refresh_order_book': snapshot_full_refresh_order_book
            'template_id::md_instrument_definition_future': md_instrument_definition_future
            'template_id::md_instrument_definition_option': md_instrument_definition_option
            'template_id::md_instrument_definition_spread': md_instrument_definition_spread
            'template_id::md_instrument_definition_fixed_income': md_instrument_definition_fixed_income
            'template_id::md_instrument_definition_repo': md_instrument_definition_repo
            'template_id::snapshot_refresh_top_orders': snapshot_refresh_top_orders
            'template_id::security_status_workup': security_status_workup
            'template_id::snapshot_full_refresh_tcp': snapshot_full_refresh_tcp
            'template_id::collateral_market_value': collateral_market_value
            'template_id::md_instrument_definition_fx': md_instrument_definition_fx
            'template_id::md_incremental_refresh_book_long_qty': md_incremental_refresh_book_long_qty
            'template_id::md_incremental_refresh_trade_summary_long_qty': md_incremental_refresh_trade_summary_long_qty
            'template_id::md_incremental_refresh_volume_long_qty': md_incremental_refresh_volume_long_qty
            'template_id::md_incremental_refresh_session_statistics_long_qty': md_incremental_refresh_session_statistics_long_qty
            'template_id::snapshot_full_refresh_tcp_long_qty': snapshot_full_refresh_tcp_long_qty
            'template_id::snapshot_full_refresh_long_qty': snapshot_full_refresh_long_qty
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
  security_status:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: security_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
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
      - id: md_entry_size_short
        type: s4
        doc: 'Cumulative traded volume'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
        doc: 'Security ID'
      - id: order_qty
        type: s4_nullable
        doc: 'Quantity requested. Nullable, No Value = 2147483647'
      - id: quote_type
        type: s1
        doc: 'Type of quote requested'
      - id: side_optional
        type: s1_nullable
        doc: 'Side requested. Nullable, No Value = 127'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
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
      - id: incremental_refresh_book_groups
        type: incremental_refresh_book_groups
        doc: 'NoMDEntries Block'
      - id: incremental_refresh_book_order_id_groups
        type: incremental_refresh_book_order_id_groups
        doc: 'NoOrderIDEntries Block'
  incremental_refresh_book_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_book_group
        type: incremental_refresh_book_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_book_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_short_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders_optional
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
      - id: tradeable_size
        type: s4_nullable
        doc: 'Tradeable qty. Nullable, No Value = 2147483647'
      - id: padding_1
        size: 1
        doc: '1 bytes padding'
  incremental_refresh_book_order_id_groups:
    seq:
      - id: group_size_8_byte
        type: group_size_8_byte
        doc: '8 Byte aligned repeating group dimensions'
      - id: incremental_refresh_book_order_id_group
        type: incremental_refresh_book_order_id_group
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
  incremental_refresh_book_order_id_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: md_order_priority_optional
        type: u8_nullable
        doc: 'Order priority for execution on the order book. Nullable, No Value = 18446744073709551615'
      - id: md_display_qty_optional
        type: s4_nullable
        doc: 'Visible qty of order. Nullable, No Value = 2147483647'
      - id: reference_id
        type: u1_nullable
        doc: 'Reference to corresponding Price and Security ID, sequence of MD entry in the message. Nullable, No Value = 255'
      - id: order_update_action
        type: u1
        enum: order_update_action
        doc: 'Order book update action to be applied to the order referenced by OrderID'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  md_incremental_refresh_order_book:
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
      - id: incremental_refresh_order_book_groups
        type: incremental_refresh_order_book_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_order_book_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_order_book_group
        type: incremental_refresh_order_book_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_order_book_group:
    seq:
      - id: order_id_optional
        type: u8_nullable
        doc: 'Order ID. Nullable, No Value = 18446744073709551615'
      - id: md_order_priority_optional
        type: u8_nullable
        doc: 'Order priority for execution on the order book. Nullable, No Value = 18446744073709551615'
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_display_qty_optional
        type: s4_nullable
        doc: 'Visible qty of order. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_entry_type_book
        type: u1
        enum: md_entry_type_book
        doc: 'Market Data entry type'
      - id: padding_6
        size: 6
        doc: '6 bytes padding'
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
      - id: incremental_refresh_trade_summary_groups
        type: incremental_refresh_trade_summary_groups
        doc: 'NoMDEntries Block'
      - id: incremental_refresh_trade_summary_order_id_groups
        type: incremental_refresh_trade_summary_order_id_groups
        doc: 'NoOrderIDEntries Block'
  incremental_refresh_trade_summary_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_trade_summary_group
        type: incremental_refresh_trade_summary_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Trade Summary entries'
  incremental_refresh_trade_summary_group:
    seq:
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: md_entry_size_short
        type: s4
        doc: 'Cumulative traded volume'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders
        type: s4
        doc: 'The total number of real orders per instrument that participated in a match step within a match event'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is the aggressor or if there is no aggressor. Nullable, No Value = 255'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: md_trade_entry_optional
        type: u4_nullable
        doc: 'Market Data Trade entry ID. Nullable, No Value = 4294967295'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  incremental_refresh_trade_summary_order_id_groups:
    seq:
      - id: group_size_8_byte
        type: group_size_8_byte
        doc: '8 Byte aligned repeating group dimensions'
      - id: incremental_refresh_trade_summary_order_id_group
        type: incremental_refresh_trade_summary_order_id_group
        repeat: expr
        repeat-expr: group_size_8_byte.num_in_group
        doc: 'Number of OrderID entries'
  incremental_refresh_trade_summary_order_id_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: last_qty
        type: s4
        doc: 'Quantity bought or sold on this last fill'
      - id: padding_4
        size: 4
        doc: '4 bytes padding'
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
      - id: incremental_refresh_daily_statistics_groups
        type: incremental_refresh_daily_statistics_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_daily_statistics_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_daily_statistics_group
        type: incremental_refresh_daily_statistics_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_daily_statistics_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_short_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
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
      - id: incremental_refresh_limits_banding_groups
        type: incremental_refresh_limits_banding_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_limits_banding_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_limits_banding_group
        type: incremental_refresh_limits_banding_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_limits_banding_group:
    seq:
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
      - id: incremental_refresh_session_statistics_groups
        type: incremental_refresh_session_statistics_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_session_statistics_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_session_statistics_group
        type: incremental_refresh_session_statistics_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_session_statistics_group:
    seq:
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
      - id: md_entry_size_short_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: padding_1
        size: 1
        doc: '1 bytes padding'
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
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: snapshot_full_refresh_groups
        type: snapshot_full_refresh_groups
        doc: 'NoMDEntries Block'
  snapshot_full_refresh_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_full_refresh_group
        type: snapshot_full_refresh_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_full_refresh_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_short_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: number_of_orders_optional
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level_optional
        type: s1_nullable
        doc: 'Aggregate book position. Nullable, No Value = 127'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
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
  snapshot_full_refresh_order_book:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'Sequence number of the last Incremental feed packet processed. This value is used to synchronize the snapshot loop with the real-time feed'
      - id: tot_num_reports
        type: u4
        doc: 'Total number of messages replayed in the loop'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: no_chunks
        type: u4
        doc: 'Total number of packets that constitutes a single instrument order book'
      - id: current_chunk
        type: u4
        doc: 'Chunk sequence'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: snapshot_full_refresh_order_book_groups
        type: snapshot_full_refresh_order_book_groups
        doc: 'NoMDEntries Block'
  snapshot_full_refresh_order_book_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_full_refresh_order_book_group
        type: snapshot_full_refresh_order_book_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_full_refresh_order_book_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: md_order_priority_optional
        type: u8_nullable
        doc: 'Order priority for execution on the order book. Nullable, No Value = 18446744073709551615'
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: md_display_qty
        type: s4
        doc: 'Visible order qty'
      - id: md_entry_type_book
        type: u1
        enum: md_entry_type_book
        doc: 'Market Data entry type'
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
        type: decimal_s8_9
        doc: 'Minimum constant tick for the instrument, sent only if instrument is non-VTT (Variable Tick table) eligible. Implied decimal with scale 1e-9'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
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
        type: decimal_s8_9_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_9_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Monetary value equivalent to the minimum price fluctuation. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
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
  events_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: events_group
        type: events_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating EventType entries'
  events_group:
    seq:
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Code to represent the type of event'
      - id: event_time
        type: nanosecond_timestamp
        doc: 'Date and Time of instument Activation or Expiration event sent as number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
  feed_types_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: feed_types_group
        type: feed_types_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating FeedType entries'
  feed_types_group:
    seq:
      - id: md_feed_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'Describes a class of service for a given data feed. GBX- Real Book, GBI-Implied Book'
      - id: market_depth
        type: s1
        doc: 'Book depth'
  inst_attrib_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: inst_attrib_group
        type: inst_attrib_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of repeating InstrAttribType entries'
  inst_attrib_group:
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
      - id: triangulation_eligible
        type: b1
        doc: 'TriangulationEligible'
      - id: variable_cab_eligible
        type: b1
        doc: 'VariableCabEligible'
      - id: inverted_book
        type: b1
        doc: 'InvertedBook'
      - id: is_aon_instrument
        type: b1
        doc: 'IsAoNInstrument'
      - id: sef_regulated
        type: b1
        doc: 'SEFRegulated'
      - id: mtf_regulated
        type: b1
        doc: 'MTFRegulated'
      - id: efix_instrument
        type: b1
        doc: 'eFIXInstrument'
      - id: hedge_instrument
        type: b1
        doc: 'HedgeInstrument'
      - id: reserved_4
        type: b4
        doc: '4 reserved bits'
  lot_type_rules_group:
    seq:
      - id: lot_type
        type: s1
        doc: 'This tag is required to interpret the value in tag 1231-MinLotSize'
      - id: min_lot_size_decimal_qty
        type: decimal_s4_4_nullable
        doc: 'Minimum quantity accepted for order entry. If tag 1093-LotType=4, this value is the minimum quantity for order entry expressed in the applicable units, specified in tag 996-UnitOfMeasure, e.g. megawatts. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
        type: decimal_s8_9_nullable
        doc: 'Strike Price for an option instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Defines cabinet price for outright options products. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Minimum constant tick for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment_amount
        type: decimal_s8_9_nullable
        doc: 'Monetary value equivalent to the minimum price fluctuation. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
      - id: tick_rule
        type: s1_nullable
        doc: 'VTT code referencing variable tick table. Nullable, No Value = 127'
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
        type: decimal_s8_9_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_9_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
      - id: option_underlyings_groups
        type: option_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: option_related_instruments_groups
        type: option_related_instruments_groups
        doc: 'NoRelatedInstruments Block'
  option_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: option_underlyings_group
        type: option_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of underlying instruments'
  option_underlyings_group:
    seq:
      - id: underlying_security_id
        type: s4
        doc: 'Unique Instrument ID as qualified by the exchange per tag 305-UnderlyingSecurityIDSource'
      - id: underlying_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying Instrument Symbol (Contract Name)'
  option_related_instruments_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: option_related_instruments_group
        type: option_related_instruments_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of related instruments group'
  option_related_instruments_group:
    seq:
      - id: related_security_id
        type: s4
        doc: 'Related Security ID'
      - id: related_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Related instrument Symbol'
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
      - id: min_price_increment_optional
        type: decimal_s8_9_nullable
        doc: 'Minimum constant tick for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
      - id: price_display_format
        type: u1_nullable
        doc: 'Number of decimals in fractional display price. Nullable, No Value = 255'
      - id: price_ratio
        type: decimal_s8_9_nullable
        doc: 'Used for price calculation in spread and leg pricing. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: tick_rule
        type: s1_nullable
        doc: 'VTT code referencing variable tick table. Nullable, No Value = 127'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: trading_reference_price
        type: decimal_s8_9_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
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
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: main_fraction
        type: u1_nullable
        doc: 'Price Denominator of Main Fraction. Nullable, No Value = 255'
      - id: sub_fraction
        type: u1_nullable
        doc: 'Price Denominator of Sub Fraction. Nullable, No Value = 255'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: price_quote_method
        type: str
        size: 5
        encoding: ASCII
        doc: 'Price quotation method'
      - id: risk_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Risk Set identifies the list of instruments sharing credit limits set up'
      - id: market_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Market Set defines the bilateral relationship and Self Match Prevention configuration for eligible markets'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long name of the instrument'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
      - id: legs_groups
        type: legs_groups
        doc: 'NoLegs Block'
  legs_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: legs_group
        type: legs_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Leg entries'
  legs_group:
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
        type: decimal_s8_9_nullable
        doc: 'Price for the future leg of a UDS Covered instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: leg_option_delta
        type: decimal_s4_4_nullable
        doc: 'Delta used to calculate the quantity of futures used to cover the option or option strategy. Implied decimal with scale 1e-4. Nullable, No Value = 2147483647'
  md_instrument_definition_fixed_income:
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
      - id: min_price_increment_optional
        type: decimal_s8_9_nullable
        doc: 'Minimum constant tick for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
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
        type: decimal_s8_9_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_9_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: min_price_increment_amount
        type: decimal_s8_9_nullable
        doc: 'Monetary value equivalent to the minimum price fluctuation. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: issue_date
        type: u2_nullable
        doc: 'Issue Date. Nullable, No Value = 65535'
      - id: dated_date
        type: u2_nullable
        doc: 'Dated Date. Nullable, No Value = 65535'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity Date. Nullable, No Value = 65535'
      - id: coupon_rate
        type: decimal_s8_9_nullable
        doc: 'The rate of interest that, when multiplied by the principal, par value, or face value of a bond, provides the currency amount of the periodic interest payment. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: par_value
        type: decimal_s8_9_nullable
        doc: 'Par value. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: coupon_frequency_unit
        type: str
        size: 3
        encoding: ASCII
        doc: 'Time unit associated with the frequency of the bond''s coupon payment'
      - id: coupon_frequency_period
        type: u2_nullable
        doc: 'Time unit multiplier for the frequency of the bond''s coupon payment. Nullable, No Value = 65535'
      - id: coupon_day_count
        type: str
        size: 20
        encoding: ASCII
        doc: 'The day count convention used in interest calculations for a bond or an interest bearing security'
      - id: country_of_issue
        type: str
        size: 2
        encoding: ASCII
        doc: 'Country of Origin, ISO alpha-2 country code'
      - id: issuer
        type: str
        size: 25
        encoding: ASCII
        doc: 'Name of security issuer or the Legal Entity Identifier (LEI - the International ISO standard 17442)'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long name of the instrument'
      - id: security_alt_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Expanded instrument description. Will contain either ISIN or CUSIP'
      - id: security_alt_id_source
        type: u1_nullable
        doc: 'Identifies class or source of the SecurityAltID (455) value. Nullable, No Value = 255'
      - id: price_quote_method
        type: str
        size: 5
        encoding: ASCII
        doc: 'Price quotation method'
      - id: party_role_clearing_org
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing organization'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: risk_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Risk Set identifies the list of instruments sharing credit limits set up'
      - id: market_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Market Set defines the bilateral relationship and Self Match Prevention configuration for eligible markets'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
  md_instrument_definition_repo:
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
        type: decimal_s8_9
        doc: 'Minimum constant tick for the instrument, sent only if instrument is non-VTT (Variable Tick table) eligible. Implied decimal with scale 1e-9'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: unit_of_measure_qty
        type: decimal_s8_9_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_price
        type: decimal_s8_9_nullable
        doc: 'Reference price for prelisted instruments or the last calculated Settlement whether it be Theoretical, Preliminary or a Final Settle of the session. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long name of the instrument'
      - id: party_role_clearing_org
        type: str
        size: 5
        encoding: ASCII
        doc: 'Clearing organization'
      - id: start_date
        type: u2_nullable
        doc: 'Start date of a financing deal, i.e. the date the buyer pays the seller cash and takes control of the collateral. Nullable, No Value = 65535'
      - id: end_date
        type: u2_nullable
        doc: 'End date of a financing deal, i.e. the date the seller reimburses the buyer and takes back control of the collateral. Nullable, No Value = 65535'
      - id: termination_type
        type: str
        size: 8
        encoding: ASCII
        doc: 'For Repos the timing or method for terminating the agreement. Term code'
      - id: repo_sub_type
        type: u1
        enum: repo_sub_type
        doc: 'Repo Sub Security Type'
      - id: money_or_par
        type: u1_nullable
        doc: 'Money or Par indicates if the GC is filled by par amount or by money amount. Nullable, No Value = 255'
      - id: max_no_of_substitutions
        type: u1
        doc: 'Max number of substitutions allowed. The value of 0 indicates that substitutions are not allowed'
      - id: price_quote_method
        type: str
        size: 5
        encoding: ASCII
        doc: 'Price quotation method'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: risk_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Risk Set identifies the list of instruments sharing credit limits set up'
      - id: market_set
        type: str
        size: 6
        encoding: ASCII
        doc: 'Market Set defines the bilateral relationship and Self Match Prevention configuration for eligible markets'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: term_code
        type: str
        size: 20
        encoding: ASCII
        doc: 'Full Repo Term Code'
      - id: broken_date_term_type
        type: u1_nullable
        doc: 'Optionally used in tailor made repo contracts and defines the type of broken dates as requested by trader. Null = Not applicable, 0 = Custom, 1 = Quarterly, 2 = Monthly. Nullable, No Value = 255'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
      - id: repo_underlyings_groups
        type: repo_underlyings_groups
        doc: 'NoUnderlyings Block'
      - id: repo_related_instruments_groups
        type: repo_related_instruments_groups
        doc: 'NoRelatedInstruments Block'
      - id: broken_dates_groups
        type: broken_dates_groups
        doc: 'NoBrokenDates Block'
  repo_underlyings_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: repo_underlyings_group
        type: repo_underlyings_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of underlying entries'
  repo_underlyings_group:
    seq:
      - id: underlying_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Underlying Instrument Symbol (Contract Name)'
      - id: underlying_security_id_optional
        type: s4_nullable
        doc: 'Underlying Security ID as qualified by tag 305-UnderlyingSecurityIDSource. Provided only if the underlying is a Globex listed instrument, this value will be the same as that contained in Security Definition Tag 48-SecurityID. Nullable, No Value = 2147483647'
      - id: underlying_security_alt_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying Alternate Security identifier value as qualified by Tag 305-UnderlyingSecuityAltIDSource (e.g. CUSIP, ISIN, etc). For Repo special will contain underlying CUSIP or ISIN. For GC Repo may contain a synthetic CUSIP or ISIN representing a basket'
      - id: underlying_security_alt_id_source
        type: u1_nullable
        doc: 'Identifies class or source of the UnderlyingSecurityAltID (458) value. Nullable, No Value = 255'
      - id: underlying_financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long Name of the Underlying Instrument. For the instruments listed on Globex this value will be the same as of that contained in Security Definition Tag 2714-FinancialInstrumentFullName'
      - id: underlying_security_type
        type: str
        size: 6
        encoding: ASCII
        doc: 'Underlying Security Type'
      - id: underlying_country_of_issue
        type: str
        size: 2
        encoding: ASCII
        doc: 'Underlying Security''s CountryOfIssue. See CountryOfIssue (470) field for description'
      - id: underlying_issuer
        type: str
        size: 25
        encoding: ASCII
        doc: 'Underlying Security''s Issuer. See Tag 106-Issuer field for description'
      - id: underlying_max_life_time
        type: u1_nullable
        doc: 'Max life time of the underlying instruments qualifying for the GC basket in number of year. Will contain null value for Repo specials. Nullable, No Value = 255'
      - id: underlying_min_days_to_maturity
        type: u2_nullable
        doc: 'Minimum days to maturity remaining of the underlying instruments to qualify for GC basket. Will contain null value for Repo specials. Nullable, No Value = 65535'
      - id: underlying_instrument_guid_optional
        type: u8_nullable
        doc: 'Underlying GUID. For Repo specials populated with individual instrument GUID of the underlying security. Nullable, No Value = 18446744073709551615'
      - id: underlying_maturity_date
        type: u2_nullable
        doc: 'Underlying Security''s Maturity Date. Will be populated with Maturity Date of the underlying security instrument for Repo Specials only. Nullable, No Value = 65535'
  repo_related_instruments_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: repo_related_instruments_group
        type: repo_related_instruments_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of related instruments group'
  repo_related_instruments_group:
    seq:
      - id: related_security_id
        type: s4
        doc: 'Related Security ID'
      - id: related_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Related instrument Symbol'
      - id: related_instrument_guid
        type: u8_nullable
        doc: 'Related Instrument GUID. Nullable, No Value = 18446744073709551615'
  broken_dates_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: broken_dates_group
        type: broken_dates_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'This group indicates the number of broken dates and references individual broken contracts in user defined tailor made repo. Applicable only to tailor made repos requested by traders with broken dates'
  broken_dates_group:
    seq:
      - id: broken_date_guid
        type: u8
        doc: 'External unique broken date Instrument ID'
      - id: broken_date_security_id
        type: s4
        doc: 'Broken date Instrument Globex Security ID'
      - id: broken_date_start
        type: u2_nullable
        doc: 'Start date of a broken date period. Nullable, No Value = 65535'
      - id: broken_date_end
        type: u2_nullable
        doc: 'End date of a broken date period. Nullable, No Value = 65535'
  snapshot_refresh_top_orders:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: snapshot_refresh_top_orders_groups
        type: snapshot_refresh_top_orders_groups
        doc: 'NoMDEntries Block'
  snapshot_refresh_top_orders_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_refresh_top_orders_group
        type: snapshot_refresh_top_orders_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks following'
  snapshot_refresh_top_orders_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: md_order_priority
        type: u8
        doc: 'Order priority for execution on the order book'
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: md_display_qty
        type: s4
        doc: 'Visible order qty'
      - id: md_entry_type_book
        type: u1
        enum: md_entry_type_book
        doc: 'Market Data entry type'
  security_status_workup:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: trade_link_id
        type: u4
        doc: 'Contains the workup ID; unique per instrument per day'
      - id: workup_trading_status
        type: u1
        enum: workup_trading_status
        doc: 'Identifies the trading status applicable to the instrument'
      - id: halt_reason
        type: u1
        enum: halt_reason
        doc: 'Identifies the reason for the status change'
      - id: security_trading_event
        type: u1
        enum: security_trading_event
        doc: 'Identifies an additional event or a rule related to the status'
      - id: security_status_workup_groups
        type: security_status_workup_groups
        doc: 'NoOrderIDEntries Block'
  security_status_workup_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: security_status_workup_group
        type: security_status_workup_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of OrderID entries'
  security_status_workup_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: aggressor_indicator
        type: u1_nullable
        doc: 'Aggressor Indicator 1=Aggressor Order 0=Passive Order. Nullable, No Value = 255'
  snapshot_full_refresh_tcp:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: snapshot_full_refresh_tcp_groups
        type: snapshot_full_refresh_tcp_groups
        doc: 'NoMDEntries Block'
  snapshot_full_refresh_tcp_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_full_refresh_tcp_group
        type: snapshot_full_refresh_tcp_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks listed in the Incremental message'
  snapshot_full_refresh_tcp_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_short_optional
        type: s4_nullable
        doc: 'Market Data entry size. Nullable, No Value = 2147483647'
      - id: tradeable_size
        type: s4_nullable
        doc: 'Tradeable qty. Nullable, No Value = 2147483647'
      - id: number_of_orders_optional
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level_optional
        type: s1_nullable
        doc: 'Aggregate book position. Nullable, No Value = 127'
      - id: open_close_settl_flag
        type: u1_nullable
        doc: 'Flag describing IOP and Open Price entries. Nullable, No Value = 255'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Market Data entry type'
      - id: trading_reference_date
        type: u2_nullable
        doc: 'Indicates session date corresponding to the settlement price in tag 1150-TradingReferencePrice. Nullable, No Value = 65535'
      - id: settl_price_type
        type: settl_price_type
        doc: 'SettlPriceType bit set'
  collateral_market_value:
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
      - id: collateral_market_value_groups
        type: collateral_market_value_groups
        doc: 'NoMDEntries Block'
  collateral_market_value_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: collateral_market_value_group
        type: collateral_market_value_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of data blocks listed in the Incremental message'
  collateral_market_value_group:
    seq:
      - id: underlying_security_alt_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Underlying Alternate Security identifier value as qualified by Tag 305-UnderlyingSecuityAltIDSource (e.g. CUSIP, ISIN, etc). For Repo special will contain underlying CUSIP or ISIN. For GC Repo may contain a synthetic CUSIP or ISIN representing a basket'
      - id: underlying_security_alt_id_source
        type: u1_nullable
        doc: 'Identifies class or source of the UnderlyingSecurityAltID (458) value. Nullable, No Value = 255'
      - id: collateral_market_price
        type: decimal_s8_9
        doc: 'Market price of the collateral, either from external market sources or a result of trading activity on the platform. Clean price. Implied decimal with scale 1e-9'
      - id: dirty_price
        type: decimal_s8_9
        doc: 'Dirty Price. Implied decimal with scale 1e-9'
      - id: underlying_instrument_guid
        type: u8
        doc: 'Underlying Instrument GUID. Collateral security identifier in REF Data API services'
      - id: md_stream_id
        type: u1_nullable
        doc: 'Source of the Clean Price. Nullable, No Value = 255'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  md_instrument_definition_fx:
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
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: appl_id
        type: s2
        doc: 'The channel ID as defined in the XML Configuration file'
      - id: market_segment_id
        type: u1
        doc: 'Identifies the market segment, populated for all CME Globex instruments'
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
        doc: 'Security Group'
      - id: asset
        type: str
        size: 6
        encoding: ASCII
        doc: 'Product Code within Security Group specified'
      - id: symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Instrument Name or Symbol'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
      - id: price_quote_currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'Local (counter) currency'
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
        type: decimal_s8_9
        doc: 'Minimum constant tick for the instrument, sent only if instrument is non-VTT (Variable Tick table) eligible. Implied decimal with scale 1e-9'
      - id: display_factor
        type: decimal_s8_9
        doc: 'Contains the multiplier to convert the CME Globex display price to the conventional price. Implied decimal with scale 1e-9'
      - id: price_precision
        type: u1
        doc: 'Specifies price decimal precision for EBS instrument'
      - id: unit_of_measure
        type: str
        size: 30
        encoding: ASCII
        doc: 'Unit of measure for the products'' original contract size. This will be populated for all products listed on CME Globex'
      - id: unit_of_measure_qty
        type: decimal_s8_9_nullable
        doc: 'This field contains the contract size for each instrument. Used in combination with tag 996-UnitofMeasure. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: user_defined_instrument
        type: str
        size: 1
        encoding: ASCII
        doc: 'User-defined instruments flag'
      - id: financial_instrument_full_name
        type: str
        size: 35
        encoding: ASCII
        doc: 'Long name of the instrument'
      - id: fx_currency_symbol
        type: str
        size: 7
        encoding: ASCII
        doc: 'Base/Local. Denotes the currency pair in CCY1/CCY2 convention'
      - id: settl_type
        type: str
        size: 3
        encoding: ASCII
        doc: 'For SPOTs will contain 0. For Fixed date NDFs will contain the value ''B''. For the standard NDFs tenors expressed using Dx, Mx, Wx, and Yx values, where ''x'' does not denote business days, but calendar days'
      - id: intervening_days
        type: u2
        doc: 'For SPOT, number of business days between trade date and value (settlement) date. For NDF, number of business days between NDF valuation (fixing) and settlement'
      - id: fx_benchmark_rate_fix
        type: str
        size: 20
        encoding: ASCII
        doc: 'Fixing Rate Description'
      - id: rate_source
        type: str
        size: 12
        encoding: ASCII
        doc: 'Fixing Rate Source'
      - id: fix_rate_local_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'Fixing Rate Local Time, denoted in HH:MM:SS format'
      - id: fix_rate_local_time_zone
        type: str
        size: 20
        encoding: ASCII
        doc: 'Fixing Rate Local Time Zone corresponding to Fixing Local Time'
      - id: min_quote_life
        type: u4
        doc: 'Minimum Quote Life in number of microseconds'
      - id: max_price_discretion_offset
        type: decimal_s8_9
        doc: 'Max allowed discretionary offset from Limit order price. When the value in this field = 0, discretionary price cannot be submitted for the instrument. Implied decimal with scale 1e-9'
      - id: instrument_guid
        type: u8_nullable
        doc: 'External unique instrument ID. Nullable, No Value = 18446744073709551615'
      - id: maturity_month_year
        type: maturity_month_year
        doc: 'MDInstrumentDefinitionFuture'
      - id: settlement_locale
        type: str
        size: 8
        encoding: ASCII
        doc: 'Settlement Locale. Optionally used to differentiate settlement location'
      - id: alt_min_price_increment
        type: decimal_s8_9_nullable
        doc: 'New sub-tick which is only available for order entry when certain conditions are met, tick value which corresponds to the Alt Min Quote Life. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: alt_min_quote_life
        type: u4_nullable
        doc: 'MQL duration in number of microseconds applied to orders at AltMinPriceIncrement. Nullable, No Value = 4294967295'
      - id: alt_price_increment_constraint
        type: decimal_s8_9_nullable
        doc: 'Minimum price offset better than the best Standard Tick order for an order to be allowed into the market. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_bid_ask_constraint
        type: decimal_s8_9_nullable
        doc: 'Maximum bid/ask spread for which sub-tick orders will be accepted (Sub tick orders will be rejected if bid/ask spread is greater than this value). Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: events_groups
        type: events_groups
        doc: 'NoEvents Block'
      - id: feed_types_groups
        type: feed_types_groups
        doc: 'NoMDFeedTypes Block'
      - id: inst_attrib_groups
        type: inst_attrib_groups
        doc: 'NoInstAttrib Block'
      - id: lot_type_rules_group
        type: lot_type_rules_group
        repeat: expr
        repeat-expr: inst_attrib_groups.group_size.num_in_group
        doc: 'Number of entries'
      - id: trading_sessions_groups
        type: trading_sessions_groups
        doc: 'NoTradingSessions Block'
  trading_sessions_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: trading_sessions_group
        type: trading_sessions_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of scheduled Trading Dates'
  trading_sessions_group:
    seq:
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: settl_date
        type: u2_nullable
        doc: 'Settle (Value) Date corresponding to Trade Date. Nullable, No Value = 65535'
      - id: maturity_date
        type: u2_nullable
        doc: 'Maturity Date. Nullable, No Value = 65535'
      - id: security_alt_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Expanded instrument description. Will contain either ISIN or CUSIP'
  md_incremental_refresh_book_long_qty:
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
      - id: incremental_refresh_book_long_groups
        type: incremental_refresh_book_long_groups
        doc: 'NoMDEntries Block'
      - id: incremental_refresh_book_long_order_id_groups
        type: incremental_refresh_book_long_order_id_groups
        repeat: expr
        repeat-expr: incremental_refresh_book_long_groups.group_size.num_in_group
        doc: 'Number of OrderID entries'
  incremental_refresh_book_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_book_long_group
        type: incremental_refresh_book_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_book_long_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Aggregate booked qty at price level, notional. Nullable, No Value = 18446744073709551615'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders_optional
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
      - id: padding_1
        size: 1
        doc: '1 bytes padding'
  incremental_refresh_book_long_order_id_groups:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: md_order_priority_optional
        type: u8_nullable
        doc: 'Order priority for execution on the order book. Nullable, No Value = 18446744073709551615'
      - id: md_display_qty_optional
        type: s4_nullable
        doc: 'Visible qty of order. Nullable, No Value = 2147483647'
      - id: reference_id
        type: u1_nullable
        doc: 'Reference to corresponding Price and Security ID, sequence of MD entry in the message. Nullable, No Value = 255'
      - id: order_update_action
        type: u1
        enum: order_update_action
        doc: 'Order book update action to be applied to the order referenced by OrderID'
      - id: padding_2
        size: 2
        doc: '2 bytes padding'
  md_incremental_refresh_trade_summary_long_qty:
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
      - id: incremental_refresh_trade_summary_long_groups
        type: incremental_refresh_trade_summary_long_groups
        doc: 'NoMDEntries Block'
      - id: incremental_refresh_trade_summary_long_order_id_groups
        type: incremental_refresh_trade_summary_long_order_id_groups
        doc: 'NoOrderIDEntries Block'
  incremental_refresh_trade_summary_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_trade_summary_long_group
        type: incremental_refresh_trade_summary_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of Trade Summary entries'
  incremental_refresh_trade_summary_long_group:
    seq:
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: md_entry_size
        type: u8
        doc: 'Consolidated trade quantity, notional'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: number_of_orders
        type: s4
        doc: 'The total number of real orders per instrument that participated in a match step within a match event'
      - id: md_trade_entry
        type: u4
        doc: 'Market Data Trade Entry ID'
      - id: aggressor_side
        type: u1_nullable
        doc: 'Indicates which side is the aggressor or if there is no aggressor. Nullable, No Value = 255'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: padding_6
        size: 6
        doc: '6 bytes padding'
  incremental_refresh_trade_summary_long_order_id_groups:
    seq:
      - id: group_size_8_byte
        type: group_size_8_byte
        doc: '8 Byte aligned repeating group dimensions'
      - id: incremental_refresh_trade_summary_long_order_id_group
        type: incremental_refresh_trade_summary_long_order_id_group
        repeat: expr
        repeat-expr: group_size_8_byte.num_in_group
        doc: 'Number of OrderID and LastQty entries in Trade Summary message'
  incremental_refresh_trade_summary_long_order_id_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique Order ID'
      - id: last_qty
        type: s4
        doc: 'Quantity bought or sold on this last fill'
      - id: padding_4
        size: 4
        doc: '4 bytes padding'
  md_incremental_refresh_volume_long_qty:
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
      - id: incremental_refresh_volume_long_groups
        type: incremental_refresh_volume_long_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_volume_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_volume_long_group
        type: incremental_refresh_volume_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_volume_long_group:
    seq:
      - id: md_entry_size
        type: u8
        doc: 'Consolidated trade quantity, notional'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'Market Data update action'
      - id: padding_7
        size: 7
        doc: '7 bytes padding'
  md_incremental_refresh_session_statistics_long_qty:
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
      - id: incremental_refresh_session_statistics_long_groups
        type: incremental_refresh_session_statistics_long_groups
        doc: 'NoMDEntries Block'
  incremental_refresh_session_statistics_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: incremental_refresh_session_statistics_long_group
        type: incremental_refresh_session_statistics_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  incremental_refresh_session_statistics_long_group:
    seq:
      - id: md_entry_px_ex
        type: decimal_s8_9
        doc: 'Trade price. Implied decimal with scale 1e-9'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Aggregate booked qty at price level, notional. Nullable, No Value = 18446744073709551615'
      - id: security_id
        type: s4
        doc: 'Security ID'
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
  snapshot_full_refresh_tcp_long_qty:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: match_event_indicator
        type: match_event_indicator
        doc: 'MatchEventIndicator bit set'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: snapshotfull_refresh_tcp_long_groups
        type: snapshotfull_refresh_tcp_long_groups
        doc: 'NoMDEntries Block'
  snapshotfull_refresh_tcp_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshotfull_refresh_tcp_long_group
        type: snapshotfull_refresh_tcp_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshotfull_refresh_tcp_long_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Aggregate booked qty at price level, notional. Nullable, No Value = 18446744073709551615'
      - id: number_of_orders_optional
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level_unsigned_optional
        type: u1_nullable
        doc: 'Aggregate book level. Nullable, No Value = 255'
      - id: open_close_settl_flag
        type: u1_nullable
        doc: 'Flag describing IOP and Open Price entries. Nullable, No Value = 255'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Market Data entry type'
  snapshot_full_refresh_long_qty:
    seq:
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'Sequence number of the last Incremental feed packet processed. This value is used to synchronize the snapshot loop with the real-time feed'
      - id: tot_num_reports
        type: u4
        doc: 'Total number of messages replayed in the loop'
      - id: security_id
        type: s4
        doc: 'Security ID'
      - id: rpt_seq
        type: u4
        doc: 'Sequence number of the last Market Data entry processed for the instrument'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Start of event processing time in number of nanoseconds since Unix epoch. Nanoseconds since Unix epoch'
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'UTC Date and time of last Security Definition add, update or delete on a given Market Data channel. Nanoseconds since Unix epoch'
      - id: trade_date
        type: u2_nullable
        doc: 'Trade Session Date. Nullable, No Value = 65535'
      - id: md_security_trading_status
        type: u1_nullable
        doc: 'Identifies the current trading state of the instrument. Nullable, No Value = 255'
      - id: high_limit_price
        type: decimal_s8_9_nullable
        doc: 'Upper price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: low_limit_price
        type: decimal_s8_9_nullable
        doc: 'Lower price threshold for the instrument. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: max_price_variation
        type: decimal_s8_9_nullable
        doc: 'Differential value for price banding. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: snapshot_full_refresh_long_groups
        type: snapshot_full_refresh_long_groups
        doc: 'NoMDEntries Block'
  snapshot_full_refresh_long_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'Repeating group dimensions'
      - id: snapshot_full_refresh_long_group
        type: snapshot_full_refresh_long_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'Number of entries in Market Data message'
  snapshot_full_refresh_long_group:
    seq:
      - id: md_entry_px_optional_ex
        type: decimal_s8_9_nullable
        doc: 'Workup price. Implied decimal with scale 1e-9. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: u8_nullable
        doc: 'Aggregate booked qty at price level, notional. Nullable, No Value = 18446744073709551615'
      - id: number_of_orders_optional
        type: s4_nullable
        doc: 'In Book entry - aggregate number of orders at given price level. Nullable, No Value = 2147483647'
      - id: md_price_level_unsigned_optional
        type: u1_nullable
        doc: 'Aggregate book level. Nullable, No Value = 255'
      - id: open_close_settl_flag
        type: u1_nullable
        doc: 'Flag describing IOP and Open Price entries. Nullable, No Value = 255'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'Market Data entry type'
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
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 2147483647
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
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == 127
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
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
    30:
      id: 'security_status'
      doc: 'SecurityStatus'
    37:
      id: 'md_incremental_refresh_volume'
      doc: 'MDIncrementalRefreshVolume'
    39:
      id: 'quote_request'
      doc: 'QuoteRequest'
    46:
      id: 'md_incremental_refresh_book'
      doc: 'MDIncrementalRefreshBook'
    47:
      id: 'md_incremental_refresh_order_book'
      doc: 'MDIncrementalRefreshOrderBook'
    48:
      id: 'md_incremental_refresh_trade_summary'
      doc: 'MDIncrementalRefreshTradeSummary'
    49:
      id: 'md_incremental_refresh_daily_statistics'
      doc: 'MDIncrementalRefreshDailyStatistics'
    50:
      id: 'md_incremental_refresh_limits_banding'
      doc: 'MDIncrementalRefreshLimitsBanding'
    51:
      id: 'md_incremental_refresh_session_statistics'
      doc: 'MDIncrementalRefreshSessionStatistics'
    52:
      id: 'snapshot_full_refresh'
      doc: 'SnapshotFullRefresh'
    53:
      id: 'snapshot_full_refresh_order_book'
      doc: 'SnapshotFullRefreshOrderBook'
    54:
      id: 'md_instrument_definition_future'
      doc: 'MDInstrumentDefinitionFuture'
    55:
      id: 'md_instrument_definition_option'
      doc: 'MDInstrumentDefinitionOption'
    56:
      id: 'md_instrument_definition_spread'
      doc: 'MDInstrumentDefinitionSpread'
    57:
      id: 'md_instrument_definition_fixed_income'
      doc: 'MDInstrumentDefinitionFixedIncome'
    58:
      id: 'md_instrument_definition_repo'
      doc: 'MDInstrumentDefinitionRepo'
    59:
      id: 'snapshot_refresh_top_orders'
      doc: 'SnapshotRefreshTopOrders'
    60:
      id: 'security_status_workup'
      doc: 'SecurityStatusWorkup'
    61:
      id: 'snapshot_full_refresh_tcp'
      doc: 'SnapshotFullRefreshTCP'
    62:
      id: 'collateral_market_value'
      doc: 'CollateralMarketValue'
    63:
      id: 'md_instrument_definition_fx'
      doc: 'MDInstrumentDefinitionFX'
    64:
      id: 'md_incremental_refresh_book_long_qty'
      doc: 'MDIncrementalRefreshBookLongQty'
    65:
      id: 'md_incremental_refresh_trade_summary_long_qty'
      doc: 'MDIncrementalRefreshTradeSummaryLongQty'
    66:
      id: 'md_incremental_refresh_volume_long_qty'
      doc: 'MDIncrementalRefreshVolumeLongQty'
    67:
      id: 'md_incremental_refresh_session_statistics_long_qty'
      doc: 'MDIncrementalRefreshSessionStatisticsLongQty'
    68:
      id: 'snapshot_full_refresh_tcp_long_qty'
      doc: 'SnapshotFullRefreshTCPLongQty'
    69:
      id: 'snapshot_full_refresh_long_qty'
      doc: 'SnapshotFullRefreshLongQty'
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
    201:
      id: 'private_workup'
      doc: 'Private Workup'
    202:
      id: 'public_workup'
      doc: 'Public Workup'
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
    7:
      id: 'trade_date_roll'
      doc: 'Trade Date Roll'
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
    7:
      id: 'end_of_workup'
      doc: 'End Of Workup'
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
    0x77:
      id: 'market_best_offer'
      doc: 'Market Best Offer'
    0x78:
      id: 'market_best_bid'
      doc: 'Market Best Bid'
  order_update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'update'
      doc: 'Update'
    2:
      id: 'delete_field'
      doc: 'Delete'
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
    100:
      id: 'intraday_vwap'
      doc: 'Latest update to VWAP'
    101:
      id: 'repo_average_830_am'
      doc: 'Repo Average 8-30 AM'
    102:
      id: 'repo_average_10_am'
      doc: 'Repo Average 10 AM'
    103:
      id: 'prev_session_repo_average_10_am'
      doc: 'Prev Session Repo Average 10 AM'
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
    0x39:
      id: 'vwap'
      doc: 'Trading Session Volume Weighted Average Price'
    0x4e:
      id: 'highest_bid'
      doc: 'Highest Bid'
    0x4f:
      id: 'lowest_offer'
      doc: 'Lowest Offer'
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
    201:
      id: 'private_workup'
      doc: 'Private Workup'
    202:
      id: 'public_workup'
      doc: 'Public Workup'
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
      id: 'open_price'
      doc: 'Open Price'
    0x36:
      id: 'settlement_price'
      doc: 'Settlement Price'
    0x37:
      id: 'trading_session_high_price'
      doc: 'Trading Session High Price'
    0x38:
      id: 'trading_session_low_price'
      doc: 'Trading Session Low Price'
    0x39:
      id: 'vwap'
      doc: 'Trading Session Volume Weighted Average Price'
    0x42:
      id: 'cleared_volume'
      doc: 'Cleared Volume'
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
      id: 'book_reset'
      doc: 'Book Reset'
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
    0x77:
      id: 'market_best_offer'
      doc: 'Market Best Offer'
    0x78:
      id: 'market_best_bid'
      doc: 'Market Best Bid'
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
  event_type:
    5:
      id: 'activation'
      doc: 'Activation'
    7:
      id: 'last_eligible_trade_date'
      doc: 'Last Eligible Trade Date'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put Option'
    1:
      id: 'call'
      doc: 'Call Option'
  leg_side:
    1:
      id: 'buy_side'
      doc: 'Buy Side'
    2:
      id: 'sell_side'
      doc: 'Sell Side'
  security_alt_id_source:
    1:
      id: 'cusip'
      doc: 'CUSIP (9 char)'
    4:
      id: 'isin'
      doc: 'ISIN (12 char)'
  repo_sub_type:
    0:
      id: 'special'
      doc: 'Repo on a single underlying instrument'
    1:
      id: 'gc'
      doc: 'General Collateral Repo on a single or basket of eligible underlyings, allocation at BrokerTec'
    2:
      id: 'gc_for_dbv'
      doc: 'General Collateral Repo on a single or basket of eligible underlyings, allocation outside of BrokerTec, such as at the clearer, tri-party agent, etc.'
  money_or_par:
    1:
      id: 'money'
      doc: 'Money Filled'
    2:
      id: 'par'
      doc: 'Par Filled'
  underlying_security_alt_id_source:
    1:
      id: 'cusip'
      doc: 'CUSIP (9 char)'
    4:
      id: 'isin'
      doc: 'ISIN (12 char)'
  workup_trading_status:
    17:
      id: 'ready_to_trade'
      doc: 'Ready To Trade'
    18:
      id: 'not_available_for_trading'
      doc: 'Not Available For Trading'
    201:
      id: 'private_workup'
      doc: 'Private Workup'
    202:
      id: 'public_workup'
      doc: 'Public Workup'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  aggressor_indicator:
    0:
      id: 'not_aggressor'
      doc: 'Not Aggressor'
    1:
      id: 'aggressor'
      doc: 'Aggressor'
  md_stream_id:
    0:
      id: 'market_place_assistant'
      doc: 'Globex Market Surveillance team'
    1:
      id: 'globex'
      doc: 'Globex Trading Activity'
    2:
      id: 'refinitiv'
      doc: 'Refinitiv'
    3:
      id: 'icap'
      doc: 'Icap Market Data Feed'

