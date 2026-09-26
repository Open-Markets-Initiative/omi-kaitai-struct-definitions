# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities BinaryOrderEntry Boe v2.3
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.3
#   Date: 3/11/2019
#   Specification: Cboe_US_Equities_BOE_Specification.pdf
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
  id: cboe_bzxequities_binaryorderentry_boe_v2_3
  title: Cboe BzxEquities BinaryOrderEntry Boe v2.3
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Binary Order Entry Boe v2.3'
doc-ref: http://markets.cboe.com/us/equities/support/technical/

seq:
  - id: message_header
    type: message_header_struct
    doc: '10-byte BOE v2 message header. Every message starts with StartOfMessage = 0xBA 0xBA'
  - id: message
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::login_request_message': login_request_message
        'message_type::login_response_message': login_response_message
        'message_type::logout_message': logout_message
        'message_type::new_order_message': new_order_message
        'message_type::cancel_order_message': cancel_order_message
        'message_type::modify_order_message': modify_order_message
        'message_type::purge_order_message': purge_order_message
        'message_type::order_acknowledgment_message': order_acknowledgment_message
        'message_type::order_rejected_message': order_rejected_message
        'message_type::order_modified_message': order_modified_message
        'message_type::order_restated_message': order_restated_message
        'message_type::user_modify_rejected_message': user_modify_rejected_message
        'message_type::order_cancelled_message': order_cancelled_message
        'message_type::cancel_rejected_message': cancel_rejected_message
        'message_type::order_execution_message': order_execution_message
        'message_type::trade_cancel_or_correct_message': trade_cancel_or_correct_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::purge_rejected_message': purge_rejected_message

