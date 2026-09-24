# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgaEquities MulticastDepthOfBook Spin v2.41.66
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Multicast Depth Of Book
#   Encoding: Spin
#   Version: 2.41.66
#   Date: 04/01/2026
#   Specification: US_EQUITIES_OPTIONS_MULTICAST_PITCH_SPECIFICATION.pdf
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
  id: cboe_edgaequities_multicastdepthofbook_spin_v2_41_66
  title: Cboe EdgaEquities MulticastDepthOfBook Spin v2.41.66
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edga Equities Multicast Depth Of Book Spin v2.41.66'
doc-ref: http://markets.cboe.com/us/equities/support/technical

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
        doc: 'Spin is available which is current through this sequence number'
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
            'message_type::instrument_definition_request_message': instrument_definition_request_message
            'message_type::instrument_definition_response_message': instrument_definition_response_message
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
        doc: 'SessionSubId supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Username supplied by Cboe'
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
        doc: 'Password supplied by Cboe'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted or reason for reject. A = Login accepted, N = Not authorized (invalid username/password), B = Session in use, S = Invalid session'
  spin_image_available_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  spin_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: order_count
        type: u4
        doc: 'Number of Add Order messages which will be contained in this spin'
      - id: spin_response_status
        type: u1
        enum: spin_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject. A = Accepted, O = Out of range, S = Spin already in process'
  spin_finished_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_request_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
  instrument_definition_response_message:
    seq:
      - id: sequence
        type: u4
        doc: 'Spin is available which is current through this sequence number'
      - id: instrument_count
        type: u4
        doc: 'Number of Symbol Mapping and Complex Instrument Definition messages (if applicable) which will be contained in this spin'
      - id: instrument_definition_response_status
        type: u1
        enum: instrument_definition_response_status
        doc: 'Accepted or reason for reject. All non-A status codes should be interpreted as a reject. A = Accepted, O = Out of range, S = Spin already in process'
  time_message:
    seq:
      - id: time
        type: u4
        doc: 'Number of whole seconds elapsed since the start of the current Eastern Time calendar day, derived by converting the current Eastern wall clock time (HH:MM:SS) to seconds'
  unit_clear_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
  add_order_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags bit field used in Add Order messages. Bit 0 is reserved and set to 1. Bit 3 (AON) is Options only'
  add_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_3
        type: b3
        doc: 'Bits 0-2 Reserved (Bit 0 set to 1)'
      - id: aon
        type: b1
        doc: 'Options only. 0 = Order is a firm quote, 1 = Order is AON (All or None)'
      - id: unused_4
        type: b4
        doc: 'Bits 4-7 Reserved'
  add_order_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags bit field used in Add Order messages. Bit 0 is reserved and set to 1. Bit 3 (AON) is Options only'
  add_order_expanded_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: add_flags
        type: add_flags
        doc: 'Add Flags bit field used in Add Order messages. Bit 0 is reserved and set to 1. Bit 3 (AON) is Options only'
      - id: participant_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Optionally specified. If specified, the MPID (equities) of firm attributed to this quote. Alternatively "RTAL" for retail specified orders (equities). Space filled otherwise'
      - id: customer_indicator
        type: u1
        enum: customer_indicator
        doc: 'Space filled on all equities markets. R = Retail Priority order (EDGX Equities only)'
  order_executed_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: executed_quantity
        type: u4
        doc: 'Number of shares/contracts executed'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  order_executed_at_price_size_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
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
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
  reduce_size_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_long
        type: u4
        doc: 'Number of shares/contracts canceled'
  reduce_size_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: canceled_quantity_short
        type: u2
        doc: 'Number of shares/contracts canceled'
  modify_order_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order messages'
  modify_flags:
    meta:
      bit-endian: le
    seq:
      - id: display
        type: b1
        doc: 'Bit 0 - Display. 0 = Order is not aggregated in the Cboe SIP quote, 1 = Order is aggregated in the Cboe SIP quote'
      - id: maintain_priority
        type: b1
        doc: 'Bit 1 - Maintain Priority. 0 = Reset Priority, 1 = Maintain Priority'
      - id: unused_6
        type: b6
        doc: 'Bits 2-7 Reserved'
  modify_order_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: modify_flags
        type: modify_flags
        doc: 'Modify Flags bit field used in Modify Order messages'
  delete_order_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
  trade_long_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  trade_short_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_short
        type: u2
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_short
        type: decimal_u2_2
        doc: 'The limit order price. Implied decimal with scale 1e-2'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  trade_expanded_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: order_id
        type: u8
        doc: 'Day-specific identifier assigned to this order'
      - id: side_indicator
        type: u1
        enum: side_indicator
        doc: 'B = Buy Order, S = Sell Order'
      - id: quantity_long
        type: u4
        doc: 'Number of shares/contracts being added to the book (may be less than the number entered)'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  trade_break_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: execution_id
        type: u8
        doc: 'Cboe generated day-unique execution identifier of this execution. Execution Id is also referenced in the Trade Break message'
  end_of_session_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
  trading_status_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'A = Accepting Orders for Queuing (Equities only), H = Halted, Q = Quote-Only, S = Exchange Specific Suspension, T = Trading'
      - id: reg_sho_action
        type: u1
        enum: reg_sho_action
        doc: '0 = No price test in effect, 1 = Reg SHO price test restriction in effect'
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
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Opening Auction, C = Closing Auction, H = Halt Auction, I = IPO Auction, M = Cboe Market Close'
      - id: reference_price
        type: u8
        doc: 'BBO Collared auction price. Shares matched for Cboe Market Close'
      - id: buy_shares
        type: u4
        doc: 'Number of shares on buy side at the Reference Price. Shares matched for Cboe Market Close'
      - id: sell_shares
        type: u4
        doc: 'Number of shares on sell side at the Reference Price. Shares matched for Cboe Market Close'
      - id: indicative_price
        type: u8
        doc: 'Price at which the auction book and the continuous book would match'
      - id: auction_only_price
        type: u8
        doc: 'Price at which the auction book would match using only Eligible Auction Orders'
  auction_summary_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: stock_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol right padded with spaces'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'O = Opening Auction, C = Closing Auction, H = Halt Auction, I = IPO Auction, M = Cboe Market Close'
      - id: price_long
        type: decimal_u8_4
        doc: 'The limit order price. Implied decimal with scale 1e-4'
      - id: shares
        type: u4
        doc: 'Cumulative number of shares/contracts executed during the auction or CMC matching'
  retail_price_improvement_message:
    seq:
      - id: time_offset
        type: u4
        doc: 'Nanosecond offset from last unit timestamp'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol right padded with spaces'
      - id: retail_price_improvement
        type: u1
        enum: retail_price_improvement
        doc: 'B = Buy Side RPI, S = Sell Side RPI, A = Buy and Sell RPI, N = No RPI'
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
      doc: 'The Login message is the first message sent to the Spin Server by a user''s process after the connection to the Spin Server is established. Failure to login before sending any other message type will result in the connection being dropped by the Spin Server. The format of the Login message for the Spin Server is identical to that of the GRP.'
    0x02:
      id: 'login_response_message'
      doc: 'The Login Response message is sent by the Spin Server to a user''s process in response to a Login message. The status field is used to reflect an accepted login or the reason the session was not accepted. If login fails, the connection will be dropped after the Login Response message is sent.'
    0x80:
      id: 'spin_image_available_message'
      doc: 'The Spin Image Available message is sent once per second and indicates through what sequence number a spin is available.'
    0x81:
      id: 'spin_request_message'
      doc: 'The Spin Request message is used by a user''s process to request transmission of a spin of the unit''s order book.'
    0x82:
      id: 'spin_response_message'
      doc: 'The Spin Response message is sent in response to a user''s Spin Request message indicating whether a spin will be sent.'
    0x83:
      id: 'spin_finished_message'
      doc: 'The Spin Finished message is sent to indicate that all messages for the spin requested have been sent. A Spin Finished message is only sent if a Spin Request was not rejected. Upon receipt of a Spin Finished message, any buffered multicast messages should be applied to the member''s copy of the book to make it current.'
    0x84:
      id: 'instrument_definition_request_message'
      doc: 'The Instrument Definition Request message is used by a user''s process to request transmission of this unit''s Symbol Mappings and Complex Instrument Definitions. Included for consistency with the Options Spin Server; not typically used on Equities feeds.'
    0x85:
      id: 'instrument_definition_response_message'
      doc: 'The Instrument Definition Response message is sent in response to a user''s Instrument Definition Request message indicating whether a spin will be sent.'
    0x86:
      id: 'instrument_definition_finished_message'
      doc: 'The Instrument Definition Finished message is sent to indicate that all Symbol Mapping and Complex Instrument Definition messages for this unit have been sent. An Instrument Definition Finished message is only sent if an Instrument Definition Request was not rejected.'
    0x20:
      id: 'time_message'
      doc: 'A Time message is immediately generated and sent when there is a PITCH event for a given clock second. If there is no PITCH event for a given clock second, then no Time message is sent for that second. The Time field is the number of seconds relative to midnight Eastern Time. All subsequent time offset fields for the same unit will use the new Time message value as the base until another Time message is received for the same unit.'
    0x97:
      id: 'unit_clear_message'
      doc: 'The Unit Clear message instructs feed recipients to clear all orders for the Cboe book in the unit specified in the Sequenced Unit Header message. For Equities only, this message will be sent at startup each day. It would also be distributed in certain recovery events such as a data center fail-over.'
    0x21:
      id: 'add_order_long_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order Id assigned by Cboe to the order.'
    0x22:
      id: 'add_order_short_message'
      doc: 'An Add Order message represents a newly accepted visible order on the Cboe book. It includes a day-specific Order Id assigned by Cboe to the order.'
    0x2f:
      id: 'add_order_expanded_message'
      doc: 'The expanded version of the Add Order message has been made available to accommodate larger symbol sizes possible through the ISRA plan.'
    0x23:
      id: 'order_executed_message'
      doc: 'Order Executed messages are sent when a visible order on the Cboe book is executed in whole or in part. The execution price equals the limit order price found in the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id.'
    0x24:
      id: 'order_executed_at_price_size_message'
      doc: 'Order Executed at Price/Size messages are sent when a visible order on the Cboe book is executed in whole or in part at a different price than the limit price on the original Add Order message or the limit order price in the latest Modify Order message referencing the Order Id. If the Remaining Quantity field contains a 0 the order should be completely removed from the book.'
    0x25:
      id: 'reduce_size_long_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x26:
      id: 'reduce_size_short_message'
      doc: 'Reduce Size messages are sent when a visible order on the Cboe book is partially reduced.'
    0x27:
      id: 'modify_order_long_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message. Note that Modify Order messages that appear to be "No Ops" (i.e. they do not appear to modify any relevant fields) will still lose priority.'
    0x28:
      id: 'modify_order_short_message'
      doc: 'The Modify Order message is sent whenever an open order is visibly modified. The Order Id refers to the Order Id of the original Add Order message.'
    0x29:
      id: 'delete_order_message'
      doc: 'The Delete Order message is sent whenever a booked order is cancelled or leaves the order book. The Order Id refers to the Order Id of the original Add Order message. An order that is deleted from the book may return to the book later under certain circumstances. Therefore, a Delete Order message does not indicate that a given Order Id will not be sent again on a subsequent Add Order message.'
    0x2a:
      id: 'trade_long_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers. Trade messages are necessary to calculate Cboe execution-based data. Trade messages do not alter the book and can be ignored if messages are being used solely to build a book.'
    0x2b:
      id: 'trade_short_message'
      doc: 'The Trade message provides information about executions of non-displayed orders on the Cboe book and routed executions to other trading centers.'
    0x30:
      id: 'trade_expanded_message'
      doc: 'The expanded version of the Trade message has been made available to accommodate larger symbol sizes possible through the ISRA plan.'
    0x2c:
      id: 'trade_break_message'
      doc: 'The Trade Break message is sent whenever an execution on Cboe is broken. Trade breaks are rare and only affect applications that rely upon Cboe execution-based data. Applications that simply build a Cboe book can ignore Trade Break messages.'
    0x2d:
      id: 'end_of_session_message'
      doc: 'The End of Session message is sent for each unit when the unit shuts down. No more sequenced messages will be delivered for this unit, but heartbeats from the unit may be received.'
    0x31:
      id: 'trading_status_message'
      doc: 'The Trading Status message is used to indicate the current trading status of a security. A Trading Status message will be sent whenever a security''s trading status changes. Trading Status of S is to be implied at system startup for all symbols. Sequenced Trading Status messages are sent upon system start up for all active securities with Trading Status = ''S'' (suspended). Trading Status messages will continue to be published upon symbol state changes, such as at the beginning of order acceptance.'
    0x95:
      id: 'auction_update_message'
      doc: 'BYX and BZX Equities Only. Auction Update messages are used to disseminate Cboe price and size information during auctions for Cboe listed securities and for Cboe Market Close (CMC) crosses on BZX, and for Periodic Auctions on BYX. This is the BZX Equities layout (Table 31).'
    0x96:
      id: 'auction_summary_message'
      doc: 'BYX Equities, BZX Equities, and Options Only. Auction Summary messages are used to disseminate the results of an auction of a Cboe listed security on BZX, the results of an Opening or Re-Opening of any options series on C1, and for Periodic Auctions on BYX. An Auction Summary message will be sent for Cboe Market Close (CMC) once the official closing price for each security is available.'
    0x98:
      id: 'retail_price_improvement_message'
      doc: 'BYX and (effective 04/10/26) EDGX Only. The Retail Price Improvement message is a Retail Liquidity Indicator (RLI) that includes symbol and side, but not price and size. An RLI will be disseminated when there is a Retail Price Improving (RPI) order present for a symbol on the Exchange order book OR to indicate a RPI order is no longer available. Cboe will disseminate a Retail Price Improvement message when the resting RPI order is priced better than the NBBO.'
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
      id: 'out_of_range_sequence_requested_is_greater_than_sequence_available_by_the_next_spin'
      doc: 'Out Of Range Sequence Requested Is Greater Than Sequence Available By The Next Spin'
    0x53:
      id: 'spin_already_in_progress_only_one_spin_can_be_running_at_a_time'
      doc: 'Spin Already In Progress Only One Spin Can Be Running At A Time'
  instrument_definition_response_status:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_range_sequence_must_be_0'
      doc: 'Out Of Range Sequence Must Be 0'
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
  aon:
    0:
      id: 'order_is_a_firm_quote'
      doc: 'Order Is A Firm Quote'
    1:
      id: 'order_is_aon_all_or_none'
      doc: 'Order Is Aon All Or None'
  customer_indicator:
    0x52:
      id: 'retail_priority_order_edgx_equities_only'
      doc: 'Retail Priority Order Edgx Equities Only'
  display:
    0:
      id: 'order_is_not_aggregated_in_the_cboe_sip_quote'
      doc: 'Order Is Not Aggregated In The Cboe Sip Quote'
    1:
      id: 'order_is_aggregated_in_the_cboe_sip_quote'
      doc: 'Order Is Aggregated In The Cboe Sip Quote'
  maintain_priority:
    0:
      id: 'reset_priority'
      doc: 'Reset Priority'
    1:
      id: 'maintain_priority'
      doc: 'Maintain Priority'
  trading_status:
    0x41:
      id: 'accepting_orders_for_queuing_equities_only'
      doc: 'Accepting Orders For Queuing Equities Only'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'quote_only'
      doc: 'Quote Only'
    0x53:
      id: 'exchange_specific_suspension'
      doc: 'Exchange Specific Suspension'
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
    0x4d:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'
    0x50:
      id: 'periodic_auction_byx_only'
      doc: 'Periodic Auction Byx Only'
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

