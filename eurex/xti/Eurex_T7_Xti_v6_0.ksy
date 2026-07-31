# ---------------------------------------------------------------------
# Omi Kaitai Struct Definition: Eurex T7 Xti v6.0
#
# Please see end of file for rules and regulations
# ---------------------------------------------------------------------

meta:
  id: eurex_t7_xti_v6_0
  title: Eurex T7 Xti Fbe v6.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Cash Enhanced Trading Interface Fbe v6.0'
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
            'template_id::enter_best_quote_request': enter_best_quote_request
            'template_id::extended_deletion_report': extended_deletion_report
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::forced_user_logout_notification': forced_user_logout_notification
            'template_id::gateway_request': gateway_request
            'template_id::gateway_response': gateway_response
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::inquire_enrichment_rule_id_list_request': inquire_enrichment_rule_id_list_request
            'template_id::inquire_enrichment_rule_id_list_response': inquire_enrichment_rule_id_list_response
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::inquire_session_list_response': inquire_session_list_response
            'template_id::inquire_user_request': inquire_user_request
            'template_id::inquire_user_response': inquire_user_response
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
      - id: template_id
        type: u2
        enum: template_id
  best_quote_execution_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_msg_id
        type: u8
      - id: security_id
        type: s8
      - id: quote_event_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: quote_event_match_id
        type: u4
      - id: quote_event_exec_id
        type: s4
      - id: quote_event_qty
        type: s4
      - id: reserved_size
        type: u4
      - id: quote_event_type
        type: u1
        enum: quote_event_type
      - id: quote_event_side
        type: u1
        enum: quote_event_side
      - id: pad2v2
        size: 2
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
      - id: pad7
        size: 7
  best_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: quote_id
        type: u8
      - id: quote_response_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: market_segment_id
        type: s4
      - id: bid_cxl_size
        type: s4
      - id: offer_cxl_size
        type: s4
      - id: pad4
        size: 4
  nr_response_header_me_comp:
    seq:
      - id: request_time
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: request_out
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
      - id: pad3
        size: 3
  broadcast_error_notification:
    seq:
      - id: pad2
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
        type: u8
        doc: 'Nanoseconds since Unix epoch'
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
        type: s8
      - id: market_segment_id
        type: s4
      - id: order_qty
        type: s4
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4
      - id: sender_sub_id
        type: u4
  cross_request_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  delete_all_order_broadcast:
    seq:
      - id: pad2
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
        type: u8
      - id: not_aff_orig_cl_ord_id
        type: u8
  affected_ord_grp_comp:
    seq:
      - id: affected_order_id
        type: u8
      - id: affected_orig_cl_ord_id
        type: u8
  delete_all_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  delete_all_order_quote_event_broadcast:
    seq:
      - id: pad2
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
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad1
        size: 1
  delete_all_order_response:
    seq:
      - id: pad2
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
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: request_out
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
      - id: pad2
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
      - id: pad1
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
      - id: pad2
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
      - id: pad6
        size: 6
  delete_all_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_securities_grp_comp
        type: u2
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
      - id: order_id_sfx
        type: u4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: market_segment_id
        type: s4
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
      - id: side
        type: u1
        enum: side
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
  delete_order_nr_response:
    seq:
      - id: pad2
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
      - id: order_id_sfx
        type: u4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
  delete_order_response:
    seq:
      - id: pad2
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
      - id: order_id_sfx
        type: u4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
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
      - id: pad2v2
        size: 2
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
        type: u8
      - id: security_id
        type: s8
      - id: bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_bid_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: bid_size
        type: s4
      - id: offer_size
        type: s4
      - id: reserved_bid_size
        type: u4
      - id: reserved_offer_size
        type: u4
      - id: market_segment_id
        type: s4
      - id: enrichment_rule_id
        type: u2
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad6
        size: 6
  extended_deletion_report:
    seq:
      - id: pad2
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
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: volume_discovery_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: order_qty
        type: s4
      - id: display_qty
        type: s4
      - id: display_low_qty
        type: s4
      - id: display_high_qty
        type: s4
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
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
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
        type: u1
        enum: triggered
      - id: pad3
        size: 3
  forced_logout_notification:
    seq:
      - id: pad2
        size: 2
      - id: notif_header_comp
        type: notif_header_comp
      - id: len_var_text
        type: u2
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
        type: u1
        enum: user_status
      - id: pad3
        size: 3
      - id: username
        type: u4
      - id: len_var_text
        type: u2
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
        type: u4
      - id: partition_id
        type: u2
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
  gateway_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: gateway_id
        type: u4
      - id: gateway_sub_id
        type: u4
      - id: secondary_gateway_id
        type: u4
      - id: secondary_gateway_sub_id
        type: u4
      - id: gateway_status
        type: u1
        enum: gateway_status
      - id: secondary_gateway_status
        type: u1
        enum: secondary_gateway_status
      - id: session_mode
        type: u1
        enum: session_mode
      - id: trad_ses_mode
        type: u1
        enum: trad_ses_mode
      - id: pad4
        size: 4
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
  inquire_enrichment_rule_id_list_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
      - id: num_enrichment_rules_grp_comp
        type: u2
      - id: pad6
        size: 6
      - id: enrichment_rules_grp_comp
        type: enrichment_rules_grp_comp
        repeat: expr
        repeat-expr: num_enrichment_rules_grp_comp
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
      - id: pad6
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
  inquire_user_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: last_entity_processed
        size: 16
      - id: num_party_details_grp_comp
        type: u2
      - id: pad6
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
      - id: pad1
        size: 1
  legal_notification_broadcast:
    seq:
      - id: pad2
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
      - id: pad3
        size: 3
  logon_response:
    seq:
      - id: pad2
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
      - id: pad6
        size: 6
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
      - id: offer_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: s4
      - id: offer_size
        type: s4
  mass_quote_response:
    seq:
      - id: pad2
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
      - id: pad3
        size: 3
      - id: quote_entry_ack_grp_comp
        type: quote_entry_ack_grp_comp
        repeat: expr
        repeat-expr: num_quote_entry_ack_grp_comp
  quote_entry_ack_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: bid_cxl_size
        type: s4
      - id: offer_cxl_size
        type: s4
      - id: quote_entry_reject_reason
        type: u4
        enum: quote_entry_reject_reason
      - id: quote_entry_status
        type: u1
        enum: quote_entry_status
      - id: pad3
        size: 3
  modify_order_nr_response:
    seq:
      - id: pad2
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
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: display_qty
        type: s4
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
      - id: pad6
        size: 6
  modify_order_response:
    seq:
      - id: pad2
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
      - id: trd_reg_ts_time_priority
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: display_qty
        type: s4
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
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: volume_discovery_price
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
      - id: order_qty
        type: s4
      - id: display_qty
        type: s4
      - id: display_low_qty
        type: s4
      - id: display_high_qty
        type: s4
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
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: ownership_indicator
        type: u1
        enum: ownership_indicator
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
        type: u8
      - id: orig_cl_ord_id
        type: u8
      - id: security_id
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: order_qty
        type: s4
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
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad3
        size: 3
  new_order_nr_response:
    seq:
      - id: pad2
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
      - id: pad6
        size: 6
  new_order_response:
    seq:
      - id: pad2
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
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: volume_discovery_price
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
      - id: order_qty
        type: s4
      - id: display_qty
        type: s4
      - id: display_low_qty
        type: s4
      - id: display_high_qty
        type: s4
      - id: expire_date
        type: u4
      - id: market_segment_id
        type: s4
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
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
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
        type: s8
      - id: price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: cl_ord_id
        type: u8
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: order_qty
        type: s4
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
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad3
        size: 3
  news_broadcast:
    seq:
      - id: pad2
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
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: display_qty
        type: s4
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
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: num_fills_grp_comp
        type: u1
      - id: pad3
        size: 3
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
  fills_grp_comp:
    seq:
      - id: fill_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: fill_qty
        type: s4
      - id: fill_match_id
        type: u4
      - id: fill_exec_id
        type: s4
      - id: fill_liquidity_ind
        type: u1
        enum: fill_liquidity_ind
      - id: pad3
        size: 3
  order_exec_report_broadcast:
    seq:
      - id: pad2
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
      - id: stop_px
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: volume_discovery_price
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_abs
        type: u8
        doc: 'Implied decimal with scale 1e-8'
      - id: peg_offset_value_pct
        type: u8
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: order_qty
        type: s4
      - id: display_qty
        type: s4
      - id: display_low_qty
        type: s4
      - id: display_high_qty
        type: s4
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
      - id: ex_destination_type
        type: u1
        enum: ex_destination_type
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
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: pad7
        size: 7
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
      - id: market_segment_id
        type: s4
      - id: order_id_sfx
        type: u4
      - id: leaves_qty
        type: s4
      - id: cum_qty
        type: s4
      - id: cxl_qty
        type: s4
      - id: display_qty
        type: s4
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
      - id: num_fills_grp_comp
        type: u1
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
      - id: pad2
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
      - id: pad6
        size: 6
  quote_activation_notification:
    seq:
      - id: pad2
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
      - id: pad5
        size: 5
  quote_activation_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_securities_grp_comp
        type: u2
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
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_quote_event_grp_comp
        type: u1
      - id: pad3
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
      - id: quote_msg_id
        type: u8
      - id: quote_event_match_id
        type: u4
      - id: quote_event_exec_id
        type: s4
      - id: quote_event_qty
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
      - id: quote_event_reason
        type: u1
        enum: quote_event_reason
  rfq_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: security_id
        type: s8
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: order_qty
        type: s4
      - id: side
        type: u1
        enum: side
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
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
        type: s8
      - id: market_segment_id
        type: s4
      - id: order_qty
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
      - id: pad5
        size: 5
  rfq_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: u8
        doc: 'Nanoseconds since Unix epoch'
  reject:
    seq:
      - id: pad2
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
      - id: pad1
        size: 1
  retransmit_me_message_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_total_message_count
        type: u2
      - id: appl_end_msg_id
        size: 16
      - id: ref_appl_last_msg_id
        size: 16
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
        type: u8
      - id: appl_end_seq_num
        type: u8
      - id: partition_id
        type: u2
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: pad5
        size: 5
  retransmit_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_end_seq_num
        type: u8
      - id: ref_appl_last_seq_num
        type: u8
      - id: appl_total_message_count
        type: u2
      - id: pad6
        size: 6
  service_availability_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: matching_engine_trade_date
        type: u4
      - id: trade_manager_trade_date
        type: u4
      - id: appl_seq_trade_date
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
      - id: pad7
        size: 7
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
        type: u4
      - id: ref_appl_id
        type: u1
        enum: ref_appl_id
      - id: pad3
        size: 3
  subscribe_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: appl_sub_id
        type: u4
      - id: pad4
        size: 4
  tm_trading_session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad7
        size: 7
  throttle_update_notification:
    seq:
      - id: pad2
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
      - id: pad2
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
      - id: order_id_sfx
        type: u4
      - id: cum_qty
        type: s4
      - id: leaves_qty
        type: s4
      - id: market_segment_id
        type: s4
      - id: last_qty
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
      - id: pad1
        size: 1
  trading_session_status_broadcast:
    seq:
      - id: pad2
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
      - id: pad7
        size: 7
  trailing_stop_update_notification:
    seq:
      - id: pad2
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
      - id: order_id_sfx
        type: u4
      - id: market_segment_id
        type: s4
      - id: order_qty
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
      - id: pad3
        size: 3
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
        type: u4
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
        type: u4
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
        type: u4
      - id: pad4
        size: 4
  user_logout_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp

