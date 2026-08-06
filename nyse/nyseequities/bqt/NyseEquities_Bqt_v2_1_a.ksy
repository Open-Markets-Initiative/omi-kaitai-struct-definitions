# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities Bqt Xdp v2.1.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Best Quote And Trade
#   Encoding: Exchange Data Publisher
#   Version: 2.1.a
#   Date: 04/04/2018
#   Specification: NYSE_BQT_Client_Specification_v2.1.pdf
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
  id: nyseequities_bqt_v2_1_a
  title: Nyse NyseEquities Bqt Xdp v2.1.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Best Quote And Trade Xdp v2.1.a'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_BQT_Client_Specification.pdf

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
            'message_type::sequence_number_reset_message': sequence_number_reset_message
            'message_type::symbol_index_mapping_message': symbol_index_mapping_message
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::request_response_message': request_response_message
            'message_type::heartbeat_response_message': heartbeat_response_message
            'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
            'message_type::refresh_request_message': refresh_request_message
            'message_type::message_unavailable_message': message_unavailable_message
            'message_type::consolidated_symbol_clear_message': consolidated_symbol_clear_message
            'message_type::consolidated_trading_session_change_message': consolidated_trading_session_change_message
            'message_type::consolidated_security_status_message': consolidated_security_status_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::bqt_message': bqt_message
            'message_type::consolidated_single_sided_quote_message': consolidated_single_sided_quote_message
            'message_type::consolidated_trade_message': consolidated_trade_message
            'message_type::consolidated_trade_cancel_message': consolidated_trade_cancel_message
            'message_type::consolidated_trade_correction_message': consolidated_trade_correction_message
            'message_type::consolidated_stock_summary_message': consolidated_stock_summary_message
            'message_type::consolidated_volume_message': consolidated_volume_message
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
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  symbol_index_mapping_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Null-terminated ASCII symbol in NYSE Symbology'
      - id: reserved_binary_1
        type: u1
        doc: 'This field is reserved for future use'
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
        doc: 'Type of Security used by Arca, National and American'
      - id: lot_size
        type: u2
        doc: 'Round lot size in shares'
      - id: prev_close_price
        type: u4
        doc: 'The previous day’s closing price for this security'
      - id: prev_close_volume
        type: u4
        doc: 'The previous day’s closing volume for the security'
      - id: price_resolution
        type: u1
        enum: price_resolution
        doc: 'All Penny, Penny/Nickel, Nickel/Dime'
      - id: round_lot
        type: u1
        enum: round_lot
        doc: 'Round Lots Accepted'
      - id: mpv
        type: u2
        doc: 'The minimum increment for a trade price, in 100ths of a cent. Typically 1, or $0.0001, but for some Tick Pilot stocks, can be 500, or $0.05'
      - id: unit_of_trade
        type: u2
        doc: 'This field specifies the security Unit of Trade in shares. Valid values are 1, 10, 50 and 100'
      - id: reserved_binary_2
        type: u2
        doc: 'Reserved for future use. Disregard any content'
  retransmission_request_message:
    seq:
      - id: begin_seq_num
        type: u4
        doc: 'The beginning sequence number of the range of messages to be retransmitted'
      - id: end_seq_num
        type: u4
        doc: 'The end sequence number of the range of messages to be retransmitted'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission . This field is up to 9 characters, null terminated'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  request_response_message:
    seq:
      - id: request_seq_num
        type: u4
        doc: 'The sequence number of the request message sent by the client. This can be used by the client to couple this response with the original request message'
      - id: begin_seq_num
        type: u4
        doc: 'The beginning sequence number of the range of messages to be retransmitted'
      - id: end_seq_num
        type: u4
        doc: 'The end sequence number of the range of messages to be retransmitted'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission . This field is up to 9 characters, null terminated'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
      - id: status
        type: u1
        enum: status
        doc: 'The reason why the request was rejected'
  heartbeat_response_message:
    seq:
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission . This field is up to 9 characters, null terminated'
  symbol_index_mapping_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission . This field is up to 9 characters, null terminated'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
      - id: retransmit_method
        type: u1
        enum: retransmit_method
        doc: 'The delivery method for the requested symbol index mapping information'
  refresh_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission . This field is up to 9 characters, null terminated'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  message_unavailable_message:
    seq:
      - id: begin_seq_num
        type: u4
        doc: 'The beginning sequence number of the range of messages to be retransmitted'
      - id: end_seq_num
        type: u4
        doc: 'The end sequence number of the range of messages to be retransmitted'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed’s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  consolidated_symbol_clear_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: next_source_seq_num
        type: u4
        doc: 'The sequence number in the next message for this symbol'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  consolidated_trading_session_change_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: trade_session
        type: trade_session
        doc: 'A trading session value'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  trade_session:
    seq:
      - id: ok_for_morning_hours
        type: b1
        doc: 'Ok for morning hours'
      - id: ok_for_national_hours_core
        type: b1
        doc: 'Ok for national hours (core)'
      - id: ok_for_late_hours
        type: b1
        doc: 'Ok for late hours'
      - id: reserved_5
        type: b5
        doc: 'Reserved'
  consolidated_security_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'Halt condition indicator'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
      - id: reserved_binary_2
        type: u2
        doc: 'Reserved for future use. Disregard any content'
      - id: price_1
        type: u4
        doc: 'Default value is 0'
      - id: price_2
        type: u4
        doc: 'Default value is 0'
      - id: ssr_triggering_exchange_id
        type: u1
        enum: ssr_triggering_exchange_id
        doc: 'This field is only populated when securityStatus = A and this security is listed on this exchange. Otherwise it is defaulted to 0x20'
      - id: ssr_triggering_volume
        type: u4
        doc: 'This field is only populated when securityStatus = A and this security is listed on this exchange'
      - id: time
        type: u4
        doc: 'Format : HHMMSSmmm (mmm = milliseconds)'
      - id: ssr_state
        type: u1
        enum: ssr_state
        doc: 'The current SSR state, which this msg updates if the Security Status field contains an SSR Code. Valid'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The current Market State, which this msg updates if the Security Status field contains a Market State Code'
      - id: session_state
        type: u1
        enum: session_state
        doc: 'Unused. Defaulted to 0x00'
  refresh_header_message:
    seq:
      - id: current_refresh_pkt
        type: u2
        doc: 'The current refresh packet in the update'
      - id: total_refresh_pkts
        type: u2
        doc: 'The total number of refresh packets you should expect in the update'
      - id: last_seq_num
        type: u4
        doc: 'The last sequence number sent on the channel for any symbol. The refresh is the state of the order book as of this sequence number'
      - id: last_symbol_seq_num
        type: u4
        doc: 'The last symbol sequence number sent for this symbol. The refresh is the symbol state of this symbol as of this symbol sequence number'
  bqt_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: ask_price
        type: u4
        doc: 'The Ask price'
      - id: ask_volume
        type: u4
        doc: 'The Ask size'
      - id: bid_price
        type: u4
        doc: 'The Bid price'
      - id: bid_volume
        type: u4
        doc: 'The Bid size'
      - id: ask_quote_condition
        type: u1
        enum: ask_quote_condition
        doc: 'Ask Quote Condition'
      - id: bid_quote_condition
        type: u1
        enum: bid_quote_condition
        doc: 'Bid Quote Condition'
      - id: retail_pricing_indicator
        type: u1
        enum: retail_pricing_indicator
        doc: 'Retail Pricing Indicator'
      - id: market_id_of_best_ask
        type: u2
        enum: market_id_of_best_ask
        doc: 'The ID of the Originating Market of best ask'
      - id: market_id_of_best_bid
        type: u2
        enum: market_id_of_best_bid
        doc: 'The ID of the Originating Market of best bid'
  consolidated_single_sided_quote_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: price
        type: u4
        doc: 'The price'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: rpi_indicator
        type: u1
        enum: rpi_indicator
        doc: 'Retail Pricing Indicator value'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  consolidated_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: trade_id
        type: u4
        doc: 'The unique Trade ID assigned by the source system'
      - id: price
        type: u4
        doc: 'The price'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: trade_condition_1
        type: u1
        enum: trade_condition_1
        doc: 'Settlement related conditions'
      - id: trade_condition_2
        type: u1
        enum: trade_condition_2
        doc: 'The reason for Trade Through Exemptions'
      - id: trade_condition_3
        type: u1
        enum: trade_condition_3
        doc: 'Extended hours/sequencing related conditions'
      - id: trade_condition_4
        type: u1
        enum: trade_condition_4
        doc: 'SRO Required Detail'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  consolidated_trade_cancel_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: trade_id
        type: u4
        doc: 'The unique Trade ID assigned by the source system'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  consolidated_trade_correction_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: original_trade_id
        type: u4
        doc: 'The ID of the Trade being corrected'
      - id: trade_id
        type: u4
        doc: 'The unique Trade ID assigned by the source system'
      - id: price
        type: u4
        doc: 'The price'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: trade_condition_1
        type: u1
        enum: trade_condition_1
        doc: 'Settlement related conditions'
      - id: trade_condition_2
        type: u1
        enum: trade_condition_2
        doc: 'The reason for Trade Through Exemptions'
      - id: trade_condition_3
        type: u1
        enum: trade_condition_3
        doc: 'Extended hours/sequencing related conditions'
      - id: trade_condition_4
        type: u1
        enum: trade_condition_4
        doc: 'SRO Required Detail'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
  consolidated_stock_summary_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: high_price
        type: u4
        doc: 'The High price of the stock for the day. Use the Price scale from the symbol mapping index'
      - id: low_price
        type: u4
        doc: 'The Low price of the stock for the day. Use the Price scale from the symbol mapping index'
      - id: open
        type: u4
        doc: 'The Opening price of the stock for the day. Use the Price scale from the symbol mapping index'
      - id: total_volume
        type: u4
        doc: 'The cumulative volume for the stock throughout the day'
      - id: market_id_of_high_price
        type: u2
        enum: market_id_of_high_price
        doc: 'The ID of the Originating Market'
      - id: market_id_of_low_price
        type: u2
        enum: market_id_of_low_price
        doc: 'The ID of the Originating Market'
      - id: market_id_of_open_price
        type: u2
        enum: market_id_of_open_price
        doc: 'The ID of the Originating Market'
      - id: number_of_close_prices
        type: u1
        doc: 'The number of Market ID/Closing Price pairs. Values can be 0-3'
      - id: close_price
        type: close_price
        doc: 'Market ID/Closing Price pairs'
  close_price:
    seq:
      - id: market_id_of_the_close
        type: u2
        enum: market_id_of_the_close
        doc: 'The ID of the Originating Market'
      - id: close
        type: u4
        doc: 'The Closing price of the stock for the day'
  consolidated_volume_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: total_volume
        type: u4
        doc: 'The cumulative volume for the stock throughout the day'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for this update'
      - id: complete
        type: u1
        enum: complete
        doc: 'Completion indicator'

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
    1:
      id: 'sequence_number_reset_message'
      doc: 'This message is sent to reset the Message Sequence Number at start of day, or in response to failures.'
    3:
      id: 'symbol_index_mapping_message'
      doc: 'This message is published over the real-time data channels at system startup or in the context of a refresh sequence after a Matching Engine or XDP Publisher failover. It provides referential data for a single specified symbol.'
    10:
      id: 'retransmission_request_message'
      doc: 'Clients who have experienced a sequence number gap and need a retransmission of the missed messages should send a Retransmission Request message via TCP to the Request Controller. A Request Response message will be sent over the TCP connection back to the client, and if the request was valid, the requested message(s) will be re-published over the relevant Retransmission multicast channel.'
    11:
      id: 'request_response_message'
      doc: 'This message will be sent immediately via TCP/IP in response to the client’s request for retransmission, refresh or Symbol Mapping messages.'
    12:
      id: 'heartbeat_response_message'
      doc: 'Clients who remain connected to the Retransmission Server intraday must respond to a Heartbeat with a Heartbeat Response message within 5 seconds. If no timely client response is received, the connection will be closed.'
    13:
      id: 'symbol_index_mapping_request_message'
      doc: 'This message is sent by clients via TCP/IP requesting the Symbol Index Mapping messages for one or all symbols in a specified channel.'
    15:
      id: 'refresh_request_message'
      doc: 'Clients who have experienced a failure and need a refresh of the state of one or all symbols in a specific channel should send a Retransmission Request message via TCP to the Request Controller. A Request Response message will be sent over the TCP connection back to the client, and if the request was valid, the requested message(s) will be published over the relevant Refresh multicast channel.'
    31:
      id: 'message_unavailable_message'
      doc: 'This message will be sent over the Retransmission multicast channels to inform clients of unavailability of a range of messages (or part of a range) for which they may have requested a retransmission.'
    32:
      id: 'consolidated_symbol_clear_message'
      doc: 'In case of a failure and recovery of a Matching Engine or an XDP Publisher, the publisher may send a full state refresh for every symbol affected. This kind of unrequested refresh is preceded by a Symbol Clear message. The client should react to receipt of a Symbol Clear message by clearing all state information for the specified symbol in anticipation of receiving a full state refresh.'
    33:
      id: 'consolidated_trading_session_change_message'
      doc: 'This message is sent on both the BBO feed and the Trades feed from the Arca market only.'
    34:
      id: 'consolidated_security_status_message'
      doc: 'This message informs clients of changes in the status of a specific security, such as Trading Halts, Short Sale Restriction state changes, etc.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels is of this type.'
    142:
      id: 'bqt_message'
      doc: 'This message is sent when an event causes a change in one or both sides of the BBO.'
    143:
      id: 'consolidated_single_sided_quote_message'
      doc: 'This message is sent when an event causes a change in only one side of a BBO.'
    220:
      id: 'consolidated_trade_message'
      doc: 'The Trade messages provided on the Trades feed are the same Trade messages provided to the Cta. All Trades are passed through and marked with the originating Market ID.'
    221:
      id: 'consolidated_trade_cancel_message'
      doc: 'This message is sent when a trade is cancelled'
    222:
      id: 'consolidated_trade_correction_message'
      doc: 'This message is sent when a trade is corrected'
    229:
      id: 'consolidated_stock_summary_message'
      doc: 'The stock summary message is sent every 1 minute regardless of whether there is a change to a particular value or not. In the event that there is no volume on the stock, the stock summary message will not be disseminated.'
    240:
      id: 'consolidated_volume_message'
      doc: 'Published on consolidated volume channels'
  market_id:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    4:
      id: 'nyse_arca_options'
      doc: 'Nyse Arca Options'
    5:
      id: 'nyse_bonds'
      doc: 'Nyse Bonds'
    6:
      id: 'global_otc'
      doc: 'Global Otc'
    8:
      id: 'nyse_amex_options'
      doc: 'Nyse Amex Options'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
    10:
      id: 'nyse_national'
      doc: 'Nyse National'
  exchange_code:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'global_otc'
      doc: 'Global Otc Primary Symbols'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x55:
      id: 'otcbb'
      doc: 'Otcbb Symbols For Global Otc'
    0x56:
      id: 'other_otc'
      doc: 'Other Otc Symbols For Global Otc'
    0x5a:
      id: 'bats'
      doc: 'Bats'
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
      id: 'units_x55'
      doc: 'Units'
    0x57:
      id: 'warrant'
      doc: 'Warrant'
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
  round_lot:
    0x59:
      id: 'yes'
      doc: 'Yes'
    0x4e:
      id: 'no'
      doc: 'No'
  status:
    0x30:
      id: 'message_was_accepted'
      doc: 'Message Was Accepted'
    0x31:
      id: 'rejected_due_to_an_invalid_source_id'
      doc: 'Rejected Due To An Invalid Source Id'
    0x32:
      id: 'invalid_sequence_range'
      doc: 'Rejected Due To Invalid Sequence Range'
    0x33:
      id: 'maximum_sequence_range'
      doc: 'Rejected Due To Maximum Sequence Range See Threshold Limits'
    0x34:
      id: 'maximum_request_in_a_day'
      doc: 'Rejected Due To Maximum Request In A Day'
    0x35:
      id: 'maximum_refresh_requests_in_a_day'
      doc: 'Rejected Due To Maximum Number Of Refresh Requests In A Day'
    0x36:
      id: 'old_seq_num_ttl'
      doc: 'Rejected Request Message Seq Num Ttl Time To Live Is Too Old Use Refresh To Recover Current State If Necessary'
    0x37:
      id: 'invalid_channel_id'
      doc: 'Rejected Due To An Invalid Channel Id'
    0x38:
      id: 'invalid_product_id'
      doc: 'Rejected Due To An Invalid Product Id'
    0x39:
      id: 'invalid_msg_type_or_mismatch_between_msg_type_and_msg_size'
      doc: 'Rejected Due To 1 Invalid Msg Type Or 2 Mismatch Between Msg Type And Msg Size'
  retransmit_method:
    0:
      id: 'udp'
      doc: 'Deliver Via Udp'
  security_status:
    0x33:
      id: 'opening_delay'
      doc: 'Opening Delay Nyse Tape A Only'
    0x34:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x35:
      id: 'resume'
      doc: 'Resume'
    0x36:
      id: 'no_openno_resume'
      doc: 'No Openno Resume Nyse Tape A Only'
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
    0x54:
      id: 'time'
      doc: 'Time'
    0x49:
      id: 'price_indication'
      doc: 'Price Indication'
    0x47:
      id: 'pre_opening_price_indication'
      doc: 'Pre Opening Price Indication'
    0x52:
      id: 'rule_15_indication'
      doc: 'Rule 15 Indication'
  halt_condition:
    0x7e:
      id: 'security_not_delayedhalted'
      doc: 'Security Not Delayedhalted'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x44:
      id: 'news_dissemination'
      doc: 'News Dissemination'
    0x49:
      id: 'order_imbalance'
      doc: 'Order Imbalance'
    0x50:
      id: 'news_pending'
      doc: 'News Pending'
    0x4d:
      id: 'volatility_trading_pause'
      doc: 'Volatility Trading Pause'
    0x58:
      id: 'equipment_changeover'
      doc: 'Equipment Changeover'
    0x5a:
      id: 'no_open_no_resume'
      doc: 'No Open No Resume'
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
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x44:
      id: 'finra'
      doc: 'Finra'
    0x49:
      id: 'ise'
      doc: 'Ise'
    0x4a:
      id: 'edga'
      doc: 'Edga'
    0x4b:
      id: 'edgx'
      doc: 'Edgx'
    0x4d:
      id: 'chx'
      doc: 'Chx'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'cts'
      doc: 'Cts'
    0x54:
      id: 'nasdaq_omx'
      doc: 'Nasdaq Omx'
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
      id: 'bats_y'
      doc: 'Bats Y'
    0x5a:
      id: 'bats'
      doc: 'Bats'
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
      id: 'late_session'
      doc: 'Late Session Non Nyse Only'
    0x58:
      id: 'closed'
      doc: 'Closed'
  session_state:
    0x58:
      id: 'early_session_state'
      doc: 'Early Session State'
    0x59:
      id: 'core_session_state'
      doc: 'Core Session State'
    0x5a:
      id: 'late_session_state'
      doc: 'Late Session State'
  ask_quote_condition:
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular_quote'
      doc: 'Regular Quote'
    0x57:
      id: 'slow_on_the_bid_and_ask'
      doc: 'Slow On The Bid And Ask Due To A Set Slow List'
  bid_quote_condition:
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular_quote'
      doc: 'Regular Quote'
    0x57:
      id: 'slow_on_the_bid_and_ask'
      doc: 'Slow On The Bid And Ask Due To A Set Slow List'
  retail_pricing_indicator:
    0:
      id: 'no_retail_interest'
      doc: 'No Retail Interest'
    1:
      id: 'retail_interest_on_the_bid_side'
      doc: 'Retail Interest On The Bid Side'
    2:
      id: 'retail_interest_on_the_ask_side'
      doc: 'Retail Interest On The Ask Side'
    3:
      id: 'retail_interest_on_bid_and_ask_side'
      doc: 'Retail Interest On Bid And Ask Side'
  market_id_of_best_ask:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  market_id_of_best_bid:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  quote_condition:
    0x43:
      id: 'closing'
      doc: 'Closing'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote'
    0x52:
      id: 'regular_quote'
      doc: 'Regular Quote'
    0x57:
      id: 'slow_on_the_bid_and_ask'
      doc: 'Slow On The Bid And Ask Due To A Set Slow List'
    0x00:
      id: 'empty_quote'
      doc: 'No Bbo Available For The Given Instrument'
  rpi_indicator:
    0x20:
      id: 'no_retail_interest'
      doc: 'Space Means No Retail Interest Default'
    0x41:
      id: 'interest_on_bid'
      doc: 'Retail Interest On The Bid Side'
    0x42:
      id: 'interest_on_offer'
      doc: 'Retail Interest On The Offer Side'
    0x43:
      id: 'interest_on_bid_and_offer'
      doc: 'Retail Interest On The Bid And Offer Sides'
  trade_condition_1:
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'next_day_trade'
      doc: 'Next Day Trade'
    0x52:
      id: 'seller'
      doc: 'Seller'
  trade_condition_2:
    0x20:
      id: 'na'
      doc: 'Na'
    0x46:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'Market Center Opening Trade'
    0x34:
      id: 'derivatively_priced'
      doc: 'Derivatively Priced'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'Market Center Reopening Trade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'Market Center Closing Trade'
    0x39:
      id: 'corrected_last_sale_price'
      doc: 'Corrected Last Sale Price'
  trade_condition_3:
    0x20:
      id: 'na'
      doc: 'Na'
    0x4c:
      id: 'sold_last'
      doc: 'Sold Last'
    0x54:
      id: 'extended_hours_trade'
      doc: 'Extended Hours Trade'
    0x55:
      id: 'extended_hours_sold_out_of_sequence'
      doc: 'Extended Hours Sold Out Of Sequence'
    0x5a:
      id: 'sold'
      doc: 'Sold'
  trade_condition_4:
    0x20:
      id: 'na'
      doc: 'Na'
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x42:
      id: 'average_price_trade'
      doc: 'Average Price Trade'
    0x45:
      id: 'automatic_execution'
      doc: 'Automatic Execution'
    0x48:
      id: 'price_variation_trade'
      doc: 'Price Variation Trade'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x4b:
      id: 'rule_127_nyse_only_or_rule_155_nyse_american_only'
      doc: 'Rule 127 Nyse Only Or Rule 155 Nyse American Only'
    0x4d:
      id: 'official_closing_price'
      doc: 'Official Closing Price'
    0x50:
      id: 'prior_reference_price'
      doc: 'Prior Reference Price'
    0x51:
      id: 'official_open_price'
      doc: 'Official Open Price'
    0x56:
      id: 'stock_option_trade'
      doc: 'Stock Option Trade'
    0x58:
      id: 'cross_trade'
      doc: 'Cross Trade'
  market_id_of_high_price:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  market_id_of_low_price:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  market_id_of_open_price:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  market_id_of_the_close:
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    1:
      id: 'nyse'
      doc: 'Nyse'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    9:
      id: 'nyse_american'
      doc: 'Nyse American'
  reason:
    0:
      id: 'new_trade'
      doc: 'New Trade'
    1:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
    2:
      id: 'trade_error'
      doc: 'Trade Error'
    3:
      id: 'trade_correction'
      doc: 'Trade Correction'
    4:
      id: 'closing_end_trade_summary'
      doc: 'Closing End Trade Summary'
  complete:
    0:
      id: 'normal'
      doc: 'Normal Data Is Complete'
    1:
      id: 'abnormal'
      doc: 'An Unrecoverable Gap Was Experienced In The Input Stream So Data May Not Be Complete'

