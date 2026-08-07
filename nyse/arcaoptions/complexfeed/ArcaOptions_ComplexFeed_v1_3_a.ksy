# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaOptions ComplexFeed Xdp v1.3.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Complex Feed
#   Encoding: Exchange Data Publisher
#   Version: 1.3.a
#   Date: 02/28/2018
#   Specification: XDP_Options_Client_Specification_v1.3a.pdf
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
  id: nyse_arcaoptions_complexfeed_xdp_v1_3_a
  title: Nyse ArcaOptions ComplexFeed Xdp v1.3.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Options Complex Feed Xdp v1.3.a'
doc-ref: https://www.nyse.com/market-data/real-time/options-complex-feed

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
      - id: timestamp
        type: u4
        doc: 'The time when this packet was published to the multicast channel, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: nanoseconds
        type: u4
        doc: 'The nanosecond offset from the Send Time'
  message_struct:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_size - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::complex_quote_message': complex_quote_message
            'message_type::complex_trade_message': complex_trade_message
            'message_type::complex_crossing_rfq_message': complex_crossing_rfq_message
            'message_type::complex_cube_rfq_message': complex_cube_rfq_message
            'message_type::complex_status_message': complex_status_message
            'message_type::refresh_complex_quote_message': refresh_complex_quote_message
            'message_type::refresh_complex_trade_message': refresh_complex_trade_message
            'message_type::complex_symbol_definition_message': complex_symbol_definition_message
            'message_type::stream_id_message': stream_id_message
            'message_type::sequence_number_reset_message': sequence_number_reset_message
  message_header:
    seq:
      - id: message_size
        type: u2
        doc: 'The size of this message in bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
  complex_quote_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: ask_price
        type: s4
        doc: 'Best Ask price*. Should be used with the Price Scale Code from the Underlying Index Mapping message'
      - id: bid_price
        type: s4
        doc: 'Best Bid price*. Should be used with the Price Scale Code from the Underlying Index Mapping message'
      - id: ask_volume
        type: u2
        doc: 'Total quantity available at the above Ask price'
      - id: bid_volume
        type: u2
        doc: 'Total quantity available at the above Bid price'
      - id: ask_customer_volume
        type: u2
        doc: 'Total quantity of ‘Customer’ orders available at the above Ask price'
      - id: bid_customer_volume
        type: u2
        doc: 'Total quantity of ‘Customer’ orders available at the above Bid price'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition value'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  complex_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: trade_id
        type: u4
        doc: 'n/a for complex symbols'
      - id: price
        type: s4
        doc: 'The net amount of money made by the Seller* (the price of the Sell legs minus the price of the Buy legs)'
      - id: volume_4
        type: u4
        doc: 'Volume of the trade in actual number of contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'TradeCond1 value'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: '(blank) n/a for complex symbols'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  complex_crossing_rfq_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the RFQ'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: volume_2
        type: u2
        doc: 'Total quantity'
      - id: price
        type: s4
        doc: 'The net amount of money made by the Seller* (the price of the Sell legs minus the price of the Buy legs)'
  complex_cube_rfq_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the RFQ'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: volume_2
        type: u2
        doc: 'Total quantity'
      - id: price
        type: s4
        doc: 'The net amount of money made by the Seller* (the price of the Sell legs minus the price of the Buy legs)'
  complex_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'SecurityStatus value'
      - id: halt_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not applicable'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_complex_quote_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: ask_price
        type: s4
        doc: 'Best Ask price*. Should be used with the Price Scale Code from the Underlying Index Mapping message'
      - id: bid_price
        type: s4
        doc: 'Best Bid price*. Should be used with the Price Scale Code from the Underlying Index Mapping message'
      - id: ask_volume
        type: u2
        doc: 'Total quantity available at the above Ask price'
      - id: bid_volume
        type: u2
        doc: 'Total quantity available at the above Bid price'
      - id: ask_customer_volume
        type: u2
        doc: 'Total quantity of ‘Customer’ orders available at the above Ask price'
      - id: bid_customer_volume
        type: u2
        doc: 'Total quantity of ‘Customer’ orders available at the above Bid price'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition value'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_complex_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the complex symbol'
      - id: trade_id
        type: u4
        doc: 'n/a for complex symbols'
      - id: price
        type: s4
        doc: 'The net amount of money made by the Seller* (the price of the Sell legs minus the price of the Buy legs)'
      - id: volume_4
        type: u4
        doc: 'Volume of the trade in actual number of contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'TradeCond1 value'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: '(blank) n/a for complex symbols'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  complex_symbol_definition_message:
    seq:
      - id: complex_index
        type: u4
        doc: 'The unique ID of the symbol in the Complex Index msg'
      - id: complex_symbol
        type: str
        size: 21
        encoding: ASCII
        doc: 'Complex Symbol. This is an alpha numeric symbol which can be used for a unique strategy until one of the legs expire'
      - id: channel_id
        type: u1
        doc: 'Multicast channel ID of the symbols being provided'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'Identifies originating market'
      - id: system_id
        type: u1
        doc: 'Identifies Trading unit (TU)'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: stream_id
        type: u2
        doc: 'Identifies Stream on which this symbol will be updated'
      - id: num_leg_definition
        type: u2
        doc: 'Number of legs in complex symbol: 1 – 5'
      - id: reserved_2
        size: 2
        doc: 'Filler'
      - id: leg_definition
        type: leg_definition
        repeat: expr
        repeat-expr: num_leg_definition
  leg_definition:
    seq:
      - id: symbol_index
        type: u4
        doc: 'Series index if Security type is Option. Underlying index if Security type is Equity'
      - id: leg_ratio_qty
        type: u2
        doc: 'Leg ratio'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the RFQ'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'Leg Security Type'
  stream_id_message:
    seq:
      - id: stream_id
        type: u2
        doc: 'Identifies Stream on which this symbol will be updated'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  sequence_number_reset_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'Multicast channel ID of the symbols being provided'

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
    423:
      id: 'complex_quote_message'
      doc: 'The Complex Quote message is a two-sided message providing best bid and offer limits of orders on complex symbols with aggregated volumes at each limit.'
    425:
      id: 'complex_trade_message'
      doc: 'The Complex Trade message is used to publish all complex Last Sales.'
    429:
      id: 'complex_crossing_rfq_message'
      doc: 'The Complex Crossing RFQ (Request for Quote) message is sent out in the event of a COA auction on a complex order.'
    472: 'complex_cube_rfq_message'
    433:
      id: 'complex_status_message'
      doc: 'The Complex Status message is used to inform the subscribers of changes in symbol status of a complex symbol.'
    511:
      id: 'refresh_complex_quote_message'
      doc: 'The Refresh Complex Quote message is sent in the event no quote messages are published for the symbol for 2 consecutive minutes.'
    513:
      id: 'refresh_complex_trade_message'
      doc: 'The Refresh Complex Trade message is sent in the event no Complex Trade messages are published for the symbol for 2 consecutive minutes.'
    439:
      id: 'complex_symbol_definition_message'
      doc: 'The Complex Symbol Definition message provides a description of the legs in a Complex symbol, and specifies its Complex symbol ID, which is unique for its stream. If the same symbol ID appears in a different stream, it represents a different Complex symbol.'
    455:
      id: 'stream_id_message'
      doc: 'In all multicast channels, a Stream ID Message is sent immediately after each packet header to uniquely identify the source or Stream ID of the data in the packet.'
    1:
      id: 'sequence_number_reset_message'
      doc: 'This message is sent to reset the Message Sequence Number at start of day, or in response to failures.'
  quote_condition:
    0x31:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x32:
      id: 'rotation'
      doc: 'Rotation'
    0x33:
      id: 'trading_halted'
      doc: 'Trading Halted'
    0x34:
      id: 'preopen'
      doc: 'Preopen'
    0x35:
      id: 'rotation_legal_width_quote_pending'
      doc: 'Rotation Legal Width Quote Pending'
  trade_cond_1:
    0x20:
      id: 'regular_trade'
      doc: 'Regular Trade'
    0x49:
      id: 'late_report'
      doc: 'Late Report'
    0x52:
      id: 'floor_trade'
      doc: 'Floor Trade'
    0x53:
      id: 'so_sweep_trade'
      doc: 'So Sweep Trade'
  trade_cond_2:
    0x50:
      id: 'complex_trade_with_equity'
      doc: 'Complex Trade With Equity Trade'
    0x4c:
      id: 'complex_trade'
      doc: 'Complex Trade'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  security_status:
    0x4c:
      id: 'light_up_a_dark_series'
      doc: 'Light Up A Dark Series'
    0x4e:
      id: 'open_a_dark_series'
      doc: 'Open A Dark Series'
    0x4f:
      id: 'open'
      doc: 'Open Indication'
    0x58:
      id: 'close'
      doc: 'Close Indication'
    0x53:
      id: 'halt'
      doc: 'Halt'
    0x55:
      id: 'unhalt'
      doc: 'Unhalt'
    0x54:
      id: 'unhalt_a_dark_series'
      doc: 'Unhalt A Dark Series'
    0x51:
      id: 'end_of_rfq_auction'
      doc: 'End Of Rfq Auction'
  market_id:
    1:
      id: 'nyse_cash'
      doc: 'Nyse Cash'
    2:
      id: 'europe_cash'
      doc: 'Europe Cash'
    3:
      id: 'nyse_arca_cash'
      doc: 'Nyse Arca Cash'
    4:
      id: 'nyse_arca_options'
      doc: 'Nyse Arca Options'
    5:
      id: 'nyse_arca_bonds'
      doc: 'Nyse Arca Bonds'
    6:
      id: 'arca_edge'
      doc: 'Arca Edge'
    7:
      id: 'liffe'
      doc: 'Liffe'
    8:
      id: 'nyse_american_options'
      doc: 'Nyse American Options'
    9:
      id: 'nyse_mkt_cash'
      doc: 'Nyse Mkt Cash'
  leg_security_type:
    0x4f:
      id: 'options_series_leg'
      doc: 'Options Series Leg'
    0x45:
      id: 'equity_stock_leg'
      doc: 'Equity Stock Leg'

