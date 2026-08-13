# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Xti Fbe v7.0
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Cash Enhanced Trading Interface
#   Encoding: Flat Binary Encoding
#   Version: 7.0
#   Date: 05/22/2017
#   Specification: T7_Enhanced_Trading_Interface_-_Manual_v.1.2.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_xti_fbe_v7_0
  title: Eurex T7 Xti Fbe v7.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Cash Enhanced Trading Interface Fbe v7.0'
doc-ref: https://www.eurex.com/ex-en/technology/t7

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Eurex T7 Eti Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Coinbase Sbe Message'
      - id: payload
        size: message_header.body_len - 6
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::approve_tes_trade_request': approve_tes_trade_request
            'template_id::best_quote_execution_report': best_quote_execution_report
            'template_id::best_quote_response': best_quote_response
            'template_id::broadcast_error_notification': broadcast_error_notification
            'template_id::cross_request': cross_request
            'template_id::cross_request_response': cross_request_response
            'template_id::delete_all_order_broadcast': delete_all_order_broadcast
            'template_id::delete_all_order_nr_response': delete_all_order_nr_response
            'template_id::delete_all_order_quote_event_broadcast': delete_all_order_quote_event_broadcast
            'template_id::delete_all_order_request': delete_all_order_request
            'template_id::delete_all_order_response': delete_all_order_response
            'template_id::delete_all_quote_broadcast': delete_all_quote_broadcast
            'template_id::delete_all_quote_request': delete_all_quote_request
            'template_id::delete_all_quote_response': delete_all_quote_response
            'template_id::delete_order_broadcast': delete_order_broadcast
            'template_id::delete_order_nr_response': delete_order_nr_response
            'template_id::delete_order_response': delete_order_response
            'template_id::delete_order_single_request': delete_order_single_request
            'template_id::delete_tes_trade_request': delete_tes_trade_request
            'template_id::enter_best_quote_request': enter_best_quote_request
            'template_id::enter_tes_trade_request': enter_tes_trade_request
            'template_id::extended_deletion_report': extended_deletion_report
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::forced_user_logout_notification': forced_user_logout_notification
            'template_id::gateway_request': gateway_request
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::inquire_enrichment_rule_id_list_request': inquire_enrichment_rule_id_list_request
            'template_id::inquire_enrichment_rule_id_list_response': inquire_enrichment_rule_id_list_response
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::inquire_session_list_response': inquire_session_list_response
            'template_id::inquire_user_request': inquire_user_request
            'template_id::inquire_user_response': inquire_user_response
            'template_id::issuer_notification': issuer_notification
            'template_id::issuer_security_state_change_request': issuer_security_state_change_request
            'template_id::issuer_security_state_change_response': issuer_security_state_change_response
            'template_id::legal_notification_broadcast': legal_notification_broadcast
            'template_id::logon_request': logon_request
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::mass_quote_request': mass_quote_request
            'template_id::mass_quote_response': mass_quote_response
            'template_id::modify_order_nr_response': modify_order_nr_response
            'template_id::modify_order_response': modify_order_response
            'template_id::modify_order_single_request': modify_order_single_request
            'template_id::modify_order_single_short_request': modify_order_single_short_request
            'template_id::modify_tes_trade_request': modify_tes_trade_request
            'template_id::new_order_nr_response': new_order_nr_response
            'template_id::new_order_response': new_order_response
            'template_id::new_order_single_request': new_order_single_request
            'template_id::new_order_single_short_request': new_order_single_short_request
            'template_id::news_broadcast': news_broadcast
            'template_id::order_exec_notification': order_exec_notification
            'template_id::order_exec_report_broadcast': order_exec_report_broadcast
            'template_id::order_exec_response': order_exec_response
            'template_id::party_action_report': party_action_report
            'template_id::party_entitlements_update_report': party_entitlements_update_report
            'template_id::quote_activation_notification': quote_activation_notification
            'template_id::quote_activation_request': quote_activation_request
            'template_id::quote_activation_response': quote_activation_response
            'template_id::quote_execution_report': quote_execution_report
            'template_id::rfq_broadcast': rfq_broadcast
            'template_id::rfq_request': rfq_request
            'template_id::rfq_response': rfq_response
            'template_id::reject': reject
            'template_id::retransmit_me_message_request': retransmit_me_message_request
            'template_id::retransmit_me_message_response': retransmit_me_message_response
            'template_id::retransmit_request': retransmit_request
            'template_id::retransmit_response': retransmit_response
            'template_id::service_availability_broadcast': service_availability_broadcast
            'template_id::subscribe_request': subscribe_request
            'template_id::subscribe_response': subscribe_response
            'template_id::tes_approve_broadcast': tes_approve_broadcast
            'template_id::tes_broadcast': tes_broadcast
            'template_id::tes_delete_broadcast': tes_delete_broadcast
            'template_id::tes_execution_broadcast': tes_execution_broadcast
            'template_id::tes_response': tes_response
            'template_id::tes_trade_broadcast': tes_trade_broadcast
            'template_id::tes_trading_session_status_broadcast': tes_trading_session_status_broadcast
            'template_id::tm_trading_session_status_broadcast': tm_trading_session_status_broadcast
            'template_id::throttle_update_notification': throttle_update_notification
            'template_id::trade_broadcast': trade_broadcast
            'template_id::trading_session_status_broadcast': trading_session_status_broadcast
            'template_id::trailing_stop_update_notification': trailing_stop_update_notification
            'template_id::unsubscribe_request': unsubscribe_request
            'template_id::unsubscribe_response': unsubscribe_response
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
  approve_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: sender_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  best_quote_execution_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_msg_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: quote_event_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: quote_event_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: reserved_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: quote_event_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_event_exec_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: quote_event_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_event_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2v2
        size: 2
  rbc_header_me_comp:
    seq:
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: notification_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_resend_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  best_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_response_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_cxl_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_cxl_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
  nr_response_header_me_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: response_in
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
  broadcast_error_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: appl_id_status
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ref_appl_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: ref_appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: session_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad4
        size: 4
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
  cross_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
  cross_request_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  delete_all_order_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_not_affected_orders_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_affected_ord_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_action_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
  not_affected_orders_grp_comp:
    seq:
      - id: not_affected_order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: not_aff_orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  affected_ord_grp_comp:
    seq:
      - id: affected_order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: affected_orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  delete_all_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  delete_all_order_quote_event_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: mass_action_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2v2
        size: 2
  delete_all_order_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
  delete_all_order_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: num_not_affected_orders_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_affected_ord_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad4
        size: 4
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
  response_header_me_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: response_in
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
  delete_all_quote_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_not_affected_securities_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: mass_action_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: target_party_id_desk_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  not_affected_securities_grp_comp:
    seq:
      - id: not_affected_security_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  delete_all_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  delete_all_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: num_not_affected_securities_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  delete_order_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
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
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_entering_firm
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  delete_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
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
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
  delete_order_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
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
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
  delete_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
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
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
  delete_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
  enter_best_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: reserved_bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: reserved_offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  enter_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: settl_curr_fx_rate
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
  side_alloc_grp_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: individual_alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
  extended_deletion_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
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
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: price
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
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_low_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_high_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: volume_discovery_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_abs
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_pct
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
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
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: triggered
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
      - id: pad6
        size: 6
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  forced_user_logout_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: user_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: username
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  gateway_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad4
        size: 4
  heartbeat:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
  heartbeat_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
  inquire_enrichment_rule_id_list_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_entity_processed
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
  inquire_enrichment_rule_id_list_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: num_enrichment_rules_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: enrichment_rules_grp_comp
        type: enrichment_rules_grp_comp
        repeat: expr
        repeat-expr: num_enrichment_rules_grp_comp
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
      - id: pad4
        size: 4
  enrichment_rules_grp_comp:
    seq:
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  inquire_session_list_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
  inquire_session_list_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
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
      - id: session_mode
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: session_sub_mode
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
  inquire_user_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_entity_processed
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
  inquire_user_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: num_party_details_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: party_details_grp_comp
        type: party_details_grp_comp
        repeat: expr
        repeat-expr: num_party_details_grp_comp
  party_details_grp_comp:
    seq:
      - id: party_detail_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_detail_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: party_detail_role_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_detail_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_detail_desk_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
  issuer_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: potential_exec_volume
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: imbalance_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: security_trading_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  issuer_security_state_change_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_security_status_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: security_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: sold_out_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: security_status_event_grp_comp
        type: security_status_event_grp_comp
        repeat: expr
        repeat-expr: num_security_status_event_grp_comp
  security_status_event_grp_comp:
    seq:
      - id: event_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: event_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: event_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  issuer_security_state_change_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: security_status_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: pad5
        size: 5
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  rbc_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_seq_num
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_sub_id
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
      - id: pad7
        size: 7
  logon_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
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
      - id: appl_usage_orders
        type: u1
        enum: appl_usage_orders
      - id: appl_usage_quotes
        type: u1
        enum: appl_usage_quotes
      - id: order_routing_indicator
        type: u1
        enum: order_routing_indicator
      - id: fix_engine_name
        type: str
        size: 30
        encoding: ASCII
      - id: fix_engine_version
        type: str
        size: 30
        encoding: ASCII
      - id: fix_engine_vendor
        type: str
        size: 30
        encoding: ASCII
      - id: application_system_name
        type: str
        size: 30
        encoding: ASCII
      - id: application_system_version
        type: str
        size: 30
        encoding: ASCII
      - id: application_system_vendor
        type: str
        size: 30
        encoding: ASCII
      - id: pad3
        size: 3
  logon_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: throttle_time_interval
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: throttle_no_msgs
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: throttle_disconnect_limit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
  logout_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
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
  mass_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: quote_id
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
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_size_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_quote_entry_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad5
        size: 5
      - id: quote_entry_grp_comp
        type: quote_entry_grp_comp
        repeat: expr
        repeat-expr: num_quote_entry_grp_comp
  quote_entry_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
  mass_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_response_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_quote_entry_ack_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: quote_entry_ack_grp_comp
        type: quote_entry_ack_grp_comp
        repeat: expr
        repeat-expr: num_quote_entry_ack_grp_comp
  quote_entry_ack_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_cxl_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_cxl_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_entry_reject_reason
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_entry_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  modify_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
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
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  modify_order_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
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
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  modify_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
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
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_low_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_high_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: volume_discovery_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_abs
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_pct
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
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: stop_px_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ownership_indicator
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
  modify_order_single_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  modify_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
  new_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  new_order_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  new_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_low_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_high_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: volume_discovery_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_abs
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_pct
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
  new_order_single_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cl_ord_id
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
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  news_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: orig_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: headline
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  order_exec_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
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
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
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
      - id: fill_liquidity_ind
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  order_exec_report_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
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
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: price
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
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_low_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_high_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: volume_discovery_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_abs
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: peg_offset_value_pct
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
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
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ex_destination_type
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
  order_exec_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
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
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: display_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
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
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_id_executing_system
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_action_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: requesting_party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
  quote_activation_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: party_id_entering_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_not_affected_securities_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_action_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_action_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  quote_activation_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: mass_action_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad5
        size: 5
  quote_activation_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: num_not_affected_securities_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  quote_execution_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_quote_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: quote_event_grp_comp
        type: quote_event_grp_comp
        repeat: expr
        repeat-expr: num_quote_event_grp_comp
  quote_event_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: quote_event_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: quote_event_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_msg_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_event_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_event_exec_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: quote_event_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_event_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_event_liquidity_ind
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_event_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad4
        size: 4
  rfq_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  rfq_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: rfq_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: rfq_requester_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
  rfq_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  reject:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: session_reject_reason
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: session_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  retransmit_me_message_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: subscription_scope
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: ref_appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_beg_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: appl_end_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: pad1
        size: 1
  retransmit_me_message_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_total_message_count
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_end_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: ref_appl_last_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: pad6
        size: 6
  retransmit_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
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
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: ref_appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad5
        size: 5
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
  service_availability_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: matching_engine_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_manager_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: appl_seq_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: t_7_entry_service_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: t_7_entry_service_rtm_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: matching_engine_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_manager_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: appl_seq_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: t_7_entry_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: t_7_entry_service_rtm_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad5
        size: 5
  nrbc_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: appl_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
  subscribe_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: subscription_scope
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: ref_appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  subscribe_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  tes_approve_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: settl_curr_fx_rate
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_quantity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
  tes_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: settl_curr_fx_rate
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_bc_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: side_alloc_grp_bc_comp
        type: side_alloc_grp_bc_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_bc_comp
  side_alloc_grp_bc_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: individual_alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  tes_delete_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: delete_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
  tes_execution_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: pad3
        size: 3
  tes_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  tes_trade_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: settl_curr_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: side_gross_trade_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: settl_curr_fx_rate
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: accrued_interes_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: coupon_rate
        type: decimal_u8_7_nullable
        doc: 'Implied decimal with scale 1e-7. Nullable, No Value = 0x8000000000000000'
      - id: root_party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: root_party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_settlement_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_contra_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_contra_settlement_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: orig_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_clearing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_days_interest
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: last_mkt
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transfer_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_coupon_deviation_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: refinancing_eligibility_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: root_party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_clearing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_clearing_organization
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_firm_kv_number
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_account
        type: str
        size: 35
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_location
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_firm_kv_number
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_account
        type: str
        size: 35
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_location
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  tes_trading_session_status_broadcast:
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
  tm_trading_session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trad_ses_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  throttle_update_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: throttle_time_interval
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: throttle_no_msgs
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: throttle_disconnect_limit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  trade_broadcast:
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
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: settl_curr_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: settl_curr_fx_rate
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: side_gross_trade_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: accrued_interes_amt
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: coupon_rate
        type: decimal_u8_7_nullable
        doc: 'Implied decimal with scale 1e-7. Nullable, No Value = 0x8000000000000000'
      - id: root_party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: root_party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: orig_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_settlement_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_clearing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_contra_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: root_party_id_contra_settlement_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: side_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_trade_report_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_number
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_days_interest
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: last_mkt
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transfer_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: match_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: match_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side_liquidity_ind
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: delivery_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_coupon_deviation_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: refinancing_eligibility_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: root_party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
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
      - id: free_text_4
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
      - id: order_category
        type: u1
        enum: order_category
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: root_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_clearing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_executing_firm_kv_number
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_account
        type: str
        size: 35
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_location
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_settlement_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_firm_kv_number
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_account
        type: str
        size: 35
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_contra_settlement_location
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
  trading_session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trad_ses_event
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ref_appl_last_msg_id
        size: 16
        doc: 'Nullable, No Value = 0x00000000000000000000000000000000'
      - id: pad7
        size: 7
  trailing_stop_update_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
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
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_id_sfx
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  unsubscribe_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: ref_appl_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
  unsubscribe_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  user_login_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
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
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0xFFFFFFFF
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0xFFFFFFFFFFFFFFFF
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
        value: value.mantissa == 0x8000000000000000
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0x80000000
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0xFFFF
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 0xFF
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
        value: value.time == 0xFFFFFFFFFFFFFFFF
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == 0x8000000000000000
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
        value: value.mantissa == 0x8000000000000000
  decimal_u8_7:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000000.0
  decimal_u8_7_nullable:
    seq:
      - id: value
        type: decimal_u8_7
    instances:
      is_null:
        value: value.mantissa == 0x8000000000000000

