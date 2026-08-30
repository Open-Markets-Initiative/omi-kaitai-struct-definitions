# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseEquities OpenBook Ultra v2.1.k
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Open Book
#   Encoding: Openbook Ultra
#   Version: 2.1.k
#   Date: 07/25/2024
#   Specification: OpenBook_Ultra_Client_Specification.pdf
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
  id: nyse_nyseequities_openbook_ultra_v2_1_k
  title: Nyse NyseEquities OpenBook Ultra v2.1.k
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange New York Stock Exchange Equities Open Book Ultra v2.1.k'
doc-ref: https://www.nyse.com/market-data/real-time/openbook-ultra

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'OpenBook Ultra packet header'
  - id: payload
    type:
      switch-on: packet_header.message_type
      cases:
        'message_type::sequence_number_reset_message': sequence_number_reset_message
        'message_type::unavailable_message': unavailable_message
        'message_type::request_response_message': request_response_message
        'message_type::retransmission_request_message': retransmission_request_message
        'message_type::book_refresh_request_message': book_refresh_request_message
        'message_type::heartbeat_response_message': heartbeat_response_message
        'message_type::extended_book_refresh_request_message': extended_book_refresh_request_message
        'message_type::symbol_index_mapping_request_message': symbol_index_mapping_request_message
        'message_type::symbol_index_mapping_response_message': symbol_index_mapping_response_message
        'message_type::full_update_message': full_update_message
        'message_type::delta_update_message': delta_update_message

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'The size of the packet in bytes, excluding these two bytes'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'This field identifies the type of message'
      - id: sequence_number
        type: u4
        doc: 'The packet sequence number. Incremented by 1 for each packet published in this channel except heartbeat packets'
      - id: timestamp
        type: u4
        doc: 'The time this packet was published, in milliseconds since midnight'
      - id: product_id
        type: u1
        enum: product_id
        doc: 'Product identifier'
      - id: retransmission_flag
        type: u1
        enum: retransmission_flag
        doc: 'Indicates whether this packet contains original, retransmitted, or refresh message'
      - id: message_count
        type: u1
        doc: 'The number of messages following this header in the packet'
      - id: link_flag
        type: u1
        doc: 'The sequence number of this packet in a refresh sequence. If RetransFlag is not 5 or 6, this field is set to 0'
  sequence_number_reset_message:
    seq:
      - id: next_seq_number
        type: u4le
        doc: 'The sequence number that will follow in the next packet. Always = 2'
  unavailable_message:
    seq:
      - id: begin_seq_num
        type: u4le
        doc: 'The beginning sequence number of the requested range of packets to be retransmitted'
      - id: end_seq_num
        type: u4le
        doc: 'The ending sequence number of the requested range of packets to be retransmitted'
  request_response_message:
    seq:
      - id: source_seq_num
        type: u4le
        doc: 'The sequence number assigned by the client to the original request. It is returned by NYSE in this message for the client''s identification purposes'
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
      - id: status
        type: u1
        enum: status
        doc: 'Status of the request'
      - id: reject_reason
        type: u1
        enum: reject_reason
        doc: 'The reason why the request was rejected'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        doc: 'Reserved for future use'
  retransmission_request_message:
    seq:
      - id: begin_seq_num
        type: u4le
        doc: 'The beginning sequence number of the requested range of packets to be retransmitted'
      - id: end_seq_num
        type: u4le
        doc: 'The ending sequence number of the requested range of packets to be retransmitted'
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
  book_refresh_request_message:
    seq:
      - id: symbol_16
        type: str
        size: 16
        encoding: ASCII
        doc: 'A sequence of characters representing the symbol, padded with NULLs'
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
  heartbeat_response_message:
    seq:
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
  extended_book_refresh_request_message:
    seq:
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
      - id: symbol_index
        type: u4le
        doc: 'The ID (from the last Full Refresh Update) of the symbol for which information is requested. 0 = Requesting all symbols in this channel'
      - id: msg_type
        type: u2le
        doc: 'Unused. Any content will be ignored'
  symbol_index_mapping_request_message:
    seq:
      - id: source_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'The ID of the client that sent the request, left justified and null padded'
      - id: symbol_index
        type: u4le
        doc: 'The ID (from the last Full Refresh Update) of the symbol for which information is requested. 0 = Requesting all symbols in this channel'
  symbol_index_mapping_response_message:
    seq:
      - id: symbol_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'The stock symbol in NYSE Symbology, right-padded with NULLs'
      - id: filler_1
        type: u1
        doc: 'Ignore any content'
      - id: symbol_index
        type: u4le
        doc: 'The ID (from the last Full Refresh Update) of the symbol for which information is requested. 0 = Requesting all symbols in this channel'
  full_update_message:
    seq:
      - id: num_full_price_point
        type: u2le
        doc: 'The number of bytes in this message including this field'
      - id: symbol_index
        type: u4le
        doc: 'The ID (from the last Full Refresh Update) of the symbol for which information is requested. 0 = Requesting all symbols in this channel'
      - id: source_time
        type: u4le
        doc: 'The time the event occurred in the matching engine, in milliseconds since midnight'
      - id: source_time_micro_secs
        type: u2le
        doc: 'The number of microseconds that have elapsed within the millisecond published in the SourceTime field'
      - id: symbol_seq_num
        type: u4le
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: source_session_id
        type: u1
        doc: 'Unused. Ignore any content'
      - id: symbol_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'The stock symbol in NYSE Symbology, right-padded with NULLs'
      - id: price_scale_code
        type: decimal_s1_8
        doc: 'The number of digits after the decimal place in all prices for this symbol. Implied decimal with scale 1e-8'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'The current quote condition for the symbol'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'The current trading status of the equity'
      - id: filler_1
        type: u1
        doc: 'Ignore any content'
      - id: mpv
        type: u2le
        doc: 'The minimum price variation, also known as Tick, the minimum amount by which prices can differ'
      - id: full_price_point
        type: full_price_point
        repeat: expr
        repeat-expr: num_full_price_point
        doc: 'Full Message Price Point'
  full_price_point:
    seq:
      - id: price_numerator
        type: decimal_s4_8
        doc: 'The price (numerator) of this price point. Use the PriceScaleCode to determine the true dollar value of the price point. Implied decimal with scale 1e-8'
      - id: volume
        type: u4le
        doc: 'The total interest quantity at this price point'
      - id: num_orders
        type: u2le
        doc: 'The number of orders at this price point'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order, Buy vs Sell'
      - id: filler_1
        type: u1
        doc: 'Ignore any content'
  delta_update_message:
    seq:
      - id: num_delta_price_point
        type: u2le
        doc: 'The number of bytes in this message including this field'
      - id: symbol_index
        type: u4le
        doc: 'The ID (from the last Full Refresh Update) of the symbol for which information is requested. 0 = Requesting all symbols in this channel'
      - id: source_time
        type: u4le
        doc: 'The time the event occurred in the matching engine, in milliseconds since midnight'
      - id: source_time_micro_secs
        type: u2le
        doc: 'The number of microseconds that have elapsed within the millisecond published in the SourceTime field'
      - id: source_seq_num
        type: u4le
        doc: 'The sequence number assigned by the client to the original request. It is returned by NYSE in this message for the client''s identification purposes'
      - id: source_session_id
        type: u1
        doc: 'Unused. Ignore any content'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'The current quote condition for the symbol'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'The current trading status of the equity'
      - id: price_scale_code
        type: decimal_s1_8
        doc: 'The number of digits after the decimal place in all prices for this symbol. Implied decimal with scale 1e-8'
      - id: delta_price_point
        type: delta_price_point
        repeat: expr
        repeat-expr: num_delta_price_point
        doc: 'Delta Message Price Point'
  delta_price_point:
    seq:
      - id: price_numerator
        type: decimal_s4_8
        doc: 'The price (numerator) of this price point. Use the PriceScaleCode to determine the true dollar value of the price point. Implied decimal with scale 1e-8'
      - id: volume
        type: u4le
        doc: 'The total interest quantity at this price point'
      - id: chg_qty
        type: u4le
        doc: 'The volume of the event taking place (i.e size of the order, cancel or execution)'
      - id: num_orders
        type: u2le
        doc: 'The number of orders at this price point'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order, Buy vs Sell'
      - id: reason_code
        type: u1
        enum: reason_code
        doc: 'This field identifies why the volume at the price point was modified'
      - id: link_id_1
        type: u4le
        doc: 'Unique ID for an execution. Correlates to the Deal ID in the gateway Execution Report msg'
      - id: link_id_2
        type: u4le
        doc: 'Unused. Ignore any content'
      - id: link_id_3
        type: u4le
        doc: 'Unused. Ignore any content'
  decimal_s1_8:
    seq:
      - id: mantissa
        type: s1
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s4_8:
    seq:
      - id: mantissa
        type: s4le
    instances:
      real:
        value: mantissa / 100000000.0