enums:
  template_id:
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
    10412:
      id: 'enter_best_quote_request'
      doc: 'Enter Best Quote Request TemplateId'
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
    10021:
      id: 'gateway_response'
      doc: 'Gateway Response TemplateId'
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
  appl_resend_flag:
    0:
      id: 'false'
      doc: 'False'
    1:
      id: 'true'
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
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
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
      doc: 'Product Assignment Change / Special Event'
    298:
      id: 'reference_price_change'
      doc: 'Reference Price Change'
    300:
      id: 'tick_rule_change'
      doc: 'Tick Rule Change'
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
  order_attribute_liquidity_provision:
    1:
      id: 'y'
      doc: 'Liquidity provision'
    0:
      id: 'n'
      doc: 'No liquidity provision'
  value_check_type_quantity:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
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
  gateway_status:
    0:
      id: 'standby'
      doc: 'Standby'
    1:
      id: 'active'
      doc: 'Active'
  secondary_gateway_status:
    0:
      id: 'standby'
      doc: 'Standby'
    1:
      id: 'active'
      doc: 'Active'
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
    5:
      id: 'xdub'
      doc: 'XDUB'
  price_validity_check_type:
    0:
      id: 'none'
      doc: 'None'
    2:
      id: 'mandatory'
      doc: 'Mandatory'
  value_check_type_value:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
  quote_size_type:
    1:
      id: 'total_size'
      doc: 'Total Size (Quote Modification)'
    2:
      id: 'open_size'
      doc: 'Open Size(Quote Entry)'
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
  fill_liquidity_ind:
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
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
      id: 'delete'
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
      doc: 'Exposure limit exceeded'
    102:
      id: 'service_temporarily_not_available'
      doc: 'Service temporarily not available'
    103:
      id: 'service_not_available'
      doc: 'Service not available'
    104:
      id: 'result_of_transaction_unknown'
      doc: 'Result of transaction unknown'
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
      doc: 'Order Management request for for a partition that is not reachable by the HF Gateway'
    219:
      id: 'partition_not_reachable_by_ps_gateway'
      doc: 'Order Management request for for a partition that is not reachable by the PS Gateway'
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
  trade_report_type:
    0:
      id: 'submit'
      doc: 'Trade'
    7:
      id: 'trade_break'
      doc: '(Locked-In) Trade Break'
  transfer_reason:
    1:
      id: 'owner'
      doc: 'Owner'
    2:
      id: 'clearer'
      doc: 'Clearer'
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

# ---------------------------------------------------------------------
# Kaitai struct definitions are an easily edited and modified cross-platform parsing solution.
# Feel free to modify. Enjoy.
# ---------------------------------------------------------------------
#
# Protocol:
#   Organization: Eurex Exchange
#   Version: 6.0
#   Date: 10/19/2017
#   Specification: T7-Enhanced-Trading-Interface-Manual.pdf
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
