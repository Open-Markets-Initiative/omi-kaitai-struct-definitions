# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities Bbo Xdp v2.4.g
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Best Bid And Offer
#   Encoding: Exchange Data Publisher
#   Version: 2.4.g
#   Date: 01/29/2018
#   Specification: XDP_BBO_Client_Specification_V2.4c.pdf
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
  id: nyseequities_bbo_v2_4_g
  title: Nyse NyseEquities Bbo Xdp v2.4.g
  license: GPL-3.0
  endian: le

doc: 'New York Stock Exchange New York Stock Exchange Equities Best Bid And Offer Xdp v2.4.g'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/XDP_BBO_Client_Specification_V2.4c.pdf

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
            'message_type::trading_session_change_message': trading_session_change_message
            'message_type::security_status_message': security_status_message
            'message_type::refresh_header_message': refresh_header_message
            'message_type::quote_message': quote_message
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
        doc: 'All Penny, Penny/Nickel, Nickel/Dime'
      - id: round_lot
        type: str
        size: 1
        encoding: ASCII
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
  trading_session_change_message:
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
      - id: trading_session
        type: u1
        doc: 'Trading session value'
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'The current SSR state, which this msg updates if the Security Status field contains an SSR Code. Valid'
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
  quote_message:
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
      - id: ask_price
        type: u4
        doc: 'The Ask price. Use the Price scale from the Symbol Index message'
      - id: ask_volume
        type: u4
        doc: 'The aggregate round lot size at the ask price, in shares'
      - id: bid_price
        type: u4
        doc: 'The Bid price. Use the Price scale from the Symbol Index message'
      - id: bid_volume
        type: u4
        doc: 'The aggregate round lot size at the bid price, in shares'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition values. For markets other than NYSE, only condition R is applicable'
      - id: rpi_indicator
        type: u1
        enum: rpi_indicator
        doc: 'The side(s) where Retail Price Indication orders (RPI orders) exist'

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
    33:
      id: 'trading_session_change_message'
      doc: 'This message announces the start of a new trading session for a specified symbol.'
    34:
      id: 'security_status_message'
      doc: 'This message informs clients of changes in the status of a specific security, such as Trading Halts, Short Sale Restriction state changes, etc.'
    35:
      id: 'refresh_header_message'
      doc: 'The first message in each packet of refresh messages published over the Refresh multicast channels is of this type.'
    140:
      id: 'quote_message'
      doc: 'A quote message is sent when any event results in a new top of book value on either side of the market.'
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
  quote_condition:
    0x43:
      id: 'closing'
      doc: 'Closing Value'
    0x4f:
      id: 'opening_quote'
      doc: 'Opening Quote Value'
    0x52:
      id: 'regular_quote'
      doc: 'Regular Quote Value'
    0x57:
      id: 'slow_on_the_bid_and_ask'
      doc: 'Slow On The Bid And Ask This Symbol Is On The Set Slow List'
  rpi_indicator:
    0x20:
      id: 'no_retail_interest'
      doc: 'Space Means No Retail Interest Default'
    0x41:
      id: 'retail_interest_on_bid_side'
      doc: 'Retail Interest On Bid Side'
    0x42:
      id: 'retail_interest_on_offer_side'
      doc: 'Retail Interest On Offer Side'
    0x43:
      id: 'retail_interest_on_the_bid_and_offer_side'
      doc: 'Retail Interest On The Bid And Offer Side'

