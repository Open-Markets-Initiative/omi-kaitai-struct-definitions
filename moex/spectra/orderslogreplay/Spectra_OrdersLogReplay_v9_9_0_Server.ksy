# ---------------------------------------------------------------------
# Kaitai struct definition for: Moex Spectra OrdersLogReplay Simba v9.9.0
#
# Protocol:
#   Organization: Moscow Exchange
#   Protocol: SIMBA Spectra Orders Log Historical Replay
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
  id: moex_spectra_orderslogreplay_simba_v9_9_0_server
  title: Moex Spectra OrdersLogReplay Simba v9.9.0
  license: GPL-3.0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market SIMBA Spectra Orders Log Historical Replay Simba v9.9.0'
doc-ref: https://ftp.moex.com/pub/SIMBA/Spectra/

seq:
  - id: server_frame
    type: server_frame_struct
    repeat: eos
    doc: 'One packet sent by the gateway, snapshot framed or incremental framed: the unit the Tcp stream repeats'

types:
  server_frame_struct:
    seq:
      - id: market_data_packet_header
        type: market_data_packet_header
        doc: 'MarketDataDummyMessage'
      - id: server_body
        size: market_data_packet_header.msg_size - 16
        type:
          switch-on: market_data_packet_header.msg_flags.incremental_packet
          cases:
            false: server_session
            true: server_replay
  market_data_packet_header:
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
  server_session:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Root block length, message template id, message schema id and schema version'
      - id: server_session_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::logout_message': logout_message
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
  logout_message:
    seq:
      - id: text
        type: str
        size: 256
        encoding: ASCII
        doc: 'Text'
      - id: block_extension
        size: _parent.sbe_header.block_length - 256
        doc: 'Bytes the stated block holds beyond the 256 this version reads'
  server_replay:
    seq:
      - id: incremental_packet_header
        type: incremental_packet_header
        doc: 'MarketDataDummyMessage'
      - id: server_replay_message
        type: server_replay_message
        repeat: eos
        doc: 'Moex Simba Market Data Message, one of the one or more an incremental packet carries'
  incremental_packet_header:
    seq:
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'TransactTime. Nanoseconds since Unix epoch'
      - id: exchange_trading_session_id
        type: u4
        doc: 'ExchangeTradingSessionID'
  server_replay_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Root block length, message template id, message schema id and schema version'
      - id: server_replay_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::best_prices_message': best_prices_message
            'template_id::empty_book_message': empty_book_message
            'template_id::order_update_message': order_update_message
            'template_id::order_execution_message': order_execution_message
  best_prices_message:
    seq:
      - id: best_prices_message_no_m_d_entries_groups
        type: best_prices_message_no_m_d_entries_groups
        doc: 'NoMDEntries Block'
  best_prices_message_no_m_d_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: best_prices_message_no_m_d_entries_group
        type: best_prices_message_no_m_d_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group_uint_8
        doc: 'NoMDEntries'
  group_size:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group_uint_8
        type: u1
        doc: 'numInGroup'
  best_prices_message_no_m_d_entries_group:
    seq:
      - id: mkt_bid_px
        type: decimal_s8_5_nullable
        doc: 'Best bid price. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: mkt_offer_px
        type: decimal_s8_5_nullable
        doc: 'Best offer price. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: mkt_bid_size
        type: s8_nullable
        doc: 'Total qty in best bid. Nullable, No Value = -9223372036854775808'
      - id: mkt_offer_size
        type: s8_nullable
        doc: 'Total qty in best offer. Nullable, No Value = -9223372036854775808'
      - id: security_id
        type: s4
        doc: 'SecurityID'
      - id: block_extension
        size: _parent.group_size.block_length - 36
        doc: 'Bytes the stated block holds beyond the 36 this version reads'
  empty_book_message:
    seq:
      - id: last_msg_seq_num_processed_u_int_32_null_optional
        type: u4_nullable
        doc: 'LastMsgSeqNumProcessed. Nullable, No Value = 4294967295'
      - id: block_extension
        size: _parent.sbe_header.block_length - 4
        doc: 'Bytes the stated block holds beyond the 4 this version reads'
  order_update_message:
    seq:
      - id: md_entry_id_int_64
        type: s8
        doc: 'MDEntryID'
      - id: md_entry_px_decimal_5
        type: decimal_s8_5
        doc: 'MDEntryPx. Implied decimal with scale 1e-5'
      - id: md_entry_size_int_64
        type: s8
        doc: 'MDEntrySize'
      - id: md_flags
        type: md_flags
        doc: 'MDFlagsSet bit set'
      - id: md_flags_2
        type: md_flags_2
        doc: 'MDFlags2Set bit set'
      - id: security_id
        type: s4
        doc: 'SecurityID'
      - id: rpt_seq
        type: u4
        doc: 'RptSeq'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'MDUpdateAction'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'MDEntryType'
      - id: block_extension
        size: _parent.sbe_header.block_length - 50
        doc: 'Bytes the stated block holds beyond the 50 this version reads'
  md_flags:
    meta:
      bit-endian: le
    seq:
      - id: day
        type: b1
        doc: 'Day'
      - id: ioc
        type: b1
        doc: 'IOC'
      - id: non_quote
        type: b1
        doc: 'NonQuote'
      - id: unused_md_flags_set_3
        type: b1
        doc: 'Unused MDFlagsSet 3'
      - id: unused_md_flags_set_4
        type: b1
        doc: 'Unused MDFlagsSet 4'
      - id: unused_md_flags_set_5
        type: b1
        doc: 'Unused MDFlagsSet 5'
      - id: unused_md_flags_set_6
        type: b1
        doc: 'Unused MDFlagsSet 6'
      - id: unused_md_flags_set_7
        type: b1
        doc: 'Unused MDFlagsSet 7'
      - id: unused_md_flags_set_8
        type: b1
        doc: 'Unused MDFlagsSet 8'
      - id: unused_md_flags_set_9
        type: b1
        doc: 'Unused MDFlagsSet 9'
      - id: unused_md_flags_set_10
        type: b1
        doc: 'Unused MDFlagsSet 10'
      - id: unused_md_flags_set_11
        type: b1
        doc: 'Unused MDFlagsSet 11'
      - id: end_of_transaction
        type: b1
        doc: 'EndOfTransaction'
      - id: due_to_cross_cancel
        type: b1
        doc: 'DueToCrossCancel'
      - id: second_leg
        type: b1
        doc: 'SecondLeg'
      - id: unused_md_flags_set_15
        type: b1
        doc: 'Unused MDFlagsSet 15'
      - id: unused_md_flags_set_16
        type: b1
        doc: 'Unused MDFlagsSet 16'
      - id: unused_md_flags_set_17
        type: b1
        doc: 'Unused MDFlagsSet 17'
      - id: unused_md_flags_set_18
        type: b1
        doc: 'Unused MDFlagsSet 18'
      - id: fok
        type: b1
        doc: 'FOK'
      - id: replace
        type: b1
        doc: 'Replace'
      - id: cancel
        type: b1
        doc: 'Cancel'
      - id: mass_cancel
        type: b1
        doc: 'MassCancel'
      - id: unused_md_flags_set_23
        type: b1
        doc: 'Unused MDFlagsSet 23'
      - id: unused_md_flags_set_24
        type: b1
        doc: 'Unused MDFlagsSet 24'
      - id: unused_md_flags_set_25
        type: b1
        doc: 'Unused MDFlagsSet 25'
      - id: negotiated
        type: b1
        doc: 'Negotiated'
      - id: multi_leg
        type: b1
        doc: 'MultiLeg'
      - id: unused_md_flags_set_28
        type: b1
        doc: 'Unused MDFlagsSet 28'
      - id: cross_trade
        type: b1
        doc: 'CrossTrade'
      - id: unused_md_flags_set_30
        type: b1
        doc: 'Unused MDFlagsSet 30'
      - id: negotiated_match_by_ref
        type: b1
        doc: 'NegotiatedMatchByRef'
      - id: cod
        type: b1
        doc: 'COD'
      - id: unused_md_flags_set_33
        type: b1
        doc: 'Unused MDFlagsSet 33'
      - id: unused_md_flags_set_34
        type: b1
        doc: 'Unused MDFlagsSet 34'
      - id: unused_md_flags_set_35
        type: b1
        doc: 'Unused MDFlagsSet 35'
      - id: unused_md_flags_set_36
        type: b1
        doc: 'Unused MDFlagsSet 36'
      - id: unused_md_flags_set_37
        type: b1
        doc: 'Unused MDFlagsSet 37'
      - id: unused_md_flags_set_38
        type: b1
        doc: 'Unused MDFlagsSet 38'
      - id: unused_md_flags_set_39
        type: b1
        doc: 'Unused MDFlagsSet 39'
      - id: unused_md_flags_set_40
        type: b1
        doc: 'Unused MDFlagsSet 40'
      - id: active_side
        type: b1
        doc: 'ActiveSide'
      - id: passive_side
        type: b1
        doc: 'PassiveSide'
      - id: unused_md_flags_set_43
        type: b1
        doc: 'Unused MDFlagsSet 43'
      - id: unused_md_flags_set_44
        type: b1
        doc: 'Unused MDFlagsSet 44'
      - id: synthetic
        type: b1
        doc: 'Synthetic'
      - id: rfs
        type: b1
        doc: 'RFS'
      - id: unused_md_flags_set_47
        type: b1
        doc: 'Unused MDFlagsSet 47'
      - id: unused_md_flags_set_48
        type: b1
        doc: 'Unused MDFlagsSet 48'
      - id: unused_md_flags_set_49
        type: b1
        doc: 'Unused MDFlagsSet 49'
      - id: unused_md_flags_set_50
        type: b1
        doc: 'Unused MDFlagsSet 50'
      - id: unused_md_flags_set_51
        type: b1
        doc: 'Unused MDFlagsSet 51'
      - id: unused_md_flags_set_52
        type: b1
        doc: 'Unused MDFlagsSet 52'
      - id: unused_md_flags_set_53
        type: b1
        doc: 'Unused MDFlagsSet 53'
      - id: unused_md_flags_set_54
        type: b1
        doc: 'Unused MDFlagsSet 54'
      - id: unused_md_flags_set_55
        type: b1
        doc: 'Unused MDFlagsSet 55'
      - id: unused_md_flags_set_56
        type: b1
        doc: 'Unused MDFlagsSet 56'
      - id: synthetic_passive
        type: b1
        doc: 'SyntheticPassive'
      - id: unused_md_flags_set_58
        type: b1
        doc: 'Unused MDFlagsSet 58'
      - id: unused_md_flags_set_59
        type: b1
        doc: 'Unused MDFlagsSet 59'
      - id: boc
        type: b1
        doc: 'BOC'
      - id: unused_md_flags_set_61
        type: b1
        doc: 'Unused MDFlagsSet 61'
      - id: during_discrete_auction
        type: b1
        doc: 'DuringDiscreteAuction'
      - id: unused_md_flags_set_63
        type: b1
        doc: 'Unused MDFlagsSet 63'
  md_flags_2:
    meta:
      bit-endian: le
    seq:
      - id: zero
        type: b1
        doc: 'Zero'
      - id: reserved_63
        type: b63
        doc: '63 reserved bits'
  order_execution_message:
    seq:
      - id: md_entry_id_int_64
        type: s8
        doc: 'MDEntryID'
      - id: md_entry_px_decimal_5_null_optional
        type: decimal_s8_5_nullable
        doc: 'MDEntryPx. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_int_64_null_optional
        type: s8_nullable
        doc: 'MDEntrySize. Nullable, No Value = -9223372036854775808'
      - id: last_px
        type: decimal_s8_5
        doc: 'LastPx. Implied decimal with scale 1e-5'
      - id: last_qty
        type: s8
        doc: 'LastQty'
      - id: trade_id_int_64
        type: s8
        doc: 'TradeID'
      - id: md_flags
        type: md_flags
        doc: 'MDFlagsSet bit set'
      - id: md_flags_2
        type: md_flags_2
        doc: 'MDFlags2Set bit set'
      - id: security_id
        type: s4
        doc: 'SecurityID'
      - id: rpt_seq
        type: u4
        doc: 'RptSeq'
      - id: md_update_action
        type: u1
        enum: md_update_action
        doc: 'MDUpdateAction'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'MDEntryType'
      - id: block_extension
        size: _parent.sbe_header.block_length - 74
        doc: 'Bytes the stated block holds beyond the 74 this version reads'
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295

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
  md_entry_type:
    0x30:
      id: 'bid'
      doc: 'Bid'
    0x31:
      id: 'offer'
      doc: 'Offer'
    0x4a:
      id: 'empty_book'
      doc: 'Empty Book'

