# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaOptions DeepFeed Xdp v1.3.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Deep Feed
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
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: arcaoptions_deepfeed_v1_3_a
  title: Nyse ArcaOptions DeepFeed Xdp v1.3.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Options Deep Feed Xdp v1.3.a'
doc-ref: https://www.nyse.com/market-data/real-time/options-deep-feed

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
            'message_type::outright_market_depth_buy_message': outright_market_depth_buy_message
            'message_type::outright_market_depth_sell_message': outright_market_depth_sell_message
            'message_type::underlying_status_message': underlying_status_message
            'message_type::outright_series_status_message': outright_series_status_message
            'message_type::refresh_outright_market_depth_buy_message': refresh_outright_market_depth_buy_message
            'message_type::refresh_outright_market_depth_sell_message': refresh_outright_market_depth_sell_message
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
  outright_market_depth_buy_message:
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
        doc: 'Sequence number of messages for the Outright options symbol'
      - id: first_level_price
        type: s4
        doc: 'Price of first buy level'
      - id: second_level_price
        type: s4
        doc: 'Price of second buy level'
      - id: third_level_price
        type: s4
        doc: 'Price of third buy level'
      - id: first_level_volume
        type: u2
        doc: 'Total volume at first price level'
      - id: second_level_volume
        type: u2
        doc: 'Total volume at second price level'
      - id: third_level_volume
        type: u2
        doc: 'Total volume at third price level'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition values'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: first_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the first level'
      - id: second_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the second level'
      - id: third_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the third level'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  outright_market_depth_sell_message:
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
        doc: 'Sequence number of messages for the Outright options symbol'
      - id: first_level_price
        type: s4
        doc: 'Price of first buy level'
      - id: second_level_price
        type: s4
        doc: 'Price of second buy level'
      - id: third_level_price
        type: s4
        doc: 'Price of third buy level'
      - id: first_volume
        type: u2
        doc: 'Total volume at First price level'
      - id: second_volume
        type: u2
        doc: 'Total volume at Second price level'
      - id: third_volume
        type: u2
        doc: 'Total volume at Third price level'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition values'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: first_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the first level'
      - id: second_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the second level'
      - id: third_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the third level'
      - id: reserved_2
        size: 2
        doc: 'Filler'
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
        doc: 'SecurityStatus value'
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
        doc: 'Sequence number of messages for the Outright options symbol'
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
  refresh_outright_market_depth_buy_message:
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
        doc: 'Sequence number of messages for the Outright options symbol'
      - id: first_level_price
        type: s4
        doc: 'Price of first buy level'
      - id: second_level_price
        type: s4
        doc: 'Price of second buy level'
      - id: third_level_price
        type: s4
        doc: 'Price of third buy level'
      - id: first_volume
        type: u2
        doc: 'Total volume at First price level'
      - id: second_volume
        type: u2
        doc: 'Total volume at Second price level'
      - id: third_volume
        type: u2
        doc: 'Total volume at Third price level'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition values'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: first_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the first level'
      - id: second_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the second level'
      - id: third_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the third level'
      - id: reserved_2
        size: 2
        doc: 'Filler'
  refresh_outright_market_depth_sell_message:
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
        doc: 'Sequence number of messages for the Outright options symbol'
      - id: first_level_price
        type: s4
        doc: 'Price of first buy level'
      - id: second_level_price
        type: s4
        doc: 'Price of second buy level'
      - id: third_level_price
        type: s4
        doc: 'Price of third buy level'
      - id: first_volume
        type: u2
        doc: 'Total volume at First price level'
      - id: second_volume
        type: u2
        doc: 'Total volume at Second price level'
      - id: third_volume
        type: u2
        doc: 'Total volume at Third price level'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'QuoteCondition values'
      - id: reserved_1
        size: 1
        doc: 'Filler'
      - id: first_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the first level'
      - id: second_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the second level'
      - id: third_level_customer_volume
        type: u2
        doc: 'Total volume of customer orders at the third level'
      - id: reserved_2
        size: 2
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
    403:
      id: 'outright_market_depth_buy_message'
      doc: 'The Buy Market Depth message provides prices and aggregated volumes for each of the best three Buy levels.'
    405:
      id: 'outright_market_depth_sell_message'
      doc: 'The Sell Market Depth message provides prices and aggregated volumes for each of the best three Sell levels.'
    419:
      id: 'underlying_status_message'
      doc: 'The Underlying Status message is used to inform the subscribers of changes in the status of an Underlying symbol.'
    421:
      id: 'outright_series_status_message'
      doc: 'The Series Status message is used to inform the subscribers of changes in symbol status of an outright symbol.'
    503:
      id: 'refresh_outright_market_depth_buy_message'
      doc: 'The Refresh Market Depth Buy message is sent in the event no Buy Market Depth messages are published for the symbol for 2 consecutive minutes.'
    505:
      id: 'refresh_outright_market_depth_sell_message'
      doc: 'The Refresh Market Depth Sell message is sent in the event no Sell Market Depth messages are published for the symbol for 2 consecutive minutes.'
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

