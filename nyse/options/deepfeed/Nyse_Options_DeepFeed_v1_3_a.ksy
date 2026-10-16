# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse Options DeepFeed Xdp v1.3.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: 
#   Encoding: Exchange Data Publisher
#   Version: 1.3.a
#   Date: 02/28/2018
#   Specification: XDP_Options_Client_Specification (1.3a).pdf
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
  id: nyse_options_deepfeed_xdp_v1_3_a
  title: Nyse Options DeepFeed Xdp v1.3.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Options Xdp v1.3.a'
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
        doc: 'Size of the message body in bytes including this field'
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
      doc: 'Heartbeat'
    2:
      id: 'contains_original_and_refresh_msgs'
      doc: 'Contains original and Refresh msgs'
    3:
      id: 'contains_only_refresh_messages'
      doc: 'Contains only Refresh messages'
    10:
      id: 'xdp_failover'
      doc: 'XDP Failover'
    11:
      id: 'contains_only_original_messages'
      doc: 'Contains only original messages'
    12:
      id: 'sequence_number_reset_message'
      doc: 'Sequence Number Reset Message'
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
      doc: 'Pre-open'
    0x35:
      id: 'rotation_legal_width_quote_pending'
      doc: 'Rotation, legal width quote pending'
  security_status:
    0x4c:
      id: 'light_up_a_dark_series'
      doc: 'Light up a dark series'
    0x4e:
      id: 'open_a_dark_series'
      doc: 'Open a dark series'
    0x4f:
      id: 'open'
      doc: 'Open indication'
    0x58:
      id: 'close'
      doc: 'Close indication'
    0x53:
      id: 'halt'
      doc: 'Halt'
    0x55:
      id: 'unhalt'
      doc: 'Unhalt'
    0x54:
      id: 'unhalt_a_dark_series'
      doc: 'Unhalt a dark series'
    0x51:
      id: 'end_of_rfq_auction'
      doc: 'End of RFQ auction'
  market_id:
    1:
      id: 'nyse_cash'
      doc: 'NYSE Cash'
    2:
      id: 'europe_cash'
      doc: 'Europe Cash'
    3:
      id: 'nyse_arca_cash'
      doc: 'NYSE Arca Cash'
    4:
      id: 'nyse_arca_options'
      doc: 'NYSE/Arca Options'
    5:
      id: 'nyse_arca_bonds'
      doc: 'NYSE/Arca Bonds'
    6:
      id: 'arca_edge'
      doc: 'ArcaEdge'
    7:
      id: 'liffe'
      doc: 'LIFFE'
    8:
      id: 'nyse_american_options'
      doc: 'NYSE American Options'
    9:
      id: 'nyse_mkt_cash'
      doc: 'NYSE MKT Cash'
  exchange_code:
    0x4e:
      id: 'nyse'
      doc: 'NYSE'
    0x50:
      id: 'nyse_arca'
      doc: 'NYSE Arca'
    0x51:
      id: 'nasdaq'
      doc: 'NASDAQ'
    0x41:
      id: 'nyse_mkt'
      doc: 'NYSE MKT'
    0x31:
      id: 'global_otc'
      doc: 'GLOBAL OTC'
    0x32:
      id: 'arca_local_nontapeb_index'
      doc: 'ARCA LOCAL NON-TAPE-B INDEX'
  security_type:
    0x41:
      id: 'adr'
      doc: 'ADR'
    0x43:
      id: 'common_stock'
      doc: 'COMMON STOCK'
    0x44:
      id: 'debentures'
      doc: 'DEBENTURES'
    0x45:
      id: 'etf'
      doc: 'ETF'
    0x46:
      id: 'foreign'
      doc: 'FOREIGN'
    0x48:
      id: 'american_depository_shares'
      doc: 'AMERICAN DEPOSITORY SHARES'
    0x49:
      id: 'units'
      doc: 'UNITS'
    0x4d:
      id: 'miscliquid_trust'
      doc: 'MISC/LIQUID TRUST'
    0x4f:
      id: 'ordinary_shares'
      doc: 'ORDINARY SHARES'
    0x50:
      id: 'preferred_stock'
      doc: 'PREFERRED STOCK'
    0x52:
      id: 'rights'
      doc: 'RIGHTS'
    0x53:
      id: 'shares_of_beneficiary_interest'
      doc: 'SHARES OF BENEFICIARY INTEREST'
    0x54:
      id: 'test'
      doc: 'TEST'
    0x55:
      id: 'units_x55'
      doc: 'UNITS'
    0x57:
      id: 'warrant'
      doc: 'WARRANT'
    0x58:
      id: 'index'
      doc: 'INDEX'
  price_resolution:
    0:
      id: 'all_penny'
      doc: 'All penny'
    1:
      id: 'penny_nickel'
      doc: 'Penny/Nickel'
    5:
      id: 'nickel_dime'
      doc: 'Nickel/Dime'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'

