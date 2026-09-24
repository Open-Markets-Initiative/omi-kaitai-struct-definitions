# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities BinaryOrderEntry Boe v2.4.57
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.4.57
#   Date: 9/8/2026
#   Specification: Cboe Titanium U.S. Equities BOE Specification.pdf
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
  id: cboe_bzxequities_binaryorderentry_boe_v2_4_57
  title: Cboe BzxEquities BinaryOrderEntry Boe v2.4.57
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Binary Order Entry Boe v2.4.57'
doc-ref: https://www.cboe.com/us/equities/support/technical/

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
        doc: 'Return message type for which the bitfields are being specified (e.g., 0x25 for an Order Acknowledgment message)'
      - id: matching_unit
        type: u1
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
        doc: 'Repeating group stated NumberOfParamGroups times'
  param_group:
    seq:
      - id: param_group_length
        type: u2
        doc: 'Number of bytes for the parameter group, including this field'
      - id: param_group_type
        type: u1
        doc: '0x80'
  login_response_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted, or the reason for the rejection. A=Login Accepted N=Not authorized (invalid username/password) D=Session is disabled B=Session in use S=Invalid session Q=Sequence ahead in Login message I=Invalid unit given in Login message F=Invalid return bit field in Login message M=Invalid Login Request message structure'
      - id: login_response_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for rejection. ASCII NUL (0x00) filled on the right, if necessary'
      - id: no_unspecified_unit_replay
        type: u1
        doc: 'Echoed back from the original Login Request message'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Member to Cboe) message sequence number processed by Cboe'
      - id: num_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: units
        type: units
        repeat: expr
        repeat-expr: num_units
        doc: 'Repeating group stated NumberOfUnits times'
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Repeating group stated NumberOfParamGroups times'
  units:
    seq:
      - id: unit_number
        type: u1
        doc: 'A unit number'
      - id: unit_sequence
        type: u4
        doc: 'Highest available Cboe to Member sequence number for the unit'
  logout_message:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'The reason why the Logout message was sent. U=User Requested E=End of Day A=Administrative !=Protocol Violation'
      - id: logout_reason_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional information about the reason for logout. Particularly useful if LogoutReason = ! (Protocol Violation)'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Member to Cboe) message sequence number processed by Cboe'
      - id: num_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: units
        type: units
        repeat: expr
        repeat-expr: num_units
        doc: 'Repeating group stated NumberOfUnits times'
  new_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: number_of_new_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
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
      - id: new_order_bitfield_8
        type: new_order_bitfield_8
        if: number_of_new_order_bitfields >= 8
        doc: 'BitSet NewOrder byte 8'
      - id: new_order_bitfield_9
        type: new_order_bitfield_9
        if: number_of_new_order_bitfields >= 9
        doc: 'BitSet NewOrder byte 9'
      - id: new_order_bitfield_10
        type: new_order_bitfield_10
        if: number_of_new_order_bitfields >= 10
        doc: 'BitSet NewOrder byte 10'
      - id: new_order_bitfield_11
        type: new_order_bitfield_11
        if: number_of_new_order_bitfields >= 11
        doc: 'BitSet NewOrder byte 11'
      - id: new_order_bitfield_12
        type: new_order_bitfield_12
        if: number_of_new_order_bitfields >= 12
        doc: 'BitSet NewOrder byte 12'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_clearing_account > 0
      - id: price
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_min_qty > 0
      - id: max_floor
        type: u4
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_max_floor > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_capacity > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_routing_inst > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_display_indicator > 0
      - id: discretion_amount
        type: u2
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_discretion_amount > 0
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_prevent_match > 0
      - id: locate_reqd
        type: u1
        enum: locate_reqd
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_locate_reqd > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_risk_reset > 0
      - id: display_range
        type: u4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_display_range > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_ex_destination > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_echo_text > 0
      - id: risk_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_risk_group_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_bitfields >= 10 and new_order_bitfield_10.new_order_bitfield_10_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_new_order_bitfields >= 10 and new_order_bitfield_10.new_order_bitfield_10_ext_exec_inst > 0
      - id: cross_trade_flag
        type: u1
        enum: cross_trade_flag
        if: number_of_new_order_bitfields >= 11 and new_order_bitfield_11.new_order_bitfield_11_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 12 and new_order_bitfield_12.new_order_bitfield_12_locate_broker > 0
      - id: cmc_sessions
        type: str
        size: 2
        encoding: ASCII
        if: number_of_new_order_bitfields >= 12 and new_order_bitfield_12.new_order_bitfield_12_cmc_sessions > 0
      - id: step_up_amount
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 12 and new_order_bitfield_12.new_order_bitfield_12_step_up_amount > 0
        doc: 'Implied decimal with scale 1e-4'
  new_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_1_new_order_input_bitfields
        type: b1
      - id: new_order_bitfield_1_reserved_2
        type: b1
      - id: new_order_bitfield_1_reserved_4
        type: b1
      - id: new_order_bitfield_1_reserved_8
        type: b1
      - id: new_order_bitfield_1_reserved_16
        type: b1
      - id: new_order_bitfield_1_reserved_32
        type: b1
      - id: new_order_bitfield_1_reserved_64
        type: b1
      - id: new_order_bitfield_1_reserved_128
        type: b1
  new_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_2_clearing_firm
        type: b1
      - id: new_order_bitfield_2_clearing_account
        type: b1
      - id: new_order_bitfield_2_price
        type: b1
      - id: new_order_bitfield_2_exec_inst
        type: b1
      - id: new_order_bitfield_2_ord_type
        type: b1
      - id: new_order_bitfield_2_time_in_force
        type: b1
      - id: new_order_bitfield_2_min_qty
        type: b1
      - id: new_order_bitfield_2_max_floor
        type: b1
  new_order_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_3_symbol
        type: b1
      - id: new_order_bitfield_3_symbol_sfx
        type: b1
      - id: new_order_bitfield_3_currency
        type: b1
      - id: new_order_bitfield_3_id_source
        type: b1
      - id: new_order_bitfield_3_security_id
        type: b1
      - id: new_order_bitfield_3_security_exchange
        type: b1
      - id: new_order_bitfield_3_capacity
        type: b1
      - id: new_order_bitfield_3_routing_inst
        type: b1
  new_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_4_account
        type: b1
      - id: new_order_bitfield_4_display_indicator
        type: b1
      - id: new_order_bitfield_4_reserved_4
        type: b1
      - id: new_order_bitfield_4_discretion_amount
        type: b1
      - id: new_order_bitfield_4_peg_difference
        type: b1
      - id: new_order_bitfield_4_prevent_match
        type: b1
      - id: new_order_bitfield_4_locate_reqd
        type: b1
      - id: new_order_bitfield_4_expire_time
        type: b1
  new_order_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_5_maturity_date
        type: b1
      - id: new_order_bitfield_5_strike_price
        type: b1
      - id: new_order_bitfield_5_put_or_call
        type: b1
      - id: new_order_bitfield_5_risk_reset
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
      - id: new_order_bitfield_6_auction_id
        type: b1
      - id: new_order_bitfield_6_routing_firm_id
        type: b1
  new_order_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_7_algorithmic_indicator
        type: b1
      - id: new_order_bitfield_7_risk_group_id
        type: b1
      - id: new_order_bitfield_7_client_qualified_role
        type: b1
      - id: new_order_bitfield_7_investor_qualified_role
        type: b1
      - id: new_order_bitfield_7_executor_qualified_role
        type: b1
      - id: new_order_bitfield_7_cti_code
        type: b1
      - id: new_order_bitfield_7_manual_order_indicator
        type: b1
      - id: new_order_bitfield_7_operator_id
        type: b1
  new_order_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_8_reserved_1
        type: b1
      - id: new_order_bitfield_8_reserved_2
        type: b1
      - id: new_order_bitfield_8_clearing_optional_data
        type: b1
      - id: new_order_bitfield_8_client_id_attr
        type: b1
      - id: new_order_bitfield_8_frequent_trader_id
        type: b1
      - id: new_order_bitfield_8_compression
        type: b1
      - id: new_order_bitfield_8_floor_destination
        type: b1
      - id: new_order_bitfield_8_floor_routing_inst
        type: b1
  new_order_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_9_order_origin
        type: b1
      - id: new_order_bitfield_9_ors
        type: b1
      - id: new_order_bitfield_9_price_type
        type: b1
      - id: new_order_bitfield_9_reserved_8
        type: b1
      - id: new_order_bitfield_9_open_close
        type: b1
      - id: new_order_bitfield_9_cmta_number
        type: b1
      - id: new_order_bitfield_9_target_party_id
        type: b1
      - id: new_order_bitfield_9_reserved_128
        type: b1
  new_order_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_10_session_eligibility
        type: b1
      - id: new_order_bitfield_10_attributed_quote
        type: b1
      - id: new_order_bitfield_10_booking_type
        type: b1
      - id: new_order_bitfield_10_ext_exec_inst
        type: b1
      - id: new_order_bitfield_10_client_id
        type: b1
      - id: new_order_bitfield_10_investor_id
        type: b1
      - id: new_order_bitfield_10_executor_id
        type: b1
      - id: new_order_bitfield_10_order_origination
        type: b1
  new_order_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_11_reserved_1
        type: b1
      - id: new_order_bitfield_11_reserved_2
        type: b1
      - id: new_order_bitfield_11_reserved_4
        type: b1
      - id: new_order_bitfield_11_reserved_8
        type: b1
      - id: new_order_bitfield_11_reserved_16
        type: b1
      - id: new_order_bitfield_11_reserved_32
        type: b1
      - id: new_order_bitfield_11_cross_trade_flag
        type: b1
      - id: new_order_bitfield_11_reserved_128
        type: b1
  new_order_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_12_held
        type: b1
      - id: new_order_bitfield_12_locate_broker
        type: b1
      - id: new_order_bitfield_12_cmc_sessions
        type: b1
      - id: new_order_bitfield_12_step_up_amount
        type: b1
      - id: new_order_bitfield_12_reserved_16
        type: b1
      - id: new_order_bitfield_12_reserved_32
        type: b1
      - id: new_order_bitfield_12_reserved_64
        type: b1
      - id: new_order_bitfield_12_reserved_128
        type: b1
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: number_of_cancel_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
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
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_clearing_firm > 0
  cancel_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_bitfield_1_clearing_firm
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel_lockout
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel
        type: b1
      - id: cancel_order_bitfield_1_risk_root
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel_id
        type: b1
      - id: cancel_order_bitfield_1_routing_firm_id
        type: b1
      - id: cancel_order_bitfield_1_manual_order_indicator
        type: b1
      - id: cancel_order_bitfield_1_operator_id
        type: b1
  cancel_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_bitfield_2_mass_cancel_inst
        type: b1
      - id: cancel_order_bitfield_2_symbol
        type: b1
      - id: cancel_order_bitfield_2_symbol_sfx
        type: b1
      - id: cancel_order_bitfield_2_send_time
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: number_of_modify_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: modify_order_bitfield_1
        type: modify_order_bitfield_1
        if: number_of_modify_order_bitfields >= 1
        doc: 'BitSet ModifyOrder byte 1'
      - id: modify_order_bitfield_2
        type: modify_order_bitfield_2
        if: number_of_modify_order_bitfields >= 2
        doc: 'BitSet ModifyOrder byte 2'
      - id: price
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_ord_type > 0
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_cancel_orig_on_reject > 0
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_exec_inst > 0
      - id: side
        type: u1
        enum: side
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: max_floor
        type: u4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_max_floor > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_locate_broker > 0
  modify_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_bitfield_1_reserved_1
        type: b1
      - id: modify_order_bitfield_1_reserved_2
        type: b1
      - id: modify_order_bitfield_1_reserved_4
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
      - id: modify_order_bitfield_2_routing_firm_id
        type: b1
      - id: modify_order_bitfield_2_manual_order_indicator
        type: b1
      - id: modify_order_bitfield_2_operator_id
        type: b1
      - id: modify_order_bitfield_2_frequent_trader_id
        type: b1
      - id: modify_order_bitfield_2_reserved_64
        type: b1
      - id: modify_order_bitfield_2_locate_broker
        type: b1
  purge_order_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_purge_orders_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: purge_orders_bitfield_1
        type: purge_orders_bitfield_1
        if: number_of_purge_orders_bitfields >= 1
        doc: 'BitSet PurgeOrders byte 1'
      - id: purge_orders_bitfield_2
        type: purge_orders_bitfield_2
        if: number_of_purge_orders_bitfields >= 2
        doc: 'BitSet PurgeOrders byte 2'
      - id: num_risk_group_i_ds
        type: u1
        doc: 'Number of repeating RiskGroupID values included in this message'
      - id: risk_group_i_ds
        type: risk_group_i_ds
        repeat: expr
        repeat-expr: num_risk_group_i_ds
        doc: 'Repeating group stated RiskGroupIDCnt times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_clearing_firm > 0
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_inst > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_id > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 2 and purge_orders_bitfield_2.purge_orders_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 2 and purge_orders_bitfield_2.purge_orders_bitfield_2_symbol_sfx > 0
      - id: matching_unit
        type: u1
        if: number_of_purge_orders_bitfields >= 2 and purge_orders_bitfield_2.purge_orders_bitfield_2_matching_unit > 0
  purge_orders_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_orders_bitfield_1_clearing_firm
        type: b1
      - id: purge_orders_bitfield_1_mass_cancel_lockout
        type: b1
      - id: purge_orders_bitfield_1_mass_cancel_inst
        type: b1
      - id: purge_orders_bitfield_1_risk_root
        type: b1
      - id: purge_orders_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_orders_bitfield_1_routing_firm_id
        type: b1
      - id: purge_orders_bitfield_1_manual_order_indicator
        type: b1
      - id: purge_orders_bitfield_1_operator_id
        type: b1
  purge_orders_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_orders_bitfield_2_symbol
        type: b1
      - id: purge_orders_bitfield_2_symbol_sfx
        type: b1
      - id: purge_orders_bitfield_2_reserved_4
        type: b1
      - id: purge_orders_bitfield_2_reserved_8
        type: b1
      - id: purge_orders_bitfield_2_reserved_16
        type: b1
      - id: purge_orders_bitfield_2_reserved_32
        type: b1
      - id: purge_orders_bitfield_2_send_time
        type: b1
      - id: purge_orders_bitfield_2_matching_unit
        type: b1
  risk_group_i_ds:
    seq:
      - id: risk_group_id
        type: u2
  order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_acknowledgment_return_bitfield_1
        type: order_acknowledgment_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgment byte 1'
      - id: order_acknowledgment_return_bitfield_2
        type: order_acknowledgment_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgment byte 2'
      - id: order_acknowledgment_return_bitfield_3
        type: order_acknowledgment_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgment byte 3'
      - id: order_acknowledgment_return_bitfield_4
        type: order_acknowledgment_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgment byte 4'
      - id: order_acknowledgment_return_bitfield_5
        type: order_acknowledgment_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgment byte 5'
      - id: order_acknowledgment_return_bitfield_6
        type: order_acknowledgment_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgment byte 6'
      - id: order_acknowledgment_return_bitfield_7
        type: order_acknowledgment_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgment byte 7'
      - id: order_acknowledgment_return_bitfield_8
        type: order_acknowledgment_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgment byte 8'
      - id: order_acknowledgment_return_bitfield_9
        type: order_acknowledgment_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgment byte 9'
      - id: order_acknowledgment_return_bitfield_10
        type: order_acknowledgment_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgment byte 10'
      - id: order_acknowledgment_return_bitfield_11
        type: order_acknowledgment_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgment byte 11'
      - id: order_acknowledgment_return_bitfield_12
        type: order_acknowledgment_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgment byte 12'
      - id: order_acknowledgment_return_bitfield_13
        type: order_acknowledgment_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgment byte 13'
      - id: order_acknowledgment_return_bitfield_14
        type: order_acknowledgment_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgment byte 14'
      - id: order_acknowledgment_return_bitfield_15
        type: order_acknowledgment_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgment byte 15'
      - id: order_acknowledgment_return_bitfield_16
        type: order_acknowledgment_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgment byte 16'
      - id: order_acknowledgment_return_bitfield_17
        type: order_acknowledgment_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgment byte 17'
      - id: order_acknowledgment_return_bitfield_18
        type: order_acknowledgment_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: order_acknowledgment_return_bitfield_19
        type: order_acknowledgment_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: order_acknowledgment_return_bitfield_20
        type: order_acknowledgment_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderAcknowledgment byte 20'
      - id: order_acknowledgment_return_bitfield_21
        type: order_acknowledgment_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderAcknowledgment byte 21'
      - id: order_acknowledgment_return_bitfield_22
        type: order_acknowledgment_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderAcknowledgment byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_prevent_match > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_sub_liquidity_indicator > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_ex_destination > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 15 and order_acknowledgment_return_bitfield_15.order_acknowledgment_return_bitfield_15_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 15 and order_acknowledgment_return_bitfield_15.order_acknowledgment_return_bitfield_15_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 15 and order_acknowledgment_return_bitfield_15.order_acknowledgment_return_bitfield_15_ext_exec_inst > 0
      - id: cross_trade_flag
        type: u1
        enum: cross_trade_flag
        if: number_of_return_bitfields >= 21 and order_acknowledgment_return_bitfield_21.order_acknowledgment_return_bitfield_21_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_acknowledgment_return_bitfield_21.order_acknowledgment_return_bitfield_21_locate_broker > 0
      - id: cmc_sessions
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 22 and order_acknowledgment_return_bitfield_22.order_acknowledgment_return_bitfield_22_cmc_sessions > 0
      - id: step_up_amount
        type: decimal_s8_4
        if: number_of_return_bitfields >= 22 and order_acknowledgment_return_bitfield_22.order_acknowledgment_return_bitfield_22_step_up_amount > 0
        doc: 'Implied decimal with scale 1e-4'
  order_acknowledgment_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_1_order_acknowledgment_return_bitfields
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_2
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_4
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_2_side
        type: b1
      - id: order_acknowledgment_return_bitfield_2_peg_difference
        type: b1
      - id: order_acknowledgment_return_bitfield_2_price
        type: b1
      - id: order_acknowledgment_return_bitfield_2_exec_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_2_ord_type
        type: b1
      - id: order_acknowledgment_return_bitfield_2_time_in_force
        type: b1
      - id: order_acknowledgment_return_bitfield_2_min_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_2_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_3_symbol
        type: b1
      - id: order_acknowledgment_return_bitfield_3_symbol_sfx
        type: b1
      - id: order_acknowledgment_return_bitfield_3_currency
        type: b1
      - id: order_acknowledgment_return_bitfield_3_id_source
        type: b1
      - id: order_acknowledgment_return_bitfield_3_security_id
        type: b1
      - id: order_acknowledgment_return_bitfield_3_security_exchange
        type: b1
      - id: order_acknowledgment_return_bitfield_3_capacity
        type: b1
      - id: order_acknowledgment_return_bitfield_3_contra_trader
        type: b1
  order_acknowledgment_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_4_account
        type: b1
      - id: order_acknowledgment_return_bitfield_4_clearing_firm
        type: b1
      - id: order_acknowledgment_return_bitfield_4_clearing_account
        type: b1
      - id: order_acknowledgment_return_bitfield_4_display_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_4_max_floor
        type: b1
      - id: order_acknowledgment_return_bitfield_4_discretion_amount
        type: b1
      - id: order_acknowledgment_return_bitfield_4_order_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_4_prevent_match
        type: b1
  order_acknowledgment_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_5_maturity_date
        type: b1
      - id: order_acknowledgment_return_bitfield_5_strike_price
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_4
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_5_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_6_sub_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_6_trade_report_type_return
        type: b1
      - id: order_acknowledgment_return_bitfield_6_trade_publish_ind_return
        type: b1
      - id: order_acknowledgment_return_bitfield_6_text
        type: b1
      - id: order_acknowledgment_return_bitfield_6_bid
        type: b1
      - id: order_acknowledgment_return_bitfield_6_offer
        type: b1
      - id: order_acknowledgment_return_bitfield_6_large_size
        type: b1
      - id: order_acknowledgment_return_bitfield_6_last_mkt
        type: b1
  order_acknowledgment_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_7_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_7_echo_text
        type: b1
      - id: order_acknowledgment_return_bitfield_7_stop_px
        type: b1
      - id: order_acknowledgment_return_bitfield_7_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_7_rout_strategy
        type: b1
      - id: order_acknowledgment_return_bitfield_7_route_delivery_method
        type: b1
      - id: order_acknowledgment_return_bitfield_7_ex_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_7_trade_report_ref_id
        type: b1
  order_acknowledgment_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_8_marketing_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_8_target_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_8_auction_id
        type: b1
      - id: order_acknowledgment_return_bitfield_8_order_category
        type: b1
      - id: order_acknowledgment_return_bitfield_8_liquidity_provision
        type: b1
      - id: order_acknowledgment_return_bitfield_8_cmta_number
        type: b1
      - id: order_acknowledgment_return_bitfield_8_cross_type
        type: b1
      - id: order_acknowledgment_return_bitfield_8_cross_prioritization
        type: b1
  order_acknowledgment_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_9_cross_id
        type: b1
      - id: order_acknowledgment_return_bitfield_9_alloc_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_4
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_9_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_10_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_10_day_order_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_10_day_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_10_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_10_day_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_10_pending_status
        type: b1
      - id: order_acknowledgment_return_bitfield_10_drill_thru_protection
        type: b1
      - id: order_acknowledgment_return_bitfield_10_multileg_reporting_typ
        type: b1
  order_acknowledgment_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_11_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_11_leg_maturity_date
        type: b1
      - id: order_acknowledgment_return_bitfield_11_leg_strike_price
        type: b1
      - id: order_acknowledgment_return_bitfield_11_room_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_secondary_exec_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_user_request_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_sis_username
        type: b1
      - id: order_acknowledgment_return_bitfield_11_user_status
        type: b1
  order_acknowledgment_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_12_trade_reporting_indica
        type: b1
      - id: order_acknowledgment_return_bitfield_12_equity_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_12_equity_nbbo_protect
        type: b1
      - id: order_acknowledgment_return_bitfield_12_mass_cancel_id
        type: b1
      - id: order_acknowledgment_return_bitfield_12_trade_publish_ind
        type: b1
      - id: order_acknowledgment_return_bitfield_12_report_time
        type: b1
      - id: order_acknowledgment_return_bitfield_12_leg_symbol_sfx
        type: b1
      - id: order_acknowledgment_return_bitfield_12_client_id_attr
        type: b1
  order_acknowledgment_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_13_frequent_trader_id
        type: b1
      - id: order_acknowledgment_return_bitfield_13_session_eligibility
        type: b1
      - id: order_acknowledgment_return_bitfield_13_put_or_call
        type: b1
      - id: order_acknowledgment_return_bitfield_13_open_close
        type: b1
      - id: order_acknowledgment_return_bitfield_13_cl_ord_id_batch
        type: b1
      - id: order_acknowledgment_return_bitfield_13_corrected_size
        type: b1
      - id: order_acknowledgment_return_bitfield_13_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_13_access_fee
        type: b1
  order_acknowledgment_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_14_orig_cl_ord_id
        type: b1
      - id: order_acknowledgment_return_bitfield_14_leaves_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_14_last_shares
        type: b1
      - id: order_acknowledgment_return_bitfield_14_last_px
        type: b1
      - id: order_acknowledgment_return_bitfield_14_display_price
        type: b1
      - id: order_acknowledgment_return_bitfield_14_working_price
        type: b1
      - id: order_acknowledgment_return_bitfield_14_base_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_14_expire_time
        type: b1
  order_acknowledgment_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_15_secondary_order_id
        type: b1
      - id: order_acknowledgment_return_bitfield_15_ccp
        type: b1
      - id: order_acknowledgment_return_bitfield_15_contra_capacity
        type: b1
      - id: order_acknowledgment_return_bitfield_15_attributed_quote
        type: b1
      - id: order_acknowledgment_return_bitfield_15_ext_exec_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_15_bulk_order_ids
        type: b1
      - id: order_acknowledgment_return_bitfield_15_bulk_reject_reasons
        type: b1
      - id: order_acknowledgment_return_bitfield_15_party_role
        type: b1
  order_acknowledgment_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_16_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_16_reserved_2
        type: b1
      - id: order_acknowledgment_return_bitfield_16_give_up_firm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_routing_firm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_waiver_type
        type: b1
      - id: order_acknowledgment_return_bitfield_16_cross_exclusion_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_16_price_formation
        type: b1
      - id: order_acknowledgment_return_bitfield_16_client_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_17_client_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_investor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_executor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_order_origination
        type: b1
      - id: order_acknowledgment_return_bitfield_17_algo
        type: b1
      - id: order_acknowledgment_return_bitfield_17_deferral_reason
        type: b1
      - id: order_acknowledgment_return_bitfield_17_investor_qualified_role
        type: b1
      - id: order_acknowledgment_return_bitfield_17_executor_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_18_cti_code
        type: b1
      - id: order_acknowledgment_return_bitfield_18_manual_order_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_18_operator_id
        type: b1
      - id: order_acknowledgment_return_bitfield_18_trade_date
        type: b1
      - id: order_acknowledgment_return_bitfield_18_clearing_price
        type: b1
      - id: order_acknowledgment_return_bitfield_18_clearing_size
        type: b1
      - id: order_acknowledgment_return_bitfield_18_clearing_symbol
        type: b1
      - id: order_acknowledgment_return_bitfield_18_clearing_optional_data
        type: b1
  order_acknowledgment_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_19_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_19_reserved_2
        type: b1
      - id: order_acknowledgment_return_bitfield_19_combo_order
        type: b1
      - id: order_acknowledgment_return_bitfield_19_compression
        type: b1
      - id: order_acknowledgment_return_bitfield_19_floor_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_19_floor_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_acknowledgment_return_bitfield_19_order_origin
        type: b1
  order_acknowledgment_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_20_price_type
        type: b1
      - id: order_acknowledgment_return_bitfield_20_strategy_id
        type: b1
      - id: order_acknowledgment_return_bitfield_20_trading_session_id
        type: b1
      - id: order_acknowledgment_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: order_acknowledgment_return_bitfield_20_sender_location_id
        type: b1
      - id: order_acknowledgment_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_acknowledgment_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_20_cust_order_handling_in
        type: b1
  order_acknowledgment_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_21_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_21_cross_initiator
        type: b1
      - id: order_acknowledgment_return_bitfield_21_subreason
        type: b1
      - id: order_acknowledgment_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_acknowledgment_return_bitfield_21_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_21_held
        type: b1
      - id: order_acknowledgment_return_bitfield_21_locate_broker
        type: b1
      - id: order_acknowledgment_return_bitfield_21_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_acknowledgment_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_acknowledgment_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_acknowledgment_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: order_acknowledgment_return_bitfield_22_cmc_match_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_22_step_up_amount
        type: b1
      - id: order_acknowledgment_return_bitfield_22_reserved_128
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_rejected_return_bitfield_1
        type: order_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderRejected byte 1'
      - id: order_rejected_return_bitfield_2
        type: order_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderRejected byte 2'
      - id: order_rejected_return_bitfield_3
        type: order_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderRejected byte 3'
      - id: order_rejected_return_bitfield_4
        type: order_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderRejected byte 4'
      - id: order_rejected_return_bitfield_5
        type: order_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderRejected byte 5'
      - id: order_rejected_return_bitfield_6
        type: order_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderRejected byte 6'
      - id: order_rejected_return_bitfield_7
        type: order_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderRejected byte 7'
      - id: order_rejected_return_bitfield_8
        type: order_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderRejected byte 8'
      - id: order_rejected_return_bitfield_9
        type: order_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderRejected byte 9'
      - id: order_rejected_return_bitfield_10
        type: order_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderRejected byte 10'
      - id: order_rejected_return_bitfield_11
        type: order_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderRejected byte 11'
      - id: order_rejected_return_bitfield_12
        type: order_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderRejected byte 12'
      - id: order_rejected_return_bitfield_13
        type: order_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderRejected byte 13'
      - id: order_rejected_return_bitfield_14
        type: order_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderRejected byte 14'
      - id: order_rejected_return_bitfield_15
        type: order_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderRejected byte 15'
      - id: order_rejected_return_bitfield_16
        type: order_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderRejected byte 16'
      - id: order_rejected_return_bitfield_17
        type: order_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderRejected byte 17'
      - id: order_rejected_return_bitfield_18
        type: order_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderRejected byte 18'
      - id: order_rejected_return_bitfield_19
        type: order_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderRejected byte 19'
      - id: order_rejected_return_bitfield_20
        type: order_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderRejected byte 20'
      - id: order_rejected_return_bitfield_21
        type: order_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderRejected byte 21'
      - id: order_rejected_return_bitfield_22
        type: order_rejected_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderRejected byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_rejected_return_bitfield_5.order_rejected_return_bitfield_5_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_rejected_return_bitfield_5.order_rejected_return_bitfield_5_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 5 and order_rejected_return_bitfield_5.order_rejected_return_bitfield_5_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_prevent_match > 0
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 9 and order_rejected_return_bitfield_9.order_rejected_return_bitfield_9_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 9 and order_rejected_return_bitfield_9.order_rejected_return_bitfield_9_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 9 and order_rejected_return_bitfield_9.order_rejected_return_bitfield_9_ext_exec_inst > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_ex_destination > 0
  order_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_1_order_rejected_return_bitfields
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_2
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_4
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_128
        type: b1
  order_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_2_side
        type: b1
      - id: order_rejected_return_bitfield_2_peg_difference
        type: b1
      - id: order_rejected_return_bitfield_2_price
        type: b1
      - id: order_rejected_return_bitfield_2_exec_inst
        type: b1
      - id: order_rejected_return_bitfield_2_ord_type
        type: b1
      - id: order_rejected_return_bitfield_2_time_in_force
        type: b1
      - id: order_rejected_return_bitfield_2_min_qty
        type: b1
      - id: order_rejected_return_bitfield_2_reserved_128
        type: b1
  order_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_3_sub_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_3_trade_report_type_return
        type: b1
      - id: order_rejected_return_bitfield_3_trade_publish_ind_return
        type: b1
      - id: order_rejected_return_bitfield_3_text
        type: b1
      - id: order_rejected_return_bitfield_3_bid
        type: b1
      - id: order_rejected_return_bitfield_3_offer
        type: b1
      - id: order_rejected_return_bitfield_3_large_size
        type: b1
      - id: order_rejected_return_bitfield_3_reserved_128
        type: b1
  order_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_4_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_4_day_order_qty
        type: b1
      - id: order_rejected_return_bitfield_4_day_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_4_avg_px
        type: b1
      - id: order_rejected_return_bitfield_4_day_avg_px
        type: b1
      - id: order_rejected_return_bitfield_4_pending_status
        type: b1
      - id: order_rejected_return_bitfield_4_drill_thru_protection
        type: b1
      - id: order_rejected_return_bitfield_4_reserved_128
        type: b1
  order_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_5_symbol
        type: b1
      - id: order_rejected_return_bitfield_5_symbol_sfx
        type: b1
      - id: order_rejected_return_bitfield_5_currency
        type: b1
      - id: order_rejected_return_bitfield_5_id_source
        type: b1
      - id: order_rejected_return_bitfield_5_security_id
        type: b1
      - id: order_rejected_return_bitfield_5_security_exchange
        type: b1
      - id: order_rejected_return_bitfield_5_capacity
        type: b1
      - id: order_rejected_return_bitfield_5_contra_trader
        type: b1
  order_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_6_account
        type: b1
      - id: order_rejected_return_bitfield_6_clearing_firm
        type: b1
      - id: order_rejected_return_bitfield_6_clearing_account
        type: b1
      - id: order_rejected_return_bitfield_6_display_indicator
        type: b1
      - id: order_rejected_return_bitfield_6_max_floor
        type: b1
      - id: order_rejected_return_bitfield_6_discretion_amount
        type: b1
      - id: order_rejected_return_bitfield_6_order_qty
        type: b1
      - id: order_rejected_return_bitfield_6_prevent_match
        type: b1
  order_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_7_maturity_date
        type: b1
      - id: order_rejected_return_bitfield_7_strike_price
        type: b1
      - id: order_rejected_return_bitfield_7_put_or_call
        type: b1
      - id: order_rejected_return_bitfield_7_open_close
        type: b1
      - id: order_rejected_return_bitfield_7_cl_ord_id_batch
        type: b1
      - id: order_rejected_return_bitfield_7_corrected_size
        type: b1
      - id: order_rejected_return_bitfield_7_party_id
        type: b1
      - id: order_rejected_return_bitfield_7_access_fee
        type: b1
  order_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_8_orig_cl_ord_id
        type: b1
      - id: order_rejected_return_bitfield_8_leaves_qty
        type: b1
      - id: order_rejected_return_bitfield_8_last_shares
        type: b1
      - id: order_rejected_return_bitfield_8_last_px
        type: b1
      - id: order_rejected_return_bitfield_8_display_price
        type: b1
      - id: order_rejected_return_bitfield_8_working_price
        type: b1
      - id: order_rejected_return_bitfield_8_base_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_8_expire_time
        type: b1
  order_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_9_secondary_order_id
        type: b1
      - id: order_rejected_return_bitfield_9_ccp
        type: b1
      - id: order_rejected_return_bitfield_9_contra_capacity
        type: b1
      - id: order_rejected_return_bitfield_9_attributed_quote
        type: b1
      - id: order_rejected_return_bitfield_9_ext_exec_inst
        type: b1
      - id: order_rejected_return_bitfield_9_bulk_order_ids
        type: b1
      - id: order_rejected_return_bitfield_9_bulk_reject_reasons
        type: b1
      - id: order_rejected_return_bitfield_9_party_role
        type: b1
  order_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_10_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_2
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_4
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_10_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_10_last_mkt
        type: b1
  order_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_11_fee_code
        type: b1
      - id: order_rejected_return_bitfield_11_echo_text
        type: b1
      - id: order_rejected_return_bitfield_11_stop_px
        type: b1
      - id: order_rejected_return_bitfield_11_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_11_rout_strategy
        type: b1
      - id: order_rejected_return_bitfield_11_route_delivery_method
        type: b1
      - id: order_rejected_return_bitfield_11_ex_destination
        type: b1
      - id: order_rejected_return_bitfield_11_trade_report_ref_id
        type: b1
  order_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_12_marketing_fee_code
        type: b1
      - id: order_rejected_return_bitfield_12_target_party_id
        type: b1
      - id: order_rejected_return_bitfield_12_auction_id
        type: b1
      - id: order_rejected_return_bitfield_12_order_category
        type: b1
      - id: order_rejected_return_bitfield_12_liquidity_provision
        type: b1
      - id: order_rejected_return_bitfield_12_cmta_number
        type: b1
      - id: order_rejected_return_bitfield_12_cross_type
        type: b1
      - id: order_rejected_return_bitfield_12_cross_prioritization
        type: b1
  order_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_13_cross_id
        type: b1
      - id: order_rejected_return_bitfield_13_alloc_qty
        type: b1
      - id: order_rejected_return_bitfield_13_give_up_firm_id
        type: b1
      - id: order_rejected_return_bitfield_13_routing_firm_id
        type: b1
      - id: order_rejected_return_bitfield_13_waiver_type
        type: b1
      - id: order_rejected_return_bitfield_13_cross_exclusion_indicator
        type: b1
      - id: order_rejected_return_bitfield_13_price_formation
        type: b1
      - id: order_rejected_return_bitfield_13_client_qualified_role
        type: b1
  order_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_14_client_id
        type: b1
      - id: order_rejected_return_bitfield_14_investor_id
        type: b1
      - id: order_rejected_return_bitfield_14_executor_id
        type: b1
      - id: order_rejected_return_bitfield_14_order_origination
        type: b1
      - id: order_rejected_return_bitfield_14_algo
        type: b1
      - id: order_rejected_return_bitfield_14_deferral_reason
        type: b1
      - id: order_rejected_return_bitfield_14_investor_qualified_role
        type: b1
      - id: order_rejected_return_bitfield_14_executor_qualified_role
        type: b1
  order_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_15_cti_code
        type: b1
      - id: order_rejected_return_bitfield_15_manual_order_indicator
        type: b1
      - id: order_rejected_return_bitfield_15_operator_id
        type: b1
      - id: order_rejected_return_bitfield_15_trade_date
        type: b1
      - id: order_rejected_return_bitfield_15_clearing_price
        type: b1
      - id: order_rejected_return_bitfield_15_clearing_size
        type: b1
      - id: order_rejected_return_bitfield_15_clearing_symbol
        type: b1
      - id: order_rejected_return_bitfield_15_clearing_optional_data
        type: b1
  order_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_16_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_2
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_4
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_16_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_16_multileg_reporting_typ
        type: b1
  order_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_17_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_17_leg_maturity_date
        type: b1
      - id: order_rejected_return_bitfield_17_leg_strike_price
        type: b1
      - id: order_rejected_return_bitfield_17_room_id
        type: b1
      - id: order_rejected_return_bitfield_17_secondary_exec_id
        type: b1
      - id: order_rejected_return_bitfield_17_user_request_id
        type: b1
      - id: order_rejected_return_bitfield_17_sis_username
        type: b1
      - id: order_rejected_return_bitfield_17_user_status
        type: b1
  order_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_18_trade_reporting_indica
        type: b1
      - id: order_rejected_return_bitfield_18_equity_party_id
        type: b1
      - id: order_rejected_return_bitfield_18_equity_nbbo_protect
        type: b1
      - id: order_rejected_return_bitfield_18_mass_cancel_id
        type: b1
      - id: order_rejected_return_bitfield_18_trade_publish_ind
        type: b1
      - id: order_rejected_return_bitfield_18_report_time
        type: b1
      - id: order_rejected_return_bitfield_18_leg_symbol_sfx
        type: b1
      - id: order_rejected_return_bitfield_18_client_id_attr
        type: b1
  order_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_19_frequent_trader_id
        type: b1
      - id: order_rejected_return_bitfield_19_session_eligibility
        type: b1
      - id: order_rejected_return_bitfield_19_combo_order
        type: b1
      - id: order_rejected_return_bitfield_19_compression
        type: b1
      - id: order_rejected_return_bitfield_19_floor_destination
        type: b1
      - id: order_rejected_return_bitfield_19_floor_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_rejected_return_bitfield_19_order_origin
        type: b1
  order_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_20_price_type
        type: b1
      - id: order_rejected_return_bitfield_20_strategy_id
        type: b1
      - id: order_rejected_return_bitfield_20_trading_session_id
        type: b1
      - id: order_rejected_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: order_rejected_return_bitfield_20_sender_location_id
        type: b1
      - id: order_rejected_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_rejected_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_20_cust_order_handling_in
        type: b1
  order_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_21_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_21_cross_initiator
        type: b1
      - id: order_rejected_return_bitfield_21_subreason
        type: b1
      - id: order_rejected_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_rejected_return_bitfield_21_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_21_held
        type: b1
      - id: order_rejected_return_bitfield_21_locate_broker
        type: b1
      - id: order_rejected_return_bitfield_21_reserved_128
        type: b1
  order_rejected_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_rejected_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_rejected_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_rejected_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_rejected_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: order_rejected_return_bitfield_22_cmc_match_qty
        type: b1
      - id: order_rejected_return_bitfield_22_step_up_amount
        type: b1
      - id: order_rejected_return_bitfield_22_reserved_128
        type: b1
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_modified_return_bitfield_1
        type: order_modified_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderModified byte 1'
      - id: order_modified_return_bitfield_2
        type: order_modified_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderModified byte 2'
      - id: order_modified_return_bitfield_3
        type: order_modified_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderModified byte 3'
      - id: order_modified_return_bitfield_4
        type: order_modified_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderModified byte 4'
      - id: order_modified_return_bitfield_5
        type: order_modified_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderModified byte 5'
      - id: order_modified_return_bitfield_6
        type: order_modified_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderModified byte 6'
      - id: order_modified_return_bitfield_7
        type: order_modified_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderModified byte 7'
      - id: order_modified_return_bitfield_8
        type: order_modified_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderModified byte 8'
      - id: order_modified_return_bitfield_9
        type: order_modified_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderModified byte 9'
      - id: order_modified_return_bitfield_10
        type: order_modified_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderModified byte 10'
      - id: order_modified_return_bitfield_11
        type: order_modified_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderModified byte 11'
      - id: order_modified_return_bitfield_12
        type: order_modified_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderModified byte 12'
      - id: order_modified_return_bitfield_13
        type: order_modified_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderModified byte 13'
      - id: order_modified_return_bitfield_14
        type: order_modified_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderModified byte 14'
      - id: order_modified_return_bitfield_15
        type: order_modified_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderModified byte 15'
      - id: order_modified_return_bitfield_16
        type: order_modified_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderModified byte 16'
      - id: order_modified_return_bitfield_17
        type: order_modified_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderModified byte 17'
      - id: order_modified_return_bitfield_18
        type: order_modified_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderModified byte 18'
      - id: order_modified_return_bitfield_19
        type: order_modified_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderModified byte 19'
      - id: order_modified_return_bitfield_20
        type: order_modified_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderModified byte 20'
      - id: order_modified_return_bitfield_21
        type: order_modified_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderModified byte 21'
      - id: order_modified_return_bitfield_22
        type: order_modified_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderModified byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_symbol_sfx > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_prevent_match > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_ex_destination > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_ext_exec_inst > 0
      - id: cross_trade_flag
        type: u1
        enum: cross_trade_flag
        if: number_of_return_bitfields >= 21 and order_modified_return_bitfield_21.order_modified_return_bitfield_21_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_modified_return_bitfield_21.order_modified_return_bitfield_21_locate_broker > 0
  order_modified_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_1_order_modified_return_bitfields
        type: b1
      - id: order_modified_return_bitfield_1_reserved_2
        type: b1
      - id: order_modified_return_bitfield_1_reserved_4
        type: b1
      - id: order_modified_return_bitfield_1_reserved_8
        type: b1
      - id: order_modified_return_bitfield_1_reserved_16
        type: b1
      - id: order_modified_return_bitfield_1_reserved_32
        type: b1
      - id: order_modified_return_bitfield_1_reserved_64
        type: b1
      - id: order_modified_return_bitfield_1_reserved_128
        type: b1
  order_modified_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_2_side
        type: b1
      - id: order_modified_return_bitfield_2_peg_difference
        type: b1
      - id: order_modified_return_bitfield_2_price
        type: b1
      - id: order_modified_return_bitfield_2_exec_inst
        type: b1
      - id: order_modified_return_bitfield_2_ord_type
        type: b1
      - id: order_modified_return_bitfield_2_time_in_force
        type: b1
      - id: order_modified_return_bitfield_2_min_qty
        type: b1
      - id: order_modified_return_bitfield_2_reserved_128
        type: b1
  order_modified_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_3_symbol
        type: b1
      - id: order_modified_return_bitfield_3_symbol_sfx
        type: b1
      - id: order_modified_return_bitfield_3_currency
        type: b1
      - id: order_modified_return_bitfield_3_id_source
        type: b1
      - id: order_modified_return_bitfield_3_security_id
        type: b1
      - id: order_modified_return_bitfield_3_security_exchange
        type: b1
      - id: order_modified_return_bitfield_3_capacity
        type: b1
      - id: order_modified_return_bitfield_3_contra_trader
        type: b1
  order_modified_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_4_account
        type: b1
      - id: order_modified_return_bitfield_4_clearing_firm
        type: b1
      - id: order_modified_return_bitfield_4_clearing_account
        type: b1
      - id: order_modified_return_bitfield_4_display_indicator
        type: b1
      - id: order_modified_return_bitfield_4_max_floor
        type: b1
      - id: order_modified_return_bitfield_4_discretion_amount
        type: b1
      - id: order_modified_return_bitfield_4_order_qty
        type: b1
      - id: order_modified_return_bitfield_4_prevent_match
        type: b1
  order_modified_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_5_maturity_date
        type: b1
      - id: order_modified_return_bitfield_5_strike_price
        type: b1
      - id: order_modified_return_bitfield_5_put_or_call
        type: b1
      - id: order_modified_return_bitfield_5_open_close
        type: b1
      - id: order_modified_return_bitfield_5_cl_ord_id_batch
        type: b1
      - id: order_modified_return_bitfield_5_corrected_size
        type: b1
      - id: order_modified_return_bitfield_5_reserved_64
        type: b1
      - id: order_modified_return_bitfield_5_reserved_128
        type: b1
  order_modified_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_6_sub_liquidity_indicator
        type: b1
      - id: order_modified_return_bitfield_6_trade_report_type_return
        type: b1
      - id: order_modified_return_bitfield_6_trade_publish_ind_return
        type: b1
      - id: order_modified_return_bitfield_6_text
        type: b1
      - id: order_modified_return_bitfield_6_bid
        type: b1
      - id: order_modified_return_bitfield_6_offer
        type: b1
      - id: order_modified_return_bitfield_6_large_size
        type: b1
      - id: order_modified_return_bitfield_6_last_mkt
        type: b1
  order_modified_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_7_fee_code
        type: b1
      - id: order_modified_return_bitfield_7_echo_text
        type: b1
      - id: order_modified_return_bitfield_7_stop_px
        type: b1
      - id: order_modified_return_bitfield_7_routing_inst
        type: b1
      - id: order_modified_return_bitfield_7_rout_strategy
        type: b1
      - id: order_modified_return_bitfield_7_route_delivery_method
        type: b1
      - id: order_modified_return_bitfield_7_ex_destination
        type: b1
      - id: order_modified_return_bitfield_7_trade_report_ref_id
        type: b1
  order_modified_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_8_marketing_fee_code
        type: b1
      - id: order_modified_return_bitfield_8_target_party_id
        type: b1
      - id: order_modified_return_bitfield_8_auction_id
        type: b1
      - id: order_modified_return_bitfield_8_order_category
        type: b1
      - id: order_modified_return_bitfield_8_liquidity_provision
        type: b1
      - id: order_modified_return_bitfield_8_cmta_number
        type: b1
      - id: order_modified_return_bitfield_8_cross_type
        type: b1
      - id: order_modified_return_bitfield_8_cross_prioritization
        type: b1
  order_modified_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_9_cross_id
        type: b1
      - id: order_modified_return_bitfield_9_alloc_qty
        type: b1
      - id: order_modified_return_bitfield_9_give_up_firm_id
        type: b1
      - id: order_modified_return_bitfield_9_routing_firm_id
        type: b1
      - id: order_modified_return_bitfield_9_waiver_type
        type: b1
      - id: order_modified_return_bitfield_9_cross_exclusion_indicator
        type: b1
      - id: order_modified_return_bitfield_9_reserved_64
        type: b1
      - id: order_modified_return_bitfield_9_reserved_128
        type: b1
  order_modified_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_10_cum_qty
        type: b1
      - id: order_modified_return_bitfield_10_day_order_qty
        type: b1
      - id: order_modified_return_bitfield_10_day_cum_qty
        type: b1
      - id: order_modified_return_bitfield_10_avg_px
        type: b1
      - id: order_modified_return_bitfield_10_day_avg_px
        type: b1
      - id: order_modified_return_bitfield_10_pending_status
        type: b1
      - id: order_modified_return_bitfield_10_drill_thru_protection
        type: b1
      - id: order_modified_return_bitfield_10_multileg_reporting_typ
        type: b1
  order_modified_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_11_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_11_leg_maturity_date
        type: b1
      - id: order_modified_return_bitfield_11_leg_strike_price
        type: b1
      - id: order_modified_return_bitfield_11_room_id
        type: b1
      - id: order_modified_return_bitfield_11_secondary_exec_id
        type: b1
      - id: order_modified_return_bitfield_11_user_request_id
        type: b1
      - id: order_modified_return_bitfield_11_sis_username
        type: b1
      - id: order_modified_return_bitfield_11_user_status
        type: b1
  order_modified_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_12_trade_reporting_indica
        type: b1
      - id: order_modified_return_bitfield_12_equity_party_id
        type: b1
      - id: order_modified_return_bitfield_12_equity_nbbo_protect
        type: b1
      - id: order_modified_return_bitfield_12_mass_cancel_id
        type: b1
      - id: order_modified_return_bitfield_12_trade_publish_ind
        type: b1
      - id: order_modified_return_bitfield_12_report_time
        type: b1
      - id: order_modified_return_bitfield_12_leg_symbol_sfx
        type: b1
      - id: order_modified_return_bitfield_12_client_id_attr
        type: b1
  order_modified_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_13_frequent_trader_id
        type: b1
      - id: order_modified_return_bitfield_13_session_eligibility
        type: b1
      - id: order_modified_return_bitfield_13_combo_order
        type: b1
      - id: order_modified_return_bitfield_13_compression
        type: b1
      - id: order_modified_return_bitfield_13_floor_destination
        type: b1
      - id: order_modified_return_bitfield_13_floor_routing_inst
        type: b1
      - id: order_modified_return_bitfield_13_party_id
        type: b1
      - id: order_modified_return_bitfield_13_access_fee
        type: b1
  order_modified_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_14_orig_cl_ord_id
        type: b1
      - id: order_modified_return_bitfield_14_leaves_qty
        type: b1
      - id: order_modified_return_bitfield_14_last_shares
        type: b1
      - id: order_modified_return_bitfield_14_last_px
        type: b1
      - id: order_modified_return_bitfield_14_display_price
        type: b1
      - id: order_modified_return_bitfield_14_working_price
        type: b1
      - id: order_modified_return_bitfield_14_base_liquidity_indicator
        type: b1
      - id: order_modified_return_bitfield_14_expire_time
        type: b1
  order_modified_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_15_secondary_order_id
        type: b1
      - id: order_modified_return_bitfield_15_ccp
        type: b1
      - id: order_modified_return_bitfield_15_contra_capacity
        type: b1
      - id: order_modified_return_bitfield_15_attributed_quote
        type: b1
      - id: order_modified_return_bitfield_15_ext_exec_inst
        type: b1
      - id: order_modified_return_bitfield_15_bulk_order_ids
        type: b1
      - id: order_modified_return_bitfield_15_bulk_reject_reasons
        type: b1
      - id: order_modified_return_bitfield_15_party_role
        type: b1
  order_modified_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_16_reserved_1
        type: b1
      - id: order_modified_return_bitfield_16_reserved_2
        type: b1
      - id: order_modified_return_bitfield_16_reserved_4
        type: b1
      - id: order_modified_return_bitfield_16_reserved_8
        type: b1
      - id: order_modified_return_bitfield_16_reserved_16
        type: b1
      - id: order_modified_return_bitfield_16_reserved_32
        type: b1
      - id: order_modified_return_bitfield_16_price_formation
        type: b1
      - id: order_modified_return_bitfield_16_client_qualified_role
        type: b1
  order_modified_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_17_client_id
        type: b1
      - id: order_modified_return_bitfield_17_investor_id
        type: b1
      - id: order_modified_return_bitfield_17_executor_id
        type: b1
      - id: order_modified_return_bitfield_17_order_origination
        type: b1
      - id: order_modified_return_bitfield_17_algo
        type: b1
      - id: order_modified_return_bitfield_17_deferral_reason
        type: b1
      - id: order_modified_return_bitfield_17_investor_qualified_role
        type: b1
      - id: order_modified_return_bitfield_17_executor_qualified_role
        type: b1
  order_modified_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_18_cti_code
        type: b1
      - id: order_modified_return_bitfield_18_manual_order_indicator
        type: b1
      - id: order_modified_return_bitfield_18_operator_id
        type: b1
      - id: order_modified_return_bitfield_18_trade_date
        type: b1
      - id: order_modified_return_bitfield_18_clearing_price
        type: b1
      - id: order_modified_return_bitfield_18_clearing_size
        type: b1
      - id: order_modified_return_bitfield_18_clearing_symbol
        type: b1
      - id: order_modified_return_bitfield_18_clearing_optional_data
        type: b1
  order_modified_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_19_reserved_1
        type: b1
      - id: order_modified_return_bitfield_19_reserved_2
        type: b1
      - id: order_modified_return_bitfield_19_reserved_4
        type: b1
      - id: order_modified_return_bitfield_19_reserved_8
        type: b1
      - id: order_modified_return_bitfield_19_reserved_16
        type: b1
      - id: order_modified_return_bitfield_19_reserved_32
        type: b1
      - id: order_modified_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_modified_return_bitfield_19_order_origin
        type: b1
  order_modified_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_20_price_type
        type: b1
      - id: order_modified_return_bitfield_20_strategy_id
        type: b1
      - id: order_modified_return_bitfield_20_trading_session_id
        type: b1
      - id: order_modified_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: order_modified_return_bitfield_20_sender_location_id
        type: b1
      - id: order_modified_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_modified_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_20_cust_order_handling_in
        type: b1
  order_modified_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_21_reserved_1
        type: b1
      - id: order_modified_return_bitfield_21_cross_initiator
        type: b1
      - id: order_modified_return_bitfield_21_subreason
        type: b1
      - id: order_modified_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_modified_return_bitfield_21_reserved_16
        type: b1
      - id: order_modified_return_bitfield_21_held
        type: b1
      - id: order_modified_return_bitfield_21_locate_broker
        type: b1
      - id: order_modified_return_bitfield_21_reserved_128
        type: b1
  order_modified_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_modified_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_modified_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_modified_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_modified_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: order_modified_return_bitfield_22_cmc_match_qty
        type: b1
      - id: order_modified_return_bitfield_22_step_up_amount
        type: b1
      - id: order_modified_return_bitfield_22_reserved_128
        type: b1
  order_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. C=Cboe Market Close (CMC) L=Reload P=Peg or Price Sliding Reprice Q=Liquidity Updated R=Reroute S=Reduction of OrderQty due to SWP W=Wash or MTP Decrement Cboe reserves the right to add new values as necessary without prior notice'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_restated_return_bitfield_1
        type: order_restated_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderRestated byte 1'
      - id: order_restated_return_bitfield_2
        type: order_restated_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderRestated byte 2'
      - id: order_restated_return_bitfield_3
        type: order_restated_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderRestated byte 3'
      - id: order_restated_return_bitfield_4
        type: order_restated_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderRestated byte 4'
      - id: order_restated_return_bitfield_5
        type: order_restated_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderRestated byte 5'
      - id: order_restated_return_bitfield_6
        type: order_restated_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderRestated byte 6'
      - id: order_restated_return_bitfield_7
        type: order_restated_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderRestated byte 7'
      - id: order_restated_return_bitfield_8
        type: order_restated_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderRestated byte 8'
      - id: order_restated_return_bitfield_9
        type: order_restated_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderRestated byte 9'
      - id: order_restated_return_bitfield_10
        type: order_restated_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderRestated byte 10'
      - id: order_restated_return_bitfield_11
        type: order_restated_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderRestated byte 11'
      - id: order_restated_return_bitfield_12
        type: order_restated_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderRestated byte 12'
      - id: order_restated_return_bitfield_13
        type: order_restated_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderRestated byte 13'
      - id: order_restated_return_bitfield_14
        type: order_restated_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderRestated byte 14'
      - id: order_restated_return_bitfield_15
        type: order_restated_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderRestated byte 15'
      - id: order_restated_return_bitfield_16
        type: order_restated_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderRestated byte 16'
      - id: order_restated_return_bitfield_17
        type: order_restated_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderRestated byte 17'
      - id: order_restated_return_bitfield_18
        type: order_restated_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderRestated byte 18'
      - id: order_restated_return_bitfield_19
        type: order_restated_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderRestated byte 19'
      - id: order_restated_return_bitfield_20
        type: order_restated_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderRestated byte 20'
      - id: order_restated_return_bitfield_21
        type: order_restated_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderRestated byte 21'
      - id: order_restated_return_bitfield_22
        type: order_restated_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderRestated byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_return_bitfield_3.order_restated_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_return_bitfield_3.order_restated_return_bitfield_3_symbol_sfx > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_restated_return_bitfield_5.order_restated_return_bitfield_5_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_return_bitfield_5.order_restated_return_bitfield_5_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_ext_exec_inst > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_ex_destination > 0
  order_restated_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_1_order_restated_return_bitfields
        type: b1
      - id: order_restated_return_bitfield_1_reserved_2
        type: b1
      - id: order_restated_return_bitfield_1_reserved_4
        type: b1
      - id: order_restated_return_bitfield_1_reserved_8
        type: b1
      - id: order_restated_return_bitfield_1_reserved_16
        type: b1
      - id: order_restated_return_bitfield_1_reserved_32
        type: b1
      - id: order_restated_return_bitfield_1_reserved_64
        type: b1
      - id: order_restated_return_bitfield_1_reserved_128
        type: b1
  order_restated_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_2_side
        type: b1
      - id: order_restated_return_bitfield_2_peg_difference
        type: b1
      - id: order_restated_return_bitfield_2_price
        type: b1
      - id: order_restated_return_bitfield_2_exec_inst
        type: b1
      - id: order_restated_return_bitfield_2_ord_type
        type: b1
      - id: order_restated_return_bitfield_2_time_in_force
        type: b1
      - id: order_restated_return_bitfield_2_min_qty
        type: b1
      - id: order_restated_return_bitfield_2_reserved_128
        type: b1
  order_restated_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_3_symbol
        type: b1
      - id: order_restated_return_bitfield_3_symbol_sfx
        type: b1
      - id: order_restated_return_bitfield_3_currency
        type: b1
      - id: order_restated_return_bitfield_3_reserved_8
        type: b1
      - id: order_restated_return_bitfield_3_reserved_16
        type: b1
      - id: order_restated_return_bitfield_3_reserved_32
        type: b1
      - id: order_restated_return_bitfield_3_reserved_64
        type: b1
      - id: order_restated_return_bitfield_3_reserved_128
        type: b1
  order_restated_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_4_sub_liquidity_indicator
        type: b1
      - id: order_restated_return_bitfield_4_trade_report_type_return
        type: b1
      - id: order_restated_return_bitfield_4_trade_publish_ind_return
        type: b1
      - id: order_restated_return_bitfield_4_text
        type: b1
      - id: order_restated_return_bitfield_4_bid
        type: b1
      - id: order_restated_return_bitfield_4_offer
        type: b1
      - id: order_restated_return_bitfield_4_large_size
        type: b1
      - id: order_restated_return_bitfield_4_last_mkt
        type: b1
  order_restated_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_5_fee_code
        type: b1
      - id: order_restated_return_bitfield_5_echo_text
        type: b1
      - id: order_restated_return_bitfield_5_stop_px
        type: b1
      - id: order_restated_return_bitfield_5_reserved_8
        type: b1
      - id: order_restated_return_bitfield_5_reserved_16
        type: b1
      - id: order_restated_return_bitfield_5_reserved_32
        type: b1
      - id: order_restated_return_bitfield_5_reserved_64
        type: b1
      - id: order_restated_return_bitfield_5_reserved_128
        type: b1
  order_restated_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_6_cum_qty
        type: b1
      - id: order_restated_return_bitfield_6_day_order_qty
        type: b1
      - id: order_restated_return_bitfield_6_day_cum_qty
        type: b1
      - id: order_restated_return_bitfield_6_avg_px
        type: b1
      - id: order_restated_return_bitfield_6_day_avg_px
        type: b1
      - id: order_restated_return_bitfield_6_pending_status
        type: b1
      - id: order_restated_return_bitfield_6_drill_thru_protection
        type: b1
      - id: order_restated_return_bitfield_6_multileg_reporting_typ
        type: b1
  order_restated_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_7_leg_cfi_code
        type: b1
      - id: order_restated_return_bitfield_7_leg_maturity_date
        type: b1
      - id: order_restated_return_bitfield_7_leg_strike_price
        type: b1
      - id: order_restated_return_bitfield_7_id_source
        type: b1
      - id: order_restated_return_bitfield_7_security_id
        type: b1
      - id: order_restated_return_bitfield_7_security_exchange
        type: b1
      - id: order_restated_return_bitfield_7_capacity
        type: b1
      - id: order_restated_return_bitfield_7_contra_trader
        type: b1
  order_restated_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_8_account
        type: b1
      - id: order_restated_return_bitfield_8_clearing_firm
        type: b1
      - id: order_restated_return_bitfield_8_clearing_account
        type: b1
      - id: order_restated_return_bitfield_8_display_indicator
        type: b1
      - id: order_restated_return_bitfield_8_max_floor
        type: b1
      - id: order_restated_return_bitfield_8_discretion_amount
        type: b1
      - id: order_restated_return_bitfield_8_order_qty
        type: b1
      - id: order_restated_return_bitfield_8_prevent_match
        type: b1
  order_restated_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_9_maturity_date
        type: b1
      - id: order_restated_return_bitfield_9_strike_price
        type: b1
      - id: order_restated_return_bitfield_9_put_or_call
        type: b1
      - id: order_restated_return_bitfield_9_open_close
        type: b1
      - id: order_restated_return_bitfield_9_cl_ord_id_batch
        type: b1
      - id: order_restated_return_bitfield_9_corrected_size
        type: b1
      - id: order_restated_return_bitfield_9_party_id
        type: b1
      - id: order_restated_return_bitfield_9_access_fee
        type: b1
  order_restated_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_10_orig_cl_ord_id
        type: b1
      - id: order_restated_return_bitfield_10_leaves_qty
        type: b1
      - id: order_restated_return_bitfield_10_last_shares
        type: b1
      - id: order_restated_return_bitfield_10_last_px
        type: b1
      - id: order_restated_return_bitfield_10_display_price
        type: b1
      - id: order_restated_return_bitfield_10_working_price
        type: b1
      - id: order_restated_return_bitfield_10_base_liquidity_indicator
        type: b1
      - id: order_restated_return_bitfield_10_expire_time
        type: b1
  order_restated_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_11_secondary_order_id
        type: b1
      - id: order_restated_return_bitfield_11_ccp
        type: b1
      - id: order_restated_return_bitfield_11_contra_capacity
        type: b1
      - id: order_restated_return_bitfield_11_attributed_quote
        type: b1
      - id: order_restated_return_bitfield_11_ext_exec_inst
        type: b1
      - id: order_restated_return_bitfield_11_bulk_order_ids
        type: b1
      - id: order_restated_return_bitfield_11_bulk_reject_reasons
        type: b1
      - id: order_restated_return_bitfield_11_party_role
        type: b1
  order_restated_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_12_reserved_1
        type: b1
      - id: order_restated_return_bitfield_12_reserved_2
        type: b1
      - id: order_restated_return_bitfield_12_reserved_4
        type: b1
      - id: order_restated_return_bitfield_12_routing_inst
        type: b1
      - id: order_restated_return_bitfield_12_rout_strategy
        type: b1
      - id: order_restated_return_bitfield_12_route_delivery_method
        type: b1
      - id: order_restated_return_bitfield_12_ex_destination
        type: b1
      - id: order_restated_return_bitfield_12_trade_report_ref_id
        type: b1
  order_restated_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_13_marketing_fee_code
        type: b1
      - id: order_restated_return_bitfield_13_target_party_id
        type: b1
      - id: order_restated_return_bitfield_13_auction_id
        type: b1
      - id: order_restated_return_bitfield_13_order_category
        type: b1
      - id: order_restated_return_bitfield_13_liquidity_provision
        type: b1
      - id: order_restated_return_bitfield_13_cmta_number
        type: b1
      - id: order_restated_return_bitfield_13_cross_type
        type: b1
      - id: order_restated_return_bitfield_13_cross_prioritization
        type: b1
  order_restated_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_14_cross_id
        type: b1
      - id: order_restated_return_bitfield_14_alloc_qty
        type: b1
      - id: order_restated_return_bitfield_14_give_up_firm_id
        type: b1
      - id: order_restated_return_bitfield_14_routing_firm_id
        type: b1
      - id: order_restated_return_bitfield_14_waiver_type
        type: b1
      - id: order_restated_return_bitfield_14_cross_exclusion_indicator
        type: b1
      - id: order_restated_return_bitfield_14_price_formation
        type: b1
      - id: order_restated_return_bitfield_14_client_qualified_role
        type: b1
  order_restated_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_15_client_id
        type: b1
      - id: order_restated_return_bitfield_15_investor_id
        type: b1
      - id: order_restated_return_bitfield_15_executor_id
        type: b1
      - id: order_restated_return_bitfield_15_order_origination
        type: b1
      - id: order_restated_return_bitfield_15_algo
        type: b1
      - id: order_restated_return_bitfield_15_deferral_reason
        type: b1
      - id: order_restated_return_bitfield_15_investor_qualified_role
        type: b1
      - id: order_restated_return_bitfield_15_executor_qualified_role
        type: b1
  order_restated_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_16_cti_code
        type: b1
      - id: order_restated_return_bitfield_16_manual_order_indicator
        type: b1
      - id: order_restated_return_bitfield_16_operator_id
        type: b1
      - id: order_restated_return_bitfield_16_trade_date
        type: b1
      - id: order_restated_return_bitfield_16_clearing_price
        type: b1
      - id: order_restated_return_bitfield_16_clearing_size
        type: b1
      - id: order_restated_return_bitfield_16_clearing_symbol
        type: b1
      - id: order_restated_return_bitfield_16_clearing_optional_data
        type: b1
  order_restated_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_17_reserved_1
        type: b1
      - id: order_restated_return_bitfield_17_reserved_2
        type: b1
      - id: order_restated_return_bitfield_17_reserved_4
        type: b1
      - id: order_restated_return_bitfield_17_room_id
        type: b1
      - id: order_restated_return_bitfield_17_secondary_exec_id
        type: b1
      - id: order_restated_return_bitfield_17_user_request_id
        type: b1
      - id: order_restated_return_bitfield_17_sis_username
        type: b1
      - id: order_restated_return_bitfield_17_user_status
        type: b1
  order_restated_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_18_trade_reporting_indica
        type: b1
      - id: order_restated_return_bitfield_18_equity_party_id
        type: b1
      - id: order_restated_return_bitfield_18_equity_nbbo_protect
        type: b1
      - id: order_restated_return_bitfield_18_mass_cancel_id
        type: b1
      - id: order_restated_return_bitfield_18_trade_publish_ind
        type: b1
      - id: order_restated_return_bitfield_18_report_time
        type: b1
      - id: order_restated_return_bitfield_18_leg_symbol_sfx
        type: b1
      - id: order_restated_return_bitfield_18_client_id_attr
        type: b1
  order_restated_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_19_frequent_trader_id
        type: b1
      - id: order_restated_return_bitfield_19_session_eligibility
        type: b1
      - id: order_restated_return_bitfield_19_combo_order
        type: b1
      - id: order_restated_return_bitfield_19_compression
        type: b1
      - id: order_restated_return_bitfield_19_floor_destination
        type: b1
      - id: order_restated_return_bitfield_19_floor_routing_inst
        type: b1
      - id: order_restated_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_restated_return_bitfield_19_order_origin
        type: b1
  order_restated_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_20_price_type
        type: b1
      - id: order_restated_return_bitfield_20_strategy_id
        type: b1
      - id: order_restated_return_bitfield_20_trading_session_id
        type: b1
      - id: order_restated_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: order_restated_return_bitfield_20_sender_location_id
        type: b1
      - id: order_restated_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_restated_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_restated_return_bitfield_20_cust_order_handling_in
        type: b1
  order_restated_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_21_reserved_1
        type: b1
      - id: order_restated_return_bitfield_21_cross_initiator
        type: b1
      - id: order_restated_return_bitfield_21_subreason
        type: b1
      - id: order_restated_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_restated_return_bitfield_21_reserved_16
        type: b1
      - id: order_restated_return_bitfield_21_held
        type: b1
      - id: order_restated_return_bitfield_21_locate_broker
        type: b1
      - id: order_restated_return_bitfield_21_reserved_128
        type: b1
  order_restated_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_restated_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_restated_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_restated_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_restated_return_bitfield_22_intra_firm_trade_ind
        type: b1
  user_modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection. See Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: user_modify_rejected_return_bitfield_1
        type: user_modify_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet UserModifyRejected byte 1'
      - id: user_modify_rejected_return_bitfield_2
        type: user_modify_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet UserModifyRejected byte 2'
      - id: user_modify_rejected_return_bitfield_3
        type: user_modify_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet UserModifyRejected byte 3'
      - id: user_modify_rejected_return_bitfield_4
        type: user_modify_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet UserModifyRejected byte 4'
      - id: user_modify_rejected_return_bitfield_5
        type: user_modify_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet UserModifyRejected byte 5'
      - id: user_modify_rejected_return_bitfield_6
        type: user_modify_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet UserModifyRejected byte 6'
      - id: user_modify_rejected_return_bitfield_7
        type: user_modify_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet UserModifyRejected byte 7'
      - id: user_modify_rejected_return_bitfield_8
        type: user_modify_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet UserModifyRejected byte 8'
      - id: user_modify_rejected_return_bitfield_9
        type: user_modify_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet UserModifyRejected byte 9'
      - id: user_modify_rejected_return_bitfield_10
        type: user_modify_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet UserModifyRejected byte 10'
      - id: user_modify_rejected_return_bitfield_11
        type: user_modify_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet UserModifyRejected byte 11'
      - id: user_modify_rejected_return_bitfield_12
        type: user_modify_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet UserModifyRejected byte 12'
      - id: user_modify_rejected_return_bitfield_13
        type: user_modify_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet UserModifyRejected byte 13'
      - id: user_modify_rejected_return_bitfield_14
        type: user_modify_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet UserModifyRejected byte 14'
      - id: user_modify_rejected_return_bitfield_15
        type: user_modify_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet UserModifyRejected byte 15'
      - id: user_modify_rejected_return_bitfield_16
        type: user_modify_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet UserModifyRejected byte 16'
      - id: user_modify_rejected_return_bitfield_17
        type: user_modify_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet UserModifyRejected byte 17'
      - id: user_modify_rejected_return_bitfield_18
        type: user_modify_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet UserModifyRejected byte 18'
      - id: user_modify_rejected_return_bitfield_19
        type: user_modify_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet UserModifyRejected byte 19'
      - id: user_modify_rejected_return_bitfield_20
        type: user_modify_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet UserModifyRejected byte 20'
      - id: user_modify_rejected_return_bitfield_21
        type: user_modify_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet UserModifyRejected byte 21'
      - id: user_modify_rejected_return_bitfield_22
        type: user_modify_rejected_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet UserModifyRejected byte 22'
  user_modify_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_1_user_modify_rejected_return_bitfields
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_2
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_4
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_2_side
        type: b1
      - id: user_modify_rejected_return_bitfield_2_peg_difference
        type: b1
      - id: user_modify_rejected_return_bitfield_2_price
        type: b1
      - id: user_modify_rejected_return_bitfield_2_exec_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_2_ord_type
        type: b1
      - id: user_modify_rejected_return_bitfield_2_time_in_force
        type: b1
      - id: user_modify_rejected_return_bitfield_2_min_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_2_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_3_symbol
        type: b1
      - id: user_modify_rejected_return_bitfield_3_symbol_sfx
        type: b1
      - id: user_modify_rejected_return_bitfield_3_currency
        type: b1
      - id: user_modify_rejected_return_bitfield_3_id_source
        type: b1
      - id: user_modify_rejected_return_bitfield_3_security_id
        type: b1
      - id: user_modify_rejected_return_bitfield_3_security_exchange
        type: b1
      - id: user_modify_rejected_return_bitfield_3_capacity
        type: b1
      - id: user_modify_rejected_return_bitfield_3_contra_trader
        type: b1
  user_modify_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_4_account
        type: b1
      - id: user_modify_rejected_return_bitfield_4_clearing_firm
        type: b1
      - id: user_modify_rejected_return_bitfield_4_clearing_account
        type: b1
      - id: user_modify_rejected_return_bitfield_4_display_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_4_max_floor
        type: b1
      - id: user_modify_rejected_return_bitfield_4_discretion_amount
        type: b1
      - id: user_modify_rejected_return_bitfield_4_order_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_4_prevent_match
        type: b1
  user_modify_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_5_maturity_date
        type: b1
      - id: user_modify_rejected_return_bitfield_5_strike_price
        type: b1
      - id: user_modify_rejected_return_bitfield_5_put_or_call
        type: b1
      - id: user_modify_rejected_return_bitfield_5_open_close
        type: b1
      - id: user_modify_rejected_return_bitfield_5_cl_ord_id_batch
        type: b1
      - id: user_modify_rejected_return_bitfield_5_corrected_size
        type: b1
      - id: user_modify_rejected_return_bitfield_5_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_5_access_fee
        type: b1
  user_modify_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_6_orig_cl_ord_id
        type: b1
      - id: user_modify_rejected_return_bitfield_6_leaves_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_4
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_6_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: user_modify_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: user_modify_rejected_return_bitfield_7_text
        type: b1
      - id: user_modify_rejected_return_bitfield_7_bid
        type: b1
      - id: user_modify_rejected_return_bitfield_7_offer
        type: b1
      - id: user_modify_rejected_return_bitfield_7_large_size
        type: b1
      - id: user_modify_rejected_return_bitfield_7_last_mkt
        type: b1
  user_modify_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_8_fee_code
        type: b1
      - id: user_modify_rejected_return_bitfield_8_echo_text
        type: b1
      - id: user_modify_rejected_return_bitfield_8_stop_px
        type: b1
      - id: user_modify_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: user_modify_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: user_modify_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  user_modify_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: user_modify_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_9_auction_id
        type: b1
      - id: user_modify_rejected_return_bitfield_9_order_category
        type: b1
      - id: user_modify_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: user_modify_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: user_modify_rejected_return_bitfield_9_cross_type
        type: b1
      - id: user_modify_rejected_return_bitfield_9_cross_prioritization
        type: b1
  user_modify_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_10_cross_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_routing_firm_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: user_modify_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_10_price_formation
        type: b1
      - id: user_modify_rejected_return_bitfield_10_client_qualified_role
        type: b1
  user_modify_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_11_client_id
        type: b1
      - id: user_modify_rejected_return_bitfield_11_investor_id
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_4
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_11_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_12_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_12_day_order_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_12_day_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_12_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_12_day_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_12_pending_status
        type: b1
      - id: user_modify_rejected_return_bitfield_12_drill_thru_protection
        type: b1
      - id: user_modify_rejected_return_bitfield_12_multileg_reporting_typ
        type: b1
  user_modify_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_13_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_13_leg_maturity_date
        type: b1
      - id: user_modify_rejected_return_bitfield_13_leg_strike_price
        type: b1
      - id: user_modify_rejected_return_bitfield_13_room_id
        type: b1
      - id: user_modify_rejected_return_bitfield_13_secondary_exec_id
        type: b1
      - id: user_modify_rejected_return_bitfield_13_user_request_id
        type: b1
      - id: user_modify_rejected_return_bitfield_13_sis_username
        type: b1
      - id: user_modify_rejected_return_bitfield_13_user_status
        type: b1
  user_modify_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_14_trade_reporting_indica
        type: b1
      - id: user_modify_rejected_return_bitfield_14_equity_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_equity_nbbo_protect
        type: b1
      - id: user_modify_rejected_return_bitfield_14_mass_cancel_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_trade_publish_ind
        type: b1
      - id: user_modify_rejected_return_bitfield_14_report_time
        type: b1
      - id: user_modify_rejected_return_bitfield_14_leg_symbol_sfx
        type: b1
      - id: user_modify_rejected_return_bitfield_14_client_id_attr
        type: b1
  user_modify_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_15_frequent_trader_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_session_eligibility
        type: b1
      - id: user_modify_rejected_return_bitfield_15_combo_order
        type: b1
      - id: user_modify_rejected_return_bitfield_15_compression
        type: b1
      - id: user_modify_rejected_return_bitfield_15_floor_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_15_floor_routing_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_15_multi_class_sprd
        type: b1
      - id: user_modify_rejected_return_bitfield_15_order_origin
        type: b1
  user_modify_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_16_price_type
        type: b1
      - id: user_modify_rejected_return_bitfield_16_strategy_id
        type: b1
      - id: user_modify_rejected_return_bitfield_16_last_shares
        type: b1
      - id: user_modify_rejected_return_bitfield_16_last_px
        type: b1
      - id: user_modify_rejected_return_bitfield_16_display_price
        type: b1
      - id: user_modify_rejected_return_bitfield_16_working_price
        type: b1
      - id: user_modify_rejected_return_bitfield_16_base_liquidity_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_16_expire_time
        type: b1
  user_modify_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_17_secondary_order_id
        type: b1
      - id: user_modify_rejected_return_bitfield_17_ccp
        type: b1
      - id: user_modify_rejected_return_bitfield_17_contra_capacity
        type: b1
      - id: user_modify_rejected_return_bitfield_17_attributed_quote
        type: b1
      - id: user_modify_rejected_return_bitfield_17_ext_exec_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_17_bulk_order_ids
        type: b1
      - id: user_modify_rejected_return_bitfield_17_bulk_reject_reasons
        type: b1
      - id: user_modify_rejected_return_bitfield_17_party_role
        type: b1
  user_modify_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_2
        type: b1
      - id: user_modify_rejected_return_bitfield_18_executor_id
        type: b1
      - id: user_modify_rejected_return_bitfield_18_order_origination
        type: b1
      - id: user_modify_rejected_return_bitfield_18_algo
        type: b1
      - id: user_modify_rejected_return_bitfield_18_deferral_reason
        type: b1
      - id: user_modify_rejected_return_bitfield_18_investor_qualified_role
        type: b1
      - id: user_modify_rejected_return_bitfield_18_executor_qualified_role
        type: b1
  user_modify_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_19_cti_code
        type: b1
      - id: user_modify_rejected_return_bitfield_19_manual_order_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_19_operator_id
        type: b1
      - id: user_modify_rejected_return_bitfield_19_trade_date
        type: b1
      - id: user_modify_rejected_return_bitfield_19_clearing_price
        type: b1
      - id: user_modify_rejected_return_bitfield_19_clearing_size
        type: b1
      - id: user_modify_rejected_return_bitfield_19_clearing_symbol
        type: b1
      - id: user_modify_rejected_return_bitfield_19_clearing_optional_data
        type: b1
  user_modify_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_20_reserved_2
        type: b1
      - id: user_modify_rejected_return_bitfield_20_trading_session_id
        type: b1
      - id: user_modify_rejected_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: user_modify_rejected_return_bitfield_20_sender_location_id
        type: b1
      - id: user_modify_rejected_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: user_modify_rejected_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_20_cust_order_handling_in
        type: b1
  user_modify_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_21_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_21_cross_initiator
        type: b1
      - id: user_modify_rejected_return_bitfield_21_subreason
        type: b1
      - id: user_modify_rejected_return_bitfield_21_cross_trade_flag
        type: b1
      - id: user_modify_rejected_return_bitfield_21_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_21_held
        type: b1
      - id: user_modify_rejected_return_bitfield_21_locate_broker
        type: b1
      - id: user_modify_rejected_return_bitfield_21_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_22_floor_trade_time
        type: b1
      - id: user_modify_rejected_return_bitfield_22_equity_ex_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: user_modify_rejected_return_bitfield_22_cmc_sessions
        type: b1
      - id: user_modify_rejected_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: user_modify_rejected_return_bitfield_22_cmc_match_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_22_step_up_amount
        type: b1
      - id: user_modify_rejected_return_bitfield_22_reserved_128
        type: b1
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Reason Codes for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_cancelled_return_bitfield_1
        type: order_cancelled_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderCancelled byte 1'
      - id: order_cancelled_return_bitfield_2
        type: order_cancelled_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderCancelled byte 2'
      - id: order_cancelled_return_bitfield_3
        type: order_cancelled_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderCancelled byte 3'
      - id: order_cancelled_return_bitfield_4
        type: order_cancelled_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderCancelled byte 4'
      - id: order_cancelled_return_bitfield_5
        type: order_cancelled_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderCancelled byte 5'
      - id: order_cancelled_return_bitfield_6
        type: order_cancelled_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderCancelled byte 6'
      - id: order_cancelled_return_bitfield_7
        type: order_cancelled_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderCancelled byte 7'
      - id: order_cancelled_return_bitfield_8
        type: order_cancelled_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderCancelled byte 8'
      - id: order_cancelled_return_bitfield_9
        type: order_cancelled_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderCancelled byte 9'
      - id: order_cancelled_return_bitfield_10
        type: order_cancelled_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderCancelled byte 10'
      - id: order_cancelled_return_bitfield_11
        type: order_cancelled_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderCancelled byte 11'
      - id: order_cancelled_return_bitfield_12
        type: order_cancelled_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderCancelled byte 12'
      - id: order_cancelled_return_bitfield_13
        type: order_cancelled_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderCancelled byte 13'
      - id: order_cancelled_return_bitfield_14
        type: order_cancelled_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderCancelled byte 14'
      - id: order_cancelled_return_bitfield_15
        type: order_cancelled_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderCancelled byte 15'
      - id: order_cancelled_return_bitfield_16
        type: order_cancelled_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderCancelled byte 16'
      - id: order_cancelled_return_bitfield_17
        type: order_cancelled_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderCancelled byte 17'
      - id: order_cancelled_return_bitfield_18
        type: order_cancelled_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderCancelled byte 18'
      - id: order_cancelled_return_bitfield_19
        type: order_cancelled_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderCancelled byte 19'
      - id: order_cancelled_return_bitfield_20
        type: order_cancelled_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderCancelled byte 20'
      - id: order_cancelled_return_bitfield_21
        type: order_cancelled_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderCancelled byte 21'
      - id: order_cancelled_return_bitfield_22
        type: order_cancelled_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderCancelled byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_capacity > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_ex_destination > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_ext_exec_inst > 0
      - id: cross_trade_flag
        type: u1
        enum: cross_trade_flag
        if: number_of_return_bitfields >= 21 and order_cancelled_return_bitfield_21.order_cancelled_return_bitfield_21_cross_trade_flag > 0
  order_cancelled_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_1_order_cancelled_return_bitfields
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_2
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_4
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_8
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_64
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_128
        type: b1
  order_cancelled_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_2_side
        type: b1
      - id: order_cancelled_return_bitfield_2_peg_difference
        type: b1
      - id: order_cancelled_return_bitfield_2_price
        type: b1
      - id: order_cancelled_return_bitfield_2_exec_inst
        type: b1
      - id: order_cancelled_return_bitfield_2_ord_type
        type: b1
      - id: order_cancelled_return_bitfield_2_time_in_force
        type: b1
      - id: order_cancelled_return_bitfield_2_min_qty
        type: b1
      - id: order_cancelled_return_bitfield_2_reserved_128
        type: b1
  order_cancelled_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_3_symbol
        type: b1
      - id: order_cancelled_return_bitfield_3_symbol_sfx
        type: b1
      - id: order_cancelled_return_bitfield_3_currency
        type: b1
      - id: order_cancelled_return_bitfield_3_id_source
        type: b1
      - id: order_cancelled_return_bitfield_3_security_id
        type: b1
      - id: order_cancelled_return_bitfield_3_security_exchange
        type: b1
      - id: order_cancelled_return_bitfield_3_capacity
        type: b1
      - id: order_cancelled_return_bitfield_3_reserved_128
        type: b1
  order_cancelled_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_4_sub_liquidity_indicator
        type: b1
      - id: order_cancelled_return_bitfield_4_trade_report_type_return
        type: b1
      - id: order_cancelled_return_bitfield_4_trade_publish_ind_return
        type: b1
      - id: order_cancelled_return_bitfield_4_text
        type: b1
      - id: order_cancelled_return_bitfield_4_bid
        type: b1
      - id: order_cancelled_return_bitfield_4_offer
        type: b1
      - id: order_cancelled_return_bitfield_4_large_size
        type: b1
      - id: order_cancelled_return_bitfield_4_last_mkt
        type: b1
  order_cancelled_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_5_fee_code
        type: b1
      - id: order_cancelled_return_bitfield_5_echo_text
        type: b1
      - id: order_cancelled_return_bitfield_5_stop_px
        type: b1
      - id: order_cancelled_return_bitfield_5_routing_inst
        type: b1
      - id: order_cancelled_return_bitfield_5_rout_strategy
        type: b1
      - id: order_cancelled_return_bitfield_5_route_delivery_method
        type: b1
      - id: order_cancelled_return_bitfield_5_ex_destination
        type: b1
      - id: order_cancelled_return_bitfield_5_reserved_128
        type: b1
  order_cancelled_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_6_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_6_day_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_6_day_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_6_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_6_day_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_6_pending_status
        type: b1
      - id: order_cancelled_return_bitfield_6_drill_thru_protection
        type: b1
      - id: order_cancelled_return_bitfield_6_multileg_reporting_typ
        type: b1
  order_cancelled_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_7_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_7_leg_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_7_leg_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_7_room_id
        type: b1
      - id: order_cancelled_return_bitfield_7_secondary_exec_id
        type: b1
      - id: order_cancelled_return_bitfield_7_user_request_id
        type: b1
      - id: order_cancelled_return_bitfield_7_sis_username
        type: b1
      - id: order_cancelled_return_bitfield_7_contra_trader
        type: b1
  order_cancelled_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_8_account
        type: b1
      - id: order_cancelled_return_bitfield_8_clearing_firm
        type: b1
      - id: order_cancelled_return_bitfield_8_clearing_account
        type: b1
      - id: order_cancelled_return_bitfield_8_display_indicator
        type: b1
      - id: order_cancelled_return_bitfield_8_max_floor
        type: b1
      - id: order_cancelled_return_bitfield_8_discretion_amount
        type: b1
      - id: order_cancelled_return_bitfield_8_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_8_prevent_match
        type: b1
  order_cancelled_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_9_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_9_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_9_put_or_call
        type: b1
      - id: order_cancelled_return_bitfield_9_open_close
        type: b1
      - id: order_cancelled_return_bitfield_9_cl_ord_id_batch
        type: b1
      - id: order_cancelled_return_bitfield_9_corrected_size
        type: b1
      - id: order_cancelled_return_bitfield_9_party_id
        type: b1
      - id: order_cancelled_return_bitfield_9_access_fee
        type: b1
  order_cancelled_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_10_orig_cl_ord_id
        type: b1
      - id: order_cancelled_return_bitfield_10_leaves_qty
        type: b1
      - id: order_cancelled_return_bitfield_10_last_shares
        type: b1
      - id: order_cancelled_return_bitfield_10_last_px
        type: b1
      - id: order_cancelled_return_bitfield_10_display_price
        type: b1
      - id: order_cancelled_return_bitfield_10_working_price
        type: b1
      - id: order_cancelled_return_bitfield_10_base_liquidity_indicator
        type: b1
      - id: order_cancelled_return_bitfield_10_expire_time
        type: b1
  order_cancelled_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_11_secondary_order_id
        type: b1
      - id: order_cancelled_return_bitfield_11_ccp
        type: b1
      - id: order_cancelled_return_bitfield_11_contra_capacity
        type: b1
      - id: order_cancelled_return_bitfield_11_attributed_quote
        type: b1
      - id: order_cancelled_return_bitfield_11_ext_exec_inst
        type: b1
      - id: order_cancelled_return_bitfield_11_bulk_order_ids
        type: b1
      - id: order_cancelled_return_bitfield_11_bulk_reject_reasons
        type: b1
      - id: order_cancelled_return_bitfield_11_party_role
        type: b1
  order_cancelled_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_12_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_2
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_4
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_8
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_64
        type: b1
      - id: order_cancelled_return_bitfield_12_trade_report_ref_id
        type: b1
  order_cancelled_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_13_marketing_fee_code
        type: b1
      - id: order_cancelled_return_bitfield_13_target_party_id
        type: b1
      - id: order_cancelled_return_bitfield_13_auction_id
        type: b1
      - id: order_cancelled_return_bitfield_13_order_category
        type: b1
      - id: order_cancelled_return_bitfield_13_liquidity_provision
        type: b1
      - id: order_cancelled_return_bitfield_13_cmta_number
        type: b1
      - id: order_cancelled_return_bitfield_13_cross_type
        type: b1
      - id: order_cancelled_return_bitfield_13_cross_prioritization
        type: b1
  order_cancelled_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_14_cross_id
        type: b1
      - id: order_cancelled_return_bitfield_14_alloc_qty
        type: b1
      - id: order_cancelled_return_bitfield_14_give_up_firm_id
        type: b1
      - id: order_cancelled_return_bitfield_14_routing_firm_id
        type: b1
      - id: order_cancelled_return_bitfield_14_waiver_type
        type: b1
      - id: order_cancelled_return_bitfield_14_cross_exclusion_indicator
        type: b1
      - id: order_cancelled_return_bitfield_14_price_formation
        type: b1
      - id: order_cancelled_return_bitfield_14_client_qualified_role
        type: b1
  order_cancelled_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_15_client_id
        type: b1
      - id: order_cancelled_return_bitfield_15_investor_id
        type: b1
      - id: order_cancelled_return_bitfield_15_executor_id
        type: b1
      - id: order_cancelled_return_bitfield_15_order_origination
        type: b1
      - id: order_cancelled_return_bitfield_15_algo
        type: b1
      - id: order_cancelled_return_bitfield_15_deferral_reason
        type: b1
      - id: order_cancelled_return_bitfield_15_investor_qualified_role
        type: b1
      - id: order_cancelled_return_bitfield_15_executor_qualified_role
        type: b1
  order_cancelled_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_16_cti_code
        type: b1
      - id: order_cancelled_return_bitfield_16_manual_order_indicator
        type: b1
      - id: order_cancelled_return_bitfield_16_operator_id
        type: b1
      - id: order_cancelled_return_bitfield_16_trade_date
        type: b1
      - id: order_cancelled_return_bitfield_16_clearing_price
        type: b1
      - id: order_cancelled_return_bitfield_16_clearing_size
        type: b1
      - id: order_cancelled_return_bitfield_16_clearing_symbol
        type: b1
      - id: order_cancelled_return_bitfield_16_clearing_optional_data
        type: b1
  order_cancelled_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_17_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_2
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_4
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_8
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_17_reserved_64
        type: b1
      - id: order_cancelled_return_bitfield_17_user_status
        type: b1
  order_cancelled_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_18_trade_reporting_indica
        type: b1
      - id: order_cancelled_return_bitfield_18_equity_party_id
        type: b1
      - id: order_cancelled_return_bitfield_18_equity_nbbo_protect
        type: b1
      - id: order_cancelled_return_bitfield_18_mass_cancel_id
        type: b1
      - id: order_cancelled_return_bitfield_18_trade_publish_ind
        type: b1
      - id: order_cancelled_return_bitfield_18_report_time
        type: b1
      - id: order_cancelled_return_bitfield_18_leg_symbol_sfx
        type: b1
      - id: order_cancelled_return_bitfield_18_client_id_attr
        type: b1
  order_cancelled_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_19_frequent_trader_id
        type: b1
      - id: order_cancelled_return_bitfield_19_session_eligibility
        type: b1
      - id: order_cancelled_return_bitfield_19_combo_order
        type: b1
      - id: order_cancelled_return_bitfield_19_compression
        type: b1
      - id: order_cancelled_return_bitfield_19_floor_destination
        type: b1
      - id: order_cancelled_return_bitfield_19_floor_routing_inst
        type: b1
      - id: order_cancelled_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_cancelled_return_bitfield_19_order_origin
        type: b1
  order_cancelled_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_20_price_type
        type: b1
      - id: order_cancelled_return_bitfield_20_strategy_id
        type: b1
      - id: order_cancelled_return_bitfield_20_trading_session_id
        type: b1
      - id: order_cancelled_return_bitfield_20_trade_through_alert_ty
        type: b1
      - id: order_cancelled_return_bitfield_20_sender_location_id
        type: b1
      - id: order_cancelled_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_cancelled_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_20_cust_order_handling_in
        type: b1
  order_cancelled_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_21_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_21_cross_initiator
        type: b1
      - id: order_cancelled_return_bitfield_21_subreason
        type: b1
      - id: order_cancelled_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_cancelled_return_bitfield_21_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_21_held
        type: b1
      - id: order_cancelled_return_bitfield_21_locate_broker
        type: b1
      - id: order_cancelled_return_bitfield_21_reserved_128
        type: b1
  order_cancelled_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_cancelled_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_cancelled_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_cancelled_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_cancelled_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: order_cancelled_return_bitfield_22_cmc_match_qty
        type: b1
      - id: order_cancelled_return_bitfield_22_step_up_amount
        type: b1
      - id: order_cancelled_return_bitfield_22_reserved_128
        type: b1
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason for the order cancellation. See Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: cancel_rejected_return_bitfield_1
        type: cancel_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet CancelRejected byte 1'
      - id: cancel_rejected_return_bitfield_2
        type: cancel_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet CancelRejected byte 2'
      - id: cancel_rejected_return_bitfield_3
        type: cancel_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet CancelRejected byte 3'
      - id: cancel_rejected_return_bitfield_4
        type: cancel_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet CancelRejected byte 4'
      - id: cancel_rejected_return_bitfield_5
        type: cancel_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet CancelRejected byte 5'
      - id: cancel_rejected_return_bitfield_6
        type: cancel_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet CancelRejected byte 6'
      - id: cancel_rejected_return_bitfield_7
        type: cancel_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet CancelRejected byte 7'
      - id: cancel_rejected_return_bitfield_8
        type: cancel_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet CancelRejected byte 8'
      - id: cancel_rejected_return_bitfield_9
        type: cancel_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet CancelRejected byte 9'
      - id: cancel_rejected_return_bitfield_10
        type: cancel_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet CancelRejected byte 10'
      - id: cancel_rejected_return_bitfield_11
        type: cancel_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet CancelRejected byte 11'
      - id: cancel_rejected_return_bitfield_12
        type: cancel_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet CancelRejected byte 12'
      - id: cancel_rejected_return_bitfield_13
        type: cancel_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet CancelRejected byte 13'
      - id: cancel_rejected_return_bitfield_14
        type: cancel_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet CancelRejected byte 14'
      - id: cancel_rejected_return_bitfield_15
        type: cancel_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet CancelRejected byte 15'
      - id: cancel_rejected_return_bitfield_16
        type: cancel_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet CancelRejected byte 16'
      - id: cancel_rejected_return_bitfield_17
        type: cancel_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet CancelRejected byte 17'
      - id: cancel_rejected_return_bitfield_18
        type: cancel_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet CancelRejected byte 18'
      - id: cancel_rejected_return_bitfield_19
        type: cancel_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet CancelRejected byte 19'
      - id: cancel_rejected_return_bitfield_20
        type: cancel_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet CancelRejected byte 20'
      - id: cancel_rejected_return_bitfield_21
        type: cancel_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet CancelRejected byte 21'
      - id: cancel_rejected_return_bitfield_22
        type: cancel_rejected_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet CancelRejected byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cancel_rejected_return_bitfield_3.cancel_rejected_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cancel_rejected_return_bitfield_3.cancel_rejected_return_bitfield_3_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 3 and cancel_rejected_return_bitfield_3.cancel_rejected_return_bitfield_3_capacity > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and cancel_rejected_return_bitfield_8.cancel_rejected_return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and cancel_rejected_return_bitfield_8.cancel_rejected_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
  cancel_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_1_cancel_rejected_return_bitfields
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_2
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_4
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_8
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_32
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_64
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_128
        type: b1
  cancel_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_2_side
        type: b1
      - id: cancel_rejected_return_bitfield_2_peg_difference
        type: b1
      - id: cancel_rejected_return_bitfield_2_price
        type: b1
      - id: cancel_rejected_return_bitfield_2_exec_inst
        type: b1
      - id: cancel_rejected_return_bitfield_2_ord_type
        type: b1
      - id: cancel_rejected_return_bitfield_2_time_in_force
        type: b1
      - id: cancel_rejected_return_bitfield_2_min_qty
        type: b1
      - id: cancel_rejected_return_bitfield_2_reserved_128
        type: b1
  cancel_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_3_symbol
        type: b1
      - id: cancel_rejected_return_bitfield_3_symbol_sfx
        type: b1
      - id: cancel_rejected_return_bitfield_3_currency
        type: b1
      - id: cancel_rejected_return_bitfield_3_id_source
        type: b1
      - id: cancel_rejected_return_bitfield_3_security_id
        type: b1
      - id: cancel_rejected_return_bitfield_3_security_exchange
        type: b1
      - id: cancel_rejected_return_bitfield_3_capacity
        type: b1
      - id: cancel_rejected_return_bitfield_3_contra_trader
        type: b1
  cancel_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_4_account
        type: b1
      - id: cancel_rejected_return_bitfield_4_clearing_firm
        type: b1
      - id: cancel_rejected_return_bitfield_4_clearing_account
        type: b1
      - id: cancel_rejected_return_bitfield_4_display_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_4_max_floor
        type: b1
      - id: cancel_rejected_return_bitfield_4_discretion_amount
        type: b1
      - id: cancel_rejected_return_bitfield_4_order_qty
        type: b1
      - id: cancel_rejected_return_bitfield_4_prevent_match
        type: b1
  cancel_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_5_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_5_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_5_put_or_call
        type: b1
      - id: cancel_rejected_return_bitfield_5_open_close
        type: b1
      - id: cancel_rejected_return_bitfield_5_cl_ord_id_batch
        type: b1
      - id: cancel_rejected_return_bitfield_5_corrected_size
        type: b1
      - id: cancel_rejected_return_bitfield_5_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_5_access_fee
        type: b1
  cancel_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_6_orig_cl_ord_id
        type: b1
      - id: cancel_rejected_return_bitfield_6_leaves_qty
        type: b1
      - id: cancel_rejected_return_bitfield_6_last_shares
        type: b1
      - id: cancel_rejected_return_bitfield_6_last_px
        type: b1
      - id: cancel_rejected_return_bitfield_6_display_price
        type: b1
      - id: cancel_rejected_return_bitfield_6_working_price
        type: b1
      - id: cancel_rejected_return_bitfield_6_base_liquidity_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_6_reserved_128
        type: b1
  cancel_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: cancel_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: cancel_rejected_return_bitfield_7_text
        type: b1
      - id: cancel_rejected_return_bitfield_7_bid
        type: b1
      - id: cancel_rejected_return_bitfield_7_offer
        type: b1
      - id: cancel_rejected_return_bitfield_7_large_size
        type: b1
      - id: cancel_rejected_return_bitfield_7_last_mkt
        type: b1
  cancel_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_8_fee_code
        type: b1
      - id: cancel_rejected_return_bitfield_8_echo_text
        type: b1
      - id: cancel_rejected_return_bitfield_8_stop_px
        type: b1
      - id: cancel_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: cancel_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: cancel_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: cancel_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: cancel_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  cancel_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: cancel_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_9_auction_id
        type: b1
      - id: cancel_rejected_return_bitfield_9_order_category
        type: b1
      - id: cancel_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: cancel_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: cancel_rejected_return_bitfield_9_cross_type
        type: b1
      - id: cancel_rejected_return_bitfield_9_cross_prioritization
        type: b1
  cancel_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_10_cross_id
        type: b1
      - id: cancel_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: cancel_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: cancel_rejected_return_bitfield_10_routing_firm_id
        type: b1
      - id: cancel_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: cancel_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_10_price_formation
        type: b1
      - id: cancel_rejected_return_bitfield_10_client_qualified_role
        type: b1
  cancel_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_11_client_id
        type: b1
      - id: cancel_rejected_return_bitfield_11_investor_id
        type: b1
      - id: cancel_rejected_return_bitfield_11_executor_id
        type: b1
      - id: cancel_rejected_return_bitfield_11_order_origination
        type: b1
      - id: cancel_rejected_return_bitfield_11_algo
        type: b1
      - id: cancel_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: cancel_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: cancel_rejected_return_bitfield_11_reserved_128
        type: b1
  cancel_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_12_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_12_day_order_qty
        type: b1
      - id: cancel_rejected_return_bitfield_12_day_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_12_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_12_day_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_12_pending_status
        type: b1
      - id: cancel_rejected_return_bitfield_12_drill_thru_protection
        type: b1
      - id: cancel_rejected_return_bitfield_12_multileg_reporting_typ
        type: b1
  cancel_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_13_leg_cfi_code
        type: b1
      - id: cancel_rejected_return_bitfield_13_leg_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_13_leg_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_13_room_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_secondary_exec_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_user_request_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_sis_username
        type: b1
      - id: cancel_rejected_return_bitfield_13_user_status
        type: b1
  cancel_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_14_trade_reporting_indica
        type: b1
      - id: cancel_rejected_return_bitfield_14_equity_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_equity_nbbo_protect
        type: b1
      - id: cancel_rejected_return_bitfield_14_mass_cancel_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_trade_publish_ind
        type: b1
      - id: cancel_rejected_return_bitfield_14_report_time
        type: b1
      - id: cancel_rejected_return_bitfield_14_leg_symbol_sfx
        type: b1
      - id: cancel_rejected_return_bitfield_14_client_id_attr
        type: b1
  cancel_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_15_frequent_trader_id
        type: b1
      - id: cancel_rejected_return_bitfield_15_session_eligibility
        type: b1
      - id: cancel_rejected_return_bitfield_15_combo_order
        type: b1
      - id: cancel_rejected_return_bitfield_15_compression
        type: b1
      - id: cancel_rejected_return_bitfield_15_floor_destination
        type: b1
      - id: cancel_rejected_return_bitfield_15_floor_routing_inst
        type: b1
      - id: cancel_rejected_return_bitfield_15_multi_class_sprd
        type: b1
      - id: cancel_rejected_return_bitfield_15_order_origin
        type: b1
  cancel_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_16_price_type
        type: b1
      - id: cancel_rejected_return_bitfield_16_strategy_id
        type: b1
      - id: cancel_rejected_return_bitfield_16_trading_session_id
        type: b1
      - id: cancel_rejected_return_bitfield_16_trade_through_alert_typ
        type: b1
      - id: cancel_rejected_return_bitfield_16_sender_location_id
        type: b1
      - id: cancel_rejected_return_bitfield_16_floor_trader_acronym
        type: b1
      - id: cancel_rejected_return_bitfield_16_exec_leg_cfi_code
        type: b1
      - id: cancel_rejected_return_bitfield_16_expire_time
        type: b1
  cancel_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_17_secondary_order_id
        type: b1
      - id: cancel_rejected_return_bitfield_17_ccp
        type: b1
      - id: cancel_rejected_return_bitfield_17_contra_capacity
        type: b1
      - id: cancel_rejected_return_bitfield_17_attributed_quote
        type: b1
      - id: cancel_rejected_return_bitfield_17_ext_exec_inst
        type: b1
      - id: cancel_rejected_return_bitfield_17_bulk_order_ids
        type: b1
      - id: cancel_rejected_return_bitfield_17_bulk_reject_reasons
        type: b1
      - id: cancel_rejected_return_bitfield_17_party_role
        type: b1
  cancel_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_2
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_4
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: cancel_rejected_return_bitfield_18_executor_qualified_role
        type: b1
  cancel_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_19_cti_code
        type: b1
      - id: cancel_rejected_return_bitfield_19_manual_order_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_19_operator_id
        type: b1
      - id: cancel_rejected_return_bitfield_19_trade_date
        type: b1
      - id: cancel_rejected_return_bitfield_19_clearing_price
        type: b1
      - id: cancel_rejected_return_bitfield_19_clearing_size
        type: b1
      - id: cancel_rejected_return_bitfield_19_clearing_symbol
        type: b1
      - id: cancel_rejected_return_bitfield_19_clearing_optional_data
        type: b1
  cancel_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_2
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_4
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_8
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_32
        type: b1
      - id: cancel_rejected_return_bitfield_20_reserved_64
        type: b1
      - id: cancel_rejected_return_bitfield_20_cust_order_handling_ins
        type: b1
  cancel_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_21_reserved_1
        type: b1
      - id: cancel_rejected_return_bitfield_21_cross_initiator
        type: b1
      - id: cancel_rejected_return_bitfield_21_subreason
        type: b1
      - id: cancel_rejected_return_bitfield_21_cross_trade_flag
        type: b1
      - id: cancel_rejected_return_bitfield_21_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_21_held
        type: b1
      - id: cancel_rejected_return_bitfield_21_locate_broker
        type: b1
      - id: cancel_rejected_return_bitfield_21_reserved_128
        type: b1
  cancel_rejected_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_22_floor_trade_time
        type: b1
      - id: cancel_rejected_return_bitfield_22_equity_ex_destination
        type: b1
      - id: cancel_rejected_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: cancel_rejected_return_bitfield_22_cmc_sessions
        type: b1
      - id: cancel_rejected_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: cancel_rejected_return_bitfield_22_cmc_match_qty
        type: b1
      - id: cancel_rejected_return_bitfield_22_step_up_amount
        type: b1
      - id: cancel_rejected_return_bitfield_22_reserved_128
        type: b1
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
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
      - id: sub_liquidity_indicato
        type: u1
        enum: sub_liquidity_indicato
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values. ASCII NUL (0x00) = No additional information E=Trade added RPI liquidity (BYX and EDGX) H=Trade added hidden liquidity I=Trade added hidden liquidity that was price improved J=Execution from first order to join the NBBO P=Periodic Auction (BYX Only) S=NBBO-Setter fee eligible V=Visible liquidity add trade that was price improved m=Midpoint Peg Order s=Order set the NBBO but is not fee eligible'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. All externally matched (routed) executions will identify the away exchange. AMEX=Routed to NYSE American ARCA=Routed to NYSE Arca BEX=Routed to Nasdaq Texas CHX=Routed to NYSE Texas ICRS=Routed to Intelligent Cross (pending approval) IEX=Routed to Investors Exchange INET=Routed to Nasdaq LTSE=Routed to Long Term Stock Exchange MEMX=Routed to Members Exchange NYSE=Routed to NYSE PERL=Routed to MIAX PEARL Exchange PSX=Routed to Nasdaq PSX NSX=Routed to NYSE National DRT=Routed to DRT Pool TFXE=Routed to 24X National Exchange TXSE=Routed to Texas Stock Exchange BATS=Routed to Cboe BZX Exchange* BYXX=Routed to Cboe BYX Exchange* EDGA=Routed to Cboe EDGA Exchange* EDGX=Routed to Cboe EDGX Exchange* * Internally matched if ContraBroker matches the identifier of the local trading platform’s book'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_execution_return_bitfield_1
        type: order_execution_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderExecution byte 1'
      - id: order_execution_return_bitfield_2
        type: order_execution_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderExecution byte 2'
      - id: order_execution_return_bitfield_3
        type: order_execution_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderExecution byte 3'
      - id: order_execution_return_bitfield_4
        type: order_execution_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderExecution byte 4'
      - id: order_execution_return_bitfield_5
        type: order_execution_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderExecution byte 5'
      - id: order_execution_return_bitfield_6
        type: order_execution_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderExecution byte 6'
      - id: order_execution_return_bitfield_7
        type: order_execution_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderExecution byte 7'
      - id: order_execution_return_bitfield_8
        type: order_execution_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderExecution byte 8'
      - id: order_execution_return_bitfield_9
        type: order_execution_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderExecution byte 9'
      - id: order_execution_return_bitfield_10
        type: order_execution_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderExecution byte 10'
      - id: order_execution_return_bitfield_11
        type: order_execution_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderExecution byte 11'
      - id: order_execution_return_bitfield_12
        type: order_execution_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderExecution byte 12'
      - id: order_execution_return_bitfield_13
        type: order_execution_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderExecution byte 13'
      - id: order_execution_return_bitfield_14
        type: order_execution_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderExecution byte 14'
      - id: order_execution_return_bitfield_15
        type: order_execution_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderExecution byte 15'
      - id: order_execution_return_bitfield_16
        type: order_execution_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderExecution byte 16'
      - id: order_execution_return_bitfield_17
        type: order_execution_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderExecution byte 17'
      - id: order_execution_return_bitfield_18
        type: order_execution_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderExecution byte 18'
      - id: order_execution_return_bitfield_19
        type: order_execution_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderExecution byte 19'
      - id: order_execution_return_bitfield_20
        type: order_execution_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet OrderExecution byte 20'
      - id: order_execution_return_bitfield_21
        type: order_execution_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet OrderExecution byte 21'
      - id: order_execution_return_bitfield_22
        type: order_execution_return_bitfield_22
        if: number_of_return_bitfields >= 22
        doc: 'BitSet OrderExecution byte 22'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_display_indicator > 0
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_fee_code > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_route_delivery_method > 0
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_ex_destination > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_prevent_match > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_attributed_quote > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_ext_exec_inst > 0
      - id: cross_trade_flag
        type: u1
        enum: cross_trade_flag
        if: number_of_return_bitfields >= 21 and order_execution_return_bitfield_21.order_execution_return_bitfield_21_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_execution_return_bitfield_21.order_execution_return_bitfield_21_locate_broker > 0
  order_execution_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_1_order_execution_return_bitfields
        type: b1
      - id: order_execution_return_bitfield_1_reserved_2
        type: b1
      - id: order_execution_return_bitfield_1_reserved_4
        type: b1
      - id: order_execution_return_bitfield_1_reserved_8
        type: b1
      - id: order_execution_return_bitfield_1_reserved_16
        type: b1
      - id: order_execution_return_bitfield_1_reserved_32
        type: b1
      - id: order_execution_return_bitfield_1_reserved_64
        type: b1
      - id: order_execution_return_bitfield_1_reserved_128
        type: b1
  order_execution_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_2_side
        type: b1
      - id: order_execution_return_bitfield_2_peg_difference
        type: b1
      - id: order_execution_return_bitfield_2_price
        type: b1
      - id: order_execution_return_bitfield_2_exec_inst
        type: b1
      - id: order_execution_return_bitfield_2_ord_type
        type: b1
      - id: order_execution_return_bitfield_2_time_in_force
        type: b1
      - id: order_execution_return_bitfield_2_min_qty
        type: b1
      - id: order_execution_return_bitfield_2_reserved_128
        type: b1
  order_execution_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_3_symbol
        type: b1
      - id: order_execution_return_bitfield_3_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_3_currency
        type: b1
      - id: order_execution_return_bitfield_3_id_source
        type: b1
      - id: order_execution_return_bitfield_3_security_id
        type: b1
      - id: order_execution_return_bitfield_3_security_exchange
        type: b1
      - id: order_execution_return_bitfield_3_capacity
        type: b1
      - id: order_execution_return_bitfield_3_contra_trader
        type: b1
  order_execution_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_4_account
        type: b1
      - id: order_execution_return_bitfield_4_clearing_firm
        type: b1
      - id: order_execution_return_bitfield_4_clearing_account
        type: b1
      - id: order_execution_return_bitfield_4_display_indicator
        type: b1
      - id: order_execution_return_bitfield_4_reserved_16
        type: b1
      - id: order_execution_return_bitfield_4_reserved_32
        type: b1
      - id: order_execution_return_bitfield_4_reserved_64
        type: b1
      - id: order_execution_return_bitfield_4_reserved_128
        type: b1
  order_execution_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_5_trade_report_type_return
        type: b1
      - id: order_execution_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: order_execution_return_bitfield_5_text
        type: b1
      - id: order_execution_return_bitfield_5_bid
        type: b1
      - id: order_execution_return_bitfield_5_offer
        type: b1
      - id: order_execution_return_bitfield_5_large_size
        type: b1
      - id: order_execution_return_bitfield_5_last_mkt
        type: b1
  order_execution_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_6_fee_code
        type: b1
      - id: order_execution_return_bitfield_6_echo_text
        type: b1
      - id: order_execution_return_bitfield_6_stop_px
        type: b1
      - id: order_execution_return_bitfield_6_routing_inst
        type: b1
      - id: order_execution_return_bitfield_6_rout_strategy
        type: b1
      - id: order_execution_return_bitfield_6_route_delivery_method
        type: b1
      - id: order_execution_return_bitfield_6_ex_destination
        type: b1
      - id: order_execution_return_bitfield_6_trade_report_ref_id
        type: b1
  order_execution_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_7_marketing_fee_code
        type: b1
      - id: order_execution_return_bitfield_7_target_party_id
        type: b1
      - id: order_execution_return_bitfield_7_auction_id
        type: b1
      - id: order_execution_return_bitfield_7_order_category
        type: b1
      - id: order_execution_return_bitfield_7_reserved_16
        type: b1
      - id: order_execution_return_bitfield_7_reserved_32
        type: b1
      - id: order_execution_return_bitfield_7_reserved_64
        type: b1
      - id: order_execution_return_bitfield_7_reserved_128
        type: b1
  order_execution_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_8_cum_qty
        type: b1
      - id: order_execution_return_bitfield_8_day_order_qty
        type: b1
      - id: order_execution_return_bitfield_8_day_cum_qty
        type: b1
      - id: order_execution_return_bitfield_8_avg_px
        type: b1
      - id: order_execution_return_bitfield_8_day_avg_px
        type: b1
      - id: order_execution_return_bitfield_8_pending_status
        type: b1
      - id: order_execution_return_bitfield_8_drill_thru_protection
        type: b1
      - id: order_execution_return_bitfield_8_multileg_reporting_typ
        type: b1
  order_execution_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_9_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_9_leg_maturity_date
        type: b1
      - id: order_execution_return_bitfield_9_leg_strike_price
        type: b1
      - id: order_execution_return_bitfield_9_room_id
        type: b1
      - id: order_execution_return_bitfield_9_secondary_exec_id
        type: b1
      - id: order_execution_return_bitfield_9_user_request_id
        type: b1
      - id: order_execution_return_bitfield_9_sis_username
        type: b1
      - id: order_execution_return_bitfield_9_user_status
        type: b1
  order_execution_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_10_trade_reporting_indica
        type: b1
      - id: order_execution_return_bitfield_10_equity_party_id
        type: b1
      - id: order_execution_return_bitfield_10_equity_nbbo_protect
        type: b1
      - id: order_execution_return_bitfield_10_mass_cancel_id
        type: b1
      - id: order_execution_return_bitfield_10_max_floor
        type: b1
      - id: order_execution_return_bitfield_10_discretion_amount
        type: b1
      - id: order_execution_return_bitfield_10_order_qty
        type: b1
      - id: order_execution_return_bitfield_10_prevent_match
        type: b1
  order_execution_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_11_maturity_date
        type: b1
      - id: order_execution_return_bitfield_11_strike_price
        type: b1
      - id: order_execution_return_bitfield_11_put_or_call
        type: b1
      - id: order_execution_return_bitfield_11_open_close
        type: b1
      - id: order_execution_return_bitfield_11_cl_ord_id_batch
        type: b1
      - id: order_execution_return_bitfield_11_corrected_size
        type: b1
      - id: order_execution_return_bitfield_11_party_id
        type: b1
      - id: order_execution_return_bitfield_11_access_fee
        type: b1
  order_execution_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_12_orig_cl_ord_id
        type: b1
      - id: order_execution_return_bitfield_12_leaves_qty
        type: b1
      - id: order_execution_return_bitfield_12_last_shares
        type: b1
      - id: order_execution_return_bitfield_12_last_px
        type: b1
      - id: order_execution_return_bitfield_12_display_price
        type: b1
      - id: order_execution_return_bitfield_12_working_price
        type: b1
      - id: order_execution_return_bitfield_12_base_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_12_expire_time
        type: b1
  order_execution_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_13_secondary_order_id
        type: b1
      - id: order_execution_return_bitfield_13_ccp
        type: b1
      - id: order_execution_return_bitfield_13_contra_capacity
        type: b1
      - id: order_execution_return_bitfield_13_attributed_quote
        type: b1
      - id: order_execution_return_bitfield_13_ext_exec_inst
        type: b1
      - id: order_execution_return_bitfield_13_bulk_order_ids
        type: b1
      - id: order_execution_return_bitfield_13_bulk_reject_reasons
        type: b1
      - id: order_execution_return_bitfield_13_party_role
        type: b1
  order_execution_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_14_reserved_1
        type: b1
      - id: order_execution_return_bitfield_14_reserved_2
        type: b1
      - id: order_execution_return_bitfield_14_reserved_4
        type: b1
      - id: order_execution_return_bitfield_14_reserved_8
        type: b1
      - id: order_execution_return_bitfield_14_liquidity_provision
        type: b1
      - id: order_execution_return_bitfield_14_cmta_number
        type: b1
      - id: order_execution_return_bitfield_14_cross_type
        type: b1
      - id: order_execution_return_bitfield_14_cross_prioritization
        type: b1
  order_execution_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_15_cross_id
        type: b1
      - id: order_execution_return_bitfield_15_alloc_qty
        type: b1
      - id: order_execution_return_bitfield_15_give_up_firm_id
        type: b1
      - id: order_execution_return_bitfield_15_routing_firm_id
        type: b1
      - id: order_execution_return_bitfield_15_waiver_type
        type: b1
      - id: order_execution_return_bitfield_15_cross_exclusion_indicator
        type: b1
      - id: order_execution_return_bitfield_15_price_formation
        type: b1
      - id: order_execution_return_bitfield_15_client_qualified_role
        type: b1
  order_execution_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_16_client_id
        type: b1
      - id: order_execution_return_bitfield_16_investor_id
        type: b1
      - id: order_execution_return_bitfield_16_executor_id
        type: b1
      - id: order_execution_return_bitfield_16_order_origination
        type: b1
      - id: order_execution_return_bitfield_16_algo
        type: b1
      - id: order_execution_return_bitfield_16_deferral_reason
        type: b1
      - id: order_execution_return_bitfield_16_investor_qualified_role
        type: b1
      - id: order_execution_return_bitfield_16_executor_qualified_role
        type: b1
  order_execution_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_17_cti_code
        type: b1
      - id: order_execution_return_bitfield_17_manual_order_indicator
        type: b1
      - id: order_execution_return_bitfield_17_operator_id
        type: b1
      - id: order_execution_return_bitfield_17_trade_date
        type: b1
      - id: order_execution_return_bitfield_17_clearing_price
        type: b1
      - id: order_execution_return_bitfield_17_clearing_size
        type: b1
      - id: order_execution_return_bitfield_17_clearing_symbol
        type: b1
      - id: order_execution_return_bitfield_17_clearing_optional_data
        type: b1
  order_execution_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_18_reserved_1
        type: b1
      - id: order_execution_return_bitfield_18_reserved_2
        type: b1
      - id: order_execution_return_bitfield_18_reserved_4
        type: b1
      - id: order_execution_return_bitfield_18_reserved_8
        type: b1
      - id: order_execution_return_bitfield_18_trade_publish_ind
        type: b1
      - id: order_execution_return_bitfield_18_report_time
        type: b1
      - id: order_execution_return_bitfield_18_leg_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_18_client_id_attr
        type: b1
  order_execution_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_19_frequent_trader_id
        type: b1
      - id: order_execution_return_bitfield_19_session_eligibility
        type: b1
      - id: order_execution_return_bitfield_19_combo_order
        type: b1
      - id: order_execution_return_bitfield_19_compression
        type: b1
      - id: order_execution_return_bitfield_19_floor_destination
        type: b1
      - id: order_execution_return_bitfield_19_floor_routing_inst
        type: b1
      - id: order_execution_return_bitfield_19_multi_class_sprd
        type: b1
      - id: order_execution_return_bitfield_19_order_origin
        type: b1
  order_execution_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_20_price_type
        type: b1
      - id: order_execution_return_bitfield_20_strategy_id
        type: b1
      - id: order_execution_return_bitfield_20_trading_session_id
        type: b1
      - id: order_execution_return_bitfield_20_trade_through_alert_typ
        type: b1
      - id: order_execution_return_bitfield_20_sender_location_id
        type: b1
      - id: order_execution_return_bitfield_20_floor_trader_acronym
        type: b1
      - id: order_execution_return_bitfield_20_exec_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_20_cust_order_handling_ins
        type: b1
  order_execution_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_21_reserved_1
        type: b1
      - id: order_execution_return_bitfield_21_cross_initiator
        type: b1
      - id: order_execution_return_bitfield_21_subreason
        type: b1
      - id: order_execution_return_bitfield_21_cross_trade_flag
        type: b1
      - id: order_execution_return_bitfield_21_reserved_16
        type: b1
      - id: order_execution_return_bitfield_21_held
        type: b1
      - id: order_execution_return_bitfield_21_locate_broker
        type: b1
      - id: order_execution_return_bitfield_21_reserved_128
        type: b1
  order_execution_return_bitfield_22:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_22_floor_trade_time
        type: b1
      - id: order_execution_return_bitfield_22_equity_ex_destination
        type: b1
      - id: order_execution_return_bitfield_22_cross_on_behalf_of_id
        type: b1
      - id: order_execution_return_bitfield_22_cmc_sessions
        type: b1
      - id: order_execution_return_bitfield_22_intra_firm_trade_ind
        type: b1
      - id: order_execution_return_bitfield_22_cmc_match_qty
        type: b1
      - id: order_execution_return_bitfield_22_step_up_amount
        type: b1
      - id: order_execution_return_bitfield_22_reserved_128
        type: b1
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in Cboe FIX. Refers to the ExecID of the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1=Buy 2=Sell 5=Sell Short (client affirms ability to borrow) 6=Sell Short Exempt'
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
        doc: 'Corresponds to OrigTime (42). The date and time of the original trade, in GMT. Nanoseconds since Unix epoch'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_cancelor_correct_return_bitfield_1
        type: trade_cancelor_correct_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCancelorCorrect byte 1'
      - id: trade_cancelor_correct_return_bitfield_2
        type: trade_cancelor_correct_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCancelorCorrect byte 2'
      - id: trade_cancelor_correct_return_bitfield_3
        type: trade_cancelor_correct_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCancelorCorrect byte 3'
      - id: trade_cancelor_correct_return_bitfield_4
        type: trade_cancelor_correct_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCancelorCorrect byte 4'
      - id: trade_cancelor_correct_return_bitfield_5
        type: trade_cancelor_correct_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCancelorCorrect byte 5'
      - id: trade_cancelor_correct_return_bitfield_6
        type: trade_cancelor_correct_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCancelorCorrect byte 6'
      - id: trade_cancelor_correct_return_bitfield_7
        type: trade_cancelor_correct_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCancelorCorrect byte 7'
      - id: trade_cancelor_correct_return_bitfield_8
        type: trade_cancelor_correct_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCancelorCorrect byte 8'
      - id: trade_cancelor_correct_return_bitfield_9
        type: trade_cancelor_correct_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCancelorCorrect byte 9'
      - id: trade_cancelor_correct_return_bitfield_10
        type: trade_cancelor_correct_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCancelorCorrect byte 10'
      - id: trade_cancelor_correct_return_bitfield_11
        type: trade_cancelor_correct_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCancelorCorrect byte 11'
      - id: trade_cancelor_correct_return_bitfield_12
        type: trade_cancelor_correct_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCancelorCorrect byte 12'
      - id: trade_cancelor_correct_return_bitfield_13
        type: trade_cancelor_correct_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCancelorCorrect byte 13'
      - id: trade_cancelor_correct_return_bitfield_14
        type: trade_cancelor_correct_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCancelorCorrect byte 14'
      - id: trade_cancelor_correct_return_bitfield_15
        type: trade_cancelor_correct_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCancelorCorrect byte 15'
      - id: trade_cancelor_correct_return_bitfield_16
        type: trade_cancelor_correct_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCancelorCorrect byte 16'
      - id: trade_cancelor_correct_return_bitfield_17
        type: trade_cancelor_correct_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCancelorCorrect byte 17'
      - id: trade_cancelor_correct_return_bitfield_18
        type: trade_cancelor_correct_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCancelorCorrect byte 18'
      - id: trade_cancelor_correct_return_bitfield_19
        type: trade_cancelor_correct_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCancelorCorrect byte 19'
      - id: trade_cancelor_correct_return_bitfield_20
        type: trade_cancelor_correct_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet TradeCancelorCorrect byte 20'
      - id: trade_cancelor_correct_return_bitfield_21
        type: trade_cancelor_correct_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet TradeCancelorCorrect byte 21'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_capacity > 0
  trade_cancelor_correct_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_1_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_peg_difference
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_exec_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_ord_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_time_in_force
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_min_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_2_symbol
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_currency
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_id_source
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_security_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_security_exchange
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_capacity
        type: b1
      - id: trade_cancelor_correct_return_bitfield_2_contra_trader
        type: b1
  trade_cancelor_correct_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_3_account
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_clearing_account
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_display_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_max_floor
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_order_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_3_prevent_match
        type: b1
  trade_cancelor_correct_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_4_maturity_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_strike_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_put_or_call
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_open_close
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_corrected_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_access_fee
        type: b1
  trade_cancelor_correct_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_last_shares
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_last_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_display_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_working_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_expire_time
        type: b1
  trade_cancelor_correct_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_ccp
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_reserved_8
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_reserved_32
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_reserved_64
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_7_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_text
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_bid
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_offer
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_large_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_last_mkt
        type: b1
  trade_cancelor_correct_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_8_fee_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_echo_text
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_stop_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_routing_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_ex_destination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_cancelor_correct_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_target_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_auction_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_order_category
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_cmta_number
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_cross_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_cross_prioritization
        type: b1
  trade_cancelor_correct_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_10_cross_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_waiver_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_price_formation
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_client_qualified_role
        type: b1
  trade_cancelor_correct_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_11_client_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_investor_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_executor_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_order_origination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_algo
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_executor_qualified_role
        type: b1
  trade_cancelor_correct_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_12_cti_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_operator_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_8
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_32
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_64
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_13_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_avg_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_pending_status
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_multileg_reporting_typ
        type: b1
  trade_cancelor_correct_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_room_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_user_request_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_sis_username
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_user_status
        type: b1
  trade_cancelor_correct_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_15_trade_reporting_indica
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_report_time
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_client_id_attr
        type: b1
  trade_cancelor_correct_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_combo_order
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_compression
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_floor_destination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_multi_class_sprd
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_order_origin
        type: b1
  trade_cancelor_correct_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_17_price_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_strategy_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_trade_through_alert_ty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_cust_order_handling_in
        type: b1
  trade_cancelor_correct_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_18_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_subreason
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_attributed_quote
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_ext_exec_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_bulk_order_ids
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_bulk_reject_reasons
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_party_role
        type: b1
  trade_cancelor_correct_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_19_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_reserved_2
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_reserved_4
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_trade_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_clearing_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_clearing_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_clearing_symbol
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_clearing_optional_data
        type: b1
  trade_cancelor_correct_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_20_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_reserved_2
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_reserved_4
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_cross_trade_flag
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_held
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_locate_broker
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_21_floor_trade_time
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_equity_ex_destination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_cmc_sessions
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_cmc_match_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_step_up_amount
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_reserved_128
        type: b1
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_coun
        type: u4
        doc: 'Number of orders cancelled. This field corresponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection. See Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: purge_rejected_return_bitfield_1
        type: purge_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet PurgeRejected byte 1'
      - id: purge_rejected_return_bitfield_2
        type: purge_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet PurgeRejected byte 2'
      - id: purge_rejected_return_bitfield_3
        type: purge_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet PurgeRejected byte 3'
      - id: purge_rejected_return_bitfield_4
        type: purge_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet PurgeRejected byte 4'
      - id: purge_rejected_return_bitfield_5
        type: purge_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet PurgeRejected byte 5'
      - id: purge_rejected_return_bitfield_6
        type: purge_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet PurgeRejected byte 6'
      - id: purge_rejected_return_bitfield_7
        type: purge_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet PurgeRejected byte 7'
      - id: purge_rejected_return_bitfield_8
        type: purge_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet PurgeRejected byte 8'
      - id: purge_rejected_return_bitfield_9
        type: purge_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet PurgeRejected byte 9'
      - id: purge_rejected_return_bitfield_10
        type: purge_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet PurgeRejected byte 10'
      - id: purge_rejected_return_bitfield_11
        type: purge_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet PurgeRejected byte 11'
      - id: purge_rejected_return_bitfield_12
        type: purge_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet PurgeRejected byte 12'
      - id: purge_rejected_return_bitfield_13
        type: purge_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet PurgeRejected byte 13'
      - id: purge_rejected_return_bitfield_14
        type: purge_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet PurgeRejected byte 14'
      - id: purge_rejected_return_bitfield_15
        type: purge_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet PurgeRejected byte 15'
      - id: purge_rejected_return_bitfield_16
        type: purge_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet PurgeRejected byte 16'
      - id: purge_rejected_return_bitfield_17
        type: purge_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet PurgeRejected byte 17'
      - id: purge_rejected_return_bitfield_18
        type: purge_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet PurgeRejected byte 18'
      - id: purge_rejected_return_bitfield_19
        type: purge_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet PurgeRejected byte 19'
      - id: purge_rejected_return_bitfield_20
        type: purge_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet PurgeRejected byte 20'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and purge_rejected_return_bitfield_10.purge_rejected_return_bitfield_10_mass_cancel_id > 0
  purge_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_1_purge_rejected_return_bitfields
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_2
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_4
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_8
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_32
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_64
        type: b1
      - id: purge_rejected_return_bitfield_1_reserved_128
        type: b1
  purge_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_2_side
        type: b1
      - id: purge_rejected_return_bitfield_2_peg_difference
        type: b1
      - id: purge_rejected_return_bitfield_2_price
        type: b1
      - id: purge_rejected_return_bitfield_2_exec_inst
        type: b1
      - id: purge_rejected_return_bitfield_2_ord_type
        type: b1
      - id: purge_rejected_return_bitfield_2_time_in_force
        type: b1
      - id: purge_rejected_return_bitfield_2_min_qty
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_128
        type: b1
  purge_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_3_symbol
        type: b1
      - id: purge_rejected_return_bitfield_3_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_3_currency
        type: b1
      - id: purge_rejected_return_bitfield_3_id_source
        type: b1
      - id: purge_rejected_return_bitfield_3_security_id
        type: b1
      - id: purge_rejected_return_bitfield_3_security_exchange
        type: b1
      - id: purge_rejected_return_bitfield_3_capacity
        type: b1
      - id: purge_rejected_return_bitfield_3_contra_trader
        type: b1
  purge_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_4_account
        type: b1
      - id: purge_rejected_return_bitfield_4_clearing_firm
        type: b1
      - id: purge_rejected_return_bitfield_4_clearing_account
        type: b1
      - id: purge_rejected_return_bitfield_4_display_indicator
        type: b1
      - id: purge_rejected_return_bitfield_4_max_floor
        type: b1
      - id: purge_rejected_return_bitfield_4_discretion_amount
        type: b1
      - id: purge_rejected_return_bitfield_4_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_4_prevent_match
        type: b1
  purge_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_5_trade_report_type_return
        type: b1
      - id: purge_rejected_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: purge_rejected_return_bitfield_5_text
        type: b1
      - id: purge_rejected_return_bitfield_5_bid
        type: b1
      - id: purge_rejected_return_bitfield_5_offer
        type: b1
      - id: purge_rejected_return_bitfield_5_large_size
        type: b1
      - id: purge_rejected_return_bitfield_5_last_mkt
        type: b1
  purge_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_6_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_6_echo_text
        type: b1
      - id: purge_rejected_return_bitfield_6_stop_px
        type: b1
      - id: purge_rejected_return_bitfield_6_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_6_rout_strategy
        type: b1
      - id: purge_rejected_return_bitfield_6_route_delivery_method
        type: b1
      - id: purge_rejected_return_bitfield_6_ex_destination
        type: b1
      - id: purge_rejected_return_bitfield_6_trade_report_ref_id
        type: b1
  purge_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_7_marketing_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_7_target_party_id
        type: b1
      - id: purge_rejected_return_bitfield_7_auction_id
        type: b1
      - id: purge_rejected_return_bitfield_7_order_category
        type: b1
      - id: purge_rejected_return_bitfield_7_liquidity_provision
        type: b1
      - id: purge_rejected_return_bitfield_7_cmta_number
        type: b1
      - id: purge_rejected_return_bitfield_7_cross_type
        type: b1
      - id: purge_rejected_return_bitfield_7_cross_prioritization
        type: b1
  purge_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_8_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_8_day_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_8_day_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_8_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_8_day_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_8_pending_status
        type: b1
      - id: purge_rejected_return_bitfield_8_drill_thru_protection
        type: b1
      - id: purge_rejected_return_bitfield_8_multileg_reporting_typ
        type: b1
  purge_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_9_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_9_leg_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_9_leg_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_9_room_id
        type: b1
      - id: purge_rejected_return_bitfield_9_secondary_exec_id
        type: b1
      - id: purge_rejected_return_bitfield_9_user_request_id
        type: b1
      - id: purge_rejected_return_bitfield_9_sis_username
        type: b1
      - id: purge_rejected_return_bitfield_9_user_status
        type: b1
  purge_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_10_trade_reporting_indica
        type: b1
      - id: purge_rejected_return_bitfield_10_equity_party_id
        type: b1
      - id: purge_rejected_return_bitfield_10_equity_nbbo_protect
        type: b1
      - id: purge_rejected_return_bitfield_10_mass_cancel_id
        type: b1
      - id: purge_rejected_return_bitfield_10_trade_publish_ind
        type: b1
      - id: purge_rejected_return_bitfield_10_report_time
        type: b1
      - id: purge_rejected_return_bitfield_10_leg_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_10_client_id_attr
        type: b1
  purge_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_11_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_11_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_11_put_or_call
        type: b1
      - id: purge_rejected_return_bitfield_11_open_close
        type: b1
      - id: purge_rejected_return_bitfield_11_cl_ord_id_batch
        type: b1
      - id: purge_rejected_return_bitfield_11_corrected_size
        type: b1
      - id: purge_rejected_return_bitfield_11_party_id
        type: b1
      - id: purge_rejected_return_bitfield_11_access_fee
        type: b1
  purge_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_12_orig_cl_ord_id
        type: b1
      - id: purge_rejected_return_bitfield_12_leaves_qty
        type: b1
      - id: purge_rejected_return_bitfield_12_last_shares
        type: b1
      - id: purge_rejected_return_bitfield_12_last_px
        type: b1
      - id: purge_rejected_return_bitfield_12_display_price
        type: b1
      - id: purge_rejected_return_bitfield_12_working_price
        type: b1
      - id: purge_rejected_return_bitfield_12_base_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_12_expire_time
        type: b1
  purge_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_13_secondary_order_id
        type: b1
      - id: purge_rejected_return_bitfield_13_ccp
        type: b1
      - id: purge_rejected_return_bitfield_13_contra_capacity
        type: b1
      - id: purge_rejected_return_bitfield_13_attributed_quote
        type: b1
      - id: purge_rejected_return_bitfield_13_ext_exec_inst
        type: b1
      - id: purge_rejected_return_bitfield_13_bulk_order_ids
        type: b1
      - id: purge_rejected_return_bitfield_13_bulk_reject_reasons
        type: b1
      - id: purge_rejected_return_bitfield_13_party_role
        type: b1
  purge_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_14_cross_id
        type: b1
      - id: purge_rejected_return_bitfield_14_alloc_qty
        type: b1
      - id: purge_rejected_return_bitfield_14_give_up_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_14_routing_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_14_waiver_type
        type: b1
      - id: purge_rejected_return_bitfield_14_cross_exclusion_indicator
        type: b1
      - id: purge_rejected_return_bitfield_14_price_formation
        type: b1
      - id: purge_rejected_return_bitfield_14_client_qualified_role
        type: b1
  purge_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_15_client_id
        type: b1
      - id: purge_rejected_return_bitfield_15_investor_id
        type: b1
      - id: purge_rejected_return_bitfield_15_executor_id
        type: b1
      - id: purge_rejected_return_bitfield_15_order_origination
        type: b1
      - id: purge_rejected_return_bitfield_15_algo
        type: b1
      - id: purge_rejected_return_bitfield_15_deferral_reason
        type: b1
      - id: purge_rejected_return_bitfield_15_investor_qualified_role
        type: b1
      - id: purge_rejected_return_bitfield_15_executor_qualified_role
        type: b1
  purge_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_16_cti_code
        type: b1
      - id: purge_rejected_return_bitfield_16_manual_order_indicator
        type: b1
      - id: purge_rejected_return_bitfield_16_operator_id
        type: b1
      - id: purge_rejected_return_bitfield_16_trade_date
        type: b1
      - id: purge_rejected_return_bitfield_16_clearing_price
        type: b1
      - id: purge_rejected_return_bitfield_16_clearing_size
        type: b1
      - id: purge_rejected_return_bitfield_16_clearing_symbol
        type: b1
      - id: purge_rejected_return_bitfield_16_clearing_optional_data
        type: b1
  purge_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_17_frequent_trader_id
        type: b1
      - id: purge_rejected_return_bitfield_17_session_eligibility
        type: b1
      - id: purge_rejected_return_bitfield_17_combo_order
        type: b1
      - id: purge_rejected_return_bitfield_17_compression
        type: b1
      - id: purge_rejected_return_bitfield_17_floor_destination
        type: b1
      - id: purge_rejected_return_bitfield_17_floor_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_17_multi_class_sprd
        type: b1
      - id: purge_rejected_return_bitfield_17_order_origin
        type: b1
  purge_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_18_price_type
        type: b1
      - id: purge_rejected_return_bitfield_18_strategy_id
        type: b1
      - id: purge_rejected_return_bitfield_18_trading_session_id
        type: b1
      - id: purge_rejected_return_bitfield_18_trade_through_alert_typ
        type: b1
      - id: purge_rejected_return_bitfield_18_sender_location_id
        type: b1
      - id: purge_rejected_return_bitfield_18_floor_trader_acronym
        type: b1
      - id: purge_rejected_return_bitfield_18_exec_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_18_cust_order_handling_ins
        type: b1
  purge_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_19_reserved_1
        type: b1
      - id: purge_rejected_return_bitfield_19_cross_initiator
        type: b1
      - id: purge_rejected_return_bitfield_19_subreason
        type: b1
      - id: purge_rejected_return_bitfield_19_cross_trade_flag
        type: b1
      - id: purge_rejected_return_bitfield_19_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_19_held
        type: b1
      - id: purge_rejected_return_bitfield_19_locate_broker
        type: b1
      - id: purge_rejected_return_bitfield_19_reserved_128
        type: b1
  purge_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_20_floor_trade_time
        type: b1
      - id: purge_rejected_return_bitfield_20_equity_ex_destination
        type: b1
      - id: purge_rejected_return_bitfield_20_cross_on_behalf_of_id
        type: b1
      - id: purge_rejected_return_bitfield_20_cmc_sessions
        type: b1
      - id: purge_rejected_return_bitfield_20_intra_firm_trade_ind
        type: b1
      - id: purge_rejected_return_bitfield_20_cmc_match_qty
        type: b1
      - id: purge_rejected_return_bitfield_20_step_up_amount
        type: b1
      - id: purge_rejected_return_bitfield_20_reserved_128
        type: b1
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
      doc: 'Login Request Message.'
    0x02:
      id: 'logout_request_message'
      doc: 'Logout Request Message.'
    0x03:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat Message.'
    0x24:
      id: 'login_response_message'
      doc: 'Login Response Message.'
    0x08:
      id: 'logout_message'
      doc: 'Logout Message.'
    0x09:
      id: 'server_heartbeat_message'
      doc: 'Server Heartbeat Message.'
    0x13:
      id: 'replay_complete_message'
      doc: 'Replay Complete Message.'
    0x38:
      id: 'new_order_message'
      doc: 'New Order Message.'
    0x39:
      id: 'cancel_order_message'
      doc: 'Cancel Order Message.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Modify Order Message.'
    0x47:
      id: 'purge_order_message'
      doc: 'Purge Order Message.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'Order Acknowledgment Message.'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected Message.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified Message.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated Message.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected Message.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'Order Cancelled Message.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'Cancel Rejected Message.'
    0x2c:
      id: 'order_execution_message'
      doc: 'Order Execution Message.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Trade Cancel or Correct Message.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'Mass Cancel Acknowledgment Message.'
    0x48:
      id: 'purge_rejected_message'
      doc: 'Purge Rejected Message.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized Invalid Usernamepassword'
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
      id: 'sell_short'
      doc: 'Sell Short Client Affirms Ability To Borrow'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  exec_inst:
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep Directed Or Book Post Only'
    0x50:
      id: 'market_peg'
      doc: 'Market Peg Peg Buy Sell To Nbbo Offer Bid'
    0x51:
      id: 'market_maker_peg'
      doc: 'Market Maker Peg See Cboe Titanium Us Equities Market Maker Specification'
    0x52:
      id: 'primary_peg'
      doc: 'Primary Peg Peg Buy Sell To Nbb Bid Offer'
    0x55:
      id: 'supplemental_peg_order'
      doc: 'Supplemental Peg Order'
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint Peg To Nbbo Midpoint'
    0x6d:
      id: 'midpoint_x6d'
      doc: 'Midpoint Peg To Nbbo Midpoint But Do Not Match When Nbbo Is Locked'
    0x4c:
      id: 'alternate_midpoint'
      doc: 'Alternate Midpoint Less Aggressive Of Midpoint And 1 Tick Inside Nbbo Edga And Edgx'
    0x64:
      id: 'midpoint_discretionary_order'
      doc: 'Midpoint Discretionary Order'
    0x65:
      id: 'midpoint_discretionary_order_with_quote_depletion_protection'
      doc: 'Midpoint Discretionary Order With Quote Depletion Protection Bzx'
    0x72:
      id: 'late'
      doc: 'Late For Use With Auction Only Orders See The Cboe Titanium Us Equities Auction Process Specification Bzx And Edgx'
    0x6f:
      id: 'listing_market_opening'
      doc: 'Listing Market Opening For Rooc Rout Strategy Only'
    0x63:
      id: 'listing_market_close'
      doc: 'Listing Market Close For Rooc Rout Strategy Only'
    0x61:
      id: 'both_listing_market_open_and_close'
      doc: 'Both Listing Market Open And Close For Rooc Rout Strategy Strategy Only Also Eligible For Participation In Halt Auctions'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit Default'
    0x33:
      id: 'stop'
      doc: 'Stop'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit'
    0x50:
      id: 'pegged'
      doc: 'Pegged Pegged Requires Exec Inst Be Set To L M M P Q Or R Market Implies A Time In Force Of Day Market Day Orders Post In Luld Straddle State Or If A Short Sale During A Regulation Sho Short Sale Circuit Breaker Pegged Orders May Not Be Routable Except For Midpoint Pegs Byx Where Rout Strategy Rmpt Rmpl Or Dirc'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day Default Early Trading Session Until End Of Regular Session'
    0x31:
      id: 'gtc'
      doc: 'Gtc Allowed But Treated As Day'
    0x32:
      id: 'at_the_open'
      doc: 'At The Open Bzx Only And Cboe Listed Securities Only'
    0x33:
      id: 'ioc'
      doc: 'Ioc Portion Not Filled Immediately Is Cancelled'
    0x34:
      id: 'fok'
      doc: 'Fok An Ioc Where The Entire Size Must Be Filled Else The Order Will Be Cancelled Back'
    0x35:
      id: 'gtx'
      doc: 'Gtx Early Trading Session Until End Of Post Market Session'
    0x36:
      id: 'gtd'
      doc: 'Gtd Early Trading Session Expires At Earlier Of Expire Time Or End Of Post Market Session'
    0x37:
      id: 'at_the_close'
      doc: 'At The Close Bzx Only And Applicable To Cboe Listed Securities And Cboe Market Close Symbols'
    0x45:
      id: 'pre'
      doc: 'Pre Pre Market Trading Session Until End Of Regular Session'
    0x50:
      id: 'rtp'
      doc: 'Rtp Regular Hours And Post Market Sessioneffective 100926'
    0x52:
      id: 'rho'
      doc: 'Rho Regular Hours Session Only'
    0x54:
      id: 'ptd'
      doc: 'Ptd Pre Market Trading Session Expires At Earlier Of Specified Expire Time Or End Of Post Market Session'
    0x58:
      id: 'ptx'
      doc: 'Ptx Pre Market Trading Session Until End Of Post Market Session'
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
      id: 'default_field'
      doc: 'Default As Determined By Port Level Setting Defaults To S'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'cancel_back_the_order_if_it_cannot_be_booked_and_displayed'
      doc: 'Cancel Back The Order If It Cannot Be Booked And Displayed Without Adjustment'
    0x72:
      id: 'hidden'
      doc: 'Hidden Cancel Back The Order If It Cannot Be Booked Without Adjustment'
    0x53:
      id: 'display_price_sliding'
      doc: 'Display Price Sliding This Is To Override An Optout Of Display Price Siding At The Port Level'
    0x4c:
      id: 'display_price_sliding_but_cancel_back_if_order_crosses_the'
      doc: 'Display Price Sliding But Cancel Back If Order Crosses The Nbbo On Entry'
    0x4d:
      id: 'multiple_display_price_sliding'
      doc: 'Multiple Display Price Sliding'
    0x68:
      id: 'hidden_multiple_price_slide'
      doc: 'Hidden Multiple Price Slide Other Options'
    0x76:
      id: 'visible'
      doc: 'Visible For Visible Peg Orders Only Others Will Be Rejected'
    0x49:
      id: 'invisible'
      doc: 'Invisible Implied For Midpoint Peg Orders'
    0x4e:
      id: 'no_rescrape_at_limit'
      doc: 'No Rescrape At Limit Applicable Only To Fully Routable Ioc Orders Routing Inst R And Time In Force 3 After Walking The Price To The Limit There Will Be No Final Scrape At Cboe And The Cancel Reason Code Will State X Expired Rather Than N No Liquidity'
  locate_reqd:
    0x4e:
      id: 'client_affirms_ability_to_borrow'
      doc: 'Client Affirms Ability To Borrow Default'
    0x59:
      id: 'client_does_not_affirm_ability_to_borrow'
      doc: 'Client Does Not Affirm Ability To Borrow Results In Reject'
  ex_destination:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x46:
      id: 'texas_stock_exchange'
      doc: 'Texas Stock Exchange'
    0x47:
      id: 'n_24_x_national_exchange'
      doc: '24 X National Exchange'
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
      id: 'nyse_texas'
      doc: 'Nyse Texas'
    0x4e:
      id: 'nyse'
      doc: 'Nyse'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x54:
      id: 'intelligent_cross'
      doc: 'Intelligent Cross Pending Approval'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx'
    0x59:
      id: 'byx_1'
      doc: 'Byx 1'
    0x5a:
      id: 'bzx_1'
      doc: 'Bzx 11 Post To Away Option Available For Rout And Roux Only 2 Post To Edgx For Rout Roux Rouz Rdot'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_mpid_to_this_order'
      doc: 'Do Not Attribute Firm Mpid To This Order'
    0x59:
      id: 'attribute_firm_mpid_to_this_order'
      doc: 'Attribute Firm Mpid To This Order'
    0x52:
      id: 'attribute_rtal_to_this_order'
      doc: 'Attribute Rtal To This Order'
  ext_exec_inst:
    0x4e:
      id: 'none'
      doc: 'None'
    0x52:
      id: 'retail_order_eligible_for_retail_rebate'
      doc: 'Retail Order Eligible For Retail Rebate Byx And Edgx'
    0x50:
      id: 'retail_order'
      doc: 'Retail Order Price Improvement Only'
    0x54:
      id: 'retail_price_improving_order'
      doc: 'Retail Price Improving Order Edgx'
    0x58:
      id: 'retail_priority_order'
      doc: 'Retail Priority Order Eligible For Retail Priority And Retail Rebate Rate'
  cross_trade_flag:
    0x30:
      id: 'none'
      doc: 'None To Override Port Setting As Necessary'
    0x31:
      id: 'periodic_auction_only'
      doc: 'Periodic Auction Only'
    0x32:
      id: 'periodic_auction_eligible'
      doc: 'Periodic Auction Eligible'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  sub_liquidity_indicator:
    0x45:
      id: 'trade_added_rpi_liquidity'
      doc: 'Trade Added Rpi Liquidity Byx And Edgx'
    0x48:
      id: 'trade_added_hidden_liquidity'
      doc: 'Trade Added Hidden Liquidity'
    0x49:
      id: 'trade_added_hidden_liquidity_that_was_price_improved'
      doc: 'Trade Added Hidden Liquidity That Was Price Improved'
    0x4a:
      id: 'execution_from_first_order_to_join_the_nbbo'
      doc: 'Execution From First Order To Join The Nbbo'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction Byx Only'
    0x53:
      id: 'nbbo_setter_fee_eligible'
      doc: 'Nbbo Setter Fee Eligible'
    0x56:
      id: 'visible_liquidity_add_trade_that_was_price_improved'
      doc: 'Visible Liquidity Add Trade That Was Price Improved'
    0x6d:
      id: 'midpoint_peg_order'
      doc: 'Midpoint Peg Order'
    0x73:
      id: 'order_set_the_nbbo_but_is_not_fee_eligible'
      doc: 'Order Set The Nbbo But Is Not Fee Eligible'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x57:
      id: 'waiting_for_execution_at_premarket_time_as'
      doc: 'Waiting For Execution At Premarket Time As Defined By Time In Force Value And Hold Early To 7 Am Port Setting Only Applied On The Initial Order Acknowledgment'
    0x58:
      id: 'routed_to_another_market'
      doc: 'Routed To Another Market'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
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
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down Luld'
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
      doc: 'Cboe Market Close Cmc'
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
      id: 'reduction_of_order_qty_due_to_swp'
      doc: 'Reduction Of Order Qty Due To Swp'
    0x57:
      id: 'wash_or_mtp_decrement'
      doc: 'Wash Or Mtp Decrement Cboe Reserves The Right To Add New Values As Necessary Without Prior Notice'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
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
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down Luld'
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
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
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
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down Luld'
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
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
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
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  sub_liquidity_indicato:
    0x45:
      id: 'trade_added_rpi_liquidity'
      doc: 'Trade Added Rpi Liquidity Byx And Edgx'
    0x48:
      id: 'trade_added_hidden_liquidity'
      doc: 'Trade Added Hidden Liquidity'
    0x49:
      id: 'trade_added_hidden_liquidity_that_was_price'
      doc: 'Trade Added Hidden Liquidity That Was Price Improved'
    0x4a:
      id: 'execution_from_first_order_to_join_the_nbbo'
      doc: 'Execution From First Order To Join The Nbbo'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction Byx Only'
    0x53:
      id: 'nbbo_setter_fee_eligible'
      doc: 'Nbbo Setter Fee Eligible'
    0x56:
      id: 'visible_liquidity_add_trade_that_was_price'
      doc: 'Visible Liquidity Add Trade That Was Price Improved'
    0x6d:
      id: 'midpoint_peg_order'
      doc: 'Midpoint Peg Order'
    0x73:
      id: 'order_set_the_nbbo_but_is_not_fee_eligible'
      doc: 'Order Set The Nbbo But Is Not Fee Eligible'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
      id: 'risk_management_mpid_or_risk_group_id_level'
      doc: 'Risk Management Mpid Or Risk Group Id Level'
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
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x75:
      id: 'limit_up_limit_down'
      doc: 'Limit Up Limit Down Luld'
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'

