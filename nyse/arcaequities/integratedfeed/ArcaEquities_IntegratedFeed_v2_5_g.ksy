# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaEquities IntegratedFeed Pillar v2.5.g
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Integrated Feed
#   Encoding: Pillar
#   Version: 2.5.g
#   Date: 10/23/2025
#   Specification: NYSE_Pillar_Integrated_Feed_Client_Specification.pdf
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
  id: nyse_arcaequities_integratedfeed_pillar_v2_5_g
  title: Nyse ArcaEquities IntegratedFeed Pillar v2.5.g
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Equities Integrated Feed Pillar v2.5.g'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Pillar_Integrated_Feed_Client_Specification.pdf

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Pillar common client udp packet header'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.number_msgs
    doc: 'Pillar message'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: delivery_flag
        type: u1
        enum: delivery_flag
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
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
        doc: 'Pillar message header'
      - id: payload
        size: message_header.message_size - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::sequence_number_reset_message': sequence_number_reset_message
            'message_type::source_time_reference_message': source_time_reference_message
            'message_type::symbol_index_mapping_message': symbol_index_mapping_message
            'message_type::symbol_clear_message': symbol_clear_message
            'message_type::security_status_message': security_status_message
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::order_execution_message': order_execution_message
            'message_type::replace_order_message': replace_order_message
            'message_type::imbalance_message': imbalance_message
            'message_type::add_order_refresh_message': add_order_refresh_message
            'message_type::non_displayed_trade_message': non_displayed_trade_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::cross_correction_message': cross_correction_message
            'message_type::retail_price_improvement_message': retail_price_improvement_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'The size of this message in bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  sequence_number_reset_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  source_time_reference_message:
    seq:
      - id: id
        type: u4
        doc: 'ID of the originating Matching Engine partition to which this message applies'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
  symbol_index_mapping_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Null-terminated ASCII symbol in NYSE Symbology'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating matching engine server'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'For listed equity markets, the market where this symbol is listed'
      - id: price_scale_code
        type: u1
        doc: 'Specifies placement of the decimal point in price fields for this security'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Type of Security used by Pillar-powered markets'
      - id: lot_size
        type: u2
        doc: 'Round lot size in shares'
      - id: prev_close_price
        type: decimal_s4_8
        doc: 'The previous day''s closing price for this security. Implied decimal with scale 1e-8'
      - id: prev_close_volume
        type: u4
        doc: 'The previous day''s closing volume for the security'
      - id: price_resolution
        type: u1
        doc: 'Minimum price increment: 0 - All Penny, 1 - Penny/Nickel, 5 - Nickel/Dime'
      - id: round_lot
        type: u1
        enum: round_lot
        doc: 'Round Lots Accepted: Y - Yes, N - No'
      - id: mpv
        type: u2
        doc: 'The minimum increment for a trade price, in 100ths of a cent. Typically 1, or $0.0001, but for some Tick Pilot stocks, can be 500, or $0.05'
      - id: unit_of_trade
        type: u2
        doc: 'This field specifies the security Unit of Trade in shares. Valid values are 1, 10, 50 and 100'
      - id: late_close_eligible
        type: u1
        enum: late_close_eligible
        doc: 'The Outright series for the underlying symbol is eligible for a later Core session close'
      - id: eth_eligible
        type: u1
        enum: eth_eligible
        doc: 'The Outright series for the underlying symbol is eligible for Extended Trading Sessions'
  symbol_clear_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: next_source_seq_num
        type: u4
        doc: 'The sequence number in the next message for this symbol'
  security_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'The halt or other condition associated with the security status change'
      - id: reserved_4
        type: u4
        doc: 'Future use. Any field content should be ignored'
      - id: price_1
        type: decimal_s4_8
        doc: 'Default value is 0. If securityStatus = A and this security is listed on this exchange, then this field is the SSR Triggering Trade Price. If securityStatus = G or I, then this field is the Indication Low Price. Implied decimal with scale 1e-8'
      - id: price_2
        type: decimal_s4_8
        doc: 'Default value is 0. If securityStatus = G or I, then this field is the Indication High Price. Implied decimal with scale 1e-8'
      - id: ssr_triggering_exchange_id
        type: u1
        enum: ssr_triggering_exchange_id
        doc: 'This field is only populated when securityStatus = A and this security is listed on this exchange. Otherwise it is defaulted to 0x20'
      - id: ssr_triggering_volume
        type: u4
        doc: 'Default value is 0. This field is only populated when securityStatus = A and this security is listed on this exchange'
      - id: time
        type: u4
        doc: 'Default value is 0. Format: HHMMSSmmm (mmm = milliseconds). If securityStatus = A and this security is listed on this exchange, then this field is the SSR Trigger Time'
      - id: ssr_state
        type: u1
        enum: ssr_state
        doc: 'The current SSR state, which this msg updates if the Security Status field contains an SSR Code'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The current Market State, which this msg updates if the Security Status field contains a Market State Code'
      - id: session_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Unused. Defaulted to 0x00'
  add_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order (Buy/Sell)'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant''s firm ID'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  modify_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: position_change
        type: u1
        doc: 'Currently defaulted to 0'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order (Buy/Sell)'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  delete_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  order_execution_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: trade_id
        type: u4
        doc: 'Unique ID assigned by the matching engine to this execution'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: printable_flag
        type: u1
        enum: printable_flag
        doc: '0 = Not Printed to the SIP. 1 = Printed to the SIP'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'Settlement related conditions'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'The reason for Trade Through Exemptions'
      - id: trade_cond_3
        type: u1
        enum: trade_cond_3
        doc: 'Extended hours/sequencing related conditions'
      - id: trade_cond_4
        type: u1
        enum: trade_cond_4
        doc: 'SRO Required Detail'
  replace_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: new_order_id
        type: u8
        doc: 'The new Order ID of the replacement order'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order (Buy/Sell)'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: reference_price
        type: decimal_s4_8
        doc: 'The price at which imbalances are calculated. Implied decimal with scale 1e-8'
      - id: paired_qty
        type: u4
        doc: 'Number of shares paired at the Reference Price'
      - id: total_imbalance_qty
        type: u4
        doc: 'The total imbalance quantity at the Reference Price'
      - id: market_imbalance_qty
        type: u4
        doc: 'The total market order imbalance quantity at the Reference Price'
      - id: auction_time
        type: u2
        doc: 'Projected Auction Time (hhmm)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type indicator'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'The side of the TotalImbalanceQty'
      - id: continuous_book_clearing_price
        type: decimal_s4_8
        doc: 'The price closest to the reference price where the imbalance is 0. Implied decimal with scale 1e-8'
      - id: auction_interest_clearing_price
        type: decimal_s4_8
        doc: 'The price at which auction only interest would trade. Implied decimal with scale 1e-8'
      - id: ssr_filing_price
        type: decimal_s4_8
        doc: 'For NYSE non-Significant imbalances, if a Sell Short Restriction is in effect, the price at which Sell Short interest will be filed. Implied decimal with scale 1e-8'
      - id: indicative_match_price
        type: decimal_s4_8
        doc: 'The best price at which the maximum volume of shares is executable in the applicable auction, subject to Auction Collars. Implied decimal with scale 1e-8'
      - id: upper_collar
        type: s4
        doc: 'Upper boundary for the Indicative Match Price'
      - id: lower_collar
        type: s4
        doc: 'Lower boundary for the Indicative Match Price'
      - id: auction_status
        type: u1
        enum: auction_status
        doc: 'Indicates whether the auction will run'
      - id: freeze_status
        type: u1
        enum: freeze_status
        doc: 'Indicates an Imbalance Freeze for the auction'
      - id: num_extensions
        type: u1
        doc: 'The number of times a halt period has been extended'
      - id: unpaired_qty
        type: u4
        doc: 'The number of unpaired shares priced at or better than the Reference Price'
      - id: unpaired_side
        type: u1
        enum: unpaired_side
        doc: 'The side of the Unpaired Qty'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  add_order_refresh_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in secs since 1/1/1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order (Buy/Sell)'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant''s firm ID'
      - id: reserved_1
        type: u1
        doc: 'Defaulted to 0. Future use only'
  non_displayed_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: trade_id
        type: u4
        doc: 'Unique ID assigned by the matching engine to this execution'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: printable_flag
        type: u1
        enum: printable_flag
        doc: '0 = Not Printed to the SIP. 1 = Printed to the SIP'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'Settlement related conditions'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'The reason for Trade Through Exemptions'
      - id: trade_cond_3
        type: u1
        enum: trade_cond_3
        doc: 'Extended hours/sequencing related conditions'
      - id: trade_cond_4
        type: u1
        enum: trade_cond_4
        doc: 'SRO Required Detail'
  cross_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: cross_id
        type: u4
        doc: 'Unique identifier for this Cross Trade'
      - id: price
        type: decimal_s4_8
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Reason for the crossing auction'
  trade_cancel_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: trade_id
        type: u4
        doc: 'Unique ID assigned by the matching engine to this execution'
  cross_correction_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: cross_id
        type: u4
        doc: 'Unique identifier for this Cross Trade'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
  retail_price_improvement_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Time Reference second'
      - id: symbol_index
        type: u4
        doc: 'The ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: rpi_indicator
        type: u1
        enum: rpi_indicator
        doc: 'The side(s) where Retail Price Improvement orders (RPI orders) exist'
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
  decimal_s4_8:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  delivery_flag:
    1:
      id: 'heartbeat'
      doc: 'Pillar Heartbeat Message'
    10:
      id: 'pillar_failover'
      doc: 'Pillar Failover'
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
      doc: 'One packet in Refresh sequence'
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
    1:
      id: 'sequence_number_reset_message'
      doc: 'This message is sent to reset the Message Sequence Number at start of day, or in response to failures.'
    2:
      id: 'source_time_reference_message'
      doc: 'For high-volume feeds, this message is sent at the start of every second during periods of active data publication. The client can concatenate the SourceTime field with the SourceTimeNS field in subsequent market data messages to get full 8-byte Matching Engine event timestamps.'
    3:
      id: 'symbol_index_mapping_message'
      doc: 'This message is published over the real-time data channels at system startup or in the context of a refresh sequence after a Matching Engine or Pillar Publisher failover. It provides referential data for a single specified symbol.'
    32:
      id: 'symbol_clear_message'
      doc: 'In case of a failure and recovery of a Matching Engine or an Pillar Publisher, the publisher may send a full state refresh for every symbol affected. This unrequested refresh is preceded by a Symbol Clear message. The client should react to receipt of a Symbol Clear message by clearing all state information for the specified symbol in anticipation of receiving a full state refresh.'
    34:
      id: 'security_status_message'
      doc: 'This message informs clients of changes in the status of a specific security, such as Trading Halts, Short Sale Restriction state changes, etc.'
    100:
      id: 'add_order_message'
      doc: 'An Add Order message is published when a new visible order has been received and added to the book.'
    101:
      id: 'modify_order_message'
      doc: 'A Modify Order message is sent when the price or volume of an order is changed.'
    102:
      id: 'delete_order_message'
      doc: 'A Delete Order message is published when an order is taken off of the book.'
    103:
      id: 'order_execution_message'
      doc: 'An Order Execution message is sent when an order is partially or fully executed.'
    104:
      id: 'replace_order_message'
      doc: 'A Replace Order message is published when a cancel/replace order is received and executed.'
    105:
      id: 'imbalance_message'
      doc: 'Imbalance messages are published once a second during auctions to update price and volume information.'
    106:
      id: 'add_order_refresh_message'
      doc: 'The Add Order Refresh message can be sent in either of two contexts: refresh response or symbol refresh.'
    110:
      id: 'non_displayed_trade_message'
      doc: 'A Non Displayed Trade message is sent as a result of a match between two non-displayed orders.'
    111:
      id: 'cross_trade_message'
      doc: 'A Cross Trade message is published on completion of a crossing auction.'
    112:
      id: 'trade_cancel_message'
      doc: 'In the event that an earlier trade has been reported in error, a Trade Cancel message is sent.'
    113:
      id: 'cross_correction_message'
      doc: 'In the event that an earlier Cross Trade has been reported in error, a Cross Correction message is sent.'
    114:
      id: 'retail_price_improvement_message'
      doc: 'Published when RPI interest is added or removed between the best bid and best offer price.'
  market_id:
    1:
      id: 'nyse_equities'
      doc: 'Nyse Equities'
    3:
      id: 'nyse_arca_equities'
      doc: 'Nyse Arca Equities'
    9:
      id: 'nyse_american_equities'
      doc: 'Nyse American Equities'
    10:
      id: 'nyse_national_equities'
      doc: 'Nyse National Equities'
    11:
      id: 'nyse_texas_equities'
      doc: 'Nyse Texas Equities'
  exchange_code:
    0x46:
      id: 'txse'
      doc: 'Txse'
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x5a:
      id: 'cboe'
      doc: 'Cboe'
  security_type:
    0x41:
      id: 'adr'
      doc: 'Adr'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x44:
      id: 'debentures'
      doc: 'Debentures'
    0x45:
      id: 'etf'
      doc: 'Etf'
    0x46:
      id: 'foreign'
      doc: 'Foreign'
    0x48:
      id: 'us_depositary_shares'
      doc: 'Us Depositary Shares'
    0x49:
      id: 'units'
      doc: 'Units'
    0x4c:
      id: 'index_linked_notes'
      doc: 'Index Linked Notes'
    0x4d:
      id: 'miscliquid_trust'
      doc: 'Miscliquid Trust'
    0x4f:
      id: 'ordinary_shares'
      doc: 'Ordinary Shares'
    0x50:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x52:
      id: 'rights'
      doc: 'Rights'
    0x53:
      id: 'shares_of_beneficiary_interest'
      doc: 'Shares Of Beneficiary Interest'
    0x54:
      id: 'test'
      doc: 'Test'
    0x55:
      id: 'closed_end_fund'
      doc: 'Closed End Fund'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
  round_lot:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  late_close_eligible:
    0:
      id: 'not_eligible'
      doc: 'Not Eligible'
    1:
      id: 'eligible'
      doc: 'Eligible'
  eth_eligible:
    0:
      id: 'not_eligible'
      doc: 'Not Eligible'
    1:
      id: 'eligible'
      doc: 'Eligible'
  security_status:
    0x34:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x35:
      id: 'resume'
      doc: 'Resume'
    0x36:
      id: 'suspend_operational_halt'
      doc: 'Suspend Operational Halt'
    0x41:
      id: 'short_sale_restriction_activated_day_1'
      doc: 'Short Sale Restriction Activated Day 1'
    0x43:
      id: 'short_sale_restriction_continued_day_2'
      doc: 'Short Sale Restriction Continued Day 2'
    0x44:
      id: 'short_sale_restriction_deactivated'
      doc: 'Short Sale Restriction Deactivated'
    0x50:
      id: 'preopening'
      doc: 'Preopening'
    0x42:
      id: 'begin_accepting_orders'
      doc: 'Begin Accepting Orders'
    0x45:
      id: 'early_session'
      doc: 'Early Session'
    0x4f:
      id: 'core_session'
      doc: 'Core Session'
    0x4c:
      id: 'late_session_non_nyse_only'
      doc: 'Late Session Non Nyse Only'
    0x58:
      id: 'closed'
      doc: 'Closed'
    0x49:
      id: 'halt_resume_price_indication'
      doc: 'Halt Resume Price Indication'
    0x47:
      id: 'pre_opening_price_indication'
      doc: 'Pre Opening Price Indication'
  halt_condition:
    0x7e:
      id: 'security_not_delayedhalted'
      doc: 'Security Not Delayedhalted'
    0x44:
      id: 'news_released_news_dissemination'
      doc: 'News Released News Dissemination'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x50:
      id: 'news_pending'
      doc: 'News Pending'
    0x4d:
      id: 'luld_pause'
      doc: 'Luld Pause'
    0x58:
      id: 'equipment_changeover'
      doc: 'Equipment Changeover'
    0x41:
      id: 'sip_outage_material_sip_latency_or_extraordinary_market_activity'
      doc: 'Sip Outage Material Sip Latency Or Extraordinary Market Activity'
    0x43:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern'
    0x45:
      id: 'merger_effective'
      doc: 'Merger Effective'
    0x46:
      id: 'etf_iiv_etf_component_prices_not_available'
      doc: 'Etf Iiv Etf Component Prices Not Available'
    0x4e:
      id: 'corporate_action'
      doc: 'Corporate Action'
    0x4f:
      id: 'new_security_offering'
      doc: 'New Security Offering'
    0x56:
      id: 'primary_listing_exchange_discretionary_halt'
      doc: 'Primary Listing Exchange Discretionary Halt'
    0x36:
      id: 'suspend_operational_halt'
      doc: 'Suspend Operational Halt'
    0x31:
      id: 'market_wide_circuit_breaker_halt_level_1'
      doc: 'Market Wide Circuit Breaker Halt Level 1'
    0x32:
      id: 'market_wide_circuit_breaker_halt_level_2'
      doc: 'Market Wide Circuit Breaker Halt Level 2'
    0x33:
      id: 'market_wide_circuit_breaker_halt_level_3'
      doc: 'Market Wide Circuit Breaker Halt Level 3'
  ssr_triggering_exchange_id:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_oms_tx'
      doc: 'Nasdaq Oms Tx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'finra'
      doc: 'Finra'
    0x47:
      id: 'n_24_x'
      doc: 'N 24 X'
    0x48:
      id: 'miami_peral'
      doc: 'Miami Peral'
    0x49:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x4a:
      id: 'cboe_edga'
      doc: 'Cboe Edga'
    0x4b:
      id: 'cboe_edgx'
      doc: 'Cboe Edgx'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
    0x4d:
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x54:
      id: 'nasdaq_omx'
      doc: 'Nasdaq Omx'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x57:
      id: 'cbsx'
      doc: 'Cbsx'
    0x58:
      id: 'nasdaq_omx_psx'
      doc: 'Nasdaq Omx Psx'
    0x59:
      id: 'cboe_byx'
      doc: 'Cboe Byx'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx'
  ssr_state:
    0x7e:
      id: 'no_short_sale_restriction_in_effect'
      doc: 'No Short Sale Restriction In Effect'
    0x45:
      id: 'short_sale_restriction_in_effect'
      doc: 'Short Sale Restriction In Effect'
  market_state:
    0x50:
      id: 'preopening'
      doc: 'Preopening'
    0x45:
      id: 'early_session'
      doc: 'Early Session'
    0x4f:
      id: 'core_session'
      doc: 'Core Session'
    0x4c:
      id: 'late_session_non_nyse_only'
      doc: 'Late Session Non Nyse Only'
    0x58:
      id: 'closed'
      doc: 'Closed'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable_flag:
    0:
      id: 'not_printed_to_the_sip'
      doc: 'Not Printed To The Sip'
    1:
      id: 'printed_to_the_sip'
      doc: 'Printed To The Sip'
  trade_cond_1:
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x43:
      id: 'cash_texas_only'
      doc: 'Cash Texas Only'
  trade_cond_2:
    0x20:
      id: 'na'
      doc: 'Na'
    0x46:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x4f:
      id: 'market_center_opening_trade_arca_american_and_nyse_only'
      doc: 'Market Center Opening Trade Arca American And Nyse Only'
    0x35:
      id: 'reopening_trade_arca_american_and_nyse_only'
      doc: 'Reopening Trade Arca American And Nyse Only'
    0x36:
      id: 'market_center_closing_trade_arca_american_and_nyse_only'
      doc: 'Market Center Closing Trade Arca American And Nyse Only'
    0x37:
      id: 'qualified_contingent_trade_texas_only'
      doc: 'Qualified Contingent Trade Texas Only'
  trade_cond_3:
    0x20:
      id: 'na'
      doc: 'Na'
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_sold_out_of_sequence'
      doc: 'Extended Hours Sold Out Of Sequence'
    0x5a:
      id: 'sold'
      doc: 'Sold'
  trade_cond_4:
    0x20:
      id: 'na'
      doc: 'Na'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x56:
      id: 'contingent_trade_texas_only'
      doc: 'Contingent Trade Texas Only'
  auction_type:
    0x4f:
      id: 'early_opening_auction'
      doc: 'Early Opening Auction'
    0x4d:
      id: 'core_opening_auction'
      doc: 'Core Opening Auction'
    0x48:
      id: 'reopening_auction_halt_resume'
      doc: 'Reopening Auction Halt Resume'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x50:
      id: 'extreme_closing_imbalance'
      doc: 'Extreme Closing Imbalance'
    0x52:
      id: 'significant_closing_imbalance'
      doc: 'Significant Closing Imbalance'
  imbalance_side:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
    0x20:
      id: 'no_imbalance'
      doc: 'No Imbalance'
  auction_status:
    0:
      id: 'will_run_as_always_for_open_and_close'
      doc: 'Will Run As Always For Open And Close'
    1:
      id: 'will_run_interest_exists_inside_or_at_the_collars_or_is_fully_paired_off'
      doc: 'Will Run Interest Exists Inside Or At The Collars Or Is Fully Paired Off'
    2:
      id: 'will_not_run_because_there_is_an_imbalance_through_the_collars'
      doc: 'Will Not Run Because There Is An Imbalance Through The Collars'
    3:
      id: 'will_not_run_will_transition_to_the_closing_auction_instead'
      doc: 'Will Not Run Will Transition To The Closing Auction Instead'
  freeze_status:
    0:
      id: 'imbalance_freeze_not_in_effect'
      doc: 'Imbalance Freeze Not In Effect'
    1:
      id: 'imbalance_freeze_is_in_effect'
      doc: 'Imbalance Freeze Is In Effect'
  unpaired_side:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  cross_type:
    0x45:
      id: 'market_center_early_opening_auction'
      doc: 'Market Center Early Opening Auction'
    0x4f:
      id: 'market_center_opening_auction'
      doc: 'Market Center Opening Auction'
    0x35:
      id: 'market_center_reopening_auction'
      doc: 'Market Center Reopening Auction'
    0x36:
      id: 'market_center_closing_auction'
      doc: 'Market Center Closing Auction'
  rpi_indicator:
    0x20:
      id: 'no_retail_interest_default'
      doc: 'No Retail Interest Default'
    0x41:
      id: 'retail_interest_on_the_bid_side'
      doc: 'Retail Interest On The Bid Side'
    0x42:
      id: 'retail_interest_on_the_offer_side'
      doc: 'Retail Interest On The Offer Side'
    0x43:
      id: 'retail_interest_on_the_bid_and_offer_sides'
      doc: 'Retail Interest On The Bid And Offer Sides'

