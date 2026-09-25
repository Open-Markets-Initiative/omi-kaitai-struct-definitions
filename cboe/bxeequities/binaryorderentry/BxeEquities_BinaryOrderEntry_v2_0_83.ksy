# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BxeEquities BinaryOrderEntry Boe v2.0.83
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: 
#   Encoding: Cboe Binary Order Entry
#   Version: 2.0.83
#   Date: 5/27/2026
#   Specification: Cboe Europe BOE2 Specification.pdf
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
  id: cboe_bxeequities_binaryorderentry_boe_v2_0_83
  title: Cboe BxeEquities BinaryOrderEntry Boe v2.0.83
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe BXE Boe v2.0.83'
doc-ref: https://www.cboe.com/europe/equities/support/technical/

seq:
  - id: message_header
    type: message_header_struct
    doc: '10-byte BOE v2 message header. Every message starts with StartOfMessage = 0xBA 0xBA'
  - id: message
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::login_request_v_2_message': login_request_v_2_message
        'message_type::login_response_v_2_message': login_response_v_2_message
        'message_type::logout_message': logout_message
        'message_type::new_order_v_2_message': new_order_v_2_message
        'message_type::cancel_order_v_2_message': cancel_order_v_2_message
        'message_type::modify_order_v_2_message': modify_order_v_2_message
        'message_type::purge_orders_v_2_message': purge_orders_v_2_message
        'message_type::trade_capture_report_v_2_message': trade_capture_report_v_2_message
        'message_type::order_acknowledgment_v_2_message': order_acknowledgment_v_2_message
        'message_type::order_rejected_v_2_message': order_rejected_v_2_message
        'message_type::order_modified_v_2_message': order_modified_v_2_message
        'message_type::order_restated_v_2_message': order_restated_v_2_message
        'message_type::user_modify_rejected_v_2_message': user_modify_rejected_v_2_message
        'message_type::order_cancelled_v_2_message': order_cancelled_v_2_message
        'message_type::cancel_rejected_v_2_message': cancel_rejected_v_2_message
        'message_type::order_execution_v_2_message': order_execution_v_2_message
        'message_type::trade_cancel_or_correct_v_2_message': trade_cancel_or_correct_v_2_message
        'message_type::purge_rejected_v_2_message': purge_rejected_v_2_message
        'message_type::mass_cancel_acknowledgment_v_2_message': mass_cancel_acknowledgment_v_2_message
        'message_type::trade_capture_report_acknowledgment_v_2_message': trade_capture_report_acknowledgment_v_2_message
        'message_type::trade_capture_report_reject_v_2_message': trade_capture_report_reject_v_2_message
        'message_type::trade_capture_confirm_v_2_message': trade_capture_confirm_v_2_message
        'message_type::trade_capture_report_decline_v_2_message': trade_capture_report_decline_v_2_message

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
        doc: 'Return message type for which the bitfields are being specified (e.g., 0x25 for an Order Ac- knowledgment V2 message)'
      - id: matching_unit
        type: u1
        doc: 'The matching unit which created this message. Only populated on sequenced, non-session level messages sent from Cboe to the Member; 0 for inbound and all session level messages'
      - id: sequence_number
        type: u4
        doc: 'The sequence number for this message. Cboe-to-Member messages sequenced distinctly per matching unit; Member-to-Cboe sequenced across all matching units with a single stream'
  login_request_v_2_message:
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
        doc: 'Number of bytes for the parameter group, in- cluding this field'
      - id: param_group_type
        type: u1
        doc: '0x80'
  login_response_v_2_message:
    seq:
      - id: login_response_status
        type: u1
        enum: login_response_status
        doc: 'Accepted, or the reason for the rejection. A = Login Accepted N = Not authorized (invalid user- name/password) D = Session is disabled B = Session in use S = Invalid session Q = Sequence ahead in Login message I = Invalid unit given in Login message F = Invalid return bitfield in login message M = Invalid Login Request message structure'
      - id: login_response_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional informa- tion about the reason for rejection. For suc- cessful logins, this is empty. ASCII NUL (0x00) filled on the right, if necessary'
      - id: no_unspecified_unit_replay
        type: u1
        doc: 'Echoed back from the original Login Request V2 message'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Participant to Cboe) message se- quence number processed by Cboe'
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
        doc: 'Highest available Cboe to Participant sequence number for the unit'
  logout_message:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'The reason why the Logout message was sent. U = User Requested E = End of Day A = Administrative ! = Protocol Violation'
      - id: logout_reason_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human-readable text with additional informa- tion about the reason for logout. Particularly useful if LogoutReason = ! (Protocol Viola- tion)'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Participant to Cboe) message se- quence number processed by Cboe'
      - id: num_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: units
        type: units
        repeat: expr
        repeat-expr: num_units
        doc: 'Repeating group stated NumberOfUnits times'
  new_order_v_2_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: number_of_new_order_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_order_v_2_bitfield_1
        type: new_order_v_2_bitfield_1
        if: number_of_new_order_v_2_bitfields >= 1
        doc: 'BitSet NewOrderV2 byte 1'
      - id: new_order_v_2_bitfield_2
        type: new_order_v_2_bitfield_2
        if: number_of_new_order_v_2_bitfields >= 2
        doc: 'BitSet NewOrderV2 byte 2'
      - id: new_order_v_2_bitfield_3
        type: new_order_v_2_bitfield_3
        if: number_of_new_order_v_2_bitfields >= 3
        doc: 'BitSet NewOrderV2 byte 3'
      - id: new_order_v_2_bitfield_4
        type: new_order_v_2_bitfield_4
        if: number_of_new_order_v_2_bitfields >= 4
        doc: 'BitSet NewOrderV2 byte 4'
      - id: new_order_v_2_bitfield_5
        type: new_order_v_2_bitfield_5
        if: number_of_new_order_v_2_bitfields >= 5
        doc: 'BitSet NewOrderV2 byte 5'
      - id: new_order_v_2_bitfield_6
        type: new_order_v_2_bitfield_6
        if: number_of_new_order_v_2_bitfields >= 6
        doc: 'BitSet NewOrderV2 byte 6'
      - id: new_order_v_2_bitfield_7
        type: new_order_v_2_bitfield_7
        if: number_of_new_order_v_2_bitfields >= 7
        doc: 'BitSet NewOrderV2 byte 7'
      - id: new_order_v_2_bitfield_8
        type: new_order_v_2_bitfield_8
        if: number_of_new_order_v_2_bitfields >= 8
        doc: 'BitSet NewOrderV2 byte 8'
      - id: new_order_v_2_bitfield_9
        type: new_order_v_2_bitfield_9
        if: number_of_new_order_v_2_bitfields >= 9
        doc: 'BitSet NewOrderV2 byte 9'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_clearing_account > 0
      - id: price
        type: decimal_s8_4
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_min_qty > 0
      - id: max_floor
        type: u4
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_max_floor > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_capacity > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_routing_inst > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_display_indicator > 0
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_prevent_match > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 4 and new_order_v_2_bitfield_4.new_order_v_2_bitfield_4_risk_reset > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_new_order_v_2_bitfields >= 4 and new_order_v_2_bitfield_4.new_order_v_2_bitfield_4_liquidity_provision > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_ext_exec_inst > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_algorithmic_indicator > 0
      - id: custom_group_id
        type: u2
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_custom_group_id > 0
      - id: client_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_client_qualified_role > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_executor_qualified_role > 0
  new_order_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_1_clearing_firm
        type: b1
      - id: new_order_v_2_bitfield_1_clearing_account
        type: b1
      - id: new_order_v_2_bitfield_1_price
        type: b1
      - id: new_order_v_2_bitfield_1_exec_inst
        type: b1
      - id: new_order_v_2_bitfield_1_ord_type
        type: b1
      - id: new_order_v_2_bitfield_1_time_in_force
        type: b1
      - id: new_order_v_2_bitfield_1_min_qty
        type: b1
      - id: new_order_v_2_bitfield_1_max_floor
        type: b1
  new_order_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_2_symbol
        type: b1
      - id: new_order_v_2_bitfield_2_symbol_sfx
        type: b1
      - id: new_order_v_2_bitfield_2_currency
        type: b1
      - id: new_order_v_2_bitfield_2_id_source
        type: b1
      - id: new_order_v_2_bitfield_2_security_id
        type: b1
      - id: new_order_v_2_bitfield_2_security_exchange
        type: b1
      - id: new_order_v_2_bitfield_2_capacity
        type: b1
      - id: new_order_v_2_bitfield_2_routing_inst
        type: b1
  new_order_v_2_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_3_account
        type: b1
      - id: new_order_v_2_bitfield_3_display_indicator
        type: b1
      - id: new_order_v_2_bitfield_3_max_remove_pct
        type: b1
      - id: new_order_v_2_bitfield_3_discretion_amount
        type: b1
      - id: new_order_v_2_bitfield_3_peg_difference
        type: b1
      - id: new_order_v_2_bitfield_3_prevent_match
        type: b1
      - id: new_order_v_2_bitfield_3_locate_required
        type: b1
      - id: new_order_v_2_bitfield_3_expire_time
        type: b1
  new_order_v_2_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_4_maturity_date
        type: b1
      - id: new_order_v_2_bitfield_4_strike_price
        type: b1
      - id: new_order_v_2_bitfield_4_put_or_call
        type: b1
      - id: new_order_v_2_bitfield_4_risk_reset
        type: b1
      - id: new_order_v_2_bitfield_4_open_close
        type: b1
      - id: new_order_v_2_bitfield_4_cmta_number
        type: b1
      - id: new_order_v_2_bitfield_4_target_party_id
        type: b1
      - id: new_order_v_2_bitfield_4_liquidity_provision
        type: b1
  new_order_v_2_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_5_reserved_1
        type: b1
      - id: new_order_v_2_bitfield_5_attributed_quote
        type: b1
      - id: new_order_v_2_bitfield_5_booking_type
        type: b1
      - id: new_order_v_2_bitfield_5_ext_exec_inst
        type: b1
      - id: new_order_v_2_bitfield_5_client_id
        type: b1
      - id: new_order_v_2_bitfield_5_investor_id
        type: b1
      - id: new_order_v_2_bitfield_5_executor_id
        type: b1
      - id: new_order_v_2_bitfield_5_order_origination
        type: b1
  new_order_v_2_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_6_display_range
        type: b1
      - id: new_order_v_2_bitfield_6_stop_px
        type: b1
      - id: new_order_v_2_bitfield_6_rout_strategy
        type: b1
      - id: new_order_v_2_bitfield_6_route_delivery_method
        type: b1
      - id: new_order_v_2_bitfield_6_ex_destination
        type: b1
      - id: new_order_v_2_bitfield_6_echo_text
        type: b1
      - id: new_order_v_2_bitfield_6_auction_id
        type: b1
      - id: new_order_v_2_bitfield_6_routing_firm_id
        type: b1
  new_order_v_2_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_7_algorithmic_indicator
        type: b1
      - id: new_order_v_2_bitfield_7_custom_group_id
        type: b1
      - id: new_order_v_2_bitfield_7_client_qualified_role
        type: b1
      - id: new_order_v_2_bitfield_7_investor_qualified_role
        type: b1
      - id: new_order_v_2_bitfield_7_executor_qualified_role
        type: b1
      - id: new_order_v_2_bitfield_7_cti_code
        type: b1
      - id: new_order_v_2_bitfield_7_manual_order_indicator
        type: b1
      - id: new_order_v_2_bitfield_7_operator_id
        type: b1
  new_order_v_2_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_8_quote_room_id
        type: b1
      - id: new_order_v_2_bitfield_8_si_indicator
        type: b1
      - id: new_order_v_2_bitfield_8_clearing_optional_data
        type: b1
      - id: new_order_v_2_bitfield_8_client_id_attr
        type: b1
      - id: new_order_v_2_bitfield_8_frequent_trader_id
        type: b1
      - id: new_order_v_2_bitfield_8_compression
        type: b1
      - id: new_order_v_2_bitfield_8_floor_destination
        type: b1
      - id: new_order_v_2_bitfield_8_floor_routing_inst
        type: b1
  new_order_v_2_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: new_order_v_2_bitfield_9_order_origin
        type: b1
      - id: new_order_v_2_bitfield_9_ors
        type: b1
      - id: new_order_v_2_bitfield_9_price_type
        type: b1
      - id: new_order_v_2_bitfield_9_trading_session_id
        type: b1
      - id: new_order_v_2_bitfield_9_cust_order_handling_inst
        type: b1
      - id: new_order_v_2_bitfield_9_account_type
        type: b1
      - id: new_order_v_2_bitfield_9_cross_trade_flag
        type: b1
      - id: new_order_v_2_bitfield_9_drill_thru_protection
        type: b1
  cancel_order_v_2_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: number_of_cancel_order_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: cancel_order_v_2_bitfield_1
        type: cancel_order_v_2_bitfield_1
        if: number_of_cancel_order_v_2_bitfields >= 1
        doc: 'BitSet CancelOrderV2 byte 1'
      - id: cancel_order_v_2_bitfield_2
        type: cancel_order_v_2_bitfield_2
        if: number_of_cancel_order_v_2_bitfields >= 2
        doc: 'BitSet CancelOrderV2 byte 2'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_cancel_order_v_2_bitfields >= 1 and cancel_order_v_2_bitfield_1.cancel_order_v_2_bitfield_1_clearing_firm > 0
  cancel_order_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_v_2_bitfield_1_clearing_firm
        type: b1
      - id: cancel_order_v_2_bitfield_1_mass_cancel_lockout
        type: b1
      - id: cancel_order_v_2_bitfield_1_mass_cancel
        type: b1
      - id: cancel_order_v_2_bitfield_1_underlying
        type: b1
      - id: cancel_order_v_2_bitfield_1_mass_cancel_id
        type: b1
      - id: cancel_order_v_2_bitfield_1_routing_firm_id
        type: b1
      - id: cancel_order_v_2_bitfield_1_manual_order_indicator
        type: b1
      - id: cancel_order_v_2_bitfield_1_operator_id
        type: b1
  cancel_order_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_v_2_bitfield_2_mass_cancel_inst
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_2
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_4
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_8
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_16
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_32
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_64
        type: b1
      - id: cancel_order_v_2_bitfield_2_reserved_128
        type: b1
  modify_order_v_2_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: number_of_modify_order_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: modify_order_v_2_bitfield_1
        type: modify_order_v_2_bitfield_1
        if: number_of_modify_order_v_2_bitfields >= 1
        doc: 'BitSet ModifyOrderV2 byte 1'
      - id: modify_order_v_2_bitfield_2
        type: modify_order_v_2_bitfield_2
        if: number_of_modify_order_v_2_bitfields >= 2
        doc: 'BitSet ModifyOrderV2 byte 2'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_clearing_firm > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_ord_type > 0
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_cancel_orig_on_reject > 0
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_exec_inst > 0
  modify_order_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_v_2_bitfield_1_clearing_firm
        type: b1
      - id: modify_order_v_2_bitfield_1_expire_time
        type: b1
      - id: modify_order_v_2_bitfield_1_order_qty
        type: b1
      - id: modify_order_v_2_bitfield_1_price
        type: b1
      - id: modify_order_v_2_bitfield_1_ord_type
        type: b1
      - id: modify_order_v_2_bitfield_1_cancel_orig_on_reject
        type: b1
      - id: modify_order_v_2_bitfield_1_exec_inst
        type: b1
      - id: modify_order_v_2_bitfield_1_side
        type: b1
  modify_order_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_v_2_bitfield_2_max_floor
        type: b1
      - id: modify_order_v_2_bitfield_2_stop_px
        type: b1
      - id: modify_order_v_2_bitfield_2_routing_firm_id
        type: b1
      - id: modify_order_v_2_bitfield_2_manual_order_indicator
        type: b1
      - id: modify_order_v_2_bitfield_2_operator_id
        type: b1
      - id: modify_order_v_2_bitfield_2_frequent_trader_id
        type: b1
      - id: modify_order_v_2_bitfield_2_cust_order_handling_inst
        type: b1
      - id: modify_order_v_2_bitfield_2_reserved_128
        type: b1
  purge_orders_v_2_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_purge_orders_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: purge_orders_v_2_bitfield_1
        type: purge_orders_v_2_bitfield_1
        if: number_of_purge_orders_v_2_bitfields >= 1
        doc: 'BitSet PurgeOrdersV2 byte 1'
      - id: purge_orders_v_2_bitfield_2
        type: purge_orders_v_2_bitfield_2
        if: number_of_purge_orders_v_2_bitfields >= 2
        doc: 'BitSet PurgeOrdersV2 byte 2'
      - id: num_custom_group_ids
        type: u1
        doc: 'Number of repeating CustomGroupId included in this message'
      - id: custom_group_ids
        type: custom_group_ids
        repeat: expr
        repeat-expr: num_custom_group_ids
        doc: 'Repeating group stated CustomGroupIdCnt times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 1 and purge_orders_v_2_bitfield_1.purge_orders_v_2_bitfield_1_clearing_firm > 0
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 1 and purge_orders_v_2_bitfield_1.purge_orders_v_2_bitfield_1_mass_cancel_inst > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 1 and purge_orders_v_2_bitfield_1.purge_orders_v_2_bitfield_1_mass_cancel_id > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 2 and purge_orders_v_2_bitfield_2.purge_orders_v_2_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 2 and purge_orders_v_2_bitfield_2.purge_orders_v_2_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_purge_orders_v_2_bitfields >= 2 and purge_orders_v_2_bitfield_2.purge_orders_v_2_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 2 and purge_orders_v_2_bitfield_2.purge_orders_v_2_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_orders_v_2_bitfields >= 2 and purge_orders_v_2_bitfield_2.purge_orders_v_2_bitfield_2_security_exchange > 0
  purge_orders_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_orders_v_2_bitfield_1_clearing_firm
        type: b1
      - id: purge_orders_v_2_bitfield_1_mass_cancel_lockout
        type: b1
      - id: purge_orders_v_2_bitfield_1_mass_cancel_inst
        type: b1
      - id: purge_orders_v_2_bitfield_1_osi_root
        type: b1
      - id: purge_orders_v_2_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_orders_v_2_bitfield_1_routing_firm_id
        type: b1
      - id: purge_orders_v_2_bitfield_1_manual_order_indicator
        type: b1
      - id: purge_orders_v_2_bitfield_1_operator_id
        type: b1
  purge_orders_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_orders_v_2_bitfield_2_symbol
        type: b1
      - id: purge_orders_v_2_bitfield_2_symbol_sfx
        type: b1
      - id: purge_orders_v_2_bitfield_2_currency
        type: b1
      - id: purge_orders_v_2_bitfield_2_id_source
        type: b1
      - id: purge_orders_v_2_bitfield_2_security_id
        type: b1
      - id: purge_orders_v_2_bitfield_2_security_exchange
        type: b1
      - id: purge_orders_v_2_bitfield_2_reserved_64
        type: b1
      - id: purge_orders_v_2_bitfield_2_reserved_128
        type: b1
  custom_group_ids:
    seq:
      - id: custom_group_id
        type: u2
  trade_capture_report_v_2_message:
    seq:
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-7'
      - id: number_of_trade_capture_report_v_2_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_v_2_bitfield_1
        type: trade_capture_report_v_2_bitfield_1
        if: number_of_trade_capture_report_v_2_bitfields >= 1
        doc: 'BitSet TradeCaptureReportV2 byte 1'
      - id: trade_capture_report_v_2_bitfield_2
        type: trade_capture_report_v_2_bitfield_2
        if: number_of_trade_capture_report_v_2_bitfields >= 2
        doc: 'BitSet TradeCaptureReportV2 byte 2'
      - id: trade_capture_report_v_2_bitfield_3
        type: trade_capture_report_v_2_bitfield_3
        if: number_of_trade_capture_report_v_2_bitfields >= 3
        doc: 'BitSet TradeCaptureReportV2 byte 3'
      - id: trade_capture_report_v_2_bitfield_4
        type: trade_capture_report_v_2_bitfield_4
        if: number_of_trade_capture_report_v_2_bitfields >= 4
        doc: 'BitSet TradeCaptureReportV2 byte 4'
      - id: trade_capture_report_v_2_bitfield_5
        type: trade_capture_report_v_2_bitfield_5
        if: number_of_trade_capture_report_v_2_bitfields >= 5
        doc: 'BitSet TradeCaptureReportV2 byte 5'
      - id: trade_capture_report_v_2_bitfield_6
        type: trade_capture_report_v_2_bitfield_6
        if: number_of_trade_capture_report_v_2_bitfields >= 6
        doc: 'BitSet TradeCaptureReportV2 byte 6'
      - id: num_trd_cap_rpt_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trd_cap_rpt_side_grp
        type: trd_cap_rpt_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_rpt_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_security_exchange > 0
      - id: transaction_category
        type: u1
        enum: transaction_category
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_transaction_category > 0
      - id: trade_time
        type: nanosecond_timestamp
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_report_trans_type > 0
      - id: trade_id
        type: u8
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_id > 0
      - id: venue_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_venue_type > 0
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trading_session_sub_id > 0
      - id: match_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_match_type > 0
      - id: trd_sub_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trd_sub_type > 0
      - id: secondary_trd_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_secondary_trd_type > 0
      - id: trade_price_condition
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trade_price_condition > 0
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trade_publish_indicator > 0
      - id: large_size
        type: u8
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_large_size > 0
      - id: execution_method
        type: u1
        enum: execution_method
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_execution_method > 0
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_report_type > 0
      - id: trade_handling_instruction
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_handling_instruction > 0
      - id: trade_link_id
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_link_id > 0
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_report_ref_id > 0
      - id: gross_trade_amt
        type: decimal_s8_4
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_gross_trade_amt > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: tolerance
        type: u2
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_tolerance > 0
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_order_category > 0
      - id: settlement_price
        type: decimal_u8_7
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_settlement_price > 0
        doc: 'Implied decimal with scale 1e-7'
      - id: settlement_date
        type: nanosecond_timestamp
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_settlement_date > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_algorithmic_indicator > 0
      - id: settlement_currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_settlement_currency > 0
      - id: settlement_location
        type: str
        size: 2
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_settlement_location > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_intra_firm_trade_ind > 0
      - id: tertiary_trd_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_tertiary_trd_type > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_account > 0
      - id: party_role
        type: u1
        enum: party_role
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  trade_capture_report_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_1_symbol
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_reserved_2
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_currency
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_id_source
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_security_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_security_exchange
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_last_mkt
        type: b1
      - id: trade_capture_report_v_2_bitfield_1_reserved_128
        type: b1
  trade_capture_report_v_2_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_account
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_transaction_category
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_time
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_party_role
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_report_trans_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_trade_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_2_venue_type
        type: b1
  trade_capture_report_v_2_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_3_trading_session_sub_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_match_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trd_sub_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_secondary_trd_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trade_price_condition
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_trade_publish_indicator
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_large_size
        type: b1
      - id: trade_capture_report_v_2_bitfield_3_execution_method
        type: b1
  trade_capture_report_v_2_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_4_trade_report_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_handling_instruction
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_link_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_trade_report_ref_id
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_gross_trade_amt
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_tolerance
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_order_category
        type: b1
      - id: trade_capture_report_v_2_bitfield_4_settlement_price
        type: b1
  trade_capture_report_v_2_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_5_settlement_date
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_price_formation
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_algorithmic_indicator
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_waiver_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_deferral_reason
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_settlement_currency
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_settlement_location
        type: b1
      - id: trade_capture_report_v_2_bitfield_5_third_party
        type: b1
  trade_capture_report_v_2_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_v_2_bitfield_6_cust_order_handling_inst
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_open_close
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_account_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_multi_juris_reporting_ind
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_tertiary_trd_type
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_64
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_128
        type: b1
  trd_cap_rpt_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: party_role
        type: u1
        enum: party_role
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  order_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_acknowledgment_v_2_return_bitfield_1
        type: order_acknowledgment_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderAcknowledgmentV2 byte 1'
      - id: order_acknowledgment_v_2_return_bitfield_2
        type: order_acknowledgment_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderAcknowledgmentV2 byte 2'
      - id: order_acknowledgment_v_2_return_bitfield_3
        type: order_acknowledgment_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderAcknowledgmentV2 byte 3'
      - id: order_acknowledgment_v_2_return_bitfield_4
        type: order_acknowledgment_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderAcknowledgmentV2 byte 4'
      - id: order_acknowledgment_v_2_return_bitfield_5
        type: order_acknowledgment_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderAcknowledgmentV2 byte 5'
      - id: order_acknowledgment_v_2_return_bitfield_6
        type: order_acknowledgment_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderAcknowledgmentV2 byte 6'
      - id: order_acknowledgment_v_2_return_bitfield_7
        type: order_acknowledgment_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderAcknowledgmentV2 byte 7'
      - id: order_acknowledgment_v_2_return_bitfield_8
        type: order_acknowledgment_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderAcknowledgmentV2 byte 8'
      - id: order_acknowledgment_v_2_return_bitfield_9
        type: order_acknowledgment_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderAcknowledgmentV2 byte 9'
      - id: order_acknowledgment_v_2_return_bitfield_10
        type: order_acknowledgment_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderAcknowledgmentV2 byte 10'
      - id: order_acknowledgment_v_2_return_bitfield_11
        type: order_acknowledgment_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderAcknowledgmentV2 byte 11'
      - id: order_acknowledgment_v_2_return_bitfield_12
        type: order_acknowledgment_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderAcknowledgmentV2 byte 12'
      - id: order_acknowledgment_v_2_return_bitfield_13
        type: order_acknowledgment_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderAcknowledgmentV2 byte 13'
      - id: order_acknowledgment_v_2_return_bitfield_14
        type: order_acknowledgment_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderAcknowledgmentV2 byte 14'
      - id: order_acknowledgment_v_2_return_bitfield_15
        type: order_acknowledgment_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderAcknowledgmentV2 byte 15'
      - id: order_acknowledgment_v_2_return_bitfield_16
        type: order_acknowledgment_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderAcknowledgmentV2 byte 16'
      - id: order_acknowledgment_v_2_return_bitfield_17
        type: order_acknowledgment_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderAcknowledgmentV2 byte 17'
      - id: order_acknowledgment_v_2_return_bitfield_18
        type: order_acknowledgment_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgmentV2 byte 18'
      - id: order_acknowledgment_v_2_return_bitfield_19
        type: order_acknowledgment_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgmentV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_min_qty > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_acknowledgment_v_2_return_bitfield_6.order_acknowledgment_v_2_return_bitfield_6_secondary_order_id > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and order_acknowledgment_v_2_return_bitfield_6.order_acknowledgment_v_2_return_bitfield_6_ext_exec_inst > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and order_acknowledgment_v_2_return_bitfield_7.order_acknowledgment_v_2_return_bitfield_7_sub_liquidity_indicator > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_acknowledgment_v_2_return_bitfield_9.order_acknowledgment_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and order_acknowledgment_v_2_return_bitfield_10.order_acknowledgment_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_acknowledgment_v_2_return_bitfield_10.order_acknowledgment_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_executor_qualified_role > 0
  order_acknowledgment_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_1_side
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_acknowledgment_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_currency
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_2_contra_trader
        type: b1
  order_acknowledgment_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_3_account
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_3_prevent_match
        type: b1
  order_acknowledgment_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_4_access_fee
        type: b1
  order_acknowledgment_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_5_expire_time
        type: b1
  order_acknowledgment_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_6_party_role
        type: b1
  order_acknowledgment_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_text
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_bid
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_offer
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_7_last_mkt
        type: b1
  order_acknowledgment_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_acknowledgment_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_acknowledgment_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_acknowledgment_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_acknowledgment_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_acknowledgment_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_acknowledgment_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_username
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_14_user_status
        type: b1
  order_acknowledgment_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_acknowledgment_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_compression
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_16_order_origin
        type: b1
  order_acknowledgment_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_acknowledgment_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_acknowledgment_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_19_reserved_128
        type: b1
  order_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_rejected_v_2_return_bitfield_1
        type: order_rejected_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderRejectedV2 byte 1'
      - id: order_rejected_v_2_return_bitfield_2
        type: order_rejected_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderRejectedV2 byte 2'
      - id: order_rejected_v_2_return_bitfield_3
        type: order_rejected_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderRejectedV2 byte 3'
      - id: order_rejected_v_2_return_bitfield_4
        type: order_rejected_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderRejectedV2 byte 4'
      - id: order_rejected_v_2_return_bitfield_5
        type: order_rejected_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderRejectedV2 byte 5'
      - id: order_rejected_v_2_return_bitfield_6
        type: order_rejected_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderRejectedV2 byte 6'
      - id: order_rejected_v_2_return_bitfield_7
        type: order_rejected_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderRejectedV2 byte 7'
      - id: order_rejected_v_2_return_bitfield_8
        type: order_rejected_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderRejectedV2 byte 8'
      - id: order_rejected_v_2_return_bitfield_9
        type: order_rejected_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderRejectedV2 byte 9'
      - id: order_rejected_v_2_return_bitfield_10
        type: order_rejected_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderRejectedV2 byte 10'
      - id: order_rejected_v_2_return_bitfield_11
        type: order_rejected_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderRejectedV2 byte 11'
      - id: order_rejected_v_2_return_bitfield_12
        type: order_rejected_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderRejectedV2 byte 12'
      - id: order_rejected_v_2_return_bitfield_13
        type: order_rejected_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderRejectedV2 byte 13'
      - id: order_rejected_v_2_return_bitfield_14
        type: order_rejected_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderRejectedV2 byte 14'
      - id: order_rejected_v_2_return_bitfield_15
        type: order_rejected_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderRejectedV2 byte 15'
      - id: order_rejected_v_2_return_bitfield_16
        type: order_rejected_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderRejectedV2 byte 16'
      - id: order_rejected_v_2_return_bitfield_17
        type: order_rejected_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderRejectedV2 byte 17'
      - id: order_rejected_v_2_return_bitfield_18
        type: order_rejected_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderRejectedV2 byte 18'
      - id: order_rejected_v_2_return_bitfield_19
        type: order_rejected_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderRejectedV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_prevent_match > 0
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_rejected_v_2_return_bitfield_6.order_rejected_v_2_return_bitfield_6_secondary_order_id > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_rejected_v_2_return_bitfield_9.order_rejected_v_2_return_bitfield_9_liquidity_provision > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_rejected_v_2_return_bitfield_10.order_rejected_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_executor_qualified_role > 0
  order_rejected_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_1_side
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_rejected_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_currency
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_rejected_v_2_return_bitfield_2_contra_trader
        type: b1
  order_rejected_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_3_account
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_3_prevent_match
        type: b1
  order_rejected_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_4_access_fee
        type: b1
  order_rejected_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_5_expire_time
        type: b1
  order_rejected_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_rejected_v_2_return_bitfield_6_party_role
        type: b1
  order_rejected_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_text
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_bid
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_offer
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_rejected_v_2_return_bitfield_7_last_mkt
        type: b1
  order_rejected_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_rejected_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_rejected_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_rejected_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_rejected_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_rejected_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_rejected_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_rejected_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_rejected_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_rejected_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_rejected_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_rejected_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_username
        type: b1
      - id: order_rejected_v_2_return_bitfield_14_user_status
        type: b1
  order_rejected_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_rejected_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_rejected_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_compression
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_rejected_v_2_return_bitfield_16_order_origin
        type: b1
  order_rejected_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_rejected_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_rejected_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_rejected_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_rejected_v_2_return_bitfield_19_reserved_128
        type: b1
  order_modified_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_modified_v_2_return_bitfield_1
        type: order_modified_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderModifiedV2 byte 1'
      - id: order_modified_v_2_return_bitfield_2
        type: order_modified_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderModifiedV2 byte 2'
      - id: order_modified_v_2_return_bitfield_3
        type: order_modified_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderModifiedV2 byte 3'
      - id: order_modified_v_2_return_bitfield_4
        type: order_modified_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderModifiedV2 byte 4'
      - id: order_modified_v_2_return_bitfield_5
        type: order_modified_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderModifiedV2 byte 5'
      - id: order_modified_v_2_return_bitfield_6
        type: order_modified_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderModifiedV2 byte 6'
      - id: order_modified_v_2_return_bitfield_7
        type: order_modified_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderModifiedV2 byte 7'
      - id: order_modified_v_2_return_bitfield_8
        type: order_modified_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderModifiedV2 byte 8'
      - id: order_modified_v_2_return_bitfield_9
        type: order_modified_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderModifiedV2 byte 9'
      - id: order_modified_v_2_return_bitfield_10
        type: order_modified_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderModifiedV2 byte 10'
      - id: order_modified_v_2_return_bitfield_11
        type: order_modified_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderModifiedV2 byte 11'
      - id: order_modified_v_2_return_bitfield_12
        type: order_modified_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderModifiedV2 byte 12'
      - id: order_modified_v_2_return_bitfield_13
        type: order_modified_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderModifiedV2 byte 13'
      - id: order_modified_v_2_return_bitfield_14
        type: order_modified_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderModifiedV2 byte 14'
      - id: order_modified_v_2_return_bitfield_15
        type: order_modified_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderModifiedV2 byte 15'
      - id: order_modified_v_2_return_bitfield_16
        type: order_modified_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderModifiedV2 byte 16'
      - id: order_modified_v_2_return_bitfield_17
        type: order_modified_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderModifiedV2 byte 17'
      - id: order_modified_v_2_return_bitfield_18
        type: order_modified_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderModifiedV2 byte 18'
      - id: order_modified_v_2_return_bitfield_19
        type: order_modified_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderModifiedV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_min_qty > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_modified_v_2_return_bitfield_6.order_modified_v_2_return_bitfield_6_secondary_order_id > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and order_modified_v_2_return_bitfield_6.order_modified_v_2_return_bitfield_6_ext_exec_inst > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_modified_v_2_return_bitfield_9.order_modified_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and order_modified_v_2_return_bitfield_10.order_modified_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_modified_v_2_return_bitfield_10.order_modified_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_executor_qualified_role > 0
  order_modified_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_1_side
        type: b1
      - id: order_modified_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_modified_v_2_return_bitfield_1_price
        type: b1
      - id: order_modified_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_modified_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_modified_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_modified_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_modified_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_modified_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_modified_v_2_return_bitfield_2_currency
        type: b1
      - id: order_modified_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_modified_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_modified_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_modified_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_modified_v_2_return_bitfield_2_contra_trader
        type: b1
  order_modified_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_3_account
        type: b1
      - id: order_modified_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_modified_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_modified_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_modified_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_modified_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_3_prevent_match
        type: b1
  order_modified_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_modified_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_modified_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_modified_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_modified_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_modified_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_modified_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_modified_v_2_return_bitfield_4_access_fee
        type: b1
  order_modified_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_modified_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_modified_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_modified_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_modified_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_modified_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_5_expire_time
        type: b1
  order_modified_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_modified_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_modified_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_modified_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_modified_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_modified_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_modified_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_modified_v_2_return_bitfield_6_party_role
        type: b1
  order_modified_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_modified_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_modified_v_2_return_bitfield_7_text
        type: b1
      - id: order_modified_v_2_return_bitfield_7_bid
        type: b1
      - id: order_modified_v_2_return_bitfield_7_offer
        type: b1
      - id: order_modified_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_modified_v_2_return_bitfield_7_last_mkt
        type: b1
  order_modified_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_modified_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_modified_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_modified_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_modified_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_modified_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_modified_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_modified_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_modified_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_modified_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_modified_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_modified_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_modified_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_modified_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_modified_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_modified_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_modified_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_modified_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_modified_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_modified_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_modified_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_modified_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_modified_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_modified_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_modified_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_modified_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_modified_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_modified_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_modified_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_modified_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_modified_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_modified_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_modified_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_modified_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_modified_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_modified_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_modified_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_modified_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_modified_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_modified_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_modified_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_modified_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_modified_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_modified_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_modified_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_modified_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_modified_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_modified_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_modified_v_2_return_bitfield_14_username
        type: b1
      - id: order_modified_v_2_return_bitfield_14_user_status
        type: b1
  order_modified_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_modified_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_modified_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_modified_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_modified_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_modified_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_modified_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_modified_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_modified_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_modified_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_modified_v_2_return_bitfield_16_compression
        type: b1
      - id: order_modified_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_modified_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_modified_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_modified_v_2_return_bitfield_16_order_origin
        type: b1
  order_modified_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_modified_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_modified_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_modified_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_modified_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_modified_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_modified_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_modified_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_modified_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_modified_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_modified_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_modified_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_modified_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_modified_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_modified_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_modified_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_modified_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_modified_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_modified_v_2_return_bitfield_19_reserved_128
        type: b1
  order_restated_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. R = Reroute X = Locked in cross W = Wash L = Reload Q = Liquidity Updated Cboe reserves the right to add new values as necessary without prior notice'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_restated_v_2_return_bitfield_1
        type: order_restated_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderRestatedV2 byte 1'
      - id: order_restated_v_2_return_bitfield_2
        type: order_restated_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderRestatedV2 byte 2'
      - id: order_restated_v_2_return_bitfield_3
        type: order_restated_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderRestatedV2 byte 3'
      - id: order_restated_v_2_return_bitfield_4
        type: order_restated_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderRestatedV2 byte 4'
      - id: order_restated_v_2_return_bitfield_5
        type: order_restated_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderRestatedV2 byte 5'
      - id: order_restated_v_2_return_bitfield_6
        type: order_restated_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderRestatedV2 byte 6'
      - id: order_restated_v_2_return_bitfield_7
        type: order_restated_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderRestatedV2 byte 7'
      - id: order_restated_v_2_return_bitfield_8
        type: order_restated_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderRestatedV2 byte 8'
      - id: order_restated_v_2_return_bitfield_9
        type: order_restated_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderRestatedV2 byte 9'
      - id: order_restated_v_2_return_bitfield_10
        type: order_restated_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderRestatedV2 byte 10'
      - id: order_restated_v_2_return_bitfield_11
        type: order_restated_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderRestatedV2 byte 11'
      - id: order_restated_v_2_return_bitfield_12
        type: order_restated_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderRestatedV2 byte 12'
      - id: order_restated_v_2_return_bitfield_13
        type: order_restated_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderRestatedV2 byte 13'
      - id: order_restated_v_2_return_bitfield_14
        type: order_restated_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderRestatedV2 byte 14'
      - id: order_restated_v_2_return_bitfield_15
        type: order_restated_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderRestatedV2 byte 15'
      - id: order_restated_v_2_return_bitfield_16
        type: order_restated_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderRestatedV2 byte 16'
      - id: order_restated_v_2_return_bitfield_17
        type: order_restated_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderRestatedV2 byte 17'
      - id: order_restated_v_2_return_bitfield_18
        type: order_restated_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderRestatedV2 byte 18'
      - id: order_restated_v_2_return_bitfield_19
        type: order_restated_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderRestatedV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_symbol > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_restated_v_2_return_bitfield_6.order_restated_v_2_return_bitfield_6_secondary_order_id > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and order_restated_v_2_return_bitfield_6.order_restated_v_2_return_bitfield_6_ext_exec_inst > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_restated_v_2_return_bitfield_9.order_restated_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and order_restated_v_2_return_bitfield_10.order_restated_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_restated_v_2_return_bitfield_10.order_restated_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_executor_qualified_role > 0
  order_restated_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_1_side
        type: b1
      - id: order_restated_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_restated_v_2_return_bitfield_1_price
        type: b1
      - id: order_restated_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_restated_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_restated_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_restated_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_restated_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_restated_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_restated_v_2_return_bitfield_2_currency
        type: b1
      - id: order_restated_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_restated_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_restated_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_restated_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_restated_v_2_return_bitfield_2_contra_trader
        type: b1
  order_restated_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_3_account
        type: b1
      - id: order_restated_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_restated_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_restated_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_restated_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_restated_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_3_prevent_match
        type: b1
  order_restated_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_restated_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_restated_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_restated_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_restated_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_restated_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_restated_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_restated_v_2_return_bitfield_4_access_fee
        type: b1
  order_restated_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_restated_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_restated_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_restated_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_restated_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_restated_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_5_expire_time
        type: b1
  order_restated_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_restated_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_restated_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_restated_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_restated_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_restated_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_restated_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_restated_v_2_return_bitfield_6_party_role
        type: b1
  order_restated_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_restated_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_restated_v_2_return_bitfield_7_text
        type: b1
      - id: order_restated_v_2_return_bitfield_7_bid
        type: b1
      - id: order_restated_v_2_return_bitfield_7_offer
        type: b1
      - id: order_restated_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_restated_v_2_return_bitfield_7_last_mkt
        type: b1
  order_restated_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_restated_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_restated_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_restated_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_restated_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_restated_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_restated_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_restated_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_restated_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_restated_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_restated_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_restated_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_restated_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_restated_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_restated_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_restated_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_restated_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_restated_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_restated_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_restated_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_restated_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_restated_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_restated_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_restated_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_restated_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_restated_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_restated_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_restated_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_restated_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_restated_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_restated_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_restated_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_restated_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_restated_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_restated_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_restated_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_restated_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_restated_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_restated_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_restated_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_restated_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_restated_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_restated_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_restated_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_restated_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_restated_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_restated_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_restated_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_restated_v_2_return_bitfield_14_username
        type: b1
      - id: order_restated_v_2_return_bitfield_14_user_status
        type: b1
  order_restated_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_restated_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_restated_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_restated_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_restated_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_restated_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_restated_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_restated_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_restated_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_restated_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_restated_v_2_return_bitfield_16_compression
        type: b1
      - id: order_restated_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_restated_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_restated_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_restated_v_2_return_bitfield_16_order_origin
        type: b1
  order_restated_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_restated_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_restated_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_restated_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_restated_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_restated_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_restated_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_restated_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_restated_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_restated_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_restated_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_restated_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_restated_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_restated_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_restated_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_restated_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_restated_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_restated_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_restated_v_2_return_bitfield_19_reserved_128
        type: b1
  user_modify_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: user_modify_rejected_v_2_return_bitfield_1
        type: user_modify_rejected_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet UserModifyRejectedV2 byte 1'
      - id: user_modify_rejected_v_2_return_bitfield_2
        type: user_modify_rejected_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet UserModifyRejectedV2 byte 2'
      - id: user_modify_rejected_v_2_return_bitfield_3
        type: user_modify_rejected_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet UserModifyRejectedV2 byte 3'
      - id: user_modify_rejected_v_2_return_bitfield_4
        type: user_modify_rejected_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet UserModifyRejectedV2 byte 4'
      - id: user_modify_rejected_v_2_return_bitfield_5
        type: user_modify_rejected_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet UserModifyRejectedV2 byte 5'
      - id: user_modify_rejected_v_2_return_bitfield_6
        type: user_modify_rejected_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet UserModifyRejectedV2 byte 6'
      - id: user_modify_rejected_v_2_return_bitfield_7
        type: user_modify_rejected_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet UserModifyRejectedV2 byte 7'
      - id: user_modify_rejected_v_2_return_bitfield_8
        type: user_modify_rejected_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet UserModifyRejectedV2 byte 8'
      - id: user_modify_rejected_v_2_return_bitfield_9
        type: user_modify_rejected_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet UserModifyRejectedV2 byte 9'
      - id: user_modify_rejected_v_2_return_bitfield_10
        type: user_modify_rejected_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet UserModifyRejectedV2 byte 10'
      - id: user_modify_rejected_v_2_return_bitfield_11
        type: user_modify_rejected_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet UserModifyRejectedV2 byte 11'
      - id: user_modify_rejected_v_2_return_bitfield_12
        type: user_modify_rejected_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet UserModifyRejectedV2 byte 12'
      - id: user_modify_rejected_v_2_return_bitfield_13
        type: user_modify_rejected_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet UserModifyRejectedV2 byte 13'
      - id: user_modify_rejected_v_2_return_bitfield_14
        type: user_modify_rejected_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet UserModifyRejectedV2 byte 14'
      - id: user_modify_rejected_v_2_return_bitfield_15
        type: user_modify_rejected_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet UserModifyRejectedV2 byte 15'
      - id: user_modify_rejected_v_2_return_bitfield_16
        type: user_modify_rejected_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet UserModifyRejectedV2 byte 16'
      - id: user_modify_rejected_v_2_return_bitfield_17
        type: user_modify_rejected_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet UserModifyRejectedV2 byte 17'
      - id: user_modify_rejected_v_2_return_bitfield_18
        type: user_modify_rejected_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet UserModifyRejectedV2 byte 18'
      - id: user_modify_rejected_v_2_return_bitfield_19
        type: user_modify_rejected_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet UserModifyRejectedV2 byte 19'
  user_modify_rejected_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_1_side
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_ord_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_min_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_1_max_remove_pct
        type: b1
  user_modify_rejected_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_2_symbol
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_currency
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_id_source
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_security_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_capacity
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_2_contra_trader
        type: b1
  user_modify_rejected_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_3_account
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_max_floor
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_order_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_3_prevent_match
        type: b1
  user_modify_rejected_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_strike_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_open_close
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_party_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_4_access_fee
        type: b1
  user_modify_rejected_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_last_shares
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_last_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_display_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_working_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_5_expire_time
        type: b1
  user_modify_rejected_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_ccp
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_6_party_role
        type: b1
  user_modify_rejected_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_text
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_bid
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_offer
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_large_size
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_7_last_mkt
        type: b1
  user_modify_rejected_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_8_fee_code
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_echo_text
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_stop_px
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  user_modify_rejected_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_auction_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_order_category
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_cross_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_9_cross_prioritization
        type: b1
  user_modify_rejected_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_10_cross_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_price_formation
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_10_client_qualified_role
        type: b1
  user_modify_rejected_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_11_client_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_investor_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_executor_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_order_origination
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  user_modify_rejected_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_12_cti_code
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_operator_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_trade_date
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  user_modify_rejected_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_avg_px
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_pending_status
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  user_modify_rejected_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_username
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_14_user_status
        type: b1
  user_modify_rejected_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_report_time
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_15_client_id_attr
        type: b1
  user_modify_rejected_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_combo_order
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_compression
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_16_order_origin
        type: b1
  user_modify_rejected_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_17_price_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  user_modify_rejected_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_18_account_type
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_subreason
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_leg_price
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  user_modify_rejected_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_19_reserved_128
        type: b1
  order_cancelled_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_cancelled_v_2_return_bitfield_1
        type: order_cancelled_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderCancelledV2 byte 1'
      - id: order_cancelled_v_2_return_bitfield_2
        type: order_cancelled_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderCancelledV2 byte 2'
      - id: order_cancelled_v_2_return_bitfield_3
        type: order_cancelled_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderCancelledV2 byte 3'
      - id: order_cancelled_v_2_return_bitfield_4
        type: order_cancelled_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderCancelledV2 byte 4'
      - id: order_cancelled_v_2_return_bitfield_5
        type: order_cancelled_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderCancelledV2 byte 5'
      - id: order_cancelled_v_2_return_bitfield_6
        type: order_cancelled_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderCancelledV2 byte 6'
      - id: order_cancelled_v_2_return_bitfield_7
        type: order_cancelled_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderCancelledV2 byte 7'
      - id: order_cancelled_v_2_return_bitfield_8
        type: order_cancelled_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderCancelledV2 byte 8'
      - id: order_cancelled_v_2_return_bitfield_9
        type: order_cancelled_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderCancelledV2 byte 9'
      - id: order_cancelled_v_2_return_bitfield_10
        type: order_cancelled_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderCancelledV2 byte 10'
      - id: order_cancelled_v_2_return_bitfield_11
        type: order_cancelled_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderCancelledV2 byte 11'
      - id: order_cancelled_v_2_return_bitfield_12
        type: order_cancelled_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderCancelledV2 byte 12'
      - id: order_cancelled_v_2_return_bitfield_13
        type: order_cancelled_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderCancelledV2 byte 13'
      - id: order_cancelled_v_2_return_bitfield_14
        type: order_cancelled_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderCancelledV2 byte 14'
      - id: order_cancelled_v_2_return_bitfield_15
        type: order_cancelled_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderCancelledV2 byte 15'
      - id: order_cancelled_v_2_return_bitfield_16
        type: order_cancelled_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderCancelledV2 byte 16'
      - id: order_cancelled_v_2_return_bitfield_17
        type: order_cancelled_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderCancelledV2 byte 17'
      - id: order_cancelled_v_2_return_bitfield_18
        type: order_cancelled_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderCancelledV2 byte 18'
      - id: order_cancelled_v_2_return_bitfield_19
        type: order_cancelled_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderCancelledV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_symbol > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_cancelled_v_2_return_bitfield_6.order_cancelled_v_2_return_bitfield_6_secondary_order_id > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and order_cancelled_v_2_return_bitfield_6.order_cancelled_v_2_return_bitfield_6_ext_exec_inst > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_cancelled_v_2_return_bitfield_9.order_cancelled_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and order_cancelled_v_2_return_bitfield_10.order_cancelled_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_cancelled_v_2_return_bitfield_10.order_cancelled_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_executor_qualified_role > 0
  order_cancelled_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_1_side
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_cancelled_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_currency
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_cancelled_v_2_return_bitfield_2_contra_trader
        type: b1
  order_cancelled_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_3_account
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_3_prevent_match
        type: b1
  order_cancelled_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_4_access_fee
        type: b1
  order_cancelled_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_5_expire_time
        type: b1
  order_cancelled_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_cancelled_v_2_return_bitfield_6_party_role
        type: b1
  order_cancelled_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_text
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_bid
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_offer
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_cancelled_v_2_return_bitfield_7_last_mkt
        type: b1
  order_cancelled_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_cancelled_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_cancelled_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_cancelled_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_cancelled_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_cancelled_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_cancelled_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_cancelled_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_cancelled_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_cancelled_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_cancelled_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_cancelled_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_username
        type: b1
      - id: order_cancelled_v_2_return_bitfield_14_user_status
        type: b1
  order_cancelled_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_cancelled_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_cancelled_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_compression
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_cancelled_v_2_return_bitfield_16_order_origin
        type: b1
  order_cancelled_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_cancelled_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_cancelled_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_cancelled_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_cancelled_v_2_return_bitfield_19_reserved_128
        type: b1
  cancel_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason for a cancel rejection. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: cancel_rejected_v_2_return_bitfield_1
        type: cancel_rejected_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet CancelRejectedV2 byte 1'
      - id: cancel_rejected_v_2_return_bitfield_2
        type: cancel_rejected_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet CancelRejectedV2 byte 2'
      - id: cancel_rejected_v_2_return_bitfield_3
        type: cancel_rejected_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet CancelRejectedV2 byte 3'
      - id: cancel_rejected_v_2_return_bitfield_4
        type: cancel_rejected_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet CancelRejectedV2 byte 4'
      - id: cancel_rejected_v_2_return_bitfield_5
        type: cancel_rejected_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet CancelRejectedV2 byte 5'
      - id: cancel_rejected_v_2_return_bitfield_6
        type: cancel_rejected_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet CancelRejectedV2 byte 6'
      - id: cancel_rejected_v_2_return_bitfield_7
        type: cancel_rejected_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet CancelRejectedV2 byte 7'
      - id: cancel_rejected_v_2_return_bitfield_8
        type: cancel_rejected_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet CancelRejectedV2 byte 8'
      - id: cancel_rejected_v_2_return_bitfield_9
        type: cancel_rejected_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet CancelRejectedV2 byte 9'
      - id: cancel_rejected_v_2_return_bitfield_10
        type: cancel_rejected_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet CancelRejectedV2 byte 10'
      - id: cancel_rejected_v_2_return_bitfield_11
        type: cancel_rejected_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet CancelRejectedV2 byte 11'
      - id: cancel_rejected_v_2_return_bitfield_12
        type: cancel_rejected_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet CancelRejectedV2 byte 12'
      - id: cancel_rejected_v_2_return_bitfield_13
        type: cancel_rejected_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet CancelRejectedV2 byte 13'
      - id: cancel_rejected_v_2_return_bitfield_14
        type: cancel_rejected_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet CancelRejectedV2 byte 14'
      - id: cancel_rejected_v_2_return_bitfield_15
        type: cancel_rejected_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet CancelRejectedV2 byte 15'
      - id: cancel_rejected_v_2_return_bitfield_16
        type: cancel_rejected_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet CancelRejectedV2 byte 16'
      - id: cancel_rejected_v_2_return_bitfield_17
        type: cancel_rejected_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet CancelRejectedV2 byte 17'
      - id: cancel_rejected_v_2_return_bitfield_18
        type: cancel_rejected_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet CancelRejectedV2 byte 18'
      - id: cancel_rejected_v_2_return_bitfield_19
        type: cancel_rejected_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet CancelRejectedV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_capacity > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and cancel_rejected_v_2_return_bitfield_9.cancel_rejected_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and cancel_rejected_v_2_return_bitfield_10.cancel_rejected_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and cancel_rejected_v_2_return_bitfield_10.cancel_rejected_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_executor_qualified_role > 0
  cancel_rejected_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_1_side
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_ord_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_min_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_1_max_remove_pct
        type: b1
  cancel_rejected_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_2_symbol
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_currency
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_id_source
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_security_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_capacity
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_2_contra_trader
        type: b1
  cancel_rejected_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_3_account
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_max_floor
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_order_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_3_prevent_match
        type: b1
  cancel_rejected_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_strike_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_open_close
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_party_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_4_access_fee
        type: b1
  cancel_rejected_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_last_shares
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_last_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_display_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_working_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_5_expire_time
        type: b1
  cancel_rejected_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_ccp
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_6_party_role
        type: b1
  cancel_rejected_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_text
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_bid
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_offer
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_large_size
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_7_last_mkt
        type: b1
  cancel_rejected_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_8_fee_code
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_echo_text
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_stop_px
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  cancel_rejected_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_auction_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_order_category
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_cross_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_9_cross_prioritization
        type: b1
  cancel_rejected_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_10_cross_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_price_formation
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_10_client_qualified_role
        type: b1
  cancel_rejected_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_11_client_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_investor_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_executor_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_order_origination
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  cancel_rejected_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_12_cti_code
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_operator_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_trade_date
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  cancel_rejected_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_avg_px
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_pending_status
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  cancel_rejected_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_username
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_14_user_status
        type: b1
  cancel_rejected_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_report_time
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_15_client_id_attr
        type: b1
  cancel_rejected_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_combo_order
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_compression
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_16_order_origin
        type: b1
  cancel_rejected_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_17_price_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  cancel_rejected_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_18_account_type
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_subreason
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_leg_price
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  cancel_rejected_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_19_reserved_128
        type: b1
  order_execution_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be rep- resented on ODROP, FIXDROP and standard DROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
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
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Indicates the market of execution. Markets are identified by their ISO Market Identification Code (MIC)12'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: order_execution_v_2_return_bitfield_1
        type: order_execution_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet OrderExecutionV2 byte 1'
      - id: order_execution_v_2_return_bitfield_2
        type: order_execution_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet OrderExecutionV2 byte 2'
      - id: order_execution_v_2_return_bitfield_3
        type: order_execution_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet OrderExecutionV2 byte 3'
      - id: order_execution_v_2_return_bitfield_4
        type: order_execution_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet OrderExecutionV2 byte 4'
      - id: order_execution_v_2_return_bitfield_5
        type: order_execution_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet OrderExecutionV2 byte 5'
      - id: order_execution_v_2_return_bitfield_6
        type: order_execution_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet OrderExecutionV2 byte 6'
      - id: order_execution_v_2_return_bitfield_7
        type: order_execution_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet OrderExecutionV2 byte 7'
      - id: order_execution_v_2_return_bitfield_8
        type: order_execution_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet OrderExecutionV2 byte 8'
      - id: order_execution_v_2_return_bitfield_9
        type: order_execution_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet OrderExecutionV2 byte 9'
      - id: order_execution_v_2_return_bitfield_10
        type: order_execution_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet OrderExecutionV2 byte 10'
      - id: order_execution_v_2_return_bitfield_11
        type: order_execution_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet OrderExecutionV2 byte 11'
      - id: order_execution_v_2_return_bitfield_12
        type: order_execution_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet OrderExecutionV2 byte 12'
      - id: order_execution_v_2_return_bitfield_13
        type: order_execution_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet OrderExecutionV2 byte 13'
      - id: order_execution_v_2_return_bitfield_14
        type: order_execution_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet OrderExecutionV2 byte 14'
      - id: order_execution_v_2_return_bitfield_15
        type: order_execution_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet OrderExecutionV2 byte 15'
      - id: order_execution_v_2_return_bitfield_16
        type: order_execution_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet OrderExecutionV2 byte 16'
      - id: order_execution_v_2_return_bitfield_17
        type: order_execution_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet OrderExecutionV2 byte 17'
      - id: order_execution_v_2_return_bitfield_18
        type: order_execution_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderExecutionV2 byte 18'
      - id: order_execution_v_2_return_bitfield_19
        type: order_execution_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderExecutionV2 byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_symbol > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_max_floor > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_prevent_match > 0
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_execution_v_2_return_bitfield_6.order_execution_v_2_return_bitfield_6_secondary_order_id > 0
      - id: ext_exec_inst
        type: u1
        enum: ext_exec_inst
        if: number_of_return_bitfields >= 6 and order_execution_v_2_return_bitfield_6.order_execution_v_2_return_bitfield_6_ext_exec_inst > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_execution_v_2_return_bitfield_7.order_execution_v_2_return_bitfield_7_last_mkt > 0
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_v_2_return_bitfield_8.order_execution_v_2_return_bitfield_8_fee_code > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_v_2_return_bitfield_8.order_execution_v_2_return_bitfield_8_routing_inst > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_execution_v_2_return_bitfield_9.order_execution_v_2_return_bitfield_9_liquidity_provision > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and order_execution_v_2_return_bitfield_10.order_execution_v_2_return_bitfield_10_waiver_type > 0
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_execution_v_2_return_bitfield_10.order_execution_v_2_return_bitfield_10_client_qualified_role > 0
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_client_id > 0
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_investor_id > 0
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_executor_id > 0
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_order_origination > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_investor_qualified_role > 0
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_executor_qualified_role > 0
  order_execution_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_1_side
        type: b1
      - id: order_execution_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: order_execution_v_2_return_bitfield_1_price
        type: b1
      - id: order_execution_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: order_execution_v_2_return_bitfield_1_ord_type
        type: b1
      - id: order_execution_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: order_execution_v_2_return_bitfield_1_min_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_1_max_remove_pct
        type: b1
  order_execution_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_2_symbol
        type: b1
      - id: order_execution_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_execution_v_2_return_bitfield_2_currency
        type: b1
      - id: order_execution_v_2_return_bitfield_2_id_source
        type: b1
      - id: order_execution_v_2_return_bitfield_2_security_id
        type: b1
      - id: order_execution_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: order_execution_v_2_return_bitfield_2_capacity
        type: b1
      - id: order_execution_v_2_return_bitfield_2_contra_trader
        type: b1
  order_execution_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_3_account
        type: b1
      - id: order_execution_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: order_execution_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: order_execution_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_3_max_floor
        type: b1
      - id: order_execution_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: order_execution_v_2_return_bitfield_3_order_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_3_prevent_match
        type: b1
  order_execution_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: order_execution_v_2_return_bitfield_4_strike_price
        type: b1
      - id: order_execution_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: order_execution_v_2_return_bitfield_4_open_close
        type: b1
      - id: order_execution_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_execution_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: order_execution_v_2_return_bitfield_4_party_id
        type: b1
      - id: order_execution_v_2_return_bitfield_4_access_fee
        type: b1
  order_execution_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_execution_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_5_last_shares
        type: b1
      - id: order_execution_v_2_return_bitfield_5_last_price
        type: b1
      - id: order_execution_v_2_return_bitfield_5_display_price
        type: b1
      - id: order_execution_v_2_return_bitfield_5_working_price
        type: b1
      - id: order_execution_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_5_expire_time
        type: b1
  order_execution_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_execution_v_2_return_bitfield_6_ccp
        type: b1
      - id: order_execution_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: order_execution_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: order_execution_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_execution_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_execution_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_execution_v_2_return_bitfield_6_party_role
        type: b1
  order_execution_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_execution_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_execution_v_2_return_bitfield_7_text
        type: b1
      - id: order_execution_v_2_return_bitfield_7_bid
        type: b1
      - id: order_execution_v_2_return_bitfield_7_offer
        type: b1
      - id: order_execution_v_2_return_bitfield_7_large_size
        type: b1
      - id: order_execution_v_2_return_bitfield_7_last_mkt
        type: b1
  order_execution_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_8_fee_code
        type: b1
      - id: order_execution_v_2_return_bitfield_8_echo_text
        type: b1
      - id: order_execution_v_2_return_bitfield_8_stop_px
        type: b1
      - id: order_execution_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: order_execution_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: order_execution_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_execution_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: order_execution_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  order_execution_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_execution_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: order_execution_v_2_return_bitfield_9_auction_id
        type: b1
      - id: order_execution_v_2_return_bitfield_9_order_category
        type: b1
      - id: order_execution_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_execution_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: order_execution_v_2_return_bitfield_9_cross_type
        type: b1
      - id: order_execution_v_2_return_bitfield_9_cross_prioritization
        type: b1
  order_execution_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_10_cross_id
        type: b1
      - id: order_execution_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_execution_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: order_execution_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: order_execution_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_10_price_formation
        type: b1
      - id: order_execution_v_2_return_bitfield_10_client_qualified_role
        type: b1
  order_execution_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_11_client_id
        type: b1
      - id: order_execution_v_2_return_bitfield_11_investor_id
        type: b1
      - id: order_execution_v_2_return_bitfield_11_executor_id
        type: b1
      - id: order_execution_v_2_return_bitfield_11_order_origination
        type: b1
      - id: order_execution_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: order_execution_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_execution_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  order_execution_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_12_cti_code
        type: b1
      - id: order_execution_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_12_operator_id
        type: b1
      - id: order_execution_v_2_return_bitfield_12_trade_date
        type: b1
      - id: order_execution_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: order_execution_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: order_execution_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_execution_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  order_execution_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_execution_v_2_return_bitfield_13_avg_px
        type: b1
      - id: order_execution_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: order_execution_v_2_return_bitfield_13_pending_status
        type: b1
      - id: order_execution_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_execution_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  order_execution_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_execution_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_execution_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_execution_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: order_execution_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_execution_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: order_execution_v_2_return_bitfield_14_username
        type: b1
      - id: order_execution_v_2_return_bitfield_14_user_status
        type: b1
  order_execution_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: order_execution_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_execution_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_execution_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_execution_v_2_return_bitfield_15_report_time
        type: b1
      - id: order_execution_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_execution_v_2_return_bitfield_15_client_id_attr
        type: b1
  order_execution_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_execution_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: order_execution_v_2_return_bitfield_16_combo_order
        type: b1
      - id: order_execution_v_2_return_bitfield_16_compression
        type: b1
      - id: order_execution_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: order_execution_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_execution_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: order_execution_v_2_return_bitfield_16_order_origin
        type: b1
  order_execution_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_17_price_type
        type: b1
      - id: order_execution_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: order_execution_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: order_execution_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_execution_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: order_execution_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_execution_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_execution_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_execution_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_18_account_type
        type: b1
      - id: order_execution_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: order_execution_v_2_return_bitfield_18_subreason
        type: b1
      - id: order_execution_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_execution_v_2_return_bitfield_18_leg_price
        type: b1
      - id: order_execution_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: order_execution_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: order_execution_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  order_execution_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: order_execution_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: order_execution_v_2_return_bitfield_19_reserved_128
        type: b1
  trade_cancel_or_correct_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe (—). A leading tilde (˜) cannot be sent on any ClOrdID and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system-generated ClOrdID. If the ClOrdID matches a live order, the order will be rejected as a duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live or- ders, which includes long-lived persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID val- ues at least day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in Cboe FIX. Refers to the ExecID (o)f the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
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
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'For trade corrections, this is the new trade price. For trade breaks, this is set to 0. Implied decimal with scale 1e-4'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'Corresponds to OrigTime (42). The date and time of the original trade, in GMT. Nanoseconds since Unix epoch'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_cancelor_correct_v_2_return_bitfield_1
        type: trade_cancelor_correct_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCancelorCorrectV2 byte 1'
      - id: trade_cancelor_correct_v_2_return_bitfield_2
        type: trade_cancelor_correct_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCancelorCorrectV2 byte 2'
      - id: trade_cancelor_correct_v_2_return_bitfield_3
        type: trade_cancelor_correct_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCancelorCorrectV2 byte 3'
      - id: trade_cancelor_correct_v_2_return_bitfield_4
        type: trade_cancelor_correct_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCancelorCorrectV2 byte 4'
      - id: trade_cancelor_correct_v_2_return_bitfield_5
        type: trade_cancelor_correct_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCancelorCorrectV2 byte 5'
      - id: trade_cancelor_correct_v_2_return_bitfield_6
        type: trade_cancelor_correct_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCancelorCorrectV2 byte 6'
      - id: trade_cancelor_correct_v_2_return_bitfield_7
        type: trade_cancelor_correct_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCancelorCorrectV2 byte 7'
      - id: trade_cancelor_correct_v_2_return_bitfield_8
        type: trade_cancelor_correct_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCancelorCorrectV2 byte 8'
      - id: trade_cancelor_correct_v_2_return_bitfield_9
        type: trade_cancelor_correct_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCancelorCorrectV2 byte 9'
      - id: trade_cancelor_correct_v_2_return_bitfield_10
        type: trade_cancelor_correct_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCancelorCorrectV2 byte 10'
      - id: trade_cancelor_correct_v_2_return_bitfield_11
        type: trade_cancelor_correct_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCancelorCorrectV2 byte 11'
      - id: trade_cancelor_correct_v_2_return_bitfield_12
        type: trade_cancelor_correct_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCancelorCorrectV2 byte 12'
      - id: trade_cancelor_correct_v_2_return_bitfield_13
        type: trade_cancelor_correct_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCancelorCorrectV2 byte 13'
      - id: trade_cancelor_correct_v_2_return_bitfield_14
        type: trade_cancelor_correct_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCancelorCorrectV2 byte 14'
      - id: trade_cancelor_correct_v_2_return_bitfield_15
        type: trade_cancelor_correct_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCancelorCorrectV2 byte 15'
      - id: trade_cancelor_correct_v_2_return_bitfield_16
        type: trade_cancelor_correct_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCancelorCorrectV2 byte 16'
      - id: trade_cancelor_correct_v_2_return_bitfield_17
        type: trade_cancelor_correct_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCancelorCorrectV2 byte 17'
      - id: trade_cancelor_correct_v_2_return_bitfield_18
        type: trade_cancelor_correct_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCancelorCorrectV2 byte 18'
      - id: trade_cancelor_correct_v_2_return_bitfield_19
        type: trade_cancelor_correct_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCancelorCorrectV2 byte 19'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_symbol > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_security_exchange > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_capacity > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_v_2_return_bitfield_4.trade_cancelor_correct_v_2_return_bitfield_4_corrected_size > 0
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_v_2_return_bitfield_7.trade_cancelor_correct_v_2_return_bitfield_7_last_mkt > 0
  trade_cancelor_correct_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_1_side
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_2_contra_trader
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_3_account
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_4_access_fee
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_5_expire_time
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_6_party_role
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_text
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_username
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_14_user_status
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_16_order_origin
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_cancelor_correct_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_19_reserved_128
        type: b1
  purge_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
  mass_cancel_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. This field corre- sponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
  trade_capture_report_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 1'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 2'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 3'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 4'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 5'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 6'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 7'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 8'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 9'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 10'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 11'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 12'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 13'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 14'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 15'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 16'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 17'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 18'
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19
        type: trade_capture_report_acknowledgment_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportAcknowledgmentV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_acknowledgment_v_2_return_bitfield_7.trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_capture_report_acknowledgment_v_2_return_bitfield_8.trade_capture_report_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id > 0
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_report_acknowledgment_v_2_return_bitfield_9.trade_capture_report_acknowledgment_v_2_return_bitfield_9_order_category > 0
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and trade_capture_report_acknowledgment_v_2_return_bitfield_9.trade_capture_report_acknowledgment_v_2_return_bitfield_9_liquidity_provision > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_acknowledgment_v_2_return_bitfield_10.trade_capture_report_acknowledgment_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_acknowledgment_v_2_return_bitfield_11.trade_capture_report_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_acknowledgment_v_2_return_bitfield_19.trade_capture_report_acknowledgment_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_acknowledgment_v_2_return_bitfield_1.trade_capture_report_acknowledgment_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_account > 0
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_acknowledgment_v_2_return_bitfield_4.trade_capture_report_acknowledgment_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: u1
        enum: party_role
        if: number_of_return_bitfields >= 6 and trade_capture_report_acknowledgment_v_2_return_bitfield_6.trade_capture_report_acknowledgment_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  trade_capture_report_acknowledgment_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_acknowledgment_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_19_reserved_128
        type: b1
  trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: u1
        enum: party_role
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  trade_capture_report_reject_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_reject_v_2_return_bitfield_1
        type: trade_capture_report_reject_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportRejectV2 byte 1'
      - id: trade_capture_report_reject_v_2_return_bitfield_2
        type: trade_capture_report_reject_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportRejectV2 byte 2'
      - id: trade_capture_report_reject_v_2_return_bitfield_3
        type: trade_capture_report_reject_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportRejectV2 byte 3'
      - id: trade_capture_report_reject_v_2_return_bitfield_4
        type: trade_capture_report_reject_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportRejectV2 byte 4'
      - id: trade_capture_report_reject_v_2_return_bitfield_5
        type: trade_capture_report_reject_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportRejectV2 byte 5'
      - id: trade_capture_report_reject_v_2_return_bitfield_6
        type: trade_capture_report_reject_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportRejectV2 byte 6'
      - id: trade_capture_report_reject_v_2_return_bitfield_7
        type: trade_capture_report_reject_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportRejectV2 byte 7'
      - id: trade_capture_report_reject_v_2_return_bitfield_8
        type: trade_capture_report_reject_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportRejectV2 byte 8'
      - id: trade_capture_report_reject_v_2_return_bitfield_9
        type: trade_capture_report_reject_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportRejectV2 byte 9'
      - id: trade_capture_report_reject_v_2_return_bitfield_10
        type: trade_capture_report_reject_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportRejectV2 byte 10'
      - id: trade_capture_report_reject_v_2_return_bitfield_11
        type: trade_capture_report_reject_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportRejectV2 byte 11'
      - id: trade_capture_report_reject_v_2_return_bitfield_12
        type: trade_capture_report_reject_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportRejectV2 byte 12'
      - id: trade_capture_report_reject_v_2_return_bitfield_13
        type: trade_capture_report_reject_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportRejectV2 byte 13'
      - id: trade_capture_report_reject_v_2_return_bitfield_14
        type: trade_capture_report_reject_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportRejectV2 byte 14'
      - id: trade_capture_report_reject_v_2_return_bitfield_15
        type: trade_capture_report_reject_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportRejectV2 byte 15'
      - id: trade_capture_report_reject_v_2_return_bitfield_16
        type: trade_capture_report_reject_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportRejectV2 byte 16'
      - id: trade_capture_report_reject_v_2_return_bitfield_17
        type: trade_capture_report_reject_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportRejectV2 byte 17'
      - id: trade_capture_report_reject_v_2_return_bitfield_18
        type: trade_capture_report_reject_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportRejectV2 byte 18'
      - id: trade_capture_report_reject_v_2_return_bitfield_19
        type: trade_capture_report_reject_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportRejectV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_reject_v_2_return_bitfield_10.trade_capture_report_reject_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_reject_v_2_return_bitfield_11.trade_capture_report_reject_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_reject_v_2_return_bitfield_19.trade_capture_report_reject_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_reject_v_2_return_bitfield_1.trade_capture_report_reject_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_account > 0
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_reject_v_2_return_bitfield_4.trade_capture_report_reject_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: u1
        enum: party_role
        if: number_of_return_bitfields >= 6 and trade_capture_report_reject_v_2_return_bitfield_6.trade_capture_report_reject_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  trade_capture_report_reject_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_reject_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_19_reserved_128
        type: b1
  trade_capture_confirm_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
      - id: trade_id
        type: u8
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Indicates the market of execution. Markets are identified by their ISO Market Identification Code (MIC)12'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_confirm_v_2_return_bitfield_1
        type: trade_capture_confirm_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureConfirmV2 byte 1'
      - id: trade_capture_confirm_v_2_return_bitfield_2
        type: trade_capture_confirm_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureConfirmV2 byte 2'
      - id: trade_capture_confirm_v_2_return_bitfield_3
        type: trade_capture_confirm_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureConfirmV2 byte 3'
      - id: trade_capture_confirm_v_2_return_bitfield_4
        type: trade_capture_confirm_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureConfirmV2 byte 4'
      - id: trade_capture_confirm_v_2_return_bitfield_5
        type: trade_capture_confirm_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureConfirmV2 byte 5'
      - id: trade_capture_confirm_v_2_return_bitfield_6
        type: trade_capture_confirm_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureConfirmV2 byte 6'
      - id: trade_capture_confirm_v_2_return_bitfield_7
        type: trade_capture_confirm_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureConfirmV2 byte 7'
      - id: trade_capture_confirm_v_2_return_bitfield_8
        type: trade_capture_confirm_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureConfirmV2 byte 8'
      - id: trade_capture_confirm_v_2_return_bitfield_9
        type: trade_capture_confirm_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureConfirmV2 byte 9'
      - id: trade_capture_confirm_v_2_return_bitfield_10
        type: trade_capture_confirm_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureConfirmV2 byte 10'
      - id: trade_capture_confirm_v_2_return_bitfield_11
        type: trade_capture_confirm_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureConfirmV2 byte 11'
      - id: trade_capture_confirm_v_2_return_bitfield_12
        type: trade_capture_confirm_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureConfirmV2 byte 12'
      - id: trade_capture_confirm_v_2_return_bitfield_13
        type: trade_capture_confirm_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureConfirmV2 byte 13'
      - id: trade_capture_confirm_v_2_return_bitfield_14
        type: trade_capture_confirm_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureConfirmV2 byte 14'
      - id: trade_capture_confirm_v_2_return_bitfield_15
        type: trade_capture_confirm_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureConfirmV2 byte 15'
      - id: trade_capture_confirm_v_2_return_bitfield_16
        type: trade_capture_confirm_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureConfirmV2 byte 16'
      - id: trade_capture_confirm_v_2_return_bitfield_17
        type: trade_capture_confirm_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureConfirmV2 byte 17'
      - id: trade_capture_confirm_v_2_return_bitfield_18
        type: trade_capture_confirm_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureConfirmV2 byte 18'
      - id: trade_capture_confirm_v_2_return_bitfield_19
        type: trade_capture_confirm_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureConfirmV2 byte 19'
      - id: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: text
        type: str
        size: 60
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_text > 0
        doc: 'Human readable text with more information about the reject reason'
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_confirm_v_2_return_bitfield_9.trade_capture_confirm_v_2_return_bitfield_9_order_category > 0
      - id: waiver_type
        type: u1
        enum: waiver_type
        if: number_of_return_bitfields >= 10 and trade_capture_confirm_v_2_return_bitfield_10.trade_capture_confirm_v_2_return_bitfield_10_waiver_type > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_confirm_v_2_return_bitfield_10.trade_capture_confirm_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_deferral_reason > 0
      - id: trade_publish_ind
        type: u1
        enum: trade_publish_ind
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_trade_publish_ind > 0
      - id: report_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_report_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_confirm_v_2_return_bitfield_19.trade_capture_confirm_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_confirm_v_2_return_bitfield_1.trade_capture_confirm_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_account > 0
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_confirm_v_2_return_bitfield_4.trade_capture_confirm_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: u1
        enum: party_role
        if: number_of_return_bitfields >= 6 and trade_capture_confirm_v_2_return_bitfield_6.trade_capture_confirm_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_capture_confirm_v_2_return_bitfield_8.trade_capture_confirm_v_2_return_bitfield_8_fee_code > 0
  trade_capture_confirm_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_confirm_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_confirm_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_confirm_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_confirm_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_confirm_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_confirm_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_confirm_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_confirm_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_confirm_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_confirm_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_confirm_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_confirm_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_confirm_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_confirm_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_confirm_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_confirm_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_19_reserved_128
        type: b1
  trade_capture_confirm_v_2_trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: central_counterparty
        type: u1
        enum: central_counterparty
        doc: 'The CCP handling the trade Counterparty E = Cboe Clear L = LCH Ltd (London) X = SIX x-clear N = None - Clearing Suppressed for self match'
      - id: party_role
        type: u1
        enum: party_role
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
  trade_capture_report_decline_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanosecond precision. Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
      - id: trade_id
        type: u8
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity. If the LargeSize op- tional field is specified, that value holds pre- cedance over this field'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Indicates the market of execution. Markets are identified by their ISO Market Identification Code (MIC)12'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 8, p. 128) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: trade_capture_report_decline_v_2_return_bitfield_1
        type: trade_capture_report_decline_v_2_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 1'
      - id: trade_capture_report_decline_v_2_return_bitfield_2
        type: trade_capture_report_decline_v_2_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 2'
      - id: trade_capture_report_decline_v_2_return_bitfield_3
        type: trade_capture_report_decline_v_2_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 3'
      - id: trade_capture_report_decline_v_2_return_bitfield_4
        type: trade_capture_report_decline_v_2_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 4'
      - id: trade_capture_report_decline_v_2_return_bitfield_5
        type: trade_capture_report_decline_v_2_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 5'
      - id: trade_capture_report_decline_v_2_return_bitfield_6
        type: trade_capture_report_decline_v_2_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 6'
      - id: trade_capture_report_decline_v_2_return_bitfield_7
        type: trade_capture_report_decline_v_2_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 7'
      - id: trade_capture_report_decline_v_2_return_bitfield_8
        type: trade_capture_report_decline_v_2_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 8'
      - id: trade_capture_report_decline_v_2_return_bitfield_9
        type: trade_capture_report_decline_v_2_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 9'
      - id: trade_capture_report_decline_v_2_return_bitfield_10
        type: trade_capture_report_decline_v_2_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 10'
      - id: trade_capture_report_decline_v_2_return_bitfield_11
        type: trade_capture_report_decline_v_2_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 11'
      - id: trade_capture_report_decline_v_2_return_bitfield_12
        type: trade_capture_report_decline_v_2_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 12'
      - id: trade_capture_report_decline_v_2_return_bitfield_13
        type: trade_capture_report_decline_v_2_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 13'
      - id: trade_capture_report_decline_v_2_return_bitfield_14
        type: trade_capture_report_decline_v_2_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 14'
      - id: trade_capture_report_decline_v_2_return_bitfield_15
        type: trade_capture_report_decline_v_2_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 15'
      - id: trade_capture_report_decline_v_2_return_bitfield_16
        type: trade_capture_report_decline_v_2_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 16'
      - id: trade_capture_report_decline_v_2_return_bitfield_17
        type: trade_capture_report_decline_v_2_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 17'
      - id: trade_capture_report_decline_v_2_return_bitfield_18
        type: trade_capture_report_decline_v_2_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 18'
      - id: trade_capture_report_decline_v_2_return_bitfield_19
        type: trade_capture_report_decline_v_2_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet TradeCaptureReportDeclineV2 byte 19'
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_symbol > 0
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_currency > 0
      - id: id_source
        type: u1
        enum: id_source
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_id_source > 0
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_security_id > 0
      - id: security_exchange
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_security_exchange > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 99,999,999 shares'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_trade_report_type_return > 0
      - id: price_formation
        type: u1
        enum: price_formation
        if: number_of_return_bitfields >= 10 and trade_capture_report_decline_v_2_return_bitfield_10.trade_capture_report_decline_v_2_return_bitfield_10_price_formation > 0
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_decline_v_2_return_bitfield_11.trade_capture_report_decline_v_2_return_bitfield_11_algorithmic_indicator > 0
      - id: intra_firm_trade_ind
        type: u1
        enum: intra_firm_trade_ind
        if: number_of_return_bitfields >= 19 and trade_capture_report_decline_v_2_return_bitfield_19.trade_capture_report_decline_v_2_return_bitfield_19_intra_firm_trade_ind > 0
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and trade_capture_report_decline_v_2_return_bitfield_1.trade_capture_report_decline_v_2_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell 5 = Sell Short 6 = Sell Short Exempt H = Sell Undisclosed'
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_account > 0
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and trade_capture_report_decline_v_2_return_bitfield_4.trade_capture_report_decline_v_2_return_bitfield_4_party_id > 0
        doc: 'Corresponds to PartyID (448) in Cboe FIX. The end-client responsible for the trade. Must be an identifier (4 uppercase letters) known to Cboe'
      - id: party_role
        type: u1
        enum: party_role
        if: number_of_return_bitfields >= 6 and trade_capture_report_decline_v_2_return_bitfield_6.trade_capture_report_decline_v_2_return_bitfield_6_party_role > 0
        doc: 'Corresponds to PartyRole (452) in Cboe FIX. Contains the PartyRole specified on this leg on the trade capture, if any. Reflected back on trade capture report confirmations. 1 = ExecutingFirm (default) (if used, must be set on both sides. Is not permitted for bilateral trades) 2 = EnteringFirm (the party reporting the trade. Should not be used for the second leg) 3 = ContraFirm (the party the trade is alleged against)'
  trade_capture_report_decline_v_2_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_1_side
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_peg_difference
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_exec_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_ord_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_time_in_force
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_min_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_1_max_remove_pct
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_2_symbol
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_symbol_sfx
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_currency
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_id_source
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_security_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_security_exchange
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_capacity
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_2_reserved_128
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_3_account
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_clearing_firm
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_clearing_account
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_display_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_max_floor
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_discretion_amount
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_order_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_3_prevent_match
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_4_maturity_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_strike_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_put_or_call
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_open_close
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_corrected_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_4_access_fee
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_leaves_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_last_shares
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_last_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_display_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_working_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_5_expire_time
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_6_secondary_order_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_ccp
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_contra_capacity
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_attributed_quote
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_6_party_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_trade_report_type_return
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_text
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_bid
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_offer
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_large_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_7_last_mkt
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_8_fee_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_echo_text
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_stop_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_routing_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_rout_strategy
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_route_delivery_method
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_ex_destination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_8_trade_report_ref_id
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_9_marketing_fee_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_target_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_auction_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_order_category
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_liquidity_provision
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cmta_number
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cross_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_9_cross_prioritization
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_10_cross_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_alloc_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_give_up_firm_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_routing_firm_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_waiver_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_price_formation
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_10_client_qualified_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_11_client_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_investor_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_executor_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_order_origination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_deferral_reason
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_investor_qualified_role
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_11_executor_qualified_role
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_12_cti_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_manual_order_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_operator_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_trade_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_size
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_12_clearing_optional_data
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_13_cum_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_order_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_cum_qty
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_avg_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_day_avg_px
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_pending_status
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_drill_thru_protection
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_13_multileg_reporting_type
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_cfi_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_maturity_date
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_leg_strike_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_quote_room_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_secondary_exec_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_user_request_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_username
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_14_user_status
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_equity_party_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_mass_cancel_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_trade_publish_ind
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_report_time
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_15_client_id_attr
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_16_frequent_trader_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_session_eligibility
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_combo_order
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_compression
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_floor_destination
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_floor_routing_inst
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_multi_class_spread
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_16_order_origin
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_17_price_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_strategy_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_trading_session_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_17_cust_order_handling_inst
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_18_account_type
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_cross_initiator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_subreason
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_cross_trade_flag
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_leg_price
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_held_indicator
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_locate_broker
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_multi_juris_reporting_ind
        type: b1
  trade_capture_report_decline_v_2_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_1
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_2
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_4
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_8
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_32
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_64
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_19_reserved_128
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
  decimal_u8_7:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000000.0

