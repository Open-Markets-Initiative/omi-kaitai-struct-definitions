# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaEquities ArcaBook Xdp v1.9.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: ArcaBook
#   Encoding: Exchange Data Publisher
#   Version: 1.9.a
#   Date: 03/24/2014
#   Specification: XDP_Depth_of_Book_Client_Spec.pdf
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
  id: nyse_arcaequities_arcabook_xdp_v1_9_a
  title: Nyse ArcaEquities ArcaBook Xdp v1.9.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Equities ArcaBook Xdp v1.9.a'
doc-ref: https://www.nyse.com/market-data/real-time/openbook-ultra

seq:
  - id: packet_header
    type: packet_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.message_count

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
      - id: message_count
        type: u1
        doc: 'The number of messages in this packet'
      - id: sequence_number
        type: u4
        doc: 'The message sequence number of the first message in this packet'
      - id: send_time
        type: send_time
        doc: 'The time when this packet was published to the multicast channel. Nanoseconds since Unix epoch'
  send_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'The time when this packet was published to the multicast channel, in seconds since Jan 1, 1970 00:00:00 UTC. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The nanosecond offset from the Send Time. Nanoseconds since Second epoch'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::add_order_message': add_order_message
            'message_type::attributed_add_order_message': attributed_add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::execution_message': execution_message
            'message_type::add_order_refresh_message': add_order_refresh_message
            'message_type::attributed_add_order_refresh_message': attributed_add_order_refresh_message
            'message_type::imbalance_message': imbalance_message
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trading sessions the order is eligible for. For NYSE and NYSE MKT, only 2 is applicable'
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trading sessions the order is eligible for. For NYSE and NYSE MKT, only 2 is applicable'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field provides market participant''s firm ID'
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason: 5 - Change (lost position in book), 6 - Routed (keep position in book), 7 - Modify Fill keep position. Reason Code 7 not applicable to NYSE or NYSE MKT. This field is left as a future enhancement. The default value is currently set as 0, which has no underlying meaning'
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
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason: 5 - Change (lost position in book), 6 - Routed (keep position in book), 7 - Modify Fill keep position. Reason Code 7 not applicable to NYSE or NYSE MKT. This field is left as a future enhancement. The default value is currently set as 0, which has no underlying meaning'
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: reason_code
        type: u1
        doc: 'Modify Reason: 5 - Change (lost position in book), 6 - Routed (keep position in book), 7 - Modify Fill keep position. Reason Code 7 not applicable to NYSE or NYSE MKT. This field is left as a future enhancement. The default value is currently set as 0, which has no underlying meaning'
      - id: trade_id
        type: u4
        doc: 'The TradeID identifies a unique transaction in the matching engine and allows clients to correlate execution reports to the last sale'
  add_order_refresh_message:
    seq:
      - id: source_time
        type: u4
        doc: 'This field specifies the time when the msg was generated in the order book. The number represents the number of seconds in UTC time (EPOCH)'
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trading sessions the order is eligible for. For NYSE and NYSE MKT, only 2 is applicable'
  attributed_add_order_refresh_message:
    seq:
      - id: source_time
        type: u4
        doc: 'This field specifies the time when the msg was generated in the order book. The number represents the number of seconds in UTC time (EPOCH)'
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
        type: u4
        doc: 'This field contains the price point. Use the Price scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'This field contains the order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'This field indicates the side of the order Buy/Sell'
      - id: order_idgtc_indicator
        type: u1
        enum: order_idgtc_indicator
        doc: 'This field specifies if Trade Order ID is a GTC order'
      - id: trade_session
        type: u1
        enum: trade_session
        doc: 'Trading sessions the order is eligible for. For NYSE and NYSE MKT, only 2 is applicable'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'This field provides market participant''s firm ID'
  imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'This field specifies the time when the msg was generated in the order book. The number represents the number of seconds in UTC time (EPOCH)'
      - id: source_time_ns
        type: u4
        doc: 'This field represents the nanosecond offset from the time reference second in UTC time (EPOCH)'
      - id: symbol_index
        type: u4
        doc: 'This field identifies the numerical representation of the symbol'
      - id: symbol_seq_num
        type: u4
        doc: 'This field contains the symbol sequence number'
      - id: reference_price
        type: u4
        doc: 'The Reference Price is the Last Sale if the last sale is at or between the current best quote. Otherwise the Reference Price is the Bid Price if last sale is lower than Bid price, or the Offer price if last sale is higher than Offer price'
      - id: paired_qty
        type: u4
        doc: 'This field contains the paired off quantity at the reference price point'
      - id: total_imbalance_qty
        type: u4
        doc: 'This field contains the total imbalance quantity at the reference price point. For NYSE Arca, positive or negative Imbalance Quantities denote a Buy or Sell imbalance, respectively'
      - id: market_imbalance_qty
        type: u4
        doc: 'This field indicates the total market order imbalance at the reference price. For NYSE Arca, positive or negative Imbalance Quantities denote a Buy or Sell imbalance, respectively'
      - id: auction_time
        type: u2
        doc: 'Projected Auction Time (hhmm)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type. For the NYSE / NYSE MKT, the opening imbalance will have an "M" Auction Type'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'This field indicates the side of the imbalance Buy/sell. This field is a future enhancement for NYSE Arca and will have a ''0'' value until such time. This field is not yet implemented and is left as a future release'
      - id: continuous_book_clearing_price
        type: u4
        doc: 'The Continuous Book Clearing Price is defined as the price closest to last sale where imbalance is zero. If a Book Clearing Price is not reached, a zero will be published. This field is a future enhancement for NYSE Arca and will have a ''0'' value until such time. This field is not yet implemented and is left as a future release'
      - id: closing_only_clearing_price
        type: u4
        doc: 'This field contains the indicative price against closing only order only. This field is a future enhancement for NYSE Arca and will have a ''0'' value until such time. This field is not yet implemented and is left as a future release'
      - id: ssr_filing_price
        type: u4
        doc: 'This field contains the SSR Filing Price, the price at which Sell Short interest will be filed in the matching in the event a Sell Short Restriction is in effect for the security. It is based on the National Best Bid at 9:30am and remains static after it has been determined. This field is a future enhancement for NYSE Arca and will have a ''0'' value until such time. This field is not yet implemented and is left as a future release'
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
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000

