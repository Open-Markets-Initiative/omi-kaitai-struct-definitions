# ---------------------------------------------------------------------
# Kaitai struct definition for: Eurex T7 Edci Fbe v13.0
#
# Protocol:
#   Organization: Eurex Exchange
#   Protocol: Extended Derivatives Clearing Interface
#   Encoding: Flat Binary Encoding
#   Version: 13.0
#   Date: 10/10/2024
#   Specification: T7_R.13.0_Enhanced_Drop_Copy_Interface_-_Derivatives_Message_Reference_Version_1.pdf
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
  id: eurex_t7_edci_fbe_v13_0
  title: Eurex T7 Edci Fbe v13.0
  license: GPL-3.0
  endian: le

doc: 'Eurex Exchange T7 Extended Derivatives Clearing Interface Fbe v13.0'
doc-ref: https://www.eurex.com/ex-en/technology/t7

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
            'template_id::delete_order_broadcast': delete_order_broadcast
            'template_id::forced_logout_notification': forced_logout_notification
            'template_id::heartbeat': heartbeat
            'template_id::heartbeat_notification': heartbeat_notification
            'template_id::logon_request': logon_request
            'template_id::logon_response': logon_response
            'template_id::logout_request': logout_request
            'template_id::logout_response': logout_response
            'template_id::order_exec_report_broadcast': order_exec_report_broadcast
            'template_id::partition_list_notification': partition_list_notification
            'template_id::reject': reject
            'template_id::session_list_notification': session_list_notification
            'template_id::session_status_broadcast': session_status_broadcast
  message_header:
    seq:
      - id: body_len
        type: u4
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: template_id
        type: u2
        enum: template_id
        doc: 'Nullable, No Value = 0xFFFF'
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
  rbc_header_comp:
    seq:
      - id: sending_time
        type: nanosecond_timestamp_nullable
        doc: 'Nanoseconds since Unix epoch. Nullable, No Value = 0xFFFFFFFFFFFFFFFF'
      - id: party_id_executing_unit
        type: u4_nullable
        doc: 'Nullable, No Value = 0xFFFFFFFF'
      - id: partition_id
        type: u2_nullable
        doc: 'Nullable, No Value = 0xFFFF'
      - id: appl_id
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: last_fragment
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
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
      - id: pad4
        size: 4
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
      - id: pad7
        size: 7
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
      - id: session_mode
        type: u1_nullable
        doc: 'Nullable, No Value = 0xFF'
      - id: party_executing_firm
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
      - id: pad6
        size: 6
  session_status_broadcast:
    seq:
      - id: pad2
        size: 2
      - id: rbc_header_comp
        type: rbc_header_comp
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 0xFFFFFFFF
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
  s4_nullable:
    seq:
      - id: value
        type: s4
    instances:
      is_null:
        value: value == 0x80000000
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 0xFFFFFFFFFFFFFFFF
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
    10902:
      id: 'delete_order_broadcast'
      doc: 'Delete Order Broadcast TemplateId'
    10012:
      id: 'forced_logout_notification'
      doc: 'Forced Logout Notification TemplateId'
    10011:
      id: 'heartbeat'
      doc: 'Heartbeat TemplateId'
    10023:
      id: 'heartbeat_notification'
      doc: 'Heartbeat Notification TemplateId'
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
    10037:
      id: 'partition_list_notification'
      doc: 'Partition List Notification TemplateId'
    10010:
      id: 'reject'
      doc: 'Reject TemplateId'
    10036:
      id: 'session_list_notification'
      doc: 'Session List Notification TemplateId'
    10903:
      id: 'session_status_broadcast'
      doc: 'Session Status Broadcast TemplateId'
  appl_id:
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
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
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
    3:
      id: 'hq'
      doc: 'Persistent and non-persistent orders affected (FIX value ''H Q'')'
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
  crossed_indicator:
    0:
      id: 'nocrossing'
      doc: 'No crossing (Order not subject to crossing)'
    1:
      id: 'crossrejected'
      doc: 'Cross rejected (Order subject to crossing and match prevented)'
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
  session_status:
    0:
      id: 'active'
      doc: 'Session active'
    4:
      id: 'logout'
      doc: 'Session logout complete'
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

