# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities MulticastDepthOfBook Spin v2.20.4
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Spin
#   Version: 2.20.4
#   Date: 1/29/2014
#   Specification: BATS_MC_PITCH_Specification.pdf
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
  id: cboe_bzxequities_multicastdepthofbook_spin_v2_20_4
  title: Cboe BzxEquities MulticastDepthOfBook Spin v2.20.4
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Multicast Depth Of Book Spin v2.20.4'
doc-ref: https://web.archive.org/web/20151001003945/http://www.batstrading.com/resources/membership/BATS_MC_PITCH_Specification.pdf

seq:
  - id: packet_header
    type: packet_header_struct
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
      - id: length
        type: u2
        doc: 'Length of entire block of messages. Includes this header and Message Count messages to follow'
      - id: message_count
        type: u1
        doc: 'Number of messages to follow this header'
      - id: unit
        type: u1
        doc: 'Unit that applies to messages included in this header'
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_message': login_message
            'message_type::login_response_message': login_response_message
            'message_type::spin_image_available_message': spin_image_available_message
            'message_type::spin_request_message': spin_request_message
            'message_type::spin_response_message': spin_response_message
            'message_type::spin_finished_message': spin_finished_message
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
            'message_type::trade_expanded_message': trade_expanded_message
            'message_type::trade_break_message': trade_break_message
            'message_type::end_of_session_message': end_of_session_message
            'message_type::symbol_mapping_message': symbol_mapping_message
            'message_type::trading_status_message': trading_status_message
            'message_type::auction_update_message': auction_update_message
            'message_type::auction_summary_message': auction_summary_message
            'message_type::retail_price_improvement_message': retail_price_improvement_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Current Pitch message length'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'SessionSubId supplied by Bats'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Bats'
      - id: filler
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '(space filled)'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password supplied by Bats'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this'
      - id: order_count
        type: u4
        doc: 'Number of Add Order messages which will be contained in this spin; 0 if spin cannot be satisfied'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this'
  time_message:
    seq:
      - id: time
        type: second_timestamp
        doc: 'Number of whole seconds. Seconds since Midnight epoch'
  unit_clear_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
  add_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Order is displayed in the Sip quote'
      - id: unused_7
        type: b7
        doc: 'Reserved 1-7 Bits'
  add_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_2
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_short_price_2
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags'
  add_order_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, MPID (equities) or Executing Broker (options) of firm attributed to this quote. Space filled'
  order_executed_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
      - id: execution_id
        type: u8
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
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
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_binary_2
        type: u2
        doc: 'Number of shares/contracts'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags'
  modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Order is displayed in the Sip quote'
      - id: maintain_priority
        type: b1
        doc: 'Order keeps its priority rather than resetting it'
      - id: unused_6
        type: b6
        doc: 'Reserved 2-7 Bits'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_binary_2
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_binary_short_price_2
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags'
  delete_order_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_long_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
  trade_short_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_2
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_short_price_2
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
  trade_expanded_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: '"B" = Buy Order "S" = Sell Order'
      - id: quantity_binary_4
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_binary_long_price_8
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
  trade_break_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: execution_id
        type: u8
        doc: 'BATS generated day-unique execution identifier of this execution. Execution Id is also referenced in the'
  end_of_session_message:
    seq:
      - id: timestamp
        type: u4
        doc: 'Nanosecond offset from last'
  symbol_mapping_message:
    seq:
      - id: feed_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: osi_symbol
        type: str
        size: 21
        encoding: ASCII
        pad-right: 0x20
        doc: 'OSI Symbol Symbol'
      - id: symbol_condition
        type: u1
        enum: symbol_condition
        doc: '"N" = Normal'
  trading_status_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: '"H" = Halted "Q" = Quote-Only "T" = Trading Reg SHO'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: '"0" = No price test in effect "1" = Reg SHO price test restriction in effect'
      - id: reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
      - id: second_reserved_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved'
  auction_update_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: '"O" = Opening Auction "C" = Closing Auction "H" = Halt Auction "I" = IPO Auction'
      - id: reference_price
        type: u8
        doc: 'BBO Collared auction price (see Auction Process Spec)'
      - id: buy_shares
        type: u4
        doc: 'Number of shares on buy side at the Reference Price'
      - id: sell_shares
        type: u4
        doc: 'Number of shares on sell side at the Reference Price'
      - id: indicative_price
        type: u8
        doc: 'Price at which the auction book and the continuous book would match'
      - id: auction_only_price
        type: u8
        doc: 'Price at which the auction book would match using only Eligible Auction'
  auction_summary_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: '"O" = Opening Auction "C" = Closing Auction "H" = Halt Auction "I" = IPO Auction'
      - id: price_binary_8
        type: u8
        doc: 'Auction price'
      - id: shares
        type: u4
        doc: 'Cumulative number of shares executed'
  retail_price_improvement_message:
    seq:
      - id: time_offset
        type: nanosecond_offset
        doc: 'Nanosecond offset from last. Nanoseconds since Second epoch'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: '"B" = Buy Side RPI "S" = Sell Side RPI "A" = Buy & Sell RPI'
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

