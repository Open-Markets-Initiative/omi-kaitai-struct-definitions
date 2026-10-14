# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe DxeDerivatives BinaryOrderEntry Boe v2.18
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Europe Derivatives Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.18
#   Date: 5/9/2022
#   Specification: Cboe_Europe_CEDX_BOE2_Specification.pdf
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
  id: cboe_dxederivatives_binaryorderentry_boe_v2_18
  title: Cboe DxeDerivatives BinaryOrderEntry Boe v2.18
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Europe Derivatives Europe Derivatives Binary Order Entry Boe v2.18'
doc-ref: https://www.cboe.com/europe/derivatives/support/technical

seq:
  - id: message_header
    type: message_header_struct
    doc: '10-byte BOE v2 message header. Every message starts with StartOfMessage = 0xBA 0xBA'
  - id: message
    size: message_header.message_length + 2 - 10
    type:
      switch-on: message_header.message_type
      cases:
        'message_type::login_request_v_2_message': login_request_v_2_message
        'message_type::login_response_v_2_message': login_response_v_2_message
        'message_type::logout_message': logout_message
        'message_type::new_order_v_2_message': new_order_v_2_message
        'message_type::new_order_cross_message': new_order_cross_message
        'message_type::new_complex_order_message': new_complex_order_message
        'message_type::new_order_cross_multileg_message': new_order_cross_multileg_message
        'message_type::cancel_order_v_2_message': cancel_order_v_2_message
        'message_type::modify_order_v_2_message': modify_order_v_2_message
        'message_type::quote_update_message': quote_update_message
        'message_type::purge_orders_message': purge_orders_message
        'message_type::reset_risk_message': reset_risk_message
        'message_type::new_complex_instrument_message': new_complex_instrument_message
        'message_type::trade_capture_report_v_2_message': trade_capture_report_v_2_message
        'message_type::order_acknowledgment_v_2_message': order_acknowledgment_v_2_message
        'message_type::cross_order_acknowledgment_message': cross_order_acknowledgment_message
        'message_type::quote_update_acknowledgment_message': quote_update_acknowledgment_message
        'message_type::order_rejected_v_2_message': order_rejected_v_2_message
        'message_type::cross_order_rejected_message': cross_order_rejected_message
        'message_type::quote_update_rejected_message': quote_update_rejected_message
        'message_type::order_modified_v_2_message': order_modified_v_2_message
        'message_type::order_restated_message': order_restated_message
        'message_type::quote_restated_message': quote_restated_message
        'message_type::user_modify_rejected_v_2_message': user_modify_rejected_v_2_message
        'message_type::order_cancelled_v_2_message': order_cancelled_v_2_message
        'message_type::quote_cancelled_message': quote_cancelled_message
        'message_type::cross_order_cancelled_message': cross_order_cancelled_message
        'message_type::cancel_rejected_v_2_message': cancel_rejected_v_2_message
        'message_type::order_execution_v_2_message': order_execution_v_2_message
        'message_type::quote_execution_message': quote_execution_message
        'message_type::trade_cancel_or_correct_v_2_message': trade_cancel_or_correct_v_2_message
        'message_type::purge_rejected_message': purge_rejected_message
        'message_type::reset_risk_acknowledgment_message': reset_risk_acknowledgment_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::complex_instrument_accepted_message': complex_instrument_accepted_message
        'message_type::complex_instrument_rejected_message': complex_instrument_rejected_message
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
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
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_clearing_account
      - id: price
        type: decimal_s8_4
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_new_order_v_2_bitfields >= 1 and new_order_v_2_bitfield_1.new_order_v_2_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_v_2_bitfields >= 2 and new_order_v_2_bitfield_2.new_order_v_2_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_account
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_v_2_bitfields >= 3 and new_order_v_2_bitfield_3.new_order_v_2_bitfield_3_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_v_2_bitfields >= 4 and new_order_v_2_bitfield_4.new_order_v_2_bitfield_4_risk_reset
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_new_order_v_2_bitfields >= 4 and new_order_v_2_bitfield_4.new_order_v_2_bitfield_4_open_close
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_new_order_v_2_bitfields >= 4 and new_order_v_2_bitfield_4.new_order_v_2_bitfield_4_liquidity_provision
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_client_id
      - id: investor_id
        type: u4
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_investor_id
      - id: executor_id
        type: u4
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_new_order_v_2_bitfields >= 5 and new_order_v_2_bitfield_5.new_order_v_2_bitfield_5_order_origination
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_v_2_bitfields >= 6 and new_order_v_2_bitfield_6.new_order_v_2_bitfield_6_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: auction_id
        type: u8
        if: number_of_new_order_v_2_bitfields >= 6 and new_order_v_2_bitfield_6.new_order_v_2_bitfield_6_auction_id
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_algorithmic_indicator
      - id: custom_group_id
        type: u2
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_custom_group_id
      - id: client_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_client_qualified_role
      - id: investor_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_new_order_v_2_bitfields >= 7 and new_order_v_2_bitfield_7.new_order_v_2_bitfield_7_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_new_order_v_2_bitfields >= 9 and new_order_v_2_bitfield_9.new_order_v_2_bitfield_9_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_new_order_v_2_bitfields >= 9 and new_order_v_2_bitfield_9.new_order_v_2_bitfield_9_account_type
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_order_v_2_bitfields >= 9 and new_order_v_2_bitfield_9.new_order_v_2_bitfield_9_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
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
  new_order_cross_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: number_of_new_order_cross_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_order_cross_bitfield_1
        type: new_order_cross_bitfield_1
        if: number_of_new_order_cross_bitfields >= 1
        doc: 'BitSet NewOrderCross byte 1'
      - id: new_order_cross_bitfield_2
        type: new_order_cross_bitfield_2
        if: number_of_new_order_cross_bitfields >= 2
        doc: 'BitSet NewOrderCross byte 2'
      - id: new_order_cross_bitfield_3
        type: new_order_cross_bitfield_3
        if: number_of_new_order_cross_bitfields >= 3
        doc: 'BitSet NewOrderCross byte 3'
      - id: num_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: order_allocations
        type: order_allocations
        repeat: expr
        repeat-expr: num_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_security_id
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_liquidity_provision
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_prevent_match
      - id: auto_match
        type: u1
        enum: auto_match
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_auto_match
      - id: auto_match_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_auto_match_price
        doc: 'Implied decimal with scale 1e-4'
      - id: last_priority
        type: u1
        enum: last_priority
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_last_priority
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
  new_order_cross_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_1_symbol
        type: b1
      - id: new_order_cross_bitfield_1_id_source
        type: b1
      - id: new_order_cross_bitfield_1_security_id
        type: b1
      - id: new_order_cross_bitfield_1_cust_order_handling_inst
        type: b1
      - id: new_order_cross_bitfield_1_liquidity_provision
        type: b1
      - id: new_order_cross_bitfield_1_order_origination
        type: b1
      - id: new_order_cross_bitfield_1_algorithmic_indicator
        type: b1
      - id: new_order_cross_bitfield_1_prevent_match
        type: b1
  new_order_cross_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_2_auto_match
        type: b1
      - id: new_order_cross_bitfield_2_auto_match_price
        type: b1
      - id: new_order_cross_bitfield_2_last_priority
        type: b1
      - id: new_order_cross_bitfield_2_account
        type: b1
      - id: new_order_cross_bitfield_2_reserved_16
        type: b1
      - id: new_order_cross_bitfield_2_clearing_account
        type: b1
      - id: new_order_cross_bitfield_2_client_id
        type: b1
      - id: new_order_cross_bitfield_2_client_qualified_role
        type: b1
  new_order_cross_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_3_investor_id
        type: b1
      - id: new_order_cross_bitfield_3_investor_qualified_role
        type: b1
      - id: new_order_cross_bitfield_3_executor_id
        type: b1
      - id: new_order_cross_bitfield_3_executor_qualified_role
        type: b1
      - id: new_order_cross_bitfield_3_open_close
        type: b1
      - id: new_order_cross_bitfield_3_drill_thru_protection
        type: b1
      - id: new_order_cross_bitfield_3_reserved_64
        type: b1
      - id: new_order_cross_bitfield_3_reserved_128
        type: b1
  order_allocations:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: alloc_qty
        type: u4
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: capacity
        type: u1
        enum: capacity
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: account_type
        type: u1
        enum: account_type
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_account
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_clearing_account
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_new_order_cross_bitfields >= 3 and _parent.new_order_cross_bitfield_3.new_order_cross_bitfield_3_open_close
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_new_order_cross_bitfields >= 1 and _parent.new_order_cross_bitfield_1.new_order_cross_bitfield_1_cust_order_handling_inst
      - id: order_origination
        type: u1
        enum: order_origination
        if: _parent.number_of_new_order_cross_bitfields >= 1 and _parent.new_order_cross_bitfield_1.new_order_cross_bitfield_1_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: _parent.number_of_new_order_cross_bitfields >= 1 and _parent.new_order_cross_bitfield_1.new_order_cross_bitfield_1_algorithmic_indicator
      - id: client_id
        type: u4
        enum: client_id
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_client_id
      - id: client_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_client_qualified_role
      - id: investor_id
        type: u4
        if: _parent.number_of_new_order_cross_bitfields >= 3 and _parent.new_order_cross_bitfield_3.new_order_cross_bitfield_3_investor_id
      - id: investor_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_bitfields >= 3 and _parent.new_order_cross_bitfield_3.new_order_cross_bitfield_3_investor_qualified_role
      - id: executor_id
        type: u4
        if: _parent.number_of_new_order_cross_bitfields >= 3 and _parent.new_order_cross_bitfield_3.new_order_cross_bitfield_3_executor_id
      - id: executor_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_bitfields >= 3 and _parent.new_order_cross_bitfield_3.new_order_cross_bitfield_3_executor_qualified_role
  new_complex_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: number_of_new_complex_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_complex_order_bitfield_1
        type: new_complex_order_bitfield_1
        if: number_of_new_complex_order_bitfields >= 1
        doc: 'BitSet NewComplexOrder byte 1'
      - id: new_complex_order_bitfield_2
        type: new_complex_order_bitfield_2
        if: number_of_new_complex_order_bitfields >= 2
        doc: 'BitSet NewComplexOrder byte 2'
      - id: new_complex_order_bitfield_3
        type: new_complex_order_bitfield_3
        if: number_of_new_complex_order_bitfields >= 3
        doc: 'BitSet NewComplexOrder byte 3'
      - id: new_complex_order_bitfield_4
        type: new_complex_order_bitfield_4
        if: number_of_new_complex_order_bitfields >= 4
        doc: 'BitSet NewComplexOrder byte 4'
      - id: new_complex_order_bitfield_5
        type: new_complex_order_bitfield_5
        if: number_of_new_complex_order_bitfields >= 5
        doc: 'BitSet NewComplexOrder byte 5'
      - id: new_complex_order_bitfield_6
        type: new_complex_order_bitfield_6
        if: number_of_new_complex_order_bitfields >= 6
        doc: 'BitSet NewComplexOrder byte 6'
      - id: new_complex_order_bitfield_7
        type: new_complex_order_bitfield_7
        if: number_of_new_complex_order_bitfields >= 7
        doc: 'BitSet NewComplexOrder byte 7'
      - id: num_complex_leg_order_info
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 13. However, for orders with AccountType value of 3 (House Trader), it is possible to specify 0 here. In that case, the repeating group ComplexLe- gOrderInfo should not follow, and the LegPosi- tionEffect is defaulted to None (“N”) for each leg'
      - id: complex_leg_order_info
        type: complex_leg_order_info
        repeat: expr
        repeat-expr: num_complex_leg_order_info
        doc: 'Repeating group stated NoLegs times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_account
      - id: price
        type: decimal_s8_4
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_time_in_force
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_capacity
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_routing_inst
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_account
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: auction_id
        type: u8
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_auction_id
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_risk_reset
      - id: custom_group_id
        type: u2
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_custom_group_id
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_liquidity_provision
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_algorithmic_indicator
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_client_id
      - id: client_qualified_role
        type: u1
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_client_qualified_role
      - id: investor_id
        type: u4
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_investor_id
      - id: investor_qualified_role
        type: u1
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_investor_qualified_role
      - id: executor_id
        type: u4
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_executor_id
      - id: executor_qualified_role
        type: u1
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_account_type
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_display_indicator
  new_complex_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_1_clearing_firm
        type: b1
      - id: new_complex_order_bitfield_1_clearing_account
        type: b1
      - id: new_complex_order_bitfield_1_price
        type: b1
      - id: new_complex_order_bitfield_1_ord_type
        type: b1
      - id: new_complex_order_bitfield_1_time_in_force
        type: b1
      - id: new_complex_order_bitfield_1_symbol
        type: b1
      - id: new_complex_order_bitfield_1_capacity
        type: b1
      - id: new_complex_order_bitfield_1_routing_inst
        type: b1
  new_complex_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_2_account
        type: b1
      - id: new_complex_order_bitfield_2_prevent_match
        type: b1
      - id: new_complex_order_bitfield_2_expire_time
        type: b1
      - id: new_complex_order_bitfield_2_cmta_number
        type: b1
      - id: new_complex_order_bitfield_2_target_party_id
        type: b1
      - id: new_complex_order_bitfield_2_attributed_quote
        type: b1
      - id: new_complex_order_bitfield_2_echo_text
        type: b1
      - id: new_complex_order_bitfield_2_auction_id
        type: b1
  new_complex_order_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_3_routing_firm_id
        type: b1
      - id: new_complex_order_bitfield_3_drill_thru_protection
        type: b1
      - id: new_complex_order_bitfield_3_risk_reset
        type: b1
      - id: new_complex_order_bitfield_3_custom_group_id
        type: b1
      - id: new_complex_order_bitfield_3_leg_side
        type: b1
      - id: new_complex_order_bitfield_3_equity_party_id
        type: b1
      - id: new_complex_order_bitfield_3_reserved_64
        type: b1
      - id: new_complex_order_bitfield_3_clearing_option_data
        type: b1
  new_complex_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_4_client_id_attr
        type: b1
      - id: new_complex_order_bitfield_4_frequent_trader_id
        type: b1
      - id: new_complex_order_bitfield_4_session_eligibility
        type: b1
      - id: new_complex_order_bitfield_4_max_floor
        type: b1
      - id: new_complex_order_bitfield_4_display_range
        type: b1
      - id: new_complex_order_bitfield_4_combo_order
        type: b1
      - id: new_complex_order_bitfield_4_compression
        type: b1
      - id: new_complex_order_bitfield_4_equity_ex_destination
        type: b1
  new_complex_order_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_5_equity_leg_short_sell
        type: b1
      - id: new_complex_order_bitfield_5_floor_destination
        type: b1
      - id: new_complex_order_bitfield_5_floor_routing_inst
        type: b1
      - id: new_complex_order_bitfield_5_multi_class_sprd
        type: b1
      - id: new_complex_order_bitfield_5_order_origin
        type: b1
      - id: new_complex_order_bitfield_5_ors
        type: b1
      - id: new_complex_order_bitfield_5_price_type
        type: b1
      - id: new_complex_order_bitfield_5_strategy_id
        type: b1
  new_complex_order_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_6_reserved_1
        type: b1
      - id: new_complex_order_bitfield_6_exec_inst
        type: b1
      - id: new_complex_order_bitfield_6_tied_hedge
        type: b1
      - id: new_complex_order_bitfield_6_liquidity_provision
        type: b1
      - id: new_complex_order_bitfield_6_order_origination
        type: b1
      - id: new_complex_order_bitfield_6_algorithmic_indicator
        type: b1
      - id: new_complex_order_bitfield_6_client_id
        type: b1
      - id: new_complex_order_bitfield_6_client_qualified_role
        type: b1
  new_complex_order_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_7_investor_id
        type: b1
      - id: new_complex_order_bitfield_7_investor_qualified_role
        type: b1
      - id: new_complex_order_bitfield_7_executor_id
        type: b1
      - id: new_complex_order_bitfield_7_executor_qualified_role
        type: b1
      - id: new_complex_order_bitfield_7_cust_order_handling_inst
        type: b1
      - id: new_complex_order_bitfield_7_account_type
        type: b1
      - id: new_complex_order_bitfield_7_display_indicator
        type: b1
      - id: new_complex_order_bitfield_7_reserved_128
        type: b1
  complex_leg_order_info:
    seq:
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Corresponds to LegPositionEffect (564) in Cboe FIX. Indicates status of client position in option for this leg. O = Open C = Close N = None Orders must specify LegPositionEffect. How- ever, orders with AccountType value of 3 (House Trader) may specify a value of “N” for each leg. For House Trader, this repeating group is only needed if a non-zero value of NoLegs is used'
  new_order_cross_multileg_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: number_of_new_order_cross_multileg_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_order_cross_multileg_bitfield_1
        type: new_order_cross_multileg_bitfield_1
        if: number_of_new_order_cross_multileg_bitfields >= 1
        doc: 'BitSet NewOrderCrossMultileg byte 1'
      - id: new_order_cross_multileg_bitfield_2
        type: new_order_cross_multileg_bitfield_2
        if: number_of_new_order_cross_multileg_bitfields >= 2
        doc: 'BitSet NewOrderCrossMultileg byte 2'
      - id: new_order_cross_multileg_bitfield_3
        type: new_order_cross_multileg_bitfield_3
        if: number_of_new_order_cross_multileg_bitfields >= 3
        doc: 'BitSet NewOrderCrossMultileg byte 3'
      - id: num_new_order_cross_multileg_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: new_order_cross_multileg_order_allocations
        type: new_order_cross_multileg_order_allocations
        repeat: expr
        repeat-expr: num_new_order_cross_multileg_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_symbol
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_liquidity_provision
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_prevent_match
      - id: auto_match
        type: u1
        enum: auto_match
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_auto_match
      - id: auto_match_price
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_auto_match_price
        doc: 'Implied decimal with scale 1e-4'
      - id: last_priority
        type: u1
        enum: last_priority
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_last_priority
  new_order_cross_multileg_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_1_symbol
        type: b1
      - id: new_order_cross_multileg_bitfield_1_id_source
        type: b1
      - id: new_order_cross_multileg_bitfield_1_security_id
        type: b1
      - id: new_order_cross_multileg_bitfield_1_cust_order_handling_inst
        type: b1
      - id: new_order_cross_multileg_bitfield_1_liquidity_provision
        type: b1
      - id: new_order_cross_multileg_bitfield_1_order_origination
        type: b1
      - id: new_order_cross_multileg_bitfield_1_algorithmic_indicator
        type: b1
      - id: new_order_cross_multileg_bitfield_1_prevent_match
        type: b1
  new_order_cross_multileg_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_2_auto_match
        type: b1
      - id: new_order_cross_multileg_bitfield_2_auto_match_price
        type: b1
      - id: new_order_cross_multileg_bitfield_2_last_priority
        type: b1
      - id: new_order_cross_multileg_bitfield_2_account
        type: b1
      - id: new_order_cross_multileg_bitfield_2_reserved_16
        type: b1
      - id: new_order_cross_multileg_bitfield_2_clearing_account
        type: b1
      - id: new_order_cross_multileg_bitfield_2_client_id
        type: b1
      - id: new_order_cross_multileg_bitfield_2_client_qualified_role
        type: b1
  new_order_cross_multileg_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_3_investor_id
        type: b1
      - id: new_order_cross_multileg_bitfield_3_investor_qualified_role
        type: b1
      - id: new_order_cross_multileg_bitfield_3_executor_id
        type: b1
      - id: new_order_cross_multileg_bitfield_3_executor_qualified_role
        type: b1
      - id: new_order_cross_multileg_bitfield_3_leg_position_effects
        type: b1
      - id: new_order_cross_multileg_bitfield_3_reserved_32
        type: b1
      - id: new_order_cross_multileg_bitfield_3_reserved_64
        type: b1
      - id: new_order_cross_multileg_bitfield_3_reserved_128
        type: b1
  new_order_cross_multileg_order_allocations:
    seq:
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: alloc_qty
        type: u4
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: capacity
        type: u1
        enum: capacity
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: account_type
        type: u1
        enum: account_type
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 2 and _parent.new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_account
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 2 and _parent.new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_clearing_account
      - id: leg_position_effects
        type: str
        size: 12
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_leg_position_effects
        doc: 'See List of Optional Fields (§ 6, p. 159)'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 1 and _parent.new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_cust_order_handling_inst
      - id: order_origination
        type: u1
        enum: order_origination
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 1 and _parent.new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 1 and _parent.new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_algorithmic_indicator
      - id: client_id
        type: u4
        enum: client_id
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 2 and _parent.new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_client_id
      - id: client_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 2 and _parent.new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_client_qualified_role
      - id: investor_id
        type: u4
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_investor_id
      - id: investor_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_investor_qualified_role
      - id: executor_id
        type: u4
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_executor_id
      - id: executor_qualified_role
        type: u1
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_executor_qualified_role
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
        if: number_of_cancel_order_v_2_bitfields >= 1 and cancel_order_v_2_bitfield_1.cancel_order_v_2_bitfield_1_clearing_firm
      - id: product_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_cancel_order_v_2_bitfields >= 1 and cancel_order_v_2_bitfield_1.cancel_order_v_2_bitfield_1_product_code
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_cancel_order_v_2_bitfields >= 1 and cancel_order_v_2_bitfield_1.cancel_order_v_2_bitfield_1_mass_cancel_id
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_cancel_order_v_2_bitfields >= 2 and cancel_order_v_2_bitfield_2.cancel_order_v_2_bitfield_2_mass_cancel_inst
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
      - id: cancel_order_v_2_bitfield_1_product_code
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
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
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_clearing_firm
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_ord_type
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        if: number_of_modify_order_v_2_bitfields >= 1 and modify_order_v_2_bitfield_1.modify_order_v_2_bitfield_1_cancel_orig_on_reject
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_v_2_bitfields >= 2 and modify_order_v_2_bitfield_2.modify_order_v_2_bitfield_2_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_modify_order_v_2_bitfields >= 2 and modify_order_v_2_bitfield_2.modify_order_v_2_bitfield_2_cust_order_handling_inst
  modify_order_v_2_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: modify_order_v_2_bitfield_1_clearing_firm
        type: b1
      - id: modify_order_v_2_bitfield_1_reserved_2
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
  quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: order_origination
        type: u1
        enum: order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: custom_group_id
        type: u2
      - id: capacity
        type: u1
        enum: capacity
      - id: client_id
        type: u4
        enum: client_id
      - id: client_qualified_role
        type: u1
      - id: executor_id
        type: u4
      - id: executor_qualified_role
        type: u1
      - id: investor_id
        type: u4
      - id: investor_qualified_role
        type: u1
      - id: account_type
        type: u1
        enum: account_type
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'P = Post Only (do not remove liquidity) B = Book Only (allow removal of liquidity, avail- able for Market Makers of futures only). Note that for options, only Post Only is sup- ported'
      - id: num_quote
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote
        type: quote
        repeat: expr
        repeat-expr: num_quote
        doc: 'Repeating group stated QuoteCnt times'
  quote:
    seq:
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Populate with Symbol for resets at the Product- Code level. Leave empty for resets at the Trading Firm level'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: open_close
        type: u1
        enum: open_close
      - id: price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
  purge_orders_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
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
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_clearing_firm
      - id: product_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_product_code
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_id
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
      - id: purge_orders_bitfield_1_product_code
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
      - id: purge_orders_bitfield_2_currency
        type: b1
      - id: purge_orders_bitfield_2_id_source
        type: b1
      - id: purge_orders_bitfield_2_security_id
        type: b1
      - id: purge_orders_bitfield_2_security_exchange
        type: b1
      - id: purge_orders_bitfield_2_reserved_64
        type: b1
      - id: purge_orders_bitfield_2_reserved_128
        type: b1
  custom_group_ids:
    seq:
      - id: custom_group_id
        type: u2
  reset_risk_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: Cboe only enforces uniqueness of RiskStatusID values among currently unac- knowledged requests. However, we strongly recommend that you keep your RiskSta- tusID values day-unique'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
      - id: reserved_4
        size: 4
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Populate with Symbol for resets at the Product- Code level. Leave empty for resets at the Trading Firm level'
      - id: custom_group_id
        type: u2
  new_complex_instrument_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: number_of_new_complex_instrument_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_complex_instrument_bitfield_1
        type: new_complex_instrument_bitfield_1
        if: number_of_new_complex_instrument_bitfields >= 1
        doc: 'BitSet NewComplexInstrument byte 1'
      - id: num_complex_leg
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 13. However, for orders with AccountType value of 3 (House Trader), it is possible to specify 0 here. In that case, the repeating group ComplexLe- gOrderInfo should not follow, and the LegPosi- tionEffect is defaulted to None (“N”) for each leg'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: num_complex_leg
        doc: 'Repeating group stated NoLegs times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_clearing_firm
      - id: leg_price
        type: decimal_s8_4
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_price
        doc: 'Corresponds to LegPrice (566) in Cboe FIX. Reference price for the future leg of a Volatility Strategy. Mandatory for this case, otherwise ig- nored. See the Volatility Strategies section (p. 7) for more details. Implied decimal with scale 1e-4'
  new_complex_instrument_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_instrument_bitfield_1_leg_cfi_code
        type: b1
      - id: new_complex_instrument_bitfield_1_leg_maturity_date
        type: b1
      - id: new_complex_instrument_bitfield_1_leg_strike_price
        type: b1
      - id: new_complex_instrument_bitfield_1_clearing_firm
        type: b1
      - id: new_complex_instrument_bitfield_1_reserved_16
        type: b1
      - id: new_complex_instrument_bitfield_1_leg_price
        type: b1
      - id: new_complex_instrument_bitfield_1_reserved_64
        type: b1
      - id: new_complex_instrument_bitfield_1_reserved_128
        type: b1
  complex_leg:
    seq:
      - id: leg_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'Corresponds to LegSymbol (600) in Cboe FIX'
      - id: leg_price
        type: decimal_s8_4
        doc: 'Corresponds to LegPrice (566) in Cboe FIX. Reference price for the future leg of a Volatility Strategy. Mandatory for this case, otherwise ig- nored. See the Volatility Strategies section (p. 7) for more details. Implied decimal with scale 1e-4'
      - id: leg_ratio_qty
        type: u4
        doc: 'Corresponds to LegRatioQty (623) in Cboe FIX. Ratio of number of contracts in this leg per order quantity. Must be between 1 and 99,999'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Corresponds to LegSide (624) in Cboe FIX. 1 = Buy 2 = Sell'
  trade_capture_report_v_2_message:
    seq:
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Note the use of Binary Price to represent positive and negative prices, which can occur with complex/spread instruments. Implied decimal with scale 1e-7'
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
      - id: no_sides
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_security_id
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 1 and trade_capture_report_v_2_bitfield_1.trade_capture_report_v_2_bitfield_1_exec_inst
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_account
      - id: transaction_category
        type: u1
        enum: transaction_category
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_transaction_category
      - id: trade_time
        type: nanosecond_timestamp
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_time
        doc: 'Nanoseconds since Unix epoch'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_party_role
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_report_trans_type
      - id: trade_id
        type: u8
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_trade_id
      - id: venue_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 2 and trade_capture_report_v_2_bitfield_2.trade_capture_report_v_2_bitfield_2_venue_type
      - id: match_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_match_type
      - id: trd_sub_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trd_sub_type
      - id: trade_publish_indicator
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 3 and trade_capture_report_v_2_bitfield_3.trade_capture_report_v_2_bitfield_3_trade_publish_indicator
      - id: trade_report_type
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_report_type
      - id: trade_handling_instruction
        type: u1
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_handling_instruction
      - id: trade_link_id
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_trade_link_id
      - id: gross_trade_amt
        type: decimal_s8_4
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_gross_trade_amt
        doc: 'Implied decimal with scale 1e-4'
      - id: tolerance
        type: u2
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_tolerance
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_trade_capture_report_v_2_bitfields >= 4 and trade_capture_report_v_2_bitfield_4.trade_capture_report_v_2_bitfield_4_order_category
      - id: price_formation
        type: str
        size: 1
        encoding: ASCII
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_price_formation
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_trade_capture_report_v_2_bitfields >= 5 and trade_capture_report_v_2_bitfield_5.trade_capture_report_v_2_bitfield_5_algorithmic_indicator
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_cust_order_handling_inst
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_open_close
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_trade_capture_report_v_2_bitfields >= 6 and trade_capture_report_v_2_bitfield_6.trade_capture_report_v_2_bitfield_6_account_type
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
      - id: trade_capture_report_v_2_bitfield_1_exec_inst
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
      - id: trade_capture_report_v_2_bitfield_6_reserved_8
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_16
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_32
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_64
        type: b1
      - id: trade_capture_report_v_2_bitfield_6_reserved_128
        type: b1
  order_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_v_2_return_bitfield_1.order_acknowledgment_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_acknowledgment_v_2_return_bitfield_2.order_acknowledgment_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_v_2_return_bitfield_3.order_acknowledgment_v_2_return_bitfield_3_prevent_match
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_acknowledgment_v_2_return_bitfield_4.order_acknowledgment_v_2_return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_last_shares
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_acknowledgment_v_2_return_bitfield_5.order_acknowledgment_v_2_return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_acknowledgment_v_2_return_bitfield_6.order_acknowledgment_v_2_return_bitfield_6_secondary_order_id
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and order_acknowledgment_v_2_return_bitfield_7.order_acknowledgment_v_2_return_bitfield_7_sub_liquidity_indicator
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_acknowledgment_v_2_return_bitfield_8.order_acknowledgment_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_acknowledgment_v_2_return_bitfield_8.order_acknowledgment_v_2_return_bitfield_8_routing_inst
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and order_acknowledgment_v_2_return_bitfield_9.order_acknowledgment_v_2_return_bitfield_9_auction_id
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_acknowledgment_v_2_return_bitfield_9.order_acknowledgment_v_2_return_bitfield_9_liquidity_provision
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_acknowledgment_v_2_return_bitfield_10.order_acknowledgment_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_acknowledgment_v_2_return_bitfield_11.order_acknowledgment_v_2_return_bitfield_11_executor_qualified_role
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_v_2_return_bitfield_13.order_acknowledgment_v_2_return_bitfield_13_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_acknowledgment_v_2_return_bitfield_17.order_acknowledgment_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_return_bitfields >= 18 and order_acknowledgment_v_2_return_bitfield_18.order_acknowledgment_v_2_return_bitfield_18_account_type
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
      - id: order_acknowledgment_v_2_return_bitfield_5_last_px
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
      - id: order_acknowledgment_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_acknowledgment_v_2_return_bitfield_18_reserved_128
        type: b1
  cross_order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: auction_id
        type: u8
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: cross_order_acknowledgment_return_bitfield_1
        type: cross_order_acknowledgment_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet CrossOrderAcknowledgment byte 1'
      - id: cross_order_acknowledgment_return_bitfield_2
        type: cross_order_acknowledgment_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet CrossOrderAcknowledgment byte 2'
      - id: cross_order_acknowledgment_return_bitfield_3
        type: cross_order_acknowledgment_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet CrossOrderAcknowledgment byte 3'
      - id: cross_order_acknowledgment_return_bitfield_4
        type: cross_order_acknowledgment_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet CrossOrderAcknowledgment byte 4'
      - id: cross_order_acknowledgment_return_bitfield_5
        type: cross_order_acknowledgment_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet CrossOrderAcknowledgment byte 5'
      - id: cross_order_acknowledgment_return_bitfield_6
        type: cross_order_acknowledgment_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet CrossOrderAcknowledgment byte 6'
      - id: cross_order_acknowledgment_return_bitfield_7
        type: cross_order_acknowledgment_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet CrossOrderAcknowledgment byte 7'
      - id: cross_order_acknowledgment_return_bitfield_8
        type: cross_order_acknowledgment_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet CrossOrderAcknowledgment byte 8'
      - id: cross_order_acknowledgment_return_bitfield_9
        type: cross_order_acknowledgment_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet CrossOrderAcknowledgment byte 9'
      - id: cross_order_acknowledgment_return_bitfield_10
        type: cross_order_acknowledgment_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet CrossOrderAcknowledgment byte 10'
      - id: cross_order_acknowledgment_return_bitfield_11
        type: cross_order_acknowledgment_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet CrossOrderAcknowledgment byte 11'
      - id: cross_order_acknowledgment_return_bitfield_12
        type: cross_order_acknowledgment_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet CrossOrderAcknowledgment byte 12'
      - id: cross_order_acknowledgment_return_bitfield_13
        type: cross_order_acknowledgment_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet CrossOrderAcknowledgment byte 13'
      - id: cross_order_acknowledgment_return_bitfield_14
        type: cross_order_acknowledgment_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet CrossOrderAcknowledgment byte 14'
      - id: cross_order_acknowledgment_return_bitfield_15
        type: cross_order_acknowledgment_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet CrossOrderAcknowledgment byte 15'
      - id: cross_order_acknowledgment_return_bitfield_16
        type: cross_order_acknowledgment_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet CrossOrderAcknowledgment byte 16'
      - id: cross_order_acknowledgment_return_bitfield_17
        type: cross_order_acknowledgment_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet CrossOrderAcknowledgment byte 17'
      - id: cross_order_acknowledgment_return_bitfield_18
        type: cross_order_acknowledgment_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet CrossOrderAcknowledgment byte 18'
      - id: num_cross_order_acknowledgment_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: cross_order_acknowledgment_order_allocations
        type: cross_order_acknowledgment_order_allocations
        repeat: expr
        repeat-expr: num_cross_order_acknowledgment_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_acknowledgment_return_bitfield_1.cross_order_acknowledgment_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_acknowledgment_return_bitfield_2.cross_order_acknowledgment_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_acknowledgment_return_bitfield_2.cross_order_acknowledgment_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_acknowledgment_return_bitfield_2.cross_order_acknowledgment_return_bitfield_2_security_id
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and cross_order_acknowledgment_return_bitfield_3.cross_order_acknowledgment_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cross_order_acknowledgment_return_bitfield_3.cross_order_acknowledgment_return_bitfield_3_prevent_match
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and cross_order_acknowledgment_return_bitfield_9.cross_order_acknowledgment_return_bitfield_9_liquidity_provision
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and cross_order_acknowledgment_return_bitfield_9.cross_order_acknowledgment_return_bitfield_9_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and cross_order_acknowledgment_return_bitfield_9.cross_order_acknowledgment_return_bitfield_9_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and cross_order_acknowledgment_return_bitfield_13.cross_order_acknowledgment_return_bitfield_13_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
  cross_order_acknowledgment_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_1_side
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_peg_difference
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_exec_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_ord_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_time_in_force
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_min_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_1_max_remove_pct
        type: b1
  cross_order_acknowledgment_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_2_symbol
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_symbol_sfx
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_currency
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_id_source
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_security_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_security_exchange
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_capacity
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_contra_trader
        type: b1
  cross_order_acknowledgment_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_3_account
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_clearing_firm
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_clearing_account
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_display_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_max_floor
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_discretion_amount
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_order_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_prevent_match
        type: b1
  cross_order_acknowledgment_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_4_maturity_date
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_strike_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_put_or_call
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_open_close
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_corrected_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_party_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_access_fee
        type: b1
  cross_order_acknowledgment_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_leaves_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_last_shares
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_last_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_display_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_working_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_expire_time
        type: b1
  cross_order_acknowledgment_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_6_secondary_order_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_ccp
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_contra_capacity
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_attributed_quote
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_ext_exec_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_bulk_order_ids
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_party_role
        type: b1
  cross_order_acknowledgment_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_trade_report_type_return
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_text
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_bid
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_offer
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_large_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_last_mkt
        type: b1
  cross_order_acknowledgment_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_8_fee_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_echo_text
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_stop_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_routing_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_rout_strategy
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_route_delivery_method
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_ex_destination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_trade_report_ref_id
        type: b1
  cross_order_acknowledgment_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_9_marketing_fee_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_target_party_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_auction_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_order_category
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_liquidity_provision
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_cmta_number
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_cross_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_cross_prioritization
        type: b1
  cross_order_acknowledgment_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_10_cross_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_alloc_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_give_up_firm_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_routing_firm_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_waiver_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_price_formation
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_client_qualified_role
        type: b1
  cross_order_acknowledgment_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_11_client_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_investor_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_executor_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_order_origination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_deferral_reason
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_investor_qualified_role
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_executor_qualified_role
        type: b1
  cross_order_acknowledgment_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_12_cti_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_manual_order_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_operator_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_trade_date
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_clearing_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_clearing_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_clearing_symbol
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_clearing_optional_data
        type: b1
  cross_order_acknowledgment_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_13_cum_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_day_order_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_day_cum_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_avg_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_day_avg_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_pending_status
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_drill_thru_protection
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_multileg_reporting_type
        type: b1
  cross_order_acknowledgment_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_14_leg_cfi_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_leg_maturity_date
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_leg_strike_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_quote_room_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_user_request_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_username
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_user_status
        type: b1
  cross_order_acknowledgment_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_equity_party_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_mass_cancel_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_trade_publish_ind
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_report_time
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_15_client_id_attr
        type: b1
  cross_order_acknowledgment_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_16_frequent_trader_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_session_eligibility
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_combo_order
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_compression
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_floor_destination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_floor_routing_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_multi_class_spread
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_16_order_origin
        type: b1
  cross_order_acknowledgment_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_17_price_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_strategy_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_trading_session_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_sender_location_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_17_cust_order_handling_inst
        type: b1
  cross_order_acknowledgment_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_18_account_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_cross_initiator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_subreason
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_8
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_16
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_32
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_64
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_128
        type: b1
  cross_order_acknowledgment_order_allocations:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.cross_order_acknowledgment_return_bitfield_1.cross_order_acknowledgment_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: alloc_qty
        type: u4
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_alloc_qty
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.cross_order_acknowledgment_return_bitfield_2.cross_order_acknowledgment_return_bitfield_2_capacity
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.cross_order_acknowledgment_return_bitfield_4.cross_order_acknowledgment_return_bitfield_4_open_close
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_acknowledgment_return_bitfield_3.cross_order_acknowledgment_return_bitfield_3_account
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_acknowledgment_return_bitfield_3.cross_order_acknowledgment_return_bitfield_3_clearing_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_acknowledgment_return_bitfield_3.cross_order_acknowledgment_return_bitfield_3_clearing_firm
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.cross_order_acknowledgment_return_bitfield_17.cross_order_acknowledgment_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.cross_order_acknowledgment_return_bitfield_18.cross_order_acknowledgment_return_bitfield_18_account_type
      - id: order_origination
        type: u1
        enum: order_origination
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_algorithmic_indicator
      - id: client_id
        type: u4
        enum: client_id
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_client_id
      - id: client_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_client_qualified_role
      - id: investor_id
        type: u4
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_investor_id
      - id: investor_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_investor_qualified_role
      - id: executor_id
        type: u4
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_executor_id
      - id: executor_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_executor_qualified_role
  quote_update_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Up- date message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0. <space> = Success See Quote Reason Codes (§ 7.2, p. 176) for a list of possible quote reject codes. Additional reasons may be added in the future without warning'
      - id: reserved_17
        size: 17
        doc: 'Reserved for Cboe internal use. Filled with 0'
      - id: num_quote_update_acknowledgment_quote
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote_update_acknowledgment_quote
        type: quote_update_acknowledgment_quote
        repeat: expr
        repeat-expr: num_quote_update_acknowledgment_quote
        doc: 'Repeating group stated QuoteCnt times'
  quote_update_acknowledgment_quote:
    seq:
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result of the quote request. Acceptance: A = New Quote L = Modified; loss of priority R = Modified; retains priority (size reduction) N = No change, matches existing quote D = New Quote, but may remove liquidity d = Modified, but may remove liquidity Cancellation: U = User cancelled (zero size/price requested) Rejection: a = Admin P = Rejected, cannot post f = Risk management firm or Custom Group ID level S = Rejected, symbol not found p = Rejected, invalid price r = Invalid Remove s = Risk management underlying level u = Rejected, other reason Additional reasons indicating a reject may be added in the future with no notice'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: subreason
        type: u1
        enum: subreason
      - id: reserved_5
        size: 5
        doc: 'Reserved for Cboe internal use. Filled with 0'
  order_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_rejected_v_2_return_bitfield_1.order_rejected_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_rejected_v_2_return_bitfield_2.order_rejected_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_v_2_return_bitfield_3.order_rejected_v_2_return_bitfield_3_prevent_match
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_rejected_v_2_return_bitfield_4.order_rejected_v_2_return_bitfield_4_open_close
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_rejected_v_2_return_bitfield_6.order_rejected_v_2_return_bitfield_6_secondary_order_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_rejected_v_2_return_bitfield_8.order_rejected_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_rejected_v_2_return_bitfield_8.order_rejected_v_2_return_bitfield_8_routing_inst
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_rejected_v_2_return_bitfield_9.order_rejected_v_2_return_bitfield_9_liquidity_provision
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_rejected_v_2_return_bitfield_10.order_rejected_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_rejected_v_2_return_bitfield_11.order_rejected_v_2_return_bitfield_11_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_rejected_v_2_return_bitfield_17.order_rejected_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_return_bitfields >= 18 and order_rejected_v_2_return_bitfield_18.order_rejected_v_2_return_bitfield_18_account_type
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 18 and order_rejected_v_2_return_bitfield_18.order_rejected_v_2_return_bitfield_18_subreason
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
      - id: order_rejected_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_rejected_v_2_return_bitfield_18_reserved_128
        type: b1
  cross_order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: cross_order_rejected_return_bitfield_1
        type: cross_order_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet CrossOrderRejected byte 1'
      - id: cross_order_rejected_return_bitfield_2
        type: cross_order_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet CrossOrderRejected byte 2'
      - id: cross_order_rejected_return_bitfield_3
        type: cross_order_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet CrossOrderRejected byte 3'
      - id: cross_order_rejected_return_bitfield_4
        type: cross_order_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet CrossOrderRejected byte 4'
      - id: cross_order_rejected_return_bitfield_5
        type: cross_order_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet CrossOrderRejected byte 5'
      - id: cross_order_rejected_return_bitfield_6
        type: cross_order_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet CrossOrderRejected byte 6'
      - id: cross_order_rejected_return_bitfield_7
        type: cross_order_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet CrossOrderRejected byte 7'
      - id: cross_order_rejected_return_bitfield_8
        type: cross_order_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet CrossOrderRejected byte 8'
      - id: cross_order_rejected_return_bitfield_9
        type: cross_order_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet CrossOrderRejected byte 9'
      - id: cross_order_rejected_return_bitfield_10
        type: cross_order_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet CrossOrderRejected byte 10'
      - id: cross_order_rejected_return_bitfield_11
        type: cross_order_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet CrossOrderRejected byte 11'
      - id: cross_order_rejected_return_bitfield_12
        type: cross_order_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet CrossOrderRejected byte 12'
      - id: cross_order_rejected_return_bitfield_13
        type: cross_order_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet CrossOrderRejected byte 13'
      - id: cross_order_rejected_return_bitfield_14
        type: cross_order_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet CrossOrderRejected byte 14'
      - id: cross_order_rejected_return_bitfield_15
        type: cross_order_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet CrossOrderRejected byte 15'
      - id: cross_order_rejected_return_bitfield_16
        type: cross_order_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet CrossOrderRejected byte 16'
      - id: cross_order_rejected_return_bitfield_17
        type: cross_order_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet CrossOrderRejected byte 17'
      - id: cross_order_rejected_return_bitfield_18
        type: cross_order_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet CrossOrderRejected byte 18'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_rejected_return_bitfield_1.cross_order_rejected_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_rejected_return_bitfield_2.cross_order_rejected_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_rejected_return_bitfield_2.cross_order_rejected_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_rejected_return_bitfield_2.cross_order_rejected_return_bitfield_2_security_id
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and cross_order_rejected_return_bitfield_3.cross_order_rejected_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cross_order_rejected_return_bitfield_3.cross_order_rejected_return_bitfield_3_prevent_match
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and cross_order_rejected_return_bitfield_9.cross_order_rejected_return_bitfield_9_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and cross_order_rejected_return_bitfield_9.cross_order_rejected_return_bitfield_9_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 18 and cross_order_rejected_return_bitfield_18.cross_order_rejected_return_bitfield_18_subreason
  cross_order_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_1_side
        type: b1
      - id: cross_order_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: cross_order_rejected_return_bitfield_1_price
        type: b1
      - id: cross_order_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_1_ord_type
        type: b1
      - id: cross_order_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: cross_order_rejected_return_bitfield_1_min_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_1_max_remove_pct
        type: b1
  cross_order_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_2_symbol
        type: b1
      - id: cross_order_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: cross_order_rejected_return_bitfield_2_currency
        type: b1
      - id: cross_order_rejected_return_bitfield_2_id_source
        type: b1
      - id: cross_order_rejected_return_bitfield_2_security_id
        type: b1
      - id: cross_order_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: cross_order_rejected_return_bitfield_2_capacity
        type: b1
      - id: cross_order_rejected_return_bitfield_2_contra_trader
        type: b1
  cross_order_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_3_account
        type: b1
      - id: cross_order_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: cross_order_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: cross_order_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_3_max_floor
        type: b1
      - id: cross_order_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: cross_order_rejected_return_bitfield_3_order_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_3_prevent_match
        type: b1
  cross_order_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: cross_order_rejected_return_bitfield_4_strike_price
        type: b1
      - id: cross_order_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: cross_order_rejected_return_bitfield_4_open_close
        type: b1
      - id: cross_order_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: cross_order_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: cross_order_rejected_return_bitfield_4_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_4_access_fee
        type: b1
  cross_order_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: cross_order_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_5_last_shares
        type: b1
      - id: cross_order_rejected_return_bitfield_5_last_price
        type: b1
      - id: cross_order_rejected_return_bitfield_5_display_price
        type: b1
      - id: cross_order_rejected_return_bitfield_5_working_price
        type: b1
      - id: cross_order_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_5_expire_time
        type: b1
  cross_order_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: cross_order_rejected_return_bitfield_6_ccp
        type: b1
      - id: cross_order_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: cross_order_rejected_return_bitfield_6_attributed_quote
        type: b1
      - id: cross_order_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: cross_order_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: cross_order_rejected_return_bitfield_6_party_role
        type: b1
  cross_order_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: cross_order_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: cross_order_rejected_return_bitfield_7_text
        type: b1
      - id: cross_order_rejected_return_bitfield_7_bid
        type: b1
      - id: cross_order_rejected_return_bitfield_7_offer
        type: b1
      - id: cross_order_rejected_return_bitfield_7_large_size
        type: b1
      - id: cross_order_rejected_return_bitfield_7_last_mkt
        type: b1
  cross_order_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_8_fee_code
        type: b1
      - id: cross_order_rejected_return_bitfield_8_echo_text
        type: b1
      - id: cross_order_rejected_return_bitfield_8_stop_px
        type: b1
      - id: cross_order_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: cross_order_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: cross_order_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: cross_order_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  cross_order_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: cross_order_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_9_auction_id
        type: b1
      - id: cross_order_rejected_return_bitfield_9_order_category
        type: b1
      - id: cross_order_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: cross_order_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: cross_order_rejected_return_bitfield_9_cross_type
        type: b1
      - id: cross_order_rejected_return_bitfield_9_cross_prioritization
        type: b1
  cross_order_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_10_cross_id
        type: b1
      - id: cross_order_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: cross_order_rejected_return_bitfield_10_routing_firm_id
        type: b1
      - id: cross_order_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: cross_order_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_10_price_formation
        type: b1
      - id: cross_order_rejected_return_bitfield_10_client_qualified_role
        type: b1
  cross_order_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_11_client_id
        type: b1
      - id: cross_order_rejected_return_bitfield_11_investor_id
        type: b1
      - id: cross_order_rejected_return_bitfield_11_executor_id
        type: b1
      - id: cross_order_rejected_return_bitfield_11_order_origination
        type: b1
      - id: cross_order_rejected_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: cross_order_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: cross_order_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  cross_order_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_12_cti_code
        type: b1
      - id: cross_order_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_12_operator_id
        type: b1
      - id: cross_order_rejected_return_bitfield_12_trade_date
        type: b1
      - id: cross_order_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: cross_order_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: cross_order_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: cross_order_rejected_return_bitfield_12_clearing_optional_data
        type: b1
  cross_order_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_13_avg_px
        type: b1
      - id: cross_order_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: cross_order_rejected_return_bitfield_13_pending_status
        type: b1
      - id: cross_order_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: cross_order_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  cross_order_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: cross_order_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: cross_order_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: cross_order_rejected_return_bitfield_14_quote_room_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_username
        type: b1
      - id: cross_order_rejected_return_bitfield_14_user_status
        type: b1
  cross_order_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: cross_order_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: cross_order_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: cross_order_rejected_return_bitfield_15_report_time
        type: b1
      - id: cross_order_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: cross_order_rejected_return_bitfield_15_client_id_attr
        type: b1
  cross_order_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: cross_order_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: cross_order_rejected_return_bitfield_16_combo_order
        type: b1
      - id: cross_order_rejected_return_bitfield_16_compression
        type: b1
      - id: cross_order_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: cross_order_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_16_multi_class_spread
        type: b1
      - id: cross_order_rejected_return_bitfield_16_order_origin
        type: b1
  cross_order_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_17_price_type
        type: b1
      - id: cross_order_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: cross_order_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: cross_order_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: cross_order_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: cross_order_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: cross_order_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: cross_order_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  cross_order_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_18_account_type
        type: b1
      - id: cross_order_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: cross_order_rejected_return_bitfield_18_subreason
        type: b1
      - id: cross_order_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: cross_order_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: cross_order_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: cross_order_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: cross_order_rejected_return_bitfield_18_reserved_128
        type: b1
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Up- date message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0. <space> = Success See Quote Reason Codes (§ 7.2, p. 176) for a list of possible quote reject codes. Additional reasons may be added in the future without warning'
      - id: reserved_17
        size: 17
        doc: 'Reserved for Cboe internal use. Filled with 0'
  order_modified_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_modified_v_2_return_bitfield_1.order_modified_v_2_return_bitfield_1_min_qty
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_v_2_return_bitfield_3.order_modified_v_2_return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_last_shares
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_modified_v_2_return_bitfield_5.order_modified_v_2_return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_modified_v_2_return_bitfield_6.order_modified_v_2_return_bitfield_6_secondary_order_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_modified_v_2_return_bitfield_8.order_modified_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_modified_v_2_return_bitfield_8.order_modified_v_2_return_bitfield_8_routing_inst
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and order_modified_v_2_return_bitfield_9.order_modified_v_2_return_bitfield_9_auction_id
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_modified_v_2_return_bitfield_9.order_modified_v_2_return_bitfield_9_liquidity_provision
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_modified_v_2_return_bitfield_10.order_modified_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_modified_v_2_return_bitfield_11.order_modified_v_2_return_bitfield_11_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_modified_v_2_return_bitfield_17.order_modified_v_2_return_bitfield_17_cust_order_handling_inst
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
      - id: order_modified_v_2_return_bitfield_5_last_px
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
      - id: order_modified_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_modified_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_modified_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_modified_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_modified_v_2_return_bitfield_18_reserved_128
        type: b1
  order_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. Q = Liquidity Updated Cboe reserves the right to add new values as necessary without prior notice'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_restated_v_2_return_bitfield_1.order_restated_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_restated_v_2_return_bitfield_2.order_restated_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_restated_v_2_return_bitfield_3.order_restated_v_2_return_bitfield_3_prevent_match
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_restated_v_2_return_bitfield_4.order_restated_v_2_return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_last_shares
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_restated_v_2_return_bitfield_5.order_restated_v_2_return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_restated_v_2_return_bitfield_6.order_restated_v_2_return_bitfield_6_secondary_order_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_restated_v_2_return_bitfield_8.order_restated_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_restated_v_2_return_bitfield_8.order_restated_v_2_return_bitfield_8_routing_inst
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_restated_v_2_return_bitfield_9.order_restated_v_2_return_bitfield_9_liquidity_provision
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_restated_v_2_return_bitfield_10.order_restated_v_2_return_bitfield_10_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_restated_v_2_return_bitfield_10.order_restated_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_restated_v_2_return_bitfield_11.order_restated_v_2_return_bitfield_11_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_restated_v_2_return_bitfield_17.order_restated_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_return_bitfields >= 18 and order_restated_v_2_return_bitfield_18.order_restated_v_2_return_bitfield_18_account_type
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
      - id: order_restated_v_2_return_bitfield_5_last_px
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
      - id: order_restated_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_restated_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_restated_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_restated_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_restated_v_2_return_bitfield_18_reserved_128
        type: b1
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: leaves_qty
        type: u4
      - id: working_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Populate with Symbol for resets at the Product- Code level. Leave empty for resets at the Trading Firm level'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. Q = Liquidity Updated Cboe reserves the right to add new values as necessary without prior notice'
  user_modify_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: user_modify_rejected_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: user_modify_rejected_v_2_return_bitfield_18_reserved_128
        type: b1
  order_cancelled_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_cancelled_v_2_return_bitfield_1.order_cancelled_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_cancelled_v_2_return_bitfield_2.order_cancelled_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_v_2_return_bitfield_3.order_cancelled_v_2_return_bitfield_3_prevent_match
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_cancelled_v_2_return_bitfield_4.order_cancelled_v_2_return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_last_shares
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_cancelled_v_2_return_bitfield_5.order_cancelled_v_2_return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_cancelled_v_2_return_bitfield_6.order_cancelled_v_2_return_bitfield_6_secondary_order_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_cancelled_v_2_return_bitfield_8.order_cancelled_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_cancelled_v_2_return_bitfield_8.order_cancelled_v_2_return_bitfield_8_routing_inst
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and order_cancelled_v_2_return_bitfield_9.order_cancelled_v_2_return_bitfield_9_liquidity_provision
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_cancelled_v_2_return_bitfield_10.order_cancelled_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_cancelled_v_2_return_bitfield_11.order_cancelled_v_2_return_bitfield_11_executor_qualified_role
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_cancelled_v_2_return_bitfield_17.order_cancelled_v_2_return_bitfield_17_cust_order_handling_inst
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 18 and order_cancelled_v_2_return_bitfield_18.order_cancelled_v_2_return_bitfield_18_subreason
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
      - id: order_cancelled_v_2_return_bitfield_5_last_px
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
      - id: order_cancelled_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_cancelled_v_2_return_bitfield_18_reserved_128
        type: b1
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Populate with Symbol for resets at the Product- Code level. Leave empty for resets at the Trading Firm level'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
      - id: cancel_subreason
        type: u1
        enum: cancel_subreason
        doc: 'Additional detail for a quote cancellation. See Subreason Codes (§ 7.3, p. 177) for a list of possible subreasons'
  cross_order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: cross_order_cancelled_return_bitfield_1
        type: cross_order_cancelled_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet CrossOrderCancelled byte 1'
      - id: cross_order_cancelled_return_bitfield_2
        type: cross_order_cancelled_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet CrossOrderCancelled byte 2'
      - id: cross_order_cancelled_return_bitfield_3
        type: cross_order_cancelled_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet CrossOrderCancelled byte 3'
      - id: cross_order_cancelled_return_bitfield_4
        type: cross_order_cancelled_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet CrossOrderCancelled byte 4'
      - id: cross_order_cancelled_return_bitfield_5
        type: cross_order_cancelled_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet CrossOrderCancelled byte 5'
      - id: cross_order_cancelled_return_bitfield_6
        type: cross_order_cancelled_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet CrossOrderCancelled byte 6'
      - id: cross_order_cancelled_return_bitfield_7
        type: cross_order_cancelled_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet CrossOrderCancelled byte 7'
      - id: cross_order_cancelled_return_bitfield_8
        type: cross_order_cancelled_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet CrossOrderCancelled byte 8'
      - id: cross_order_cancelled_return_bitfield_9
        type: cross_order_cancelled_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet CrossOrderCancelled byte 9'
      - id: cross_order_cancelled_return_bitfield_10
        type: cross_order_cancelled_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet CrossOrderCancelled byte 10'
      - id: cross_order_cancelled_return_bitfield_11
        type: cross_order_cancelled_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet CrossOrderCancelled byte 11'
      - id: cross_order_cancelled_return_bitfield_12
        type: cross_order_cancelled_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet CrossOrderCancelled byte 12'
      - id: cross_order_cancelled_return_bitfield_13
        type: cross_order_cancelled_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet CrossOrderCancelled byte 13'
      - id: cross_order_cancelled_return_bitfield_14
        type: cross_order_cancelled_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet CrossOrderCancelled byte 14'
      - id: cross_order_cancelled_return_bitfield_15
        type: cross_order_cancelled_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet CrossOrderCancelled byte 15'
      - id: cross_order_cancelled_return_bitfield_16
        type: cross_order_cancelled_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet CrossOrderCancelled byte 16'
      - id: cross_order_cancelled_return_bitfield_17
        type: cross_order_cancelled_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet CrossOrderCancelled byte 17'
      - id: cross_order_cancelled_return_bitfield_18
        type: cross_order_cancelled_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet CrossOrderCancelled byte 18'
      - id: num_cross_order_cancelled_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: cross_order_cancelled_order_allocations
        type: cross_order_cancelled_order_allocations
        repeat: expr
        repeat-expr: num_cross_order_cancelled_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_cancelled_return_bitfield_1.cross_order_cancelled_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_cancelled_return_bitfield_2.cross_order_cancelled_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_cancelled_return_bitfield_2.cross_order_cancelled_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_cancelled_return_bitfield_2.cross_order_cancelled_return_bitfield_2_security_id
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_prevent_match
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_auction_id
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_liquidity_provision
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
  cross_order_cancelled_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_1_side
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_peg_difference
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_exec_inst
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_ord_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_time_in_force
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_min_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_1_max_remove_pct
        type: b1
  cross_order_cancelled_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_2_symbol
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_symbol_sfx
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_currency
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_id_source
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_security_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_security_exchange
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_capacity
        type: b1
      - id: cross_order_cancelled_return_bitfield_2_contra_trader
        type: b1
  cross_order_cancelled_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_3_account
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_clearing_firm
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_clearing_account
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_display_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_max_floor
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_discretion_amount
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_order_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_3_prevent_match
        type: b1
  cross_order_cancelled_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_4_maturity_date
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_strike_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_put_or_call
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_open_close
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_corrected_size
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_party_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_4_access_fee
        type: b1
  cross_order_cancelled_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_leaves_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_last_shares
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_last_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_display_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_working_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_5_expire_time
        type: b1
  cross_order_cancelled_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_6_secondary_order_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_ccp
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_contra_capacity
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_attributed_quote
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_ext_exec_inst
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_bulk_order_ids
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_party_role
        type: b1
  cross_order_cancelled_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_trade_report_type_return
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_text
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_bid
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_offer
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_large_size
        type: b1
      - id: cross_order_cancelled_return_bitfield_7_last_mkt
        type: b1
  cross_order_cancelled_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_8_fee_code
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_echo_text
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_stop_px
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_routing_inst
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_rout_strategy
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_route_delivery_method
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_ex_destination
        type: b1
      - id: cross_order_cancelled_return_bitfield_8_trade_report_ref_id
        type: b1
  cross_order_cancelled_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_9_marketing_fee_code
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_target_party_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_auction_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_order_category
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_liquidity_provision
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_cmta_number
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_cross_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_9_cross_prioritization
        type: b1
  cross_order_cancelled_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_10_cross_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_alloc_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_give_up_firm_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_routing_firm_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_waiver_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_price_formation
        type: b1
      - id: cross_order_cancelled_return_bitfield_10_client_qualified_role
        type: b1
  cross_order_cancelled_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_11_client_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_investor_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_executor_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_order_origination
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_deferral_reason
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_investor_qualified_role
        type: b1
      - id: cross_order_cancelled_return_bitfield_11_executor_qualified_role
        type: b1
  cross_order_cancelled_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_12_cti_code
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_manual_order_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_operator_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_trade_date
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_clearing_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_clearing_size
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_clearing_symbol
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_clearing_optional_data
        type: b1
  cross_order_cancelled_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_13_cum_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_day_order_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_day_cum_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_avg_px
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_day_avg_px
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_pending_status
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_drill_thru_protection
        type: b1
      - id: cross_order_cancelled_return_bitfield_13_multileg_reporting_type
        type: b1
  cross_order_cancelled_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_14_leg_cfi_code
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_leg_maturity_date
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_leg_strike_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_quote_room_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_user_request_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_username
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_user_status
        type: b1
  cross_order_cancelled_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_equity_party_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_mass_cancel_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_trade_publish_ind
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_report_time
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: cross_order_cancelled_return_bitfield_15_client_id_attr
        type: b1
  cross_order_cancelled_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_16_frequent_trader_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_session_eligibility
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_combo_order
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_compression
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_floor_destination
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_floor_routing_inst
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_multi_class_spread
        type: b1
      - id: cross_order_cancelled_return_bitfield_16_order_origin
        type: b1
  cross_order_cancelled_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_17_price_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_strategy_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_trading_session_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_sender_location_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: cross_order_cancelled_return_bitfield_17_cust_order_handling_inst
        type: b1
  cross_order_cancelled_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_18_account_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_cross_initiator
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_subreason
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_reserved_8
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_reserved_16
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_reserved_32
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_reserved_64
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_reserved_128
        type: b1
  cross_order_cancelled_order_allocations:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.cross_order_cancelled_return_bitfield_1.cross_order_cancelled_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: alloc_qty
        type: u4
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_cancelled_return_bitfield_10.cross_order_cancelled_return_bitfield_10_alloc_qty
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.cross_order_cancelled_return_bitfield_2.cross_order_cancelled_return_bitfield_2_capacity
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.cross_order_cancelled_return_bitfield_4.cross_order_cancelled_return_bitfield_4_open_close
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_account
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_clearing_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_clearing_firm
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.cross_order_cancelled_return_bitfield_17.cross_order_cancelled_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.cross_order_cancelled_return_bitfield_18.cross_order_cancelled_return_bitfield_18_account_type
      - id: order_origination
        type: u1
        enum: order_origination
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_algorithmic_indicator
      - id: client_id
        type: u4
        enum: client_id
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_client_id
      - id: client_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_cancelled_return_bitfield_10.cross_order_cancelled_return_bitfield_10_client_qualified_role
      - id: investor_id
        type: u4
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_investor_id
      - id: investor_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_investor_qualified_role
      - id: executor_id
        type: u4
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_executor_id
      - id: executor_qualified_role
        type: u1
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_cancelled_return_bitfield_11.cross_order_cancelled_return_bitfield_11_executor_qualified_role
  cancel_rejected_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason for a cancel rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and cancel_rejected_v_2_return_bitfield_1.cancel_rejected_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and cancel_rejected_v_2_return_bitfield_2.cancel_rejected_v_2_return_bitfield_2_capacity
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and cancel_rejected_v_2_return_bitfield_4.cancel_rejected_v_2_return_bitfield_4_open_close
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and cancel_rejected_v_2_return_bitfield_8.cancel_rejected_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and cancel_rejected_v_2_return_bitfield_9.cancel_rejected_v_2_return_bitfield_9_liquidity_provision
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and cancel_rejected_v_2_return_bitfield_10.cancel_rejected_v_2_return_bitfield_10_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and cancel_rejected_v_2_return_bitfield_10.cancel_rejected_v_2_return_bitfield_10_alloc_qty
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and cancel_rejected_v_2_return_bitfield_10.cancel_rejected_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and cancel_rejected_v_2_return_bitfield_11.cancel_rejected_v_2_return_bitfield_11_executor_qualified_role
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and cancel_rejected_v_2_return_bitfield_15.cancel_rejected_v_2_return_bitfield_15_mass_cancel_id
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
      - id: cancel_rejected_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: cancel_rejected_v_2_return_bitfield_18_reserved_128
        type: b1
  order_execution_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be rep- resented on ODROP, FIXDROP and standard DROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_execution_v_2_return_bitfield_1.order_execution_v_2_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_execution_v_2_return_bitfield_2.order_execution_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_clearing_account
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_display_indicator
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_v_2_return_bitfield_3.order_execution_v_2_return_bitfield_3_prevent_match
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_execution_v_2_return_bitfield_4.order_execution_v_2_return_bitfield_4_open_close
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_execution_v_2_return_bitfield_7.order_execution_v_2_return_bitfield_7_last_mkt
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_v_2_return_bitfield_8.order_execution_v_2_return_bitfield_8_fee_code
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_execution_v_2_return_bitfield_8.order_execution_v_2_return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_v_2_return_bitfield_8.order_execution_v_2_return_bitfield_8_routing_inst
      - id: cross_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_execution_v_2_return_bitfield_9.order_execution_v_2_return_bitfield_9_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and order_execution_v_2_return_bitfield_9.order_execution_v_2_return_bitfield_9_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be pri- oritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_v_2_return_bitfield_10.order_execution_v_2_return_bitfield_10_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33– 126 are allowed, except for comma, semicolon, and pipe'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and order_execution_v_2_return_bitfield_10.order_execution_v_2_return_bitfield_10_alloc_qty
      - id: client_qualified_role
        type: u1
        if: number_of_return_bitfields >= 10 and order_execution_v_2_return_bitfield_10.order_execution_v_2_return_bitfield_10_client_qualified_role
      - id: client_id
        type: u4
        enum: client_id
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_client_id
      - id: investor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_investor_id
      - id: executor_id
        type: u4
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_executor_id
      - id: order_origination
        type: u1
        enum: order_origination
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_order_origination
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_algorithmic_indicator
      - id: investor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_investor_qualified_role
      - id: executor_qualified_role
        type: u1
        if: number_of_return_bitfields >= 11 and order_execution_v_2_return_bitfield_11.order_execution_v_2_return_bitfield_11_executor_qualified_role
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_execution_v_2_return_bitfield_13.order_execution_v_2_return_bitfield_13_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_return_bitfields >= 13 and order_execution_v_2_return_bitfield_13.order_execution_v_2_return_bitfield_13_multileg_reporting_type
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and order_execution_v_2_return_bitfield_14.order_execution_v_2_return_bitfield_14_secondary_exec_id
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_execution_v_2_return_bitfield_17.order_execution_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: number_of_return_bitfields >= 18 and order_execution_v_2_return_bitfield_18.order_execution_v_2_return_bitfield_18_account_type
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
      - id: order_execution_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: order_execution_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: order_execution_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: order_execution_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: order_execution_v_2_return_bitfield_18_reserved_128
        type: b1
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe, the ’at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the matching en- gine. However, we strongly recommend that you keep your QuoteUpdateID values day- unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be rep- resented on ODROP, FIXDROP and standard DROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Populate with Symbol for resets at the Product- Code level. Leave empty for resets at the Trading Firm level'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
  trade_cancel_or_correct_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identi- fier corresponds to the identifiers used in Cboe market data products'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in Cboe FIX. Refers to the ExecID (o)f the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
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
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_binary_price_8
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
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_security_id
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_v_2_return_bitfield_2.trade_cancelor_correct_v_2_return_bitfield_2_capacity
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_v_2_return_bitfield_4.trade_cancelor_correct_v_2_return_bitfield_4_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_v_2_return_bitfield_4.trade_cancelor_correct_v_2_return_bitfield_4_corrected_size
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_v_2_return_bitfield_7.trade_cancelor_correct_v_2_return_bitfield_7_sub_liquidity_indicator
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_v_2_return_bitfield_7.trade_cancelor_correct_v_2_return_bitfield_7_last_mkt
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
      - id: trade_cancelor_correct_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: trade_cancelor_correct_v_2_return_bitfield_18_reserved_128
        type: b1
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and purge_rejected_return_bitfield_15.purge_rejected_return_bitfield_15_mass_cancel_id
  purge_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_1_side
        type: b1
      - id: purge_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: purge_rejected_return_bitfield_1_price
        type: b1
      - id: purge_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: purge_rejected_return_bitfield_1_ord_type
        type: b1
      - id: purge_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: purge_rejected_return_bitfield_1_min_qty
        type: b1
      - id: purge_rejected_return_bitfield_1_max_remove_pct
        type: b1
  purge_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_2_symbol
        type: b1
      - id: purge_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_2_currency
        type: b1
      - id: purge_rejected_return_bitfield_2_id_source
        type: b1
      - id: purge_rejected_return_bitfield_2_security_id
        type: b1
      - id: purge_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: purge_rejected_return_bitfield_2_capacity
        type: b1
      - id: purge_rejected_return_bitfield_2_contra_trader
        type: b1
  purge_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_3_account
        type: b1
      - id: purge_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: purge_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: purge_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: purge_rejected_return_bitfield_3_max_floor
        type: b1
      - id: purge_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: purge_rejected_return_bitfield_3_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_3_prevent_match
        type: b1
  purge_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_4_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: purge_rejected_return_bitfield_4_open_close
        type: b1
      - id: purge_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: purge_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: purge_rejected_return_bitfield_4_party_id
        type: b1
      - id: purge_rejected_return_bitfield_4_access_fee
        type: b1
  purge_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: purge_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: purge_rejected_return_bitfield_5_last_shares
        type: b1
      - id: purge_rejected_return_bitfield_5_last_price
        type: b1
      - id: purge_rejected_return_bitfield_5_display_price
        type: b1
      - id: purge_rejected_return_bitfield_5_working_price
        type: b1
      - id: purge_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_5_expire_time
        type: b1
  purge_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: purge_rejected_return_bitfield_6_ccp
        type: b1
      - id: purge_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: purge_rejected_return_bitfield_6_attributed_quote
        type: b1
      - id: purge_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: purge_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: purge_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: purge_rejected_return_bitfield_6_party_role
        type: b1
  purge_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: purge_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: purge_rejected_return_bitfield_7_text
        type: b1
      - id: purge_rejected_return_bitfield_7_bid
        type: b1
      - id: purge_rejected_return_bitfield_7_offer
        type: b1
      - id: purge_rejected_return_bitfield_7_large_size
        type: b1
      - id: purge_rejected_return_bitfield_7_last_mkt
        type: b1
  purge_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_8_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_8_echo_text
        type: b1
      - id: purge_rejected_return_bitfield_8_stop_px
        type: b1
      - id: purge_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: purge_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: purge_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: purge_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  purge_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: purge_rejected_return_bitfield_9_auction_id
        type: b1
      - id: purge_rejected_return_bitfield_9_order_category
        type: b1
      - id: purge_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: purge_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: purge_rejected_return_bitfield_9_cross_type
        type: b1
      - id: purge_rejected_return_bitfield_9_cross_prioritization
        type: b1
  purge_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_10_cross_id
        type: b1
      - id: purge_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: purge_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_10_routing_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: purge_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: purge_rejected_return_bitfield_10_price_formation
        type: b1
      - id: purge_rejected_return_bitfield_10_client_qualified_role
        type: b1
  purge_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_11_client_id
        type: b1
      - id: purge_rejected_return_bitfield_11_investor_id
        type: b1
      - id: purge_rejected_return_bitfield_11_executor_id
        type: b1
      - id: purge_rejected_return_bitfield_11_order_origination
        type: b1
      - id: purge_rejected_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: purge_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: purge_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: purge_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  purge_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_12_cti_code
        type: b1
      - id: purge_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: purge_rejected_return_bitfield_12_operator_id
        type: b1
      - id: purge_rejected_return_bitfield_12_trade_date
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_optional_data
        type: b1
  purge_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_13_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_13_pending_status
        type: b1
      - id: purge_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: purge_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  purge_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_14_quote_room_id
        type: b1
      - id: purge_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: purge_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: purge_rejected_return_bitfield_14_username
        type: b1
      - id: purge_rejected_return_bitfield_14_user_status
        type: b1
  purge_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: purge_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: purge_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: purge_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: purge_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: purge_rejected_return_bitfield_15_report_time
        type: b1
      - id: purge_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_15_client_id_attr
        type: b1
  purge_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: purge_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: purge_rejected_return_bitfield_16_combo_order
        type: b1
      - id: purge_rejected_return_bitfield_16_compression
        type: b1
      - id: purge_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: purge_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_16_multi_class_spread
        type: b1
      - id: purge_rejected_return_bitfield_16_order_origin
        type: b1
  purge_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_17_price_type
        type: b1
      - id: purge_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: purge_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: purge_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: purge_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: purge_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: purge_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  purge_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_18_account_type
        type: b1
      - id: purge_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: purge_rejected_return_bitfield_18_subreason
        type: b1
      - id: purge_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: purge_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: purge_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: purge_rejected_return_bitfield_18_reserved_128
        type: b1
  reset_risk_acknowledgment_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: Cboe only enforces uniqueness of RiskStatusID values among currently unac- knowledged requests. However, we strongly recommend that you keep your RiskSta- tusID values day-unique'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: '<space> = Ignored; exceeds 1 reset per second Y = Success F = Rejected; exceeds firm reset limit C = Rejected; exceeds Custom Group ID limit D = Rejected; automatic risk resets are disabled E = Rejected; empty ResetRisk field I = Rejected; Incorrect data center S = Rejected; exceeds risk root reset limit U = Rejected; invalid underlying c = Rejected; invalid ClearingFirm y = Rejected; in replay Additional reject values may be added in the fu- ture with no notice'
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
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
  complex_instrument_accepted_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: revised_legs
        type: u1
        enum: revised_legs
        doc: 'Indicates if the legs on the created complex strat- egy have been reordered from the original re- quest. If the legs were reordered, the order of the Open- Close fields on a NewComplexOrder must be the order returned by the exchange, not the order from the original request. 1 = Legs were not reordered 2 = Legs were reordered'
      - id: no_of_securities
        type: u4
        doc: 'Corresponds to NoOfSecurities (8641) in Cboe FIX. Indicates the number of securities created by the member in this trading session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: complex_instrument_accepted_return_bitfield_1
        type: complex_instrument_accepted_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet ComplexInstrumentAccepted byte 1'
      - id: complex_instrument_accepted_return_bitfield_2
        type: complex_instrument_accepted_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet ComplexInstrumentAccepted byte 2'
      - id: complex_instrument_accepted_return_bitfield_3
        type: complex_instrument_accepted_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet ComplexInstrumentAccepted byte 3'
      - id: complex_instrument_accepted_return_bitfield_4
        type: complex_instrument_accepted_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet ComplexInstrumentAccepted byte 4'
      - id: complex_instrument_accepted_return_bitfield_5
        type: complex_instrument_accepted_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet ComplexInstrumentAccepted byte 5'
      - id: complex_instrument_accepted_return_bitfield_6
        type: complex_instrument_accepted_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet ComplexInstrumentAccepted byte 6'
      - id: complex_instrument_accepted_return_bitfield_7
        type: complex_instrument_accepted_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet ComplexInstrumentAccepted byte 7'
      - id: complex_instrument_accepted_return_bitfield_8
        type: complex_instrument_accepted_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet ComplexInstrumentAccepted byte 8'
      - id: complex_instrument_accepted_return_bitfield_9
        type: complex_instrument_accepted_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet ComplexInstrumentAccepted byte 9'
      - id: complex_instrument_accepted_return_bitfield_10
        type: complex_instrument_accepted_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet ComplexInstrumentAccepted byte 10'
      - id: complex_instrument_accepted_return_bitfield_11
        type: complex_instrument_accepted_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet ComplexInstrumentAccepted byte 11'
      - id: complex_instrument_accepted_return_bitfield_12
        type: complex_instrument_accepted_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet ComplexInstrumentAccepted byte 12'
      - id: complex_instrument_accepted_return_bitfield_13
        type: complex_instrument_accepted_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet ComplexInstrumentAccepted byte 13'
      - id: complex_instrument_accepted_return_bitfield_14
        type: complex_instrument_accepted_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet ComplexInstrumentAccepted byte 14'
      - id: complex_instrument_accepted_return_bitfield_15
        type: complex_instrument_accepted_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet ComplexInstrumentAccepted byte 15'
      - id: complex_instrument_accepted_return_bitfield_16
        type: complex_instrument_accepted_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet ComplexInstrumentAccepted byte 16'
      - id: complex_instrument_accepted_return_bitfield_17
        type: complex_instrument_accepted_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet ComplexInstrumentAccepted byte 17'
      - id: complex_instrument_accepted_return_bitfield_18
        type: complex_instrument_accepted_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet ComplexInstrumentAccepted byte 18'
      - id: num_complex_leg
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 13. However, for orders with AccountType value of 3 (House Trader), it is possible to specify 0 here. In that case, the repeating group ComplexLe- gOrderInfo should not follow, and the LegPosi- tionEffect is defaulted to None (“N”) for each leg'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: num_complex_leg
        doc: 'Repeating group stated NoLegs times'
      - id: leg_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 18 and complex_instrument_accepted_return_bitfield_18.complex_instrument_accepted_return_bitfield_18_leg_price
        doc: 'Corresponds to LegPrice (566) in Cboe FIX. Reference price for the future leg of a Volatility Strategy. Mandatory for this case, otherwise ig- nored. See the Volatility Strategies section (p. 7) for more details. Implied decimal with scale 1e-4'
  complex_instrument_accepted_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_1_side
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_peg_difference
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_exec_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_ord_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_time_in_force
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_min_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_1_max_remove_pct
        type: b1
  complex_instrument_accepted_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_2_symbol
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_symbol_sfx
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_currency
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_id_source
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_security_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_security_exchange
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_capacity
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_contra_trader
        type: b1
  complex_instrument_accepted_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_3_account
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_clearing_firm
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_clearing_account
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_display_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_max_floor
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_discretion_amount
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_order_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_prevent_match
        type: b1
  complex_instrument_accepted_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_4_maturity_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_strike_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_put_or_call
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_open_close
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_corrected_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_access_fee
        type: b1
  complex_instrument_accepted_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_leaves_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_last_shares
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_last_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_display_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_working_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_expire_time
        type: b1
  complex_instrument_accepted_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_6_secondary_order_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_ccp
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_contra_capacity
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_attributed_quote
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_ext_exec_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_bulk_order_ids
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_party_role
        type: b1
  complex_instrument_accepted_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_trade_report_type_return
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_text
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_bid
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_offer
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_large_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_last_mkt
        type: b1
  complex_instrument_accepted_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_8_fee_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_echo_text
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_stop_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_routing_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_rout_strategy
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_route_delivery_method
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_ex_destination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_trade_report_ref_id
        type: b1
  complex_instrument_accepted_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_9_marketing_fee_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_target_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_auction_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_order_category
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_liquidity_provision
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_cmta_number
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_cross_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_cross_prioritization
        type: b1
  complex_instrument_accepted_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_10_cross_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_alloc_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_give_up_firm_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_routing_firm_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_waiver_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_price_formation
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_client_qualified_role
        type: b1
  complex_instrument_accepted_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_11_client_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_investor_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_executor_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_order_origination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_deferral_reason
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_investor_qualified_role
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_executor_qualified_role
        type: b1
  complex_instrument_accepted_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_12_cti_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_manual_order_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_operator_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_trade_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_clearing_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_clearing_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_clearing_symbol
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_clearing_optional_data
        type: b1
  complex_instrument_accepted_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_13_cum_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_day_order_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_day_cum_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_avg_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_day_avg_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_pending_status
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_drill_thru_protection
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_multileg_reporting_type
        type: b1
  complex_instrument_accepted_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_14_leg_cfi_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_leg_maturity_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_leg_strike_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_quote_room_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_secondary_exec_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_user_request_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_username
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_user_status
        type: b1
  complex_instrument_accepted_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_equity_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_mass_cancel_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_trade_publish_ind
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_report_time
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_client_id_attr
        type: b1
  complex_instrument_accepted_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_16_frequent_trader_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_session_eligibility
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_combo_order
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_compression
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_floor_destination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_floor_routing_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_multi_class_spread
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_order_origin
        type: b1
  complex_instrument_accepted_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_17_price_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_strategy_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_trading_session_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_sender_location_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_cust_order_handling_inst
        type: b1
  complex_instrument_accepted_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_18_account_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_cross_initiator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_subreason
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_reserved_8
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_leg_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_reserved_32
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_reserved_64
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_reserved_128
        type: b1
  complex_instrument_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. Day-unique ID chosen by the client. Characters in the ASCII range 33–126 are allowed, except for comma, semicolon, and pipe. A leading tilde (˜) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by Cboe and could be received as a result of a system generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders. However, we strongly recommend that you keep your ClOrdID values day-unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: no_of_securities
        type: u4
        doc: 'Corresponds to NoOfSecurities (8641) in Cboe FIX. Indicates the number of securities created by the member in this trading session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use. To maintain for- ward compatibility, fill with 0'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: complex_instrument_rejected_return_bitfield_1
        type: complex_instrument_rejected_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet ComplexInstrumentRejected byte 1'
      - id: complex_instrument_rejected_return_bitfield_2
        type: complex_instrument_rejected_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet ComplexInstrumentRejected byte 2'
      - id: complex_instrument_rejected_return_bitfield_3
        type: complex_instrument_rejected_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet ComplexInstrumentRejected byte 3'
      - id: complex_instrument_rejected_return_bitfield_4
        type: complex_instrument_rejected_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet ComplexInstrumentRejected byte 4'
      - id: complex_instrument_rejected_return_bitfield_5
        type: complex_instrument_rejected_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet ComplexInstrumentRejected byte 5'
      - id: complex_instrument_rejected_return_bitfield_6
        type: complex_instrument_rejected_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet ComplexInstrumentRejected byte 6'
      - id: complex_instrument_rejected_return_bitfield_7
        type: complex_instrument_rejected_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet ComplexInstrumentRejected byte 7'
      - id: complex_instrument_rejected_return_bitfield_8
        type: complex_instrument_rejected_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet ComplexInstrumentRejected byte 8'
      - id: complex_instrument_rejected_return_bitfield_9
        type: complex_instrument_rejected_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet ComplexInstrumentRejected byte 9'
      - id: complex_instrument_rejected_return_bitfield_10
        type: complex_instrument_rejected_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet ComplexInstrumentRejected byte 10'
      - id: complex_instrument_rejected_return_bitfield_11
        type: complex_instrument_rejected_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet ComplexInstrumentRejected byte 11'
      - id: complex_instrument_rejected_return_bitfield_12
        type: complex_instrument_rejected_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet ComplexInstrumentRejected byte 12'
      - id: complex_instrument_rejected_return_bitfield_13
        type: complex_instrument_rejected_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet ComplexInstrumentRejected byte 13'
      - id: complex_instrument_rejected_return_bitfield_14
        type: complex_instrument_rejected_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet ComplexInstrumentRejected byte 14'
      - id: complex_instrument_rejected_return_bitfield_15
        type: complex_instrument_rejected_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet ComplexInstrumentRejected byte 15'
      - id: complex_instrument_rejected_return_bitfield_16
        type: complex_instrument_rejected_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet ComplexInstrumentRejected byte 16'
      - id: complex_instrument_rejected_return_bitfield_17
        type: complex_instrument_rejected_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet ComplexInstrumentRejected byte 17'
      - id: complex_instrument_rejected_return_bitfield_18
        type: complex_instrument_rejected_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet ComplexInstrumentRejected byte 18'
  complex_instrument_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_1_side
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_ord_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_min_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_1_max_remove_pct
        type: b1
  complex_instrument_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_2_symbol
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_currency
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_id_source
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_security_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_capacity
        type: b1
      - id: complex_instrument_rejected_return_bitfield_2_contra_trader
        type: b1
  complex_instrument_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_3_account
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_max_floor
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_order_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_3_prevent_match
        type: b1
  complex_instrument_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_strike_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_open_close
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_party_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_4_access_fee
        type: b1
  complex_instrument_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_last_shares
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_last_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_display_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_working_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_expire_time
        type: b1
  complex_instrument_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_ccp
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_attributed_quote
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_party_role
        type: b1
  complex_instrument_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_text
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_bid
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_offer
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_large_size
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_last_mkt
        type: b1
  complex_instrument_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_8_fee_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_echo_text
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_stop_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  complex_instrument_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_auction_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_order_category
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_cross_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_cross_prioritization
        type: b1
  complex_instrument_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_10_cross_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_routing_firm_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_price_formation
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_client_qualified_role
        type: b1
  complex_instrument_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_11_client_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_investor_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_executor_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_order_origination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_algorithmic_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  complex_instrument_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_12_cti_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_operator_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_trade_date
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_clearing_optional_data
        type: b1
  complex_instrument_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_avg_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_pending_status
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  complex_instrument_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_quote_room_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_username
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_user_status
        type: b1
  complex_instrument_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_report_time
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_client_id_attr
        type: b1
  complex_instrument_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_combo_order
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_compression
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_multi_class_spread
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_order_origin
        type: b1
  complex_instrument_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_17_price_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  complex_instrument_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_18_account_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_subreason
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_reserved_128
        type: b1
  trade_capture_report_acknowledgment_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
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
      - id: num_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trd_cap_ack_side_grp
        type: trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_security_id
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_clearing_firm
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_acknowledgment_v_2_return_bitfield_7.trade_capture_report_acknowledgment_v_2_return_bitfield_7_trade_report_type_return
      - id: trade_report_ref_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_capture_report_acknowledgment_v_2_return_bitfield_8.trade_capture_report_acknowledgment_v_2_return_bitfield_8_trade_report_ref_id
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_report_acknowledgment_v_2_return_bitfield_9.trade_capture_report_acknowledgment_v_2_return_bitfield_9_order_category
      - id: liquidity_provision
        type: u1
        enum: liquidity_provision
        if: number_of_return_bitfields >= 9 and trade_capture_report_acknowledgment_v_2_return_bitfield_9.trade_capture_report_acknowledgment_v_2_return_bitfield_9_liquidity_provision
      - id: price_formation
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and trade_capture_report_acknowledgment_v_2_return_bitfield_10.trade_capture_report_acknowledgment_v_2_return_bitfield_10_price_formation
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_acknowledgment_v_2_return_bitfield_11.trade_capture_report_acknowledgment_v_2_return_bitfield_11_algorithmic_indicator
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
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: trade_capture_report_acknowledgment_v_2_return_bitfield_18_reserved_128
        type: b1
  trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_1.trade_capture_report_acknowledgment_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_2.trade_capture_report_acknowledgment_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_3.trade_capture_report_acknowledgment_v_2_return_bitfield_3_account
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_4.trade_capture_report_acknowledgment_v_2_return_bitfield_4_party_id
        doc: 'Echoed back from the original Trade Cap- ture Report V2 message'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 6 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_6.trade_capture_report_acknowledgment_v_2_return_bitfield_6_party_role
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_4.trade_capture_report_acknowledgment_v_2_return_bitfield_4_open_close
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_17.trade_capture_report_acknowledgment_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.trade_capture_report_acknowledgment_v_2_return_bitfield_18.trade_capture_report_acknowledgment_v_2_return_bitfield_18_account_type
  trade_capture_report_reject_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to TradeReportID (571) in Cboe FIX. Day-unique ID chosen by client. Cboe will en- force port level day-uniqueness. 20 characters or less. Characters in ASCII range 33–126 are allowed, except for comma, semi- colon, and pipe. If the TradeReportID matches a live trade report (one that has been acked, but not confirmed or declined), it will be rejected as duplicate'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: num_trade_capture_report_reject_v_2_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trade_capture_report_reject_v_2_trd_cap_ack_side_grp
        type: trade_capture_report_reject_v_2_trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trade_capture_report_reject_v_2_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_security_id
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_clearing_firm
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_trade_report_type_return
      - id: trade_publish_indicator
        type: u1
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_trade_publish_ind_return
      - id: rpt_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 7 and trade_capture_report_reject_v_2_return_bitfield_7.trade_capture_report_reject_v_2_return_bitfield_7_trade_publish_ind_return
        doc: 'Nanoseconds since Unix epoch'
      - id: price_formation
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and trade_capture_report_reject_v_2_return_bitfield_10.trade_capture_report_reject_v_2_return_bitfield_10_price_formation
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_reject_v_2_return_bitfield_11.trade_capture_report_reject_v_2_return_bitfield_11_algorithmic_indicator
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
      - id: trade_capture_report_reject_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: trade_capture_report_reject_v_2_return_bitfield_18_reserved_128
        type: b1
  trade_capture_report_reject_v_2_trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.trade_capture_report_reject_v_2_return_bitfield_1.trade_capture_report_reject_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.trade_capture_report_reject_v_2_return_bitfield_2.trade_capture_report_reject_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.trade_capture_report_reject_v_2_return_bitfield_3.trade_capture_report_reject_v_2_return_bitfield_3_account
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_reject_v_2_return_bitfield_4.trade_capture_report_reject_v_2_return_bitfield_4_party_id
        doc: 'Echoed back from the original Trade Cap- ture Report V2 message'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 6 and _parent.trade_capture_report_reject_v_2_return_bitfield_6.trade_capture_report_reject_v_2_return_bitfield_6_party_role
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_reject_v_2_return_bitfield_4.trade_capture_report_reject_v_2_return_bitfield_4_open_close
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.trade_capture_report_reject_v_2_return_bitfield_17.trade_capture_report_reject_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.trade_capture_report_reject_v_2_return_bitfield_18.trade_capture_report_reject_v_2_return_bitfield_18_account_type
  trade_capture_confirm_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
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
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Note the use of Binary Price to represent positive and negative prices, which can occur with complex/spread instruments. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX'
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
      - id: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        type: trade_capture_confirm_v_2_trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trade_capture_confirm_v_2_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_security_id
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_trade_report_type_return
      - id: trade_publish_indicator
        type: u1
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_trade_publish_ind_return
      - id: rpt_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_trade_publish_ind_return
        doc: 'Nanoseconds since Unix epoch'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_text
        doc: 'Human readable text with more information about the reject reason'
      - id: last_mkt
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_capture_confirm_v_2_return_bitfield_7.trade_capture_confirm_v_2_return_bitfield_7_last_mkt
      - id: order_category
        type: u1
        enum: order_category
        if: number_of_return_bitfields >= 9 and trade_capture_confirm_v_2_return_bitfield_9.trade_capture_confirm_v_2_return_bitfield_9_order_category
      - id: price_formation
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and trade_capture_confirm_v_2_return_bitfield_10.trade_capture_confirm_v_2_return_bitfield_10_price_formation
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_algorithmic_indicator
      - id: deferral_reason
        type: u1
        enum: deferral_reason
        if: number_of_return_bitfields >= 11 and trade_capture_confirm_v_2_return_bitfield_11.trade_capture_confirm_v_2_return_bitfield_11_deferral_reason
      - id: trade_publish_ind
        type: u1
        enum: trade_publish_ind
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_trade_publish_ind
      - id: report_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 15 and trade_capture_confirm_v_2_return_bitfield_15.trade_capture_confirm_v_2_return_bitfield_15_report_time
        doc: 'Nanoseconds since Unix epoch'
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
      - id: trade_capture_confirm_v_2_return_bitfield_6_central_counterparty
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
      - id: trade_capture_confirm_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: trade_capture_confirm_v_2_return_bitfield_18_reserved_128
        type: b1
  trade_capture_confirm_v_2_trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.trade_capture_confirm_v_2_return_bitfield_1.trade_capture_confirm_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.trade_capture_confirm_v_2_return_bitfield_2.trade_capture_confirm_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.trade_capture_confirm_v_2_return_bitfield_3.trade_capture_confirm_v_2_return_bitfield_3_account
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_confirm_v_2_return_bitfield_4.trade_capture_confirm_v_2_return_bitfield_4_party_id
        doc: 'Echoed back from the original Trade Cap- ture Report V2 message'
      - id: central_counterparty
        type: str
        size: 1
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 6 and _parent.trade_capture_confirm_v_2_return_bitfield_6.trade_capture_confirm_v_2_return_bitfield_6_central_counterparty
        doc: 'The CCP handling the trade C = EuroCCP'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 6 and _parent.trade_capture_confirm_v_2_return_bitfield_6.trade_capture_confirm_v_2_return_bitfield_6_party_role
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 8 and _parent.trade_capture_confirm_v_2_return_bitfield_8.trade_capture_confirm_v_2_return_bitfield_8_fee_code
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_confirm_v_2_return_bitfield_4.trade_capture_confirm_v_2_return_bitfield_4_open_close
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.trade_capture_confirm_v_2_return_bitfield_17.trade_capture_confirm_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.trade_capture_confirm_v_2_return_bitfield_18.trade_capture_confirm_v_2_return_bitfield_18_account_type
  trade_capture_report_decline_v_2_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe match- ing engine (not the time the message was sent). Nanoseconds since Unix epoch'
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
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed contract quantity. System limit is 999,999 contracts'
      - id: last_px_trade_price_8
        type: decimal_u8_7
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Note the use of Binary Price to represent positive and negative prices, which can occur with complex/spread instruments. Implied decimal with scale 1e-7'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX'
      - id: reason
        type: u1
        enum: reason
        doc: 'Reason for a Trade Capture Report reject or decline. See Reason Codes (§ 7.1, p. 175) for a list of possible reasons'
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
      - id: num_trade_capture_report_decline_v_2_trd_cap_ack_side_grp
        type: u1
        doc: 'Corresponds to NoSides (552) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be 2'
      - id: trade_capture_report_decline_v_2_trd_cap_ack_side_grp
        type: trade_capture_report_decline_v_2_trd_cap_ack_side_grp
        repeat: expr
        repeat-expr: num_trade_capture_report_decline_v_2_trd_cap_ack_side_grp
        doc: 'Repeating group stated NoSides times'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_symbol
      - id: id_source
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_id_source
      - id: security_id
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_security_id
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_clearing_firm
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 con- tracts'
      - id: trade_report_type_return
        type: u2
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_trade_report_type_return
      - id: trade_publish_indicator
        type: u1
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_trade_publish_ind_return
      - id: rpt_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 7 and trade_capture_report_decline_v_2_return_bitfield_7.trade_capture_report_decline_v_2_return_bitfield_7_trade_publish_ind_return
        doc: 'Nanoseconds since Unix epoch'
      - id: price_formation
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and trade_capture_report_decline_v_2_return_bitfield_10.trade_capture_report_decline_v_2_return_bitfield_10_price_formation
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        if: number_of_return_bitfields >= 11 and trade_capture_report_decline_v_2_return_bitfield_11.trade_capture_report_decline_v_2_return_bitfield_11_algorithmic_indicator
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
      - id: trade_capture_report_decline_v_2_return_bitfield_18_reserved_8
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_reserved_16
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_reserved_32
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_reserved_64
        type: b1
      - id: trade_capture_report_decline_v_2_return_bitfield_18_reserved_128
        type: b1
  trade_capture_report_decline_v_2_trd_cap_ack_side_grp:
    seq:
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.trade_capture_report_decline_v_2_return_bitfield_1.trade_capture_report_decline_v_2_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 2 and _parent.trade_capture_report_decline_v_2_return_bitfield_2.trade_capture_report_decline_v_2_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.trade_capture_report_decline_v_2_return_bitfield_3.trade_capture_report_decline_v_2_return_bitfield_3_account
      - id: party_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_decline_v_2_return_bitfield_4.trade_capture_report_decline_v_2_return_bitfield_4_party_id
        doc: 'Echoed back from the original Trade Cap- ture Report V2 message'
      - id: party_role
        type: str
        size: 1
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 6 and _parent.trade_capture_report_decline_v_2_return_bitfield_6.trade_capture_report_decline_v_2_return_bitfield_6_party_role
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 4 and _parent.trade_capture_report_decline_v_2_return_bitfield_4.trade_capture_report_decline_v_2_return_bitfield_4_open_close
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: _parent.number_of_return_bitfields >= 17 and _parent.trade_capture_report_decline_v_2_return_bitfield_17.trade_capture_report_decline_v_2_return_bitfield_17_cust_order_handling_inst
      - id: account_type
        type: u1
        enum: account_type
        if: _parent.number_of_return_bitfields >= 18 and _parent.trade_capture_report_decline_v_2_return_bitfield_18.trade_capture_report_decline_v_2_return_bitfield_18_account_type
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
    0x7a:
      id: 'new_order_cross_message'
      doc: 'New Order Cross Message.'
    0x4b:
      id: 'new_complex_order_message'
      doc: 'New Complex Order Message.'
    0x85:
      id: 'new_order_cross_multileg_message'
      doc: 'New Order Cross Multileg Message.'
    0x39:
      id: 'cancel_order_v_2_message'
      doc: 'Cancel Order V2 Message.'
    0x3a:
      id: 'modify_order_v_2_message'
      doc: 'Modify Order V2 Message.'
    0x7b:
      id: 'quote_update_message'
      doc: 'Quote Update Message.'
    0x47:
      id: 'purge_orders_message'
      doc: 'Purge Orders Message.'
    0x56:
      id: 'reset_risk_message'
      doc: 'Reset Risk Message.'
    0x4c:
      id: 'new_complex_instrument_message'
      doc: 'New Complex Instrument Message.'
    0x3c:
      id: 'trade_capture_report_v_2_message'
      doc: 'Trade Capture Report V2 Message.'
    0x25:
      id: 'order_acknowledgment_v_2_message'
      doc: 'Order Acknowledgment V2 Message.'
    0x7c:
      id: 'cross_order_acknowledgment_message'
      doc: 'Cross Order Acknowledgment Message.'
    0x7d:
      id: 'quote_update_acknowledgment_message'
      doc: 'Quote Update Acknowledgment Message.'
    0x26:
      id: 'order_rejected_v_2_message'
      doc: 'Order Rejected V2 Message.'
    0x7e:
      id: 'cross_order_rejected_message'
      doc: 'Cross Order Rejected Message.'
    0x7f:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected Message.'
    0x27:
      id: 'order_modified_v_2_message'
      doc: 'Order Modified V2 Message.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated Message.'
    0x80:
      id: 'quote_restated_message'
      doc: 'Quote Restated Message.'
    0x29:
      id: 'user_modify_rejected_v_2_message'
      doc: 'User Modify Rejected V2 Message.'
    0x2a:
      id: 'order_cancelled_v_2_message'
      doc: 'Order Cancelled V2 Message.'
    0x81:
      id: 'quote_cancelled_message'
      doc: 'Quote Cancelled Message.'
    0x82:
      id: 'cross_order_cancelled_message'
      doc: 'Cross Order Cancelled Message.'
    0x2b:
      id: 'cancel_rejected_v_2_message'
      doc: 'Cancel Rejected V2 Message.'
    0x2c:
      id: 'order_execution_v_2_message'
      doc: 'Order Execution V2 Message.'
    0x83:
      id: 'quote_execution_message'
      doc: 'Quote Execution Message.'
    0x2d:
      id: 'trade_cancel_or_correct_v_2_message'
      doc: 'Trade Cancel or Correct V2 Message.'
    0x48:
      id: 'purge_rejected_message'
      doc: 'Purge Rejected Message.'
    0x57:
      id: 'reset_risk_acknowledgment_message'
      doc: 'Reset Risk Acknowledgment Message.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'Mass Cancel Acknowledgment Message.'
    0x4d:
      id: 'complex_instrument_accepted_message'
      doc: 'Complex Instrument Accepted Message.'
    0x4e:
      id: 'complex_instrument_rejected_message'
      doc: 'Complex Instrument Rejected Message.'
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
      doc: 'Not authorized (invalid user- name/password)'
    0x44:
      id: 'session_is_disabled'
      doc: 'Session is disabled'
    0x42:
      id: 'session_in_use'
      doc: 'Session in use'
    0x53:
      id: 'invalid_session'
      doc: 'Invalid session'
    0x51:
      id: 'sequence_ahead_in_login_message'
      doc: 'Sequence ahead in Login message'
    0x49:
      id: 'invalid_unit_given_in_login_message'
      doc: 'Invalid unit given in Login message'
    0x46:
      id: 'invalid_return_bitfield_in_login_message'
      doc: 'Invalid return bitfield in login message'
    0x4d:
      id: 'invalid_login_request_message_structure'
      doc: 'Invalid Login Request message structure'
  logout_reason:
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x45:
      id: 'end_of_day'
      doc: 'End of Day'
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
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit (default)'
    0x33:
      id: 'stop'
      doc: 'Stop (Options only)'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit Market implies TimeInForce of IOC (3). Stop/Stop Limit orders must have TimeInForce = 0 (DAY), 1 (GTC), or 6 (GTD).'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'gtc'
      doc: 'GTC (allowed, but treated as Day)'
    0x32:
      id: 'at_the_open'
      doc: 'At The Open (complex only)'
    0x33:
      id: 'ioc'
      doc: 'IOC (Portion not filled immediately is cancelled. Market orders are implicitly IOC.)'
    0x34:
      id: 'fok'
      doc: 'FOK (Supported in New Order only; Not supported in New Complex Order.'
    0x36:
      id: 'gtd'
      doc: 'GTD (expires at earlier of specified ExpireTime or end of day)'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency (maps to ’AOTC’)'
    0x50:
      id: 'principal'
      doc: 'Principal (maps to ’DEAL’)'
    0x52:
      id: 'riskless_principal'
      doc: 'Riskless Principal (maps to ’MTCH’)'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None Orders with AccountType value of 3 (House Trader) are not required to specify OpenClose or may optionally specify a value of “N”. Otherwise, orders with Orders with AccountType value of 1 (Customer Account) must specify OpenClose.'
  liquidity_provision:
    0x4e:
      id: 'not_liquidity_provision'
      doc: 'Not Liquidity Provision (default)'
    0x59:
      id: 'liquidity_provision'
      doc: 'Liquidity Provision'
  client_id:
    0:
      id: 'none'
      doc: 'NONE (No Client for this order)'
    1:
      id: 'aggr'
      doc: 'AGGR (An aggregation of multiple client orders)'
    2:
      id: 'pnal'
      doc: 'PNAL (Clients are pending allocation)'
  order_origination:
    0x35:
      id: 'dea_indicates_dea_activity_as_deemed_by_mi_fid_ii'
      doc: '(DEA). Indicates DEA activity (as deemed by MiFID II) is involved in this order.'
    0x30:
      id: 'non_dea'
      doc: 'Non-DEA. (default) Other values are unsupported and will be rejected.'
  algorithmic_indicator:
    0x4e:
      id: 'no_algorithm_was_involved'
      doc: 'No algorithm was involved (default).'
    0x59:
      id: 'algorithm_was_involved'
      doc: 'Algorithm was involved (ALGO).'
  cust_order_handling_inst:
    0x59:
      id: 'electronic'
      doc: 'Electronic. (Default)'
    0x57:
      id: 'desk'
      doc: 'Desk'
    0x43:
      id: 'vendorprovided_platform_billed_by_executing_broker'
      doc: 'Vendor-provided Platform billed by Executing Broker (For complex)'
    0x47:
      id: 'sponsored_access_via_exchange_api_or_fix_provided_by'
      doc: 'Sponsored Access via Exchange API or FIX, provided by Executing Broker (For complex)'
    0x48:
      id: 'premium_algorithmic_trading_provider_billed_by_execut'
      doc: 'Premium Algorithmic Trading Provider, billed by Execut- ing Broker (For complex)'
    0x44:
      id: 'other_including_otherprovided_screen'
      doc: 'Other, including other-provided screen (For complex)'
  account_type:
    0x31:
      id: 'account_is_carried_on_customer_side_of_the_books'
      doc: 'Account is carried on customer side of the books.'
    0x33:
      id: 'house_trader'
      doc: 'House Trader'
  cross_prioritization:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  auto_match:
    0x30:
      id: 'disabled'
      doc: 'Disabled (Default)'
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
  auto_match_price:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  last_priority:
    0x30:
      id: 'disabled'
      doc: 'Disabled (Default)'
    0x31:
      id: 'enabled'
      doc: 'Enabled'
  leg_position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None Orders must specify LegPositionEffect. How- ever, orders with AccountType value of 3 (House Trader) may specify a value of “N” for each leg. For House Trader, this repeating group is only needed if a non-zero value of NoLegs is used.'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave original order alone.'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel original order if modification fails.'
  posting_instruction:
    0x50:
      id: 'post_only'
      doc: 'Post Only (do not remove liquidity)'
    0x42:
      id: 'book_only'
      doc: 'Book Only (allow removal of liquidity, avail- able for Market Makers of futures only). Note that for options, only Post Only is sup- ported.'
  leg_side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  transaction_category:
    0x50:
      id: 'regular_trade'
      doc: 'Regular Trade (aka Plain-Vanilla Trade)'
    0x59:
      id: 'exchange_for_physical'
      doc: 'Exchange For Physical'
    0x5a:
      id: 'package_trade'
      doc: 'Package Trade'
  trade_report_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'cancel'
      doc: 'Cancel (only on return)'
    2:
      id: 'replace'
      doc: 'Replace (only on return)'
    3:
      id: 'release'
      doc: 'Release'
  order_category:
    0:
      id: 'not_a_negotiated_trade'
      doc: 'Not a Negotiated Trade'
    3:
      id: 'privately_negotiated_trade'
      doc: 'Privately Negotiated Trade On return fields, this field indicates whether Cboe deems the trade as utilising the Negotiated Transaction waiver under Mi- FID.'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'auction_trade'
      doc: 'Auction Trade'
  sub_liquidity_indicator:
    0x62:
      id: 'automated_improvement_mechanism'
      doc: 'Automated Improvement Mechanism (AIM)'
    0x55:
      id: 'qualifying_market_turner_order'
      doc: 'Qualifying Market Turner order. Only set when BaseLiq- uidityIndicator = A.'
    0x67:
      id: 'aggressive_hold'
      doc: 'Aggressive Hold. Order held by speed bump.'
  quote_reject_reason:
    0x43:
      id: 'invalid_clearing_firm'
      doc: 'Invalid ClearingFirm'
    0x44:
      id: 'invalid_wash_id'
      doc: 'Invalid WashId'
    0x46:
      id: 'not_enabled_for_quotes'
      doc: 'Not enabled for quotes'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4c:
      id: 'invalid_quote_cnt'
      doc: 'Invalid QuoteCnt'
    0x4d:
      id: 'symbols_not_on_same_matching_engine'
      doc: 'Symbols not on same matching engine'
    0x50:
      id: 'invalid_posting_instruction'
      doc: 'Invalid PostingInstruction'
    0x51:
      id: 'invalid_quote_update_id'
      doc: 'Invalid QuoteUpdateID'
    0x52:
      id: 'product_code_does_not_match_across_quotes'
      doc: 'Product Code does not match across quotes'
    0x53:
      id: 'symbol_not_found'
      doc: 'Symbol not found'
    0x55:
      id: 'symbol_range_unreachable'
      doc: 'Symbol range unreachable'
    0x57:
      id: 'invalid_wash_prevent_type'
      doc: 'Invalid WashPreventType'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x62:
      id: 'invalid_account_type'
      doc: 'Invalid AccountType'
    0x63:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    0x66:
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
    0x6c:
      id: 'liquidity_provision_quotes_require_active_lpp_registration_for_product'
      doc: 'Liquidity Provision quotes require active LPP registration for product'
    0x6d:
      id: 'invalid_wash_method'
      doc: 'Invalid WashMethod'
    0x6e:
      id: 'exceed_max_notional_value_per_order'
      doc: 'Exceed max notional value per order'
    0x6f:
      id: 'invalid_open_close'
      doc: 'Invalid OpenClose'
    0x73:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x76:
      id: 'invalid_eu_record_keeping_info_such_as_order_origination_algorithmic_indicator_liquidity_provision'
      doc: 'Invalid EU Record Keeping info, such as OrderOrigination, AlgorithmicIndicator, LiquidityProvision,'
    0x78:
      id: 'exceed_max_size_per_order'
      doc: 'Exceed max size per order'
    0x79:
      id: 'quote_received_by_cboe_during_replay'
      doc: 'Quote Received by Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x4c:
      id: 'modified'
      doc: 'Modified; loss of priority'
    0x52:
      id: 'modified_x52'
      doc: 'Modified; retains priority (size reduction)'
    0x4e:
      id: 'no_change_matches_existing_quote'
      doc: 'No change, matches existing quote'
    0x44:
      id: 'new_quote_but_may_remove_liquidity'
      doc: 'New Quote, but may remove liquidity'
    0x64:
      id: 'modified_but_may_remove_liquidity'
      doc: 'Modified, but may remove liquidity Cancellation:'
    0x55:
      id: 'user_cancelled'
      doc: 'User cancelled (zero size/price requested) Rejection:'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x50:
      id: 'rejected_cannot_post'
      doc: 'Rejected, cannot post'
    0x66:
      id: 'risk_management_firm_or_custom_group_id'
      doc: 'Risk management firm or Custom Group ID level'
    0x53:
      id: 'rejected_symbol_not_found'
      doc: 'Rejected, symbol not found'
    0x70:
      id: 'rejected_invalid_price'
      doc: 'Rejected, invalid price'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'risk_management_underlying_level'
      doc: 'Risk management underlying level'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected, other reason Additional reasons indicating a reject may be added in the future with no notice.'
  subreason:
    0x41:
      id: 'purge_mass_cancel_trading_firm_level_by_user'
      doc: 'Purge/Mass Cancel Trading Firm Level by user'
    0x42:
      id: 'purge_mass_cancel_symbol_level_by_user'
      doc: 'Purge/Mass Cancel Symbol Level by user'
    0x43:
      id: 'purge_mass_cancel_custom_group_id_level_by_user'
      doc: 'Purge/Mass Cancel Custom Group ID Level by user'
    0x45:
      id: 'trading_firm_level_lockout_by_cboe_trade_desk_admin'
      doc: 'Trading Firm Level lockout by Cboe Trade Desk Admin'
    0x4a:
      id: 'firm_disconnect'
      doc: 'Firm disconnect'
    0x4b:
      id: 'matching_engine_disconnect'
      doc: 'Matching engine disconnect'
    0x54:
      id: 'cboe_trade_desk_admin'
      doc: 'Cboe Trade Desk admin'
    0x66:
      id: 'risk_management_trading_firm_level_by_rule'
      doc: 'Risk Management Trading Firm Level by rule'
    0x73:
      id: 'risk_management_symbol_level_by_rule'
      doc: 'Risk Management Symbol Level by rule'
    0x2b:
      id: 'risk_management_trading_firm_group_level_by_rule'
      doc: 'Risk Management Trading Firm Group Level by rule'
    0x6c:
      id: 'limit_order_collar_breach'
      doc: 'Limit order collar breach'
    0x70:
      id: 'spike_protection_collar_breach'
      doc: 'Spike protection collar breach'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  restatement_reason:
    0x57:
      id: 'wash'
      doc: 'Wash'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  cancel_subreason:
    0x41:
      id: 'purge_mass_cancel_trading_firm_level_by_user'
      doc: 'Purge/Mass Cancel Trading Firm Level by user'
    0x42:
      id: 'purge_mass_cancel_symbol_level_by_user'
      doc: 'Purge/Mass Cancel Symbol Level by user'
    0x43:
      id: 'purge_mass_cancel_custom_group_id_level_by_user'
      doc: 'Purge/Mass Cancel Custom Group ID Level by user'
    0x45:
      id: 'trading_firm_level_lockout_by_cboe_trade_desk_admin'
      doc: 'Trading Firm Level lockout by Cboe Trade Desk Admin'
    0x4a:
      id: 'firm_disconnect'
      doc: 'Firm disconnect'
    0x4b:
      id: 'matching_engine_disconnect'
      doc: 'Matching engine disconnect'
    0x54:
      id: 'cboe_trade_desk_admin'
      doc: 'Cboe Trade Desk admin'
    0x66:
      id: 'risk_management_trading_firm_level_by_rule'
      doc: 'Risk Management Trading Firm Level by rule'
    0x73:
      id: 'risk_management_symbol_level_by_rule'
      doc: 'Risk Management Symbol Level by rule'
    0x2b:
      id: 'risk_management_trading_firm_group_level_by_rule'
      doc: 'Risk Management Trading Firm Group Level by rule'
    0x6c:
      id: 'limit_order_collar_breach'
      doc: 'Limit order collar breach'
    0x70:
      id: 'spike_protection_collar_breach'
      doc: 'Spike protection collar breach'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  multileg_reporting_type:
    0x31:
      id: 'singleleg_simple_instrument'
      doc: 'Single-leg /Simple instrument'
    0x32:
      id: 'individual_leg_of_multileg_instrument'
      doc: 'Individual leg of multi-leg instrument (Options), or Sim- ple instrument execution that is part of a Spread instrument execution (Futures)'
    0x33:
      id: 'entire_multileg_spread_instrument_package'
      doc: 'Entire multi-leg / Spread instrument package'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored; exceeds 1 reset per second'
    0x59:
      id: 'success'
      doc: 'Success'
    0x46:
      id: 'rejected'
      doc: 'Rejected; exceeds firm reset limit'
    0x43:
      id: 'rejected_x43'
      doc: 'Rejected; exceeds Custom Group ID limit'
    0x44:
      id: 'rejected_x44'
      doc: 'Rejected; automatic risk resets are disabled'
    0x45:
      id: 'rejected_x45'
      doc: 'Rejected; empty ResetRisk field'
    0x49:
      id: 'rejected_x49'
      doc: 'Rejected; Incorrect data center'
    0x53:
      id: 'rejected_x53'
      doc: 'Rejected; exceeds risk root reset limit'
    0x55:
      id: 'rejected_x55'
      doc: 'Rejected; invalid underlying'
    0x63:
      id: 'rejected_x63'
      doc: 'Rejected; invalid ClearingFirm'
    0x79:
      id: 'rejected_x79'
      doc: 'Rejected; in replay Additional reject values may be added in the fu- ture with no notice.'
  revised_legs:
    0x31:
      id: 'legs_were_not_reordered'
      doc: 'Legs were not reordered'
    0x32:
      id: 'legs_were_reordered'
      doc: 'Legs were reordered'
  reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier (e.g., ClOrdID)'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4a:
      id: 'too_late_to_cancel'
      doc: 'Too late to cancel'
    0x4b:
      id: 'order_rate_threshold_exceeded'
      doc: 'Order Rate Threshold Exceeded'
    0x4c:
      id: 'price_exceeds_cross_range'
      doc: 'Price Exceeds Cross Range'
    0x4d:
      id: 'liquidity_available_exceeds_order_size'
      doc: 'Liquidity Available Exceeds Order Size'
    0x4e:
      id: 'ran_out_of_liquidity_to_execute_against'
      doc: 'Ran Out of Liquidity to Execute Against'
    0x4f:
      id: 'cl_ord_id_doesnt_match_a_known_order'
      doc: 'ClOrdID Doesn’t Match a Known Order'
    0x50:
      id: 'cant_modify_an_order_that_is_pending_fill'
      doc: 'Can’t Modify an Order That is Pending Fill'
    0x51:
      id: 'waiting_for_first_trade'
      doc: 'Waiting For First Trade'
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
      id: 'risk_management_trading_firm_level'
      doc: 'Risk Management Trading Firm Level'
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
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received by Cboe During Replay'
    0x2b:
      id: 'risk_management_trading_firm_group_level'
      doc: 'Risk Management Trading Firm Group Level'
  deferral_reason:
    0x2d:
      id: 'no_deferral_reason'
      doc: 'No Deferral Reason'
    0x36:
      id: 'deferral_for_large_in_scale'
      doc: 'Deferral for Large In Scale (LRGS)'
  trade_publish_ind:
    0:
      id: 'do_not_publish'
      doc: 'Do not publish'
    1:
      id: 'publish_trade'
      doc: 'Publish trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred publication'