types:
  message_header_struct:
    seq:
      - id: start_of_message
        type: u2
        doc: 'BA BA (47802). Two initial bytes present to aid in message reassembly for network capture purposes'
      - id: message_length
        type: u2
        doc: 'Number of bytes for the message, including this field but not including the two bytes of the StartOfMessage field'
      - id: message_type
        type: u1
        enum: message_type
      - id: matching_unit
        type: u1
        doc: 'The matching unit which created this message. Only populated on sequenced, non-session level messages sent from Cboe to the Member; 0 for inbound and all session level messages'
      - id: sequence_number
        type: u4
        doc: 'The sequence number for this message. Cboe-to-Member messages sequenced distinctly per matching unit; Member-to-Cboe sequenced across all matching units with a single stream'
  login_request_message:
    seq:
      - id: session_sub_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Session Sub ID supplied by Cboe'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        doc: 'Username supplied by Cboe'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Password supplied by Cboe'
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Repeating parameter group appended to the Login Request and Login Response messages. NumberOfParamGroups instances follow (count may be 0 — the group is optional). Each instance starts with the 2-byte ParamGroupLength + 1-byte ParamGroupType header; the remaining payload bytes are interpreted per ParamGroupType (0x80 = Unit Sequences Parameter Group, 0x81 = Return Bitfields Parameter Group)'
  param_group:
    seq:
      - id: param_group_length
        type: u2
      - id: param_group_type
        type: u1
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted, or the reason for the rejection'
      - id: login_response_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for rejection. ASCII NUL (0x00) filled on the right, if necessary'
      - id: no_unspecified_unit_replay
        type: u1
        enum: no_unspecified_unit_replay
        doc: 'Echoed back from the original Login Request message'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Member to Cboe) message sequence number processed by Cboe'
      - id: number_of_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: unit_sequence
        type: u4
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Repeating parameter group appended to the Login Request and Login Response messages. NumberOfParamGroups instances follow (count may be 0 — the group is optional). Each instance starts with the 2-byte ParamGroupLength + 1-byte ParamGroupType header; the remaining payload bytes are interpreted per ParamGroupType (0x80 = Unit Sequences Parameter Group, 0x81 = Return Bitfields Parameter Group)'
  logout_message:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'The reason why the Logout message was sent'
      - id: logout_reason_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for logout. Particularly useful if LogoutReason = ! (Protocol Violation)'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Member to Cboe) message sequence number processed by Cboe'
      - id: number_of_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: unit_sequence
        type: u4
  new_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: number_of_new_order_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: new_order_bitfield_1
        type: new_order_bitfield_1
        if: number_of_new_order_bitfields >= 1
        doc: 'BitSet NewOrder byte 1'
      - id: new_order_bitfield_2
        type: new_order_bitfield_2
        if: number_of_new_order_bitfields >= 2
        doc: 'BitSet NewOrder byte 2'
      - id: new_order_bitfield_3
        type: new_order_bitfield_3
        if: number_of_new_order_bitfields >= 3
        doc: 'BitSet NewOrder byte 3'
      - id: new_order_bitfield_4
        type: new_order_bitfield_4
        if: number_of_new_order_bitfields >= 4
        doc: 'BitSet NewOrder byte 4'
      - id: new_order_bitfield_5
        type: new_order_bitfield_5
        if: number_of_new_order_bitfields >= 5
        doc: 'BitSet NewOrder byte 5'
      - id: new_order_bitfield_6
        type: new_order_bitfield_6
        if: number_of_new_order_bitfields >= 6
        doc: 'BitSet NewOrder byte 6'
      - id: new_order_bitfield_7
        type: new_order_bitfield_7
        if: number_of_new_order_bitfields >= 7
        doc: 'BitSet NewOrder byte 7'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_clearing_account
      - id: price
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_min_qty
      - id: max_floor
        type: u4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_max_floor
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_capacity
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_routing_inst
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_display_indicator
      - id: discretion_amount
        type: u2
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_discretion_amount
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_prevent_match
      - id: locate_reqd
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_locate_reqd
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_risk_reset
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_ext_exec_inst
      - id: display_range
        type: u4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_display_range
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_ex_destination
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_echo_text
      - id: custom_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_custom_group_id
  new_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_1_clearing_firm
        type: b1
      - id: new_order_bitfield_1_clearing_account
        type: b1
      - id: new_order_bitfield_1_price
        type: b1
      - id: new_order_bitfield_1_exec_inst
        type: b1
      - id: new_order_bitfield_1_ord_type
        type: b1
      - id: new_order_bitfield_1_time_in_force
        type: b1
      - id: new_order_bitfield_1_min_qty
        type: b1
      - id: new_order_bitfield_1_max_floor
        type: b1
  new_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_2_symbol
        type: b1
      - id: new_order_bitfield_2_symbol_sfx
        type: b1
      - id: new_order_bitfield_2_reserved_4
        type: b1
      - id: new_order_bitfield_2_reserved_8
        type: b1
      - id: new_order_bitfield_2_reserved_16
        type: b1
      - id: new_order_bitfield_2_reserved_32
        type: b1
      - id: new_order_bitfield_2_capacity
        type: b1
      - id: new_order_bitfield_2_routing_inst
        type: b1
  new_order_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_3_account
        type: b1
      - id: new_order_bitfield_3_display_indicator
        type: b1
      - id: new_order_bitfield_3_reserved_4
        type: b1
      - id: new_order_bitfield_3_discretion_amount
        type: b1
      - id: new_order_bitfield_3_peg_difference
        type: b1
      - id: new_order_bitfield_3_prevent_match
        type: b1
      - id: new_order_bitfield_3_locate_reqd
        type: b1
      - id: new_order_bitfield_3_expire_time
        type: b1
  new_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_4_reserved_1
        type: b1
      - id: new_order_bitfield_4_reserved_2
        type: b1
      - id: new_order_bitfield_4_reserved_4
        type: b1
      - id: new_order_bitfield_4_risk_reset
        type: b1
      - id: new_order_bitfield_4_reserved_16
        type: b1
      - id: new_order_bitfield_4_reserved_32
        type: b1
      - id: new_order_bitfield_4_reserved_64
        type: b1
      - id: new_order_bitfield_4_reserved_128
        type: b1
  new_order_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_5_reserved_1
        type: b1
      - id: new_order_bitfield_5_attributed_quote
        type: b1
      - id: new_order_bitfield_5_reserved_4
        type: b1
      - id: new_order_bitfield_5_ext_exec_inst
        type: b1
      - id: new_order_bitfield_5_reserved_16
        type: b1
      - id: new_order_bitfield_5_reserved_32
        type: b1
      - id: new_order_bitfield_5_reserved_64
        type: b1
      - id: new_order_bitfield_5_reserved_128
        type: b1
  new_order_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_6_display_range
        type: b1
      - id: new_order_bitfield_6_stop_px
        type: b1
      - id: new_order_bitfield_6_rout_strategy
        type: b1
      - id: new_order_bitfield_6_route_delivery_method
        type: b1
      - id: new_order_bitfield_6_ex_destination
        type: b1
      - id: new_order_bitfield_6_echo_text
        type: b1
      - id: new_order_bitfield_6_reserved_64
        type: b1
      - id: new_order_bitfield_6_reserved_128
        type: b1
  new_order_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_7_reserved_1
        type: b1
      - id: new_order_bitfield_7_custom_group_id
        type: b1
      - id: new_order_bitfield_7_reserved_4
        type: b1
      - id: new_order_bitfield_7_reserved_8
        type: b1
      - id: new_order_bitfield_7_reserved_16
        type: b1
      - id: new_order_bitfield_7_reserved_32
        type: b1
      - id: new_order_bitfield_7_reserved_64
        type: b1
      - id: new_order_bitfield_7_reserved_128
        type: b1
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: number_of_cancel_order_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: cancel_order_bitfield_1
        type: cancel_order_bitfield_1
        if: number_of_cancel_order_bitfields >= 1
        doc: 'BitSet CancelOrder byte 1'
      - id: cancel_order_bitfield_2
        type: cancel_order_bitfield_2
        if: number_of_cancel_order_bitfields >= 2
        doc: 'BitSet CancelOrder byte 2'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_clearing_firm
  cancel_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_bitfield_1_clearing_firm
        type: b1
      - id: cancel_order_bitfield_1_reserved_2
        type: b1
      - id: cancel_order_bitfield_1_reserved_4
        type: b1
      - id: cancel_order_bitfield_1_reserved_8
        type: b1
      - id: cancel_order_bitfield_1_reserved_16
        type: b1
      - id: cancel_order_bitfield_1_reserved_32
        type: b1
      - id: cancel_order_bitfield_1_reserved_64
        type: b1
      - id: cancel_order_bitfield_1_reserved_128
        type: b1
  cancel_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_bitfield_2_reserved_1
        type: b1
      - id: cancel_order_bitfield_2_reserved_2
        type: b1
      - id: cancel_order_bitfield_2_reserved_4
        type: b1
      - id: cancel_order_bitfield_2_reserved_8
        type: b1
      - id: cancel_order_bitfield_2_reserved_16
        type: b1
      - id: cancel_order_bitfield_2_reserved_32
        type: b1
      - id: cancel_order_bitfield_2_reserved_64
        type: b1
      - id: cancel_order_bitfield_2_reserved_128
        type: b1
  modify_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: number_of_modify_order_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: modify_order_bitfield_1
        type: modify_order_bitfield_1
        if: number_of_modify_order_bitfields >= 1
        doc: 'BitSet ModifyOrder byte 1'
      - id: modify_order_bitfield_2
        type: modify_order_bitfield_2
        if: number_of_modify_order_bitfields >= 2
        doc: 'BitSet ModifyOrder byte 2'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_clearing_firm
      - id: order_qty
        type: u4
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: price
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_ord_type
      - id: cancel_orig_on_reject
        type: str
        size: 1
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_cancel_orig_on_reject
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_exec_inst
      - id: side
        type: u1
        enum: side
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: max_floor
        type: u4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_max_floor
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px
        doc: 'Implied decimal with scale 1e-4'
  modify_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_bitfield_1_clearing_firm
        type: b1
      - id: modify_order_bitfield_1_reserved_2
        type: b1
      - id: modify_order_bitfield_1_order_qty
        type: b1
      - id: modify_order_bitfield_1_price
        type: b1
      - id: modify_order_bitfield_1_ord_type
        type: b1
      - id: modify_order_bitfield_1_cancel_orig_on_reject
        type: b1
      - id: modify_order_bitfield_1_exec_inst
        type: b1
      - id: modify_order_bitfield_1_side
        type: b1
  modify_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_bitfield_2_max_floor
        type: b1
      - id: modify_order_bitfield_2_stop_px
        type: b1
      - id: modify_order_bitfield_2_reserved_4
        type: b1
      - id: modify_order_bitfield_2_reserved_8
        type: b1
      - id: modify_order_bitfield_2_reserved_16
        type: b1
      - id: modify_order_bitfield_2_reserved_32
        type: b1
      - id: modify_order_bitfield_2_reserved_64
        type: b1
      - id: modify_order_bitfield_2_reserved_128
        type: b1
  purge_order_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_purge_order_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: purge_order_bitfield_1
        type: purge_order_bitfield_1
        if: number_of_purge_order_bitfields >= 1
        doc: 'BitSet PurgeOrder byte 1'
      - id: purge_order_bitfield_2
        type: purge_order_bitfield_2
        if: number_of_purge_order_bitfields >= 2
        doc: 'BitSet PurgeOrder byte 2'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_clearing_firm
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_inst
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_id
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 2 and purge_order_bitfield_2.purge_order_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 2 and purge_order_bitfield_2.purge_order_bitfield_2_symbol_sfx
  purge_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_order_bitfield_1_clearing_firm
        type: b1
      - id: purge_order_bitfield_1_reserved_2
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_inst
        type: b1
      - id: purge_order_bitfield_1_reserved_8
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_order_bitfield_1_reserved_32
        type: b1
      - id: purge_order_bitfield_1_reserved_64
        type: b1
      - id: purge_order_bitfield_1_reserved_128
        type: b1
  purge_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_order_bitfield_2_symbol
        type: b1
      - id: purge_order_bitfield_2_symbol_sfx
        type: b1
      - id: purge_order_bitfield_2_reserved_4
        type: b1
      - id: purge_order_bitfield_2_reserved_8
        type: b1
      - id: purge_order_bitfield_2_reserved_16
        type: b1
      - id: purge_order_bitfield_2_reserved_32
        type: b1
      - id: purge_order_bitfield_2_reserved_64
        type: b1
      - id: purge_order_bitfield_2_reserved_128
        type: b1
  order_acknowledgment_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'The time the event occurred in the CFE matching engine'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_1_side
        type: b1
      - id: return_bitfield_1_peg_difference
        type: b1
      - id: return_bitfield_1_price
        type: b1
      - id: return_bitfield_1_exec_inst
        type: b1
      - id: return_bitfield_1_ord_type
        type: b1
      - id: return_bitfield_1_time_in_force
        type: b1
      - id: return_bitfield_1_min_qty
        type: b1
      - id: return_bitfield_1_reserved_128
        type: b1
  return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_2_symbol
        type: b1
      - id: return_bitfield_2_symbol_sfx
        type: b1
      - id: return_bitfield_2_reserved_4
        type: b1
      - id: return_bitfield_2_reserved_8
        type: b1
      - id: return_bitfield_2_reserved_16
        type: b1
      - id: return_bitfield_2_reserved_32
        type: b1
      - id: return_bitfield_2_capacity
        type: b1
      - id: return_bitfield_2_reserved_128
        type: b1
  return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_3_account
        type: b1
      - id: return_bitfield_3_clearing_firm
        type: b1
      - id: return_bitfield_3_clearing_account
        type: b1
      - id: return_bitfield_3_display_indicator
        type: b1
      - id: return_bitfield_3_max_floor
        type: b1
      - id: return_bitfield_3_discretion_amount
        type: b1
      - id: return_bitfield_3_order_qty
        type: b1
      - id: return_bitfield_3_prevent_match
        type: b1
  return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_4_reserved_1
        type: b1
      - id: return_bitfield_4_reserved_2
        type: b1
      - id: return_bitfield_4_reserved_4
        type: b1
      - id: return_bitfield_4_reserved_8
        type: b1
      - id: return_bitfield_4_reserved_16
        type: b1
      - id: return_bitfield_4_reserved_32
        type: b1
      - id: return_bitfield_4_reserved_64
        type: b1
      - id: return_bitfield_4_reserved_128
        type: b1
  return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: return_bitfield_5_leaves_qty
        type: b1
      - id: return_bitfield_5_last_shares
        type: b1
      - id: return_bitfield_5_last_px
        type: b1
      - id: return_bitfield_5_display_price
        type: b1
      - id: return_bitfield_5_working_price
        type: b1
      - id: return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: return_bitfield_5_expire_time
        type: b1
  return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_6_secondary_order_id
        type: b1
      - id: return_bitfield_6_reserved_2
        type: b1
      - id: return_bitfield_6_reserved_4
        type: b1
      - id: return_bitfield_6_attributed_quote
        type: b1
      - id: return_bitfield_6_ext_exec_inst
        type: b1
      - id: return_bitfield_6_reserved_32
        type: b1
      - id: return_bitfield_6_reserved_64
        type: b1
      - id: return_bitfield_6_reserved_128
        type: b1
  return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: return_bitfield_7_reserved_2
        type: b1
      - id: return_bitfield_7_reserved_4
        type: b1
      - id: return_bitfield_7_reserved_8
        type: b1
      - id: return_bitfield_7_reserved_16
        type: b1
      - id: return_bitfield_7_reserved_32
        type: b1
      - id: return_bitfield_7_reserved_64
        type: b1
      - id: return_bitfield_7_reserved_128
        type: b1
  return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_8_fee_code
        type: b1
      - id: return_bitfield_8_echo_text
        type: b1
      - id: return_bitfield_8_stop_px
        type: b1
      - id: return_bitfield_8_routing_inst
        type: b1
      - id: return_bitfield_8_rout_strategy
        type: b1
      - id: return_bitfield_8_route_delivery_method
        type: b1
      - id: return_bitfield_8_ex_destination
        type: b1
      - id: return_bitfield_8_reserved_128
        type: b1
  return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_9_reserved_1
        type: b1
      - id: return_bitfield_9_reserved_2
        type: b1
      - id: return_bitfield_9_reserved_4
        type: b1
      - id: return_bitfield_9_reserved_8
        type: b1
      - id: return_bitfield_9_reserved_16
        type: b1
      - id: return_bitfield_9_reserved_32
        type: b1
      - id: return_bitfield_9_reserved_64
        type: b1
      - id: return_bitfield_9_reserved_128
        type: b1
  return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_10_reserved_1
        type: b1
      - id: return_bitfield_10_reserved_2
        type: b1
      - id: return_bitfield_10_reserved_4
        type: b1
      - id: return_bitfield_10_reserved_8
        type: b1
      - id: return_bitfield_10_reserved_16
        type: b1
      - id: return_bitfield_10_reserved_32
        type: b1
      - id: return_bitfield_10_reserved_64
        type: b1
      - id: return_bitfield_10_reserved_128
        type: b1
  return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_11_reserved_1
        type: b1
      - id: return_bitfield_11_reserved_2
        type: b1
      - id: return_bitfield_11_reserved_4
        type: b1
      - id: return_bitfield_11_reserved_8
        type: b1
      - id: return_bitfield_11_reserved_16
        type: b1
      - id: return_bitfield_11_reserved_32
        type: b1
      - id: return_bitfield_11_reserved_64
        type: b1
      - id: return_bitfield_11_reserved_128
        type: b1
  return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_12_reserved_1
        type: b1
      - id: return_bitfield_12_reserved_2
        type: b1
      - id: return_bitfield_12_reserved_4
        type: b1
      - id: return_bitfield_12_reserved_8
        type: b1
      - id: return_bitfield_12_reserved_16
        type: b1
      - id: return_bitfield_12_reserved_32
        type: b1
      - id: return_bitfield_12_reserved_64
        type: b1
      - id: return_bitfield_12_reserved_128
        type: b1
  return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_13_reserved_1
        type: b1
      - id: return_bitfield_13_reserved_2
        type: b1
      - id: return_bitfield_13_reserved_4
        type: b1
      - id: return_bitfield_13_reserved_8
        type: b1
      - id: return_bitfield_13_reserved_16
        type: b1
      - id: return_bitfield_13_reserved_32
        type: b1
      - id: return_bitfield_13_reserved_64
        type: b1
      - id: return_bitfield_13_reserved_128
        type: b1
  return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_14_reserved_1
        type: b1
      - id: return_bitfield_14_reserved_2
        type: b1
      - id: return_bitfield_14_reserved_4
        type: b1
      - id: return_bitfield_14_reserved_8
        type: b1
      - id: return_bitfield_14_reserved_16
        type: b1
      - id: return_bitfield_14_reserved_32
        type: b1
      - id: return_bitfield_14_reserved_64
        type: b1
      - id: return_bitfield_14_reserved_128
        type: b1
  return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_15_reserved_1
        type: b1
      - id: return_bitfield_15_reserved_2
        type: b1
      - id: return_bitfield_15_reserved_4
        type: b1
      - id: return_bitfield_15_mass_cancel_id
        type: b1
      - id: return_bitfield_15_reserved_16
        type: b1
      - id: return_bitfield_15_reserved_32
        type: b1
      - id: return_bitfield_15_reserved_64
        type: b1
      - id: return_bitfield_15_reserved_128
        type: b1
  return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_16_reserved_1
        type: b1
      - id: return_bitfield_16_reserved_2
        type: b1
      - id: return_bitfield_16_reserved_4
        type: b1
      - id: return_bitfield_16_reserved_8
        type: b1
      - id: return_bitfield_16_reserved_16
        type: b1
      - id: return_bitfield_16_reserved_32
        type: b1
      - id: return_bitfield_16_reserved_64
        type: b1
      - id: return_bitfield_16_reserved_128
        type: b1
  return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_17_reserved_1
        type: b1
      - id: return_bitfield_17_reserved_2
        type: b1
      - id: return_bitfield_17_reserved_4
        type: b1
      - id: return_bitfield_17_reserved_8
        type: b1
      - id: return_bitfield_17_reserved_16
        type: b1
      - id: return_bitfield_17_reserved_32
        type: b1
      - id: return_bitfield_17_reserved_64
        type: b1
      - id: return_bitfield_17_reserved_128
        type: b1
  order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  order_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  user_modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator
  order_cancelled_message:
    seq:
      - id: transact_time
        type: u8
        doc: 'The time the event occurred in the CFE matching engine'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Order Cancel Reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason for the order cancellation'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
      - id: last_shares
        type: u4
      - id: last_px
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_ref_id
        type: u8
        doc: 'Refers to the ExecID of the fill being cancelled or corrected. Corresponds to ExecRefID (19) in Cboe FIX'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: last_shares
        type: u4
      - id: last_px
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'For trade corrections, this is the new trade price. For trade breaks, this is set to 0. Implied decimal with scale 1e-4'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'The date and time of the original trade, in GMT. Corresponds to OrigTime (42). Nanoseconds since Unix epoch'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. This field corresponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Bitfield identifying which bitfields are set. Field values must be appended to the end of the message'
      - id: return_bitfield_1
        type: return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: return_bitfield_2
        type: return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: return_bitfield_3
        type: return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: return_bitfield_4
        type: return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: return_bitfield_5
        type: return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: return_bitfield_6
        type: return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: return_bitfield_7
        type: return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: return_bitfield_8
        type: return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: return_bitfield_9
        type: return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: return_bitfield_10
        type: return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: return_bitfield_11
        type: return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: return_bitfield_12
        type: return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: return_bitfield_13
        type: return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: return_bitfield_14
        type: return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: return_bitfield_15
        type: return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: return_bitfield_16
        type: return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: return_bitfield_17
        type: return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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
    0x37:
      id: 'login_request_message'
      doc: 'A Login Response message is sent in response to a Login Request message. On a successful login, the LoginResponseStatus will be set to ‘A’. On a failed login, LoginResponseStatus will be set to a value other than ‘A’, and LoginResponseText will be set to an appropriate failure description.'
    0x02:
      id: 'logout_request_message'
      doc: 'To end the session, the Member should send a Logout Request message. Cboe will finish sending any queued data and finally respond with a Logout message and close the connection.'
    0x03:
      id: 'client_heartbeat_message'
      doc: 'Heartbeat.'
    0x24:
      id: 'login_response_message'
      doc: 'A Login Response message is sent in response to a Login Request message. On a successful login, the LoginResponseStatus will be set to ‘A’. On a failed login, LoginResponseStatus will be set to a value other than ‘A’, and LoginResponseText will be set to an appropriate failure description.'
    0x08:
      id: 'logout_message'
      doc: 'A Logout is usually sent in response to a Logout Request. Any queued data is transmitted, a Logout is sent, and Cboe will close the connection.'
    0x09:
      id: 'server_heartbeat_message'
      doc: 'Heartbeat.'
    0x13:
      id: 'replay_complete_message'
      doc: 'Replay Complete.'
    0x38:
      id: 'new_order_message'
      doc: 'A new order message consists of a number of required fields followed by a number of optional fields.'
    0x39:
      id: 'cancel_order_message'
      doc: 'Request to cancel either a single order or mass cancellation of a group of orders.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Request to modify an order.'
    0x47:
      id: 'purge_order_message'
      doc: 'Request to cancel a group of orders across all the firm’s sessions.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'An order has been acknowledged'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Request to indicate that the order has been successfully modified.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated messages are sent to inform the Member that an order has been asynchronously modified.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'An order has been cancelled.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur. Cancel Rejected messages are unsequenced.'
    0x2c:
      id: 'order_execution_message'
      doc: 'An Order Execution is sent for each fill on an order.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected (price or size change only).'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'A Mass Cancel Acknowledgment is an unsequenced message sent when a Cancel Order or Purge Orders message requesting a mass cancellation has completed cancelling all individual orders.'
    0x48:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized'
    0x44:
      id: 'session_is_disabled'
      doc: 'Session Is Disabled'
    0x42:
      id: 'session_in_use'
      doc: 'Session In Use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid Session'
    0x51:
      id: 'sequence_ahead_in_login_message'
      doc: 'Sequence Ahead In Login Message'
    0x49:
      id: 'invalid_unit_given_in_login_message'
      doc: 'Invalid Unit Given In Login Message'
    0x46:
      id: 'invalid_return_bit_field_in_login_message'
      doc: 'Invalid Return Bit Field In Login Message'
    0x4d:
      id: 'invalid_login_request_message_structure'
      doc: 'Invalid Login Request Message Structure'
  no_unspecified_unit_replay:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  logout_reason:
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x41:
      id: 'administrative'
      doc: 'Administrative'
    0x21:
      id: 'protocol_violation'
      doc: 'Protocol Violation'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x35:
      id: 'short_sell'
      doc: 'Short Sell'
    0x36:
      id: 'short_sell_exempt'
      doc: 'Short Sell Exempt'
  exec_inst:
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x50:
      id: 'market_peg'
      doc: 'Market Peg'
    0x51:
      id: 'market_marker_peg'
      doc: 'Market Marker Peg'
    0x52:
      id: 'primary_peg'
      doc: 'Primary Peg'
    0x55:
      id: 'supplemental_peg_order'
      doc: 'Supplemental Peg Order'
    0x4d:
      id: 'midpoint_peg'
      doc: 'Midpoint Peg'
    0x6d:
      id: 'midpoint_peg_but_no_match_on_nbbo_lock'
      doc: 'Midpoint Peg But No Match On Nbbo Lock'
    0x4c:
      id: 'alternate_midpoint'
      doc: 'Alternate Midpoint'
    0x72:
      id: 'late'
      doc: 'Late'
    0x6f:
      id: 'listing_market_opening'
      doc: 'Listing Market Opening'
    0x63:
      id: 'listing_market_close'
      doc: 'Listing Market Close'
    0x61:
      id: 'both_listing_market_open_and_close'
      doc: 'Both Listing Market Open And Close'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x33:
      id: 'stop'
      doc: 'Stop'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
    0x50:
      id: 'pegged'
      doc: 'Pegged'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'gtc'
      doc: 'Gtc'
    0x32:
      id: 'at_the_open'
      doc: 'At The Open'
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok'
    0x35:
      id: 'gtx'
      doc: 'Gtx'
    0x36:
      id: 'gtd'
      doc: 'Gtd'
    0x37:
      id: 'at_the_close'
      doc: 'At The Close'
    0x45:
      id: 'pre'
      doc: 'Pre'
    0x52:
      id: 'rho'
      doc: 'Rho'
    0x54:
      id: 'ptd'
      doc: 'Ptd'
    0x58:
      id: 'ptx'
      doc: 'Ptx'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
  display_indicator:
    0x56:
      id: 'determined_by_port_level_setting'
      doc: 'Determined By Port Level Setting'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'cancel_back_the_order_if_it_cannot_be_booked_and_displayed_without_adjustment'
      doc: 'Cancel Back The Order If It Cannot Be Booked And Displayed Without Adjustment'
    0x72:
      id: 'hidden_cancel_back_the_order_if_it_cannot_be_booked_without_adjustment'
      doc: 'Hidden Cancel Back The Order If It Cannot Be Booked Without Adjustment'
    0x53:
      id: 'display_price_sliding'
      doc: 'Display Price Sliding'
    0x4c:
      id: 'display_price_sliding_but_reject_if_order_crosses_the_nbbo_on_entry'
      doc: 'Display Price Sliding But Reject If Order Crosses The Nbbo On Entry'
    0x4d:
      id: 'multiple_display_price_sliding'
      doc: 'Multiple Display Price Sliding'
    0x76:
      id: 'visible'
      doc: 'Visible'
    0x49:
      id: 'invisible'
      doc: 'Invisible'
    0x4e:
      id: 'no_rescrape_at_limit'
      doc: 'No Rescrape At Limit'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_mpid'
      doc: 'Do Not Attribute Firm Mpid'
    0x59:
      id: 'attribute_firm_mpid'
      doc: 'Attribute Firm Mpid'
    0x52:
      id: 'attribute_rtal'
      doc: 'Attribute Rtal'
  ext_exec_inst:
    0x4e:
      id: 'none'
      doc: 'None'
    0x52:
      id: 'order_eligible_for_retail_rebate'
      doc: 'Order Eligible For Retail Rebate'
  ex_destination:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x48:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x49:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x4a:
      id: 'edga'
      doc: 'Edga'
    0x4b:
      id: 'edgx'
      doc: 'Edgx'
    0x4c:
      id: 'long_term_stock_exchange'
      doc: 'Long Term Stock Exchange'
    0x4d:
      id: 'chx'
      doc: 'Chx'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx'
    0x59:
      id: 'byx'
      doc: 'Byx'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x58:
      id: 'routed_to_another_market'
      doc: 'Routed To Another Market'
    0x43:
      id: 'auction_or_uncrossing'
      doc: 'Auction Or Uncrossing'
  sub_liquidity_indicator:
    0x45:
      id: 'trade_added_rpi_liquidity'
      doc: 'Trade Added Rpi Liquidity'
    0x48:
      id: 'trade_added_hidden_liquidity'
      doc: 'Trade Added Hidden Liquidity'
    0x49:
      id: 'trade_added_hidden_liquidity_that_was_price_improved'
      doc: 'Trade Added Hidden Liquidity That Was Price Improved'
    0x6d:
      id: 'midpoint_peg_order'
      doc: 'Midpoint Peg Order'
    0x4a:
      id: 'execution_from_first_order_to_join_the_nbbo'
      doc: 'Execution From First Order To Join The Nbbo'
    0x53:
      id: 'execution_from_order_that_set_the_nbbo'
      doc: 'Execution From Order That Set The Nbbo'
    0x56:
      id: 'visible_liquidity_add_trade_that_was_price_improved'
      doc: 'Visible Liquidity Add Trade That Was Price Improved'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  restatement_reason:
    0x43:
      id: 'cboe_market_close'
      doc: 'Cboe Market Close'
    0x4c:
      id: 'reload'
      doc: 'Reload'
    0x50:
      id: 'peg_or_price_sliding_reprice'
      doc: 'Peg Or Price Sliding Reprice'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated'
    0x52:
      id: 'reroute'
      doc: 'Reroute'
    0x53:
      id: 'reduction_of_quantity'
      doc: 'Reduction Of Quantity'
    0x57:
      id: 'wash'
      doc: 'Wash'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
    0x45:
      id: 'size_reduction_due_to_swp_restatement'
      doc: 'Size Reduction Due To Swp Restatement'
    0x46:
      id: 'failed_to_quote'
      doc: 'Failed To Quote'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too Late To Cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'order_would_lock_or_cross_nbbo'
      doc: 'Order Would Lock Or Cross Nbbo'
    0x4d:
      id: 'order_size_exceeded'
      doc: 'Order Size Exceeded'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out Of Liquidity To Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'Cl Ord Id Doesnt Match A Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Cant Modify An Order That Is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
    0x52:
      id: 'routing_unavailable'
      doc: 'Routing Unavailable'
    0x53:
      id: 'short_sale_price_violation'
      doc: 'Short Sale Price Violation'
    0x54:
      id: 'fill_would_trade_through_the_nbbo'
      doc: 'Fill Would Trade Through The Nbbo'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x57:
      id: 'add_liquidity_only_order_would_remove'
      doc: 'Add Liquidity Only Order Would Remove'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'

