# ---------------------------------------------------------------------
# Kaitai struct definition for: Moex Spectra OrdersLogSnapshot Simba v1.0.4
#
# Protocol:
#   Organization: Moscow Exchange
#   Protocol: SIMBA Spectra Orders Log Snapshot
#   Encoding: SIMBA
#   Version: 1.0.4
#   Date: 11/10/2021
#   Specification: spectra_simba_en.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: moex_spectra_orderslogsnapshot_simba_v1_0_4
  title: Moex Spectra OrdersLogSnapshot Simba v1.0.4
  license: MIT-0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market SIMBA Spectra Orders Log Snapshot Simba v1.0.4'
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
        doc: 'MsgFlagsSet bit set'
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
      - id: reserved_6_to_16
        type: b11
        doc: '11 reserved bits'
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
            'template_id::order_book_snapshot_message': order_book_snapshot_message
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
  order_book_snapshot_message:
    seq:
      - id: security_id
        type: s4
        doc: 'SecurityID'
      - id: last_msg_seq_num_processed
        type: u4
        doc: 'LastMsgSeqNumProcessed'
      - id: rpt_seq
        type: u4
        doc: 'RptSeq'
      - id: exchange_trading_session_id
        type: u4
        doc: 'ExchangeTradingSessionID'
      - id: block_extension
        size: _parent.sbe_header.block_length - 16
        doc: 'Bytes the stated block holds beyond the 16 this version reads'
      - id: order_book_snapshot_message_no_md_entries_groups
        type: order_book_snapshot_message_no_md_entries_groups
        doc: 'NoMDEntries Block'
  order_book_snapshot_message_no_md_entries_groups:
    seq:
      - id: group_size
        type: group_size
        doc: 'groupSize'
      - id: order_book_snapshot_message_no_md_entries_group
        type: order_book_snapshot_message_no_md_entries_group
        repeat: expr
        repeat-expr: group_size.num_in_group
        doc: 'NoMDEntries'
  group_size:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  order_book_snapshot_message_no_md_entries_group:
    seq:
      - id: md_entry_id_optional
        type: s8_nullable
        doc: 'Order ID. Nullable, No Value = -9223372036854775808'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'TransactTime. Nanoseconds since Unix epoch. Nullable, No Value = 0'
      - id: md_entry_px_optional
        type: decimal_s8_5_nullable
        doc: 'MDEntryPx. Implied decimal with scale 1e-5. Nullable, No Value = 9223372036854775807'
      - id: md_entry_size_optional
        type: s8_nullable
        doc: 'MDEntrySize. Nullable, No Value = -9223372036854775808'
      - id: trade_id_optional
        type: s8_nullable
        doc: 'Trade ID. Nullable, No Value = -9223372036854775808'
      - id: md_flags
        type: md_flags
        doc: 'MDFlagsSet bit set'
      - id: md_entry_type
        type: u1
        enum: md_entry_type
        doc: 'MDEntryType'
      - id: block_extension
        size: _parent.group_size.block_length - 49
        doc: 'Bytes the stated block holds beyond the 49 this version reads'
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
      - id: unused_bits_4_to_12
        type: b9
        doc: '9 unused bits'
      - id: end_of_transaction
        type: b1
        doc: 'EndOfTransaction'
      - id: unused_bit_14
        type: b1
        doc: '1 unused bit'
      - id: second_leg
        type: b1
        doc: 'SecondLeg'
      - id: unused_bits_16_to_19
        type: b4
        doc: '4 unused bits'
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
      - id: unused_bits_24_to_26
        type: b3
        doc: '3 unused bits'
      - id: negotiated
        type: b1
        doc: 'Negotiated'
      - id: multi_leg
        type: b1
        doc: 'MultiLeg'
      - id: unused_bit_29
        type: b1
        doc: '1 unused bit'
      - id: cross_trade
        type: b1
        doc: 'CrossTrade'
      - id: unused_bits_31_to_32
        type: b2
        doc: '2 unused bits'
      - id: cod
        type: b1
        doc: 'COD'
      - id: unused_bits_34_to_41
        type: b8
        doc: '8 unused bits'
      - id: active_side
        type: b1
        doc: 'ActiveSide'
      - id: passive_side
        type: b1
        doc: 'PassiveSide'
      - id: unused_bits_44_to_45
        type: b2
        doc: '2 unused bits'
      - id: synthetic
        type: b1
        doc: 'Synthetic'
      - id: rfs
        type: b1
        doc: 'RFS'
      - id: reserved_48_to_64
        type: b17
        doc: '17 reserved bits'
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == 0
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
    3:
      id: 'best_prices_message'
      doc: 'BestPricesMessage'
    4:
      id: 'empty_book_message'
      doc: 'EmptyBookMessage'
    5:
      id: 'order_update_message'
      doc: 'OrderUpdateMessage'
    6:
      id: 'order_execution_message'
      doc: 'OrderExecutionMessage'
    7:
      id: 'order_book_snapshot_message'
      doc: 'OrderBookSnapshotMessage'
    8:
      id: 'security_definition_message'
      doc: 'SecurityDefinitionMessage'
    9:
      id: 'security_status_message'
      doc: 'SecurityStatusMessage'
    10:
      id: 'security_definition_update_report_message'
      doc: 'SecurityDefinitionUpdateReportMessage'
    11:
      id: 'trading_session_status_message'
      doc: 'TradingSessionStatusMessage'
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

