# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe EdgxOptions BinaryOrderEntry Boe v2.10
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 2.10
#   Date: 12/3/2019
#   Specification: BATS_US_Options_BOE2_Specification.pdf
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
  id: cboe_edgxoptions_binaryorderentry_boe_v2_10
  title: Cboe EdgxOptions BinaryOrderEntry Boe v2.10
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Edgx Options Binary Order Entry Boe v2.10'
doc-ref: http://markets.cboe.com/us/options/support/technical/

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
        'message_type::new_order_complex_message': new_order_complex_message
        'message_type::new_order_cross_multileg_message': new_order_cross_multileg_message
        'message_type::cancel_order_message': cancel_order_message
        'message_type::modify_order_message': modify_order_message
        'message_type::quote_update_message': quote_update_message
        'message_type::short_quote_update_message': short_quote_update_message
        'message_type::purge_order_message': purge_order_message
        'message_type::risk_reset_message': risk_reset_message
        'message_type::new_complex_instrument_message': new_complex_instrument_message
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
        'message_type::quote_execution_message': quote_execution_message
        'message_type::trade_cancel_or_correct_message': trade_cancel_or_correct_message
        'message_type::purge_rejected_message': purge_rejected_message
        'message_type::reset_risk_acknowledgment_message': reset_risk_acknowledgment_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::complex_instrument_accepted_message': complex_instrument_accepted_message
        'message_type::complex_instrument_rejected_message': complex_instrument_rejected_message
        'message_type::order_execution_message': order_execution_message

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
        doc: 'Message type'
      - id: matching_unit
        type: u1
        doc: 'The matching unit which created this message. Only populated on sequenced, non-session level messages sent from Cboe to the Member; 0 for inbound and all session level messages'
      - id: sequence_number
        type: u4
        doc: 'Last Received Sequence number for the unit'
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
        doc: 'Parameter group header'
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
      - id: num_unit_sequence
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: unit_sequence
        type: unit_sequence
        repeat: expr
        repeat-expr: num_unit_sequence
        doc: 'Unit Sequence'
      - id: num_param_group
        type: u1
        doc: 'A number, n (possibly 0), of parameter groups to follow'
      - id: param_group
        type: param_group
        repeat: expr
        repeat-expr: num_param_group
        doc: 'Parameter group header'
  unit_sequence:
    seq:
      - id: unit_number
        type: u1
        doc: 'A unit number'
      - id: sequence_number
        type: u4
        doc: 'Last Received Sequence number for the unit'
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
      - id: num_unit_sequence
        type: u1
        doc: 'A number, n, of unit/sequence pairs to follow, one per unit. A pair for every unit will be sent, even if no messages have been sent to this port today. For unsuccessful logins, this will be 0'
      - id: unit_sequence
        type: unit_sequence
        repeat: expr
        repeat-expr: num_unit_sequence
        doc: 'Unit Sequence'
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
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: number_of_new_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_display_indicator > 0
      - id: max_remove_pct
        type: u1
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_max_remove_pct > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_put_or_call > 0
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
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_target_party_id > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_session_eligibility > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_bitfields >= 5 and new_order_bitfield_5.new_order_bitfield_5_attributed_quote > 0
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
      - id: auction_id
        type: u8
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_auction_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_routing_firm_id > 0
      - id: custom_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_custom_group_id > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_clearing_optional_data > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_frequent_trader_id > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_order_origin > 0
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_ors > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_new_order_bitfields >= 9 and new_order_bitfield_9.new_order_bitfield_9_price_type > 0
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
      - id: new_order_bitfield_3_max_remove_pct
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
      - id: new_order_bitfield_6_auction_id
        type: b1
      - id: new_order_bitfield_6_routing_firm_id
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
  new_order_bitfield_8:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_8_reserved_1
        type: b1
      - id: new_order_bitfield_8_custom_group_id
        type: b1
      - id: new_order_bitfield_8_clearing_optional_data
        type: b1
      - id: new_order_bitfield_8_client_id_attr
        type: b1
      - id: new_order_bitfield_8_frequent_trader_id
        type: b1
      - id: new_order_bitfield_8_reserved_32
        type: b1
      - id: new_order_bitfield_8_reserved_64
        type: b1
      - id: new_order_bitfield_8_reserved_128
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
      - id: new_order_bitfield_9_reserved_64
        type: b1
      - id: new_order_bitfield_9_reserved_128
        type: b1
  new_order_cross_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: number_of_new_order_cross_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_put_or_call > 0
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_exec_inst > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_attributed_quote > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_target_party_id > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 1 and new_order_cross_bitfield_1.new_order_cross_bitfield_1_prevent_match > 0
      - id: auto_match
        type: u1
        enum: auto_match
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_auto_match > 0
      - id: auto_match_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_auto_match_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: last_priority
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_last_priority > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_account > 0
      - id: cmta_number
        type: u4
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_cmta_number > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_clearing_account > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_routing_firm_id > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 2 and new_order_cross_bitfield_2.new_order_cross_bitfield_2_clearing_optional_data > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_client_id_attr > 0
      - id: equity_trade_price
        type: decimal_s8_4
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_size > 0
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_trade_venue > 0
      - id: equity_transact_time
        type: nanosecond_timestamp
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_transact_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_buy_clearing_firm > 0
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_equity_sell_clearing_firm > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_cross_bitfields >= 3 and new_order_cross_bitfield_3.new_order_cross_bitfield_3_session_eligibility > 0
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_cross_bitfields >= 4 and new_order_cross_bitfield_4.new_order_cross_bitfield_4_ors > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_cross_bitfields >= 4 and new_order_cross_bitfield_4.new_order_cross_bitfield_4_frequent_trader_id > 0
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
      - id: new_order_cross_bitfield_4_reserved_1
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
  new_order_complex_message:
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
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: number_of_new_complex_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_firm > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_clearing_account > 0
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_type
        type: u1
        enum: ord_type
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_ord_type > 0
      - id: time_in_force
        type: u1
        enum: time_in_force
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_time_in_force > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_capacity > 0
      - id: routing_inst
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 1 and new_complex_order_bitfield_1.new_complex_order_bitfield_1_routing_inst > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_account > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_prevent_match > 0
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: cmta_number
        type: u4
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_cmta_number > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_target_party_id > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_attributed_quote > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_echo_text > 0
      - id: auction_id
        type: u8
        if: number_of_new_complex_order_bitfields >= 2 and new_complex_order_bitfield_2.new_complex_order_bitfield_2_auction_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_routing_firm_id > 0
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_drill_thru_protection > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_risk_reset > 0
      - id: custom_group_id
        type: u2
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_custom_group_id > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_equity_party_id > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 3 and new_complex_order_bitfield_3.new_complex_order_bitfield_3_clearing_optional_data > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_frequent_trader_id > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_session_eligibility > 0
      - id: max_floor
        type: u4
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_max_floor > 0
      - id: display_range
        type: u4
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_display_range > 0
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        if: number_of_new_complex_order_bitfields >= 4 and new_complex_order_bitfield_4.new_complex_order_bitfield_4_equity_ex_destination > 0
      - id: equity_leg_short_sell
        type: u1
        enum: equity_leg_short_sell
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_equity_leg_short_sell > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_order_origin > 0
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_ors > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_new_complex_order_bitfields >= 5 and new_complex_order_bitfield_5.new_complex_order_bitfield_5_strategy_id > 0
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_exec_inst > 0
      - id: tied_hedge
        type: u1
        enum: tied_hedge
        if: number_of_new_complex_order_bitfields >= 6 and new_complex_order_bitfield_6.new_complex_order_bitfield_6_tied_hedge > 0
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
      - id: new_complex_order_bitfield_3_reserved_16
        type: b1
      - id: new_complex_order_bitfield_3_equity_party_id
        type: b1
      - id: new_complex_order_bitfield_3_reserved_64
        type: b1
      - id: new_complex_order_bitfield_3_clearing_optional_data
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
      - id: new_complex_order_bitfield_4_reserved_32
        type: b1
      - id: new_complex_order_bitfield_4_reserved_64
        type: b1
      - id: new_complex_order_bitfield_4_equity_ex_destination
        type: b1
  new_complex_order_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_complex_order_bitfield_5_equity_leg_short_sell
        type: b1
      - id: new_complex_order_bitfield_5_reserved_2
        type: b1
      - id: new_complex_order_bitfield_5_reserved_4
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
      - id: new_complex_order_bitfield_6_reserved_8
        type: b1
      - id: new_complex_order_bitfield_6_reserved_16
        type: b1
      - id: new_complex_order_bitfield_6_reserved_32
        type: b1
      - id: new_complex_order_bitfield_6_reserved_64
        type: b1
      - id: new_complex_order_bitfield_6_reserved_128
        type: b1
  new_order_cross_multileg_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: number_of_new_order_cross_multileg_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_exec_inst > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_attributed_quote > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_target_party_id > 0
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 1 and new_order_cross_multileg_bitfield_1.new_order_cross_multileg_bitfield_1_prevent_match > 0
      - id: auto_match
        type: u1
        enum: auto_match
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_auto_match > 0
      - id: auto_match_price
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_auto_match_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: last_priority
        type: str
        size: 1
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_last_priority > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_account > 0
      - id: cmta_number
        type: u4
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_cmta_number > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_clearing_account > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_routing_firm_id > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 2 and new_order_cross_multileg_bitfield_2.new_order_cross_multileg_bitfield_2_clearing_optional_data > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_client_id_attr > 0
      - id: equity_trade_price
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_trade_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_trade_size
        type: u4
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_trade_size > 0
      - id: equity_trade_venue
        type: u1
        enum: equity_trade_venue
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_trade_venue > 0
      - id: equity_transact_time
        type: nanosecond_timestamp
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_transact_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: equity_buy_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_buy_clearing_firm > 0
      - id: equity_sell_clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_equity_sell_clearing_firm > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_new_order_cross_multileg_bitfields >= 3 and new_order_cross_multileg_bitfield_3.new_order_cross_multileg_bitfield_3_session_eligibility > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_equity_party_id > 0
      - id: equity_leg_short_sell
        type: u1
        enum: equity_leg_short_sell
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_equity_leg_short_sell > 0
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_drill_thru_protection > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_ex_destination
        type: u1
        enum: equity_ex_destination
        if: number_of_new_order_cross_multileg_bitfields >= 4 and new_order_cross_multileg_bitfield_4.new_order_cross_multileg_bitfield_4_equity_ex_destination > 0
      - id: ors
        type: u1
        enum: ors
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_ors > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_cross_multileg_bitfields >= 5 and new_order_cross_multileg_bitfield_5.new_order_cross_multileg_bitfield_5_frequent_trader_id > 0
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
      - id: new_order_cross_multileg_bitfield_2_account
        type: b1
      - id: new_order_cross_multileg_bitfield_2_cmta_number
        type: b1
      - id: new_order_cross_multileg_bitfield_2_clearing_account
        type: b1
      - id: new_order_cross_multileg_bitfield_2_routing_firm_id
        type: b1
      - id: new_order_cross_multileg_bitfield_2_clearing_optional_data
        type: b1
  new_order_cross_multileg_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_3_client_id_attr
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_trade_price
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_trade_size
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_trade_venue
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_transact_time
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_buy_clearing_firm
        type: b1
      - id: new_order_cross_multileg_bitfield_3_equity_sell_clearing_firm
        type: b1
      - id: new_order_cross_multileg_bitfield_3_session_eligibility
        type: b1
  new_order_cross_multileg_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_4_equity_party_id
        type: b1
      - id: new_order_cross_multileg_bitfield_4_equity_leg_short_sell
        type: b1
      - id: new_order_cross_multileg_bitfield_4_reserved_4
        type: b1
      - id: new_order_cross_multileg_bitfield_4_reserved_8
        type: b1
      - id: new_order_cross_multileg_bitfield_4_drill_thru_protection
        type: b1
      - id: new_order_cross_multileg_bitfield_4_reserved_32
        type: b1
      - id: new_order_cross_multileg_bitfield_4_equity_ex_destination
        type: b1
      - id: new_order_cross_multileg_bitfield_4_reserved_128
        type: b1
  new_order_cross_multileg_bitfield_5:
    meta:
      bit-endian: le
    seq:
      - id: new_order_cross_multileg_bitfield_5_ors
        type: b1
      - id: new_order_cross_multileg_bitfield_5_frequent_trader_id
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_4
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_8
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_16
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_32
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_64
        type: b1
      - id: new_order_cross_multileg_bitfield_5_reserved_128
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
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: mass_cancel_lockout
        type: u1
        enum: mass_cancel_lockout
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel_lockout > 0
      - id: mass_cancel
        type: str
        size: 1
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel > 0
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_risk_root > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_routing_firm_id > 0
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
      - id: cancel_order_bitfield_1_risk_root
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel_id
        type: b1
      - id: cancel_order_bitfield_1_routing_firm_id
        type: b1
      - id: cancel_order_bitfield_1_reserved_64
        type: b1
      - id: cancel_order_bitfield_1_reserved_128
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
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: number_of_modify_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: price_long
        type: decimal_s8_4
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
      - id: max_floor
        type: u4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_max_floor > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_routing_firm_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_frequent_trader_id > 0
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
      - id: modify_order_bitfield_2_reserved_8
        type: b1
      - id: modify_order_bitfield_2_reserved_16
        type: b1
      - id: modify_order_bitfield_2_frequent_trader_id
        type: b1
      - id: modify_order_bitfield_2_reserved_64
        type: b1
      - id: modify_order_bitfield_2_reserved_128
        type: b1
  quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
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
        doc: 'Optional, may be filled with binary zero (0x00). Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'Posting Instruction'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
      - id: num_quote_update
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote_update
        type: quote_update
        repeat: expr
        repeat-expr: num_quote_update
        doc: 'Quote Update'
  quote_update:
    seq:
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: open_close
        type: u1
        enum: open_close
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  short_quote_update_message:
    seq:
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
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
        doc: 'Optional, may be filled with binary zero (0x00). Nanoseconds since Unix epoch'
      - id: posting_instruction
        type: u1
        enum: posting_instruction
        doc: 'Posting Instruction'
      - id: session_eligibility
        type: u1
        enum: session_eligibility
      - id: num_short_quote_update
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: short_quote_update
        type: short_quote_update
        repeat: expr
        repeat-expr: num_short_quote_update
        doc: 'Short Quote Update'
  short_quote_update:
    seq:
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: open_close
        type: u1
        enum: open_close
      - id: price_short
        type: decimal_s4_4
        doc: 'Limit price. To cancel an existing quote, specify a size of 0. Implied decimal with scale 1e-4'
      - id: order_qty_short
        type: u2
        doc: 'Order quantity. System limit is 999,999 contracts'
      - id: reserved_2
        size: 2
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  purge_order_message:
    seq:
      - id: mass_cancel
        type: str
        size: 1
        encoding: ASCII
      - id: number_of_purge_order_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_clearing_firm > 0
      - id: mass_cancel_lockout
        type: u1
        enum: mass_cancel_lockout
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_lockout > 0
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_inst > 0
      - id: risk_root
        type: str
        size: 6
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_risk_root > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_routing_firm_id > 0
  purge_order_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: purge_order_bitfield_1_clearing_firm
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_lockout
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_inst
        type: b1
      - id: purge_order_bitfield_1_risk_root
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_order_bitfield_1_routing_firm_id
        type: b1
      - id: purge_order_bitfield_1_reserved_64
        type: b1
      - id: purge_order_bitfield_1_reserved_128
        type: b1
  purge_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: purge_order_bitfield_2_reserved_1
        type: b1
      - id: purge_order_bitfield_2_reserved_2
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
  risk_reset_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier'
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
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: number_of_new_complex_instrument_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
      - id: new_complex_instrument_bitfield_1
        type: new_complex_instrument_bitfield_1
        if: number_of_new_complex_instrument_bitfields >= 1
        doc: 'BitSet NewComplexInstrument byte 1'
      - id: leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_cfi_code > 0
      - id: leg_maturity_date
        type: yyyymmdd_date
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_maturity_date > 0
      - id: leg_strike_price
        type: decimal_s8_4
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_leg_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_firm
        type: str
        size: 4
        encoding: ASCII
        if: number_of_new_complex_instrument_bitfields >= 1 and new_complex_instrument_bitfield_1.new_complex_instrument_bitfield_1_clearing_firm > 0
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator > 0
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_optional_data > 0
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_drill_thru_protection > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_session_eligibility > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
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
      - id: return_bitfield_1_max_remove_pct
        type: b1
  return_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_2_symbol
        type: b1
      - id: return_bitfield_2_reserved_2
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
      - id: return_bitfield_3_reserved_32
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
      - id: return_bitfield_4_reserved_16
        type: b1
      - id: return_bitfield_4_corrected_size
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
      - id: return_bitfield_6_contra_capacity
        type: b1
      - id: return_bitfield_6_attributed_quote
        type: b1
      - id: return_bitfield_6_reserved_16
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
      - id: return_bitfield_9_marketing_fee_code
        type: b1
      - id: return_bitfield_9_target_party_id
        type: b1
      - id: return_bitfield_9_auction_id
        type: b1
      - id: return_bitfield_9_reserved_8
        type: b1
      - id: return_bitfield_9_reserved_16
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
      - id: return_bitfield_10_reserved_16
        type: b1
      - id: return_bitfield_10_cross_exclusion_indicator
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
      - id: return_bitfield_13_reserved_32
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
      - id: return_bitfield_14_reserved_8
        type: b1
      - id: return_bitfield_14_secondary_exec_id
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
      - id: return_bitfield_15_equity_party_id
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
      - id: return_bitfield_16_reserved_4
        type: b1
      - id: return_bitfield_16_reserved_8
        type: b1
      - id: return_bitfield_16_reserved_16
        type: b1
      - id: return_bitfield_16_reserved_32
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
      - id: return_bitfield_17_reserved_4
        type: b1
      - id: return_bitfield_17_trade_through_alert_type
        type: b1
      - id: return_bitfield_17_sender_location_id
        type: b1
      - id: return_bitfield_17_floor_trader_acronym
        type: b1
      - id: return_bitfield_17_reserved_64
        type: b1
      - id: return_bitfield_17_reserved_128
        type: b1
  cross_order_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: auction_id
        type: u8
      - id: reserved_1
        size: 1
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_account > 0
      - id: clearing_account
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_clearing_account > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_type > 0
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_prioritization > 0
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_optional_data > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
  quote_update_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Update message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future expansion. Filled with 0'
      - id: num_quote_result_group
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote_result_group
        type: quote_result_group
        repeat: expr
        repeat-expr: num_quote_result_group
        doc: 'Quote Result Group'
  quote_result_group:
    seq:
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: quote_result
        type: u1
        enum: quote_result
        doc: 'Result of the quote request'
      - id: quote_liquidity_indicator
        type: u1
        enum: quote_liquidity_indicator
        doc: 'Quote Liquidity Indicator Values'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future expansion. Filled with 0'
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_session_eligibility > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
  cross_order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_type > 0
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_prioritization > 0
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: quote_reject_reason
        type: u1
        enum: quote_reject_reason
        doc: 'Reason for rejection of an entire Quote Update message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future expansion. Filled with 0'
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator > 0
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_optional_data > 0
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_drill_thru_protection > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: session_eligibility
        type: u1
        enum: session_eligibility
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_session_eligibility > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: leaves_qty
        type: u4
      - id: working_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: quote_restatement_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'The reason for this Quote Restated message'
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
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
        doc: 'Todo'
      - id: reserved_1
        size: 1
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id > 0
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty > 0
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares > 0
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px > 0
        doc: 'Implied decimal with scale 1e-4'
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
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time > 0
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Todo'
  cross_order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: cancel_reason
        type: u1
        enum: cancel_reason
        doc: 'Todo'
      - id: reserved_1
        size: 1
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_exec_inst > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_type > 0
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_prioritization > 0
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: echo_text
        type: str
        size: 64
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_echo_text > 0
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id > 0
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: order_id
        type: u8
        doc: 'Order identifier supplied by Cboe. This Identifier corresponds to the identifiers used in Cboe market data products'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Corresponds to ExecID (17) in Cboe FIX'
      - id: symbol_short
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
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm'
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
      - id: side
        type: u1
        enum: side
        doc: 'Corresponds to Side (54) in Cboe FIX'
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
        doc: 'Corresponds to FeeCode (9882) in Cboe FIX'
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id > 0
  reset_risk_acknowledgment_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk request. Response message will have this corresponding identifier'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: 'RiskResetResult'
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
        doc: 'Todo'
  complex_instrument_accepted_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: revised_legs
        type: u1
        enum: revised_legs
        doc: 'Indicates if the legs on the created complex strategy have been reordered from the original request'
      - id: no_of_securities
        type: u4
        doc: 'Indicates the number of securities created by the member in the trading session. Correspondes to NoOfSecurities (8641) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
      - id: leg_cfi_code
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_leg_cfi_code > 0
      - id: leg_maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_leg_maturity_date > 0
      - id: leg_strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_leg_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
  complex_instrument_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the Cboe Matching Engine (not the time the message was sent). Nanoseconds since Unix epoch'
      - id: order_reject_reason
        type: u1
        enum: order_reject_reason
        doc: 'Reason for an order rejection'
      - id: text
        type: str
        size: 60
        encoding: ASCII
        doc: 'Human readable text with more information about the reject reason'
      - id: no_of_securities
        type: u4
        doc: 'Indicates the number of securities created by the member in the trading session. Correspondes to NoOfSecurities (8641) in Cboe FIX'
      - id: reserved_1
        size: 1
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        doc: 'Execution ID. Unique across all matching units on a given day. Corresponds to ExecID (17) in Cboe FIX'
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
        doc: 'Todo'
      - id: number_of_return_bitfields
        type: u1
        doc: 'Number of bitfields that follow; the fields they gate are appended to the message'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side > 0
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price_long
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: exec_inst
        type: u1
        enum: exec_inst
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
      - id: max_remove_pct
        type: u1
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_max_remove_pct > 0
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity > 0
      - id: contra_trader
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_contra_trader > 0
        doc: 'Displays the EFID (ClearingFirm) of the contra side firm'
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
        type: u1
        enum: display_indicator
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_display_indicator > 0
      - id: max_floor
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_max_floor > 0
      - id: order_qty_long
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match > 0
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date > 0
      - id: strike_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_strike_price > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: put_or_call
        type: u1
        enum: put_or_call
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_put_or_call > 0
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close > 0
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size > 0
      - id: contra_capacity
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_contra_capacity > 0
      - id: attributed_quote
        type: u1
        enum: attributed_quote
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_attributed_quote > 0
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code > 0
        doc: 'Corresponds to FeeCode (9882) in Cboe FIX'
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
        type: u1
        enum: ex_destination
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_ex_destination > 0
      - id: marketing_fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_marketing_fee_code > 0
      - id: target_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_target_party_id > 0
      - id: auction_id
        type: u8
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_auction_id > 0
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number > 0
      - id: cross_type
        type: u1
        enum: cross_type
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_type > 0
        doc: 'Corresponds to CrossType (549) in Cboe FIX. Type of auction order being submitted. This indicates the type of auction that will be initiated upon order entry'
      - id: cross_prioritization
        type: u1
        enum: cross_prioritization
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cross_prioritization > 0
        doc: 'Corresponds to CrossPrioritization (550) in Cboe Fix. Indicates which side of the cross order will be pri-oritized for execution. This identifies the Agency'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_id > 0
        doc: 'Corresponds to CrossID (548) in Cboe FIX'
      - id: alloc_qty
        type: u4
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_alloc_qty > 0
      - id: give_up_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_give_up_firm_id > 0
      - id: routing_firm_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_routing_firm_id > 0
      - id: cross_exclusion_indicator
        type: u1
        enum: cross_exclusion_indicator
        if: number_of_return_bitfields >= 10 and return_bitfield_10.return_bitfield_10_cross_exclusion_indicator > 0
      - id: clearing_optional_data
        type: str
        size: 16
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_optional_data > 0
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_cum_qty > 0
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_order_qty > 0
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_cum_qty > 0
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_avg_px > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: drill_thru_protection
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_drill_thru_protection > 0
        doc: 'Implied decimal with scale 1e-4'
      - id: multileg_reporting_type
        type: u1
        enum: multileg_reporting_type
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_multileg_reporting_type > 0
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_secondary_exec_id > 0
      - id: equity_party_id
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_equity_party_id > 0
      - id: client_id_attr
        type: str
        size: 4
        encoding: ASCII
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_client_id_attr > 0
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id > 0
      - id: multi_class_sprd
        type: u1
        enum: multi_class_sprd
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_multi_class_sprd > 0
      - id: order_origin
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_order_origin > 0
      - id: price_type
        type: u1
        enum: price_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_price_type > 0
      - id: strategy_id
        type: u1
        enum: strategy_id
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_strategy_id > 0
      - id: trade_through_alert_type
        type: u1
        enum: trade_through_alert_type
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_trade_through_alert_type > 0
      - id: sender_location_id
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_sender_location_id > 0
      - id: floor_trader_acronym
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 17 and return_bitfield_17.return_bitfield_17_floor_trader_acronym > 0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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
    0x41:
      id: 'new_order_cross_message'
      doc: 'A New Order Cross message contains the details for both the agency (initiating) and contra side(s) of a cross order (such as an AIM order).'
    0x4b:
      id: 'new_order_complex_message'
      doc: 'A New Complex Order message contains the details required to enter an order on a complex instrument created with previously entered New Complex Instrument request.'
    0x5a:
      id: 'new_order_cross_multileg_message'
      doc: 'A New Order Cross Multileg message contains the details for both the agency (initiating) and contra side(s) of a cross order (such as an AIM order).'
    0x39:
      id: 'cancel_order_message'
      doc: 'Request to cancel either a single order or mass cancellation of a group of orders.'
    0x3a:
      id: 'modify_order_message'
      doc: 'Request to modify an order. T.'
    0x55:
      id: 'quote_update_message'
      doc: 'Request to enter or update one or more quotes.'
    0x59:
      id: 'short_quote_update_message'
      doc: 'A shorter version of Quote Update which restricts the information which can be presented.'
    0x47:
      id: 'purge_order_message'
      doc: 'Request to cancel a group of orders across all the firm’s sessions.'
    0x56:
      id: 'risk_reset_message'
      doc: 'Reset or release Firm, Risk Root, or Custom Group ID level lockout conditions resulting from risk profile trips or self-imposed lockouts issued via Cancel Order or Purge Orders messages.'
    0x4c:
      id: 'new_complex_instrument_message'
      doc: 'A New Complex Instrument message is used to request that the system create a complex strategy.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'An order has been acknowledged'
    0x43:
      id: 'cross_order_acknowledgment_message'
      doc: 'Cross Order Acknowledgment messages are sent in response to New Order Cross and New Order Cross Multileg messages.'
    0x51:
      id: 'quote_update_acknowledgment_message'
      doc: 'Quote Update Acknowledgment messages are sent in response to a Quote Update message.'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected.'
    0x44:
      id: 'cross_order_rejected_message'
      doc: 'Cross Order Rejected messages are sent in response to a New Order Cross and New Order Cross Multileg.'
    0x58:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected messages are sent in response to a Quote Update message when the entire quote block is rejected by the order handler.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Request to indicate that the order has been successfully modified.'
    0x28:
      id: 'order_restated_message'
      doc: 'Order Restated messages are sent to inform the Member that an order has been asynchronously modified.'
    0x52:
      id: 'quote_restated_message'
      doc: 'Quote Restated messages are sent to inform the Member that an order has been asynchronously modified for some reason by the Exchange. For quotes, this could happen if the MTP decrement method has been used by an inbound order against a resting quote.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'An order has been cancelled.'
    0x53:
      id: 'quote_cancelled_message'
      doc: 'A Quote Cancelled message will be sent to indicate an unsolicited cancellation of a quote entered with a Quote Update message.'
    0x46:
      id: 'cross_order_cancelled_message'
      doc: 'A New Order Cross has been cancelled. Individual order allocations from the original New Order Cross and New Order Cross Multileg message will be echoed back in the repeating groups.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur. Cancel Rejected messages are unsequenced.'
    0x54:
      id: 'quote_execution_message'
      doc: 'A Quote Execution message is used to indicate an execution has occurred on a resting quote.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected (price or size change only).'
    0x48:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur.'
    0x57:
      id: 'reset_risk_acknowledgment_message'
      doc: 'Response to a Reset Risk request.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'A Mass Cancel Acknowledgment is an unsequenced message sent when a Cancel Order or Purge Orders message requesting a mass cancellation has completed cancelling all individual orders.'
    0x4d:
      id: 'complex_instrument_accepted_message'
      doc: 'The Complex Instrument Accepted is used to indicate acceptance of a complex strategy.'
    0x4e:
      id: 'complex_instrument_rejected_message'
      doc: 'The Complex Instrument Rejected message is used to indicate that a requested complex strategy has been rejected. Complex Instrument Rejected messages are unsequenced.'
    0x2c:
      id: 'order_execution_message'
      doc: 'An Order Execution is sent for each fill on an order.'
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
      id: 'sell_short'
      doc: 'Sell Short'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
  exec_inst:
    0x66:
      id: 'intermarket_sweep'
      doc: 'Intermarket Sweep'
    0x47:
      id: 'all_or_none'
      doc: 'All Or None'
    0x73:
      id: 'sweep'
      doc: 'Sweep'
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
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x31:
      id: 'gtc'
      doc: 'Gtc'
    0x32:
      id: 'ato'
      doc: 'Ato'
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok'
    0x36:
      id: 'gtd'
      doc: 'Gtd'
    0x37:
      id: 'atc'
      doc: 'Atc'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x55:
      id: 'professional_customer'
      doc: 'Professional Customer'
    0x4e:
      id: 'non_cboe_market_maker'
      doc: 'Non Cboe Market Maker'
    0x42:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office'
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
      id: 'reject_the_order_if_it_cannot_be_booked_and_displayed_without_adjustment'
      doc: 'Reject The Order If It Cannot Be Booked And Displayed Without Adjustment'
  put_or_call:
    0x30:
      id: 'put'
      doc: 'Put'
    0x31:
      id: 'call'
      doc: 'Call'
  open_close:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x4e:
      id: 'none'
      doc: 'None'
  session_eligibility:
    0x41:
      id: 'all'
      doc: 'All'
    0x52:
      id: 'rth'
      doc: 'Rth'
    0x4e:
      id: 'book_only_no_slide'
      doc: 'Book Only No Slide'
  attributed_quote:
    0x4e:
      id: 'do_not_attribute_firm_executing_broker_id'
      doc: 'Do Not Attribute Firm Executing Broker Id'
    0x59:
      id: 'attribute_firm_executing_broker_id'
      doc: 'Attribute Firm Executing Broker Id'
    0x43:
      id: 'attribute_client_id_only'
      doc: 'Attribute Client Id Only'
    0x5a:
      id: 'attribute_both_clearing_firm_and_client_id'
      doc: 'Attribute Both Clearing Firm And Client Id'
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
    0x4b:
      id: 'box_field'
      doc: 'Box'
    0x4e:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
    0x55:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x57:
      id: 'c_1'
      doc: 'C 1'
    0x58:
      id: 'nasdaq_phlx'
      doc: 'Nasdaq Phlx'
    0x5a:
      id: 'bzx_options'
      doc: 'Bzx Options'
    0x67:
      id: 'nasdaq_gemx'
      doc: 'Nasdaq Gemx'
  ors:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  price_type:
    0x30:
      id: 'fixed_cabinet_trade_price'
      doc: 'Fixed Cabinet Trade Price'
    0x31:
      id: 'percentage'
      doc: 'Percentage'
    0x32:
      id: 'price_per_unit'
      doc: 'Price Per Unit'
    0x33:
      id: 'fixed_amount'
      doc: 'Fixed Amount'
  cross_type:
    0x31:
      id: 'aim'
      doc: 'Aim'
    0x32:
      id: 'qcc'
      doc: 'Qcc'
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
      doc: 'Disabled'
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
  equity_trade_venue:
    0x41:
      id: 'nyse_american'
      doc: 'Nyse American'
    0x42:
      id: 'nasdaq_bx'
      doc: 'Nasdaq Bx'
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
  equity_ex_destination:
    0x43:
      id: 'cowen'
      doc: 'Cowen'
  equity_leg_short_sell:
    0x35:
      id: 'sell_short'
      doc: 'Sell Short'
    0x36:
      id: 'sell_short_exempt'
      doc: 'Sell Short Exempt'
    0x30:
      id: 'disabled'
      doc: 'Disabled'
    0x31:
      id: 'enabled'
      doc: 'Enabled'
  multi_class_sprd:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
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
  tied_hedge:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  mass_cancel_lockout:
    0x30:
      id: 'no_lockout'
      doc: 'No Lockout'
    0x31:
      id: 'lockout'
      doc: 'Lockout'
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
      doc: 'Post Only'
    0x42:
      id: 'book_only'
      doc: 'Book Only'
    0x4e:
      id: 'book_only_no_slide'
      doc: 'Book Only No Slide'
    0x52:
      id: 'post_only_no_slide'
      doc: 'Post Only No Slide'
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
    0x53:
      id: 'execution_from_order_that_set_the_nbbo'
      doc: 'Execution From Order That Set The Nbbo'
    0x42:
      id: 'step_up_mechanism'
      doc: 'Step Up Mechanism'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner'
    0x62:
      id: 'aim'
      doc: 'Aim'
    0x43:
      id: 'carried'
      doc: 'Carried'
    0x44:
      id: 'done_for_day'
      doc: 'Done For Day'
    0x71:
      id: 'qcc'
      doc: 'Qcc'
    0x73:
      id: 'sam'
      doc: 'Sam'
  cross_exclusion_indicator:
    0x4e:
      id: 'no_field'
      doc: 'No'
    0x59:
      id: 'yes_field'
      doc: 'Yes'
  quote_reject_reason:
    0x43:
      id: 'invalid_efid'
      doc: 'Invalid Efid'
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
    0x75:
      id: 'symbol_range_unreachable'
      doc: 'Symbol Range Unreachable'
    0x79:
      id: 'quote_received_by_cboe_during_replay'
      doc: 'Quote Received By Cboe During Replay'
  quote_result:
    0x41:
      id: 'new_quote'
      doc: 'New Quote'
    0x4c:
      id: 'modified_loss_of_priority'
      doc: 'Modified Loss Of Priority'
    0x52:
      id: 'modified_retains_priority'
      doc: 'Modified Retains Priority'
    0x4e:
      id: 'no_change_matches_existing_quote'
      doc: 'No Change Matches Existing Quote'
    0x44:
      id: 'new_quote_but_may_remove_liquidity'
      doc: 'New Quote But May Remove Liquidity'
    0x64:
      id: 'modified_but_may_remove_liquidity'
      doc: 'Modified But May Remove Liquidity'
    0x55:
      id: 'user_cancelled'
      doc: 'User Cancelled'
    0x61:
      id: 'admin_rejection'
      doc: 'Admin Rejection'
    0x50:
      id: 'rejected_cant_post'
      doc: 'Rejected Cant Post'
    0x66:
      id: 'risk_management_firm_or_custom_group_id_level'
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
  quote_liquidity_indicator:
    0x4e:
      id: 'normal'
      doc: 'Normal'
    0x53:
      id: 'nbbo_setter'
      doc: 'Nbbo Setter'
    0x4a:
      id: 'nbbo_joiner'
      doc: 'Nbbo Joiner'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner'
    0x20:
      id: 'no_quote_on_book'
      doc: 'No Quote On Book'
  order_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
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
  restatement_reason:
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
      doc: 'Ship And Post'
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
  cancel_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
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
  cancel_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
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
  purge_reject_reason:
    0x41:
      id: 'admin'
      doc: 'Admin'
    0x44:
      id: 'duplicate_identifier'
      doc: 'Duplicate Identifier'
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
  risk_reset_result:
    0x20:
      id: 'ignored'
      doc: 'Ignored'
    0x59:
      id: 'success'
      doc: 'Success'
    0x46:
      id: 'rejected_exceeds_firm_reset_limit'
      doc: 'Rejected Exceeds Firm Reset Limit'
    0x43:
      id: 'rejected_exceeds_custom_group_id_limit'
      doc: 'Rejected Exceeds Custom Group Id Limit'
    0x44:
      id: 'rejected_automatic_risk_resets_are_disabled'
      doc: 'Rejected Automatic Risk Resets Are Disabled'
    0x45:
      id: 'rejected_empty_reset_risk_field'
      doc: 'Rejected Empty Reset Risk Field'
    0x49:
      id: 'rejected_incorrect_data_center'
      doc: 'Rejected Incorrect Data Center'
    0x53:
      id: 'rejected_exceeds_risk_root_reset_limit'
      doc: 'Rejected Exceeds Risk Root Reset Limit'
    0x55:
      id: 'rejected_invalid_risk_root'
      doc: 'Rejected Invalid Risk Root'
    0x63:
      id: 'rejected_invalid_efid_or_clearing_firm'
      doc: 'Rejected Invalid Efid Or Clearing Firm'
    0x79:
      id: 'rejected_in_replay'
      doc: 'Rejected In Replay'
  revised_legs:
    0x31:
      id: 'not_reordered'
      doc: 'Not Reordered'
    0x32:
      id: 'reordered'
      doc: 'Reordered'
  multileg_reporting_type:
    0x31:
      id: 'single_leg_instrument'
      doc: 'Single Leg Instrument'
    0x32:
      id: 'individual_leg_of_multileg_instrument'
      doc: 'Individual Leg Of Multileg Instrument'
    0x33:
      id: 'entire_multileg_package'
      doc: 'Entire Multileg Package'
  trade_through_alert_type:
    0x30:
      id: 'no_trade_through'
      doc: 'No Trade Through'
    0x31:
      id: 'nbbo'
      doc: 'Nbbo'
    0x32:
      id: 'bbo'
      doc: 'Bbo'
    0x33:
      id: 'sbbo'
      doc: 'Sbbo'
    0x34:
      id: 'book_trade_through'
      doc: 'Book Trade Through'
    0x35:
      id: 'due_diligence_trade_through'
      doc: 'Due Diligence Trade Through'

