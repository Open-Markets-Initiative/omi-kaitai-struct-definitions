# ---------------------------------------------------------------------
# Kaitai struct definition for: SmallX OrderBookFeed Sbe v2.2
#
# Protocol:
#   Organization: The Small Exchange
#   Protocol: Order Book Feed
#   Encoding: Simple Binary Encoding
#   Version: 2.2
#   Date: 10/12/2021
#   Specification: Small Exchange Market Data Feed 2.2.pdf
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
  id: smallx_smallfutures_orderbookfeed_sbe_v2_2
  title: SmallX OrderBookFeed Sbe v2.2
  license: GPL-3.0
  endian: le

doc: 'The Small Exchange Small Exchange Order Book Feed Sbe v2.2'
doc-ref: https://smallexchange.com/reference/info-hub

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Order Book Feed PacketHeader Header'
  - id: sbe_frame
    type: sbe_frame_struct
    repeat: expr
    repeat-expr: packet_header.message_count
    doc: 'Sbe Frame'

types:
  packet_header_struct:
    seq:
      - id: channel_id
        type: u1
        doc: 'Identifier of Market Data Channel distributing data for a group of instruments'
      - id: incarnation
        type: u2
        doc: 'Incarnation of the Market Data Channel'
      - id: source
        type: u1
        doc: 'Packet source line type'
      - id: packet_flags
        type: packet_flags
        doc: 'Packet flags'
      - id: message_sequence
        type: u4_nullable
        doc: 'Sequence of the first message in this packet. Nullable, No Value = 0'
      - id: message_count
        type: u1
        doc: 'Number of messages in the packet'
  packet_flags:
    meta:
      bit-endian: le
    seq:
      - id: incarnation_end
        type: b1
        doc: 'Set when the packet is incarnation end'
      - id: retransmission
        type: b1
        doc: 'Set when the packet is resent by the retransmission service'
      - id: administrative
        type: b1
        doc: 'Set when the packet contains an administrative message such as an indication of the retransmission error'
      - id: reserved_5
        type: b5
        doc: '5 reserved bits'
  sbe_frame_struct:
    seq:
      - id: frame_length
        type: u2
        doc: 'Total message size in bytes including this header length'
      - id: message_header
        type: message_header
        doc: 'SmallX Sbe message header'
      - id: payload
        size: frame_length - 10
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::instrument_trading_status_incremental_message': instrument_trading_status_incremental_message
            'template_id::trades_incremental_message': trades_incremental_message
            'template_id::trade_correct_message': trade_correct_message
            'template_id::trade_bust_message': trade_bust_message
            'template_id::order_book_incremental_message': order_book_incremental_message
            'template_id::market_summary_incremental_message': market_summary_incremental_message
            'template_id::order_book_snapshot_message': order_book_snapshot_message
            'template_id::market_summary_snapshot_message': market_summary_snapshot_message
            'template_id::index_value_snapshot_message': index_value_snapshot_message
            'template_id::single_instrument_definition_incremental_v_2_message': single_instrument_definition_incremental_v_2_message
            'template_id::multileg_definition_incremental_v_2_message': multileg_definition_incremental_v_2_message
            'template_id::single_instrument_definition_snapshot_v_2_message': single_instrument_definition_snapshot_v_2_message
            'template_id::multileg_definition_snapshot_v_2_message': multileg_definition_snapshot_v_2_message
  message_header:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Template ID used to encode the message'
      - id: schema_id
        type: u2
        doc: 'Identifier of the schema publishing the message'
      - id: version
        type: u2
        doc: 'Schema version'
  instrument_trading_status_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: block_extension
        size: _parent.message_header.block_length - 25
        doc: 'Bytes the stated block holds beyond the 25 this version reads'
  incremental_message_instructions:
    meta:
      bit-endian: le
    seq:
      - id: transaction_begin
        type: b1
        doc: 'Set in the first message resulting a single business event processing'
      - id: transaction_end
        type: b1
        doc: 'Set in the last message resulting a single business event processing'
      - id: instrument_begin
        type: b1
        doc: 'Set in the first message of an instrument within a single transaction or snapshot replay'
      - id: instrument_end
        type: b1
        doc: 'Set in the last message of an instrument within a single transaction or snapshot replay'
      - id: book_begin
        type: b1
        doc: 'Set in the first Order Book Incremental or Order Book Snapshot message of an instrument'
      - id: book_end
        type: b1
        doc: 'Set in the last Order Book Incremental or Order Book Snapshot message of an instrument'
      - id: book_reset
        type: b1
        doc: 'Marks an instrument order book as empty; the next order book message should be applied to the empty book'
      - id: reserved_9
        type: b9
        doc: '9 reserved bits'
  trades_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'Last traded price for the instrument. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'Size of the last trade. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp of the last trade for the day. Nanoseconds since Unix epoch. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'Total day traded volume for the instrument. Implied decimal with scale 1e0'
      - id: block_extension
        size: _parent.message_header.block_length - 57
        doc: 'Bytes the stated block holds beyond the 57 this version reads'
      - id: incremental_trade_groups
        type: incremental_trade_groups
        doc: 'Trades repeating group'
  incremental_trade_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: incremental_trade_group
        type: incremental_trade_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  group_dimension:
    seq:
      - id: block_length
        type: u2
        doc: 'blockLength'
      - id: num_in_group
        type: u1
        doc: 'numInGroup'
  incremental_trade_group:
    seq:
      - id: trade_id
        type: s8
        doc: 'Unique numeric trade identifier'
      - id: price
        type: decimal_s8_7
        doc: 'Trade price, or the order price in the Order Book Snapshot Message. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Trade quantity, or the order quantity in order book messages. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8_nullable
        doc: 'Id of the ''buy'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'Id of the ''sell'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: trade_conditions
        type: trade_conditions
        doc: 'Bit set of trade condition flags'
      - id: block_extension
        size: _parent.group_dimension.block_length - 43
        doc: 'Bytes the stated block holds beyond the 43 this version reads'
  trade_conditions:
    meta:
      bit-endian: le
    seq:
      - id: synthetic
        type: b1
        doc: 'Spread leg fill with calculated synthetic price'
      - id: auction
        type: b1
        doc: 'Trade is a result of opening auction'
      - id: reserved_14
        type: b14
        doc: '14 reserved bits'
  trade_correct_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'Last traded price for the instrument. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'Size of the last trade. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp of the last trade for the day. Nanoseconds since Unix epoch. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'Total day traded volume for the instrument. Implied decimal with scale 1e0'
      - id: block_extension
        size: _parent.message_header.block_length - 57
        doc: 'Bytes the stated block holds beyond the 57 this version reads'
      - id: trade_correct_groups
        type: trade_correct_groups
        doc: 'Trades update repeating group'
  trade_correct_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: trade_correct_group
        type: trade_correct_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  trade_correct_group:
    seq:
      - id: trade_update_action
        type: u1
        enum: trade_update_action
        doc: 'Trade update type'
      - id: trade_id
        type: s8
        doc: 'Unique numeric trade identifier'
      - id: time
        type: nanosecond_timestamp
        doc: 'Trade timestamp, or the order timestamp in the Order Book Snapshot Message. Nanoseconds since Unix epoch'
      - id: price
        type: decimal_s8_7
        doc: 'Trade price, or the order price in the Order Book Snapshot Message. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Trade quantity, or the order quantity in order book messages. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8_nullable
        doc: 'Id of the ''buy'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'Id of the ''sell'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: trade_conditions
        type: trade_conditions
        doc: 'Bit set of trade condition flags'
      - id: block_extension
        size: _parent.group_dimension.block_length - 52
        doc: 'Bytes the stated block holds beyond the 52 this version reads'
  trade_bust_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'Last traded price for the instrument. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'Size of the last trade. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp_optional
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp of the last trade for the day. Nanoseconds since Unix epoch. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity
        type: decimal_s8_0
        doc: 'Total day traded volume for the instrument. Implied decimal with scale 1e0'
      - id: block_extension
        size: _parent.message_header.block_length - 57
        doc: 'Bytes the stated block holds beyond the 57 this version reads'
      - id: trade_bust_groups
        type: trade_bust_groups
        doc: 'Busted trades repeating group'
  trade_bust_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: trade_bust_group
        type: trade_bust_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoTrades'
  trade_bust_group:
    seq:
      - id: trade_id
        type: s8
        doc: 'Unique numeric trade identifier'
      - id: time
        type: nanosecond_timestamp
        doc: 'Trade timestamp, or the order timestamp in the Order Book Snapshot Message. Nanoseconds since Unix epoch'
      - id: price
        type: decimal_s8_7
        doc: 'Trade price, or the order price in the Order Book Snapshot Message. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Trade quantity, or the order quantity in order book messages. Implied decimal with scale 1e0'
      - id: aggressor_side
        type: u1
        enum: aggressor_side
        doc: 'Trade aggressor side'
      - id: buy_order_id
        type: s8_nullable
        doc: 'Id of the ''buy'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: sell_order_id
        type: s8_nullable
        doc: 'Id of the ''sell'' order. Order id here is the same as reported in FIX protocol. Nullable, No Value = -9223372036854775808'
      - id: trade_conditions
        type: trade_conditions
        doc: 'Bit set of trade condition flags'
      - id: block_extension
        size: _parent.group_dimension.block_length - 51
        doc: 'Bytes the stated block holds beyond the 51 this version reads'
  order_book_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: block_extension
        size: _parent.message_header.block_length - 25
        doc: 'Bytes the stated block holds beyond the 25 this version reads'
      - id: incremental_orders_groups
        type: incremental_orders_groups
        doc: 'Orders repeating group'
  incremental_orders_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: incremental_orders_group
        type: incremental_orders_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoOrders'
  incremental_orders_group:
    seq:
      - id: order_update_action
        type: u1
        enum: order_update_action
        doc: 'Order update action'
      - id: order_id
        type: s8
        doc: 'Unique numeric order identifier. Order id here is the same as reported in FIX protocol'
      - id: trade_id_optional
        type: s8_nullable
        doc: 'Id of the trade if this order update is caused by a trade. Nullable, No Value = -9223372036854775808'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: price_optional
        type: decimal_s8_7_nullable
        doc: 'Order price. For modified order represents a price after modification. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: size
        type: decimal_s8_0
        doc: 'Trade quantity, or the order quantity in order book messages. Implied decimal with scale 1e0'
      - id: order_priority_optional
        type: s8_nullable
        doc: 'Order priority assigned to all orders in a book. This field can be used to compare order priority in a queue across all orders on the same price level: an order with lower field value has higher priority. Implied orders have maximum value of order priority (0x7fffffffffffffff) so that they always have less priority than any direct order. Nullable, No Value = -9223372036854775808'
      - id: order_attributes
        type: order_attributes
        doc: 'Bit set of order attribute flags'
      - id: block_extension
        size: _parent.group_dimension.block_length - 44
        doc: 'Bytes the stated block holds beyond the 44 this version reads'
  order_attributes:
    meta:
      bit-endian: le
    seq:
      - id: implied
        type: b1
        doc: 'Implied order'
      - id: reserved_15
        type: b15
        doc: '15 reserved bits'
  market_summary_incremental_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'The session opening price; can be indicative. In the Index Snapshot Message, the first index value calculated for a day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_price_type
        type: u1
        enum: open_price_type
        doc: 'Open price type'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'Highest traded price for the session. In the Index Snapshot Message, the highest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'Lowest trade price for the summary date. In the Index Snapshot Message, the lowest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'Closing price for the summary date. In the Index Snapshot Message, the last index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_interest
        type: decimal_s8_0_nullable
        doc: 'Contract open interest. Total number of long (and equally short) contract positions. Published for single instruments only. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_7_nullable
        doc: 'Settlement price for the session day. Published for single instruments only. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: settlement_price_type
        type: u1
        enum: settlement_price_type
        doc: 'Settlement price type'
      - id: block_extension
        size: _parent.message_header.block_length - 75
        doc: 'Bytes the stated block holds beyond the 75 this version reads'
  order_book_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'Bit set of snapshot line message flags'
      - id: snapshot_instruments_count
        type: s4
        doc: 'Total number of instruments in the Snapshot line publishing cycle. The number may increase within a single publishing cycle in case any instruments are created'
      - id: last_incremental_message_seq
        type: s8
        doc: 'Last incremental message sequence in this incarnation related to this instrument'
      - id: block_extension
        size: _parent.message_header.block_length - 37
        doc: 'Bytes the stated block holds beyond the 37 this version reads'
      - id: snapshot_orders_groups
        type: snapshot_orders_groups
        doc: 'Orders repeating group'
  snapshot_message_instructions:
    meta:
      bit-endian: le
    seq:
      - id: unused_snapshot_message_instructions_0
        type: b1
        doc: 'Unused SnapshotMessageInstructions 0'
      - id: unused_snapshot_message_instructions_1
        type: b1
        doc: 'Unused SnapshotMessageInstructions 1'
      - id: instrument_begin
        type: b1
        doc: 'Set in the first message of an instrument within a single transaction or snapshot replay'
      - id: instrument_end
        type: b1
        doc: 'Set in the last message of an instrument within a single transaction or snapshot replay'
      - id: book_begin
        type: b1
        doc: 'Set in the first Order Book Incremental or Order Book Snapshot message of an instrument'
      - id: book_end
        type: b1
        doc: 'Set in the last Order Book Incremental or Order Book Snapshot message of an instrument'
      - id: unused_snapshot_message_instructions_6
        type: b1
        doc: 'Unused SnapshotMessageInstructions 6'
      - id: snapshot_begin
        type: b1
        doc: 'Marks the first message of a single snapshot replay in a line'
      - id: snapshot_end
        type: b1
        doc: 'Marks the last message of a single snapshot replay in a line'
      - id: reserved_7
        type: b7
        doc: '7 reserved bits'
  snapshot_orders_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: snapshot_orders_group
        type: snapshot_orders_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoOrders'
  snapshot_orders_group:
    seq:
      - id: order_id
        type: s8
        doc: 'Unique numeric order identifier. Order id here is the same as reported in FIX protocol'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: price
        type: decimal_s8_7
        doc: 'Trade price, or the order price in the Order Book Snapshot Message. Implied decimal with scale 1e-7'
      - id: size
        type: decimal_s8_0
        doc: 'Trade quantity, or the order quantity in order book messages. Implied decimal with scale 1e0'
      - id: order_priority
        type: s8
        doc: 'Order priority assigned to all orders in a book. This field can be used to compare order priority in a queue across all orders on the same price level: an order with lower field value has higher priority. Implied orders have maximum value of order priority (0x7fffffffffffffff) so that they always have less priority than any direct order'
      - id: order_attributes
        type: order_attributes
        doc: 'Bit set of order attribute flags'
      - id: time
        type: nanosecond_timestamp
        doc: 'Trade timestamp, or the order timestamp in the Order Book Snapshot Message. Nanoseconds since Unix epoch'
      - id: block_extension
        size: _parent.group_dimension.block_length - 43
        doc: 'Bytes the stated block holds beyond the 43 this version reads'
  market_summary_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'Bit set of snapshot line message flags'
      - id: snapshot_instruments_count
        type: s4
        doc: 'Total number of instruments in the Snapshot line publishing cycle. The number may increase within a single publishing cycle in case any instruments are created'
      - id: last_incremental_message_seq
        type: s8
        doc: 'Last incremental message sequence in this incarnation related to this instrument'
      - id: last_trade_price
        type: decimal_s8_7_nullable
        doc: 'Last traded price for the instrument. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: last_trade_size
        type: decimal_s8_0_nullable
        doc: 'Size of the last trade. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: last_trade_time_timestamp
        type: nanosecond_timestamp_nullable
        doc: 'Timestamp of the session last trade. Nanoseconds since Unix epoch. Nullable, No Value = -9223372036854775808'
      - id: total_volume_quantity_optional
        type: decimal_s8_0_nullable
        doc: 'Total traded volume for the instrument session. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'The session opening price; can be indicative. In the Index Snapshot Message, the first index value calculated for a day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_price_type
        type: u1
        enum: open_price_type
        doc: 'Open price type'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'Highest traded price for the session. In the Index Snapshot Message, the highest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'Lowest trade price for the summary date. In the Index Snapshot Message, the lowest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'Closing price for the summary date. In the Index Snapshot Message, the last index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: open_interest
        type: decimal_s8_0_nullable
        doc: 'Contract open interest. Total number of long (and equally short) contract positions. Published for single instruments only. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: settlement_price
        type: decimal_s8_7_nullable
        doc: 'Settlement price for the session day. Published for single instruments only. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: settlement_price_type
        type: u1
        enum: settlement_price_type
        doc: 'Settlement price type'
      - id: block_extension
        size: _parent.message_header.block_length - 119
        doc: 'Bytes the stated block holds beyond the 119 this version reads'
  index_value_snapshot_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'Bit set of snapshot line message flags'
      - id: index_count
        type: s4
        doc: 'Total number of indices in the line publishing cycle'
      - id: index_symbol
        type: str
        size: 20
        encoding: ASCII
        doc: 'Index symbol'
      - id: value_field
        type: decimal_s8_7_nullable
        doc: 'Last index value. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: session_date
        type: epoch_date
        doc: 'Index session date. Days since Unix epoch'
      - id: open_price
        type: decimal_s8_7_nullable
        doc: 'The session opening price; can be indicative. In the Index Snapshot Message, the first index value calculated for a day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: high_price
        type: decimal_s8_7_nullable
        doc: 'Highest traded price for the session. In the Index Snapshot Message, the highest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: low_price
        type: decimal_s8_7_nullable
        doc: 'Lowest trade price for the summary date. In the Index Snapshot Message, the lowest index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: close_price
        type: decimal_s8_7_nullable
        doc: 'Closing price for the summary date. In the Index Snapshot Message, the last index value for the day. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: block_extension
        size: _parent.message_header.block_length - 80
        doc: 'Bytes the stated block holds beyond the 80 this version reads'
  single_instrument_definition_incremental_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: instrument_update_action
        type: u1
        enum: instrument_update_action
        doc: 'Type of instrument update action'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Instrument symbol'
      - id: product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Instrument product'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Instrument text description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument type'
      - id: maturity_date
        type: epoch_date
        doc: 'Instrument maturity date. For multi-leg instruments is usually defined as the nearest maturity date from all legs. Days since Unix epoch'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'Instrument first trading business day. Days since Unix epoch'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'Instrument last trading business day. Days since Unix epoch'
      - id: expiration_date
        type: epoch_date
        doc: 'Day of instrument final expiration settlement price calculation. For multi-leg instruments is usually defined as the nearest expiration date from all legs. Days since Unix epoch'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO 10962 instrument 6-character classification code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'ISO 4217 instrument currency code. For instance "USD"'
      - id: price_increment
        type: decimal_s8_7
        doc: 'Instrument price increment. Positive number; price increment of 0.01 is represented as 100000 field value. All prices for the instrument order and trade messages are a multiple of the price increment. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'Ratio between contract price and its value expressed in instrument''s currency amount. Implied decimal with scale 1e-7'
      - id: underlying_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Option underlying symbol'
      - id: underlying_instrument_id
        type: s4
        doc: 'Option underlying ID. The ID is used to reference instrument definition message of the underlying transmitted in the snapshot line for getting underlying details from it'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option put/call flag'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'Option strike price. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: shares_per_contract
        type: decimal_s8_0_nullable
        doc: 'Option number of shares per contract. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: expiration_style
        type: u1
        enum: expiration_style
        doc: 'Expiration style'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Option exercise style'
      - id: delivery
        type: u1
        enum: delivery
        doc: 'Delivery style'
      - id: block_extension
        size: _parent.message_header.block_length - 262
        doc: 'Bytes the stated block holds beyond the 262 this version reads'
  multileg_definition_incremental_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: incremental_message_instructions
        type: incremental_message_instructions
        doc: 'Incremental message handling instructions flags'
      - id: instrument_update_action
        type: u1
        enum: instrument_update_action
        doc: 'Type of instrument update action'
      - id: spread_symbol
        type: str
        size: 120
        encoding: ASCII
        doc: 'Multi-leg instrument symbol'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Instrument text description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument type'
      - id: maturity_date
        type: epoch_date
        doc: 'Instrument maturity date. For multi-leg instruments is usually defined as the nearest maturity date from all legs. Days since Unix epoch'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'Instrument first trading business day. Days since Unix epoch'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'Instrument last trading business day. Days since Unix epoch'
      - id: expiration_date
        type: epoch_date
        doc: 'Day of instrument final expiration settlement price calculation. For multi-leg instruments is usually defined as the nearest expiration date from all legs. Days since Unix epoch'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO 10962 instrument 6-character classification code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'ISO 4217 instrument currency code. For instance "USD"'
      - id: price_increment
        type: decimal_s8_7
        doc: 'Instrument price increment. Positive number; price increment of 0.01 is represented as 100000 field value. All prices for the instrument order and trade messages are a multiple of the price increment. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'Ratio between contract price and its value expressed in instrument''s currency amount. Implied decimal with scale 1e-7'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'Type of multi-leg strategy'
      - id: block_extension
        size: _parent.message_header.block_length - 301
        doc: 'Bytes the stated block holds beyond the 301 this version reads'
      - id: legs_groups
        type: legs_groups
        doc: 'Legs repeating group'
  legs_groups:
    seq:
      - id: group_dimension
        type: group_dimension
        doc: 'GroupDimension'
      - id: legs_group
        type: legs_group
        repeat: expr
        repeat-expr: group_dimension.num_in_group
        doc: 'NoLegs'
  legs_group:
    seq:
      - id: leg_instrument_id
        type: s4
        doc: 'Unique numeric ID of the leg instrument. The ID is used to reference instrument definition message of the leg transmitted in the snapshot line for getting details and all information data fields from it'
      - id: leg_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Leg instrument symbol'
      - id: leg_product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Leg instrument product'
      - id: leg_ratio_quantity
        type: decimal_s8_0
        doc: 'Leg quantity in a single quantity of the multi-leg instrument. Implied decimal with scale 1e0'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side'
      - id: block_extension
        size: _parent.group_dimension.block_length - 46
        doc: 'Bytes the stated block holds beyond the 46 this version reads'
  single_instrument_definition_snapshot_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'Bit set of snapshot line message flags'
      - id: snapshot_instruments_count
        type: s4
        doc: 'Total number of instruments in the Snapshot line publishing cycle. The number may increase within a single publishing cycle in case any instruments are created'
      - id: last_incremental_message_seq
        type: s8
        doc: 'Last incremental message sequence in this incarnation related to this instrument'
      - id: symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Instrument symbol'
      - id: product
        type: str
        size: 8
        encoding: ASCII
        doc: 'Instrument product'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Instrument text description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument type'
      - id: maturity_date
        type: epoch_date
        doc: 'Instrument maturity date. For multi-leg instruments is usually defined as the nearest maturity date from all legs. Days since Unix epoch'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'Instrument first trading business day. Days since Unix epoch'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'Instrument last trading business day. Days since Unix epoch'
      - id: expiration_date
        type: epoch_date
        doc: 'Day of instrument final expiration settlement price calculation. For multi-leg instruments is usually defined as the nearest expiration date from all legs. Days since Unix epoch'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO 10962 instrument 6-character classification code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'ISO 4217 instrument currency code. For instance "USD"'
      - id: price_increment
        type: decimal_s8_7
        doc: 'Instrument price increment. Positive number; price increment of 0.01 is represented as 100000 field value. All prices for the instrument order and trade messages are a multiple of the price increment. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'Ratio between contract price and its value expressed in instrument''s currency amount. Implied decimal with scale 1e-7'
      - id: underlying_symbol
        type: str
        size: 25
        encoding: ASCII
        doc: 'Option underlying symbol'
      - id: underlying_instrument_id
        type: s4
        doc: 'Option underlying ID. The ID is used to reference instrument definition message of the underlying transmitted in the snapshot line for getting underlying details from it'
      - id: put_or_call
        type: u1
        enum: put_or_call
        doc: 'Option put/call flag'
      - id: strike_price
        type: decimal_s8_7_nullable
        doc: 'Option strike price. Implied decimal with scale 1e-7. Nullable, No Value = -9223372036854775808'
      - id: shares_per_contract
        type: decimal_s8_0_nullable
        doc: 'Option number of shares per contract. Implied decimal with scale 1e0. Nullable, No Value = -9223372036854775808'
      - id: expiration_style
        type: u1
        enum: expiration_style
        doc: 'Expiration style'
      - id: exercise_style
        type: u1
        enum: exercise_style
        doc: 'Option exercise style'
      - id: delivery
        type: u1
        enum: delivery
        doc: 'Delivery style'
      - id: block_extension
        size: _parent.message_header.block_length - 273
        doc: 'Bytes the stated block holds beyond the 273 this version reads'
  multileg_definition_snapshot_v_2_message:
    seq:
      - id: instrument_id
        type: s4
        doc: 'Unique numeric identifier of the instrument, or of the index in the Index Snapshot Message'
      - id: instrument_message_no
        type: s8
        doc: 'Number of incremental message for the instrument. Starts with 1 on instrument creation and monotonically increases with each message sent for the instrument. In snapshot messages, the number of the instrument incremental message the snapshot reflects the instrument data for'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Message event timestamp; in snapshot messages, the last instrument incremental message event timestamp; in the Index Snapshot Message, the index value calculation time. Nanoseconds since Unix epoch'
      - id: trading_session_date
        type: epoch_date
        doc: 'Trading session business date. Days since Unix epoch'
      - id: instrument_trading_status
        type: u1
        enum: instrument_trading_status
        doc: 'Trading session status of the instrument'
      - id: snapshot_message_instructions
        type: snapshot_message_instructions
        doc: 'Bit set of snapshot line message flags'
      - id: snapshot_instruments_count
        type: s4
        doc: 'Total number of instruments in the Snapshot line publishing cycle. The number may increase within a single publishing cycle in case any instruments are created'
      - id: last_incremental_message_seq
        type: s8
        doc: 'Last incremental message sequence in this incarnation related to this instrument'
      - id: spread_symbol
        type: str
        size: 120
        encoding: ASCII
        doc: 'Multi-leg instrument symbol'
      - id: description
        type: str
        size: 120
        encoding: ASCII
        doc: 'Instrument text description'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument type'
      - id: maturity_date
        type: epoch_date
        doc: 'Instrument maturity date. For multi-leg instruments is usually defined as the nearest maturity date from all legs. Days since Unix epoch'
      - id: first_trading_session_date
        type: epoch_date
        doc: 'Instrument first trading business day. Days since Unix epoch'
      - id: last_trading_session_date
        type: epoch_date
        doc: 'Instrument last trading business day. Days since Unix epoch'
      - id: expiration_date
        type: epoch_date
        doc: 'Day of instrument final expiration settlement price calculation. For multi-leg instruments is usually defined as the nearest expiration date from all legs. Days since Unix epoch'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'ISO 10962 instrument 6-character classification code'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        doc: 'ISO 4217 instrument currency code. For instance "USD"'
      - id: price_increment
        type: decimal_s8_7
        doc: 'Instrument price increment. Positive number; price increment of 0.01 is represented as 100000 field value. All prices for the instrument order and trade messages are a multiple of the price increment. Implied decimal with scale 1e-7'
      - id: price_multiplier
        type: decimal_s8_7
        doc: 'Ratio between contract price and its value expressed in instrument''s currency amount. Implied decimal with scale 1e-7'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'Type of multi-leg strategy'
      - id: block_extension
        size: _parent.message_header.block_length - 312
        doc: 'Bytes the stated block holds beyond the 312 this version reads'
      - id: legs_groups
        type: legs_groups
        doc: 'Legs repeating group'
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0
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
  epoch_date:
    seq:
      - id: days
        type: u2
    instances:
      unix_seconds:
        value: days * 86400
  decimal_s8_7:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000000.0
  decimal_s8_7_nullable:
    seq:
      - id: value
        type: decimal_s8_7
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  decimal_s8_0:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1.0
  decimal_s8_0_nullable:
    seq:
      - id: value
        type: decimal_s8_0
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -9223372036854775808
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808