enums:
  message_type:
    0x01:
      id: 'login_message'
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the Grp.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'Spin Image Available message'
    0x81:
      id: 'spin_request_message'
      doc: 'Spin Request message'
    0x82:
      id: 'spin_response_message'
      doc: 'Spin Response message'
    0x83:
      id: 'spin_finished_message'
      doc: 'Spin Finished message'
    0x20:
      id: 'time_message'
      doc: 'Time message'
    0x97:
      id: 'unit_clear_message'
      doc: 'Unit Clear message'
    0x21:
      id: 'add_order_long_message'
      doc: 'Add Order message (long)'
    0x22:
      id: 'add_order_short_message'
      doc: 'Add Order message (short)'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'Add Order message (expanded)'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed message'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size message (long)'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size message (short)'
    0x27:
      id: 'modify_order_long_message'
      doc: 'Modify Order message (long)'
    0x28:
      id: 'modify_order_short_message'
      doc: 'Modify Order message (short)'
    0x29:
      id: 'delete_order_message'
      doc: 'Delete Order message'
    0x2a:
      id: 'trade_long_message'
      doc: 'Trade message (long)'
    0x2b:
      id: 'trade_short_message'
      doc: 'Trade message (short)'
    0x30:
      id: 'trade_expanded_message'
      doc: 'Trade message (long)'
    0x2c:
      id: 'trade_break_message'
      doc: 'Trade Break message'
    0x2d:
      id: 'end_of_session_message'
      doc: 'End of Session message'
    0x2e:
      id: 'symbol_mapping_message'
      doc: 'Symbol Mapping message'
    0x31:
      id: 'trading_status_message'
      doc: 'Trading Status message'
    0x95:
      id: 'auction_update_message'
      doc: 'Auction Update message'
    0x96:
      id: 'auction_summary_message'
      doc: 'Auction Summary message'
    0x98:
      id: 'retail_price_improvement_message'
      doc: 'Retail Price Improvement message'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_username_password'
      doc: 'Not Authorized Invalid Username Password'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
  spin_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_spin_no_longer_available'
      doc: 'Out Of Range Spin No Longer Available'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  side_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  display:
    0:
      id: 'not_displayed_in_sip'
      doc: 'Not Displayed In Sip'
    1:
      id: 'displayed_in_sip'
      doc: 'Displayed In Sip'
  maintain_priority:
    0:
      id: 'reset_priority'
      doc: 'Reset Priority'
    1:
      id: 'maintain_priority'
      doc: 'Maintain Priority'
  symbol_condition:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x43:
      id: 'closing_only'
      doc: 'Closing Only'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x54:
      id: 'trading'
      doc: 'Trading'
  reg_sho_action:
    0x30:
      id: 'no_price_test_in_effect'
      doc: 'No Price Test In Effect'
    0x31:
      id: 'reg_sho_price_test_restriction_in_effect'
      doc: 'Reg Sho Price Test Restriction In Effect'
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
    0x49:
      id: 'ipo_auction'
      doc: 'Ipo Auction'
  retail_price_improvement:
    0x42:
      id: 'buy_side_rpi'
      doc: 'Buy Side Rpi'
    0x53:
      id: 'sell_side_rpi'
      doc: 'Sell Side Rpi'
    0x41:
      id: 'buy_and_sell_rpi'
      doc: 'Buy And Sell Rpi'
    0x4e:
      id: 'no_rpi'
      doc: 'No Rpi'

