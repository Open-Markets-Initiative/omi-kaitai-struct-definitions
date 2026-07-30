# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Eurex T7 Xti v13.0
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_xti_v13_0
  title: Eurex T7 Xti Fbe v13.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Cash Enhanced Trading Interface Fbe v13.0'
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
            'template_id::enter_tes_trade_request': enter_tes_trade_request
            'template_id::extended_deletion_report': extended_deletion_report
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::forced_user_logout_notification': forced_user_logout_notification
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::inquire_enrichment_rule_id_list_request': inquire_enrichment_rule_id_list_request
            'template_id::inquire_enrichment_rule_id_list_response': inquire_enrichment_rule_id_list_response
            'template_id::inquire_pre_trade_risk_limits_request': inquire_pre_trade_risk_limits_request
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::inquire_session_list_response': inquire_session_list_response
            'template_id::inquire_user_request': inquire_user_request
            'template_id::inquire_user_response': inquire_user_response
            'template_id::issuer_notification': issuer_notification
            'template_id::issuer_security_state_change_request': issuer_security_state_change_request
            'template_id::issuer_security_state_change_response': issuer_security_state_change_response
            'template_id::legal_notification_broadcast': legal_notification_broadcast
            'template_id::logon_request': logon_request
            'template_id::logon_request_encrypted': logon_request_encrypted
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::mass_quote_request': mass_quote_request
            'template_id::mass_quote_response': mass_quote_response
            'template_id::modify_order_nr_response': modify_order_nr_response
            'template_id::modify_order_request': modify_order_request
            'template_id::modify_order_response': modify_order_response
            'template_id::modify_order_short_request': modify_order_short_request
            'template_id::modify_order_single_request': modify_order_single_request
            'template_id::modify_order_single_short_request': modify_order_single_short_request
            'template_id::modify_tes_trade_request': modify_tes_trade_request
            'template_id::new_order_nr_response': new_order_nr_response
            'template_id::new_order_request': new_order_request
            'template_id::new_order_response': new_order_response
            'template_id::new_order_short_request': new_order_short_request
            'template_id::new_order_single_request': new_order_single_request
            'template_id::new_order_single_short_request': new_order_single_short_request
            'template_id::news_broadcast': news_broadcast
            'template_id::otc_response': otc_response
            'template_id::otc_upload_broadcast': otc_upload_broadcast
            'template_id::otc_upload_request': otc_upload_request
            'template_id::order_exec_notification': order_exec_notification
            'template_id::order_exec_report_broadcast': order_exec_report_broadcast
            'template_id::order_exec_response': order_exec_response
            'template_id::party_action_report': party_action_report
            'template_id::party_entitlements_update_report': party_entitlements_update_report
            'template_id::ping_request': ping_request
            'template_id::ping_response': ping_response
            'template_id::pre_trade_risk_limit_response': pre_trade_risk_limit_response
            'template_id::pre_trade_risk_limits_definition_request': pre_trade_risk_limits_definition_request
            'template_id::quote_activation_notification': quote_activation_notification
            'template_id::quote_activation_request': quote_activation_request
            'template_id::quote_activation_response': quote_activation_response
            'template_id::quote_execution_report': quote_execution_report
            'template_id::rfq_broadcast': rfq_broadcast
            'template_id::rfq_reject_notification': rfq_reject_notification
            'template_id::rfq_request': rfq_request
            'template_id::rfq_response': rfq_response
            'template_id::rfq_specialist_broadcast': rfq_specialist_broadcast
            'template_id::reject': reject
            'template_id::retransmit_me_message_request': retransmit_me_message_request
            'template_id::retransmit_me_message_response': retransmit_me_message_response
            'template_id::retransmit_request': retransmit_request
            'template_id::retransmit_response': retransmit_response
            'template_id::service_availability_broadcast': service_availability_broadcast
            'template_id::service_availability_market_broadcast': service_availability_market_broadcast
            'template_id::single_quote_request': single_quote_request
            'template_id::specialist_delete_all_order_broadcast': specialist_delete_all_order_broadcast
            'template_id::specialist_instrument_event_notification': specialist_instrument_event_notification
            'template_id::specialist_order_book_notification': specialist_order_book_notification
            'template_id::specialist_rfq_reject_request': specialist_rfq_reject_request
            'template_id::specialist_rfq_reply_notification': specialist_rfq_reply_notification
            'template_id::specialist_rfq_reply_request': specialist_rfq_reply_request
            'template_id::specialist_rfq_reply_response': specialist_rfq_reply_response
            'template_id::specialist_security_state_change_request': specialist_security_state_change_request
            'template_id::specialist_security_state_change_response': specialist_security_state_change_response
            'template_id::status_broadcast': status_broadcast
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
            'template_id::user_login_request_encrypted': user_login_request_encrypted
            'template_id::user_login_response': user_login_response
            'template_id::user_logout_request': user_logout_request
            'template_id::user_logout_response': user_logout_response
            'template_id::xetra_en_light_approve_deal_notification': xetra_en_light_approve_deal_notification
            'template_id::xetra_en_light_approve_deal_request': xetra_en_light_approve_deal_request
            'template_id::xetra_en_light_create_deal_notification': xetra_en_light_create_deal_notification
            'template_id::xetra_en_light_deal_response': xetra_en_light_deal_response
            'template_id::xetra_en_light_deal_status_notification': xetra_en_light_deal_status_notification
            'template_id::xetra_en_light_delete_all_quote_notification': xetra_en_light_delete_all_quote_notification
            'template_id::xetra_en_light_delete_all_quote_request': xetra_en_light_delete_all_quote_request
            'template_id::xetra_en_light_enter_quote_request': xetra_en_light_enter_quote_request
            'template_id::xetra_en_light_hit_quote_request': xetra_en_light_hit_quote_request
            'template_id::xetra_en_light_negotiation_notification': xetra_en_light_negotiation_notification
            'template_id::xetra_en_light_negotiation_requester_notification': xetra_en_light_negotiation_requester_notification
            'template_id::xetra_en_light_negotiation_status_notification': xetra_en_light_negotiation_status_notification
            'template_id::xetra_en_light_open_negotiation_notification': xetra_en_light_open_negotiation_notification
            'template_id::xetra_en_light_open_negotiation_request': xetra_en_light_open_negotiation_request
            'template_id::xetra_en_light_open_negotiation_requester_notification': xetra_en_light_open_negotiation_requester_notification
            'template_id::xetra_en_light_quote_notification': xetra_en_light_quote_notification
            'template_id::xetra_en_light_quote_requester_notification': xetra_en_light_quote_requester_notification
            'template_id::xetra_en_light_quote_response': xetra_en_light_quote_response
            'template_id::xetra_en_light_quote_snapshot_notification': xetra_en_light_quote_snapshot_notification
            'template_id::xetra_en_light_quote_snapshot_request': xetra_en_light_quote_snapshot_request
            'template_id::xetra_en_light_quoting_status_request': xetra_en_light_quoting_status_request
            'template_id::xetra_en_light_response': xetra_en_light_response
            'template_id::xetra_en_light_status_broadcast': xetra_en_light_status_broadcast
            'template_id::xetra_en_light_update_negotiation_request': xetra_en_light_update_negotiation_request
  message_header:
    seq:
      - id: body_len
        type: u4
      - id: template_id
        type: u2
        enum: template_id
  approve_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: alloc_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: package_id
        type: u4
      - id: alloc_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: side
        type: u1
        enum: side
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
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
      - id: pad_6
        size: 6
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4
      - id: sender_sub_id
        type: u4
  broadcast_error_notification:
    seq:
      - id: pad_2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: appl_id_status
        type: u4
        enum: appl_id_status
      - id: ref_appl_sub_id
        type: u4
      - id: len_var_text
        type: u2
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: session_status
        type: u1
        enum: session_status
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
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  cross_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: pad_4
        size: 4
  cross_request_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  nr_response_header_me_comp:
    seq:
      - id: request_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_out
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: response_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: msg_seq_num
        type: u4
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: pad_3
        size: 3
  delete_all_order_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: target_party_id_executing_trader
        type: u4
      - id: party_id_entering_trader
        type: u4
      - id: num_not_affected_orders_grp_comp
        type: u2
      - id: num_affected_ord_grp_comp
        type: u2
      - id: num_affected_order_requests_grp_comp
        type: u2
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: side
        type: u1
        enum: side
      - id: pad_6
        size: 6
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
      - id: affected_order_requests_grp_comp
        type: affected_order_requests_grp_comp
        repeat: expr
        repeat-expr: num_affected_order_requests_grp_comp
  rbc_header_me_comp:
    seq:
      - id: trd_reg_ts_time_out
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: notification_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: appl_sub_id
        type: u4
      - id: partition_id
        type: u2
      - id: appl_msg_id
        size: 16
      - id: appl_id
        type: u1
        enum: appl_id
      - id: appl_resend_flag
        type: u1
        enum: appl_resend_flag
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: pad_7
        size: 7
  not_affected_orders_grp_comp:
    seq:
      - id: not_affected_order_id
        type: u8
      - id: not_aff_orig_cl_ord_id
        type: u8
  affected_ord_grp_comp:
    seq:
      - id: affected_order_id
        type: u8
      - id: affected_orig_cl_ord_id
        type: u8
  affected_order_requests_grp_comp:
    seq:
      - id: affected_order_request_id
        type: u4
      - id: pad_4
        size: 4
  delete_all_order_nr_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  delete_all_order_quote_event_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: market_segment_id
        type: s4
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: pad_2_2
        size: 2
  delete_all_order_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: target_party_id_executing_trader
        type: u4
      - id: side
        type: u1
        enum: side
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
  delete_all_order_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_orders_grp_comp
        type: u2
      - id: num_affected_ord_grp_comp
        type: u2
      - id: num_affected_order_requests_grp_comp
        type: u2
      - id: pad_2_2
        size: 2
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
      - id: affected_order_requests_grp_comp
        type: affected_order_requests_grp_comp
        repeat: expr
        repeat-expr: num_affected_order_requests_grp_comp
  response_header_me_comp:
    seq:
      - id: request_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_out
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: response_in
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: msg_seq_num
        type: u4
      - id: partition_id
        type: u2
      - id: appl_id
        type: u1
        enum: appl_id
      - id: appl_msg_id
        size: 16
      - id: last_fragment
        type: u1
        enum: last_fragment
  delete_all_quote_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: party_id_entering_trader
        type: u4
      - id: target_party_id_executing_trader
        type: u4
      - id: num_not_affected_securities_grp_comp
        type: u2
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: target_party_id_desk_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  not_affected_securities_grp_comp:
    seq:
      - id: not_affected_security_id
        type: u8
  delete_all_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad_6
        size: 6
  delete_all_quote_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_securities_grp_comp
        type: u2
      - id: pad_6
        size: 6
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  delete_order_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: order_id_sfx
        type: u4
      - id: market_segment_id
        type: s4
      - id: party_id_entering_trader
        type: u4
      - id: party_id_session_id
        type: u4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: side
        type: u1
        enum: side
      - id: order_event_type
        type: u1
        enum: order_event_type
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_entering_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2_2
        size: 2
  delete_order_nr_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: pad_7
        size: 7
  delete_order_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: pad_7
        size: 7
  delete_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: fix_cl_ord_id
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
      - id: pad_6
        size: 6
  delete_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: package_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: tes_exec_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_5
        size: 5
  enter_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: settl_date
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_grp_comp
        type: u1
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
      - id: pad_3
        size: 3
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
  side_alloc_grp_comp:
    seq:
      - id: alloc_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: individual_alloc_id
        type: u4
      - id: tes_enrichment_rule_id
        type: u4
      - id: side
        type: u1
        enum: side
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
      - id: pad_4
        size: 4
  extended_deletion_report:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: expire_date
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: party_id_executing_unit
        type: u4
      - id: party_id_session_id
        type: u4
      - id: party_id_executing_trader
        type: u4
      - id: party_id_entering_trader
        type: u4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
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
      - id: party_entering_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_entering_trader
        type: str
        size: 6
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: triggered
        type: u1
        enum: triggered
      - id: pad_1
        size: 1
  forced_logout_notification:
    seq:
      - id: pad_2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: len_var_text
        type: u2
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
      - id: pad_2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: username
        type: u4
      - id: len_var_text
        type: u2
      - id: user_status
        type: u1
        enum: user_status
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  heartbeat:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
  heartbeat_notification:
    seq:
      - id: pad_2
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_entity_processed
        size: 16
  inquire_enrichment_rule_id_list_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
      - id: num_enrichment_rules_grp_comp
        type: u2
      - id: pad_6
        size: 6
      - id: enrichment_rules_grp_comp
        type: enrichment_rules_grp_comp
        repeat: expr
        repeat-expr: num_enrichment_rules_grp_comp
  response_header_comp:
    seq:
      - id: request_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: msg_seq_num
        type: u4
      - id: pad_4
        size: 4
  enrichment_rules_grp_comp:
    seq:
      - id: enrichment_rule_id
        type: u2
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
      - id: pad_6
        size: 6
  inquire_pre_trade_risk_limits_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: market_segment_id
        type: s4
      - id: party_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: risk_limit_group
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad_4
        size: 4
  inquire_session_list_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
  inquire_session_list_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: num_sessions_grp_comp
        type: u2
      - id: pad_6
        size: 6
      - id: sessions_grp_comp
        type: sessions_grp_comp
        repeat: expr
        repeat-expr: num_sessions_grp_comp
  sessions_grp_comp:
    seq:
      - id: party_id_session_id
        type: u4
      - id: session_mode
        type: u1
        enum: session_mode
      - id: session_sub_mode
        type: u1
        enum: session_sub_mode
      - id: pad_2
        size: 2
  inquire_user_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_entity_processed
        size: 16
  inquire_user_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
      - id: num_party_details_grp_comp
        type: u2
      - id: pad_6
        size: 6
      - id: party_details_grp_comp
        type: party_details_grp_comp
        repeat: expr
        repeat-expr: num_party_details_grp_comp
  party_details_grp_comp:
    seq:
      - id: party_detail_id_executing_trader
        type: u4
      - id: party_detail_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: party_detail_role_qualifier
        type: u1
        enum: party_detail_role_qualifier
      - id: party_detail_status
        type: u1
        enum: party_detail_status
      - id: party_detail_desk_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
  issuer_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: potential_exec_volume
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: imbalance_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: party_id_session_id
        type: u4
      - id: security_trading_status
        type: u1
        enum: security_trading_status
      - id: pad_7
        size: 7
  issuer_security_state_change_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_security_status_event_grp_comp
        type: u1
      - id: security_status
        type: u1
        enum: security_status
      - id: sold_out_indicator
        type: u1
        enum: sold_out_indicator
      - id: pad_1
        size: 1
      - id: security_status_event_grp_comp
        type: security_status_event_grp_comp
        repeat: expr
        repeat-expr: num_security_status_event_grp_comp
  security_status_event_grp_comp:
    seq:
      - id: event_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: event_date
        type: u4
      - id: event_type
        type: u1
        enum: event_type
      - id: pad_3
        size: 3
  issuer_security_state_change_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: security_status_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  legal_notification_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: len_var_text
        type: u2
      - id: user_status
        type: u1
        enum: user_status
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
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: appl_seq_num
        type: u8
      - id: appl_sub_id
        type: u4
      - id: partition_id
        type: u2
      - id: appl_resend_flag
        type: u1
        enum: appl_resend_flag
      - id: appl_id
        type: u1
        enum: appl_id
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: pad_7
        size: 7
  logon_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: heart_bt_int
        type: u4
      - id: party_id_session_id
        type: u4
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
      - id: pad_3
        size: 3
  logon_request_encrypted:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: heart_bt_int
        type: u4
      - id: party_id_session_id
        type: u4
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: encrypted_password
        type: str
        size: 684
        encoding: ASCII
        pad-right: 0x20
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
      - id: pad_7
        size: 7
  logon_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: throttle_time_interval
        type: s8
      - id: throttle_no_msgs
        type: u4
      - id: throttle_disconnect_limit
        type: u4
      - id: heart_bt_int
        type: u4
      - id: session_instance_id
        type: u4
      - id: latest_public_key_seq_no
        type: u4
      - id: len_public_key
        type: u2
      - id: market_id
        type: u2
        enum: market_id
      - id: trad_ses_mode
        type: u1
        enum: trad_ses_mode
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: default_cstm_appl_ver_sub_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: public_key
        type: str
        size: len_public_key
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  logout_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
  logout_response:
    seq:
      - id: pad_2
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: quote_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: match_inst_cross_id
        type: u4
      - id: enrichment_rule_id
        type: u2
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: quote_size_type
        type: u1
        enum: quote_size_type
      - id: quote_type
        type: u1
        enum: quote_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: num_quote_entry_grp_comp
        type: u1
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad_4
        size: 4
      - id: quote_entry_grp_comp
        type: quote_entry_grp_comp
        repeat: expr
        repeat-expr: num_quote_entry_grp_comp
  quote_entry_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
  mass_quote_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: quote_id
        type: u8
      - id: quote_response_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_quote_entry_ack_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: quote_entry_ack_grp_comp
        type: quote_entry_ack_grp_comp
        repeat: expr
        repeat-expr: num_quote_entry_ack_grp_comp
  quote_entry_ack_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: cxl_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_entry_reject_reason
        type: u4
        enum: quote_entry_reject_reason
      - id: quote_entry_status
        type: u1
        enum: quote_entry_status
      - id: side
        type: u1
        enum: side
      - id: pad_2
        size: 2
  modify_order_nr_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: num_order_event_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  order_event_grp_comp:
    seq:
      - id: order_event_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_event_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_event_match_id
        type: u4
      - id: order_event_reason
        type: u1
        enum: order_event_reason
      - id: pad_3
        size: 3
  modify_order_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: order_id
        type: u8
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: match_inst_cross_id
        type: u4
      - id: expire_date
        type: u4
      - id: target_party_id_session_id
        type: u4
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: stop_px_indicator
        type: u1
        enum: stop_px_indicator
      - id: ownership_indicator
        type: u1
        enum: ownership_indicator
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
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: ord_type
        type: u1
        enum: ord_type
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_origination
        type: u1
        enum: order_origination
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
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: pad_2_2
        size: 2
      - id: party_id_investment_decision_maker
        type: u8
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: pad_2v_1
        size: 2
      - id: market_segment_id
        type: s4
      - id: security_id
        type: s8
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: check_sum_correction
        type: u2
      - id: pad_2v_2
        size: 2
  modify_order_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: num_order_event_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  modify_order_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: match_inst_cross_id
        type: u4
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_origination
        type: u1
        enum: order_origination
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: pad_4
        size: 4
      - id: party_id_investment_decision_maker
        type: u8
      - id: enrichment_rule_id
        type: u2
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: pad_5
        size: 5
      - id: security_id
        type: s8
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: check_sum_correction
        type: u2
      - id: pad_2_2
        size: 2
  modify_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: expire_date
        type: u4
      - id: market_segment_id
        type: s4
      - id: match_inst_cross_id
        type: u4
      - id: target_party_id_session_id
        type: u4
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: stop_px_indicator
        type: u1
        enum: stop_px_indicator
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: ownership_indicator
        type: u1
        enum: ownership_indicator
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  modify_order_single_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: match_inst_cross_id
        type: u4
      - id: enrichment_rule_id
        type: u2
      - id: side
        type: u1
        enum: side
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad_5
        size: 5
  modify_tes_trade_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: settl_date
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_grp_comp
        type: u1
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
      - id: pad_3
        size: 3
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
  new_order_nr_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: num_order_event_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  new_order_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: cl_ord_id
        type: u8
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: quote_id
        type: u8
      - id: target_party_id_session_id
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: expire_date
        type: u4
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: trade_at_close_opt_in
        type: u1
        enum: trade_at_close_opt_in
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: ord_type
        type: u1
        enum: ord_type
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_origination
        type: u1
        enum: order_origination
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: pad_3
        size: 3
      - id: party_id_investment_decision_maker
        type: u8
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: pad_2_2
        size: 2
      - id: market_segment_id
        type: s4
      - id: security_id
        type: s8
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: check_sum_correction
        type: u2
      - id: pad_2v_1
        size: 2
  new_order_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: trd_reg_ts_entry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_id_sfx
        type: u4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: num_order_event_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  new_order_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: cl_ord_id
        type: u8
      - id: party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: match_inst_cross_id
        type: u4
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_origination
        type: u1
        enum: order_origination
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: pad_4
        size: 4
      - id: party_id_investment_decision_maker
        type: u8
      - id: enrichment_rule_id
        type: u2
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: pad_5
        size: 5
      - id: security_id
        type: s8
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: side
        type: u1
        enum: side
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: check_sum_correction
        type: u2
      - id: pad_2_2
        size: 2
  new_order_single_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: quote_id
        type: u8
      - id: expire_date
        type: u4
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: trade_at_close_opt_in
        type: u1
        enum: trade_at_close_opt_in
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
  new_order_single_short_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cl_ord_id
        type: u8
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: match_inst_cross_id
        type: u4
      - id: enrichment_rule_id
        type: u2
      - id: side
        type: u1
        enum: side
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: order_origination
        type: u1
        enum: order_origination
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad_5
        size: 5
  news_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: orig_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: len_var_text
        type: u2
      - id: headline
        type: str
        size: 256
        encoding: ASCII
        pad-right: 0x20
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  otc_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: otc_exec_id
        type: u4
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  otc_upload_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: otc_exec_id
        type: u4
      - id: pad_4
        size: 4
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: transaction_cost_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: settl_date
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_otc_grp_comp
        type: u1
      - id: transaction_cost_code
        type: u1
        enum: transaction_cost_code
      - id: trade_platform
        type: u1
        enum: trade_platform
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
      - id: side_alloc_otc_grp_comp
        type: side_alloc_otc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_otc_grp_comp
  side_alloc_otc_grp_comp:
    seq:
      - id: side
        type: u1
        enum: side
      - id: trading_capacity
        type: u1
        enum: trading_capacity
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
      - id: pad_3
        size: 3
  otc_upload_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: transaction_cost_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: settl_date
        type: u4
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: num_side_alloc_otc_grp_comp
        type: u1
      - id: transaction_cost_code
        type: u1
        enum: transaction_cost_code
      - id: trade_platform
        type: u1
        enum: trade_platform
      - id: settl_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
      - id: side_alloc_otc_grp_comp
        type: side_alloc_otc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_otc_grp_comp
  order_exec_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: side
        type: u1
        enum: side
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: order_event_type
        type: u1
        enum: order_event_type
      - id: match_type
        type: u1
        enum: match_type
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_fills_grp_comp
        type: u1
      - id: num_order_event_grp_comp
        type: u1
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  fills_grp_comp:
    seq:
      - id: fill_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: fill_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: fill_match_id
        type: u4
      - id: fill_exec_id
        type: s4
      - id: fill_liquidity_ind
        type: u1
        enum: fill_liquidity_ind
      - id: pad_7
        size: 7
  order_exec_report_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_low_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_high_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: min_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: expire_date
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: party_id_executing_unit
        type: u4
      - id: party_id_session_id
        type: u4
      - id: party_id_executing_trader
        type: u4
      - id: party_id_entering_trader
        type: u4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: order_event_type
        type: u1
        enum: order_event_type
      - id: match_type
        type: u1
        enum: match_type
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: mid_point_type
        type: u1
        enum: mid_point_type
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: party_entering_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_entering_trader
        type: str
        size: 6
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_fills_grp_comp
        type: u1
      - id: num_order_event_grp_comp
        type: u1
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: trade_at_close_opt_in
        type: u1
        enum: trade_at_close_opt_in
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: pad_1
        size: 1
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  order_exec_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_me_comp
        type: response_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: display_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: side
        type: u1
        enum: side
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: match_type
        type: u1
        enum: match_type
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: num_fills_grp_comp
        type: u1
      - id: num_order_event_grp_comp
        type: u1
      - id: pad_4
        size: 4
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  party_action_report:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trade_date
        type: u4
      - id: requesting_party_id_executing_trader
        type: u4
      - id: party_id_executing_unit
        type: u4
      - id: party_id_executing_trader
        type: u4
      - id: requesting_party_id_executing_system
        type: u4
        enum: requesting_party_id_executing_system
      - id: market_id
        type: u2
        enum: market_id
      - id: party_action_type
        type: u1
        enum: party_action_type
      - id: requesting_party_id_entering_firm
        type: u1
        enum: requesting_party_id_entering_firm
  party_entitlements_update_report:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trade_date
        type: u4
      - id: party_detail_id_executing_unit
        type: u4
      - id: requesting_party_id_executing_system
        type: u4
        enum: requesting_party_id_executing_system
      - id: market_id
        type: u2
        enum: market_id
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
        type: u1
        enum: party_detail_status
      - id: pad_6
        size: 6
  ping_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: partition_id
        type: u2
      - id: pad_6
        size: 6
  ping_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  pre_trade_risk_limit_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: risk_limit_report_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: num_risk_limits_rpt_grp_comp
        type: u1
      - id: party_detail_status
        type: u1
        enum: party_detail_status
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_5
        size: 5
      - id: risk_limits_rpt_grp_comp
        type: risk_limits_rpt_grp_comp
        repeat: expr
        repeat-expr: num_risk_limits_rpt_grp_comp
  risk_limits_rpt_grp_comp:
    seq:
      - id: risk_limit_amount
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: risk_limit_open_amount
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: risk_limit_net_position_amount
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: activation_date
        type: u4
      - id: risk_limit_type
        type: u1
        enum: risk_limit_type
      - id: risk_limit_requesting_party_role
        type: u1
        enum: risk_limit_requesting_party_role
      - id: risk_limit_violation_indicator
        type: u1
        enum: risk_limit_violation_indicator
      - id: risk_limit_group
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad_6
        size: 6
  pre_trade_risk_limits_definition_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: market_segment_id
        type: s4
      - id: num_risk_limit_amount_grp_comp
        type: u1
      - id: party_detail_status
        type: u1
        enum: party_detail_status
      - id: risk_limit_group
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2_2
        size: 2
      - id: risk_limit_amount_grp_comp
        type: risk_limit_amount_grp_comp
        repeat: expr
        repeat-expr: num_risk_limit_amount_grp_comp
  risk_limit_amount_grp_comp:
    seq:
      - id: risk_limit_amount
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: risk_limit_type
        type: u1
        enum: risk_limit_type
      - id: pad_7
        size: 7
  quote_activation_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: party_id_entering_trader
        type: u4
      - id: num_not_affected_securities_grp_comp
        type: u2
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: mass_action_type
        type: u1
        enum: mass_action_type
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: pad_3
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: mass_action_type
        type: u1
        enum: mass_action_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad_5
        size: 5
  quote_activation_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_securities_grp_comp
        type: u2
      - id: pad_6
        size: 6
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  quote_execution_report:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_quote_event_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: quote_event_grp_comp
        type: quote_event_grp_comp
        repeat: expr
        repeat-expr: num_quote_event_grp_comp
  quote_event_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: quote_event_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: quote_event_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_msg_id
        type: u8
      - id: quote_event_match_id
        type: u4
      - id: quote_event_exec_id
        type: s4
      - id: quote_event_type
        type: u1
        enum: quote_event_type
      - id: quote_event_side
        type: u1
        enum: quote_event_side
      - id: quote_event_liquidity_ind
        type: u1
        enum: quote_event_liquidity_ind
      - id: bbo_setting
        type: u1
        enum: bbo_setting
      - id: quote_event_reason
        type: u1
        enum: quote_event_reason
      - id: pad_3
        size: 3
  rfq_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: side
        type: u1
        enum: side
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_6
        size: 6
  rfq_reject_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: quote_request_reject_reason
        type: u1
        enum: quote_request_reject_reason
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_6
        size: 6
  rfq_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: rfq_publish_indicator
        type: u1
        enum: rfq_publish_indicator
      - id: rfq_requester_disclosure_instruction
        type: u1
        enum: rfq_requester_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: pad_1
        size: 1
  rfq_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  rfq_specialist_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: side
        type: u1
        enum: side
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_6
        size: 6
  reject:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: session_reject_reason
        type: u4
        enum: session_reject_reason
      - id: len_var_text
        type: u2
      - id: session_status
        type: u1
        enum: session_status
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: subscription_scope
        type: u4
      - id: partition_id
        type: u2
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: appl_beg_msg_id
        size: 16
      - id: appl_end_msg_id
        size: 16
      - id: pad_1
        size: 1
  retransmit_me_message_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_total_message_count
        type: u2
      - id: appl_end_msg_id
        size: 16
      - id: ref_appl_last_msg_id
        size: 16
      - id: pad_6
        size: 6
  retransmit_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: appl_beg_seq_num
        type: u8
      - id: appl_end_seq_num
        type: u8
      - id: partition_id
        type: u2
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: pad_5
        size: 5
  retransmit_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_end_seq_num
        type: u8
      - id: ref_appl_last_seq_num
        type: u8
      - id: appl_total_message_count
        type: u2
      - id: pad_6
        size: 6
  service_availability_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: matching_engine_trade_date
        type: u4
      - id: trade_manager_trade_date
        type: u4
      - id: appl_seq_trade_date
        type: u4
      - id: t_7_entry_service_trade_date
        type: u4
      - id: t_7_entry_service_rtm_trade_date
        type: u4
      - id: partition_id
        type: u2
      - id: matching_engine_status
        type: u1
        enum: matching_engine_status
      - id: trade_manager_status
        type: u1
        enum: trade_manager_status
      - id: appl_seq_status
        type: u1
        enum: appl_seq_status
      - id: t_7_entry_service_status
        type: u1
        enum: t_7_entry_service_status
      - id: t_7_entry_service_rtm_status
        type: u1
        enum: t_7_entry_service_rtm_status
      - id: pad_5
        size: 5
  nrbc_header_comp:
    seq:
      - id: sending_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: appl_sub_id
        type: u4
      - id: appl_id
        type: u1
        enum: appl_id
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: pad_2
        size: 2
  service_availability_market_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: selective_request_for_quote_service_trade_date
        type: u4
      - id: selective_request_for_quote_service_status
        type: u1
        enum: selective_request_for_quote_service_status
      - id: selective_request_for_quote_rtm_service_status
        type: u1
        enum: selective_request_for_quote_rtm_service_status
      - id: news_rtm_service_status
        type: u1
        enum: news_rtm_service_status
      - id: risk_control_rtm_service_status
        type: u1
        enum: risk_control_rtm_service_status
  single_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: quote_id
        type: u8
      - id: security_id
        type: s8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: match_inst_cross_id
        type: u4
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: quote_size_type
        type: u1
        enum: quote_size_type
      - id: quote_type
        type: u1
        enum: quote_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
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
      - id: pad_7
        size: 7
  specialist_delete_all_order_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: party_id_entering_trader
        type: u4
      - id: num_affected_ord_grp_comp
        type: u2
      - id: num_not_affected_orders_grp_comp
        type: u2
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: pad_2_2
        size: 2
      - id: affected_ord_grp_comp
        type: affected_ord_grp_comp
        repeat: expr
        repeat-expr: num_affected_ord_grp_comp
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
  specialist_instrument_event_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: event_type
        type: u1
        enum: event_type
      - id: pad_3
        size: 3
  specialist_order_book_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: expire_date
        type: u4
      - id: party_id_executing_unit
        type: u4
      - id: party_id_session_id
        type: u4
      - id: party_id_executing_trader
        type: u4
      - id: party_id_entering_trader
        type: u4
      - id: num_fills_grp_comp
        type: u1
      - id: pad_1
        size: 1
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: order_event_type
        type: u1
        enum: order_event_type
      - id: match_type
        type: u1
        enum: match_type
      - id: side
        type: u1
        enum: side
      - id: ord_type
        type: u1
        enum: ord_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: triggered
        type: u1
        enum: triggered
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: party_entering_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_entering_trader
        type: str
        size: 6
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
  specialist_rfq_reject_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: quote_id
        type: u8
      - id: market_segment_id
        type: s4
      - id: quote_request_reject_reason
        type: u1
        enum: quote_request_reject_reason
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_6
        size: 6
  specialist_rfq_reply_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_id
        type: u8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_7
        size: 7
  specialist_rfq_reply_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: quote_id
        type: u8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad_7
        size: 7
  specialist_rfq_reply_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  specialist_security_state_change_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: market_segment_id
        type: s4
      - id: event_type
        type: u1
        enum: event_type
      - id: pad_3
        size: 3
  specialist_security_state_change_response:
    seq:
      - id: pad_2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: security_status_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  status_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad_3
        size: 3
  subscribe_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: subscription_scope
        type: u4
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: pad_3
        size: 3
  subscribe_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_sub_id
        type: u4
      - id: pad_4
        size: 4
  tes_approve_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: alloc_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: alloc_id
        type: u4
      - id: settl_date
        type: u4
      - id: tes_enrichment_rule_id
        type: u4
      - id: auto_approval_rule_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: len_var_text
        type: u2
      - id: side
        type: u1
        enum: side
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: trade_alloc_status
        type: u1
        enum: trade_alloc_status
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
        type: u1
        enum: party_id_entering_firm
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
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  tes_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: settl_date
        type: u4
      - id: auto_approval_rule_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: len_var_text
        type: u2
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_grp_bc_comp
        type: u1
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
      - id: var_text
        type: str
        size: len_var_text
        encoding: ASCII
        pad-right: 0x20
      - id: alignment_padding
        size: _parent.message_header.body_len - _io.pos
        doc: 'Alignment'
  side_alloc_grp_bc_comp:
    seq:
      - id: alloc_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: individual_alloc_id
        type: u4
      - id: tes_enrichment_rule_id
        type: u4
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
        type: u1
        enum: side
      - id: trade_alloc_status
        type: u1
        enum: trade_alloc_status
      - id: pad_3
        size: 3
  tes_delete_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: delete_reason
        type: u1
        enum: delete_reason
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2_2
        size: 2
  tes_execution_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: alloc_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: side
        type: u1
        enum: side
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: pad_2_2
        size: 2
  tes_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: tes_exec_id
        type: u4
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  tes_trade_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trans_bkd_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: settl_curr_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: side_gross_trade_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: accrued_interes_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: coupon_rate
        type: u8
        doc: 'Implied decimal with scale 1e-7'
      - id: root_party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: root_party_id_investment_decision_maker
        type: u8
      - id: transaction_cost_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: package_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: trade_id
        type: u4
      - id: trade_date
        type: u4
      - id: side_trade_id
        type: u4
      - id: root_party_id_session_id
        type: u4
      - id: root_party_id_settlement_unit
        type: u4
      - id: root_party_id_contra_unit
        type: u4
      - id: root_party_id_contra_settlement_unit
        type: u4
      - id: orig_trade_id
        type: u4
      - id: root_party_id_executing_unit
        type: u4
      - id: root_party_id_executing_trader
        type: u4
      - id: root_party_id_clearing_unit
        type: u4
      - id: settl_date
        type: u4
      - id: num_days_interest
        type: u4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: last_mkt
        type: u2
        enum: last_mkt
      - id: side
        type: u1
        enum: side
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: transfer_reason
        type: u1
        enum: transfer_reason
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: delivery_type
        type: u1
        enum: delivery_type
      - id: last_coupon_deviation_indicator
        type: u1
        enum: last_coupon_deviation_indicator
      - id: refinancing_eligibility_indicator
        type: u1
        enum: refinancing_eligibility_indicator
      - id: clearing_instruction
        type: u1
        enum: clearing_instruction
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: root_party_id_investment_decision_maker_qualifier
        type: u1
        enum: root_party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
      - id: transaction_cost_code
        type: u1
        enum: transaction_cost_code
      - id: trade_platform
        type: u1
        enum: trade_platform
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
      - id: root_party_id_execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_5
        size: 5
  tes_trading_session_status_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad_3
        size: 3
  tm_trading_session_status_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad_7
        size: 7
  throttle_update_notification:
    seq:
      - id: pad_2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: throttle_time_interval
        type: s8
      - id: throttle_no_msgs
        type: u4
      - id: throttle_disconnect_limit
        type: u4
  trade_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: settl_curr_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: settl_curr_fx_rate
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: side_gross_trade_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: accrued_interes_amt
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: coupon_rate
        type: u8
        doc: 'Implied decimal with scale 1e-7'
      - id: root_party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: root_party_id_investment_decision_maker
        type: u8
      - id: trade_id
        type: u4
      - id: orig_trade_id
        type: u4
      - id: root_party_id_executing_unit
        type: u4
      - id: root_party_id_session_id
        type: u4
      - id: root_party_id_executing_trader
        type: u4
      - id: root_party_id_settlement_unit
        type: u4
      - id: root_party_id_clearing_unit
        type: u4
      - id: root_party_id_contra_unit
        type: u4
      - id: root_party_id_contra_settlement_unit
        type: u4
      - id: party_id_specialist_trader
        type: u4
      - id: order_id_sfx
        type: u4
      - id: market_segment_id
        type: s4
      - id: side_trade_id
        type: u4
      - id: side_trade_report_id
        type: u4
      - id: trade_number
        type: u4
      - id: match_date
        type: u4
      - id: settl_date
        type: u4
      - id: trd_match_id
        type: u4
      - id: num_days_interest
        type: u4
      - id: last_mkt
        type: u2
        enum: last_mkt
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: transfer_reason
        type: u1
        enum: transfer_reason
      - id: match_type
        type: u1
        enum: match_type
      - id: match_sub_type
        type: u1
        enum: match_sub_type
      - id: side
        type: u1
        enum: side
      - id: side_liquidity_ind
        type: u1
        enum: side_liquidity_ind
      - id: delivery_type
        type: u1
        enum: delivery_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: last_coupon_deviation_indicator
        type: u1
        enum: last_coupon_deviation_indicator
      - id: refinancing_eligibility_indicator
        type: u1
        enum: refinancing_eligibility_indicator
      - id: clearing_instruction
        type: u1
        enum: clearing_instruction
      - id: order_origination
        type: u1
        enum: order_origination
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: root_party_id_investment_decision_maker_qualifier
        type: u1
        enum: root_party_id_investment_decision_maker_qualifier
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
        type: u1
        enum: ord_type
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
      - id: party_specialist_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_specialist_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_id_execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: pad_3
        size: 3
  trading_session_status_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: market_segment_id
        type: s4
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: ref_appl_last_msg_id
        size: 16
      - id: pad_7
        size: 7
  trailing_stop_update_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: order_id_sfx
        type: u4
      - id: market_segment_id
        type: s4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: side
        type: u1
        enum: side
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_7
        size: 7
  unsubscribe_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: ref_appl_sub_id
        type: u4
      - id: pad_4
        size: 4
  unsubscribe_response:
    seq:
      - id: pad_2
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: username
        type: u4
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad_4
        size: 4
  user_login_request_encrypted:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: username
        type: u4
      - id: encrypted_password
        type: str
        size: 684
        encoding: ASCII
        pad-right: 0x20
  user_login_response:
    seq:
      - id: pad_2
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
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: username
        type: u4
      - id: pad_4
        size: 4
  user_logout_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  xetra_en_light_approve_deal_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: requesting_side
        type: u1
        enum: requesting_side
      - id: target_side
        type: u1
        enum: target_side
      - id: message_event_source
        type: u1
        enum: message_event_source
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
      - id: requesting_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: requesting_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad_7
        size: 7
  xetra_en_light_approve_deal_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: trade_report_type
        type: u1
        enum: trade_report_type
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
  xetra_en_light_create_deal_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: security_id
        type: s8
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: settl_date
        type: u4
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: side
        type: u1
        enum: side
      - id: alloc_method
        type: u1
        enum: alloc_method
      - id: auto_exec_type
        type: u1
        enum: auto_exec_type
      - id: num_order_book_item_grp_comp
        type: u1
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
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
      - id: root_party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: firm_trade_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
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
      - id: order_book_item_grp_comp
        type: order_book_item_grp_comp
        repeat: expr
        repeat-expr: num_order_book_item_grp_comp
  order_book_item_grp_comp:
    seq:
      - id: best_bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: best_bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: best_offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: best_offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: md_book_type
        type: u1
        enum: md_book_type
      - id: md_sub_book_type
        type: u1
        enum: md_sub_book_type
      - id: pad_6
        size: 6
  xetra_en_light_deal_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: security_id
        type: s8
      - id: quote_id
        type: u8
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: secondary_trade_id
        type: u4
      - id: firm_trade_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_4
        size: 4
  xetra_en_light_deal_status_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: pad_2_2
        size: 2
  xetra_en_light_delete_all_quote_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: target_party_id_session_id
        type: u4
      - id: pad_4
        size: 4
  xetra_en_light_delete_all_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: target_party_id_session_id
        type: u4
      - id: pad_4
        size: 4
  xetra_en_light_enter_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: valid_until_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: quoting_frequency
        type: u1
        enum: quoting_frequency
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
      - id: pad_6
        size: 6
  xetra_en_light_hit_quote_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: quote_id
        type: u8
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: side
        type: u1
        enum: side
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: alloc_method
        type: u1
        enum: alloc_method
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
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
      - id: firm_trade_id
        type: str
        size: 20
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
  xetra_en_light_negotiation_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
        type: u4
      - id: number_of_respondents
        type: u4
      - id: settl_date
        type: u4
      - id: side
        type: u1
        enum: side
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad_5
        size: 5
  xetra_en_light_negotiation_requester_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_execution_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: auto_exec_limit_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: expire_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: auto_exec_expiry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: negotiation_id
        type: u4
      - id: number_of_respondents
        type: u4
      - id: settl_date
        type: u4
      - id: auto_exec_reference_price_offset
        type: s4
      - id: auto_exec_min_no_of_quotes
        type: u4
      - id: num_xetra_en_light_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: quote_type
        type: u1
        enum: quote_type
      - id: respondent_type
        type: u1
        enum: respondent_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: auto_exec_type
        type: u1
        enum: auto_exec_type
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: closure_reason
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: xetra_en_light_target_parties_comp
        type: xetra_en_light_target_parties_comp
        repeat: expr
        repeat-expr: num_xetra_en_light_target_parties_comp
  xetra_en_light_target_parties_comp:
    seq:
      - id: target_party_id_executing_trader
        type: u4
      - id: target_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
  xetra_en_light_negotiation_status_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_id
        type: u4
      - id: quote_condition
        type: u1
        enum: quote_condition
      - id: firm_negotiation_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad_7
        size: 7
  xetra_en_light_open_negotiation_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_start_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: expire_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: number_of_respondents
        type: u4
      - id: settl_date
        type: u4
      - id: side
        type: u1
        enum: side
      - id: quote_type
        type: u1
        enum: quote_type
      - id: respondent_type
        type: u1
        enum: respondent_type
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: target_party_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
  xetra_en_light_open_negotiation_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: valid_until_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: auto_exec_limit_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: settl_date
        type: u4
      - id: auto_exec_exposure_duration
        type: u4
      - id: auto_exec_reference_price_offset
        type: s4
      - id: auto_exec_min_no_of_quotes
        type: u4
      - id: num_xetra_en_light_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: respondent_type
        type: u1
        enum: respondent_type
      - id: bid_px_is_locked
        type: u1
        enum: bid_px_is_locked
      - id: offer_px_is_locked
        type: u1
        enum: offer_px_is_locked
      - id: side_is_locked
        type: u1
        enum: side_is_locked
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: auto_exec_type
        type: u1
        enum: auto_exec_type
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: quote_req_id
        type: str
        size: 20
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
      - id: xetra_en_light_target_parties_comp
        type: xetra_en_light_target_parties_comp
        repeat: expr
        repeat-expr: num_xetra_en_light_target_parties_comp
  xetra_en_light_open_negotiation_requester_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: expire_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: auto_exec_expiry_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: auto_exec_limit_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: negotiation_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: number_of_respondents
        type: u4
      - id: settl_date
        type: u4
      - id: auto_exec_reference_price_offset
        type: s4
      - id: auto_exec_min_no_of_quotes
        type: u4
      - id: num_xetra_en_light_target_parties_comp
        type: u1
      - id: side
        type: u1
        enum: side
      - id: quote_type
        type: u1
        enum: quote_type
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: respondent_type
        type: u1
        enum: respondent_type
      - id: bid_px_is_locked
        type: u1
        enum: bid_px_is_locked
      - id: offer_px_is_locked
        type: u1
        enum: offer_px_is_locked
      - id: side_is_locked
        type: u1
        enum: side_is_locked
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: auto_exec_type
        type: u1
        enum: auto_exec_type
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: firm_negotiation_id
        type: str
        size: 20
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad_5
        size: 5
      - id: xetra_en_light_target_parties_comp
        type: xetra_en_light_target_parties_comp
        repeat: expr
        repeat-expr: num_xetra_en_light_target_parties_comp
  xetra_en_light_quote_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_id
        type: u8
      - id: secondary_quote_id
        type: u8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: expire_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_id
        type: u4
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: quoting_status
        type: u1
        enum: quoting_status
      - id: quote_event_reason
        type: u1
        enum: quote_event_reason
      - id: quote_cancel_reason
        type: u1
        enum: quote_cancel_reason
      - id: quoting_frequency
        type: u1
        enum: quoting_frequency
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: quote_req_id
        type: str
        size: 20
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
      - id: pad_2_2
        size: 2
  xetra_en_light_quote_requester_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: quote_req_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_srqs_quote_entry_grp_comp
        type: u1
      - id: pad_3
        size: 3
      - id: srqs_quote_entry_grp_comp
        type: srqs_quote_entry_grp_comp
        repeat: expr
        repeat-expr: num_srqs_quote_entry_grp_comp
  srqs_quote_entry_grp_comp:
    seq:
      - id: transact_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: expire_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_id
        type: u8
      - id: secondary_quote_id
        type: u8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_executing_trader
        type: u4
      - id: negotiation_id
        type: u4
      - id: quoting_status
        type: u1
        enum: quoting_status
      - id: quoting_frequency
        type: u1
        enum: quoting_frequency
      - id: firm_negotiation_id
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
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad_1
        size: 1
  xetra_en_light_quote_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: quote_id
        type: u8
      - id: negotiation_id
        type: u4
      - id: quote_req_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  xetra_en_light_quote_snapshot_notification:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: num_srqs_quote_entry_grp_comp
        type: u1
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: pad_6
        size: 6
      - id: srqs_quote_entry_grp_comp
        type: srqs_quote_entry_grp_comp
        repeat: expr
        repeat-expr: num_srqs_quote_entry_grp_comp
  xetra_en_light_quote_snapshot_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
  xetra_en_light_quoting_status_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: quoting_status
        type: u1
        enum: quoting_status
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
      - id: pad_4
        size: 4
  xetra_en_light_response:
    seq:
      - id: pad_2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  xetra_en_light_status_broadcast:
    seq:
      - id: pad_2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad_3
        size: 3
  xetra_en_light_update_negotiation_request:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad_2
        size: 2
      - id: request_header_comp
        type: request_header_comp
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: auto_exec_limit_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: auto_exec_reference_price_offset
        type: s4
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: settl_date
        type: u4
      - id: auto_exec_exposure_duration
        type: u4
      - id: auto_exec_min_no_of_quotes
        type: u4
      - id: num_xetra_en_light_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: respondent_type
        type: u1
        enum: respondent_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: auto_exec_type
        type: u1
        enum: auto_exec_type
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_origination
        type: u1
        enum: order_origination
      - id: quote_condition
        type: u1
        enum: quote_condition
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad_3
        size: 3
      - id: xetra_en_light_target_parties_comp
        type: xetra_en_light_target_parties_comp
        repeat: expr
        repeat-expr: num_xetra_en_light_target_parties_comp

