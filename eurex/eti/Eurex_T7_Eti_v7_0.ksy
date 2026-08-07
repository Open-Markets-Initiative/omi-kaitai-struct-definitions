# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Eti Fbe v7.0
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Enhanced Trading Interface
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
  id: eurex_t7_eti_fbe_v7_0
  title: Eurex T7 Eti Fbe v7.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Trading Interface Fbe v7.0'
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
            'template_id::add_complex_instrument_request': add_complex_instrument_request
            'template_id::add_complex_instrument_response': add_complex_instrument_response
            'template_id::add_flexible_instrument_request': add_flexible_instrument_request
            'template_id::add_flexible_instrument_response': add_flexible_instrument_response
            'template_id::approve_tes_trade_request': approve_tes_trade_request
            'template_id::broadcast_error_notification': broadcast_error_notification
            'template_id::clip_deletion_notification': clip_deletion_notification
            'template_id::clip_execution_notification': clip_execution_notification
            'template_id::clip_response': clip_response
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
            'template_id::delete_clip_request': delete_clip_request
            'template_id::delete_order_broadcast': delete_order_broadcast
            'template_id::delete_order_complex_request': delete_order_complex_request
            'template_id::delete_order_nr_response': delete_order_nr_response
            'template_id::delete_order_response': delete_order_response
            'template_id::delete_order_single_request': delete_order_single_request
            'template_id::delete_tes_trade_request': delete_tes_trade_request
            'template_id::enter_clip_request': enter_clip_request
            'template_id::enter_tes_trade_request': enter_tes_trade_request
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::forced_user_logout_notification': forced_user_logout_notification
            'template_id::gateway_request': gateway_request
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::inquire_enrichment_rule_id_list_request': inquire_enrichment_rule_id_list_request
            'template_id::inquire_enrichment_rule_id_list_response': inquire_enrichment_rule_id_list_response
            'template_id::inquire_mm_parameter_request': inquire_mm_parameter_request
            'template_id::inquire_mm_parameter_response': inquire_mm_parameter_response
            'template_id::inquire_pre_trade_risk_limits_request': inquire_pre_trade_risk_limits_request
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::inquire_session_list_response': inquire_session_list_response
            'template_id::inquire_user_request': inquire_user_request
            'template_id::inquire_user_response': inquire_user_response
            'template_id::legal_notification_broadcast': legal_notification_broadcast
            'template_id::logon_request': logon_request
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::mm_parameter_definition_request': mm_parameter_definition_request
            'template_id::mm_parameter_definition_response': mm_parameter_definition_response
            'template_id::mass_quote_request': mass_quote_request
            'template_id::mass_quote_response': mass_quote_response
            'template_id::modify_order_complex_request': modify_order_complex_request
            'template_id::modify_order_complex_short_request': modify_order_complex_short_request
            'template_id::modify_order_nr_response': modify_order_nr_response
            'template_id::modify_order_response': modify_order_response
            'template_id::modify_order_single_request': modify_order_single_request
            'template_id::modify_order_single_short_request': modify_order_single_short_request
            'template_id::modify_tes_trade_request': modify_tes_trade_request
            'template_id::new_order_complex_request': new_order_complex_request
            'template_id::new_order_complex_short_request': new_order_complex_short_request
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
            'template_id::pre_trade_risk_limit_response': pre_trade_risk_limit_response
            'template_id::pre_trade_risk_limits_definition_request': pre_trade_risk_limits_definition_request
            'template_id::quote_activation_notification': quote_activation_notification
            'template_id::quote_activation_request': quote_activation_request
            'template_id::quote_activation_response': quote_activation_response
            'template_id::quote_execution_report': quote_execution_report
            'template_id::rfq_request': rfq_request
            'template_id::rfq_response': rfq_response
            'template_id::reject': reject
            'template_id::retransmit_me_message_request': retransmit_me_message_request
            'template_id::retransmit_me_message_response': retransmit_me_message_response
            'template_id::retransmit_request': retransmit_request
            'template_id::retransmit_response': retransmit_response
            'template_id::risk_notification_broadcast': risk_notification_broadcast
            'template_id::srqs_create_deal_notification': srqs_create_deal_notification
            'template_id::srqs_deal_notification': srqs_deal_notification
            'template_id::srqs_deal_response': srqs_deal_response
            'template_id::srqs_enter_quote_request': srqs_enter_quote_request
            'template_id::srqs_hit_quote_request': srqs_hit_quote_request
            'template_id::srqs_negotiation_notification': srqs_negotiation_notification
            'template_id::srqs_negotiation_requester_notification': srqs_negotiation_requester_notification
            'template_id::srqs_negotiation_status_notification': srqs_negotiation_status_notification
            'template_id::srqs_open_negotiation_notification': srqs_open_negotiation_notification
            'template_id::srqs_open_negotiation_request': srqs_open_negotiation_request
            'template_id::srqs_open_negotiation_requester_notification': srqs_open_negotiation_requester_notification
            'template_id::srqs_quote_notification': srqs_quote_notification
            'template_id::srqs_quote_response': srqs_quote_response
            'template_id::srqs_status_broadcast': srqs_status_broadcast
            'template_id::srqs_update_deal_status_request': srqs_update_deal_status_request
            'template_id::srqs_update_negotiation_request': srqs_update_negotiation_request
            'template_id::service_availability_broadcast': service_availability_broadcast
            'template_id::service_availability_market_broadcast': service_availability_market_broadcast
            'template_id::subscribe_request': subscribe_request
            'template_id::subscribe_response': subscribe_response
            'template_id::tes_approve_broadcast': tes_approve_broadcast
            'template_id::tes_broadcast': tes_broadcast
            'template_id::tes_delete_broadcast': tes_delete_broadcast
            'template_id::tes_execution_broadcast': tes_execution_broadcast
            'template_id::tes_response': tes_response
            'template_id::tes_trade_broadcast': tes_trade_broadcast
            'template_id::tes_trading_session_status_broadcast': tes_trading_session_status_broadcast
            'template_id::tes_upload_broadcast': tes_upload_broadcast
            'template_id::tm_trading_session_status_broadcast': tm_trading_session_status_broadcast
            'template_id::throttle_update_notification': throttle_update_notification
            'template_id::trade_broadcast': trade_broadcast
            'template_id::trading_session_status_broadcast': trading_session_status_broadcast
            'template_id::unsubscribe_request': unsubscribe_request
            'template_id::unsubscribe_response': unsubscribe_response
            'template_id::upload_tes_trade_request': upload_tes_trade_request
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
  add_complex_instrument_request:
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
      - id: market_segment_id
        type: s4
      - id: security_sub_type
        type: s4
      - id: product_complex
        type: u1
        enum: product_complex
      - id: num_instrmt_leg_grp_comp
        type: u1
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4
      - id: sender_sub_id
        type: u4
  instrmt_leg_grp_comp:
    seq:
      - id: leg_security_id
        type: s8
      - id: leg_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leg_symbol
        type: s4
      - id: leg_ratio_qty
        type: u4
      - id: leg_side
        type: u1
        enum: leg_side
      - id: leg_security_type
        type: u1
        enum: leg_security_type
      - id: pad6
        size: 6
  add_complex_instrument_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: low_limit_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: high_limit_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: security_id
        type: s8
      - id: last_update_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_response_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: number_of_securities
        type: s4
      - id: security_sub_type
        type: s4
      - id: multileg_model
        type: u1
        enum: multileg_model
      - id: implied_market_indicator
        type: u1
        enum: implied_market_indicator
      - id: product_complex
        type: u1
        enum: product_complex
      - id: num_instrmt_leg_grp_comp
        type: u1
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
  nr_response_header_me_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: response_in
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: msg_seq_num
        type: u4
      - id: last_fragment
        type: u1
        enum: last_fragment
      - id: pad3
        size: 3
  add_flexible_instrument_request:
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
      - id: strike_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: maturity_date
        type: u4
      - id: settl_method
        type: u1
        enum: settl_method
      - id: opt_attribute
        type: u1
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: exercise_style
        type: u1
        enum: exercise_style
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  add_flexible_instrument_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: security_response_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: strike_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: maturity_date
        type: u4
      - id: product_complex
        type: u1
        enum: product_complex
      - id: settl_method
        type: u1
        enum: settl_method
      - id: opt_attribute
        type: u1
      - id: put_or_call
        type: u1
        enum: put_or_call
      - id: exercise_style
        type: u1
        enum: exercise_style
      - id: symbol
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
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
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: alloc_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: package_id
        type: u4
      - id: alloc_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: related_market_segment_id
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
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
  clip_deletion_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: product_complex
        type: u1
        enum: product_complex
      - id: side
        type: u1
        enum: side
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: pad6
        size: 6
  rbc_header_me_comp:
    seq:
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: notification_in
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: nanosecond_timestamp
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
  clip_execution_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
      - id: product_complex
        type: u1
        enum: product_complex
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
      - id: num_fills_grp_comp
        type: u1
      - id: pad2v2
        size: 2
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
  fills_grp_comp:
    seq:
      - id: fill_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: fill_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: fill_match_id
        type: u4
      - id: fill_exec_id
        type: s4
      - id: fill_liquidity_ind
        type: u1
        enum: fill_liquidity_ind
      - id: pad7
        size: 7
  instrmnt_leg_exec_grp_comp:
    seq:
      - id: leg_security_id
        type: s8
      - id: leg_last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leg_last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leg_exec_id
        type: s4
      - id: leg_side
        type: u1
        enum: leg_side
      - id: fill_ref_id
        type: u1
      - id: pad2
        size: 2
  clip_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: market_segment_id
        type: s4
      - id: num_cross_request_ack_side_grp_comp
        type: u1
      - id: pad3
        size: 3
      - id: cross_request_id
        type: s4
      - id: pad4
        size: 4
      - id: cross_request_ack_side_grp_comp
        type: cross_request_ack_side_grp_comp
        repeat: expr
        repeat-expr: num_cross_request_ack_side_grp_comp
  cross_request_ack_side_grp_comp:
    seq:
      - id: order_id
        type: u8
      - id: input_source
        type: u1
        enum: input_source
      - id: side
        type: u1
        enum: side
      - id: pad6
        size: 6
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
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  cross_request_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
  delete_all_order_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: price
        type: decimal_u8_8
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
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_order_requests_grp_comp
        type: affected_order_requests_grp_comp
        repeat: expr
        repeat-expr: num_affected_order_requests_grp_comp
  not_affected_orders_grp_comp:
    seq:
      - id: not_affected_order_id
        type: u8
      - id: not_aff_orig_cl_ord_id
        type: u8
  affected_order_requests_grp_comp:
    seq:
      - id: affected_order_request_id
        type: u4
      - id: pad4
        size: 4
  delete_all_order_nr_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
  delete_all_order_quote_event_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp
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
        type: decimal_u8_8
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_orders_grp_comp
        type: u2
      - id: num_affected_order_requests_grp_comp
        type: u2
      - id: pad4
        size: 4
      - id: not_affected_orders_grp_comp
        type: not_affected_orders_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_orders_grp_comp
      - id: affected_order_requests_grp_comp
        type: affected_order_requests_grp_comp
        repeat: expr
        repeat-expr: num_affected_order_requests_grp_comp
  response_header_me_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_in
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_out
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: response_in
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: num_not_affected_securities_grp_comp
        type: u2
      - id: pad6
        size: 6
      - id: not_affected_securities_grp_comp
        type: not_affected_securities_grp_comp
        repeat: expr
        repeat-expr: num_not_affected_securities_grp_comp
  delete_clip_request:
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
      - id: security_id
        type: s8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: pad2v2
        size: 2
      - id: cross_request_id
        type: s4
      - id: pad4
        size: 4
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
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
      - id: product_complex
        type: u1
        enum: product_complex
      - id: side
        type: u1
        enum: side
      - id: fix_cl_ord_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
  delete_order_complex_request:
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: product_complex
        type: u1
        enum: product_complex
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: pad2v2
        size: 2
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: product_complex
        type: u1
        enum: product_complex
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: pad2v2
        size: 2
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
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: simple_security_id
        type: u4
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
      - id: pad6
        size: 6
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
        type: u4
      - id: market_segment_id
        type: s4
      - id: tes_exec_id
        type: u4
      - id: related_market_segment_id
        type: s4
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
      - id: pad1
        size: 1
  enter_clip_request:
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: cross_id
        type: s4
      - id: cross_request_id
        type: s4
      - id: num_cross_request_side_grp_comp
        type: u1
      - id: num_side_cross_leg_grp_comp
        type: u1
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: price_disclosure_instruction
        type: u1
        enum: price_disclosure_instruction
      - id: order_qty_disclosure_instruction
        type: u1
        enum: order_qty_disclosure_instruction
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
      - id: pad4
        size: 4
      - id: cross_request_side_grp_comp
        type: cross_request_side_grp_comp
        repeat: expr
        repeat-expr: num_cross_request_side_grp_comp
      - id: side_cross_leg_grp_comp
        type: side_cross_leg_grp_comp
        repeat: expr
        repeat-expr: num_side_cross_leg_grp_comp
  cross_request_side_grp_comp:
    seq:
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: maximum_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: input_source
        type: u1
        enum: input_source
      - id: side
        type: u1
        enum: side
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: position_effect
        type: u1
        enum: position_effect
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: side_compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  side_cross_leg_grp_comp:
    seq:
      - id: leg_input_source
        type: u1
        enum: leg_input_source
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
      - id: leg_account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
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
        type: s8
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: related_close_price
        type: decimal_u8_6
        doc: 'Implied decimal with scale 1e-6'
      - id: related_trade_quantity
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: underlying_settlement_date
        type: u4
      - id: underlying_maturity_date
        type: u4
      - id: related_trade_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: product_complex
        type: u1
        enum: product_complex
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_grp_comp
        type: u1
      - id: num_instrument_event_grp_comp
        type: u1
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
      - id: num_instrument_attribute_grp_comp
        type: u1
      - id: num_underlying_stip_grp_comp
        type: u1
      - id: party_id_settlement_location
        type: u1
        enum: party_id_settlement_location
      - id: hedge_type
        type: u1
        enum: hedge_type
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
      - id: underlying_security_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_desc
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
      - id: instrument_event_grp_comp
        type: instrument_event_grp_comp
        repeat: expr
        repeat-expr: num_instrument_event_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
  side_alloc_grp_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: individual_alloc_id
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
  trd_instrmnt_leg_grp_comp:
    seq:
      - id: leg_security_id
        type: s8
      - id: leg_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
  instrument_event_grp_comp:
    seq:
      - id: event_date
        type: u4
      - id: event_type
        type: u1
        enum: event_type
      - id: pad3
        size: 3
  instrument_attribute_grp_comp:
    seq:
      - id: instr_attrib_type
        type: u1
        enum: instr_attrib_type
      - id: instr_attrib_value
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  underlying_stip_grp_comp:
    seq:
      - id: underlying_stip_value
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_stip_type
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
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
  response_header_comp:
    seq:
      - id: request_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: sending_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: msg_seq_num
        type: u4
      - id: pad4
        size: 4
  enrichment_rules_grp_comp:
    seq:
      - id: enrichment_rule_id
        type: u2
      - id: party_id_origination_market
        type: u1
        enum: party_id_origination_market
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
  inquire_mm_parameter_request:
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
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
  inquire_mm_parameter_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mm_parameter_report_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_mm_parameter_grp_comp
        type: u1
      - id: pad3
        size: 3
      - id: mm_parameter_grp_comp
        type: mm_parameter_grp_comp
        repeat: expr
        repeat-expr: num_mm_parameter_grp_comp
  mm_parameter_grp_comp:
    seq:
      - id: exposure_duration
        type: s8
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: delta
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: vega
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: pct_count
        type: s4
      - id: target_party_id_session_id
        type: u4
  inquire_pre_trade_risk_limits_request:
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
      - id: market_segment_id
        type: s4
      - id: risk_limit_platform
        type: u1
        enum: risk_limit_platform
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
      - id: pad3
        size: 3
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
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
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
  mm_parameter_definition_request:
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
      - id: exposure_duration
        type: s8
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: delta
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: vega
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: target_party_id_session_id
        type: u4
      - id: pct_count
        type: s4
      - id: pad4
        size: 4
  mm_parameter_definition_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
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
      - id: quote_size_type
        type: u1
        enum: quote_size_type
      - id: quote_type
        type: u1
        enum: quote_type
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
  mass_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: quote_id
        type: u8
      - id: quote_response_id
        type: nanosecond_timestamp
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
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_cxl_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_entry_reject_reason
        type: u4
        enum: quote_entry_reject_reason
      - id: quote_entry_status
        type: u1
        enum: quote_entry_status
      - id: pad3
        size: 3
  modify_order_complex_request:
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: expire_date
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: target_party_id_session_id
        type: u4
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: product_complex
        type: u1
        enum: product_complex
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
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: ownership_indicator
        type: u1
        enum: ownership_indicator
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
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
      - id: num_leg_ord_grp_comp
        type: u1
      - id: pad6
        size: 6
      - id: leg_ord_grp_comp
        type: leg_ord_grp_comp
        repeat: expr
        repeat-expr: num_leg_ord_grp_comp
  leg_ord_grp_comp:
    seq:
      - id: leg_account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: leg_position_effect
        type: u1
        enum: leg_position_effect
      - id: pad5
        size: 5
  modify_order_complex_short_request:
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
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
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: product_complex
        type: u1
        enum: product_complex
      - id: side
        type: u1
        enum: side
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
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
      - id: product_complex
        type: u1
        enum: product_complex
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
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
      - id: product_complex
        type: u1
        enum: product_complex
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
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
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
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
      - id: simple_security_id
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: target_party_id_session_id
        type: u4
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: ownership_indicator
        type: u1
        enum: ownership_indicator
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
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
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: simple_security_id
        type: u4
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
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad4
        size: 4
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
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
      - id: num_trd_instrmnt_leg_grp_comp
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
      - id: pad2v2
        size: 2
      - id: side_alloc_grp_comp
        type: side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_comp
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
  new_order_complex_request:
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
      - id: security_id
        type: s8
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: market_segment_id
        type: s4
      - id: expire_date
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: product_complex
        type: u1
        enum: product_complex
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
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: party_id_position_account
        type: str
        size: 32
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
      - id: num_leg_ord_grp_comp
        type: u1
      - id: pad2v2
        size: 2
      - id: leg_ord_grp_comp
        type: leg_ord_grp_comp
        repeat: expr
        repeat-expr: num_leg_ord_grp_comp
  new_order_complex_short_request:
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cl_ord_id
        type: u8
      - id: party_id_client_id
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
      - id: appl_seq_indicator
        type: u1
        enum: appl_seq_indicator
      - id: product_complex
        type: u1
        enum: product_complex
      - id: side
        type: u1
        enum: side
      - id: price_validity_check_type
        type: u1
        enum: price_validity_check_type
      - id: value_check_type_value
        type: u1
        enum: value_check_type_value
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: exec_inst
        type: u1
        enum: exec_inst
      - id: time_in_force
        type: u1
        enum: time_in_force
      - id: trading_capacity
        type: u1
        enum: trading_capacity
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
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
      - id: product_complex
        type: u1
        enum: product_complex
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
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
      - id: product_complex
        type: u1
        enum: product_complex
      - id: triggered
        type: u1
        enum: triggered
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
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
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: cl_ord_id
        type: u8
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
      - id: simple_security_id
        type: u4
      - id: match_inst_cross_id
        type: u4
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
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
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
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
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
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
      - id: pad4
        size: 4
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
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cl_ord_id
        type: u8
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: simple_security_id
        type: u4
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
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad4
        size: 4
  news_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: orig_time
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: side
        type: u1
        enum: side
      - id: product_complex
        type: u1
        enum: product_complex
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
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
      - id: pad5
        size: 5
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: stop_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
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
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: party_id_entering_firm
        type: u1
        enum: party_id_entering_firm
      - id: product_complex
        type: u1
        enum: product_complex
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
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
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
      - id: num_fills_grp_comp
        type: u1
      - id: num_leg_ord_grp_comp
        type: u1
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: pad2v2
        size: 2
      - id: leg_ord_grp_comp
        type: leg_ord_grp_comp
        repeat: expr
        repeat-expr: num_leg_ord_grp_comp
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cxl_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
      - id: exec_restatement_reason
        type: u2
        enum: exec_restatement_reason
      - id: side
        type: u1
        enum: side
      - id: product_complex
        type: u1
        enum: product_complex
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: triggered
        type: u1
        enum: triggered
      - id: crossed_indicator
        type: u1
        enum: crossed_indicator
      - id: transaction_delay_indicator
        type: u1
        enum: transaction_delay_indicator
      - id: num_fills_grp_comp
        type: u1
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
  party_action_report:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
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
  pre_trade_risk_limit_response:
    seq:
      - id: pad2
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
      - id: risk_limit_platform
        type: u1
        enum: risk_limit_platform
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
      - id: risk_limits_rpt_grp_comp
        type: risk_limits_rpt_grp_comp
        repeat: expr
        repeat-expr: num_risk_limits_rpt_grp_comp
  risk_limits_rpt_grp_comp:
    seq:
      - id: risk_limit_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_limit_open_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_limit_net_position_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
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
      - id: pad2
        size: 2
  pre_trade_risk_limits_definition_request:
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
      - id: market_segment_id
        type: s4
      - id: risk_limit_platform
        type: u1
        enum: risk_limit_platform
      - id: num_risk_limit_qty_grp_comp
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
      - id: pad1
        size: 1
      - id: risk_limit_qty_grp_comp
        type: risk_limit_qty_grp_comp
        repeat: expr
        repeat-expr: num_risk_limit_qty_grp_comp
  risk_limit_qty_grp_comp:
    seq:
      - id: risk_limit_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: risk_limit_type
        type: u1
        enum: risk_limit_type
      - id: pad7
        size: 7
  quote_activation_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp
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
      - id: mass_action_sub_type
        type: u1
        enum: mass_action_sub_type
      - id: mass_action_reason
        type: u1
        enum: mass_action_reason
      - id: pad2v2
        size: 2
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
      - id: mass_action_sub_type
        type: u1
        enum: mass_action_sub_type
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: pad4
        size: 4
  quote_activation_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mass_action_report_id
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: market_segment_id
        type: s4
      - id: num_quote_leg_exec_grp_comp
        type: u2
      - id: num_quote_event_grp_comp
        type: u1
      - id: pad1
        size: 1
      - id: quote_event_grp_comp
        type: quote_event_grp_comp
        repeat: expr
        repeat-expr: num_quote_event_grp_comp
      - id: quote_leg_exec_grp_comp
        type: quote_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_quote_leg_exec_grp_comp
  quote_event_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: quote_event_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: quote_event_qty
        type: decimal_u8_4
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
      - id: quote_event_reason
        type: u1
        enum: quote_event_reason
      - id: pad4
        size: 4
  quote_leg_exec_grp_comp:
    seq:
      - id: leg_security_id
        type: s8
      - id: leg_last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leg_last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: leg_exec_id
        type: s4
      - id: leg_side
        type: u1
        enum: leg_side
      - id: no_quote_events_index
        type: u1
      - id: pad2
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
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: side
        type: u1
        enum: side
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  rfq_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp
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
  risk_notification_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
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
      - id: risk_limit_action
        type: u1
        enum: risk_limit_action
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
      - id: pad6
        size: 6
  srqs_create_deal_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_id
        type: u8
      - id: security_id
        type: s8
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_effective_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_price_stip_value
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: orig_trade_id
        type: u4
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: side
        type: u1
        enum: side
      - id: num_order_book_item_grp_comp
        type: u1
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
      - id: pad7
        size: 7
      - id: order_book_item_grp_comp
        type: order_book_item_grp_comp
        repeat: expr
        repeat-expr: num_order_book_item_grp_comp
  order_book_item_grp_comp:
    seq:
      - id: security_id
        type: s8
      - id: best_bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: best_bid_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: best_offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: best_offer_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: md_book_type
        type: u1
        enum: md_book_type
      - id: md_sub_book_type
        type: u1
        enum: md_sub_book_type
      - id: pad6
        size: 6
  srqs_deal_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_price_stip_value
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: message_event_source
        type: u1
        enum: message_event_source
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
      - id: pad4
        size: 4
  srqs_deal_response:
    seq:
      - id: pad2
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
      - id: pad4
        size: 4
  srqs_enter_quote_request:
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
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: bid_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: value_check_type_quantity
        type: u1
        enum: value_check_type_quantity
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
  srqs_hit_quote_request:
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
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: valid_until_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_price_stip_value
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
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
      - id: pad3
        size: 3
  srqs_negotiation_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
        type: u4
      - id: number_of_respondents
        type: u4
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_sub_type
        type: u1
        enum: quote_sub_type
      - id: quote_status
        type: u1
        enum: quote_status
      - id: quote_instruction
        type: u1
        enum: quote_instruction
      - id: side
        type: u1
        enum: side
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
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
      - id: pad2v2
        size: 2
  srqs_negotiation_requester_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
        type: u4
      - id: number_of_respondents
        type: u4
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_sub_type
        type: u1
        enum: quote_sub_type
      - id: quote_status
        type: u1
        enum: quote_status
      - id: num_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
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
      - id: pad4
        size: 4
      - id: target_parties_comp
        type: target_parties_comp
        repeat: expr
        repeat-expr: num_target_parties_comp
  target_parties_comp:
    seq:
      - id: side_disclosure_instruction
        type: u1
        enum: side_disclosure_instruction
      - id: price_disclosure_instruction
        type: u1
        enum: price_disclosure_instruction
      - id: leaves_qty_disclosure_instruction
        type: u1
        enum: leaves_qty_disclosure_instruction
      - id: last_px_disclosure_instruction
        type: u1
        enum: last_px_disclosure_instruction
      - id: last_qty_disclosure_instruction
        type: u1
        enum: last_qty_disclosure_instruction
      - id: quote_instruction
        type: u1
        enum: quote_instruction
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
      - id: pad7
        size: 7
  srqs_negotiation_status_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_id
        type: u4
      - id: quote_status
        type: u1
        enum: quote_status
      - id: firm_negotiation_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  srqs_open_negotiation_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: negotiation_start_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: security_sub_type
        type: s4
      - id: number_of_respondents
        type: u4
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_sub_type
        type: u1
        enum: quote_sub_type
      - id: quote_status
        type: u1
        enum: quote_status
      - id: num_quot_req_legs_grp_comp
        type: u1
      - id: side
        type: u1
        enum: side
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
      - id: trade_underlying
        type: u1
        enum: trade_underlying
      - id: product_complex
        type: u1
        enum: product_complex
      - id: negotiate_underlying
        type: u1
        enum: negotiate_underlying
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
      - id: pad7
        size: 7
      - id: quot_req_legs_grp_comp
        type: quot_req_legs_grp_comp
        repeat: expr
        repeat-expr: num_quot_req_legs_grp_comp
  quot_req_legs_grp_comp:
    seq:
      - id: leg_security_id
        type: s8
      - id: leg_ratio_qty
        type: u4
      - id: leg_symbol
        type: s4
      - id: leg_security_type
        type: u1
        enum: leg_security_type
      - id: leg_side
        type: u1
        enum: leg_side
      - id: pad6
        size: 6
  srqs_open_negotiation_request:
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
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: security_sub_type
        type: s4
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_sub_type
        type: u1
        enum: quote_sub_type
      - id: num_quot_req_legs_grp_comp
        type: u1
      - id: num_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
      - id: trade_underlying
        type: u1
        enum: trade_underlying
      - id: negotiate_underlying
        type: u1
        enum: negotiate_underlying
      - id: product_complex
        type: u1
        enum: product_complex
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
      - id: quote_req_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
      - id: quot_req_legs_grp_comp
        type: quot_req_legs_grp_comp
        repeat: expr
        repeat-expr: num_quot_req_legs_grp_comp
      - id: target_parties_comp
        type: target_parties_comp
        repeat: expr
        repeat-expr: num_target_parties_comp
  srqs_open_negotiation_requester_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: security_id
        type: s8
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
        type: u4
      - id: market_segment_id
        type: s4
      - id: security_sub_type
        type: s4
      - id: number_of_respondents
        type: u4
      - id: quote_type
        type: u1
        enum: quote_type
      - id: quote_sub_type
        type: u1
        enum: quote_sub_type
      - id: quote_status
        type: u1
        enum: quote_status
      - id: num_quot_req_legs_grp_comp
        type: u1
      - id: num_target_parties_comp
        type: u1
      - id: side
        type: u1
        enum: side
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
      - id: trade_underlying
        type: u1
        enum: trade_underlying
      - id: negotiate_underlying
        type: u1
        enum: negotiate_underlying
      - id: product_complex
        type: u1
        enum: product_complex
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
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
      - id: quot_req_legs_grp_comp
        type: quot_req_legs_grp_comp
        repeat: expr
        repeat-expr: num_quot_req_legs_grp_comp
      - id: target_parties_comp
        type: target_parties_comp
        repeat: expr
        repeat-expr: num_target_parties_comp
  srqs_quote_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: quote_id
        type: u8
      - id: secondary_quote_id
        type: u8
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: bid_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_size
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: negotiation_id
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
      - id: pad3
        size: 3
  srqs_quote_response:
    seq:
      - id: pad2
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
  srqs_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad3
        size: 3
  srqs_update_deal_status_request:
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
      - id: underlying_price_stip_value
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: trade_id
        type: u4
      - id: pad4
        size: 4
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
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
      - id: pad3
        size: 3
  srqs_update_negotiation_request:
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
      - id: quote_ref_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: underlying_delta_percentage
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: bid_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: offer_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: order_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: num_target_parties_comp
        type: u1
      - id: number_of_resp_disclosure_instruction
        type: u1
        enum: number_of_resp_disclosure_instruction
      - id: side
        type: u1
        enum: side
      - id: quote_cancel_type
        type: u1
        enum: quote_cancel_type
      - id: quote_ref_price_source
        type: u1
        enum: quote_ref_price_source
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
      - id: target_parties_comp
        type: target_parties_comp
        repeat: expr
        repeat-expr: num_target_parties_comp
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
      - id: pad5
        size: 5
  nrbc_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp
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
  service_availability_market_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: selective_request_for_quote_service_trade_date
        type: u4
      - id: selective_request_for_quote_service_status
        type: u1
        enum: selective_request_for_quote_service_status
      - id: pad3
        size: 3
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
  tes_approve_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: alloc_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: related_close_price
        type: decimal_u8_6
        doc: 'Implied decimal with scale 1e-6'
      - id: related_trade_quantity
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: alloc_id
        type: u4
      - id: underlying_settlement_date
        type: u4
      - id: underlying_maturity_date
        type: u4
      - id: related_trade_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: side
        type: u1
        enum: side
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: product_complex
        type: u1
        enum: product_complex
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: party_id_settlement_location
        type: u1
        enum: party_id_settlement_location
      - id: trade_alloc_status
        type: u1
        enum: trade_alloc_status
      - id: hedge_type
        type: u1
        enum: hedge_type
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
      - id: num_instrument_event_grp_comp
        type: u1
      - id: num_instrument_attribute_grp_comp
        type: u1
      - id: num_underlying_stip_grp_comp
        type: u1
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
      - id: position_effect
        type: u1
        enum: position_effect
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_desc
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v1
        size: 2
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
      - id: instrument_event_grp_comp
        type: instrument_event_grp_comp
        repeat: expr
        repeat-expr: num_instrument_event_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
  tes_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: related_close_price
        type: decimal_u8_6
        doc: 'Implied decimal with scale 1e-6'
      - id: related_trade_quantity
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: underlying_settlement_date
        type: u4
      - id: underlying_maturity_date
        type: u4
      - id: related_trade_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: product_complex
        type: u1
        enum: product_complex
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_instrument_event_grp_comp
        type: u1
      - id: num_instrument_attribute_grp_comp
        type: u1
      - id: num_underlying_stip_grp_comp
        type: u1
      - id: num_side_alloc_grp_bc_comp
        type: u1
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
      - id: party_id_settlement_location
        type: u1
        enum: party_id_settlement_location
      - id: hedge_type
        type: u1
        enum: hedge_type
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
      - id: underlying_security_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_desc
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: side_alloc_grp_bc_comp
        type: side_alloc_grp_bc_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_bc_comp
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
      - id: instrument_event_grp_comp
        type: instrument_event_grp_comp
        repeat: expr
        repeat-expr: num_instrument_event_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
  side_alloc_grp_bc_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: individual_alloc_id
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
      - id: pad7
        size: 7
  tes_delete_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp
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
        type: nanosecond_timestamp
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
        type: u4
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
        type: s8
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_trade_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: clearing_trade_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: related_security_id
        type: s8
      - id: root_party_id_client_id
        type: u8
      - id: executing_trader
        type: u8
      - id: root_party_id_investment_decision_maker
        type: u8
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
      - id: orig_trade_id
        type: u4
      - id: root_party_id_executing_unit
        type: u4
      - id: root_party_id_executing_trader
        type: u4
      - id: root_party_id_clearing_unit
        type: u4
      - id: strategy_link_id
        type: u4
      - id: related_symbol
        type: s4
      - id: tot_num_trade_reports
        type: s4
      - id: basket_trd_match_id
        type: s4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: product_complex
        type: u1
        enum: product_complex
      - id: related_product_complex
        type: u1
        enum: related_product_complex
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
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
      - id: position_effect
        type: u1
        enum: position_effect
      - id: multileg_price_model
        type: u1
        enum: multileg_price_model
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
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
      - id: root_party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
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
      - id: root_party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: basket_side_trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  tes_trading_session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: trade_date
        type: u4
      - id: trad_ses_event
        type: u1
        enum: trad_ses_event
      - id: pad3
        size: 3
  tes_upload_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: security_id
        type: s8
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: related_close_price
        type: decimal_u8_6
        doc: 'Implied decimal with scale 1e-6'
      - id: related_trade_quantity
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: package_id
        type: u4
      - id: tes_exec_id
        type: u4
      - id: underlying_settlement_date
        type: u4
      - id: underlying_maturity_date
        type: u4
      - id: related_trade_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: product_complex
        type: u1
        enum: product_complex
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: trade_platform
        type: u1
        enum: trade_platform
      - id: num_side_alloc_ext_grp_comp
        type: u1
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
      - id: num_instrument_event_grp_comp
        type: u1
      - id: num_instrument_attribute_grp_comp
        type: u1
      - id: num_underlying_stip_grp_comp
        type: u1
      - id: hedge_type
        type: u1
        enum: hedge_type
      - id: party_id_settlement_location
        type: u1
        enum: party_id_settlement_location
      - id: message_event_source
        type: u1
        enum: message_event_source
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
      - id: underlying_security_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_desc
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
      - id: side_alloc_ext_grp_comp
        type: side_alloc_ext_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_ext_grp_comp
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
      - id: instrument_event_grp_comp
        type: instrument_event_grp_comp
        repeat: expr
        repeat-expr: num_instrument_event_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
  side_alloc_ext_grp_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: party_id_client_id
        type: u8
      - id: party_id_investment_decision_maker
        type: u8
      - id: executing_trader
        type: u8
      - id: individual_alloc_id
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
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: position_effect
        type: u1
        enum: position_effect
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: executing_trader_qualifier
        type: u1
        enum: executing_trader_qualifier
      - id: party_id_investment_decision_maker_qualifier
        type: u1
        enum: party_id_investment_decision_maker_qualifier
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
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
      - id: related_security_id
        type: s8
      - id: price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: side_last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: side_last_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: clearing_trade_price
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: clearing_trade_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: transact_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
      - id: cl_ord_id
        type: u8
      - id: leaves_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: cum_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
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
      - id: root_party_id_clearing_unit
        type: u4
      - id: market_segment_id
        type: s4
      - id: related_symbol
        type: s4
      - id: side_trade_id
        type: u4
      - id: match_date
        type: u4
      - id: trd_match_id
        type: u4
      - id: strategy_link_id
        type: u4
      - id: tot_num_trade_reports
        type: s4
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: transfer_reason
        type: u1
        enum: transfer_reason
      - id: root_party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: root_party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
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
      - id: trading_capacity
        type: u1
        enum: trading_capacity
      - id: order_attribute_liquidity_provision
        type: u1
        enum: order_attribute_liquidity_provision
      - id: order_attribute_risk_reduction
        type: u1
        enum: order_attribute_risk_reduction
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
      - id: root_party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
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
      - id: order_category
        type: u1
        enum: order_category
      - id: ord_type
        type: u1
        enum: ord_type
      - id: related_product_complex
        type: u1
        enum: related_product_complex
      - id: order_side
        type: u1
        enum: order_side
      - id: root_party_clearing_organization
        type: str
        size: 4
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
      - id: regulatory_trade_id
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
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
  upload_tes_trade_request:
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
      - id: last_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: trans_bkd_time
        type: nanosecond_timestamp
        doc: 'Nanoseconds since Unix epoch'
      - id: underlying_px
        type: decimal_u8_8
        doc: 'Implied decimal with scale 1e-8'
      - id: related_close_price
        type: decimal_u8_6
        doc: 'Implied decimal with scale 1e-6'
      - id: related_trade_quantity
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: underlying_qty
        type: decimal_u8_4
        doc: 'Implied decimal with scale 1e-4'
      - id: market_segment_id
        type: s4
      - id: underlying_settlement_date
        type: u4
      - id: underlying_maturity_date
        type: u4
      - id: related_trade_id
        type: u4
      - id: related_market_segment_id
        type: s4
      - id: negotiation_id
        type: u4
      - id: srqs_related_trade_id
        type: u4
      - id: trd_type
        type: u2
        enum: trd_type
      - id: product_complex
        type: u1
        enum: product_complex
      - id: trade_report_type
        type: u1
        enum: trade_report_type
      - id: trade_publish_indicator
        type: u1
        enum: trade_publish_indicator
      - id: num_side_alloc_ext_grp_comp
        type: u1
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
      - id: num_instrument_event_grp_comp
        type: u1
      - id: num_instrument_attribute_grp_comp
        type: u1
      - id: num_underlying_stip_grp_comp
        type: u1
      - id: skip_validations
        type: u1
        enum: skip_validations
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
      - id: trade_platform
        type: u1
        enum: trade_platform
      - id: hedge_type
        type: u1
        enum: hedge_type
      - id: party_id_settlement_location
        type: u1
        enum: party_id_settlement_location
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_id
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_security_desc
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_issuer
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
      - id: side_alloc_ext_grp_comp
        type: side_alloc_ext_grp_comp
        repeat: expr
        repeat-expr: num_side_alloc_ext_grp_comp
      - id: trd_instrmnt_leg_grp_comp
        type: trd_instrmnt_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_instrmnt_leg_grp_comp
      - id: instrument_event_grp_comp
        type: instrument_event_grp_comp
        repeat: expr
        repeat-expr: num_instrument_event_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
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
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0

