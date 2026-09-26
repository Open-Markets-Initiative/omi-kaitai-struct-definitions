# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe C1Options BinaryOrderEntry Boe v2.11.115
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.11.115
#   Date: 9/14/2026
#   Specification: Cboe Titanium U.S. Options BOE Specification.pdf
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
  id: cboe_c1options_binaryorderentry_boe_v2_11_115
  title: Cboe C1Options BinaryOrderEntry Boe v2.11.115
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe C1 Options Binary Order Entry Boe v2.11.115'
doc-ref: https://www.cboe.com/us/options/support/technical/

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
        'message_type::new_order_cross_message': new_order_cross_message
        'message_type::new_complex_order_message': new_complex_order_message
        'message_type::new_order_cross_multileg_message': new_order_cross_multileg_message
        'message_type::cancel_order_message': cancel_order_message
        'message_type::modify_order_message': modify_order_message
        'message_type::quote_update_message': quote_update_message
        'message_type::quote_update_short_message': quote_update_short_message
        'message_type::complex_quote_update_message': complex_quote_update_message
        'message_type::complex_quote_update_short_message': complex_quote_update_short_message
        'message_type::purge_orders_message': purge_orders_message
        'message_type::reset_risk_message': reset_risk_message
        'message_type::new_complex_instrument_message': new_complex_instrument_message
        'message_type::add_floor_trade_message': add_floor_trade_message
        'message_type::floor_trade_confirmation_message': floor_trade_confirmation_message
        'message_type::delete_floor_trade_message': delete_floor_trade_message
        'message_type::order_acknowledgment_message': order_acknowledgment_message
        'message_type::cross_order_acknowledgment_message': cross_order_acknowledgment_message
        'message_type::quote_update_acknowledgment_message': quote_update_acknowledgment_message
        'message_type::order_rejected_message': order_rejected_message
        'message_type::cross_order_rejected_message': cross_order_rejected_message
        'message_type::quote_update_rejected_message': quote_update_rejected_message
        'message_type::order_modified_message': order_modified_message
        'message_type::order_restated_message': order_restated_message
        'message_type::quote_restated_message': quote_restated_message
        'message_type::user_modify_rejected_message': user_modify_rejected_message
        'message_type::order_cancelled_message': order_cancelled_message
        'message_type::quote_cancelled_message': quote_cancelled_message
        'message_type::cross_order_cancelled_message': cross_order_cancelled_message
        'message_type::cancel_rejected_message': cancel_rejected_message
        'message_type::order_execution_message': order_execution_message
        'message_type::quote_execution_message': quote_execution_message
        'message_type::complex_quote_execution_message': complex_quote_execution_message
        'message_type::trade_cancel_or_correct_message': trade_cancel_or_correct_message
        'message_type::purge_rejected_message': purge_rejected_message
        'message_type::reset_risk_acknowledgment_message': reset_risk_acknowledgment_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::purge_notification_message': purge_notification_message
        'message_type::complex_instrument_accepted_message': complex_instrument_accepted_message
        'message_type::complex_instrument_rejected_message': complex_instrument_rejected_message
        'message_type::floor_trade_notification_message': floor_trade_notification_message
        'message_type::add_floor_trade_rejected_message': add_floor_trade_rejected_message
        'message_type::floor_trade_confirmation_rejected_message': floor_trade_confirmation_rejected_message
        'message_type::delete_floor_trade_rejected_message': delete_floor_trade_rejected_message
        'message_type::delete_floor_trade_acknowledgement_message': delete_floor_trade_acknowledgement_message

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
        doc: 'Accepted, or the reason for the rejection. A = Login Accepted N = Not authorized (invalid username/password) D = Session is disabled B = Session in use S = Invalid session Q = Sequence ahead in Login message I = Invalid unit given in Login message F = Invalid return bit field in login message M = Invalid Login Request message structure'
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
        doc: 'The reason why the Logout message was sent. U = User Requested E = End of Day A = Administrative ! = Protocol Violation'
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: price_binary_price_8
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
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_symbol
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
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_put_or_call
      - id: display_range
        type: u4
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_display_range
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_ex_destination
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_echo_text
      - id: auction_id
        type: u8
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_auction_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_routing_firm_id
      - id: custom_group_id
        type: u2
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_custom_group_id
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_clearing_optional_data
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_frequent_trader_id
      - id: compression
        type: u1
        enum: compression
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_floor_routing_inst
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_order_origin
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_ors
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_price_type
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_risk_reset
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_open_close
      - id: cmta_number
        type: u4
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_cmta_number
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_target_party_id
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_session_eligibility
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_attributed_quote
      - id: held
        type: u1
        enum: held
        if: number_of_new_order_bitfields >= 11 and new_order_bitfield_11.new_order_bitfield_11_held
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
      - id: new_order_bitfield_4_reserved_8
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
      - id: new_order_bitfield_5_display_range
        type: b1
      - id: new_order_bitfield_5_stop_px
        type: b1
      - id: new_order_bitfield_5_rout_strategy
        type: b1
      - id: new_order_bitfield_5_route_delivery_method
        type: b1
      - id: new_order_bitfield_5_ex_destination
        type: b1
      - id: new_order_bitfield_5_echo_text
        type: b1
      - id: new_order_bitfield_5_auction_id
        type: b1
      - id: new_order_bitfield_5_routing_firm_id
        type: b1
  new_order_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_6_algorithmic_indicator
        type: b1
      - id: new_order_bitfield_6_custom_group_id
        type: b1
      - id: new_order_bitfield_6_client_qualified_role
        type: b1
      - id: new_order_bitfield_6_investor_qualified_role
        type: b1
      - id: new_order_bitfield_6_executor_qualified_role
        type: b1
      - id: new_order_bitfield_6_cti_code
        type: b1
      - id: new_order_bitfield_6_manual_order_indicator
        type: b1
      - id: new_order_bitfield_6_operator_id
        type: b1
  new_order_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_7_reserved_1
        type: b1
      - id: new_order_bitfield_7_reserved_2
        type: b1
      - id: new_order_bitfield_7_clearing_optional_data
        type: b1
      - id: new_order_bitfield_7_client_id_attr
        type: b1
      - id: new_order_bitfield_7_frequent_trader_id
        type: b1
      - id: new_order_bitfield_7_compression
        type: b1
      - id: new_order_bitfield_7_floor_destination
        type: b1
      - id: new_order_bitfield_7_floor_routing_inst
        type: b1
  new_order_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_8_order_origin
        type: b1
      - id: new_order_bitfield_8_ors
        type: b1
      - id: new_order_bitfield_8_price_type
        type: b1
      - id: new_order_bitfield_8_risk_reset
        type: b1
      - id: new_order_bitfield_8_open_close
        type: b1
      - id: new_order_bitfield_8_cmta_number
        type: b1
      - id: new_order_bitfield_8_target_party_id
        type: b1
      - id: new_order_bitfield_8_reserved_128
        type: b1
  new_order_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_9_session_eligibility
        type: b1
      - id: new_order_bitfield_9_attributed_quote
        type: b1
      - id: new_order_bitfield_9_booking_type
        type: b1
      - id: new_order_bitfield_9_ext_exec_inst
        type: b1
      - id: new_order_bitfield_9_client_id
        type: b1
      - id: new_order_bitfield_9_investor_id
        type: b1
      - id: new_order_bitfield_9_executor_id
        type: b1
      - id: new_order_bitfield_9_order_origination
        type: b1
  new_order_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_10_reserved_1
        type: b1
      - id: new_order_bitfield_10_reserved_2
        type: b1
      - id: new_order_bitfield_10_reserved_4
        type: b1
      - id: new_order_bitfield_10_reserved_8
        type: b1
      - id: new_order_bitfield_10_reserved_16
        type: b1
      - id: new_order_bitfield_10_reserved_32
        type: b1
      - id: new_order_bitfield_10_cross_trade_flag
        type: b1
      - id: new_order_bitfield_10_reserved_128
        type: b1
  new_order_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_11_held
        type: b1
      - id: new_order_bitfield_11_locate_broker
        type: b1
      - id: new_order_bitfield_11_reserved_4
        type: b1
      - id: new_order_bitfield_11_reserved_8
        type: b1
      - id: new_order_bitfield_11_reserved_16
        type: b1
      - id: new_order_bitfield_11_reserved_32
        type: b1
      - id: new_order_bitfield_11_reserved_64
        type: b1
      - id: new_order_bitfield_11_reserved_128
        type: b1
  new_order_cross_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: new_order_cross_bitfield_4
        type: new_order_cross_bitfield_4
        if: number_of_new_order_cross_bitfields >= 4
        doc: 'BitSet NewOrderCross byte 4'
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
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_put_or_call
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_exec_inst
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_attributed_quote
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_target_party_id
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
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_routing_firm_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_client_id_attr
      - id: equity_trade_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_price
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_size
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_venue
      - id: equity_transact_time
        type: nanosecond_timestamp
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_transact_time
        doc: 'Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_buy_clearing_firm
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_sell_clearing_firm
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_session_eligibility
      - id: compression
        type: u1
        enum: compression
        if: number_of_new_order_cross_bitfields >= 4 and new_order_cross_bitfield_4.new_order_cross_bitfield_4_compression
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_cross_bitfields >= 4 and new_order_cross_bitfield_4.new_order_cross_bitfield_4_ors
  new_order_cross_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_1_symbol
        type: b1
      - id: new_order_cross_bitfield_1_maturity_date
        type: b1
      - id: new_order_cross_bitfield_1_strike_price
        type: b1
      - id: new_order_cross_bitfield_1_put_or_call
        type: b1
      - id: new_order_cross_bitfield_1_exec_inst
        type: b1
      - id: new_order_cross_bitfield_1_attributed_quote
        type: b1
      - id: new_order_cross_bitfield_1_target_party_id
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
      - id: new_order_cross_bitfield_2_cmta_number
        type: b1
      - id: new_order_cross_bitfield_2_clearing_account
        type: b1
      - id: new_order_cross_bitfield_2_routing_firm_id
        type: b1
      - id: new_order_cross_bitfield_2_clearing_optional_data
        type: b1
  new_order_cross_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_3_client_id_attr
        type: b1
      - id: new_order_cross_bitfield_3_equity_trade_price
        type: b1
      - id: new_order_cross_bitfield_3_equity_trade_size
        type: b1
      - id: new_order_cross_bitfield_3_equity_trade_venue
        type: b1
      - id: new_order_cross_bitfield_3_equity_transact_time
        type: b1
      - id: new_order_cross_bitfield_3_equity_buy_clearing_firm
        type: b1
      - id: new_order_cross_bitfield_3_equity_sell_clearing_firm
        type: b1
      - id: new_order_cross_bitfield_3_session_eligibility
        type: b1
  new_order_cross_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_bitfield_4_compression
        type: b1
      - id: new_order_cross_bitfield_4_ors
        type: b1
      - id: new_order_cross_bitfield_4_frequent_trader_id
        type: b1
      - id: new_order_cross_bitfield_4_reserved_8
        type: b1
      - id: new_order_cross_bitfield_4_reserved_16
        type: b1
      - id: new_order_cross_bitfield_4_reserved_32
        type: b1
      - id: new_order_cross_bitfield_4_reserved_64
        type: b1
      - id: new_order_cross_bitfield_4_reserved_128
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: capacity
        type: u1
        enum: capacity
      - id: open_close
        type: u1
        enum: open_close
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_account
      - id: cmta_number
        type: u4
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_cmta_number
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_clearing_account
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 2 and _parent.new_order_cross_bitfield_2.new_order_cross_bitfield_2_clearing_optional_data
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: _parent.number_of_new_order_cross_bitfields >= 4 and _parent.new_order_cross_bitfield_4.new_order_cross_bitfield_4_frequent_trader_id
  new_complex_order_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: new_complex_order_bitfield_8
        type: new_complex_order_bitfield_8
        if: number_of_new_complex_order_bitfields >= 8
        doc: 'BitSet NewComplexOrder byte 8'
      - id: new_complex_order_bitfield_9
        type: new_complex_order_bitfield_9
        if: number_of_new_complex_order_bitfields >= 9
        doc: 'BitSet NewComplexOrder byte 9'
      - id: num_complex_leg_order_info
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 16'
      - id: complex_leg_order_info
        type: complex_leg_order_info
        repeat: expr
        repeat-expr: num_complex_leg_order_info
        doc: 'Repeating group stated NoLegs times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_f_irm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_account
      - id: price_binary_price_8
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
      - id: equity_leg_short_sell
        type: u1
        enum: equity_leg_short_sell
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_equity_leg_short_sell
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_order_origin
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_capacity
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_routing_inst
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_account
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_prevent_match
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: cmta_number
        type: u4
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_cmta_number
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_target_party_id
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_attributed_quote
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_echo_text
      - id: auction_id
        type: u8
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_auction_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_routing_firm_id
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_risk_reset
      - id: custom_group_id
        type: u2
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_custom_group_id
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_equity_party_id
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_clearing_optional_data
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_frequent_trader_id
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_session_eligibility
      - id: max_floor
        type: u4
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_max_floor
      - id: display_range
        type: u4
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_display_range
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_compression
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_equity_ex_destination
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_ors
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_strategy_id
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_exec_inst
      - id: tied_hedge
        type: u1
        enum: tied_hedge
        if: number_of_new_complex_order_bitfields >= 7 and new_complex_order_bitfield_7.new_complex_order_bitfield_7_tied_hedge
      - id: held
        type: u1
        enum: held
        if: number_of_new_complex_order_bitfields >= 8 and new_complex_order_bitfield_8.new_complex_order_bitfield_8_held
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 9 and new_complex_order_bitfield_9.new_complex_order_bitfield_9_cross_initiator
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 9 and new_complex_order_bitfield_9.new_complex_order_bitfield_9_cross_on_behalf_of_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_complex_order_bitfields >= 9 and new_complex_order_bitfield_9.new_complex_order_bitfield_9_stop_px
        doc: 'Implied decimal with scale 1e-4'
  new_complex_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_1_clearing_f_irm
        type: b1
      - id: new_complex_order_bitfield_1_clearing_account
        type: b1
      - id: new_complex_order_bitfield_1_price
        type: b1
      - id: new_complex_order_bitfield_1_ord_type
        type: b1
      - id: new_complex_order_bitfield_1_time_in_force
        type: b1
      - id: new_complex_order_bitfield_1_reserved_32
        type: b1
      - id: new_complex_order_bitfield_1_reserved_64
        type: b1
      - id: new_complex_order_bitfield_1_reserved_128
        type: b1
  new_complex_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_2_equity_leg_short_sell
        type: b1
      - id: new_complex_order_bitfield_2_floor_destination
        type: b1
      - id: new_complex_order_bitfield_2_floor_routing_inst
        type: b1
      - id: new_complex_order_bitfield_2_multi_class_sprd
        type: b1
      - id: new_complex_order_bitfield_2_order_origin
        type: b1
      - id: new_complex_order_bitfield_2_symbol
        type: b1
      - id: new_complex_order_bitfield_2_capacity
        type: b1
      - id: new_complex_order_bitfield_2_routing_inst
        type: b1
  new_complex_order_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_3_account
        type: b1
      - id: new_complex_order_bitfield_3_prevent_match
        type: b1
      - id: new_complex_order_bitfield_3_expire_time
        type: b1
      - id: new_complex_order_bitfield_3_cmta_number
        type: b1
      - id: new_complex_order_bitfield_3_target_party_id
        type: b1
      - id: new_complex_order_bitfield_3_attributed_quote
        type: b1
      - id: new_complex_order_bitfield_3_echo_text
        type: b1
      - id: new_complex_order_bitfield_3_auction_id
        type: b1
  new_complex_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_4_routing_firm_id
        type: b1
      - id: new_complex_order_bitfield_4_drill_thru_protection
        type: b1
      - id: new_complex_order_bitfield_4_risk_reset
        type: b1
      - id: new_complex_order_bitfield_4_custom_group_id
        type: b1
      - id: new_complex_order_bitfield_4_leg_side
        type: b1
      - id: new_complex_order_bitfield_4_equity_party_id
        type: b1
      - id: new_complex_order_bitfield_4_reserved_64
        type: b1
      - id: new_complex_order_bitfield_4_clearing_optional_data
        type: b1
  new_complex_order_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_5_client_id_attr
        type: b1
      - id: new_complex_order_bitfield_5_frequent_trader_id
        type: b1
      - id: new_complex_order_bitfield_5_session_eligibility
        type: b1
      - id: new_complex_order_bitfield_5_max_floor
        type: b1
      - id: new_complex_order_bitfield_5_display_range
        type: b1
      - id: new_complex_order_bitfield_5_combo_order
        type: b1
      - id: new_complex_order_bitfield_5_compression
        type: b1
      - id: new_complex_order_bitfield_5_equity_ex_destination
        type: b1
  new_complex_order_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_6_reserved_1
        type: b1
      - id: new_complex_order_bitfield_6_reserved_2
        type: b1
      - id: new_complex_order_bitfield_6_reserved_4
        type: b1
      - id: new_complex_order_bitfield_6_reserved_8
        type: b1
      - id: new_complex_order_bitfield_6_reserved_16
        type: b1
      - id: new_complex_order_bitfield_6_ors
        type: b1
      - id: new_complex_order_bitfield_6_price_type
        type: b1
      - id: new_complex_order_bitfield_6_strategy_id
        type: b1
  new_complex_order_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_7_reserved_1
        type: b1
      - id: new_complex_order_bitfield_7_exec_inst
        type: b1
      - id: new_complex_order_bitfield_7_tied_hedge
        type: b1
      - id: new_complex_order_bitfield_7_reserved_8
        type: b1
      - id: new_complex_order_bitfield_7_reserved_16
        type: b1
      - id: new_complex_order_bitfield_7_reserved_32
        type: b1
      - id: new_complex_order_bitfield_7_reserved_64
        type: b1
      - id: new_complex_order_bitfield_7_reserved_128
        type: b1
  new_complex_order_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_8_reserved_1
        type: b1
      - id: new_complex_order_bitfield_8_reserved_2
        type: b1
      - id: new_complex_order_bitfield_8_reserved_4
        type: b1
      - id: new_complex_order_bitfield_8_reserved_8
        type: b1
      - id: new_complex_order_bitfield_8_reserved_16
        type: b1
      - id: new_complex_order_bitfield_8_reserved_32
        type: b1
      - id: new_complex_order_bitfield_8_reserved_64
        type: b1
      - id: new_complex_order_bitfield_8_held
        type: b1
  new_complex_order_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_9_reserved_1
        type: b1
      - id: new_complex_order_bitfield_9_cross_initiator
        type: b1
      - id: new_complex_order_bitfield_9_cross_on_behalf_of_id
        type: b1
      - id: new_complex_order_bitfield_9_stop_px
        type: b1
      - id: new_complex_order_bitfield_9_stop_px_type
        type: b1
      - id: new_complex_order_bitfield_9_reserved_32
        type: b1
      - id: new_complex_order_bitfield_9_reserved_64
        type: b1
      - id: new_complex_order_bitfield_9_reserved_128
        type: b1
  complex_leg_order_info:
    seq:
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
        doc: 'Corresponds to LegPositionEffect (564) in Cboe FIX. Indicates status of client position in option for this leg. O = Open C = Close N = None* *Only Orders with an OrderCapacity of ‘M’ or ‘N’ will be allowed to specify ‘N’ for LegPositionEffect. If the leg is limited to closing only transactions, onlyC apacity = M will be permitted to submit OpenClose = O if the order has TimeInForce = ‘3’ (IOC) and RoutingInst = B'
  new_order_cross_multileg_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
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
      - id: new_order_cross_multileg_bitfield_4
        type: new_order_cross_multileg_bitfield_4
        if: number_of_new_order_cross_multileg_bitfields >= 4
        doc: 'BitSet NewOrderCrossMultileg byte 4'
      - id: new_order_cross_multileg_bitfield_5
        type: new_order_cross_multileg_bitfield_5
        if: number_of_new_order_cross_multileg_bitfields >= 5
        doc: 'BitSet NewOrderCrossMultileg byte 5'
      - id: new_order_cross_multileg_bitfield_6
        type: new_order_cross_multileg_bitfield_6
        if: number_of_new_order_cross_multileg_bitfields >= 6
        doc: 'BitSet NewOrderCrossMultileg byte 6'
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
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_exec_inst
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_attributed_quote
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_target_party_id
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
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_ex_destination
      - id: compression
        type: u1
        enum: compression
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_compression
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_ors
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_cross_initiator
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_routing_firm_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_client_id_attr
      - id: equity_trade_price
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_trade_price
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_trade_size
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_trade_venue
      - id: equity_transact_time
        type: nanosecond_timestamp
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_transact_time
        doc: 'Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_buy_clearing_firm
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_equity_sell_clearing_firm
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_session_eligibility
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 6 and new_order_cross_multileg_bitfield_6.new_order_cross_multileg_bitfield_6_cross_on_behalf_of_id
  new_order_cross_multileg_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_1_symbol
        type: b1
      - id: new_order_cross_multileg_bitfield_1_reserved_2
        type: b1
      - id: new_order_cross_multileg_bitfield_1_reserved_4
        type: b1
      - id: new_order_cross_multileg_bitfield_1_reserved_8
        type: b1
      - id: new_order_cross_multileg_bitfield_1_exec_inst
        type: b1
      - id: new_order_cross_multileg_bitfield_1_attributed_quote
        type: b1
      - id: new_order_cross_multileg_bitfield_1_target_party_id
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
      - id: new_order_cross_multileg_bitfield_2_reserved_8
        type: b1
      - id: new_order_cross_multileg_bitfield_2_reserved_16
        type: b1
      - id: new_order_cross_multileg_bitfield_2_reserved_32
        type: b1
      - id: new_order_cross_multileg_bitfield_2_reserved_64
        type: b1
      - id: new_order_cross_multileg_bitfield_2_reserved_128
        type: b1
  new_order_cross_multileg_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_3_equity_party_id
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_leg_short_sell
        type: b1
      - id: new_order_cross_multileg_bitfield_3_reserved_4
        type: b1
      - id: new_order_cross_multileg_bitfield_3_reserved_8
        type: b1
      - id: new_order_cross_multileg_bitfield_3_drill_thru_protection
        type: b1
      - id: new_order_cross_multileg_bitfield_3_price_type
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_ex_destination
        type: b1
      - id: new_order_cross_multileg_bitfield_3_compression
        type: b1
  new_order_cross_multileg_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_4_ors
        type: b1
      - id: new_order_cross_multileg_bitfield_4_frequent_trader_id
        type: b1
      - id: new_order_cross_multileg_bitfield_4_cross_initiator
        type: b1
      - id: new_order_cross_multileg_bitfield_4_account
        type: b1
      - id: new_order_cross_multileg_bitfield_4_cmta_number
        type: b1
      - id: new_order_cross_multileg_bitfield_4_clearing_account
        type: b1
      - id: new_order_cross_multileg_bitfield_4_routing_firm_id
        type: b1
      - id: new_order_cross_multileg_bitfield_4_clearing_optional_data
        type: b1
  new_order_cross_multileg_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_5_client_id_attr
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_trade_price
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_trade_size
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_trade_venue
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_transact_time
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_buy_clearing_firm
        type: b1
      - id: new_order_cross_multileg_bitfield_5_equity_sell_clearing_firm
        type: b1
      - id: new_order_cross_multileg_bitfield_5_session_eligibility
        type: b1
  new_order_cross_multileg_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_6_reserved_1
        type: b1
      - id: new_order_cross_multileg_bitfield_6_reserved_2
        type: b1
      - id: new_order_cross_multileg_bitfield_6_reserved_4
        type: b1
      - id: new_order_cross_multileg_bitfield_6_leg_position_effects_ext
        type: b1
      - id: new_order_cross_multileg_bitfield_6_cross_on_behalf_of_id
        type: b1
      - id: new_order_cross_multileg_bitfield_6_reserved_32
        type: b1
      - id: new_order_cross_multileg_bitfield_6_reserved_64
        type: b1
      - id: new_order_cross_multileg_bitfield_6_reserved_128
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: capacity
        type: u1
        enum: capacity
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
      - id: leg_position_effects
        type: str
        size: 12
        encoding: ASCII
        doc: 'Indicates status of the client position in the option for each complex option leg. This value String of characters ‘O’, ‘C’, and ‘N’, equal in length to the number of option legs of the instrument. If an equity leg is present it will always be the last leg, and the position effect must be set to ‘N’. This field can be used for complex instruments with up to 12 legs. For more than 12 legs, fill this field with spaces (0x20) and use the optional LegPositionEffectsExt field. O=Open C=Close N=None* *Orders with Capacity = M or ‘N’ will not be required to specify a position effect on their orders or may specify a value of ‘N’, in which case<blank> will be sent to clearing. If the leg is limited to closing only transactions, only Capacity = M will be permitted to submit OpenClose = O if the order has TimeInForce= ‘3’ (IOC) and RoutingInst = B'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 4 and _parent.new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_account
      - id: cmta_number
        type: u4
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 4 and _parent.new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_cmta_number
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 4 and _parent.new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_clearing_account
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 4 and _parent.new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_clearing_optional_data
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_party_id
      - id: equity_leg_short_sell
        type: u1
        enum: equity_leg_short_sell
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 3 and _parent.new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_leg_short_sell
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 4 and _parent.new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_frequent_trader_id
      - id: leg_position_effects_ext
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_new_order_cross_multileg_bitfields >= 6 and _parent.new_order_cross_multileg_bitfield_6.new_order_cross_multileg_bitfield_6_leg_position_effects_ext
        doc: 'See List of Optional Fields'
  cancel_order_message:
    seq:
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
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
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_clearing_firm
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_risk_root
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_routing_firm_id
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 2 and cancel_order_bitfield_2.cancel_order_bitfield_2_mass_cancel_inst
      - id: send_time
        type: nanosecond_timestamp
        if: number_of_cancel_order_bitfields >= 2 and cancel_order_bitfield_2.cancel_order_bitfield_2_send_time
        doc: 'Nanoseconds since Unix epoch'
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
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
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
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_ord_type
      - id: cancel_orig_on_reject
        type: u1
        enum: cancel_orig_on_reject
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_cancel_orig_on_reject
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_exec_inst
      - id: max_floor
        type: u4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_max_floor
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_routing_firm_id
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
  quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
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
      - id: reserved_15
        size: 15
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'P=Post Only (do not remove liquidity) B=Book Only (allow removal of liquidity, available for Market Makers only) N=Book Only, No Slide R=Post Only, No Slide (do not remove liquidity) I=Book Only IOC'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
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
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: open_close
        type: u1
        enum: open_close
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  quote_update_short_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: custom_group_id
        type: u2
      - id: capacity
        type: u1
        enum: capacity
      - id: reserved_3
        size: 3
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'P=Post Only (do not remove liquidity) B=Book Only (allow removal of liquidity, available for Market Makers only) N=Book Only, No Slide R=Post Only, No Slide (do not remove liquidity) I=Book Only IOC'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
      - id: num_quote_update_short_quote
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote_update_short_quote
        type: quote_update_short_quote
        repeat: expr
        repeat-expr: num_quote_update_short_quote
        doc: 'Repeating group stated QuoteCnt times'
  quote_update_short_quote:
    seq:
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: open_close
        type: u1
        enum: open_close
      - id: price_binary_price_4
        type: decimal_s4_4
        doc: 'Limit price. To cancel an existing quote, specify a size of 0. Implied decimal with scale 1e-4'
      - id: order_qty_binary_2
        type: u2
        doc: 'Order quantity. System limit is 999,999 contracts. To cancel an existing quote, specify a size of 0'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  complex_quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
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
      - id: reserved_15
        size: 15
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'P=Post Only (do not remove liquidity) B=Book Only (allow removal of liquidity, available for Market Makers only) N=Book Only, No Slide R=Post Only, No Slide (do not remove liquidity) I=Book Only IOC'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
      - id: num_quote
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote
        type: quote
        repeat: expr
        repeat-expr: num_quote
        doc: 'Repeating group stated QuoteCnt times'
  complex_quote_update_short_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: custom_group_id
        type: u2
      - id: capacity
        type: u1
        enum: capacity
      - id: reserved_3
        size: 3
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'P=Post Only (do not remove liquidity) B=Book Only (allow removal of liquidity, available for Market Makers only) N=Book Only, No Slide R=Post Only, No Slide (do not remove liquidity) I=Book Only IOC'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
      - id: num_complex_quote_update_short_quote
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: complex_quote_update_short_quote
        type: complex_quote_update_short_quote
        repeat: expr
        repeat-expr: num_complex_quote_update_short_quote
        doc: 'Repeating group stated QuoteCnt times'
  complex_quote_update_short_quote:
    seq:
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: open_close
        type: u1
        enum: open_close
      - id: price_binary_price_4
        type: decimal_s4_4
        doc: 'Limit price. To cancel an existing quote, specify a size of 0. Implied decimal with scale 1e-4'
      - id: order_qty_binary_2
        type: u2
        doc: 'Order quantity. System limit is 999,999 contracts. To cancel an existing quote, specify a size of 0'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  purge_orders_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: num_custom_group_i_ds
        type: u1
        doc: 'Number of repeating CustomGroupID included in this message. Integer 0-10'
      - id: custom_group_i_ds
        type: custom_group_i_ds
        repeat: expr
        repeat-expr: num_custom_group_i_ds
        doc: 'Repeating group stated CustomGroupIDCnt times'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_clearing_firm
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_inst
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_risk_root
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_mass_cancel_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_orders_bitfields >= 1 and purge_orders_bitfield_1.purge_orders_bitfield_1_routing_firm_id
      - id: send_time
        type: nanosecond_timestamp
        if: number_of_purge_orders_bitfields >= 2 and purge_orders_bitfield_2.purge_orders_bitfield_2_send_time
        doc: 'Nanoseconds since Unix epoch'
      - id: matching_unit
        type: u1
        if: number_of_purge_orders_bitfields >= 2 and purge_orders_bitfield_2.purge_orders_bitfield_2_matching_unit
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
  custom_group_i_ds:
    seq:
      - id: custom_group_id
        type: u2
  reset_risk_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: Cboe only enforces uniqueness of RiskStatusID values among currently unacknowledged requests. However, we strongly recommend that you keep your RiskStatusID values day-unique'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
      - id: target_matching_unit
        type: u1
        doc: 'Direct the reset risk to a specific matching unit. A zero value will cause the reset risk to be sent to all matching units. Ignored for risk root level resets'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
      - id: custom_group_id
        type: u2
  new_complex_instrument_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: number_of_new_complex_instrument_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: new_complex_instrument_bitfield_1
        type: new_complex_instrument_bitfield_1
        if: number_of_new_complex_instrument_bitfields >= 1
        doc: 'BitSet NewComplexInstrument byte 1'
      - id: num_complex_leg
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 16'
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
      - id: leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_cfi_code
        doc: 'Corresponds to LegCFICode (608) in Cboe FIX. (Optional) CFI Code for leg. Required if LegSymbol is in OSI format. OP = Options Put OC = Options Call E = Equity'
      - id: leg_maturity_date
        type: yyyymmdd_date
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_maturity_date
        doc: 'Corresponds to LegMaturityDate (611) in Cboe FIX. (Optional) Required if LegSymbol is in OSI format'
      - id: leg_strike_price
        type: decimal_s8_4
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_strike_price
        doc: 'Corresponds to LegStrikePrice (612) in Cboe FIX. (Optional) Option strike price. System maximum is 99,999,999. Must be non-negative. Required if LegSymbol is in OSI format. Implied decimal with scale 1e-4'
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
      - id: new_complex_instrument_bitfield_1_reserved_32
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
        doc: 'Corresponds to LegSymbol (600) in Cboe FIX. Entire Cboe format symbol or OSI Root. Must send LegCFICode, LegMaturityDate, and LegStrikePrice if using OSI format'
      - id: leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        doc: 'Corresponds to LegCFICode (608) in Cboe FIX. (Optional) CFI Code for leg. Required if LegSymbol is in OSI format. OP = Options Put OC = Options Call E = Equity'
      - id: leg_maturity_date
        type: yyyymmdd_date
        doc: 'Corresponds to LegMaturityDate (611) in Cboe FIX. (Optional) Required if LegSymbol is in OSI format'
      - id: leg_strike_price
        type: decimal_s8_4
        doc: 'Corresponds to LegStrikePrice (612) in Cboe FIX. (Optional) Option strike price. System maximum is 99,999,999. Must be non-negative. Required if LegSymbol is in OSI format. Implied decimal with scale 1e-4'
      - id: leg_ratio_qty
        type: u4
        doc: 'Corresponds to LegRatioQty (623) in Cboe FIX. Ratio of number of contracts in this leg per order quantity. Accepted values are 1-999,999'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Corresponds to LegSide (624) in Cboe FIX. 1 = Buy 2 = Sell'
  add_floor_trade_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Corresponds to MultilegReportingType (442) in Cboe FIX. Indicates the type of Order Execution message. 1=Single-leg instrument 2=Individual leg of multi-leg instrument'
      - id: combo_order
        type: u1
        enum: combo_order
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: cmta_number
        type: u4
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor acronym of participant submitting trade'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: open_close
        type: u1
        enum: open_close
      - id: floor_trade_time
        type: nanosecond_timestamp
        doc: 'Trade time. Nanoseconds since Unix epoch'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  floor_trade_confirmation_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: price_type
        type: u1
        enum: price_type
      - id: reserved_15
        size: 15
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  delete_floor_trade_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: number_of_return_bitf
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_acknowledgment_return_bitfield_1.order_acknowledgment_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_acknowledgment_return_bitfield_2.order_acknowledgment_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_acknowledgment_return_bitfield_3.order_acknowledgment_return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and order_acknowledgment_return_bitfield_4.order_acknowledgment_return_bitfield_4_put_or_call
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 5 and order_acknowledgment_return_bitfield_5.order_acknowledgment_return_bitfield_5_sub_liquidity_indicator
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 6 and order_acknowledgment_return_bitfield_6.order_acknowledgment_return_bitfield_6_ex_destination
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 7 and order_acknowledgment_return_bitfield_7.order_acknowledgment_return_bitfield_7_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_acknowledgment_return_bitfield_8.order_acknowledgment_return_bitfield_8_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 8 and order_acknowledgment_return_bitfield_8.order_acknowledgment_return_bitfield_8_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_acknowledgment_return_bitfield_8.order_acknowledgment_return_bitfield_8_give_up_firm_id
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 9 and order_acknowledgment_return_bitfield_9.order_acknowledgment_return_bitfield_9_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_acknowledgment_return_bitfield_11.order_acknowledgment_return_bitfield_11_equity_party_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_acknowledgment_return_bitfield_11.order_acknowledgment_return_bitfield_11_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_frequent_trader_id
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_session_eligibility
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_combo_order
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 12 and order_acknowledgment_return_bitfield_12.order_acknowledgment_return_bitfield_12_corrected_size
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 13 and order_acknowledgment_return_bitfield_13.order_acknowledgment_return_bitfield_13_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_secondary_order_id
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 14 and order_acknowledgment_return_bitfield_14.order_acknowledgment_return_bitfield_14_attributed_quote
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and order_acknowledgment_return_bitfield_15.order_acknowledgment_return_bitfield_15_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 15 and order_acknowledgment_return_bitfield_15.order_acknowledgment_return_bitfield_15_cross_exclusion_indicator
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and order_acknowledgment_return_bitfield_17.order_acknowledgment_return_bitfield_17_clearing_optional_data
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 18 and order_acknowledgment_return_bitfield_18.order_acknowledgment_return_bitfield_18_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_acknowledgment_return_bitfield_18.order_acknowledgment_return_bitfield_18_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 18 and order_acknowledgment_return_bitfield_18.order_acknowledgment_return_bitfield_18_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 18 and order_acknowledgment_return_bitfield_18.order_acknowledgment_return_bitfield_18_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_acknowledgment_return_bitfield_18.order_acknowledgment_return_bitfield_18_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 19 and order_acknowledgment_return_bitfield_19.order_acknowledgment_return_bitfield_19_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 19 and order_acknowledgment_return_bitfield_19.order_acknowledgment_return_bitfield_19_strategy_id
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 20 and order_acknowledgment_return_bitfield_20.order_acknowledgment_return_bitfield_20_cross_initiator
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 20 and order_acknowledgment_return_bitfield_20.order_acknowledgment_return_bitfield_20_held
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_acknowledgment_return_bitfield_21.order_acknowledgment_return_bitfield_21_cross_on_behalf_of_id
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
      - id: order_acknowledgment_return_bitfield_1_ord_type
        type: b1
      - id: order_acknowledgment_return_bitfield_1_time_in_force
        type: b1
      - id: order_acknowledgment_return_bitfield_1_min_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_1_reserved_128
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
      - id: order_acknowledgment_return_bitfield_2_contra_trader
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
      - id: order_acknowledgment_return_bitfield_4_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_4_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_4_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_4_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_4_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_5_trade_report_type_return
        type: b1
      - id: order_acknowledgment_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: order_acknowledgment_return_bitfield_5_text
        type: b1
      - id: order_acknowledgment_return_bitfield_5_bid
        type: b1
      - id: order_acknowledgment_return_bitfield_5_offer
        type: b1
      - id: order_acknowledgment_return_bitfield_5_large_size
        type: b1
      - id: order_acknowledgment_return_bitfield_5_last_mkt
        type: b1
  order_acknowledgment_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_6_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_6_echo_text
        type: b1
      - id: order_acknowledgment_return_bitfield_6_stop_px
        type: b1
      - id: order_acknowledgment_return_bitfield_6_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_6_rout_strategy
        type: b1
      - id: order_acknowledgment_return_bitfield_6_route_delivery_method
        type: b1
      - id: order_acknowledgment_return_bitfield_6_ex_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_6_trade_report_ref_id
        type: b1
  order_acknowledgment_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_7_marketing_fee_code
        type: b1
      - id: order_acknowledgment_return_bitfield_7_target_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_7_auction_id
        type: b1
      - id: order_acknowledgment_return_bitfield_7_order_category
        type: b1
      - id: order_acknowledgment_return_bitfield_7_liquidity_provision
        type: b1
      - id: order_acknowledgment_return_bitfield_7_cmta_number
        type: b1
      - id: order_acknowledgment_return_bitfield_7_cross_type
        type: b1
      - id: order_acknowledgment_return_bitfield_7_cross_prioritization
        type: b1
  order_acknowledgment_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_8_cross_id
        type: b1
      - id: order_acknowledgment_return_bitfield_8_alloc_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_8_give_up_firm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_8_reserved_8
        type: b1
      - id: order_acknowledgment_return_bitfield_8_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_8_reserved_32
        type: b1
      - id: order_acknowledgment_return_bitfield_8_reserved_64
        type: b1
      - id: order_acknowledgment_return_bitfield_8_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_9_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_9_day_order_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_9_day_cum_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_9_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_9_day_avg_px
        type: b1
      - id: order_acknowledgment_return_bitfield_9_pending_status
        type: b1
      - id: order_acknowledgment_return_bitfield_9_drill_thru_protection
        type: b1
      - id: order_acknowledgment_return_bitfield_9_multileg_reporting_type
        type: b1
  order_acknowledgment_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_10_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_10_leg_maturity_date
        type: b1
      - id: order_acknowledgment_return_bitfield_10_leg_strike_price
        type: b1
      - id: order_acknowledgment_return_bitfield_10_room_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_secondary_exec_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_user_request_id
        type: b1
      - id: order_acknowledgment_return_bitfield_10_sis_username
        type: b1
      - id: order_acknowledgment_return_bitfield_10_user_status
        type: b1
  order_acknowledgment_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_11_trade_reporting_indicato
        type: b1
      - id: order_acknowledgment_return_bitfield_11_equity_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_equity_nbbo_protect
        type: b1
      - id: order_acknowledgment_return_bitfield_11_mass_cancel_id
        type: b1
      - id: order_acknowledgment_return_bitfield_11_trade_publish_ind
        type: b1
      - id: order_acknowledgment_return_bitfield_11_report_time
        type: b1
      - id: order_acknowledgment_return_bitfield_11_leg_symbol_sfx
        type: b1
      - id: order_acknowledgment_return_bitfield_11_client_id_attr
        type: b1
  order_acknowledgment_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_12_frequent_trader_id
        type: b1
      - id: order_acknowledgment_return_bitfield_12_session_eligibility
        type: b1
      - id: order_acknowledgment_return_bitfield_12_combo_order
        type: b1
      - id: order_acknowledgment_return_bitfield_12_open_close
        type: b1
      - id: order_acknowledgment_return_bitfield_12_cl_ord_id_batch
        type: b1
      - id: order_acknowledgment_return_bitfield_12_corrected_size
        type: b1
      - id: order_acknowledgment_return_bitfield_12_party_id
        type: b1
      - id: order_acknowledgment_return_bitfield_12_access_fee
        type: b1
  order_acknowledgment_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_13_orig_cl_ord_id
        type: b1
      - id: order_acknowledgment_return_bitfield_13_leaves_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_13_last_shares
        type: b1
      - id: order_acknowledgment_return_bitfield_13_last_px
        type: b1
      - id: order_acknowledgment_return_bitfield_13_display_price
        type: b1
      - id: order_acknowledgment_return_bitfield_13_working_price
        type: b1
      - id: order_acknowledgment_return_bitfield_13_base_liquidity_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_13_expire_time
        type: b1
  order_acknowledgment_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_14_secondary_order_id
        type: b1
      - id: order_acknowledgment_return_bitfield_14_ccp
        type: b1
      - id: order_acknowledgment_return_bitfield_14_contra_capacity
        type: b1
      - id: order_acknowledgment_return_bitfield_14_attributed_quote
        type: b1
      - id: order_acknowledgment_return_bitfield_14_ext_exec_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_14_bulk_order_ids
        type: b1
      - id: order_acknowledgment_return_bitfield_14_bulk_reject_reasons
        type: b1
      - id: order_acknowledgment_return_bitfield_14_party_role
        type: b1
  order_acknowledgment_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_15_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_15_reserved_2
        type: b1
      - id: order_acknowledgment_return_bitfield_15_reserved_4
        type: b1
      - id: order_acknowledgment_return_bitfield_15_routing_firm_id
        type: b1
      - id: order_acknowledgment_return_bitfield_15_waiver_type
        type: b1
      - id: order_acknowledgment_return_bitfield_15_cross_exclusion_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_15_price_formation
        type: b1
      - id: order_acknowledgment_return_bitfield_15_client_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_16_client_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_investor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_executor_id
        type: b1
      - id: order_acknowledgment_return_bitfield_16_order_origination
        type: b1
      - id: order_acknowledgment_return_bitfield_16_algo
        type: b1
      - id: order_acknowledgment_return_bitfield_16_deferral_reason
        type: b1
      - id: order_acknowledgment_return_bitfield_16_investor_qualified_role
        type: b1
      - id: order_acknowledgment_return_bitfield_16_executor_qualified_role
        type: b1
  order_acknowledgment_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_17_cti_code
        type: b1
      - id: order_acknowledgment_return_bitfield_17_manual_order_indicator
        type: b1
      - id: order_acknowledgment_return_bitfield_17_operator_id
        type: b1
      - id: order_acknowledgment_return_bitfield_17_trade_date
        type: b1
      - id: order_acknowledgment_return_bitfield_17_clearing_price
        type: b1
      - id: order_acknowledgment_return_bitfield_17_clearing_size
        type: b1
      - id: order_acknowledgment_return_bitfield_17_clearing_symbol
        type: b1
      - id: order_acknowledgment_return_bitfield_17_clearing_optional_data
        type: b1
  order_acknowledgment_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_18_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_2
        type: b1
      - id: order_acknowledgment_return_bitfield_18_reserved_4
        type: b1
      - id: order_acknowledgment_return_bitfield_18_compression
        type: b1
      - id: order_acknowledgment_return_bitfield_18_floor_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_18_floor_routing_inst
        type: b1
      - id: order_acknowledgment_return_bitfield_18_multi_class_sprd
        type: b1
      - id: order_acknowledgment_return_bitfield_18_order_origin
        type: b1
  order_acknowledgment_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_19_price_type
        type: b1
      - id: order_acknowledgment_return_bitfield_19_strategy_id
        type: b1
      - id: order_acknowledgment_return_bitfield_19_trading_session_id
        type: b1
      - id: order_acknowledgment_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: order_acknowledgment_return_bitfield_19_sender_location_id
        type: b1
      - id: order_acknowledgment_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: order_acknowledgment_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: order_acknowledgment_return_bitfield_19_cust_order_handling_inst
        type: b1
  order_acknowledgment_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_20_reserved_1
        type: b1
      - id: order_acknowledgment_return_bitfield_20_cross_initiator
        type: b1
      - id: order_acknowledgment_return_bitfield_20_subreason
        type: b1
      - id: order_acknowledgment_return_bitfield_20_cross_trade_flag
        type: b1
      - id: order_acknowledgment_return_bitfield_20_reserved_16
        type: b1
      - id: order_acknowledgment_return_bitfield_20_held
        type: b1
      - id: order_acknowledgment_return_bitfield_20_locate_broker
        type: b1
      - id: order_acknowledgment_return_bitfield_20_reserved_128
        type: b1
  order_acknowledgment_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_acknowledgment_return_bitfield_21_floor_trade_time
        type: b1
      - id: order_acknowledgment_return_bitfield_21_equity_ex_destination
        type: b1
      - id: order_acknowledgment_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: order_acknowledgment_return_bitfield_21_cmc_sessions
        type: b1
      - id: order_acknowledgment_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: order_acknowledgment_return_bitfield_21_cmc_match_qty
        type: b1
      - id: order_acknowledgment_return_bitfield_21_stop_px_type
        type: b1
      - id: order_acknowledgment_return_bitfield_21_reserved_128
        type: b1
  cross_order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: auction_id
        type: u8
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: number_of_return_bitf
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: cross_order_acknowledgment_return_bitfield_19
        type: cross_order_acknowledgment_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet CrossOrderAcknowledgment byte 19'
      - id: num_cross_order_acknowledgment_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: cross_order_acknowledgment_order_allocations
        type: cross_order_acknowledgment_order_allocations
        repeat: expr
        repeat-expr: num_cross_order_acknowledgment_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_acknowledgment_return_bitfield_1.cross_order_acknowledgment_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and cross_order_acknowledgment_return_bitfield_1.cross_order_acknowledgment_return_bitfield_1_exec_inst
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and cross_order_acknowledgment_return_bitfield_4.cross_order_acknowledgment_return_bitfield_4_symbol
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 5 and cross_order_acknowledgment_return_bitfield_5.cross_order_acknowledgment_return_bitfield_5_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and cross_order_acknowledgment_return_bitfield_5.cross_order_acknowledgment_return_bitfield_5_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 6 and cross_order_acknowledgment_return_bitfield_6.cross_order_acknowledgment_return_bitfield_6_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and cross_order_acknowledgment_return_bitfield_6.cross_order_acknowledgment_return_bitfield_6_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 6 and cross_order_acknowledgment_return_bitfield_6.cross_order_acknowledgment_return_bitfield_6_put_or_call
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 8 and cross_order_acknowledgment_return_bitfield_8.cross_order_acknowledgment_return_bitfield_8_attributed_quote
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_target_party_id
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 10 and cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 10 and cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_routing_firm_id
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and cross_order_acknowledgment_return_bitfield_13.cross_order_acknowledgment_return_bitfield_13_clearing_optional_data
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and cross_order_acknowledgment_return_bitfield_15.cross_order_acknowledgment_return_bitfield_15_equity_party_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and cross_order_acknowledgment_return_bitfield_15.cross_order_acknowledgment_return_bitfield_15_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and cross_order_acknowledgment_return_bitfield_16.cross_order_acknowledgment_return_bitfield_16_frequent_trader_id
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 16 and cross_order_acknowledgment_return_bitfield_16.cross_order_acknowledgment_return_bitfield_16_compression
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and cross_order_acknowledgment_return_bitfield_18.cross_order_acknowledgment_return_bitfield_18_cross_initiator
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 19 and cross_order_acknowledgment_return_bitfield_19.cross_order_acknowledgment_return_bitfield_19_cross_on_behalf_of_id
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
      - id: cross_order_acknowledgment_return_bitfield_1_reserved_128
        type: b1
  cross_order_acknowledgment_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_2_sub_liquidity_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_trade_report_type_return
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_trade_publish_ind_return
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_text
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_bid
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_offer
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_large_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_2_last_mkt
        type: b1
  cross_order_acknowledgment_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_3_cum_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_day_order_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_day_cum_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_avg_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_day_avg_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_pending_status
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_drill_thru_protection
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_3_multileg_reporting_type
        type: b1
  cross_order_acknowledgment_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_4_symbol
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_symbol_sfx
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_currency
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_id_source
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_security_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_security_exchange
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_capacity
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_4_contra_trader
        type: b1
  cross_order_acknowledgment_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_5_account
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_clearing_firm
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_clearing_account
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_display_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_max_floor
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_discretion_amount
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_order_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_5_prevent_match
        type: b1
  cross_order_acknowledgment_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_6_maturity_date
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_strike_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_put_or_call
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_open_close
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_cl_ord_id_batch
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_corrected_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_party_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_6_access_fee
        type: b1
  cross_order_acknowledgment_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_7_orig_cl_ord_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_leaves_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_last_shares
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_last_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_display_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_working_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_base_liquidity_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_7_expire_time
        type: b1
  cross_order_acknowledgment_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_8_secondary_order_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_ccp
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_contra_capacity
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_attributed_quote
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_ext_exec_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_bulk_order_ids
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_bulk_reject_reasons
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_8_party_role
        type: b1
  cross_order_acknowledgment_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_9_fee_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_echo_text
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_stop_px
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_routing_inst
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_rout_strategy
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_route_delivery_method
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_ex_destination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_9_trade_report_ref_id
        type: b1
  cross_order_acknowledgment_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_10_marketing_fee_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_target_party_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_auction_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_order_category
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_liquidity_provision
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_cmta_number
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_cross_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_10_cross_prioritization
        type: b1
  cross_order_acknowledgment_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_11_cross_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_alloc_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_give_up_firm_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_routing_firm_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_waiver_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_cross_exclusion_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_price_formation
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_11_client_qualified_role
        type: b1
  cross_order_acknowledgment_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_12_client_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_investor_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_executor_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_order_origination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_algo
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_deferral_reason
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_investor_qualified_role
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_12_executor_qualified_role
        type: b1
  cross_order_acknowledgment_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_13_cti_code
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_manual_order_indicator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_operator_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_trade_date
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_clearing_price
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_clearing_size
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_clearing_symbol
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_13_clearing_optional_data
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
      - id: cross_order_acknowledgment_return_bitfield_14_room_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_user_request_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_sis_username
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_14_user_status
        type: b1
  cross_order_acknowledgment_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_15_trade_reporting_indicato
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
      - id: cross_order_acknowledgment_return_bitfield_16_multi_class_sprd
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
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_1
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_cross_initiator
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_subreason
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_cross_trade_flag
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_16
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_held
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_locate_broker
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_18_reserved_128
        type: b1
  cross_order_acknowledgment_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_acknowledgment_return_bitfield_19_floor_trade_time
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_equity_ex_destination
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_cross_on_behalf_of_id
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_cmc_sessions
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_cmc_match_qty
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_stop_px_type
        type: b1
      - id: cross_order_acknowledgment_return_bitfield_19_reserved_128
        type: b1
  cross_order_acknowledgment_order_allocations:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: side
        type: u1
        enum: side
        if: _parent.number_of_return_bitfields >= 1 and _parent.cross_order_acknowledgment_return_bitfield_1.cross_order_acknowledgment_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: alloc_qty
        type: u4
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_alloc_qty
      - id: capacity
        type: u1
        enum: capacity
        if: _parent.number_of_return_bitfields >= 4 and _parent.cross_order_acknowledgment_return_bitfield_4.cross_order_acknowledgment_return_bitfield_4_capacity
      - id: open_close
        type: u1
        enum: open_close
        if: _parent.number_of_return_bitfields >= 6 and _parent.cross_order_acknowledgment_return_bitfield_6.cross_order_acknowledgment_return_bitfield_6_open_close
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 11 and _parent.cross_order_acknowledgment_return_bitfield_11.cross_order_acknowledgment_return_bitfield_11_give_up_firm_id
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 5 and _parent.cross_order_acknowledgment_return_bitfield_5.cross_order_acknowledgment_return_bitfield_5_account
      - id: cmta_number
        type: u4
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_acknowledgment_return_bitfield_10.cross_order_acknowledgment_return_bitfield_10_cmta_number
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 5 and _parent.cross_order_acknowledgment_return_bitfield_5.cross_order_acknowledgment_return_bitfield_5_clearing_account
  quote_update_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
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
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result of the quote request. Acceptance: A = New Quote I = IOC Quote Accepted L = Modified; loss of priority R = Modified; retains priority (size reduction) N = No change, matches existing quote D = New Quote, but may remove liquidity d = Modified, but may remove liquidity V = No change, existing constituent series quote modify attempt after cutoff time (C1 only) Cancellation: U = User cancelled (zero size/price requested) Rejection: a = Admin O = Rejected, doesn’t match a known quote P = Rejected, can’t post f = Risk management firm or Custom Group ID level S = Rejected, symbol not found p = Rejected, invalid price r = Invalid Remove s = Risk management risk root level u = Rejected, other reason + = Risk management EFID Group level c = Rejected, closing only series v = Rejected, attempt to add constituent series quote after cutoff time (C1 only) Additional reasons indicating a reject may be added in the future with no notice'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: subreason
        type: u1
        enum: subreason
      - id: reserved_5
        size: 5
        doc: 'Reserved for future expansion. Filled with 0'
  order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_rejected_return_bitfield_1.order_rejected_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_rejected_return_bitfield_2.order_rejected_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_rejected_return_bitfield_3.order_rejected_return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and order_rejected_return_bitfield_4.order_rejected_return_bitfield_4_corrected_size
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 6 and order_rejected_return_bitfield_6.order_rejected_return_bitfield_6_ex_destination
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_rejected_return_bitfield_7.order_rejected_return_bitfield_7_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_rejected_return_bitfield_7.order_rejected_return_bitfield_7_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 7 and order_rejected_return_bitfield_7.order_rejected_return_bitfield_7_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 7 and order_rejected_return_bitfield_7.order_rejected_return_bitfield_7_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 8 and order_rejected_return_bitfield_8.order_rejected_return_bitfield_8_cross_exclusion_indicator
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_equity_party_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_rejected_return_bitfield_11.order_rejected_return_bitfield_11_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_frequent_trader_id
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_session_eligibility
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 12 and order_rejected_return_bitfield_12.order_rejected_return_bitfield_12_multi_class_sprd
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 14 and order_rejected_return_bitfield_14.order_rejected_return_bitfield_14_secondary_order_id
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_rejected_return_bitfield_14.order_rejected_return_bitfield_14_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 14 and order_rejected_return_bitfield_14.order_rejected_return_bitfield_14_attributed_quote
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and order_rejected_return_bitfield_17.order_rejected_return_bitfield_17_clearing_optional_data
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_rejected_return_bitfield_18.order_rejected_return_bitfield_18_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 19 and order_rejected_return_bitfield_19.order_rejected_return_bitfield_19_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 19 and order_rejected_return_bitfield_19.order_rejected_return_bitfield_19_strategy_id
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 20 and order_rejected_return_bitfield_20.order_rejected_return_bitfield_20_cross_initiator
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 20 and order_rejected_return_bitfield_20.order_rejected_return_bitfield_20_subreason
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 20 and order_rejected_return_bitfield_20.order_rejected_return_bitfield_20_held
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_rejected_return_bitfield_21.order_rejected_return_bitfield_21_cross_on_behalf_of_id
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
      - id: order_rejected_return_bitfield_1_ord_type
        type: b1
      - id: order_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: order_rejected_return_bitfield_1_min_qty
        type: b1
      - id: order_rejected_return_bitfield_1_reserved_128
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
      - id: order_rejected_return_bitfield_2_contra_trader
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
      - id: order_rejected_return_bitfield_4_reserved_128
        type: b1
  order_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_5_trade_report_type_return
        type: b1
      - id: order_rejected_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: order_rejected_return_bitfield_5_text
        type: b1
      - id: order_rejected_return_bitfield_5_bid
        type: b1
      - id: order_rejected_return_bitfield_5_offer
        type: b1
      - id: order_rejected_return_bitfield_5_large_size
        type: b1
      - id: order_rejected_return_bitfield_5_last_mkt
        type: b1
  order_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_6_fee_code
        type: b1
      - id: order_rejected_return_bitfield_6_echo_text
        type: b1
      - id: order_rejected_return_bitfield_6_stop_px
        type: b1
      - id: order_rejected_return_bitfield_6_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_6_rout_strategy
        type: b1
      - id: order_rejected_return_bitfield_6_route_delivery_method
        type: b1
      - id: order_rejected_return_bitfield_6_ex_destination
        type: b1
      - id: order_rejected_return_bitfield_6_trade_report_ref_id
        type: b1
  order_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_7_marketing_fee_code
        type: b1
      - id: order_rejected_return_bitfield_7_target_party_id
        type: b1
      - id: order_rejected_return_bitfield_7_auction_id
        type: b1
      - id: order_rejected_return_bitfield_7_order_category
        type: b1
      - id: order_rejected_return_bitfield_7_liquidity_provision
        type: b1
      - id: order_rejected_return_bitfield_7_cmta_number
        type: b1
      - id: order_rejected_return_bitfield_7_cross_type
        type: b1
      - id: order_rejected_return_bitfield_7_cross_prioritization
        type: b1
  order_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_8_cross_id
        type: b1
      - id: order_rejected_return_bitfield_8_alloc_qty
        type: b1
      - id: order_rejected_return_bitfield_8_give_up_firm_id
        type: b1
      - id: order_rejected_return_bitfield_8_routing_firm_id
        type: b1
      - id: order_rejected_return_bitfield_8_waiver_type
        type: b1
      - id: order_rejected_return_bitfield_8_cross_exclusion_indicator
        type: b1
      - id: order_rejected_return_bitfield_8_price_formation
        type: b1
      - id: order_rejected_return_bitfield_8_reserved_128
        type: b1
  order_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_9_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_9_day_order_qty
        type: b1
      - id: order_rejected_return_bitfield_9_day_cum_qty
        type: b1
      - id: order_rejected_return_bitfield_9_avg_px
        type: b1
      - id: order_rejected_return_bitfield_9_day_avg_px
        type: b1
      - id: order_rejected_return_bitfield_9_pending_status
        type: b1
      - id: order_rejected_return_bitfield_9_drill_thru_protection
        type: b1
      - id: order_rejected_return_bitfield_9_multileg_reporting_type
        type: b1
  order_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_10_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_10_leg_maturity_date
        type: b1
      - id: order_rejected_return_bitfield_10_leg_strike_price
        type: b1
      - id: order_rejected_return_bitfield_10_room_id
        type: b1
      - id: order_rejected_return_bitfield_10_secondary_exec_id
        type: b1
      - id: order_rejected_return_bitfield_10_user_request_id
        type: b1
      - id: order_rejected_return_bitfield_10_sis_username
        type: b1
      - id: order_rejected_return_bitfield_10_user_status
        type: b1
  order_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_11_trade_reporting_indicato
        type: b1
      - id: order_rejected_return_bitfield_11_equity_party_id
        type: b1
      - id: order_rejected_return_bitfield_11_equity_nbbo_protect
        type: b1
      - id: order_rejected_return_bitfield_11_mass_cancel_id
        type: b1
      - id: order_rejected_return_bitfield_11_trade_publish_ind
        type: b1
      - id: order_rejected_return_bitfield_11_report_time
        type: b1
      - id: order_rejected_return_bitfield_11_leg_symbol_sfx
        type: b1
      - id: order_rejected_return_bitfield_11_client_id_attr
        type: b1
  order_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_12_frequent_trader_id
        type: b1
      - id: order_rejected_return_bitfield_12_session_eligibility
        type: b1
      - id: order_rejected_return_bitfield_12_combo_order
        type: b1
      - id: order_rejected_return_bitfield_12_compression
        type: b1
      - id: order_rejected_return_bitfield_12_floor_destination
        type: b1
      - id: order_rejected_return_bitfield_12_floor_routing_inst
        type: b1
      - id: order_rejected_return_bitfield_12_multi_class_sprd
        type: b1
      - id: order_rejected_return_bitfield_12_access_fee
        type: b1
  order_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_13_orig_cl_ord_id
        type: b1
      - id: order_rejected_return_bitfield_13_leaves_qty
        type: b1
      - id: order_rejected_return_bitfield_13_last_shares
        type: b1
      - id: order_rejected_return_bitfield_13_last_px
        type: b1
      - id: order_rejected_return_bitfield_13_display_price
        type: b1
      - id: order_rejected_return_bitfield_13_working_price
        type: b1
      - id: order_rejected_return_bitfield_13_base_liquidity_indicator
        type: b1
      - id: order_rejected_return_bitfield_13_expire_time
        type: b1
  order_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_14_secondary_order_id
        type: b1
      - id: order_rejected_return_bitfield_14_ccp
        type: b1
      - id: order_rejected_return_bitfield_14_contra_capacity
        type: b1
      - id: order_rejected_return_bitfield_14_attributed_quote
        type: b1
      - id: order_rejected_return_bitfield_14_ext_exec_inst
        type: b1
      - id: order_rejected_return_bitfield_14_bulk_order_ids
        type: b1
      - id: order_rejected_return_bitfield_14_bulk_reject_reasons
        type: b1
      - id: order_rejected_return_bitfield_14_party_role
        type: b1
  order_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_15_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_2
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_4
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_15_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_15_client_qualified_role
        type: b1
  order_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_16_client_id
        type: b1
      - id: order_rejected_return_bitfield_16_investor_id
        type: b1
      - id: order_rejected_return_bitfield_16_executor_id
        type: b1
      - id: order_rejected_return_bitfield_16_order_origination
        type: b1
      - id: order_rejected_return_bitfield_16_algo
        type: b1
      - id: order_rejected_return_bitfield_16_deferral_reason
        type: b1
      - id: order_rejected_return_bitfield_16_investor_qualified_role
        type: b1
      - id: order_rejected_return_bitfield_16_executor_qualified_role
        type: b1
  order_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_17_cti_code
        type: b1
      - id: order_rejected_return_bitfield_17_manual_order_indicator
        type: b1
      - id: order_rejected_return_bitfield_17_operator_id
        type: b1
      - id: order_rejected_return_bitfield_17_trade_date
        type: b1
      - id: order_rejected_return_bitfield_17_clearing_price
        type: b1
      - id: order_rejected_return_bitfield_17_clearing_size
        type: b1
      - id: order_rejected_return_bitfield_17_clearing_symbol
        type: b1
      - id: order_rejected_return_bitfield_17_clearing_optional_data
        type: b1
  order_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_18_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_2
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_4
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_8
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_32
        type: b1
      - id: order_rejected_return_bitfield_18_reserved_64
        type: b1
      - id: order_rejected_return_bitfield_18_order_origin
        type: b1
  order_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_19_price_type
        type: b1
      - id: order_rejected_return_bitfield_19_strategy_id
        type: b1
      - id: order_rejected_return_bitfield_19_trading_session_id
        type: b1
      - id: order_rejected_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: order_rejected_return_bitfield_19_sender_location_id
        type: b1
      - id: order_rejected_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: order_rejected_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: order_rejected_return_bitfield_19_cust_order_handling_inst
        type: b1
  order_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: order_rejected_return_bitfield_20_cross_initiator
        type: b1
      - id: order_rejected_return_bitfield_20_subreason
        type: b1
      - id: order_rejected_return_bitfield_20_cross_trade_flag
        type: b1
      - id: order_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: order_rejected_return_bitfield_20_held
        type: b1
      - id: order_rejected_return_bitfield_20_locate_broker
        type: b1
      - id: order_rejected_return_bitfield_20_reserved_128
        type: b1
  order_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_rejected_return_bitfield_21_floor_trade_time
        type: b1
      - id: order_rejected_return_bitfield_21_equity_ex_destination
        type: b1
      - id: order_rejected_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: order_rejected_return_bitfield_21_cmc_sessions
        type: b1
      - id: order_rejected_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: order_rejected_return_bitfield_21_cmc_match_qty
        type: b1
      - id: order_rejected_return_bitfield_21_stop_px_type
        type: b1
      - id: order_rejected_return_bitfield_21_reserved_128
        type: b1
  cross_order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: cross_order_rejected_return_bitfield_19
        type: cross_order_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet CrossOrderRejected byte 19'
      - id: cross_order_rejected_return_bitfield_20
        type: cross_order_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet CrossOrderRejected byte 20'
      - id: cross_order_rejected_return_bitfield_21
        type: cross_order_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet CrossOrderRejected byte 21'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_rejected_return_bitfield_1.cross_order_rejected_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and cross_order_rejected_return_bitfield_1.cross_order_rejected_return_bitfield_1_exec_inst
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_rejected_return_bitfield_2.cross_order_rejected_return_bitfield_2_symbol
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 7 and cross_order_rejected_return_bitfield_7.cross_order_rejected_return_bitfield_7_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and cross_order_rejected_return_bitfield_7.cross_order_rejected_return_bitfield_7_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 8 and cross_order_rejected_return_bitfield_8.cross_order_rejected_return_bitfield_8_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and cross_order_rejected_return_bitfield_8.cross_order_rejected_return_bitfield_8_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 8 and cross_order_rejected_return_bitfield_8.cross_order_rejected_return_bitfield_8_put_or_call
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 10 and cross_order_rejected_return_bitfield_10.cross_order_rejected_return_bitfield_10_attributed_quote
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and cross_order_rejected_return_bitfield_12.cross_order_rejected_return_bitfield_12_target_party_id
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 12 and cross_order_rejected_return_bitfield_12.cross_order_rejected_return_bitfield_12_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 12 and cross_order_rejected_return_bitfield_12.cross_order_rejected_return_bitfield_12_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and cross_order_rejected_return_bitfield_13.cross_order_rejected_return_bitfield_13_routing_firm_id
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and cross_order_rejected_return_bitfield_17.cross_order_rejected_return_bitfield_17_equity_party_id
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and cross_order_rejected_return_bitfield_18.cross_order_rejected_return_bitfield_18_frequent_trader_id
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 18 and cross_order_rejected_return_bitfield_18.cross_order_rejected_return_bitfield_18_compression
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 20 and cross_order_rejected_return_bitfield_20.cross_order_rejected_return_bitfield_20_cross_initiator
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 20 and cross_order_rejected_return_bitfield_20.cross_order_rejected_return_bitfield_20_subreason
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and cross_order_rejected_return_bitfield_21.cross_order_rejected_return_bitfield_21_cross_on_behalf_of_id
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
      - id: cross_order_rejected_return_bitfield_1_reserved_128
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
      - id: cross_order_rejected_return_bitfield_2_reserved_16
        type: b1
      - id: cross_order_rejected_return_bitfield_2_reserved_32
        type: b1
      - id: cross_order_rejected_return_bitfield_2_reserved_64
        type: b1
      - id: cross_order_rejected_return_bitfield_2_reserved_128
        type: b1
  cross_order_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_3_sub_liquidity_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_3_trade_report_type_return
        type: b1
      - id: cross_order_rejected_return_bitfield_3_trade_publish_ind_return
        type: b1
      - id: cross_order_rejected_return_bitfield_3_text
        type: b1
      - id: cross_order_rejected_return_bitfield_3_bid
        type: b1
      - id: cross_order_rejected_return_bitfield_3_offer
        type: b1
      - id: cross_order_rejected_return_bitfield_3_large_size
        type: b1
      - id: cross_order_rejected_return_bitfield_3_last_mkt
        type: b1
  cross_order_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_4_fee_code
        type: b1
      - id: cross_order_rejected_return_bitfield_4_echo_text
        type: b1
      - id: cross_order_rejected_return_bitfield_4_stop_px
        type: b1
      - id: cross_order_rejected_return_bitfield_4_routing_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_4_reserved_16
        type: b1
      - id: cross_order_rejected_return_bitfield_4_reserved_32
        type: b1
      - id: cross_order_rejected_return_bitfield_4_reserved_64
        type: b1
      - id: cross_order_rejected_return_bitfield_4_reserved_128
        type: b1
  cross_order_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_5_cum_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_5_day_order_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_5_day_cum_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_5_avg_px
        type: b1
      - id: cross_order_rejected_return_bitfield_5_day_avg_px
        type: b1
      - id: cross_order_rejected_return_bitfield_5_pending_status
        type: b1
      - id: cross_order_rejected_return_bitfield_5_drill_thru_protection
        type: b1
      - id: cross_order_rejected_return_bitfield_5_multileg_reporting_type
        type: b1
  cross_order_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_6_leg_cfi_code
        type: b1
      - id: cross_order_rejected_return_bitfield_6_leg_maturity_date
        type: b1
      - id: cross_order_rejected_return_bitfield_6_leg_strike_price
        type: b1
      - id: cross_order_rejected_return_bitfield_6_room_id
        type: b1
      - id: cross_order_rejected_return_bitfield_6_security_id
        type: b1
      - id: cross_order_rejected_return_bitfield_6_security_exchange
        type: b1
      - id: cross_order_rejected_return_bitfield_6_capacity
        type: b1
      - id: cross_order_rejected_return_bitfield_6_contra_trader
        type: b1
  cross_order_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_7_account
        type: b1
      - id: cross_order_rejected_return_bitfield_7_clearing_firm
        type: b1
      - id: cross_order_rejected_return_bitfield_7_clearing_account
        type: b1
      - id: cross_order_rejected_return_bitfield_7_display_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_7_max_floor
        type: b1
      - id: cross_order_rejected_return_bitfield_7_discretion_amount
        type: b1
      - id: cross_order_rejected_return_bitfield_7_order_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_7_prevent_match
        type: b1
  cross_order_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_8_maturity_date
        type: b1
      - id: cross_order_rejected_return_bitfield_8_strike_price
        type: b1
      - id: cross_order_rejected_return_bitfield_8_put_or_call
        type: b1
      - id: cross_order_rejected_return_bitfield_8_open_close
        type: b1
      - id: cross_order_rejected_return_bitfield_8_cl_ord_id_batch
        type: b1
      - id: cross_order_rejected_return_bitfield_8_corrected_size
        type: b1
      - id: cross_order_rejected_return_bitfield_8_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_8_access_fee
        type: b1
  cross_order_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_9_orig_cl_ord_id
        type: b1
      - id: cross_order_rejected_return_bitfield_9_leaves_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_9_last_shares
        type: b1
      - id: cross_order_rejected_return_bitfield_9_last_px
        type: b1
      - id: cross_order_rejected_return_bitfield_9_display_price
        type: b1
      - id: cross_order_rejected_return_bitfield_9_working_price
        type: b1
      - id: cross_order_rejected_return_bitfield_9_base_liquidity_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_9_expire_time
        type: b1
  cross_order_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_10_secondary_order_id
        type: b1
      - id: cross_order_rejected_return_bitfield_10_ccp
        type: b1
      - id: cross_order_rejected_return_bitfield_10_contra_capacity
        type: b1
      - id: cross_order_rejected_return_bitfield_10_attributed_quote
        type: b1
      - id: cross_order_rejected_return_bitfield_10_ext_exec_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_10_bulk_order_ids
        type: b1
      - id: cross_order_rejected_return_bitfield_10_bulk_reject_reasons
        type: b1
      - id: cross_order_rejected_return_bitfield_10_party_role
        type: b1
  cross_order_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_11_reserved_1
        type: b1
      - id: cross_order_rejected_return_bitfield_11_reserved_2
        type: b1
      - id: cross_order_rejected_return_bitfield_11_reserved_4
        type: b1
      - id: cross_order_rejected_return_bitfield_11_reserved_8
        type: b1
      - id: cross_order_rejected_return_bitfield_11_rout_strategy
        type: b1
      - id: cross_order_rejected_return_bitfield_11_route_delivery_method
        type: b1
      - id: cross_order_rejected_return_bitfield_11_ex_destination
        type: b1
      - id: cross_order_rejected_return_bitfield_11_trade_report_ref_id
        type: b1
  cross_order_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_12_marketing_fee_code
        type: b1
      - id: cross_order_rejected_return_bitfield_12_target_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_12_auction_id
        type: b1
      - id: cross_order_rejected_return_bitfield_12_order_category
        type: b1
      - id: cross_order_rejected_return_bitfield_12_liquidity_provision
        type: b1
      - id: cross_order_rejected_return_bitfield_12_cmta_number
        type: b1
      - id: cross_order_rejected_return_bitfield_12_cross_type
        type: b1
      - id: cross_order_rejected_return_bitfield_12_cross_prioritization
        type: b1
  cross_order_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_13_cross_id
        type: b1
      - id: cross_order_rejected_return_bitfield_13_alloc_qty
        type: b1
      - id: cross_order_rejected_return_bitfield_13_give_up_firm_id
        type: b1
      - id: cross_order_rejected_return_bitfield_13_routing_firm_id
        type: b1
      - id: cross_order_rejected_return_bitfield_13_waiver_type
        type: b1
      - id: cross_order_rejected_return_bitfield_13_cross_exclusion_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_13_price_formation
        type: b1
      - id: cross_order_rejected_return_bitfield_13_client_qualified_role
        type: b1
  cross_order_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_14_client_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_investor_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_executor_id
        type: b1
      - id: cross_order_rejected_return_bitfield_14_order_origination
        type: b1
      - id: cross_order_rejected_return_bitfield_14_algo
        type: b1
      - id: cross_order_rejected_return_bitfield_14_deferral_reason
        type: b1
      - id: cross_order_rejected_return_bitfield_14_investor_qualified_role
        type: b1
      - id: cross_order_rejected_return_bitfield_14_executor_qualified_role
        type: b1
  cross_order_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_15_cti_code
        type: b1
      - id: cross_order_rejected_return_bitfield_15_manual_order_indicator
        type: b1
      - id: cross_order_rejected_return_bitfield_15_operator_id
        type: b1
      - id: cross_order_rejected_return_bitfield_15_trade_date
        type: b1
      - id: cross_order_rejected_return_bitfield_15_clearing_price
        type: b1
      - id: cross_order_rejected_return_bitfield_15_clearing_size
        type: b1
      - id: cross_order_rejected_return_bitfield_15_clearing_symbol
        type: b1
      - id: cross_order_rejected_return_bitfield_15_clearing_optional_data
        type: b1
  cross_order_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_16_reserved_1
        type: b1
      - id: cross_order_rejected_return_bitfield_16_reserved_2
        type: b1
      - id: cross_order_rejected_return_bitfield_16_reserved_4
        type: b1
      - id: cross_order_rejected_return_bitfield_16_reserved_8
        type: b1
      - id: cross_order_rejected_return_bitfield_16_secondary_exec_id
        type: b1
      - id: cross_order_rejected_return_bitfield_16_user_request_id
        type: b1
      - id: cross_order_rejected_return_bitfield_16_sis_username
        type: b1
      - id: cross_order_rejected_return_bitfield_16_user_status
        type: b1
  cross_order_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_17_trade_reporting_indicato
        type: b1
      - id: cross_order_rejected_return_bitfield_17_equity_party_id
        type: b1
      - id: cross_order_rejected_return_bitfield_17_equity_nbbo_protect
        type: b1
      - id: cross_order_rejected_return_bitfield_17_mass_cancel_id
        type: b1
      - id: cross_order_rejected_return_bitfield_17_trade_publish_ind
        type: b1
      - id: cross_order_rejected_return_bitfield_17_report_time
        type: b1
      - id: cross_order_rejected_return_bitfield_17_leg_symbol_sfx
        type: b1
      - id: cross_order_rejected_return_bitfield_17_client_id_attr
        type: b1
  cross_order_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_18_frequent_trader_id
        type: b1
      - id: cross_order_rejected_return_bitfield_18_session_eligibility
        type: b1
      - id: cross_order_rejected_return_bitfield_18_combo_order
        type: b1
      - id: cross_order_rejected_return_bitfield_18_compression
        type: b1
      - id: cross_order_rejected_return_bitfield_18_floor_destination
        type: b1
      - id: cross_order_rejected_return_bitfield_18_floor_routing_inst
        type: b1
      - id: cross_order_rejected_return_bitfield_18_multi_class_sprd
        type: b1
      - id: cross_order_rejected_return_bitfield_18_order_origin
        type: b1
  cross_order_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_19_price_type
        type: b1
      - id: cross_order_rejected_return_bitfield_19_strategy_id
        type: b1
      - id: cross_order_rejected_return_bitfield_19_trading_session_id
        type: b1
      - id: cross_order_rejected_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: cross_order_rejected_return_bitfield_19_sender_location_id
        type: b1
      - id: cross_order_rejected_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: cross_order_rejected_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: cross_order_rejected_return_bitfield_19_cust_order_handling_inst
        type: b1
  cross_order_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: cross_order_rejected_return_bitfield_20_cross_initiator
        type: b1
      - id: cross_order_rejected_return_bitfield_20_subreason
        type: b1
      - id: cross_order_rejected_return_bitfield_20_cross_trade_flag
        type: b1
      - id: cross_order_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: cross_order_rejected_return_bitfield_20_held
        type: b1
      - id: cross_order_rejected_return_bitfield_20_locate_broker
        type: b1
      - id: cross_order_rejected_return_bitfield_20_reserved_128
        type: b1
  cross_order_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_rejected_return_bitfield_21_floor_trade_time
        type: b1
      - id: cross_order_rejected_return_bitfield_21_equity_ex_destination
        type: b1
      - id: cross_order_rejected_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: cross_order_rejected_return_bitfield_21_cmc_sessions
        type: b1
      - id: cross_order_rejected_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: cross_order_rejected_return_bitfield_21_cmc_match_qty
        type: b1
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
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
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_modified_return_bitfield_1.order_modified_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_modified_return_bitfield_2.order_modified_return_bitfield_2_symbol
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_modified_return_bitfield_3.order_modified_return_bitfield_3_prevent_match
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and order_modified_return_bitfield_5.order_modified_return_bitfield_5_last_shares
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 7 and order_modified_return_bitfield_7.order_modified_return_bitfield_7_ex_destination
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_modified_return_bitfield_8.order_modified_return_bitfield_8_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_modified_return_bitfield_8.order_modified_return_bitfield_8_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 8 and order_modified_return_bitfield_8.order_modified_return_bitfield_8_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 8 and order_modified_return_bitfield_8.order_modified_return_bitfield_8_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 9 and order_modified_return_bitfield_9.order_modified_return_bitfield_9_cross_exclusion_indicator
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_frequent_trader_id
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_modified_return_bitfield_14.order_modified_return_bitfield_14_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_strategy_id
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 15 and order_modified_return_bitfield_15.order_modified_return_bitfield_15_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 16 and order_modified_return_bitfield_16.order_modified_return_bitfield_16_secondary_order_id
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_modified_return_bitfield_16.order_modified_return_bitfield_16_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 16 and order_modified_return_bitfield_16.order_modified_return_bitfield_16_attributed_quote
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 20 and order_modified_return_bitfield_20.order_modified_return_bitfield_20_held
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
      - id: order_modified_return_bitfield_1_ord_type
        type: b1
      - id: order_modified_return_bitfield_1_time_in_force
        type: b1
      - id: order_modified_return_bitfield_1_min_qty
        type: b1
      - id: order_modified_return_bitfield_1_reserved_128
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
      - id: order_modified_return_bitfield_2_contra_trader
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
      - id: order_modified_return_bitfield_5_reserved_8
        type: b1
      - id: order_modified_return_bitfield_5_reserved_16
        type: b1
      - id: order_modified_return_bitfield_5_reserved_32
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
      - id: order_modified_return_bitfield_9_price_formation
        type: b1
      - id: order_modified_return_bitfield_9_client_qualified_role
        type: b1
  order_modified_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_10_client_id
        type: b1
      - id: order_modified_return_bitfield_10_investor_id
        type: b1
      - id: order_modified_return_bitfield_10_executor_id
        type: b1
      - id: order_modified_return_bitfield_10_reserved_8
        type: b1
      - id: order_modified_return_bitfield_10_reserved_16
        type: b1
      - id: order_modified_return_bitfield_10_reserved_32
        type: b1
      - id: order_modified_return_bitfield_10_reserved_64
        type: b1
      - id: order_modified_return_bitfield_10_reserved_128
        type: b1
  order_modified_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_11_cum_qty
        type: b1
      - id: order_modified_return_bitfield_11_day_order_qty
        type: b1
      - id: order_modified_return_bitfield_11_day_cum_qty
        type: b1
      - id: order_modified_return_bitfield_11_avg_px
        type: b1
      - id: order_modified_return_bitfield_11_day_avg_px
        type: b1
      - id: order_modified_return_bitfield_11_pending_status
        type: b1
      - id: order_modified_return_bitfield_11_drill_thru_protection
        type: b1
      - id: order_modified_return_bitfield_11_multileg_reporting_type
        type: b1
  order_modified_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_12_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_12_leg_maturity_date
        type: b1
      - id: order_modified_return_bitfield_12_leg_strike_price
        type: b1
      - id: order_modified_return_bitfield_12_room_id
        type: b1
      - id: order_modified_return_bitfield_12_secondary_exec_id
        type: b1
      - id: order_modified_return_bitfield_12_user_request_id
        type: b1
      - id: order_modified_return_bitfield_12_sis_username
        type: b1
      - id: order_modified_return_bitfield_12_user_status
        type: b1
  order_modified_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_13_trade_reporting_indicato
        type: b1
      - id: order_modified_return_bitfield_13_equity_party_id
        type: b1
      - id: order_modified_return_bitfield_13_equity_nbbo_protect
        type: b1
      - id: order_modified_return_bitfield_13_mass_cancel_id
        type: b1
      - id: order_modified_return_bitfield_13_trade_publish_ind
        type: b1
      - id: order_modified_return_bitfield_13_report_time
        type: b1
      - id: order_modified_return_bitfield_13_leg_symbol_sfx
        type: b1
      - id: order_modified_return_bitfield_13_client_id_attr
        type: b1
  order_modified_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_14_frequent_trader_id
        type: b1
      - id: order_modified_return_bitfield_14_session_eligibility
        type: b1
      - id: order_modified_return_bitfield_14_combo_order
        type: b1
      - id: order_modified_return_bitfield_14_compression
        type: b1
      - id: order_modified_return_bitfield_14_floor_destination
        type: b1
      - id: order_modified_return_bitfield_14_floor_routing_inst
        type: b1
      - id: order_modified_return_bitfield_14_multi_class_sprd
        type: b1
      - id: order_modified_return_bitfield_14_order_origin
        type: b1
  order_modified_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_15_price_type
        type: b1
      - id: order_modified_return_bitfield_15_strategy_id
        type: b1
      - id: order_modified_return_bitfield_15_trading_session_id
        type: b1
      - id: order_modified_return_bitfield_15_last_px
        type: b1
      - id: order_modified_return_bitfield_15_display_price
        type: b1
      - id: order_modified_return_bitfield_15_working_price
        type: b1
      - id: order_modified_return_bitfield_15_base_liquidity_indicator
        type: b1
      - id: order_modified_return_bitfield_15_expire_time
        type: b1
  order_modified_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_16_secondary_order_id
        type: b1
      - id: order_modified_return_bitfield_16_ccp
        type: b1
      - id: order_modified_return_bitfield_16_contra_capacity
        type: b1
      - id: order_modified_return_bitfield_16_attributed_quote
        type: b1
      - id: order_modified_return_bitfield_16_ext_exec_inst
        type: b1
      - id: order_modified_return_bitfield_16_bulk_order_ids
        type: b1
      - id: order_modified_return_bitfield_16_bulk_reject_reasons
        type: b1
      - id: order_modified_return_bitfield_16_party_role
        type: b1
  order_modified_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_17_reserved_1
        type: b1
      - id: order_modified_return_bitfield_17_reserved_2
        type: b1
      - id: order_modified_return_bitfield_17_reserved_4
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
      - id: order_modified_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: order_modified_return_bitfield_19_sender_location_id
        type: b1
      - id: order_modified_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: order_modified_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: order_modified_return_bitfield_19_cust_order_handling_inst
        type: b1
  order_modified_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_20_reserved_1
        type: b1
      - id: order_modified_return_bitfield_20_cross_initiator
        type: b1
      - id: order_modified_return_bitfield_20_subreason
        type: b1
      - id: order_modified_return_bitfield_20_cross_trade_flag
        type: b1
      - id: order_modified_return_bitfield_20_reserved_16
        type: b1
      - id: order_modified_return_bitfield_20_held
        type: b1
      - id: order_modified_return_bitfield_20_locate_broker
        type: b1
      - id: order_modified_return_bitfield_20_reserved_128
        type: b1
  order_modified_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_modified_return_bitfield_21_floor_trade_time
        type: b1
      - id: order_modified_return_bitfield_21_equity_ex_destination
        type: b1
      - id: order_modified_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: order_modified_return_bitfield_21_cmc_sessions
        type: b1
      - id: order_modified_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: order_modified_return_bitfield_21_cmc_match_qty
        type: b1
      - id: order_modified_return_bitfield_21_stop_px_type
        type: b1
      - id: order_modified_return_bitfield_21_reserved_128
        type: b1
  order_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. E=Reduction of OrdQty due to Equity Leg Reject (C1 only) F=Represented on Floor(C1 only) L=Reload P=Price Sliding Reprice Q=Liquidity Updated R=Reroute S=Ship and Post (SWP) W=Wash f=Unsolicited Floor Action(C1 only) Cboe reserves the right to add new values as necessary without prior notice'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_restated_return_bitfield_1.order_restated_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_restated_return_bitfield_2.order_restated_return_bitfield_2_capacity
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 4 and order_restated_return_bitfield_4.order_restated_return_bitfield_4_ex_destination
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and order_restated_return_bitfield_7.order_restated_return_bitfield_7_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 8 and order_restated_return_bitfield_8.order_restated_return_bitfield_8_corrected_size
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 9 and order_restated_return_bitfield_9.order_restated_return_bitfield_9_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_secondary_order_id
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 10 and order_restated_return_bitfield_10.order_restated_return_bitfield_10_attributed_quote
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 11 and order_restated_return_bitfield_11.order_restated_return_bitfield_11_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 12 and order_restated_return_bitfield_12.order_restated_return_bitfield_12_cross_exclusion_indicator
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and order_restated_return_bitfield_15.order_restated_return_bitfield_15_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_frequent_trader_id
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_restated_return_bitfield_16.order_restated_return_bitfield_16_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and order_restated_return_bitfield_17.order_restated_return_bitfield_17_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and order_restated_return_bitfield_17.order_restated_return_bitfield_17_strategy_id
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 18 and order_restated_return_bitfield_18.order_restated_return_bitfield_18_held
  order_restated_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_1_side
        type: b1
      - id: order_restated_return_bitfield_1_peg_difference
        type: b1
      - id: order_restated_return_bitfield_1_price
        type: b1
      - id: order_restated_return_bitfield_1_exec_inst
        type: b1
      - id: order_restated_return_bitfield_1_ord_type
        type: b1
      - id: order_restated_return_bitfield_1_time_in_force
        type: b1
      - id: order_restated_return_bitfield_1_min_qty
        type: b1
      - id: order_restated_return_bitfield_1_reserved_128
        type: b1
  order_restated_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_2_symbol
        type: b1
      - id: order_restated_return_bitfield_2_symbol_sfx
        type: b1
      - id: order_restated_return_bitfield_2_currency
        type: b1
      - id: order_restated_return_bitfield_2_id_source
        type: b1
      - id: order_restated_return_bitfield_2_security_id
        type: b1
      - id: order_restated_return_bitfield_2_security_exchange
        type: b1
      - id: order_restated_return_bitfield_2_capacity
        type: b1
      - id: order_restated_return_bitfield_2_contra_trader
        type: b1
  order_restated_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_3_sub_liquidity_indicator
        type: b1
      - id: order_restated_return_bitfield_3_trade_report_type_return
        type: b1
      - id: order_restated_return_bitfield_3_trade_publish_ind_return
        type: b1
      - id: order_restated_return_bitfield_3_text
        type: b1
      - id: order_restated_return_bitfield_3_bid
        type: b1
      - id: order_restated_return_bitfield_3_offer
        type: b1
      - id: order_restated_return_bitfield_3_large_size
        type: b1
      - id: order_restated_return_bitfield_3_last_mkt
        type: b1
  order_restated_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_4_fee_code
        type: b1
      - id: order_restated_return_bitfield_4_echo_text
        type: b1
      - id: order_restated_return_bitfield_4_stop_px
        type: b1
      - id: order_restated_return_bitfield_4_routing_inst
        type: b1
      - id: order_restated_return_bitfield_4_rout_strategy
        type: b1
      - id: order_restated_return_bitfield_4_route_delivery_method
        type: b1
      - id: order_restated_return_bitfield_4_ex_destination
        type: b1
      - id: order_restated_return_bitfield_4_trade_report_ref_id
        type: b1
  order_restated_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_5_cum_qty
        type: b1
      - id: order_restated_return_bitfield_5_day_order_qty
        type: b1
      - id: order_restated_return_bitfield_5_day_cum_qty
        type: b1
      - id: order_restated_return_bitfield_5_avg_px
        type: b1
      - id: order_restated_return_bitfield_5_day_avg_px
        type: b1
      - id: order_restated_return_bitfield_5_pending_status
        type: b1
      - id: order_restated_return_bitfield_5_drill_thru_protection
        type: b1
      - id: order_restated_return_bitfield_5_multileg_reporting_type
        type: b1
  order_restated_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_6_leg_cfi_code
        type: b1
      - id: order_restated_return_bitfield_6_leg_maturity_date
        type: b1
      - id: order_restated_return_bitfield_6_leg_strike_price
        type: b1
      - id: order_restated_return_bitfield_6_room_id
        type: b1
      - id: order_restated_return_bitfield_6_secondary_exec_id
        type: b1
      - id: order_restated_return_bitfield_6_user_request_id
        type: b1
      - id: order_restated_return_bitfield_6_sis_username
        type: b1
      - id: order_restated_return_bitfield_6_user_status
        type: b1
  order_restated_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_7_account
        type: b1
      - id: order_restated_return_bitfield_7_clearing_firm
        type: b1
      - id: order_restated_return_bitfield_7_clearing_account
        type: b1
      - id: order_restated_return_bitfield_7_display_indicator
        type: b1
      - id: order_restated_return_bitfield_7_max_floor
        type: b1
      - id: order_restated_return_bitfield_7_discretion_amount
        type: b1
      - id: order_restated_return_bitfield_7_order_qty
        type: b1
      - id: order_restated_return_bitfield_7_prevent_match
        type: b1
  order_restated_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_8_maturity_date
        type: b1
      - id: order_restated_return_bitfield_8_strike_price
        type: b1
      - id: order_restated_return_bitfield_8_put_or_call
        type: b1
      - id: order_restated_return_bitfield_8_open_close
        type: b1
      - id: order_restated_return_bitfield_8_cl_ord_id_batch
        type: b1
      - id: order_restated_return_bitfield_8_corrected_size
        type: b1
      - id: order_restated_return_bitfield_8_party_id
        type: b1
      - id: order_restated_return_bitfield_8_access_fee
        type: b1
  order_restated_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_9_orig_cl_ord_id
        type: b1
      - id: order_restated_return_bitfield_9_leaves_qty
        type: b1
      - id: order_restated_return_bitfield_9_last_shares
        type: b1
      - id: order_restated_return_bitfield_9_last_px
        type: b1
      - id: order_restated_return_bitfield_9_display_price
        type: b1
      - id: order_restated_return_bitfield_9_working_price
        type: b1
      - id: order_restated_return_bitfield_9_base_liquidity_indicator
        type: b1
      - id: order_restated_return_bitfield_9_expire_time
        type: b1
  order_restated_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_10_secondary_order_id
        type: b1
      - id: order_restated_return_bitfield_10_ccp
        type: b1
      - id: order_restated_return_bitfield_10_contra_capacity
        type: b1
      - id: order_restated_return_bitfield_10_attributed_quote
        type: b1
      - id: order_restated_return_bitfield_10_ext_exec_inst
        type: b1
      - id: order_restated_return_bitfield_10_bulk_order_ids
        type: b1
      - id: order_restated_return_bitfield_10_bulk_reject_reasons
        type: b1
      - id: order_restated_return_bitfield_10_party_role
        type: b1
  order_restated_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_11_marketing_fee_code
        type: b1
      - id: order_restated_return_bitfield_11_target_party_id
        type: b1
      - id: order_restated_return_bitfield_11_auction_id
        type: b1
      - id: order_restated_return_bitfield_11_order_category
        type: b1
      - id: order_restated_return_bitfield_11_liquidity_provision
        type: b1
      - id: order_restated_return_bitfield_11_cmta_number
        type: b1
      - id: order_restated_return_bitfield_11_cross_type
        type: b1
      - id: order_restated_return_bitfield_11_cross_prioritization
        type: b1
  order_restated_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_12_cross_id
        type: b1
      - id: order_restated_return_bitfield_12_alloc_qty
        type: b1
      - id: order_restated_return_bitfield_12_give_up_firm_id
        type: b1
      - id: order_restated_return_bitfield_12_routing_firm_id
        type: b1
      - id: order_restated_return_bitfield_12_waiver_type
        type: b1
      - id: order_restated_return_bitfield_12_cross_exclusion_indicator
        type: b1
      - id: order_restated_return_bitfield_12_price_formation
        type: b1
      - id: order_restated_return_bitfield_12_client_qualified_role
        type: b1
  order_restated_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_13_client_id
        type: b1
      - id: order_restated_return_bitfield_13_investor_id
        type: b1
      - id: order_restated_return_bitfield_13_executor_id
        type: b1
      - id: order_restated_return_bitfield_13_order_origination
        type: b1
      - id: order_restated_return_bitfield_13_algo
        type: b1
      - id: order_restated_return_bitfield_13_deferral_reason
        type: b1
      - id: order_restated_return_bitfield_13_investor_qualified_role
        type: b1
      - id: order_restated_return_bitfield_13_executor_qualified_role
        type: b1
  order_restated_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_14_cti_code
        type: b1
      - id: order_restated_return_bitfield_14_manual_order_indicator
        type: b1
      - id: order_restated_return_bitfield_14_operator_id
        type: b1
      - id: order_restated_return_bitfield_14_trade_date
        type: b1
      - id: order_restated_return_bitfield_14_clearing_price
        type: b1
      - id: order_restated_return_bitfield_14_clearing_size
        type: b1
      - id: order_restated_return_bitfield_14_clearing_symbol
        type: b1
      - id: order_restated_return_bitfield_14_clearing_optional_data
        type: b1
  order_restated_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_15_trade_reporting_indicato
        type: b1
      - id: order_restated_return_bitfield_15_equity_party_id
        type: b1
      - id: order_restated_return_bitfield_15_equity_nbbo_protect
        type: b1
      - id: order_restated_return_bitfield_15_mass_cancel_id
        type: b1
      - id: order_restated_return_bitfield_15_trade_publish_ind
        type: b1
      - id: order_restated_return_bitfield_15_report_time
        type: b1
      - id: order_restated_return_bitfield_15_leg_symbol_sfx
        type: b1
      - id: order_restated_return_bitfield_15_client_id_attr
        type: b1
  order_restated_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_16_frequent_trader_id
        type: b1
      - id: order_restated_return_bitfield_16_session_eligibility
        type: b1
      - id: order_restated_return_bitfield_16_combo_order
        type: b1
      - id: order_restated_return_bitfield_16_compression
        type: b1
      - id: order_restated_return_bitfield_16_floor_destination
        type: b1
      - id: order_restated_return_bitfield_16_floor_routing_inst
        type: b1
      - id: order_restated_return_bitfield_16_multi_class_sprd
        type: b1
      - id: order_restated_return_bitfield_16_order_origin
        type: b1
  order_restated_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_17_price_type
        type: b1
      - id: order_restated_return_bitfield_17_strategy_id
        type: b1
      - id: order_restated_return_bitfield_17_trading_session_id
        type: b1
      - id: order_restated_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: order_restated_return_bitfield_17_sender_location_id
        type: b1
      - id: order_restated_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: order_restated_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: order_restated_return_bitfield_17_cust_order_handling_inst
        type: b1
  order_restated_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_18_reserved_1
        type: b1
      - id: order_restated_return_bitfield_18_cross_initiator
        type: b1
      - id: order_restated_return_bitfield_18_subreason
        type: b1
      - id: order_restated_return_bitfield_18_cross_trade_flag
        type: b1
      - id: order_restated_return_bitfield_18_reserved_16
        type: b1
      - id: order_restated_return_bitfield_18_held
        type: b1
      - id: order_restated_return_bitfield_18_locate_broker
        type: b1
      - id: order_restated_return_bitfield_18_reserved_128
        type: b1
  order_restated_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_restated_return_bitfield_19_floor_trade_time
        type: b1
      - id: order_restated_return_bitfield_19_equity_ex_destination
        type: b1
      - id: order_restated_return_bitfield_19_cross_on_behalf_of_id
        type: b1
      - id: order_restated_return_bitfield_19_cmc_sessions
        type: b1
      - id: order_restated_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: order_restated_return_bitfield_19_cmc_match_qty
        type: b1
      - id: order_restated_return_bitfield_19_stop_px_type
        type: b1
      - id: order_restated_return_bitfield_19_reserved_128
        type: b1
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: leaves_qty
        type: u4
      - id: working_price_binary_8
        type: u8
        doc: 'New working price'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: restatement_reason
        type: u1
        enum: restatement_reason
        doc: 'The reason for this Order Restated message. E=Reduction of OrdQty due to Equity Leg Reject (C1 only) F=Represented on Floor(C1 only) L=Reload P=Price Sliding Reprice Q=Liquidity Updated R=Reroute S=Ship and Post (SWP) W=Wash f=Unsolicited Floor Action(C1 only) Cboe reserves the right to add new values as necessary without prior notice'
  user_modify_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: modify_reject_reason
        type: u1
        enum: modify_reject_reason
        doc: 'Reason for a modify rejection. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and user_modify_rejected_return_bitfield_9.user_modify_rejected_return_bitfield_9_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 9 and user_modify_rejected_return_bitfield_9.user_modify_rejected_return_bitfield_9_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and user_modify_rejected_return_bitfield_9.user_modify_rejected_return_bitfield_9_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and user_modify_rejected_return_bitfield_9.user_modify_rejected_return_bitfield_9_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 9 and user_modify_rejected_return_bitfield_9.user_modify_rejected_return_bitfield_9_cross_exclusion_indicator
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
      - id: user_modify_rejected_return_bitfield_1_ord_type
        type: b1
      - id: user_modify_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: user_modify_rejected_return_bitfield_1_min_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_1_reserved_128
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
      - id: user_modify_rejected_return_bitfield_2_contra_trader
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
      - id: user_modify_rejected_return_bitfield_5_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_6_sub_liquidity_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_6_trade_report_type_return
        type: b1
      - id: user_modify_rejected_return_bitfield_6_trade_publish_ind_return
        type: b1
      - id: user_modify_rejected_return_bitfield_6_text
        type: b1
      - id: user_modify_rejected_return_bitfield_6_bid
        type: b1
      - id: user_modify_rejected_return_bitfield_6_offer
        type: b1
      - id: user_modify_rejected_return_bitfield_6_large_size
        type: b1
      - id: user_modify_rejected_return_bitfield_6_last_mkt
        type: b1
  user_modify_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_7_fee_code
        type: b1
      - id: user_modify_rejected_return_bitfield_7_echo_text
        type: b1
      - id: user_modify_rejected_return_bitfield_7_stop_px
        type: b1
      - id: user_modify_rejected_return_bitfield_7_routing_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_7_rout_strategy
        type: b1
      - id: user_modify_rejected_return_bitfield_7_route_delivery_method
        type: b1
      - id: user_modify_rejected_return_bitfield_7_ex_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_7_trade_report_ref_id
        type: b1
  user_modify_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_8_marketing_fee_code
        type: b1
      - id: user_modify_rejected_return_bitfield_8_target_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_8_auction_id
        type: b1
      - id: user_modify_rejected_return_bitfield_8_order_category
        type: b1
      - id: user_modify_rejected_return_bitfield_8_liquidity_provision
        type: b1
      - id: user_modify_rejected_return_bitfield_8_cmta_number
        type: b1
      - id: user_modify_rejected_return_bitfield_8_cross_type
        type: b1
      - id: user_modify_rejected_return_bitfield_8_cross_prioritization
        type: b1
  user_modify_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_9_cross_id
        type: b1
      - id: user_modify_rejected_return_bitfield_9_alloc_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_9_give_up_firm_id
        type: b1
      - id: user_modify_rejected_return_bitfield_9_routing_firm_id
        type: b1
      - id: user_modify_rejected_return_bitfield_9_waiver_type
        type: b1
      - id: user_modify_rejected_return_bitfield_9_cross_exclusion_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_9_price_formation
        type: b1
      - id: user_modify_rejected_return_bitfield_9_client_qualified_role
        type: b1
  user_modify_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_10_client_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_investor_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_executor_id
        type: b1
      - id: user_modify_rejected_return_bitfield_10_order_origination
        type: b1
      - id: user_modify_rejected_return_bitfield_10_algo
        type: b1
      - id: user_modify_rejected_return_bitfield_10_deferral_reason
        type: b1
      - id: user_modify_rejected_return_bitfield_10_investor_qualified_role
        type: b1
      - id: user_modify_rejected_return_bitfield_10_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_11_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_11_day_order_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_11_day_cum_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_11_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_11_day_avg_px
        type: b1
      - id: user_modify_rejected_return_bitfield_11_pending_status
        type: b1
      - id: user_modify_rejected_return_bitfield_11_drill_thru_protection
        type: b1
      - id: user_modify_rejected_return_bitfield_11_multileg_reporting_type
        type: b1
  user_modify_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_12_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_12_leg_maturity_date
        type: b1
      - id: user_modify_rejected_return_bitfield_12_leg_strike_price
        type: b1
      - id: user_modify_rejected_return_bitfield_12_room_id
        type: b1
      - id: user_modify_rejected_return_bitfield_12_secondary_exec_id
        type: b1
      - id: user_modify_rejected_return_bitfield_12_user_request_id
        type: b1
      - id: user_modify_rejected_return_bitfield_12_sis_username
        type: b1
      - id: user_modify_rejected_return_bitfield_12_user_status
        type: b1
  user_modify_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_13_trade_reporting_indicato
        type: b1
      - id: user_modify_rejected_return_bitfield_13_equity_party_id
        type: b1
      - id: user_modify_rejected_return_bitfield_13_equity_nbbo_protect
        type: b1
      - id: user_modify_rejected_return_bitfield_13_mass_cancel_id
        type: b1
      - id: user_modify_rejected_return_bitfield_13_trade_publish_ind
        type: b1
      - id: user_modify_rejected_return_bitfield_13_report_time
        type: b1
      - id: user_modify_rejected_return_bitfield_13_leg_symbol_sfx
        type: b1
      - id: user_modify_rejected_return_bitfield_13_client_id_attr
        type: b1
  user_modify_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_14_frequent_trader_id
        type: b1
      - id: user_modify_rejected_return_bitfield_14_session_eligibility
        type: b1
      - id: user_modify_rejected_return_bitfield_14_combo_order
        type: b1
      - id: user_modify_rejected_return_bitfield_14_compression
        type: b1
      - id: user_modify_rejected_return_bitfield_14_floor_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_14_floor_routing_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_14_multi_class_sprd
        type: b1
      - id: user_modify_rejected_return_bitfield_14_order_origin
        type: b1
  user_modify_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_15_price_type
        type: b1
      - id: user_modify_rejected_return_bitfield_15_strategy_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_trading_session_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_trade_through_alert_type
        type: b1
      - id: user_modify_rejected_return_bitfield_15_sender_location_id
        type: b1
      - id: user_modify_rejected_return_bitfield_15_floor_trader_acronym
        type: b1
      - id: user_modify_rejected_return_bitfield_15_exec_leg_cfi_code
        type: b1
      - id: user_modify_rejected_return_bitfield_15_expire_time
        type: b1
  user_modify_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_16_secondary_order_id
        type: b1
      - id: user_modify_rejected_return_bitfield_16_ccp
        type: b1
      - id: user_modify_rejected_return_bitfield_16_contra_capacity
        type: b1
      - id: user_modify_rejected_return_bitfield_16_attributed_quote
        type: b1
      - id: user_modify_rejected_return_bitfield_16_ext_exec_inst
        type: b1
      - id: user_modify_rejected_return_bitfield_16_bulk_order_ids
        type: b1
      - id: user_modify_rejected_return_bitfield_16_bulk_reject_reasons
        type: b1
      - id: user_modify_rejected_return_bitfield_16_party_role
        type: b1
  user_modify_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_17_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_2
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_4
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_17_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_17_executor_qualified_role
        type: b1
  user_modify_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_18_cti_code
        type: b1
      - id: user_modify_rejected_return_bitfield_18_manual_order_indicator
        type: b1
      - id: user_modify_rejected_return_bitfield_18_operator_id
        type: b1
      - id: user_modify_rejected_return_bitfield_18_trade_date
        type: b1
      - id: user_modify_rejected_return_bitfield_18_clearing_price
        type: b1
      - id: user_modify_rejected_return_bitfield_18_clearing_size
        type: b1
      - id: user_modify_rejected_return_bitfield_18_clearing_symbol
        type: b1
      - id: user_modify_rejected_return_bitfield_18_clearing_optional_data
        type: b1
  user_modify_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_19_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_2
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_4
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_8
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_32
        type: b1
      - id: user_modify_rejected_return_bitfield_19_reserved_64
        type: b1
      - id: user_modify_rejected_return_bitfield_19_cust_order_handling_inst
        type: b1
  user_modify_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: user_modify_rejected_return_bitfield_20_cross_initiator
        type: b1
      - id: user_modify_rejected_return_bitfield_20_subreason
        type: b1
      - id: user_modify_rejected_return_bitfield_20_cross_trade_flag
        type: b1
      - id: user_modify_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: user_modify_rejected_return_bitfield_20_held
        type: b1
      - id: user_modify_rejected_return_bitfield_20_locate_broker
        type: b1
      - id: user_modify_rejected_return_bitfield_20_reserved_128
        type: b1
  user_modify_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: user_modify_rejected_return_bitfield_21_floor_trade_time
        type: b1
      - id: user_modify_rejected_return_bitfield_21_equity_ex_destination
        type: b1
      - id: user_modify_rejected_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: user_modify_rejected_return_bitfield_21_cmc_sessions
        type: b1
      - id: user_modify_rejected_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: user_modify_rejected_return_bitfield_21_cmc_match_qty
        type: b1
      - id: user_modify_rejected_return_bitfield_21_stop_px_type
        type: b1
      - id: user_modify_rejected_return_bitfield_21_reserved_128
        type: b1
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Order Reason Codes for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and order_cancelled_return_bitfield_1.order_cancelled_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and order_cancelled_return_bitfield_2.order_cancelled_return_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and order_cancelled_return_bitfield_3.order_cancelled_return_bitfield_3_display_indicator
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 5 and order_cancelled_return_bitfield_5.order_cancelled_return_bitfield_5_ex_destination
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_cancelled_return_bitfield_6.order_cancelled_return_bitfield_6_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and order_cancelled_return_bitfield_6.order_cancelled_return_bitfield_6_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 6 and order_cancelled_return_bitfield_6.order_cancelled_return_bitfield_6_auction_id
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_cancelled_return_bitfield_9.order_cancelled_return_bitfield_9_equity_party_id
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 9 and order_cancelled_return_bitfield_9.order_cancelled_return_bitfield_9_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 9 and order_cancelled_return_bitfield_9.order_cancelled_return_bitfield_9_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and order_cancelled_return_bitfield_9.order_cancelled_return_bitfield_9_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 10 and order_cancelled_return_bitfield_10.order_cancelled_return_bitfield_10_corrected_size
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_leaves_qty
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: display_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_display_price
        doc: 'Implied decimal with scale 1e-4'
      - id: working_price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_working_price
        doc: 'Implied decimal with scale 1e-4'
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 11 and order_cancelled_return_bitfield_11.order_cancelled_return_bitfield_11_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_secondary_order_id
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 12 and order_cancelled_return_bitfield_12.order_cancelled_return_bitfield_12_attributed_quote
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 13 and order_cancelled_return_bitfield_13.order_cancelled_return_bitfield_13_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_cancelled_return_bitfield_14.order_cancelled_return_bitfield_14_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 14 and order_cancelled_return_bitfield_14.order_cancelled_return_bitfield_14_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_cancelled_return_bitfield_14.order_cancelled_return_bitfield_14_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and order_cancelled_return_bitfield_14.order_cancelled_return_bitfield_14_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 14 and order_cancelled_return_bitfield_14.order_cancelled_return_bitfield_14_cross_exclusion_indicator
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and order_cancelled_return_bitfield_16.order_cancelled_return_bitfield_16_clearing_optional_data
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_frequent_trader_id
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_cancelled_return_bitfield_18.order_cancelled_return_bitfield_18_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 19 and order_cancelled_return_bitfield_19.order_cancelled_return_bitfield_19_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 19 and order_cancelled_return_bitfield_19.order_cancelled_return_bitfield_19_strategy_id
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 20 and order_cancelled_return_bitfield_20.order_cancelled_return_bitfield_20_cross_initiator
      - id: subreason
        type: u1
        enum: subreason
        if: number_of_return_bitfields >= 20 and order_cancelled_return_bitfield_20.order_cancelled_return_bitfield_20_subreason
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 20 and order_cancelled_return_bitfield_20.order_cancelled_return_bitfield_20_held
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_cancelled_return_bitfield_21.order_cancelled_return_bitfield_21_cross_on_behalf_of_id
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
      - id: order_cancelled_return_bitfield_1_ord_type
        type: b1
      - id: order_cancelled_return_bitfield_1_time_in_force
        type: b1
      - id: order_cancelled_return_bitfield_1_min_qty
        type: b1
      - id: order_cancelled_return_bitfield_1_reserved_128
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
      - id: order_cancelled_return_bitfield_2_contra_trader
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
      - id: order_cancelled_return_bitfield_3_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_3_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_3_reserved_64
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
      - id: order_cancelled_return_bitfield_5_trade_report_ref_id
        type: b1
  order_cancelled_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_6_marketing_fee_code
        type: b1
      - id: order_cancelled_return_bitfield_6_target_party_id
        type: b1
      - id: order_cancelled_return_bitfield_6_auction_id
        type: b1
      - id: order_cancelled_return_bitfield_6_order_category
        type: b1
      - id: order_cancelled_return_bitfield_6_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_6_reserved_32
        type: b1
      - id: order_cancelled_return_bitfield_6_reserved_64
        type: b1
      - id: order_cancelled_return_bitfield_6_reserved_128
        type: b1
  order_cancelled_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_7_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_7_day_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_7_day_cum_qty
        type: b1
      - id: order_cancelled_return_bitfield_7_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_7_day_avg_px
        type: b1
      - id: order_cancelled_return_bitfield_7_pending_status
        type: b1
      - id: order_cancelled_return_bitfield_7_drill_thru_protection
        type: b1
      - id: order_cancelled_return_bitfield_7_multileg_reporting_type
        type: b1
  order_cancelled_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_8_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_8_leg_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_8_leg_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_8_room_id
        type: b1
      - id: order_cancelled_return_bitfield_8_secondary_exec_id
        type: b1
      - id: order_cancelled_return_bitfield_8_user_request_id
        type: b1
      - id: order_cancelled_return_bitfield_8_sis_username
        type: b1
      - id: order_cancelled_return_bitfield_8_user_status
        type: b1
  order_cancelled_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_9_trade_reporting_indicato
        type: b1
      - id: order_cancelled_return_bitfield_9_equity_party_id
        type: b1
      - id: order_cancelled_return_bitfield_9_equity_nbbo_protect
        type: b1
      - id: order_cancelled_return_bitfield_9_mass_cancel_id
        type: b1
      - id: order_cancelled_return_bitfield_9_max_floor
        type: b1
      - id: order_cancelled_return_bitfield_9_discretion_amount
        type: b1
      - id: order_cancelled_return_bitfield_9_order_qty
        type: b1
      - id: order_cancelled_return_bitfield_9_prevent_match
        type: b1
  order_cancelled_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_10_maturity_date
        type: b1
      - id: order_cancelled_return_bitfield_10_strike_price
        type: b1
      - id: order_cancelled_return_bitfield_10_put_or_call
        type: b1
      - id: order_cancelled_return_bitfield_10_open_close
        type: b1
      - id: order_cancelled_return_bitfield_10_cl_ord_id_batch
        type: b1
      - id: order_cancelled_return_bitfield_10_corrected_size
        type: b1
      - id: order_cancelled_return_bitfield_10_party_id
        type: b1
      - id: order_cancelled_return_bitfield_10_access_fee
        type: b1
  order_cancelled_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_11_orig_cl_ord_id
        type: b1
      - id: order_cancelled_return_bitfield_11_leaves_qty
        type: b1
      - id: order_cancelled_return_bitfield_11_last_shares
        type: b1
      - id: order_cancelled_return_bitfield_11_last_px
        type: b1
      - id: order_cancelled_return_bitfield_11_display_price
        type: b1
      - id: order_cancelled_return_bitfield_11_working_price
        type: b1
      - id: order_cancelled_return_bitfield_11_base_liquidity_indicator
        type: b1
      - id: order_cancelled_return_bitfield_11_expire_time
        type: b1
  order_cancelled_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_12_secondary_order_id
        type: b1
      - id: order_cancelled_return_bitfield_12_ccp
        type: b1
      - id: order_cancelled_return_bitfield_12_contra_capacity
        type: b1
      - id: order_cancelled_return_bitfield_12_attributed_quote
        type: b1
      - id: order_cancelled_return_bitfield_12_ext_exec_inst
        type: b1
      - id: order_cancelled_return_bitfield_12_bulk_order_ids
        type: b1
      - id: order_cancelled_return_bitfield_12_bulk_reject_reasons
        type: b1
      - id: order_cancelled_return_bitfield_12_party_role
        type: b1
  order_cancelled_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_13_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_13_reserved_2
        type: b1
      - id: order_cancelled_return_bitfield_13_reserved_4
        type: b1
      - id: order_cancelled_return_bitfield_13_reserved_8
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
      - id: order_cancelled_return_bitfield_17_trade_publish_ind
        type: b1
      - id: order_cancelled_return_bitfield_17_report_time
        type: b1
      - id: order_cancelled_return_bitfield_17_leg_symbol_sfx
        type: b1
      - id: order_cancelled_return_bitfield_17_client_id_attr
        type: b1
  order_cancelled_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_18_frequent_trader_id
        type: b1
      - id: order_cancelled_return_bitfield_18_session_eligibility
        type: b1
      - id: order_cancelled_return_bitfield_18_combo_order
        type: b1
      - id: order_cancelled_return_bitfield_18_compression
        type: b1
      - id: order_cancelled_return_bitfield_18_floor_destination
        type: b1
      - id: order_cancelled_return_bitfield_18_floor_routing_inst
        type: b1
      - id: order_cancelled_return_bitfield_18_multi_class_sprd
        type: b1
      - id: order_cancelled_return_bitfield_18_order_origin
        type: b1
  order_cancelled_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_19_price_type
        type: b1
      - id: order_cancelled_return_bitfield_19_strategy_id
        type: b1
      - id: order_cancelled_return_bitfield_19_trading_session_id
        type: b1
      - id: order_cancelled_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: order_cancelled_return_bitfield_19_sender_location_id
        type: b1
      - id: order_cancelled_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: order_cancelled_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: order_cancelled_return_bitfield_19_cust_order_handling_inst
        type: b1
  order_cancelled_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_20_reserved_1
        type: b1
      - id: order_cancelled_return_bitfield_20_cross_initiator
        type: b1
      - id: order_cancelled_return_bitfield_20_subreason
        type: b1
      - id: order_cancelled_return_bitfield_20_cross_trade_flag
        type: b1
      - id: order_cancelled_return_bitfield_20_reserved_16
        type: b1
      - id: order_cancelled_return_bitfield_20_held
        type: b1
      - id: order_cancelled_return_bitfield_20_locate_broker
        type: b1
      - id: order_cancelled_return_bitfield_20_reserved_128
        type: b1
  order_cancelled_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_cancelled_return_bitfield_21_floor_trade_time
        type: b1
      - id: order_cancelled_return_bitfield_21_equity_ex_destination
        type: b1
      - id: order_cancelled_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: order_cancelled_return_bitfield_21_cmc_sessions
        type: b1
      - id: order_cancelled_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: order_cancelled_return_bitfield_21_cmc_match_qty
        type: b1
      - id: order_cancelled_return_bitfield_21_stop_px_type
        type: b1
      - id: order_cancelled_return_bitfield_21_reserved_128
        type: b1
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Order Reason Codes for a list of possible reasons'
      - id: cancel_subreason
        type: u1
        enum: cancel_subreason
        doc: 'Additional detail for the quote cancellation. See Order and Quote Subreason Codes for a list of possible reasons'
  cross_order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Reason for the order cancellation. See Order Reason Codes for a list of possible reasons'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: cross_order_cancelled_return_bitfield_19
        type: cross_order_cancelled_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet CrossOrderCancelled byte 19'
      - id: cross_order_cancelled_return_bitfield_20
        type: cross_order_cancelled_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet CrossOrderCancelled byte 20'
      - id: cross_order_cancelled_return_bitfield_21
        type: cross_order_cancelled_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet CrossOrderCancelled byte 21'
      - id: num_cross_order_cancelled_order_allocations
        type: u2
        doc: 'Number of order allocations represented by re- peating groups included in this cross order. Must be at least 2 (One agency and one contra), and no more than 11'
      - id: cross_order_cancelled_order_allocations
        type: cross_order_cancelled_order_allocations
        repeat: expr
        repeat-expr: num_cross_order_cancelled_order_allocations
        doc: 'Repeating group stated GroupCnt times'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cross_order_cancelled_return_bitfield_1.cross_order_cancelled_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and cross_order_cancelled_return_bitfield_1.cross_order_cancelled_return_bitfield_1_exec_inst
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cross_order_cancelled_return_bitfield_2.cross_order_cancelled_return_bitfield_2_symbol
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_clearing_firm
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 3 and cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and cross_order_cancelled_return_bitfield_4.cross_order_cancelled_return_bitfield_4_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and cross_order_cancelled_return_bitfield_4.cross_order_cancelled_return_bitfield_4_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and cross_order_cancelled_return_bitfield_4.cross_order_cancelled_return_bitfield_4_put_or_call
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_auction_id
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and cross_order_cancelled_return_bitfield_10.cross_order_cancelled_return_bitfield_10_routing_firm_id
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and cross_order_cancelled_return_bitfield_15.cross_order_cancelled_return_bitfield_15_equity_party_id
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and cross_order_cancelled_return_bitfield_16.cross_order_cancelled_return_bitfield_16_frequent_trader_id
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 16 and cross_order_cancelled_return_bitfield_16.cross_order_cancelled_return_bitfield_16_compression
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and cross_order_cancelled_return_bitfield_18.cross_order_cancelled_return_bitfield_18_cross_initiator
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 18 and cross_order_cancelled_return_bitfield_18.cross_order_cancelled_return_bitfield_18_attributed_quote
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and cross_order_cancelled_return_bitfield_21.cross_order_cancelled_return_bitfield_21_cross_on_behalf_of_id
  cross_order_cancelled_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_1_reserved_1
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
      - id: cross_order_cancelled_return_bitfield_1_reserved_128
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
      - id: cross_order_cancelled_return_bitfield_5_last_px
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
      - id: cross_order_cancelled_return_bitfield_6_reserved_8
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_reserved_16
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_reserved_32
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_reserved_64
        type: b1
      - id: cross_order_cancelled_return_bitfield_6_reserved_128
        type: b1
  cross_order_cancelled_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_7_reserved_1
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
      - id: cross_order_cancelled_return_bitfield_11_algo
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
      - id: cross_order_cancelled_return_bitfield_12_reserved_8
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_reserved_16
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_reserved_32
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_reserved_64
        type: b1
      - id: cross_order_cancelled_return_bitfield_12_reserved_128
        type: b1
  cross_order_cancelled_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_13_reserved_1
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
      - id: cross_order_cancelled_return_bitfield_14_room_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_secondary_exec_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_user_request_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_sis_username
        type: b1
      - id: cross_order_cancelled_return_bitfield_14_user_status
        type: b1
  cross_order_cancelled_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_15_trade_reporting_indicato
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
      - id: cross_order_cancelled_return_bitfield_16_multi_class_sprd
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
      - id: cross_order_cancelled_return_bitfield_18_reserved_1
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_cross_initiator
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_subreason
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_attributed_quote
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_ext_exec_inst
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_bulk_order_ids
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_bulk_reject_reasons
        type: b1
      - id: cross_order_cancelled_return_bitfield_18_party_role
        type: b1
  cross_order_cancelled_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_19_reserved_1
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_reserved_2
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_reserved_4
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_trade_date
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_clearing_price
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_clearing_size
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_clearing_symbol
        type: b1
      - id: cross_order_cancelled_return_bitfield_19_clearing_optional_data
        type: b1
  cross_order_cancelled_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_20_reserved_1
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_reserved_2
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_reserved_4
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_cross_trade_flag
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_reserved_16
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_held
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_locate_broker
        type: b1
      - id: cross_order_cancelled_return_bitfield_20_reserved_128
        type: b1
  cross_order_cancelled_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: cross_order_cancelled_return_bitfield_21_floor_trade_time
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_equity_ex_destination
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_cmc_sessions
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_cmc_match_qty
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_stop_px_type
        type: b1
      - id: cross_order_cancelled_return_bitfield_21_reserved_128
        type: b1
  cross_order_cancelled_order_allocations:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: side
        type: u1
        enum: side
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
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 10 and _parent.cross_order_cancelled_return_bitfield_10.cross_order_cancelled_return_bitfield_10_give_up_firm_id
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: _parent.number_of_return_bitfields >= 3 and _parent.cross_order_cancelled_return_bitfield_3.cross_order_cancelled_return_bitfield_3_account
      - id: cmta_number
        type: u4
        if: _parent.number_of_return_bitfields >= 9 and _parent.cross_order_cancelled_return_bitfield_9.cross_order_cancelled_return_bitfield_9_cmta_number
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: cancel_reject_reason
        type: u1
        enum: cancel_reject_reason
        doc: 'Reason for the order cancellation. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_ord_type
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 1 and cancel_rejected_return_bitfield_1.cancel_rejected_return_bitfield_1_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and cancel_rejected_return_bitfield_2.cancel_rejected_return_bitfield_2_capacity
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and cancel_rejected_return_bitfield_5.cancel_rejected_return_bitfield_5_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and cancel_rejected_return_bitfield_5.cancel_rejected_return_bitfield_5_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and cancel_rejected_return_bitfield_6.cancel_rejected_return_bitfield_6_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and cancel_rejected_return_bitfield_6.cancel_rejected_return_bitfield_6_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 6 and cancel_rejected_return_bitfield_6.cancel_rejected_return_bitfield_6_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 6 and cancel_rejected_return_bitfield_6.cancel_rejected_return_bitfield_6_cmta_number
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and cancel_rejected_return_bitfield_9.cancel_rejected_return_bitfield_9_mass_cancel_id
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 10 and cancel_rejected_return_bitfield_10.cancel_rejected_return_bitfield_10_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and cancel_rejected_return_bitfield_10.cancel_rejected_return_bitfield_10_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 10 and cancel_rejected_return_bitfield_10.cancel_rejected_return_bitfield_10_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 10 and cancel_rejected_return_bitfield_10.cancel_rejected_return_bitfield_10_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 10 and cancel_rejected_return_bitfield_10.cancel_rejected_return_bitfield_10_corrected_size
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and cancel_rejected_return_bitfield_13.cancel_rejected_return_bitfield_13_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 13 and cancel_rejected_return_bitfield_13.cancel_rejected_return_bitfield_13_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and cancel_rejected_return_bitfield_13.cancel_rejected_return_bitfield_13_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and cancel_rejected_return_bitfield_13.cancel_rejected_return_bitfield_13_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 13 and cancel_rejected_return_bitfield_13.cancel_rejected_return_bitfield_13_cross_exclusion_indicator
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and cancel_rejected_return_bitfield_15.cancel_rejected_return_bitfield_15_clearing_optional_data
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
      - id: cancel_rejected_return_bitfield_1_ord_type
        type: b1
      - id: cancel_rejected_return_bitfield_1_time_in_force
        type: b1
      - id: cancel_rejected_return_bitfield_1_min_qty
        type: b1
      - id: cancel_rejected_return_bitfield_1_reserved_128
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
      - id: cancel_rejected_return_bitfield_2_contra_trader
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
      - id: cancel_rejected_return_bitfield_4_sub_liquidity_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_4_trade_report_type_return
        type: b1
      - id: cancel_rejected_return_bitfield_4_trade_publish_ind_return
        type: b1
      - id: cancel_rejected_return_bitfield_4_text
        type: b1
      - id: cancel_rejected_return_bitfield_4_bid
        type: b1
      - id: cancel_rejected_return_bitfield_4_offer
        type: b1
      - id: cancel_rejected_return_bitfield_4_large_size
        type: b1
      - id: cancel_rejected_return_bitfield_4_last_mkt
        type: b1
  cancel_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_5_fee_code
        type: b1
      - id: cancel_rejected_return_bitfield_5_echo_text
        type: b1
      - id: cancel_rejected_return_bitfield_5_stop_px
        type: b1
      - id: cancel_rejected_return_bitfield_5_routing_inst
        type: b1
      - id: cancel_rejected_return_bitfield_5_rout_strategy
        type: b1
      - id: cancel_rejected_return_bitfield_5_route_delivery_method
        type: b1
      - id: cancel_rejected_return_bitfield_5_ex_destination
        type: b1
      - id: cancel_rejected_return_bitfield_5_trade_report_ref_id
        type: b1
  cancel_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_6_marketing_fee_code
        type: b1
      - id: cancel_rejected_return_bitfield_6_target_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_6_auction_id
        type: b1
      - id: cancel_rejected_return_bitfield_6_order_category
        type: b1
      - id: cancel_rejected_return_bitfield_6_liquidity_provision
        type: b1
      - id: cancel_rejected_return_bitfield_6_cmta_number
        type: b1
      - id: cancel_rejected_return_bitfield_6_cross_type
        type: b1
      - id: cancel_rejected_return_bitfield_6_cross_prioritization
        type: b1
  cancel_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_7_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_7_day_order_qty
        type: b1
      - id: cancel_rejected_return_bitfield_7_day_cum_qty
        type: b1
      - id: cancel_rejected_return_bitfield_7_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_7_day_avg_px
        type: b1
      - id: cancel_rejected_return_bitfield_7_pending_status
        type: b1
      - id: cancel_rejected_return_bitfield_7_drill_thru_protection
        type: b1
      - id: cancel_rejected_return_bitfield_7_multileg_reporting_type
        type: b1
  cancel_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_8_leg_cfi_code
        type: b1
      - id: cancel_rejected_return_bitfield_8_leg_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_8_leg_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_8_room_id
        type: b1
      - id: cancel_rejected_return_bitfield_8_secondary_exec_id
        type: b1
      - id: cancel_rejected_return_bitfield_8_user_request_id
        type: b1
      - id: cancel_rejected_return_bitfield_8_sis_username
        type: b1
      - id: cancel_rejected_return_bitfield_8_user_status
        type: b1
  cancel_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_9_trade_reporting_indicato
        type: b1
      - id: cancel_rejected_return_bitfield_9_equity_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_9_equity_nbbo_protect
        type: b1
      - id: cancel_rejected_return_bitfield_9_mass_cancel_id
        type: b1
      - id: cancel_rejected_return_bitfield_9_trade_publish_ind
        type: b1
      - id: cancel_rejected_return_bitfield_9_report_time
        type: b1
      - id: cancel_rejected_return_bitfield_9_leg_symbol_sfx
        type: b1
      - id: cancel_rejected_return_bitfield_9_client_id_attr
        type: b1
  cancel_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_10_maturity_date
        type: b1
      - id: cancel_rejected_return_bitfield_10_strike_price
        type: b1
      - id: cancel_rejected_return_bitfield_10_put_or_call
        type: b1
      - id: cancel_rejected_return_bitfield_10_open_close
        type: b1
      - id: cancel_rejected_return_bitfield_10_cl_ord_id_batch
        type: b1
      - id: cancel_rejected_return_bitfield_10_corrected_size
        type: b1
      - id: cancel_rejected_return_bitfield_10_party_id
        type: b1
      - id: cancel_rejected_return_bitfield_10_access_fee
        type: b1
  cancel_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_11_orig_cl_ord_id
        type: b1
      - id: cancel_rejected_return_bitfield_11_leaves_qty
        type: b1
      - id: cancel_rejected_return_bitfield_11_last_shares
        type: b1
      - id: cancel_rejected_return_bitfield_11_last_px
        type: b1
      - id: cancel_rejected_return_bitfield_11_display_price
        type: b1
      - id: cancel_rejected_return_bitfield_11_working_price
        type: b1
      - id: cancel_rejected_return_bitfield_11_base_liquidity_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_11_expire_time
        type: b1
  cancel_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_12_secondary_order_id
        type: b1
      - id: cancel_rejected_return_bitfield_12_ccp
        type: b1
      - id: cancel_rejected_return_bitfield_12_contra_capacity
        type: b1
      - id: cancel_rejected_return_bitfield_12_attributed_quote
        type: b1
      - id: cancel_rejected_return_bitfield_12_ext_exec_inst
        type: b1
      - id: cancel_rejected_return_bitfield_12_bulk_order_ids
        type: b1
      - id: cancel_rejected_return_bitfield_12_bulk_reject_reasons
        type: b1
      - id: cancel_rejected_return_bitfield_12_party_role
        type: b1
  cancel_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_13_cross_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_alloc_qty
        type: b1
      - id: cancel_rejected_return_bitfield_13_give_up_firm_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_routing_firm_id
        type: b1
      - id: cancel_rejected_return_bitfield_13_waiver_type
        type: b1
      - id: cancel_rejected_return_bitfield_13_cross_exclusion_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_13_price_formation
        type: b1
      - id: cancel_rejected_return_bitfield_13_client_qualified_role
        type: b1
  cancel_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_14_client_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_investor_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_executor_id
        type: b1
      - id: cancel_rejected_return_bitfield_14_order_origination
        type: b1
      - id: cancel_rejected_return_bitfield_14_algo
        type: b1
      - id: cancel_rejected_return_bitfield_14_deferral_reason
        type: b1
      - id: cancel_rejected_return_bitfield_14_investor_qualified_role
        type: b1
      - id: cancel_rejected_return_bitfield_14_executor_qualified_role
        type: b1
  cancel_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_15_cti_code
        type: b1
      - id: cancel_rejected_return_bitfield_15_manual_order_indicator
        type: b1
      - id: cancel_rejected_return_bitfield_15_operator_id
        type: b1
      - id: cancel_rejected_return_bitfield_15_trade_date
        type: b1
      - id: cancel_rejected_return_bitfield_15_clearing_price
        type: b1
      - id: cancel_rejected_return_bitfield_15_clearing_size
        type: b1
      - id: cancel_rejected_return_bitfield_15_clearing_symbol
        type: b1
      - id: cancel_rejected_return_bitfield_15_clearing_optional_data
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
      - id: cancel_rejected_return_bitfield_18_cross_trade_flag
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_16
        type: b1
      - id: cancel_rejected_return_bitfield_18_held
        type: b1
      - id: cancel_rejected_return_bitfield_18_locate_broker
        type: b1
      - id: cancel_rejected_return_bitfield_18_reserved_128
        type: b1
  cancel_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: cancel_rejected_return_bitfield_19_floor_trade_time
        type: b1
      - id: cancel_rejected_return_bitfield_19_equity_ex_destination
        type: b1
      - id: cancel_rejected_return_bitfield_19_cross_on_behalf_of_id
        type: b1
      - id: cancel_rejected_return_bitfield_19_cmc_sessions
        type: b1
      - id: cancel_rejected_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: cancel_rejected_return_bitfield_19_cmc_match_qty
        type: b1
      - id: cancel_rejected_return_bitfield_19_stop_px_type
        type: b1
      - id: cancel_rejected_return_bitfield_19_reserved_128
        type: b1
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
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
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
      - id: contra_broker
        type: str
        size: 4
        encoding: ASCII
        doc: 'Corresponds to ContraBroker (375) in Cboe FIX. Simple Instrument Fills Internally matched simple executions will identify the clearing number of the contra on the execution. This includes leg fill reports (MultilegReportingType=2) that are sent as a result of a complex trade. Executions matched on the C1 trading floor will contain a value of ‘FBKR’ for ContraBroker for the first reporter of a Broker to Broker floor trade otherwise, this will identify the OCC clearing number of the contra (C1 only). Complex Package Fills ContraBroker will be sent and populated on electronic, complex package fills (MultilegReportingType=3) when the contra side is also a complex order. When legging in to the simple books ContraBroker will be blank. ContraBroker will be blank on complex package fills (MultilegReportingType=3) executed on the Cboe Options trading floor (C1 only). Routed Fills All externally matched (routed, BaseLiquidityIndicator = X) executions will identify the away exchange with the following possible values. AMEX = Routed to NYSE American ARCA = Routed to NYSE Arca BATS = Routed to Cboe BZX Options BOX = Routed to BOX CBOE = Routed to Cboe Options CTWO = Routed to C2 Options EDGX = Routed to Cboe EDGX Options EMLD = Routed to MIAX Emerald GMNI = Routed to Nasdaq GEMX IEX = Routed to IEX Options ISE = Routed to Nasdaq ISE MEMX = Routed to MEMX MERC = Routed to Nasdaq MRX MIAX = Routed to MIAX Options Exchange MXTO = Routed to MX2 Options NOMX = Routed to Nasdaq NOBX = Routed to Nasdaq Texas PERL = Routed to MIAX PEARL PHLX = Routed to Nasdaq PHLX SPHR = Routed to MIAX Sapphire'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: side
        type: u1
        enum: side
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: price_binary_price_8
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_exec_inst
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_return_bitfields >= 1 and order_execution_return_bitfield_1.order_execution_return_bitfield_1_ord_type
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_cum_qty
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_day_order_qty
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_day_cum_qty
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: day_avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_day_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_time_in_force
      - id: min_qty
        type: u4
        if: number_of_return_bitfields >= 3 and order_execution_return_bitfield_3.order_execution_return_bitfield_3_min_qty
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_capacity
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 4 and order_execution_return_bitfield_4.order_execution_return_bitfield_4_contra_trader
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_account
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_clearing_firm
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_clearing_account
      - id: display_indicator
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_display_indicator
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_max_floor
      - id: order_qty_binary_4
        type: u4
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_order_qty
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and order_execution_return_bitfield_5.order_execution_return_bitfield_5_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 6 and order_execution_return_bitfield_6.order_execution_return_bitfield_6_corrected_size
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and order_execution_return_bitfield_8.order_execution_return_bitfield_8_contra_capacity
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 8 and order_execution_return_bitfield_8.order_execution_return_bitfield_8_attributed_quote
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_fee_code
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_echo_text
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_routing_inst
      - id: rout_strategy
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_rout_strategy
      - id: route_delivery_method
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_route_delivery_method
      - id: ex_destination
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 10 and order_execution_return_bitfield_10.order_execution_return_bitfield_10_ex_destination
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_cmta_number
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry. 1 = Automated Improvement Mechanism (AIM) 2 = Qualified Contingent Cross (QCC) 3 = Solicitation Cross (SAM) 4 = Position Compression Cross (PCC) (C1 Only)'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 11 and order_execution_return_bitfield_11.order_execution_return_bitfield_11_cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe FIX. Indicates which side of the cross order will be prioritized for execution. This identifies the Agency side. 1 = Buy 2 = Sell'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_alloc_qty
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_routing_firm_id
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 12 and order_execution_return_bitfield_12.order_execution_return_bitfield_12_cross_exclusion_indicator
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 14 and order_execution_return_bitfield_14.order_execution_return_bitfield_14_trade_date
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 15 and order_execution_return_bitfield_15.order_execution_return_bitfield_15_drill_thru_protection
        doc: 'Implied decimal with scale 1e-4'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_return_bitfields >= 15 and order_execution_return_bitfield_15.order_execution_return_bitfield_15_multileg_reporting_type
        doc: 'Corresponds to MultilegReportingType (442) in Cboe FIX. Indicates the type of Order Execution message. 1=Single-leg instrument 2=Individual leg of multi-leg instrument'
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 16 and order_execution_return_bitfield_16.order_execution_return_bitfield_16_secondary_exec_id
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and order_execution_return_bitfield_17.order_execution_return_bitfield_17_equity_party_id
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and order_execution_return_bitfield_17.order_execution_return_bitfield_17_client_id_attr
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_frequent_trader_id
      - id: combo_order
        type: u1
        enum: combo_order
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_combo_order
      - id: compression
        type: u1
        enum: compression
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_compression
      - id: floor_destination
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_floor_destination
      - id: floor_routing_inst
        type: u1
        enum: floor_routing_inst
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_floor_routing_inst
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_multi_class_sprd
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 18 and order_execution_return_bitfield_18.order_execution_return_bitfield_18_order_origin
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_price_type
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_strategy_id
      - id: trade_through_alert_type
        type: u1
        enum: trade_through_alert_type
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_trade_through_alert_type
      - id: sender_location_id
        type: u1
        enum: sender_location_id
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_sender_location_id
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_floor_trader_acronym
        doc: 'Floor acronym of participant submitting trade'
      - id: exec_leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 19 and order_execution_return_bitfield_19.order_execution_return_bitfield_19_exec_leg_cfi_code
      - id: cross_initiator
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 20 and order_execution_return_bitfield_20.order_execution_return_bitfield_20_cross_initiator
      - id: held
        type: u1
        enum: held
        if: number_of_return_bitfields >= 20 and order_execution_return_bitfield_20.order_execution_return_bitfield_20_held
      - id: floor_trade_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 21 and order_execution_return_bitfield_21.order_execution_return_bitfield_21_floor_trade_time
        doc: 'Trade time. Nanoseconds since Unix epoch'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        if: number_of_return_bitfields >= 21 and order_execution_return_bitfield_21.order_execution_return_bitfield_21_equity_ex_destination
      - id: cross_on_behalf_of_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 21 and order_execution_return_bitfield_21.order_execution_return_bitfield_21_cross_on_behalf_of_id
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
      - id: order_execution_return_bitfield_1_ord_type
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
      - id: order_execution_return_bitfield_2_sub_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_2_trade_report_type_return
        type: b1
      - id: order_execution_return_bitfield_2_trade_publish_ind_return
        type: b1
      - id: order_execution_return_bitfield_2_text
        type: b1
      - id: order_execution_return_bitfield_2_bid
        type: b1
      - id: order_execution_return_bitfield_2_reserved_32
        type: b1
      - id: order_execution_return_bitfield_2_reserved_64
        type: b1
      - id: order_execution_return_bitfield_2_reserved_128
        type: b1
  order_execution_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_3_cum_qty
        type: b1
      - id: order_execution_return_bitfield_3_day_order_qty
        type: b1
      - id: order_execution_return_bitfield_3_day_cum_qty
        type: b1
      - id: order_execution_return_bitfield_3_avg_px
        type: b1
      - id: order_execution_return_bitfield_3_day_avg_px
        type: b1
      - id: order_execution_return_bitfield_3_time_in_force
        type: b1
      - id: order_execution_return_bitfield_3_min_qty
        type: b1
      - id: order_execution_return_bitfield_3_reserved_128
        type: b1
  order_execution_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_4_symbol
        type: b1
      - id: order_execution_return_bitfield_4_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_4_currency
        type: b1
      - id: order_execution_return_bitfield_4_id_source
        type: b1
      - id: order_execution_return_bitfield_4_security_id
        type: b1
      - id: order_execution_return_bitfield_4_security_exchange
        type: b1
      - id: order_execution_return_bitfield_4_capacity
        type: b1
      - id: order_execution_return_bitfield_4_contra_trader
        type: b1
  order_execution_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_5_account
        type: b1
      - id: order_execution_return_bitfield_5_clearing_firm
        type: b1
      - id: order_execution_return_bitfield_5_clearing_account
        type: b1
      - id: order_execution_return_bitfield_5_display_indicator
        type: b1
      - id: order_execution_return_bitfield_5_max_floor
        type: b1
      - id: order_execution_return_bitfield_5_discretion_amount
        type: b1
      - id: order_execution_return_bitfield_5_order_qty
        type: b1
      - id: order_execution_return_bitfield_5_prevent_match
        type: b1
  order_execution_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_6_maturity_date
        type: b1
      - id: order_execution_return_bitfield_6_strike_price
        type: b1
      - id: order_execution_return_bitfield_6_put_or_call
        type: b1
      - id: order_execution_return_bitfield_6_open_close
        type: b1
      - id: order_execution_return_bitfield_6_cl_ord_id_batch
        type: b1
      - id: order_execution_return_bitfield_6_corrected_size
        type: b1
      - id: order_execution_return_bitfield_6_party_id
        type: b1
      - id: order_execution_return_bitfield_6_access_fee
        type: b1
  order_execution_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_7_orig_cl_ord_id
        type: b1
      - id: order_execution_return_bitfield_7_leaves_qty
        type: b1
      - id: order_execution_return_bitfield_7_last_shares
        type: b1
      - id: order_execution_return_bitfield_7_last_px
        type: b1
      - id: order_execution_return_bitfield_7_display_price
        type: b1
      - id: order_execution_return_bitfield_7_working_price
        type: b1
      - id: order_execution_return_bitfield_7_base_liquidity_indicator
        type: b1
      - id: order_execution_return_bitfield_7_expire_time
        type: b1
  order_execution_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_8_secondary_order_id
        type: b1
      - id: order_execution_return_bitfield_8_ccp
        type: b1
      - id: order_execution_return_bitfield_8_contra_capacity
        type: b1
      - id: order_execution_return_bitfield_8_attributed_quote
        type: b1
      - id: order_execution_return_bitfield_8_ext_exec_inst
        type: b1
      - id: order_execution_return_bitfield_8_bulk_order_ids
        type: b1
      - id: order_execution_return_bitfield_8_bulk_reject_reasons
        type: b1
      - id: order_execution_return_bitfield_8_reserved_128
        type: b1
  order_execution_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_9_reserved_1
        type: b1
      - id: order_execution_return_bitfield_9_reserved_2
        type: b1
      - id: order_execution_return_bitfield_9_reserved_4
        type: b1
      - id: order_execution_return_bitfield_9_reserved_8
        type: b1
      - id: order_execution_return_bitfield_9_reserved_16
        type: b1
      - id: order_execution_return_bitfield_9_offer
        type: b1
      - id: order_execution_return_bitfield_9_large_size
        type: b1
      - id: order_execution_return_bitfield_9_last_mkt
        type: b1
  order_execution_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_10_fee_code
        type: b1
      - id: order_execution_return_bitfield_10_echo_text
        type: b1
      - id: order_execution_return_bitfield_10_stop_px
        type: b1
      - id: order_execution_return_bitfield_10_routing_inst
        type: b1
      - id: order_execution_return_bitfield_10_rout_strategy
        type: b1
      - id: order_execution_return_bitfield_10_route_delivery_method
        type: b1
      - id: order_execution_return_bitfield_10_ex_destination
        type: b1
      - id: order_execution_return_bitfield_10_trade_report_ref_id
        type: b1
  order_execution_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_11_marketing_fee_code
        type: b1
      - id: order_execution_return_bitfield_11_target_party_id
        type: b1
      - id: order_execution_return_bitfield_11_auction_id
        type: b1
      - id: order_execution_return_bitfield_11_order_category
        type: b1
      - id: order_execution_return_bitfield_11_liquidity_provision
        type: b1
      - id: order_execution_return_bitfield_11_cmta_number
        type: b1
      - id: order_execution_return_bitfield_11_cross_type
        type: b1
      - id: order_execution_return_bitfield_11_cross_prioritization
        type: b1
  order_execution_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_12_cross_id
        type: b1
      - id: order_execution_return_bitfield_12_alloc_qty
        type: b1
      - id: order_execution_return_bitfield_12_give_up_firm_id
        type: b1
      - id: order_execution_return_bitfield_12_routing_firm_id
        type: b1
      - id: order_execution_return_bitfield_12_waiver_type
        type: b1
      - id: order_execution_return_bitfield_12_cross_exclusion_indicator
        type: b1
      - id: order_execution_return_bitfield_12_price_formation
        type: b1
      - id: order_execution_return_bitfield_12_client_qualified_role
        type: b1
  order_execution_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_13_client_id
        type: b1
      - id: order_execution_return_bitfield_13_investor_id
        type: b1
      - id: order_execution_return_bitfield_13_executor_id
        type: b1
      - id: order_execution_return_bitfield_13_order_origination
        type: b1
      - id: order_execution_return_bitfield_13_algo
        type: b1
      - id: order_execution_return_bitfield_13_deferral_reason
        type: b1
      - id: order_execution_return_bitfield_13_investor_qualified_role
        type: b1
      - id: order_execution_return_bitfield_13_executor_qualified_role
        type: b1
  order_execution_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_14_cti_code
        type: b1
      - id: order_execution_return_bitfield_14_manual_order_indicator
        type: b1
      - id: order_execution_return_bitfield_14_operator_id
        type: b1
      - id: order_execution_return_bitfield_14_trade_date
        type: b1
      - id: order_execution_return_bitfield_14_clearing_price
        type: b1
      - id: order_execution_return_bitfield_14_clearing_size
        type: b1
      - id: order_execution_return_bitfield_14_clearing_symbol
        type: b1
      - id: order_execution_return_bitfield_14_reserved_128
        type: b1
  order_execution_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_15_reserved_1
        type: b1
      - id: order_execution_return_bitfield_15_reserved_2
        type: b1
      - id: order_execution_return_bitfield_15_reserved_4
        type: b1
      - id: order_execution_return_bitfield_15_reserved_8
        type: b1
      - id: order_execution_return_bitfield_15_reserved_16
        type: b1
      - id: order_execution_return_bitfield_15_pending_status
        type: b1
      - id: order_execution_return_bitfield_15_drill_thru_protection
        type: b1
      - id: order_execution_return_bitfield_15_multileg_reporting_type
        type: b1
  order_execution_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_16_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_16_leg_maturity_date
        type: b1
      - id: order_execution_return_bitfield_16_leg_strike_price
        type: b1
      - id: order_execution_return_bitfield_16_room_id
        type: b1
      - id: order_execution_return_bitfield_16_secondary_exec_id
        type: b1
      - id: order_execution_return_bitfield_16_user_request_id
        type: b1
      - id: order_execution_return_bitfield_16_sis_username
        type: b1
      - id: order_execution_return_bitfield_16_user_status
        type: b1
  order_execution_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_17_trade_reporting_indicato
        type: b1
      - id: order_execution_return_bitfield_17_equity_party_id
        type: b1
      - id: order_execution_return_bitfield_17_equity_nbbo_protect
        type: b1
      - id: order_execution_return_bitfield_17_mass_cancel_id
        type: b1
      - id: order_execution_return_bitfield_17_trade_publish_ind
        type: b1
      - id: order_execution_return_bitfield_17_report_time
        type: b1
      - id: order_execution_return_bitfield_17_leg_symbol_sfx
        type: b1
      - id: order_execution_return_bitfield_17_client_id_attr
        type: b1
  order_execution_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_18_frequent_trader_id
        type: b1
      - id: order_execution_return_bitfield_18_session_eligibility
        type: b1
      - id: order_execution_return_bitfield_18_combo_order
        type: b1
      - id: order_execution_return_bitfield_18_compression
        type: b1
      - id: order_execution_return_bitfield_18_floor_destination
        type: b1
      - id: order_execution_return_bitfield_18_floor_routing_inst
        type: b1
      - id: order_execution_return_bitfield_18_multi_class_sprd
        type: b1
      - id: order_execution_return_bitfield_18_order_origin
        type: b1
  order_execution_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_19_price_type
        type: b1
      - id: order_execution_return_bitfield_19_strategy_id
        type: b1
      - id: order_execution_return_bitfield_19_trading_session_id
        type: b1
      - id: order_execution_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: order_execution_return_bitfield_19_sender_location_id
        type: b1
      - id: order_execution_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: order_execution_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: order_execution_return_bitfield_19_cust_order_handling_inst
        type: b1
  order_execution_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_20_reserved_1
        type: b1
      - id: order_execution_return_bitfield_20_cross_initiator
        type: b1
      - id: order_execution_return_bitfield_20_subreason
        type: b1
      - id: order_execution_return_bitfield_20_cross_trade_flag
        type: b1
      - id: order_execution_return_bitfield_20_reserved_16
        type: b1
      - id: order_execution_return_bitfield_20_held
        type: b1
      - id: order_execution_return_bitfield_20_locate_broker
        type: b1
      - id: order_execution_return_bitfield_20_reserved_128
        type: b1
  order_execution_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: order_execution_return_bitfield_21_floor_trade_time
        type: b1
      - id: order_execution_return_bitfield_21_equity_ex_destination
        type: b1
      - id: order_execution_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: order_execution_return_bitfield_21_cmc_sessions
        type: b1
      - id: order_execution_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: order_execution_return_bitfield_21_cmc_match_qty
        type: b1
      - id: order_execution_return_bitfield_21_stop_px_type
        type: b1
      - id: order_execution_return_bitfield_21_reserved_128
        type: b1
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
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
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: base_liquidity_indicat
        type: u1
        enum: base_liquidity_indicat
        doc: 'Indicates whether the trade added or removed liquidity. A = Added Liquidity R = Removed Liquidity C = Auction/Uncrossing'
      - id: sub_liquidity_indicato
        type: u1
        enum: sub_liquidity_indicato
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values. ASCII NUL ( 0x00) = No additional information S = Execution from order that set the NBBO B = Step Up Mechanism (C1 and EDGX Only) U = Market Turner (C1 Only) b = AIM (C1 and EDGX Only) s = SAM (C1 and EDGX Only)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
  complex_quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes. Responses, both to the Quote Update and any Quote Executions, Quote Cancellations, and Quote Modification messages will include this identifier. Note: Cboe strongly recommends that QuoteUpdateID be kept unique for a trading day, and CAT reporting requirements mandate that QuoteUpdateID is unique for each Quote Update message sent to the Exchange'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_6
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
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
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: base_liquidity_indicat
        type: u1
        enum: base_liquidity_indicat
        doc: 'Indicates whether the trade added or removed liquidity. A = Added Liquidity R = Removed Liquidity C = Auction/Uncrossing'
      - id: sub_liquidity_indicato
        type: u1
        enum: sub_liquidity_indicato
        doc: 'Cboe may add additional values without notice. Members must gracefully ignore unknown values. ASCII NUL ( 0x00) = No additional information S = Execution from order that set the NBBO B = Step Up Mechanism (C1 and EDGX Only) U = Market Turner (C1 Only) b = AIM (C1 and EDGX Only) s = SAM (C1 and EDGX Only)'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Corresponds to MultilegReportingType (442) in Cboe FIX. Indicates the type of Order Execution message. 1=Single-leg instrument 2=Individual leg of multi-leg instrument'
      - id: secondary_exec_id
        type: u8
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_id
        type: u8
        doc: 'Corresponds to OrderID (37) in Cboe FIX. Order identifier supplied by Cboe. This identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_ref_id
        type: u8
        doc: 'Corresponds to ExecRefID (19) in Cboe FIX. Refers to the ExecID of the fill being cancelled or corrected'
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
      - id: last_px
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: corrected_price
        type: decimal_s8_4
        doc: 'For trade corrections, this is the new trade price. For trade breaks, this is set to 0. Implied decimal with scale 1e-4'
      - id: orig_time
        type: nanosecond_timestamp
        doc: 'Corresponds to OrigTime (42). The date and time of the original trade, in GMT. The UTC date and time of the original trade are available in nanoseconds. Nanoseconds since Unix epoch'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: number_of_return_bitf
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_symbol
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and trade_cancelor_correct_return_bitfield_2.trade_cancelor_correct_return_bitfield_2_capacity
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_maturity_date
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_strike_price
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_put_or_call
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and trade_cancelor_correct_return_bitfield_4.trade_cancelor_correct_return_bitfield_4_open_close
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 5 and trade_cancelor_correct_return_bitfield_5.trade_cancelor_correct_return_bitfield_5_sub_liquidity_indicator
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_return_bitfield_7.trade_cancelor_correct_return_bitfield_7_marketing_fee_code
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_return_bitfield_7.trade_cancelor_correct_return_bitfield_7_target_party_id
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_return_bitfield_7.trade_cancelor_correct_return_bitfield_7_auction_id
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 7 and trade_cancelor_correct_return_bitfield_7.trade_cancelor_correct_return_bitfield_7_cmta_number
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_cancelor_correct_return_bitfield_8.trade_cancelor_correct_return_bitfield_8_cross_id
        doc: 'Corresponds to CrossID (548) in Cboe FIX. Day-unique identifier for the cross order chosen by the client. Characters in the ASCII range 33- 126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol and double quotes'
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_cancelor_correct_return_bitfield_8.trade_cancelor_correct_return_bitfield_8_give_up_firm_id
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and trade_cancelor_correct_return_bitfield_8.trade_cancelor_correct_return_bitfield_8_routing_firm_id
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 12 and trade_cancelor_correct_return_bitfield_12.trade_cancelor_correct_return_bitfield_12_corrected_size
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 15 and trade_cancelor_correct_return_bitfield_15.trade_cancelor_correct_return_bitfield_15_cross_exclusion_indicator
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
      - id: trade_cancelor_correct_return_bitfield_4_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_reserved_32
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_reserved_64
        type: b1
      - id: trade_cancelor_correct_return_bitfield_4_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_trade_report_type_return
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_text
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_bid
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_offer
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_large_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_5_last_mkt
        type: b1
  trade_cancelor_correct_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_6_fee_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_echo_text
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_stop_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_routing_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_rout_strategy
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_route_delivery_method
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_ex_destination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_6_trade_report_ref_id
        type: b1
  trade_cancelor_correct_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_7_marketing_fee_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_target_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_auction_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_order_category
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_liquidity_provision
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_cmta_number
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_cross_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_7_cross_prioritization
        type: b1
  trade_cancelor_correct_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_8_cross_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_alloc_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_give_up_firm_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_routing_firm_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_reserved_16
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_reserved_32
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_reserved_64
        type: b1
      - id: trade_cancelor_correct_return_bitfield_8_reserved_128
        type: b1
  trade_cancelor_correct_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_9_cum_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_day_order_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_day_cum_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_avg_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_day_avg_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_pending_status
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_drill_thru_protection
        type: b1
      - id: trade_cancelor_correct_return_bitfield_9_multileg_reporting_type
        type: b1
  trade_cancelor_correct_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_10_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_leg_maturity_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_leg_strike_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_room_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_secondary_exec_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_user_request_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_sis_username
        type: b1
      - id: trade_cancelor_correct_return_bitfield_10_user_status
        type: b1
  trade_cancelor_correct_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_11_trade_reporting_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_equity_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_equity_nbbo_protect
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_mass_cancel_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_trade_publish_ind
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_report_time
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_leg_symbol_sfx
        type: b1
      - id: trade_cancelor_correct_return_bitfield_11_client_id_attr
        type: b1
  trade_cancelor_correct_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_12_frequent_trader_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_session_eligibility
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_combo_order
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_compression
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_cl_ord_id_batch
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_corrected_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_party_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_12_access_fee
        type: b1
  trade_cancelor_correct_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_13_orig_cl_ord_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_leaves_qty
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_last_shares
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_last_px
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_display_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_working_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_base_liquidity_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_13_expire_time
        type: b1
  trade_cancelor_correct_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_14_secondary_order_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_ccp
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_contra_capacity
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_attributed_quote
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_ext_exec_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_bulk_order_ids
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_bulk_reject_reasons
        type: b1
      - id: trade_cancelor_correct_return_bitfield_14_party_role
        type: b1
  trade_cancelor_correct_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_15_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_reserved_2
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_reserved_4
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_reserved_8
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_waiver_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_cross_exclusion_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_price_formation
        type: b1
      - id: trade_cancelor_correct_return_bitfield_15_client_qualified_role
        type: b1
  trade_cancelor_correct_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_16_client_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_investor_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_executor_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_order_origination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_algo
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_deferral_reason
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_investor_qualified_role
        type: b1
      - id: trade_cancelor_correct_return_bitfield_16_executor_qualified_role
        type: b1
  trade_cancelor_correct_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_17_cti_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_manual_order_indicator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_operator_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_trade_date
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_clearing_price
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_clearing_size
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_clearing_symbol
        type: b1
      - id: trade_cancelor_correct_return_bitfield_17_clearing_optional_data
        type: b1
  trade_cancelor_correct_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_18_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_2
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_4
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_reserved_8
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_floor_destination
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_floor_routing_inst
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_multi_class_sprd
        type: b1
      - id: trade_cancelor_correct_return_bitfield_18_order_origin
        type: b1
  trade_cancelor_correct_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_19_price_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_strategy_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_trading_session_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_sender_location_id
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: trade_cancelor_correct_return_bitfield_19_cust_order_handling_inst
        type: b1
  trade_cancelor_correct_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancelor_correct_return_bitfield_20_reserved_1
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_cross_initiator
        type: b1
      - id: trade_cancelor_correct_return_bitfield_20_subreason
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
      - id: trade_cancelor_correct_return_bitfield_21_stop_px_type
        type: b1
      - id: trade_cancelor_correct_return_bitfield_21_reserved_128
        type: b1
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: purge_reject_reason
        type: u1
        enum: purge_reject_reason
        doc: 'Reason for a purge rejection. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: purge_rejected_return_bitfield_21
        type: purge_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet PurgeRejected byte 21'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and purge_rejected_return_bitfield_17.purge_rejected_return_bitfield_17_mass_cancel_id
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
      - id: purge_rejected_return_bitfield_1_reserved_128
        type: b1
  purge_rejected_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_2_symbol
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_2
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_4
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_8
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_32
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_64
        type: b1
      - id: purge_rejected_return_bitfield_2_reserved_128
        type: b1
  purge_rejected_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_3_sub_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_3_trade_report_type_return
        type: b1
      - id: purge_rejected_return_bitfield_3_trade_publish_ind_return
        type: b1
      - id: purge_rejected_return_bitfield_3_text
        type: b1
      - id: purge_rejected_return_bitfield_3_bid
        type: b1
      - id: purge_rejected_return_bitfield_3_offer
        type: b1
      - id: purge_rejected_return_bitfield_3_large_size
        type: b1
      - id: purge_rejected_return_bitfield_3_last_mkt
        type: b1
  purge_rejected_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_4_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_2
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_4
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_8
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_32
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_64
        type: b1
      - id: purge_rejected_return_bitfield_4_reserved_128
        type: b1
  purge_rejected_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_5_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_5_day_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_5_day_cum_qty
        type: b1
      - id: purge_rejected_return_bitfield_5_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_5_day_avg_px
        type: b1
      - id: purge_rejected_return_bitfield_5_pending_status
        type: b1
      - id: purge_rejected_return_bitfield_5_drill_thru_protection
        type: b1
      - id: purge_rejected_return_bitfield_5_multileg_reporting_type
        type: b1
  purge_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_6_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_6_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_6_currency
        type: b1
      - id: purge_rejected_return_bitfield_6_id_source
        type: b1
      - id: purge_rejected_return_bitfield_6_security_id
        type: b1
      - id: purge_rejected_return_bitfield_6_security_exchange
        type: b1
      - id: purge_rejected_return_bitfield_6_capacity
        type: b1
      - id: purge_rejected_return_bitfield_6_contra_trader
        type: b1
  purge_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_7_account
        type: b1
      - id: purge_rejected_return_bitfield_7_clearing_firm
        type: b1
      - id: purge_rejected_return_bitfield_7_clearing_account
        type: b1
      - id: purge_rejected_return_bitfield_7_display_indicator
        type: b1
      - id: purge_rejected_return_bitfield_7_max_floor
        type: b1
      - id: purge_rejected_return_bitfield_7_discretion_amount
        type: b1
      - id: purge_rejected_return_bitfield_7_order_qty
        type: b1
      - id: purge_rejected_return_bitfield_7_prevent_match
        type: b1
  purge_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_8_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_8_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_8_put_or_call
        type: b1
      - id: purge_rejected_return_bitfield_8_open_close
        type: b1
      - id: purge_rejected_return_bitfield_8_cl_ord_id_batch
        type: b1
      - id: purge_rejected_return_bitfield_8_corrected_size
        type: b1
      - id: purge_rejected_return_bitfield_8_party_id
        type: b1
      - id: purge_rejected_return_bitfield_8_access_fee
        type: b1
  purge_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_9_orig_cl_ord_id
        type: b1
      - id: purge_rejected_return_bitfield_9_leaves_qty
        type: b1
      - id: purge_rejected_return_bitfield_9_last_shares
        type: b1
      - id: purge_rejected_return_bitfield_9_last_px
        type: b1
      - id: purge_rejected_return_bitfield_9_display_price
        type: b1
      - id: purge_rejected_return_bitfield_9_working_price
        type: b1
      - id: purge_rejected_return_bitfield_9_base_liquidity_indicator
        type: b1
      - id: purge_rejected_return_bitfield_9_expire_time
        type: b1
  purge_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_10_secondary_order_id
        type: b1
      - id: purge_rejected_return_bitfield_10_ccp
        type: b1
      - id: purge_rejected_return_bitfield_10_contra_capacity
        type: b1
      - id: purge_rejected_return_bitfield_10_attributed_quote
        type: b1
      - id: purge_rejected_return_bitfield_10_ext_exec_inst
        type: b1
      - id: purge_rejected_return_bitfield_10_bulk_order_ids
        type: b1
      - id: purge_rejected_return_bitfield_10_bulk_reject_reasons
        type: b1
      - id: purge_rejected_return_bitfield_10_party_role
        type: b1
  purge_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_11_reserved_1
        type: b1
      - id: purge_rejected_return_bitfield_11_echo_text
        type: b1
      - id: purge_rejected_return_bitfield_11_stop_px
        type: b1
      - id: purge_rejected_return_bitfield_11_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_11_rout_strategy
        type: b1
      - id: purge_rejected_return_bitfield_11_route_delivery_method
        type: b1
      - id: purge_rejected_return_bitfield_11_ex_destination
        type: b1
      - id: purge_rejected_return_bitfield_11_trade_report_ref_id
        type: b1
  purge_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_12_marketing_fee_code
        type: b1
      - id: purge_rejected_return_bitfield_12_target_party_id
        type: b1
      - id: purge_rejected_return_bitfield_12_auction_id
        type: b1
      - id: purge_rejected_return_bitfield_12_order_category
        type: b1
      - id: purge_rejected_return_bitfield_12_liquidity_provision
        type: b1
      - id: purge_rejected_return_bitfield_12_cmta_number
        type: b1
      - id: purge_rejected_return_bitfield_12_cross_type
        type: b1
      - id: purge_rejected_return_bitfield_12_cross_prioritization
        type: b1
  purge_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_13_cross_id
        type: b1
      - id: purge_rejected_return_bitfield_13_alloc_qty
        type: b1
      - id: purge_rejected_return_bitfield_13_give_up_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_13_routing_firm_id
        type: b1
      - id: purge_rejected_return_bitfield_13_waiver_type
        type: b1
      - id: purge_rejected_return_bitfield_13_cross_exclusion_indicator
        type: b1
      - id: purge_rejected_return_bitfield_13_price_formation
        type: b1
      - id: purge_rejected_return_bitfield_13_client_qualified_role
        type: b1
  purge_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_14_client_id
        type: b1
      - id: purge_rejected_return_bitfield_14_investor_id
        type: b1
      - id: purge_rejected_return_bitfield_14_executor_id
        type: b1
      - id: purge_rejected_return_bitfield_14_order_origination
        type: b1
      - id: purge_rejected_return_bitfield_14_algo
        type: b1
      - id: purge_rejected_return_bitfield_14_deferral_reason
        type: b1
      - id: purge_rejected_return_bitfield_14_investor_qualified_role
        type: b1
      - id: purge_rejected_return_bitfield_14_executor_qualified_role
        type: b1
  purge_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_15_cti_code
        type: b1
      - id: purge_rejected_return_bitfield_15_manual_order_indicator
        type: b1
      - id: purge_rejected_return_bitfield_15_operator_id
        type: b1
      - id: purge_rejected_return_bitfield_15_trade_date
        type: b1
      - id: purge_rejected_return_bitfield_15_clearing_price
        type: b1
      - id: purge_rejected_return_bitfield_15_clearing_size
        type: b1
      - id: purge_rejected_return_bitfield_15_clearing_symbol
        type: b1
      - id: purge_rejected_return_bitfield_15_clearing_optional_data
        type: b1
  purge_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_16_reserved_1
        type: b1
      - id: purge_rejected_return_bitfield_16_leg_maturity_date
        type: b1
      - id: purge_rejected_return_bitfield_16_leg_strike_price
        type: b1
      - id: purge_rejected_return_bitfield_16_room_id
        type: b1
      - id: purge_rejected_return_bitfield_16_secondary_exec_id
        type: b1
      - id: purge_rejected_return_bitfield_16_user_request_id
        type: b1
      - id: purge_rejected_return_bitfield_16_sis_username
        type: b1
      - id: purge_rejected_return_bitfield_16_user_status
        type: b1
  purge_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_17_trade_reporting_indicato
        type: b1
      - id: purge_rejected_return_bitfield_17_equity_party_id
        type: b1
      - id: purge_rejected_return_bitfield_17_equity_nbbo_protect
        type: b1
      - id: purge_rejected_return_bitfield_17_mass_cancel_id
        type: b1
      - id: purge_rejected_return_bitfield_17_trade_publish_ind
        type: b1
      - id: purge_rejected_return_bitfield_17_report_time
        type: b1
      - id: purge_rejected_return_bitfield_17_leg_symbol_sfx
        type: b1
      - id: purge_rejected_return_bitfield_17_client_id_attr
        type: b1
  purge_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_18_frequent_trader_id
        type: b1
      - id: purge_rejected_return_bitfield_18_session_eligibility
        type: b1
      - id: purge_rejected_return_bitfield_18_combo_order
        type: b1
      - id: purge_rejected_return_bitfield_18_compression
        type: b1
      - id: purge_rejected_return_bitfield_18_floor_destination
        type: b1
      - id: purge_rejected_return_bitfield_18_floor_routing_inst
        type: b1
      - id: purge_rejected_return_bitfield_18_multi_class_sprd
        type: b1
      - id: purge_rejected_return_bitfield_18_order_origin
        type: b1
  purge_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_19_price_type
        type: b1
      - id: purge_rejected_return_bitfield_19_strategy_id
        type: b1
      - id: purge_rejected_return_bitfield_19_trading_session_id
        type: b1
      - id: purge_rejected_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: purge_rejected_return_bitfield_19_sender_location_id
        type: b1
      - id: purge_rejected_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: purge_rejected_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: purge_rejected_return_bitfield_19_cust_order_handling_inst
        type: b1
  purge_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: purge_rejected_return_bitfield_20_cross_initiator
        type: b1
      - id: purge_rejected_return_bitfield_20_subreason
        type: b1
      - id: purge_rejected_return_bitfield_20_cross_trade_flag
        type: b1
      - id: purge_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: purge_rejected_return_bitfield_20_held
        type: b1
      - id: purge_rejected_return_bitfield_20_locate_broker
        type: b1
      - id: purge_rejected_return_bitfield_20_reserved_128
        type: b1
  purge_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: purge_rejected_return_bitfield_21_floor_trade_time
        type: b1
      - id: purge_rejected_return_bitfield_21_equity_ex_destination
        type: b1
      - id: purge_rejected_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: purge_rejected_return_bitfield_21_cmc_sessions
        type: b1
      - id: purge_rejected_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: purge_rejected_return_bitfield_21_cmc_match_qty
        type: b1
      - id: purge_rejected_return_bitfield_21_stop_px_type
        type: b1
      - id: purge_rejected_return_bitfield_21_reserved_128
        type: b1
  reset_risk_acknowledgment_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier. Note: Cboe only enforces uniqueness of RiskStatusID values among currently unacknowledged requests. However, we strongly recommend that you keep your RiskStatusID values day-unique'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: '<space> = Ignored; exceeds 1 reset per 100 milliseconds C = Rejected; exceeds Custom Group ID limit D = Rejected; automatic risk resets are disabled E = Rejected; empty ResetRisk field F = Rejected; exceeds firm reset limit I = Rejected; incorrect data center M = Rejected; invalid matching unit S = Rejected; exceeds risk root reset limit U = Rejected; invalid RiskRoot Y = Success c = Rejected; invalid EFID/ClearingFirm y = Rejected; in replay Additional reject values may be added in the future with no notice'
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. This field corresponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: source_matching_unit
        type: u1
        doc: 'Matching unit number on which orders were cancelled by Purge Orders. The default value of this field is ''0'' unless MassCancelInst, 2nd character = ‘I''. This field corresponds to MatchingUnit (25017) in Cboe FIX'
  purge_notification_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
      - id: cancelled_order_count
        type: u4
        doc: 'Number of orders cancelled. This field corresponds to CancelledOrderCount (7696) in Cboe FIX'
      - id: source_matching_unit
        type: u1
        doc: 'Matching unit number on which orders were cancelled by Purge Orders. The default value of this field is ''0'' unless MassCancelInst, 2nd character = ‘I''. This field corresponds to MatchingUnit (25017) in Cboe FIX'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
      - id: mass_cancel_lock_out
        type: u1
        enum: mass_cancel_lock_out
        doc: 'Reported back with the following possible values. Y = Lockout N = No Lockout This field corresponds to Lockout (7697) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: number_of_return_bitf
        type: u1
        doc: 'Number of bitfields to follow'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended'
      - id: purge_notification_return_bitfield_1
        type: purge_notification_return_bitfield_1
        if: number_of_return_bitfields >= 1
        doc: 'BitSet PurgeNotification byte 1'
      - id: purge_notification_return_bitfield_2
        type: purge_notification_return_bitfield_2
        if: number_of_return_bitfields >= 2
        doc: 'BitSet PurgeNotification byte 2'
      - id: purge_notification_return_bitfield_3
        type: purge_notification_return_bitfield_3
        if: number_of_return_bitfields >= 3
        doc: 'BitSet PurgeNotification byte 3'
      - id: purge_notification_return_bitfield_4
        type: purge_notification_return_bitfield_4
        if: number_of_return_bitfields >= 4
        doc: 'BitSet PurgeNotification byte 4'
      - id: purge_notification_return_bitfield_5
        type: purge_notification_return_bitfield_5
        if: number_of_return_bitfields >= 5
        doc: 'BitSet PurgeNotification byte 5'
      - id: purge_notification_return_bitfield_6
        type: purge_notification_return_bitfield_6
        if: number_of_return_bitfields >= 6
        doc: 'BitSet PurgeNotification byte 6'
      - id: purge_notification_return_bitfield_7
        type: purge_notification_return_bitfield_7
        if: number_of_return_bitfields >= 7
        doc: 'BitSet PurgeNotification byte 7'
      - id: purge_notification_return_bitfield_8
        type: purge_notification_return_bitfield_8
        if: number_of_return_bitfields >= 8
        doc: 'BitSet PurgeNotification byte 8'
      - id: purge_notification_return_bitfield_9
        type: purge_notification_return_bitfield_9
        if: number_of_return_bitfields >= 9
        doc: 'BitSet PurgeNotification byte 9'
      - id: purge_notification_return_bitfield_10
        type: purge_notification_return_bitfield_10
        if: number_of_return_bitfields >= 10
        doc: 'BitSet PurgeNotification byte 10'
      - id: purge_notification_return_bitfield_11
        type: purge_notification_return_bitfield_11
        if: number_of_return_bitfields >= 11
        doc: 'BitSet PurgeNotification byte 11'
      - id: purge_notification_return_bitfield_12
        type: purge_notification_return_bitfield_12
        if: number_of_return_bitfields >= 12
        doc: 'BitSet PurgeNotification byte 12'
      - id: purge_notification_return_bitfield_13
        type: purge_notification_return_bitfield_13
        if: number_of_return_bitfields >= 13
        doc: 'BitSet PurgeNotification byte 13'
      - id: purge_notification_return_bitfield_14
        type: purge_notification_return_bitfield_14
        if: number_of_return_bitfields >= 14
        doc: 'BitSet PurgeNotification byte 14'
      - id: purge_notification_return_bitfield_15
        type: purge_notification_return_bitfield_15
        if: number_of_return_bitfields >= 15
        doc: 'BitSet PurgeNotification byte 15'
      - id: purge_notification_return_bitfield_16
        type: purge_notification_return_bitfield_16
        if: number_of_return_bitfields >= 16
        doc: 'BitSet PurgeNotification byte 16'
      - id: purge_notification_return_bitfield_17
        type: purge_notification_return_bitfield_17
        if: number_of_return_bitfields >= 17
        doc: 'BitSet PurgeNotification byte 17'
      - id: purge_notification_return_bitfield_18
        type: purge_notification_return_bitfield_18
        if: number_of_return_bitfields >= 18
        doc: 'BitSet PurgeNotification byte 18'
      - id: purge_notification_return_bitfield_19
        type: purge_notification_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet PurgeNotification byte 19'
  purge_notification_return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_1_side
        type: b1
      - id: purge_notification_return_bitfield_1_peg_difference
        type: b1
      - id: purge_notification_return_bitfield_1_price
        type: b1
      - id: purge_notification_return_bitfield_1_exec_inst
        type: b1
      - id: purge_notification_return_bitfield_1_ord_type
        type: b1
      - id: purge_notification_return_bitfield_1_time_in_force
        type: b1
      - id: purge_notification_return_bitfield_1_min_qty
        type: b1
      - id: purge_notification_return_bitfield_1_reserved_128
        type: b1
  purge_notification_return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_2_symbol
        type: b1
      - id: purge_notification_return_bitfield_2_symbol_sfx
        type: b1
      - id: purge_notification_return_bitfield_2_currency
        type: b1
      - id: purge_notification_return_bitfield_2_id_source
        type: b1
      - id: purge_notification_return_bitfield_2_security_id
        type: b1
      - id: purge_notification_return_bitfield_2_security_exchange
        type: b1
      - id: purge_notification_return_bitfield_2_capacity
        type: b1
      - id: purge_notification_return_bitfield_2_contra_trader
        type: b1
  purge_notification_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_3_account
        type: b1
      - id: purge_notification_return_bitfield_3_clearing_firm
        type: b1
      - id: purge_notification_return_bitfield_3_clearing_account
        type: b1
      - id: purge_notification_return_bitfield_3_display_indicator
        type: b1
      - id: purge_notification_return_bitfield_3_max_floor
        type: b1
      - id: purge_notification_return_bitfield_3_discretion_amount
        type: b1
      - id: purge_notification_return_bitfield_3_order_qty
        type: b1
      - id: purge_notification_return_bitfield_3_prevent_match
        type: b1
  purge_notification_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_4_maturity_date
        type: b1
      - id: purge_notification_return_bitfield_4_strike_price
        type: b1
      - id: purge_notification_return_bitfield_4_put_or_call
        type: b1
      - id: purge_notification_return_bitfield_4_open_close
        type: b1
      - id: purge_notification_return_bitfield_4_cl_ord_id_batch
        type: b1
      - id: purge_notification_return_bitfield_4_corrected_size
        type: b1
      - id: purge_notification_return_bitfield_4_party_id
        type: b1
      - id: purge_notification_return_bitfield_4_access_fee
        type: b1
  purge_notification_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_5_sub_liquidity_indicator
        type: b1
      - id: purge_notification_return_bitfield_5_trade_report_type_return
        type: b1
      - id: purge_notification_return_bitfield_5_trade_publish_ind_return
        type: b1
      - id: purge_notification_return_bitfield_5_text
        type: b1
      - id: purge_notification_return_bitfield_5_bid
        type: b1
      - id: purge_notification_return_bitfield_5_offer
        type: b1
      - id: purge_notification_return_bitfield_5_large_size
        type: b1
      - id: purge_notification_return_bitfield_5_last_mkt
        type: b1
  purge_notification_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_6_fee_code
        type: b1
      - id: purge_notification_return_bitfield_6_echo_text
        type: b1
      - id: purge_notification_return_bitfield_6_stop_px
        type: b1
      - id: purge_notification_return_bitfield_6_routing_inst
        type: b1
      - id: purge_notification_return_bitfield_6_rout_strategy
        type: b1
      - id: purge_notification_return_bitfield_6_route_delivery_method
        type: b1
      - id: purge_notification_return_bitfield_6_ex_destination
        type: b1
      - id: purge_notification_return_bitfield_6_trade_report_ref_id
        type: b1
  purge_notification_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_7_marketing_fee_code
        type: b1
      - id: purge_notification_return_bitfield_7_target_party_id
        type: b1
      - id: purge_notification_return_bitfield_7_auction_id
        type: b1
      - id: purge_notification_return_bitfield_7_order_category
        type: b1
      - id: purge_notification_return_bitfield_7_liquidity_provision
        type: b1
      - id: purge_notification_return_bitfield_7_cmta_number
        type: b1
      - id: purge_notification_return_bitfield_7_cross_type
        type: b1
      - id: purge_notification_return_bitfield_7_cross_prioritization
        type: b1
  purge_notification_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_8_cross_id
        type: b1
      - id: purge_notification_return_bitfield_8_alloc_qty
        type: b1
      - id: purge_notification_return_bitfield_8_give_up_firm_id
        type: b1
      - id: purge_notification_return_bitfield_8_routing_firm_id
        type: b1
      - id: purge_notification_return_bitfield_8_waiver_type
        type: b1
      - id: purge_notification_return_bitfield_8_cross_exclusion_indicator
        type: b1
      - id: purge_notification_return_bitfield_8_price_formation
        type: b1
      - id: purge_notification_return_bitfield_8_client_qualified_role
        type: b1
  purge_notification_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_9_cum_qty
        type: b1
      - id: purge_notification_return_bitfield_9_day_order_qty
        type: b1
      - id: purge_notification_return_bitfield_9_day_cum_qty
        type: b1
      - id: purge_notification_return_bitfield_9_avg_px
        type: b1
      - id: purge_notification_return_bitfield_9_day_avg_px
        type: b1
      - id: purge_notification_return_bitfield_9_pending_status
        type: b1
      - id: purge_notification_return_bitfield_9_drill_thru_protection
        type: b1
      - id: purge_notification_return_bitfield_9_multileg_reporting_type
        type: b1
  purge_notification_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_10_leg_cfi_code
        type: b1
      - id: purge_notification_return_bitfield_10_leg_maturity_date
        type: b1
      - id: purge_notification_return_bitfield_10_leg_strike_price
        type: b1
      - id: purge_notification_return_bitfield_10_room_id
        type: b1
      - id: purge_notification_return_bitfield_10_secondary_exec_id
        type: b1
      - id: purge_notification_return_bitfield_10_user_request_id
        type: b1
      - id: purge_notification_return_bitfield_10_sis_username
        type: b1
      - id: purge_notification_return_bitfield_10_user_status
        type: b1
  purge_notification_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_11_trade_reporting_indicato
        type: b1
      - id: purge_notification_return_bitfield_11_equity_party_id
        type: b1
      - id: purge_notification_return_bitfield_11_equity_nbbo_protect
        type: b1
      - id: purge_notification_return_bitfield_11_mass_cancel_id
        type: b1
      - id: purge_notification_return_bitfield_11_trade_publish_ind
        type: b1
      - id: purge_notification_return_bitfield_11_report_time
        type: b1
      - id: purge_notification_return_bitfield_11_leg_symbol_sfx
        type: b1
      - id: purge_notification_return_bitfield_11_client_id_attr
        type: b1
  purge_notification_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_12_frequent_trader_id
        type: b1
      - id: purge_notification_return_bitfield_12_session_eligibility
        type: b1
      - id: purge_notification_return_bitfield_12_combo_order
        type: b1
      - id: purge_notification_return_bitfield_12_compression
        type: b1
      - id: purge_notification_return_bitfield_12_floor_destination
        type: b1
      - id: purge_notification_return_bitfield_12_floor_routing_inst
        type: b1
      - id: purge_notification_return_bitfield_12_multi_class_sprd
        type: b1
      - id: purge_notification_return_bitfield_12_order_origin
        type: b1
  purge_notification_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_13_orig_cl_ord_id
        type: b1
      - id: purge_notification_return_bitfield_13_leaves_qty
        type: b1
      - id: purge_notification_return_bitfield_13_last_shares
        type: b1
      - id: purge_notification_return_bitfield_13_last_px
        type: b1
      - id: purge_notification_return_bitfield_13_display_price
        type: b1
      - id: purge_notification_return_bitfield_13_working_price
        type: b1
      - id: purge_notification_return_bitfield_13_base_liquidity_indicator
        type: b1
      - id: purge_notification_return_bitfield_13_expire_time
        type: b1
  purge_notification_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_14_secondary_order_id
        type: b1
      - id: purge_notification_return_bitfield_14_ccp
        type: b1
      - id: purge_notification_return_bitfield_14_contra_capacity
        type: b1
      - id: purge_notification_return_bitfield_14_attributed_quote
        type: b1
      - id: purge_notification_return_bitfield_14_ext_exec_inst
        type: b1
      - id: purge_notification_return_bitfield_14_bulk_order_ids
        type: b1
      - id: purge_notification_return_bitfield_14_bulk_reject_reasons
        type: b1
      - id: purge_notification_return_bitfield_14_party_role
        type: b1
  purge_notification_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_15_client_id
        type: b1
      - id: purge_notification_return_bitfield_15_investor_id
        type: b1
      - id: purge_notification_return_bitfield_15_executor_id
        type: b1
      - id: purge_notification_return_bitfield_15_order_origination
        type: b1
      - id: purge_notification_return_bitfield_15_algo
        type: b1
      - id: purge_notification_return_bitfield_15_deferral_reason
        type: b1
      - id: purge_notification_return_bitfield_15_investor_qualified_role
        type: b1
      - id: purge_notification_return_bitfield_15_executor_qualified_role
        type: b1
  purge_notification_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_16_cti_code
        type: b1
      - id: purge_notification_return_bitfield_16_manual_order_indicator
        type: b1
      - id: purge_notification_return_bitfield_16_operator_id
        type: b1
      - id: purge_notification_return_bitfield_16_trade_date
        type: b1
      - id: purge_notification_return_bitfield_16_clearing_price
        type: b1
      - id: purge_notification_return_bitfield_16_clearing_size
        type: b1
      - id: purge_notification_return_bitfield_16_clearing_symbol
        type: b1
      - id: purge_notification_return_bitfield_16_clearing_optional_data
        type: b1
  purge_notification_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_17_price_type
        type: b1
      - id: purge_notification_return_bitfield_17_strategy_id
        type: b1
      - id: purge_notification_return_bitfield_17_trading_session_id
        type: b1
      - id: purge_notification_return_bitfield_17_trade_through_alert_type
        type: b1
      - id: purge_notification_return_bitfield_17_sender_location_id
        type: b1
      - id: purge_notification_return_bitfield_17_floor_trader_acronym
        type: b1
      - id: purge_notification_return_bitfield_17_exec_leg_cfi_code
        type: b1
      - id: purge_notification_return_bitfield_17_cust_order_handling_inst
        type: b1
  purge_notification_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_18_reserved_1
        type: b1
      - id: purge_notification_return_bitfield_18_cross_initiator
        type: b1
      - id: purge_notification_return_bitfield_18_subreason
        type: b1
      - id: purge_notification_return_bitfield_18_cross_trade_flag
        type: b1
      - id: purge_notification_return_bitfield_18_reserved_16
        type: b1
      - id: purge_notification_return_bitfield_18_held
        type: b1
      - id: purge_notification_return_bitfield_18_locate_broker
        type: b1
      - id: purge_notification_return_bitfield_18_reserved_128
        type: b1
  purge_notification_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: purge_notification_return_bitfield_19_floor_trade_time
        type: b1
      - id: purge_notification_return_bitfield_19_equity_ex_destination
        type: b1
      - id: purge_notification_return_bitfield_19_cross_on_behalf_of_id
        type: b1
      - id: purge_notification_return_bitfield_19_cmc_sessions
        type: b1
      - id: purge_notification_return_bitfield_19_intra_firm_trade_ind
        type: b1
      - id: purge_notification_return_bitfield_19_cmc_match_qty
        type: b1
      - id: purge_notification_return_bitfield_19_stop_px_type
        type: b1
      - id: purge_notification_return_bitfield_19_reserved_128
        type: b1
  complex_instrument_accepted_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: revised_legs
        type: u1
        enum: revised_legs
        doc: 'Indicates if the legs on the created complex strategy have been reordered from the original request. If the legs were reordered, the order of the Open- Close fields on a New Complex Order must be the order returned by the exchange, not the order from the original request. 1 = Legs were not reordered 2 = Legs were reordered'
      - id: no_of_securities
        type: u4
        doc: 'Corresponds to NoOfSecurities (8641) in Cboe FIX. Indicates the number of securities created by the member in the trading session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: number_of_return_bitf
        type: u1
        doc: 'Number of bitfields to follow'
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
      - id: complex_instrument_accepted_return_bitfield_19
        type: complex_instrument_accepted_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet ComplexInstrumentAccepted byte 19'
      - id: complex_instrument_accepted_return_bitfield_20
        type: complex_instrument_accepted_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet ComplexInstrumentAccepted byte 20'
      - id: complex_instrument_accepted_return_bitfield_21
        type: complex_instrument_accepted_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet ComplexInstrumentAccepted byte 21'
      - id: num_complex_leg
        type: u1
        doc: 'Corresponds to NoLegs (555) in Cboe FIX. Indicates the number of repeating groups to fol- low. Must be a minimum of 2 and a maximum of 16'
      - id: complex_leg
        type: complex_leg
        repeat: expr
        repeat-expr: num_complex_leg
        doc: 'Repeating group stated NoLegs times'
      - id: leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and complex_instrument_accepted_return_bitfield_6.complex_instrument_accepted_return_bitfield_6_leg_cfi_code
        doc: 'Corresponds to LegCFICode (608) in Cboe FIX. (Optional) CFI Code for leg. Required if LegSymbol is in OSI format. OP = Options Put OC = Options Call E = Equity'
      - id: leg_maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 6 and complex_instrument_accepted_return_bitfield_6.complex_instrument_accepted_return_bitfield_6_leg_maturity_date
        doc: 'Corresponds to LegMaturityDate (611) in Cboe FIX. (Optional) Required if LegSymbol is in OSI format'
      - id: leg_strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 6 and complex_instrument_accepted_return_bitfield_6.complex_instrument_accepted_return_bitfield_6_leg_strike_price
        doc: 'Corresponds to LegStrikePrice (612) in Cboe FIX. (Optional) Option strike price. System maximum is 99,999,999. Must be non-negative. Required if LegSymbol is in OSI format. Implied decimal with scale 1e-4'
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
      - id: complex_instrument_accepted_return_bitfield_1_reserved_128
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
      - id: complex_instrument_accepted_return_bitfield_2_reserved_32
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_reserved_64
        type: b1
      - id: complex_instrument_accepted_return_bitfield_2_reserved_128
        type: b1
  complex_instrument_accepted_return_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_3_sub_liquidity_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_trade_report_type_return
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_trade_publish_ind_return
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_text
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_bid
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_offer
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_large_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_3_last_mkt
        type: b1
  complex_instrument_accepted_return_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_4_fee_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_echo_text
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_stop_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_routing_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_rout_strategy
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_reserved_32
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_reserved_64
        type: b1
      - id: complex_instrument_accepted_return_bitfield_4_reserved_128
        type: b1
  complex_instrument_accepted_return_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_5_cum_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_day_order_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_day_cum_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_avg_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_day_avg_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_pending_status
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_drill_thru_protection
        type: b1
      - id: complex_instrument_accepted_return_bitfield_5_multileg_reporting_type
        type: b1
  complex_instrument_accepted_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_6_leg_cfi_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_leg_maturity_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_leg_strike_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_room_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_secondary_exec_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_security_exchange
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_capacity
        type: b1
      - id: complex_instrument_accepted_return_bitfield_6_contra_trader
        type: b1
  complex_instrument_accepted_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_7_account
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_clearing_firm
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_clearing_account
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_display_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_max_floor
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_discretion_amount
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_order_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_7_prevent_match
        type: b1
  complex_instrument_accepted_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_8_maturity_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_strike_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_put_or_call
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_open_close
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_cl_ord_id_batch
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_corrected_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_8_access_fee
        type: b1
  complex_instrument_accepted_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_9_orig_cl_ord_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_leaves_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_last_shares
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_last_px
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_display_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_working_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_base_liquidity_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_9_expire_time
        type: b1
  complex_instrument_accepted_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_10_secondary_order_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_ccp
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_contra_capacity
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_attributed_quote
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_ext_exec_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_bulk_order_ids
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_bulk_reject_reasons
        type: b1
      - id: complex_instrument_accepted_return_bitfield_10_party_role
        type: b1
  complex_instrument_accepted_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_11_reserved_1
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_reserved_2
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_reserved_4
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_reserved_8
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_reserved_16
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_route_delivery_method
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_ex_destination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_11_trade_report_ref_id
        type: b1
  complex_instrument_accepted_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_12_marketing_fee_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_target_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_auction_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_order_category
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_liquidity_provision
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_cmta_number
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_cross_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_12_cross_prioritization
        type: b1
  complex_instrument_accepted_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_13_cross_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_alloc_qty
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_give_up_firm_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_routing_firm_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_waiver_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_cross_exclusion_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_price_formation
        type: b1
      - id: complex_instrument_accepted_return_bitfield_13_client_qualified_role
        type: b1
  complex_instrument_accepted_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_14_client_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_investor_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_executor_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_order_origination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_algo
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_deferral_reason
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_investor_qualified_role
        type: b1
      - id: complex_instrument_accepted_return_bitfield_14_executor_qualified_role
        type: b1
  complex_instrument_accepted_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_15_cti_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_manual_order_indicator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_operator_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_trade_date
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_clearing_price
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_clearing_size
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_clearing_symbol
        type: b1
      - id: complex_instrument_accepted_return_bitfield_15_clearing_optional_data
        type: b1
  complex_instrument_accepted_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_16_reserved_1
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_reserved_2
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_reserved_4
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_reserved_8
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_reserved_16
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_user_request_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_sis_username
        type: b1
      - id: complex_instrument_accepted_return_bitfield_16_user_status
        type: b1
  complex_instrument_accepted_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_17_trade_reporting_indicato
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_equity_party_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_equity_nbbo_protect
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_mass_cancel_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_trade_publish_ind
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_report_time
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_leg_symbol_sfx
        type: b1
      - id: complex_instrument_accepted_return_bitfield_17_client_id_attr
        type: b1
  complex_instrument_accepted_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_18_frequent_trader_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_session_eligibility
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_combo_order
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_compression
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_floor_destination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_floor_routing_inst
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_multi_class_sprd
        type: b1
      - id: complex_instrument_accepted_return_bitfield_18_order_origin
        type: b1
  complex_instrument_accepted_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_19_price_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_strategy_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_trading_session_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_sender_location_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: complex_instrument_accepted_return_bitfield_19_cust_order_handling_inst
        type: b1
  complex_instrument_accepted_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_20_reserved_1
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_cross_initiator
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_subreason
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_cross_trade_flag
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_reserved_16
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_held
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_locate_broker
        type: b1
      - id: complex_instrument_accepted_return_bitfield_20_reserved_128
        type: b1
  complex_instrument_accepted_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_accepted_return_bitfield_21_floor_trade_time
        type: b1
      - id: complex_instrument_accepted_return_bitfield_21_equity_ex_destination
        type: b1
      - id: complex_instrument_accepted_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: complex_instrument_accepted_return_bitfield_21_cmc_sessions
        type: b1
      - id: complex_instrument_accepted_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: complex_instrument_accepted_return_bitfield_21_cmc_match_qty
        type: b1
  complex_instrument_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection. See Order Reason Codes for a list of possible reasons'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: no_of_securities
        type: u4
        doc: 'Corresponds to NoOfSecurities (8641) in Cboe FIX. Indicates the number of securities created by the member in the trading session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
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
      - id: complex_instrument_rejected_return_bitfield_19
        type: complex_instrument_rejected_return_bitfield_19
        if: number_of_return_bitfields >= 19
        doc: 'BitSet ComplexInstrumentRejected byte 19'
      - id: complex_instrument_rejected_return_bitfield_20
        type: complex_instrument_rejected_return_bitfield_20
        if: number_of_return_bitfields >= 20
        doc: 'BitSet ComplexInstrumentRejected byte 20'
      - id: complex_instrument_rejected_return_bitfield_21
        type: complex_instrument_rejected_return_bitfield_21
        if: number_of_return_bitfields >= 21
        doc: 'BitSet ComplexInstrumentRejected byte 21'
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
      - id: complex_instrument_rejected_return_bitfield_1_reserved_128
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
      - id: complex_instrument_rejected_return_bitfield_5_reserved_8
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_reserved_16
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_reserved_32
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_reserved_64
        type: b1
      - id: complex_instrument_rejected_return_bitfield_5_reserved_128
        type: b1
  complex_instrument_rejected_return_bitfield_6:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_6_sub_liquidity_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_trade_report_type_return
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_trade_publish_ind_return
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_text
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_bid
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_offer
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_large_size
        type: b1
      - id: complex_instrument_rejected_return_bitfield_6_last_mkt
        type: b1
  complex_instrument_rejected_return_bitfield_7:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_7_fee_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_echo_text
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_stop_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_routing_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_rout_strategy
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_route_delivery_method
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_ex_destination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_7_trade_report_ref_id
        type: b1
  complex_instrument_rejected_return_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_8_marketing_fee_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_target_party_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_auction_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_order_category
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_liquidity_provision
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_cmta_number
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_cross_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_8_cross_prioritization
        type: b1
  complex_instrument_rejected_return_bitfield_9:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_9_cross_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_alloc_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_give_up_firm_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_routing_firm_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_waiver_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_cross_exclusion_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_price_formation
        type: b1
      - id: complex_instrument_rejected_return_bitfield_9_client_qualified_role
        type: b1
  complex_instrument_rejected_return_bitfield_10:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_10_client_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_investor_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_executor_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_reserved_8
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_reserved_16
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_reserved_32
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_reserved_64
        type: b1
      - id: complex_instrument_rejected_return_bitfield_10_reserved_128
        type: b1
  complex_instrument_rejected_return_bitfield_11:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_11_cum_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_day_order_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_day_cum_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_avg_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_day_avg_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_pending_status
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_drill_thru_protection
        type: b1
      - id: complex_instrument_rejected_return_bitfield_11_multileg_reporting_type
        type: b1
  complex_instrument_rejected_return_bitfield_12:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_12_leg_cfi_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_leg_maturity_date
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_leg_strike_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_room_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_secondary_exec_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_user_request_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_sis_username
        type: b1
      - id: complex_instrument_rejected_return_bitfield_12_user_status
        type: b1
  complex_instrument_rejected_return_bitfield_13:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_13_trade_reporting_indicato
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_equity_party_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_equity_nbbo_protect
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_mass_cancel_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_trade_publish_ind
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_report_time
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_leg_symbol_sfx
        type: b1
      - id: complex_instrument_rejected_return_bitfield_13_client_id_attr
        type: b1
  complex_instrument_rejected_return_bitfield_14:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_14_frequent_trader_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_session_eligibility
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_combo_order
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_compression
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_floor_destination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_floor_routing_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_multi_class_sprd
        type: b1
      - id: complex_instrument_rejected_return_bitfield_14_order_origin
        type: b1
  complex_instrument_rejected_return_bitfield_15:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_15_price_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_strategy_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_trading_session_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_last_px
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_display_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_working_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_base_liquidity_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_15_expire_time
        type: b1
  complex_instrument_rejected_return_bitfield_16:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_16_secondary_order_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_ccp
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_contra_capacity
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_attributed_quote
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_ext_exec_inst
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_bulk_order_ids
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_bulk_reject_reasons
        type: b1
      - id: complex_instrument_rejected_return_bitfield_16_party_role
        type: b1
  complex_instrument_rejected_return_bitfield_17:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_17_reserved_1
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_reserved_2
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_reserved_4
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_order_origination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_algo
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_deferral_reason
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_investor_qualified_role
        type: b1
      - id: complex_instrument_rejected_return_bitfield_17_executor_qualified_role
        type: b1
  complex_instrument_rejected_return_bitfield_18:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_18_cti_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_manual_order_indicator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_operator_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_trade_date
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_clearing_price
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_clearing_size
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_clearing_symbol
        type: b1
      - id: complex_instrument_rejected_return_bitfield_18_clearing_optional_data
        type: b1
  complex_instrument_rejected_return_bitfield_19:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_19_reserved_1
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_reserved_2
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_reserved_4
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_trade_through_alert_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_sender_location_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_floor_trader_acronym
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_exec_leg_cfi_code
        type: b1
      - id: complex_instrument_rejected_return_bitfield_19_cust_order_handling_inst
        type: b1
  complex_instrument_rejected_return_bitfield_20:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_20_reserved_1
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_cross_initiator
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_subreason
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_cross_trade_flag
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_reserved_16
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_held
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_locate_broker
        type: b1
      - id: complex_instrument_rejected_return_bitfield_20_reserved_128
        type: b1
  complex_instrument_rejected_return_bitfield_21:
    meta:
      bit-endian: le
    seq:
      - id: complex_instrument_rejected_return_bitfield_21_floor_trade_time
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_equity_ex_destination
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_cross_on_behalf_of_id
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_cmc_sessions
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_intra_firm_trade_ind
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_cmc_match_qty
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_stop_px_type
        type: b1
      - id: complex_instrument_rejected_return_bitfield_21_reserved_128
        type: b1
  floor_trade_notification_message:
    seq:
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor acronym of participant submitting trade'
      - id: floor_trade_time
        type: nanosecond_timestamp
        doc: 'Trade time. Nanoseconds since Unix epoch'
      - id: trade_through_alert_type
        type: u1
        enum: trade_through_alert_type
      - id: price_type
        type: u1
        enum: price_type
      - id: reserved_15
        size: 15
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  add_floor_trade_rejected_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        doc: 'Corresponds to MultilegReportingType (442) in Cboe FIX. Indicates the type of Order Execution message. 1=Single-leg instrument 2=Individual leg of multi-leg instrument'
      - id: combo_order
        type: u1
        enum: combo_order
      - id: account
        type: str
        size: 16
        encoding: ASCII
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
      - id: cmta_number
        type: u4
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        doc: 'Floor acronym of participant submitting trade'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: order_qty_binary_4
        type: u4
        doc: 'Corresponds to OrderQty (38) in Cboe FIX. Order quantity. System limit is 999,999 contracts'
      - id: price_binary_price_8
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: open_close
        type: u1
        enum: open_close
      - id: floor_trade_time
        type: nanosecond_timestamp
        doc: 'Trade time. Nanoseconds since Unix epoch'
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm on all internally matched executions'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
      - id: reject_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  floor_trade_confirmation_rejected_message:
    seq:
      - id: cl_ord
        type: str
        size: 20
        encoding: ASCII
        doc: 'Echoed back from the original request'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Report send time (for audit). Nanoseconds since Unix epoch'
      - id: price_type
        type: u1
        enum: price_type
      - id: reserved_15
        size: 15
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: reject_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  delete_floor_trade_rejected_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: symbol_alphanumeric_8
        type: str
        size: 8
        encoding: ASCII
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: strike_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: maturity_date
        type: yyyymmdd_date
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX. 1 = Buy 2 = Sell'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
      - id: reject_text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
  delete_floor_trade_acknowledgement_message:
    seq:
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to ClOrdID (11) in Cboe FIX. ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, pipe, the ‘at’ symbol (@) and double quotes. If the ClOrdID matches a live order, the order will be rejected as duplicate. Note: Cboe only enforces uniqueness of ClOrdID values among currently live orders, which includes long-lived, persisting GTC/GTD orders. However, we strongly recommend that you keep your ClOrdID values unique'
      - id: exec_id
        type: u8
        doc: 'Corresponds to ExecID (17) in Cboe FIX. Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters. Table 2. Example Conversion Decimal Base 36 28294005440239 A1234B567 76335905726621 R248BC23H 728557228187 09AP05V2Z'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

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
    0x41:
      id: 'new_order_cross_message'
      doc: 'New Order Cross Message.'
    0x4b:
      id: 'new_complex_order_message'
      doc: 'New Complex Order Message.'
    0x5a:
      id: 'new_order_cross_multileg_message'
      doc: 'New Order Cross Multileg Message.'
    0x39:
      id: 'cancel_order_message'
      doc: 'Cancel Order Message.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Modify Order Message.'
    0x55:
      id: 'quote_update_message'
      doc: 'Quote Update Message.'
    0x59:
      id: 'quote_update_short_message'
      doc: 'Quote Update (Short) Message.'
    0x84:
      id: 'complex_quote_update_message'
      doc: 'Complex Quote Update Message.'
    0x86:
      id: 'complex_quote_update_short_message'
      doc: 'Complex Quote Update (Short) Message.'
    0x47:
      id: 'purge_orders_message'
      doc: 'Purge Orders Message.'
    0x56:
      id: 'reset_risk_message'
      doc: 'Reset Risk Message.'
    0x4c:
      id: 'new_complex_instrument_message'
      doc: 'New Complex Instrument Message.'
    0x5c:
      id: 'add_floor_trade_message'
      doc: 'Add Floor Trade Message.'
    0x5b:
      id: 'floor_trade_confirmation_message'
      doc: 'Floor Trade Confirmation Message.'
    0x5d:
      id: 'delete_floor_trade_message'
      doc: 'Delete Floor Trade Message.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'Order Acknowledgment Message.'
    0x43:
      id: 'cross_order_acknowledgment_message'
      doc: 'Cross Order Acknowledgment Message.'
    0x51:
      id: 'quote_update_acknowledgment_message'
      doc: 'Quote Update Acknowledgment Message.'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected Message.'
    0x44:
      id: 'cross_order_rejected_message'
      doc: 'Cross Order Rejected Message.'
    0x58:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected Message.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified Message.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated Message.'
    0x52:
      id: 'quote_restated_message'
      doc: 'Quote Restated Message.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected Message.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'Order Cancelled Message.'
    0x53:
      id: 'quote_cancelled_message'
      doc: 'Quote Cancelled Message.'
    0x46:
      id: 'cross_order_cancelled_message'
      doc: 'Cross Order Cancelled Message.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'Cancel Rejected Message.'
    0x2c:
      id: 'order_execution_message'
      doc: 'Order Execution Message.'
    0x54:
      id: 'quote_execution_message'
      doc: 'Quote Execution Message.'
    0x87:
      id: 'complex_quote_execution_message'
      doc: 'Complex Quote Execution Message.'
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
    0x63:
      id: 'purge_notification_message'
      doc: 'Purge Notification Message.'
    0x4d:
      id: 'complex_instrument_accepted_message'
      doc: 'Complex Instrument Accepted Message.'
    0x4e:
      id: 'complex_instrument_rejected_message'
      doc: 'Complex Instrument Rejected Message.'
    0x62:
      id: 'floor_trade_notification_message'
      doc: 'Floor Trade Notification Message.'
    0x5f:
      id: 'add_floor_trade_rejected_message'
      doc: 'Add Floor Trade Rejected Message.'
    0x5e:
      id: 'floor_trade_confirmation_rejected_message'
      doc: 'Floor Trade Confirmation Rejected Message.'
    0x60:
      id: 'delete_floor_trade_rejected_message'
      doc: 'Delete Floor Trade Rejected Message.'
    0x61:
      id: 'delete_floor_trade_acknowledgement_message'
      doc: 'Delete Floor Trade Acknowledgement Message.'
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
      doc: 'Sell Short Stock Leg Only C 1 And Edgx Only'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt Stock Leg Only C 1 And Edgx Only'
  exec_inst:
    0x31:
      id: 'not_held'
      doc: 'Not Held Must Be Routed To The Floor C 1 Only'
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep Directed Or Cboe'
    0x72:
      id: 'settlement_liquidity_1'
      doc: 'Settlement Liquidity 1 C 1 Only'
    0x47:
      id: 'all_or_none'
      doc: 'All Or None Aonc 1 And Edgx Only'
    0x73:
      id: 'sweep_2'
      doc: 'Sweep 2c 1 And Edgx Only Ascii Null 0 X 00 No Special Handling 1 Requires Time In Force 2 And Price 2 Used For New Order Cross And New Order Cross Multileg Messages Only Requires Cross Type 1 Aim'
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
      doc: 'Stop Limit Stop Stop Limit Orders Must Be Set To Time In Force 0 Day 1 Gtc Or 6 Gtd Note Market And Stopstop Limit Orders Are Not Supported During Gth Or Curb Sessions'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day Default Expires At End Of Market Day'
    0x31:
      id: 'gtc_remains_in_system_until_executed_cancelled_or'
      doc: 'Gtc Remains In System Until Executed Cancelled Or Option Expires'
    0x32:
      id: 'at_the_open_will_remain_queued_and_only_interact_in_the'
      doc: 'At The Open Will Remain Queued And Only Interact In The Cboe Opening Process C 2 And Edgx Only Or The Cboe Opening Auction C 1 Only'
    0x33:
      id: 'ioc_portion_not_filled_immediately_is_cancelled'
      doc: 'Ioc Portion Not Filled Immediately Is Cancelled Market Orders Are Implicitly Ioc For Noncomplex Orders'
    0x34:
      id: 'fok_an_ioc_where_the_entire_size_must_be_filled_else_the'
      doc: 'Fok An Ioc Where The Entire Size Must Be Filled Else The Order Will Be Cancelled Back Not Compatible With Step Up Mechanism Sum'
    0x36:
      id: 'gtd_expires_at_specified_expire_time_for_a_specified_day'
      doc: 'Gtd Expires At Specified Expire Time For A Specified Day'
    0x37:
      id: 'at_the_close_orders_held_for_execution_until_180_seconds'
      doc: 'At The Close Orders Held For Execution Until 180 Seconds Before Series Is Scheduled To Close Bulk Quoting Ports Only Support Time In Force Day Or Gtd With A Same Day Expiration On C 1 C 2 And Edgx'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker This Must Be Used For All Quote Update Messages'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x55:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x4e:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office'
    0x4c:
      id: 'non_trading_permit_holder_affiliate'
      doc: 'Non Trading Permit Holder Affiliate C 1 And C 2 Only'
  display_indicator:
    0x56:
      id: 'default_field'
      doc: 'Default As Determined By Port Level Setting Default To S'
    0x50:
      id: 'price_adjust'
      doc: 'Price Adjust'
    0x6d:
      id: 'multiple_price_adjust'
      doc: 'Multiple Price Adjust'
    0x52:
      id: 'reject_the_order_if_it_cannot_be_booked_and_displayed'
      doc: 'Reject The Order If It Cannot Be Booked And Displayed Without Adjustment See Display Indicator Features For Details On Sliding Options'
  put_or_call:
    0x30:
      id: 'put'
      doc: 'Put'
    0x31:
      id: 'call'
      doc: 'Call'
  ex_destination:
    0x41:
      id: 'nyse_arca'
      doc: 'Nyse Arca'
    0x45:
      id: 'nasdaq_ise'
      doc: 'Nasdaq Ise'
    0x46:
      id: 'miax'
      doc: 'Miax'
    0x50:
      id: 'miax_pearl'
      doc: 'Miax Pearl'
    0x44:
      id: 'miax_emerald'
      doc: 'Miax Emerald'
    0x47:
      id: 'edgx_options'
      doc: 'Edgx Options'
    0x48:
      id: 'c_2'
      doc: 'C 2'
    0x49:
      id: 'iex_options'
      doc: 'Iex Options'
    0x4a:
      id: 'mx_2_options'
      doc: 'Mx 2 Options'
    0x4b:
      id: 'box_field'
      doc: 'Box'
    0x4d:
      id: 'memx'
      doc: 'Memx'
    0x4e:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x55:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x57:
      id: 'cboe_options'
      doc: 'Cboe Options C 1'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'bzx_options'
      doc: 'Bzx Options'
    0x67:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq Gemx'
    0x6d:
      id: 'nasdaq_mrx'
      doc: 'Nasdaq Mrx'
    0x77:
      id: 'miax_sapphire'
      doc: 'Miax Sapphire'
  compression:
    0x4e:
      id: 'default_no'
      doc: 'Default No'
    0x59:
      id: 'yes_field'
      doc: 'Yes When Cross Type 5494 This Field Should Not Be Specified'
  floor_routing_inst:
    0x44:
      id: 'direct'
      doc: 'Direct Do Not Attempt To Process Electronically 1'
    0x45:
      id: 'electronic_only'
      doc: 'Electronic Only'
    0x58:
      id: 'route_to_floor_if_unable_to_process_electronically'
      doc: 'Route To Floor If Unable To Process Electronically'
    0x20:
      id: 'port_level_default'
      doc: 'Port Level Default The Default Value For Any Given Port Can Be Changed By Requesting An Update To The Default Floor Routing Inst Port Attribute 1 When Floor Routing Inst Is D Or X Routing Inst Must Be Set To B Or R For Simple Orders Or B For Complex Instruments'
  ors:
    0x4e:
      id: 'default_no'
      doc: 'Default No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  price_type:
    0x30:
      id: 'fixed_cabinet_trade_price'
      doc: 'Fixed Cabinet Trade Price'
    0x32:
      id: 'default_price_per_unit_contract'
      doc: 'Default Price Per Unit Contract'
    0x33:
      id: 'fixed_amount'
      doc: 'Fixed Amount Cash Spread Pricing Only For Complex Orders Routed To The Floor'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None Orders With Capacity M Or N Will Not Be Required To Specify Open Close On Their Orders A Value Of N May Optionally Be Specified Unless The Series Is Limited To Closing Only If The Series Is Limited To Closing Only Transactions Only Capacity M Will Be Permitted To Submit Open Close O If The Order Has Time In Force 3 Ioc And Routing Inst B Or The Order Has Routing Inst P An Open Position Cannot Trade With An Open Position For Series Limited To Closing Only Transactions Even If The Inbound Ioc From The Aggressing Market Maker Is Sent With That Combination Of Tags'
  session_eligibility:
    0x52:
      id: 'default_order_participates_in_regular_trading_hours'
      doc: 'Default Order Participates In Regular Trading Hours'
    0x41:
      id: 'order_participates_in_both_global_and_regular_trading'
      doc: 'Order Participates In Both Global And Regular Trading Hours Also Allows For Participation In Curb Trading Session'
    0x42:
      id: 'order_participates_in_both_rth_and_curb_session'
      doc: 'Order Participates In Both Rth And Curb Session'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_executing_broker_id_to_this_order'
      doc: 'Do Not Attribute Firm Executing Broker Id To This Order Default'
    0x59:
      id: 'attribute_firm_executing_broker_id_to_this_order'
      doc: 'Attribute Firm Executing Broker Id To This Order'
    0x43:
      id: 'attribute_client_id_only'
      doc: 'Attribute Client Id Only'
    0x5a:
      id: 'attribute_both_clearing_firm'
      doc: 'Attribute Both Clearing Firm Efid And Client Id'
  held:
    0x4e:
      id: 'mark_order_as_not_held'
      doc: 'Mark Order As Not Held'
    0x59:
      id: 'mark_order_as_held'
      doc: 'Mark Order As Held Default Value Is N If The Order Is Direct Routed To A Non Par Official On The Floor'
  cross_type:
    0x31:
      id: 'automated_improvement_mechamism'
      doc: 'Automated Improvement Mechamism Aim'
    0x32:
      id: 'qualified_contingent_cross'
      doc: 'Qualified Contingent Cross Qcc'
    0x33:
      id: 'solicitation_cross'
      doc: 'Solicitation Cross Sam C 1 And Edgx Only'
    0x34:
      id: 'position_compression_cross'
      doc: 'Position Compression Cross Pcc C 1 Only'
    0x35:
      id: 'related_futures_cross'
      doc: 'Related Futures Cross Rfc C 1 Only Entry Of Spx Versus Spxw As A Complex Spread Is Not Supported For Pcc'
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
      doc: 'Disabled Default'
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x33:
      id: 'market_x33'
      doc: 'Market No Starting Price Adjustments'
    0x34:
      id: 'limit_x34'
      doc: 'Limit No Starting Price Adjustments'
  last_priority:
    0x30:
      id: 'disabled'
      doc: 'Disabled Default'
    0x31:
      id: 'enabled'
      doc: 'Enabled'
  equity_trade_venue:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_texas'
      doc: 'Nasdaq Texas'
    0x43:
      id: 'nyse_national'
      doc: 'Nyse National'
    0x49:
      id: 'investors_exchange'
      doc: 'Investors Exchange'
    0x4a:
      id: 'cboe_edga_exchange'
      doc: 'Cboe Edga Exchange'
    0x4b:
      id: 'cboe_edgx_exchange'
      doc: 'Cboe Edgx Exchange'
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
    0x58:
      id: 'nasdaq_psx'
      doc: 'Nasdaq Psx'
    0x59:
      id: 'cboe_byx_exchange'
      doc: 'Cboe Byx Exchange'
    0x5a:
      id: 'cboe_bzx_exchange'
      doc: 'Cboe Bzx Exchange'
  leg_position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None Only Orders With An Order Capacity Of M Or N Will Be Allowed To Specify N For Leg Position Effect If The Leg Is Limited To Closing Only Transactions Only C Apacity M Will Be Permitted To Submit Open Close O If The Order Has Time In Force 3 Ioc And Routing Inst B'
  equity_leg_short_sell:
    0x35:
      id: 'sell_short'
      doc: 'Sell Short For Stock Leg'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt For Stock Leg'
  multi_class_sprd:
    0x4e:
      id: 'default_no'
      doc: 'Default No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  combo_order:
    0x4e:
      id: 'default_no'
      doc: 'Default No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  equity_ex_destination:
    0x43:
      id: 'td_securities'
      doc: 'Td Securities Usa Llc Default'
    0x50:
      id: 'penserra_via_nyse_chicago'
      doc: 'Penserra Via Nyse Chicago'
    0x46:
      id: 'fog_equities_via_nyse_chicago'
      doc: 'Fog Equities Via Nyse Chicago'
    0x4c:
      id: 'libucki_co'
      doc: 'Libucki Co Via Nyse Chicago'
    0x53:
      id: 'srt_securities_via_nyse_chicago'
      doc: 'Srt Securities Via Nyse Chicago If Buyer And Seller Do Not Provide Matching Venues The Equity Match Will Be Reported To Td Securities Usa Llc'
  strategy_id:
    0x43:
      id: 'conversion'
      doc: 'Conversion'
    0x52:
      id: 'reversal'
      doc: 'Reversal'
    0x4d:
      id: 'merger'
      doc: 'Merger'
    0x53:
      id: 'short_stock_interest'
      doc: 'Short Stock Interest'
    0x4a:
      id: 'jelly_roll'
      doc: 'Jelly Roll'
    0x46:
      id: 'compression_forum'
      doc: 'Compression Forum'
    0x42:
      id: 'box_spread'
      doc: 'Box Spread'
    0x41:
      id: 'box_swap'
      doc: 'Box Swap'
  tied_hedge:
    0x4e:
      id: 'default_no'
      doc: 'Default No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  posting_instruction:
    0x50:
      id: 'post_only'
      doc: 'Post Only Do Not Remove Liquidity'
    0x42:
      id: 'book_only'
      doc: 'Book Only Allow Removal Of Liquidity Available For Market Makers Only'
    0x4e:
      id: 'book_only_no_slide'
      doc: 'Book Only No Slide'
    0x52:
      id: 'post_only_no_slide'
      doc: 'Post Only No Slide Do Not Remove Liquidity'
    0x49:
      id: 'book_only_ioc'
      doc: 'Book Only Ioc'
  leg_side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
  multileg_reporting_type:
    0x31:
      id: 'singleleg_instrument'
      doc: 'Singleleg Instrument'
    0x32:
      id: 'individual_leg_of_multileg_instrument'
      doc: 'Individual Leg Of Multileg Instrument'
    0x33:
      id: 'entire_multileg_instrument_package'
      doc: 'Entire Multileg Instrument Package'
    0x34:
      id: 'last_individual_leg_of_multileg_instrument'
      doc: 'Last Individual Leg Of Multileg Instrument'
  sub_liquidity_indicator:
    0x53:
      id: 'execution_from_order_that_set_the_nbbo'
      doc: 'Execution From Order That Set The Nbbo'
    0x42:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism C 1 And Edgx Only'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner C 1 Only'
    0x62:
      id: 'aim'
      doc: 'Aim C 1 And Edgx Only'
    0x43:
      id: 'carried'
      doc: 'Carried'
    0x44:
      id: 'done_for_day'
      doc: 'Done For Day'
    0x51:
      id: 'qcc'
      doc: 'Qcc C 1 And Edgx Only'
    0x73:
      id: 'sam'
      doc: 'Sam C 1 And Edgx Only'
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
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
  cross_exclusion_indicator:
    0x4e:
      id: 'contracts_were_executed_in_auction_against_contra_party_or'
      doc: 'Contracts Were Executed In Auction Against Contra Party Or Against A Resting Order When Auction Was Initiated'
    0x59:
      id: 'contracts_were_executed_in_auction_against_another_party'
      doc: 'Contracts Were Executed In Auction Against Another Party'
  quote_reject_reason:
    0x43:
      id: 'invalid_efid'
      doc: 'Invalid Efid Clearing Firm'
    0x44:
      id: 'invalid_wash_id'
      doc: 'Invalid Wash Id'
    0x45:
      id: 'invalid_session_eligibility'
      doc: 'Invalid Session Eligibility'
    0x46:
      id: 'not_enabled_for_quotes'
      doc: 'Not Enabled For Quotes'
    0x49:
      id: 'incorrect_data_center'
      doc: 'Incorrect Data Center'
    0x4c:
      id: 'invalid_quote_cnt'
      doc: 'Invalid Quote Cnt'
    0x4d:
      id: 'symbols_not_on_same_matching_engine'
      doc: 'Symbols Not On Same Matching Engine'
    0x50:
      id: 'invalid_posting_instruction'
      doc: 'Invalid Posting Instruction'
    0x51:
      id: 'invalid_quote_update_id'
      doc: 'Invalid Quote Update Id'
    0x52:
      id: 'risk_root_does_not_match_across_quotes'
      doc: 'Risk Root Does Not Match Across Quotes'
    0x53:
      id: 'symbol_not_found'
      doc: 'Symbol Not Found'
    0x55:
      id: 'message_unable_to_be_sent_to_matching_engine'
      doc: 'Message Unable To Be Sent To Matching Engine'
    0x57:
      id: 'invalid_wash_prevent_type'
      doc: 'Invalid Wash Prevent Type'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x63:
      id: 'invalid_capacity'
      doc: 'Invalid Capacity'
    0x64:
      id: 'close_only'
      doc: 'Close Only'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'invalid_side'
      doc: 'Invalid Side'
    0x74:
      id: 'invalid_send_time'
      doc: 'Invalid Send Time'
    0x75:
      id: 'symbol_range_unreachable'
      doc: 'Symbol Range Unreachable'
    0x78:
      id: 'exceeds_max_size_per_order'
      doc: 'Exceeds Max Size Per Order'
    0x79:
      id: 'quote_received_by_cboe_during_replay'
      doc: 'Quote Received By Cboe During Replay'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x49:
      id: 'ioc_quote_accepted'
      doc: 'Ioc Quote Accepted'
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
      doc: 'Modified But May Remove Liquidity'
    0x56:
      id: 'no_change_existing_constituent_series_quote'
      doc: 'No Change Existing Constituent Series Quote Modify Attempt After Cutoff Time C 1 Only Cancellation'
    0x55:
      id: 'user_cancelled'
      doc: 'User Cancelled Zero Sizeprice Requested Rejection'
    0x61:
      id: 'admin'
      doc: 'Admin'
    0x4f:
      id: 'rejected_doesnt_match_a_known_quote'
      doc: 'Rejected Doesnt Match A Known Quote'
    0x50:
      id: 'rejected_cant_post'
      doc: 'Rejected Cant Post'
    0x66:
      id: 'risk_management_firm_or_custom_group_id'
      doc: 'Risk Management Firm Or Custom Group Id Level'
    0x53:
      id: 'rejected_symbol_not_found'
      doc: 'Rejected Symbol Not Found'
    0x70:
      id: 'rejected_invalid_price'
      doc: 'Rejected Invalid Price'
    0x72:
      id: 'invalid_remove'
      doc: 'Invalid Remove'
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected Other Reason'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x63:
      id: 'rejected_closing_only_series'
      doc: 'Rejected Closing Only Series'
    0x76:
      id: 'rejected_attempt_to_add_constituent_series'
      doc: 'Rejected Attempt To Add Constituent Series Quote After Cutoff Time C 1 Only Additional Reasons Indicating A Reject May Be Added In The Future With No Notice'
  subreason:
    0x41:
      id: 'purgemass_cancel_efid_level_by_user'
      doc: 'Purgemass Cancel Efid Level By User'
    0x42:
      id: 'purgemass_cancel_symbol_level_by_user'
      doc: 'Purgemass Cancel Symbol Level By User'
    0x43:
      id: 'purgemass_cancel_custom_group_id_level_by_user'
      doc: 'Purgemass Cancel Custom Group Id Level By User'
    0x45:
      id: 'efid_level_lockout_by_cboe_trade_desk_admin'
      doc: 'Efid Level Lockout By Cboe Trade Desk Admin'
    0x4a:
      id: 'firm_disconnect'
      doc: 'Firm Disconnect'
    0x4b:
      id: 'me_disconnect'
      doc: 'Me Disconnect'
    0x4c:
      id: 'unregistered_mm_account'
      doc: 'Unregistered Mm Account'
    0x53:
      id: 'minimum_size_requirement_not_met'
      doc: 'Minimum Size Requirement Not Met'
    0x54:
      id: 'cboe_trade_desk_admin'
      doc: 'Cboe Trade Desk Admin'
    0x66:
      id: 'risk_management_efid_level_by_rule'
      doc: 'Risk Management Efid Level By Rule'
    0x73:
      id: 'risk_management_symbol_level_by_rule'
      doc: 'Risk Management Symbol Level By Rule'
    0x2b:
      id: 'risk_management_efid_group_level_by_rule'
      doc: 'Risk Management Efid Group Level By Rule'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x46:
      id: 'could_not_reflect_to_consolidated_quote'
      doc: 'Could Not Reflect To Consolidated Quote Opra'
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
    0x63:
      id: 'only_close_transactions_accepted'
      doc: 'Only Close Transactions Accepted'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x34:
      id: 'after_volatility_cutoff'
      doc: 'After Volatility Cutoff'
  restatement_reason:
    0x45:
      id: 'reduction_of_ord_qty_due_to_equity_leg_reject'
      doc: 'Reduction Of Ord Qty Due To Equity Leg Reject C Only'
    0x46:
      id: 'represented_on_floor'
      doc: 'Represented On Floor C 1 Only'
    0x4c:
      id: 'reload'
      doc: 'Reload'
    0x50:
      id: 'price_sliding_reprice'
      doc: 'Price Sliding Reprice'
    0x51:
      id: 'liquidity_updated'
      doc: 'Liquidity Updated'
    0x52:
      id: 'reroute'
      doc: 'Reroute'
    0x53:
      id: 'ship_and_post'
      doc: 'Ship And Post Swp'
    0x57:
      id: 'wash'
      doc: 'Wash'
    0x66:
      id: 'unsolicited_floor_action'
      doc: 'Unsolicited Floor Action C 1 Only Cboe Reserves The Right To Add New Values As Necessary Without Prior Notice'
  modify_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x46:
      id: 'could_not_reflect_to_consolidated_quote'
      doc: 'Could Not Reflect To Consolidated Quote Opra'
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
    0x63:
      id: 'only_close_transactions_accepted'
      doc: 'Only Close Transactions Accepted'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x34:
      id: 'after_volatility_cutoff'
      doc: 'After Volatility Cutoff'
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x46:
      id: 'could_not_reflect_to_consolidated_quote'
      doc: 'Could Not Reflect To Consolidated Quote Opra'
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
    0x63:
      id: 'only_close_transactions_accepted'
      doc: 'Only Close Transactions Accepted'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x34:
      id: 'after_volatility_cutoff'
      doc: 'After Volatility Cutoff'
  cancel_subreason:
    0x41:
      id: 'purgemass_cancel_efid_level_by_user'
      doc: 'Purgemass Cancel Efid Level By User'
    0x42:
      id: 'purgemass_cancel_symbol_level_by_user'
      doc: 'Purgemass Cancel Symbol Level By User'
    0x43:
      id: 'purgemass_cancel_custom_group_id_level_by_user'
      doc: 'Purgemass Cancel Custom Group Id Level By User'
    0x45:
      id: 'efid_level_lockout_by_cboe_trade_desk_admin'
      doc: 'Efid Level Lockout By Cboe Trade Desk Admin'
    0x4a:
      id: 'firm_disconnect'
      doc: 'Firm Disconnect'
    0x4b:
      id: 'me_disconnect'
      doc: 'Me Disconnect'
    0x4c:
      id: 'unregistered_mm_account'
      doc: 'Unregistered Mm Account'
    0x53:
      id: 'minimum_size_requirement_not_met'
      doc: 'Minimum Size Requirement Not Met'
    0x54:
      id: 'cboe_trade_desk_admin'
      doc: 'Cboe Trade Desk Admin'
    0x66:
      id: 'risk_management_efid_level_by_rule'
      doc: 'Risk Management Efid Level By Rule'
    0x73:
      id: 'risk_management_symbol_level_by_rule'
      doc: 'Risk Management Symbol Level By Rule'
    0x2b:
      id: 'risk_management_efid_group_level_by_rule'
      doc: 'Risk Management Efid Group Level By Rule'
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x46:
      id: 'could_not_reflect_to_consolidated_quote'
      doc: 'Could Not Reflect To Consolidated Quote Opra'
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
    0x63:
      id: 'only_close_transactions_accepted'
      doc: 'Only Close Transactions Accepted'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x34:
      id: 'after_volatility_cutoff'
      doc: 'After Volatility Cutoff'
  trade_through_alert_type:
    0x30:
      id: 'no_trade_through'
      doc: 'No Trade Through'
    0x31:
      id: 'nbbo'
      doc: 'Nbbo'
    0x32:
      id: 'bbo'
      doc: 'Bbo Local Best Bid Or Offer'
    0x33:
      id: 'sbbo'
      doc: 'Sbbo Market Quote Of Complex Derived By Legs'
    0x34:
      id: 'book_trade_through'
      doc: 'Book Trade Through Trade Through Customer Size'
    0x35:
      id: 'due_dilligence_trade_through'
      doc: 'Due Dilligence Trade Through'
  sender_location_id:
    0x46:
      id: 'floor'
      doc: 'Floor'
    0x20:
      id: 'or_not_present_for_electronic_execution'
      doc: 'Or Not Present For Electronic Execution'
  base_liquidity_indicat:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'auction_uncrossing'
      doc: 'Auction Uncrossing'
  sub_liquidity_indicato:
    0x53:
      id: 'execution_from_order_that_set_the_nbbo'
      doc: 'Execution From Order That Set The Nbbo'
    0x42:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism C 1 And Edgx Only'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner C 1 Only'
    0x62:
      id: 'aim'
      doc: 'Aim C 1 And Edgx Only'
    0x73:
      id: 'sam'
      doc: 'Sam C 1 And Edgx Only'
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier Eg Cl Ord Id'
    0x46:
      id: 'could_not_reflect_to_consolidated_quote'
      doc: 'Could Not Reflect To Consolidated Quote Opra'
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
    0x63:
      id: 'only_close_transactions_accepted'
      doc: 'Only Close Transactions Accepted'
    0x66:
      id: 'risk_management_efid_or_custom_group_id_level'
      doc: 'Risk Management Efid Or Custom Group Id Level'
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
    0x77:
      id: 'would_remove_on_unslide'
      doc: 'Would Remove On Unslide'
    0x78:
      id: 'crossed_market'
      doc: 'Crossed Market'
    0x79:
      id: 'order_received_by_cboe_during_replay'
      doc: 'Order Received By Cboe During Replay'
    0x7a:
      id: 'session_end'
      doc: 'Session End'
    0x2b:
      id: 'risk_management_efid_group_level'
      doc: 'Risk Management Efid Group Level'
    0x34:
      id: 'after_volatility_cutoff'
      doc: 'After Volatility Cutoff'
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored Exceeds 1 Reset Per 100 Milliseconds'
    0x43:
      id: 'rejected'
      doc: 'Rejected Exceeds Custom Group Id Limit'
    0x44:
      id: 'rejected_x44'
      doc: 'Rejected Automatic Risk Resets Are Disabled'
    0x45:
      id: 'rejected_x45'
      doc: 'Rejected Empty Reset Risk Field'
    0x46:
      id: 'rejected_x46'
      doc: 'Rejected Exceeds Firm Reset Limit'
    0x49:
      id: 'rejected_x49'
      doc: 'Rejected Incorrect Data Center'
    0x4d:
      id: 'rejected_x4d'
      doc: 'Rejected Invalid Matching Unit'
    0x53:
      id: 'rejected_x53'
      doc: 'Rejected Exceeds Risk Root Reset Limit'
    0x55:
      id: 'rejected_x55'
      doc: 'Rejected Invalid Risk Root'
    0x59:
      id: 'success'
      doc: 'Success'
    0x63:
      id: 'rejected_x63'
      doc: 'Rejected Invalid Efid Clearing Firm'
    0x79:
      id: 'rejected_x79'
      doc: 'Rejected In Replay Additional Reject Values May Be Added In The Future With No Notice'
  mass_cancel_lock_out:
    0x59:
      id: 'lockout'
      doc: 'Lockout'
    0x4e:
      id: 'no_lockout'
      doc: 'No Lockout This Field Corresponds To Lockout 7697 In Cboe Fix'
  revised_legs:
    0x31:
      id: 'legs_were_not_reordered'
      doc: 'Legs Were Not Reordered'
    0x32:
      id: 'legs_were_reordered'
      doc: 'Legs Were Reordered'

