# ---------------------------------------------------------------------
# Kaitai struct definition for: Taifex TaifexDerivatives ClearingMember Tmp v2.18.7
#
# Protocol:
#   Organization: Taiwan Futures Exchange
#   Protocol: Clearing Member Order And Execution Report
#   Encoding: Taifex Message Protocol
#   Version: 2.18.7
#   Date: 08/18/2025
#   Specification: Taifex_TCPIP_TMP_v2.18.7.pdf
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
  id: taifex_taifexderivatives_clearingmember_tmp_v2_18_7
  title: Taifex TaifexDerivatives ClearingMember Tmp v2.18.7
  license: GPL-3.0
  endian: be

doc: 'Taiwan Futures Exchange Taifex Derivatives Clearing Member Order And Execution Report Tmp v2.18.7'

seq:
  - id: hdr
    type: hdr_struct
    doc: 'Tmp Common message header, carried by every Tmp message'
  - id: payload
    size: hdr.msg_length - 15
    type:
      switch-on: hdr.message_type
      cases:
        'message_type::wake_up_call_message': wake_up_call_message
        'message_type::wake_up_call_confirmed_message': wake_up_call_confirmed_message
        'message_type::logon_notice_message': logon_notice_message
        'message_type::final_sequential_number_notification_for_group_message': final_sequential_number_notification_for_group_message
        'message_type::request_logon_message': request_logon_message
        'message_type::activate_application_system_message': activate_application_system_message
        'message_type::activate_application_system_confirmed_message': activate_application_system_confirmed_message
        'message_type::logout_confirmed_message': logout_confirmed_message
        'message_type::confirm_connection_message': confirm_connection_message
        'message_type::connection_confirmed_message': connection_confirmed_message
        'message_type::order_status_report_message': order_status_report_message
        'message_type::order_status_report_long_format_message': order_status_report_long_format_message
        'message_type::execution_report_including_head_office_and_branch_offices_message': execution_report_including_head_office_and_branch_offices_message
        'message_type::flex_order_status_report_message': flex_order_status_report_message
        'message_type::clearing_member_initiate_operation_message': clearing_member_initiate_operation_message
        'message_type::clearing_member_initiate_operation_confirmed_message': clearing_member_initiate_operation_confirmed_message
        'message_type::flex_clearing_member_initiate_operation_message': flex_clearing_member_initiate_operation_message
        'message_type::flex_clearing_member_initiate_operation_confirmed_message': flex_clearing_member_initiate_operation_confirmed_message
  - id: message_tail
    type: message_tail_struct
    doc: 'Tmp Message Tail, carrying the check sum of a message'

