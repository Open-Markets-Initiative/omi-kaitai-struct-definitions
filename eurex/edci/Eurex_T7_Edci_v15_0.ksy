# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Edci Fbe v15.0
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Extended Derivatives Clearing Interface
#   Encoding: Flat Binary Encoding
#   Version: 15.0
#   Date: 8/26/2026
#   Specification: T7_R.15.0_Enhanced_Drop_Copy_Interface_-_Derivatives_Message_Reference_Version_2.pdf
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
  id: eurex_t7_edci_fbe_v15_0
  title: Eurex T7 Edci Fbe v15.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Extended Derivatives Clearing Interface Fbe v15.0'
doc-ref: https://www.eurex.com/ex-en/support/initiatives/t7release15-0

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Eurex T7 Edci Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Edci Message'
      - id: payload
        size: message_header.body_len - 6
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::cross_request_notification': cross_request_notification
            'template_id::delete_order_broadcast': delete_order_broadcast
            'template_id::enter_clip_request_notification': enter_clip_request_notification
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::legal_notification_broadcast': legal_notification_broadcast
            'template_id::logon_request': logon_request
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::order_exec_report_broadcast': order_exec_report_broadcast
            'template_id::order_reject_notification': order_reject_notification
            'template_id::partition_list_notification': partition_list_notification
            'template_id::party_action_report': party_action_report
            'template_id::party_entitlements_update_report': party_entitlements_update_report
            'template_id::reject': reject
            'template_id::retransmit_request': retransmit_request
            'template_id::retransmit_response': retransmit_response
            'template_id::rfq_notification': rfq_notification
            'template_id::risk_notification_broadcast': risk_notification_broadcast
            'template_id::service_availability_market_broadcast': service_availability_market_broadcast
            'template_id::session_list_notification': session_list_notification
            'template_id::session_status_broadcast': session_status_broadcast
            'template_id::status_broadcast': status_broadcast
            'template_id::trading_action_request': trading_action_request
            'template_id::trading_action_response': trading_action_response
            'template_id::user_login_request': user_login_request
            'template_id::user_login_response': user_login_response
            'template_id::user_logout_request': user_logout_request
            'template_id::user_logout_response': user_logout_response
  message_header:
    seq:
      - id: body_len
        type: u4
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Nullable, No Value = 0xFFFF'
  cross_request_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  rbc_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_group
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_resend_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  delete_order_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_affected_ord_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad2v2
        size: 2
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
  affected_ord_grp_comp:
    seq:
      - id: affected_order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: affected_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: affected_orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: affected_fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: affected_fix_orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  enter_clip_request_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: cross_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_cross_request_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: cross_request_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: root_party_contra_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
      - id: cross_request_side_grp_comp
        type: cross_request_side_grp_comp
        repeat: expr
        repeat-expr: num_cross_request_side_grp_comp
  cross_request_side_grp_comp:
    seq:
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: maximum_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: input_source
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: self_match_prevention_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: cross_match_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_end_client_identification
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  forced_logout_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  notif_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  heartbeat:
    seq:
      - id: pad2
        size: 2
  heartbeat_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
  legal_notification_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: user_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  logon_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: heart_bt_int
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad2v2
        size: 2
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: sender_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  logon_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: heart_bt_int
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: session_instance_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trad_ses_mode
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: default_cstm_appl_ver_sub_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
  response_header_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  logout_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
  logout_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  order_exec_report_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: self_match_prevention_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: cross_match_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: free_text_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_2
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: fix_orig_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_end_client_identification
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
  fills_grp_comp:
    seq:
      - id: fill_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: fill_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: fill_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: fill_exec_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
  order_reject_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_entering_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: session_reject_reason
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  partition_list_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: num_partition_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: partition_grp_comp
        type: partition_grp_comp
        repeat: expr
        repeat-expr: num_partition_grp_comp
  partition_grp_comp:
    seq:
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
  party_action_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_id_executing_system
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: order_deletion_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_action_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: requesting_party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  party_entitlements_update_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_detail_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_id_executing_system
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: list_update_action
        type: u1
        enum: list_update_action
      - id: requesting_party_entering_firm
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: requesting_party_clearing_firm
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_detail_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  reject:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: session_reject_reason
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: session_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  retransmit_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: appl_beg_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_end_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_group
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: ref_appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
  retransmit_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_end_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: ref_appl_last_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_total_message_count
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
  rfq_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  risk_notification_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_detail_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_id_executing_system
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: inventory_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: list_update_action
        type: u1
        enum: list_update_action
      - id: risk_limit_action
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: requesting_party_entering_firm
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: requesting_party_clearing_firm
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
  service_availability_market_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: risk_control_rtm_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: marketwide_analytics_and_risk_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  session_list_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: num_sessions_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: sessions_grp_comp
        type: sessions_grp_comp
        repeat: expr
        repeat-expr: num_sessions_grp_comp
  sessions_grp_comp:
    seq:
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_sponsored_access_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: session_mode
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_sponsored_access_unit
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
  session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: ref_appl_last_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trad_ses_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trad_ses_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  trading_action_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: risk_limit_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_deletion_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_action_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  trading_action_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: num_matching_engine_status_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: matching_engine_status_grp_comp
        type: matching_engine_status_grp_comp
        repeat: expr
        repeat-expr: num_matching_engine_status_grp_comp
  matching_engine_status_grp_comp:
    seq:
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: matching_engine_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad5
        size: 5
  user_login_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: username
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad4
        size: 4
  user_login_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  user_logout_request:
    seq:
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: username
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  user_logout_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
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
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 65535
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 255
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_4_nullable:
    seq:
      - id: value
        type: decimal_u8_4
    instances:
      is_null:
        value: value.mantissa == 9223372036854775808
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u8_8_nullable:
    seq:
      - id: value
        type: decimal_u8_8
    instances:
      is_null:
        value: value.mantissa == 9223372036854775808

