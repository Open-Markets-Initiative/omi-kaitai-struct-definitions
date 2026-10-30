# ---------------------------------------------------------------------
# Kaitai struct definition for: Gpw Wse Bonds Xdp v6.8
#
# Protocol:
#   Organization: Giełda Papierów Wartościowych w Warszawie
#   Protocol: Warsaw Stock Exchange Bonds
#   Encoding: Exchange Data Publisher
#   Version: 6.8
#   Date: 02/11/2020
#   Specification: WSE_CDE_XDP_Message_Specifications_v_68.pdf
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
  id: gpw_wse_bonds_xdp_v6_8
  title: Gpw Wse Bonds Xdp v6.8
  license: GPL-3.0
  endian: be

doc: 'Giełda Papierów Wartościowych w Warszawie Warsaw Stock Exchange Warsaw Stock Exchange Bonds Xdp v6.8'
doc-ref: https://www.gpw.pl/utp-documentation

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'All messages are preceded by a common packet header format, which section 1.1 states for every Market Information message'
  - id: message_buffer
    type: message_buffer_struct
    size-eos: true
    doc: 'The packet''s message area: the messages it counts, or one ZliB block holding them'

types:
  packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of the packet including the 16 byte packet header'
      - id: packet_type
        type: u2
        enum: packet_type
        doc: 'Identifier for the type of data contained in the packet. Section 1.1 states one value, 501 for Market Data messages, for every feed the document specifies'
      - id: packet_sequence_number
        type: u4
        doc: 'The packet sequence number, unique for each broadcast stream and used for gap detection. It increases serially and monotonically and is reset to 1 at the beginning of each trading day. It is unique for packets containing market data only, and heartbeats inherit it from the last market data packet or packet sequence number reset packet'
      - id: send_time
        type: u4
        doc: 'Timestamp in millisecond indicating the packet broadcast time. The number represents the number of milliseconds since midnight of the last Sunday 00:00 UTC, a weekly epoch no Epoch trait represents, so the field carries no epoch and a reader resolves the absolute time against the Sunday preceding the capture'
      - id: service_id
        type: u2
        doc: 'Numeric value identifying the broadcast stream. Section 1.1 states that the possible values are described in the XDP CDE Configuration document, a companion this specification does not reproduce, so no value set is declared here'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'Indicates delivery method, and a client reads it to determine whether the packet is ZliB compressed'
      - id: number_msg_entries
        type: u1
        doc: 'The number of messages that are contained within the packet'
  message_buffer_struct:
    seq:
      - id: message
        type: message
        repeat: expr
        repeat-expr: _root.packet_header.number_msg_entries
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size + 2 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::accrued_interest_message': accrued_interest_message
            'message_type::interest_for_settlement_day_message': interest_for_settlement_day_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Length of the message body, excluding the 2 byte MsgSize field'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  accrued_interest_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: number_days
        type: u2
        doc: 'Number of days for which accrued interest is provided'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: accrued_interest_scale_code
        type: u1
        doc: 'Applicable to all accrued interests'
      - id: reserved_3
        size: 3
        doc: 'For future use'
      - id: accrued_interest_group
        type: accrued_interest_group
        repeat: expr
        repeat-expr: 31
        doc: 'Group repeated 31 times, the combination Date / Accrued Interest'
  accrued_interest_group:
    seq:
      - id: date
        type: yyyymmdd_date
        doc: 'Stock Exchange date (YYYYMMDD)'
      - id: accrued_interest
        type: u4
        doc: 'Accrued interest for the day defined by field date'
  interest_for_settlement_day_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'UTP-MD proprietary identification of the instrument'
      - id: source_time
        type: millisecond_timestamp
        doc: 'This field specifies the message generation time. Milliseconds since Midnight epoch'
      - id: source_seq_num
        type: u4
        doc: 'This field specifies the sequence number assigned by the source system to this message'
      - id: system_id
        type: u4
        enum: system_id
        doc: 'The ID of the originating Exchange/System of the message'
      - id: date
        type: yyyymmdd_date
        doc: 'Stock Exchange date (YYYYMMDD)'
      - id: settlement_date
        type: yyyymmdd_ascii_date
        doc: 'Settlement date (YYYYMMDD)'
      - id: interest
        type: u4
        doc: 'Interest for the settlement day defined by field "SettlementDate". Provided with 0 if settlement date is not significant'
      - id: source_time_micro_secs
        type: u2
        doc: 'Number of micro seconds to be combined with SourceTime'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code of the currency in which the interest is determined'
      - id: interest_scale_code
        type: u1
        doc: 'Applicable to the interest for the settlement day'
      - id: reserved_2
        size: 2
        doc: 'For future use'
  millisecond_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600000 % 24
      minute:
        value: time / 60000 % 60
      second:
        value: time / 1000 % 60
      millisecond:
        value: time % 1000
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
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i

enums:
  packet_type:
    501:
      id: 'market_data_messages'
      doc: 'Market Data messages'
  delivery_flag:
    0:
      id: 'real_time_message_uncompressed'
      doc: 'Real Time message (Uncompressed)'
    2:
      id: 'retransmission_message_uncompressed'
      doc: 'Retransmission message (Uncompressed)'
    16:
      id: 'real_time_message_zlib_compressed'
      doc: 'Real Time message (ZliB Compressed)'
    17:
      id: 'refresh_message_zlib_compressed'
      doc: 'Refresh message (ZliB Compressed)'
    18:
      id: 'retransmission_message_compressed'
      doc: 'Retransmission message (Compressed)'
  message_type:
    601:
      id: 'accrued_interest_message'
      doc: 'This message informs about the accrued interest for bonds and mortgage- backed bonds'
    602:
      id: 'interest_for_settlement_day_message'
      doc: 'This message informs about the interest for settlement day for bonds and mortgage-backed bonds'
  system_id:
    1:
      id: 'all_non_utp_systems'
      doc: 'All Non Utp Systems'
    11:
      id: 'utp_trading_unit_1'
      doc: 'Utp Trading Unit 1'
    12:
      id: 'utp_trading_unit_2'
      doc: 'Utp Trading Unit 2'