types:
  hdr_struct:
    seq:
      - id: msg_length
        type: u2
        doc: 'Message length, the total number of bytes behind the msg_length field up to before the CheckSum field'
      - id: msg_seq_num
        type: u4
        doc: 'Message sequence number, assigned to each new order, cancel or change order message as a unique identification code and entered as zero on the messages that carry none'
      - id: header_time
        type: header_time
        doc: 'Message time, the Tmp time format of section 2.1 carried by the common message header. Milliseconds since Unix epoch'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Message code, which section 2.1 names by a letter and a number, L for a Link Subsystem message and R for a Trading Subsystem message'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: session_id
        type: u2
        doc: 'Tcp connection session number, connection to the trading system being allowed only if fcm_id and session_id are provided together'
  header_time:
    seq:
      - id: header_epoch_s
        type: second_timestamp
        doc: 'Seconds since the epoch, the number of seconds from 1970/01/01 0:0 UTC. Seconds since Unix epoch'
      - id: header_ms
        type: millisecond_timestamp
        doc: 'One thousandth of a second, the millisecond fraction of the second carried beside it. Milliseconds since Second epoch'
  wake_up_call_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: start_in_bound_num
        type: u4
        doc: 'Order message start No, assigned zero'
  wake_up_call_confirmed_message:
    seq:
      - id: version
        type: u1
        enum: version
        doc: 'Version, indicating the message version, with 1 denoting the use of the new FLEX message'
  logon_notice_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: append_no
        type: u2
        doc: 'Appended check value, a three-digit random number the futures commission merchant is asked to include in its logon message for the calculation of KEY-VALUE'
      - id: end_out_bound_num
        type: u4
        doc: 'The last end message No, the number of the last valid response message Taifex sent the futures commission merchant'
      - id: system_type
        type: u1
        enum: system_type
        doc: 'System type, naming the market and the trading session'
      - id: encrypt_method
        type: u1
        enum: encrypt_method
        doc: 'Encryption method, 0 if unencrypted'
  final_sequential_number_notification_for_group_message:
    seq:
      - id: sub_hdr
        type: sub_hdr
        doc: 'Tmp Expanded Message Header, which assigns different functionalities to a MessageType by defining additional subcategories for it'
      - id: status_code_uint_162
        type: u2
        enum: status_code_uint_162
        doc: 'Status code, referring to the Error Message Table'
      - id: part_id
        type: u1
        enum: part_id
        doc: 'Partition ID, referring to Section 3.6'
      - id: end_out_bound_num
        type: u4
        doc: 'The last end message No, the number of the last valid response message Taifex sent the futures commission merchant'
      - id: reserved_8
        size: 8
        doc: 'Reserved'
  sub_hdr:
    seq:
      - id: msg_type_ext
        type: u1
        enum: msg_type_ext
        doc: 'Expanded MessageType, by which additional subcategories of a MessageType assign different functionalities based on each specific definition'
      - id: preserve
        type: u1
        doc: 'Preserve, whose default is 0'
      - id: msg_time_ns
        type: nanosecond_offset
        doc: 'Nanosecond-level timing details for the msg_time field in the hdr, of which currently only data at the microsecond level is available. Nanoseconds since Second epoch'
  request_logon_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: append_no
        type: u2
        doc: 'Appended check value, a three-digit random number the futures commission merchant is asked to include in its logon message for the calculation of KEY-VALUE'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: session_id
        type: u2
        doc: 'Tcp connection session number, connection to the trading system being allowed only if fcm_id and session_id are provided together'
      - id: system_type
        type: u1
        enum: system_type
        doc: 'System type, naming the market and the trading session'
      - id: ap_code
        type: u1
        enum: ap_code
        doc: 'Application system code, naming the line the session joins'
      - id: key_value
        type: u1
        doc: 'Key value, the two-digit number at the thousandth and hundredth place of append_no multiplied by the password the futures commission merchant set on line application'
      - id: request_start_seq
        type: u4
        doc: 'The start message No this time, entered as 0 for the Clearing member order and execution report Line and the TMPDC Session'
      - id: cancel_order_sec
        type: u1
        doc: 'Reject order second on an order line, and the reply data per second in units of 100 on a TMPCM or TMPDC session'
  activate_application_system_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: heart_bt_int
        type: u1
        doc: 'Seconds in synchronization, whose default is 30'
      - id: max_flow_ctrl_cnt
        type: u2
        doc: 'Maximum flow per second, informing the futures commission merchant of the limit of input per second in this session'
  activate_application_system_confirmed_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
  logout_confirmed_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
  confirm_connection_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
  connection_confirmed_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
  order_status_report_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: cm_id
        type: u2
        doc: 'Clearing member ID, read from the FCM ID Mapping File P06'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: order_no
        type: str
        size: 5
        encoding: ASCII
        doc: 'Order No, whose five characters may all be alphanumeric'
      - id: ord_id
        type: u4
        doc: 'Order serial No, a number of at most seven digits'
      - id: user_define
        type: str
        size: 8
        encoding: ASCII
        doc: 'FCM defined variable, which the trading system updates in the order status when it adds, cancels or changes an order'
      - id: symbol_type
        type: u1
        enum: symbol_type
        doc: 'Product ID format, 1 for a numeric and 2 for a text product ID'
      - id: sym_symbol_x
        type:
          switch-on: symbol_type
          cases:
            'symbol_type::numeric_product_id': symbol_num
            'symbol_type::text_product_id': symbol_text
      - id: price
        type: s4
        doc: 'Order price, an integer whose number of decimal digits is the Decimal_Locator of the product definition file'
      - id: qty
        type: u2
        doc: 'Order quantity'
      - id: investor_acno
        type: u4
        doc: 'Investor account No'
      - id: investor_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Investor ID code'
      - id: side
        type: u1
        enum: side
        doc: 'Buy/sell code'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Order condition'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'Open/offset code'
      - id: last_px
        type: s4
        doc: 'Last execution price, which is the last execution price for an execution report and 0 for a cancel, decrease or modify price order'
      - id: last_qty
        type: u2
        doc: 'Last quantity executed, which is the last execution quantity for an execution report and 0 for a cancel, decrease or modify price order'
      - id: px_subtotal
        type: s8
        doc: 'Cumulative weighted execution price, which divided by CumQty is the average price per contract'
      - id: cum_qty
        type: u2
        doc: 'Total quantity executed'
      - id: leaves_qty
        type: u2
        doc: 'Remaining quantity'
      - id: before_qty
        type: u2
        doc: 'Remaining order quantity before match'
      - id: leg_side_uint_822
        type: u1
        enum: leg_side_uint_822
        doc: 'Buy/sell code for both legs, where 0 in the first element means a single order'
      - id: leg_px
        type: s4
        doc: 'Execution price for both legs'
      - id: leg_qty_uint_1624
        type: u2
        doc: 'Quantity executed for both legs'
      - id: org_trans_time_msg_time
        type: org_trans_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: transact_time_msg_time
        type: transact_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: uniq_id
        type: u4
        doc: 'Unique ID, a system unique No assigned to the order reply of each order'
      - id: rpt_seq
        type: u4
        doc: 'Report sequence No'
      - id: protocol_type
        type: u1
        enum: protocol_type
        doc: 'Source of new order data, distinguishing the protocol the order was placed over'
  symbol_num:
    seq:
      - id: pseq_1
        type: u2
        doc: 'First leg product ID, whose minimum value is 1'
      - id: pseq_2
        type: u2
        doc: 'Second leg product ID, where 0 means a single order'
      - id: leg_side_uint_822
        type: u1
        enum: leg_side_uint_822
        doc: 'Buy/sell code for both legs, where 0 in the first element means a single order'
      - id: comb_op
        type: u1
        enum: comb_op
        doc: 'ID of multi-leg order'
      - id: reserved_13
        size: 13
        doc: 'Make up field length'
  symbol_text:
    seq:
      - id: symbol_char_2020
        type: str
        size: 20
        encoding: ASCII
        doc: 'Text product ID'
  org_trans_time_msg_time:
    seq:
      - id: epoch_s_int_324
        type: second_timestamp
        doc: 'Seconds since the epoch, the number of seconds from 1970/01/01 0:0 UTC. Seconds since Unix epoch'
      - id: ms
        type: millisecond_timestamp
        doc: 'One thousandth of a second. Milliseconds since Second epoch'
  transact_time_msg_time:
    seq:
      - id: epoch_s_int_324
        type: second_timestamp
        doc: 'Seconds since the epoch, the number of seconds from 1970/01/01 0:0 UTC. Seconds since Unix epoch'
      - id: ms
        type: millisecond_timestamp
        doc: 'One thousandth of a second. Milliseconds since Second epoch'
  order_status_report_long_format_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: cm_id
        type: u2
        doc: 'Clearing member ID, read from the FCM ID Mapping File P06'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: order_no
        type: str
        size: 5
        encoding: ASCII
        doc: 'Order No, whose five characters may all be alphanumeric'
      - id: ord_id
        type: u4
        doc: 'Order serial No, a number of at most seven digits'
      - id: user_define
        type: str
        size: 8
        encoding: ASCII
        doc: 'FCM defined variable, which the trading system updates in the order status when it adds, cancels or changes an order'
      - id: symbol_type
        type: u1
        enum: symbol_type
        doc: 'Product ID format, 1 for a numeric and 2 for a text product ID'
      - id: sym_long_symbol_x
        type:
          switch-on: symbol_type
          cases:
            'symbol_type::numeric_product_id_long_format': long_symbol_num
            'symbol_type::text_product_id_long_format': long_symbol_text
      - id: price
        type: s4
        doc: 'Order price, an integer whose number of decimal digits is the Decimal_Locator of the product definition file'
      - id: qty
        type: u2
        doc: 'Order quantity'
      - id: investor_acno
        type: u4
        doc: 'Investor account No'
      - id: investor_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Investor ID code'
      - id: side
        type: u1
        enum: side
        doc: 'Buy/sell code'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Order condition'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'Open/offset code'
      - id: last_px
        type: s4
        doc: 'Last execution price, which is the last execution price for an execution report and 0 for a cancel, decrease or modify price order'
      - id: last_qty
        type: u2
        doc: 'Last quantity executed, which is the last execution quantity for an execution report and 0 for a cancel, decrease or modify price order'
      - id: px_subtotal
        type: s8
        doc: 'Cumulative weighted execution price, which divided by CumQty is the average price per contract'
      - id: cum_qty
        type: u2
        doc: 'Total quantity executed'
      - id: leaves_qty
        type: u2
        doc: 'Remaining quantity'
      - id: before_qty
        type: u2
        doc: 'Remaining order quantity before match'
      - id: leg_side_uint_822
        type: u1
        enum: leg_side_uint_822
        doc: 'Buy/sell code for both legs, where 0 in the first element means a single order'
      - id: leg_px
        type: s4
        doc: 'Execution price for both legs'
      - id: leg_qty_uint_1624
        type: u2
        doc: 'Quantity executed for both legs'
      - id: org_trans_time_msg_time
        type: org_trans_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: transact_time_msg_time
        type: transact_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: uniq_id
        type: u4
        doc: 'Unique ID, a system unique No assigned to the order reply of each order'
      - id: rpt_seq
        type: u4
        doc: 'Report sequence No'
      - id: protocol_type
        type: u1
        enum: protocol_type
        doc: 'Source of new order data, distinguishing the protocol the order was placed over'
  long_symbol_num:
    seq:
      - id: pseq_1
        type: u2
        doc: 'First leg product ID, whose minimum value is 1'
      - id: pseq_2
        type: u2
        doc: 'Second leg product ID, where 0 means a single order'
      - id: leg_side_uint_822
        type: u1
        enum: leg_side_uint_822
        doc: 'Buy/sell code for both legs, where 0 in the first element means a single order'
      - id: comb_op
        type: u1
        enum: comb_op
        doc: 'ID of multi-leg order'
      - id: reserved_33
        size: 33
        doc: 'Make up field length'
  long_symbol_text:
    seq:
      - id: symbol_char_4040
        type: str
        size: 40
        encoding: ASCII
        doc: 'Text product ID'
  execution_report_including_head_office_and_branch_offices_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: cm_id
        type: u2
        doc: 'Clearing member ID, read from the FCM ID Mapping File P06'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: order_no
        type: str
        size: 5
        encoding: ASCII
        doc: 'Order No, whose five characters may all be alphanumeric'
      - id: ord_id
        type: u4
        doc: 'Order serial No, a number of at most seven digits'
      - id: user_define
        type: str
        size: 8
        encoding: ASCII
        doc: 'FCM defined variable, which the trading system updates in the order status when it adds, cancels or changes an order'
      - id: symbol_type
        type: u1
        enum: symbol_type
        doc: 'Product ID format, 1 for a numeric and 2 for a text product ID'
      - id: sym_symbol_x
        type:
          switch-on: symbol_type
          cases:
            'symbol_type::numeric_product_id': symbol_num
            'symbol_type::text_product_id': symbol_text
      - id: price
        type: s4
        doc: 'Order price, an integer whose number of decimal digits is the Decimal_Locator of the product definition file'
      - id: qty
        type: u2
        doc: 'Order quantity'
      - id: investor_acno
        type: u4
        doc: 'Investor account No'
      - id: investor_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Investor ID code'
      - id: side
        type: u1
        enum: side
        doc: 'Buy/sell code'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Order condition'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'Open/offset code'
      - id: last_px
        type: s4
        doc: 'Last execution price, which is the last execution price for an execution report and 0 for a cancel, decrease or modify price order'
      - id: last_qty
        type: u2
        doc: 'Last quantity executed, which is the last execution quantity for an execution report and 0 for a cancel, decrease or modify price order'
      - id: px_subtotal
        type: s8
        doc: 'Cumulative weighted execution price, which divided by CumQty is the average price per contract'
      - id: cum_qty
        type: u2
        doc: 'Total quantity executed'
      - id: leaves_qty
        type: u2
        doc: 'Remaining quantity'
      - id: before_qty
        type: u2
        doc: 'Remaining order quantity before match'
      - id: leg_side_uint_822
        type: u1
        enum: leg_side_uint_822
        doc: 'Buy/sell code for both legs, where 0 in the first element means a single order'
      - id: leg_px
        type: s4
        doc: 'Execution price for both legs'
      - id: leg_qty_uint_1624
        type: u2
        doc: 'Quantity executed for both legs'
      - id: org_trans_time_msg_time
        type: org_trans_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: transact_time_msg_time
        type: transact_time_msg_time
        doc: 'Tmp time format, the seconds since the epoch and the thousandth of a second. Milliseconds since Unix epoch'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: uniq_id
        type: u4
        doc: 'Unique ID, a system unique No assigned to the order reply of each order'
      - id: rpt_seq
        type: u4
        doc: 'Report sequence No'
      - id: protocol_type
        type: u1
        enum: protocol_type
        doc: 'Source of new order data, distinguishing the protocol the order was placed over'
      - id: rpt_session_id
        type: u2
        doc: 'Session ID of the session the report relates to'
  flex_order_status_report_message:
    seq:
      - id: sub_hdr
        type: sub_hdr
        doc: 'Tmp Expanded Message Header, which assigns different functionalities to a MessageType by defining additional subcategories for it'
      - id: part_id
        type: u1
        enum: part_id
        doc: 'Partition ID, referring to Section 3.6'
      - id: no_leg
        type: u1
        doc: 'Number of legs, which is 1 for a single-leg product and by which the content of the NoLeg related block is modified'
      - id: status_code_uint_162
        type: u2
        enum: status_code_uint_162
        doc: 'Status code, referring to the Error Message Table'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution type'
      - id: cm_id
        type: u2
        doc: 'Clearing member ID, read from the FCM ID Mapping File P06'
      - id: fcm_id
        type: u2
        doc: 'FCM ID, read from the FCM ID Mapping File P06'
      - id: order_no
        type: str
        size: 5
        encoding: ASCII
        doc: 'Order No, whose five characters may all be alphanumeric'
      - id: ord_id
        type: u4
        doc: 'Order serial No, a number of at most seven digits'
      - id: user_define
        type: str
        size: 8
        encoding: ASCII
        doc: 'FCM defined variable, which the trading system updates in the order status when it adds, cancels or changes an order'
      - id: sym_flex_product_x
        type:
          switch-on: sub_hdr.msg_type_ext
          cases:
            'msg_type_ext::single_leg_order_with_a_numeric_product_serial_number': symbol_num_x
            'msg_type_ext::single_leg_order_with_a_textual_product_symbol': symbol_txt_x
            'msg_type_ext::multi_leg_order_with_a_numeric_product_serial_number': multi_leg_num
            'msg_type_ext::multi_leg_order_with_a_textual_product_symbol': multi_leg_txt
      - id: price
        type: s4
        doc: 'Order price, an integer whose number of decimal digits is the Decimal_Locator of the product definition file'
      - id: qty
        type: u2
        doc: 'Order quantity'
      - id: investor_acno
        type: u4
        doc: 'Investor account No'
      - id: investor_flag
        type: str
        size: 1
        encoding: ASCII
        doc: 'Investor ID code'
      - id: side
        type: u1
        enum: side
        doc: 'Buy/sell code'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Order condition'
      - id: position_effect
        type: u1
        enum: position_effect
        doc: 'Open/offset code'
      - id: last_px
        type: s4
        doc: 'Last execution price, which is the last execution price for an execution report and 0 for a cancel, decrease or modify price order'
      - id: last_qty
        type: u2
        doc: 'Last quantity executed, which is the last execution quantity for an execution report and 0 for a cancel, decrease or modify price order'
      - id: px_subtotal
        type: s8
        doc: 'Cumulative weighted execution price, which divided by CumQty is the average price per contract'
      - id: cum_qty
        type: u2
        doc: 'Total quantity executed'
      - id: leaves_qty
        type: u2
        doc: 'Remaining quantity'
      - id: before_qty
        type: u2
        doc: 'Remaining order quantity before match'
      - id: org_trans_time_msg_time_x
        type: org_trans_time_msg_time_x
        doc: 'Tmp Expanded Time Format, the seconds since the epoch and the billionth of a second, which the FLEX reports carry in place of msg_time. Nanoseconds since Unix epoch'
      - id: transact_time_msg_time_x
        type: transact_time_msg_time_x
        doc: 'Tmp Expanded Time Format, the seconds since the epoch and the billionth of a second, which the FLEX reports carry in place of msg_time. Nanoseconds since Unix epoch'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: uniq_id
        type: u4
        doc: 'Unique ID, a system unique No assigned to the order reply of each order'
      - id: rpt_seq
        type: u4
        doc: 'Report sequence No'
      - id: rpt_session_id
        type: u2
        doc: 'Session ID of the session the report relates to'
      - id: rpt_session_seq
        type: u4
        doc: 'Session serial No, the current session_seq where target_id is 4 and the session_seq of the original reporting session where it is 8 or 9'
      - id: reserved_12
        size: 12
        doc: 'Reserved'
  symbol_num_x:
    seq:
      - id: pseq
        type: u4
        doc: 'Numeric product serial number, referring to the product serial number in XP08'
  symbol_txt_x:
    seq:
      - id: prod_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Textual Product Symbol, referring to the product symbol in XP08'
  multi_leg_num:
    seq:
      - id: num_leg_entry_num
        type: u1
        doc: 'Number of legs, which is 1 for a single-leg product and by which the content of the NoLeg related block is modified'
      - id: comb_op
        type: u1
        enum: comb_op
        doc: 'ID of multi-leg order'
      - id: leg_entry_num
        type: leg_entry_num
        repeat: expr
        repeat-expr: num_leg_entry_num
        doc: 'One leg of a multi leg FLEX order whose product is named by a numeric product serial number'
  leg_entry_num:
    seq:
      - id: leg_sym_symbol_num_x
        type: leg_sym_symbol_num_x
        doc: 'FLEX Numeric Single Product Serial number, naming a FLEX product by the serial number of the XP08 product and time flow group definition file'
      - id: leg_side_uint_81
        type: u1
        enum: leg_side_uint_81
        doc: 'Buy/sell code for one leg'
      - id: leg_qty_uint_162
        type: u2
        doc: 'Quantity for one leg'
  leg_sym_symbol_num_x:
    seq:
      - id: pseq
        type: u4
        doc: 'Numeric product serial number, referring to the product serial number in XP08'
  multi_leg_txt:
    seq:
      - id: num_leg_entry_txt
        type: u1
        doc: 'Number of legs, which is 1 for a single-leg product and by which the content of the NoLeg related block is modified'
      - id: comb_op
        type: u1
        enum: comb_op
        doc: 'ID of multi-leg order'
      - id: leg_entry_txt
        type: leg_entry_txt
        repeat: expr
        repeat-expr: num_leg_entry_txt
        doc: 'One leg of a multi leg FLEX order whose product is named by a textual product symbol'
  leg_entry_txt:
    seq:
      - id: leg_sym_symbol_txt_x
        type: leg_sym_symbol_txt_x
        doc: 'FLEX Textual Single Product Symbol, naming a FLEX product by the product symbol of the XP08 product and time flow group definition file'
      - id: leg_side_uint_81
        type: u1
        enum: leg_side_uint_81
        doc: 'Buy/sell code for one leg'
      - id: leg_qty_uint_162
        type: u2
        doc: 'Quantity for one leg'
  leg_sym_symbol_txt_x:
    seq:
      - id: prod_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Textual Product Symbol, referring to the product symbol in XP08'
  org_trans_time_msg_time_x:
    seq:
      - id: epoch_s_uint_324
        type: second_timestamp
        doc: 'Seconds since the epoch, the number of seconds from 1970/01/01 0:0 UTC. Seconds since Unix epoch'
      - id: nanosecond
        type: nanosecond_offset
        doc: 'One billionth of a second. Nanoseconds since Second epoch'
  transact_time_msg_time_x:
    seq:
      - id: epoch_s_uint_324
        type: second_timestamp
        doc: 'Seconds since the epoch, the number of seconds from 1970/01/01 0:0 UTC. Seconds since Unix epoch'
      - id: nanosecond
        type: nanosecond_offset
        doc: 'One billionth of a second. Nanoseconds since Second epoch'
  clearing_member_initiate_operation_message:
    seq:
      - id: member_id
        type: u2
        doc: 'Member id, the cm_id where target_id is 8, 9, 18 or 19 and the fcm_id where it is 3, 13 or 23'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: req_cm_seq
        type: u4
        doc: 'Request report start No, corresponding to the rpt_seq of the reports the connection will receive'
  clearing_member_initiate_operation_confirmed_message:
    seq:
      - id: status_code_uint_81
        type: u1
        enum: status_code_uint_81
        doc: 'Status code, referring to the Error Message Tables'
      - id: member_id
        type: u2
        doc: 'Member id, the cm_id where target_id is 8, 9, 18 or 19 and the fcm_id where it is 3, 13 or 23'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: req_cm_seq
        type: u4
        doc: 'Request report start No, corresponding to the rpt_seq of the reports the connection will receive'
  flex_clearing_member_initiate_operation_message:
    seq:
      - id: sub_hdr
        type: sub_hdr
        doc: 'Tmp Expanded Message Header, which assigns different functionalities to a MessageType by defining additional subcategories for it'
      - id: part_id
        type: u1
        enum: part_id
        doc: 'Partition ID, referring to Section 3.6'
      - id: member_id
        type: u2
        doc: 'Member id, the cm_id where target_id is 8, 9, 18 or 19 and the fcm_id where it is 3, 13 or 23'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: req_cm_seq
        type: u4
        doc: 'Request report start No, corresponding to the rpt_seq of the reports the connection will receive'
  flex_clearing_member_initiate_operation_confirmed_message:
    seq:
      - id: sub_hdr
        type: sub_hdr
        doc: 'Tmp Expanded Message Header, which assigns different functionalities to a MessageType by defining additional subcategories for it'
      - id: part_id
        type: u1
        enum: part_id
        doc: 'Partition ID, referring to Section 3.6'
      - id: status_code_uint_162
        type: u2
        enum: status_code_uint_162
        doc: 'Status code, referring to the Error Message Table'
      - id: member_id
        type: u2
        doc: 'Member id, the cm_id where target_id is 8, 9, 18 or 19 and the fcm_id where it is 3, 13 or 23'
      - id: target_id
        type: u1
        enum: target_id
        doc: 'Target ID, naming the report this message carries and the line it is sent on'
      - id: req_cm_seq
        type: u4
        doc: 'Request report start No, corresponding to the rpt_seq of the reports the connection will receive'
      - id: reserved_16
        size: 16
        doc: 'Reserved'
  message_tail_struct:
    seq:
      - id: check_sum
        type: u1
        doc: 'Check sum, the remainder of the sum of the binary values of every byte from the front-end field up to the field right before the CheckSum field divided by 256'
  millisecond_timestamp:
    seq:
      - id: time
        type: b48
    instances:
      hour:
        value: time.as<s8> / 3600000 % 24
      minute:
        value: time.as<s8> / 60000 % 60
      second:
        value: time.as<s8> / 1000 % 60
      millisecond:
        value: time.as<s8> % 1000
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
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

