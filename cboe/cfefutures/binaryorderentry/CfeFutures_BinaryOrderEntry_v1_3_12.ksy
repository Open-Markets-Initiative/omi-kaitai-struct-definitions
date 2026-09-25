# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures BinaryOrderEntry Boe v1.3.12
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 1.3.12
#   Date: 3/11/2021
#   Specification: Cboe Futures Exchange BOE Specification.pdf
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
  id: cboe_cfefutures_binaryorderentry_boe_v1_3_12
  title: Cboe CfeFutures BinaryOrderEntry Boe v1.3.12
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Binary Order Entry Boe v1.3.12'
doc-ref: https://www.cboe.com/us/futures/support/technical/

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
        'message_type::quote_update_message': quote_update_message
        'message_type::purge_orders_message': purge_orders_message
        'message_type::reset_risk_message': reset_risk_message
        'message_type::order_acknowledgment_message': order_acknowledgment_message
        'message_type::quote_update_acknowledgment_message': quote_update_acknowledgment_message
        'message_type::order_rejected_message': order_rejected_message
        'message_type::quote_update_rejected_message': quote_update_rejected_message
        'message_type::order_modified_message': order_modified_message
        'message_type::quote_restated_message': quote_restated_message
        'message_type::user_modify_rejected_message': user_modify_rejected_message
        'message_type::order_cancelled_message': order_cancelled_message
        'message_type::quote_cancelled_message': quote_cancelled_message
        'message_type::cancel_rejected_message': cancel_rejected_message
        'message_type::order_execution_message': order_execution_message
        'message_type::quote_execution_message': quote_execution_message
        'message_type::trade_cancel_or_correct_message': trade_cancel_or_correct_message
        'message_type::purge_rejected_message': purge_rejected_message
        'message_type::reset_risk_acknowledgment_message': reset_risk_acknowledgment_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::tas_restatement_new_order_message_message': tas_restatement_new_order_message_message
        'message_type::variance_restatement_new_order_message_message': variance_restatement_new_order_message_message
        'message_type::tas_quote_restatement_message': tas_quote_restatement_message
        'message_type::variance_quote_restatement_message': variance_quote_restatement_message

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
        doc: 'Session Sub ID supplied by CFE'
      - id: username
        type: str
        size: 4
        encoding: ASCII
        doc: 'Username supplied by CFE'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Password supplied by CFE'
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
        doc: 'Accepted, or the reason for the rejection. A = Login Accepted N = Not authorized (invalid username/pwd) D = Session is disabled B = Session in use S = Invalid session Q = Sequence ahead in Login message I = Invalid unit given in Login message F = Invalid return bit field in login message M = Invalid Login Request message structure'
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
        doc: 'Last inbound (TPH to CFE) message sequence number processed by CFE'
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
        doc: 'Highest available CFE to TPH sequence number for the unit'
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
        doc: 'Human-readable text with additional information about the reason for logout. Particularly useful if LogoutReason = ! (Protocol Violation)'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (TPH to CFE) message sequence number processed by CFE'
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
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_clearing_account > 0
      - id: price
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_account > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_prevent_match > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_maturity_date > 0
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_risk_reset > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_open_close > 0
      - id: cmta_number
        type: u4
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_cmta_number > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: custom_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_custom_group_id > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_oeoid > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_cust_order_handling_inst > 0
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
      - id: new_order_bitfield_2_currency
        type: b1
      - id: new_order_bitfield_2_id_source
        type: b1
      - id: new_order_bitfield_2_security_id
        type: b1
      - id: new_order_bitfield_2_security_exchange
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
      - id: new_order_bitfield_3_max_remove_pct
        type: b1
      - id: new_order_bitfield_3_discretion_amount
        type: b1
      - id: new_order_bitfield_3_peg_difference
        type: b1
      - id: new_order_bitfield_3_prevent_match
        type: b1
      - id: new_order_bitfield_3_locate_required
        type: b1
      - id: new_order_bitfield_3_expire_time
        type: b1
  new_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_4_maturity_date
        type: b1
      - id: new_order_bitfield_4_strike_price
        type: b1
      - id: new_order_bitfield_4_put_or_call
        type: b1
      - id: new_order_bitfield_4_risk_reset
        type: b1
      - id: new_order_bitfield_4_open_close
        type: b1
      - id: new_order_bitfield_4_cmta_number
        type: b1
      - id: new_order_bitfield_4_target_party_id
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
      - id: new_order_bitfield_5_booking_type
        type: b1
      - id: new_order_bitfield_5_ext_exec_inst
        type: b1
      - id: new_order_bitfield_5_client_id
        type: b1
      - id: new_order_bitfield_5_investor_id
        type: b1
      - id: new_order_bitfield_5_executor_id
        type: b1
      - id: new_order_bitfield_5_order_origination
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
      - id: new_order_bitfield_7_custom_group_id
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
      - id: new_order_bitfield_7_oeoid
        type: b1
  new_order_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_8_room_id
        type: b1
      - id: new_order_bitfield_8_si_indicator
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
      - id: new_order_bitfield_9_trading_session_id
        type: b1
      - id: new_order_bitfield_9_cust_order_handling_inst
        type: b1
      - id: new_order_bitfield_9_reserved_32
        type: b1
      - id: new_order_bitfield_9_reserved_64
        type: b1
      - id: new_order_bitfield_9_reserved_128
        type: b1
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
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
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_product_name > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel_id > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_oeoid > 0
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 2 and cancel_order_bitfield_2.cancel_order_bitfield_2_mass_cancel_inst > 0
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
      - id: cancel_order_bitfield_1_product_name
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel_id
        type: b1
      - id: cancel_order_bitfield_1_routing_firm_id
        type: b1
      - id: cancel_order_bitfield_1_manual_order_indicator
        type: b1
      - id: cancel_order_bitfield_1_oeoid
        type: b1
  cancel_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_order_bitfield_2_mass_cancel_inst
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
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
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
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_clearing_firm > 0
      - id: order_qty
        type: u4
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_oeoid > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_cust_order_handling_inst > 0
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
      - id: modify_order_bitfield_2_routing_firm_id
        type: b1
      - id: modify_order_bitfield_2_manual_order_indicator
        type: b1
      - id: modify_order_bitfield_2_oeoid
        type: b1
      - id: modify_order_bitfield_2_frequent_trader_id
        type: b1
      - id: modify_order_bitfield_2_cust_order_handling_inst
        type: b1
      - id: modify_order_bitfield_2_reserved_128
        type: b1
  quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: cmta_number
        type: u4
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: custom_group_id
        type: u2
      - id: capacity
        type: u1
        enum: capacity
      - id: cti_code
        type: u1
        enum: cti_code
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
      - id: size_modifier
        type: str
        size: 1
        encoding: ASCII
        doc: 'Controls the behavior of the OrderQty field. Using “R” allows for a TPH to ensure that in-flight fills or cancels do not result in unwanted additional size exposure. NULL (0x00) = New quote size will be set to value of OrderQty. R = Reduce outstanding size of quote by the OrderQty provided. When using “R”, if the resulting size is zero or negative, then the quote is cancelled. TPHs are expected to track the remaining quantity of each quote as resulting size is not included on the Quote Update Acknowledgement message'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
        doc: 'CFE native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: open_close
        type: u1
        enum: open_close
      - id: price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  purge_orders_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: custom_group_id_cnt
        type: u1
        doc: 'Number of repeating CustomGroupID included in this message'
      - id: custom_group_id_one
        type: u2
        doc: 'First CustomGroupID. Only present if CustomGroupIDCnt is non-zero'
      - id: custom_group_idn
        type: u2
        doc: 'Last CustomGroupID'
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
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_product_name > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_id > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_oeoid > 0
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
      - id: purge_orders_bitfield_1_product_name
        type: b1
      - id: purge_orders_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_orders_bitfield_1_routing_firm_id
        type: b1
      - id: purge_orders_bitfield_1_manual_order_indicator
        type: b1
      - id: purge_orders_bitfield_1_oeoid
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
      - id: purge_orders_bitfield_2_reserved_64
        type: b1
      - id: purge_orders_bitfield_2_reserved_128
        type: b1
  reset_risk_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: CFE only enforces uniqueness of RiskStatusID values among currently unacknowledged requests. However, we strongly recommend that you keep your RiskStatusID values day-unique'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
      - id: reserved_4
        size: 4
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
      - id: custom_group_id
        type: u2
  order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_clearing_account > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_open_close > 0
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_acknowledgment_return_bitfield_5.order_acknowledgment_return_bitfield_5_leaves_qty > 0
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_acknowledgment_return_bitfield_5.order_acknowledgment_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_acknowledgment_return_bitfield_5.order_acknowledgment_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_sub_liquidity_indicator > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_acknowledgment_return_bitfield_8.order_acknowledgment_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and order_acknowledgment_return_bitfield_9.order_acknowledgment_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_oeoid > 0
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_cum_qty > 0
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_day_order_qty > 0
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_day_cum_qty > 0
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_avg_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: day_avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_day_avg_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_acknowledgment_return_bitfield_16.order_acknowledgment_return_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_acknowledgment_return_bitfield_17.order_acknowledgment_return_bitfield_17_cust_order_handling_inst > 0
  order_acknowledgment_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_1_side
        type: b1
      - id: order_acknowledgment_return_bitfield_1_peg_difference
        type: b1
      - id: order_acknowledgment_return_bitfield_1_price
        type: b1
      - id: order_acknowledgment_return_bitfield_1_exec_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_1_order_type
        type: b1
      - id: order_acknowledgment_return_bitfield_1_time_in_force
        type: b1
      - id: order_acknowledgment_return_bitfield_1_min_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_1_max_remove_pct
        type: b1
  order_acknowledgment_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_2_symbol
        type: b1
      - id: order_acknowledgment_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_acknowledgment_return_bitfield_2_currency
        type: b1
      - id: order_acknowledgment_return_bitfield_2_id_source
        type: b1
      - id: order_acknowledgment_return_bitfield_2_security_id
        type: b1
      - id: order_acknowledgment_return_bitfield_2_security_exchange
        type: b1
      - id: order_acknowledgment_return_bitfield_2_capacity
        type: b1
      - id: order_acknowledgment_return_bitfield_2_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_3_account
        type: b1
      - id: order_acknowledgment_return_bitfield_3_clearing_firm
        type: b1
      - id: order_acknowledgment_return_bitfield_3_clearing_account
        type: b1
      - id: order_acknowledgment_return_bitfield_3_display_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_3_max_floor
        type: b1
      - id: order_acknowledgment_return_bitfield_3_discretion_amount
        type: b1
      - id: order_acknowledgment_return_bitfield_3_order_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_3_prevent_match
        type: b1
  order_acknowledgment_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_4_maturity_date
        type: b1
      - id: order_acknowledgment_return_bitfield_4_strike_price
        type: b1
      - id: order_acknowledgment_return_bitfield_4_put_or_call
        type: b1
      - id: order_acknowledgment_return_bitfield_4_open_close
        type: b1
      - id: order_acknowledgment_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_acknowledgment_return_bitfield_4_corrected_size
        type: b1
      - id: order_acknowledgment_return_bitfield_4_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_4_access_fee
        type: b1
  order_acknowledgment_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_acknowledgment_return_bitfield_5_leaves_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_5_last_shares
        type: b1
      - id: order_acknowledgment_return_bitfield_5_last_px
        type: b1
      - id: order_acknowledgment_return_bitfield_5_display_price
        type: b1
      - id: order_acknowledgment_return_bitfield_5_working_price
        type: b1
      - id: order_acknowledgment_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_5_expire_time
        type: b1
  order_acknowledgment_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_acknowledgment_return_bitfield_6_ccp
        type: b1
      - id: order_acknowledgment_return_bitfield_6_contra_capacity
        type: b1
      - id: order_acknowledgment_return_bitfield_6_attributed_order
        type: b1
      - id: order_acknowledgment_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_acknowledgment_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_acknowledgment_return_bitfield_6_party_role
        type: b1
  order_acknowledgment_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_acknowledgment_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_acknowledgment_return_bitfield_7_text
        type: b1
      - id: order_acknowledgment_return_bitfield_7_bid
        type: b1
      - id: order_acknowledgment_return_bitfield_7_offer
        type: b1
      - id: order_acknowledgment_return_bitfield_7_large_size
        type: b1
      - id: order_acknowledgment_return_bitfield_7_last_mkt
        type: b1
  order_acknowledgment_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_8_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_8_echo_text
        type: b1
      - id: order_acknowledgment_return_bitfield_8_stop_px
        type: b1
      - id: order_acknowledgment_return_bitfield_8_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_8_rout_strategy
        type: b1
      - id: order_acknowledgment_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_acknowledgment_return_bitfield_8_ex_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_8_trade_report_ref_id
        type: b1
  order_acknowledgment_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_9_target_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_9_auction_id
        type: b1
      - id: order_acknowledgment_return_bitfield_9_order_category
        type: b1
      - id: order_acknowledgment_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_acknowledgment_return_bitfield_9_cmta_number
        type: b1
      - id: order_acknowledgment_return_bitfield_9_cross_type
        type: b1
      - id: order_acknowledgment_return_bitfield_9_cross_prioritization
        type: b1
  order_acknowledgment_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_10_cross_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_alloc_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_routing_f_irm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_waiver_type
        type: b1
      - id: order_acknowledgment_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_10_price_formation
        type: b1
      - id: order_acknowledgment_return_bitfield_10_client_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_11_client_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_investor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_executor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_order_origination
        type: b1
      - id: order_acknowledgment_return_bitfield_11_algo
        type: b1
      - id: order_acknowledgment_return_bitfield_11_deferral_reason
        type: b1
      - id: order_acknowledgment_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_acknowledgment_return_bitfield_11_executor_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_12_cti_code
        type: b1
      - id: order_acknowledgment_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_12_oeoid
        type: b1
      - id: order_acknowledgment_return_bitfield_12_trade_date
        type: b1
      - id: order_acknowledgment_return_bitfield_12_clearing_price
        type: b1
      - id: order_acknowledgment_return_bitfield_12_clearing_size
        type: b1
      - id: order_acknowledgment_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_acknowledgment_return_bitfield_12_clearing_optional_data
        type: b1
  order_acknowledgment_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_13_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_13_day_order_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_13_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_13_day_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_13_pending_status
        type: b1
      - id: order_acknowledgment_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_acknowledgment_return_bitfield_13_multileg_reporting_type
        type: b1
  order_acknowledgment_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_acknowledgment_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_acknowledgment_return_bitfield_14_room_id
        type: b1
      - id: order_acknowledgment_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_acknowledgment_return_bitfield_14_user_request_id
        type: b1
      - id: order_acknowledgment_return_bitfield_14_sis_username
        type: b1
      - id: order_acknowledgment_return_bitfield_14_user_status
        type: b1
  order_acknowledgment_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_15_equity_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_acknowledgment_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_acknowledgment_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_acknowledgment_return_bitfield_15_report_time
        type: b1
      - id: order_acknowledgment_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_acknowledgment_return_bitfield_15_client_id_attr
        type: b1
  order_acknowledgment_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_session_eligibility
        type: b1
      - id: order_acknowledgment_return_bitfield_16_combo_order
        type: b1
      - id: order_acknowledgment_return_bitfield_16_compression
        type: b1
      - id: order_acknowledgment_return_bitfield_16_floor_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_16_multi_class_sprd
        type: b1
      - id: order_acknowledgment_return_bitfield_16_order_origin
        type: b1
  order_acknowledgment_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_17_price_type
        type: b1
      - id: order_acknowledgment_return_bitfield_17_strategy_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_trading_session_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_acknowledgment_return_bitfield_17_sender_location_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_acknowledgment_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_acknowledgment_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_18_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_18_cross_initiator
        type: b1
      - id: order_acknowledgment_return_bitfield_18_subreason
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_128
        type: b1
  quote_update_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Update message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0. <space> = Success See Quote Reason Codes for a list of possible quote reject codes. Additional reasons may be added in the future without warning'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future expansion. Filled with 0'
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
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result of the quote request. Acceptance: A = New Quote L = Modified; loss of priority R = Modified; retains priority (size reduction) N = No change, matches existing quote D = New Quote, but may remove liquidity d = Modified, but may remove liquidity Cancellation: U = User cancelled (zero size/price requested) Rejection: a = Admin P = Rejected, can’t post f = Risk management EFID or Custom Group ID level S = Rejected, symbol not found p = Rejected, invalid price s = Risk management product root level n = Risk management configuration is not sufficient u = Rejected, other reason Additional reasons indicating a reject may be added in the future with no notice'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: reserved_6
        size: 6
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See ‘Section 8 – Reason Codes’ for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_clearing_account > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_open_close > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and order_rejected_return_bitfield_9.order_rejected_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_oeoid > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_rejected_return_bitfield_16.order_rejected_return_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_rejected_return_bitfield_17.order_rejected_return_bitfield_17_cust_order_handling_inst > 0
  order_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_1_side
        type: b1
      - id: order_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: order_rejected_return_bitfield_1_price
        type: b1
      - id: order_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: order_rejected_return_bitfield_1_order_type
        type: b1
      - id: order_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: order_rejected_return_bitfield_1_min_qty
        type: b1
      - id: order_rejected_return_bitfield_1_max_remove_pct
        type: b1
  order_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_2_symbol
        type: b1
      - id: order_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_rejected_return_bitfield_2_currency
        type: b1
      - id: order_rejected_return_bitfield_2_id_source
        type: b1
      - id: order_rejected_return_bitfield_2_security_id
        type: b1
      - id: order_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: order_rejected_return_bitfield_2_capacity
        type: b1
      - id: order_rejected_return_bitfield_2_reserved_128
        type: b1
  order_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_3_account
        type: b1
      - id: order_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: order_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: order_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: order_rejected_return_bitfield_3_max_floor
        type: b1
      - id: order_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: order_rejected_return_bitfield_3_order_qty
        type: b1
      - id: order_rejected_return_bitfield_3_prevent_match
        type: b1
  order_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: order_rejected_return_bitfield_4_strike_price
        type: b1
      - id: order_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: order_rejected_return_bitfield_4_open_close
        type: b1
      - id: order_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: order_rejected_return_bitfield_4_party_id
        type: b1
      - id: order_rejected_return_bitfield_4_access_fee
        type: b1
  order_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: order_rejected_return_bitfield_5_last_shares
        type: b1
      - id: order_rejected_return_bitfield_5_last_px
        type: b1
      - id: order_rejected_return_bitfield_5_display_price
        type: b1
      - id: order_rejected_return_bitfield_5_working_price
        type: b1
      - id: order_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_5_expire_time
        type: b1
  order_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_rejected_return_bitfield_6_ccp
        type: b1
      - id: order_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: order_rejected_return_bitfield_6_attributed_order
        type: b1
      - id: order_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_rejected_return_bitfield_6_party_role
        type: b1
  order_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_rejected_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_rejected_return_bitfield_7_text
        type: b1
      - id: order_rejected_return_bitfield_7_bid
        type: b1
      - id: order_rejected_return_bitfield_7_offer
        type: b1
      - id: order_rejected_return_bitfield_7_large_size
        type: b1
      - id: order_rejected_return_bitfield_7_last_mkt
        type: b1
  order_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_8_fee_code
        type: b1
      - id: order_rejected_return_bitfield_8_echo_text
        type: b1
      - id: order_rejected_return_bitfield_8_stop_px
        type: b1
      - id: order_rejected_return_bitfield_8_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_8_rout_strategy
        type: b1
      - id: order_rejected_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_rejected_return_bitfield_8_ex_destination
        type: b1
      - id: order_rejected_return_bitfield_8_trade_report_ref_id
        type: b1
  order_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_rejected_return_bitfield_9_target_party_id
        type: b1
      - id: order_rejected_return_bitfield_9_auction_id
        type: b1
      - id: order_rejected_return_bitfield_9_order_category
        type: b1
      - id: order_rejected_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_rejected_return_bitfield_9_cmta_number
        type: b1
      - id: order_rejected_return_bitfield_9_cross_type
        type: b1
      - id: order_rejected_return_bitfield_9_cross_prioritization
        type: b1
  order_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_10_cross_id
        type: b1
      - id: order_rejected_return_bitfield_10_alloc_qty
        type: b1
      - id: order_rejected_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_rejected_return_bitfield_10_routing_f_irm_id
        type: b1
      - id: order_rejected_return_bitfield_10_waiver_type
        type: b1
      - id: order_rejected_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_rejected_return_bitfield_10_price_formation
        type: b1
      - id: order_rejected_return_bitfield_10_client_qualified_role
        type: b1
  order_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_11_client_id
        type: b1
      - id: order_rejected_return_bitfield_11_investor_id
        type: b1
      - id: order_rejected_return_bitfield_11_executor_id
        type: b1
      - id: order_rejected_return_bitfield_11_order_origination
        type: b1
      - id: order_rejected_return_bitfield_11_algo
        type: b1
      - id: order_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: order_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  order_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_12_cti_code
        type: b1
      - id: order_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_rejected_return_bitfield_12_oeoid
        type: b1
      - id: order_rejected_return_bitfield_12_trade_date
        type: b1
      - id: order_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: order_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: order_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_rejected_return_bitfield_12_reserved_128
        type: b1
  order_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: order_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_13_avg_px
        type: b1
      - id: order_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: order_rejected_return_bitfield_13_pending_status
        type: b1
      - id: order_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  order_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_rejected_return_bitfield_14_room_id
        type: b1
      - id: order_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: order_rejected_return_bitfield_14_sis_username
        type: b1
      - id: order_rejected_return_bitfield_14_user_status
        type: b1
  order_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: order_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_rejected_return_bitfield_15_report_time
        type: b1
      - id: order_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_rejected_return_bitfield_15_client_id_attr
        type: b1
  order_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: order_rejected_return_bitfield_16_combo_order
        type: b1
      - id: order_rejected_return_bitfield_16_compression
        type: b1
      - id: order_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: order_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_16_multi_class_sprd
        type: b1
      - id: order_rejected_return_bitfield_16_order_origin
        type: b1
  order_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_17_price_type
        type: b1
      - id: order_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: order_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: order_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: order_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: order_rejected_return_bitfield_18_subreason
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_128
        type: b1
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Update message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0. <space> = Success See Quote Reason Codes for a list of possible quote reject codes. Additional reasons may be added in the future without warning'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future expansion. Filled with 0'
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_clearing_account > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_modified_return_bitfield_4.order_modified_return_bitfield_4_open_close > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_leaves_qty > 0
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_base_liquidity_indicator > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_modified_return_bitfield_8.order_modified_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and order_modified_return_bitfield_12.order_modified_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_modified_return_bitfield_12.order_modified_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_modified_return_bitfield_12.order_modified_return_bitfield_12_oeoid > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_modified_return_bitfield_16.order_modified_return_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_modified_return_bitfield_17.order_modified_return_bitfield_17_cust_order_handling_inst > 0
  order_modified_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_1_side
        type: b1
      - id: order_modified_return_bitfield_1_peg_difference
        type: b1
      - id: order_modified_return_bitfield_1_price
        type: b1
      - id: order_modified_return_bitfield_1_exec_inst
        type: b1
      - id: order_modified_return_bitfield_1_order_type
        type: b1
      - id: order_modified_return_bitfield_1_time_in_force
        type: b1
      - id: order_modified_return_bitfield_1_min_qty
        type: b1
      - id: order_modified_return_bitfield_1_max_remove_pct
        type: b1
  order_modified_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_2_symbol
        type: b1
      - id: order_modified_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_modified_return_bitfield_2_currency
        type: b1
      - id: order_modified_return_bitfield_2_id_source
        type: b1
      - id: order_modified_return_bitfield_2_security_id
        type: b1
      - id: order_modified_return_bitfield_2_security_exchange
        type: b1
      - id: order_modified_return_bitfield_2_capacity
        type: b1
      - id: order_modified_return_bitfield_2_reserved_128
        type: b1
  order_modified_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_3_account
        type: b1
      - id: order_modified_return_bitfield_3_clearing_firm
        type: b1
      - id: order_modified_return_bitfield_3_clearing_account
        type: b1
      - id: order_modified_return_bitfield_3_display_indicator
        type: b1
      - id: order_modified_return_bitfield_3_max_floor
        type: b1
      - id: order_modified_return_bitfield_3_discretion_amount
        type: b1
      - id: order_modified_return_bitfield_3_order_qty
        type: b1
      - id: order_modified_return_bitfield_3_prevent_match
        type: b1
  order_modified_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_4_maturity_date
        type: b1
      - id: order_modified_return_bitfield_4_strike_price
        type: b1
      - id: order_modified_return_bitfield_4_put_or_call
        type: b1
      - id: order_modified_return_bitfield_4_open_close
        type: b1
      - id: order_modified_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_modified_return_bitfield_4_corrected_size
        type: b1
      - id: order_modified_return_bitfield_4_party_id
        type: b1
      - id: order_modified_return_bitfield_4_access_fee
        type: b1
  order_modified_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_modified_return_bitfield_5_leaves_qty
        type: b1
      - id: order_modified_return_bitfield_5_last_shares
        type: b1
      - id: order_modified_return_bitfield_5_last_px
        type: b1
      - id: order_modified_return_bitfield_5_display_price
        type: b1
      - id: order_modified_return_bitfield_5_working_price
        type: b1
      - id: order_modified_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_modified_return_bitfield_5_expire_time
        type: b1
  order_modified_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_modified_return_bitfield_6_ccp
        type: b1
      - id: order_modified_return_bitfield_6_contra_capacity
        type: b1
      - id: order_modified_return_bitfield_6_attributed_order
        type: b1
      - id: order_modified_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_modified_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_modified_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_modified_return_bitfield_6_party_role
        type: b1
  order_modified_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_modified_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_modified_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_modified_return_bitfield_7_text
        type: b1
      - id: order_modified_return_bitfield_7_bid
        type: b1
      - id: order_modified_return_bitfield_7_offer
        type: b1
      - id: order_modified_return_bitfield_7_large_size
        type: b1
      - id: order_modified_return_bitfield_7_last_mkt
        type: b1
  order_modified_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_8_fee_code
        type: b1
      - id: order_modified_return_bitfield_8_echo_text
        type: b1
      - id: order_modified_return_bitfield_8_stop_px
        type: b1
      - id: order_modified_return_bitfield_8_routing_inst
        type: b1
      - id: order_modified_return_bitfield_8_rout_strategy
        type: b1
      - id: order_modified_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_modified_return_bitfield_8_ex_destination
        type: b1
      - id: order_modified_return_bitfield_8_trade_report_ref_id
        type: b1
  order_modified_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_modified_return_bitfield_9_target_party_id
        type: b1
      - id: order_modified_return_bitfield_9_auction_id
        type: b1
      - id: order_modified_return_bitfield_9_order_category
        type: b1
      - id: order_modified_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_modified_return_bitfield_9_cmta_number
        type: b1
      - id: order_modified_return_bitfield_9_cross_type
        type: b1
      - id: order_modified_return_bitfield_9_cross_prioritization
        type: b1
  order_modified_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_10_cross_id
        type: b1
      - id: order_modified_return_bitfield_10_alloc_qty
        type: b1
      - id: order_modified_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_modified_return_bitfield_10_routing_f_irm_id
        type: b1
      - id: order_modified_return_bitfield_10_waiver_type
        type: b1
      - id: order_modified_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_modified_return_bitfield_10_price_formation
        type: b1
      - id: order_modified_return_bitfield_10_client_qualified_role
        type: b1
  order_modified_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_11_client_id
        type: b1
      - id: order_modified_return_bitfield_11_investor_id
        type: b1
      - id: order_modified_return_bitfield_11_executor_id
        type: b1
      - id: order_modified_return_bitfield_11_order_origination
        type: b1
      - id: order_modified_return_bitfield_11_algo
        type: b1
      - id: order_modified_return_bitfield_11_deferral_reason
        type: b1
      - id: order_modified_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_modified_return_bitfield_11_executor_qualified_role
        type: b1
  order_modified_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_12_cti_code
        type: b1
      - id: order_modified_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_modified_return_bitfield_12_oeoid
        type: b1
      - id: order_modified_return_bitfield_12_trade_date
        type: b1
      - id: order_modified_return_bitfield_12_clearing_price
        type: b1
      - id: order_modified_return_bitfield_12_clearing_size
        type: b1
      - id: order_modified_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_modified_return_bitfield_12_reserved_128
        type: b1
  order_modified_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_13_cum_qty
        type: b1
      - id: order_modified_return_bitfield_13_day_order_qty
        type: b1
      - id: order_modified_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_modified_return_bitfield_13_avg_px
        type: b1
      - id: order_modified_return_bitfield_13_day_avg_px
        type: b1
      - id: order_modified_return_bitfield_13_pending_status
        type: b1
      - id: order_modified_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_modified_return_bitfield_13_multileg_reporting_type
        type: b1
  order_modified_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_modified_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_modified_return_bitfield_14_room_id
        type: b1
      - id: order_modified_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_modified_return_bitfield_14_user_request_id
        type: b1
      - id: order_modified_return_bitfield_14_sis_username
        type: b1
      - id: order_modified_return_bitfield_14_user_status
        type: b1
  order_modified_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_modified_return_bitfield_15_equity_party_id
        type: b1
      - id: order_modified_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_modified_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_modified_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_modified_return_bitfield_15_report_time
        type: b1
      - id: order_modified_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_modified_return_bitfield_15_client_id_attr
        type: b1
  order_modified_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_modified_return_bitfield_16_session_eligibility
        type: b1
      - id: order_modified_return_bitfield_16_combo_order
        type: b1
      - id: order_modified_return_bitfield_16_compression
        type: b1
      - id: order_modified_return_bitfield_16_floor_destination
        type: b1
      - id: order_modified_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_modified_return_bitfield_16_multi_class_sprd
        type: b1
      - id: order_modified_return_bitfield_16_order_origin
        type: b1
  order_modified_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_17_price_type
        type: b1
      - id: order_modified_return_bitfield_17_strategy_id
        type: b1
      - id: order_modified_return_bitfield_17_trading_session_id
        type: b1
      - id: order_modified_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_modified_return_bitfield_17_sender_location_id
        type: b1
      - id: order_modified_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_modified_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_modified_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_18_reserved_1
        type: b1
      - id: order_modified_return_bitfield_18_cross_initiator
        type: b1
      - id: order_modified_return_bitfield_18_subreason
        type: b1
      - id: order_modified_return_bitfield_18_reserved_8
        type: b1
      - id: order_modified_return_bitfield_18_reserved_16
        type: b1
      - id: order_modified_return_bitfield_18_reserved_32
        type: b1
      - id: order_modified_return_bitfield_18_reserved_64
        type: b1
      - id: order_modified_return_bitfield_18_reserved_128
        type: b1
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: leaves_qty
        type: u4
      - id: working_price
        type: u8
        doc: 'New working price'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFE native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Quote Restated message. Q = Liquidity W = Wash CFE reserves the right to add new values as necessary without prior notice'
  user_modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection. See ‘Section 8 – Reason Codes’ for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
  user_modify_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_1_side
        type: b1
      - id: user_modify_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: user_modify_rejected_return_bitfield_1_price
        type: b1
      - id: user_modify_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_1_order_type
        type: b1
      - id: user_modify_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: user_modify_rejected_return_bitfield_1_min_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_1_max_remove_pct
        type: b1
  user_modify_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_2_symbol
        type: b1
      - id: user_modify_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: user_modify_rejected_return_bitfield_2_currency
        type: b1
      - id: user_modify_rejected_return_bitfield_2_id_source
        type: b1
      - id: user_modify_rejected_return_bitfield_2_security_id
        type: b1
      - id: user_modify_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: user_modify_rejected_return_bitfield_2_capacity
        type: b1
      - id: user_modify_rejected_return_bitfield_2_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_3_account
        type: b1
      - id: user_modify_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: user_modify_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: user_modify_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_3_max_floor
        type: b1
      - id: user_modify_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: user_modify_rejected_return_bitfield_3_order_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_3_prevent_match
        type: b1
  user_modify_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: user_modify_rejected_return_bitfield_4_strike_price
        type: b1
      - id: user_modify_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: user_modify_rejected_return_bitfield_4_open_close
        type: b1
      - id: user_modify_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: user_modify_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: user_modify_rejected_return_bitfield_4_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_4_access_fee
        type: b1
  user_modify_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: user_modify_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_5_last_shares
        type: b1
      - id: user_modify_rejected_return_bitfield_5_last_px
        type: b1
      - id: user_modify_rejected_return_bitfield_5_display_price
        type: b1
      - id: user_modify_rejected_return_bitfield_5_working_price
        type: b1
      - id: user_modify_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_5_expire_time
        type: b1
  user_modify_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: user_modify_rejected_return_bitfield_6_ccp
        type: b1
      - id: user_modify_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: user_modify_rejected_return_bitfield_6_attributed_order
        type: b1
      - id: user_modify_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: user_modify_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: user_modify_rejected_return_bitfield_6_party_role
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
      - id: user_modify_rejected_return_bitfield_10_routing_f_irm_id
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
      - id: user_modify_rejected_return_bitfield_11_executor_id
        type: b1
      - id: user_modify_rejected_return_bitfield_11_order_origination
        type: b1
      - id: user_modify_rejected_return_bitfield_11_algo
        type: b1
      - id: user_modify_rejected_return_bitfield_11_deferral_reason
        type: b1
      - id: user_modify_rejected_return_bitfield_11_investor_qualified_role
        type: b1
      - id: user_modify_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  user_modify_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_12_cti_code
        type: b1
      - id: user_modify_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_12_oeoid
        type: b1
      - id: user_modify_rejected_return_bitfield_12_trade_date
        type: b1
      - id: user_modify_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: user_modify_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: user_modify_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: user_modify_rejected_return_bitfield_12_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_13_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_13_pending_status
        type: b1
      - id: user_modify_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: user_modify_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  user_modify_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: user_modify_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: user_modify_rejected_return_bitfield_14_room_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_sis_username
        type: b1
      - id: user_modify_rejected_return_bitfield_14_user_status
        type: b1
  user_modify_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: user_modify_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: user_modify_rejected_return_bitfield_15_report_time
        type: b1
      - id: user_modify_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: user_modify_rejected_return_bitfield_15_client_id_attr
        type: b1
  user_modify_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: user_modify_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: user_modify_rejected_return_bitfield_16_combo_order
        type: b1
      - id: user_modify_rejected_return_bitfield_16_compression
        type: b1
      - id: user_modify_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_16_multi_class_sprd
        type: b1
      - id: user_modify_rejected_return_bitfield_16_order_origin
        type: b1
  user_modify_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_17_price_type
        type: b1
      - id: user_modify_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: user_modify_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: user_modify_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: user_modify_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: user_modify_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: user_modify_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  user_modify_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: user_modify_rejected_return_bitfield_18_subreason
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_18_reserved_128
        type: b1
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See ‘Section 8 – Reason Codes’ for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_clearing_account > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_cancelled_return_bitfield_4.order_cancelled_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_cancelled_return_bitfield_4.order_cancelled_return_bitfield_4_open_close > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_cancelled_return_bitfield_6.order_cancelled_return_bitfield_6_secondary_order_id > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_cancelled_return_bitfield_8.order_cancelled_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and order_cancelled_return_bitfield_9.order_cancelled_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_oeoid > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_cancelled_return_bitfield_16.order_cancelled_return_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_cancelled_return_bitfield_17.order_cancelled_return_bitfield_17_cust_order_handling_inst > 0
  order_cancelled_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_1_side
        type: b1
      - id: order_cancelled_return_bitfield_1_peg_difference
        type: b1
      - id: order_cancelled_return_bitfield_1_price
        type: b1
      - id: order_cancelled_return_bitfield_1_exec_inst
        type: b1
      - id: order_cancelled_return_bitfield_1_order_type
        type: b1
      - id: order_cancelled_return_bitfield_1_time_in_force
        type: b1
      - id: order_cancelled_return_bitfield_1_min_qty
        type: b1
      - id: order_cancelled_return_bitfield_1_max_remove_pct
        type: b1
  order_cancelled_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_2_symbol
        type: b1
      - id: order_cancelled_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_cancelled_return_bitfield_2_currency
        type: b1
      - id: order_cancelled_return_bitfield_2_id_source
        type: b1
      - id: order_cancelled_return_bitfield_2_security_id
        type: b1
      - id: order_cancelled_return_bitfield_2_security_exchange
        type: b1
      - id: order_cancelled_return_bitfield_2_capacity
        type: b1
      - id: order_cancelled_return_bitfield_2_reserved_128
        type: b1
  order_cancelled_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_3_account
        type: b1
      - id: order_cancelled_return_bitfield_3_clearing_firm
        type: b1
      - id: order_cancelled_return_bitfield_3_clearing_account
        type: b1
      - id: order_cancelled_return_bitfield_3_display_indicator
        type: b1
      - id: order_cancelled_return_bitfield_3_max_floor
        type: b1
      - id: order_cancelled_return_bitfield_3_discretion_amount
        type: b1
      - id: order_cancelled_return_bitfield_3_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_3_prevent_match
        type: b1
  order_cancelled_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_4_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_4_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_4_put_or_call
        type: b1
      - id: order_cancelled_return_bitfield_4_open_close
        type: b1
      - id: order_cancelled_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_cancelled_return_bitfield_4_corrected_size
        type: b1
      - id: order_cancelled_return_bitfield_4_party_id
        type: b1
      - id: order_cancelled_return_bitfield_4_access_fee
        type: b1
  order_cancelled_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_cancelled_return_bitfield_5_leaves_qty
        type: b1
      - id: order_cancelled_return_bitfield_5_last_shares
        type: b1
      - id: order_cancelled_return_bitfield_5_last_px
        type: b1
      - id: order_cancelled_return_bitfield_5_display_price
        type: b1
      - id: order_cancelled_return_bitfield_5_working_price
        type: b1
      - id: order_cancelled_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_cancelled_return_bitfield_5_expire_time
        type: b1
  order_cancelled_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_cancelled_return_bitfield_6_ccp
        type: b1
      - id: order_cancelled_return_bitfield_6_contra_capacity
        type: b1
      - id: order_cancelled_return_bitfield_6_attributed_order
        type: b1
      - id: order_cancelled_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_cancelled_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_cancelled_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_cancelled_return_bitfield_6_party_role
        type: b1
  order_cancelled_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_cancelled_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_cancelled_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_cancelled_return_bitfield_7_text
        type: b1
      - id: order_cancelled_return_bitfield_7_bid
        type: b1
      - id: order_cancelled_return_bitfield_7_offer
        type: b1
      - id: order_cancelled_return_bitfield_7_large_size
        type: b1
      - id: order_cancelled_return_bitfield_7_last_mkt
        type: b1
  order_cancelled_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_8_fee_code
        type: b1
      - id: order_cancelled_return_bitfield_8_echo_text
        type: b1
      - id: order_cancelled_return_bitfield_8_stop_px
        type: b1
      - id: order_cancelled_return_bitfield_8_routing_inst
        type: b1
      - id: order_cancelled_return_bitfield_8_rout_strategy
        type: b1
      - id: order_cancelled_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_cancelled_return_bitfield_8_ex_destination
        type: b1
      - id: order_cancelled_return_bitfield_8_trade_report_ref_id
        type: b1
  order_cancelled_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_cancelled_return_bitfield_9_target_party_id
        type: b1
      - id: order_cancelled_return_bitfield_9_auction_id
        type: b1
      - id: order_cancelled_return_bitfield_9_order_category
        type: b1
      - id: order_cancelled_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_cancelled_return_bitfield_9_cmta_number
        type: b1
      - id: order_cancelled_return_bitfield_9_cross_type
        type: b1
      - id: order_cancelled_return_bitfield_9_cross_prioritization
        type: b1
  order_cancelled_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_10_cross_id
        type: b1
      - id: order_cancelled_return_bitfield_10_alloc_qty
        type: b1
      - id: order_cancelled_return_bitfield_10_give_up_firm_id
        type: b1
      - id: order_cancelled_return_bitfield_10_routing_f_irm_id
        type: b1
      - id: order_cancelled_return_bitfield_10_waiver_type
        type: b1
      - id: order_cancelled_return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: order_cancelled_return_bitfield_10_price_formation
        type: b1
      - id: order_cancelled_return_bitfield_10_client_qualified_role
        type: b1
  order_cancelled_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_11_client_id
        type: b1
      - id: order_cancelled_return_bitfield_11_investor_id
        type: b1
      - id: order_cancelled_return_bitfield_11_executor_id
        type: b1
      - id: order_cancelled_return_bitfield_11_order_origination
        type: b1
      - id: order_cancelled_return_bitfield_11_algo
        type: b1
      - id: order_cancelled_return_bitfield_11_deferral_reason
        type: b1
      - id: order_cancelled_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_cancelled_return_bitfield_11_executor_qualified_role
        type: b1
  order_cancelled_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_12_cti_code
        type: b1
      - id: order_cancelled_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_cancelled_return_bitfield_12_oeoid
        type: b1
      - id: order_cancelled_return_bitfield_12_trade_date
        type: b1
      - id: order_cancelled_return_bitfield_12_clearing_price
        type: b1
      - id: order_cancelled_return_bitfield_12_clearing_size
        type: b1
      - id: order_cancelled_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_cancelled_return_bitfield_12_reserved_128
        type: b1
  order_cancelled_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_13_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_13_day_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_13_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_13_day_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_13_pending_status
        type: b1
      - id: order_cancelled_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_cancelled_return_bitfield_13_multileg_reporting_type
        type: b1
  order_cancelled_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_14_room_id
        type: b1
      - id: order_cancelled_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_cancelled_return_bitfield_14_user_request_id
        type: b1
      - id: order_cancelled_return_bitfield_14_sis_username
        type: b1
      - id: order_cancelled_return_bitfield_14_user_status
        type: b1
  order_cancelled_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_cancelled_return_bitfield_15_equity_party_id
        type: b1
      - id: order_cancelled_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_cancelled_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_cancelled_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_cancelled_return_bitfield_15_report_time
        type: b1
      - id: order_cancelled_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_cancelled_return_bitfield_15_client_id_attr
        type: b1
  order_cancelled_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_cancelled_return_bitfield_16_session_eligibility
        type: b1
      - id: order_cancelled_return_bitfield_16_combo_order
        type: b1
      - id: order_cancelled_return_bitfield_16_compression
        type: b1
      - id: order_cancelled_return_bitfield_16_floor_destination
        type: b1
      - id: order_cancelled_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_cancelled_return_bitfield_16_multi_class_sprd
        type: b1
      - id: order_cancelled_return_bitfield_16_order_origin
        type: b1
  order_cancelled_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_17_price_type
        type: b1
      - id: order_cancelled_return_bitfield_17_strategy_id
        type: b1
      - id: order_cancelled_return_bitfield_17_trading_session_id
        type: b1
      - id: order_cancelled_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_cancelled_return_bitfield_17_sender_location_id
        type: b1
      - id: order_cancelled_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_cancelled_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_cancelled_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_18_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_18_cross_initiator
        type: b1
      - id: order_cancelled_return_bitfield_18_subreason
        type: b1
      - id: order_cancelled_return_bitfield_18_reserved_8
        type: b1
      - id: order_cancelled_return_bitfield_18_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_18_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_18_reserved_64
        type: b1
      - id: order_cancelled_return_bitfield_18_reserved_128
        type: b1
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFE native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See ‘Section 8 – Reason Codes’ for a list of possible reasons'
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'See ‘Section 8 – Reason Codes’ for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_capacity > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and cancel_rejected_return_bitfield_4.cancel_rejected_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and cancel_rejected_return_bitfield_4.cancel_rejected_return_bitfield_4_open_close > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and cancel_rejected_return_bitfield_5.cancel_rejected_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and cancel_rejected_return_bitfield_8.cancel_rejected_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and cancel_rejected_return_bitfield_9.cancel_rejected_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and cancel_rejected_return_bitfield_12.cancel_rejected_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and cancel_rejected_return_bitfield_12.cancel_rejected_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and cancel_rejected_return_bitfield_12.cancel_rejected_return_bitfield_12_oeoid > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and cancel_rejected_return_bitfield_17.cancel_rejected_return_bitfield_17_cust_order_handling_inst > 0
  cancel_rejected_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_1_side
        type: b1
      - id: cancel_rejected_return_bitfield_1_peg_difference
        type: b1
      - id: cancel_rejected_return_bitfield_1_price
        type: b1
      - id: cancel_rejected_return_bitfield_1_exec_inst
        type: b1
      - id: cancel_rejected_return_bitfield_1_order_type
        type: b1
      - id: cancel_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: cancel_rejected_return_bitfield_1_min_qty
        type: b1
      - id: cancel_rejected_return_bitfield_1_max_remove_pct
        type: b1
  cancel_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_2_symbol
        type: b1
      - id: cancel_rejected_return_bitfield_2_symbol_sfx
        type: b1
      - id: cancel_rejected_return_bitfield_2_currency
        type: b1
      - id: cancel_rejected_return_bitfield_2_id_source
        type: b1
      - id: cancel_rejected_return_bitfield_2_security_id
        type: b1
      - id: cancel_rejected_return_bitfield_2_security_exchange
        type: b1
      - id: cancel_rejected_return_bitfield_2_capacity
        type: b1
      - id: cancel_rejected_return_bitfield_2_reserved_128
        type: b1
  cancel_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_3_account
        type: b1
      - id: cancel_rejected_return_bitfield_3_clearing_firm
        type: b1
      - id: cancel_rejected_return_bitfield_3_clearing_account
        type: b1
      - id: cancel_rejected_return_bitfield_3_display_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_3_max_floor
        type: b1
      - id: cancel_rejected_return_bitfield_3_discretion_amount
        type: b1
      - id: cancel_rejected_return_bitfield_3_order_qty
        type: b1
      - id: cancel_rejected_return_bitfield_3_prevent_match
        type: b1
  cancel_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_4_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_4_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_4_put_or_call
        type: b1
      - id: cancel_rejected_return_bitfield_4_open_close
        type: b1
      - id: cancel_rejected_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: cancel_rejected_return_bitfield_4_corrected_size
        type: b1
      - id: cancel_rejected_return_bitfield_4_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_4_access_fee
        type: b1
  cancel_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: cancel_rejected_return_bitfield_5_leaves_qty
        type: b1
      - id: cancel_rejected_return_bitfield_5_last_shares
        type: b1
      - id: cancel_rejected_return_bitfield_5_last_px
        type: b1
      - id: cancel_rejected_return_bitfield_5_display_price
        type: b1
      - id: cancel_rejected_return_bitfield_5_working_price
        type: b1
      - id: cancel_rejected_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_5_expire_time
        type: b1
  cancel_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_6_secondary_order_id
        type: b1
      - id: cancel_rejected_return_bitfield_6_ccp
        type: b1
      - id: cancel_rejected_return_bitfield_6_contra_capacity
        type: b1
      - id: cancel_rejected_return_bitfield_6_attributed_order
        type: b1
      - id: cancel_rejected_return_bitfield_6_ext_exec_inst
        type: b1
      - id: cancel_rejected_return_bitfield_6_bulk_order_ids
        type: b1
      - id: cancel_rejected_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: cancel_rejected_return_bitfield_6_party_role
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
      - id: cancel_rejected_return_bitfield_10_routing_f_irm_id
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
      - id: cancel_rejected_return_bitfield_11_executor_qualified_role
        type: b1
  cancel_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_12_cti_code
        type: b1
      - id: cancel_rejected_return_bitfield_12_manual_order_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_12_oeoid
        type: b1
      - id: cancel_rejected_return_bitfield_12_trade_date
        type: b1
      - id: cancel_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: cancel_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: cancel_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: cancel_rejected_return_bitfield_12_reserved_128
        type: b1
  cancel_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_13_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_13_day_order_qty
        type: b1
      - id: cancel_rejected_return_bitfield_13_day_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_13_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_13_day_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_13_pending_status
        type: b1
      - id: cancel_rejected_return_bitfield_13_drill_thru_protection
        type: b1
      - id: cancel_rejected_return_bitfield_13_multileg_reporting_type
        type: b1
  cancel_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_14_leg_cfi_code
        type: b1
      - id: cancel_rejected_return_bitfield_14_leg_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_14_leg_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_14_room_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_sis_username
        type: b1
      - id: cancel_rejected_return_bitfield_14_user_status
        type: b1
  cancel_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_15_equity_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: cancel_rejected_return_bitfield_15_mass_cancel_id
        type: b1
      - id: cancel_rejected_return_bitfield_15_trade_publish_ind
        type: b1
      - id: cancel_rejected_return_bitfield_15_report_time
        type: b1
      - id: cancel_rejected_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: cancel_rejected_return_bitfield_15_client_id_attr
        type: b1
  cancel_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_16_frequent_trader_id
        type: b1
      - id: cancel_rejected_return_bitfield_16_session_eligibility
        type: b1
      - id: cancel_rejected_return_bitfield_16_combo_order
        type: b1
      - id: cancel_rejected_return_bitfield_16_compression
        type: b1
      - id: cancel_rejected_return_bitfield_16_floor_destination
        type: b1
      - id: cancel_rejected_return_bitfield_16_floor_routing_inst
        type: b1
      - id: cancel_rejected_return_bitfield_16_multi_class_sprd
        type: b1
      - id: cancel_rejected_return_bitfield_16_order_origin
        type: b1
  cancel_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_17_price_type
        type: b1
      - id: cancel_rejected_return_bitfield_17_strategy_id
        type: b1
      - id: cancel_rejected_return_bitfield_17_trading_session_id
        type: b1
      - id: cancel_rejected_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: cancel_rejected_return_bitfield_17_sender_location_id
        type: b1
      - id: cancel_rejected_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: cancel_rejected_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: cancel_rejected_return_bitfield_17_cust_order_handling_inst
        type: b1
  cancel_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: cancel_rejected_return_bitfield_18_cross_initiator
        type: b1
      - id: cancel_rejected_return_bitfield_18_subreason
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_128
        type: b1
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
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
        doc: 'Corresponds to ContraBroker (375) in CFE FIX. Value always set to “CFE”'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_execution_return_bitfield_2.order_execution_return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_clearing_account > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_order_qty > 0
        doc: 'Corresponds to OrderQty (38) in CFE FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_open_close > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_return_bitfield_8.order_execution_return_bitfield_8_fee_code > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_execution_return_bitfield_8.order_execution_return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and order_execution_return_bitfield_9.order_execution_return_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_oeoid > 0
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_trade_date > 0
      - id: clearing_size
        type: u4
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_clearing_size > 0
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_cum_qty > 0
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_day_order_qty > 0
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_day_cum_qty > 0
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_avg_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: day_avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_day_avg_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: pending_status
        type: u1
        enum: pending_status
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_pending_status > 0
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_return_bitfields >= 13 and order_execution_return_bitfield_13.order_execution_return_bitfield_13_multileg_reporting_type > 0
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and order_execution_return_bitfield_14.order_execution_return_bitfield_14_secondary_exec_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_execution_return_bitfield_16.order_execution_return_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_return_bitfields >= 17 and order_execution_return_bitfield_17.order_execution_return_bitfield_17_cust_order_handling_inst > 0
  order_execution_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_1_side
        type: b1
      - id: order_execution_return_bitfield_1_peg_difference
        type: b1
      - id: order_execution_return_bitfield_1_price
        type: b1
      - id: order_execution_return_bitfield_1_exec_inst
        type: b1
      - id: order_execution_return_bitfield_1_order_type
        type: b1
      - id: order_execution_return_bitfield_1_time_in_force
        type: b1
      - id: order_execution_return_bitfield_1_min_qty
        type: b1
      - id: order_execution_return_bitfield_1_max_remove_pct
        type: b1
  order_execution_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_2_symbol
        type: b1
      - id: order_execution_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_2_currency
        type: b1
      - id: order_execution_return_bitfield_2_id_source
        type: b1
      - id: order_execution_return_bitfield_2_security_id
        type: b1
      - id: order_execution_return_bitfield_2_security_exchange
        type: b1
      - id: order_execution_return_bitfield_2_capacity
        type: b1
      - id: order_execution_return_bitfield_2_reserved_128
        type: b1
  order_execution_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_3_account
        type: b1
      - id: order_execution_return_bitfield_3_clearing_firm
        type: b1
      - id: order_execution_return_bitfield_3_clearing_account
        type: b1
      - id: order_execution_return_bitfield_3_display_indicator
        type: b1
      - id: order_execution_return_bitfield_3_max_floor
        type: b1
      - id: order_execution_return_bitfield_3_discretion_amount
        type: b1
      - id: order_execution_return_bitfield_3_order_qty
        type: b1
      - id: order_execution_return_bitfield_3_prevent_match
        type: b1
  order_execution_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_4_maturity_date
        type: b1
      - id: order_execution_return_bitfield_4_strike_price
        type: b1
      - id: order_execution_return_bitfield_4_put_or_call
        type: b1
      - id: order_execution_return_bitfield_4_open_close
        type: b1
      - id: order_execution_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: order_execution_return_bitfield_4_corrected_size
        type: b1
      - id: order_execution_return_bitfield_4_party_id
        type: b1
      - id: order_execution_return_bitfield_4_access_fee
        type: b1
  order_execution_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_5_orig_cl_ord_id
        type: b1
      - id: order_execution_return_bitfield_5_leaves_qty
        type: b1
      - id: order_execution_return_bitfield_5_last_shares
        type: b1
      - id: order_execution_return_bitfield_5_last_px
        type: b1
      - id: order_execution_return_bitfield_5_display_price
        type: b1
      - id: order_execution_return_bitfield_5_working_price
        type: b1
      - id: order_execution_return_bitfield_5_base_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_5_expire_time
        type: b1
  order_execution_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_6_secondary_order_id
        type: b1
      - id: order_execution_return_bitfield_6_ccp
        type: b1
      - id: order_execution_return_bitfield_6_contra_capacity
        type: b1
      - id: order_execution_return_bitfield_6_attributed_order
        type: b1
      - id: order_execution_return_bitfield_6_ext_exec_inst
        type: b1
      - id: order_execution_return_bitfield_6_bulk_order_ids
        type: b1
      - id: order_execution_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: order_execution_return_bitfield_6_party_role
        type: b1
  order_execution_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_7_trade_report_type_return
        type: b1
      - id: order_execution_return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: order_execution_return_bitfield_7_text
        type: b1
      - id: order_execution_return_bitfield_7_bid
        type: b1
      - id: order_execution_return_bitfield_7_offer
        type: b1
      - id: order_execution_return_bitfield_7_large_size
        type: b1
      - id: order_execution_return_bitfield_7_last_mkt
        type: b1
  order_execution_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_8_fee_code
        type: b1
      - id: order_execution_return_bitfield_8_echo_text
        type: b1
      - id: order_execution_return_bitfield_8_stop_px
        type: b1
      - id: order_execution_return_bitfield_8_routing_inst
        type: b1
      - id: order_execution_return_bitfield_8_rout_strategy
        type: b1
      - id: order_execution_return_bitfield_8_route_delivery_method
        type: b1
      - id: order_execution_return_bitfield_8_ex_destination
        type: b1
      - id: order_execution_return_bitfield_8_trade_report_ref_id
        type: b1
  order_execution_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_9_marketing_fee_code
        type: b1
      - id: order_execution_return_bitfield_9_target_party_id
        type: b1
      - id: order_execution_return_bitfield_9_auction_id
        type: b1
      - id: order_execution_return_bitfield_9_order_category
        type: b1
      - id: order_execution_return_bitfield_9_liquidity_provision
        type: b1
      - id: order_execution_return_bitfield_9_cmta_number
        type: b1
      - id: order_execution_return_bitfield_9_cross_type
        type: b1
      - id: order_execution_return_bitfield_9_cross_prioritization
        type: b1
  order_execution_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_10_cross_id
        type: b1
      - id: order_execution_return_bitfield_10_alloc_qty
        type: b1
      - id: order_execution_return_bitfield_10_give_up_firm_id_combo_order
        type: b1
      - id: order_execution_return_bitfield_10_routing_f_irm_id
        type: b1
      - id: order_execution_return_bitfield_10_waiver_type_floor_destination
        type: b1
      - id: order_execution_return_bitfield_10_cross_exclusion_indicator_floor_routing_inst
        type: b1
      - id: order_execution_return_bitfield_10_price_formation_multi_class_sprd
        type: b1
      - id: order_execution_return_bitfield_10_client_qualified_role
        type: b1
  order_execution_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_11_client_id
        type: b1
      - id: order_execution_return_bitfield_11_investor_id
        type: b1
      - id: order_execution_return_bitfield_11_executor_id
        type: b1
      - id: order_execution_return_bitfield_11_order_origination
        type: b1
      - id: order_execution_return_bitfield_11_algo
        type: b1
      - id: order_execution_return_bitfield_11_deferral_reason
        type: b1
      - id: order_execution_return_bitfield_11_investor_qualified_role
        type: b1
      - id: order_execution_return_bitfield_11_executor_qualified_role
        type: b1
  order_execution_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_12_cti_code
        type: b1
      - id: order_execution_return_bitfield_12_manual_order_indicator
        type: b1
      - id: order_execution_return_bitfield_12_oeoid
        type: b1
      - id: order_execution_return_bitfield_12_trade_date
        type: b1
      - id: order_execution_return_bitfield_12_clearing_price
        type: b1
      - id: order_execution_return_bitfield_12_clearing_size
        type: b1
      - id: order_execution_return_bitfield_12_clearing_symbol
        type: b1
      - id: order_execution_return_bitfield_12_reserved_128
        type: b1
  order_execution_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_13_cum_qty
        type: b1
      - id: order_execution_return_bitfield_13_day_order_qty
        type: b1
      - id: order_execution_return_bitfield_13_day_cum_qty
        type: b1
      - id: order_execution_return_bitfield_13_avg_px
        type: b1
      - id: order_execution_return_bitfield_13_day_avg_px
        type: b1
      - id: order_execution_return_bitfield_13_pending_status
        type: b1
      - id: order_execution_return_bitfield_13_drill_thru_protection
        type: b1
      - id: order_execution_return_bitfield_13_multileg_reporting_type
        type: b1
  order_execution_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_14_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_14_leg_maturity_date
        type: b1
      - id: order_execution_return_bitfield_14_leg_strike_price
        type: b1
      - id: order_execution_return_bitfield_14_room_id
        type: b1
      - id: order_execution_return_bitfield_14_secondary_exec_id
        type: b1
      - id: order_execution_return_bitfield_14_user_request_id
        type: b1
      - id: order_execution_return_bitfield_14_sis_username
        type: b1
      - id: order_execution_return_bitfield_14_user_status
        type: b1
  order_execution_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: order_execution_return_bitfield_15_equity_party_id
        type: b1
      - id: order_execution_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_execution_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_execution_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_execution_return_bitfield_15_report_time
        type: b1
      - id: order_execution_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_15_client_id_attr
        type: b1
  order_execution_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_execution_return_bitfield_16_session_eligibility
        type: b1
      - id: order_execution_return_bitfield_16_compression
        type: b1
      - id: order_execution_return_bitfield_16_order_origin
        type: b1
      - id: order_execution_return_bitfield_16_reserved_16
        type: b1
      - id: order_execution_return_bitfield_16_reserved_32
        type: b1
      - id: order_execution_return_bitfield_16_reserved_64
        type: b1
      - id: order_execution_return_bitfield_16_reserved_128
        type: b1
  order_execution_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_17_price_type
        type: b1
      - id: order_execution_return_bitfield_17_strategy_id
        type: b1
      - id: order_execution_return_bitfield_17_trading_session_id
        type: b1
      - id: order_execution_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_execution_return_bitfield_17_sender_location_id
        type: b1
      - id: order_execution_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_execution_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_execution_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_18_reserved_1
        type: b1
      - id: order_execution_return_bitfield_18_cross_initiator
        type: b1
      - id: order_execution_return_bitfield_18_subreason
        type: b1
      - id: order_execution_return_bitfield_18_reserved_8
        type: b1
      - id: order_execution_return_bitfield_18_reserved_16
        type: b1
      - id: order_execution_return_bitfield_18_reserved_32
        type: b1
      - id: order_execution_return_bitfield_18_reserved_64
        type: b1
      - id: order_execution_return_bitfield_18_reserved_128
        type: b1
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFE native identifier'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: last_shares
        type: u4
      - id: last_px
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
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
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in CFE FIX. Order identifier supplied by CFE. This identifier corresponds to the identifiers used in CFE market data products. Sent to the OCC in the Exchange Data field'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in CFE FIX. Refers to the ExecID of the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
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
        doc: 'Reserved for CFE Internal use'
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
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_capacity > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_corrected_size > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and trade_cancelor_correct_return_bitfield_9.trade_cancelor_correct_return_bitfield_9_cmta_number > 0
  trade_cancelor_correct_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_1_side
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_peg_difference
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_exec_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_order_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_time_in_force
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_min_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_1_max_remove_pct
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
      - id: trade_cancelor_correct_return_bitfield_2_reserved_128
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
      - id: trade_cancelor_correct_return_bitfield_6_attributed_order
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_ext_exec_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_bulk_order_ids
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_party_role
        type: b1
  trade_cancelor_correct_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_7_sub_liquidity_indicator
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
      - id: trade_cancelor_correct_return_bitfield_10_routing_f_irm_id
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
      - id: trade_cancelor_correct_return_bitfield_12_oeoid
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_trade_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_clearing_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_clearing_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_clearing_symbol
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_13_cum_qty
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
      - id: trade_cancelor_correct_return_bitfield_13_multileg_reporting_type
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
      - id: trade_cancelor_correct_return_bitfield_15_trade_reporting_indicator
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
      - id: trade_cancelor_correct_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_sender_location_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_cust_order_handling_inst
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
      - id: trade_cancelor_correct_return_bitfield_18_reserved_8
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_32
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_64
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_128
        type: b1
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection. See ‘Section 8 – Reason Codes’ for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
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
        if: number_of_return_bitfields >= 15 and purge_rejected_return_bitfield_15.purge_rejected_return_bitfield_15_mass_cancel_id > 0
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
      - id: purge_rejected_return_bitfield_1_order_type
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
      - id: purge_rejected_return_bitfield_2_reserved_128
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
      - id: purge_rejected_return_bitfield_5_last_px
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
      - id: purge_rejected_return_bitfield_6_attributed_order
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
      - id: purge_rejected_return_bitfield_10_routing_f_irm_id
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
      - id: purge_rejected_return_bitfield_11_algo
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
      - id: purge_rejected_return_bitfield_12_oeoid
        type: b1
      - id: purge_rejected_return_bitfield_12_trade_date
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_price
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_size
        type: b1
      - id: purge_rejected_return_bitfield_12_clearing_symbol
        type: b1
      - id: purge_rejected_return_bitfield_12_reserved_128
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
      - id: purge_rejected_return_bitfield_14_room_id
        type: b1
      - id: purge_rejected_return_bitfield_14_secondary_exec_id
        type: b1
      - id: purge_rejected_return_bitfield_14_user_request_id
        type: b1
      - id: purge_rejected_return_bitfield_14_sis_username
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
      - id: purge_rejected_return_bitfield_16_multi_class_sprd
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
      - id: purge_rejected_return_bitfield_18_reserved_1
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
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: CFE only enforces uniqueness of RiskStatusID values among currently unacknowledged requests. However, we strongly recommend that you keep your RiskStatusID values day-unique'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: '<space> = Ignored; exceeds 1 reset per second Y = Success F = Rejected; exceeds firm reset limit C = Rejected; exceeds Custom Group ID limit E = Rejected; empty ResetRisk field I = Rejected; Incorrect data center S = Rejected; exceeds product level reset limit U = Rejected; invalid RiskRoot c = Rejected; invalid EFID/ClearingFirm'
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. This field corresponds to CancelledOrderCount (7696) in CFE FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
  tas_restatement_new_order_message_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
      - id: number_of_tas_restatement_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: tas_restatement_bitfield_1
        type: tas_restatement_bitfield_1
        if: number_of_tas_restatement_bitfields >= 1
        doc: 'BitSet TASRestatement byte 1'
      - id: tas_restatement_bitfield_2
        type: tas_restatement_bitfield_2
        if: number_of_tas_restatement_bitfields >= 2
        doc: 'BitSet TASRestatement byte 2'
      - id: tas_restatement_bitfield_3
        type: tas_restatement_bitfield_3
        if: number_of_tas_restatement_bitfields >= 3
        doc: 'BitSet TASRestatement byte 3'
      - id: tas_restatement_bitfield_4
        type: tas_restatement_bitfield_4
        if: number_of_tas_restatement_bitfields >= 4
        doc: 'BitSet TASRestatement byte 4'
      - id: tas_restatement_bitfield_5
        type: tas_restatement_bitfield_5
        if: number_of_tas_restatement_bitfields >= 5
        doc: 'BitSet TASRestatement byte 5'
      - id: tas_restatement_bitfield_6
        type: tas_restatement_bitfield_6
        if: number_of_tas_restatement_bitfields >= 6
        doc: 'BitSet TASRestatement byte 6'
      - id: tas_restatement_bitfield_7
        type: tas_restatement_bitfield_7
        if: number_of_tas_restatement_bitfields >= 7
        doc: 'BitSet TASRestatement byte 7'
      - id: tas_restatement_bitfield_8
        type: tas_restatement_bitfield_8
        if: number_of_tas_restatement_bitfields >= 8
        doc: 'BitSet TASRestatement byte 8'
      - id: tas_restatement_bitfield_9
        type: tas_restatement_bitfield_9
        if: number_of_tas_restatement_bitfields >= 9
        doc: 'BitSet TASRestatement byte 9'
      - id: tas_restatement_bitfield_10
        type: tas_restatement_bitfield_10
        if: number_of_tas_restatement_bitfields >= 10
        doc: 'BitSet TASRestatement byte 10'
      - id: tas_restatement_bitfield_11
        type: tas_restatement_bitfield_11
        if: number_of_tas_restatement_bitfields >= 11
        doc: 'BitSet TASRestatement byte 11'
      - id: tas_restatement_bitfield_12
        type: tas_restatement_bitfield_12
        if: number_of_tas_restatement_bitfields >= 12
        doc: 'BitSet TASRestatement byte 12'
      - id: tas_restatement_bitfield_13
        type: tas_restatement_bitfield_13
        if: number_of_tas_restatement_bitfields >= 13
        doc: 'BitSet TASRestatement byte 13'
      - id: tas_restatement_bitfield_14
        type: tas_restatement_bitfield_14
        if: number_of_tas_restatement_bitfields >= 14
        doc: 'BitSet TASRestatement byte 14'
      - id: tas_restatement_bitfield_15
        type: tas_restatement_bitfield_15
        if: number_of_tas_restatement_bitfields >= 15
        doc: 'BitSet TASRestatement byte 15'
      - id: tas_restatement_bitfield_16
        type: tas_restatement_bitfield_16
        if: number_of_tas_restatement_bitfields >= 16
        doc: 'BitSet TASRestatement byte 16'
      - id: tas_restatement_bitfield_17
        type: tas_restatement_bitfield_17
        if: number_of_tas_restatement_bitfields >= 17
        doc: 'BitSet TASRestatement byte 17'
      - id: tas_restatement_bitfield_18
        type: tas_restatement_bitfield_18
        if: number_of_tas_restatement_bitfields >= 18
        doc: 'BitSet TASRestatement byte 18'
      - id: side
        type: u1
        enum: side
        if: number_of_tas_restatement_bitfields >= 1 and tas_restatement_bitfield_1.tas_restatement_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_tas_restatement_bitfields >= 1 and tas_restatement_bitfield_1.tas_restatement_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_tas_restatement_bitfields >= 1 and tas_restatement_bitfield_1.tas_restatement_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_tas_restatement_bitfields >= 1 and tas_restatement_bitfield_1.tas_restatement_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 2 and tas_restatement_bitfield_2.tas_restatement_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_tas_restatement_bitfields >= 2 and tas_restatement_bitfield_2.tas_restatement_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 3 and tas_restatement_bitfield_3.tas_restatement_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 3 and tas_restatement_bitfield_3.tas_restatement_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 3 and tas_restatement_bitfield_3.tas_restatement_bitfield_3_clearing_account > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 3 and tas_restatement_bitfield_3.tas_restatement_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_tas_restatement_bitfields >= 4 and tas_restatement_bitfield_4.tas_restatement_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_tas_restatement_bitfields >= 4 and tas_restatement_bitfield_4.tas_restatement_bitfield_4_open_close > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 5 and tas_restatement_bitfield_5.tas_restatement_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: last_shares
        type: u4
        if: number_of_tas_restatement_bitfields >= 5 and tas_restatement_bitfield_5.tas_restatement_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_tas_restatement_bitfields >= 5 and tas_restatement_bitfield_5.tas_restatement_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 8 and tas_restatement_bitfield_8.tas_restatement_bitfield_8_fee_code > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_tas_restatement_bitfields >= 8 and tas_restatement_bitfield_8.tas_restatement_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_tas_restatement_bitfields >= 9 and tas_restatement_bitfield_9.tas_restatement_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_oeoid > 0
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_trade_date > 0
      - id: clearing_price
        type: decimal_s8_4
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_clearing_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 12 and tas_restatement_bitfield_12.tas_restatement_bitfield_12_clearing_symbol > 0
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_tas_restatement_bitfields >= 13 and tas_restatement_bitfield_13.tas_restatement_bitfield_13_multileg_reporting_type > 0
      - id: secondary_exec_id
        type: u8
        if: number_of_tas_restatement_bitfields >= 14 and tas_restatement_bitfield_14.tas_restatement_bitfield_14_secondary_exec_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_tas_restatement_bitfields >= 16 and tas_restatement_bitfield_16.tas_restatement_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_tas_restatement_bitfields >= 17 and tas_restatement_bitfield_17.tas_restatement_bitfield_17_cust_order_handling_inst > 0
  tas_restatement_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_1_side
        type: b1
      - id: tas_restatement_bitfield_1_peg_difference
        type: b1
      - id: tas_restatement_bitfield_1_price
        type: b1
      - id: tas_restatement_bitfield_1_exec_inst
        type: b1
      - id: tas_restatement_bitfield_1_order_type
        type: b1
      - id: tas_restatement_bitfield_1_time_in_force
        type: b1
      - id: tas_restatement_bitfield_1_min_qty
        type: b1
      - id: tas_restatement_bitfield_1_max_remove_pct
        type: b1
  tas_restatement_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_2_symbol
        type: b1
      - id: tas_restatement_bitfield_2_symbol_sfx
        type: b1
      - id: tas_restatement_bitfield_2_currency
        type: b1
      - id: tas_restatement_bitfield_2_id_source
        type: b1
      - id: tas_restatement_bitfield_2_security_id
        type: b1
      - id: tas_restatement_bitfield_2_security_exchange
        type: b1
      - id: tas_restatement_bitfield_2_capacity
        type: b1
      - id: tas_restatement_bitfield_2_reserved_128
        type: b1
  tas_restatement_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_3_account
        type: b1
      - id: tas_restatement_bitfield_3_clearing_firm
        type: b1
      - id: tas_restatement_bitfield_3_clearing_account
        type: b1
      - id: tas_restatement_bitfield_3_display_indicator
        type: b1
      - id: tas_restatement_bitfield_3_max_floor
        type: b1
      - id: tas_restatement_bitfield_3_discretion_amount
        type: b1
      - id: tas_restatement_bitfield_3_order_qty
        type: b1
      - id: tas_restatement_bitfield_3_prevent_match
        type: b1
  tas_restatement_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_4_maturity_date
        type: b1
      - id: tas_restatement_bitfield_4_strike_price
        type: b1
      - id: tas_restatement_bitfield_4_put_or_call
        type: b1
      - id: tas_restatement_bitfield_4_open_close
        type: b1
      - id: tas_restatement_bitfield_4_cl_ord_id_batch
        type: b1
      - id: tas_restatement_bitfield_4_corrected_size
        type: b1
      - id: tas_restatement_bitfield_4_party_id
        type: b1
      - id: tas_restatement_bitfield_4_access_fee
        type: b1
  tas_restatement_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_5_orig_cl_ord_id
        type: b1
      - id: tas_restatement_bitfield_5_leaves_qty
        type: b1
      - id: tas_restatement_bitfield_5_last_shares
        type: b1
      - id: tas_restatement_bitfield_5_last_px
        type: b1
      - id: tas_restatement_bitfield_5_display_price
        type: b1
      - id: tas_restatement_bitfield_5_working_price
        type: b1
      - id: tas_restatement_bitfield_5_base_liquidity_indicator
        type: b1
      - id: tas_restatement_bitfield_5_expire_time
        type: b1
  tas_restatement_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_6_secondary_order_id
        type: b1
      - id: tas_restatement_bitfield_6_ccp
        type: b1
      - id: tas_restatement_bitfield_6_contra_capacity
        type: b1
      - id: tas_restatement_bitfield_6_attributed_order
        type: b1
      - id: tas_restatement_bitfield_6_ext_exec_inst
        type: b1
      - id: tas_restatement_bitfield_6_bulk_order_ids
        type: b1
      - id: tas_restatement_bitfield_6_bulk_reject_reasons
        type: b1
      - id: tas_restatement_bitfield_6_party_role
        type: b1
  tas_restatement_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: tas_restatement_bitfield_7_trade_report_type_return
        type: b1
      - id: tas_restatement_bitfield_7_trade_publish_ind_return
        type: b1
      - id: tas_restatement_bitfield_7_text
        type: b1
      - id: tas_restatement_bitfield_7_bid
        type: b1
      - id: tas_restatement_bitfield_7_offer
        type: b1
      - id: tas_restatement_bitfield_7_large_size
        type: b1
      - id: tas_restatement_bitfield_7_last_mkt
        type: b1
  tas_restatement_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_8_fee_code
        type: b1
      - id: tas_restatement_bitfield_8_echo_text
        type: b1
      - id: tas_restatement_bitfield_8_stop_px
        type: b1
      - id: tas_restatement_bitfield_8_routing_inst
        type: b1
      - id: tas_restatement_bitfield_8_rout_strategy
        type: b1
      - id: tas_restatement_bitfield_8_route_delivery_method
        type: b1
      - id: tas_restatement_bitfield_8_ex_destination
        type: b1
      - id: tas_restatement_bitfield_8_trade_report_ref_id
        type: b1
  tas_restatement_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_9_marketing_fee_code
        type: b1
      - id: tas_restatement_bitfield_9_target_party_id
        type: b1
      - id: tas_restatement_bitfield_9_auction_id
        type: b1
      - id: tas_restatement_bitfield_9_order_category
        type: b1
      - id: tas_restatement_bitfield_9_liquidity_provision
        type: b1
      - id: tas_restatement_bitfield_9_cmta_number
        type: b1
      - id: tas_restatement_bitfield_9_cross_type
        type: b1
      - id: tas_restatement_bitfield_9_cross_prioritization
        type: b1
  tas_restatement_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_10_cross_id
        type: b1
      - id: tas_restatement_bitfield_10_alloc_qty
        type: b1
      - id: tas_restatement_bitfield_10_give_up_firm_id
        type: b1
      - id: tas_restatement_bitfield_10_routing_f_irm_id
        type: b1
      - id: tas_restatement_bitfield_10_waiver_type
        type: b1
      - id: tas_restatement_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: tas_restatement_bitfield_10_price_formation
        type: b1
      - id: tas_restatement_bitfield_10_client_qualified_role
        type: b1
  tas_restatement_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_11_client_id
        type: b1
      - id: tas_restatement_bitfield_11_investor_id
        type: b1
      - id: tas_restatement_bitfield_11_executor_id
        type: b1
      - id: tas_restatement_bitfield_11_order_origination
        type: b1
      - id: tas_restatement_bitfield_11_algo
        type: b1
      - id: tas_restatement_bitfield_11_deferral_reason
        type: b1
      - id: tas_restatement_bitfield_11_investor_qualified_role
        type: b1
      - id: tas_restatement_bitfield_11_executor_qualified_role
        type: b1
  tas_restatement_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_12_cti_code
        type: b1
      - id: tas_restatement_bitfield_12_manual_order_indicator
        type: b1
      - id: tas_restatement_bitfield_12_oeoid
        type: b1
      - id: tas_restatement_bitfield_12_trade_date
        type: b1
      - id: tas_restatement_bitfield_12_clearing_price
        type: b1
      - id: tas_restatement_bitfield_12_clearing_size
        type: b1
      - id: tas_restatement_bitfield_12_clearing_symbol
        type: b1
      - id: tas_restatement_bitfield_12_reserved_128
        type: b1
  tas_restatement_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_13_cum_qty
        type: b1
      - id: tas_restatement_bitfield_13_day_order_qty
        type: b1
      - id: tas_restatement_bitfield_13_day_cum_qty
        type: b1
      - id: tas_restatement_bitfield_13_avg_px
        type: b1
      - id: tas_restatement_bitfield_13_day_avg_px
        type: b1
      - id: tas_restatement_bitfield_13_pending_status
        type: b1
      - id: tas_restatement_bitfield_13_drill_thru_protection
        type: b1
      - id: tas_restatement_bitfield_13_multileg_reporting_type
        type: b1
  tas_restatement_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_14_leg_cfi_code
        type: b1
      - id: tas_restatement_bitfield_14_leg_maturity_date
        type: b1
      - id: tas_restatement_bitfield_14_leg_strike_price
        type: b1
      - id: tas_restatement_bitfield_14_room_id
        type: b1
      - id: tas_restatement_bitfield_14_secondary_exec_id
        type: b1
      - id: tas_restatement_bitfield_14_user_request_id
        type: b1
      - id: tas_restatement_bitfield_14_sis_username
        type: b1
      - id: tas_restatement_bitfield_14_user_status
        type: b1
  tas_restatement_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_15_trade_reporting_indicator
        type: b1
      - id: tas_restatement_bitfield_15_equity_party_id
        type: b1
      - id: tas_restatement_bitfield_15_equity_nbbo_protect
        type: b1
      - id: tas_restatement_bitfield_15_mass_cancel_id
        type: b1
      - id: tas_restatement_bitfield_15_trade_publish_ind
        type: b1
      - id: tas_restatement_bitfield_15_report_time
        type: b1
      - id: tas_restatement_bitfield_15_leg_symbol_sfx
        type: b1
      - id: tas_restatement_bitfield_15_client_id_attr
        type: b1
  tas_restatement_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_16_frequent_trader_id
        type: b1
      - id: tas_restatement_bitfield_16_session_eligibility
        type: b1
      - id: tas_restatement_bitfield_16_combo_order
        type: b1
      - id: tas_restatement_bitfield_16_compression
        type: b1
      - id: tas_restatement_bitfield_16_floor_destination
        type: b1
      - id: tas_restatement_bitfield_16_floor_routing_inst
        type: b1
      - id: tas_restatement_bitfield_16_multi_class_sprd
        type: b1
      - id: tas_restatement_bitfield_16_order_origin
        type: b1
  tas_restatement_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_17_price_type
        type: b1
      - id: tas_restatement_bitfield_17_strategy_id
        type: b1
      - id: tas_restatement_bitfield_17_trading_session_id
        type: b1
      - id: tas_restatement_bitfield_17_trade_through_alert_type
        type: b1
      - id: tas_restatement_bitfield_17_sender_location_id
        type: b1
      - id: tas_restatement_bitfield_17_floor_trader_acronym
        type: b1
      - id: tas_restatement_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: tas_restatement_bitfield_17_cust_order_handling_inst
        type: b1
  tas_restatement_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: tas_restatement_bitfield_18_reserved_1
        type: b1
      - id: tas_restatement_bitfield_18_cross_initiator
        type: b1
      - id: tas_restatement_bitfield_18_subreason
        type: b1
      - id: tas_restatement_bitfield_18_reserved_8
        type: b1
      - id: tas_restatement_bitfield_18_reserved_16
        type: b1
      - id: tas_restatement_bitfield_18_reserved_32
        type: b1
      - id: tas_restatement_bitfield_18_reserved_64
        type: b1
      - id: tas_restatement_bitfield_18_reserved_128
        type: b1
  variance_restatement_new_order_message_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in CFE FIX. Unique ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. A leading tilde (~) cannot be sent on any ClOrdId and will result in a reject. These are reserved for internal use by CFE and could be received as a result of a system-generated ClOrdId. If the ClOrdID matches a live order, the order will be rejected as duplicate. Sent to the OCC in the Order ID field. Note: CFE only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived GTC and GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CFE Internal use'
      - id: number_of_variance_restatement_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: variance_restatement_bitfield_1
        type: variance_restatement_bitfield_1
        if: number_of_variance_restatement_bitfields >= 1
        doc: 'BitSet VarianceRestatement byte 1'
      - id: variance_restatement_bitfield_2
        type: variance_restatement_bitfield_2
        if: number_of_variance_restatement_bitfields >= 2
        doc: 'BitSet VarianceRestatement byte 2'
      - id: variance_restatement_bitfield_3
        type: variance_restatement_bitfield_3
        if: number_of_variance_restatement_bitfields >= 3
        doc: 'BitSet VarianceRestatement byte 3'
      - id: variance_restatement_bitfield_4
        type: variance_restatement_bitfield_4
        if: number_of_variance_restatement_bitfields >= 4
        doc: 'BitSet VarianceRestatement byte 4'
      - id: variance_restatement_bitfield_5
        type: variance_restatement_bitfield_5
        if: number_of_variance_restatement_bitfields >= 5
        doc: 'BitSet VarianceRestatement byte 5'
      - id: variance_restatement_bitfield_6
        type: variance_restatement_bitfield_6
        if: number_of_variance_restatement_bitfields >= 6
        doc: 'BitSet VarianceRestatement byte 6'
      - id: variance_restatement_bitfield_7
        type: variance_restatement_bitfield_7
        if: number_of_variance_restatement_bitfields >= 7
        doc: 'BitSet VarianceRestatement byte 7'
      - id: variance_restatement_bitfield_8
        type: variance_restatement_bitfield_8
        if: number_of_variance_restatement_bitfields >= 8
        doc: 'BitSet VarianceRestatement byte 8'
      - id: variance_restatement_bitfield_9
        type: variance_restatement_bitfield_9
        if: number_of_variance_restatement_bitfields >= 9
        doc: 'BitSet VarianceRestatement byte 9'
      - id: variance_restatement_bitfield_10
        type: variance_restatement_bitfield_10
        if: number_of_variance_restatement_bitfields >= 10
        doc: 'BitSet VarianceRestatement byte 10'
      - id: variance_restatement_bitfield_11
        type: variance_restatement_bitfield_11
        if: number_of_variance_restatement_bitfields >= 11
        doc: 'BitSet VarianceRestatement byte 11'
      - id: variance_restatement_bitfield_12
        type: variance_restatement_bitfield_12
        if: number_of_variance_restatement_bitfields >= 12
        doc: 'BitSet VarianceRestatement byte 12'
      - id: variance_restatement_bitfield_13
        type: variance_restatement_bitfield_13
        if: number_of_variance_restatement_bitfields >= 13
        doc: 'BitSet VarianceRestatement byte 13'
      - id: variance_restatement_bitfield_14
        type: variance_restatement_bitfield_14
        if: number_of_variance_restatement_bitfields >= 14
        doc: 'BitSet VarianceRestatement byte 14'
      - id: variance_restatement_bitfield_15
        type: variance_restatement_bitfield_15
        if: number_of_variance_restatement_bitfields >= 15
        doc: 'BitSet VarianceRestatement byte 15'
      - id: variance_restatement_bitfield_16
        type: variance_restatement_bitfield_16
        if: number_of_variance_restatement_bitfields >= 16
        doc: 'BitSet VarianceRestatement byte 16'
      - id: variance_restatement_bitfield_17
        type: variance_restatement_bitfield_17
        if: number_of_variance_restatement_bitfields >= 17
        doc: 'BitSet VarianceRestatement byte 17'
      - id: variance_restatement_bitfield_18
        type: variance_restatement_bitfield_18
        if: number_of_variance_restatement_bitfields >= 18
        doc: 'BitSet VarianceRestatement byte 18'
      - id: side
        type: u1
        enum: side
        if: number_of_variance_restatement_bitfields >= 1 and variance_restatement_bitfield_1.variance_restatement_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in CFE FIX. 1 = Buy 2 = Sell'
      - id: price
        type: decimal_s8_4
        if: number_of_variance_restatement_bitfields >= 1 and variance_restatement_bitfield_1.variance_restatement_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_variance_restatement_bitfields >= 1 and variance_restatement_bitfield_1.variance_restatement_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_variance_restatement_bitfields >= 1 and variance_restatement_bitfield_1.variance_restatement_bitfield_1_min_qty > 0
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 2 and variance_restatement_bitfield_2.variance_restatement_bitfield_2_symbol > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_variance_restatement_bitfields >= 2 and variance_restatement_bitfield_2.variance_restatement_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 3 and variance_restatement_bitfield_3.variance_restatement_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 3 and variance_restatement_bitfield_3.variance_restatement_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 3 and variance_restatement_bitfield_3.variance_restatement_bitfield_3_clearing_account > 0
      - id: prevent_participant_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 3 and variance_restatement_bitfield_3.variance_restatement_bitfield_3_prevent_participant_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_variance_restatement_bitfields >= 4 and variance_restatement_bitfield_4.variance_restatement_bitfield_4_maturity_date > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_variance_restatement_bitfields >= 4 and variance_restatement_bitfield_4.variance_restatement_bitfield_4_open_close > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 5 and variance_restatement_bitfield_5.variance_restatement_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in CFE FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: last_shares
        type: u4
        if: number_of_variance_restatement_bitfields >= 5 and variance_restatement_bitfield_5.variance_restatement_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_variance_restatement_bitfields >= 5 and variance_restatement_bitfield_5.variance_restatement_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 8 and variance_restatement_bitfield_8.variance_restatement_bitfield_8_fee_code > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_variance_restatement_bitfields >= 8 and variance_restatement_bitfield_8.variance_restatement_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_variance_restatement_bitfields >= 9 and variance_restatement_bitfield_9.variance_restatement_bitfield_9_cmta_number > 0
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_cti_code > 0
      - id: manual_order_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_manual_order_indicator > 0
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_oeoid > 0
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_trade_date > 0
      - id: clearing_price
        type: decimal_s8_4
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_clearing_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_clearing_size > 0
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 12 and variance_restatement_bitfield_12.variance_restatement_bitfield_12_clearing_symbol > 0
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_variance_restatement_bitfields >= 13 and variance_restatement_bitfield_13.variance_restatement_bitfield_13_multileg_reporting_type > 0
      - id: secondary_exec_id
        type: u8
        if: number_of_variance_restatement_bitfields >= 14 and variance_restatement_bitfield_14.variance_restatement_bitfield_14_secondary_exec_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_variance_restatement_bitfields >= 16 and variance_restatement_bitfield_16.variance_restatement_bitfield_16_frequent_trader_id > 0
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
        if: number_of_variance_restatement_bitfields >= 17 and variance_restatement_bitfield_17.variance_restatement_bitfield_17_cust_order_handling_inst > 0
  variance_restatement_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_1_side
        type: b1
      - id: variance_restatement_bitfield_1_peg_difference
        type: b1
      - id: variance_restatement_bitfield_1_price
        type: b1
      - id: variance_restatement_bitfield_1_exec_inst
        type: b1
      - id: variance_restatement_bitfield_1_order_type
        type: b1
      - id: variance_restatement_bitfield_1_time_in_force
        type: b1
      - id: variance_restatement_bitfield_1_min_qty
        type: b1
      - id: variance_restatement_bitfield_1_max_remove_pct
        type: b1
  variance_restatement_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_2_symbol
        type: b1
      - id: variance_restatement_bitfield_2_symbol_sfx
        type: b1
      - id: variance_restatement_bitfield_2_currency
        type: b1
      - id: variance_restatement_bitfield_2_id_source
        type: b1
      - id: variance_restatement_bitfield_2_security_id
        type: b1
      - id: variance_restatement_bitfield_2_security_exchange
        type: b1
      - id: variance_restatement_bitfield_2_capacity
        type: b1
      - id: variance_restatement_bitfield_2_reserved_128
        type: b1
  variance_restatement_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_3_account
        type: b1
      - id: variance_restatement_bitfield_3_clearing_firm
        type: b1
      - id: variance_restatement_bitfield_3_clearing_account
        type: b1
      - id: variance_restatement_bitfield_3_display_indicator
        type: b1
      - id: variance_restatement_bitfield_3_max_floor
        type: b1
      - id: variance_restatement_bitfield_3_discretion_amount
        type: b1
      - id: variance_restatement_bitfield_3_order_qty
        type: b1
      - id: variance_restatement_bitfield_3_prevent_participant_match
        type: b1
  variance_restatement_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_4_maturity_date
        type: b1
      - id: variance_restatement_bitfield_4_strike_price
        type: b1
      - id: variance_restatement_bitfield_4_put_or_call
        type: b1
      - id: variance_restatement_bitfield_4_open_close
        type: b1
      - id: variance_restatement_bitfield_4_cl_ord_id_batch
        type: b1
      - id: variance_restatement_bitfield_4_corrected_size
        type: b1
      - id: variance_restatement_bitfield_4_party_id
        type: b1
      - id: variance_restatement_bitfield_4_access_fee
        type: b1
  variance_restatement_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_5_orig_cl_ord_id
        type: b1
      - id: variance_restatement_bitfield_5_leaves_qty
        type: b1
      - id: variance_restatement_bitfield_5_last_shares
        type: b1
      - id: variance_restatement_bitfield_5_last_px
        type: b1
      - id: variance_restatement_bitfield_5_display_price
        type: b1
      - id: variance_restatement_bitfield_5_working_price
        type: b1
      - id: variance_restatement_bitfield_5_base_liquidity_indicator
        type: b1
      - id: variance_restatement_bitfield_5_expire_time
        type: b1
  variance_restatement_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_6_secondary_order_id
        type: b1
      - id: variance_restatement_bitfield_6_ccp
        type: b1
      - id: variance_restatement_bitfield_6_contra_capacity
        type: b1
      - id: variance_restatement_bitfield_6_attributed_order
        type: b1
      - id: variance_restatement_bitfield_6_ext_exec_inst
        type: b1
      - id: variance_restatement_bitfield_6_bulk_order_ids
        type: b1
      - id: variance_restatement_bitfield_6_bulk_reject_reasons
        type: b1
      - id: variance_restatement_bitfield_6_party_role
        type: b1
  variance_restatement_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: variance_restatement_bitfield_7_trade_report_type_return
        type: b1
      - id: variance_restatement_bitfield_7_trade_publish_ind_return
        type: b1
      - id: variance_restatement_bitfield_7_text
        type: b1
      - id: variance_restatement_bitfield_7_bid
        type: b1
      - id: variance_restatement_bitfield_7_offer
        type: b1
      - id: variance_restatement_bitfield_7_large_size
        type: b1
      - id: variance_restatement_bitfield_7_last_mkt
        type: b1
  variance_restatement_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_8_fee_code
        type: b1
      - id: variance_restatement_bitfield_8_echo_text
        type: b1
      - id: variance_restatement_bitfield_8_stop_px
        type: b1
      - id: variance_restatement_bitfield_8_routing_inst
        type: b1
      - id: variance_restatement_bitfield_8_rout_strategy
        type: b1
      - id: variance_restatement_bitfield_8_route_delivery_method
        type: b1
      - id: variance_restatement_bitfield_8_ex_destination
        type: b1
      - id: variance_restatement_bitfield_8_trade_report_ref_id
        type: b1
  variance_restatement_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_9_marketing_fee_code
        type: b1
      - id: variance_restatement_bitfield_9_target_party_id
        type: b1
      - id: variance_restatement_bitfield_9_auction_id
        type: b1
      - id: variance_restatement_bitfield_9_order_category
        type: b1
      - id: variance_restatement_bitfield_9_liquidity_provision
        type: b1
      - id: variance_restatement_bitfield_9_cmta_number
        type: b1
      - id: variance_restatement_bitfield_9_cross_type
        type: b1
      - id: variance_restatement_bitfield_9_cross_prioritization
        type: b1
  variance_restatement_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_10_cross_id
        type: b1
      - id: variance_restatement_bitfield_10_alloc_qty
        type: b1
      - id: variance_restatement_bitfield_10_give_up_firm_id
        type: b1
      - id: variance_restatement_bitfield_10_routing_f_irm_id
        type: b1
      - id: variance_restatement_bitfield_10_waiver_type
        type: b1
      - id: variance_restatement_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: variance_restatement_bitfield_10_price_formation
        type: b1
      - id: variance_restatement_bitfield_10_client_qualified_role
        type: b1
  variance_restatement_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_11_client_id
        type: b1
      - id: variance_restatement_bitfield_11_investor_id
        type: b1
      - id: variance_restatement_bitfield_11_executor_id
        type: b1
      - id: variance_restatement_bitfield_11_order_origination
        type: b1
      - id: variance_restatement_bitfield_11_algo
        type: b1
      - id: variance_restatement_bitfield_11_deferral_reason
        type: b1
      - id: variance_restatement_bitfield_11_investor_qualified_role
        type: b1
      - id: variance_restatement_bitfield_11_executor_qualified_role
        type: b1
  variance_restatement_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_12_cti_code
        type: b1
      - id: variance_restatement_bitfield_12_manual_order_indicator
        type: b1
      - id: variance_restatement_bitfield_12_oeoid
        type: b1
      - id: variance_restatement_bitfield_12_trade_date
        type: b1
      - id: variance_restatement_bitfield_12_clearing_price
        type: b1
      - id: variance_restatement_bitfield_12_clearing_size
        type: b1
      - id: variance_restatement_bitfield_12_clearing_symbol
        type: b1
      - id: variance_restatement_bitfield_12_reserved_128
        type: b1
  variance_restatement_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_13_cum_qty
        type: b1
      - id: variance_restatement_bitfield_13_day_order_qty
        type: b1
      - id: variance_restatement_bitfield_13_day_cum_qty
        type: b1
      - id: variance_restatement_bitfield_13_avg_px
        type: b1
      - id: variance_restatement_bitfield_13_day_avg_px
        type: b1
      - id: variance_restatement_bitfield_13_pending_status
        type: b1
      - id: variance_restatement_bitfield_13_drill_thru_protection
        type: b1
      - id: variance_restatement_bitfield_13_multileg_reporting_type
        type: b1
  variance_restatement_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_14_leg_cfi_code
        type: b1
      - id: variance_restatement_bitfield_14_leg_maturity_date
        type: b1
      - id: variance_restatement_bitfield_14_leg_strike_price
        type: b1
      - id: variance_restatement_bitfield_14_room_id
        type: b1
      - id: variance_restatement_bitfield_14_secondary_exec_id
        type: b1
      - id: variance_restatement_bitfield_14_user_request_id
        type: b1
      - id: variance_restatement_bitfield_14_sis_username
        type: b1
      - id: variance_restatement_bitfield_14_user_status
        type: b1
  variance_restatement_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_15_trade_reporting_indicator
        type: b1
      - id: variance_restatement_bitfield_15_equity_party_id
        type: b1
      - id: variance_restatement_bitfield_15_equity_nbbo_protect
        type: b1
      - id: variance_restatement_bitfield_15_mass_cancel_id
        type: b1
      - id: variance_restatement_bitfield_15_trade_publish_ind
        type: b1
      - id: variance_restatement_bitfield_15_report_time
        type: b1
      - id: variance_restatement_bitfield_15_leg_symbol_sfx
        type: b1
      - id: variance_restatement_bitfield_15_client_id_attr
        type: b1
  variance_restatement_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_16_frequent_trader_id
        type: b1
      - id: variance_restatement_bitfield_16_session_eligibility
        type: b1
      - id: variance_restatement_bitfield_16_combo_order
        type: b1
      - id: variance_restatement_bitfield_16_compression
        type: b1
      - id: variance_restatement_bitfield_16_floor_destination
        type: b1
      - id: variance_restatement_bitfield_16_floor_routing_inst
        type: b1
      - id: variance_restatement_bitfield_16_multi_class_sprd
        type: b1
      - id: variance_restatement_bitfield_16_order_origin
        type: b1
  variance_restatement_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_17_price_type
        type: b1
      - id: variance_restatement_bitfield_17_strategy_id
        type: b1
      - id: variance_restatement_bitfield_17_trading_session_id
        type: b1
      - id: variance_restatement_bitfield_17_trade_through_alert_type
        type: b1
      - id: variance_restatement_bitfield_17_sender_location_id
        type: b1
      - id: variance_restatement_bitfield_17_floor_trader_acronym
        type: b1
      - id: variance_restatement_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: variance_restatement_bitfield_17_cust_order_handling_inst
        type: b1
  variance_restatement_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: variance_restatement_bitfield_18_reserved_1
        type: b1
      - id: variance_restatement_bitfield_18_cross_initiator
        type: b1
      - id: variance_restatement_bitfield_18_subreason
        type: b1
      - id: variance_restatement_bitfield_18_reserved_8
        type: b1
      - id: variance_restatement_bitfield_18_reserved_16
        type: b1
      - id: variance_restatement_bitfield_18_reserved_32
        type: b1
      - id: variance_restatement_bitfield_18_reserved_64
        type: b1
      - id: variance_restatement_bitfield_18_reserved_128
        type: b1
  tas_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFE native identifier'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  variance_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe. All quote response messages will include this identifier. Note: CFE only enforces uniqueness of QuoteUpdateID values among those not yet acknowledged by the ME. However, we strongly recommend that you keep your QuoteUpdateID values unique for a trading day'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in CFE FIX. Sent to the OCC in the Trade ID field. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as base 36 ASCII. Example conversion: Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'CFE native identifier'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
      - id: reserved_16
        size: 16
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100

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
    0x70:
      id: 'quote_update_message'
      doc: 'Quote Update Message.'
    0x47:
      id: 'purge_orders_message'
      doc: 'Purge Orders Message.'
    0x56:
      id: 'reset_risk_message'
      doc: 'Reset Risk Message.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'Order Acknowledgment Message.'
    0x71:
      id: 'quote_update_acknowledgment_message'
      doc: 'Quote Update Acknowledgment Message.'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected Message.'
    0x78:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected Message.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified Message.'
    0x72:
      id: 'quote_restated_message'
      doc: 'Quote Restated Message.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected Message.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'Order Cancelled Message.'
    0x73:
      id: 'quote_cancelled_message'
      doc: 'Quote Cancelled Message.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'Cancel Rejected Message.'
    0x2c:
      id: 'order_execution_message'
      doc: 'Order Execution Message.'
    0x74:
      id: 'quote_execution_message'
      doc: 'Quote Execution Message.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Trade Cancel or Correct Message.'
    0x48:
      id: 'purge_rejected_message'
      doc: 'Purge Rejected Message.'
    0x57:
      id: 'reset_risk_acknowledgment_message'
      doc: 'Reset Risk Acknowledgment Message.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'Mass Cancel Acknowledgment Message.'
    0x49:
      id: 'tas_restatement_new_order_message_message'
      doc: 'TAS Restatement (New Order Message) Message.'
    0x4a:
      id: 'variance_restatement_new_order_message_message'
      doc: 'Variance Restatement (New Order Message) Message.'
    0x75:
      id: 'tas_quote_restatement_message'
      doc: 'TAS Quote Restatement Message.'
    0x76:
      id: 'variance_quote_restatement_message'
      doc: 'Variance Quote Restatement Message.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized'
      doc: 'Not Authorized Invalid Usernamepwd'
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
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit Default'
    0x34:
      id: 'stop_limit'
      doc: 'Stop Limit Market Implies Time In Force Of Ioc 3 Stop Limit Orders Must Have A Time In Force Of Day 0 Gtc 1 Or Gtd 6'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day Expires At The End Of The Business Day'
    0x31:
      id: 'gtc'
      doc: 'Gtc Good Till Cancel Order Remains Until Cancelled Or Contract Expires'
    0x33:
      id: 'ioc'
      doc: 'Ioc Portion Not Filled Immediately Is Cancelled Market Orders Are Implicitly Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok An Ioc Where The Entire Size Must Be Filled Else The Order Will Be Cancelled Back'
    0x36:
      id: 'gtd'
      doc: 'Gtd Good Till Date Time Expires At The Datetime Specified In The Expire Time Field'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm The Capacity Refers To The Occ Account Type A Value Of C Denotes An Account That Clears In The Customer Range At Occ A Value Of F Denotes An Account That Clears In The Clearing Firm Range At Occ'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None Same As Not Present'
  cti_code:
    0x31:
      id: 'cti_1'
      doc: 'Cti 1 Transactions Initiated And Executed By An Individual Tph For The Tp Hs Own Account For An Account The Tph Controls Or For The Account In Which The Tph Has An Ownership Or Financial Interest'
    0x32:
      id: 'cti_2'
      doc: 'Cti 2 Transactions Executed For The Proprietary Account Of A Clearing Tph Or Nonclearing Tph'
    0x33:
      id: 'cti_3'
      doc: 'Cti 3 Transactions Where An Individual Tph Or Authorized Trader Executes For The Personal Account Of Another Individual Tph For An Account The Other Individual Tph Controls Or For An Account In Which The Other Individual Tph Has An Ownership Or Financial Interest'
    0x34:
      id: 'cti_4'
      doc: 'Cti 4 Any Transaction Not Meeting The Definition Of Cti 12 Or 3 These Should Be Non Tph Customer Transactions'
  cust_order_handling_inst:
    0x57:
      id: 'desk'
      doc: 'Desk High Touch'
    0x59:
      id: 'electronic'
      doc: 'Electronic Default'
    0x43:
      id: 'vendorprovided_platform_billed_by_executing_broker'
      doc: 'Vendorprovided Platform Billed By Executing Broker'
    0x47:
      id: 'sponsored_access_via_exchange_api_or_fix_provided_by'
      doc: 'Sponsored Access Via Exchange Api Or Fix Provided By Executing Broker'
    0x48:
      id: 'premium_algorithmic_trading_provider_billed_by_executing'
      doc: 'Premium Algorithmic Trading Provider Billed By Executing Broker'
    0x44:
      id: 'other_including_otherprovided_screen'
      doc: 'Other Including Otherprovided Screen'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'market_opening_reopening_trade'
      doc: 'Market Opening Reopening Trade'
  sub_liquidity_indicator:
    0x43:
      id: 'carried_order_indicator'
      doc: 'Carried Order Indicator'
    0x55:
      id: 'qualifying_market_turner_order'
      doc: 'Qualifying Market Turner Order'
  quote_reject_reason:
    0x43:
      id: 'invalid_efid'
      doc: 'Invalid Efid Clearing Firm'
    0x44:
      id: 'invalid_wash_id'
      doc: 'Invalid Wash Id'
    0x46:
      id: 'not_enabled_for_quotes'
      doc: 'Not Enabled For Quotes'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4b:
      id: 'message_rate_threshold'
      doc: 'Message Rate Threshold'
    0x4c:
      id: 'invalid_quote_cnt'
      doc: 'Invalid Quote Cnt'
    0x4d:
      id: 'symbols_not_on_same_matching_engine'
      doc: 'Symbols Not On Same Matching Engine'
    0x4f:
      id: 'invalid_manual_order_indicator'
      doc: 'Invalid Manual Order Indicator'
    0x51:
      id: 'invalid_quote_update_id'
      doc: 'Invalid Quote Update Id'
    0x52:
      id: 'futures_root_does_not_match_across_quotes'
      doc: 'Futures Root Does Not Match Across Quotes'
    0x53:
      id: 'symbol_not_found'
      doc: 'Symbol Not Found'
    0x57:
      id: 'invalid_wash_prevent_type'
      doc: 'Invalid Wash Prevent Type'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x63:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    0x65:
      id: 'invalid_oeoid'
      doc: 'Invalid Oeoid Order Entry Operator Id'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
    0x69:
      id: 'invalid_cti_code'
      doc: 'Invalid Cti Code'
    0x6d:
      id: 'invalid_wash_method'
      doc: 'Invalid Wash Method'
    0x6e:
      id: 'exceedes_max_notional_value_per_order'
      doc: 'Exceedes Max Notional Value Per Order'
    0x6f:
      id: 'invalid_open_close'
      doc: 'Invalid Open Close'
    0x70:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x75:
      id: 'symbol_range_unreachable'
      doc: 'Symbol Range Unreachable'
    0x78:
      id: 'exceedes_max_size_per_order'
      doc: 'Exceedes Max Size Per Order'
    0x79:
      id: 'quote_received_by_cfe_during_replay'
      doc: 'Quote Received By Cfe During Replay'
    0x7a:
      id: 'invalid_size_modifier'
      doc: 'Invalid Size Modifier'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x4c:
      id: 'modified'
      doc: 'Modified Loss Of Priority'
    0x52:
      id: 'modified_x52'
      doc: 'Modified Retains Priority Size Reduction'
    0x4e:
      id: 'no_change_matches_existing_quote'
      doc: 'No Change Matches Existing Quote'
    0x44:
      id: 'new_quote_but_may_remove_liquidity'
      doc: 'New Quote But May Remove Liquidity'
    0x64:
      id: 'modified_but_may_remove_liquidity'
      doc: 'Modified But May Remove Liquidity Cancellation'
    0x55:
      id: 'user_cancelled'
      doc: 'User Cancelled Zero Sizeprice Requested Rejection'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x50:
      id: 'rejected_cant_post'
      doc: 'Rejected Cant Post'
    0x66:
      id: 'risk_management_efid_or_custom_group_id'
      doc: 'Risk Management Efid Or Custom Group Id Level'
    0x53:
      id: 'rejected_symbol_not_found'
      doc: 'Rejected Symbol Not Found'
    0x70:
      id: 'rejected_invalid_price'
      doc: 'Rejected Invalid Price'
    0x73:
      id: 'risk_management_product_root_level'
      doc: 'Risk Management Product Root Level'
    0x6e:
      id: 'risk_management_configuration_is_not'
      doc: 'Risk Management Configuration Is Not Sufficient'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected Other Reason Additional Reasons Indicating A Reject May Be Added In The Future With No Notice'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
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
      id: 'cant_modify_an_order_that_is_pending'
      doc: 'Cant Modify An Order That Is Pending'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_efid_level_or_custom_group_id_level'
      doc: 'Risk Management Efid Level Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  restatement_reason:
    0x51:
      id: 'liquidity'
      doc: 'Liquidity'
    0x57:
      id: 'wash'
      doc: 'Wash Cfe Reserves The Right To Add New Values As Necessary Without Prior Notice'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
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
      id: 'cant_modify_an_order_that_is_pending'
      doc: 'Cant Modify An Order That Is Pending'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_efid_level_or_custom_group_id_level'
      doc: 'Risk Management Efid Level Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
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
      id: 'cant_modify_an_order_that_is_pending'
      doc: 'Cant Modify An Order That Is Pending'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_efid_level_or_custom_group_id_level'
      doc: 'Risk Management Efid Level Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
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
      id: 'cant_modify_an_order_that_is_pending'
      doc: 'Cant Modify An Order That Is Pending'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_efid_level_or_custom_group_id_level'
      doc: 'Risk Management Efid Level Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  pending_status:
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x50:
      id: 'pending'
      doc: 'Pending See Section Error Reference Source Not Found Error Reference Source Not Found For A Description Products For Which Pending Status Is Applicable'
  multileg_reporting_type:
    0x31:
      id: 'simple_instrument_execution'
      doc: 'Simple Instrument Execution'
    0x32:
      id: 'simple_instrument_execution_that_is_part_of_a_spread'
      doc: 'Simple Instrument Execution That Is Part Of A Spread Execution'
    0x33:
      id: 'spread_instrument_execution'
      doc: 'Spread Instrument Execution'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x42:
      id: 'unknown_maturity_date'
      doc: 'Unknown Maturity Date'
    0x43:
      id: 'unknown_product_name'
      doc: 'Unknown Product Name'
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
      id: 'cant_modify_an_order_that_is_pending'
      doc: 'Cant Modify An Order That Is Pending'
    0x55:
      id: 'user_requested'
      doc: 'User Requested'
    0x56:
      id: 'would_wash'
      doc: 'Would Wash'
    0x58:
      id: 'order_expired'
      doc: 'Order Expired'
    0x59:
      id: 'symbol_not_supported'
      doc: 'Symbol Not Supported'
    0x5a:
      id: 'unforeseen_reason'
      doc: 'Unforeseen Reason'
    0x68:
      id: 'order_persisted'
      doc: 'Order Persisted'
    0x66:
      id: 'risk_management_efid_level_or_custom_group_id_level'
      doc: 'Risk Management Efid Level Or Custom Group Id Level'
    0x6d:
      id: 'market_access_risk_limit_exceeded'
      doc: 'Market Access Risk Limit Exceeded'
    0x6e:
      id: 'risk_management_configuration_is_insufficient'
      doc: 'Risk Management Configuration Is Insufficient'
    0x6f:
      id: 'max_open_orders_count_exceeded'
      doc: 'Max Open Orders Count Exceeded'
    0x73:
      id: 'risk_management_product_level'
      doc: 'Risk Management Product Level'
    0x79:
      id: 'order_received_by_cfe_during_replay'
      doc: 'Order Received By Cfe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored Exceeds 1 Reset Per Second'
    0x59:
      id: 'success'
      doc: 'Success'
    0x46:
      id: 'rejected'
      doc: 'Rejected Exceeds Firm Reset Limit'
    0x43:
      id: 'rejected_x43'
      doc: 'Rejected Exceeds Custom Group Id Limit'
    0x45:
      id: 'rejected_x45'
      doc: 'Rejected Empty Reset Risk Field'
    0x49:
      id: 'rejected_x49'
      doc: 'Rejected Incorrect Data Center'
    0x53:
      id: 'rejected_x53'
      doc: 'Rejected Exceeds Product Level Reset Limit'
    0x55:
      id: 'rejected_x55'
      doc: 'Rejected Invalid Risk Root'
    0x63:
      id: 'rejected_x63'
      doc: 'Rejected Invalid Efid Clearing Firm'

