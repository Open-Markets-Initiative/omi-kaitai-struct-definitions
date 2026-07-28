# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Nyse NyseEquities ImbalancesFeed v2.2.a
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: nyseequities_imbalancesfeed_v2_2_a
  title: Nyse NyseEquities ImbalancesFeed Xdp v2.2.a
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Imbalances Feed Xdp v2.2.a'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/XDP_Imbalances_Feed_Client_Specification_v2.2a.pdf

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
            'message_type::symbol_clear_message': symbol_clear_message
            'message_type::security_status_message': security_status_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::imbalance_message': imbalance_message
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
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
        doc: 'ID of the Originating Market'
      - id: system_id
        type: u1
        doc: 'ID of the Originating matching engine server'
      - id: exchange_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'For listed equity markets, the market where this symbol is listed'
      - id: price_scale_code
        type: u1
        doc: 'Specifies placement of the decimal point in price fields for this security'
      - id: security_type
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'All Penny, Penny/Nickel, Nickel/Dime'
      - id: round_lot
        type: str
        size: 1
        encoding: ASCII
        doc: 'Round Lots Accepted'
      - id: mpv
        type: u2
        doc: 'The minimum increment for a trade price, in 100ths of a cent.  Typically 1, or $0.0001, but for some Tick Pilot stocks, can be 500, or $0.05'
      - id: unit_of_trade
        type: u2
        doc: 'This field specifies the security Unit of Trade in shares.  Valid values are 1, 10, 50 and 100'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use.  Disregard any content'
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
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: security_status
        type: str
        size: 1
        encoding: ASCII
        doc: 'The new status that this security is transitioning to'
      - id: halt_condition
        type: str
        size: 1
        encoding: ASCII
        doc: 'Halt condition indicator'
      - id: reserved_4
        size: 4
        doc: 'Future use.  Any field content should be ignored'
      - id: price_1
        type: u4
        doc: 'Default value is 0'
      - id: price_2
        type: u4
        doc: 'Default value is 0'
      - id: ssr_triggering_exchange_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'This field is only populated when securityStatus = A and this security is listed on this exchange.  Otherwise it is defaulted to 0x20'
      - id: ssr_triggering_volume
        type: u4
        doc: 'This field is only populated when securityStatus = A and this security is listed on this exchange'
      - id: time
        type: u4
        doc: 'Format : HHMMSSmmm  (mmm = milliseconds)'
      - id: ssr_state
        type: str
        size: 1
        encoding: ASCII
        doc: 'The current SSR state, which this msg updates if the Security Status field contains an SSR Code.  Valid'
      - id: market_state
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'The unique ID of this symbol for all products within this market.  This ID cannot be used to cross reference a security between markets'
      - id: symbol_seq_num
        type: u4
        doc: 'The unique ID of this message in the sequence of messages published for this specific symbol'
      - id: reference_price
        type: u4
        doc: 'See Information on Auctions for details'
      - id: paired_qty
        type: u4
        doc: 'For Pillar-powered markets, the number of shares paired off at the Indicative Match Price. For NYSE,  the number of shares paired off at the Reference Price, truncated to the nearest round lot quantity'
      - id: total_imbalance_qty
        type: u4
        doc: 'For Pillar-powered markets, the total imbalance quantity at the Indicative Match Price.For NYSE, the total imbalance quantity at the Reference Price, truncated to the round lot'
      - id: market_imbalance_qty
        type: u4
        doc: 'For Pillar-powered markets, the total market order imbalance quantity at the Indicative Match Price.  For NYSE, unused and defaulted to 0'
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
        doc: 'Continuous book clearing price'
      - id: closing_only_clearing_price
        type: u4
        doc: 'Closing only clearing price'
      - id: ssr_filing_price
        type: u4
        doc: 'For NYSE, the price at which Sell Short interest in the opening auction will be filed if a Sell Short Restriction is in effect for the security'
      - id: indicative_match_price
        type: u4
        doc: 'For Pillar-powered markets, the price that has the highest executable volume of auction-eligible shares, subject to auction collars'
      - id: upper_collar
        type: u4
        doc: 'If the IndicativeMatchPrice is not strictly between the UpperCollar and the LowerCollar, special auction rules apply'
      - id: lower_collar
        type: u4
        doc: 'If the IndicativeMatchPrice is not strictly between the UpperCollar and the LowerCollar, special auction rules apply'
      - id: auction_status
        type: u1
        enum: auction_status
        doc: 'Indicates whether the auction will run'
      - id: freeze_status
        type: u1
        enum: freeze_status
        doc: 'Freeze status'
      - id: num_extensions
        type: u1
        doc: 'Number of times the halt period has been extended'
      - id: unpaired_qty
        type: u4
        doc: 'For NYSE only, during the ClosingAuction,the number of unpaired shares priced at or better than the Reference Price. For non-NYSE markets,0'
      - id: unpaired_side
        type: u1
        enum: unpaired_side
        doc: 'The side of the Unpaired Qty'
      - id: significant_imbalance
        type: u1
        enum: significant_imbalance
        doc: 'For Auction Types=C or P in NYSE-listed symbols. Using historical closing data for each symbol,NYSE will set this indicator if the Continuous Book Clearing Price is more than a ‘significant’ range away from the Reference Price'

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
      doc: 'This message is published over the real-time data channels at system startup or in the context of a refresh sequence after a Matching Engine or XDP Publisher failover.  It provides referential data for a single specified symbol.'
    10:
      id: 'retransmission_request_message'
      doc: 'Clients who have experienced a sequence number gap and need a retransmission of the missed messages should send a Retransmission Request message via TCP to the Request Controller. A Request Response message will be sent over the TCP connection back to the client, and if the request was valid, the requested message(s) will be re-published over the relevant Retransmission multicast channel.'
    11:
      id: 'request_response_message'
      doc: 'This message will be sent immediately via TCP/IP in response to the client’s request for retransmission, refresh or Symbol Mapping messages.'
    12:
      id: 'heartbeat_response_message'
      doc: 'Clients who remain connected to the Retransmission Server intraday must respond to a Heartbeat with a Heartbeat Response message within 5 seconds.  If no timely client response is received, the connection will be closed.'
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
      doc: 'In case of a failure and recovery of a Matching Engine or an XDP Publisher, the publisher may send a full state refresh for every symbol affected.  This kind of unrequested refresh is preceded by a Symbol Clear message.  The client should react to receipt of a Symbol Clear message by clearing all state information for the specified symbol in anticipation of receiving a full state refresh.'
    34:
      id: 'security_status_message'
      doc: 'This message informs clients of changes in the status of a specific security, such as Trading Halts, Short Sale Restriction state changes, etc.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels is of this type.'
    105:
      id: 'imbalance_message'
      doc: 'Imbalance messages are sent periodically during auctions to update price and volume information. If there is no change to the calculated fields, no message will be generated.'
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
  unpaired_side:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x42:
      id: 'buy_side'
      doc: 'Buy Side'
    0x53:
      id: 'sell_side'
      doc: 'Sell Side'
  significant_imbalance:
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x59:
      id: 'yes'
      doc: 'Yes'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: New York Stock Exchange
#   Version: 2.2.a
#   Date: 03/08/2019
#   Specification: XDP_Imbalances_Feed_Client_Specification_v2.2a.pdf
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