enums:
  template_id:
    3:
      id: 'instrument_trading_status_incremental_message'
      doc: 'InstrumentTradingStatusIncrementalMessage'
    4:
      id: 'trades_incremental_message'
      doc: 'TradesIncrementalMessage'
    5:
      id: 'trade_correct_message'
      doc: 'TradeCorrectMessage'
    6:
      id: 'trade_bust_message'
      doc: 'TradeBustMessage'
    7:
      id: 'order_book_incremental_message'
      doc: 'OrderBookIncrementalMessage'
    8:
      id: 'market_summary_incremental_message'
      doc: 'MarketSummaryIncrementalMessage'
    11:
      id: 'order_book_snapshot_message'
      doc: 'OrderBookSnapshotMessage'
    12:
      id: 'market_summary_snapshot_message'
      doc: 'MarketSummarySnapshotMessage'
    13:
      id: 'index_value_snapshot_message'
      doc: 'IndexValueSnapshotMessage'
    14:
      id: 'single_instrument_definition_incremental_v_2_message'
      doc: 'SingleInstrumentDefinitionIncrementalV2Message'
    15:
      id: 'multileg_definition_incremental_v_2_message'
      doc: 'MultilegDefinitionIncrementalV2Message'
    16:
      id: 'single_instrument_definition_snapshot_v_2_message'
      doc: 'SingleInstrumentDefinitionSnapshotV2Message'
    17:
      id: 'multileg_definition_snapshot_v_2_message'
      doc: 'MultilegDefinitionSnapshotV2Message'
  instrument_trading_status:
    0x43:
      id: 'closed'
      doc: 'CLOSED'
    0x50:
      id: 'pre_open'
      doc: 'PRE_OPEN'
    0x4e:
      id: 'pre_open_nc'
      doc: 'Pre-open no cancel'
    0x4f:
      id: 'open'
      doc: 'OPEN'
    0x55:
      id: 'paused'
      doc: 'PAUSED'
    0x48:
      id: 'halted'
      doc: 'HALTED'
  aggressor_side:
    0x4e:
      id: 'no_aggressor'
      doc: 'No aggressor'
    0x42:
      id: 'buy'
      doc: 'Buy side is a trade aggressor'
    0x53:
      id: 'sell'
      doc: 'Sell side is a trade aggressor'
  trade_update_action:
    0x4e:
      id: 'new_field'
      doc: 'New correcting trade'
    0x44:
      id: 'delete_field'
      doc: 'Delete/bust original trade'
  order_update_action:
    0x4e:
      id: 'new_field'
      doc: 'New order in an order book'
    0x55:
      id: 'update'
      doc: 'Existing order in a book: price or working quantity is updated'
    0x44:
      id: 'delete_field'
      doc: 'Existing order is removed from a book due to cancel or fill'
  side:
    0x42:
      id: 'buy'
      doc: 'BUY'
    0x53:
      id: 'sell'
      doc: 'SELL'
  open_price_type:
    0x49:
      id: 'indicative'
      doc: 'Indicative price calculated and published every second during the pre-opening auction'
    0x54:
      id: 'traded'
      doc: 'Traded open price as a result of opening after the day pre-opening auction'
    0x4e:
      id: 'no_price'
      doc: 'No price'
  settlement_price_type:
    0x46:
      id: 'final_field'
      doc: 'Final settlement price for a day, published within 15 mins after instrument market is closed for a day'
    0x50:
      id: 'preliminary'
      doc: 'Preliminary. Reserved for future use, not published'
    0x4e:
      id: 'no_price'
      doc: 'No price. For multi-leg, or if not calculated yet'
  instrument_update_action:
    0x41:
      id: 'add'
      doc: 'Instrument is added'
    0x44:
      id: 'delete_field'
      doc: 'Instrument is deleted'
    0x4d:
      id: 'modify'
      doc: 'Instrument is modified'
  instrument_type:
    0x46:
      id: 'futures'
      doc: 'FUTURES'
    0x4f:
      id: 'option'
      doc: 'OPTION'
    0x4d:
      id: 'mleg'
      doc: 'Multi-leg'
  put_or_call:
    0x50:
      id: 'put'
      doc: 'PUT'
    0x43:
      id: 'call'
      doc: 'CALL'
    0x4e:
      id: 'not_option'
      doc: 'Not option (for futures)'
  expiration_style:
    0x53:
      id: 'standard'
      doc: 'Standard (third Friday of each month)'
    0x44:
      id: 'daily'
      doc: 'DAILY'
    0x57:
      id: 'weekly'
      doc: 'WEEKLY'
    0x51:
      id: 'quaterly'
      doc: 'Quarterly'
  exercise_style:
    0x45:
      id: 'european'
      doc: 'EUROPEAN'
    0x41:
      id: 'american'
      doc: 'AMERICAN'
    0x4e:
      id: 'not_option'
      doc: 'Not option (for futures)'
  delivery:
    0x43:
      id: 'cash'
      doc: 'CASH'
    0x50:
      id: 'physical'
      doc: 'PHYSICAL'
  strategy_type:
    0:
      id: 'custom'
      doc: 'Custom spread/Unrecognized'
    1:
      id: 'futures_calendar'
      doc: 'Futures calendar, front minus back month'
    2:
      id: 'futures_inter_commodity'
      doc: 'Futures Inter-Commodity Spread, two-legged cross-product futures strategy with up to 5 ratio in legs'
    3:
      id: 'covered'
      doc: 'Covered Call'
    4:
      id: 'option_butterfly'
      doc: 'OPTION_BUTTERFLY'
    5:
      id: 'option_vertical'
      doc: 'OPTION_VERTICAL'
    6:
      id: 'option_strangle'
      doc: 'OPTION_STRANGLE'
    7:
      id: 'option_straddle'
      doc: 'OPTION_STRADDLE'
    8:
      id: 'option_diagonal'
      doc: 'OPTION_DIAGONAL'
    9:
      id: 'option_calendar'
      doc: 'OPTION_CALENDAR'
    10:
      id: 'option_iron_condor'
      doc: 'OPTION_IRON_CONDOR'
    11:
      id: 'protective_put'
      doc: 'PROTECTIVE_PUT'
  leg_side:
    0x42:
      id: 'buy'
      doc: 'BUY'
    0x53:
      id: 'sell'
      doc: 'SELL'

