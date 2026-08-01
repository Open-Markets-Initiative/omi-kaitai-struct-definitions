# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse AmexOptions TopFeed Xdp v1.3.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Top Feed
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------

meta:
  id: amexoptions_topfeed_v1_3_a
  title: Nyse AmexOptions TopFeed Xdp v1.3.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Amex Options Top Feed Xdp v1.3.a'
doc-ref: https://www.nyse.com/market-data/real-time/options-top-feed

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
            'message_type::outright_quote_message': outright_quote_message
            'message_type::outright_trade_message': outright_trade_message
            'message_type::outright_trade_cancel_message': outright_trade_cancel_message
            'message_type::outright_trade_correction_message': outright_trade_correction_message
            'message_type::outright_imbalance_message': outright_imbalance_message
            'message_type::outright_crossing_rfq_message': outright_crossing_rfq_message
            'message_type::outright_bold_rfq_message': outright_bold_rfq_message
            'message_type::outright_summary_message': outright_summary_message
            'message_type::underlying_status_message': underlying_status_message
            'message_type::outright_series_status_message': outright_series_status_message
            'message_type::refresh_outright_quote_message': refresh_outright_quote_message
            'message_type::refresh_outright_trade_message': refresh_outright_trade_message
            'message_type::refresh_outright_imbalance_message': refresh_outright_imbalance_message
            'message_type::underlying_index_mapping_message': underlying_index_mapping_message
            'message_type::series_index_mapping_message': series_index_mapping_message
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
  outright_quote_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: ask_price
        type: s4
        doc: 'Best Ask price. To be used with the Price Scale Code from the Outright Index Mapping message'
      - id: bid_price
        type: s4
        doc: 'Best Bid price. To be used with the Price Scale Code from the Outright Index Mapping message'
      - id: ask_volume
        type: u2
        doc: 'Total quantity available at the above Ask price'
      - id: bid_volume
        type: u2
        doc: 'Total quantity available at the above Bid price'
      - id: ask_customer_volume
        type: u2
        doc: '*Total quantity of customer orders at the Ask price'
      - id: bid_customer_volume
        type: u2
        doc: '*Total quantity of customer orders at the Bid price'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition values: 1-5'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  outright_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: trade_id
        type: u4
        doc: 'Unique Trade execution ID'
      - id: price
        type: s4
        doc: 'Price of the trade. Use the Price Scale Code from the symbol index mapping message.symbol index mapping message'
      - id: volume_4
        type: u4
        doc: 'Volume of the trade in number of contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'TradeCond1 value'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'Complex indicator'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  outright_trade_cancel_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: original_trade_id
        type: u4
        doc: 'Original TradeID of the trade'
  outright_trade_correction_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: original_trade_id
        type: u4
        doc: 'Original TradeID of the trade'
      - id: trade_id
        type: u4
        doc: 'Unique Trade execution ID'
      - id: price
        type: s4
        doc: 'Price of the trade. Use the Price Scale Code from the symbol index mapping message.symbol index mapping message'
      - id: volume_4
        type: u4
        doc: 'Volume of the trade in number of contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'TradeCond1 value'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'Complex indicator'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  outright_imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: reference_price
        type: s4
        doc: 'Indicative opening price'
      - id: paired_qty
        type: u2
        doc: 'Paired off quantity at the indicative opening price'
      - id: total_imbalance_qty
        type: u2
        doc: 'Total imbalance quantity at the indicative opening price'
      - id: market_imbalance_qty
        type: u2
        doc: 'Total market order imbalance at the indicative opening price'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType value'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Side of the imbalance Buy/sell'
      - id: market_imbalance_side
        type: u1
        enum: market_imbalance_side
        doc: 'Side of the market imbalance Buy/sell'
      - id: reserved_3
        size: 3
        doc: 'Filler'
  outright_crossing_rfq_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
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
        doc: 'Price of the trade. Use the Price Scale Code from the symbol index mapping message.symbol index mapping message'
  outright_bold_rfq_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the RFQ'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Customer or Firm capacity specified with the order'
      - id: contracts
        type: u2
        doc: 'The quantity of the order'
      - id: price
        type: s4
        doc: 'Price of the trade. Use the Price Scale Code from the symbol index mapping message.symbol index mapping message'
      - id: participant
        type: str
        size: 4
        encoding: ASCII
        doc: 'OCC code for the Clearing firm specified with the order'
  outright_summary_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: high_price
        type: s4
        doc: 'Exchange high price of the symbol for the day. Use the Price Scale Code from the symbol index mapping message'
      - id: low_price
        type: s4
        doc: 'Exchange Low price of the symbol for the day. Use the Price Scale Code from the symbol index mapping message'
      - id: open
        type: s4
        doc: 'Exchange Opening price of the symbol for the day. Use the Price Scale Code from the symbol index mapping message'
      - id: close
        type: s4
        doc: 'Exchange Closing price of the symbol for the day. Use the Price Scale Code from the symbol index mapping message'
      - id: total_volume
        type: u4
        doc: 'Exchange cumulative volume for the symbol throughout the day'
  underlying_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: underlying_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: underlying_seq_num
        type: u4
        doc: 'Sequence number of messages for the underlying symbol'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security status value'
      - id: halt_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not applicable'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  outright_series_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'Security status value'
      - id: halt_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not applicable'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_outright_quote_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: ask_price
        type: s4
        doc: 'Best Ask price. To be used with the Price Scale Code from the Outright Index Mapping message'
      - id: bid_price
        type: s4
        doc: 'Best Bid price. To be used with the Price Scale Code from the Outright Index Mapping message'
      - id: ask_volume
        type: u2
        doc: 'Total quantity available at the above Ask price'
      - id: bid_volume
        type: u2
        doc: 'Total quantity available at the above Bid price'
      - id: ask_customer_volume
        type: u2
        doc: '*Total quantity of customer orders at the Ask price'
      - id: bid_customer_volume
        type: u2
        doc: '*Total quantity of customer orders at the Bid price'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition values: 1-5'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_outright_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: trade_id
        type: u4
        doc: 'Unique Trade execution ID'
      - id: price
        type: s4
        doc: 'Price of the trade. Use the Price Scale Code from the symbol index mapping message.symbol index mapping message'
      - id: volume_4
        type: u4
        doc: 'Volume of the trade in number of contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'TradeCond1 value'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'Complex indicator'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_outright_imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: symbol_seq_num
        type: u4
        doc: 'Sequence number of messages for the outright options symbol'
      - id: reference_price
        type: s4
        doc: 'Indicative opening price'
      - id: paired_qty
        type: u2
        doc: 'Paired off quantity at the indicative opening price'
      - id: total_imbalance_qty
        type: u2
        doc: 'Total imbalance quantity at the indicative opening price'
      - id: market_imbalance_qty
        type: u2
        doc: 'Total market order imbalance at the indicative opening price'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'AuctionType value'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Side of the imbalance Buy/sell'
      - id: market_imbalance_side
        type: u1
        enum: market_imbalance_side
        doc: 'Side of the market imbalance Buy/sell'
      - id: reserved_3
        size: 3
        doc: 'Filler'
  underlying_index_mapping_message:
    seq:
      - id: underlying_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Full symbol in NYSE Symbology'
      - id: channel_id
        type: u1
        doc: 'Multicast channel ID of the symbols being provided'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'Identifies originating market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating System'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Exchanges where it is listed'
      - id: price_scale_code
        type: u1
        doc: 'Price Scale Code for price conversion of the symbol. See Price Formats'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Type of Security'
      - id: price_resolution
        type: u1
        enum: price_resolution
        doc: 'Price Resolution value'
      - id: reserved_1
        size: 1
        doc: 'Filler'
  series_index_mapping_message:
    seq:
      - id: series_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: channel_id
        type: u1
        doc: 'Multicast channel ID of the symbols being provided'
      - id: reserved_a_1
        size: 1
        doc: 'Filler'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'Identifies originating market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating System'
      - id: reserved_b_1
        size: 1
        doc: 'Filler'
      - id: stream_id
        type: u2
        doc: 'Identifies Stream on which this symbol will be updated'
      - id: underlying_index
        type: u4
        doc: 'The unique ID of the symbol in the Series Index message'
      - id: contract_multiplier
        type: u2
        doc: 'Contract quantity'
      - id: maturity_date
        type: str
        size: 6
        encoding: ASCII
        doc: 'YY MM DD'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Put or Call'
      - id: strike_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Strike price. ASCII 0-9 with optional decimal point. EG: 51.75, 123'
      - id: price_scale_code
        type: u1
        doc: 'Price Scale Code for price conversion of the symbol. See Price Formats'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Full symbol in NYSE Symbology'
      - id: option_symbol_root
        type: str
        size: 5
        encoding: ASCII
        doc: 'OCC root of option symbol'
      - id: group_id
        type: u4
        doc: 'Used by Market Makers. Predefined group of series within a given underlying symbol'
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
    401:
      id: 'outright_quote_message'
      doc: 'The Outright Quote message provides the price and aggregated volume for the best bid and best offer. Volumes aggregate quote and order interest. The message also indicates aggregated Customer volumes within the overall volumes.'
    407:
      id: 'outright_trade_message'
      doc: 'The Outright Trade message is used to publish all Last Sales for outright symbols.'
    409:
      id: 'outright_trade_cancel_message'
      doc: 'The Trade Cancel message is used to cancel or bust a trade.'
    411:
      id: 'outright_trade_correction_message'
      doc: 'The Trade Correction message is used to correct a trade.'
    413:
      id: 'outright_imbalance_message'
      doc: 'The Outright Imbalance message is sent during the Pre-opening phase or a symbol Halt to provide indicative opening price and net imbalance of all orders at that price which are orders eligible for next Auction.'
    415:
      id: 'outright_crossing_rfq_message'
      doc: 'The Outright Crossing RFQ (Request for Quote) message is sent out in the event of an auction on an outright order.'
    471:
      id: 'outright_bold_rfq_message'
      doc: 'The Outright BOLD RFQ (Request for Quote) message notifies clients of a special exposure order (a BOLD order) available for execution on a first-come first-served basis.'
    417:
      id: 'outright_summary_message'
      doc: 'The Outright summary message provides trading highlights of the day. It is sent out once at the end of the trading day as soon as a symbol closes.'
    419:
      id: 'underlying_status_message'
      doc: 'The Underlying Status message is used to inform the subscribers of changes in the status of an Underlying symbol.'
    421:
      id: 'outright_series_status_message'
      doc: 'The Series Status message is used to inform the subscribers of changes in symbol status of an outright symbol.'
    501:
      id: 'refresh_outright_quote_message'
      doc: 'The Refresh Quote message is sent in the event no quote messages are published for the symbol for 2 consecutive minutes.'
    507:
      id: 'refresh_outright_trade_message'
      doc: 'The Refresh Outright Trade message is sent in the event no Outright Trade messages are published for the symbol for 2 consecutive minutes.'
    509:
      id: 'refresh_outright_imbalance_message'
      doc: 'The Refresh Outright Imbalance message is sent in the event no Outright Imbalance messages are published for the symbol for 2 consecutive minutes during Pre-opening or a symbol Halt.'
    435:
      id: 'underlying_index_mapping_message'
      doc: 'On system startup, each multicast channel sends all the symbols on its channel. Underlying Index Mapping messages are published first, followed by all Series Index Mapping messages, and for the Complex feed, Complex Symbol Definitions last of all.'
    437:
      id: 'series_index_mapping_message'
      doc: 'On system startup, each multicast channel sends all the symbols on its channel. Underlying Index Mapping messages are published first, followed by all Series Index Mapping messages, and for the Complex feed, Complex Symbol Definitions last of all.'
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
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x48:
      id: 'halt'
      doc: 'Halt'
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
  market_imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'no_imbalance'
      doc: 'No Imbalance'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  capacity:
    0x20:
      id: 'not_specified'
      doc: 'Information Not Specified'
    0x30:
      id: 'customer'
      doc: 'Customer'
    0x31:
      id: 'firm'
      doc: 'Firm'
    0x32:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x33:
      id: 'market_maker'
      doc: 'Market Maker'
    0x38:
      id: 'professional_customer'
      doc: 'Professional Customer'
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
  exchange_code:
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x41:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x31:
      id: 'global_otc'
      doc: 'Global Otc'
    0x32:
      id: 'arca_local_nontapeb_index'
      doc: 'Arca Local Nontapeb Index'
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
      id: 'american_depository_shares'
      doc: 'American Depository Shares'
    0x49:
      id: 'units'
      doc: 'Units'
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
      id: 'units_x55'
      doc: 'Units'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
    0x58:
      id: 'index'
      doc: 'Index'
  price_resolution:
    0:
      id: 'all_penny'
      doc: 'All Penny'
    1:
      id: 'penny_nickel'
      doc: 'Penny Nickel'
    5:
      id: 'nickel_dime'
      doc: 'Nickel Dime'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'

