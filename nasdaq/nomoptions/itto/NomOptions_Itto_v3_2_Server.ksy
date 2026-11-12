# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NomOptions Itto Itch v3.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nom Itto Top Order Market Data
#   Encoding: Itch
#   Version: 3.2
#   Date: 11/02/2017
#   Specification: Nasdaq ITTO.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: nasdaq_nomoptions_itto_itch_v3_2_server
  title: Nasdaq NomOptions Itto Itch v3.2
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Options Market Nom Itto Top Order Market Data Itch v3.2'

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: debug_text
        type: str
        size: _parent.server_packet_header.packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::seconds_message': seconds_message
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::base_reference_message': base_reference_message
            'sequenced_message_type::options_directory_message': options_directory_message
            'sequenced_message_type::options_trading_action_message': options_trading_action_message
            'sequenced_message_type::option_open_message': option_open_message
            'sequenced_message_type::add_order_message_short_form': add_order_message_short_form
            'sequenced_message_type::add_order_message_long_form': add_order_message_long_form
            'sequenced_message_type::add_quote_message_short_form': add_quote_message_short_form
            'sequenced_message_type::add_quote_message_long_form': add_quote_message_long_form
            'sequenced_message_type::single_side_executed_message': single_side_executed_message
            'sequenced_message_type::single_side_executed_with_price_message': single_side_executed_with_price_message
            'sequenced_message_type::order_cancel_message': order_cancel_message
            'sequenced_message_type::single_side_replace_message_short_form': single_side_replace_message_short_form
            'sequenced_message_type::single_side_replace_message_long_form': single_side_replace_message_long_form
            'sequenced_message_type::single_side_delete_message': single_side_delete_message
            'sequenced_message_type::single_side_update_message': single_side_update_message
            'sequenced_message_type::quote_replace_message_short_form': quote_replace_message_short_form
            'sequenced_message_type::quote_replace_message_long_form': quote_replace_message_long_form
            'sequenced_message_type::quote_delete_message': quote_delete_message
            'sequenced_message_type::block_single_side_delete_message': block_single_side_delete_message
            'sequenced_message_type::options_trade_non_auction_message': options_trade_non_auction_message
            'sequenced_message_type::options_cross_trade_message': options_cross_trade_message
            'sequenced_message_type::broken_trade_or_order_execution_message': broken_trade_or_order_execution_message
            'sequenced_message_type::net_order_imbalance_indicator_message': net_order_imbalance_indicator_message
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
        doc: 'The base reference number'
  options_directory_message:
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
        type: decimal_u4_4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Call option Put option'
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
        doc: 'Denotes which System Event is used to trigger the option closing process'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange. The allowable values are:'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option. See Notes below for further explanation:'
  options_trading_action_message:
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
        doc: 'Reflects the current trading state for the options security in the Nasdaq Options Market. The allowable values are:'
  option_open_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID assigned daily, valid for trading day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'The allowable values are:'
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
        type: decimal_u2_2
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
        type: decimal_u4_4
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
        type: decimal_u2_2
        doc: 'The display bid price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: decimal_u2_2
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
        type: decimal_u4_4
        doc: 'The display bid price of the new quote. Implied decimal with scale 1e-4'
      - id: bid_size_long
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask
        type: decimal_u4_4
        doc: 'The display ask price of the new quote. Implied decimal with scale 1e-4'
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
  single_side_executed_with_price_message:
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
        type: decimal_u4_4
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
        type: decimal_u2_2
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
        type: decimal_u4_4
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
        doc: '`U'' - USER `R'' REPRICE `S'' - SUSPEND'
      - id: price_long
        type: decimal_u4_4
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
        type: decimal_u2_2
        doc: 'The display bid price of the new quote. NOTE: When converted to a decimal format, this price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'The bid contracts of the new quote'
      - id: ask_price
        type: decimal_u2_2
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
        type: decimal_u4_4
        doc: 'The display bid price of the replaced quote. Implied decimal with scale 1e-4'
      - id: bid_size_long
        type: u4
        doc: 'The bid contracts of the new quote'
      - id: ask_price_long
        type: decimal_u4_4
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
  block_single_side_delete_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of timestamp. Nanoseconds since Second epoch'
      - id: num_reference_number_deltas
        type: u2
        doc: 'The number of single side deletes in this block. Max possible value = 360'
      - id: reference_number_deltas
        type: reference_number_deltas
        repeat: expr
        repeat-expr: num_reference_number_deltas
        doc: 'The block of single side deletes, one four byte reference number delta per entry at offset 4n + 7, repeated Total Number of Reference Number Deltas times'
  reference_number_deltas:
    seq:
      - id: reference_number_delta
        type: u4
        doc: 'The order/quote reference number delta associated with the executed order'
  options_trade_non_auction_message:
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
        type: decimal_u4_4
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
        doc: 'The Nasdaq auction session for which the message is being generated'
      - id: price_long
        type: decimal_u4_4
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
        type: decimal_u4_4
        doc: 'The imbalance price. 0 for Price Improvement (PRISM) Auction. Implied decimal with scale 1e-4'
      - id: imbalance_volume
        type: u4
        doc: 'The imbalance volume'
      - id: customer_firm_indicator
        type: u1
        enum: customer_firm_indicator
        doc: 'For Order Exposure (AuctionType=I) only. Indicates the order capacity:'
      - id: reserved_3
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
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

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one ITTO message is being generated. For bandwidth efficiency the timestamp is separated into this standalone Seconds message and a Nanoseconds portion carried by every other message.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x4c:
      id: 'base_reference_message'
      doc: 'Indicates the base reference number to which all the order, quote and trade reference number deltas must be added to obtain the absolute order or quote Nasdaq reference number. Sent prior to any order, quote and trade messages.'
    0x52:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates options symbol directory messages for all active options symbols in the Nasdaq option system. Intra-day updates are sent as they occur; for a given Option Id the canonical information is invariant.'
    0x48:
      id: 'options_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of an index or equity option within the Nasdaq Options Market. Prior to the start of system hours Nasdaq sends a Trading Action spin carrying T (Trading Resumption) for every contract eligible for trading; an option absent from the spin should be treated as halted.'
    0x4f:
      id: 'option_open_message'
      doc: 'Disseminated for each option as soon as the opening is completed. On the open state the option is available for auto execution within the Nasdaq Options Market System; on the closed state it is no longer eligible. Recipients should continue to process the Trading Action spin, which this message does not override.'
    0x61:
      id: 'add_order_message_short_form'
      doc: 'Indicates that a new order has been accepted by the Nasdaq Option system and was added to the displayable book, carrying a day unique Order Reference Number. The short form of the message, published for bandwidth efficiency.'
    0x41:
      id: 'add_order_message_long_form'
      doc: 'Indicates that a new order has been accepted by the Nasdaq Option system and was added to the displayable book, carrying a day unique Order Reference Number. The long form of the message, with four byte price and volume.'
    0x6a:
      id: 'add_quote_message_short_form'
      doc: 'Indicates that a new quote has been accepted by the Nasdaq Option system and was added to the displayable book, carrying unique Bid and Ask Reference Numbers. The short form of the message, published for bandwidth efficiency.'
    0x4a:
      id: 'add_quote_message_long_form'
      doc: 'Indicates that a new quote has been accepted by the Nasdaq Option system and was added to the displayable book, carrying unique Bid and Ask Reference Numbers. The long form of the message, with four byte prices and sizes.'
    0x45:
      id: 'single_side_executed_message'
      doc: 'Sent whenever a Side order, an order or one side of a quote, is executed in whole or in part. Several of these messages may be received for the same Side order when it is executed in several parts, and they are cumulative.'
    0x43:
      id: 'single_side_executed_with_price_message'
      doc: 'Sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price, so the execution price is carried in the message.'
    0x58:
      id: 'order_cancel_message'
      doc: 'Sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_message_short_form'
      doc: 'Sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. The short form of the message, published for bandwidth efficiency.'
    0x55:
      id: 'single_side_replace_message_long_form'
      doc: 'Sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. The long form of the message, with four byte price and volume.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'Sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'Sent whenever an order or a side of a quote is being updated for price and or contracts. The reference number associated with the order or quote is unchanged and it retains its priority on the book.'
    0x6b:
      id: 'quote_replace_message_short_form'
      doc: 'Sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides, replacing the prior sequence numbers. The short form of the message, published for bandwidth efficiency.'
    0x4b:
      id: 'quote_replace_message_long_form'
      doc: 'Sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides, replacing the prior sequence numbers. The long form of the message, with four byte prices and sizes.'
    0x59:
      id: 'quote_delete_message'
      doc: 'Sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x5a:
      id: 'block_single_side_delete_message'
      doc: 'Contains a block of Single Side Deletes. Each reference number inside the block represents an order or a side of a quote that is being cancelled; all remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'options_trade_non_auction_message'
      doc: 'Provides execution details for normal match events involving non displayable order types, for which no Add Order or Add Quote message is generated. Auction events are reported separately by the Options Cross Trade message.'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'Sent for every option when an auction in that option is completed, indicating the bulk volume associated with the auction event. Also used to report all executions within a price improvement (PRISM) auction. To avoid double counting of auction volume, firms should not include transactions marked as auction trades.'
    0x42:
      id: 'broken_trade_or_order_execution_message'
      doc: 'Sent whenever an execution on Nasdaq is broken, which may happen if it is found to be clearly erroneous pursuant to the Nasdaq Clearly Erroneous Policy. A trade break is final; once a trade is broken it cannot be reinstated.'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'Nasdaq disseminates Net Order Imbalance Indicator data at five second intervals in the minutes leading up to the Nasdaq Opening Auction events, and for price improvement (PRISM) auctions.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. This is always the first message sent in any trading day, typically after ~2:00am.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start of System Hours. Indicates that Nasdaq is open and ready to start accepting orders, typically 7:00am.'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start of Opening Process. Indicates that Nasdaq has started its opening auction process, typically 9:30:00am.'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End of Normal Hours Processing. Indicates that Nasdaq will no longer accept any new orders or changes to existing orders for options that trade during normal trading hours, typically 4:00:00pm.'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End of Late Hours Processing. Indicates that Nasdaq will no longer accept any new orders or changes to existing orders for options that trade during extended hours, typically 4:15:00pm.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End of System Hours. Indicates that the Nasdaq options system is now closed, typically ~5:15pm.'
    0x43:
      id: 'end_of_messages'
      doc: 'End of Messages. This is always the last message sent in any trading day, typically ~5:20pm.'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call option'
    0x50:
      id: 'put_option'
      doc: 'Put option'
  options_closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'option_is_tradable'
      doc: 'Option is tradable'
    0x4e:
      id: 'option_is_not_tradable'
      doc: 'Option is not tradable. Sent intra-day when an option is removed from the system; quotes sent for it will be rejected and existing quotes purged.'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'All prices are in penny increments'
    0x53:
      id: 'scaled'
      doc: 'Prices below $3.00 are in increments of $0.05, prices above $3.00 are in increments of $0.10'
    0x50:
      id: 'penny_pilot'
      doc: 'Prices below $3.00 are in increments of $0.01, prices above $3.00 are in increments of $0.05'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt in effect'
    0x54:
      id: 'trading_on_nasdaq'
      doc: 'Trading on Nasdaq'
    0x42:
      id: 'buy_side_trading_suspended'
      doc: 'Buy Side Trading Suspended, that is buy orders are not executable'
    0x53:
      id: 'sell_side_trading_suspended'
      doc: 'Sell Side Trading Suspended, that is sell orders are not executable'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open for auto execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed for auto execution'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  printable:
    0x4e:
      id: 'non_printable'
      doc: 'The execution should not be reflected on time and sale displays and volume calculations'
    0x59:
      id: 'printable'
      doc: 'The execution should be reflected on time and sale displays and volume calculations'
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
      id: 'buy_order'
      doc: 'The non display order on the book being matched is a buy order'
    0x53:
      id: 'sell_order'
      doc: 'The non display order on the book being matched is a sell order'
  cross_type:
    0x4f:
      id: 'nasdaq_opening_reopening_auction'
      doc: 'Nasdaq Opening or Reopening Auction'
    0x50:
      id: 'price_improvement_auction'
      doc: 'Price Improvement (PRISM) Auction'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'price_improvement_auction'
      doc: 'Price Improvement (PRISM) Auction'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell imbalance'
  customer_firm_indicator:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm_joint_back_office'
      doc: 'Firm or Joint Back Office (JBO)'
    0x4d:
      id: 'on_floor_market_maker'
      doc: 'On-floor Market Maker'
    0x50:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer or Non Registered Market Maker'
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one ITTO message is being generated. For bandwidth efficiency the timestamp is separated into this standalone Seconds message and a Nanoseconds portion carried by every other message.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x4c:
      id: 'base_reference_message'
      doc: 'Indicates the base reference number to which all the order, quote and trade reference number deltas must be added to obtain the absolute order or quote Nasdaq reference number. Sent prior to any order, quote and trade messages.'
    0x52:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates options symbol directory messages for all active options symbols in the Nasdaq option system. Intra-day updates are sent as they occur; for a given Option Id the canonical information is invariant.'
    0x48:
      id: 'options_trading_action_message'
      doc: 'Nasdaq uses this administrative message to indicate the current trading status of an index or equity option within the Nasdaq Options Market. Prior to the start of system hours Nasdaq sends a Trading Action spin carrying T (Trading Resumption) for every contract eligible for trading; an option absent from the spin should be treated as halted.'
    0x4f:
      id: 'option_open_message'
      doc: 'Disseminated for each option as soon as the opening is completed. On the open state the option is available for auto execution within the Nasdaq Options Market System; on the closed state it is no longer eligible. Recipients should continue to process the Trading Action spin, which this message does not override.'
    0x61:
      id: 'add_order_message_short_form'
      doc: 'Indicates that a new order has been accepted by the Nasdaq Option system and was added to the displayable book, carrying a day unique Order Reference Number. The short form of the message, published for bandwidth efficiency.'
    0x41:
      id: 'add_order_message_long_form'
      doc: 'Indicates that a new order has been accepted by the Nasdaq Option system and was added to the displayable book, carrying a day unique Order Reference Number. The long form of the message, with four byte price and volume.'
    0x6a:
      id: 'add_quote_message_short_form'
      doc: 'Indicates that a new quote has been accepted by the Nasdaq Option system and was added to the displayable book, carrying unique Bid and Ask Reference Numbers. The short form of the message, published for bandwidth efficiency.'
    0x4a:
      id: 'add_quote_message_long_form'
      doc: 'Indicates that a new quote has been accepted by the Nasdaq Option system and was added to the displayable book, carrying unique Bid and Ask Reference Numbers. The long form of the message, with four byte prices and sizes.'
    0x45:
      id: 'single_side_executed_message'
      doc: 'Sent whenever a Side order, an order or one side of a quote, is executed in whole or in part. Several of these messages may be received for the same Side order when it is executed in several parts, and they are cumulative.'
    0x43:
      id: 'single_side_executed_with_price_message'
      doc: 'Sent whenever an incoming Side order is executed against the book in whole or in part at a price different from the initial display price, so the execution price is carried in the message.'
    0x58:
      id: 'order_cancel_message'
      doc: 'Sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'single_side_replace_message_short_form'
      doc: 'Sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. The short form of the message, published for bandwidth efficiency.'
    0x55:
      id: 'single_side_replace_message_long_form'
      doc: 'Sent whenever an order or one side of a quote on the book is replaced. The replacement has a new sequence number and replaces the prior sequence number. The long form of the message, with four byte price and volume.'
    0x44:
      id: 'single_side_delete_message'
      doc: 'Sent when an order or a side of a quote is being cancelled. All remaining contracts are no longer accessible so the side should be removed from the book.'
    0x47:
      id: 'single_side_update_message'
      doc: 'Sent whenever an order or a side of a quote is being updated for price and or contracts. The reference number associated with the order or quote is unchanged and it retains its priority on the book.'
    0x6b:
      id: 'quote_replace_message_short_form'
      doc: 'Sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides, replacing the prior sequence numbers. The short form of the message, published for bandwidth efficiency.'
    0x4b:
      id: 'quote_replace_message_long_form'
      doc: 'Sent whenever a quote on the book is replaced. The replaced quote has new sequence numbers on both sides, replacing the prior sequence numbers. The long form of the message, with four byte prices and sizes.'
    0x59:
      id: 'quote_delete_message'
      doc: 'Sent when a single quote is being cancelled. All remaining contracts are no longer accessible so the quote should be removed from the book.'
    0x5a:
      id: 'block_single_side_delete_message'
      doc: 'Contains a block of Single Side Deletes. Each reference number inside the block represents an order or a side of a quote that is being cancelled; all remaining contracts are no longer accessible so the side should be removed from the book.'
    0x50:
      id: 'options_trade_non_auction_message'
      doc: 'Provides execution details for normal match events involving non displayable order types, for which no Add Order or Add Quote message is generated. Auction events are reported separately by the Options Cross Trade message.'
    0x51:
      id: 'options_cross_trade_message'
      doc: 'Sent for every option when an auction in that option is completed, indicating the bulk volume associated with the auction event. Also used to report all executions within a price improvement (PRISM) auction. To avoid double counting of auction volume, firms should not include transactions marked as auction trades.'
    0x42:
      id: 'broken_trade_or_order_execution_message'
      doc: 'Sent whenever an execution on Nasdaq is broken, which may happen if it is found to be clearly erroneous pursuant to the Nasdaq Clearly Erroneous Policy. A trade break is final; once a trade is broken it cannot be reinstated.'
    0x49:
      id: 'net_order_imbalance_indicator_message'
      doc: 'Nasdaq disseminates Net Order Imbalance Indicator data at five second intervals in the minutes leading up to the Nasdaq Opening Auction events, and for price improvement (PRISM) auctions.'