enums:
  delivery_flag:
    1:
      id: 'heartbeat'
      doc: 'Xdp Heartbeat Message'
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
      doc: 'one packet in Refresh sequence'
    18:
      id: 'refresh_sequence_start'
      doc: 'Start of Refresh sequence'
    19:
      id: 'refresh_sequence_message'
      doc: 'Part of a Refresh sequence'
    20:
      id: 'refresh_sequence_end'
      doc: 'End of Refresh Sequence'
    21:
      id: 'message_unavailable'
      doc: 'Message Unavailable'
  message_type:
    100:
      id: 'add_order_message'
      doc: 'Order Book Add Order message. Size of the message: 31 bytes (NYSE, NYSE MKT and NYSE Arca).'
    107:
      id: 'attributed_add_order_message'
      doc: 'Order Book Attribution Add Order message. Size of the message: NYSE 31 bytes, NYSE MKT 31 bytes, NYSE Arca 36 bytes.'
    101:
      id: 'modify_order_message'
      doc: 'Sent when an order in the Order Book is modified: the price or the size of the order changes, or the order is routed to an away market with some shares remaining in the Order Book. The Order ID refers to the original order sent in the add order message. Size of the message: 31 bytes (NYSE, NYSE MKT and NYSE Arca).'
    102:
      id: 'delete_order_message'
      doc: 'Sent when an order is taken off of the order book: the order is cancelled, expires, or is routed to an away market. Size of the message: 23 bytes (NYSE, NYSE MKT and NYSE Arca).'
    103:
      id: 'execution_message'
      doc: 'Order Book Execution message. With reason codes set to zero, a partial fill is followed by a modify message and a full fill by a delete message for the executed OrderID; with reason codes in use, only the execution message is sent, with reason code 7 (reduce the order''s volume) or 3 (remove the order). Size of the message: 34 bytes (NYSE, NYSE MKT and NYSE Arca).'
    106:
      id: 'add_order_refresh_message'
      doc: 'Sent only during a refresh or after a symbol clear which will result in a book refresh. Size of the message: 35 bytes (NYSE, NYSE MKT and NYSE Arca).'
    108:
      id: 'attributed_add_order_refresh_message'
      doc: 'Sent by NYSE Arca only during a refresh or after a symbol clear which will result in a book refresh. Size of the message: NYSE 35 bytes, NYSE MKT 35 bytes, NYSE Arca 40 bytes.'
    105:
      id: 'imbalance_message'
      doc: 'Imbalance message. Size of the message: 52 bytes (NYSE, NYSE MKT and NYSE Arca).'
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
      id: 'open_4_am_arca_only'
      doc: 'Open 4 Am Arca Only'
    0x4d:
      id: 'market_930_am'
      doc: 'Market 930 Am'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x52:
      id: 'regulatory_imbalance'
      doc: 'Regulatory Imbalance'
  imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance'
      doc: 'No Imbalance'

