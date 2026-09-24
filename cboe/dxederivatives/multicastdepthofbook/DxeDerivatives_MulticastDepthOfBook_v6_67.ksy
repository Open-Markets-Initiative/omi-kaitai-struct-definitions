# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe DxeDerivatives MulticastDepthOfBook Pitch v6.67
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Europe Derivatives Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 6.67
#   Date: 04/02/2026
#   Specification: BATS_Europe_MC_PITCH_Specification.pdf
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
  id: cboe_dxederivatives_multicastdepthofbook_pitch_v6_67
  title: Cboe DxeDerivatives MulticastDepthOfBook Pitch v6.67
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Europe Derivatives Europe Derivatives Multicast Depth Of Book Pitch v6.67'
doc-ref: https://www.cboe.com/europe/equities/support/technical

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Hdr Count messages to follow'
      - id: count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::time_message': time_message
            'message_type::unit_clear_message': unit_clear_message
            'message_type::add_order_long_message': add_order_long_message
            'message_type::add_order_short_message': add_order_short_message
            'message_type::add_order_expanded_message': add_order_expanded_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_at_price_size_message': order_executed_at_price_size_message
            'message_type::reduce_size_long_message': reduce_size_long_message
            'message_type::reduce_size_short_message': reduce_size_short_message
            'message_type::modify_order_long_message': modify_order_long_message
            'message_type::modify_order_short_message': modify_order_short_message
            'message_type::delete_order_message': delete_order_message
            'message_type::trade_long_message': trade_long_message
            'message_type::trade_short_message': trade_short_message
            'message_type::trade_extended_message': trade_extended_message
            'message_type::trade_unknown_symbol_message': trade_unknown_symbol_message
            'message_type::end_of_session': end_of_session
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
            'message_type::trading_status_message': trading_status_message
            'message_type::statistics_message': statistics_message
            'message_type::auction_update_message': auction_update_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::index_quote_message': index_quote_message
            'message_type::index_quote_edsp_message': index_quote_edsp_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds from midnight Eastern Time. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  add_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Number of shares added to the complex book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  add_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Order Side'
      - id: quantity_short
        type: u2
        doc: 'Number of shares being added to the complex book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  add_order_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Order Side'
      - id: quantity
        type: u4
        doc: 'Number of shares added to the complex book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributes this quote to a particular participant'
  add_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: si_quote
        type: b1
        doc: 'Add represents SI Quote'
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: unused_6
        type: b6
        doc: 'Reserved 2-7 Bits'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares
        type: u4
        doc: 'Number of shares executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: execution_flags
        type: execution_flags
        doc: 'Execution Flags'
  execution_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level level 2'
      - id: ex_cum_dividend
        type: u1
        enum: ex_cum_dividend
        doc: 'MMT Level 3.6'
      - id: algorithmic_trade
        type: u1
        enum: algorithmic_trade
        doc: 'MMT Level 3.9'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_shares
        type: u4
        doc: 'Number of shares executed'
      - id: remaining_shares
        type: u4
        doc: 'Number of shares remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_flags
        type: execution_flags
        doc: 'Execution Flags'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_shares_long
        type: u4
        doc: 'Number of shares canceled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_shares_short
        type: u2
        doc: 'Number of shares canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: shares_short
        type: u2
        doc: 'Number of shares associated with this order after this modify'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  delete_order_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Order Side'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
  trade_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level level 2'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'MMT Level 3.1 and 3.13'
      - id: trade_types
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MMT Levels 3.5, 3.11, and 3.12'
      - id: algorithmic_trade
        type: u1
        enum: algorithmic_trade
        doc: 'MMT Level 3.9'
  trade_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'Order Side'
      - id: contracts_short
        type: u2
        doc: 'Incremental number of contracts executed'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
  trade_extended_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: shares_extended
        type: u8
        doc: 'Number of shares executed'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Cboe generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_timestamp
        type: u8
        doc: 'Date/Time on which the trade occurred, encoded as the number of nanoseconds since the January 1st 1970 UTC (also known as the Unix epoch)'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_flags
        type: u1
        enum: cboe_trade_flags
        doc: 'Cboe Trade Flags'
      - id: extended_trade_flags
        type: extended_trade_flags
        doc: 'Extended Trade Flags'
  extended_trade_flags:
    seq:
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'MMT Level level 1'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'MMT Level level 2'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'MMT Level 3.1 and 3.13'
      - id: negotiated_trade
        type: u1
        enum: negotiated_trade
        doc: 'MMT Levels 3.2'
      - id: crossing_trade
        type: u1
        enum: crossing_trade
        doc: 'MMT Level 3.3'
      - id: modification_indicator
        type: u1
        enum: modification_indicator
        doc: 'MMT Level 3.4'
      - id: benchmark_reference_price_indicator
        type: u1
        enum: benchmark_reference_price_indicator
        doc: 'MMT Level 3.5'
      - id: special_dividend
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MMT Level 3.6'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'MMT Level 3.7'
      - id: price_formation_discovery_process
        type: u1
        enum: price_formation_discovery_process
        doc: 'MMT Level 3.8'
      - id: algorithmic_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MMT Level 3.9'
      - id: publication_mode_deferral_reason
        type: u1
        enum: publication_mode_deferral_reason
        doc: 'MMT Level 4.1'
      - id: deferral_or_enrichment_type
        type: u1
        enum: deferral_or_enrichment_type
        doc: 'MMT Level 4.2'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'MMT Level 5'
  trade_unknown_symbol_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: shares_extended
        type: u8
        doc: 'Number of shares executed'
      - id: symbol_long
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol in ISIN'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: trade_id
        type: u8
        doc: 'Cboe generated identifier of this trade. This identifier is guaranteed to be unique for at least 7 calendar days'
      - id: trade_timestamp
        type: u8
        doc: 'Date/Time on which the trade occurred, encoded as the number of nanoseconds since the January 1st 1970 UTC (also known as the Unix epoch)'
      - id: execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The venue on which the trade executed, when applicable'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_flags
        type: u1
        enum: cboe_trade_flags
        doc: 'Cboe Trade Flags'
      - id: extended_trade_flags
        type: extended_trade_flags
        doc: 'Extended Trade Flags'
  end_of_session:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_begin_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  transaction_end_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  statistics_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: statistic_type
        type: u1
        enum: statistic_type
        doc: 'Statistic Type'
      - id: price_determination
        type: u1
        enum: price_determination
        doc: 'Price Determination'
  auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Reference price used in tie-breaker situations. Implied decimal with scale 1e-4'
      - id: indicative_price
        type: decimal_u4_4
        doc: 'Price at which the auction would match if executed at the time of the message. Implied decimal with scale 1e-4'
      - id: indicative_shares
        type: u4
        doc: 'Number of shares at the Indicative Price'
      - id: outside_tolerance
        type: u1
        enum: outside_tolerance
        doc: 'Indicates whether the price on this update is outside the Cboe EBBO collar'
      - id: includes_primary
        type: u1
        enum: includes_primary
        doc: 'Indicates whether the Cboe EBBO used to collar this update includes the Primary Market quotes'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares_long
        type: u4
        doc: 'Number of shares associated with this order after this modify'
  index_quote_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: index_ticker
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ticker code'
      - id: index_price
        type: decimal_u8_4
        doc: 'Price of the index. Implied decimal with scale 1e-4'
      - id: index_status
        type: u1
        enum: index_status
        doc: 'Index Status'
  index_quote_edsp_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: index_ticker
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ticker code'
      - id: index_price
        type: decimal_u8_4
        doc: 'Price of the index. Implied decimal with scale 1e-4'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header'
    0x40:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. Expanded version accommodates larger symbol sizes possible through the ISRA plan.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever an open order is completely canceled. The Order Id refers to the Order Id of the original Add Order message.'
    0x41:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0x32:
      id: 'trade_extended_message'
      doc: 'The Trade message provides information about executions of complex order auctions on the Cboe complex book.'
    0x35:
      id: 'trade_unknown_symbol_message'
      doc: 'This message provides details of trades reported to Cboe, but traded on a symbol not currently known to Cboe'
    0x2d:
      id: 'end_of_session'
      doc: 'The End of Session message is sent for each unit when the unit shuts down'
    0xbc:
      id: 'transaction_begin_message'
      doc: 'The Transaction Begin message indicates any subsequent messages, up to the accompanying Transaction End message, are all part of the same transaction block'
    0xbd:
      id: 'transaction_end_message'
      doc: 'The Transaction End message indicates that a transaction indicated by a previous Transaction Begin message has completed'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a complex instrument.'
    0x34:
      id: 'statistics_message'
      doc: 'The Statistics Message is used to disseminate the statistics prices: opening, closing, high, low'
    0xac:
      id: 'auction_update_message'
      doc: 'Auction Update messages are used to disseminate indicative price and size information during auctions for Cboe auction eligible securities'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction in a Cboe auction eligible security'
    0xd8:
      id: 'index_quote_message'
      doc: 'Index Quote Messages are sent every second'
    0xd9:
      id: 'index_quote_edsp_message'
      doc: 'Index Quote EDSP Messages are sent at end of day'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  market_mechanism:
    0x31:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x32:
      id: 'quote_driven_market'
      doc: 'Quote Driven Market'
    0x33:
      id: 'dark_order_book'
      doc: 'Dark Order Book'
    0x34:
      id: 'off_book'
      doc: 'Off Book'
    0x35:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x36:
      id: 'request_for_quotes'
      doc: 'Request For Quotes'
    0x37:
      id: 'any_other_including_hybrid'
      doc: 'Any Other Including Hybrid'
  trading_mode:
    0x31:
      id: 'undefined_auction'
      doc: 'Undefined Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
    0x34:
      id: 'out_of_main_session'
      doc: 'Out Of Main Session'
    0x35:
      id: 'trade_reporting_on_exchange'
      doc: 'Trade Reporting On Exchange'
    0x36:
      id: 'trade_reporting_off_exchange'
      doc: 'Trade Reporting Off Exchange'
    0x37:
      id: 'trade_reporting_systematic_internaliser'
      doc: 'Trade Reporting Systematic Internaliser'
    0x4f:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    0x4b:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
  ex_cum_dividend:
    0x45:
      id: 'ex_cum_special_dividend_if_optionally_set_by_reporting_party'
      doc: 'Ex Cum Special Dividend If Optionally Set By Reporting Party'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  algorithmic_trade:
    0x48:
      id: 'algorithmic_trade'
      doc: 'Algorithmic Trade'
    0x2d:
      id: 'nonalgorithmic_trade'
      doc: 'Nonalgorithmic Trade'
  transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x52:
      id: 'trade_that_has_received_price_improvement'
      doc: 'Trade That Has Received Price Improvement'
    0x5a:
      id: 'packaged_trade'
      doc: 'Packaged Trade'
    0x59:
      id: 'exchange_for_physicals_trade'
      doc: 'Exchange For Physicals Trade'
    0x2d:
      id: 'none_of_the_above_apply'
      doc: 'None Of The Above Apply'
  cboe_trade_flags:
    0x34:
      id: 'on_time_in_the_main_session'
      doc: 'The Trade Was Reported To Cboe On Time And In The Main Session'
    0x35:
      id: 'late'
      doc: 'The Trade Was Reported To Cboe Late'
    0x36:
      id: 'out_of_the_main_session'
      doc: 'The Trade Was Reported To Cboe Out Of The Main Session'
    0x37:
      id: 'late_and_out_of_the_main_session'
      doc: 'The Trade Was Reported To Cboe Late And Out Of The Main Session'
    0x43:
      id: 'on_time_in_the_main_session_3_rd_country_venue'
      doc: 'The Trade Was Reported To Cboe On Time In The Main Session And Trade Venue Is An Esma Nonrecognised 3 Rd Country Venue'
    0x44:
      id: 'late_3_rd_country_venue'
      doc: 'The Trade Was Reported To Cboe Late And Trade Venue Is An Esma Nonrecognised 3 Rd Country Venue'
    0x45:
      id: 'out_of_the_main_session_3_rd_country_venue'
      doc: 'The Trade Was Reported To Cboe Out Of The Main Session And Trade Venue Is An Esma Nonrecognised 3 Rd Country Venue'
    0x46:
      id: 'late_and_out_of_the_main_session_3_rd_country_venue'
      doc: 'The Trade Was Reported To Cboe Late Out Of The Main Session And Trade Venue Is An Esma Nonrecognised 3 Rd Country Venue'
  negotiated_trade:
    0x31:
      id: 'negotiated_trade_in_liquid_financial_instruments'
      doc: 'Negotiated Trade In Liquid Financial Instruments'
    0x32:
      id: 'negotiated_trade_in_illiquid_financial_instruments'
      doc: 'Negotiated Trade In Illiquid Financial Instruments'
    0x33:
      id: 'negotiated_trade_subject_to_conditions_other_than_the_current_market_price'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price'
    0x4e:
      id: 'negotiated_trade_where_none_of_the_above_apply'
      doc: 'Negotiated Trade Where None Of The Above Apply'
    0x34:
      id: 'pre_trade_transparency_waiver_for_illiquid_instrument_on_an_si'
      doc: 'Pre Trade Transparency Waiver For Illiquid Instrument On An Si'
    0x35:
      id: 'pre_trade_transparency_waiver_for_above_standard_market_size_on_an_si'
      doc: 'Pre Trade Transparency Waiver For Above Standard Market Size On An Si'
    0x36:
      id: 'pre_trade_transparency_waivers_for_illiquid_instrument_on_an_si_and_above_standard_market_size_on_an_si'
      doc: 'Pre Trade Transparency Waivers For Illiquid Instrument On An Si And Above Standard Market Size On An Si'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  crossing_trade:
    0x58:
      id: 'crossing_trade'
      doc: 'Crossing Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  modification_indicator:
    0x41:
      id: 'indicates_a_modification_of_a_previously_reported_trade'
      doc: 'Indicates A Modification Of A Previously Reported Trade'
    0x43:
      id: 'indicates_a_cancellation_of_a_previously_reported_trade'
      doc: 'Indicates A Cancellation Of A Previously Reported Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  benchmark_reference_price_indicator:
    0x42:
      id: 'benchmark_trade_if_optionally_set_by_reporting_party'
      doc: 'Benchmark Trade If Optionally Set By Reporting Party'
    0x53:
      id: 'reference_price_trade'
      doc: 'Reference Price Trade'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  off_book_automated_indicator:
    0x51:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  price_formation_discovery_process:
    0x50:
      id: 'standard_trade_for_the_specified_market_mechanism_or_trading_mode'
      doc: 'Standard Trade For The Specified Market Mechanism Or Trading Mode'
    0x54:
      id: 'non_price_forming_trade'
      doc: 'Non Price Forming Trade'
    0x4a:
      id: 'trade_not_contributing_to_price_discovery_process'
      doc: 'Trade Not Contributing To Price Discovery Process'
    0x4e:
      id: 'price_is_currently_not_available_but_pending'
      doc: 'Price Is Currently Not Available But Pending'
  publication_mode_deferral_reason:
    0x31:
      id: 'trade_report_reported_late_without_permitted_deferral'
      doc: 'Trade Report Reported Late Without Permitted Deferral'
    0x32:
      id: 'deferral_trade_for_large_in_scale'
      doc: 'Deferral Trade For Large In Scale'
    0x33:
      id: 'deferral_trade_for_illiquid_instrument'
      doc: 'Deferral Trade For Illiquid Instrument'
    0x34:
      id: 'deferral_trade_for_size_specific'
      doc: 'Deferral Trade For Size Specific'
    0x35:
      id: 'deferral_trade_for_illiquid_instrument_and_size_specific'
      doc: 'Deferral Trade For Illiquid Instrument And Size Specific'
    0x36:
      id: 'deferral_trade_for_illiquid_instrument_and_large_in_scale'
      doc: 'Deferral Trade For Illiquid Instrument And Large In Scale'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  deferral_or_enrichment_type:
    0x31:
      id: 'limited_details_trade'
      doc: 'Limited Details Trade'
    0x32:
      id: 'daily_aggregated_trade'
      doc: 'Daily Aggregated Trade'
    0x33:
      id: 'volume_omission_trade'
      doc: 'Volume Omission Trade'
    0x34:
      id: 'four_weeks_aggregation_trade'
      doc: 'Four Weeks Aggregation Trade'
    0x35:
      id: 'indefinite_aggregation_trade'
      doc: 'Indefinite Aggregation Trade'
    0x36:
      id: 'volume_omission_trade_eligible_for_subsequent_enrichment_in_aggregated_form'
      doc: 'Volume Omission Trade Eligible For Subsequent Enrichment In Aggregated Form'
    0x37:
      id: 'full_details_of_earlier_limited_details_trade'
      doc: 'Full Details Of Earlier Limited Details Trade'
    0x38:
      id: 'full_details_of_earlier_daily_aggregated_trade'
      doc: 'Full Details Of Earlier Daily Aggregated Trade'
    0x39:
      id: 'full_details_of_earlier_volume_omission_trade'
      doc: 'Full Details Of Earlier Volume Omission Trade'
    0x56:
      id: 'full_details_of_four_weeks_aggregation_trade'
      doc: 'Full Details Of Four Weeks Aggregation Trade'
    0x57:
      id: 'full_details_of_earlier_volume_omission_trade_eligible_for_subsequent_enrichment_in_aggregated_form'
      doc: 'Full Details Of Earlier Volume Omission Trade Eligible For Subsequent Enrichment In Aggregated Form'
    0x2d:
      id: 'not_applicable'
      doc: 'Not Applicable'
  duplicative_indicator:
    0x31:
      id: 'duplicative_trade_report'
      doc: 'Duplicative Trade Report'
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique Trade Report'
  trading_status:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x52:
      id: 'off_book_reporting'
      doc: 'Off Book Reporting'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x53:
      id: 'suspension'
      doc: 'Suspension'
    0x4e:
      id: 'no_reference_price'
      doc: 'No Reference Price'
    0x56:
      id: 'volatility_interruption'
      doc: 'Volatility Interruption'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x45:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x4d:
      id: 'market_order_imbalance_extension'
      doc: 'Market Order Imbalance Extension'
    0x50:
      id: 'price_monitoring_extension'
      doc: 'Price Monitoring Extension'
    0x55:
      id: 'cboe_closing_cross'
      doc: 'Cboe Closing Cross'
  statistic_type:
    0x43:
      id: 'closing_price'
      doc: 'Closing Price'
    0x48:
      id: 'high_price'
      doc: 'High Price'
    0x4c:
      id: 'low_price'
      doc: 'Low Price'
    0x4f:
      id: 'opening_price'
      doc: 'Opening Price'
    0x50:
      id: 'previous_closing_price'
      doc: 'Previous Closing Price'
  price_determination:
    0x30:
      id: 'normal'
      doc: 'Normal'
    0x31:
      id: 'manual'
      doc: 'Manual'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x48:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x56:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x55:
      id: 'cboe_closing_cross'
      doc: 'Cboe Closing Cross'
  outside_tolerance:
    0x4f:
      id: 'outside_tolerance'
      doc: 'Outside Tolerance'
    0x49:
      id: 'inside_tolerance'
      doc: 'Inside Tolerance'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  includes_primary:
    0x50:
      id: 'includes_primary'
      doc: 'Includes Primary'
    0x4e:
      id: 'excludes_primary'
      doc: 'Excludes Primary'
    0x2d:
      id: 'not_specified'
      doc: 'Not Specified'
  index_status:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x49:
      id: 'indicative'
      doc: 'Indicative'
    0x43:
      id: 'closing'
      doc: 'Closing'

