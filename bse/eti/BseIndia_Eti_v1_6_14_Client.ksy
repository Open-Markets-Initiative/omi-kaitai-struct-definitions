# ---------------------------------------------------------------------
# Kaitai struct definition for: Bse BseIndia Eti Fbe v1.6.14
#
# Protocol:
#   Organization: BSE Limited
#   Protocol: Enhanced Trading Interface
#   Encoding: Flat Binary Encoding
#   Version: 1.6.14
#   Date: 3/30/2026
#   Specification: BSE_ETI_Manual_V1.6.14.pdf
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
  id: bse_bseindia_eti_fbe_v1_6_14_client
  title: Bse BseIndia Eti Fbe v1.6.14
  license: GPL-3.0
  endian: le

doc: 'BSE Limited BSE India Enhanced Trading Interface Fbe v1.6.14'
doc-ref: https://www.bseindia.com/nta

seq:
  - id: client_message
    type: client_message_struct
    repeat: eos
    doc: 'Bse Eti Message sent by the participant to Bse'

types:
  client_message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Bse Eti message header'
      - id: client_payload
        size: message_header.body_len - 6
        type:
          switch-on: message_header.template_id
          cases:
            'template_id::debt_inquiry_request': debt_inquiry_request
            'template_id::delete_all_order_request': delete_all_order_request
            'template_id::delete_all_quote_request': delete_all_quote_request
            'template_id::delete_order_complex_request': delete_order_complex_request
            'template_id::delete_order_single_request': delete_order_single_request
            'template_id::gateway_request': gateway_request
            'template_id::heartbeat': heartbeat
            'template_id::inquire_session_list_request': inquire_session_list_request
            'template_id::logon_request': logon_request
            'template_id::logout_request': logout_request
            'template_id::mass_quote_request': mass_quote_request
            'template_id::modify_order_complex_request': modify_order_complex_request
            'template_id::modify_order_single_request': modify_order_single_request
            'template_id::modify_order_single_short_request': modify_order_single_short_request
            'template_id::multi_leg_order_request': multi_leg_order_request
            'template_id::new_order_complex_request': new_order_complex_request
            'template_id::new_order_single_request': new_order_single_request
            'template_id::new_order_single_short_request': new_order_single_short_request
            'template_id::retransmit_me_message_request': retransmit_me_message_request
            'template_id::retransmit_request': retransmit_request
            'template_id::session_password_change_request': session_password_change_request
            'template_id::session_registration_request': session_registration_request
            'template_id::subscribe_request': subscribe_request
            'template_id::unsubscribe_request': unsubscribe_request
            'template_id::user_login_request': user_login_request
            'template_id::user_logout_request': user_logout_request
            'template_id::user_password_change_request': user_password_change_request
  message_header:
    seq:
      - id: body_len
        type: u4
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Nullable, No Value = 0xFFFF'
  debt_inquiry_request:
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
      - id: underlying_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: yield_field
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
  request_header_comp:
    seq:
      - id: msg_seq_num
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: sender_sub_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_executing_trader
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
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
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: pad4
        size: 4
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
      - id: filler1
        size: 8
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
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
      - id: filler1
        size: 8
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: pad4
        size: 4
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
      - id: default_cstm_appl_ver_id
        type: str
        size: 30
        encoding: ASCII
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: pad6
        size: 6
  heartbeat:
    seq:
      - id: network_msg_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
      - id: pad2
        size: 2
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
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: quote_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: enrichment_rule_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: quote_size_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: stpc_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: num_quote_entry_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: pad1
        size: 1
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
      - id: offer_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: bid_size
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: offer_size
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: pad4
        size: 4
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
      - id: max_price_percentage
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: activity_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: filler1
        size: 8
      - id: filler2
        size: 4
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler4
        size: 2
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
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: rollover_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: delta_qty_flag
        type: str
        size: 1
        encoding: ASCII
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: regulatory_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: num_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad2v2
        size: 2
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
        type: str
        size: 1
        encoding: ASCII
      - id: pad5
        size: 5
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
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: max_price_percentage
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: activity_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: filler1
        size: 8
      - id: filler2
        size: 4
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: target_party_id_session_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler4
        size: 2
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
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: rollover_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: delta_qty_flag
        type: str
        size: 1
        encoding: ASCII
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: str
        size: 1
        encoding: ASCII
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: regulatory_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: free_text_3
        type: str
        size: 12
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
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: activity_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler2
        size: 4
      - id: filler4
        size: 2
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: pad1
        size: 1
  multi_leg_order_request:
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
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: all_or_none_flag
        type: u1
        enum: all_or_none_flag
      - id: num_multi_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: pad5
        size: 5
      - id: multi_leg_ord_grp_comp
        type: multi_leg_ord_grp_comp
        repeat: expr
        repeat-expr: num_multi_leg_ord_grp_comp
  multi_leg_ord_grp_comp:
    seq:
      - id: security_id
        type: s8_nullable
        doc: 'Nullable, No Value = 0x8000000000000000'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: max_price_percentage
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: product_complex
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: ord_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: pad1
        size: 1
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
      - id: max_price_percentage
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: price
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: filler1
        size: 8
      - id: filler2
        size: 4
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler4
        size: 2
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
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: stpc_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: rollover_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: regulatory_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
      - id: num_leg_ord_grp_comp
        type: u1
        doc: 'Nullable, No Value = 0xFF'
      - id: pad6
        size: 6
      - id: leg_ord_grp_comp
        type: leg_ord_grp_comp
        repeat: expr
        repeat-expr: num_leg_ord_grp_comp
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
      - id: stop_px
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: max_price_percentage
        type: decimal_u8_8_nullable
        doc: 'Implied decimal with scale 1e-8. Nullable, No Value = 0x8000000000000000'
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: filler1
        size: 8
      - id: filler2
        size: 4
      - id: message_tag
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: expire_date
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: market_segment_id
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: regulatory_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler4
        size: 2
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
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: stpc_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: rollover_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_session_sub_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: trading_capacity
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: account
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: position_effect
        type: str
        size: 1
        encoding: ASCII
      - id: party_id_location_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: cust_order_handling_inst
        type: str
        size: 1
        encoding: ASCII
      - id: regulatory_text
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
      - id: free_text_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
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
      - id: sender_location_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: cl_ord_id
        type: u8_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: order_qty
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: max_show
        type: s4_nullable
        doc: 'Nullable, No Value = 0x80000000'
      - id: simple_security_id
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: filler2
        size: 4
      - id: filler4
        size: 2
      - id: account_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: side
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: price_validity_check_type
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: time_in_force
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: stpc_flag
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: exec_inst
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: algo_id
        type: str
        size: 16
        encoding: ASCII
      - id: client_code
        type: str
        size: 12
        encoding: ASCII
      - id: cp_code
        type: str
        size: 12
        encoding: ASCII
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
      - id: subscription_scope
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
  session_password_change_request:
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
      - id: password
        type: str
        size: 32
        encoding: ASCII
      - id: new_password
        type: str
        size: 32
        encoding: ASCII
      - id: pad4
        size: 4
  session_registration_request:
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
      - id: pad4
        size: 4
      - id: filler1
        size: 8
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
  user_password_change_request:
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
      - id: new_password
        type: str
        size: 32
        encoding: ASCII
      - id: pad4
        size: 4
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
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
  s8_nullable:
    seq:
      - id: value
        type: s8
    instances:
      is_null:
        value: value == -9223372036854775808
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == -2147483648
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
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

