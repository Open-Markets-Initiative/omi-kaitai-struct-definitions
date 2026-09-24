# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe BzxEquities BinaryOrderEntry Boe v2.4.55
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.4.55
#   Date: 4/24/2026
#   Specification: Cboe US Equities BOE Specification.pdf
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
  id: cboe_bzxequities_binaryorderentry_boe_v2_4_55
  title: Cboe BzxEquities BinaryOrderEntry Boe v2.4.55
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Bzx Equities Binary Order Entry Boe v2.4.55'
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
        'message_type::purge_orders_message': purge_orders_message
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
      - id: number_of_param_groups
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
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
        doc: 'Human-readable text with additional information about the reason for rejection'
      - id: no_unspecified_unit_replay
        type: u1
        doc: 'Echoed back from the original Login Request message'
      - id: last_received_sequence_number
        type: u4
        doc: 'Last inbound (Member to Cboe) message sequence number processed by Cboe'
      - id: number_of_units
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: number_of_param_groups
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
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
  new_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
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
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_exec_inst > 0
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
      - id: max_floor
        type: u4
        if: number_of_new_order_bitfields >= 1 and new_order_bitfield_1.new_order_bitfield_1_max_floor > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_capacity > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_routing_inst > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_display_indicator > 0
      - id: discretion_amount
        type: u2
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_discretion_amount > 0
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_prevent_match > 0
      - id: locate_reqd
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_locate_reqd > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_risk_reset > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_ext_exec_inst > 0
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
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_ex_destination > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_echo_text > 0
      - id: risk_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_risk_group_id > 0
      - id: cross_trade_flag
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 10 and new_order_bitfield_10.new_order_bitfield_10_locate_broker > 0
      - id: cmc_sessions
        type: str
        size: 2
        encoding: ASCII
        if: number_of_new_order_bitfields >= 10 and new_order_bitfield_10.new_order_bitfield_10_cmc_sessions > 0
      - id: step_up_amount
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 10 and new_order_bitfield_10.new_order_bitfield_10_step_up_amount > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: new_order_bitfield_5_session_eligibility
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
      - id: new_order_bitfield_9_reserved_16
        type: b1
      - id: new_order_bitfield_9_reserved_32
        type: b1
      - id: new_order_bitfield_9_cross_trade_flag
        type: b1
      - id: new_order_bitfield_9_reserved_128
        type: b1
  new_order_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_10_held
        type: b1
      - id: new_order_bitfield_10_locate_broker
        type: b1
      - id: new_order_bitfield_10_cmc_sessions
        type: b1
      - id: new_order_bitfield_10_step_up_amount
        type: b1
      - id: new_order_bitfield_10_reserved_16
        type: b1
      - id: new_order_bitfield_10_reserved_32
        type: b1
      - id: new_order_bitfield_10_reserved_64
        type: b1
      - id: new_order_bitfield_10_reserved_128
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
        doc: 'Bitfield identifying bitfields which are set. May be 0. Field values must be appended to the end of the message'
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
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: number_of_modify_order_bitfields
        type: u1
        doc: 'Bitfield identifying bitfields which are set. May be 0. Field values must be appended to the end of the message'
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
        doc: 'Order quantity. System limit is 999,999 shares'
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
        type: str
        size: 1
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_exec_inst > 0
      - id: side
        type: u1
        enum: side
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
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
      - id: modify_order_bitfield_2_operator_id
        type: b1
      - id: modify_order_bitfield_2_frequent_trader_id
        type: b1
      - id: modify_order_bitfield_2_reserved_64
        type: b1
      - id: modify_order_bitfield_2_locate_broker
        type: b1
  purge_orders_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_purge_orders_bitfields
        type: u1
        doc: 'Bitfield identifying bitfields which are set. May be 0. Field values must be appended to the end of the message'
      - id: purge_orders_bitfield_1
        type: purge_orders_bitfield_1
        if: number_of_purge_orders_bitfields >= 1
        doc: 'BitSet PurgeOrders byte 1'
      - id: purge_orders_bitfield_2
        type: purge_orders_bitfield_2
        if: number_of_purge_orders_bitfields >= 2
        doc: 'BitSet PurgeOrders byte 2'
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
        doc: 'Copied from the MassCancelID passed on the original Purge Orders message. Corresponds to MassCancelID (7695) in Cboe FIX'
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
  order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
        doc: 'Corresponds to LeavesQty (151) in Cboe FIX. Quantity still open for further execution'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator > 0
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator > 0
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values'
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: cross_trade_flag
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_locate_broker > 0
      - id: cmc_sessions
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 19 and return_bitfield_19.return_bitfield_19_cmc_sessions > 0
      - id: step_up_amount
        type: decimal_s8_4
        if: number_of_return_bitfields >= 19 and return_bitfield_19.return_bitfield_19_step_up_amount > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: return_bitfield_2_currency
        type: b1
      - id: return_bitfield_2_id_source
        type: b1
      - id: return_bitfield_2_security_id
        type: b1
      - id: return_bitfield_2_security_exchange
        type: b1
      - id: return_bitfield_2_capacity
        type: b1
      - id: return_bitfield_2_contra_trader
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
      - id: return_bitfield_4_maturity_date
        type: b1
      - id: return_bitfield_4_strike_price
        type: b1
      - id: return_bitfield_4_put_or_call
        type: b1
      - id: return_bitfield_4_open_close
        type: b1
      - id: return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: return_bitfield_4_corrected_size
        type: b1
      - id: return_bitfield_4_party_id
        type: b1
      - id: return_bitfield_4_access_fee
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
      - id: return_bitfield_6_ccp
        type: b1
      - id: return_bitfield_6_contra_capacity
        type: b1
      - id: return_bitfield_6_attributed_quote
        type: b1
      - id: return_bitfield_6_ext_exec_inst
        type: b1
      - id: return_bitfield_6_bulk_order_ids
        type: b1
      - id: return_bitfield_6_bulk_reject_reasons
        type: b1
      - id: return_bitfield_6_party_role
        type: b1
  return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_7_sub_liquidity_indicator
        type: b1
      - id: return_bitfield_7_trade_report_type_return
        type: b1
      - id: return_bitfield_7_trade_publish_ind_return
        type: b1
      - id: return_bitfield_7_text
        type: b1
      - id: return_bitfield_7_bid
        type: b1
      - id: return_bitfield_7_offer
        type: b1
      - id: return_bitfield_7_large_size
        type: b1
      - id: return_bitfield_7_last_mkt
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
      - id: return_bitfield_8_trade_report_ref_id
        type: b1
  return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_9_marketing_fee_code
        type: b1
      - id: return_bitfield_9_target_party_id
        type: b1
      - id: return_bitfield_9_auction_id
        type: b1
      - id: return_bitfield_9_order_category
        type: b1
      - id: return_bitfield_9_liquidity_provision
        type: b1
      - id: return_bitfield_9_cmta_number
        type: b1
      - id: return_bitfield_9_cross_type
        type: b1
      - id: return_bitfield_9_cross_prioritization
        type: b1
  return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_10_cross_id
        type: b1
      - id: return_bitfield_10_alloc_qty
        type: b1
      - id: return_bitfield_10_give_up_firm_id
        type: b1
      - id: return_bitfield_10_routing_firm_id
        type: b1
      - id: return_bitfield_10_waiver_type
        type: b1
      - id: return_bitfield_10_cross_exclusion_indicator
        type: b1
      - id: return_bitfield_10_price_formation
        type: b1
      - id: return_bitfield_10_client_qualified_role
        type: b1
  return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_11_client_id
        type: b1
      - id: return_bitfield_11_investor_id
        type: b1
      - id: return_bitfield_11_executor_id
        type: b1
      - id: return_bitfield_11_order_origination
        type: b1
      - id: return_bitfield_11_algo
        type: b1
      - id: return_bitfield_11_deferral_reason
        type: b1
      - id: return_bitfield_11_investor_qualified_role
        type: b1
      - id: return_bitfield_11_executor_qualified_role
        type: b1
  return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_12_cti_code
        type: b1
      - id: return_bitfield_12_manual_order_indicator
        type: b1
      - id: return_bitfield_12_operator_id
        type: b1
      - id: return_bitfield_12_trade_date
        type: b1
      - id: return_bitfield_12_clearing_price
        type: b1
      - id: return_bitfield_12_clearing_size
        type: b1
      - id: return_bitfield_12_clearing_symbol
        type: b1
      - id: return_bitfield_12_clearing_optional_data
        type: b1
  return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_13_cum_qty
        type: b1
      - id: return_bitfield_13_day_order_qty
        type: b1
      - id: return_bitfield_13_day_cum_qty
        type: b1
      - id: return_bitfield_13_avg_px
        type: b1
      - id: return_bitfield_13_day_avg_px
        type: b1
      - id: return_bitfield_13_pending_status
        type: b1
      - id: return_bitfield_13_drill_thru_protection
        type: b1
      - id: return_bitfield_13_multileg_reporting_type
        type: b1
  return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_14_leg_cfi_code
        type: b1
      - id: return_bitfield_14_leg_maturity_date
        type: b1
      - id: return_bitfield_14_leg_strike_price
        type: b1
      - id: return_bitfield_14_room_id
        type: b1
      - id: return_bitfield_14_secondary_exec_id
        type: b1
      - id: return_bitfield_14_user_request_id
        type: b1
      - id: return_bitfield_14_sis_username
        type: b1
      - id: return_bitfield_14_user_status
        type: b1
  return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_15_trade_reporting_indicator
        type: b1
      - id: return_bitfield_15_equity_party_id
        type: b1
      - id: return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: return_bitfield_15_mass_cancel_id
        type: b1
      - id: return_bitfield_15_trade_publish_ind
        type: b1
      - id: return_bitfield_15_report_time
        type: b1
      - id: return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: return_bitfield_15_client_id_attr
        type: b1
  return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_16_frequent_trader_id
        type: b1
      - id: return_bitfield_16_session_eligibility
        type: b1
      - id: return_bitfield_16_combo_order
        type: b1
      - id: return_bitfield_16_compression
        type: b1
      - id: return_bitfield_16_floor_destination
        type: b1
      - id: return_bitfield_16_floor_routing_inst
        type: b1
      - id: return_bitfield_16_multi_class_sprd
        type: b1
      - id: return_bitfield_16_order_origin
        type: b1
  return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_17_price_type
        type: b1
      - id: return_bitfield_17_strategy_id
        type: b1
      - id: return_bitfield_17_trading_session_id
        type: b1
      - id: return_bitfield_17_trade_through_alert_type
        type: b1
      - id: return_bitfield_17_sender_location_id
        type: b1
      - id: return_bitfield_17_floor_trader_acronym
        type: b1
      - id: return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: return_bitfield_17_cust_order_handling_inst
        type: b1
  return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_18_reserved_1
        type: b1
      - id: return_bitfield_18_cross_initiator
        type: b1
      - id: return_bitfield_18_subreason
        type: b1
      - id: return_bitfield_18_cross_trade_flag
        type: b1
      - id: return_bitfield_18_reserved_16
        type: b1
      - id: return_bitfield_18_held
        type: b1
      - id: return_bitfield_18_locate_broker
        type: b1
      - id: return_bitfield_18_reserved_128
        type: b1
  return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_19_floor_trade_time
        type: b1
      - id: return_bitfield_19_equity_ex_destination
        type: b1
      - id: return_bitfield_19_cross_on_behalf_of_id
        type: b1
      - id: return_bitfield_19_cmc_sessions
        type: b1
      - id: return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: return_bitfield_19_cmc_match_qty
        type: b1
      - id: return_bitfield_19_step_up_amount
        type: b1
      - id: return_bitfield_19_reserved_128
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
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
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
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
        doc: 'Corresponds to LeavesQty (151) in Cboe FIX. Quantity still open for further execution'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator > 0
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: cross_trade_flag
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_locate_broker > 0
  order_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
        doc: 'Corresponds to LeavesQty (151) in Cboe FIX. Quantity still open for further execution'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator > 0
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: cmc_match_qty
        type: u4
        if: number_of_return_bitfields >= 19 and return_bitfield_19.return_bitfield_19_cmc_match_qty > 0
      - id: step_up_amount
        type: decimal_s8_4
        if: number_of_return_bitfields >= 19 and return_bitfield_19.return_bitfield_19_step_up_amount > 0
        doc: 'Implied decimal with scale 1e-4'
  user_modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: modify_reject_reason
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: cancel_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reason for the order cancellation. See Reason Codes for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
        doc: 'Corresponds to LeavesQty (151) in Cboe FIX. Quantity still open for further execution'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_display_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_working_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator > 0
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: cross_trade_flag
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_cross_trade_flag > 0
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: cancel_reject_reason
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day'
      - id: last_shares
        type: u4
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
        type: decimal_s8_4
        doc: 'Corresponds to LastPx (31) in Cboe FIX. Price of this fill. Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: u4
        doc: 'Corresponds to LeavesQty (151) in Cboe FIX. Quantity still open for further execution'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values'
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. All externally matched (routed) executions will identify the away exchange'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: peg_difference
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_peg_difference > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_time_in_force > 0
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_min_qty > 0
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: display_indicator
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: discretion_amount
        type: u2
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_discretion_amount > 0
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty > 0
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: ext_exec_inst
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_ext_exec_inst > 0
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_routing_inst > 0
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_rout_strategy > 0
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_route_delivery_method > 0
      - id: ex_destination
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: cross_trade_flag
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_cross_trade_flag > 0
      - id: locate_broker
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and return_bitfield_18.return_bitfield_18_locate_broker > 0
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the at symbol and double quotes'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in Cboe FIX. Refers to the ExecID of the fill being cancelled or corrected'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        doc: 'Indicates whether the trade added or removed liquidity'
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
        doc: 'Corresponds to LastShares (32) in Cboe FIX. Executed share quantity'
      - id: last_px
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
        doc: 'Reserved for Cboe internal use'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol > 0
      - id: symbol_sfx
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_symbol_sfx > 0
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator > 0
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values'
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Copied from the MassCancelID passed on the original Purge Orders message. Corresponds to MassCancelID (7695) in Cboe FIX'
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. Corresponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for Cboe internal use'
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Number of bitfields to follow'
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
      - id: return_bitfield_18
        type: return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet OrderAcknowledgment byte 18'
      - id: return_bitfield_19
        type: return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet OrderAcknowledgment byte 19'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id > 0
        doc: 'Copied from the MassCancelID passed on the original Purge Orders message. Corresponds to MassCancelID (7695) in Cboe FIX'
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
      doc: 'A Login Request message must be sent as the first message upon connection. A number of repeating parameter groups are sent at the end of the message.'
    0x02:
      id: 'logout_request_message'
      doc: 'To end the session, the Member should send a Logout Request message. Cboe will finish sending any queued data and finally respond with a Logout message and close the connection.'
    0x03:
      id: 'client_heartbeat_message'
      doc: 'Client Heartbeat messages are sent from Member to Cboe if no other data has been sent in that direction for one second.'
    0x24:
      id: 'login_response_message'
      doc: 'A Login Response message is sent in response to a Login Request message. On a successful login, the LoginResponseStatus will be set to A. On a failed login, LoginResponseStatus will be set to a value other than A, and LoginResponseText will be set to an appropriate failure description.'
    0x08:
      id: 'logout_message'
      doc: 'A Logout message is usually sent in response to a Logout Request message. Any queued data is transmitted, a Logout message is sent, and Cboe will close the connection. A Logout may also be sent if the Member violates the protocol specification (e.g., by moving backwards in sequence number).'
    0x09:
      id: 'server_heartbeat_message'
      doc: 'Server Heartbeat messages are sent from Cboe to Member if no other data has been sent in that direction for one second.'
    0x13:
      id: 'replay_complete_message'
      doc: 'Cboe will send a Replay Complete message when replay is finished. If there are no messages to replay, a Replay Complete message will be sent immediately after a Login Response message.'
    0x38:
      id: 'new_order_message'
      doc: 'A New Order message consists of a number of required fields followed by a number of optional fields. The optional fields used are specified by setting bits in the NewOrderBitfields. Fields must be appended at the end of the message, starting with the lowest order enabled bit in the first bit field first.'
    0x39:
      id: 'cancel_order_message'
      doc: 'Request to cancel an order.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Request to modify an order. The order attributes to be modified are selected using NumberOfModifyBitfields and some number of bitfields to follow.'
    0x47:
      id: 'purge_orders_message'
      doc: 'Request to cancel a group of orders across all of the firm''s sessions. Purge Orders messages are only accepted on dedicated BOE Purge Ports.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'Order Acknowledgment messages are sent in response to a New Order message. The message corresponds to a FIX Execution Report with ExecType (150) = 0 (New).'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order message which must be rejected. This message corresponds to a FIX Execution Report with ExecType (150) = 8 (Rejected). Order Rejected messages are unsequenced.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Request to indicate that the order has been successfully modified.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated messages are sent to inform the Member that an order has been asynchronously modified for some reason without an explicit Modify Order message request having been sent.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order message for an order which cannot be modified. User Modify Rejected messages are unsequenced.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'An order has been cancelled.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur. Cancel Rejected messages are unsequenced.'
    0x2c:
      id: 'order_execution_message'
      doc: 'An Order Execution message is sent for each fill on an order. Rather than returning a monetary value indicating the rebate or charge for an execution, the FeeCode is an indication of a fee classification corresponding to an item on the venue''s fee schedule.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected (price change only). The CorrectedPrice field will be set to 0 for cancelled trades and to the new trade price for corrected trades. Trade Cancel or Correct messages can be sent for same day as well as previous day trades.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'A Mass Cancel Acknowledgment message is an unsequenced message sent when a Purge Orders message requesting a mass cancellation has completed canceling all individual orders. This message type only appears on dedicated BOE Purge Ports.'
    0x48:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur. Purge Rejected messages are unsequenced. This message type only appears on dedicated BOE Purge Ports.'
  login_response_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x4e:
      id: 'not_authorized_invalid_usernamepassword'
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
      id: 'sell_short_client_affirms_ability_to_borrow'
      doc: 'Sell Short Client Affirms Ability To Borrow'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit_default'
      doc: 'Limit Default'
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
      id: 'day_default'
      doc: 'Day Default'
    0x31:
      id: 'gtc_allowed_but_treated_as_day'
      doc: 'Gtc Allowed But Treated As Day'
    0x32:
      id: 'at_the_open_bzx_only'
      doc: 'At The Open Bzx Only'
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok'
    0x35:
      id: 'gtx_early_trading_session_until_end_of_post_market_session'
      doc: 'Gtx Early Trading Session Until End Of Post Market Session'
    0x36:
      id: 'gtd'
      doc: 'Gtd'
    0x37:
      id: 'at_the_close_bzx_only'
      doc: 'At The Close Bzx Only'
    0x45:
      id: 'pre_pre_market_trading_session_until_end_of_regular_session'
      doc: 'Pre Pre Market Trading Session Until End Of Regular Session'
    0x52:
      id: 'rho_regular_hours_session_only'
      doc: 'Rho Regular Hours Session Only'
    0x54:
      id: 'ptd_pre_market_trading_session_expires_at_earlier_of_expire_time_or_end_of_post_market_session'
      doc: 'Ptd Pre Market Trading Session Expires At Earlier Of Expire Time Or End Of Post Market Session'
    0x58:
      id: 'ptx_pre_market_trading_session_until_end_of_post_market_session'
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
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x57:
      id: 'waiting_for_execution_at_premarket_time'
      doc: 'Waiting For Execution At Premarket Time'
    0x58:
      id: 'routed_to_another_market'
      doc: 'Routed To Another Market'
  sub_liquidity_indicator:
    0x20:
      id: 'no_additional_information'
      doc: 'No Additional Information'
    0x45:
      id: 'trade_added_rpi_liquidity_byx_and_edgx'
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
      id: 'periodic_auction_byx_only'
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
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x43:
      id: 'capacity_undefined'
      doc: 'Capacity Undefined'
    0x44:
      id: 'duplicate_identifier_eg_cl_ord_id'
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
      id: 'limit_up_limit_down_luld'
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
      id: 'cboe_market_close_cmc'
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
      doc: 'Wash Or Mtp Decrement'