enums:
  message_type:
    10:
      id: 'wake_up_call_message'
      doc: 'Wake up call message, which either Taifex or the futures commission merchant may initiate in the logon phase of the Link Subsystem.'
    20:
      id: 'wake_up_call_confirmed_message'
      doc: 'Wake up call confirmed message, sent by the futures commission merchant to Taifex.'
    30:
      id: 'logon_notice_message'
      doc: 'Logon notice message, carrying the sequence No of the last message Taifex sent the futures commission merchant in the session.'
    230:
      id: 'final_sequential_number_notification_for_group_message'
      doc: 'Final Sequential Number Notification Message for Group, transmitting the group''s last report sequence number to the futures commission merchant.'
    40:
      id: 'request_logon_message'
      doc: 'Request logon, sent by the futures commission merchant to Taifex with the start sequence of the messages it requests Taifex to resend.'
    50:
      id: 'activate_application_system_message'
      doc: 'Activate application system, sent by Taifex to the futures commission merchant.'
    60:
      id: 'activate_application_system_confirmed_message'
      doc: 'Activate application system confirmed, from which Taifex calculates the round trip time of the L50 message to determine the maximum peak flow per second.'
    70:
      id: 'logout_message'
      doc: 'Logout message, sent by the futures commission merchant to Taifex, and carrying no field of its own beyond the common message header and the check sum.'
    80:
      id: 'logout_confirmed_message'
      doc: 'Logout confirmed message, sent by Taifex to the futures commission merchant.'
    104:
      id: 'confirm_connection_message'
      doc: 'Confirm connection message, which either party sends when no new message has arrived from the other after the number of seconds set in the HeartBtInt field of L50.'
    105:
      id: 'connection_confirmed_message'
      doc: 'Connection confirmed message, with which a party answers the confirm connection message of the other.'
    102:
      id: 'order_status_report_message'
      doc: 'Order status report, with which Taifex answers an order input and reports each execution against it, naming its product in the short product format.'
    132:
      id: 'order_status_report_long_format_message'
      doc: 'Order status report, with which Taifex answers an order input and reports each execution against it, naming its product in the long product format.'
    106:
      id: 'execution_report_including_head_office_and_branch_offices_message'
      doc: 'Execution report including head office and branch offices, which carries the executions of every protocol and neither the order response nor a deletion or decrease.'
    202:
      id: 'flex_order_status_report_message'
      doc: 'FLEX Order status report, with which Taifex answers a FLEX order input and reports each execution against it, and which is not reported if the L20 version is 0.'
    115:
      id: 'clearing_member_initiate_operation_message'
      doc: 'Clearing member initiate operation message, with which the clearing member requests the report start sequence of its downline FCM data.'
    116:
      id: 'clearing_member_initiate_operation_confirmed_message'
      doc: 'Clearing member initiate operation confirmed message, with which Taifex answers the clearing member with a report start notice.'
    215:
      id: 'flex_clearing_member_initiate_operation_message'
      doc: 'Clearing member initiate FLEX operation message, with which the clearing member subscribes to the FLEX order and execution data of a partition.'
    216:
      id: 'flex_clearing_member_initiate_operation_confirmed_message'
      doc: 'Clearing member initiate FLEX operation confirmed message, with which Taifex confirms the FLEX subscription.'
  status_code_uint_81:
    0:
      id: 'succeed'
      doc: 'Succeed'
    1:
      id: 'trading_time_over'
      doc: 'Trading Time Over'
    2:
      id: 'order_acceptance_not_yet_started_or_trading_halt'
      doc: 'Order acceptance not yet started or trading halt or order not yet accepted during receiving order stage'
    3:
      id: 'price_quote_not_yet_accepted'
      doc: 'Price Quote Not Yet Accepted'
    4:
      id: 'in_processing_no_order_accepted_for_the_time_being'
      doc: 'In Processing No Order Accepted For The Time Being'
    5:
      id: 'no_such_order_no'
      doc: 'No Such Order No'
    6:
      id: 'order_or_quote_filled'
      doc: 'Order Or Quote Filled'
    7:
      id: 'order_or_quote_cancelled'
      doc: 'Order Or Quote Cancelled'
    8:
      id: 'stop_order'
      doc: 'Stop Order'
    9:
      id: 'order_limit'
      doc: 'Order Limit'
    10:
      id: 'order_not_in_the_book'
      doc: 'Order not in the book; cancel or decrease or modify not allowed'
    11:
      id: 'exec_type_error'
      doc: 'Exec Type Error'
    12:
      id: 'broker_id_error'
      doc: 'Broker Id Error'
    13:
      id: 'branch_no_error'
      doc: 'Branch No Error'
    14:
      id: 'investor_account_error'
      doc: '1. Investor Acct No. error 2. The investor account is not opened in NBT.'
    15:
      id: 'investor_id_code_error'
      doc: 'Investor Id Code Error'
    16:
      id: 'reject_delete_or_modify_order_during_non_cancel_period'
      doc: 'Reject Delete Or Modify Order During Non Cancel Period'
    17:
      id: 'duplicate_order_no_or_quote_no'
      doc: 'Duplicate Order No Or Quote No'
    18:
      id: 'order_no_or_quote_no_error'
      doc: 'Order No Or Quote No Error'
    19:
      id: 'the_same_side_order_not_exist'
      doc: 'The Same Side Order Not Exist'
    20:
      id: 'product_id_error'
      doc: 'Product Id Error'
    21:
      id: 'exceeding_risefall_limit'
      doc: 'Exceeding rise/fall limit'
    22:
      id: 'order_quantity_error'
      doc: 'Order Quantity Error'
    23:
      id: 'price_inquiry_not_accepted_yet_or_price_is_at_risefall_limit_price_inquiry_not_accepted'
      doc: 'Price inquiry not accepted yet, or price is at rise/fall limit, price inquiry not accepted'
    24:
      id: 'buy_sell_error'
      doc: 'Buy Sell Error'
    25:
      id: 'ord_type_error'
      doc: 'Ord Type Error'
    26:
      id: 'order_type_and_price_not_matched'
      doc: 'Order Type And Price Not Matched'
    27:
      id: 'time_in_force_error'
      doc: 'Time In Force Error'
    28:
      id: 'position_effect_error'
      doc: 'Position Effect Error'
    29:
      id: 'price_and_tick_size_not_matched'
      doc: 'Price And Tick Size Not Matched'
    30:
      id: 'product_expired'
      doc: 'Product Expired'
    31:
      id: 'broker_id_product_group_and_market_makers_account_no_inconsistent'
      doc: 'Broker ID, product group, and market maker’s account No. inconsistent'
    32:
      id: 'decrease_successful_but_requested_more_than_the_decreasable_unfilled_part'
      doc: 'Decrease successful, but the change requested is greater than the unfilled part that can be decreased of the original order. This is a warning.'
    33:
      id: 'quoted_bidask_price_may_not_exceed_the_spread_limit_of_the_product'
      doc: 'Quoted bid/ask price may not exceed the spread limit of the product'
    34:
      id: 'bid_price_exceeding_ask_price'
      doc: 'Bid Price Exceeding Ask Price'
    35:
      id: 'remaining_quantity_of_the_unmodified_side_is_zero'
      doc: 'The remaining quantity of the unmodified side is zero (single-side quote order modification)'
    36:
      id: 'the_unfilled_part_of_the_one_way_quote_is_less_than_the_minimum_quantity_limit'
      doc: 'The Unfilled Part Of The One Way Quote Is Less Than The Minimum Quantity Limit'
    37:
      id: 'price_inquiry_already_present'
      doc: 'Price inquiry already present; new inquiry not accepted'
    38:
      id: 'market_orderand_mwp_does_not_accept_rod'
      doc: 'Market order(and MWP) does not accept ROD'
    39:
      id: 'decrease_quantity_error'
      doc: 'Decrease Quantity Error'
    40:
      id: 'price_error_single_side_quote_order_modification'
      doc: 'Price error (single-side quote order modification)'
    41:
      id: 'settlement_month_error'
      doc: 'Settlement Month Error'
    42:
      id: 'strike_price_error'
      doc: 'Strike Price Error'
    43:
      id: 'clearing_member_id_error'
      doc: 'Clearing Member Id Error'
    44:
      id: 'order_source_error'
      doc: 'order_source error'
    45:
      id: 'info_source_error'
      doc: 'info_source error'
    46:
      id: 'disable_kill_switch_operation_error'
      doc: 'Disable Kill Switch Operation Error'
    47:
      id: 'leaves_quantity_rejected_at_the_dynamic_price_banding_limit'
      doc: 'Reject the leaves quantity due to the simulated matched price reached the upper (lower) limit of the dynamic price banding.'
    48:
      id: 'dynamic_price_banding_limit_price_disclosure'
      doc: 'Status 48 means this report will disclose the upper or lower limit price of dynamic price banding when leaves quantity rejected due to the simulated matched price reached the upper (lower) limit of the dynamic price banding.'
    51:
      id: 'fok_not_filled_and_deleted_by_system'
      doc: 'Fok Not Filled And Deleted By System'
    52:
      id: 'ioc_is_partially_filled'
      doc: 'Ioc Is Partially Filled'
    53:
      id: 'ioc_not_filled_and_deleted_by_system'
      doc: 'Ioc Not Filled And Deleted By System'
    54:
      id: 'delete_the_order_because_of_cod'
      doc: 'Delete The Order Because Of Cod'
    61:
      id: 'buysell_code_of_canceldecrease_order_not_matching_original_order'
      doc: 'Buy/sell code of cancel/decrease order not matching original order'
    62:
      id: 'product_id_of_canceldecrease_order_not_matching_original_order'
      doc: 'Product ID of cancel/decrease order not matching original order'
    63:
      id: 'modify_price_of_ioc_order_not_allowed'
      doc: 'Modify Price Of Ioc Order Not Allowed'
    64:
      id: 'order_partially_traded_modify_to_market_fok_order_or_mwp_fok_order_is_not_allowed'
      doc: 'Order Partially Traded Modify To Market Fok Order Or Mwp Fok Order Is Not Allowed'
    65:
      id: 'kill_switch_in_operation_the_order_execution_type_is_not_allowed'
      doc: 'Kill Switch In Operation The Order Execution Type Is Not Allowed'
    77:
      id: 'no_such_contract'
      doc: 'No Such Contract'
    78:
      id: 'order_of_this_contract_is_restricted_for_this_account_code'
      doc: 'Order Of This Contract Is Restricted For This Account Code'
    79:
      id: 'order_deleted_due_to_trading_suspension_or_order_acceptance_before_collective_bidding'
      doc: 'Order Deleted Due To Trading Suspension Or Order Acceptance Before Collective Bidding'
    80:
      id: 'fcm_is_not_yet_approved_to_trade_this_product_or_execute_the_function'
      doc: 'Fcm Is Not Yet Approved To Trade This Product Or Execute The Function'
    89:
      id: 'too_many_errors'
      doc: 'Too Many Errors'
    91:
      id: 'message_time_out'
      doc: 'Message Time Out'
    92:
      id: 'message_length_error'
      doc: 'Message Length Error'
    93:
      id: 'message_format_error'
      doc: 'Message Format Error'
    99:
      id: 'major_error'
      doc: 'Major Error'
    110:
      id: 'illegal_file_code'
      doc: 'Illegal File Code'
    113:
      id: 'wrong_file_request_range'
      doc: 'Wrong File Request Range'
    114:
      id: 'file_is_not_ready'
      doc: 'File Is Not Ready'
    117:
      id: 'file_is_ready_but_empty'
      doc: 'File Is Ready But Empty'
    120:
      id: 'file_not_found_for_broker'
      doc: 'File Not Found For Broker'
    121:
      id: 'illegal_time_to_get_file'
      doc: 'Illegal Time To Get File'
    150:
      id: 'fcm_unique_id_or_serial_no_duplicate'
      doc: 'fcm_unique_id or serial no duplicate'
    151:
      id: 'product_can_not_block_trade'
      doc: 'Product Can Not Block Trade'
    152:
      id: 'block_trade_order_quantity_error'
      doc: 'Block Trade Order Quantity Error'
    153:
      id: 'invalid_prod_count'
      doc: 'Invalid prod_count'
    154:
      id: 'prod_count_is_not_match_with_the_number_of_legs_in_a_block_trade_order'
      doc: 'prod_count is not match with the number of legs in a block trade order'
    155:
      id: 'invalid_fcm_unique_id_or_serial_no'
      doc: 'invalid fcm_unique_id or serial no'
    156:
      id: 'block_trade_id_duplicate'
      doc: 'Block Trade Id Duplicate'
    157:
      id: 'invalid_block_trade_id'
      doc: 'Invalid Block Trade Id'
    158:
      id: 'invalid_participant_fcm_count'
      doc: 'Invalid participant_fcm_count'
    159:
      id: 'participant_fcm_count_is_not_consistent_with_participant_fcm_id_list'
      doc: 'participant_fcm_count is not consistent with participant_fcm_id list'
    160:
      id: 'participant_fcm_id_error'
      doc: 'participant_fcm_id error'
    161:
      id: 'invalid_prod_count_161'
      doc: 'Invalid prod_count'
    162:
      id: 'block_trade_id_does_not_exist'
      doc: 'Block Trade Id Does Not Exist'
    163:
      id: 'negotiated_block_trade_success'
      doc: 'Negotiated Block Trade Success'
    164:
      id: 'negotiated_block_trade_fail'
      doc: 'Negotiated Block Trade Fail'
    165:
      id: 'negotiated_block_trade_calcelled'
      doc: 'Negotiated Block Trade Calcelled'
    166:
      id: 'negotiated_block_trade_wait_fcm_to_comfirm_order'
      doc: 'Negotiated Block Trade Wait Fcm To Comfirm Order'
    167:
      id: 'fcm_id_not_matching_represent_fcm'
      doc: 'fcm_id not matching represent FCM'
    168:
      id: 'symbol_type_error'
      doc: 'symbol_type error'
    169:
      id: 'invalid_order_count_of_negotiated_block_trade_confirm_input'
      doc: 'Invalid order_count of negotiated block trade confirm input'
    170:
      id: 'number_of_orders_in_b_31_xb_31_is_not_consistent_with_order_count_field'
      doc: 'number of orders in B31/XB31 is not consistent with order_count field'
    171:
      id: 'negotiated_block_trade_is_not_in_the_status_of_waiting_for_confirm_input'
      doc: 'Negotiated Block Trade Is Not In The Status Of Waiting For Confirm Input'
    172:
      id: 'investor_acno_duplicate_in_negotiated_block_trade_confirm_input'
      doc: 'investor_acno duplicate in negotiated block trade confirm input'
    175:
      id: 'negotiated_block_trade_timed_out'
      doc: 'Negotiated Block Trade Timed Out'
    176:
      id: 'the_confirm_input_data_is_not_consistent_with_b_21_xb_21_registered_data'
      doc: 'The confirm input data is not consistent with B21/XB21 registered data'
    177:
      id: 'negotiated_block_trade_beyond_the_position_limit'
      doc: 'Negotiated Block Trade Beyond The Position Limit'
    186:
      id: 'illegal_source_id'
      doc: 'Illegal Source Id'
    200:
      id: 'significant_system_time_error'
      doc: 'Significant system time error. This is a warning.'
    201:
      id: 'append_no_error'
      doc: '“append_no” ERROR'
    202:
      id: 'fcm_id_error'
      doc: '“fcm_id” ERROR'
    203:
      id: 'ap_code_error'
      doc: '“ap_code” ERROR'
    204:
      id: 'key_value_error'
      doc: '“key_value” ERROR'
    205:
      id: 'session_id_error'
      doc: '“session_id” ERROR'
    206:
      id: 'system_type_error'
      doc: '“system_type” ERROR'
    207:
      id: 'msg_seq_num_error'
      doc: '“MsgSeqNum” ERROR'
    208:
      id: 'target_id_error'
      doc: '“target_id” ERROR'
    209:
      id: 'flow_group_no_error'
      doc: 'flow_group_no ERROR'
    210:
      id: 'subscription_request_type_error'
      doc: 'Subscription Request Type Error'
    220:
      id: 'msg_type_ext_error'
      doc: 'Msg Type Ext Error'
    221:
      id: 'part_id_error'
      doc: 'part_id ERROR'
    240:
      id: 'session_exceeds_the_flow_limit'
      doc: 'Session Exceeds The Flow Limit'
    241:
      id: 'session_exceeds_flow_limit_continuously_and_is_locked'
      doc: 'a session exceeds flow limit continuously, system will lock this session for a period of time.'
    242:
      id: 'order_older_than_cancel_order_sec_and_rejected'
      doc: 'The difference between msg_time of R01/R31/RX01 and TAIFEX trading system''s R01/R31/RX01 receiving time is larger than “cancel_order_sec” value. This order will be rejected. TAIFEX will not check status_code=242 when ExecType=4.'
    248:
      id: 'session_reach_80_of_the_flow_limit'
      doc: 'session reach 80% of the flow limit. This is a warning.'
    249:
      id: 'session_reach_90_of_the_flow_limit'
      doc: 'session reach 90% of the flow limit. This is a warning.'
    250:
      id: 'order_older_than_two_seconds'
      doc: 'The difference between msg_time of R01/R31/RX01 and TAIFEX trading system''s R01/R31/RX01 receiving time is larger than 2 seconds. This is a warning.'
  version:
    0:
      id: 'regular_trading'
      doc: 'Regular Trading'
    1:
      id: 'regular_trading_and_flex_trading'
      doc: 'Regular Trading And Flex Trading'
  system_type:
    10:
      id: 'options_regular_market_hours'
      doc: 'Options Regular Market Hours'
    20:
      id: 'futures_regular_market_hours'
      doc: 'Futures Regular Market Hours'
    11:
      id: 'options_after_market_hours'
      doc: 'Options After Market Hours'
    21:
      id: 'futures_after_market_hours'
      doc: 'Futures After Market Hours'
  encrypt_method:
    0:
      id: 'unencrypted'
      doc: 'Unencrypted'
  msg_type_ext:
    0:
      id: 'same_product_as_the_original_order_input'
      doc: 'Same Product As The Original Order Input'
    1:
      id: 'single_leg_order_with_a_numeric_product_serial_number'
      doc: 'Single Leg Order With A Numeric Product Serial Number'
    2:
      id: 'single_leg_order_with_a_textual_product_symbol'
      doc: 'Single Leg Order With A Textual Product Symbol'
    3:
      id: 'multi_leg_order_with_a_numeric_product_serial_number'
      doc: 'Multi Leg Order With A Numeric Product Serial Number'
    4:
      id: 'multi_leg_order_with_a_textual_product_symbol'
      doc: 'Multi Leg Order With A Textual Product Symbol'
    255:
      id: 'unexpected_error_record'
      doc: 'Unexpected Error Record'
  status_code_uint_162:
    0:
      id: 'succeed'
      doc: 'Succeed'
    1:
      id: 'trading_time_over'
      doc: 'Trading Time Over'
    2:
      id: 'order_acceptance_not_yet_started_or_trading_halt'
      doc: 'Order acceptance not yet started or trading halt or order not yet accepted during receiving order stage'
    3:
      id: 'price_quote_not_yet_accepted'
      doc: 'Price Quote Not Yet Accepted'
    4:
      id: 'in_processing_no_order_accepted_for_the_time_being'
      doc: 'In Processing No Order Accepted For The Time Being'
    5:
      id: 'no_such_order_no'
      doc: 'No Such Order No'
    6:
      id: 'order_or_quote_filled'
      doc: 'Order Or Quote Filled'
    7:
      id: 'order_or_quote_cancelled'
      doc: 'Order Or Quote Cancelled'
    8:
      id: 'stop_order'
      doc: 'Stop Order'
    9:
      id: 'order_limit'
      doc: 'Order Limit'
    10:
      id: 'order_not_in_the_book'
      doc: 'Order not in the book; cancel or decrease or modify not allowed'
    11:
      id: 'exec_type_error'
      doc: 'Exec Type Error'
    12:
      id: 'broker_id_error'
      doc: 'Broker Id Error'
    13:
      id: 'branch_no_error'
      doc: 'Branch No Error'
    14:
      id: 'investor_account_error'
      doc: '1. Investor Acct No. error 2. The investor account is not opened in NBT.'
    15:
      id: 'investor_id_code_error'
      doc: 'Investor Id Code Error'
    16:
      id: 'reject_delete_or_modify_order_during_non_cancel_period'
      doc: 'Reject Delete Or Modify Order During Non Cancel Period'
    17:
      id: 'duplicate_order_no_or_quote_no'
      doc: 'Duplicate Order No Or Quote No'
    18:
      id: 'order_no_or_quote_no_error'
      doc: 'Order No Or Quote No Error'
    19:
      id: 'the_same_side_order_not_exist'
      doc: 'The Same Side Order Not Exist'
    20:
      id: 'product_id_error'
      doc: 'Product Id Error'
    21:
      id: 'exceeding_risefall_limit'
      doc: 'Exceeding rise/fall limit'
    22:
      id: 'order_quantity_error'
      doc: 'Order Quantity Error'
    23:
      id: 'price_inquiry_not_accepted_yet_or_price_is_at_risefall_limit_price_inquiry_not_accepted'
      doc: 'Price inquiry not accepted yet, or price is at rise/fall limit, price inquiry not accepted'
    24:
      id: 'buy_sell_error'
      doc: 'Buy Sell Error'
    25:
      id: 'ord_type_error'
      doc: 'Ord Type Error'
    26:
      id: 'order_type_and_price_not_matched'
      doc: 'Order Type And Price Not Matched'
    27:
      id: 'time_in_force_error'
      doc: 'Time In Force Error'
    28:
      id: 'position_effect_error'
      doc: 'Position Effect Error'
    29:
      id: 'price_and_tick_size_not_matched'
      doc: 'Price And Tick Size Not Matched'
    30:
      id: 'product_expired'
      doc: 'Product Expired'
    31:
      id: 'broker_id_product_group_and_market_makers_account_no_inconsistent'
      doc: 'Broker ID, product group, and market maker’s account No. inconsistent'
    32:
      id: 'decrease_successful_but_requested_more_than_the_decreasable_unfilled_part'
      doc: 'Decrease successful, but the change requested is greater than the unfilled part that can be decreased of the original order. This is a warning.'
    33:
      id: 'quoted_bidask_price_may_not_exceed_the_spread_limit_of_the_product'
      doc: 'Quoted bid/ask price may not exceed the spread limit of the product'
    34:
      id: 'bid_price_exceeding_ask_price'
      doc: 'Bid Price Exceeding Ask Price'
    35:
      id: 'remaining_quantity_of_the_unmodified_side_is_zero'
      doc: 'The remaining quantity of the unmodified side is zero (single-side quote order modification)'
    36:
      id: 'the_unfilled_part_of_the_one_way_quote_is_less_than_the_minimum_quantity_limit'
      doc: 'The Unfilled Part Of The One Way Quote Is Less Than The Minimum Quantity Limit'
    37:
      id: 'price_inquiry_already_present'
      doc: 'Price inquiry already present; new inquiry not accepted'
    38:
      id: 'market_orderand_mwp_does_not_accept_rod'
      doc: 'Market order(and MWP) does not accept ROD'
    39:
      id: 'decrease_quantity_error'
      doc: 'Decrease Quantity Error'
    40:
      id: 'price_error_single_side_quote_order_modification'
      doc: 'Price error (single-side quote order modification)'
    41:
      id: 'settlement_month_error'
      doc: 'Settlement Month Error'
    42:
      id: 'strike_price_error'
      doc: 'Strike Price Error'
    43:
      id: 'clearing_member_id_error'
      doc: 'Clearing Member Id Error'
    44:
      id: 'order_source_error'
      doc: 'order_source error'
    45:
      id: 'info_source_error'
      doc: 'info_source error'
    46:
      id: 'disable_kill_switch_operation_error'
      doc: 'Disable Kill Switch Operation Error'
    47:
      id: 'leaves_quantity_rejected_at_the_dynamic_price_banding_limit'
      doc: 'Reject the leaves quantity due to the simulated matched price reached the upper (lower) limit of the dynamic price banding.'
    48:
      id: 'dynamic_price_banding_limit_price_disclosure'
      doc: 'Status 48 means this report will disclose the upper or lower limit price of dynamic price banding when leaves quantity rejected due to the simulated matched price reached the upper (lower) limit of the dynamic price banding.'
    51:
      id: 'fok_not_filled_and_deleted_by_system'
      doc: 'Fok Not Filled And Deleted By System'
    52:
      id: 'ioc_is_partially_filled'
      doc: 'Ioc Is Partially Filled'
    53:
      id: 'ioc_not_filled_and_deleted_by_system'
      doc: 'Ioc Not Filled And Deleted By System'
    54:
      id: 'delete_the_order_because_of_cod'
      doc: 'Delete The Order Because Of Cod'
    61:
      id: 'buysell_code_of_canceldecrease_order_not_matching_original_order'
      doc: 'Buy/sell code of cancel/decrease order not matching original order'
    62:
      id: 'product_id_of_canceldecrease_order_not_matching_original_order'
      doc: 'Product ID of cancel/decrease order not matching original order'
    63:
      id: 'modify_price_of_ioc_order_not_allowed'
      doc: 'Modify Price Of Ioc Order Not Allowed'
    64:
      id: 'order_partially_traded_modify_to_market_fok_order_or_mwp_fok_order_is_not_allowed'
      doc: 'Order Partially Traded Modify To Market Fok Order Or Mwp Fok Order Is Not Allowed'
    65:
      id: 'kill_switch_in_operation_the_order_execution_type_is_not_allowed'
      doc: 'Kill Switch In Operation The Order Execution Type Is Not Allowed'
    77:
      id: 'no_such_contract'
      doc: 'No Such Contract'
    78:
      id: 'order_of_this_contract_is_restricted_for_this_account_code'
      doc: 'Order Of This Contract Is Restricted For This Account Code'
    79:
      id: 'order_deleted_due_to_trading_suspension_or_order_acceptance_before_collective_bidding'
      doc: 'Order Deleted Due To Trading Suspension Or Order Acceptance Before Collective Bidding'
    80:
      id: 'fcm_is_not_yet_approved_to_trade_this_product_or_execute_the_function'
      doc: 'Fcm Is Not Yet Approved To Trade This Product Or Execute The Function'
    89:
      id: 'too_many_errors'
      doc: 'Too Many Errors'
    91:
      id: 'message_time_out'
      doc: 'Message Time Out'
    92:
      id: 'message_length_error'
      doc: 'Message Length Error'
    93:
      id: 'message_format_error'
      doc: 'Message Format Error'
    99:
      id: 'major_error'
      doc: 'Major Error'
    110:
      id: 'illegal_file_code'
      doc: 'Illegal File Code'
    113:
      id: 'wrong_file_request_range'
      doc: 'Wrong File Request Range'
    114:
      id: 'file_is_not_ready'
      doc: 'File Is Not Ready'
    117:
      id: 'file_is_ready_but_empty'
      doc: 'File Is Ready But Empty'
    120:
      id: 'file_not_found_for_broker'
      doc: 'File Not Found For Broker'
    121:
      id: 'illegal_time_to_get_file'
      doc: 'Illegal Time To Get File'
    150:
      id: 'fcm_unique_id_or_serial_no_duplicate'
      doc: 'fcm_unique_id or serial no duplicate'
    151:
      id: 'product_can_not_block_trade'
      doc: 'Product Can Not Block Trade'
    152:
      id: 'block_trade_order_quantity_error'
      doc: 'Block Trade Order Quantity Error'
    153:
      id: 'invalid_prod_count'
      doc: 'Invalid prod_count'
    154:
      id: 'prod_count_is_not_match_with_the_number_of_legs_in_a_block_trade_order'
      doc: 'prod_count is not match with the number of legs in a block trade order'
    155:
      id: 'invalid_fcm_unique_id_or_serial_no'
      doc: 'invalid fcm_unique_id or serial no'
    156:
      id: 'block_trade_id_duplicate'
      doc: 'Block Trade Id Duplicate'
    157:
      id: 'invalid_block_trade_id'
      doc: 'Invalid Block Trade Id'
    158:
      id: 'invalid_participant_fcm_count'
      doc: 'Invalid participant_fcm_count'
    159:
      id: 'participant_fcm_count_is_not_consistent_with_participant_fcm_id_list'
      doc: 'participant_fcm_count is not consistent with participant_fcm_id list'
    160:
      id: 'participant_fcm_id_error'
      doc: 'participant_fcm_id error'
    161:
      id: 'invalid_prod_count_161'
      doc: 'Invalid prod_count'
    162:
      id: 'block_trade_id_does_not_exist'
      doc: 'Block Trade Id Does Not Exist'
    163:
      id: 'negotiated_block_trade_success'
      doc: 'Negotiated Block Trade Success'
    164:
      id: 'negotiated_block_trade_fail'
      doc: 'Negotiated Block Trade Fail'
    165:
      id: 'negotiated_block_trade_calcelled'
      doc: 'Negotiated Block Trade Calcelled'
    166:
      id: 'negotiated_block_trade_wait_fcm_to_comfirm_order'
      doc: 'Negotiated Block Trade Wait Fcm To Comfirm Order'
    167:
      id: 'fcm_id_not_matching_represent_fcm'
      doc: 'fcm_id not matching represent FCM'
    168:
      id: 'symbol_type_error'
      doc: 'symbol_type error'
    169:
      id: 'invalid_order_count_of_negotiated_block_trade_confirm_input'
      doc: 'Invalid order_count of negotiated block trade confirm input'
    170:
      id: 'number_of_orders_in_b_31_xb_31_is_not_consistent_with_order_count_field'
      doc: 'number of orders in B31/XB31 is not consistent with order_count field'
    171:
      id: 'negotiated_block_trade_is_not_in_the_status_of_waiting_for_confirm_input'
      doc: 'Negotiated Block Trade Is Not In The Status Of Waiting For Confirm Input'
    172:
      id: 'investor_acno_duplicate_in_negotiated_block_trade_confirm_input'
      doc: 'investor_acno duplicate in negotiated block trade confirm input'
    175:
      id: 'negotiated_block_trade_timed_out'
      doc: 'Negotiated Block Trade Timed Out'
    176:
      id: 'the_confirm_input_data_is_not_consistent_with_b_21_xb_21_registered_data'
      doc: 'The confirm input data is not consistent with B21/XB21 registered data'
    177:
      id: 'negotiated_block_trade_beyond_the_position_limit'
      doc: 'Negotiated Block Trade Beyond The Position Limit'
    186:
      id: 'illegal_source_id'
      doc: 'Illegal Source Id'
    200:
      id: 'significant_system_time_error'
      doc: 'Significant system time error. This is a warning.'
    201:
      id: 'append_no_error'
      doc: '“append_no” ERROR'
    202:
      id: 'fcm_id_error'
      doc: '“fcm_id” ERROR'
    203:
      id: 'ap_code_error'
      doc: '“ap_code” ERROR'
    204:
      id: 'key_value_error'
      doc: '“key_value” ERROR'
    205:
      id: 'session_id_error'
      doc: '“session_id” ERROR'
    206:
      id: 'system_type_error'
      doc: '“system_type” ERROR'
    207:
      id: 'msg_seq_num_error'
      doc: '“MsgSeqNum” ERROR'
    208:
      id: 'target_id_error'
      doc: '“target_id” ERROR'
    209:
      id: 'flow_group_no_error'
      doc: 'flow_group_no ERROR'
    210:
      id: 'subscription_request_type_error'
      doc: 'Subscription Request Type Error'
    220:
      id: 'msg_type_ext_error'
      doc: 'Msg Type Ext Error'
    221:
      id: 'part_id_error'
      doc: 'part_id ERROR'
    240:
      id: 'session_exceeds_the_flow_limit'
      doc: 'Session Exceeds The Flow Limit'
    241:
      id: 'session_exceeds_flow_limit_continuously_and_is_locked'
      doc: 'a session exceeds flow limit continuously, system will lock this session for a period of time.'
    242:
      id: 'order_older_than_cancel_order_sec_and_rejected'
      doc: 'The difference between msg_time of R01/R31/RX01 and TAIFEX trading system''s R01/R31/RX01 receiving time is larger than “cancel_order_sec” value. This order will be rejected. TAIFEX will not check status_code=242 when ExecType=4.'
    248:
      id: 'session_reach_80_of_the_flow_limit'
      doc: 'session reach 80% of the flow limit. This is a warning.'
    249:
      id: 'session_reach_90_of_the_flow_limit'
      doc: 'session reach 90% of the flow limit. This is a warning.'
    250:
      id: 'order_older_than_two_seconds'
      doc: 'The difference between msg_time of R01/R31/RX01 and TAIFEX trading system''s R01/R31/RX01 receiving time is larger than 2 seconds. This is a warning.'
    300:
      id: 'the_flex_contract_has_been_resubmitted'
      doc: 'The Flex Contract Has Been Resubmitted'
    301:
      id: 'open_interest_for_today_undetermined'
      doc: 'Due to undetermined OI for today, please submit the FLEX contract application after OI confirmation.'
    302:
      id: 'the_flex_contract_is_listed_for_trading'
      doc: 'The Flex Contract Is Listed For Trading'
    303:
      id: 'incorrect_expiration_date_for_the_flex_contract'
      doc: 'Incorrect Expiration Date For The Flex Contract'
    304:
      id: 'duplicate_unique_id_of_a_security_definition_request_for_the_flex_contract'
      doc: 'Duplicate Unique Id Of A Security Definition Request For The Flex Contract'
    305:
      id: 'exceeding_the_flex_contract_limit'
      doc: 'Exceeding The Flex Contract Limit'
    306:
      id: 'no_record_of_successful_flex_contract_application_was_found'
      doc: 'No Record Of Successful Flex Contract Application Was Found'
    310:
      id: 'non_flexible_contract_application_period'
      doc: 'Non Flexible Contract Application Period'
    311:
      id: 'the_proprietary_trading_account_has_not_been_approved_to_apply_for_flex_contracts'
      doc: 'The Proprietary Trading Account Has Not Been Approved To Apply For Flex Contracts'
    312:
      id: 'the_fcm_account_has_not_been_approved_to_apply_for_flex_contracts'
      doc: 'The Fcm Account Has Not Been Approved To Apply For Flex Contracts'
    313:
      id: 'incorrect_coverage_range_for_the_flex_contract'
      doc: 'Incorrect Coverage Range For The Flex Contract'
    314:
      id: 'invalid_strike_price_for_the_flex_contract'
      doc: 'Invalid strike_price for the FLEX contract.'
    315:
      id: 'invalid_security_request_type_for_the_flex_contract'
      doc: 'Invalid Security Request Type For The Flex Contract'
    316:
      id: 'invalid_application_type_for_the_flex_contract'
      doc: 'Invalid Application Type For The Flex Contract'
    317:
      id: 'invalid_type_for_the_flex_contract'
      doc: 'Invalid Type For The Flex Contract'
    318:
      id: 'expiry_type_error'
      doc: '“expiry_type” ERROR'
    319:
      id: 'call_put_code_error'
      doc: '“call_put_code” ERROR'
  part_id:
    102:
      id: 'flex_options_regular_market_hours'
      doc: 'Flex Options Regular Market Hours'
    202:
      id: 'flex_futures_regular_market_hours'
      doc: 'Flex Futures Regular Market Hours'
  ap_code:
    4:
      id: 'fcm_order_transaction'
      doc: 'Fcm Order Transaction'
    6:
      id: 'fcm_condensed_version_order_transaction'
      doc: 'Fcm Condensed Version Order Transaction'
    7:
      id: 'tmpdc_session'
      doc: 'Tmpdc Session'
    8:
      id: 'clearing_member_order_transaction_report'
      doc: 'Clearing Member Order Transaction Report'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'cancel'
      doc: 'Cancel'
    0x35:
      id: 'decrease'
      doc: 'Decrease'
    0x36:
      id: 'new_and_execution_report'
      doc: 'New And Execution Report'
    0x46:
      id: 'execution_report'
      doc: 'Execution Report'
    0x49:
      id: 'query'
      doc: 'Query'
    0x4d:
      id: 'modify_price_replying_to_the_modifying_line'
      doc: 'Modify Price Replying To The Modifying Line'
    0x6d:
      id: 'modify_price_replying_to_the_original_line'
      doc: 'Modify Price Replying To The Original Line'
  symbol_type:
    1:
      id: 'numeric_product_id'
      doc: 'Numeric Product Id'
    2:
      id: 'text_product_id'
      doc: 'Text Product Id'
    3:
      id: 'numeric_product_id_long_format'
      doc: 'Numeric Product Id Long Format'
    4:
      id: 'text_product_id_long_format'
      doc: 'Text Product Id Long Format'
  leg_side_uint_822:
    0:
      id: 'single_order'
      doc: 'Single Order'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  comb_op:
    0:
      id: 'single_order'
      doc: 'Single Order'
    1:
      id: 'price_spread'
      doc: 'Price Spread'
    2:
      id: 'time_spread'
      doc: 'Time Spread'
    3:
      id: 'straddle'
      doc: 'Straddle'
    4:
      id: 'strangle'
      doc: 'Strangle'
    5:
      id: 'conversion_and_reversals'
      doc: 'Conversion And Reversals'
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
      id: 'market_with_protection'
      doc: 'Market With Protection'
  time_in_force:
    0:
      id: 'rod'
      doc: 'Rod'
    3:
      id: 'ioc'
      doc: 'Ioc'
    4:
      id: 'fok'
      doc: 'Fok'
    8:
      id: 'automatically_cancelled_after_a_period_of_time'
      doc: 'Automatically Cancelled After A Period Of Time'
  position_effect:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x44:
      id: 'daytrade'
      doc: 'Daytrade'
    0x41:
      id: 'open_and_specified_position_offsets'
      doc: 'Open And Specified Position Offsets'
    0x37:
      id: 'offset_by_fcm'
      doc: 'Offset By Fcm'
    0x39:
      id: 'market_maker_quote'
      doc: 'Market Maker Quote'
  target_id:
    3:
      id: 'execution_report_including_head_office_and_branch_offices_in_r_02_format'
      doc: 'Execution Report Including Head Office And Branch Offices In R 02 Format'
    4:
      id: 'fcm'
      doc: 'Fcm'
    7:
      id: 'drop_copy_in_r_02_format'
      doc: 'Drop Copy In R 02 Format'
    8:
      id: 'clearing_member_order_and_execution_in_r_02_format'
      doc: 'Clearing Member Order And Execution In R 02 Format'
    9:
      id: 'clearing_member_execution_in_r_02_format'
      doc: 'Clearing Member Execution In R 02 Format'
    13:
      id: 'execution_report_including_head_office_and_branch_offices_in_r_32_format'
      doc: 'Execution Report Including Head Office And Branch Offices In R 32 Format'
    17:
      id: 'drop_copy_in_r_32_format'
      doc: 'Drop Copy In R 32 Format'
    18:
      id: 'clearing_member_order_and_execution_in_r_32_format'
      doc: 'Clearing Member Order And Execution In R 32 Format'
    19:
      id: 'clearing_member_execution_in_r_32_format'
      doc: 'Clearing Member Execution In R 32 Format'
    23:
      id: 'execution_report_including_head_office_and_branch_offices_in_r_06_format'
      doc: 'Execution Report Including Head Office And Branch Offices In R 06 Format'
  protocol_type:
    0:
      id: 'reserved'
      doc: 'Reserved'
    1:
      id: 'tmp'
      doc: 'Tmp'
    2:
      id: 'fix'
      doc: 'Fix'
  leg_side_uint_81:
    0:
      id: 'single_order'
      doc: 'Single Order'
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'

