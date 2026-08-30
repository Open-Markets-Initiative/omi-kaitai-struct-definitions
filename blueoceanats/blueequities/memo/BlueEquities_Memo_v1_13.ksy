# ---------------------------------------------------------------------
# Kaitai struct definition for: BlueOceanAts BlueEquities Memo Sbe v1.13
#
# Protocol:
#   Organization: Blue Ocean Technologies
#   Protocol: Members Orders
#   Encoding: Simple Binary Encoding
#   Version: 1.13
#   Date: 1/1/2024
#   Specification: MEMO SBE (v1.13) BOATS.pdf
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
  id: blueoceanats_blueequities_memo_sbe_v1_13
  title: BlueOceanAts BlueEquities Memo Sbe v1.13
  license: GPL-3.0
  endian: be

doc: 'Blue Ocean Technologies Blue Equities Members Orders Sbe v1.13'
doc-ref: https://blueocean-tech.io/trading-updates

seq:
  - id: common_header
    type: common_header_struct
    doc: 'The header every frame opens with, the message type and the length of the body following it'
  - id: data
    type:
      switch-on: common_header.message_type
      cases:
        'message_type::login_request': login_request_message
        'message_type::replay_request': replay_request_message
        'message_type::replay_all_request': replay_all_request_message
        'message_type::stream_request': stream_request_message
        'message_type::unsequenced_message': unsequenced_message
        'message_type::login_accepted': login_accepted_message
        'message_type::login_rejected': login_rejected_message
        'message_type::start_of_session': start_of_session_message
        'message_type::replay_begin': replay_begin_message
        'message_type::replay_rejected': replay_rejected_message
        'message_type::replay_complete': replay_complete_message
        'message_type::stream_begin': stream_begin_message
        'message_type::stream_rejected': stream_rejected_message
        'message_type::stream_complete': stream_complete_message
        'message_type::sequenced_message': sequenced_message