enums:
  template_id:
    10301:
      id: 'add_complex_instrument_request'
      doc: 'Add Complex Instrument Request TemplateId'
    10302:
      id: 'add_complex_instrument_response'
      doc: 'Add Complex Instrument Response TemplateId'
    10309:
      id: 'add_flexible_instrument_request'
      doc: 'Add Flexible Instrument Request TemplateId'
    10310:
      id: 'add_flexible_instrument_response'
      doc: 'Add Flexible Instrument Response TemplateId'
    10603:
      id: 'approve_tes_trade_request'
      doc: 'Approve Tes Trade Request TemplateId'
    10032:
      id: 'broadcast_error_notification'
      doc: 'Broadcast Error Notification TemplateId'
    10134:
      id: 'clip_deletion_notification'
      doc: 'Clip Deletion Notification TemplateId'
    10135:
      id: 'clip_execution_notification'
      doc: 'Clip Execution Notification TemplateId'
    10133:
      id: 'clip_response'
      doc: 'Clip Response TemplateId'
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
    10132:
      id: 'delete_clip_request'
      doc: 'Delete Clip Request TemplateId'
    10112:
      id: 'delete_order_broadcast'
      doc: 'Delete Order Broadcast TemplateId'
    10123:
      id: 'delete_order_complex_request'
      doc: 'Delete Order Complex Request TemplateId'
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
    10131:
      id: 'enter_clip_request'
      doc: 'Enter Clip Request TemplateId'
    10600:
      id: 'enter_tes_trade_request'
      doc: 'Enter Tes Trade Request TemplateId'
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
    10305:
      id: 'inquire_mm_parameter_request'
      doc: 'Inquire Mm Parameter Request TemplateId'
    10306:
      id: 'inquire_mm_parameter_response'
      doc: 'Inquire Mm Parameter Response TemplateId'
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
    10303:
      id: 'mm_parameter_definition_request'
      doc: 'Mm Parameter Definition Request TemplateId'
    10304:
      id: 'mm_parameter_definition_response'
      doc: 'Mm Parameter Definition Response TemplateId'
    10405:
      id: 'mass_quote_request'
      doc: 'Mass Quote Request TemplateId'
    10406:
      id: 'mass_quote_response'
      doc: 'Mass Quote Response TemplateId'
    10114:
      id: 'modify_order_complex_request'
      doc: 'Modify Order Complex Request TemplateId'
    10130:
      id: 'modify_order_complex_short_request'
      doc: 'Modify Order Complex Short Request TemplateId'
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
    10113:
      id: 'new_order_complex_request'
      doc: 'New Order Complex Request TemplateId'
    10129:
      id: 'new_order_complex_short_request'
      doc: 'New Order Complex Short Request TemplateId'
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
    10033:
      id: 'risk_notification_broadcast'
      doc: 'Risk Notification Broadcast TemplateId'
    10708:
      id: 'srqs_create_deal_notification'
      doc: 'Srqs Create Deal Notification TemplateId'
    10709:
      id: 'srqs_deal_notification'
      doc: 'Srqs Deal Notification TemplateId'
    10705:
      id: 'srqs_deal_response'
      doc: 'Srqs Deal Response TemplateId'
    10702:
      id: 'srqs_enter_quote_request'
      doc: 'Srqs Enter Quote Request TemplateId'
    10704:
      id: 'srqs_hit_quote_request'
      doc: 'Srqs Hit Quote Request TemplateId'
    10713:
      id: 'srqs_negotiation_notification'
      doc: 'Srqs Negotiation Notification TemplateId'
    10712:
      id: 'srqs_negotiation_requester_notification'
      doc: 'Srqs Negotiation Requester Notification TemplateId'
    10715:
      id: 'srqs_negotiation_status_notification'
      doc: 'Srqs Negotiation Status Notification TemplateId'
    10711:
      id: 'srqs_open_negotiation_notification'
      doc: 'Srqs Open Negotiation Notification TemplateId'
    10700:
      id: 'srqs_open_negotiation_request'
      doc: 'Srqs Open Negotiation Request TemplateId'
    10710:
      id: 'srqs_open_negotiation_requester_notification'
      doc: 'Srqs Open Negotiation Requester Notification TemplateId'
    10707:
      id: 'srqs_quote_notification'
      doc: 'Srqs Quote Notification TemplateId'
    10703:
      id: 'srqs_quote_response'
      doc: 'Srqs Quote Response TemplateId'
    10714:
      id: 'srqs_status_broadcast'
      doc: 'Srqs Status Broadcast TemplateId'
    10706:
      id: 'srqs_update_deal_status_request'
      doc: 'Srqs Update Deal Status Request TemplateId'
    10701:
      id: 'srqs_update_negotiation_request'
      doc: 'Srqs Update Negotiation Request TemplateId'
    10030:
      id: 'service_availability_broadcast'
      doc: 'Service Availability Broadcast TemplateId'
    10044:
      id: 'service_availability_market_broadcast'
      doc: 'Service Availability Market Broadcast TemplateId'
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
    10613:
      id: 'tes_upload_broadcast'
      doc: 'Tes Upload Broadcast TemplateId'
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
    10006:
      id: 'unsubscribe_request'
      doc: 'Unsubscribe Request TemplateId'
    10007:
      id: 'unsubscribe_response'
      doc: 'Unsubscribe Response TemplateId'
    10612:
      id: 'upload_tes_trade_request'
      doc: 'Upload Tes Trade Request TemplateId'
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
    10:
      id: 'flexiblesimpleinstrument'
      doc: 'Flexible Simple Instrument'
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  leg_security_type:
    1:
      id: 'multileg_instrument'
      doc: 'Multileg Instrument'
    2:
      id: 'underlying_leg'
      doc: 'Underlying Leg'
  last_fragment:
    0:
      id: 'not_last_message'
      doc: 'Not Last Message'
    1:
      id: 'last_message'
      doc: 'Last Message'
  multileg_model:
    0:
      id: 'predefined_multileg_security'
      doc: 'Predefined Multileg Security'
    1:
      id: 'userdefined_multleg'
      doc: 'User-defined Multleg Security'
  implied_market_indicator:
    0:
      id: 'notimplied'
      doc: 'Not implied'
    3:
      id: 'impliedinout'
      doc: 'Both Implied-in and Implied-out'
  settl_method:
    0x43:
      id: 'cash_settlement'
      doc: 'Cash Settlement'
    0x50:
      id: 'physical_settlement'
      doc: 'Physical Settlement'
  put_or_call:
    0:
      id: 'put'
      doc: 'Put'
    1:
      id: 'call'
      doc: 'Call'
  exercise_style:
    0:
      id: 'european'
      doc: 'European'
    1:
      id: 'american'
      doc: 'American'
  trd_type:
    1:
      id: 'block_trade'
      doc: 'Block Trade'
    12:
      id: 'exchangefor_swap'
      doc: 'Exchange for Swap'
    1000:
      id: 'vola_trade'
      doc: 'Vola Trade'
    1001:
      id: 'efp_fin_trade'
      doc: 'EFP-Fin Trade'
    1002:
      id: 'efp_index_futures_trade'
      doc: 'EFP-Index Futures Trade'
    1004:
      id: 'tradeat_market'
      doc: 'Trade at Market'
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
  trade_report_type:
    0:
      id: 'submit'
      doc: 'Trade'
    1:
      id: 'alleged'
      doc: 'Alleged'
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
  order_attribute_risk_reduction:
    1:
      id: 'y'
      doc: 'Risk reduction'
    0:
      id: 'n'
      doc: 'No risk reduction'
  position_effect:
    0x43:
      id: 'close'
      doc: 'Close'
    0x4f:
      id: 'open'
      doc: 'Open'
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
  session_status:
    0:
      id: 'active'
      doc: 'Session active'
    4:
      id: 'logout'
      doc: 'Session logout complete'
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
  appl_resend_flag:
    0:
      id: 'false'
      doc: 'False'
    1:
      id: 'true'
      doc: 'True'
  exec_restatement_reason:
    1:
      id: 'order_book_restatement'
      doc: 'Order book restatement'
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
    108:
      id: 'book_order_executed'
      doc: 'Book Order executed'
    114:
      id: 'changedto_ioc'
      doc: 'Order has been changed to IOC'
    122:
      id: 'instrument_state_change'
      doc: 'Instrument State Change'
    135:
      id: 'market_order_triggered'
      doc: 'Market Order triggered and executed'
    149:
      id: 'cao_order_activated'
      doc: 'Closing Auction Order has been activated'
    150:
      id: 'cao_order_inactivated'
      doc: 'Closing Auction Order has been inactivated'
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
    340:
      id: 'clip_execution'
      doc: 'CLIP execution after improvement period'
    343:
      id: 'clip_arrangementtimeout'
      doc: 'CLIP Request deleted by arrangement time out'
    344:
      id: 'clip_arrangement_validation'
      doc: 'CLIP Request deleted by arrangement validation'
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
    13:
      id: 'liquidity_improvement_cross'
      doc: 'Liquidity Improvement Cross'
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
  input_source:
    1:
      id: 'client_broker'
      doc: 'Client Broker'
    2:
      id: 'proprietary_broker'
      doc: 'Proprietary Broker'
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
    3:
      id: 'market_maker_protection'
      doc: 'Market Maker Protection'
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
    109:
      id: 'complex_instrument_deletion'
      doc: 'Complex Instrument Deletion'
    110:
      id: 'volatility_interruption'
      doc: 'Volatility Interruption'
    111:
      id: 'producttemporarilynottradeable'
      doc: 'Product temporarily not tradeable'
    117:
      id: 'memberdisable'
      doc: 'Member has been disabled'
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
  transaction_delay_indicator:
    0:
      id: 'notdelayed'
      doc: 'Transaction not delayed'
    1:
      id: 'delayed'
      doc: 'Transaction delayed'
  side_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  price_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  order_qty_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  leg_input_source:
    1:
      id: 'client_broker'
      doc: 'Client Broker'
    2:
      id: 'proprietary_broker'
      doc: 'Proprietary Broker'
  leg_position_effect:
    0x43:
      id: 'close'
      doc: 'Close'
    0x4f:
      id: 'open'
      doc: 'Open'
  trade_publish_indicator:
    0: 'do_not_publish_trade'
    1: 'publish_trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred publication to market'
    3:
      id: 'published'
      doc: 'Published to market'
  party_id_settlement_location:
    1:
      id: 'clearstrem_banking_frankfurt'
      doc: 'Clearstrem Banking Frankfurt'
    2:
      id: 'clearstrem_banking_luxemburg'
      doc: 'Clearstrem Banking Luxemburg'
    3:
      id: 'cls_group'
      doc: 'CLS Group'
    4:
      id: 'euroclear'
      doc: 'Euroclear'
  hedge_type:
    0:
      id: 'duration_hedge'
      doc: 'Duration Hedge'
    1:
      id: 'nominal_hedge'
      doc: 'Nominal Hedge'
    2:
      id: 'price_factor_hedge'
      doc: 'Price Factor Hedge'
  event_type:
    8:
      id: 'swap_start_date'
      doc: 'Swap Start Date'
    9:
      id: 'swap_end_date'
      doc: 'Swap End Date'
  instr_attrib_type:
    5:
      id: 'variable_rate'
      doc: 'Variable rate'
    100:
      id: 'coupon_rate'
      doc: 'Coupon rate'
    101:
      id: 'offsettothevariablecouponrate'
      doc: 'Offset to the variable coupon rate'
    102:
      id: 'swap_customer_1'
      doc: 'Swap Customer 1'
    103:
      id: 'swap_customer_2'
      doc: 'Swap Customer 2'
    104:
      id: 'cash_basket_reference'
      doc: 'Cash Basket Reference'
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
  party_id_origination_market:
    1:
      id: 'xkfe'
      doc: 'Korea Exchange'
  risk_limit_platform:
    0:
      id: 'on_book'
      doc: 'On-Book'
    1:
      id: 'off_book'
      doc: 'Off-Book(TES)'
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
    1:
      id: 'xeur'
      doc: 'XEUR'
    2:
      id: 'xeee'
      doc: 'XEEE'
    12:
      id: 'nodx'
      doc: 'NODX'
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
    1:
      id: 'optional'
      doc: 'Optional'
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
  quote_type:
    0:
      id: 'indicative'
      doc: 'Indicative'
    1:
      id: 'tradeable'
      doc: 'Tradeable'
    100:
      id: 'tradeable_boc'
      doc: 'Tradeable(BOC)'
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
    107:
      id: 'invalid_underlying_price'
      doc: 'Invalid underlying price'
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
    119:
      id: 'entitlement_not_assigned_for_underlying'
      doc: 'Entitlement not assigned for underlying'
    124:
      id: 'currently_not_tradeable_on_book'
      doc: 'Instrument is currently not tradeable on book'
    125:
      id: 'quantity_limit_exceeded'
      doc: 'Quantity exceeds trader specific limit'
    126:
      id: 'value_limit_exceeded'
      doc: 'Value exceeds trader specific limit'
    127:
      id: 'invalid_quote_spread'
      doc: 'Invalid quote spread'
    128:
      id: 'bookor_cancel'
      doc: 'Book-or-Cancel quote type'
    131:
      id: 'cant_proc_in_curr_instr_state'
      doc: 'Instrument state does not allow processing'
    143:
      id: 'tradingindicationrunningfortrader'
      doc: 'Trading indication running for trader'
    144:
      id: 'on_book_tradingdisabledfor_instrument_type'
      doc: 'On-Book trading disabled for instrument type'
    147:
      id: 'liquidityproviderprotectionbidsidecancelled'
      doc: 'Liquidity provider protection bid side cancelled'
    148:
      id: 'liquidityproviderprotectionasksidecancelled'
      doc: 'Liquidity provider protection ask side cancelled'
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
  appl_seq_indicator:
    0: 'no_recovery_required'
    1: 'recovery_required'
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
    6:
      id: 'gtd'
      doc: 'Good Till Date (GTD) - Standard Orders only'
  ownership_indicator:
    0:
      id: 'no_changeof_ownership'
      doc: 'Do not change ownership'
    1:
      id: 'changeto_executing_trader'
      doc: 'Change ownership to executing party (User ID)'
  crossed_indicator:
    0:
      id: 'nocrossing'
      doc: 'No crossing (Order not subject to crossing)'
    1:
      id: 'crossrejected'
      doc: 'Cross rejected (Order subject to crossing and match prevented)'
  triggered:
    0: 'nottriggered'
    1: 'triggered_stop'
    2: 'triggered_oco'
  trading_session_sub_id:
    4:
      id: 'closingauction'
      doc: 'Closing or closing auction'
  requesting_party_id_executing_system:
    1:
      id: 'eurex_clearing'
      doc: 'Eurex Clearing'
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
  mass_action_sub_type:
    1:
      id: 'bookor_cancel'
      doc: 'Book or cancel'
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
    17:
      id: 'bookor_cancel'
      doc: 'Quote deleted due to Book-or-Cancel quote type'
    18:
      id: 'plp'
      doc: 'Quote deleted due to passive liquidity protection'
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
    10010:
      id: 'create_ci_throttle_exceeded'
      doc: 'Throttle limit for creation of complex instrument exceeded'
    10011:
      id: 'transaction_not_allowed_in_current_state'
      doc: 'Order maintenance not allowed in current state'
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
  md_book_type:
    1:
      id: 'top_of_book'
      doc: 'Top of book'
    2:
      id: 'price_depth'
      doc: 'Price depth (aggregated)'
  md_sub_book_type:
    1:
      id: 'implied'
      doc: 'Implied'
  value_check_type_quantity:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'
  quote_sub_type:
    1:
      id: 'working_delta'
      doc: 'Working Delta'
  quote_status:
    6:
      id: 'removed'
      doc: 'Removed'
    7:
      id: 'expired'
      doc: 'Expired'
    16:
      id: 'active'
      doc: 'Active'
  quote_instruction:
    0:
      id: 'do_not_quote'
      doc: 'Do not re-quote'
    1:
      id: 'quote'
      doc: '(Re-)Quote'
  quote_ref_price_source:
    1:
      id: 'underlying'
      doc: 'Underlying'
    2:
      id: 'custom_underlying_price'
      doc: 'Custom underlying price'
  number_of_resp_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  leaves_qty_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  last_px_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  last_qty_disclosure_instruction:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
  trade_underlying:
    1:
      id: 'no'
      doc: 'No'
    2:
      id: 'yes'
      doc: 'Yes'
  negotiate_underlying:
    0:
      id: 'no'
      doc: 'No'
    1:
      id: 'yes'
      doc: 'Yes'
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
  quote_cancel_type:
    4:
      id: 'cancel_all_quotes'
      doc: 'Cancel All Quotes'
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
    105:
      id: 'instrument_deletion'
      doc: 'Deletion of Instrument'
    106:
      id: 'instrument_suspension'
      doc: 'Suspension of Instrument'
    107:
      id: 'pre_trade_risk_event'
      doc: 'Deletion caused by a pre-trade risk event'
  related_product_complex:
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
  transfer_reason:
    1:
      id: 'owner'
      doc: 'Owner'
    2:
      id: 'clearer'
      doc: 'Clearer'
  multi_leg_reporting_type:
    1:
      id: 'singlesecurity'
      doc: 'Single instrument'
    2:
      id: 'individuallegofamultilegsecurity'
      doc: 'Complex instrument'
  multileg_price_model:
    0:
      id: 'standard'
      doc: 'leg level prices provided by system'
    1:
      id: 'user_defined'
      doc: 'leg level prices provided by user'
  root_party_id_investment_decision_maker_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
  trade_platform:
    0:
      id: 'off_book'
      doc: 'Off-Book'
    1:
      id: 'on_book'
      doc: 'On-Book'
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
    6:
      id: 'outside_bbo'
      doc: 'CLIP matching outside BBO'
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
  order_category:
    0x31:
      id: 'order'
      doc: 'Order'
    0x32:
      id: 'quote'
      doc: 'Quote'
  order_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  skip_validations:
    0:
      id: 'false'
      doc: 'False'
    1:
      id: 'true'
      doc: 'True'