enums:
  template_id:
    10907:
      id: 'cross_request_notification'
      doc: 'Cross Request Notification TemplateId'
    10902:
      id: 'delete_order_broadcast'
      doc: 'Delete Order Broadcast TemplateId'
    10906:
      id: 'enter_clip_request_notification'
      doc: 'Enter Clip Request Notification TemplateId'
    10012:
      id: 'forced_logout_notification'
      doc: 'Forced Logout Notification TemplateId'
    10011:
      id: 'heartbeat'
      doc: 'Heartbeat TemplateId'
    10023:
      id: 'heartbeat_notification'
      doc: 'Heartbeat Notification TemplateId'
    10035:
      id: 'legal_notification_broadcast'
      doc: 'Legal Notification Broadcast TemplateId'
    10000:
      id: 'logon_request'
      doc: 'Logon Request TemplateId'
    10001:
      id: 'logon_response'
      doc: 'Logon Response TemplateId'
    10002:
      id: 'logout_request'
      doc: 'Logout Request TemplateId'
    10003:
      id: 'logout_response'
      doc: 'Logout Response TemplateId'
    10901:
      id: 'order_exec_report_broadcast'
      doc: 'Order Exec Report Broadcast TemplateId'
    10014:
      id: 'order_reject_notification'
      doc: 'Order Reject Notification TemplateId'
    10037:
      id: 'partition_list_notification'
      doc: 'Partition List Notification TemplateId'
    10038:
      id: 'party_action_report'
      doc: 'Party Action Report TemplateId'
    10034:
      id: 'party_entitlements_update_report'
      doc: 'Party Entitlements Update Report TemplateId'
    10010:
      id: 'reject'
      doc: 'Reject TemplateId'
    10008:
      id: 'retransmit_request'
      doc: 'Retransmit Request TemplateId'
    10009:
      id: 'retransmit_response'
      doc: 'Retransmit Response TemplateId'
    10905:
      id: 'rfq_notification'
      doc: 'Rfq Notification TemplateId'
    10033:
      id: 'risk_notification_broadcast'
      doc: 'Risk Notification Broadcast TemplateId'
    10044:
      id: 'service_availability_market_broadcast'
      doc: 'Service Availability Market Broadcast TemplateId'
    10036:
      id: 'session_list_notification'
      doc: 'Session List Notification TemplateId'
    10903:
      id: 'session_status_broadcast'
      doc: 'Session Status Broadcast TemplateId'
    10045:
      id: 'status_broadcast'
      doc: 'Status Broadcast TemplateId'
    10908:
      id: 'trading_action_request'
      doc: 'Trading Action Request TemplateId'
    10909:
      id: 'trading_action_response'
      doc: 'Trading Action Response TemplateId'
    10018:
      id: 'user_login_request'
      doc: 'User Login Request TemplateId'
    10019:
      id: 'user_login_response'
      doc: 'User Login Response TemplateId'
    10029:
      id: 'user_logout_request'
      doc: 'User Logout Request TemplateId'
    10024:
      id: 'user_logout_response'
      doc: 'User Logout Response TemplateId'
  appl_resend_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  appl_id:
    6:
      id: 'risk_control'
      doc: 'Risk Control'
    12:
      id: 'order_drop_copy'
      doc: 'OrderDropCopy Data'
  last_fragment:
    0:
      id: 'not_last_message'
      doc: 'Not Last Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x31:
      id: 'partiallyfilled'
      doc: 'Partially filled'
    0x32:
      id: 'filled'
      doc: 'Filled'
    0x34:
      id: 'canceled'
      doc: 'Cancelled'
    0x36:
      id: 'pending_cancel'
      doc: 'Pending Cancel (i.e. result of Order Cancel Request)'
    0x39:
      id: 'suspended'
      doc: 'Suspended'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'canceled'
      doc: 'Cancelled'
    0x35:
      id: 'replaced'
      doc: 'Replaced'
    0x36:
      id: 'pending_cancele'
      doc: 'Pending Cancel (e.g. result of Order Cancel Request)'
    0x39:
      id: 'suspended'
      doc: 'Suspended'
    0x44:
      id: 'restated'
      doc: 'Restated'
    0x4c:
      id: 'triggered'
      doc: 'Triggered'
    0x46:
      id: 'trade'
      doc: 'Trade'
  product_complex:
    1:
      id: 'simpleinstrument'
      doc: 'Simple instrument'
    2:
      id: 'standardoptionstrategy'
      doc: 'Standard Option Strategy'
    3:
      id: 'nonstandardoptionstrategy'
      doc: 'Non-Standard Option Strategy'
    4:
      id: 'volatilitystrategy'
      doc: 'Volatility Strategy'
    5:
      id: 'futures_spread'
      doc: 'Futures Spread'
    6:
      id: 'interproductspread'
      doc: 'Inter-Product Spread'
    7:
      id: 'standardfuturestrategy'
      doc: 'Standard Future Strategy'
    8:
      id: 'packandbundle'
      doc: 'Pack and Bundle'
    9:
      id: 'strip'
      doc: 'Strip'
    13:
      id: 'nonstandardvolatilitystrategy'
      doc: 'Non-Standard Volatility Strategy'
    14:
      id: 'totalreturnfuturestrategy'
      doc: 'Total Return Future Strategy'
  cross_request_type:
    1:
      id: 'cross'
      doc: 'Cross Announcement'
    2:
      id: 'clip'
      doc: 'Liquidity Improvement Cross'
  input_source:
    1:
      id: 'client_broker'
      doc: 'Client Broker'
    2:
      id: 'proprietary_broker'
      doc: 'Proprietary Broker'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  self_match_prevention_instruction:
    100:
      id: 'crossrejected_bu'
      doc: 'Reject cross on business unit level'
    101:
      id: 'crossrejected_market'
      doc: 'Reject cross on market level'
  cross_match_instruction:
    1:
      id: 'cancelaggressive'
      doc: 'Cancel incoming order'
    2:
      id: 'cancelpassive'
      doc: 'Cancel resting order'
    3:
      id: 'cancelaggressiveandpassive'
      doc: 'Reduce/Cancel both incoming and resting order'
  trading_capacity:
    1:
      id: 'customer'
      doc: 'Customer (Agency)'
    5:
      id: 'principal'
      doc: 'Principal (Proprietary)'
    6:
      id: 'market_maker'
      doc: 'Market Maker'
  party_id_investment_decision_maker_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
  executing_trader_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
  cust_order_handling_inst:
    0x57:
      id: 'w'
      doc: 'Desk'
    0x59:
      id: 'y'
      doc: 'Electronic'
    0x43:
      id: 'c'
      doc: 'Vendor-provided Platform billed by Executing Broker'
    0x47:
      id: 'g'
      doc: 'Sponsored Access via Exchange API or FIX provided by Executing Broker'
    0x48:
      id: 'h'
      doc: 'Premium Algorithmic Trading Provider billed by Executing Broker'
    0x44:
      id: 'd'
      doc: 'Other, including Other-provided Screen'
  order_origination:
    5:
      id: 'directaccesscustomer'
      doc: 'Order received from a direct access customer'
    105:
      id: 'sponsoredaccesscustomer'
      doc: 'Order received from a sponsored access customer'
  user_status:
    7:
      id: 'userforcedlogout'
      doc: 'Forced user logout by exchange'
    10:
      id: 'userstopped'
      doc: 'Admission to trading suspended'
    11:
      id: 'userreleased'
      doc: 'Suspension revoked'
  market_id:
    1:
      id: 'xeur'
      doc: 'XEUR'
    2:
      id: 'xeee'
      doc: 'XEEE'
  trad_ses_mode:
    1:
      id: 'testing'
      doc: 'Development'
    2:
      id: 'simulated'
      doc: 'Simulation'
    3:
      id: 'production'
      doc: 'Production'
    4:
      id: 'acceptance'
      doc: 'Acceptance'
    5:
      id: 'disaster_recovery'
      doc: 'Disaster Recovery'
  ord_type:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'stop'
      doc: 'Stop'
    4:
      id: 'stop_limit'
      doc: 'Stop Limit'
  match_type:
    4:
      id: 'automatchincoming'
      doc: 'Auto-match incoming order'
    5:
      id: 'cross_auction'
      doc: 'Cross Auction'
    7:
      id: 'call_auction'
      doc: 'Call Auction'
    11:
      id: 'automatchresting'
      doc: 'Auto match resting order'
    13:
      id: 'liquidity_improvement_cross'
      doc: 'Liquidity Improvement Cross'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day (GFD)'
    1:
      id: 'gtc'
      doc: 'Good Till Cancelled (GTC) - Standard Orders only'
    3:
      id: 'ioc'
      doc: 'Immediate or Cancel (IOC)'
    4:
      id: 'fok'
      doc: 'Fill Or Kill (FOK)'
    6:
      id: 'gtd'
      doc: 'Good Till Date (GTD) - Standard Orders only'
  exec_inst:
    1:
      id: 'h'
      doc: 'Persistent Order (FIX value ''H'')'
    2:
      id: 'q'
      doc: 'Non-persistent Order (FIX value ''Q'')'
    5:
      id: 'h_6'
      doc: 'Persistent and Book or Cancel order (FIX value ''H 6'')'
    6:
      id: 'q_6'
      doc: 'Non-persistent and Book or Cancel order (FIX value ''Q 6'')'
  triggered:
    0: 'nottriggered'
    1: 'triggered_stop'
    2: 'triggered_oco'
  trading_session_sub_id:
    2:
      id: 'openingauction'
      doc: 'Opening or opening auction'
    4:
      id: 'closingauction'
      doc: 'Closing or closing auction'
    8:
      id: 'any_auction'
      doc: 'Any auction'
  appl_seq_indicator:
    0: 'no_recovery_required'
    1: 'recovery_required'
  crossed_indicator:
    0:
      id: 'nocrossing'
      doc: 'No crossing (Order not subject to crossing)'
    1:
      id: 'crossrejected'
      doc: 'Cross rejected (Order subject to crossing and match prevented)'
  session_reject_reason:
    1:
      id: 'required_tag_missing'
      doc: 'Required Tag Missing'
    5:
      id: 'valueisincorrect'
      doc: 'Value is incorrect (out of range) for this tag'
    7:
      id: 'decryptionproblem'
      doc: 'Decoding problem'
    11:
      id: 'invalid_msg_id'
      doc: 'Invalid TemplateID'
    16:
      id: 'incorrect_num_in_groupcount'
      doc: 'Incorrect NumInGroup count for repeating group'
    99:
      id: 'other'
      doc: 'Other'
    101:
      id: 'exposure_limit_exceeded'
      doc: 'Stale request was not forwarded to T7'
    103:
      id: 'service_not_available'
      doc: 'Service not available'
    105:
      id: 'outboundconversionerror'
      doc: 'Error converting response or broadcast'
    152:
      id: 'heartbeat_violation'
      doc: 'Heartbeat violation error'
    200:
      id: 'internaltechnicalerror'
      doc: 'Internal technical error'
    210:
      id: 'validation_error'
      doc: 'Validation Error'
    217:
      id: 'session_login_limit_reached'
      doc: 'Session login limit (per time interval) reached'
    226:
      id: 'outstanding_logins_bu_limit_reached'
      doc: 'Limit of outstanding session/user logins reached (per Business Unit)'
    227:
      id: 'outstanding_logins_session_limit_reached'
      doc: 'Limit of outstanding session/user logins reached (per Session)'
    228:
      id: 'password_timestamp_not_in_grace_period'
      doc: 'Password timestamp not in grace period'
    10001:
      id: 'price_not_reasonable'
      doc: 'Price not reasonable'
    10006:
      id: 'stop_bid_price_not_reasonable'
      doc: 'Stop buy price not reasonable'
    10007:
      id: 'stop_ask_price_not_reasonable'
      doc: 'Stop sell price not reasonable'
    10016:
      id: 'pretrade_risk_limit_exceeded'
      doc: 'Pretrade Risk Limit exceeded'
    10021:
      id: 'max_order_quantity_exceeded'
      doc: 'Max order quantity exceeded'
    10022:
      id: 'max_order_value_exceeded'
      doc: 'Max order value exceeded'
    10023:
      id: 'price_not_reasonable_extended'
      doc: 'Price exceeds extended price reasonability'
  requesting_party_id_executing_system:
    1:
      id: 'eurex_clearing'
      doc: 'Eurex Clearing'
    2:
      id: 't_7'
      doc: 'T7 trading system'
  order_deletion_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  party_action_type:
    1:
      id: 'halt_trading'
      doc: 'Halt Trading'
    2:
      id: 'reinstate'
      doc: 'Reinstate'
  requesting_party_id_entering_firm:
    1:
      id: 'participant'
      doc: 'Participant'
    2:
      id: 'market_supervision'
      doc: 'Market Supervision'
  list_update_action:
    0x41:
      id: 'add'
      doc: 'Add (Invocation)'
    0x44:
      id: 'delete_field'
      doc: 'Delete (Release)'
  party_detail_status:
    0:
      id: 'active'
      doc: 'Active'
    1:
      id: 'suspend'
      doc: 'Suspend'
    2:
      id: 'rejected'
      doc: 'Rejected'
  session_status:
    0:
      id: 'active'
      doc: 'Session active'
    4:
      id: 'logout'
      doc: 'Session logout complete'
  ref_appl_id:
    6:
      id: 'risk_control'
      doc: 'Risk Control'
    12:
      id: 'order_drop_copy'
      doc: 'OrderDropCopy Data'
  inventory_check_type:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
  risk_limit_action:
    0:
      id: 'queue_inbound'
      doc: 'Queue Inbound'
    2:
      id: 'reject'
      doc: 'Reject'
    4:
      id: 'warning'
      doc: 'Warning'
  risk_control_rtm_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  marketwide_analytics_and_risk_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  session_mode:
    1:
      id: 'etihf'
      doc: 'ETI HF'
    2:
      id: 'etilf'
      doc: 'ETI LF'
    3:
      id: 'gui'
      doc: 'GUI'
    4:
      id: 'fixlf'
      doc: 'FIX LF'
  trad_ses_event:
    101:
      id: 'startof_service'
      doc: 'Start of Service'
    103:
      id: 'endof_restatement'
      doc: 'End of Restatement'
    104:
      id: 'endof_day_service'
      doc: 'End of Service'
    107:
      id: 'endof_orderbooksynch'
      doc: 'End of Order book synchronization'
    108:
      id: 'startof_orderbooksynch'
      doc: 'Start of Order book synchronization'
    109:
      id: 'orderbookreset'
      doc: 'Order book reset'
  risk_limit_platform:
    0:
      id: 'on_book'
      doc: 'On Book'
    1:
      id: 'off_book'
      doc: 'Off Book'
  matching_engine_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'