enums:
  template_id:
    10603:
      id: 'approve_tes_trade_request'
      doc: 'Approve Tes Trade Request TemplateId'
    10414:
      id: 'best_quote_execution_report'
      doc: 'Best Quote Execution Report TemplateId'
    10413:
      id: 'best_quote_response'
      doc: 'Best Quote Response TemplateId'
    10032:
      id: 'broadcast_error_notification'
      doc: 'Broadcast Error Notification TemplateId'
    10118:
      id: 'cross_request'
      doc: 'Cross Request TemplateId'
    10119:
      id: 'cross_request_response'
      doc: 'Cross Request Response TemplateId'
    10122:
      id: 'delete_all_order_broadcast'
      doc: 'Delete All Order Broadcast TemplateId'
    10124:
      id: 'delete_all_order_nr_response'
      doc: 'Delete All Order Nr Response TemplateId'
    10308:
      id: 'delete_all_order_quote_event_broadcast'
      doc: 'Delete All Order Quote Event Broadcast TemplateId'
    10120:
      id: 'delete_all_order_request'
      doc: 'Delete All Order Request TemplateId'
    10121:
      id: 'delete_all_order_response'
      doc: 'Delete All Order Response TemplateId'
    10410:
      id: 'delete_all_quote_broadcast'
      doc: 'Delete All Quote Broadcast TemplateId'
    10408:
      id: 'delete_all_quote_request'
      doc: 'Delete All Quote Request TemplateId'
    10409:
      id: 'delete_all_quote_response'
      doc: 'Delete All Quote Response TemplateId'
    10112:
      id: 'delete_order_broadcast'
      doc: 'Delete Order Broadcast TemplateId'
    10111:
      id: 'delete_order_nr_response'
      doc: 'Delete Order Nr Response TemplateId'
    10110:
      id: 'delete_order_response'
      doc: 'Delete Order Response TemplateId'
    10109:
      id: 'delete_order_single_request'
      doc: 'Delete Order Single Request TemplateId'
    10602:
      id: 'delete_tes_trade_request'
      doc: 'Delete Tes Trade Request TemplateId'
    10412:
      id: 'enter_best_quote_request'
      doc: 'Enter Best Quote Request TemplateId'
    10600:
      id: 'enter_tes_trade_request'
      doc: 'Enter Tes Trade Request TemplateId'
    10128:
      id: 'extended_deletion_report'
      doc: 'Extended Deletion Report TemplateId'
    10012:
      id: 'forced_logout_notification'
      doc: 'Forced Logout Notification TemplateId'
    10043:
      id: 'forced_user_logout_notification'
      doc: 'Forced User Logout Notification TemplateId'
    10020:
      id: 'gateway_request'
      doc: 'Gateway Request TemplateId'
    10011:
      id: 'heartbeat'
      doc: 'Heartbeat TemplateId'
    10023:
      id: 'heartbeat_notification'
      doc: 'Heartbeat Notification TemplateId'
    10040:
      id: 'inquire_enrichment_rule_id_list_request'
      doc: 'Inquire Enrichment Rule Id List Request TemplateId'
    10041:
      id: 'inquire_enrichment_rule_id_list_response'
      doc: 'Inquire Enrichment Rule Id List Response TemplateId'
    10035:
      id: 'inquire_session_list_request'
      doc: 'Inquire Session List Request TemplateId'
    10036:
      id: 'inquire_session_list_response'
      doc: 'Inquire Session List Response TemplateId'
    10038:
      id: 'inquire_user_request'
      doc: 'Inquire User Request TemplateId'
    10039:
      id: 'inquire_user_response'
      doc: 'Inquire User Response TemplateId'
    10316:
      id: 'issuer_notification'
      doc: 'Issuer Notification TemplateId'
    10314:
      id: 'issuer_security_state_change_request'
      doc: 'Issuer Security State Change Request TemplateId'
    10315:
      id: 'issuer_security_state_change_response'
      doc: 'Issuer Security State Change Response TemplateId'
    10037:
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
    10405:
      id: 'mass_quote_request'
      doc: 'Mass Quote Request TemplateId'
    10406:
      id: 'mass_quote_response'
      doc: 'Mass Quote Response TemplateId'
    10108:
      id: 'modify_order_nr_response'
      doc: 'Modify Order Nr Response TemplateId'
    10107:
      id: 'modify_order_response'
      doc: 'Modify Order Response TemplateId'
    10106:
      id: 'modify_order_single_request'
      doc: 'Modify Order Single Request TemplateId'
    10126:
      id: 'modify_order_single_short_request'
      doc: 'Modify Order Single Short Request TemplateId'
    10601:
      id: 'modify_tes_trade_request'
      doc: 'Modify Tes Trade Request TemplateId'
    10102:
      id: 'new_order_nr_response'
      doc: 'New Order Nr Response TemplateId'
    10101:
      id: 'new_order_response'
      doc: 'New Order Response TemplateId'
    10100:
      id: 'new_order_single_request'
      doc: 'New Order Single Request TemplateId'
    10125:
      id: 'new_order_single_short_request'
      doc: 'New Order Single Short Request TemplateId'
    10031:
      id: 'news_broadcast'
      doc: 'News Broadcast TemplateId'
    10104:
      id: 'order_exec_notification'
      doc: 'Order Exec Notification TemplateId'
    10117:
      id: 'order_exec_report_broadcast'
      doc: 'Order Exec Report Broadcast TemplateId'
    10103:
      id: 'order_exec_response'
      doc: 'Order Exec Response TemplateId'
    10042:
      id: 'party_action_report'
      doc: 'Party Action Report TemplateId'
    10034:
      id: 'party_entitlements_update_report'
      doc: 'Party Entitlements Update Report TemplateId'
    10411:
      id: 'quote_activation_notification'
      doc: 'Quote Activation Notification TemplateId'
    10403:
      id: 'quote_activation_request'
      doc: 'Quote Activation Request TemplateId'
    10404:
      id: 'quote_activation_response'
      doc: 'Quote Activation Response TemplateId'
    10407:
      id: 'quote_execution_report'
      doc: 'Quote Execution Report TemplateId'
    10415:
      id: 'rfq_broadcast'
      doc: 'Rfq Broadcast TemplateId'
    10401:
      id: 'rfq_request'
      doc: 'Rfq Request TemplateId'
    10402:
      id: 'rfq_response'
      doc: 'Rfq Response TemplateId'
    10010:
      id: 'reject'
      doc: 'Reject TemplateId'
    10026:
      id: 'retransmit_me_message_request'
      doc: 'Retransmit Me Message Request TemplateId'
    10027:
      id: 'retransmit_me_message_response'
      doc: 'Retransmit Me Message Response TemplateId'
    10008:
      id: 'retransmit_request'
      doc: 'Retransmit Request TemplateId'
    10009:
      id: 'retransmit_response'
      doc: 'Retransmit Response TemplateId'
    10030:
      id: 'service_availability_broadcast'
      doc: 'Service Availability Broadcast TemplateId'
    10025:
      id: 'subscribe_request'
      doc: 'Subscribe Request TemplateId'
    10005:
      id: 'subscribe_response'
      doc: 'Subscribe Response TemplateId'
    10607:
      id: 'tes_approve_broadcast'
      doc: 'Tes Approve Broadcast TemplateId'
    10604:
      id: 'tes_broadcast'
      doc: 'Tes Broadcast TemplateId'
    10606:
      id: 'tes_delete_broadcast'
      doc: 'Tes Delete Broadcast TemplateId'
    10610:
      id: 'tes_execution_broadcast'
      doc: 'Tes Execution Broadcast TemplateId'
    10611:
      id: 'tes_response'
      doc: 'Tes Response TemplateId'
    10614:
      id: 'tes_trade_broadcast'
      doc: 'Tes Trade Broadcast TemplateId'
    10615:
      id: 'tes_trading_session_status_broadcast'
      doc: 'Tes Trading Session Status Broadcast TemplateId'
    10501:
      id: 'tm_trading_session_status_broadcast'
      doc: 'Tm Trading Session Status Broadcast TemplateId'
    10028:
      id: 'throttle_update_notification'
      doc: 'Throttle Update Notification TemplateId'
    10500:
      id: 'trade_broadcast'
      doc: 'Trade Broadcast TemplateId'
    10307:
      id: 'trading_session_status_broadcast'
      doc: 'Trading Session Status Broadcast TemplateId'
    10127:
      id: 'trailing_stop_update_notification'
      doc: 'Trailing Stop Update Notification TemplateId'
    10006:
      id: 'unsubscribe_request'
      doc: 'Unsubscribe Request TemplateId'
    10007:
      id: 'unsubscribe_response'
      doc: 'Unsubscribe Response TemplateId'
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
  trd_type:
    54:
      id: 'otc'
      doc: 'OTC'
    1005:
      id: 'lis'
      doc: 'Large in scale'
  trading_capacity:
    1:
      id: 'customer'
      doc: 'Customer (Agency)'
    5:
      id: 'principal'
      doc: 'Principal (Proprietary)'
    6:
      id: 'market_maker'
      doc: 'MarketMaker'
    8:
      id: 'systematic_internaliser'
      doc: 'Systematic Internaliser'
    9:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
  trade_report_type:
    0:
      id: 'submit'
      doc: 'Trade'
    2:
      id: 'accept'
      doc: 'Accept'
    3:
      id: 'decline'
      doc: 'Decline'
    5:
      id: 'no_was_replaced'
      doc: 'No/Was (Replaced)'
    6:
      id: 'trade_report_cancel'
      doc: 'Trade Report Cancel'
    7:
      id: 'trade_break'
      doc: '(Locked-In) Trade Break'
    11:
      id: 'alleged_new'
      doc: 'Alleged New'
    13:
      id: 'alleged_no_was'
      doc: 'Alleged No/Was'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  value_check_type_value:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
  value_check_type_quantity:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
  order_attribute_liquidity_provision:
    1:
      id: 'y'
      doc: 'Liquidity provision'
    0:
      id: 'n'
      doc: 'No liquidity provision'
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
  appl_id:
    1:
      id: 'trade'
      doc: 'Trade'
    2:
      id: 'news'
      doc: 'News'
    3:
      id: 'serviceavailability'
      doc: 'Service Availability'
    4:
      id: 'sessiondata'
      doc: 'Session Data'
    5:
      id: 'listenerdata'
      doc: 'Listener Data'
    6:
      id: 'risk_control'
      doc: 'Risk Control'
    7:
      id: 'tes_maintenance'
      doc: 'TES Maintenance'
    8:
      id: 'tes_trade'
      doc: 'TES Trade'
  appl_resend_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  last_fragment:
    0:
      id: 'not_last_message'
      doc: 'Not Last Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
  quote_event_type:
    2:
      id: 'modifiedquoteside'
      doc: 'Modified side'
    3: 'removedquoteside'
    4: 'partiallyfilled'
    5:
      id: 'filled'
      doc: 'Filled'
  quote_event_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  appl_id_status:
    105:
      id: 'outboundconversionerror'
      doc: 'Error converting response or broadcast'
  ref_appl_id:
    1:
      id: 'trade'
      doc: 'Trade'
    2:
      id: 'news'
      doc: 'News'
    3:
      id: 'serviceavailability'
      doc: 'Service Availability'
    4:
      id: 'sessiondata'
      doc: 'Session Data'
    5:
      id: 'listenerdata'
      doc: 'Listener Data'
    6:
      id: 'risk_control'
      doc: 'Risk Control'
    7:
      id: 'tes_maintenance'
      doc: 'TES Maintenance'
    8:
      id: 'tes_trade'
      doc: 'TES Trade'
  session_status:
    0:
      id: 'active'
      doc: 'Session active'
    4:
      id: 'logout'
      doc: 'Session logout complete'
  party_id_entering_firm:
    1:
      id: 'participant'
      doc: 'Participant'
    2:
      id: 'market_supervision'
      doc: 'Market Supervision'
  mass_action_reason:
    0:
      id: 'no_special_reason'
      doc: 'No special reason'
    1:
      id: 'stop_trading'
      doc: 'Trading was stopped'
    2:
      id: 'emergency'
      doc: 'Emergency'
    6:
      id: 'session_loss'
      doc: 'Session loss or logout'
    7:
      id: 'duplicate_session_login'
      doc: 'Duplicate Session Login'
    8:
      id: 'clearing_risk_control'
      doc: 'Clearing Risk Control'
    105:
      id: 'product_state_halt'
      doc: 'Product State Halt'
    106:
      id: 'product_state_holiday'
      doc: 'Product State Holiday'
    107:
      id: 'instrument_suspended'
      doc: 'Instrument Suspended'
    110:
      id: 'volatility_interruption'
      doc: 'Volatility Interruption'
    111:
      id: 'producttemporarilynottradeable'
      doc: 'Product temporarily not tradeable'
    113:
      id: 'instrument_stopped'
      doc: 'Instrument Stopped'
    115:
      id: 'instrument_knock_out'
      doc: 'Instrument Knock Out'
    116:
      id: 'instrument_sold_out'
      doc: 'Instrument Sold Out'
  exec_inst:
    1:
      id: 'h'
      doc: 'Persistent Order (FIX value ''H'')'
    2:
      id: 'q'
      doc: 'Non-persistent Order (FIX value ''Q'')'
    3:
      id: 'hq'
      doc: 'Persistent and non-persistent orders affected (FIX value ''H Q'')'
    5:
      id: 'h_6'
      doc: 'Persistent and Book or Cancel order (FIX value ''H 6'')'
    6:
      id: 'q_6'
      doc: 'Non-persistent and Book or Cancel order (FIX value ''Q 6'')'
  exec_restatement_reason:
    0:
      id: 'corporate_action'
      doc: 'Corporate Action'
    1:
      id: 'order_book_restatement'
      doc: 'Order book restatement'
    8:
      id: 'exchange_option'
      doc: 'Exchange option'
    101:
      id: 'order_added'
      doc: 'Order add accepted'
    102:
      id: 'order_modified'
      doc: 'Order modify accepted'
    103:
      id: 'order_cancelled'
      doc: 'Order delete accepted'
    105:
      id: 'ioc_order_cancelled'
      doc: 'IOC Order accepted'
    107:
      id: 'fok_order_cancelled'
      doc: 'FOK Order accepted'
    108:
      id: 'book_order_executed'
      doc: 'Book Order executed'
    122:
      id: 'instrument_state_change'
      doc: 'Instrument State Change'
    146:
      id: 'end_of_day_processing'
      doc: 'End of Day processing'
    148:
      id: 'order_expiration'
      doc: 'Order expiration'
    149:
      id: 'cao_order_activated'
      doc: 'Closing Auction Order has been activated'
    150:
      id: 'cao_order_inactivated'
      doc: 'Closing Auction Order has been inactivated'
    151:
      id: 'oao_order_activated'
      doc: 'Opening Auction Order has been activated'
    152:
      id: 'oao_order_inactivated'
      doc: 'Opening Auction Order has been inactivated'
    153:
      id: 'aao_order_activated'
      doc: 'Any Auction Order has been activated'
    154:
      id: 'aao_order_inactivated'
      doc: 'Any Auction Order has been inactivated'
    159:
      id: 'iao_order_activated'
      doc: 'Intraday Auction Order has been activated'
    160:
      id: 'iao_order_inactivated'
      doc: 'Intraday Auction Order has been inactivated'
    155:
      id: 'order_refreshed'
      doc: 'Order refreshed'
    164:
      id: 'oco_order_triggered'
      doc: 'One-cancels-the-other Order has been triggered'
    172:
      id: 'stop_order_triggered'
      doc: 'Stop Order has been triggered'
    181:
      id: 'ownership_changed'
      doc: 'Ownership Changed'
    197:
      id: 'order_cancellation_pending'
      doc: 'Pending order deletion'
    199:
      id: 'pending_cancellation_executed'
      doc: 'Pending order cancellation executed (end of FREEZE state)'
    212:
      id: 'boc_order_cancelled'
      doc: 'Book or Cancel Order accepted'
    213:
      id: 'trailing_stop_update'
      doc: 'Trailing Stop Updated'
    237:
      id: 'exceeds_maximum_quantity'
      doc: 'Order quantity exceeds maximum quantity'
    238:
      id: 'invalid_limit_price'
      doc: 'Invalid limit price'
    241:
      id: 'user_does_not_exist'
      doc: 'User does not exist anymore'
    242:
      id: 'session_does_not_exist'
      doc: 'Session does not exist anymore'
    243:
      id: 'invalid_stop_price'
      doc: 'Invalid stop price'
    245:
      id: 'instrument_does_not_exist'
      doc: 'Instrument does not exist anymore'
    246:
      id: 'business_unit_risk_event'
      doc: 'Business Unit Risk Event'
    292:
      id: 'dividend_payment'
      doc: 'Dividend Payment'
    294:
      id: 'last_trading_day'
      doc: 'Last Trading Day'
    295:
      id: 'trading_parameter_change'
      doc: 'Trading Parameter Change'
    296:
      id: 'currency_change'
      doc: 'Currency Change'
    297:
      id: 'product_assignment_change'
      doc: 'Product Assignment Change'
    298:
      id: 'reference_price_change'
      doc: 'Reference Price Change'
    300:
      id: 'tick_rule_change'
      doc: 'Tick Rule Change'
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
  time_in_force:
    0:
      id: 'day'
      doc: 'Day (GFD)'
    1:
      id: 'gtc'
      doc: 'Good Till Cancelled (GTC)'
    3:
      id: 'ioc'
      doc: 'Immediate or Cancel (IOC)'
    4:
      id: 'fok'
      doc: 'Fill Or Kill (FOK)'
    5:
      id: 'gtx'
      doc: 'Good Till Crossing (GTX)'
    6:
      id: 'gtd'
      doc: 'Good Till Date (GTD) - Standard Orders only'
  trading_session_sub_id:
    2:
      id: 'openingauction'
      doc: 'Opening or opening auction'
    4:
      id: 'closingauction'
      doc: 'Closing or closing auction'
    6:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
    8:
      id: 'any_auction'
      doc: 'Any auction'
  appl_seq_indicator:
    0: 'no_recovery_required'
    1: 'recovery_required'
  ex_destination_type:
    3:
      id: 'tradeonexchangeor_si'
      doc: 'Can be traded on a trading venue or SI'
  triggered:
    0: 'nottriggered'
    1: 'triggered_stop'
    2: 'triggered_oco'
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
  session_mode:
    1:
      id: 'hf'
      doc: 'HF'
    2:
      id: 'lf'
      doc: 'LF'
    3:
      id: 'gui'
      doc: 'GUI'
  session_sub_mode:
    0:
      id: 'regulartradingsession'
      doc: 'Regular Trading Session'
    1:
      id: 'fi_xtradingsession'
      doc: 'FIX Trading Session'
    2:
      id: 'regular_back_officesession'
      doc: 'Regular Back Office Session'
  party_detail_role_qualifier:
    10:
      id: 'trader'
      doc: 'Trader'
    11:
      id: 'head_trader'
      doc: 'Head Trader'
    12:
      id: 'supervisor'
      doc: 'Supervisor'
  party_detail_status:
    0:
      id: 'active'
      doc: 'Active'
    1:
      id: 'suspend'
      doc: 'Suspend'
  security_trading_status:
    7:
      id: 'market_imbalance_buy'
      doc: 'Imbalance Buy side'
    8:
      id: 'market_imbalance_sell'
      doc: 'Imbalance Sell side'
  security_status:
    6:
      id: 'knockedout'
      doc: 'Knocked-out'
    7:
      id: 'knockoutrevoked'
      doc: 'Knocked-out revoked'
    12:
      id: 'knockedoutandsuspend'
      doc: 'Knocked-out and suspended'
  sold_out_indicator:
    0:
      id: 'revertsoldout'
      doc: 'Revert Sold-out'
    1:
      id: 'soldout'
      doc: 'Sold-out'
  event_type:
    26:
      id: 'redemption'
      doc: 'Redemption'
    100:
      id: 'delisting'
      doc: 'Delisting'
  appl_usage_orders:
    0x41:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x42:
      id: 'auto_select'
      doc: 'Both (Automated and Manual)'
    0x4e:
      id: 'none'
      doc: 'None'
  appl_usage_quotes:
    0x41:
      id: 'automated'
      doc: 'Automated'
    0x4d:
      id: 'manual'
      doc: 'Manual'
    0x42:
      id: 'auto_select'
      doc: 'Both (Automated and Manual)'
    0x4e:
      id: 'none'
      doc: 'None'
  order_routing_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  market_id:
    3:
      id: 'xetr'
      doc: 'XETR'
    4:
      id: 'xvie'
      doc: 'XVIE'
    5:
      id: 'xdub'
      doc: 'XDUB'
    6:
      id: 'xmal'
      doc: 'XMAL'
    7:
      id: 'xbul'
      doc: 'XBUL'
    8:
      id: 'xbud'
      doc: 'XBUD'
    9:
      id: 'xlju'
      doc: 'XLJU'
    10:
      id: 'xpra'
      doc: 'XPRA'
    11:
      id: 'xzag'
      doc: 'XZAG'
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
  price_validity_check_type:
    0:
      id: 'none'
      doc: 'None'
    2:
      id: 'mandatory'
      doc: 'Mandatory'
  quote_size_type:
    1:
      id: 'total_size'
      doc: 'Total Size (Quote Modification)'
    2:
      id: 'open_size'
      doc: 'Open Size(Quote Entry)'
  quote_type:
    0:
      id: 'indicative'
      doc: 'Indicative'
    1:
      id: 'tradeable'
      doc: 'Tradeable'
    101:
      id: 'tradeable_matching'
      doc: 'Tradeable(Matching) - for Issuer trading model only'
    102:
      id: 'tradeable_pwt'
      doc: 'Tradeable(Price without turnover) - for Issuer trading model only'
  quote_entry_reject_reason:
    1:
      id: 'unknown_security'
      doc: 'Unknown security'
    6:
      id: 'duplicate_quote'
      doc: 'Duplicate quote'
    8:
      id: 'invalid_price'
      doc: 'Invalid price'
    16:
      id: 'no_reference_price_available'
      doc: 'Reference price not available'
    100:
      id: 'no_single_sided_quotes'
      doc: 'Single sided quotes not allowed'
    103:
      id: 'invalid_quoting_model'
      doc: 'Invalid usage of quoting model'
    106:
      id: 'invalid_size'
      doc: 'Invalid size'
    108:
      id: 'bid_price_not_reasonable'
      doc: 'Bid price not reasonable'
    109:
      id: 'ask_price_not_reasonable'
      doc: 'Ask price not reasonable'
    110:
      id: 'bid_price_exceeds_range'
      doc: 'Bid price exceeds extended price range'
    111:
      id: 'ask_price_exceeds_range'
      doc: 'Ask price exceeds extended price range'
    115:
      id: 'instrument_state_freeze'
      doc: 'Instrument state freeze'
    116:
      id: 'deletion_already_pending'
      doc: 'Deletion already pending'
    117:
      id: 'pre_trade_risk_session_limit_exceeded'
      doc: 'Fuse Box violation on session level'
    118:
      id: 'pre_trade_risk_bu_limit_exceeded'
      doc: 'Fuse Box violation on BU level'
    120:
      id: 'bid_value_exceeds_limit'
      doc: 'Bid value exceeds limit'
    121:
      id: 'ask_value_exceeds_limit'
      doc: 'Ask value exceeds limit'
    122:
      id: 'not_tradeable_for_business_unit'
      doc: 'Instrument cannot be traded by Business Unit'
    125:
      id: 'quantity_limit_exceeded'
      doc: 'Quantity exceeds trader specific limit'
    126:
      id: 'value_limit_exceeded'
      doc: 'Value exceeds trader specific limit'
    127:
      id: 'invalid_quote_spread'
      doc: 'Invalid quote spread'
    131:
      id: 'cant_proc_in_curr_instr_state'
      doc: 'Instrument state does not allow processing'
    135:
      id: 'pwt_quotenotallowedincurrentstate'
      doc: 'PWT Quote not allowed in current state'
    136:
      id: 'standard_quotenotallowedincurrentstate'
      doc: 'Standard Quote not allowed with crossed book'
    137:
      id: 'pwt_quotenotallowedwithcrossedbook'
      doc: 'PWT Quote not allowed with crossed book'
    138:
      id: 'asksidequotenotallowed'
      doc: 'Ask side quote not allowed'
    139:
      id: 'asksidequotewithqtynotallowed'
      doc: 'Ask side quote with qty not allowed'
    140:
      id: 'invalidchange_l_psession'
      doc: 'Invalid change liquidity provision session'
    144:
      id: 'on_book_tradingdisabledfor_instrument_type'
      doc: 'On-Book trading disabled for instrument type'
    145:
      id: 'l_plicencenotassigned'
      doc: 'LP licence not assigned'
    146:
      id: 's_plicencenotassigned'
      doc: 'SP licence not assigned'
    149:
      id: 'quantity_limit_exceeded_instrument'
      doc: 'Quantity exceeds instrument specific limit'
    150:
      id: 'value_limit_exceeded_instrument'
      doc: 'Value exceeds instrument specific limit'
  quote_entry_status:
    0:
      id: 'accepted'
      doc: 'Accepted with warning'
    5:
      id: 'rejected'
      doc: 'Rejected'
    6:
      id: 'removedand_rejected'
      doc: 'Removed from Market'
    10:
      id: 'pending'
      doc: 'Pending'
  crossed_indicator:
    0:
      id: 'nocrossing'
      doc: 'No crossing (Order not subject to crossing)'
    1:
      id: 'crossrejected'
      doc: 'Cross rejected (Order subject to crossing and match prevented)'
  stop_px_indicator:
    0:
      id: 'donotoverwrite'
      doc: 'Do not overwrite'
    1:
      id: 'overwrite'
      doc: 'Overwrite'
  ownership_indicator:
    0:
      id: 'no_changeof_ownership'
      doc: 'Do not change ownership'
    1:
      id: 'changeto_executing_trader'
      doc: 'Change ownership to executing party (User ID)'
  match_type:
    3:
      id: 'confirmed_trade_report'
      doc: 'Confirmed Trade Report (reporting from recognized markets)'
    4:
      id: 'automatchincoming'
      doc: 'Auto-match incoming order'
    5:
      id: 'cross_auction'
      doc: 'Cross Auction'
    7:
      id: 'call_auction'
      doc: 'Call Auction'
    9:
      id: 'systematic_internaliser'
      doc: 'Systematic Internaliser'
    11:
      id: 'automatchresting'
      doc: 'Auto match resting order'
    12:
      id: 'automatchatmidpoint'
      doc: 'Auto match at midpoint'
    14:
      id: 'continous_auction'
      doc: 'Continous Aution'
  fill_liquidity_ind:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    4:
      id: 'auction'
      doc: 'Auction'
    5:
      id: 'triggered_stop_order'
      doc: 'Triggered Stop Order'
    6:
      id: 'triggered_oco_order'
      doc: 'Triggered OCO Order'
    7:
      id: 'triggered_market_order'
      doc: 'Triggered Market Order'
  requesting_party_id_executing_system:
    2:
      id: 't_7'
      doc: 'T7 trading system'
  party_action_type:
    1:
      id: 'halt_trading'
      doc: 'Halt trading'
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
  mass_action_type:
    1:
      id: 'suspendquotes'
      doc: 'Suspend quotes'
    2:
      id: 'releasequotes'
      doc: 'Release quotes from suspension'
  quote_event_liquidity_ind:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    4:
      id: 'auction'
      doc: 'Auction'
  quote_event_reason:
    14: 'pendingcancellationexecuted'
    15: 'invalidprice'
    16:
      id: 'crossrejected'
      doc: 'Quote subject to crossing and match prevented'
  rfq_publish_indicator:
    1:
      id: 'market_data'
      doc: 'Market Data(public)'
    2:
      id: 'designated_sponsor'
      doc: 'Designated Sponsor(private)'
    3:
      id: 'market_dataand_designated_sponsor'
      doc: 'Market Data(public) and Designated Sponsor(private)'
    4:
      id: 'market_makerand_designated_sponsor'
      doc: 'Market Maker(private) and Designated Sponsor(private)'
    5:
      id: 'market_dataand_market_makerand_designated_sponsor'
      doc: 'Market Data(public) and Market Maker(private) and Designated Sponsor(private)'
  rfq_requester_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  session_reject_reason:
    1:
      id: 'required_tag_missing'
      doc: 'Required Tag Missing'
    5:
      id: 'valueisincorrect'
      doc: 'Value is incorrect (out of range) for this tag'
    7:
      id: 'decryptionproblem'
      doc: 'Decryption problem'
    11:
      id: 'invalid_msg_id'
      doc: 'Invalid TemplateID'
    16:
      id: 'incorrect_num_in_groupcount'
      doc: 'Incorrect NumInGroup count for repeating group'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'throttle_limit_exceeded'
      doc: 'Throttle limit exceeded'
    101:
      id: 'exposure_limit_exceeded'
      doc: 'Stale request was not forwarded to T7'
    102:
      id: 'service_temporarily_not_available'
      doc: 'Service temporarily not available'
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
    211:
      id: 'user_already_logged_in'
      doc: 'User already logged in'
    214:
      id: 'session_gateway_assignment_expired'
      doc: 'Session Gateway assignment expired'
    215:
      id: 'gateway_not_reserved_to_session'
      doc: 'Gateway not reserved to Session'
    216:
      id: 'gateway_is_standby'
      doc: 'Login to a Standby Gateway'
    217:
      id: 'session_login_limit_reached'
      doc: 'Number of Session Logins exceeds limit'
    218:
      id: 'partition_not_reachable_by_hf_gateway'
      doc: 'Order Management request for a partition that is not reachable by the HF Gateway'
    219:
      id: 'partition_not_reachable_by_ps_gateway'
      doc: 'Order Management request for a partition that is not reachable by the PS Gateway'
    222:
      id: 'no_gateway_available'
      doc: 'No Gateway available'
    223:
      id: 'user_entitlement_data_timeout'
      doc: 'User Entitlement Data time out'
    10000:
      id: 'order_not_found'
      doc: 'Order not found'
    10001:
      id: 'price_not_reasonable'
      doc: 'Price not reasonable'
    10002:
      id: 'client_order_id_not_unique'
      doc: 'Duplicate Order (ClOrdID)'
    10003:
      id: 'quote_activation_in_progress'
      doc: 'another quote activation request is pending for the same Product / Instrument Type / SessionID'
    10004:
      id: 'bu_book_order_limit_exceeded'
      doc: 'Book Order limit exceeded on BU level'
    10005:
      id: 'session_book_order_limit_exceeded'
      doc: 'Book Order limit exceeded on Session level'
    10006:
      id: 'stop_bid_price_not_reasonable'
      doc: 'Stop buy price not reasonable'
    10007:
      id: 'stop_ask_price_not_reasonable'
      doc: 'Stop sell price not reasonable'
    10008:
      id: 'order_not_executable_within_validity'
      doc: 'GFD order is not executable on current business day'
    10009:
      id: 'invalid_trading_restriction_for_instrument_state'
      doc: 'BOC order rejected in state other than cont.'
    10011:
      id: 'transaction_not_allowed_in_current_state'
      doc: 'Order maintenance not allowed in current state'
  matching_engine_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  trade_manager_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  appl_seq_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  t_7_entry_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  t_7_entry_service_rtm_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  trade_alloc_status:
    1:
      id: 'pending'
      doc: 'Pending'
    2:
      id: 'approved'
      doc: 'Approved'
    3:
      id: 'auto_approved'
      doc: 'Auto Approved'
    4:
      id: 'uploaded'
      doc: 'Uploaded'
    5:
      id: 'canceled'
      doc: 'Canceled'
  message_event_source:
    0x49:
      id: 'broadcastto_initiator'
      doc: 'Broadcast to initiator'
    0x41:
      id: 'broadcastto_approver'
      doc: 'Broadcast to approver'
    0x52:
      id: 'broadcastto_requester'
      doc: 'Broadcast to requestor'
    0x51:
      id: 'broadcastto_quote_submitter'
      doc: 'Broadcast to quote submitter'
  delete_reason:
    100:
      id: 'nospecialreason'
      doc: 'Deletion via the TES Delete Request'
    101:
      id: 'tas_change'
      doc: 'Automatic deletion due to TES Activity State Change'
    102:
      id: 'intraday_expiration'
      doc: 'Automatic deletion due to instrument expiration'
    103:
      id: 'risk_event'
      doc: 'Deletion caused by Clearing/Risk stop'
    104:
      id: 'stop_trading'
      doc: 'Deletion caused by Trading stop'
  last_mkt:
    3:
      id: 'xetr'
      doc: 'XETR'
    4:
      id: 'xvie'
      doc: 'XVIE'
    5:
      id: 'xdub'
      doc: 'XDUB'
    6:
      id: 'xmal'
      doc: 'XMAL'
    7:
      id: 'xbul'
      doc: 'XBUL'
    8:
      id: 'xbud'
      doc: 'XBUD'
    9:
      id: 'xlju'
      doc: 'XLJU'
    10:
      id: 'xpra'
      doc: 'XPRA'
    11:
      id: 'xzag'
      doc: 'XZAG'
  transfer_reason:
    1:
      id: 'owner'
      doc: 'Owner'
    2:
      id: 'clearer'
      doc: 'Clearer'
  trade_publish_indicator:
    2:
      id: 'deferred_publication'
      doc: 'Deferred publication to market'
    3:
      id: 'published'
      doc: 'Published to market'
  last_coupon_deviation_indicator:
    0:
      id: 'none'
      doc: 'None'
    1:
      id: 'shortperiod'
      doc: 'Short period'
    2:
      id: 'longperiod'
      doc: 'Long period'
    3:
      id: 'onlyonecoupon'
      doc: 'Only one coupon'
    4:
      id: 'shorttwointerestpaymentsdue'
      doc: 'Short - two interest payments due'
    5:
      id: 'longtwointerestpaymentsdue'
      doc: 'Long - two interest payments due'
  refinancing_eligibility_indicator:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  root_party_id_investment_decision_maker_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
  trad_ses_event:
    101:
      id: 'startof_service'
      doc: 'Start of Service'
    102:
      id: 'market_reset'
      doc: 'Market Reset'
    103:
      id: 'endof_restatement'
      doc: 'End of Restatement'
    104:
      id: 'endof_day_service'
      doc: 'End of Service'
    105:
      id: 'service_resumed'
      doc: 'Service Resumed'
  match_sub_type:
    1:
      id: 'opening_auction'
      doc: 'Opening auction'
    2:
      id: 'closing_auction'
      doc: 'Closing auction'
    3:
      id: 'intraday_auction'
      doc: 'Intraday auction'
    4:
      id: 'circuit_breaker_auction'
      doc: 'Circuit Breaker auction'
  side_liquidity_ind:
    1:
      id: 'added_liquidity'
      doc: 'Added liquidity (passive)'
    2:
      id: 'removed_liquidity'
      doc: 'Removed liquidity (aggressive, includes triggered orders)'
    4:
      id: 'auction'
      doc: 'Auction (includes VDO matching at midpoint)'
  delivery_type:
    1:
      id: 'akv'
      doc: 'Auslandskassenverein'
    2:
      id: 'gs'
      doc: 'Girosammelverwahrung'
    3:
      id: 'str'
      doc: 'Streifbandverwahrung'
    4:
      id: 'wpr'
      doc: 'Wertpapierrechnung'
  order_category:
    0x31:
      id: 'order'
      doc: 'Order'
    0x32:
      id: 'quote'
      doc: 'Quote'

