# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Eti Fbe v11.1
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Enhanced Trading Interface
#   Encoding: Flat Binary Encoding
#   Version: 11.1
#   Date: 02/20/2023
#   Specification: T7_Enhanced_Trading_Interface_-_Derivatives_Message_Reference_v.11.1-D0001
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
  id: eurex_t7_eti_fbe_v11_1
  title: Eurex T7 Eti Fbe v11.1
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Enhanced Trading Interface Fbe v11.1'
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
            'template_id::amend_basket_trade_request': amend_basket_trade_request
            'template_id::approve_basket_trade_request': approve_basket_trade_request
            'template_id::approve_reverse_tes_trade_request': approve_reverse_tes_trade_request
            'template_id::approve_tes_trade_request': approve_tes_trade_request
            'template_id::basket_approve_broadcast': basket_approve_broadcast
            'template_id::basket_broadcast': basket_broadcast
            'template_id::basket_delete_broadcast': basket_delete_broadcast
            'template_id::basket_execution_broadcast': basket_execution_broadcast
            'template_id::basket_response': basket_response
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
            'template_id::delete_basket_trade_request': delete_basket_trade_request
            'template_id::delete_clip_request': delete_clip_request
            'template_id::delete_order_broadcast': delete_order_broadcast
            'template_id::delete_order_complex_request': delete_order_complex_request
            'template_id::delete_order_nr_response': delete_order_nr_response
            'template_id::delete_order_response': delete_order_response
            'template_id::delete_order_single_request': delete_order_single_request
            'template_id::delete_tes_trade_request': delete_tes_trade_request
            'template_id::enter_basket_trade_request': enter_basket_trade_request
            'template_id::enter_clip_request': enter_clip_request
            'template_id::enter_tes_trade_request': enter_tes_trade_request
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::forced_user_logout_notification': forced_user_logout_notification
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::inquire_enrichment_rule_id_list_request': inquire_enrichment_rule_id_list_request
            'template_id::inquire_enrichment_rule_id_list_response': inquire_enrichment_rule_id_list_response
            'template_id::inquire_mm_parameter_request': inquire_mm_parameter_request
            'template_id::inquire_mm_parameter_response': inquire_mm_parameter_response
            'template_id::inquire_margin_based_risk_limit_request': inquire_margin_based_risk_limit_request
            'template_id::inquire_margin_based_risk_limit_response': inquire_margin_based_risk_limit_response
            'template_id::inquire_pre_trade_risk_limits_request': inquire_pre_trade_risk_limits_request
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::inquire_session_list_response': inquire_session_list_response
            'template_id::inquire_user_request': inquire_user_request
            'template_id::inquire_user_response': inquire_user_response
            'template_id::legal_notification_broadcast': legal_notification_broadcast
            'template_id::logon_request': logon_request
            'template_id::logon_request_encrypted': logon_request_encrypted
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::mm_parameter_definition_request': mm_parameter_definition_request
            'template_id::mm_parameter_definition_response': mm_parameter_definition_response
            'template_id::mass_quote_request': mass_quote_request
            'template_id::mass_quote_response': mass_quote_response
            'template_id::modify_basket_trade_request': modify_basket_trade_request
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
            'template_id::ping_request': ping_request
            'template_id::ping_response': ping_response
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
            'template_id::reverse_tes_trade_request': reverse_tes_trade_request
            'template_id::risk_notification_broadcast': risk_notification_broadcast
            'template_id::srqs_create_deal_notification': srqs_create_deal_notification
            'template_id::srqs_deal_notification': srqs_deal_notification
            'template_id::srqs_deal_response': srqs_deal_response
            'template_id::srqs_enter_quote_request': srqs_enter_quote_request
            'template_id::srqs_hit_quote_request': srqs_hit_quote_request
            'template_id::srqs_inquire_smart_respondent_request': srqs_inquire_smart_respondent_request
            'template_id::srqs_inquire_smart_respondent_response': srqs_inquire_smart_respondent_response
            'template_id::srqs_negotiation_notification': srqs_negotiation_notification
            'template_id::srqs_negotiation_requester_notification': srqs_negotiation_requester_notification
            'template_id::srqs_negotiation_status_notification': srqs_negotiation_status_notification
            'template_id::srqs_open_negotiation_notification': srqs_open_negotiation_notification
            'template_id::srqs_open_negotiation_request': srqs_open_negotiation_request
            'template_id::srqs_open_negotiation_requester_notification': srqs_open_negotiation_requester_notification
            'template_id::srqs_quote_notification': srqs_quote_notification
            'template_id::srqs_quote_response': srqs_quote_response
            'template_id::srqs_quote_snapshot_notification': srqs_quote_snapshot_notification
            'template_id::srqs_quote_snapshot_request': srqs_quote_snapshot_request
            'template_id::srqs_quoting_status_request': srqs_quoting_status_request
            'template_id::srqs_response': srqs_response
            'template_id::srqs_status_broadcast': srqs_status_broadcast
            'template_id::srqs_update_deal_status_request': srqs_update_deal_status_request
            'template_id::srqs_update_negotiation_request': srqs_update_negotiation_request
            'template_id::service_availability_broadcast': service_availability_broadcast
            'template_id::service_availability_market_broadcast': service_availability_market_broadcast
            'template_id::status_broadcast': status_broadcast
            'template_id::subscribe_request': subscribe_request
            'template_id::subscribe_response': subscribe_response
            'template_id::tes_approve_broadcast': tes_approve_broadcast
            'template_id::tes_broadcast': tes_broadcast
            'template_id::tes_compression_run_status_broadcast': tes_compression_run_status_broadcast
            'template_id::tes_compression_run_status_request': tes_compression_run_status_request
            'template_id::tes_compression_run_status_response': tes_compression_run_status_response
            'template_id::tes_delete_broadcast': tes_delete_broadcast
            'template_id::tes_execution_broadcast': tes_execution_broadcast
            'template_id::tes_response': tes_response
            'template_id::tes_reversal_broadcast': tes_reversal_broadcast
            'template_id::tes_trade_broadcast': tes_trade_broadcast
            'template_id::tes_trading_session_status_broadcast': tes_trading_session_status_broadcast
            'template_id::tes_upload_broadcast': tes_upload_broadcast
            'template_id::tm_trading_session_status_broadcast': tm_trading_session_status_broadcast
            'template_id::throttle_update_notification': throttle_update_notification
            'template_id::trade_broadcast': trade_broadcast
            'template_id::trading_session_status_broadcast': trading_session_status_broadcast
            'template_id::unsubscribe_request': unsubscribe_request
            'template_id::unsubscribe_response': unsubscribe_response
            'template_id::update_remaining_risk_allowance_base_request': update_remaining_risk_allowance_base_request
            'template_id::update_remaining_risk_allowance_base_response': update_remaining_risk_allowance_base_response
            'template_id::upload_tes_trade_request': upload_tes_trade_request
            'template_id::user_login_request': user_login_request
            'template_id::user_login_request_encrypted': user_login_request_encrypted
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: multileg_model
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: sender_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  instrmt_leg_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leg_symbol
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: leg_ratio_qty
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: leg_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: leg_security_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  add_complex_instrument_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: low_limit_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: high_limit_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_update_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_response_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: number_of_securities
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: multileg_model
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: implied_market_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: instrmt_leg_grp_comp
        type: instrmt_leg_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_leg_grp_comp
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
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: contract_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: settl_method
        type: u1
        enum: settl_method
      - id: opt_attribute
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: put_or_call
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exercise_style
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
  add_flexible_instrument_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: security_response_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: strike_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: contract_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: settl_method
        type: u1
        enum: settl_method
      - id: opt_attribute
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: put_or_call
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exercise_style
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  amend_basket_trade_request:
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
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_month_year
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_basket_side_alloc_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_basket_root_party_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_match_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: basket_root_party_grp_comp
        type: basket_root_party_grp_comp
        repeat: expr
        repeat-expr: num_basket_root_party_grp_comp
      - id: instrmt_match_side_grp_comp
        type: instrmt_match_side_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_match_side_grp_comp
      - id: basket_side_alloc_grp_comp
        type: basket_side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_grp_comp
  basket_root_party_grp_comp:
    seq:
      - id: root_party_sub_id_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
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
      - id: basket_side_trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  instrmt_match_side_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: clearing_trade_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: side_trd_sub_typ
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: instrmt_match_side_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: effect_on_basket
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  basket_side_alloc_grp_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: individual_alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_sub_id_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: instrmt_match_side_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
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
      - id: pad4
        size: 4
  approve_basket_trade_request:
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
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: root_party_sub_id_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_basket_side_alloc_ext_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: basket_side_trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
      - id: basket_side_alloc_ext_grp_comp
        type: basket_side_alloc_ext_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_ext_grp_comp
  basket_side_alloc_ext_grp_comp:
    seq:
      - id: alloc_qty
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
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: position_effect
        type: u1
        enum: position_effect
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
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
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  approve_reverse_tes_trade_request:
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: related_market_segment_id
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
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
  basket_approve_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_basket_side_alloc_ext_bc_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: num_basket_root_party_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_entering_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
      - id: basket_root_party_grp_comp
        type: basket_root_party_grp_comp
        repeat: expr
        repeat-expr: num_basket_root_party_grp_comp
      - id: basket_side_alloc_ext_bc_grp_comp
        type: basket_side_alloc_ext_bc_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_ext_bc_grp_comp
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
  basket_side_alloc_ext_bc_grp_comp:
    seq:
      - id: alloc_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_trd_sub_typ
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_sub_id_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: position_effect
        type: u1
        enum: position_effect
      - id: effect_on_basket
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
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
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
  basket_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_month_year
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_basket_side_alloc_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: num_basket_root_party_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_match_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_anonymity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
      - id: basket_root_party_grp_comp
        type: basket_root_party_grp_comp
        repeat: expr
        repeat-expr: num_basket_root_party_grp_comp
      - id: instrmt_match_side_grp_comp
        type: instrmt_match_side_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_match_side_grp_comp
      - id: basket_side_alloc_grp_comp
        type: basket_side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_grp_comp
  basket_delete_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: delete_reason
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
      - id: pad4
        size: 4
  basket_execution_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_basket_exec_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: basket_side_trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
      - id: basket_exec_grp_comp
        type: basket_exec_grp_comp
        repeat: expr
        repeat-expr: num_basket_exec_grp_comp
  basket_exec_grp_comp:
    seq:
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_trd_sub_typ
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad2
        size: 2
  basket_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
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
  clip_deletion_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
  clip_execution_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_me_comp
        type: rbc_header_me_comp
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
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
  instrmnt_leg_exec_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leg_last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: leg_exec_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: leg_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: fill_ref_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
  clip_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: cross_request_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_cross_request_ack_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: implied_check_price_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
      - id: cross_request_ack_side_grp_comp
        type: cross_request_ack_side_grp_comp
        repeat: expr
        repeat-expr: num_cross_request_ack_side_grp_comp
  cross_request_ack_side_grp_comp:
    seq:
      - id: order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: input_source
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
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
      - id: num_affected_order_requests_grp_comp
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
      - id: affected_order_requests_grp_comp
        type: affected_order_requests_grp_comp
        repeat: expr
        repeat-expr: num_affected_order_requests_grp_comp
  not_affected_orders_grp_comp:
    seq:
      - id: not_affected_order_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: not_aff_orig_cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  affected_order_requests_grp_comp:
    seq:
      - id: affected_order_request_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: num_affected_order_requests_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
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
  delete_basket_trade_request:
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
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
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
      - id: pad1
        size: 1
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
      - id: cross_request_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
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
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
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
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2v2
        size: 2
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
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: orig_cl_ord_id
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
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
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
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
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
      - id: pad1
        size: 1
  enter_basket_trade_request:
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_month_year
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_basket_side_alloc_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_basket_root_party_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_match_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_anonymity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
      - id: basket_root_party_grp_comp
        type: basket_root_party_grp_comp
        repeat: expr
        repeat-expr: num_basket_root_party_grp_comp
      - id: instrmt_match_side_grp_comp
        type: instrmt_match_side_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_match_side_grp_comp
      - id: basket_side_alloc_grp_comp
        type: basket_side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_grp_comp
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: cross_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: cross_request_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_cross_request_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_cross_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: side_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_qty_disclosure_instruction
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
      - id: input_source
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: position_effect
        type: u1
        enum: position_effect
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
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
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: related_trade_quantity
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: underlying_settlement_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_attribute_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_underlying_stip_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_settlement_location
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedge_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: swap_clearer
        type: u1_nullable
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
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: individual_alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_enrichment_rule_id
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
      - id: pad4
        size: 4
  trd_instrmnt_leg_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leg_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
  instrument_event_grp_comp:
    seq:
      - id: event_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: event_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
  instrument_attribute_grp_comp:
    seq:
      - id: instr_attrib_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: username
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: user_status
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
  enrichment_rules_grp_comp:
    seq:
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_origination_market
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  inquire_mm_parameter_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: mm_parameter_report_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_mm_parameter_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
      - id: mm_parameter_grp_comp
        type: mm_parameter_grp_comp
        repeat: expr
        repeat-expr: num_mm_parameter_grp_comp
  mm_parameter_grp_comp:
    seq:
      - id: exposure_duration
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: delta
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: vega
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: pct_count
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
  inquire_margin_based_risk_limit_request:
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
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
  inquire_margin_based_risk_limit_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: margin_based_risk_limit_long
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: margin_based_risk_limit_short
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: risk_limit_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
  logon_request_encrypted:
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
      - id: pad7
        size: 7
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
      - id: latest_public_key_seq_no
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: len_public_key
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
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
      - id: public_key
        type: str
        size: len_public_key
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: delta
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: vega
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pct_count
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
  mm_parameter_definition_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: exec_id
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: pad6
        size: 6
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
      - id: cxl_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_entry_reject_reason
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_entry_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2
        size: 2
  modify_basket_trade_request:
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
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: maturity_month_year
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_basket_side_alloc_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_basket_root_party_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrmt_match_side_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: basket_trade_report_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: basket_root_party_grp_comp
        type: basket_root_party_grp_comp
        repeat: expr
        repeat-expr: num_basket_root_party_grp_comp
      - id: instrmt_match_side_grp_comp
        type: instrmt_match_side_grp_comp
        repeat: expr
        repeat-expr: num_instrmt_match_side_grp_comp
      - id: basket_side_alloc_grp_comp
        type: basket_side_alloc_grp_comp
        repeat: expr
        repeat-expr: num_basket_side_alloc_grp_comp
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
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
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
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ownership_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
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
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: num_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
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
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
  order_event_grp_comp:
    seq:
      - id: order_event_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_event_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: order_event_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: order_event_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad3
        size: 3
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
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cum_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
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
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
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
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
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
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: swap_clearer
        type: u1_nullable
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
      - id: pad1
        size: 1
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
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
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
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
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: num_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad4
        size: 4
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_seq_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_value
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
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
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: cxl_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: trd_reg_ts_entry_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_time_priority
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_inst_cross_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
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
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
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
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad4
        size: 4
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
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
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: party_id_entering_firm
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
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
        doc: 'Nullable, No Value = 0xFF'
      - id: num_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
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
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_instrmnt_leg_exec_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: exec_restatement_reason
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_status
        type: u1
        enum: ord_status
      - id: exec_type
        type: u1
        enum: exec_type
      - id: triggered
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: crossed_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transaction_delay_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_fills_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
      - id: fills_grp_comp
        type: fills_grp_comp
        repeat: expr
        repeat-expr: num_fills_grp_comp
      - id: instrmnt_leg_exec_grp_comp
        type: instrmnt_leg_exec_grp_comp
        repeat: expr
        repeat-expr: num_instrmnt_leg_exec_grp_comp
      - id: order_event_grp_comp
        type: order_event_grp_comp
        repeat: expr
        repeat-expr: num_order_event_grp_comp
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
  ping_request:
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
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
  ping_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
  pre_trade_risk_limit_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: risk_limit_report_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_risk_limits_rpt_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_detail_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: risk_limit_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: risk_limit_open_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: risk_limit_net_position_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: netting_coefficient
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_weighting_coefficient
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: activation_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: risk_limit_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: risk_limit_requesting_party_role
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: risk_limit_violation_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: risk_limit_group
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: netting_coefficient
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_weighting_coefficient
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: risk_limit_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_risk_limit_qty_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_detail_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: risk_limit_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
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
      - id: mass_action_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: mass_action_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: mass_action_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad4
        size: 4
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
      - id: num_quote_leg_exec_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_quote_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
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
  quote_leg_exec_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leg_last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: leg_exec_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: leg_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: no_quote_events_index
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
  reverse_tes_trade_request:
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: reversal_reason_text
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
      - id: pad5
        size: 5
  srqs_create_deal_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: expire_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_effective_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_price_stip_value
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: orig_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_order_book_item_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedging_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_srqs_target_party_trd_grp_comp
        type: u1
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
      - id: root_party_entering_trader
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
      - id: order_book_item_grp_comp
        type: order_book_item_grp_comp
        repeat: expr
        repeat-expr: num_order_book_item_grp_comp
      - id: srqs_target_party_trd_grp_comp
        type: srqs_target_party_trd_grp_comp
        repeat: expr
        repeat-expr: num_srqs_target_party_trd_grp_comp
  order_book_item_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: best_bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: best_bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: best_offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: best_offer_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: md_book_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: md_sub_book_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  srqs_target_party_trd_grp_comp:
    seq:
      - id: side_last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: pad3
        size: 3
  srqs_deal_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_price_stip_value
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: requesting_party_sub_id_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_request_result
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_srqs_target_party_trd_grp_comp
        type: u1
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
      - id: root_party_entering_trader
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: srqs_target_party_trd_grp_comp
        type: srqs_target_party_trd_grp_comp
        repeat: expr
        repeat-expr: num_srqs_target_party_trd_grp_comp
  srqs_deal_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: secondary_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_srqs_quote_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
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
      - id: pad3
        size: 3
      - id: srqs_quote_grp_comp
        type: srqs_quote_grp_comp
        repeat: expr
        repeat-expr: num_srqs_quote_grp_comp
  srqs_quote_grp_comp:
    seq:
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: offer_size
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
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: valid_until_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
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
      - id: valid_until_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_price_stip_value
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedging_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_srqs_hit_quote_grp_comp
        type: u1
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_end_client_identification
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
      - id: srqs_hit_quote_grp_comp
        type: srqs_hit_quote_grp_comp
        repeat: expr
        repeat-expr: num_srqs_hit_quote_grp_comp
  srqs_hit_quote_grp_comp:
    seq:
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad7
        size: 7
  srqs_inquire_smart_respondent_request:
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: eurex_volume_ranking
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: enlight_rfq_avg_resp_time_ranking
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: enlight_rfq_avg_resp_rate_ranking
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_to_quote_ratio_ranking
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
  srqs_inquire_smart_respondent_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: num_smart_party_detail_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad2v2
        size: 2
      - id: smart_party_detail_grp_comp
        type: smart_party_detail_grp_comp
        repeat: expr
        repeat-expr: num_smart_party_detail_grp_comp
  smart_party_detail_grp_comp:
    seq:
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: party_detail_executing_trader
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: pad5
        size: 5
  srqs_negotiation_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: effective_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_update_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_to_quote_ratio
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: number_of_respondents
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_to_quote_ratio_position
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad4
        size: 4
  srqs_negotiation_requester_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trd_reg_ts_execution_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: effective_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: last_update_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_to_request_ratio
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: number_of_respondents
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: respondent_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_target_parties_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: number_of_resp_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: show_last_deal_on_closure
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
      - id: target_parties_comp
        type: target_parties_comp
        repeat: expr
        repeat-expr: num_target_parties_comp
  target_parties_comp:
    seq:
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: leaves_qty_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_px_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_qty_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: free_text_5_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_order_origination_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: charge_id_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: party_detail_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_detail_status_information
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
  srqs_negotiation_status_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: effective_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_condition
        type: u1
        enum: quote_condition
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
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: negotiation_start_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: leaves_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: expire_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_to_request_ratio
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: trade_to_quote_ratio
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: number_of_respondents
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_to_quote_ratio_position
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_quot_req_legs_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: respondent_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad2v2
        size: 2
      - id: quot_req_legs_grp_comp
        type: quot_req_legs_grp_comp
        repeat: expr
        repeat-expr: num_quot_req_legs_grp_comp
  quot_req_legs_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_ratio_qty
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: leg_symbol
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: leg_security_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: leg_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: valid_until_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_quot_req_legs_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_target_parties_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: number_of_resp_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: respondent_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: show_last_deal_on_closure
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: bid_px_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: offer_px_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_qty_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
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
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: expire_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: trade_to_request_ratio
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: number_of_respondents
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_quot_req_legs_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_target_parties_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: number_of_resp_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: respondent_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: show_last_deal_on_closure
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: bid_px_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: offer_px_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_qty_is_locked
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
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
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: secondary_quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: expire_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quoting_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_cancel_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
      - id: party_id_executing_trader
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
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_beneficiary
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
      - id: party_id_order_origination_firm
        type: str
        size: 7
        encoding: ASCII
        pad-right: 0x20
      - id: party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
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
      - id: party_id_take_up_trading_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
  srqs_quote_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quote_req_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
  srqs_quote_snapshot_notification:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: num_srqs_quote_entry_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: pad6
        size: 6
      - id: srqs_quote_entry_grp_comp
        type: srqs_quote_entry_grp_comp
        repeat: expr
        repeat-expr: num_srqs_quote_entry_grp_comp
  srqs_quote_entry_grp_comp:
    seq:
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: expire_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: secondary_quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: quote_ref_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quoting_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: pad2
        size: 2
  srqs_quote_snapshot_request:
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
  srqs_quoting_status_request:
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
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: quoting_status
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
      - id: free_text_5
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
  srqs_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
  srqs_status_broadcast:
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
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trd_rpt_status
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
      - id: free_text_5
        type: str
        size: 132
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
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: underlying_delta_percentage
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: bid_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: num_target_parties_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: number_of_resp_disclosure_instruction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: show_last_deal_on_closure
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_sub_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: respondent_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: party_order_origination_trader
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: charge_id
        type: str
        size: 132
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
  service_availability_market_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: nrbc_header_comp
        type: nrbc_header_comp
      - id: selective_request_for_quote_service_trade_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: selective_request_for_quote_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: selective_request_for_quote_rtm_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: news_rtm_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: risk_control_rtm_service_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: related_trade_quantity
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: underlying_settlement_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_enrichment_rule_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: auto_approval_rule_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_settlement_location
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedge_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_attribute_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_underlying_stip_grp_comp
        type: u1
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
        type: u1
        enum: cust_order_handling_inst
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
      - id: pad3
        size: 3
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
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: related_trade_quantity
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_settlement_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: auto_approval_rule_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: len_var_text
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_attribute_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_underlying_stip_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_bc_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_clearing_price_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_settlement_location
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedge_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: swap_clearer
        type: u1_nullable
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
      - id: trd_clearing_price_leg_grp_comp
        type: trd_clearing_price_leg_grp_comp
        repeat: expr
        repeat-expr: num_trd_clearing_price_leg_grp_comp
      - id: instrument_attribute_grp_comp
        type: instrument_attribute_grp_comp
        repeat: expr
        repeat-expr: num_instrument_attribute_grp_comp
      - id: underlying_stip_grp_comp
        type: underlying_stip_grp_comp
        repeat: expr
        repeat-expr: num_underlying_stip_grp_comp
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
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: reversal_approval_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: individual_alloc_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_enrichment_rule_id
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
      - id: pad3
        size: 3
  trd_clearing_price_leg_grp_comp:
    seq:
      - id: leg_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: leg_clearing_trade_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
  tes_compression_run_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: compression_action
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compression_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
  tes_compression_run_status_request:
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
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: compression_action
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2v2
        size: 2
  tes_compression_run_status_response:
    seq:
      - id: pad2
        size: 2
      - id: response_header_comp
        type: response_header_comp
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: compression_action
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: compression_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
  tes_delete_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: trd_rpt_status
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
      - id: pad2v2
        size: 2
  tes_execution_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
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
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: message_event_source
        type: u1
        enum: message_event_source
      - id: pad2v2
        size: 2
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
  tes_reversal_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
      - id: reversal_initiation_time
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
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: reversal_cancellation_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_grp_bc_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: reversal_reason_text
        type: str
        size: 132
        encoding: ASCII
        pad-right: 0x20
      - id: pad3
        size: 3
      - id: side_alloc_grp_bc_comp
        type: side_alloc_grp_bc_comp
        repeat: expr
        repeat-expr: num_side_alloc_grp_bc_comp
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
      - id: clearing_trade_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: clearing_trade_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: related_security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: root_party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: root_party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: basket_trd_match_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: side_last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: side_last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
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
      - id: strategy_link_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_symbol
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: tot_num_trade_reports
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: negotiation_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: srqs_related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: basket_profile_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: related_product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: multi_leg_reporting_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: position_effect
        type: u1
        enum: position_effect
      - id: multileg_price_model
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: root_party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: reversal_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_aggregation_trans_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
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
      - id: basket_party_contra_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: basket_side_trade_report_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: fee_idnt_code
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
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
  tes_upload_broadcast:
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
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: transact_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: related_trade_quantity
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: package_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tes_exec_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_settlement_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_ext_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_attribute_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_underlying_stip_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: hedge_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_settlement_location
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: swap_clearer
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
  side_alloc_ext_grp_comp:
    seq:
      - id: alloc_qty
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
      - id: pad1
        size: 1
      - id: tes_enrichment_rule_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_alloc_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: position_effect
        type: u1
        enum: position_effect
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: executing_trader_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_investment_decision_maker_qualifier
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u1
        enum: cust_order_handling_inst
      - id: compliance_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: pad1v1
        size: 1
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
      - id: related_security_id
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
      - id: side_last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: side_last_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: clearing_trade_price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: clearing_trade_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
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
      - id: root_party_id_client_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: executing_trader
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: root_party_id_investment_decision_maker
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
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
      - id: root_party_id_clearing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: related_symbol
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: side_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: match_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: trd_match_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: strategy_link_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: tot_num_trade_reports
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: security_sub_type
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: multi_leg_reporting_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: transfer_reason
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_origination
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_liquidity_provision
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_attribute_risk_reduction
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
      - id: root_party_id_position_account
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: u1
        enum: position_effect
      - id: cust_order_handling_inst
        type: u1
        enum: cust_order_handling_inst
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
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: related_product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: order_side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: root_party_id_execution_venue
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
      - id: fee_idnt_code
        type: str
        size: 15
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
  update_remaining_risk_allowance_base_request:
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
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: num_rra_update_base_party_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad4
        size: 4
      - id: rra_update_base_party_grp_comp
        type: rra_update_base_party_grp_comp
        repeat: expr
        repeat-expr: num_rra_update_base_party_grp_comp
  rra_update_base_party_grp_comp:
    seq:
      - id: remaining_risk_allowance_base_long
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: remaining_risk_allowance_base_short
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: risk_limit_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad7
        size: 7
  update_remaining_risk_allowance_base_response:
    seq:
      - id: pad2
        size: 2
      - id: nr_response_header_me_comp
        type: nr_response_header_me_comp
      - id: num_rra_update_base_party_ack_grp_comp
        type: u2
        doc: 'Nullable, No Value = 0xFFFF'
      - id: pad6
        size: 6
      - id: rra_update_base_party_ack_grp_comp
        type: rra_update_base_party_ack_grp_comp
        repeat: expr
        repeat-expr: num_rra_update_base_party_ack_grp_comp
  rra_update_base_party_ack_grp_comp:
    seq:
      - id: party_detail_executing_unit
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad1
        size: 1
      - id: risk_limit_result
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
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
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: last_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: trans_bkd_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: related_close_price
        type: decimal_u8_6_nullable
        doc: 'Implied decimal with scale 1e-6. Nullable, No Value = 0x8000000000000000'
      - id: related_trade_quantity
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: underlying_qty
        type: decimal_u8_4_nullable
        doc: 'Implied decimal with scale 1e-4. Nullable, No Value = 0x8000000000000000'
      - id: compression_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: underlying_settlement_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: underlying_maturity_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_trade_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: related_market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: trd_type
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_report_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_publish_indicator
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_side_alloc_ext_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_trd_instrmnt_leg_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_event_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_instrument_attribute_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: num_underlying_stip_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: skip_validations
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trd_rpt_status
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trade_platform
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: hedge_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_settlement_location
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: value_check_type_min_lot_size
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: swap_clearer
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad4
        size: 4
  user_login_request_encrypted:
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
      - id: encrypted_password
        type: str
        size: 684
        encoding: ASCII
        pad-right: 0x20
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
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0x80000000
  u1_nullable:
    seq:
      - id: value
        type: u1
    instances:
      is_null:
        value: value == 0xFF
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
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0xFFFFFFFFFFFFFFFF
  u2_nullable:
    seq:
      - id: value
        type: u2
    instances:
      is_null:
        value: value == 0xFFFF
  decimal_u8_6:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_u8_6_nullable:
    seq:
      - id: value
        type: decimal_u8_6
    instances:
      is_null:
        value: value.mantissa == 0x8000000000000000
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
    10629:
      id: 'amend_basket_trade_request'
      doc: 'Amend Basket Trade Request TemplateId'
    10623:
      id: 'approve_basket_trade_request'
      doc: 'Approve Basket Trade Request TemplateId'
    10631:
      id: 'approve_reverse_tes_trade_request'
      doc: 'Approve Reverse Tes Trade Request TemplateId'
    10603:
      id: 'approve_tes_trade_request'
      doc: 'Approve Tes Trade Request TemplateId'
    10627:
      id: 'basket_approve_broadcast'
      doc: 'Basket Approve Broadcast TemplateId'
    10625:
      id: 'basket_broadcast'
      doc: 'Basket Broadcast TemplateId'
    10626:
      id: 'basket_delete_broadcast'
      doc: 'Basket Delete Broadcast TemplateId'
    10628:
      id: 'basket_execution_broadcast'
      doc: 'Basket Execution Broadcast TemplateId'
    10624:
      id: 'basket_response'
      doc: 'Basket Response TemplateId'
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
    10622:
      id: 'delete_basket_trade_request'
      doc: 'Delete Basket Trade Request TemplateId'
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
    10620:
      id: 'enter_basket_trade_request'
      doc: 'Enter Basket Trade Request TemplateId'
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
    10323:
      id: 'inquire_margin_based_risk_limit_request'
      doc: 'Inquire Margin Based Risk Limit Request TemplateId'
    10324:
      id: 'inquire_margin_based_risk_limit_response'
      doc: 'Inquire Margin Based Risk Limit Response TemplateId'
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
    10621:
      id: 'modify_basket_trade_request'
      doc: 'Modify Basket Trade Request TemplateId'
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
    10630:
      id: 'reverse_tes_trade_request'
      doc: 'Reverse Tes Trade Request TemplateId'
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
    10718:
      id: 'srqs_inquire_smart_respondent_request'
      doc: 'Srqs Inquire Smart Respondent Request TemplateId'
    10719:
      id: 'srqs_inquire_smart_respondent_response'
      doc: 'Srqs Inquire Smart Respondent Response TemplateId'
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
    10723:
      id: 'srqs_quote_snapshot_notification'
      doc: 'Srqs Quote Snapshot Notification TemplateId'
    10720:
      id: 'srqs_quote_snapshot_request'
      doc: 'Srqs Quote Snapshot Request TemplateId'
    10717:
      id: 'srqs_quoting_status_request'
      doc: 'Srqs Quoting Status Request TemplateId'
    10722:
      id: 'srqs_response'
      doc: 'Srqs Response TemplateId'
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
    10618:
      id: 'tes_compression_run_status_broadcast'
      doc: 'Tes Compression Run Status Broadcast TemplateId'
    10616:
      id: 'tes_compression_run_status_request'
      doc: 'Tes Compression Run Status Request TemplateId'
    10617:
      id: 'tes_compression_run_status_response'
      doc: 'Tes Compression Run Status Response TemplateId'
    10606:
      id: 'tes_delete_broadcast'
      doc: 'Tes Delete Broadcast TemplateId'
    10610:
      id: 'tes_execution_broadcast'
      doc: 'Tes Execution Broadcast TemplateId'
    10611:
      id: 'tes_response'
      doc: 'Tes Response TemplateId'
    10632:
      id: 'tes_reversal_broadcast'
      doc: 'Tes Reversal Broadcast TemplateId'
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
    10325:
      id: 'update_remaining_risk_allowance_base_request'
      doc: 'Update Remaining Risk Allowance Base Request TemplateId'
    10326:
      id: 'update_remaining_risk_allowance_base_response'
      doc: 'Update Remaining Risk Allowance Base Response TemplateId'
    10612:
      id: 'upload_tes_trade_request'
      doc: 'Upload Tes Trade Request TemplateId'
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
    11:
      id: 'commoditystrip'
      doc: 'Commodity Strip'
  multileg_model:
    0:
      id: 'predefined_multileg_security'
      doc: 'Predefined Multileg Security'
    1:
      id: 'userdefined_multleg'
      doc: 'User-defined Multleg Security'
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
    50:
      id: 'compression'
      doc: 'Compression'
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
    1006:
      id: 'enlight'
      doc: 'Eurex/Xetra Enlight triggered trade'
    1007:
      id: 'blockqtpip'
      doc: 'QTPIP BLOCK TRADE'
    1010:
      id: 'btrf'
      doc: 'Basket of Equity Total Return Futures'
    1011:
      id: 'ebb'
      doc: 'Equity Bespoke Baskets'
  trade_report_type:
    0:
      id: 'submit'
      doc: 'Submit'
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
  basket_trade_report_type:
    0:
      id: 'submit'
      doc: 'Submit'
    4:
      id: 'addendum'
      doc: 'Addendum'
    5:
      id: 'no_was_substitue'
      doc: 'No/Was (Substitute)'
  root_party_sub_id_type:
    4001:
      id: 'buyer'
      doc: 'Buyer'
    4002:
      id: 'seller'
      doc: 'Seller'
    4003:
      id: 'broker'
      doc: 'Broker'
  side_trd_sub_typ:
    2001:
      id: 'block_trade'
      doc: 'Block Trade'
    2004:
      id: 'tradeat_market'
      doc: 'Trade at Market'
  trade_publish_indicator:
    0: 'do_not_publish_trade'
    1: 'publish_trade'
    2:
      id: 'deferred_publication'
      doc: 'Deferred publication to market'
    3:
      id: 'published'
      doc: 'Published to market'
  effect_on_basket:
    1:
      id: 'add_volume'
      doc: 'Add volume'
    2:
      id: 'remove_volume'
      doc: 'Remove volume'
  party_sub_id_type:
    14001:
      id: 'buyer'
      doc: 'Buyer'
    14002:
      id: 'seller'
      doc: 'Seller'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
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
    6:
      id: 'pending_execution'
      doc: 'Pending Execution'
    7:
      id: 'pending_reversal'
      doc: 'Pending Reversal'
    8:
      id: 'approved_reversal'
      doc: 'Side Approved Reversal'
    9:
      id: 'reversed'
      doc: 'Reversed'
    10:
      id: 'cancelled_reversal'
      doc: 'Cancelled Reversal'
  position_effect:
    0x43:
      id: 'close'
      doc: 'Close'
    0x4f:
      id: 'open'
      doc: 'Open'
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
  order_attribute_liquidity_provision:
    1:
      id: 'y'
      doc: 'Liquidity provision'
    0:
      id: 'n'
      doc: 'No liquidity provision'
  executing_trader_qualifier:
    22:
      id: 'algo'
      doc: 'Algo'
    24:
      id: 'human'
      doc: 'Human/Natural person'
  party_id_investment_decision_maker_qualifier:
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
  order_origination:
    5:
      id: 'directaccessorsponsoredaccesscustomer'
      doc: 'Order received from a direct access customer'
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
  appl_resend_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
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
  party_id_entering_firm:
    1:
      id: 'participant'
      doc: 'Participant'
    2:
      id: 'market_supervision'
      doc: 'Market Supervision'
  basket_anonymity:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
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
    108:
      id: 'amendment_reset'
      doc: 'Basket amendment cancelled'
    109:
      id: 'amendment_user_cancelled'
      doc: 'Amendment cancelled by user action'
    110:
      id: 'compression_cancelled_by_user'
      doc: 'Compression cancelled by service provider'
    111:
      id: 'compression_cancelled_by_system'
      doc: 'Compression cancelled by system'
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
    212:
      id: 'boc_order_cancelled'
      doc: 'Book or Cancel Order accepted'
    261:
      id: 'panic_cancel'
      doc: 'Panic Cancel'
    302:
      id: 'market_order_uncrossing'
      doc: 'Market Order uncrossing'
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
  implied_check_price_indicator:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  input_source:
    1:
      id: 'client_broker'
      doc: 'Client Broker'
    2:
      id: 'proprietary_broker'
      doc: 'Proprietary Broker'
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
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  price_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  order_qty_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
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
  swap_clearer:
    0:
      id: 'ecag'
      doc: 'Eurex Clearing'
    1:
      id: 'nonecag'
      doc: 'Non-Eurex Clearing'
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
    2:
      id: 'rejected'
      doc: 'Rejected'
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
    5:
      id: 'disaster_recovery'
      doc: 'Disaster Recovery'
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
    134:
      id: 'invalid_quote_type'
      doc: 'Invalid quote type'
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
    155:
      id: 'outside_quoting_period'
      doc: 'Quote entry outside quoting period not allowed'
    156:
      id: 'match_price_not_on_price_step'
      doc: 'Match price resulting from entry of the matching quote is not a valid price step'
    161:
      id: 'quantity_limit_exceeds_tsl'
      doc: 'Quantity exceeds transaction size limit'
    163:
      id: 'too_many_ordersand_quotesin_order_book'
      doc: 'Too many orders and quotes in order book'
    166:
      id: 'contractcannotbetradedduetoinsufficienteligibility'
      doc: 'Contract cannot be traded due to insufficient eligibility'
    167:
      id: 'underlying_price_timeout'
      doc: 'the VF underlying price timed out, rejection of quote'
    168:
      id: 'bu_suspend_arp_level_3_soft_breach'
      doc: 'the BU is suspended due to an ARP level 3 soft breach'
    169:
      id: 'no_clearing_product_assignment'
      doc: 'incoming quote pair rejected due to no clearing product assignment'
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
      doc: 'Good Till Cancelled (GTC) - Standard Orders only'
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
  order_event_reason:
    100:
      id: 'smp'
      doc: 'SMP event'
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
      id: 'delete_field'
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
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
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
    10010:
      id: 'create_ci_throttle_exceeded'
      doc: 'Throttle limit for creation of complex instrument exceeded'
    10011:
      id: 'transaction_not_allowed_in_current_state'
      doc: 'Order maintenance not allowed in current state'
    10013:
      id: 'required_min_lot_size_not_reached'
      doc: 'Required min lot size not reached'
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
    5:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
    7:
      id: 'terminated'
      doc: 'Terminated'
    9:
      id: 'deemed_verified'
      doc: 'Deemed verified'
  hedging_instruction:
    1:
      id: 'on_close'
      doc: 'Execute hedge transaction in the closing auction of the underlying'
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
    2:
      id: 'volume_weighted_average'
      doc: 'Volume Weighted Average'
  requesting_party_sub_id_type:
    5000:
      id: 'requester'
      doc: 'Requester'
    5001:
      id: 'responder'
      doc: 'Responder'
    5002:
      id: 'both'
      doc: 'Both (Requester and Responder)'
    5003:
      id: 'system'
      doc: 'System'
  trade_request_result:
    100:
      id: 'cancelpending'
      doc: 'Deal cancellation pending'
    101:
      id: 'canceldeclined'
      doc: 'Deal cancellation declined'
    102:
      id: 'cancelapproved'
      doc: 'Deal cancellation approved'
  eurex_volume_ranking:
    1:
      id: 'low'
      doc: 'Low'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'high'
      doc: 'High'
  enlight_rfq_avg_resp_time_ranking:
    1:
      id: 'low'
      doc: 'Low'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'high'
      doc: 'High'
  enlight_rfq_avg_resp_rate_ranking:
    1:
      id: 'low'
      doc: 'Low'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'high'
      doc: 'High'
  trade_to_quote_ratio_ranking:
    1:
      id: 'low'
      doc: 'Low'
    2:
      id: 'medium'
      doc: 'Medium'
    3:
      id: 'high'
      doc: 'High'
  quote_sub_type:
    1:
      id: 'working_delta'
      doc: 'Working Delta'
    2:
      id: 'basis_trade'
      doc: 'Basis Trade'
    3:
      id: 'regular'
      doc: 'Regular LDS Negotiation'
    4:
      id: 'negotiate_underlying_outside_exchange'
      doc: 'Negotiate the underlying outside the exchange'
    5:
      id: 'vola_strategy_fix'
      doc: 'Option Volatility Strategy with fixed Underlying price and delta'
    6:
      id: 'vola_strategy_negotiate_underlying'
      doc: 'Option Volatility Strategy - Underlying price is negotiated on exchange'
  quote_instruction:
    0:
      id: 'do_not_quote'
      doc: 'Do not re-quote'
    1:
      id: 'quote'
      doc: '(Re-)Quote'
  trade_aggregation_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
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
  respondent_type:
    1:
      id: 'all_market_participants'
      doc: 'Respondents are known during a negotiation'
    102:
      id: 'anonymous'
      doc: 'Respondents are anonymized after negotiation start, Requester will remain anonymous from start'
  number_of_resp_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  show_last_deal_on_closure:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  leaves_qty_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  last_px_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  last_qty_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  free_text_5_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  party_order_origination_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  charge_id_disclosure_instruction:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  party_detail_status_information:
    1:
      id: 'trrthresholdtoobig'
      doc: 'High TRR (TradeToRequestRatio) threshold'
    2:
      id: 'blockallanonymous'
      doc: 'Anonymous negotiation blocked by responder'
  bid_px_is_locked:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  offer_px_is_locked:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  side_is_locked:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  order_qty_is_locked:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
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
  quote_cancel_reason:
    5:
      id: 'expired'
      doc: 'Expired'
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
  compression_action:
    1:
      id: 'start_compression'
      doc: 'Start Compression'
    2:
      id: 'commit_compression'
      doc: 'Commit Compression'
    3:
      id: 'cancel_compression'
      doc: 'Cancel Compression'
  compression_status:
    1:
      id: 'open'
      doc: 'Open'
    2:
      id: 'executed'
      doc: 'Executed'
    3:
      id: 'cancelled_by_user'
      doc: 'Cancelled by service provider'
    4:
      id: 'cancelled_by_system'
      doc: 'Cancelled by System'
  reversal_cancellation_reason:
    1:
      id: 'tas_change'
      doc: 'TES Activity State Change'
    2:
      id: 'intraday_expiration'
      doc: 'Instrument Expiration'
    3:
      id: 'instrument_deletion'
      doc: 'Instrument Deletion'
    4:
      id: 'instrument_suspension'
      doc: 'Instrument Suspension'
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
    11:
      id: 'commoditystrip'
      doc: 'Commodity Strip'
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
  reversal_indicator:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
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
  risk_limit_result:
    10580:
      id: 'disabled_for_bu'
      doc: 'Margin Based Risk Limits not enabled for business unit'
    10581:
      id: 'low_rra_event_id'
      doc: 'Received Remaining Risk Allowance event ID is lower than lowest entry in Temporary Transaction List'
    10582:
      id: 'high_rra_event_id'
      doc: 'Received Remaining Risk Allowance event ID exceeds last entry in Temporary Transaction List'
  skip_validations:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  value_check_type_min_lot_size:
    0:
      id: 'donotcheck'
      doc: 'Do not check'
    1:
      id: 'check'
      doc: 'Check'