enums:
  template_id:
    10603:
      id: 'approve_tes_trade_request'
      doc: 'Approve Tes Trade Request TemplateId'
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
    10311:
      id: 'inquire_pre_trade_risk_limits_request'
      doc: 'Inquire Pre Trade Risk Limits Request TemplateId'
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
    19000:
      id: 'logon_request_encrypted'
      doc: 'Logon Request Encrypted TemplateId'
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
    10140:
      id: 'modify_order_request'
      doc: 'Modify Order Request TemplateId'
    10107:
      id: 'modify_order_response'
      doc: 'Modify Order Response TemplateId'
    10141:
      id: 'modify_order_short_request'
      doc: 'Modify Order Short Request TemplateId'
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
    10138:
      id: 'new_order_request'
      doc: 'New Order Request TemplateId'
    10101:
      id: 'new_order_response'
      doc: 'New Order Response TemplateId'
    10139:
      id: 'new_order_short_request'
      doc: 'New Order Short Request TemplateId'
    10100:
      id: 'new_order_single_request'
      doc: 'New Order Single Request TemplateId'
    10125:
      id: 'new_order_single_short_request'
      doc: 'New Order Single Short Request TemplateId'
    10031:
      id: 'news_broadcast'
      doc: 'News Broadcast TemplateId'
    10617:
      id: 'otc_response'
      doc: 'Otc Response TemplateId'
    10618:
      id: 'otc_upload_broadcast'
      doc: 'Otc Upload Broadcast TemplateId'
    10616:
      id: 'otc_upload_request'
      doc: 'Otc Upload Request TemplateId'
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
    10320:
      id: 'ping_request'
      doc: 'Ping Request TemplateId'
    10321:
      id: 'ping_response'
      doc: 'Ping Response TemplateId'
    10313:
      id: 'pre_trade_risk_limit_response'
      doc: 'Pre Trade Risk Limit Response TemplateId'
    10312:
      id: 'pre_trade_risk_limits_definition_request'
      doc: 'Pre Trade Risk Limits Definition Request TemplateId'
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
    10420:
      id: 'rfq_reject_notification'
      doc: 'Rfq Reject Notification TemplateId'
    10401:
      id: 'rfq_request'
      doc: 'Rfq Request TemplateId'
    10402:
      id: 'rfq_response'
      doc: 'Rfq Response TemplateId'
    10419:
      id: 'rfq_specialist_broadcast'
      doc: 'Rfq Specialist Broadcast TemplateId'
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
    10044:
      id: 'service_availability_market_broadcast'
      doc: 'Service Availability Market Broadcast TemplateId'
    10418:
      id: 'single_quote_request'
      doc: 'Single Quote Request TemplateId'
    10137:
      id: 'specialist_delete_all_order_broadcast'
      doc: 'Specialist Delete All Order Broadcast TemplateId'
    10319:
      id: 'specialist_instrument_event_notification'
      doc: 'Specialist Instrument Event Notification TemplateId'
    10136:
      id: 'specialist_order_book_notification'
      doc: 'Specialist Order Book Notification TemplateId'
    10421:
      id: 'specialist_rfq_reject_request'
      doc: 'Specialist Rfq Reject Request TemplateId'
    10424:
      id: 'specialist_rfq_reply_notification'
      doc: 'Specialist Rfq Reply Notification TemplateId'
    10422:
      id: 'specialist_rfq_reply_request'
      doc: 'Specialist Rfq Reply Request TemplateId'
    10423:
      id: 'specialist_rfq_reply_response'
      doc: 'Specialist Rfq Reply Response TemplateId'
    10317:
      id: 'specialist_security_state_change_request'
      doc: 'Specialist Security State Change Request TemplateId'
    10318:
      id: 'specialist_security_state_change_response'
      doc: 'Specialist Security State Change Response TemplateId'
    10045:
      id: 'status_broadcast'
      doc: 'Status Broadcast TemplateId'
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
    19018:
      id: 'user_login_request_encrypted'
      doc: 'User Login Request Encrypted TemplateId'
    10019:
      id: 'user_login_response'
      doc: 'User Login Response TemplateId'
    10029:
      id: 'user_logout_request'
      doc: 'User Logout Request TemplateId'
    10024:
      id: 'user_logout_response'
      doc: 'User Logout Response TemplateId'
    10818:
      id: 'xetra_en_light_approve_deal_notification'
      doc: 'Xetra En Light Approve Deal Notification TemplateId'
    10819:
      id: 'xetra_en_light_approve_deal_request'
      doc: 'Xetra En Light Approve Deal Request TemplateId'
    10808:
      id: 'xetra_en_light_create_deal_notification'
      doc: 'Xetra En Light Create Deal Notification TemplateId'
    10805:
      id: 'xetra_en_light_deal_response'
      doc: 'Xetra En Light Deal Response TemplateId'
    10825:
      id: 'xetra_en_light_deal_status_notification'
      doc: 'Xetra En Light Deal Status Notification TemplateId'
    10824:
      id: 'xetra_en_light_delete_all_quote_notification'
      doc: 'Xetra En Light Delete All Quote Notification TemplateId'
    10821:
      id: 'xetra_en_light_delete_all_quote_request'
      doc: 'Xetra En Light Delete All Quote Request TemplateId'
    10802:
      id: 'xetra_en_light_enter_quote_request'
      doc: 'Xetra En Light Enter Quote Request TemplateId'
    10804:
      id: 'xetra_en_light_hit_quote_request'
      doc: 'Xetra En Light Hit Quote Request TemplateId'
    10813:
      id: 'xetra_en_light_negotiation_notification'
      doc: 'Xetra En Light Negotiation Notification TemplateId'
    10812:
      id: 'xetra_en_light_negotiation_requester_notification'
      doc: 'Xetra En Light Negotiation Requester Notification TemplateId'
    10815:
      id: 'xetra_en_light_negotiation_status_notification'
      doc: 'Xetra En Light Negotiation Status Notification TemplateId'
    10811:
      id: 'xetra_en_light_open_negotiation_notification'
      doc: 'Xetra En Light Open Negotiation Notification TemplateId'
    10800:
      id: 'xetra_en_light_open_negotiation_request'
      doc: 'Xetra En Light Open Negotiation Request TemplateId'
    10810:
      id: 'xetra_en_light_open_negotiation_requester_notification'
      doc: 'Xetra En Light Open Negotiation Requester Notification TemplateId'
    10807:
      id: 'xetra_en_light_quote_notification'
      doc: 'Xetra En Light Quote Notification TemplateId'
    10816:
      id: 'xetra_en_light_quote_requester_notification'
      doc: 'Xetra En Light Quote Requester Notification TemplateId'
    10803:
      id: 'xetra_en_light_quote_response'
      doc: 'Xetra En Light Quote Response TemplateId'
    10823:
      id: 'xetra_en_light_quote_snapshot_notification'
      doc: 'Xetra En Light Quote Snapshot Notification TemplateId'
    10820:
      id: 'xetra_en_light_quote_snapshot_request'
      doc: 'Xetra En Light Quote Snapshot Request TemplateId'
    10817:
      id: 'xetra_en_light_quoting_status_request'
      doc: 'Xetra En Light Quoting Status Request TemplateId'
    10822:
      id: 'xetra_en_light_response'
      doc: 'Xetra En Light Response TemplateId'
    10814:
      id: 'xetra_en_light_status_broadcast'
      doc: 'Xetra En Light Status Broadcast TemplateId'
    10801:
      id: 'xetra_en_light_update_negotiation_request'
      doc: 'Xetra En Light Update Negotiation Request TemplateId'
  trd_type:
    54:
      id: 'otc'
      doc: 'OTC'
    1005:
      id: 'lis'
      doc: 'Large in scale'
    1006:
      id: 'enlight'
      doc: 'Eurex/Xetra Enlight triggered trade'
  trading_capacity:
    1:
      id: 'customer'
      doc: 'Customer (Agency)'
    3:
      id: 'brokerdealer'
      doc: 'Issuer/Liquidity Provider'
    5:
      id: 'principal'
      doc: 'Principal (Proprietary)'
    6:
      id: 'market_maker'
      doc: 'Market Maker'
    9:
      id: 'riskless_principal'
      doc: 'Riskless Principal'
    10:
      id: 'retail_customer'
      doc: 'Retail Customer (Agency)'
    11:
      id: 'retail_market_maker'
      doc: 'Retail Market Maker'
  trade_report_type:
    0:
      id: 'submit'
      doc: 'Submit'
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
  order_origination:
    5:
      id: 'directaccessorsponsoredaccesscustomer'
      doc: 'Order received from a direct access customer'
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
    9:
      id: 'srqs_maintenance'
      doc: 'SRQS Maintenance'
    10:
      id: 'service_availability_market'
      doc: 'Service Availability Market'
    11:
      id: 'specialist_data'
      doc: 'Specialist Data'
  session_status:
    0:
      id: 'active'
      doc: 'Session active'
    4:
      id: 'logout'
      doc: 'Session logout complete'
  last_fragment:
    0:
      id: 'not_last_message'
      doc: 'Not Last Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
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
    9:
      id: 'srqs_maintenance'
      doc: 'SRQS Maintenance'
    10:
      id: 'service_availability_market'
      doc: 'Service Availability Market'
    11:
      id: 'specialist_data'
      doc: 'Specialist Data'
  appl_resend_flag:
    0:
      id: 'false'
      doc: 'False'
    1:
      id: 'true'
      doc: 'True'
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
    100:
      id: 'internal_connection_loss'
      doc: 'Internal connection loss'
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
    117:
      id: 'memberdisable'
      doc: 'Member has been disabled'
    118:
      id: 'instrument_knock_out_reverted'
      doc: 'Instrument Knock Out has been reverted'
    119:
      id: 'automatic_quote_deletion'
      doc: 'Automatic Quote Deletion'
    120:
      id: 'outside_quoting_period'
      doc: 'Quote deletion outside quoting period'
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
    114:
      id: 'changedto_ioc'
      doc: 'Order has been changed to IOC'
    119:
      id: 'changeof_specialist'
      doc: 'Change of Specialist'
    122:
      id: 'instrument_state_change'
      doc: 'Instrument State Change'
    138:
      id: 'pending_new'
      doc: 'Pending New'
    141:
      id: 'pending_new_applied'
      doc: 'Pending new order processed (end of FREEZE state)'
    139:
      id: 'pending_replace'
      doc: 'Pending modify'
    142:
      id: 'pending_replace_applied'
      doc: 'Pending modified order processed (end of FREEZE state)'
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
      doc: 'Pending order cancellation processed (end of FREEZE state)'
    205:
      id: 'midpoint_order_sweep'
      doc: 'Midpoint Sweep order changed to regular order'
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
    261:
      id: 'panic_cancel'
      doc: 'Panic Cancel'
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
    316:
      id: 'qrs_expiry'
      doc: 'QRS Order Expiry'
    320:
      id: 'rlp_order_quote_cleanup'
      doc: 'RLP Order/Quote Cleanup'
  ord_status:
    0x30:
      id: 'new'
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
    0x41:
      id: 'pending_new'
      doc: 'Pending New'
    0x45:
      id: 'pending_replace'
      doc: 'Pending Replace'
  exec_type:
    0x30:
      id: 'new'
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
    0x41:
      id: 'pending_new'
      doc: 'Pending New'
    0x45:
      id: 'pending_replace'
      doc: 'Pending Replace'
  order_event_type:
    100:
      id: 'pendingrequestsdiscarded'
      doc: 'Final order status after locked stock - Pending requests discarded'
  transaction_delay_indicator:
    0:
      id: 'notdelayed'
      doc: 'Transaction not delayed'
    1:
      id: 'delayed'
      doc: 'Transaction delayed'
  trade_publish_indicator:
    0:
      id: 'do_not_publish_trade'
      doc: 'Do not publish trade'
    1:
      id: 'publish_trade'
      doc: 'Publish trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred publication to market'
    3:
      id: 'published'
      doc: 'Published to market'
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
  mid_point_type:
    1:
      id: 'mid_point'
      doc: 'Midpoint order'
    2:
      id: 'mid_point_sweep'
      doc: 'Midpoint sweep order'
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
    105:
      id: 'special_auction'
      doc: 'Special auction'
  appl_seq_indicator:
    0: 'no_recovery_required'
    1: 'recovery_required'
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
  session_sub_mode:
    0:
      id: 'regulartradingsession'
      doc: 'Regular Trading Session'
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
    104:
      id: 'instrument_assignment_added'
      doc: 'Instrument assignment added'
    105:
      id: 'instrument_assignment_removed'
      doc: 'Instrument assignment removed'
    106:
      id: 'closed'
      doc: 'Instrument state Closed'
    107:
      id: 'restricted'
      doc: 'Instrument state Restricted'
    108:
      id: 'book'
      doc: 'Instrument state Book'
    109:
      id: 'continuous'
      doc: 'Instrument state Continuous'
    110:
      id: 'auction'
      doc: 'Instrument state Auction'
    111:
      id: 'freeze'
      doc: 'Instrument state Freeze'
    112:
      id: 'cancel_freeze'
      doc: 'Cancel instrument state Freeze'
    113:
      id: 'pre_call'
      doc: 'Instrument state Pre Call'
    114:
      id: 'endof_restatement'
      doc: 'End of Restatement'
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
      id: 'yes'
      doc: 'Yes'
    0x4e:
      id: 'no'
      doc: 'No'
  market_id:
    3:
      id: 'xetr'
      doc: 'XETR'
    4:
      id: 'xvie'
      doc: 'XVIE'
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
    13:
      id: 'xfra'
      doc: 'XFRA'
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
      doc: 'Indicative (for Continuous Auction Issuer trading model and Eurex/Xetra EnLight only)'
    1:
      id: 'tradeable'
      doc: 'Tradeable'
    101:
      id: 'tradeable_matching'
      doc: 'Tradeable(Matching) - for Continuous Auction trading models only'
    102:
      id: 'tradeable_pwt'
      doc: 'Tradeable(Price without turnover) - for Continuous Auction trading models only'
    103:
      id: 'special_auction'
      doc: 'Special Auction'
    104:
      id: 'pw_twithin_special_auction'
      doc: 'PWT within Special Auction'
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
    134:
      id: 'invalid_quote_type'
      doc: 'Invalid quote type'
    135:
      id: 'pwt_quotenotallowedincurrentstate'
      doc: 'PWT Quote not allowed in current state'
    136:
      id: 'standard_quotenotallowedincurrentstate'
      doc: 'Standard Quote not allowed in current state'
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
    147:
      id: 'liquidityproviderprotectionbidsidecancelled'
      doc: 'Liquidity provider protection bid side cancelled'
    148:
      id: 'liquidityproviderprotectionasksidecancelled'
      doc: 'Liquidity provider protection ask side cancelled'
    149:
      id: 'quantity_limit_exceeded_instrument'
      doc: 'Quantity exceeds instrument specific limit'
    150:
      id: 'value_limit_exceeded_instrument'
      doc: 'Value exceeds instrument specific limit'
    151:
      id: 'issuer_stopped'
      doc: 'Issuer is stopped'
    152:
      id: 'partial_exec_of_qrs_order'
      doc: 'Rejection of matching quote as QRS order would be partially executed'
    153:
      id: 'matching_quote_not_allowed_in_current_state'
      doc: 'Matching quote is not allowed in current instrument state'
    155:
      id: 'outside_quoting_period'
      doc: 'Quote entry outside quoting period not allowed'
    156:
      id: 'match_price_not_on_price_step'
      doc: 'Match price resulting from entry of the matching quote is not a valid price step'
    161:
      id: 'quantity_limit_exceeds_tsl'
      doc: 'Quantity exceeds transaction size limit'
    162:
      id: 'invalid_trading_session_sub_i_dfor_instrument'
      doc: 'Invalid TradingSessionSubID for instrument'
    163:
      id: 'too_many_ordersand_quotesin_order_book'
      doc: 'Too many orders and quotes in order book'
    164:
      id: 'inactive_cover'
      doc: 'Instrument is an inactive cover'
    165:
      id: 'indicative_quotenotallowedincurrentstate'
      doc: 'Indicative quote is not allowed in current state.'
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
  bbo_setting:
    1:
      id: 'yes'
      doc: 'Yes'
  order_event_reason:
    100:
      id: 'smp'
      doc: 'SMP event'
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
  trade_at_close_opt_in:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  trd_rpt_status:
    0:
      id: 'accepted'
      doc: 'Accepted'
    1:
      id: 'rejected'
      doc: 'Rejected'
    2:
      id: 'cancelled'
      doc: 'Cancelled'
    4:
      id: 'pending_new'
      doc: 'Pending new'
    7:
      id: 'terminated'
      doc: 'Terminated'
    9:
      id: 'deemed_verified'
      doc: 'Deemed verified'
  transaction_cost_code:
    0:
      id: 'noadditionalcost'
      doc: 'No additional cost'
    1:
      id: 'franco_courtage'
      doc: 'FC (Franco Courtage)'
    2:
      id: 'franco_rechnung'
      doc: 'FR (Franco Rechnung)'
    3:
      id: 'abweichendes_courtage'
      doc: 'AC (Abweichendes Courtage)'
    4:
      id: 'spesen'
      doc: 'SP (Spesen)'
    5:
      id: 'provision'
      doc: 'PR (Provision)'
  trade_platform:
    0:
      id: 'off_book'
      doc: 'Off-Book'
    1:
      id: 'on_book'
      doc: 'On-Book'
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
    11:
      id: 'automatchresting'
      doc: 'Auto match resting order'
    12:
      id: 'automatchatmidpoint'
      doc: 'Auto match at midpoint'
    14:
      id: 'continuous_auction'
      doc: 'Continuous Aution'
    15:
      id: 'retail'
      doc: 'Retail'
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
    100:
      id: 'added_liquidity_midpoint'
      doc: 'Added Liquidity Midpoint'
    101:
      id: 'removed_liquidity_midpoint'
      doc: 'Removed Liquidity Midpoint'
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
      id: 'delete'
      doc: 'Delete (Release)'
  risk_limit_type:
    4:
      id: 'longlimit'
      doc: 'Long limit'
    5:
      id: 'shortlimit'
      doc: 'Short limit'
  risk_limit_requesting_party_role:
    4:
      id: 'clearingfirm'
      doc: 'requested by Clearing firm'
    22:
      id: 'exchange'
      doc: 'requested by Exchange'
    59:
      id: 'executingunit'
      doc: 'requested by Executing firm'
  risk_limit_violation_indicator:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  mass_action_type:
    1:
      id: 'suspendquotes'
      doc: 'Suspend quotes'
    2:
      id: 'releasequotes'
      doc: 'Release quotes from suspension'
    3:
      id: 'suspenddeletequotes'
      doc: 'Suspend and delete Quotes'
  quote_event_type:
    2:
      id: 'modifiedquoteside'
      doc: 'Modified side'
    3: 'removedquoteside'
    4: 'partiallyfilled'
    5:
      id: 'filled'
      doc: 'Filled'
    6:
      id: 'removed_quantity'
      doc: 'Quantity removed'
  quote_event_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
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
    18:
      id: 'plp'
      doc: 'Quote deleted due to passive liquidity protection'
    19:
      id: 'pricenot_topof_book'
      doc: 'Price was not top of quote book.'
    20:
      id: 'random_selection'
      doc: 'Requester choose selection by the random algorithm.'
    21:
      id: 'manual_selection'
      doc: 'Requester manually selected the quote'
  quote_request_reject_reason:
    2:
      id: 'exchangeclosed'
      doc: 'Exchange (Security) Closed'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'requestedsizetoosmall'
      doc: 'Requested size too small'
    101:
      id: 'requestedsizetoobig'
      doc: 'Requested size too big'
    102:
      id: 'novalidquotefromissuer'
      doc: 'No valid quote from issuer'
    103:
      id: 'soldout'
      doc: 'Sold out'
    104:
      id: 'tradingrestriction'
      doc: 'Trading restriction'
    105:
      id: 'pendingrequesttimedout'
      doc: 'RequestForQuote request timed out'
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
    6:
      id: 'specialist'
      doc: 'Specialist(private)'
  rfq_requester_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
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
    216:
      id: 'gateway_is_standby'
      doc: 'Gateway is standby'
    217:
      id: 'session_login_limit_reached'
      doc: 'Session login limit (per time interval) reached'
    223:
      id: 'user_entitlement_data_timeout'
      doc: 'User Entitlement Data time out'
    224:
      id: 'ps_gateway_session_limit_reached'
      doc: 'Session limit reached (per PS Gateway and Business Unit)'
    225:
      id: 'user_login_limit_reached'
      doc: 'User login tries limit (per time interval) reached'
    226:
      id: 'outstanding_logins_bu_limit_reached'
      doc: 'Limit of outstanding session/user logins reached (per Business Unit)'
    227:
      id: 'outstanding_logins_session_limit_reached'
      doc: 'Limit of outstanding session/user logins reached (per Session)'
    228:
      id: 'password_timestamp_not_in_grace_period'
      doc: 'Password timestamp not in grace period'
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
    10012:
      id: 'ordernotacceptedin_volatility_freeze'
      doc: 'Order not accepted in Volatility Freeze'
    10016:
      id: 'pretrade_risk_limit_exceeded'
      doc: 'Pretrade Risk Limit exceeded'
    10023:
      id: 'price_not_reasonable_extended'
      doc: 'Price exceeds extended price reasonability'
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
  selective_request_for_quote_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  selective_request_for_quote_rtm_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  news_rtm_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
  risk_control_rtm_service_status:
    0:
      id: 'unavailable'
      doc: 'Unavailable'
    1:
      id: 'available'
      doc: 'Available'
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
    13:
      id: 'xfra'
      doc: 'XFRA'
  transfer_reason:
    1:
      id: 'owner'
      doc: 'Owner'
    2:
      id: 'clearer'
      doc: 'Clearer'
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
    5:
      id: 'akt'
      doc: 'Non-collective safe custody securities to be settled via T2S'
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
    6:
      id: 'perpetual'
      doc: 'Perpetual'
  refinancing_eligibility_indicator:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  clearing_instruction:
    2:
      id: 'bilateralnettingonly'
      doc: 'Bilateral netting only'
    13:
      id: 'selfclearing'
      doc: 'Self clearing'
  root_party_id_investment_decision_maker_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
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
    5:
      id: 'tradeatclose'
      doc: 'Trade-at-Close'
  side_liquidity_ind:
    1:
      id: 'added_liquidity'
      doc: 'Added liquidity (passive)'
    2:
      id: 'removed_liquidity'
      doc: 'Removed liquidity (aggressive, includes triggered orders)'
    4:
      id: 'auction'
      doc: 'Auction'
  order_category:
    0x31:
      id: 'order'
      doc: 'Order'
    0x32:
      id: 'quote'
      doc: 'Quote'
  requesting_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  target_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  alloc_method:
    1:
      id: 'automatic_random'
      doc: 'Automatic (Random)'
    3:
      id: 'manual'
      doc: 'Manual'
  auto_exec_type:
    1:
      id: 'mid_point_bbo'
      doc: 'Mid point of best bid and offer prices'
    2:
      id: 'best_bid'
      doc: 'Best bid price'
    3:
      id: 'best_ask'
      doc: 'Best ask price'
    4:
      id: 'limit_price'
      doc: 'Limit price'
  md_book_type:
    1:
      id: 'top_of_book'
      doc: 'Top of book'
    2:
      id: 'price_depth'
      doc: 'Price depth (aggregated)'
  md_sub_book_type:
    2:
      id: 'volume_weighted_average'
      doc: 'Volume Weighted Average'
  quoting_frequency:
    0:
      id: 'hf'
      doc: 'HF Quotes'
    1:
      id: 'lf'
      doc: 'LF Quotes'
  quote_condition:
    0x41:
      id: 'active'
      doc: 'Active'
    0x42:
      id: 'closed'
      doc: 'Closed'
    0x7a:
      id: 'suspended'
      doc: 'Suspended'
    0x38:
      id: 'expired'
      doc: 'Expired'
    0x45:
      id: 'locked'
      doc: 'Locked'
  number_of_resp_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  respondent_type:
    2:
      id: 'specifiedmarketparticipants'
      doc: 'Respondents specified by requestor'
    100:
      id: 'specifiedand_smart_rf_qselectedparticipants'
      doc: 'Respondents specified by requestor and SmartRfQ processing'
    101:
      id: 'smart_rf_qselectedparticipants'
      doc: 'Respondents specified by SmartRfQ processing'
  side_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  bid_px_is_locked:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  offer_px_is_locked:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  side_is_locked:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  quoting_status:
    1:
      id: 'open_active'
      doc: 'Open/Active'
    2:
      id: 'open_idle'
      doc: 'Open/Working'
    3:
      id: 'closed_inactive'
      doc: 'Closed/Inactive'
    4:
      id: 'open_not_responded'
      doc: 'Open/Not Responded'
    5:
      id: 'pre_fundingnotsufficient'
      doc: 'Pre-funding amount not sufficient.'
  quote_cancel_reason:
    5:
      id: 'expired'
      doc: 'Expired'

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: Eurex Exchange
#   Version: 13.0
#   Date: 10/10/2024
#   Specification: T7_R.13.0_Enhanced_Trading_Interface_-_Cash_Message_Reference_Version 3.pdf
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
# The Binary Data Compiler technologies used to produce this file
# are the subject of patents owned by Scaled Sources LLC.  Those patent
# rights are retained and are not transferred by this contribution:
#   https://patents.google.com/patent/US20240129382A1/en
#   https://patents.google.com/patent/US20240419416A1/en
#
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
# ---------------------------------------------------------------------
