# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaEquities Bqt Xdp v2.4.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Best Quote And Trade
#   Encoding: Exchange Data Publisher
#   Version: 2.4.a
#   Date: 03/05/2026
#   Specification: NYSE_BQT_Client_Specification.pdf
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
  id: nyse_arcaequities_bqt_xdp_v2_4_a
  title: Nyse ArcaEquities Bqt Xdp v2.4.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Equities Best Quote And Trade Xdp v2.4.a'
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
            'message_type::source_time_reference_message': source_time_reference_message
            'message_type::symbol_index_mapping_message': symbol_index_mapping_message
            'message_type::symbol_clear_message': symbol_clear_message
            'message_type::security_status_message': security_status_message
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
            'message_type::refresh_request_message': refresh_request_message
            'message_type::message_unavailable_message': message_unavailable_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::request_response_message': request_response_message
            'message_type::heartbeat_response_message': heartbeat_response_message
            'message_type::best_quotes_message': best_quotes_message
            'message_type::consolidated_single_sided_quote_message': consolidated_single_sided_quote_message
            'message_type::trf_fractional_trade_message': trf_fractional_trade_message
            'message_type::consolidated_trade_message': consolidated_trade_message
            'message_type::consolidated_trade_cancel_message': consolidated_trade_cancel_message
            'message_type::trf_fractional_trade_correction_message': trf_fractional_trade_correction_message
            'message_type::consolidated_trade_correction_message': consolidated_trade_correction_message
            'message_type::trf_fractional_prior_day_trade_message': trf_fractional_prior_day_trade_message
            'message_type::trf_fractional_prior_day_trade_cancel_message': trf_fractional_prior_day_trade_cancel_message
            'message_type::consolidated_fractional_stock_summary_message': consolidated_fractional_stock_summary_message
            'message_type::consolidated_fractional_volume_message': consolidated_fractional_volume_message
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
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
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
        doc: 'The symbol sequence number'
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
  symbol_index_mapping_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Null-terminated ASCII symbol in NYSE Symbology'
      - id: reserved_1
        type: u1
        doc: 'This field is reserved for future use'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
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
        type: u4
        doc: 'The previous day''s closing price for this security'
      - id: prev_close_volume
        type: u4
        doc: 'The previous day''s closing volume for the security'
      - id: price_resolution
        type: u1
        enum: price_resolution
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
      - id: reserved_2
        type: u2
        doc: 'Reserved for future use. Disregard any content'
  symbol_clear_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: next_source_seq_num
        type: u4
        doc: 'The sequence number in the next message for this symbol'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
  security_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The symbol sequence number'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'The halt or other condition associated with the security status change'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
      - id: reserved_2
        type: u2
        doc: 'Reserved for future use. Disregard any content'
      - id: price_1
        type: u4
        doc: 'Default value is 0. If securityStatus = A and this security is listed on this exchange, then this field is the SSR Triggering Trade Price. If securityStatus = G or I, then this field is the Indication Low Price'
      - id: price_2
        type: u4
        doc: 'Default value is 0. If securityStatus = G or I, then this field is the Indication High Price'
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
  symbol_index_mapping_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
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
        doc: 'The delivery method for the requested symbol index mapping information. Valid values: 0 - deliver via UDP'
  refresh_request_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
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
  best_quotes_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: ask_price
        type: s4
        doc: 'The Ask price. Use the Price scale from the symbol mapping index'
      - id: ask_volume
        type: u4
        doc: 'The Ask size'
      - id: bid_price
        type: s4
        doc: 'The Bid price. Use the Price scale from the symbol mapping index'
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
        type: retail_pricing_indicator
        doc: 'Retail Pricing Indicator'
      - id: market_id_of_best_ask
        type: u2
        doc: 'The ID of the Originating Market for the Best Ask'
      - id: market_id_of_best_bid
        type: u2
        doc: 'The ID of the Originating Market for the Best Bid'
  retail_pricing_indicator:
    seq:
      - id: retail_interest_on_the_bid_side
        type: b1
        doc: 'Retail Interest on the Bid side'
      - id: retail_interest_on_the_ask_side
        type: b1
        doc: 'Retail Interest on the Ask side'
      - id: reserved
        type: b6
        doc: 'Reserved'
  consolidated_single_sided_quote_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order - Buy/Sell'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition'
      - id: retail_pricing_indicator
        type: retail_pricing_indicator
        doc: 'Retail Pricing Indicator'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
  trf_fractional_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The symbol sequence number'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
      - id: fractional_volume
        type: u8
        doc: 'The volume of the trade in shares, inclusive of any fractional quantity. Implied scale is 6'
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
      - id: exec_day_time
        type: u4
        doc: 'The date and time when this Trade occurred at the participant firm, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: exec_day_time_ns
        type: u4
        doc: 'The nanosecond offset from the ExecutionDayTime'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
  consolidated_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
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
        doc: 'The ID of the Originating Market'
  consolidated_trade_cancel_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: original_trade_id
        type: u4
        doc: 'The original Trade ID of trade being cancelled'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
  trf_fractional_trade_correction_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The symbol sequence number'
      - id: original_trade_id
        type: u4
        doc: 'The original Trade ID of trade being cancelled'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
      - id: fractional_volume
        type: u8
        doc: 'The volume of the trade in shares, inclusive of any fractional quantity. Implied scale is 6'
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
      - id: exec_day_time
        type: u4
        doc: 'The date and time when this Trade occurred at the participant firm, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: exec_day_time_ns
        type: u4
        doc: 'The nanosecond offset from the ExecutionDayTime'
      - id: market_id
        type: u2
        enum: market_id
        doc: 'The ID of the Originating Market'
  consolidated_trade_correction_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: original_trade_id
        type: u4
        doc: 'The original Trade ID of trade being cancelled'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
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
        doc: 'The ID of the Originating Market'
  trf_fractional_prior_day_trade_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The symbol sequence number'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
      - id: fractional_volume
        type: u8
        doc: 'The volume of the trade in shares, inclusive of any fractional quantity. Implied scale is 6'
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
      - id: prior_day_time
        type: u4
        doc: 'The date and time when this Trade occurred at the participant firm, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: prior_day_time_ns
        type: u4
        doc: 'The nanosecond offset from the Prior Day Time'
  trf_fractional_prior_day_trade_cancel_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_num
        type: u4
        doc: 'The symbol sequence number'
      - id: trade_id
        type: u4
        doc: 'Unique identifier for this trade'
      - id: price
        type: s4
        doc: 'The price. Use the PriceScaleCode in the Symbol Mapping message'
      - id: fractional_volume
        type: u8
        doc: 'The volume of the trade in shares, inclusive of any fractional quantity. Implied scale is 6'
      - id: prior_day_time
        type: u4
        doc: 'The date and time when this Trade occurred at the participant firm, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: prior_day_time_ns
        type: u4
        doc: 'The nanosecond offset from the Prior Day Time'
  consolidated_fractional_stock_summary_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated by the NYSE Pillar TRF platform, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the Source Time'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: nyse_group_high_price
        type: s4
        doc: 'The High price of the stock for the day. Use the Price scale from the symbol mapping index'
      - id: nyse_group_low_price
        type: s4
        doc: 'The Low price of the stock for the day. Use the Price scale from the symbol mapping index'
      - id: primary_listing_market_official_open_price
        type: s4
        doc: 'The Opening price of the stock for the day received from the listing market'
      - id: fractional_nyse_group_volume
        type: u8
        doc: 'The cumulative volume for the stock during the day, inclusive of any fractional quantity. Implied scale is 6'
      - id: nyse_group_market_id_of_high_price
        type: u2
        doc: 'The ID of the Originating Market of the High Price'
      - id: nyse_group_market_id_of_low_price
        type: u2
        doc: 'The ID of the Originating Market of the Low Price'
      - id: market_id_of_open_price
        type: u2
        doc: 'The ID of the Originating Market of the Open Price'
      - id: num_close_prices
        type: u1
        doc: 'The number of Market ID/Official Close Price pairs. Values can be 0 - 1'
      - id: nyse_group_market_id_of_the_close
        type: u2
        doc: 'The ID of the Originating Market of the Close Price'
      - id: primary_listing_market_official_close_price
        type: s4
        doc: 'The Official Close Price of the stock for the originating market captured in the preceding Market ID field'
      - id: consolidated_high_price
        type: s4
        doc: 'The highest price of any high/low eligible transaction on Tapes A, B or C received on the trading day'
      - id: consolidated_low_price
        type: s4
        doc: 'The lowest price of any high/low eligible transaction on Tapes A, B or C received on the trading day'
      - id: consolidated_first_price
        type: s4
        doc: 'The price of the first last sale eligible transaction on Tapes A, B, or C received on the trading day'
      - id: consolidated_last_price
        type: s4
        doc: 'The price of the final last sale eligible transaction on Tapes A, B, or C received on the trading day'
      - id: complete
        type: u1
        enum: complete
        doc: 'Data completeness indicator'
  consolidated_fractional_volume_message:
    seq:
      - id: symbol_index
        type: u4
        doc: 'The unique ID of the symbol in the Symbol Index msg'
      - id: symbol_seq_number
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: fractional_consolidated_volume
        type: u8
        doc: 'The cumulative volume for the stock throughout the day, inclusive of any fractional quantity. Implied scale is 6'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for this update'
      - id: complete
        type: u1
        enum: complete
        doc: 'Data completeness indicator'

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
    10:
      id: 'retransmission_request_message'
      doc: 'Clients who have experienced a sequence number gap and need a retransmission of the missed messages should send a Retransmission Request message via TCP to the Request Controller.'
    13:
      id: 'symbol_index_mapping_request_message'
      doc: 'This message is sent by clients via TCP/IP requesting the Symbol Index Mapping messages for one or all symbols in a specified channel.'
    15:
      id: 'refresh_request_message'
      doc: 'Clients who have experienced a failure and need a refresh of the state of one or all symbols in a specific channel should send a Refresh Request message via TCP to the Request Controller.'
    31:
      id: 'message_unavailable_message'
      doc: 'This message will be sent over the Retransmission multicast channels to inform clients of unavailability of a range of messages (or part of a range) for which they may have requested a retransmission.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels is of this type.'
    11:
      id: 'request_response_message'
      doc: 'This message will be sent immediately via TCP/IP in response to the client''s request for retransmission, refresh or Symbol Mapping messages.'
    12:
      id: 'heartbeat_response_message'
      doc: 'Clients who remain connected to the Retransmission Server intraday must respond to a Heartbeat with a Heartbeat Response message within 5 seconds. If no timely client response is received, the connection will be closed.'
    142:
      id: 'best_quotes_message'
      doc: 'This message is sent when an event causes a change in one or both sides of the BBO.'
    143:
      id: 'consolidated_single_sided_quote_message'
      doc: 'This message is sent when an event causes a change in only one side of a BBO.'
    210:
      id: 'trf_fractional_trade_message'
      doc: 'TRF Fractional Trade Message'
    220:
      id: 'consolidated_trade_message'
      doc: 'Consolidated Trade Message'
    221:
      id: 'consolidated_trade_cancel_message'
      doc: 'This message is published when a trade is cancelled.'
    212:
      id: 'trf_fractional_trade_correction_message'
      doc: 'TRF Fractional Trade Correction Message'
    222:
      id: 'consolidated_trade_correction_message'
      doc: 'This message is published when a trade is corrected.'
    213:
      id: 'trf_fractional_prior_day_trade_message'
      doc: 'TRF Fractional Prior Day Trade Message'
    214:
      id: 'trf_fractional_prior_day_trade_cancel_message'
      doc: 'TRF Fractional Prior Day Trade Cancel Message'
    202:
      id: 'consolidated_fractional_stock_summary_message'
      doc: 'The stock summary message is sent every 1 minute, after a security is Open.'
    201:
      id: 'consolidated_fractional_volume_message'
      doc: 'Consolidated Fractional Volume Message'
  market_id:
    1:
      id: 'nyse'
      doc: 'Nyse Equities'
    3:
      id: 'nyse_arca'
      doc: 'Nyse Arca Equities'
    4:
      id: 'nyse_arca_options'
      doc: 'Nyse Arca Options'
    5:
      id: 'nyse_bonds'
      doc: 'Nyse Bonds'
    8:
      id: 'nyse_american_options'
      doc: 'Nyse American Options'
    9:
      id: 'nyse_american'
      doc: 'Nyse American Equities'
    10:
      id: 'nyse_national'
      doc: 'Nyse National Equities'
    11:
      id: 'nyse_texas'
      doc: 'Nyse Texas Equities'
    0:
      id: 'nyse_group_bqt'
      doc: 'Nyse Group Bqt'
    255:
      id: 'nyse_trf'
      doc: 'Nyse Trf'
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
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
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
      id: 'n_24_x'
      doc: 'N 24 X'
    0x48:
      id: 'miami_pearl'
      doc: 'Miami Pearl'
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
  status:
    0x30:
      id: 'message_was_accepted'
      doc: 'Message Was Accepted'
    0x31:
      id: 'rejected_due_to_an_invalid_source_id'
      doc: 'Rejected Due To An Invalid Source Id'
    0x33:
      id: 'rejected_due_to_maximum_sequence_range_see_threshold_limits'
      doc: 'Rejected Due To Maximum Sequence Range See Threshold Limits'
    0x34:
      id: 'rejected_due_to_maximum_request_in_a_day'
      doc: 'Rejected Due To Maximum Request In A Day'
    0x35:
      id: 'rejected_due_to_maximum_number_of_refresh_requests_in_a_day'
      doc: 'Rejected Due To Maximum Number Of Refresh Requests In A Day'
    0x36:
      id: 'rejected_request_message_seq_num_ttl_time_to_live_is_too_old_use_refresh_to_recover_current_state_if_necessary'
      doc: 'Rejected Request Message Seq Num Ttl Time To Live Is Too Old Use Refresh To Recover Current State If Necessary'
    0x37:
      id: 'rejected_due_to_an_invalid_channel_id'
      doc: 'Rejected Due To An Invalid Channel Id'
    0x38:
      id: 'rejected_due_to_an_invalid_product_id'
      doc: 'Rejected Due To An Invalid Product Id'
    0x39:
      id: 'rejected_due_to_1_invalid_msg_type_or_2_mismatch_between_msg_type_and_msg_size'
      doc: 'Rejected Due To 1 Invalid Msg Type Or 2 Mismatch Between Msg Type And Msg Size'
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
      id: 'slow_on_the_bid_and_ask_due_to_set_slow_list'
      doc: 'Slow On The Bid And Ask Due To Set Slow List'
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
      id: 'slow_on_the_bid_and_ask_due_to_set_slow_list'
      doc: 'Slow On The Bid And Ask Due To Set Slow List'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell_offer'
      doc: 'Sell Offer'
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
      id: 'slow_on_the_bid_and_ask_due_to_set_slow_list'
      doc: 'Slow On The Bid And Ask Due To Set Slow List'
  trade_cond_1:
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x20:
      id: 'regular_sale_trf_only'
      doc: 'Regular Sale Trf Only'
    0x43:
      id: 'cash_trf_or_texas_only'
      doc: 'Cash Trf Or Texas Only'
    0x52:
      id: 'seller_trf_only'
      doc: 'Seller Trf Only'
  trade_cond_2:
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
      id: 'derivatively_priced_trf_only'
      doc: 'Derivatively Priced Trf Only'
    0x35:
      id: 'reopening_trade'
      doc: 'Reopening Trade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'Market Center Closing Trade'
    0x37:
      id: 'qualified_contingent_trade_trf_or_texas_only'
      doc: 'Qualified Contingent Trade Trf Or Texas Only'
    0x39:
      id: 'corrected_consolidated_close'
      doc: 'Corrected Consolidated Close'
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
    0x4d:
      id: 'official_closing_price'
      doc: 'Official Closing Price'
    0x51:
      id: 'official_open_price'
      doc: 'Official Open Price'
    0x56:
      id: 'contingent_trade_trf_or_texas_only'
      doc: 'Contingent Trade Trf Or Texas Only'
    0x50:
      id: 'prior_reference_price_trf_only'
      doc: 'Prior Reference Price Trf Only'
    0x57:
      id: 'weighted_average_price_trf_only'
      doc: 'Weighted Average Price Trf Only'
  trade_condition_1:
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x20:
      id: 'regular_sale_for_trf'
      doc: 'Regular Sale For Trf'
    0x43:
      id: 'cash_trf_or_texas_only'
      doc: 'Cash Trf Or Texas Only'
    0x52:
      id: 'seller_trf_only'
      doc: 'Seller Trf Only'
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
      id: 'derivatively_priced_trf_only'
      doc: 'Derivatively Priced Trf Only'
    0x35:
      id: 'market_center_reopening_trade'
      doc: 'Market Center Reopening Trade'
    0x36:
      id: 'market_center_closing_trade'
      doc: 'Market Center Closing Trade'
    0x37:
      id: 'qualified_contingent_trade_trf_or_texas_only'
      doc: 'Qualified Contingent Trade Trf Or Texas Only'
    0x39:
      id: 'corrected_last_sale_price'
      doc: 'Corrected Last Sale Price'
  trade_condition_3:
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
  trade_condition_4:
    0x40:
      id: 'regular_sale'
      doc: 'Regular Sale'
    0x20:
      id: 'na'
      doc: 'Na'
    0x49:
      id: 'odd_lot_trade'
      doc: 'Odd Lot Trade'
    0x4d:
      id: 'official_closing_price'
      doc: 'Official Closing Price'
    0x51:
      id: 'official_open_price'
      doc: 'Official Open Price'
    0x56:
      id: 'contingent_trade_trf_or_texas_only'
      doc: 'Contingent Trade Trf Or Texas Only'
    0x50:
      id: 'prior_reference_price_trf_only'
      doc: 'Prior Reference Price Trf Only'
    0x57:
      id: 'weighted_average_price_trf_only'
      doc: 'Weighted Average Price Trf Only'
  complete:
    0:
      id: 'normal_data_is_complete'
      doc: 'Normal Data Is Complete'
    1:
      id: 'an_unrecoverable_gap_was_experienced_in_the_input_stream_so_data_may_not_be_complete'
      doc: 'An Unrecoverable Gap Was Experienced In The Input Stream So Data May Not Be Complete'
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

