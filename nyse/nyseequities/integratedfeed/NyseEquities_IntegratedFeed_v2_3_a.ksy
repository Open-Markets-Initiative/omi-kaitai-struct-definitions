# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities IntegratedFeed Xdp v2.3.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Integrated Feed
#   Encoding: Exchange Data Publisher
#   Version: 2.3.a
#   Date: 10/25/2019
#   Specification: XDP_Integrated_Feed_Client_Specification_v2.3a.pdf
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
  id: nyse_nyseequities_integratedfeed_xdp_v2_3_a
  title: Nyse NyseEquities IntegratedFeed Xdp v2.3.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Integrated Feed Xdp v2.3.a'
doc-ref: https://www.nyse.com/market-data/real-time/integrated-feed

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
            'message_type::retransmission_request_message': retransmission_request_message
            'message_type::request_response_message': request_response_message
            'message_type::heartbeat_response_message': heartbeat_response_message
            'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
            'message_type::refresh_request_message': refresh_request_message
            'message_type::message_unavailable_message': message_unavailable_message
            'message_type::symbol_clear_message': symbol_clear_message
            'message_type::security_status_message': security_status_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::replace_order_message': replace_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::cross_trade_message': cross_trade_message
            'message_type::cross_correction_message': cross_correction_message
            'message_type::retail_price_improvement_message': retail_price_improvement_message
            'message_type::add_order_refresh_message': add_order_refresh_message
            'message_type::imbalance_message': imbalance_message
            'message_type::order_execution_message': order_execution_message
            'message_type::non_displayed_trade_message': non_displayed_trade_message
            'message_type::stock_summary_message': stock_summary_message
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
  source_time_reference_message:
    seq:
      - id: id
        type: u4
        doc: 'ID of the originating Matching Engine partition to which this message applies'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
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
      - id: reserved_1
        size: 1
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
      - id: reserved_2
        size: 2
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
  symbol_clear_message:
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
  security_status_message:
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
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: security_status
        type: u1
        enum: security_status
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'Halt condition indicator'
      - id: reserved_4
        size: 4
        doc: 'Future use. Any field content should be ignored'
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
        type: str
        size: 1
        encoding: ASCII
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
  add_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order. Valid values: ‘B’ – Buy ‘S’ – Sell'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant’s firm ID. Blank-filled if a firm ID was not specified'
      - id: num_parity_splits
        type: u1
        doc: 'Resulting number of splits at this price level Defaulted to 0. Future use by NYSE only'
  modify_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: position_change
        type: u1
        enum: position_change
        doc: 'Currently defaulted to 0'
      - id: prev_price_parity_splits
        type: u1
        doc: 'Resulting number of splits at the previous price Defaulted to 0. Future use by NYSE only'
      - id: new_price_parity_splits
        type: u1
        doc: 'Resulting number of splits at the new price. Defaulted to 0. Future use by NYSE only'
  replace_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: new_order_id
        type: u8
        doc: 'The new Order ID of the replacement order'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: prev_price_parity_splits
        type: u1
        doc: 'Resulting number of splits at the previous price Defaulted to 0. Future use by NYSE only'
      - id: new_price_parity_splits
        type: u1
        doc: 'Resulting number of splits at the new price. Defaulted to 0. Future use by NYSE only'
  delete_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: num_parity_splits
        type: u1
        doc: 'Resulting number of splits at this price level Defaulted to 0. Future use by NYSE only'
  trade_cancel_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: trade_id
        type: u4
        doc: 'The TradeID of the original Trade or Execution message to be cancelled'
  cross_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: cross_id
        type: u4
        doc: 'Unique identifier for this Cross Trade. Used in Cross Correction message to identify the Cross Trade to correct'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Reason for the crossing auction'
  cross_correction_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: cross_id
        type: u4
        doc: 'Unique identifier for this Cross Trade. Used in Cross Correction message to identify the Cross Trade to correct'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
  retail_price_improvement_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: rpi_indicator
        type: u1
        enum: rpi_indicator
        doc: 'The side(s) where Retail Price Improvement orders (RPI orders) exist'
  add_order_refresh_message:
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
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order. Valid values: ‘B’ – Buy ‘S’ – Sell'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant’s firm ID. Blank-filled if a firm ID was not specified'
      - id: num_parity_splits
        type: u1
        doc: 'Resulting number of splits at this price level Defaulted to 0. Future use by NYSE only'
  imbalance_message:
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
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: reference_price
        type: u4
        doc: 'For Pillar-powered markets, the Reference Price is used to calculate the Indicative Match Price. For NYSE Tape A symbols, the Reference Price is the Last Sale if the last sale is at or between the current best quote'
      - id: paired_qty
        type: u4
        doc: 'For Pillar-powered markets, the number of shares paired off at the Indicative Match Price. For NYSE, the number of shares paired off at the Reference Price, truncated to the nearest round lot quantity'
      - id: total_imbalance_qty
        type: u4
        doc: 'For Pillar-powered markets, the total imbalance quantity at the Indicative Match Price. For NYSE, the total imbalance quantity at the Reference Price, truncated to the round lot'
      - id: market_imbalance_qty
        type: u4
        doc: 'For Pillar-powered markets, the total market order imbalance quantity at the Indicative Match Price'
      - id: auction_time
        type: u2
        doc: 'Projected Auction Time (hhmm)'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of auction'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'The side of the TotalImbalanceQty'
      - id: continuous_book_clearing_price
        type: u4
        doc: 'For Pillar-powered markets, the price at which all interest on the book can trade, including auction and imbalance offset interest, and disregarding auction collars. For NYSE, the indicative matching price, i.e. the price closest to the reference price where the imbalance is 0. If a continuous book clearing price is not reached, it is defaulted to 0'
      - id: closing_only_clearing_price
        type: u4
        doc: 'For Pillar-powered markets, the price at which all eligible auction-only interest would trade, subject to auction collars For NYSE, the price closest to the reference price where the imbalance of closing-only interest is 0. If a closing-only clearing price is not reached, it is defaulted to 0'
      - id: ssr_filing_price
        type: u4
        doc: 'For Pillar-powered markets, not supported and defaulted to 0. For NYSE, the price at which Sell Short interest in the opening auction will be filed if a Sell Short Restriction is in effect for the security'
      - id: indicative_match_price
        type: u4
        doc: 'For Pillar-powered markets, the price that has the highest executable volume of auction-eligible shares, subject to auction collars. It includes the non-displayed quantity of Reserve Orders'
      - id: upper_collar
        type: u4
        doc: 'If the IndicativeMatchPrice is not strictly between the UpperCollar and the LowerCollar, special auction rules apply. See Rule 7.35P for details'
      - id: lower_collar
        type: u4
        doc: 'If the IndicativeMatchPrice is not strictly between the UpperCollar and the LowerCollar, special auction rules apply. See Rule 7.35P for details'
      - id: auction_status
        type: u1
        enum: auction_status
        doc: 'Indicates whether the auction will run'
      - id: freeze_status
        type: u1
        enum: freeze_status
        doc: 'Freeze status code'
      - id: num_extensions
        type: u1
        doc: 'Number of times the halt period has been extended'
  order_execution_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this message to the gateway Order Report'
      - id: trade_id
        type: u4
        doc: 'The TradeID of the original Trade or Execution message to be cancelled'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: printable_flag
        type: u1
        enum: printable_flag
        doc: 'Printable flag values'
      - id: num_parity_splits
        type: u1
        doc: 'Resulting number of splits at this price level Defaulted to 0. Future use by NYSE only'
      - id: db_exec_id
        type: u4
        doc: 'For Pillar-powered markets, unused, defaulted to 0. For NYSE Tape A symbols, DB ExecID is assigned by the matching engine to all orders that participated in this trade event'
  non_displayed_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: symbol_index
        type: u4
        doc: 'The unique ID of this symbol for all products within this market. This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'Reserved for future use. Ignore any content. This usage will become standard across all products in future releases'
      - id: trade_id
        type: u4
        doc: 'The TradeID of the original Trade or Execution message to be cancelled'
      - id: price
        type: u4
        doc: 'The order price. Use with the Price Scale from the symbol-mapping index'
      - id: volume
        type: u4
        doc: 'The order quantity in shares'
      - id: printable_flag
        type: u1
        enum: printable_flag
        doc: 'Printable flag values'
      - id: db_exec_id
        type: u4
        doc: 'For Pillar-powered markets, unused, defaulted to 0. For NYSE Tape A symbols, DB ExecID is assigned by the matching engine to all orders that participated in this trade event'
  stock_summary_message:
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
        doc: 'The exchange high price of this stock for the day. Use the Price Scale in the symbol index msg'
      - id: low_price
        type: u4
        doc: 'The exchange Low price of this stock for the day. Use the Price Scale in the symbol index msg'
      - id: open
        type: u4
        doc: 'The exchange Opening price of this stock for the day. Use the Price Scale in the symbol index msg'
      - id: close
        type: u4
        doc: 'The exchange Closing price of this stock for the day. Use the Price Scale in the symbol index msg'
      - id: total_volume
        type: u4
        doc: 'The exchange cumulative volume for the stock throughout the day'

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
      doc: 'This message is sent at the start of every second during periods of active data publication.'
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
      id: 'symbol_clear_message'
      doc: 'In case of a failure and recovery of a Matching Engine or an XDP Publisher, the publisher may send a full state refresh for every symbol affected. This kind of unrequested refresh is preceded by a Symbol Clear message. The client should react to receipt of a Symbol Clear message by clearing all state information for the specified symbol in anticipation of receiving a full state refresh.'
    34:
      id: 'security_status_message'
      doc: 'This message informs clients of changes in the status of a specific security, such as Trading Halts, Short Sale Restriction state changes, etc.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels is of this type.'
    100:
      id: 'add_order_message'
      doc: 'An Add Order message is published when a new visible order has been received and added to the book. The Order ID is assigned by the matching engine and is good for today only. It is unique across all markets, except that for NYSE Tape A symbols, it is only unique per matching engine instance.'
    101:
      id: 'modify_order_message'
      doc: 'A Modify Order message is sent when the price or volume of an order is changed due to an event other than a cancel-replace, or full or partial execution. The content of the price and volume fields represent the new values after modification.'
    104:
      id: 'replace_order_message'
      doc: 'A Replace Order message is published when a cancel/replace order is received and executed. The sitting order is replaced with a new one containing the same symbol, side and attribution, a new Order ID, and the price and size specified. The sitting order must be removed from the book and replaced with the new order.'
    102:
      id: 'delete_order_message'
      doc: 'A Delete Order message is published when an order is taken off of the book for any reason except for full execution, in which case an Order Execution message is sent.'
    112:
      id: 'trade_cancel_message'
      doc: 'In the event that an earlier trade has been reported in error, a Trade Cancel message is sent. This occurs whether the initial report was an Order Execution or a Non-Displayed Trade message.'
    111:
      id: 'cross_trade_message'
      doc: 'A Cross Trade message is published on completion of a crossing auction, and shows the bulk volume that traded in the auction. The Reason Code field indicates the auction type. Additionally, a non-printable Order Execution or Trade message will be published for each order that traded.'
    113:
      id: 'cross_correction_message'
      doc: 'In the event that an earlier Cross Trade has been reported in error, a Cross Correction message is sent.'
    114:
      id: 'retail_price_improvement_message'
      doc: 'Published when RPI interest (hidden retail price improvement interest) is added or removed between the best bid and best offer price. When all RPI interest for this security is removed from the book, An RPI message with RPIIndicator = '' '' (space character) is published.'
    106:
      id: 'add_order_refresh_message'
      doc: 'The Add Order Refresh message can be sent in either of two contexts: 1) If a client sends a Refresh Request to the Request Controller, an Add Order Refresh message is sent over the Refresh channels as part of the refresh response for every order currently sitting on the book. 2) If NYSE Operations refreshes a symbol, a Symbol Clear message is published, followed by a full refresh. The refresh includes an Add Order Refresh message for every order currently sitting on the book of the symbol.'
    105:
      id: 'imbalance_message'
      doc: 'Imbalance messages are sent periodically during auctions to update price and volume information. If there is no change to the calculated fields, no message will be generated.'
    103:
      id: 'order_execution_message'
      doc: 'An Order Execution message is sent when an order is partially or fully executed.'
    110:
      id: 'non_displayed_trade_message'
      doc: 'An Non Displayed Trade message is sent as a result of a match between two non-displayed orders.'
    223:
      id: 'stock_summary_message'
      doc: 'On a separate channel from the main feed, the Stock Summary channel, a Stock Summary message per symbol is sent every 60 seconds. The message is sent regardless of whether there has been a change to the symbol in the last 60 seconds or not.'
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
      id: 'nyse_american_equities'
      doc: 'Nyse American Equities'
    10:
      id: 'nyse_national_equities'
      doc: 'Nyse National Equities'
  exchange_code:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
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
      id: 'bats'
      doc: 'Bats'
    0x42:
      id: 'global_otc'
      doc: 'Global Otc Primary Symbols'
    0x55:
      id: 'otcbb'
      doc: 'Otcbb Symbols'
  security_type:
    0x41:
      id: 'common_stock'
      doc: 'Common Stock'
    0x42:
      id: 'preferred_stock'
      doc: 'Preferred Stock'
    0x43:
      id: 'warrant'
      doc: 'Warrant'
    0x44:
      id: 'right'
      doc: 'Right'
    0x45:
      id: 'corporate_bond'
      doc: 'Corporate Bond'
    0x46:
      id: 'treasury_bond'
      doc: 'Treasury Bond'
    0x47:
      id: 'structured_product'
      doc: 'Structured Product'
    0x48:
      id: 'adr_common'
      doc: 'Adr Common'
    0x49:
      id: 'adr_preferred'
      doc: 'Adr Preferred'
    0x4a:
      id: 'adr_warrants'
      doc: 'Adr Warrants'
    0x4b:
      id: 'adr_rights'
      doc: 'Adr Rights'
    0x4c:
      id: 'adr_corporate_bond'
      doc: 'Adr Corporate Bond'
    0x4d:
      id: 'ny_registered_share'
      doc: 'Ny Registered Share'
    0x4e:
      id: 'global_registered_share'
      doc: 'Global Registered Share'
    0x4f:
      id: 'index'
      doc: 'Index'
    0x50:
      id: 'fund'
      doc: 'Fund'
    0x51:
      id: 'basket'
      doc: 'Basket'
    0x52:
      id: 'unit'
      doc: 'Unit'
    0x53:
      id: 'liquidating_trust'
      doc: 'Liquidating Trust'
    0x55:
      id: 'unknown'
      doc: 'Unknown'
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
      id: 'invalid_msg_type_or_msg_size_mismatch'
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
      id: 'not_delayedhalted_nyse_tape_a_only'
      doc: 'Not Delayedhalted Nyse Tape A Only'
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
      id: 'luld_pause'
      doc: 'Luld Pause'
    0x53:
      id: 'related_security_not_used'
      doc: 'Related Security Not Used'
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
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  position_change:
    0:
      id: 'kept'
      doc: 'Kept Position In Book'
    1:
      id: 'lost'
      doc: 'Lost Position In Book'
  cross_type:
    0x45:
      id: 'early_opening'
      doc: 'Market Center Early Opening Auction'
    0x4f:
      id: 'opening'
      doc: 'Market Center Opening Auction'
    0x35:
      id: 'reopening'
      doc: 'Market Center Reopening Auction'
    0x36:
      id: 'closing'
      doc: 'Market Center Closing Auction'
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
  auction_type:
    0x4f:
      id: 'early_opening'
      doc: 'Early Opening Auction Non Nyse Only'
    0x4d:
      id: 'core_opening'
      doc: 'Core Opening Auction'
    0x48:
      id: 'reopening'
      doc: 'Reopening Auction Halt Resume'
    0x43:
      id: 'closing'
      doc: 'Closing Auction'
    0x52:
      id: 'regulatory_imbalance'
      doc: 'Regulatory Imbalance Nyse Only'
  imbalance_side:
    0x20:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  auction_status:
    0:
      id: 'will_run_open_close'
      doc: 'Will Run As Always For Open And Close'
    1:
      id: 'will_run_interest'
      doc: 'Will Run Interest Exists Inside Or At The Collars Or Is Fully Paired Off'
    2:
      id: 'will_not_run_imbalance'
      doc: 'Will Not Run Because There Is An Imbalance Through The Collars'
    3:
      id: 'will_not_run_transition_to_closing'
      doc: 'Will Not Run Will Transition To The Closing Auction Instead'
  freeze_status:
    0:
      id: 'no_imbalance_freeze'
      doc: 'Imbalance Freeze Not Yet In Effect'
    1:
      id: 'imbalance_freeze'
      doc: 'Imbalance Freeze Is In Effect'
  printable_flag:
    0:
      id: 'not_printed'
      doc: 'Not Printed To The Sip'
    1:
      id: 'printed'
      doc: 'Printed To The Sip'