enums:
  template_id:
    10032:
      id: 'broadcast_error_notification'
      doc: 'Broadcast Error Notification TemplateId'
    10390:
      id: 'debt_inquiry_request'
      doc: 'Debt Inquiry Request TemplateId'
    10391:
      id: 'debt_inquiry_response'
      doc: 'Debt Inquiry Response TemplateId'
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
    10012:
      id: 'forced_logout_notification'
      doc: 'Forced Logout Notification TemplateId'
    10020:
      id: 'gateway_request'
      doc: 'Gateway Request TemplateId'
    10022:
      id: 'gateway_response'
      doc: 'Gateway Response TemplateId'
    10990:
      id: 'gw_order_acknowledgement'
      doc: 'Gw Order Acknowledgement TemplateId'
    10011:
      id: 'heartbeat'
      doc: 'Heartbeat TemplateId'
    10023:
      id: 'heartbeat_notification'
      doc: 'Heartbeat Notification TemplateId'
    10035:
      id: 'inquire_session_list_request'
      doc: 'Inquire Session List Request TemplateId'
    10036:
      id: 'inquire_session_list_response'
      doc: 'Inquire Session List Response TemplateId'
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
    10114:
      id: 'modify_order_complex_request'
      doc: 'Modify Order Complex Request TemplateId'
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
    10994:
      id: 'multi_leg_exec_report_broadcast'
      doc: 'Multi Leg Exec Report Broadcast TemplateId'
    10993:
      id: 'multi_leg_exec_response'
      doc: 'Multi Leg Exec Response TemplateId'
    10992:
      id: 'multi_leg_order_reject'
      doc: 'Multi Leg Order Reject TemplateId'
    10991:
      id: 'multi_leg_order_request'
      doc: 'Multi Leg Order Request TemplateId'
    10113:
      id: 'new_order_complex_request'
      doc: 'New Order Complex Request TemplateId'
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
    10412:
      id: 'quote_exec_report_broadcast'
      doc: 'Quote Exec Report Broadcast TemplateId'
    10407:
      id: 'quote_execution_report'
      doc: 'Quote Execution Report TemplateId'
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
    10048:
      id: 'risk_collateral_alert_admin_broadcast'
      doc: 'Risk Collateral Alert Admin Broadcast TemplateId'
    10049:
      id: 'risk_collateral_alert_broadcast'
      doc: 'Risk Collateral Alert Broadcast TemplateId'
    10033:
      id: 'risk_notification_broadcast'
      doc: 'Risk Notification Broadcast TemplateId'
    10030:
      id: 'service_availability_broadcast'
      doc: 'Service Availability Broadcast TemplateId'
    10997:
      id: 'session_password_change_request'
      doc: 'Session Password Change Request TemplateId'
    10995:
      id: 'session_password_change_response'
      doc: 'Session Password Change Response TemplateId'
    10053:
      id: 'session_registration_request'
      doc: 'Session Registration Request TemplateId'
    10054:
      id: 'session_registration_response'
      doc: 'Session Registration Response TemplateId'
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
    10989:
      id: 'trade_enhancement_broadcast'
      doc: 'Trade Enhancement Broadcast TemplateId'
    10307:
      id: 'trading_session_status_broadcast'
      doc: 'Trading Session Status Broadcast TemplateId'
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
    10996:
      id: 'user_password_change_request'
      doc: 'User Password Change Request TemplateId'
    10043:
      id: 'user_password_change_response'
      doc: 'User Password Change Response TemplateId'
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
  account_type:
    20:
      id: 'own'
      doc: 'Own'
    30:
      id: 'client'
      doc: 'Client'
  price_validity_check_type:
    0:
      id: 'none'
      doc: 'None'
  quote_size_type:
    1:
      id: 'total_size'
      doc: 'Total Size (Quote Modification)'
    2:
      id: 'open_size'
      doc: 'Open Size(Quote Entry)'
  stpc_flag:
    0:
      id: 'passive'
      doc: 'Passive'
    1:
      id: 'active'
      doc: 'Active'
  appl_seq_indicator:
    0:
      id: 'no_recovery_required'
      doc: 'Lean Order'
    1:
      id: 'recovery_required'
      doc: 'Standard (non lean) Order'
  product_complex:
    1:
      id: 'simpleinstrument'
      doc: 'Simple Instrument'
    2:
      id: 'standardoptionstrategy'
      doc: 'Standard Option Strategy'
    5:
      id: 'futures_spread'
      doc: 'Futures Spread'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'recall'
      doc: 'Recall'
    4:
      id: 'earlyreturn'
      doc: 'Early return'
  ord_type:
    2:
      id: 'limit'
      doc: 'Limit'
    3:
      id: 'stop'
      doc: 'Stop Market'
    4:
      id: 'stop_limit'
      doc: 'Stop Limit'
    5:
      id: 'marketto_limit'
      doc: 'Market'
    6:
      id: 'block_deal'
      doc: 'Block Deal'
    7:
      id: 'quote'
      doc: 'Quote'
  exec_inst:
    1:
      id: 'h'
      doc: 'Persistent Order (FIX value ''H'')'
    2:
      id: 'q'
      doc: 'Non-persistent Order (FIX value ''Q'')'
    3:
      id: 'hq'
      doc: 'Persistent and non-persistent Orders (FIX value ''H Q'')'
    5:
      id: 'h_6'
      doc: 'Persistent and Book or Cancel Order (FIX value ''H 6'')'
    6:
      id: 'q_6'
      doc: 'Non-persistent and Book or Cancel Order (FIX value ''Q 6'')'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day (GFD)'
    3:
      id: 'ioc'
      doc: 'Immediate or Cancel (IOC)'
    7:
      id: 'gtcl'
      doc: 'Session (GFS)'
  all_or_none_flag:
    0x59:
      id: 'use_all_or_none'
      doc: 'Full Execution Only'
    0x4e:
      id: 'use_all_or_none_not'
      doc: 'Full or Partial Execution'
  ref_appl_id:
    0:
      id: 'trade_enhancement'
      doc: 'Trade Enhancement Data'
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
    8:
      id: 'risk_admin'
      doc: 'Risk Admin'
  appl_id_status:
    105:
      id: 'outboundconversionerror'
      doc: 'Outbound Conversion Error'
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
    0:
      id: 'trade_enhancement'
      doc: 'Trade Enhancement Data'
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
    8:
      id: 'risk_admin'
      doc: 'Risk Admin'
  appl_resend_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
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
      doc: 'No Special Reason'
    1:
      id: 'stop_trading'
      doc: 'Stop Trading'
    2:
      id: 'emergency'
      doc: 'Emergency'
    3:
      id: 'market_maker_protection'
      doc: 'Market Maker Parameters'
    4:
      id: 'stop_button_activated'
      doc: 'Stop Button Activated'
    5:
      id: 'bussiness_unit_suspended'
      doc: 'Business Unit Suspended'
    6:
      id: 'session_loss'
      doc: 'Session Loss'
    7:
      id: 'collateral_rrm'
      doc: 'RRM: Collateral'
    8:
      id: 'price_band_shrink'
      doc: 'Price Band Shrink'
    9:
      id: 'orders_worse_than_close_price'
      doc: 'Orders Worse Than Close Price'
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
      id: 'producttemporarilynottradable'
      doc: 'Product Temporarily Not Tradable'
    114:
      id: 'product_state_closing'
      doc: 'Product State Closing'
    115:
      id: 'product_state_eod'
      doc: 'Product State EOD'
    116:
      id: 'coolingoff'
      doc: 'RRM : Regulatory'
    117:
      id: 'mwplrrm'
      doc: 'RRM : MWPL'
  exec_restatement_reason:
    001:
      id: 'order_book_restatement'
      doc: 'Order Book Restatement'
    101:
      id: 'order_added'
      doc: 'Order Added'
    102:
      id: 'order_modified'
      doc: 'Order Replaced'
    103:
      id: 'order_cancelled'
      doc: 'Order Cancelled'
    105:
      id: 'ioc_order_cancelled'
      doc: 'IOC Order Cancelled'
    108:
      id: 'book_order_executed'
      doc: 'Book Order Executed'
    135:
      id: 'market_order_triggered'
      doc: 'Market Order Triggered'
    164:
      id: 'oco_order_triggered'
      doc: 'One-cancels-the-other Order has been triggered'
    172:
      id: 'stop_order_triggered'
      doc: 'Stop Order Triggered'
    197:
      id: 'order_cancellation_pending'
      doc: 'Order Cancellation Pending'
    199:
      id: 'pending_cancellation_executed'
      doc: 'Pending Cancellation Executed'
    212:
      id: 'boc_order_cancelled'
      doc: 'BOC Order Cancelled'
    213:
      id: 'pending_normal_orders_queried'
      doc: 'Pending Normal orders downloaded'
    214:
      id: 'pending_stoploss_orders_queried'
      doc: 'Pending Stoploss orders downloaded'
    215:
      id: 'rrm_order_added'
      doc: 'RRM Order Added'
    216:
      id: 'rrm_order_accepted'
      doc: 'RRM Order Accepted'
    219:
      id: 'rrm_order_deleted'
      doc: 'RRM Order Deleted'
    220:
      id: 'rrm_market_order_triggered'
      doc: 'RRM Market Order Triggered'
    221:
      id: 'prov_order_added'
      doc: 'Provisional Order Added'
    222:
      id: 'prov_order_accepted'
      doc: 'Provisional Order Accepted'
    223:
      id: 'prov_order_updation_rejected'
      doc: 'Provisional Order Updation Rejected'
    224:
      id: 'prov_order_updated_successfully'
      doc: 'Provisional Order Updated Successfully'
    225:
      id: 'prov_order_deleted'
      doc: 'Provisional Order Deleted'
    226:
      id: 'prov_market_order_triggered'
      doc: 'Provisional Market Order Triggered'
    231:
      id: 'callauc_order_deleted'
      doc: 'CALLAUC Order Deleted'
    232:
      id: 'gtcl_order_deleted'
      doc: 'Order Cancelled: Session Expiry'
    233:
      id: 'eod_order_deleted'
      doc: 'Order Cancelled: Day Expiry'
    234:
      id: 'halt_order_deleted'
      doc: 'Order Cancelled: Halt'
    235:
      id: 'block_deal_order_timed_out'
      doc: 'Block Deal Order Timed Out'
    236:
      id: 'out_of_price_band_order'
      doc: 'Out Of Price Band Order'
    237:
      id: 'order_worse_than_close_price'
      doc: 'Order Worse Than Close Price'
    238:
      id: 'auction_market_order_triggered'
      doc: 'Market order triggered in call auction/pcas sessions'
    239:
      id: 'pending_blockdeal_orders_queried'
      doc: 'Pending Block Deal orders downloaded'
    240:
      id: 'bu_suspended'
      doc: 'Orders cancelled due to BU is suspended'
    241:
      id: 'cooling_off_rrm_order_deleted'
      doc: 'Orders cancelled due to Cooling off RRM'
    242:
      id: 'mwpl_rrm_order_deleted'
      doc: 'Orders cancelled due to MWPL RRM'
    243:
      id: 'call_auction_uncross_order_deleted'
      doc: 'Order Cancelled : SPOS Price undetermined'
    244:
      id: 'collateral_rrm'
      doc: 'Order cancelled due to Collateral RRM'
    245:
      id: 'pending_market_orders_queried'
      doc: 'Pending Market2Limit orders downloaded'
    246:
      id: 'self_trade_order_deleted'
      doc: 'Self Trade Order Deleted'
    247:
      id: 'reverse_trade_order_deleted'
      doc: 'Reverse Trade Order Deleted'
    248:
      id: 'pending_oco_orders_queried'
      doc: 'Pending OCO orders downloaded'
    250:
      id: 'client_rrm_for_product'
      doc: 'Client RRM For Product'
    251:
      id: 'client_suspended'
      doc: 'Orders cancelled due to Client Suspension'
    252:
      id: 'client_rrm_for_contract'
      doc: 'Client RRM For Contract'
    253:
      id: 'member_rrm_for_contract'
      doc: 'Member RRM For Contract'
    265:
      id: 'market_order_out_of_range'
      doc: 'Market Order Out Of Range'
    267:
      id: 'limit_price_out_of_range'
      doc: 'Limit Price Out Of Range'
    270:
      id: 'matching_criteria_not_fulfilled'
      doc: 'Matching Criteria Not Fulfilled'
    269:
      id: 'price_level_quantity_exceeded'
      doc: 'Price Level Quantity Exceeded'
    271:
      id: 'client_debarred'
      doc: 'Intraday Debarred'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x31:
      id: 'partiallyfilled'
      doc: 'Partially Filled'
    0x32:
      id: 'filled'
      doc: 'Filled'
    0x34:
      id: 'canceled'
      doc: 'Cancelled'
    0x36:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
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
      doc: 'Pending Cancel'
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
    0x4d:
      id: 'rrm_accept'
      doc: 'RRM Order Accept'
    0x4e:
      id: 'rrm_reject'
      doc: 'RRM Order Reject'
    0x58:
      id: 'prov_accept'
      doc: 'Provisional Accept'
    0x59:
      id: 'prov_reject'
      doc: 'Provisional Order Reject'
  session_mode:
    1:
      id: 'hf'
      doc: 'HF'
    2:
      id: 'lf'
      doc: 'LF'
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
      doc: 'Invalid underlying leg price'
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
    131:
      id: 'cant_proc_in_curr_instr_state'
      doc: 'Instrument state does not allow processing'
    132:
      id: 'location_id_not_set'
      doc: 'Location id is not set'
    133:
      id: 'client_code_not_set'
      doc: 'Client code is not set'
    134:
      id: 'client_cannot_be_modified'
      doc: 'Client code cannot be modified'
    135:
      id: 'client_type_not_set'
      doc: 'Client type not set'
    136:
      id: 'invalid_client_code_for_client_type_own'
      doc: 'Invalid value in client code for client type own'
    137:
      id: 'own_client_type_not_allowed'
      doc: 'Own client type orders are not allowed for 4L/6L instrument id'
    138:
      id: 'message_tag_not_set'
      doc: 'Message tag not set'
    139:
      id: 'price_beyond_circuit_limit'
      doc: 'Price beyond circuit limit'
    140:
      id: 'quantity_not_a_multiple_of_lot_size'
      doc: 'Quantity not a multiple of lot size'
    141:
      id: 'quotes_not_allowed_in_rrm'
      doc: 'Quotes not allowed in RRM'
    142:
      id: 'amount_exceeds_tvl'
      doc: 'Amount exceeds TVL'
    143:
      id: 'quotes_not_allowed_in_auction'
      doc: 'Quotes not allowed in auction'
    144:
      id: 'client_code_debarred'
      doc: 'Client code debarred'
    145:
      id: 'price_not_multiple_of_tick_size'
      doc: 'Price not a multiple of tick size'
    146:
      id: 'quotes_not_allowed_in_post_closing'
      doc: 'Quotes not allowed in post closing'
    147:
      id: 'participant_code_cannot_be_modified'
      doc: 'Participant code cannot be modified'
    148:
      id: 'client_type_cannot_be_modified'
      doc: 'Client type cannot be modified'
    149:
      id: 'quoting_not_allowed'
      doc: 'Quoting not allowed'
    150:
      id: 'invalid_participant_code'
      doc: 'Invalid participant code'
    151:
      id: 'price_band_not_set'
      doc: 'Price band not set'
    152:
      id: 'tick_size_notset'
      doc: 'Tick size not set'
    153:
      id: 'client_type_not_allowed'
      doc: 'Client type not allowed'
    154:
      id: 'invalid_value'
      doc: 'Value less than 5000'
    155:
      id: 'client_code_not_allowed_to_trade_in_trading_restriction_window_pit'
      doc: 'Client Code not allowed to trade in Trading Restriction Window- PIT'
    156:
      id: 'deactivatedvide_seb_icirdtd_290722'
      doc: 'Deactivated vide SEBI cir dtd 29-07-22'
    157:
      id: 'bid_price_not_in_lpp_range'
      doc: 'Bid price not in LPP range'
    158:
      id: 'ask_price_not_in_lpp_range'
      doc: 'Ask price not in LPP range'
    159:
      id: 'price_level_quantity_exceeded'
      doc: 'Price Level Quantity Exceeded'
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
  leg_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  session_reject_reason:
    1:
      id: 'required_tag_missing'
      doc: 'Required Tag Missing'
    5:
      id: 'valueisincorrect'
      doc: 'Value Is Incorrect'
    7:
      id: 'decryptionproblem'
      doc: 'Decryption Problem'
    11:
      id: 'invalid_msg_id'
      doc: 'Invalid Msg ID'
    16:
      id: 'incorrect_num_in_groupcount'
      doc: 'Incorrect Num In Group Count'
    99:
      id: 'other'
      doc: 'Other'
    100:
      id: 'throttle_limit_exceeded'
      doc: 'Throttle Limit Exceeded'
    101:
      id: 'exposure_limit_exceeded'
      doc: 'Exposure Limit Exceeded'
    102:
      id: 'service_temporarily_not_available'
      doc: 'Service Temporarily Not Available'
    103:
      id: 'service_not_available'
      doc: 'Service Not Available'
    104:
      id: 'result_of_transaction_unknown'
      doc: 'Result Of Transaction Unknown'
    105:
      id: 'outboundconversionerror'
      doc: 'Outbound Conversion Error'
    152:
      id: 'heartbeat_violation'
      doc: 'Heartbeat Violation'
    200:
      id: 'internaltechnicalerror'
      doc: 'Internal Technical Error'
    210:
      id: 'validation_error'
      doc: 'Validation Error'
    211:
      id: 'user_already_logged_in'
      doc: 'User Already Logged In'
    10000:
      id: 'order_not_found'
      doc: 'Order Not Found'
    10001:
      id: 'price_not_reasonable'
      doc: 'Price Not Reasonable'
    10002:
      id: 'client_order_id_not_unique'
      doc: 'Client Order ID Not Unique'
    10004:
      id: 'bu_book_order_limit_exceeded'
      doc: 'BU Book Order Limit Exceeded'
    10005:
      id: 'session_book_order_limit_exceeded'
      doc: 'Session Book Order Limit Exceeded'
    10006:
      id: 'activity_timestamp_not_matched'
      doc: 'Activity Timestamp Not Matched.'
    10008:
      id: 'price_not_in_lpp_range'
      doc: 'Price is out of LPP range.'
  triggered:
    0:
      id: 'nottriggered'
      doc: 'Not Triggered'
    1:
      id: 'triggered_stop'
      doc: 'Triggered Stop Order'
    2:
      id: 'triggered_oco'
      doc: 'Triggered OCO'
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
  quote_event_type:
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
  quote_event_reason:
    14: 'pendingcancellationexecuted'
    15: 'invalidprice'
    16: 'selftradequotedeleted'
    17: 'reversetradequotedeleted'
    18: 'client_rrm_quotedeleted'
    20: 'price_level_quantity_exceeded'
    21: 'client_debarred'
  market_id:
    1:
      id: 'xeur'
      doc: 'BSE'
    2:
      id: 'xeee'
      doc: 'XEEE'
  rrm_state:
    0:
      id: 'no_rrm'
      doc: 'No RRM'
    1:
      id: 'in_rrm'
      doc: 'In RRM'
    2:
      id: 'out_of_rrm'
      doc: 'Out Of RRM'
  member_type:
    1: 'trading_member'
    2: 'clearing_member'
    3: 'proprietary'
  increment_decrement_status:
    1: 'increment'
    0: 'no_change'
  segment_indicator:
    1:
      id: 'cash'
      doc: 'CASH'
    2:
      id: 'equity'
      doc: 'Equity'
    3:
      id: 'repo'
      doc: 'REPO'
    4:
      id: 'slb'
      doc: 'SLB'
    5:
      id: 'sauc'
      doc: 'SAUC'
    6:
      id: 'debt'
      doc: 'DEBT'
    7:
      id: 'currency_derivatives'
      doc: 'Currency Derivatives (Full Segment)'
    8:
      id: 'currency_asset_class'
      doc: 'Currency Asset Class(CDX)'
    9:
      id: 'interest_rate_asset_class'
      doc: 'Interest Rate Asset Class(IRD)'
    10:
      id: 'inx'
      doc: 'INX'
    11:
      id: 'equity_derivatives'
      doc: 'Equity Derivatives'
    12:
      id: 'derivatives'
      doc: 'Derivatives'
    13:
      id: 'eurex'
      doc: 'EUREX'
    14:
      id: 'eex'
      doc: 'EEX'
    15:
      id: 'commodity_derivatives'
      doc: 'Commodity Derivatives'
    16:
      id: 'electronic_gold_receipts'
      doc: 'Electronic Gold Receipts (EGR)'
  duration:
    1:
      id: 'near'
      doc: 'NEAR'
    2:
      id: 'mid'
      doc: 'MID'
    3:
      id: 'far'
      doc: 'FAR'
  requesting_party_id_executing_system:
    1:
      id: 'eurex_clearing'
      doc: 'BSE Risk'
  risk_mode_status:
    1:
      id: 'in_field'
      doc: 'IN'
    2:
      id: 'out_field'
      doc: 'OUT'
  list_update_action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
  risk_limit_action:
    4:
      id: 'warning'
      doc: 'Warning'
    0:
      id: 'queue_inbound'
      doc: 'Queue Inbound'
    2:
      id: 'reject'
      doc: 'Reject'
  scope_identifier:
    1:
      id: 'membersuspension'
      doc: 'MEMBER SUSPENSION'
    2:
      id: 'positionlimitsuspension'
      doc: 'POSITION LIMIT SUSPENSION'
    3:
      id: 'collateralsuspension'
      doc: 'COLLATERAL_SUSPENSION'
    4:
      id: 'coolingoffsuspension'
      doc: 'COOLINGOFF_SUSPENSION'
    5:
      id: 'positionlimitrrm'
      doc: 'POSITION LIMIT RRM'
    6:
      id: 'market'
      doc: 'MARKET'
    7:
      id: 'coolingoffrrm'
      doc: 'COOLINGOFF RRM'
    8:
      id: 'collateralrrm'
      doc: 'COLLATERAL RRM'
    9:
      id: 'positionlimitrrmnear'
      doc: 'POSITION LIMIT RRM(NEAR MONTH CONTRACT)'
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
  status:
    0x4e:
      id: 'reject'
      doc: 'Reject'
    0x59:
      id: 'accept'
      doc: 'Accept'
  trad_ses_event:
    101:
      id: 'startof_service'
      doc: 'Start Of Service'
    102:
      id: 'market_reset'
      doc: 'Market Reset'
    103:
      id: 'endof_restatement'
      doc: 'End Of Restatement'
    104:
      id: 'endof_day_service'
      doc: 'End Of Day Service'
  multi_leg_reporting_type:
    1:
      id: 'singlesecurity'
      doc: 'Single Order'
    2:
      id: 'individuallegofamultilegsecurity'
      doc: 'Individual Leg of a Complex Order'
  transfer_reason:
    1:
      id: 'owner'
      doc: 'Owner'
    2:
      id: 'clearer'
      doc: 'Clearer'
  match_type:
    4:
      id: 'automatchincoming'
      doc: 'Auto Match Incoming'
    7:
      id: 'call_auction'
      doc: 'Call Auction'
    11:
      id: 'automatchresting'
      doc: 'Auto Match Resting'
  match_sub_type:
    1:
      id: 'opening_auction'
      doc: 'Opening Auction'
    3:
      id: 'intraday_auction'
      doc: 'Intraday Auction'
  aggressor_indicator:
    0:
      id: 'passive'
      doc: 'Passive'
    1:
      id: 'agressor'
      doc: 'Aggressive'
  order_category:
    0x31:
      id: 'order'
      doc: 'Order'
    0x32:
      id: 'quote'
      doc: 'Quote'
    0x33:
      id: 'multi_leg_order'
      doc: 'Multi Leg Order'
  related_product_complex:
    2:
      id: 'standardoptionstrategy'
      doc: 'Standard Option Strategy'
    5:
      id: 'futures_spread'
      doc: 'Futures Spread'
  order_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
    3:
      id: 'recall'
      doc: 'Recall'
    4:
      id: 'earlyreturn'
      doc: 'Early return'
  auto_accept_indicator:
    0x59:
      id: 'accepted'
      doc: 'Accepted'
    0x4e:
      id: 'rejected'
      doc: 'Rejected'

