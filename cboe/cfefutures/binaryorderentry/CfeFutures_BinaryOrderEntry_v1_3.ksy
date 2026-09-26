# ---------------------------------------------------------------------
# Kaitai struct definition for: Cboe CfeFutures BinaryOrderEntry Boe v1.3
#
# Protocol:
#   Organization: Chicago Board Options Exchange
#   Protocol: Futures Binary Order Entry
#   Encoding: Cboe Binary Order Entry
#   Version: 1.3
#   Date: 4/21/2020
#   Specification: CBOE_FUTURES_EXCHANGE_BOE_SPECIFICATION.pdf
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
  id: cboe_cfefutures_binaryorderentry_boe_v1_3
  title: Cboe CfeFutures BinaryOrderEntry Boe v1.3
  license: GPL-3.0
  endian: le

doc: 'Chicago Board Options Exchange Cboe Futures Exchange Futures Binary Order Entry Boe v1.3'
doc-ref: http://markets.cboe.com/us/futures/support/technical/

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
        'message_type::purge_order_message': purge_order_message
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
        'message_type::risk_reset_acknowledgment_message': risk_reset_acknowledgment_message
        'message_type::mass_cancel_acknowledgment_message': mass_cancel_acknowledgment_message
        'message_type::tas_restatement_message': tas_restatement_message
        'message_type::variance_restatement_message': variance_restatement_message
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
      - id: order_qty
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_new_order_bitfields >= 2 and new_order_bitfield_2.new_order_bitfield_2_capacity
      - id: account
        type: str
        size: 16
        encoding: ASCII
        if: number_of_new_order_bitfields >= 3 and new_order_bitfield_3.new_order_bitfield_3_account
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
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_risk_reset
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_open_close
      - id: cmta_number
        type: u4
        if: number_of_new_order_bitfields >= 4 and new_order_bitfield_4.new_order_bitfield_4_cmta_number
      - id: stop_px
        type: decimal_s8_4
        if: number_of_new_order_bitfields >= 6 and new_order_bitfield_6.new_order_bitfield_6_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: custom_group_id
        type: u2
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_custom_group_id
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_new_order_bitfields >= 7 and new_order_bitfield_7.new_order_bitfield_7_oeoid
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_new_order_bitfields >= 8 and new_order_bitfield_8.new_order_bitfield_8_frequent_trader_id
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
      - id: new_order_bitfield_1_reserved_8
        type: b1
      - id: new_order_bitfield_1_ord_type
        type: b1
      - id: new_order_bitfield_1_time_in_force
        type: b1
      - id: new_order_bitfield_1_min_qty
        type: b1
      - id: new_order_bitfield_1_reserved_128
        type: b1
  new_order_bitfield_2:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_2_symbol
        type: b1
      - id: new_order_bitfield_2_reserved_2
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
      - id: new_order_bitfield_2_reserved_128
        type: b1
  new_order_bitfield_3:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_3_account
        type: b1
      - id: new_order_bitfield_3_reserved_2
        type: b1
      - id: new_order_bitfield_3_reserved_4
        type: b1
      - id: new_order_bitfield_3_reserved_8
        type: b1
      - id: new_order_bitfield_3_reserved_16
        type: b1
      - id: new_order_bitfield_3_prevent_match
        type: b1
      - id: new_order_bitfield_3_reserved_64
        type: b1
      - id: new_order_bitfield_3_expire_time
        type: b1
  new_order_bitfield_4:
    meta:
      bit-endian: le
    seq:
      - id: new_order_bitfield_4_maturity_date
        type: b1
      - id: new_order_bitfield_4_reserved_2
        type: b1
      - id: new_order_bitfield_4_reserved_4
        type: b1
      - id: new_order_bitfield_4_risk_reset
        type: b1
      - id: new_order_bitfield_4_open_close
        type: b1
      - id: new_order_bitfield_4_cmta_number
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
      - id: new_order_bitfield_5_reserved_2
        type: b1
      - id: new_order_bitfield_5_reserved_4
        type: b1
      - id: new_order_bitfield_5_reserved_8
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
      - id: new_order_bitfield_6_reserved_1
        type: b1
      - id: new_order_bitfield_6_stop_px
        type: b1
      - id: new_order_bitfield_6_reserved_4
        type: b1
      - id: new_order_bitfield_6_reserved_8
        type: b1
      - id: new_order_bitfield_6_reserved_16
        type: b1
      - id: new_order_bitfield_6_reserved_32
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
      - id: new_order_bitfield_8_reserved_1
        type: b1
      - id: new_order_bitfield_8_si_indicator
        type: b1
      - id: new_order_bitfield_8_reserved_4
        type: b1
      - id: new_order_bitfield_8_reserved_8
        type: b1
      - id: new_order_bitfield_8_frequent_trader_id
        type: b1
      - id: new_order_bitfield_8_reserved_32
        type: b1
      - id: new_order_bitfield_8_reserved_64
        type: b1
      - id: new_order_bitfield_8_reserved_128
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
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_clearing_firm
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_product_name
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_mass_cancel_id
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 1 and cancel_order_bitfield_1.cancel_order_bitfield_1_oeoid
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_cancel_order_bitfields >= 2 and cancel_order_bitfield_2.cancel_order_bitfield_2_mass_cancel_inst
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
      - id: cancel_order_bitfield_1_product_name
        type: b1
      - id: cancel_order_bitfield_1_mass_cancel_id
        type: b1
      - id: cancel_order_bitfield_1_reserved_32
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
        type: u1
        enum: cancel_orig_on_reject
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_cancel_orig_on_reject
      - id: side
        type: u1
        enum: side
        if: number_of_modify_order_bitfields >= 1 and modify_order_bitfield_1.modify_order_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: stop_px
        type: decimal_s8_4
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_oeoid
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_modify_order_bitfields >= 2 and modify_order_bitfield_2.modify_order_bitfield_2_frequent_trader_id
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
      - id: modify_order_bitfield_2_manual_order_indicator
        type: b1
      - id: modify_order_bitfield_2_oeoid
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
      - id: cti_code
        type: u1
        enum: cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
      - id: size_modifier
        type: u1
        enum: size_modifier
        doc: 'Controls the behavior of the OrderQty field. Using “R” allows for a TPH to ensure that in-flight fills or cancels do not result in unwanted additional size exposure'
      - id: reserved_6
        size: 6
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
      - id: num_quote_group
        type: u1
        doc: 'Number of repeating groups included in this quote update. Allowed values are 1-20'
      - id: quote_group
        type: quote_group
        repeat: expr
        repeat-expr: num_quote_group
        doc: 'Quote Repeating Group'
  quote_group:
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
      - id: price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u4
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  purge_order_message:
    seq:
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
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
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_clearing_firm
      - id: mass_cancel_inst
        type: str
        size: 16
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_inst
      - id: product_name
        type: str
        size: 6
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_product_name
      - id: mass_cancel_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_mass_cancel_id
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_purge_order_bitfields >= 1 and purge_order_bitfield_1.purge_order_bitfield_1_oeoid
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
      - id: purge_order_bitfield_1_product_name
        type: b1
      - id: purge_order_bitfield_1_mass_cancel_id
        type: b1
      - id: purge_order_bitfield_1_reserved_32
        type: b1
      - id: purge_order_bitfield_1_manual_order_indicator
        type: b1
      - id: purge_order_bitfield_1_oeoid
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
  reset_risk_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk Request'
      - id: risk_reset
        type: str
        size: 8
        encoding: ASCII
      - id: reserved_4
        size: 4
        doc: 'Reserved'
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
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: sub_liquidity_indicator
        type: u1
        enum: sub_liquidity_indicator
        if: number_of_return_bitfields >= 7 and return_bitfield_7.return_bitfield_7_sub_liquidity_indicator
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_cum_qty
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_order_qty
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_cum_qty
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: day_avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  return_bitfield_1:
    meta:
      bit-endian: le
    seq:
      - id: return_bitfield_1_side
        type: b1
      - id: return_bitfield_1_reserved_2
        type: b1
      - id: return_bitfield_1_price
        type: b1
      - id: return_bitfield_1_reserved_8
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
      - id: return_bitfield_3_reserved_8
        type: b1
      - id: return_bitfield_3_reserved_16
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
      - id: return_bitfield_4_reserved_2
        type: b1
      - id: return_bitfield_4_reserved_4
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
      - id: return_bitfield_5_reserved_16
        type: b1
      - id: return_bitfield_5_reserved_32
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
      - id: return_bitfield_6_reserved_8
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
      - id: return_bitfield_8_reserved_2
        type: b1
      - id: return_bitfield_8_stop_px
        type: b1
      - id: return_bitfield_8_reserved_8
        type: b1
      - id: return_bitfield_8_reserved_16
        type: b1
      - id: return_bitfield_8_reserved_32
        type: b1
      - id: return_bitfield_8_reserved_64
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
      - id: return_bitfield_9_cmta_number
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
      - id: return_bitfield_12_cti_code
        type: b1
      - id: return_bitfield_12_manual_order_indicator
        type: b1
      - id: return_bitfield_12_oeoid
        type: b1
      - id: return_bitfield_12_trade_date
        type: b1
      - id: return_bitfield_12_clearing_price
        type: b1
      - id: return_bitfield_12_clearing_size
        type: b1
      - id: return_bitfield_12_clearing_symbol
        type: b1
      - id: return_bitfield_12_reserved_128
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
      - id: return_bitfield_13_reserved_64
        type: b1
      - id: return_bitfield_13_multileg_reporting_type
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
      - id: return_bitfield_16_frequent_trader_id
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
  quote_update_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: quote_reject_reason
        type: str
        size: 1
        encoding: ASCII
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
        doc: 'Reserved for future expansion. To maintain forward compatibility, fill with 0'
  order_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  quote_update_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: quote_reject_reason
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reason for rejection of an entire Quote Update message by the matching engine. If an error is indicated, then no quotes were entered or updated. QuoteCnt will be 0'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future expansion. Filled with 0'
  order_modified_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: leaves_qty
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_leaves_qty
      - id: base_liquidity_indicator
        type: u1
        enum: base_liquidity_indicator
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_base_liquidity_indicator
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  quote_restated_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        doc: 'New working price. Implied decimal with scale 1e-4'
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
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
  order_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
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
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: secondary_order_id
        type: u8
        if: number_of_return_bitfields >= 6 and return_bitfield_6.return_bitfield_6_secondary_order_id
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  quote_cancelled_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        doc: 'Order Cancel Reason'
  cancel_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
      - id: capacity
        type: u1
        enum: capacity
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
  order_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: expire_time
        type: nanosecond_timestamp
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_expire_time
        doc: 'Nanoseconds since Unix epoch'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_trade_date
      - id: clearing_size
        type: u4
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_size
      - id: cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_cum_qty
      - id: day_order_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_order_qty
      - id: day_cum_qty
        type: u4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_cum_qty
      - id: avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: day_avg_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_day_avg_px
        doc: 'Implied decimal with scale 1e-4'
      - id: pending_status
        type: u1
        enum: pending_status
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_pending_status
      - id: multileg_reporting_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_multileg_reporting_type
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_secondary_exec_id
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  quote_execution_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
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
  trade_cancel_or_correct_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 2 and return_bitfield_2.return_bitfield_2_capacity
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: corrected_size
        type: u4
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_corrected_size
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
  purge_rejected_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
        if: number_of_return_bitfields >= 15 and return_bitfield_15.return_bitfield_15_mass_cancel_id
  risk_reset_acknowledgment_message:
    seq:
      - id: risk_status_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'Unique identifier for this Reset Risk Request'
      - id: risk_reset_result
        type: u1
        enum: risk_reset_result
        doc: 'RiskResetResult'
  mass_cancel_acknowledgment_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
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
  tas_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: order_qty
        type: u4
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_order_qty
        doc: 'Order quantity. System limit is 999,999 shares'
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_trade_date
      - id: clearing_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_price
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_size
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_symbol
      - id: multileg_reporting_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_multileg_reporting_type
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_secondary_exec_id
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  variance_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
      - id: reserved_1
        size: 1
        doc: 'Reserved for CBOE internal use'
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
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_side
        doc: 'Corresponds to Side (54) in Cboe FIX'
      - id: price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 1 and return_bitfield_1.return_bitfield_1_price
        doc: 'Implied decimal with scale 1e-4'
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
      - id: symbol_long
        type: str
        size: 8
        encoding: ASCII
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
      - id: prevent_match
        type: str
        size: 3
        encoding: ASCII
        if: number_of_return_bitfields >= 3 and return_bitfield_3.return_bitfield_3_prevent_match
      - id: maturity_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_maturity_date
      - id: open_close
        type: u1
        enum: open_close
        if: number_of_return_bitfields >= 4 and return_bitfield_4.return_bitfield_4_open_close
      - id: orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_orig_cl_ord_id
        doc: 'Corresponds to OrigClOrdID (41) in Cboe FIX. ClOrdID of the order to cancel. For mass cancel requests, must be empty (all zeroes)'
      - id: last_shares
        type: u4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_shares
      - id: last_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 5 and return_bitfield_5.return_bitfield_5_last_px
        doc: 'Implied decimal with scale 1e-4'
      - id: fee_code
        type: str
        size: 2
        encoding: ASCII
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_fee_code
      - id: stop_px
        type: decimal_s8_4
        if: number_of_return_bitfields >= 8 and return_bitfield_8.return_bitfield_8_stop_px
        doc: 'Implied decimal with scale 1e-4'
      - id: cmta_number
        type: u4
        if: number_of_return_bitfields >= 9 and return_bitfield_9.return_bitfield_9_cmta_number
      - id: cti_code
        type: u1
        enum: cti_code
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_cti_code
      - id: manual_order_indicator
        type: u1
        enum: manual_order_indicator
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_manual_order_indicator
      - id: oeoid
        type: str
        size: 18
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_oeoid
      - id: trade_date
        type: yyyymmdd_date
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_trade_date
      - id: clearing_price
        type: decimal_s8_4
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_price
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_size
        type: u4
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_size
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
        if: number_of_return_bitfields >= 12 and return_bitfield_12.return_bitfield_12_clearing_symbol
      - id: multileg_reporting_type
        type: str
        size: 1
        encoding: ASCII
        if: number_of_return_bitfields >= 13 and return_bitfield_13.return_bitfield_13_multileg_reporting_type
      - id: secondary_exec_id
        type: u8
        if: number_of_return_bitfields >= 14 and return_bitfield_14.return_bitfield_14_secondary_exec_id
      - id: frequent_trader_id
        type: str
        size: 6
        encoding: ASCII
        if: number_of_return_bitfields >= 16 and return_bitfield_16.return_bitfield_16_frequent_trader_id
  tas_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
      - id: clearing_symbol
        type: str
        size: 8
        encoding: ASCII
      - id: clearing_price
        type: decimal_s8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: reserved_16
        size: 16
        doc: 'Originally reported fill price is transformed prior to clearing'
  variance_quote_restatement_message:
    seq:
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time the event occurred in the CFE matching engine. Nanoseconds since Unix epoch'
      - id: quote_update_id
        type: str
        size: 16
        encoding: ASCII
        doc: 'ID chosen by the client. Characters in the ASCII range 33-126 are allowed, except for comma, semicolon, and pipe'
      - id: exec_id
        type: u8
        doc: 'Execution ID. Unique across all matching units on a given day. Note: ExecIDs will be represented on ODROP and FIXDROP ports as nine character, base 36 ASCII. Leading zeros should be added if the converted base 36 value is shorter than nine characters'
      - id: symbol_short
        type: str
        size: 6
        encoding: ASCII
        doc: 'Cboe native identifier'
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
        doc: 'Originally reported fill price is transformed prior to clearing'
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
    0x70:
      id: 'quote_update_message'
      doc: 'Request to enter or update one or more quotes'
    0x47:
      id: 'purge_order_message'
      doc: 'Request to cancel a group of orders across all the firm’s sessions.'
    0x56:
      id: 'reset_risk_message'
      doc: 'Reset or release Firm/EFID, Product, or Custom Group ID level lockout conditions resulting from risk profile trips or self-imposed lockouts issued via Cancel Order or Purge Orders messages.'
    0x25:
      id: 'order_acknowledgment_message'
      doc: 'An order has been acknowledged'
    0x71:
      id: 'quote_update_acknowledgment_message'
      doc: 'Quote Update Acknowledgment messages are sent in response to a Quote Update message.'
    0x26:
      id: 'order_rejected_message'
      doc: 'Order Rejected messages are sent in response to a New Order which must be rejected.'
    0x78:
      id: 'quote_update_rejected_message'
      doc: 'Quote Update Rejected messages are sent in response to a Quote Update message when the entire quote block is rejected by the order handler.'
    0x27:
      id: 'order_modified_message'
      doc: 'Order Modified messages are sent in response to a Modify Request to indicate that the order has been successfully modified.'
    0x72:
      id: 'quote_restated_message'
      doc: 'Quote Restated messages are sent to inform the Member that an order has been asynchronously modified for some reason by the Exchange. For quotes, this could happen if the MTP decrement method has been used by an inbound order against a resting quote.'
    0x29:
      id: 'user_modify_rejected_message'
      doc: 'User Modify Rejected messages are sent in response to a Modify Order for an order which cannot be modified.'
    0x2a:
      id: 'order_cancelled_message'
      doc: 'An order has been cancelled.'
    0x73:
      id: 'quote_cancelled_message'
      doc: 'A Quote Cancelled message will be sent to indicate an unsolicited cancellation of a quote entered with a Quote Update message.'
    0x2b:
      id: 'cancel_rejected_message'
      doc: 'A Cancel Rejected message is sent in response to a Cancel Order message to indicate that the cancellation cannot occur. Cancel Rejected messages are unsequenced.'
    0x2c:
      id: 'order_execution_message'
      doc: 'An Order Execution is sent for each fill on an order.'
    0x74:
      id: 'quote_execution_message'
      doc: 'A Quote Execution message is used to indicate an execution has occurred on a resting quote.'
    0x2d:
      id: 'trade_cancel_or_correct_message'
      doc: 'Used to relay a trade which has been cancelled (busted) or corrected (price or size change only).'
    0x48:
      id: 'purge_rejected_message'
      doc: 'A Purge Rejected message is sent in response to a Purge Orders message to indicate that the mass cancellation cannot occur.'
    0x57:
      id: 'risk_reset_acknowledgment_message'
      doc: 'Response to a Reset Risk request.'
    0x36:
      id: 'mass_cancel_acknowledgment_message'
      doc: 'A Mass Cancel Acknowledgment is an unsequenced message sent when a Cancel Order or Purge Orders message requesting a mass cancellation has completed cancelling all individual orders.'
    0x49:
      id: 'tas_restatement_message'
      doc: 'A Tas Restatement is sent post-settlement time for each TAS (VXT) execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution.'
    0x4a:
      id: 'variance_restatement_message'
      doc: 'A Variance Restatement is sent post-settlement time for each VA and VAO execution during the associated business day is used to communicate updated Price, Size and Symbol associated with the cleared execution.'
    0x75:
      id: 'tas_quote_restatement_message'
      doc: 'A TAS Quote Restatement is sent post-settlement time for each TAS (VXT) quote execution during the associated business day to communicate the updated Price and Symbol associated with the cleared execution.'
    0x76:
      id: 'variance_quote_restatement_message'
      doc: 'A Variance Quote Restatement is sent post-settlement time for each VA and VAO execution during the associated business day is used to communicate updated Price, Size and Symbol associated with the cleared execution.'
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
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
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
    0x33:
      id: 'ioc'
      doc: 'Ioc'
    0x34:
      id: 'fok'
      doc: 'Fok'
    0x36:
      id: 'gtd'
      doc: 'Gtd'
  capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x46:
      id: 'firm'
      doc: 'Firm'
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
  cti_code:
    0x31:
      id: 'cti_2'
      doc: 'Cti 2'
    0x32:
      id: 'cti_2_x32'
      doc: 'Cti 2'
    0x33:
      id: 'cti_3'
      doc: 'Cti 3'
    0x34:
      id: 'cti_4'
      doc: 'Cti 4'
  manual_order_indicator:
    0x59:
      id: 'manual_order_entry'
      doc: 'Manual Order Entry'
    0x4e:
      id: 'automated_order_entry'
      doc: 'Automated Order Entry'
    0x31:
      id: 'simple_instrument_execution'
      doc: 'Simple Instrument Execution'
    0x32:
      id: 'simple_instrument_execution_that_is_part_of_a_spread_execution'
      doc: 'Simple Instrument Execution That Is Part Of A Spread Execution'
    0x33:
      id: 'spread_instrument_execution'
      doc: 'Spread Instrument Execution'
  cancel_orig_on_reject:
    0x4e:
      id: 'leave_original_order_alone'
      doc: 'Leave Original Order Alone'
    0x59:
      id: 'cancel_original_order_if_modification_fails'
      doc: 'Cancel Original Order If Modification Fails'
  size_modifier:
    0x52:
      id: 'reduce'
      doc: 'Reduce'
  base_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'market_opening'
      doc: 'Market Opening'
  sub_liquidity_indicator:
    0x43:
      id: 'carried_order_indicator'
      doc: 'Carried Order Indicator'
    0x55:
      id: 'qualifying_market_turner_order'
      doc: 'Qualifying Market Turner Order'
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
    0x73:
      id: 'risk_management_risk_root_level'
      doc: 'Risk Management Risk Root Level'
    0x75:
      id: 'rejected_other_reason'
      doc: 'Rejected Other Reason'
  quote_liquidity_indicator:
    0x43:
      id: 'carried_order_indicator'
      doc: 'Carried Order Indicator'
    0x55:
      id: 'market_turner'
      doc: 'Market Turner'
    0x4e:
      id: 'normal'
      doc: 'Normal'
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
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
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
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
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
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
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
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
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
      doc: 'Pending'
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
    0x66:
      id: 'risk_management_mpid_or_custom_group_id_level'
      doc: 'Risk Management Mpid Or Custom Group Id Level'
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
    0x45:
      id: 'rejected_empty_reset_risk_field'
      doc: 'Rejected Empty Reset Risk Field'
    0x49:
      id: 'rejected_incorrect_data_center'
      doc: 'Rejected Incorrect Data Center'
    0x53:
      id: 'rejected_exceeds_product_level_reset_limit'
      doc: 'Rejected Exceeds Product Level Reset Limit'
    0x55:
      id: 'rejected_invalid_risk_root'
      doc: 'Rejected Invalid Risk Root'
    0x63:
      id: 'rejected_invalid_efid_or_clearing_firm'
      doc: 'Rejected Invalid Efid Or Clearing Firm'
    0x79:
      id: 'rejected_in_replay'
      doc: 'Rejected In Replay'

