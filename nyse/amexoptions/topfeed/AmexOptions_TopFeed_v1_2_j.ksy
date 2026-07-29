# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nyse AmexOptions TopFeed v1.2.j
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: amexoptions_topfeed_v1_2_j
  title: Nyse AmexOptions TopFeed Pillar v1.2.j
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Amex Options Top Feed Pillar v1.2.j'
doc-ref: https://www.nyse.com/market-data/real-time/options-top-feed

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
            'message_type::outright_series_index_mapping_message': outright_series_index_mapping_message
            'message_type::options_status_message': options_status_message
            'message_type::complex_series_index_mapping_message': complex_series_index_mapping_message
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::refresh_request_message': refresh_request_message
            'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
            'message_type::message_unavailable_message': message_unavailable_message
            'message_type::request_response_message': request_response_message
            'message_type::heartbeat_response_message': heartbeat_response_message
            'message_type::options_quote_message': options_quote_message
            'message_type::options_trade_message': options_trade_message
            'message_type::options_trade_cancel_message': options_trade_cancel_message
            'message_type::options_trade_correction_message': options_trade_correction_message
            'message_type::options_imbalance_message': options_imbalance_message
            'message_type::series_rfq_message': series_rfq_message
            'message_type::outright_series_summary_message': outright_series_summary_message
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
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
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
        doc: 'Reserved for future use. Ignore any content'
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
  symbol_index_mapping_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Null-terminated ASCII symbol in NYSE Symbology'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
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
        enum: price_scale_code
        doc: 'Specifies placement of the decimal point in price fields for this security'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Type of Security used by Pillar markets'
      - id: lot_size
        type: u2
        doc: 'Round lot size in shares'
      - id: prev_close_price
        type: s4
        doc: 'The previous day''s closing price for this security. Implied decimal with scale 1e-8'
      - id: prev_close_volume
        type: u4
        doc: 'The previous day''s closing volume for the security'
      - id: price_resolution
        type: u1
        enum: price_resolution
        doc: 'Price resolution'
      - id: round_lot
        type: u1
        enum: round_lot
        doc: 'Round Lots Accepted'
      - id: reserved_2
        type: u2
        doc: 'Reserved for future use'
      - id: reserved_2_2
        type: u2
        doc: 'Reserved for future use'
      - id: reserved_2_3
        type: u2
        doc: 'Reserved for future use'
  symbol_clear_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: next_source_seq_num
        type: u4
        doc: 'The sequence number in the next message for this symbol'
  security_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'Halt condition'
      - id: reserved_4
        type: u4
        doc: 'Reserved for future use'
      - id: price_1
        type: s4
        doc: 'Default value is 0. SSR Triggering Trade Price or Indication Low Price depending on Security Status. Implied decimal with scale 1e-8'
      - id: price_2
        type: s4
        doc: 'Default value is 0. Indication High Price if securityStatus = G or I. Implied decimal with scale 1e-8'
      - id: ssr_triggering_exchange_id
        type: u1
        enum: ssr_triggering_exchange_id
        doc: 'Only populated when securityStatus = A and this security is listed on this exchange. Otherwise defaulted to space (0x20)'
      - id: ssr_triggering_volume
        type: u4
        doc: 'Default value is 0. Only populated when securityStatus = A and this security is listed on this exchange'
      - id: time
        type: u4
        doc: 'Default value is 0. Format: HHMMSSmmm. SSR Trigger Time if securityStatus = A'
      - id: ssr_state
        type: u1
        enum: ssr_state
        doc: 'The current SSR state'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The current Market State'
      - id: session_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'Unused. Defaulted to 0x20'
  outright_series_index_mapping_message:
    seq:
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_type
        type: u1
        enum: series_type
        doc: 'Identifies series type'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating matching engine server'
      - id: option_symbol_root
        type: str
        size: 6
        encoding: ASCII
        doc: 'Root symbol for options in OCC symbology (EX. BRKB)'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Underlying symbol for options in NYSE symbology (EX. BRK B)'
      - id: underlying_index
        type: u4
        doc: 'Underlying stock mapping index'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'Specifies placement of the decimal point in price fields for this security'
      - id: contract_multiplier
        type: u2
        doc: 'Number of Underlying shares per option contract'
      - id: maturity_date
        type: str
        size: 6
        encoding: ASCII
        doc: 'Option maturity date - YYMMDD'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Put or Call indicator'
      - id: strike_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Strike price. ASCII 0-9 with optional decimal point. EG:51.75, 123 (Option only)'
      - id: closing_only_indicator
        type: u1
        enum: closing_only_indicator
        doc: 'Closing Only Indicator'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
  options_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'The new status that this series is transitioning to'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The current Market State'
      - id: options_status_halt_condition
        type: u1
        enum: options_status_halt_condition
        doc: 'Halt condition for option series'
  complex_series_index_mapping_message:
    seq:
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'ID of the Originating Market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating matching engine server'
      - id: num_complex_series_index_mapping_leg
        type: u2
        doc: 'Number of legs in complex symbol. 2 - 12'
      - id: complex_series_index_mapping_leg
        type: complex_series_index_mapping_leg
        repeat: expr
        repeat-expr: num_complex_series_index_mapping_leg
  complex_series_index_mapping_leg:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: leg_ratio_qty
        type: u2
        doc: 'Leg Ratio. This field will repeat for each leg'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side. This field will repeat for each leg'
      - id: leg_security_type
        type: u1
        enum: leg_security_type
        doc: 'Leg Security Type. This field will repeat for each leg'
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
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
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
        doc: 'The last symbol sequence number sent for this symbol. The refresh is the symbol state as of this symbol sequence number'
  refresh_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  symbol_index_mapping_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market'
      - id: source_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
      - id: retransmit_method
        type: u1
        enum: retransmit_method
        doc: 'The delivery method for the requested symbol index mapping information. 0 - deliver via UDP'
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
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
      - id: channel_id
        type: u1
        doc: 'The ID of the multicast channel over which the packet was sent'
  request_response_message:
    seq:
      - id: request_seq_num
        type: u4
        doc: 'The sequence number of the request message sent by the client'
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
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
      - id: product_id
        type: u1
        doc: 'The unique ID for this NYSE feed listed in the feed''s client specification'
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
        doc: 'The ID of the client requesting this retransmission. All trailing characters should be NULL'
  options_quote_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: ask_price
        type: s4
        doc: 'The Ask price. Use the Price scale from the Series Index message. Implied decimal with scale 1e-8'
      - id: ask_volume
        type: u4
        doc: 'Total quantity available at the above Ask price'
      - id: bid_price
        type: s4
        doc: 'The Bid price. Use the Price scale from the Series Index message. Implied decimal with scale 1e-8'
      - id: bid_volume
        type: u4
        doc: 'Total quantity available at the above Bid price'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: ask_customer_volume
        type: u4
        doc: 'Total quantity of customer orders at the Ask price'
      - id: bid_customer_volume
        type: u4
        doc: 'Total quantity of customer orders at the Bid price'
  options_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price of the Trade. Use the Price scale from the series index mapping. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The volume of the trade in contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'Settlement related conditions'
      - id: trade_cond_2
        type: u1
        enum: trade_cond_2
        doc: 'Trade through exemption conditions'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: trade_cond_4
        type: u1
        enum: trade_cond_4
        doc: 'Additional trade conditions'
  options_trade_cancel_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: original_trade_id
        type: u4
        doc: 'The original TradeID of the Trade being cancelled'
  options_trade_correction_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: original_trade_id
        type: u4
        doc: 'The original TradeID of the Trade being cancelled'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price of the Trade. Use the Price scale from the series index mapping. Implied decimal with scale 1e-8'
      - id: volume
        type: u4
        doc: 'The volume of the trade in contracts'
      - id: trade_cond_1
        type: u1
        enum: trade_cond_1
        doc: 'Settlement related conditions'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: reserved_1_2
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: reserved_1_3
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
  options_imbalance_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: reserved_4
        type: u4
        doc: 'Reserved for future use'
      - id: paired_qty
        type: u4
        doc: 'The number of contracts paired off at the Indicative Match Price'
      - id: total_imbalance_qty
        type: u4
        doc: 'The total imbalance quantity at the Indicative Match Price'
      - id: market_imbalance_qty
        type: u4
        doc: 'The total market order imbalance quantity at the Indicative Match Price'
      - id: reserved_2
        type: u2
        doc: 'Reserved for future use'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction type indicator'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'The side of the TotalImbalanceQty'
      - id: continuous_book_clearing_price
        type: s4
        doc: 'The price at which all interest on the book can trade, including auction and imbalance offset interest, and disregarding auction collars. Implied decimal with scale 1e-8'
      - id: auction_interest_clearing_price
        type: s4
        doc: 'The price at which all eligible auction-only interest would trade, subject to auction collars. Implied decimal with scale 1e-8'
      - id: reserved_4_2
        type: u4
        doc: 'Reserved for future use'
      - id: indicative_match_price
        type: s4
        doc: 'The price at which the highest number of contracts would trade, subject to auction collars. It includes the non-displayed quantity of Reserve Orders. Implied decimal with scale 1e-8'
      - id: upper_collar
        type: s4
        doc: 'Legal width bid for option'
      - id: lower_collar
        type: s4
        doc: 'Legal width offer for option'
      - id: auction_status
        type: u1
        enum: auction_status
        doc: 'Indicates whether the auction will run'
  series_rfq_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: series_seq_num
        type: u4
        doc: 'The series sequence number'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the RFQ'
      - id: type
        type: u1
        enum: type
        doc: 'Order Type of CUBE/BOLD/COA'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Customer or Firm capacity specified with the order. This field is only used for BOLD (Type = B)'
      - id: total_quantity
        type: u4
        doc: 'Total quantity'
      - id: working_price
        type: s4
        doc: 'RFQ Price. Implied decimal with scale 1e-8'
      - id: participant
        type: u4
        doc: 'OCC Number for the Clearing firm specified with the order. 0 when no OCC Number was specified. This field is only used for BOLD (Type = B)'
      - id: auction_id
        type: u8
        doc: 'Auction ID for CUBE/COA'
      - id: rfq_status
        type: u1
        enum: rfq_status
        doc: 'This status field is used for CUBE/COA (Type = C)'
  outright_series_summary_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset (UTC Time) from the Time Reference message'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series within this market'
      - id: high_price
        type: s4
        doc: 'The Highest price of the series for the day. Use the Price scale from the series mapping index. Implied decimal with scale 1e-8'
      - id: low_price
        type: s4
        doc: 'The Lowest price of the series for the day. Use the Price scale from the series mapping index. Implied decimal with scale 1e-8'
      - id: open
        type: s4
        doc: 'The First price of the series for the day. Use the Price scale from the series mapping index'
      - id: close
        type: s4
        doc: 'The Last price of the series for the day. Use the Price scale from the series index mapping'
      - id: total_volume
        type: u4
        doc: 'The cumulative volume for the outright series throughout the day'

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
      doc: 'Sent to reset the Message Sequence Number at start of day, or in response to failure recoveries.'
    2:
      id: 'source_time_reference_message'
      doc: 'Sent at the start of every second during periods of active data publication.'
    3:
      id: 'symbol_index_mapping_message'
      doc: 'Published over the real-time data channels at system startup or in the context of a refresh sequence. Provides referential data for a single specified symbol or underlying symbol.'
    32:
      id: 'symbol_clear_message'
      doc: 'In case of a failure and recovery, the publisher may send a full state refresh for every symbol or series affected, preceded by a Symbol Clear message.'
    34:
      id: 'security_status_message'
      doc: 'Informs clients of changes in the status of a specific security or underlying symbol, such as Trading Halts, Short Sale Restriction state changes, etc.'
    50:
      id: 'outright_series_index_mapping_message'
      doc: 'Published over the real-time data channels at system startup or in the context of a refresh sequence. Provides referential data for a single specified options outright series.'
    51:
      id: 'options_status_message'
      doc: 'Informs clients of changes in the status of a specific option outright series and complex series, such as Trading Halts.'
    60:
      id: 'complex_series_index_mapping_message'
      doc: 'Published over the real-time data channels at system startup or in the context of a refresh sequence. Provides referential data for a single specified options complex series.'
    10:
      id: 'retransmission_request_message'
      doc: 'Sent by clients via TCP/IP to request retransmission of missed messages.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels.'
    15:
      id: 'refresh_request_message'
      doc: 'Sent by clients via TCP/IP to request a refresh of the state of one or all symbols in a specific channel.'
    13:
      id: 'symbol_index_mapping_request_message'
      doc: 'Sent by clients via TCP/IP requesting the Symbol Index Mapping messages for one or all symbols in a specified channel.'
    31:
      id: 'message_unavailable_message'
      doc: 'Sent over the Retransmission multicast channels to inform clients of unavailability of a range of messages.'
    11:
      id: 'request_response_message'
      doc: 'Sent immediately via TCP/IP in response to the client''s request for retransmission, refresh or Symbol Mapping messages.'
    12:
      id: 'heartbeat_response_message'
      doc: 'Clients who remain connected to the Retransmission Server intraday must respond to a Heartbeat with a Heartbeat Response message within 5 seconds.'
    340:
      id: 'options_quote_message'
      doc: 'An Options quote message is sent when any event results in a new top of book value on either side of the market.'
    320:
      id: 'options_trade_message'
      doc: 'An Options Trade message is sent when there is an execution on the order book.'
    321:
      id: 'options_trade_cancel_message'
      doc: 'In the event that an earlier trade has been reported in error, an Options Trade Cancel message is sent.'
    322:
      id: 'options_trade_correction_message'
      doc: 'In the event that an earlier trade has been reported with one or multiple fields in error, an Options Trade Correction message is sent.'
    305:
      id: 'options_imbalance_message'
      doc: 'Options Imbalance messages are published every 5 seconds during opening and reopening auctions to update price and volume information.'
    307:
      id: 'series_rfq_message'
      doc: 'The Request for Series RFQ message is published for outright series. It is generated by the matching engine to solicit interest in an auction or order.'
    323:
      id: 'outright_series_summary_message'
      doc: 'The outright series summary message is sent every 60 seconds, on a separate multicast channel from the main feed.'
  market_id:
    1:
      id: 'nyse_equities'
      doc: 'Nyse Equities'
    3:
      id: 'nyse_arca_equities'
      doc: 'Nyse Arca Equities'
    4:
      id: 'nyse_arca_options'
      doc: 'Nyse Arca Options'
    8:
      id: 'nyse_american_options'
      doc: 'Nyse American Options'
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
    0x20:
      id: 'otc_or_index_based_product_space_or_0_x_20'
      doc: 'Otc Or Index Based Product Space Or 0 X 20'
  price_scale_code:
    6:
      id: 'low_priced_securities'
      doc: 'Low Priced Securities'
    4:
      id: 'medium_priced_securities'
      doc: 'Medium Priced Securities'
    3:
      id: 'high_priced_securities'
      doc: 'High Priced Securities'
  security_type:
    0x41:
      id: 'american_depositary_receipts'
      doc: 'American Depositary Receipts'
    0x43:
      id: 'common_stock'
      doc: 'Common Stock'
    0x44:
      id: 'debentures'
      doc: 'Debentures'
    0x45:
      id: 'exchange_traded_funds'
      doc: 'Exchange Traded Funds'
    0x46:
      id: 'foreign'
      doc: 'Foreign'
    0x48:
      id: 'american_depositary_shares'
      doc: 'American Depositary Shares'
    0x49:
      id: 'units'
      doc: 'Units'
    0x4c:
      id: 'index_linked_notes'
      doc: 'Index Linked Notes'
    0x4d:
      id: 'other_blank'
      doc: 'Other Blank'
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
      id: 'shares_of_beneficial_interest'
      doc: 'Shares Of Beneficial Interest'
    0x54:
      id: 'test'
      doc: 'Test'
    0x55:
      id: 'closed_end_fund'
      doc: 'Closed End Fund'
    0x57:
      id: 'warrants'
      doc: 'Warrants'
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
  security_status:
    0x34:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x35:
      id: 'resume'
      doc: 'Resume'
    0x36:
      id: 'suspend'
      doc: 'Suspend'
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
      id: 'late_session'
      doc: 'Late Session'
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
      id: 'news_released'
      doc: 'News Released'
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
      id: 'additional_information_requested'
      doc: 'Additional Information Requested'
    0x43:
      id: 'regulatory_concern'
      doc: 'Regulatory Concern'
    0x45:
      id: 'merger_effective'
      doc: 'Merger Effective'
    0x46:
      id: 'etf_component_prices_not_available'
      doc: 'Etf Component Prices Not Available'
    0x4e:
      id: 'corporate_action'
      doc: 'Corporate Action'
    0x4f:
      id: 'new_security_offering'
      doc: 'New Security Offering'
    0x56:
      id: 'intraday_indicative_value_not_available'
      doc: 'Intraday Indicative Value Not Available'
    0x36:
      id: 'suspend'
      doc: 'Suspend'
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
    0x20:
      id: 'na_space_or_0_x_20'
      doc: 'Na Space Or 0 X 20'
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
    0x47:
      id: 'value_x47'
      doc: '24 X'
    0x49:
      id: 'ise'
      doc: 'Ise'
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
      id: 'cboe_byx'
      doc: 'Cboe Byx'
    0x5a:
      id: 'cboe_bzx'
      doc: 'Cboe Bzx'
    0x48:
      id: 'miax'
      doc: 'Miax'
    0x55:
      id: 'memx'
      doc: 'Memx'
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
  series_type:
    0:
      id: 'standard'
      doc: 'Standard'
    1:
      id: 'flex'
      doc: 'Flex'
    2:
      id: 'flex_percentage'
      doc: 'Flex Percentage'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  closing_only_indicator:
    0x30:
      id: 'standard_series'
      doc: 'Standard Series'
    0x31:
      id: 'closing_only_series'
      doc: 'Closing Only Series'
  series_status:
    0x34:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x35:
      id: 'resume'
      doc: 'Resume'
    0x36:
      id: 'suspend'
      doc: 'Suspend'
    0x50:
      id: 'preopening'
      doc: 'Preopening'
    0x42:
      id: 'begin_accepting_orders'
      doc: 'Begin Accepting Orders'
    0x4f:
      id: 'core_session'
      doc: 'Core Session'
    0x58:
      id: 'closed'
      doc: 'Closed'
  options_status_halt_condition:
    0x7e:
      id: 'series_not_delayedhalted'
      doc: 'Series Not Delayedhalted'
    0x68:
      id: 'option_series_is_halted'
      doc: 'Option Series Is Halted'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  leg_security_type:
    0x4f:
      id: 'options_series_leg'
      doc: 'Options Series Leg'
    0x45:
      id: 'equity_stock_leg'
      doc: 'Equity Stock Leg'
    0x46:
      id: 'options_flex_leg'
      doc: 'Options Flex Leg'
  retransmit_method:
    0:
      id: 'deliver_via_udp'
      doc: 'Deliver Via Udp'
  status:
    0x30:
      id: 'message_was_accepted'
      doc: 'Message Was Accepted'
    0x31:
      id: 'rejected_due_to_an_invalid_source_id'
      doc: 'Rejected Due To An Invalid Source Id'
    0x33:
      id: 'rejected_due_to_maximum_sequence_range'
      doc: 'Rejected Due To Maximum Sequence Range'
    0x34:
      id: 'rejected_due_to_maximum_request_in_a_day'
      doc: 'Rejected Due To Maximum Request In A Day'
    0x35:
      id: 'rejected_due_to_maximum_number_of_refresh_requests_in_a_day'
      doc: 'Rejected Due To Maximum Number Of Refresh Requests In A Day'
    0x36:
      id: 'rejected_request_message_seq_num_ttl_is_too_old'
      doc: 'Rejected Request Message Seq Num Ttl Is Too Old'
    0x37:
      id: 'rejected_due_to_an_invalid_channel_id'
      doc: 'Rejected Due To An Invalid Channel Id'
    0x38:
      id: 'rejected_due_to_an_invalid_product_id'
      doc: 'Rejected Due To An Invalid Product Id'
    0x39:
      id: 'rejected_due_to_invalid_msg_type_or_mismatch_between_msg_type_and_msg_size'
      doc: 'Rejected Due To Invalid Msg Type Or Mismatch Between Msg Type And Msg Size'
  quote_condition:
    0x31:
      id: 'regular_trading'
      doc: 'Regular Trading'
    0x33:
      id: 'trading_halted'
      doc: 'Trading Halted'
  trade_cond_1:
    0x61:
      id: 'outright_series_cube_order_trade'
      doc: 'Outright Series Cube Order Trade'
    0x63:
      id: 'outright_series_qcc_order_or_customer_to_customer_cross_order'
      doc: 'Outright Series Qcc Order Or Customer To Customer Cross Order'
    0x65:
      id: 'outright_series_floor_trade'
      doc: 'Outright Series Floor Trade'
    0x49:
      id: 'all_outright_series_electronic_trades'
      doc: 'All Outright Series Electronic Trades'
    0x53:
      id: 'intermarket_sweep_order'
      doc: 'Intermarket Sweep Order'
    0x66:
      id: 'complex_order_trades_not_part_of_cubeqc_celectronic_with_outright'
      doc: 'Complex Order Trades Not Part Of Cubeqc Celectronic With Outright'
    0x67:
      id: 'complex_cube_order_trade'
      doc: 'Complex Cube Order Trade'
    0x68:
      id: 'complex_qcc_order_or_customer_to_customer_cross_order'
      doc: 'Complex Qcc Order Or Customer To Customer Cross Order'
    0x69:
      id: 'complex_order_to_complex_order_floor_trade'
      doc: 'Complex Order To Complex Order Floor Trade'
    0x6a:
      id: 'complex_order_trading_electronically_with_outright_series'
      doc: 'Complex Order Trading Electronically With Outright Series'
    0x6d:
      id: 'complex_order_to_outright_series_order_floor_trade'
      doc: 'Complex Order To Outright Series Order Floor Trade'
    0x70:
      id: 'complex_order_with_stock_to_complex_order_with_stock_floor_trade'
      doc: 'Complex Order With Stock To Complex Order With Stock Floor Trade'
    0x73:
      id: 'complex_order_with_stock_to_outright_series_order_floor_trade'
      doc: 'Complex Order With Stock To Outright Series Order Floor Trade'
    0x48:
      id: 'late_report_of_opening_trade_correct_sequence'
      doc: 'Late Report Of Opening Trade Correct Sequence'
    0x46:
      id: 'late_report_of_opening_trade_out_of_sequence'
      doc: 'Late Report Of Opening Trade Out Of Sequence'
    0x44:
      id: 'transaction_reported_late_correct_sequence'
      doc: 'Transaction Reported Late Correct Sequence'
    0x42:
      id: 'transaction_reported_late_out_of_sequence'
      doc: 'Transaction Reported Late Out Of Sequence'
  trade_cond_2:
    0x20:
      id: 'na'
      doc: 'Na'
    0x4f:
      id: 'market_center_opening_trade'
      doc: 'Market Center Opening Trade'
    0x35:
      id: 'reopening_trade'
      doc: 'Reopening Trade'
  trade_cond_4:
    0x20:
      id: 'na'
      doc: 'Na'
    0x51:
      id: 'official_open_price'
      doc: 'Official Open Price'
  auction_type:
    0x4d:
      id: 'core_opening_auction'
      doc: 'Core Opening Auction'
    0x48:
      id: 'reopening_auction_halt_resume'
      doc: 'Reopening Auction Halt Resume'
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
      id: 'will_run_as_usual'
      doc: 'Will Run As Usual'
    4:
      id: 'auction_will_not_run_because_legal_width_quote_does_not_exist'
      doc: 'Auction Will Not Run Because Legal Width Quote Does Not Exist'
    5:
      id: 'auction_will_not_run_because_market_maker_quote_is_not_received'
      doc: 'Auction Will Not Run Because Market Maker Quote Is Not Received'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  type:
    0x42:
      id: 'bold_outright_only'
      doc: 'Bold Outright Only'
    0x43:
      id: 'coa_complex_only'
      doc: 'Coa Complex Only'
    0x46:
      id: 'flex_price_improvement_cube'
      doc: 'Flex Price Improvement Cube'
    0x4c:
      id: 'flex_aon_solicitation_cube'
      doc: 'Flex Aon Solicitation Cube'
    0x50:
      id: 'price_improvement_cube'
      doc: 'Price Improvement Cube'
    0x53:
      id: 'aon_solicitation_cube'
      doc: 'Aon Solicitation Cube'
  capacity:
    0x20:
      id: 'na'
      doc: 'Na'
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
    0x35:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x38:
      id: 'professional_customer'
      doc: 'Professional Customer'
  rfq_status:
    0x4f:
      id: 'start_of_rfq_auction'
      doc: 'Start Of Rfq Auction'
    0x51:
      id: 'end_of_rfq_auction'
      doc: 'End Of Rfq Auction'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: New York Stock Exchange
#   Version: 1.2.j
#   Date: 11/18/2025
#   Specification: PILLAR_TOP_Client_Specification.pdf
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