enums:
  message_type:
    0x37:
      id: 'login_request_v_2_message'
      doc: 'Login Request V2 Message.'
    0x02:
      id: 'logout_request_message'
      doc: 'Logout Request Message.'
    0x03:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat Message.'
    0x24:
      id: 'login_response_v_2_message'
      doc: 'Login Response V2 Message.'
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
      id: 'new_order_v_2_message'
      doc: 'New Order V2 Message.'
    0x39:
      id: 'cancel_order_v_2_message'
      doc: 'Cancel Order V2 Message.'
    0x3a:
      id: 'modify_order_v_2_message'
      doc: 'Modify Order V2 Message.'
    0x47:
      id: 'purge_orders_v_2_message'
      doc: 'Purge Orders V2 Message.'
    0x3c:
      id: 'trade_capture_report_v_2_message'
      doc: 'Trade Capture Report V2 Message.'
    0x25:
      id: 'order_acknowledgment_v_2_message'
      doc: 'Order Acknowledgment V2 Message.'
    0x26:
      id: 'order_rejected_v_2_message'
      doc: 'Order Rejected V2 Message.'
    0x27:
      id: 'order_modified_v_2_message'
      doc: 'Order Modified V2 Message.'
    0x28:
      id: 'order_restated_v_2_message'
      doc: 'Order Restated V2 Message.'
    0x29:
      id: 'user_modify_rejected_v_2_message'
      doc: 'User Modify Rejected V2 Message.'
    0x2a:
      id: 'order_cancelled_v_2_message'
      doc: 'Order Cancelled V2 Message.'
    0x2b:
      id: 'cancel_rejected_v_2_message'
      doc: 'Cancel Rejected V2 Message.'
    0x2c:
      id: 'order_execution_v_2_message'
      doc: 'Order Execution V2 Message.'
    0x2d:
      id: 'trade_cancel_or_correct_v_2_message'
      doc: 'Trade Cancel or Correct V2 Message.'
    0x48:
      id: 'purge_rejected_v_2_message'
      doc: 'Purge Rejected V2 Message.'
    0x36:
      id: 'mass_cancel_acknowledgment_v_2_message'
      doc: 'Mass Cancel Acknowledgment V2 Message.'
    0x30:
      id: 'trade_capture_report_acknowledgment_v_2_message'
      doc: 'Trade Capture Report Acknowledgment V2 Message.'
    0x31:
      id: 'trade_capture_report_reject_v_2_message'
      doc: 'Trade Capture Report Reject V2 Message.'
    0x32:
      id: 'trade_capture_confirm_v_2_message'
      doc: 'Trade Capture Confirm V2 Message.'
    0x33:
      id: 'trade_capture_report_decline_v_2_message'
      doc: 'Trade Capture Report Decline V2 Message.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized Invalid User Namepassword'
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
      id: 'invalid_return_bitfield_in_login_message'
      doc: 'Invalid Return Bitfield In Login Message'
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
      doc: 'Sell Short'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
    0x48:
      id: 'sell_undisclosed'
      doc: 'Sell Undisclosed'
  exec_inst:
    0x4c:
      id: 'alternate_midpoint'
      doc: 'Alternate Midpoint Less Aggressive Of Midpoint And 1 Tick Inside Pbbo For Periodic Auction Orders 5'
    0x4d:
      id: 'midpoint'
      doc: 'Midpoint Peg To Pbbo Midpoint'
    0x47:
      id: 'guarded_midpoint'
      doc: 'Guarded Midpoint Peg To Cboe Ebbo Midpoint But Suspend Order If Primary Market Quote Becomes Onesided Or Disappears'
    0x52:
      id: 'primary_peg'
      doc: 'Primary Peg Peg Buy To Pbbo Bid Peg Sell To Pbbo Offer'
    0x50:
      id: 'market_peg'
      doc: 'Market Peg Peg Buy To Pbbo Offer Peg Sell To Pbbo Bid'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit Default'
    0x50:
      id: 'pegged'
      doc: 'Pegged Pegged Requires Exec Inst Be Set To L M P Or R'
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
      doc: 'Ioc Portion Not Filled Immediately Is Cancelled Mar Ket Orders Are Implicitly Ioc Treated As Accept Or Cancel For Routing Inst Bp Or Bh'
    0x36:
      id: 'gtd'
      doc: 'Gtd Expires At Specified Expire Time For A Specific Day'
    0x37:
      id: 'at_the_close'
      doc: 'At The Close'
    0x38:
      id: 'good_for_auction'
      doc: 'Good For Auction Only Valid If Routing Inst Bp Or Bu'
  id_source:
    0x34:
      id: 'isin'
      doc: 'Isin'
    0x35:
      id: 'ric'
      doc: 'Ric'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency Maps To Aotc'
    0x50:
      id: 'principal'
      doc: 'Principal Maps To Deal'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal Maps To Mtch'
  display_indicator:
    0x58:
      id: 'displayed_order'
      doc: 'Displayed Order'
    0x49:
      id: 'invisible'
      doc: 'Invisible Invisible Orders Must Meet The Mi Fid Esma Requirements For Large In Scale Lis Unless Routed To The Cboe Dark Book'
  liquidity_provision:
    0x4e:
      id: 'not_liquidity_provision'
      doc: 'Not Liquidity Provision Default'
    0x59:
      id: 'liquidity_provision'
      doc: 'Liquidity Provision'
  ext_exec_inst:
    0x4e:
      id: 'none'
      doc: 'None'
    0x47:
      id: 'all_or_none'
      doc: 'All Or None Periodic Auction Only'
    0x52:
      id: 'retail_order'
      doc: 'Retail Order'
    0x41:
      id: 'retail_all_or_none'
      doc: 'Retail All Or None'
    0x4c:
      id: 'retail_liquidity_provision'
      doc: 'Retail Liquidity Provision The All Or None Instruction Applies To Periodic Auctions Only An Extended Exec Inst Of L Is Only Valid For Attested Retail Liq Uidity Providers This Implies An Order Attribute Types 8015 Value Of 2 Retail Liquidity Provider Orders Cannot Participate In Auctions They Will Be Rejected If Submitted Directly Or Expired If Posted Preauction Transition'
  client_id:
    0:
      id: 'none'
      doc: 'None No Client For This Order'
    1:
      id: 'aggr'
      doc: 'Aggr An Aggregation Of Multiple Client Orders'
    2:
      id: 'pnal'
      doc: 'Pnal Clients Are Pending Allocation'
  order_origination:
    0x35:
      id: 'dea_indicates_dea_activity_as_deemed_by_mi_fid_ii'
      doc: 'Dea Indicates Dea Activity As Deemed By Mi Fid Ii Is Involved In This Order'
    0x30:
      id: 'non_dea'
      doc: 'Non Dea Default Other Values Are Unsupported And Will Be Rejected'
  algorithmic_indicator:
    0x4e:
      id: 'no_algorithm_was_involved'
      doc: 'No Algorithm Was Involved Default'
    0x59:
      id: 'algorithm_was_involved'
      doc: 'Algorithm Was Involved Algo'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  party_role:
    0x31:
      id: 'executing_firm'
      doc: 'Executing Firm Default If Used Must Be Set On Both Sides Is Not Permitted For Bilateral Trades'
    0x32:
      id: 'entering_firm'
      doc: 'Entering Firm The Party Reporting The Trade Should Not Be Used For The Second Leg'
    0x33:
      id: 'contra_firm'
      doc: 'Contra Firm The Party The Trade Is Alleged Against'
  transaction_category:
    0x50:
      id: 'regular_trade'
      doc: 'Regular Trade Aka Plain Vanilla Trade'
    0x4f:
      id: 'portfolio_trade'
      doc: 'Portfolio Trade'
    0x59:
      id: 'exchange_for_physical'
      doc: 'Exchange For Physical Xfph Rts 2 Nonequities Only'
    0x5a:
      id: 'package_trade'
      doc: 'Package Trade Tpac Rts 2 Nonequities Only'
  trade_report_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'cancel'
      doc: 'Cancel'
    2:
      id: 'replace'
      doc: 'Replace'
    3:
      id: 'release'
      doc: 'Release'
  trading_session_sub_id:
    2:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    4:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    6:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    8:
      id: 'unspecified_auction'
      doc: 'Unspecified Auction'
    9:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    3:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    5:
      id: 'post_trading'
      doc: 'Post Trading 10 Out Of Main Session Trading'
  trade_publish_indicator:
    0:
      id: 'do_not_publish'
      doc: 'Do Not Publish Deprecated From 4 Th December 2017 In Certification And 2 Nd January 2018 In Production Any Requests To Publish A Trade Using This Indicator Will Not Be Honoured And Will Instead Be Published Im Mediately'
    1:
      id: 'publish_trade'
      doc: 'Publish Trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred Publication In Order For Rts 1 Based Instruments To Be Considered For A Deferral Capacity P Maps To Deal Must Be Set For Rts 1 And Rts 2 Instruments Delayed Publicationdeferrals Are Ignored If The Trade Does Not Qualify For Delayed Publication'
  execution_method:
    0x41:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x55:
      id: 'unspecified'
      doc: 'Unspecified Default'
  trade_report_type:
    0:
      id: 'submit_for_all_new_trade_reports'
      doc: 'Submit For All New Trade Reports'
    6:
      id: 'trade_report_cancel_to_cancel_any_acknowledged_but'
      doc: 'Trade Report Cancel To Cancel Any Acknowledged But Not Confirmed Trade Reports Entered Where Trade Han Dling Instruction 2'
  order_category:
    0:
      id: 'not_a_negotiated_trade'
      doc: 'Not A Negotiated Trade'
    3:
      id: 'privately_negotiated_trade'
      doc: 'Privately Negotiated Trade On Return Fields This Field Indicates Whether Cboe Deems The Trade As Utilising The Negotiated Transaction Waiver Under Mi Fid'
  price_formation:
    0x33:
      id: 'negotiated_trade_subject_to_conditions_other_than_the'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price Pric Please Note That This Is Not Needed Or Supported On Bxe Or Cxe For Mmt Level 38 Contribution To Price Formation Or The Price Discovery Process Supported Values Are Not Specified Or P Plain Vanilla Trade'
    0x54:
      id: 'non_price_forming_trade'
      doc: 'Non Price Forming Trade Npft Effective 1 December 2025 On Bxe And Cxe This Value Will Be Ignored If Used On A Rts 2 Instrument'
  intra_firm_trade_ind:
    0x4e:
      id: 'not_an_intragroup_transaction'
      doc: 'Not An Intragroup Transaction Default'
    0x59:
      id: 'is_an_intragroup_transaction'
      doc: 'Is An Intragroup Transaction'
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
      id: 'auction_trade'
      doc: 'Auction Trade'
    0x53:
      id: 'self_match'
      doc: 'Self Match Optin'
  sub_liquidity_indicator:
    0x44:
      id: 'cboe_dark_pool_execution'
      doc: 'Cboe Dark Pool Execution'
    0x54:
      id: 'removed_liquidity_from_the_cboe_dark_pool_by_ioc_order'
      doc: 'Removed Liquidity From The Cboe Dark Pool By Ioc Order'
    0x48:
      id: 'trade_added_hidden_liquidity'
      doc: 'Trade Added Hidden Liquidity Not Eu Equities'
    0x49:
      id: 'trade_added_hidden_liquidity_that_was_price_improved'
      doc: 'Trade Added Hidden Liquidity That Was Price Improved Not Eu Equities'
    0x4b:
      id: 'add_liquidity_from_hidden_reserve'
      doc: 'Add Liquidity From Hidden Reserve Iceberg Order'
    0x50:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
    0x43:
      id: 'cboe_closing_cross'
      doc: 'Cboe Closing Cross'
    0x53:
      id: 'liquidity_alps_bbo'
      doc: 'Liquidity Alps Bbo'
    0x4f:
      id: 'open_auction'
      doc: 'Open Auction'
    0x4c:
      id: 'close_auction'
      doc: 'Close Auction'
    0x41:
      id: 'halt_auction'
      doc: 'Halt Auction'
    0x56:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x52:
      id: 'carried'
      doc: 'Carried'
    0x46:
      id: 'done_for_day'
      doc: 'Done For Day'
  waiver_type:
    0x2d:
      id: 'no_waiver_type'
      doc: 'No Waiver Type'
    0x30:
      id: 'negotiated_trade_in_liquid_instrument'
      doc: 'Negotiated Trade In Liquid Instrument Nliq'
    0x31:
      id: 'negotiated_trade_in_illiquid_instrument'
      doc: 'Negotiated Trade In Illiquid Instrument Oilq'
    0x32:
      id: 'negotiated_trade_subject_to_conditions_other_than_the'
      doc: 'Negotiated Trade Subject To Conditions Other Than The Current Market Price Pric'
    0x33:
      id: 'reference_price'
      doc: 'Reference Price Dark Book Rfpt Pre Trade Trans Parency Waiver'
    0x41:
      id: 'order_management_facility'
      doc: 'Order Management Facility Iceberg Pre Trade Trans Parency Waiver'
    0x38:
      id: 'negotiated_trade_subject_to_a_pre_trade_transparency'
      doc: 'Negotiated Trade Subject To A Pre Trade Transparency Waiver Netw Replaces Nliq Oliq And Pric For Bxe And Cxe Only'
    0x63:
      id: 'negotiated_trade_that_is_large_in_scale_subject_to_a_pre'
      doc: 'Negotiated Trade That Is Large In Scale Subject To A Pre Trade Transparency Waiver Ntls Implies Netw'
    0x39:
      id: 'large_in_scale'
      doc: 'Large In Scale Pre Trade Transparency Waiver On Bxe And Cxe Netw 8 Replaces Nliq Oilq Pric If The Negotiated Trade Is Large In Scale Then Ntls C Applies Too'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  restatement_reason:
    0x52:
      id: 'reroute'
      doc: 'Reroute'
    0x58:
      id: 'locked_in_cross'
      doc: 'Locked In Cross'
    0x57:
      id: 'wash'
      doc: 'Wash'
    0x4c:
      id: 'reload'
      doc: 'Reload'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated Cboe Reserves The Right To Add New Values As Necessary Without Prior Notice'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
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
    0x6b:
      id: 'pending_periodic_auction'
      doc: 'Pending Periodic Auction Bxe And Dxe Only'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
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
    0x54:
      id: 'routing_order_would_trade_through_an_away_destination'
      doc: 'Routing Order Would Trade Through An Away Destination'
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
    0x6c:
      id: 'large_in_scale'
      doc: 'Large In Scale'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x70:
      id: 'static_collar_breach'
      doc: 'Static Collar Breach'
    0x72:
      id: 'reserve_reload'
      doc: 'Reserve Reload'
    0x73:
      id: 'risk_management_symbol_level'
      doc: 'Risk Management Symbol Level'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x76:
      id: 'mi_fid_ii_double_cap_related'
      doc: 'Mi Fid Ii Double Cap Related'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
  central_counterparty:
    0x45:
      id: 'cboe_clear'
      doc: 'Cboe Clear'
    0x4c:
      id: 'lch_ltd'
      doc: 'Lch Ltd London'
    0x58:
      id: 'six_xclear'
      doc: 'Six Xclear'
    0x4e:
      id: 'none_clearing_suppressed_for_self_match'
      doc: 'None Clearing Suppressed For Self Match'
  deferral_reason:
    0x2d:
      id: 'no_deferral_reason'
      doc: 'No Deferral Reason'
    0x36:
      id: 'deferral_for_large_in_scale'
      doc: 'Deferral For Large In Scale Lrgs'
  trade_publish_ind:
    0:
      id: 'do_not_publish'
      doc: 'Do Not Publish Deprecated From 4 Th December 2017 In Certification And 2 Nd January 2018 In Production Any Requests To Publish A Trade Using This Indicator Will Not Be Honoured And Will Instead Be Published Im Mediately'
    1:
      id: 'publish_trade'
      doc: 'Publish Trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred Publication In Order For Rts 1 Based Instruments To Be Considered For A Deferral Capacity P Maps To Deal Must Be Set For Rts 1 And Rts 2 Instruments Delayed Publicationdeferrals Are Ignored If The Trade Does Not Qualify For Delayed Publication'