types:
  common_header_struct:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'The kind of frame that follows the header; the client sends types 100 and above, the server sends the rest'
      - id: message_length
        type: u2
        doc: 'Total bytes following the header (does not include this header); zero on a heartbeat'
  login_request_message:
    seq:
      - id: token_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'The kind of login token supplied, P for a static password'
      - id: token
        type: str
        size: 1
        encoding: ASCII
        doc: 'The login token, formatted user:password for a static password token'
  replay_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'Identifier of the session, as named by Start of Session and as copied onto a replay or stream request'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number on a request, and the sequence of the next message in the stream on a begin'
      - id: count
        type: u4
        doc: 'Total number of messages to include in the replay'
  replay_all_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'Identifier of the session, as named by Start of Session and as copied onto a replay or stream request'
  stream_request_message:
    seq:
      - id: session_id
        type: u8
        doc: 'Identifier of the session, as named by Start of Session and as copied onto a replay or stream request'
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number on a request, and the sequence of the next message in the stream on a begin'
  unsequenced_message:
    seq:
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  sbe_message:
    seq:
      - id: sbe_header
        type: sbe_header
        doc: 'Sbe Header'
      - id: payload
        size: sbe_header.block_length
        type:
          switch-on: sbe_header.template_id
          cases:
            'template_id::new_order_single_message': new_order_single_message
            'template_id::order_cancel_replace_request_message': order_cancel_replace_request_message
            'template_id::order_cancel_request_message': order_cancel_request_message
            'template_id::mass_cancel_request_message': mass_cancel_request_message
            'template_id::execution_report_pending_new_message': execution_report_pending_new_message
            'template_id::execution_report_new_message': execution_report_new_message
            'template_id::execution_report_rejected_message': execution_report_rejected_message
            'template_id::execution_report_trade_message': execution_report_trade_message
            'template_id::execution_report_pending_cancel_message': execution_report_pending_cancel_message
            'template_id::pending_mass_cancel_message': pending_mass_cancel_message
            'template_id::execution_report_canceled_message': execution_report_canceled_message
            'template_id::mass_cancel_done_message': mass_cancel_done_message
            'template_id::execution_report_pending_replace_message': execution_report_pending_replace_message
            'template_id::execution_report_replaced_message': execution_report_replaced_message
            'template_id::execution_report_trade_correction_message': execution_report_trade_correction_message
            'template_id::execution_report_trade_break_message': execution_report_trade_break_message
            'template_id::execution_report_restatement_message': execution_report_restatement_message
            'template_id::order_cancel_reject_message': order_cancel_reject_message
            'template_id::mass_cancel_reject_message': mass_cancel_reject_message
  sbe_header:
    seq:
      - id: block_length
        type: u2
        doc: 'Blue Ocean Udp Block length'
      - id: template_id
        type: u1
        enum: template_id
        doc: 'T8 Identifier of the message template'
      - id: schema_id
        type: u1
        doc: 'The identifier of a message schema'
      - id: version
        type: u2
        doc: 'The version number of the message schema that was used to encode a message'
  new_order_single_message:
    seq:
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'Capacity of the customer placing the order; defaults to MemberTradingOnTheirOwnAccount when unspecified'
      - id: exec_inst
        type: exec_inst
        doc: 'Instructions for order handling on exchange; a bit set where setting a bit enables its instruction and bit 0 is the least significant'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'Signed amount added to the peg for a pegged order. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'Defines the type of peg used in a peg order. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'Expiration time of a GoodForTime order, at least one millisecond in the future; defaults to the end of the post market session, nanoseconds since the unix epoch. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1
        enum: display_method
        doc: 'The method used when refreshing displayed quantity of a reserve order; null for a fully displayed order. Nullable, No Value = 0'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'Defines the replenishment timing behavior for a reserve order. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'The minimum increment used when calculating a random refresh of the display quantity. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a reprice; an order is not repriced when this is absent. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when the market is locked or crossed. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom self trade prevention group. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'The desired behavior in the event of a wash; the null value disables self trade prevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set applied to this order; the null value disables custom risk controls. Nullable, No Value = 65535'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  exec_inst:
    seq:
      - id: participate_do_not_initiate
        type: b1
        doc: 'Post only, the order does not initiate an execution'
      - id: intermarket_sweep
        type: b1
        doc: 'Intermarket sweep order'
      - id: external_routing_not_allowed
        type: b1
        doc: 'Book only, the order is not externally routable'
      - id: reserved_13
        type: b13
        doc: '13 reserved bits'
  parties_groups:
    seq:
      - id: repeating_group_dimensions
        type: repeating_group_dimensions
        doc: 'Block preceding each repeating group, the space reserved for a single entry and the number of entries'
      - id: parties_group
        type: parties_group
        repeat: expr
        repeat-expr: repeating_group_dimensions.num_in_group
        doc: 'One party identifier associated with the order'
  repeating_group_dimensions:
    seq:
      - id: block_length_uint_8
        type: u1
        doc: 'The total space reserved for a single repeating group entry'
      - id: num_in_group
        type: u1
        doc: 'A counter representing the number of entries in the repeating group'
  parties_group:
    seq:
      - id: party_i_d_new_order_single_party_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'The Mpid as stated in the order, or the default Mpid for the account when the order did not specify one'
      - id: party_id_source
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identifies the class or source of the Party Id; the exchange currently accepts C for a generally accepted Mpid'
      - id: party_role
        type: u1
        enum: party_role
        doc: 'Identifies the type or role of the Party Id specified'
  order_cancel_replace_request_message:
    seq:
      - id: origclordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'The ClOrdID of the previous order, not the initial order of the day'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
  order_cancel_request_message:
    seq:
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'The ClOrdID of the previous order, not the initial order of the day. Nullable, No Value = 0'
      - id: order_id_optional
        type: u8_nullable
        doc: 'Order Id as assigned by the exchange. Nullable, No Value = 18446744073709551615'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
  mass_cancel_request_message:
    seq:
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side of order; null when side is not used as a cancel filter. Nullable, No Value = 0'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a lower or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a higher or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
  execution_report_pending_new_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'Capacity of the customer placing the order; defaults to MemberTradingOnTheirOwnAccount when unspecified'
      - id: exec_inst
        type: exec_inst
        doc: 'Instructions for order handling on exchange; a bit set where setting a bit enables its instruction and bit 0 is the least significant'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'Signed amount added to the peg for a pegged order. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'Defines the type of peg used in a peg order. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'Expiration time of a GoodForTime order, at least one millisecond in the future; defaults to the end of the post market session, nanoseconds since the unix epoch. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1
        enum: display_method
        doc: 'The method used when refreshing displayed quantity of a reserve order; null for a fully displayed order. Nullable, No Value = 0'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'Defines the replenishment timing behavior for a reserve order. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'The minimum increment used when calculating a random refresh of the display quantity. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a reprice; an order is not repriced when this is absent. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when the market is locked or crossed. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom self trade prevention group. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'The desired behavior in the event of a wash; the null value disables self trade prevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set applied to this order; the null value disables custom risk controls. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_new_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Defines the time during which an order is eligible for execution'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Designates the capacity of the firm placing the order'
      - id: cust_order_capacity
        type: u1
        enum: cust_order_capacity
        doc: 'Capacity of the customer placing the order; defaults to MemberTradingOnTheirOwnAccount when unspecified'
      - id: exec_inst
        type: exec_inst
        doc: 'Instructions for order handling on exchange; a bit set where setting a bit enables its instruction and bit 0 is the least significant'
      - id: peg_offset_value
        type: decimal_s8_6_nullable
        doc: 'Signed amount added to the peg for a pegged order. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: peg_price_type
        type: u1_nullable
        doc: 'Defines the type of peg used in a peg order. Nullable, No Value = 255'
      - id: expire_time
        type: u8_nullable
        doc: 'Expiration time of a GoodForTime order, at least one millisecond in the future; defaults to the end of the post market session, nanoseconds since the unix epoch. Nullable, No Value = 18446744073709551615'
      - id: min_qty
        type: u4_nullable
        doc: 'Minimum quantity of an order to be executed. Nullable, No Value = 4294967295'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: display_method
        type: u1
        enum: display_method
        doc: 'The method used when refreshing displayed quantity of a reserve order; null for a fully displayed order. Nullable, No Value = 0'
      - id: reserve_replenish_timing
        type: u1_nullable
        doc: 'Defines the replenishment timing behavior for a reserve order. Nullable, No Value = 255'
      - id: display_min_incr
        type: u4_nullable
        doc: 'The minimum increment used when calculating a random refresh of the display quantity. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: reprice_frequency
        type: u1_nullable
        doc: 'Defines the frequency of a reprice; an order is not repriced when this is absent. Nullable, No Value = 255'
      - id: reprice_behavior
        type: u1_nullable
        doc: 'Defines the reprice behavior when the market is locked or crossed. Nullable, No Value = 255'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
      - id: stp_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom self trade prevention group. Nullable, No Value = 65535'
      - id: self_trade_prevention
        type: u1_nullable
        doc: 'The desired behavior in the event of a wash; the null value disables self trade prevention. Nullable, No Value = 255'
      - id: risk_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom risk control set applied to this order; the null value disables custom risk controls. Nullable, No Value = 65535'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred, nanoseconds since the unix epoch'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_rejected_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Code identifying the reason an order was rejected'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_trade_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_qty
        type: u4
        doc: 'Quantity bought or sold on this last fill'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this last fill, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred, nanoseconds since the unix epoch'
      - id: last_liquidity_ind
        type: u1
        enum: last_liquidity_ind
        doc: 'Indicator denoting whether the referenced order removed liquidity from or added liquidity to the book'
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        doc: 'Market of execution for the last fill, or the market an order was routed to, as an Iso 10383 Mic'
      - id: trd_matching_id
        type: u8
        doc: 'Identifier assigned to the trade by the matching system; filled on a best effort basis for executions routed to another exchange'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security listing tape indicator, A, B or C'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_pending_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'The ClOrdID of the previous order, not the initial order of the day. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  pending_mass_cancel_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side of order; null when side is not used as a cancel filter. Nullable, No Value = 0'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a lower or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a higher or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
  execution_report_canceled_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'The ClOrdID of the previous order, not the initial order of the day. Nullable, No Value = 0'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: cancel_reason
        type: u1_nullable
        doc: 'Reason code for the order cancellation. Nullable, No Value = 255'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred, nanoseconds since the unix epoch'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  mass_cancel_done_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
  execution_report_pending_replace_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'The ClOrdID of the previous order, not the initial order of the day. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_replaced_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: origclordid_optional
        type: str_16_nullable
        doc: 'The ClOrdID of the previous order, not the initial order of the day. Nullable, No Value = 0'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side
        type: u1
        enum: side
        doc: 'Side of order'
      - id: order_qty
        type: u4
        doc: 'Quantity ordered, the number of shares; may not exceed 1MM shares or 30MM notional'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Type of the order'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price per unit of quantity, per share, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: display_qty
        type: u4_nullable
        doc: 'Quantity of the order to be displayed. Nullable, No Value = 4294967295'
      - id: locate_reqd
        type: str_1_nullable
        doc: 'Required on Short Sell and Short Sell Exempt orders; the only acceptable value N indicates the member has secured the required locate. Nullable, No Value = 0'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred, nanoseconds since the unix epoch'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: locate_broker_optional
        type: str_4_nullable
        doc: 'For a short sell order, the broker Mpid the member borrows shares from; a port may be configured to require it. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_trade_correction_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: exec_ref_id
        type: u8
        doc: 'The Exec Id of the execution being corrected or broken'
      - id: trd_match_id
        type: u8
        doc: 'Identifier assigned to the trade by the matching system; filled on a best effort basis for executions routed to another exchange'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_px
        type: decimal_s8_6
        doc: 'Price of this last fill, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6'
      - id: last_qty_optional
        type: u4_nullable
        doc: 'Quantity bought or sold on this last fill. Nullable, No Value = 4294967295'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security listing tape indicator, A, B or C'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_trade_break_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: exec_ref_id
        type: u8
        doc: 'The Exec Id of the execution being corrected or broken'
      - id: trd_match_id
        type: u8
        doc: 'Identifier assigned to the trade by the matching system; filled on a best effort basis for executions routed to another exchange'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: security_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Security listing tape indicator, A, B or C'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  execution_report_restatement_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Order Id as assigned by the exchange'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: exec_id
        type: u8
        doc: 'Unique identifier of the execution message as assigned by the exchange, unique within a single trading day'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'The status of the order'
      - id: last_px_optional
        type: decimal_s8_6_nullable
        doc: 'Price of this last fill, a signed mantissa scaled by a constant exponent of -6. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: leaves_qty
        type: u4
        doc: 'Quantity open for further execution'
      - id: cum_qty
        type: u4
        doc: 'Total quantity filled'
      - id: last_shares
        type: u4_nullable
        doc: 'Quantity bought or sold on this last fill. Nullable, No Value = 4294967295'
      - id: exec_restatement_reason
        type: u1
        enum: exec_restatement_reason
        doc: 'Defines the reason for a restatement'
      - id: transact_time
        type: u8
        doc: 'The time at which the transaction occurred, nanoseconds since the unix epoch'
      - id: extended_restatement_reason
        type: u1_nullable
        doc: 'Defines the extended reason for a restatement. Nullable, No Value = 255'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
      - id: parties_groups
        type: parties_groups
        doc: 'The parties associated with the order, a repeating group of party identifiers'
  order_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: cxl_rej_response_to
        type: u1
        enum: cxl_rej_response_to
        doc: 'Identifies the request type the cancel reject was issued for'
      - id: cxl_rej_reason
        type: u1
        enum: cxl_rej_reason
        doc: 'Code identifying the reason a cancel request was rejected'
      - id: link_id_optional
        type: str_4_nullable
        doc: 'A link identifier clients assign for their own order tracking. Nullable, No Value = 0'
  mass_cancel_reject_message:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'The time the message was sent, nanoseconds since the unix epoch. Nanoseconds since Unix epoch'
      - id: clordid
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier of the order as assigned by the client, unique within a single trading day'
      - id: symbol
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cms symbol tradable instrument'
      - id: symbol_sfx
        type: str_6_nullable
        doc: 'Cms symbol suffix, additional information about the security such as preferred or warrants. Nullable, No Value = 0'
      - id: side_optional
        type: u1
        enum: side_optional
        doc: 'Side of order; null when side is not used as a cancel filter. Nullable, No Value = 0'
      - id: lower_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a lower or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: higher_than_price
        type: decimal_s8_6_nullable
        doc: 'Mass cancel filter including any order with a higher or equal limit price; usable only with a specific symbol. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cancel_group_id
        type: u2_nullable
        doc: 'Unique identifier of a custom cancel group. Nullable, No Value = 65535'
      - id: mass_cancel_reject_reason
        type: u1
        enum: mass_cancel_reject_reason
        doc: 'Code identifying the reason a mass cancellation request was rejected'
  login_accepted_message:
    seq:
      - id: supported_request_mode
        type: u1
        enum: supported_request_mode
        doc: 'The request mode this connection supports, stream, replay or snapshot; a request of any other mode is rejected'
  login_rejected_message:
    seq:
      - id: login_reject_code
        type: u1
        enum: login_reject_code
        doc: 'Why the login was rejected; none of the reasons are retryable'
  start_of_session_message:
    seq:
      - id: session_id
        type: u8
        doc: 'Identifier of the session, as named by Start of Session and as copied onto a replay or stream request'
  replay_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number on a request, and the sequence of the next message in the stream on a begin'
      - id: pending_message_count
        type: u4
        doc: 'The number of messages to be delivered in this replay, which may be fewer than requested when the server caps a replay'
  replay_rejected_message:
    seq:
      - id: replay_reject_code
        type: u1
        enum: replay_reject_code
        doc: 'Why the replay request was rejected; only a start sequence out of range is retryable'
  replay_complete_message:
    seq:
      - id: message_count
        type: u8
        doc: 'The number of messages which were sent in the replay'
  stream_begin_message:
    seq:
      - id: next_sequence_number
        type: u8
        doc: 'The first requested sequence number on a request, and the sequence of the next message in the stream on a begin'
      - id: max_sequence_number
        type: u8
        doc: 'The maximum sequence number published on the stream when the request was made; it may still grow while the client catches up'
  stream_rejected_message:
    seq:
      - id: stream_reject_code
        type: u1
        enum: stream_reject_code
        doc: 'Why the stream request was rejected; only a start sequence out of range is retryable'
  stream_complete_message:
    seq:
      - id: total_sequence_count
        type: u8
        doc: 'The count of messages that were sent on this stream'
  sequenced_message:
    seq:
      - id: sbe_message
        type: sbe_message
        doc: 'Sbe Message'
  str_6_nullable:
    seq:
      - id: value
        size: 6
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_s8_6_nullable:
    seq:
      - id: value
        type: decimal_s8_6
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "0"
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  str_4_nullable:
    seq:
      - id: value
        size: 4
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
  str_16_nullable:
    seq:
      - id: value
        size: 16
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: value[0] == 0
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

