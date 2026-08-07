# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxOptions DepthOfMarket Itch v1.3
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Depth Of Market
#   Encoding: Itch
#   Version: 1.3
#   Date: 11/2/2017
#   Specification: BXOptions_DepthofMarket.pdf
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
  id: nasdaq_ntxoptions_depthofmarket_itch_v1_3
  title: Nasdaq NtxOptions DepthOfMarket Itch v1.3
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Depth Of Market Itch v1.3'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=dpspecs

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::seconds_message': seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::base_reference_message': base_reference_message
            'message_type::option_directory_message': option_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::option_open_message': option_open_message
            'message_type::add_order_message_short_form': add_order_message_short_form
            'message_type::add_order_message_long_form': add_order_message_long_form
            'message_type::add_quote_message_short_form': add_quote_message_short_form
            'message_type::add_quote_message_long_form': add_quote_message_long_form
            'message_type::single_side_executed_message': single_side_executed_message
            'message_type::single_side_order_executed_with_price_message': single_side_order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::single_side_replace_message_short_form': single_side_replace_message_short_form
            'message_type::single_side_replace_message_long_form': single_side_replace_message_long_form
            'message_type::single_side_delete_message': single_side_delete_message
            'message_type::single_side_update_message': single_side_update_message
            'message_type::quote_replace_message_short_form': quote_replace_message_short_form
            'message_type::quote_replace_message_long_form': quote_replace_message_long_form
            'message_type::quote_delete_message': quote_delete_message
            'message_type::block_delete_message': block_delete_message
            'message_type::non_auction_options_trade_message': non_auction_options_trade_message
            'message_type::options_cross_trade_message': options_cross_trade_message
            'message_type::broken_trade_or_order_execution_message': broken_trade_or_order_execution_message
            'message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight. Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  base_reference_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: base_reference_number
        type: u8
        doc: 'Base Reference Number'
  option_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the security symbol'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month (1-12)'
      - id: expiration_date
        type: u1
        doc: 'Day of the Month of expiration (1- 31)'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: '“C” = Call option “P” = Put option'
      - id: source
        type: u1
        doc: 'Identifies the source of the Option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within exchange'
      - id: options_closing_type
        type: u1
        enum: options_closing_type
        doc: 'Denotes which System Event is used to trigger the option closing process. “N” = Normal Hours “L” = Late Hours'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange. The allowable values are:'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option. See Notes below for further explanation:'
  trading_action_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the options security in the BX Options Market. The allowable values are:'
  option_open_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: open_state
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The allowable values are Yes and No'
  add_order_message_short_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number_delta
        type: u4
        doc: 'The unique reference number delta assigned to the new order. The order reference number is Increasing, but not necessarily sequential'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The type of order being added'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: price
        type: decimal_s2_2
        doc: 'The display price of the new order being added to the book. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: volume
        type: u2
        doc: 'The total number of contracts of the new order being added to the book'
  add_order_message_long_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number_delta
        type: u4
        doc: 'The unique reference number delta assigned to the new order. The order reference number is Increasing, but not necessarily sequential'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The type of order being added'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  add_quote_message_short_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: bid_price
        type: decimal_s2_2
        doc: 'The display bid price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: decimal_s2_2
        doc: 'The display ask price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: ask_size
        type: u2
        doc: 'The ask contracts of the new quote'
  add_quote_message_long_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: bid
        type: u4
        doc: 'The display bid price of the new quote'
      - id: bid_size_long
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask
        type: u4
        doc: 'The display ask price of the new quote'
      - id: ask_size_long
        type: u4
        doc: 'The ask contracts of the new quote'
  single_side_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: executed_contracts
        type: u4
        doc: 'The number of contracts executed'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day. The match number is also referenced in the Trade Break Message'
  single_side_order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day. The match number is also referenced in the Trade Break Message'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays and volume calculations'
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  order_cancel_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: order_reference_number_delta
        type: u4
        doc: 'The unique reference number delta assigned to the new order. The order reference number is Increasing, but not necessarily sequential'
      - id: cancelled_contracts
        type: u4
        doc: 'The number of contracts to be removed from the display size of the order as the result of a cancellation'
  single_side_replace_message_short_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: price
        type: decimal_s2_2
        doc: 'The display price of the new order being added to the book. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: volume
        type: u2
        doc: 'The total number of contracts of the new order being added to the book'
  single_side_replace_message_long_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: original_reference_number_delta
        type: u4
        doc: 'The original reference number delta associated with the order being replaced'
      - id: new_reference_number_delta
        type: u4
        doc: 'The new reference number delta associated with the new order'
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  single_side_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
  single_side_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
      - id: change_reason
        type: u1
        enum: change_reason
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  quote_replace_message_short_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: original_bid_reference_number_delta
        type: u4
        doc: 'The original bid reference number delta that is replaced'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: original_ask_reference_number_delta
        type: u4
        doc: 'The original ask reference number delta that is replaced'
      - id: ask_reference_delta_number
        type: u4
        doc: 'The ask reference number delta associated with the replaced quote'
      - id: bid_price
        type: decimal_s2_2
        doc: 'The display bid price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: decimal_s2_2
        doc: 'The display ask price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: ask_size
        type: u2
        doc: 'The ask contracts of the new quote'
  quote_replace_message_long_form:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: original_bid_reference_number_delta
        type: u4
        doc: 'The original bid reference number delta that is replaced'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: original_ask_reference_number_delta
        type: u4
        doc: 'The original ask reference number delta that is replaced'
      - id: ask_reference_delta_number
        type: u4
        doc: 'The ask reference number delta associated with the replaced quote'
      - id: bid_price_long
        type: decimal_s4_4
        doc: 'The display bid price of the replaced quote. Implied decimal with scale 1e-4'
      - id: bid_size_long
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask_price_long
        type: decimal_s4_4
        doc: 'The display ask price of the replaced quote. Implied decimal with scale 1e-4'
      - id: ask_size_long
        type: u4
        doc: 'The ask contracts of the new quote'
  quote_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: bid_reference_number_delta
        type: u4
        doc: 'The bid reference number delta associated with the new quote'
      - id: ask_reference_number_delta
        type: u4
        doc: 'The ask reference number delta associated with the new quote'
  block_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: total_number_of_reference_number_deltas
        type: u2
        doc: 'The number of single side deletes in this block. Max possible value = 360'
      - id: reference_number_deltan
        type: u4
        doc: 'The order/quote side reference number delta associated with the cancelled order/quote. n = 0 to (Total Number – 1)'
  non_auction_options_trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'The type of non-display order on the book being matched'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day. The match number is also referenced in the Trade Break Message'
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  options_cross_trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day. The match number is also referenced in the Trade Break Message'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The BX auction session for which the message is being generated'
      - id: price_long
        type: decimal_s4_4
        doc: 'The display price of the new order being added to the book. Implied decimal with scale 1e-4'
      - id: volume_long
        type: u4
        doc: 'The total number of contracts of the new order being added to the book'
  broken_trade_or_order_execution_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction in the matching engine'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day. The match number is also referenced in the Trade Break Message'
  net_order_imbalance_indicator_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of Auction:'
      - id: paired_contracts
        type: u4
        doc: 'The total number of contracts that are eligible to be matched at the Current Reference Price. 0 for Price Improvement (PRISM) Auction'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: imbalance_price
        type: decimal_s4_4
        doc: 'The imbalance price. 0 for Price Improvement (PRISM) Auction. Implied decimal with scale 1e-4'
      - id: imbalance_volume
        type: u4
        doc: 'The imbalance contracts'
      - id: customer_firm_indicator
        type: u1
        enum: customer_firm_indicator
        doc: 'For Order Exposure (AuctionType=I) only. Indicates the order capacity:'
      - id: reserved
        size: 3
        doc: 'Reserved for future use'
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s2_2:
    seq:
      - id: mantissa
        type: s2
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'This message is sent every second for which at least one BX Depth message is being generated.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event. The format is as follows:'
    0x4c:
      id: 'base_reference_message'
      doc: 'This message indicates the base reference number to which all the order/quote/trade reference number deltas must be added to obtain the absolute order/quote BX reference number.'
    0x52:
      id: 'option_directory_message'
      doc: 'At the start of each trading day, BX disseminates options symbol directory messages for all active options symbols in the BX option system.'
    0x48:
      id: 'trading_action_message'
      doc: 'BX uses this administrative message to indicate the current trading status of an index or equity option within the BX Options Market.'
    0x4f:
      id: 'option_open_message'
      doc: 'BX plans to disseminate the Option Open Message for each option as soon as the opening is completed. Upon receipt of the open state message, firms should be advised that the option denoted in the message is now available for auto execution within the BX Options Market System. Upon receipt of the closed state message, firms should be advised that the option is no longer eligible for auto-execution within the BX Options Market System.'
    0x61:
      id: 'add_order_message_short_form'
      doc: 'An Add Order Message indicates that a new order has been accepted by the BX Option system and was added to the displayable book. The message includes a day-unique Order Reference Number used by BX to track the order.'
    0x41:
      id: 'add_order_message_long_form'
      doc: 'An Add Order Message indicates that a new order has been accepted by the BX Option system and was added to the displayable book. The message includes a day-unique Order Reference Number used by BX to track the order.'
    0x6a:
      id: 'add_quote_message_short_form'
      doc: 'An Add Quote Message indicates that a new quote has been accepted by the BX Option system and was added to the displayable book. The message includes a unique'
    0x4a:
      id: 'add_quote_message_long_form'
      doc: 'An Add Quote Message indicates that a new quote has been accepted by the BX Option system and was added to the displayable book. The message includes a unique'
    0x45:
      id: 'single_side_executed_message'
      doc: 'A “Side order” represents an order or one side of a quote.'
    0x43:
      id: 'single_side_order_executed_with_price_message'
      doc: 'This message is sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price. Since the execution price is different than the display price of the original Add/Replace, BX includes a price field within this execution message. It is possible to receive multiple Single Side Executed and Single Side Executed with Price messages for the same Side order if that Side order is executed in several parts. The multiple Single Side Executed messages on the same Side order are cumulative.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_message_short_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x55:
      id: 'single_side_replace_message_long_form'
      doc: 'This message is sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. For bandwidth efficiency reasons, this message can be published in either short or long format.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'The message is sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'This message is sent whenever an order or a side of a quote is being updated for price and (or) contracts. The reference number associated with the order quote is unchanged.'
    0x6b:
      id: 'quote_replace_message_short_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x4b:
      id: 'quote_replace_message_long_form'
      doc: 'This message is sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides. These new sequence numbers replace the prior sequence numbers on the quote.'
    0x59:
      id: 'quote_delete_message'
      doc: 'The message is sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x5a:
      id: 'block_delete_message'
      doc: 'This message contains a block of Single Side Deletes. Each reference number inside the block represents an order or a side of a quote that is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'non_auction_options_trade_message'
      doc: 'This Options Trade Message is designed to provide execution details for normal match events involving non-displayable order types. (Note: There is a separate message for BX Option auction events.)'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'Options Auction Trade message is sent for every option when an auction in that option is completed. The message indicates the bulk volume associated with the auction event.'
    0x42:
      id: 'broken_trade_or_order_execution_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted by the BX Option system and was added to the displayable book. The message includes a unique'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'BX disseminates NOII data at 5-second intervals in the minutes leading up to the BX Opening Auction events. This message is also used for price improvement (PRISM) auctions.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages Outside Of Time Stamp Messages The Start Of Day Message Is The First Message Sent In Any Trading Day'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours This Message Indicates That Nasdaq Is Open And Ready To Start Accepting Orders'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start Of Market Hours This Message Is Intended To Indicate That Market Hours Orders Are Available For Execution'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End Of Market Hours This Message Is Intended To Indicate That Market Hours Orders Are No Longer Available For Execution'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours It Indicates That Nasdaq Is Now Closed And Will Not Accept Any New Orders Today It Is Still Possible To Receive Broken Trade Messages And Order Delete Messages After The End Of Day'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages This Is Always The Last Message Sent In Any Trading Day'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
  options_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
  tradable:
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
    0x59:
      id: 'is_tradable'
      doc: 'Option Is Tradable'
  mpv:
    0x45:
      id: 'everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'pilot'
      doc: 'Penny Pilot'
  current_trading_state:
    0x48:
      id: 'halt'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading'
      doc: 'Trading On Bx'
    0x42:
      id: 'buy_side_trading_suspended'
      doc: 'Buy Side Trading Suspended Ie Buy Orders Are Not Executable'
    0x53:
      id: 'sell_side_trading_suspended'
      doc: 'Sell Side Trading Suspended Ie Sell Orders Are Not Executable'
    0x59:
      id: 'open'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed'
      doc: 'Closed For Auto Execution'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable:
    0x4e:
      id: 'nonprintable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
    0x52:
      id: 'reprice'
      doc: 'Reprice'
    0x53:
      id: 'suspend'
      doc: 'Suspend'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  cross_type:
    0x4f:
      id: 'bx_opening_reopening'
      doc: 'Bx Opening Reopening Auction'
    0x50:
      id: 'bx_opening_reopening_x50'
      doc: 'Bx Opening Reopening Auction'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x49:
      id: 'exposure'
      doc: 'Order Exposure'
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement Prism Auction'
  imbalance_direction:
    0x42:
      id: 'buy'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell'
      doc: 'Sell Imbalance'
  customer_firm_indicator:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm_joint'
      doc: 'Firm Joint Back Office'
    0x4d:
      id: 'onfloor'
      doc: 'Onfloor Market Maker'
    0x50:
      id: 'professional'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer_non_registered'
      doc: 'Broker Dealer Non Registered Market Maker'

