# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe DxeDerivatives MulticastDepthOfBook Pitch v1.11
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Europe Derivatives Multicast Depth Of Book
#   Encoding: Pitch
#   Version: 1.11
#   Date: 2/27/2023
#   Specification: Cboe_Europe_CEDX_MCP_Specification.pdf
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
  id: cboe_dxederivatives_multicastdepthofbook_pitch_v1_11
  title: Cboe DxeDerivatives MulticastDepthOfBook Pitch v1.11
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Europe Derivatives Europe Derivatives Multicast Depth Of Book Pitch v1.11'
doc-ref: https://www.cboe.com/europe/derivatives/support/technical

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
            'message_type::end_of_session': end_of_session
            'message_type::transaction_begin_message': transaction_begin_message
            'message_type::transaction_end_message': transaction_end_message
            'message_type::trading_status_message': trading_status_message
            'message_type::fast_status_message': fast_status_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::opening_auction_update_message': opening_auction_update_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::auction_cancel_message': auction_cancel_message
            'message_type::auction_trade_message': auction_trade_message
            'message_type::auction_liquidity_message': auction_liquidity_message
            'message_type::width_update_message': width_update_message
            'message_type::futures_instrument_definition_message': futures_instrument_definition_message
            'message_type::options_instrument_definition_message': options_instrument_definition_message
            'message_type::complex_instrument_definition_message': complex_instrument_definition_message
            'message_type::trade_break_message': trade_break_message
            'message_type::settlement_message': settlement_message
            'message_type::end_of_day_summary_message': end_of_day_summary_message
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
        doc: 'Instrument quantity added to the complex book (may be less than the number entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
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
        doc: 'Instrument quantity being added to the complex book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
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
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
      - id: remaining_quantity
        type: u4
        doc: 'Number of shares/contracts remaining after the execution'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price
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
      - id: canceled_contracts_long
        type: u4
        doc: 'Number of contracts canceled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_contracts_short
        type: u2
        doc: 'Number of contracts canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
      - id: price
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
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
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
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
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
        doc: 'MMT Levels 3.1'
      - id: benchmark_reference_price_indicator
        type: u1
        enum: benchmark_reference_price_indicator
        doc: 'MMT Levels 3.5'
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
        doc: 'Number of contracts associated with this order after this modify'
      - id: symbol_long
        type: str
        size: 8
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
      - id: contracts_long
        type: u8
        doc: 'Number of contracts executed'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: price
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
        doc: 'Always CEDX'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Traded currency'
      - id: cboe_trade_flags
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
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
        doc: 'MMT Levels 3.1'
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
        doc: 'MMT Levels 3.5'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: status
        type: u1
        enum: status
        doc: 'Trading Status'
      - id: reserved_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  fast_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: product_code_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product'
      - id: is_fast
        type: u1
        doc: 'LPP obligations'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_opening_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Auction Opening Type'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
  opening_auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Regular Opening'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Collared VMIM price. Implied decimal with scale 1e-4'
      - id: buy_contracts
        type: u4
        doc: 'Cumulative buy contracts at the Reference Price and above'
      - id: sell_contracts
        type: u4
        doc: 'Cumulative sell contracts at the Reference Price and below'
      - id: indicative_price
        type: decimal_u8_4
        doc: 'Equal to Reference Price. Implied decimal with scale 1e-4'
      - id: auction_only_price
        type: decimal_u8_4
        doc: 'Uncollared VMIM price. Implied decimal with scale 1e-4'
      - id: opening_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'O = Would open Q = Need quote to open B = Need more buyers S = Need more sellers C = Crossed Composite Market'
      - id: composite_market_bid_price
        type: decimal_u8_4
        doc: 'Bid Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
      - id: composite_market_offer_price
        type: decimal_u8_4
        doc: 'Offer Price of the prevailing Composite Market. Implied decimal with scale 1e-4'
  auction_notification_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Regular Opening'
      - id: side
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
      - id: customer_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer Indicator'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Executing Broker (optional) of firm attributed to this quote'
      - id: auction_end_offset
        type: u4
        doc: 'Nanosecond offset from last timestamp'
  auction_cancel_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
  auction_trade_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
      - id: price
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: contracts_short
        type: u2
        doc: 'Number of contracts associated with this order after this modify'
      - id: execution_flags
        type: execution_flags
        doc: 'Execution Flags'
  auction_liquidity_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u8
        doc: 'Day specific identifier assigned to this auction'
      - id: num_price_level_group
        type: u1
        doc: 'Number of price levels present in this auction'
      - id: price_level_group
        type: price_level_group
        repeat: expr
        repeat-expr: num_price_level_group
        doc: 'Price Level'
  price_level_group:
    seq:
      - id: price_level
        type: decimal_u8_4
        doc: 'Price Level. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'Total volume of responses at this Price Level'
  width_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: product_code_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cboe Symbol for underlying Product'
      - id: width_type
        type: u1
        enum: width_type
        doc: 'R = Regular'
      - id: multiplier
        type: decimal_u4_1
        doc: 'Width Multiplier. Implied decimal with scale 1e-1'
  futures_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: product_code_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cboe Symbol for underlying Product'
      - id: expiration_date
        type: u4
        doc: 'Expiration Date of Instrument'
      - id: contract_size
        type: u2
        doc: 'Contract size of Instrument'
      - id: listing_state
        type: u1
        enum: listing_state
        doc: 'Listing State'
      - id: price_increment
        type: decimal_u8_4
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-4'
  options_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: product_code_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Cboe Symbol for underlying Product'
      - id: call_put
        type: u1
        enum: call_put
        doc: 'Call/Put'
      - id: expiration_date
        type: u4
        doc: 'Expiration Date of Instrument'
      - id: strike_price
        type: decimal_u8_4
        doc: 'Strike Price of Instrument. Implied decimal with scale 1e-4'
      - id: contract_size
        type: u2
        doc: 'Contract size of Instrument'
      - id: listing_state
        type: u1
        enum: listing_state
        doc: 'Listing State'
      - id: price_increment
        type: decimal_u8_4
        doc: 'Minimum Price Increment. Implied decimal with scale 1e-4'
  complex_instrument_definition_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: complex_instrument_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Complex Instrument Id'
      - id: reference_price
        type: decimal_u8_4
        doc: 'Collared VMIM price. Implied decimal with scale 1e-4'
      - id: num_leg_group
        type: u1
        doc: 'The number of legs in the complex instrument'
      - id: leg_group
        type: leg_group
        repeat: expr
        repeat-expr: num_leg_group
        doc: 'Leg'
  leg_group:
    seq:
      - id: leg_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option, Future or Equity Symbol of leg'
      - id: leg_ratio
        type: s4
        doc: 'Leg Ratio'
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  settlement_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: trade_date
        type: u4
        doc: 'Trade Date for the settlement'
      - id: settlement_price
        type: decimal_u8_4
        doc: 'Settlement Price. Implied decimal with scale 1e-4'
      - id: issue
        type: u1
        enum: issue
        doc: 'S = Initial Settlement R = Re-issued Settlement'
  end_of_day_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last unit timestamp. Nanoseconds since Second epoch'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol'
      - id: trade_date
        type: u4
        doc: 'Trade Date for the settlement'
      - id: open_interest
        type: u4
        doc: 'Unused in CEDX'
      - id: high_price
        type: decimal_u8_4
        doc: 'Highest trade price or best bid for the day. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_u8_4
        doc: 'Lowest trade price or best offer for the day. Implied decimal with scale 1e-4'
      - id: open_price
        type: decimal_u8_4
        doc: 'If Total Volume greater than 0, represents the first trade of the day. Implied decimal with scale 1e-4'
      - id: close_price
        type: decimal_u8_4
        doc: 'For futures represents a calculated price based upon VWAP, last traded or mid-point price. For options represents a price provided by an external vendor. Implied decimal with scale 1e-4'
      - id: total_volume
        type: u4
        doc: 'Total number of contracts traded'
      - id: block_volume
        type: u4
        doc: 'Total number of block contracts traded'
      - id: ecrp_volume
        type: u4
        doc: 'Unused in CEDX'
      - id: summary_flags
        type: summary_flags
        doc: 'Summary Flags'
  summary_flags:
    meta:
      bit-endian: le
    seq:
      - id: open_and_close_price
        type: b1
        doc: 'Set if both Open and Close Price fields contain valid values'
      - id: low_price_1
        type: b1
        doc: 'Set if Low Price is valid'
      - id: high_price_1
        type: b1
        doc: 'High Price'
      - id: unused_3
        type: b3
        doc: 'Reserved 1-7 Bits'
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: second_unused_1
        type: b1
        doc: 'Reserved'
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
  decimal_u4_1:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10.0

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
    0xe2:
      id: 'fast_status_message'
      doc: 'The Fast Status Message is used to indicate that Cboe Europe now consider the given product to be in a Fast Market'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary messages are used to disseminate the results of an auction in a Cboe auction eligible security'
    0xd1:
      id: 'opening_auction_update_message'
      doc: 'Opening Auction Update messages are used to disseminate price and size information during the Opening and Re-Opening (halt) auctions'
    0xad:
      id: 'auction_notification_message'
      doc: 'Auction Notification messages are used to disseminate order details of an auction'
    0xae:
      id: 'auction_cancel_message'
      doc: 'Auction Cancel messages are used to disseminate the cancellation of an earlier Auction Notification message as a result of a user cancellation of the original order, a user modification request to change the price or increase the original order quantity, or a fading of the NBBO'
    0xdf:
      id: 'auction_trade_message'
      doc: 'Auction Trade messages are used to disseminate executions resulting from an options auction'
    0xde:
      id: 'auction_liquidity_message'
      doc: 'An Auction Liquidity Message is sent out for all AIM Auctions to give an indication of the level of response to a given Auction'
    0xd2:
      id: 'width_update_message'
      doc: 'The Width Update message is used to communicate the opening quote width multiplier'
    0xda:
      id: 'futures_instrument_definition_message'
      doc: 'Futures Instrument Definition'
    0xdb:
      id: 'options_instrument_definition_message'
      doc: 'Options Instrument Definition'
    0xdc:
      id: 'complex_instrument_definition_message'
      doc: 'A Complex Instrument Definition message represents a complex instrument that is available to place orders'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution is broken'
    0xb9:
      id: 'settlement_message'
      doc: 'Settlement messages are normally sent once per day per instrument after settlement prices have been calculated for all applicable instruments on a given business date'
    0xba:
      id: 'end_of_day_summary_message'
      doc: 'The End of Day Summary is sent out right after trading ends for a symbol and contains a summary of trading activity for that symbol for the day'
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
  status:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x51:
      id: 'queuing'
      doc: 'Queuing'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x53:
      id: 'suspension'
      doc: 'Suspension'
    0x48:
      id: 'halted'
      doc: 'Halted'
  auction_type:
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x42:
      id: 'aim'
      doc: 'Aim'
    0x43:
      id: 'crfq'
      doc: 'Crfq'
  width_type:
    0x52:
      id: 'regular'
      doc: 'Regular'
  listing_state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x49:
      id: 'inactive'
      doc: 'Inactive'
    0x54:
      id: 'test'
      doc: 'Test'
  call_put:
    0x50:
      id: 'put'
      doc: 'Put'
    0x43:
      id: 'call'
      doc: 'Call'
  issue:
    0x53:
      id: 'initial_settlement'
      doc: 'Initial Settlement'
    0x52:
      id: 'reissued_settlement'
      doc: 'Reissued Settlement'