enums:
  message_type:
    100:
      id: 'login_request'
      doc: 'Login Request, authorizing the session'
    101:
      id: 'replay_request'
      doc: 'Replay Request, asking for a count of messages from a sequence number'
    102:
      id: 'replay_all_request'
      doc: 'Replay All Request, asking for every message from sequence one'
    103:
      id: 'stream_request'
      doc: 'Stream Request, asking for a continuous stream from a sequence number'
    104:
      id: 'unsequenced_message'
      doc: 'Unsequenced Message, one business message from the client while streaming; it applies to the session of the stream in progress'
    1:
      id: 'login_accepted'
      doc: 'Login Accepted, naming the request mode the connection allows'
    2:
      id: 'login_rejected'
      doc: 'Login Rejected, the connection closes after it is sent'
    3:
      id: 'start_of_session'
      doc: 'Start of Session, naming the session now available on the connection'
    4:
      id: 'end_of_session'
      doc: 'End of Session, no further messages arrive on the session that was active'
    5:
      id: 'replay_begin'
      doc: 'Replay Begin, the replay request was accepted'
    6:
      id: 'replay_rejected'
      doc: 'Replay Rejected, the replay request was refused'
    7:
      id: 'replay_complete'
      doc: 'Replay Complete, the replay in progress finished'
    8:
      id: 'stream_begin'
      doc: 'Stream Begin, the stream request was accepted'
    9:
      id: 'stream_rejected'
      doc: 'Stream Rejected, the stream request was refused'
    10:
      id: 'stream_complete'
      doc: 'Stream Complete, the stream in progress finished'
    11:
      id: 'sequenced_message'
      doc: 'Sequenced Message, one business message from the server; it does advance the stream sequence and its payload is defined by the protocol this session wraps'
  template_id:
    1:
      id: 'new_order_single_message'
      doc: 'NewOrderSingleMessage'
    2:
      id: 'order_cancel_replace_request_message'
      doc: 'OrderCancelReplaceRequestMessage'
    3:
      id: 'order_cancel_request_message'
      doc: 'OrderCancelRequestMessage'
    4:
      id: 'mass_cancel_request_message'
      doc: 'MassCancelRequestMessage'
    5:
      id: 'execution_report_pending_new_message'
      doc: 'ExecutionReport_PendingNewMessage'
    6:
      id: 'execution_report_new_message'
      doc: 'ExecutionReport_NewMessage'
    7:
      id: 'execution_report_rejected_message'
      doc: 'ExecutionReport_RejectedMessage'
    8:
      id: 'execution_report_trade_message'
      doc: 'ExecutionReport_TradeMessage'
    9:
      id: 'execution_report_pending_cancel_message'
      doc: 'ExecutionReport_PendingCancelMessage'
    10:
      id: 'pending_mass_cancel_message'
      doc: 'PendingMassCancelMessage'
    11:
      id: 'execution_report_canceled_message'
      doc: 'ExecutionReport_CanceledMessage'
    12:
      id: 'mass_cancel_done_message'
      doc: 'MassCancelDoneMessage'
    13:
      id: 'execution_report_pending_replace_message'
      doc: 'ExecutionReport_PendingReplaceMessage'
    14:
      id: 'execution_report_replaced_message'
      doc: 'ExecutionReport_ReplacedMessage'
    15:
      id: 'execution_report_trade_correction_message'
      doc: 'ExecutionReport_TradeCorrectionMessage'
    16:
      id: 'execution_report_trade_break_message'
      doc: 'ExecutionReport_TradeBreakMessage'
    17:
      id: 'execution_report_restatement_message'
      doc: 'ExecutionReport_RestatementMessage'
    18:
      id: 'order_cancel_reject_message'
      doc: 'OrderCancelRejectMessage'
    20:
      id: 'mass_cancel_reject_message'
      doc: 'MassCancelRejectMessage'
  side:
    0x31:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'sell_short'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'sell_short_exempt'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_type:
    0x31:
      id: 'market'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'limit'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'pegged'
      doc: 'OrdType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'fill_or_kill'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'good_for_time'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x46:
      id: 'regular_hours_only'
      doc: 'TimeInForceType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_capacity:
    0x41:
      id: 'agency'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x50:
      id: 'principal'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x52:
      id: 'riskless_principal'
      doc: 'OrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cust_order_capacity:
    1:
      id: 'member_trading_on_their_own_account'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'retail_customer'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CustOrderCapacityType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  peg_price_type:
    2:
      id: 'mid_price_peg'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'primary_peg'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'PegType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  display_method:
    0x31:
      id: 'initial'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x33:
      id: 'random'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'undisclosed'
      doc: 'DispMethodType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reserve_replenish_timing:
    1:
      id: 'immediate'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'random'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ReserveReplenishTimingType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_frequency:
    0:
      id: 'single_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'continuous_reprice'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'none'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceFrequencyType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  reprice_behavior:
    1:
      id: 'reprice_lock_cancel_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'reprice_lock_reprice_cross'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'RepriceBehaviorType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  self_trade_prevention:
    0:
      id: 'cancel_newest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'cancel_oldest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'decrement_and_cancel'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'cancel_both'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cancel_smallest'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'SelfTradePreventionType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  party_role:
    1:
      id: 'executing_firm'
      doc: 'PartyRoleType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  side_optional:
    0x31:
      id: 'buy'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'sell'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x35:
      id: 'sell_short'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'sell_short_exempt'
      doc: 'SideType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x31:
      id: 'partial_filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'filled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x34:
      id: 'canceled'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x36:
      id: 'pending_cancel'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x38:
      id: 'rejected'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x41:
      id: 'pending_new'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x45:
      id: 'pending_replace'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x43:
      id: 'expired'
      doc: 'OrdStatusType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  order_reject_reason:
    1:
      id: 'invalid_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'exchange_closed'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_size_exceeds_limit'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'invalid_limit_price_increment'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'no_nbbo_available'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'order_notional_exceeds_limit'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    22:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    23:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    27:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'missing_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'missing_locate'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'invalid_locate'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'missing_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'invalid_cl_ord_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'missing_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    106:
      id: 'invalid_side'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'missing_order_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'invalid_order_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'missing_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'invalid_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    111:
      id: 'missing_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    112:
      id: 'invalid_time_in_force'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    113:
      id: 'missing_order_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    114:
      id: 'invalid_order_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    115:
      id: 'missing_exec_inst'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    116:
      id: 'missing_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    117:
      id: 'invalid_limit_price'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    118:
      id: 'missing_max_floor'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    119:
      id: 'invalid_max_floor'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    120:
      id: 'missing_reserve_replenish_amount_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    121:
      id: 'invalid_reserve_replenish_amount_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    122:
      id: 'missing_reserve_replenish_time_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    123:
      id: 'invalid_reserve_replenish_time_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    124:
      id: 'missing_random_replenish_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    125:
      id: 'invalid_random_replenish_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    126:
      id: 'invalid_random_replenish_value_for_reserve_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    127:
      id: 'missing_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    128:
      id: 'invalid_reprice_frequency_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    129:
      id: 'missing_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    130:
      id: 'invalid_reprice_behavior_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    131:
      id: 'invalid_reprice_behavior_for_reprice_frequency'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    132:
      id: 'missing_customer_capacity_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    133:
      id: 'invalid_customer_capacity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    134:
      id: 'missing_expire_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    135:
      id: 'invalid_expire_time'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    136:
      id: 'missing_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    137:
      id: 'invalid_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    138:
      id: 'invalid_modifier_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    139:
      id: 'invalid_modifiers_combination'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    140:
      id: 'invalid_trading_session_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    141:
      id: 'invalid_time_in_force_for_order_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    142:
      id: 'invalid_modifier_for_peg_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    143:
      id: 'invalid_min_quantity'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    145:
      id: 'invalid_mpid_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    146:
      id: 'symbol_halted_or_paused'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    147:
      id: 'block_iso_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    148:
      id: 'block_session_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    149:
      id: 'block_non_test_symbols_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    150:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    151:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    152:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    153:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    154:
      id: 'daily_gross_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    155:
      id: 'daily_net_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    156:
      id: 'max_num_duplicate_orders_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    157:
      id: 'max_order_rate_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    158:
      id: 'restricted_security_risk_rule_violated'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    159:
      id: 'invalid_self_trade_prevention_configuration'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    160:
      id: 'invalid_self_trade_prevention_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    161:
      id: 'invalid_risk_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    162:
      id: 'firm_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    163:
      id: 'mpid_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    164:
      id: 'account_disabled'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    165:
      id: 'cannot_trade_non_test_symbol'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    166:
      id: 'missing_firm'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    167:
      id: 'missing_account'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    168:
      id: 'missing_mpid'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    169:
      id: 'missing_risk_group'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    170:
      id: 'daily_market_order_gross_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    171:
      id: 'daily_market_order_net_notional_exposure_risk_rule_breach'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    172:
      id: 'missing_disp_method_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    173:
      id: 'missing_firm_risk_setting'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    174:
      id: 'invalid_account_mpid_to_firm'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    175:
      id: 'invalid_peg_offset_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    176:
      id: 'invalid_disp_method_type'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    177:
      id: 'missing_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    178:
      id: 'invalid_cancel_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    179:
      id: 'missing_stp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    180:
      id: 'invalid_stp_group_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    181:
      id: 'invalid_lnk_id'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    182:
      id: 'missing_locate_broker'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    183:
      id: 'invalid_locate_broker'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'OrderRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  last_liquidity_ind:
    1:
      id: 'add_displayed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'removed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'routed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'cross'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    51:
      id: 'add_hidden'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    52:
      id: 'add_midpoint_peg'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    53:
      id: 'add_displayed_nbbo_improve'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    54:
      id: 'add_displayed_nbbo_join'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    61:
      id: 'immediate_midpoint_remove_on_entry'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    62:
      id: 'add_displayed_price_improvement'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    63:
      id: 'add_hidden_price_improvement'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'retail_add_displayed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'retail_removed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'retail_routed'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'retail_cross'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    151:
      id: 'retail_add_hidden'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    152:
      id: 'retail_add_midpoint_peg'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    153:
      id: 'retail_add_displayed_nbbo_improve'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    154:
      id: 'retail_add_displayed_nbbo_join'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    160:
      id: 'retail_removed_on_entry'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    161:
      id: 'retail_immediate_midpoint_remove_on_entry'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    162:
      id: 'retail_add_displayed_price_improvement'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    163:
      id: 'retail_add_hidden_price_improvement'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'LastLiquidityIndType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cancel_reason:
    0:
      id: 'other'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'user_requested_cancel'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'end_of_trading'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'limit_up_limit_down'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'halted'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'exchange_supervisory'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'order_expired'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'lock_or_cross_book'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'self_trade_prevention'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'insufficient_quotes'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    12:
      id: 'non_compliant_price'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    13:
      id: 'participant_disconnect'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    14:
      id: 'order_not_bookable'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    15:
      id: 'trade_protection_limits'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    16:
      id: 'unable_to_route'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    17:
      id: 'firm_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'mpid_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    19:
      id: 'account_disabled'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    20:
      id: 'notional_exposure_risk_breached'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CancelReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  exec_restatement_reason:
    3:
      id: 'order_reprice'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'self_trade_prevention'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExecRestatementType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  extended_restatement_reason:
    0:
      id: 'none'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'set_nbbo'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'joined_nbbo'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'self_trade_cancel_newest'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'self_trade_cancel_oldest'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'self_trade_decrement_and_cancel'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'self_trade_cancel_both'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'self_trade_cancel_smallest'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'ExtendedRestatementReasonType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_response_to:
    0x31:
      id: 'order_cancel_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    0x32:
      id: 'order_cancel_replace_request'
      doc: 'CxlRejResponseToType Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  cxl_rej_reason:
    1:
      id: 'unknown_orig_order'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'order_in_pending_state'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    18:
      id: 'invalid_limit_price_increment'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    99:
      id: 'other'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    100:
      id: 'missing_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    101:
      id: 'missing_locate'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    102:
      id: 'missing_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    103:
      id: 'invalid_order_quantity'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    104:
      id: 'invalid_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    105:
      id: 'invalid_limit_price'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    107:
      id: 'symbol_halted_or_paused'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    108:
      id: 'order_size_exceeds_limit'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    109:
      id: 'exceeded_max_notional_order_amt'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    110:
      id: 'missing_orig_order_identifiers'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    111:
      id: 'ambiguous_orig_order_identifiers'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    112:
      id: 'orig_order_symbol_not_matching_request_symbol'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    113:
      id: 'unsupported_display_quantity_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    114:
      id: 'unsupported_ord_type_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    115:
      id: 'unsupported_side_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    116:
      id: 'unsupported_quantity_change'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    117:
      id: 'invalid_locate'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    118:
      id: 'exchange_closed'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    119:
      id: 'block_session_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    120:
      id: 'block_sell_short_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    121:
      id: 'max_shares_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    122:
      id: 'no_nbbo_available'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    123:
      id: 'max_notional_value_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    124:
      id: 'max_adv_percent_per_order_risk_rule_breach'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    125:
      id: 'price_percent_collar_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    126:
      id: 'price_value_collar_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    127:
      id: 'hard_to_borrow_security_risk_rule_violated'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    128:
      id: 'invalid_side'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    129:
      id: 'invalid_ord_type'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    130:
      id: 'invalid_cl_ord_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    131:
      id: 'invalid_lnk_id'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    132:
      id: 'missing_locate_broker'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    133:
      id: 'invalid_locate_broker'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'CancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  mass_cancel_reject_reason:
    0:
      id: 'other'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    1:
      id: 'unknown_product'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    2:
      id: 'unknown_side'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    3:
      id: 'unknown_group_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    4:
      id: 'higher_price_lower_or_equal_to_lower_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    5:
      id: 'product_missing_for_price_restriction'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    6:
      id: 'duplicate_cl_ord_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    7:
      id: 'malformed_request_missing_cl_ord_id_field'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    8:
      id: 'invalid_cancel_group_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    9:
      id: 'invalid_cl_ord_id'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    10:
      id: 'invalid_lower_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    11:
      id: 'invalid_higher_price'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
    255:
      id: 'null_value'
      doc: 'MassCancelRejectReasonCode Scaled.Binary.Specification.Load.Sbe.V1.Xml.Xml.typesEnumValidValue'
  supported_request_mode:
    0x53:
      id: 'stream'
      doc: 'Stream mode, the server accepts stream requests and rejects replay requests'
    0x52:
      id: 'replay'
      doc: 'Replay mode, the server accepts ranged replay requests and rejects stream requests'
    0x54:
      id: 'snapshot_mode'
      doc: 'Snapshot mode, the server accepts replay all requests'
  login_reject_code:
    0x54:
      id: 'malformed_token'
      doc: 'Malformed token; not retryable'
    0x55:
      id: 'token_type_unsupported'
      doc: 'Token type unsupported by this server; not retryable'
    0x56:
      id: 'token_type_invalid'
      doc: 'Token type invalid on any server; not retryable'
    0x41:
      id: 'authorization_failed'
      doc: 'Authorization failed; not retryable'
  replay_reject_code:
    0x52:
      id: 'replay_requests_are_not_allowed'
      doc: 'Replay requests are not allowed by this server, stream requests must be used; not retryable'
    0x41:
      id: 'replay_all_requests_are_not_allowed'
      doc: 'Replay all requests are not allowed by this server, ranged replay requests must be used; not retryable'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session on the request is not the active session; not retryable'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'The start sequence number is out of range; retryable'
  stream_reject_code:
    0x52:
      id: 'stream_requests_are_not_allowed'
      doc: 'Stream requests are not allowed by this server, replay requests must be used; not retryable'
    0x50:
      id: 'not_the_active_session'
      doc: 'The session on the request is not the active session; not retryable'
    0x53:
      id: 'sequence_number_out_of_range'
      doc: 'The start sequence number is out of range; retryable'