enums:
  message_type:
    1:
      id: 'sequence_number_reset_message'
      doc: 'This message is sent to reset the Packet Sequence Number.'
    2:
      id: 'heartbeat_message'
      doc: 'Ultra heartbeat message.'
    5:
      id: 'unavailable_message'
      doc: 'This message will be sent over the Retransmission multicast channels to inform the clients of unavailability of a range of messages for which they have requested a retransmission.'
    10:
      id: 'request_response_message'
      doc: 'This message will be sent immediately via TCP/IP in response to the client''s request for a retransmission, refresh, or Symbol Index information.'
    19:
      id: 'heartbeat_subscription_message'
      doc: 'Heartbeat Subscription message.'
    20:
      id: 'retransmission_request_message'
      doc: 'This message is sent by clients to request a retransmission of missed packets.'
    22:
      id: 'book_refresh_request_message'
      doc: 'This message is sent by clients requesting a full book refresh.'
    24:
      id: 'heartbeat_response_message'
      doc: 'Clients that remain connected to the Request server intraday must respond within 120 seconds to any heartbeat received with a single message of this type in its own packet.'
    27:
      id: 'extended_book_refresh_request_message'
      doc: 'The Extended Book Refresh Request message allows the client to request a refresh by symbol index as opposed to symbol, and to request a refresh of all symbols in a channel.'
    34:
      id: 'symbol_index_mapping_request_message'
      doc: 'This message is sent by clients requesting a refresh of Symbol Index mapping information only.'
    35:
      id: 'symbol_index_mapping_response_message'
      doc: 'This message is sent by the NYSE in response to a Symbol Index Request.'
    230:
      id: 'full_update_message'
      doc: 'This message contains the complete order book for a single symbol, with all price points, an aggregated quantity at each price point and symbol mapping information.'
    231:
      id: 'delta_update_message'
      doc: 'A Delta Update message is published in response to events that occur in the book such as interest being added, executions, cancellations and interest routed to a different market.'
  product_id:
    12:
      id: 'nyse_openbook_ultra'
      doc: 'NYSE OpenBook Ultra'
    62:
      id: 'nyse_american_openbook_ultra'
      doc: 'NYSE American OpenBook Ultra'
  retransmission_flag:
    1:
      id: 'original_packet'
      doc: 'Original packet'
    2:
      id: 'retransmitted_packet'
      doc: 'Retransmitted packet'
    5:
      id: 'refresh_packet'
      doc: 'Refresh packet with more to come'
    6:
      id: 'last_refresh_packet'
      doc: 'Last Refresh packet in a sequence'
  status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x52:
      id: 'rejected'
      doc: 'Rejected'
  reject_reason:
    0x30:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x31:
      id: 'rejected_due_to_permissions'
      doc: 'Rejected Due To Permissions'
    0x32:
      id: 'invalid_sequence_range_eg_low_high'
      doc: 'Invalid Sequence Range Eg Low High'
    0x33:
      id: 'exceeded_max_sequence_range_1000'
      doc: 'Exceeded Max Sequence Range 1000'
    0x34:
      id: 'exceeded_max_retrans_requests_in_a_day'
      doc: 'Exceeded Max Retrans Requests In A Day'
    0x35:
      id: 'exceeded_max_refresh_requests_in_a_day'
      doc: 'Exceeded Max Refresh Requests In A Day'
    0x36:
      id: 'rejected_requested_seqnum_1000000_packets_in_the_past_use_refresh_to_recover_current_state_if_necessary'
      doc: 'Rejected Requested Seqnum 1000000 Packets In The Past Use Refresh To Recover Current State If Necessary'
  quote_condition:
    0x20:
      id: 'no_special_quote_condition'
      doc: 'No Special Quote Condition'
    0x57:
      id: 'slow_quote'
      doc: 'Slow Quote'
  trading_status:
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
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
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x36:
      id: 'suspended'
      doc: 'Suspended'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  reason_code:
    0x4f:
      id: 'new_orderadditional_interest_added'
      doc: 'New Orderadditional Interest Added'
    0x43:
      id: 'cancel'
      doc: 'Cancel'
    0x45:
      id: 'execution'
      doc: 'Execution'
    0x58:
      id: 'multiple_events'
      doc: 'Multiple Events'

