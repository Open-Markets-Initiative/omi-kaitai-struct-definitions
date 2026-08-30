# ---------------------------------------------------------------------
# Kaitai struct definition for: OtcMarkets LinkAts Trade Link v4.10.4
#
# Protocol:
#   Organization: OTC Markets Group
#   Protocol: 
#   Encoding: Otc Link
#   Version: 4.10.4
#   Date: 6/16/2026
#   Specification: OTC Markets Multicast Data Feeds.pdf
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
  id: otcmarkets_linkats_trade_link_v4_10_4
  title: OtcMarkets LinkAts Trade Link v4.10.4
  license: GPL-3.0
  endian: be

doc: 'OTC Markets Group OTC Link ATS Link v4.10.4'
doc-ref: https://www.otcmarkets.com/market-data/technical-and-user-documentation

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.messages

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'Size of packet in bytes'
      - id: seq_num
        type: u4
        doc: 'Channel specific Sequence number of packet'
      - id: packet_flag
        type: packet_flag
        doc: 'Packet Flags'
      - id: messages
        type: u1
        doc: 'Number of messages in packet'
      - id: packet_milli
        type: millisecond_timestamp
        doc: 'Milliseconds since local time midnight (EST/EDT). Milliseconds since Midnight epoch'
  packet_flag:
    seq:
      - id: heartbeat
        type: b1
        doc: 'A Heartbeat is sent if no business level message has been published for more than a second'
      - id: seq_num_reset
        type: b1
        doc: 'indicates that the channel sequence numbers are being reset to 1'
      - id: reserved_4
        type: b4
        doc: 'Reserved 4'
      - id: replay
        type: b1
        doc: 'Packet contains replay messages'
      - id: test
        type: b1
        doc: 'Packet contains test messages'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Otc Udp Message Header'
      - id: payload
        size: message_header.message_size - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::start_of_spin_message': start_of_spin_message
            'message_type::end_of_spin_message': end_of_spin_message
            'message_type::market_open_message': market_open_message
            'message_type::market_close_message': market_close_message
            'message_type::trade_message': trade_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'Size of message in bytes'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  start_of_spin_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_start_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Last sequence number applied to this spin'
  end_of_spin_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: spin_type
        type: u1
        enum: spin_type
        doc: 'Spin type'
      - id: spin_msg_ct
        type: u4
        doc: 'Total number of messages in the spin'
      - id: spin_end_time_milli
        type: u8
        doc: 'Milliseconds since UTC epoch'
      - id: spin_last_seq_num
        type: u4
        doc: 'Last sequence number applied to this spin'
  market_open_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: market_open
        type: u8
        doc: 'Market open time in milliseconds since UTC epoch'
      - id: market_close
        type: u8
        doc: 'Anticipated market close time in milliseconds since UTC epoch'
  market_close_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: market_close_time_milli
        type: u8
        doc: 'Market close time in milliseconds since UTC epoch midnight'
      - id: market_msg_ct
        type: u4
        doc: 'Total day message count'
  trade_message:
    seq:
      - id: channel_seq_num
        type: u4
        doc: 'Monotonically increasing message sequence number at the channel level'
      - id: trade_id
        type: u4
        doc: 'Unique Trade ID'
      - id: trade_action
        type: u1
        enum: trade_action
        doc: 'Trade action indicator'
      - id: trade_flags
        type: u1
        doc: 'Trade flags. See TradeFlag definition'
      - id: security_id
        type: u4
        doc: 'OTC Markets security ID'
      - id: trade_status
        type: trade_status
        doc: 'Trade Status Information'
      - id: venue
        type: str
        size: 3
        encoding: ASCII
        doc: 'Executing venue. For the Trade Channel this is always ATS'
      - id: deprecated_utf_85
        type: str
        size: 5
        encoding: ASCII
        doc: 'Deprecated field. Spaces will be sent in message'
      - id: trade_price
        type: u8
        doc: 'Trade price. Six decimal places assumed'
      - id: trade_size
        type: u4
        doc: 'Number of shares'
      - id: trade_time_milli
        type: u8
        doc: 'Milliseconds from UTC epoch'
  trade_status:
    seq:
      - id: irregular
        type: b1
        doc: 'Indicates irregular trade'
      - id: reserved_7
        type: b7
        doc: 'Reserved Trade Flag bits'
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

enums:
  message_type:
    11:
      id: 'start_of_spin_message'
      doc: 'This message appears on all channels and indicates the beginning of a spin message cycle.'
    12:
      id: 'end_of_spin_message'
      doc: 'This message appears on all channels and indicates the end of a spin message cycle.'
    13:
      id: 'market_open_message'
      doc: 'This message is sent out at 6 AM on all channels. The message can also be sent mid-day if a technical outage caused a temporary closure of the market.'
    14:
      id: 'market_close_message'
      doc: 'This message is sent out at 5 PM on all channels. The message can also be sent mid-day if a technical outage causes a temporary closure of the market.'
    17:
      id: 'trade_message'
      doc: 'A Trade Message is created for every trade that occurs on OTC Markets OTC Link ATS.'
  spin_type:
    1:
      id: 'reference'
      doc: 'Reference Spin'
    2:
      id: 'market_data'
      doc: 'Market Data Spin'
    3:
      id: 'opening'
      doc: 'Opening Spin'
  trade_action:
    2:
      id: 'add'
      doc: 'Add'

