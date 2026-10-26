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
  id: moex_spectra_orderslogreplay_simba_v9_9_0_client
  title: Moex Spectra OrdersLogReplay Simba v9.9.0
  license: GPL-3.0
  endian: le

doc: 'Moscow Exchange MOEX Derivatives Market SIMBA Spectra Orders Log Historical Replay Simba v9.9.0'
doc-ref: https://ftp.moex.com/pub/SIMBA/Spectra/

seq:
  - id: client_frame
    type: client_frame_struct
    repeat: eos
    doc: 'One snapshot packet sent by the firm: the unit the Tcp stream repeats'

types:
  client_frame_struct:
    seq:
      - id: market_data_packet_header
        type: market_data_packet_header
        doc: 'MarketDataDummyMessage'
      - id: client_message
        type: client_message
        doc: 'Moex Simba Replay Request Message'
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
  client_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Root block length, message template id, message schema id and schema version'
      - id: client_payload
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::logout_message': logout_message
            'template_id::market_data_request_message': market_data_request_message
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
  market_data_request_message:
    seq:
      - id: appl_beg_seq_num
        type: u4
        doc: 'ApplBegSeqNum'
      - id: appl_end_seq_num
        type: u4
        doc: 'ApplEndSeqNum'
      - id: block_extension
        size: _parent.sbe_header.block_length - 8
        doc: 'Bytes the stated block holds beyond the 8 this version reads'
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

