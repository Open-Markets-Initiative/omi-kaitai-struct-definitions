# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse ArcaOptions DeepFeed Pillar v1.2.f
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Deep Feed
#   Encoding: Pillar
#   Version: 1.2.f
#   Date: 04/29/2022
#   Specification: PILLAR_DEEP_Client_Specification.pdf
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
  id: nyse_arcaoptions_deepfeed_pillar_v1_2_f
  title: Nyse ArcaOptions DeepFeed Pillar v1.2.f
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange Nyse Arca Options Deep Feed Pillar v1.2.f'
doc-ref: https://www.nyse.com/market-data/real-time/options-deep-feed

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
            'message_type::time_reference_message': time_reference_message
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
            'message_type::outright_series_index_mapping': outright_series_index_mapping
            'message_type::options_status_message': options_status_message
            'message_type::options_add_order_message': options_add_order_message
            'message_type::options_modify_order_message': options_modify_order_message
            'message_type::options_delete_order_message': options_delete_order_message
            'message_type::options_order_execution_message': options_order_execution_message
            'message_type::options_replace_order_message': options_replace_order_message
            'message_type::options_imbalance_message': options_imbalance_message
            'message_type::options_add_order_refresh_message': options_add_order_refresh_message
            'message_type::options_series_rfq_message': options_series_rfq_message
            'message_type::options_non_displayed_trade_message': options_non_displayed_trade_message
            'message_type::options_cross_trade_message': options_cross_trade_message
            'message_type::options_trade_cancel_message': options_trade_cancel_message
            'message_type::options_outright_series_summary_message': options_outright_series_summary_message
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
  time_reference_message:
    seq:
      - id: id
        type: u4
        doc: 'ID of the originating Matching Engine partition to which this message applies'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
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
        enum: price_scale_code
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
      - id: reserved_6
        size: 6
        doc: 'Reserved for future use'
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
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
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
        doc: 'Reserved for future use'
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
        doc: 'Unused'
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
  outright_series_index_mapping:
    seq:
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
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
        doc: 'Root symbol for options in OCC symbology'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'Underlying symbol for options in NYSE symbology'
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
        doc: 'Option Type'
      - id: strike_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Strike price'
      - id: closing_only_indicator
        type: u1
        enum: closing_only_indicator
        doc: 'Closing Only Indicator'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
  options_status_message:
    seq:
      - id: source_time
        type: u4
        doc: 'The time when this msg was generated in the order book, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: series_status
        type: u1
        enum: series_status
        doc: 'The new status that this series is transitioning to'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The current Market State, which this msg updates if the Security Status field contains a Market State Code'
      - id: halt_condition
        type: u1
        enum: halt_condition
        doc: 'Halt condition indicator'
  options_add_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant’s firm ID'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
      - id: cust_indicator
        type: u1
        enum: cust_indicator
        doc: 'Capacity of the order:'
  options_modify_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: position_change
        type: u1
        doc: 'position change'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: cust_indicator
        type: u1
        enum: cust_indicator
        doc: 'Capacity of the order:'
  options_delete_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
  options_order_execution_message:
    seq:
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
  options_replace_order_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: new_order_id
        type: u8
        doc: 'The new Order ID of the replacement order'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
      - id: cust_indicator
        type: u1
        enum: cust_indicator
        doc: 'Capacity of the order:'
  options_imbalance_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: reserved_4
        size: 4
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
        size: 2
        doc: 'Reserved for Future use'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of Auction'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'The side of the TotalImbalanceQty'
      - id: continuous_book_clearing_price
        type: s4
        doc: 'The price at which all interest on the book can trade, including auction and imbalance offset interest, and disregarding auction collars'
      - id: auction_interest_clearing_price
        type: s4
        doc: 'The price at which all eligible auction-only interest would trade, subject to auction collars'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: indicative_match_price
        type: s4
        doc: 'The price at which the highest number of contracts would trade, subject to auction collars. It includes the non-displayed quantity of Reserve Orders. See Information on Auctions for details'
      - id: upper_collar
        type: s4
        doc: 'Legal width bid for option'
      - id: lower_collar
        type: s4
        doc: 'Legal width offer for option'
      - id: auction_status
        type: u1
        enum: auction_status
        doc: 'Indicates the Auction Status:'
  options_add_order_refresh_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: order_id
        type: u8
        doc: 'The unique ID assigned by the matching engine to this order . Can be used to match this order to the gateway Order Report'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: firm_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'The market participant’s firm ID'
      - id: reserved_1
        size: 1
        doc: 'This field is reserved for future use'
      - id: cust_indicator
        type: u1
        enum: cust_indicator
        doc: 'Capacity of the order:'
  options_series_rfq_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order'
      - id: type_field
        type: u1
        enum: type_field
        doc: 'Order Type of CUBE/Bold/COA'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Customer or Firm capacity specified with the order. Values include:'
      - id: total_quantity
        type: u4
        doc: 'Total quantity'
      - id: working_price
        type: s4
        doc: 'RFQ Price'
      - id: participant
        type: u4
        doc: 'OCC Number for the Clearing firm specified with the order'
      - id: auction_id
        type: u8
        doc: 'Auction ID for CUBE/COA'
      - id: rfq_status
        type: u1
        enum: rfq_status
        doc: 'This status field is used for CUBE/COA'
  options_non_displayed_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: trade_id
        type: u4
        doc: 'Unique ID assigned by the matching engine to this trade event. Used by any subsequent Trade Cancel message to identify this execution. Can be matched to the Deal ID field in the gateway Execution Report'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: printable_flag
        type: u1
        enum: printable_flag
        doc: 'PrintableFlag'
      - id: trade_cond_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Valid values:'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future use'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'PriceType'
  options_cross_trade_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: cross_id
        type: u4
        doc: 'Unique identifier for this Cross Trade. Used in Cross Correction message to identify the Cross Trade to correct'
      - id: price
        type: s4
        doc: 'The order price. Use with the Price Scale from the series index mapping'
      - id: volume
        type: u4
        doc: 'The order quantity in contracts'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Reason for the crossing from the opening and re-opening auction. Valid values:'
  options_trade_cancel_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: series_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific series'
      - id: trade_id
        type: u4
        doc: 'Unique ID assigned by the matching engine to this trade event. Used by any subsequent Trade Cancel message to identify this execution. Can be matched to the Deal ID field in the gateway Execution Report'
  options_outright_series_summary_message:
    seq:
      - id: source_time_ns
        type: u4
        doc: 'The nanosecond offset from the SourceTime'
      - id: series_index
        type: u4
        doc: 'The unique ID of this series for all products within this market'
      - id: high_price
        type: s4
        doc: 'The Highest price of the series for the day. Use the Price scale from the series index mapping'
      - id: low_price
        type: s4
        doc: 'The Lowest price of the series for the day. Use the Price scale from the series index mapping'
      - id: open
        type: s4
        doc: 'The First price of the series for the day. Use the Price scale from the series index mapping'
      - id: close
        type: s4
        doc: 'The Last price of the series for the day. Use the Price scale from the series index mapping'
      - id: total_volume
        type: u4
        doc: 'The cumulative volume for the series throughout the day'
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
      id: 'time_reference_message'
      doc: 'This message is sent at the start of every second during periods of active data publication'
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
    50:
      id: 'outright_series_index_mapping'
      doc: 'This message is published over the real-time data channels at system startup or in the context of a refresh sequence after a Matching Engine or PILLAR Publisher failover.'
    51:
      id: 'options_status_message'
      doc: 'This message informs clients of changes in the status of a specific option outright series and complex series'
    300:
      id: 'options_add_order_message'
      doc: 'An Options Add Order message is published when a new visible order has been received and added to the book.'
    301:
      id: 'options_modify_order_message'
      doc: 'An Options Modify Order message is sent when the price or volume of an order is changed due to an event other than a cancel-replace, or full or partial execution.'
    302:
      id: 'options_delete_order_message'
      doc: 'An Options Modify Order message is sent when the price or volume of an order is changed due to an event other than a cancel-replace, or full or partial execution.'
    303:
      id: 'options_order_execution_message'
      doc: 'An Options Order Execution message is sent when an order is partially or fully executed.'
    304:
      id: 'options_replace_order_message'
      doc: 'An Options Replace Order message is published when a cancel/replace order is received.'
    305:
      id: 'options_imbalance_message'
      doc: 'Options Imbalance messages are published once a second during opening and re-opening auctions to update price and volume information.'
    306:
      id: 'options_add_order_refresh_message'
      doc: 'See the Pillar Common Client Specification for details on Time Reference and Symbol/Series Index Mapping messages, and Order ID and Price field formats.'
    307:
      id: 'options_series_rfq_message'
      doc: 'The Request for outright series RFQ data is published for outright series.'
    310:
      id: 'options_non_displayed_trade_message'
      doc: 'An Options Non Displayed Trade message is published as a result of a match between two non-displayed orders.'
    311:
      id: 'options_cross_trade_message'
      doc: 'An Options Cross Trade message is published on completion of a crossing from the opening and re-opening auction, and shows the bulk volume that traded in the auction. The Cross Type field indicates the auction type. Additionally, a non-printable Order Execution or Non-Displayed Trade message will be published for each order that traded.'
    312:
      id: 'options_trade_cancel_message'
      doc: 'In the event that an earlier trade has been reported in error, an Options Trade Cancel message is published.'
    323:
      id: 'options_outright_series_summary_message'
      doc: 'The outright series summary message is published every 60 seconds, on a separate multicast channel from the main feed.'
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
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
  exchange_code:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
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
      id: 'otc_or_indexed_product'
      doc: 'Otc Or Indexed Product'
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
  status:
    0x30:
      id: 'accepted'
      doc: 'Message Was Accepted'
    0x31:
      id: 'rejected'
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
      id: 'invalid_msg_type_or_msg_size'
      doc: 'Rejected Due To 1 Invalid Msg Type Or 2 Mismatch Between Msg Type And Msg Size'
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
      id: 'security_not_delayed_or_halted'
      doc: 'Security Not Delayed Or Halted'
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
      id: 'cboe_edgx'
      doc: 'Cboe Edgx'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
    0x4d:
      id: 'nyse_chicago'
      doc: 'Nyse Chicago'
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
      id: 'late_session'
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
      id: 'call'
      doc: 'Call'
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
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  cust_indicator:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x4e:
      id: 'noncustomer'
      doc: 'Noncustomer'
    0x44:
      id: 'derived'
      doc: 'Derived'
  auction_type:
    0x6d:
      id: 'core_opening_auction'
      doc: 'Core Opening Auction'
    0x68:
      id: 'reopening_auction'
      doc: 'Reopening Auction'
  imbalance_side:
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
    0x2d:
      id: 'indicates_no_imbalance'
      doc: 'Indicates No Imbalance'
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
  type_field:
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement'
    0x46:
      id: 'facilitation'
      doc: 'Facilitation'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x42:
      id: 'bold'
      doc: 'Bold'
    0x43:
      id: 'coa'
      doc: 'Coa'
  capacity:
    0x20:
      id: 'not_specified'
      doc: 'Not Specified'
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
  rfq_status:
    0x4f:
      id: 'start'
      doc: 'Start Of Rfq Auction'
    0x51:
      id: 'end'
      doc: 'End Of Rfq Auction'
  printable_flag:
    0:
      id: 'trade_not_included_in_total_volume'
      doc: 'Trade Not Included In Total Volume'
    1:
      id: 'trade_included_in_total_volume'
      doc: 'Trade Included In Total Volume'
  price_type:
    0:
      id: 'strike_price_is_amount'
      doc: 'Strike Price Is Amount'
    1:
      id: 'strike_price_is_amount_1'
      doc: 'Strike Price Is Amount'
  cross_type:
    0x30:
      id: 'market_center_opening_auction'
      doc: 'Market Center Opening Auction'
    0x35:
      id: 'market_center_reopening_auction'
      doc: 'Market Center Reopening Auction'

