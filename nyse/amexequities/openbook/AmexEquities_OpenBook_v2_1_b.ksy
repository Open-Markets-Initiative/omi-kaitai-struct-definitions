# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse AmexEquities OpenBook Ultra v2.1.b
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Open Book
#   Encoding: Openbook Ultra
#   Version: 2.1.b
#   Date: 03/9/2018
#   Specification: OpenBook_Ultra_Client_Spec_v2.1b.pdf
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
  id: nyse_amexequities_openbook_ultra_v2_1_b
  title: Nyse AmexEquities OpenBook Ultra v2.1.b
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange Nyse Amex Equities Open Book Ultra v2.1.b'
doc-ref: https://www.nyse.com/market-data/real-time/openbook-ultra

seq:
  - id: packet_header
    type: packet_header_struct
  - id: payload
    type:
      switch-on: packet_header.message_type
      cases:
        'message_type::full_update_message': full_update_messages
        'message_type::delta_update_message': delta_update_messages
        'message_type::sequence_number_reset_message': sequence_number_reset_message

types:
  packet_header_struct:
    seq:
      - id: packet_size
        type: u2
        doc: 'The size of the packet in bytes, including this 16 byte packet header'
      - id: message_type
        type: u2
        enum: message_type
        doc: 'The type of this message'
      - id: sequence_number
        type: u4
        doc: 'The message sequence number of the first message in this packet'
      - id: timestamp
        type: u4
        doc: 'The time when this packet was published to the multicast channel, in seconds since Jan 1, 1970 00:00:00 UTC'
      - id: product_id
        type: u1
        doc: 'The nanosecond offset from the Send Time'
      - id: retransmission_flag
        type: u1
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
      - id: message_count
        type: u1
        doc: 'The number of messages in this packet'
      - id: link_flag
        type: u1
        doc: 'A flag that indicates whether this is an original, retransmitted, or ‘replayed’ message'
  full_update_messages:
    seq:
      - id: full_update_message
        type: full_update_message
        repeat: eos
  full_update_message:
    seq:
      - id: update_size
        type: s2
        doc: 'The number of bytes in this message including this field'
      - id: symbol_index
        type: s4
        doc: 'The ID of this symbol used in other message types'
      - id: source_time
        type: s4
        doc: 'The time the event occurred in the matching engine, in milliseconds since midnight'
      - id: source_time_micro_secs
        type: s2
        doc: 'The number of microseconds that have elapsed within the millisecond published in the SourceTime field. If the ME event occurred at 13:12:56, 170 millisecs and 30 microsecs, this field will contain 30'
      - id: symbol_seq_num
        type: s4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: source_session_id
        type: s1
        doc: 'Unused. Ignore any content'
      - id: symbol
        type: str
        size: 11
        encoding: ASCII
        doc: 'The stock symbol in NYSE Symbology the root, optionally followed by a space and a suffix), right-padded with NULLs'
      - id: price_scale_code
        type: s1
        doc: 'The number of digits after the decimal place in all prices for this symbol'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'The current quote condition for the symbol'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'The current trading status of the equity'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: mpv
        type: s2
        doc: 'The minimum price variation, also known as Tick, the minimum amount by which prices can differ'
      - id: full_price_point
        type: full_price_point
        repeat: eos
  full_price_point:
    seq:
      - id: price_numerator
        type: s4
        doc: 'The price (numerator) of this price point. Use the PriceScaleCode to determine the true dollar value of the price point'
      - id: volume
        type: s4
        doc: 'The total interest quantity at this price point'
      - id: num_orders
        type: s2
        doc: 'The number of orders at this price point'
      - id: side
        type: u1
        enum: side
        doc: 'The side of the order, Buy vs Sell'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
  delta_update_messages:
    seq:
      - id: delta_update_message
        type: delta_update_message
        repeat: eos
  delta_update_message:
    seq:
      - id: delta_size
        type: s2
        doc: 'The number of bytes in this message including this field'
      - id: symbol_index
        type: s4
        doc: 'The ID of this symbol used in other message types'
      - id: source_time
        type: s4
        doc: 'The time the event occurred in the matching engine, in milliseconds since midnight'
      - id: source_time_micro_secs
        type: s2
        doc: 'The number of microseconds that have elapsed within the millisecond published in the SourceTime field. If the ME event occurred at 13:12:56, 170 millisecs and 30 microsecs, this field will contain 30'
      - id: source_seq_num
        type: s4
        doc: 'The sequence number of this message in the set of all messages for this symbol'
      - id: source_session_id
        type: s1
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
        type: s1
        doc: 'The number of digits after the decimal place in all prices for this symbol'
      - id: delta_price_point
        type: delta_price_point
        repeat: eos
  delta_price_point:
    seq:
      - id: price_numerator
        type: s4
        doc: 'The price (numerator) of this price point. Use the PriceScaleCode to determine the true dollar value of the price point'
      - id: volume
        type: s4
        doc: 'The total interest quantity at this price point'
      - id: chg_qty
        type: s4
        doc: 'The volume of the event taking place (i.e size of the order, cancel or execution)'
      - id: num_orders
        type: s2
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
        type: s4
        doc: 'Unique ID for an execution. Correlates to the Deal ID in the gateway Execution Report msg'
      - id: link_id_2
        type: s4
        doc: 'Unused. Ignore any content'
      - id: link_id_3
        type: s4
        doc: 'Unused. Ignore any content'
  sequence_number_reset_message:
    seq:
      - id: next_sequence_number
        type: s4
        doc: 'The sequence number that will follow in the next packet. Always = 2'

enums:
  message_type:
    230:
      id: 'full_update_message'
      doc: 'This message contains the complete order book for a single symbol, with all price points, an aggregated quantity at each price point and symbol mapping information.'
    231:
      id: 'delta_update_message'
      doc: 'A Delta Update message is published in response to events that occur in the book such as interest being added, executions, cancellations and interest routed to a different market.'
    1:
      id: 'sequence_number_reset_message'
      doc: 'This message is sent to reset the Packet Sequence Number.'
    2:
      id: 'heartbeat_message'
      doc: 'Ultra heartbeat message'
  quote_condition:
    0x20:
      id: 'no_special_quote_condition'
      doc: 'No Special Quote Condition'
    0x57:
      id: 'slow_quote'
      doc: 'Slow Quote Due To A Set Slow List'
  trading_status:
    0x50:
      id: 'pre_opening'
      doc: 'Pre Opening'
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
    0x48:
      id: 'halted'
      doc: 'Halted'
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

