# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nyse ArcaEquities ArcaBook v2.1
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: arcaequities_arcabook_v2_1
  title: Nyse ArcaEquities ArcaBook Pillar v2.1
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Equities ArcaBook Pillar v2.1'
doc-ref: https://www.nyse.com/market-data/real-time/arcabook

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'ArcaBook common client udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msgs
    doc: 'ArcaBook message'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'A flag that indicates whether this is an original, retransmitted, or ''replayed'' message'
      - id: number_msgs
        type: u1
        doc: 'The number of messages in this packet'
      - id: seq_num
        type: u4
        doc: 'The message sequence number of the first message in this packet'
      - id: send_time
        type: send_time
        doc: 'The time when this packet was published to the multicast channel. nanoseconds since Unix epoch'
  send_time:
    seq:
      - id: seconds
        type: u4
        doc: 'Seconds since Jan 1, 1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'The nanosecond offset from the Send Time'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'ArcaBook message header'
      - id: payload
        size: message_header.message_size - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::execution_message': execution_message
            'message_type::imbalance_message': imbalance_message
            'message_type::add_order_refresh_message': add_order_refresh_message
            'message_type::attributed_add_order_message': attributed_add_order_message
            'message_type::attributed_add_order_refresh_message': attributed_add_order_refresh_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'The size of this message in bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  add_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trade session indicator'
  modify_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason'
  delete_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason'
  execution_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason'
      - id: trade_id
        type: u4
        doc: 'The TradeID identifies a unique transaction in the matching engine and allows clients to correlate execution reports to the last sale'
  imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: indicative_match_price
        type: s4
        doc: 'The best price at which the maximum volume of shares is executable in the applicable auction, subject to Auction Collars. Implied decimal with scale 1e-8'
      - id: paired_qty
        type: u4
        doc: 'The number of shares paired off at the Indicative Match Price'
      - id: total_imbalance_qty
        type: u4
        doc: 'The total imbalance quantity at the Indicative Match Price. If the value is negative, the imbalance is on the Sell side, otherwise, the Buy side'
      - id: market_imbalance_qty
        type: u4
        doc: 'The total market order imbalance at the Indicative Match Price. If the value is negative, the imbalance is on the Sell side, otherwise, the Buy side'
      - id: auction_time
        type: u2
        doc: 'Projected Auction Time (hhmm)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type indicator'
      - id: imbalance_side
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not supported, defaulted to 0'
      - id: continuous_book_clearing_price
        type: s4
        doc: 'Not supported, defaulted to 0. Implied decimal with scale 1e-8'
      - id: closing_only_clearing_price
        type: s4
        doc: 'Not supported, defaulted to 0. Implied decimal with scale 1e-8'
      - id: ssr_filing_price
        type: s4
        doc: 'Not supported, defaulted to 0. Implied decimal with scale 1e-8'
  add_order_refresh_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trade session indicator'
  attributed_add_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trade session indicator'
      - id: firm_id
        size: 5
        doc: 'This field provides market participant''s firm ID'
  attributed_add_order_refresh_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: order_id
        type: u4
        doc: 'The Order ID identifies a unique order'
      - id: price
        type: s4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trade session indicator'
      - id: firm_id
        size: 5
        doc: 'This field provides market participant''s firm ID'

enums:
  delivery_flag:
    1:
      id: 'heartbeat'
      doc: 'Heartbeat'
    10:
      id: 'xdp_failover'
      doc: 'XDP Failover'
    11:
      id: 'original_message'
      doc: 'Original Message'
    12:
      id: 'sequence_number_reset_message'
      doc: 'Sequence Number Reset Message'
    13:
      id: 'one_retransmission_packet'
      doc: 'Only one packet in retransmission sequence'
    15:
      id: 'retransmission_sequence_message'
      doc: 'Part of a retransmission sequence'
    17:
      id: 'one_refresh_packet'
      doc: 'Only one packet in Refresh sequence'
    18:
      id: 'refresh_sequence_start'
      doc: 'Start of Refresh sequence'
    19:
      id: 'refresh_sequence_message'
      doc: 'Part of a Refresh sequence'
    20:
      id: 'refresh_sequence_end'
      doc: 'End of Refresh sequence'
    21:
      id: 'message_unavailable'
      doc: 'Message Unavailable'
  message_type:
    100:
      id: 'add_order_message'
      doc: 'ArcaBook Add Order Message'
    101:
      id: 'modify_order_message'
      doc: 'ArcaBook Modify Order Message'
    102:
      id: 'delete_order_message'
      doc: 'ArcaBook Delete Order Message'
    103:
      id: 'execution_message'
      doc: 'ArcaBook Execution Message'
    105:
      id: 'imbalance_message'
      doc: 'ArcaBook Imbalance Message'
    106:
      id: 'add_order_refresh_message'
      doc: 'ArcaBook Add Order Refresh Message'
    107:
      id: 'attributed_add_order_message'
      doc: 'ArcaBook Attributed Add Order Message'
    108:
      id: 'attributed_add_order_refresh_message'
      doc: 'ArcaBook Attributed Add Order Refresh Message'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  order_idgtc_indicator:
    0:
      id: 'day_order'
      doc: 'Day Order'
    1:
      id: 'gtc_order'
      doc: 'Gtc Order'
  trade_session:
    1:
      id: 'ok_for_morning_hours'
      doc: 'Ok For Morning Hours'
    2:
      id: 'ok_for_national_hours_core'
      doc: 'Ok For National Hours Core'
    3:
      id: 'ok_for_morning_and_core'
      doc: 'Ok For Morning And Core'
    4:
      id: 'ok_for_late_hours'
      doc: 'Ok For Late Hours'
    6:
      id: 'ok_for_core_and_late'
      doc: 'Ok For Core And Late'
    7:
      id: 'ok_for_morning_core_and_late'
      doc: 'Ok For Morning Core And Late'
  auction_type:
    0x4f:
      id: 'early_opening_auction'
      doc: 'Early Opening Auction'
    0x4d:
      id: 'core_opening_auction'
      doc: 'Core Opening Auction'
    0x48:
      id: 'trading_halt_auction'
      doc: 'Trading Halt Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: New York Stock Exchange
#   Version: 2.1
#   Date: 10/23/2025
#   Specification: ArcaBook_Client_Specification.pdf
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
