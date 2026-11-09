# ---------------------------------------------------------------------
# Kaitai struct definition for: Neeq NeeqSecurities OrderEntry BjseBinary v1.1
#
# Protocol:
#   Organization: National Equities Exchange and Quotations
#   Protocol: Neeq Order Entry
#   Encoding: Bjse Binary Market Data Feed
#   Version: 1.1
#   Date: 12/31/2025
#   Specification: Trade Interface Specification Binary V1.1 (2025-12-31).pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
  id: neeq_neeqsecurities_orderentry_bjsebinary_v1_1
  title: Neeq NeeqSecurities OrderEntry BjseBinary v1.1
  license: MIT-0
  endian: be

doc: 'National Equities Exchange and Quotations National Equities Exchange and Quotations Neeq Order Entry BjseBinary v1.1'
doc-ref: https://www.neeq.com.cn/rule/Tech_area.html

seq:
  - id: message_header
    type: message_header_struct
    doc: 'Bjse Bjtg Message Header, defining the type and body length of a message, transmitted without encryption'
  - id: payload
    size: message_header.body_length
    type:
      switch-on: message_header.msg_type
      cases:
        'msg_type::logon_message': logon_message
        'msg_type::logout_message': logout_message
        'msg_type::business_reject_message': business_reject_message
        'msg_type::report_synchronization_message': report_synchronization_message
        'msg_type::platform_state_info_message': platform_state_info_message
        'msg_type::report_finished_message': report_finished_message
        'msg_type::platform_info_message': platform_info_message
        'msg_type::trading_session_status_message': trading_session_status_message
        'msg_type::bond_spot_matching_new_order_message': bond_spot_matching_new_order_message
        'msg_type::centralized_auction_new_order_message': centralized_auction_new_order_message
        'msg_type::conversion_new_order_message': conversion_new_order_message
        'msg_type::inquiry_new_order_message': inquiry_new_order_message
        'msg_type::subscription_new_order_message': subscription_new_order_message
        'msg_type::put_back_new_order_message': put_back_new_order_message
        'msg_type::tender_offer_acceptance_new_order_message': tender_offer_acceptance_new_order_message
        'msg_type::refinancing_securities_lending_non_agreed_new_order_message': refinancing_securities_lending_non_agreed_new_order_message
        'msg_type::order_cancel_request_message': order_cancel_request_message
        'msg_type::cancel_reject_message': cancel_reject_message
        'msg_type::bond_spot_matching_execution_report_message': bond_spot_matching_execution_report_message
        'msg_type::centralized_auction_execution_report_message': centralized_auction_execution_report_message
        'msg_type::conversion_execution_report_message': conversion_execution_report_message
        'msg_type::inquiry_execution_report_message': inquiry_execution_report_message
        'msg_type::subscription_execution_report_message': subscription_execution_report_message
        'msg_type::put_back_execution_report_message': put_back_execution_report_message
        'msg_type::tender_offer_acceptance_execution_report_message': tender_offer_acceptance_execution_report_message
        'msg_type::refinancing_securities_lending_non_agreed_execution_report_message': refinancing_securities_lending_non_agreed_execution_report_message
        'msg_type::bond_spot_matching_trade_execution_report_message': bond_spot_matching_trade_execution_report_message
        'msg_type::centralized_auction_trade_execution_report_message': centralized_auction_trade_execution_report_message
        'msg_type::refinancing_securities_lending_non_agreed_trade_execution_report_message': refinancing_securities_lending_non_agreed_trade_execution_report_message
        'msg_type::bond_spot_negotiated_trade_capture_report_message': bond_spot_negotiated_trade_capture_report_message
        'msg_type::refinancing_securities_lending_agreed_trade_capture_report_message': refinancing_securities_lending_agreed_trade_capture_report_message
        'msg_type::mutual_trade_confirmation_trade_capture_report_message': mutual_trade_confirmation_trade_capture_report_message
        'msg_type::market_making_mutual_trade_confirmation_trade_capture_report_message': market_making_mutual_trade_confirmation_trade_capture_report_message
        'msg_type::after_hours_block_trade_trade_capture_report_message': after_hours_block_trade_trade_capture_report_message
        'msg_type::bond_spot_negotiated_trade_capture_report_ack_message': bond_spot_negotiated_trade_capture_report_ack_message
        'msg_type::refinancing_securities_lending_agreed_trade_capture_report_ack_message': refinancing_securities_lending_agreed_trade_capture_report_ack_message
        'msg_type::mutual_trade_confirmation_trade_capture_report_ack_message': mutual_trade_confirmation_trade_capture_report_ack_message
        'msg_type::market_making_mutual_trade_confirmation_trade_capture_report_ack_message': market_making_mutual_trade_confirmation_trade_capture_report_ack_message
        'msg_type::after_hours_block_trade_trade_capture_report_ack_message': after_hours_block_trade_trade_capture_report_ack_message
        'msg_type::bond_spot_negotiated_trade_capture_report_confirmation_message': bond_spot_negotiated_trade_capture_report_confirmation_message
        'msg_type::refinancing_securities_lending_agreed_trade_capture_report_confirmation_message': refinancing_securities_lending_agreed_trade_capture_report_confirmation_message
        'msg_type::mutual_trade_confirmation_trade_capture_report_confirmation_message': mutual_trade_confirmation_trade_capture_report_confirmation_message
        'msg_type::market_making_mutual_trade_confirmation_trade_capture_report_confirmation_message': market_making_mutual_trade_confirmation_trade_capture_report_confirmation_message
        'msg_type::after_hours_block_trade_trade_capture_report_confirmation_message': after_hours_block_trade_trade_capture_report_confirmation_message
  - id: message_tail
    type: message_tail_struct
    doc: 'Bjse Bjtg Message Tail, defining the checksum of a message, transmitted without encryption'

types:
  message_header_struct:
    seq:
      - id: msg_type
        type: u4
        enum: msg_type
        doc: 'Type of a message'
      - id: body_length
        type: u4
        doc: 'The length of a message body'
  logon_message:
    seq:
      - id: sender_comp_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sender code'
      - id: target_comp_id
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Receiver code'
      - id: heart_bt_int
        type: s4
        doc: 'Heartbeat interval in seconds, given by the order management system at logon'
      - id: password
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password'
      - id: default_appl_ver_id
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Binary protocol version, the communication version number written as n.xy'
  logout_message:
    seq:
      - id: session_status
        type: s4
        enum: session_status
        doc: 'Session status at logout'
      - id: text
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'Further explanation of the logout reason, up to 200 bytes that may include Chinese characters'
  business_reject_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: ref_seq_num
        type: s8
        doc: 'Message sequence number of the rejected message'
      - id: ref_msg_type
        type: u4
        doc: 'Message type of the rejected message'
      - id: business_reject_ref_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business layer ID of the rejected message: ClOrdID for a new order, an order cancel request or a quote response, QuoteMsgID for a quote, TradeReportID for a trade capture report'
      - id: business_reject_reason
        type: u2
        enum: business_reject_reason
        doc: 'Reject reason'
      - id: business_reject_text
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reject reason text, up to 50 bytes that may include Chinese characters'
  report_synchronization_message:
    seq:
      - id: num_partition_reports
        type: u4
        doc: 'Number of platform partitions'
      - id: partition_reports
        type: partition_reports
        repeat: expr
        repeat-expr: num_partition_reports
        doc: 'One entry per platform partition the order management system expects to receive'
  partition_reports:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
  platform_state_info_message:
    seq:
      - id: platform_id
        type: u2
        enum: platform_id
        doc: 'Platform number'
      - id: platform_state
        type: u2
        enum: platform_state
        doc: 'Platform state'
  report_finished_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: platform_id
        type: u2
        enum: platform_id
        doc: 'Platform number'
  platform_info_message:
    seq:
      - id: platform_id
        type: u2
        enum: platform_id
        doc: 'Platform number'
      - id: num_partitions
        type: u4
        doc: 'Number of platform partitions'
      - id: partitions
        type: partitions
        repeat: expr
        repeat-expr: num_partitions
        doc: 'One entry per platform partition'
  partitions:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
  trading_session_status_message:
    seq:
      - id: market_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market code, reserved'
      - id: market_segment_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment code; only the first character is used, giving the platform: 2 = fixed income platform'
      - id: trading_session_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading session ID, reserved'
      - id: trading_session_sub_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading session sub ID, a numeric string'
      - id: trad_ses_status
        type: u2
        doc: 'Trading session status, reserved'
      - id: trad_ses_start_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Trading session start time, reserved'
      - id: trad_ses_end_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Trading session end time, reserved'
  bond_spot_matching_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: stop_px
        type: decimal_s8_5
        doc: 'Stop price. Implied decimal with scale 1e-5'
      - id: min_qty
        type: decimal_s8_3
        doc: 'Minimum trade quantity. Implied decimal with scale 1e-3'
      - id: max_price_levels
        type: u2
        doc: 'Maximum number of price levels to trade at; 0 means unlimited'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force type'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
  centralized_auction_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: stop_px
        type: decimal_s8_5
        doc: 'Stop price. Implied decimal with scale 1e-5'
      - id: min_qty
        type: decimal_s8_3
        doc: 'Minimum trade quantity. Implied decimal with scale 1e-3'
      - id: max_price_levels
        type: u2
        doc: 'Maximum number of price levels to trade at; 0 means unlimited'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force type'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  conversion_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
  inquiry_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
  subscription_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
  put_back_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
  tender_offer_acceptance_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
  refinancing_securities_lending_non_agreed_new_order_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  order_cancel_request_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
  cancel_reject_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: cxl_rej_reason
        type: u2
        enum: cxl_rej_reason
        doc: 'Cancel reject reason code'
      - id: reject_text
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reject reason text, up to 16 bytes that may include Chinese characters'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
  bond_spot_matching_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: stop_px
        type: decimal_s8_5
        doc: 'Stop price. Implied decimal with scale 1e-5'
      - id: min_qty
        type: decimal_s8_3
        doc: 'Minimum trade quantity. Implied decimal with scale 1e-3'
      - id: max_price_levels
        type: u2
        doc: 'Maximum number of price levels to trade at; 0 means unlimited'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force type'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  centralized_auction_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: stop_px
        type: decimal_s8_5
        doc: 'Stop price. Implied decimal with scale 1e-5'
      - id: min_qty
        type: decimal_s8_3
        doc: 'Minimum trade quantity. Implied decimal with scale 1e-3'
      - id: max_price_levels
        type: u2
        doc: 'Maximum number of price levels to trade at; 0 means unlimited'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force type'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  conversion_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
  inquiry_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
  subscription_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
  put_back_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
  tender_offer_acceptance_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
  refinancing_securities_lending_non_agreed_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: orig_cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number of the original order, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: ord_rej_reason
        type: u2
        enum: ord_rej_reason
        doc: 'Cancel or reject reason code'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: ord_type
        type: u1
        enum: ord_type
        doc: 'Order type'
      - id: order_qty
        type: decimal_s8_3
        doc: 'Order quantity. Implied decimal with scale 1e-3'
      - id: price
        type: decimal_s8_5
        doc: 'Price. Implied decimal with scale 1e-5'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: order_restrictions
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order restrictions, up to four codes at once, blank when none: 1 = programmatic trading, E = algorithmic trading'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  bond_spot_matching_trade_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
  centralized_auction_trade_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  refinancing_securities_lending_non_agreed_trade_execution_report_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: order_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange order number of the original order'
      - id: cl_ord_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client order number, a 10 digit string with leading zeros'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'Execution report type'
      - id: ord_status
        type: u1
        enum: ord_status
        doc: 'Order status'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: leaves_qty
        type: decimal_s8_3
        doc: 'Remaining order quantity. Implied decimal with scale 1e-3'
      - id: cum_qty
        type: decimal_s8_3
        doc: 'Cumulative executed quantity. Implied decimal with scale 1e-3'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: maturity_date
        type: yyyymmdd_date
        doc: 'Maturity date'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  bond_spot_negotiated_trade_capture_report_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own dealer code'
      - id: trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trader code'
      - id: counterparty_member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty dealer code'
      - id: counterparty_trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trader code'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
      - id: memo
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks, up to 120 bytes that may include Chinese characters'
  refinancing_securities_lending_agreed_trade_capture_report_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  mutual_trade_confirmation_trade_capture_report_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  market_making_mutual_trade_confirmation_trade_capture_report_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  after_hours_block_trade_trade_capture_report_message:
    seq:
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  bond_spot_negotiated_trade_capture_report_ack_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: trd_ack_status
        type: u1
        enum: trd_ack_status
        doc: 'Trade report acknowledgement status'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
        doc: 'Trade report status'
      - id: trade_report_reject_reason
        type: u2
        enum: trade_report_reject_reason
        doc: 'Trade report reject reason code'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own dealer code'
      - id: trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trader code'
      - id: counterparty_member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty dealer code'
      - id: counterparty_trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trader code'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
      - id: memo
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks, up to 120 bytes that may include Chinese characters'
  refinancing_securities_lending_agreed_trade_capture_report_ack_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: trd_ack_status
        type: u1
        enum: trd_ack_status
        doc: 'Trade report acknowledgement status'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
        doc: 'Trade report status'
      - id: trade_report_reject_reason
        type: u2
        enum: trade_report_reject_reason
        doc: 'Trade report reject reason code'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  mutual_trade_confirmation_trade_capture_report_ack_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: trd_ack_status
        type: u1
        enum: trd_ack_status
        doc: 'Trade report acknowledgement status'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
        doc: 'Trade report status'
      - id: trade_report_reject_reason
        type: u2
        enum: trade_report_reject_reason
        doc: 'Trade report reject reason code'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  market_making_mutual_trade_confirmation_trade_capture_report_ack_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: trd_ack_status
        type: u1
        enum: trd_ack_status
        doc: 'Trade report acknowledgement status'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
        doc: 'Trade report status'
      - id: trade_report_reject_reason
        type: u2
        enum: trade_report_reject_reason
        doc: 'Trade report reject reason code'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  after_hours_block_trade_trade_capture_report_ack_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: trade_report_ref_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Original client trade report number, used when cancelling a trade report'
      - id: trd_ack_status
        type: u1
        enum: trd_ack_status
        doc: 'Trade report acknowledgement status'
      - id: trd_rpt_status
        type: u1
        enum: trd_rpt_status
        doc: 'Trade report status'
      - id: trade_report_reject_reason
        type: u2
        enum: trade_report_reject_reason
        doc: 'Trade report reject reason code'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  bond_spot_negotiated_trade_capture_report_confirmation_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own dealer code'
      - id: trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trader code'
      - id: counterparty_member_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty dealer code'
      - id: counterparty_trader_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trader code'
      - id: settl_type
        type: u1
        enum: settl_type
        doc: 'Settlement method'
      - id: settl_period
        type: u1
        enum: settl_period
        doc: 'Settlement period'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
      - id: memo
        type: str
        size: 120
        encoding: ASCII
        pad-right: 0x20
        doc: 'Remarks, up to 120 bytes that may include Chinese characters'
  refinancing_securities_lending_agreed_trade_capture_report_confirmation_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: expiration_days
        type: u2
        doc: 'Term in days'
      - id: expiration_type
        type: u1
        enum: expiration_type
        doc: 'Term type'
      - id: maturity_date
        type: yyyymmdd_date
        doc: 'Maturity date'
      - id: share_property
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Share property'
  mutual_trade_confirmation_trade_capture_report_confirmation_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  market_making_mutual_trade_confirmation_trade_capture_report_confirmation_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
  after_hours_block_trade_trade_capture_report_confirmation_message:
    seq:
      - id: partition_no
        type: s4
        doc: 'Platform partition number'
      - id: report_index
        type: s8
        doc: 'Report record number, continuing the numbering of the partition''s reports'
      - id: appl_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application identifier'
      - id: reporting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reporting trading unit'
      - id: submitting_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Submitting trading unit'
      - id: security_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code, 6 digits behind 2 leading spaces'
      - id: security_id_source
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security code source, 3 digits behind a leading space'
      - id: owner_type
        type: u2
        enum: owner_type
        doc: 'Order owner type'
      - id: clearing_firm
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing firm code'
      - id: transact_time
        type: yyyymmddhhmmssmmm_timestamp
        doc: 'Report time'
      - id: user_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'User private information, printable Ascii only'
      - id: trade_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange trade report number, unique across trading days'
      - id: trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client trade report number'
      - id: trade_report_type
        type: u1
        enum: trade_report_type
        doc: 'Trade report type'
      - id: trade_report_trans_type
        type: u1
        enum: trade_report_trans_type
        doc: 'Trade report transaction type'
      - id: trade_handling_instr
        type: u1
        enum: trade_handling_instr
        doc: 'Trade report mode'
      - id: last_px
        type: decimal_s8_5
        doc: 'Trade price. Implied decimal with scale 1e-5'
      - id: last_qty
        type: decimal_s8_3
        doc: 'Trade quantity. Implied decimal with scale 1e-3'
      - id: trd_type
        type: u2
        doc: 'Trade report business type'
      - id: trd_sub_type
        type: u2
        enum: trd_sub_type
        doc: 'Trade report business sub type'
      - id: confirm_id
        type: u4
        doc: 'Agreement number, N8(0)'
      - id: exec_id
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Execution number, the Beijing Stock Exchange trade number, assigned by the exchange and unique within a trading day'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Own trading unit'
      - id: account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securities account'
      - id: branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Branch identification code'
      - id: counterparty_pbuid
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty trading unit'
      - id: counterparty_account_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty securities account'
      - id: counterparty_branch_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Counterparty branch identification code'
      - id: cash_margin
        type: u1
        enum: cash_margin
        doc: 'Credit flag'
  message_tail_struct:
    seq:
      - id: checksum
        type: u4
        doc: 'The checksum of a message, the sum of every byte from the start of the message header through the end of the message body taken modulo 256'
  yyyymmddhhmmssmmm_timestamp:
    seq:
      - id: packed
        type: s8
    instances:
      year:
        value: packed / 10000000000000
      month:
        value: packed / 100000000000 % 100
      day:
        value: packed / 1000000000 % 100
      hour:
        value: packed / 10000000 % 100
      minute:
        value: packed / 100000 % 100
      second:
        value: packed / 1000 % 100
      millisecond:
        value: packed % 1000
  decimal_s8_3:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000.0
  decimal_s8_5:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000.0
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
  msg_type:
    1:
      id: 'logon_message'
      doc: 'The first message the order management system sends to the trading gateway, which confirms a successful logon with a Logon of its own, so both sides transmit this message type.'
    2:
      id: 'logout_message'
      doc: 'Sent by the trading gateway to refuse a logon, and by either side to end the session; the receiver answers with a Logout of its own, so both sides transmit this message type.'
    3:
      id: 'heartbeat_message'
      doc: 'Sent by either side when idle so that no more than one heartbeat interval passes between messages; the body is empty.'
    4:
      id: 'business_reject_message'
      doc: 'Sent by the trading gateway when a submission fails a basic validity check, such as an unknown security code or a submission outside its time window.'
    5:
      id: 'report_synchronization_message'
      doc: 'Sent by the order management system after logon to give, for each platform partition, the record number of the next report it expects; the gateway sends no reports for a partition the message omits.'
    6:
      id: 'platform_state_info_message'
      doc: 'Sent by the trading gateway after logon and whenever a platform changes state, so the order management system can control when it submits orders.'
    7:
      id: 'report_finished_message'
      doc: 'Sent by the trading gateway when every report of the trading day for a platform partition has been sent; its record number continues the numbering of the partition''s reports.'
    9:
      id: 'platform_info_message'
      doc: 'Sent by the trading gateway after logon, giving the number of partitions of the platform and their numbers, which need not be consecutive.'
    10:
      id: 'trading_session_status_message'
      doc: 'Sent by the trading gateway after logon and whenever the trading session of the connected platform changes; only the fixed income platform currently sends it.'
    101010:
      id: 'bond_spot_matching_new_order_message'
      doc: 'New order for spot bond trading by matching, ApplID 010.'
    101040:
      id: 'centralized_auction_new_order_message'
      doc: 'New order for centralized auction stock trading, ApplID 040. Not yet enabled.'
    101041:
      id: 'conversion_new_order_message'
      doc: 'New order for conversion, ApplID 041. Not yet enabled.'
    101042:
      id: 'inquiry_new_order_message'
      doc: 'New order for inquiry, ApplID 042. Not yet enabled.'
    101043:
      id: 'subscription_new_order_message'
      doc: 'New order for subscription, ApplID 043. Not yet enabled.'
    101044:
      id: 'put_back_new_order_message'
      doc: 'New order for put back, ApplID 044. Not yet enabled.'
    101045:
      id: 'tender_offer_acceptance_new_order_message'
      doc: 'New order for tender offer acceptance, ApplID 045. Not yet enabled.'
    101050:
      id: 'refinancing_securities_lending_non_agreed_new_order_message'
      doc: 'New order for refinancing securities lending without agreement, ApplID 050. Not yet enabled.'
    102000:
      id: 'order_cancel_request_message'
      doc: 'Cancels an order; the exchange does not check the original order quantity it carries.'
    201000:
      id: 'cancel_reject_message'
      doc: 'Sent by the trading gateway when an order cancel request fails.'
    202010:
      id: 'bond_spot_matching_execution_report_message'
      doc: 'Order response and cancel execution report for spot bond trading by matching, ApplID 010: confirms or rejects a new order, a successful cancel, or an order the system cancels itself.'
    202040:
      id: 'centralized_auction_execution_report_message'
      doc: 'Order response and cancel execution report for centralized auction stock trading, ApplID 040: confirms or rejects a new order, a successful cancel, or an order the system cancels itself. Not yet enabled.'
    202041:
      id: 'conversion_execution_report_message'
      doc: 'Order response and cancel execution report for conversion, ApplID 041: confirms or rejects a new order, a successful cancel, or an order the system cancels itself. Not yet enabled.'
    202042:
      id: 'inquiry_execution_report_message'
      doc: 'Order response and cancel execution report for inquiry, ApplID 042: confirms or rejects a new order; the business does not allow cancellation. Not yet enabled.'
    202043:
      id: 'subscription_execution_report_message'
      doc: 'Order response and cancel execution report for subscription, ApplID 043: confirms or rejects a new order; the business does not allow cancellation. Not yet enabled.'
    202044:
      id: 'put_back_execution_report_message'
      doc: 'Order response and cancel execution report for put back, ApplID 044: confirms or rejects a new order, a successful cancel, or an order the system cancels itself. Not yet enabled.'
    202045:
      id: 'tender_offer_acceptance_execution_report_message'
      doc: 'Order response and cancel execution report for tender offer acceptance, ApplID 045: confirms or rejects a new order, a successful cancel, or an order the system cancels itself. Not yet enabled.'
    202050:
      id: 'refinancing_securities_lending_non_agreed_execution_report_message'
      doc: 'Order response and cancel execution report for refinancing securities lending without agreement, ApplID 050: confirms or rejects a new order, a successful cancel, or an order the system cancels itself. Not yet enabled.'
    203010:
      id: 'bond_spot_matching_trade_execution_report_message'
      doc: 'Execution report for a trade on an order for spot bond trading by matching, ApplID 010.'
    203040:
      id: 'centralized_auction_trade_execution_report_message'
      doc: 'Execution report for a trade on an order for centralized auction stock trading, ApplID 040. Not yet enabled.'
    203050:
      id: 'refinancing_securities_lending_non_agreed_trade_execution_report_message'
      doc: 'Execution report for a trade on an order for refinancing securities lending without agreement, ApplID 050. Not yet enabled.'
    103031:
      id: 'bond_spot_negotiated_trade_capture_report_message'
      doc: 'Trade capture report for spot bond trading by negotiation, ApplID 031, submitted for matching.'
    103051:
      id: 'refinancing_securities_lending_agreed_trade_capture_report_message'
      doc: 'Trade capture report for refinancing securities lending by agreement, ApplID 051, submitted for matching. Not yet enabled.'
    103060:
      id: 'mutual_trade_confirmation_trade_capture_report_message'
      doc: 'Trade capture report for mutual trade confirmation, ApplID 060, submitted for matching. Not yet enabled.'
    103061:
      id: 'market_making_mutual_trade_confirmation_trade_capture_report_message'
      doc: 'Trade capture report for market making mutual trade confirmation, ApplID 061, submitted for matching. Not yet enabled.'
    103062:
      id: 'after_hours_block_trade_trade_capture_report_message'
      doc: 'Trade capture report for after hours block trading, ApplID 062, submitted for matching. Not yet enabled.'
    204031:
      id: 'bond_spot_negotiated_trade_capture_report_ack_message'
      doc: 'Trading gateway response to a trade capture report for spot bond trading by negotiation, ApplID 031.'
    204051:
      id: 'refinancing_securities_lending_agreed_trade_capture_report_ack_message'
      doc: 'Trading gateway response to a trade capture report for refinancing securities lending by agreement, ApplID 051. Not yet enabled.'
    204060:
      id: 'mutual_trade_confirmation_trade_capture_report_ack_message'
      doc: 'Trading gateway response to a trade capture report for mutual trade confirmation, ApplID 060. Not yet enabled.'
    204061:
      id: 'market_making_mutual_trade_confirmation_trade_capture_report_ack_message'
      doc: 'Trading gateway response to a trade capture report for market making mutual trade confirmation, ApplID 061. Not yet enabled.'
    204062:
      id: 'after_hours_block_trade_trade_capture_report_ack_message'
      doc: 'Trading gateway response to a trade capture report for after hours block trading, ApplID 062. Not yet enabled.'
    205031:
      id: 'bond_spot_negotiated_trade_capture_report_confirmation_message'
      doc: 'Trade confirmation of a trade capture report for spot bond trading by negotiation, ApplID 031.'
    205051:
      id: 'refinancing_securities_lending_agreed_trade_capture_report_confirmation_message'
      doc: 'Trade confirmation of a trade capture report for refinancing securities lending by agreement, ApplID 051. Not yet enabled.'
    205060:
      id: 'mutual_trade_confirmation_trade_capture_report_confirmation_message'
      doc: 'Trade confirmation of a trade capture report for mutual trade confirmation, ApplID 060. Not yet enabled.'
    205061:
      id: 'market_making_mutual_trade_confirmation_trade_capture_report_confirmation_message'
      doc: 'Trade confirmation of a trade capture report for market making mutual trade confirmation, ApplID 061. Not yet enabled.'
    205062:
      id: 'after_hours_block_trade_trade_capture_report_confirmation_message'
      doc: 'Trade confirmation of a trade capture report for after hours block trading, ApplID 062. Not yet enabled.'
  session_status:
    0:
      id: 'session_active'
      doc: 'Session Active'
    1:
      id: 'session_password_changed'
      doc: 'Session Password Changed'
    2:
      id: 'session_password_due_to_expire'
      doc: 'Session Password Due To Expire'
    3:
      id: 'new_session_password_does_not_comply_with_policy'
      doc: 'New Session Password Does Not Comply With Policy'
    4:
      id: 'session_logout_complete'
      doc: 'Session Logout Complete'
    5:
      id: 'invalid_username_or_password'
      doc: 'Invalid Username Or Password'
    6:
      id: 'account_locked'
      doc: 'Account Locked'
    7:
      id: 'logons_are_not_allowed_at_this_time'
      doc: 'Logons Are Not Allowed At This Time'
    8:
      id: 'password_expired'
      doc: 'Password Expired'
    9:
      id: 'msg_seq_num_received_too_low'
      doc: 'Msg Seq Num Received Too Low'
    10:
      id: 'next_expected_msg_seq_num_received_too_high'
      doc: 'Next Expected Msg Seq Num Received Too High'
    101:
      id: 'other'
      doc: 'Other'
    102:
      id: 'invalid_message'
      doc: 'Invalid Message'
  business_reject_reason:
    1:
      id: 'invalid_account'
      doc: 'Invalid Account'
    101:
      id: 'own_securities_account_format_invalid'
      doc: 'Own Securities Account Format Invalid'
    102:
      id: 'counterparty_securities_account_format_invalid'
      doc: 'Counterparty Securities Account Format Invalid'
    3:
      id: 'trading_unit_short_sale'
      doc: 'Trading Unit Short Sale'
    4:
      id: 'shareholder_short_sale'
      doc: 'Shareholder Short Sale'
    6:
      id: 'price_too_high'
      doc: 'Price Too High'
    601:
      id: 'price_above_upper_limit_regular_session'
      doc: 'Price Above Upper Limit Regular Session'
    602:
      id: 'price_above_upper_limit_after_hours_session'
      doc: 'Price Above Upper Limit After Hours Session'
    603:
      id: 'price_above_ceiling_in_call_matching'
      doc: 'Price Above Ceiling In Call Matching'
    605:
      id: 'price_above_ceiling_in_continuous_matching'
      doc: 'Price Above Ceiling In Continuous Matching'
    7:
      id: 'price_too_low'
      doc: 'Price Too Low'
    701:
      id: 'price_below_lower_limit_regular_session'
      doc: 'Price Below Lower Limit Regular Session'
    702:
      id: 'price_below_lower_limit_after_hours_session'
      doc: 'Price Below Lower Limit After Hours Session'
    705:
      id: 'price_below_floor_in_call_matching'
      doc: 'Price Below Floor In Call Matching'
    707:
      id: 'price_below_floor_in_continuous_matching'
      doc: 'Price Below Floor In Continuous Matching'
    8:
      id: 'price_error'
      doc: 'Price Error'
    801:
      id: 'price_not_a_multiple_of_the_tick_size'
      doc: 'Price Not A Multiple Of The Tick Size'
    804:
      id: 'price_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Price Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    807:
      id: 'stop_price_value_invalid'
      doc: 'Stop Price Value Invalid'
    9:
      id: 'quantity_invalid'
      doc: 'Quantity Invalid'
    901:
      id: 'quantity_above_maximum_regular_session'
      doc: 'Quantity Above Maximum Regular Session'
    902:
      id: 'quantity_below_minimum_regular_session'
      doc: 'Quantity Below Minimum Regular Session'
    906:
      id: 'quantity_not_a_multiple_of_the_buy_or_sell_unit'
      doc: 'Quantity Not A Multiple Of The Buy Or Sell Unit'
    909:
      id: 'quantity_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Quantity Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    912:
      id: 'minimum_trade_quantity_value_invalid'
      doc: 'Minimum Trade Quantity Value Invalid'
    12:
      id: 'account_invalid'
      doc: 'Account Invalid'
    1201:
      id: 'securities_account_does_not_exist'
      doc: 'Securities Account Does Not Exist'
    1202:
      id: 'securities_account_deactivated'
      doc: 'Securities Account Deactivated'
    13:
      id: 'account_restricted'
      doc: 'Account Restricted'
    1301:
      id: 'account_type_restricted_for_trading_unit'
      doc: 'Account Type Restricted For Trading Unit'
    1302:
      id: 'account_type_restricted_for_trading_unit_type'
      doc: 'Account Type Restricted For Trading Unit Type'
    1306:
      id: 'securities_account_restricted_for_trading_unit'
      doc: 'Securities Account Restricted For Trading Unit'
    1307:
      id: 'securities_account_restricted_for_trading_unit_type'
      doc: 'Securities Account Restricted For Trading Unit Type'
    1310:
      id: 'securities_account_not_allowed_this_business'
      doc: 'Securities Account Not Allowed This Business'
    1315:
      id: 'credit_account_may_not_buy_non_collateral_securities'
      doc: 'Credit Account May Not Buy Non Collateral Securities'
    1316:
      id: 'credit_account_margin_trading_allows_limit_orders_only'
      doc: 'Credit Account Margin Trading Allows Limit Orders Only'
    1909:
      id: 'negotiated_trade_pairing_failed'
      doc: 'Negotiated Trade Pairing Failed'
    22:
      id: 'agreement_number_error'
      doc: 'Agreement Number Error'
    2201:
      id: 'agreement_number_duplicate'
      doc: 'Agreement Number Duplicate'
    2203:
      id: 'agreement_number_format_invalid'
      doc: 'Agreement Number Format Invalid'
    23:
      id: 'invalid_trading_unit'
      doc: 'Invalid Trading Unit'
    2301:
      id: 'trading_unit_does_not_exist'
      doc: 'Trading Unit Does Not Exist'
    2302:
      id: 'trading_unit_deactivated'
      doc: 'Trading Unit Deactivated'
    2317:
      id: 'trading_unit_closed'
      doc: 'Trading Unit Closed'
    2320:
      id: 'trading_unit_value_invalid'
      doc: 'Trading Unit Value Invalid'
    2323:
      id: 'forced_liquidation_from_a_non_margin_trading_unit'
      doc: 'Forced Liquidation From A Non Margin Trading Unit'
    2324:
      id: 'margin_trading_from_a_non_margin_trading_unit'
      doc: 'Margin Trading From A Non Margin Trading Unit'
    2326:
      id: 'own_trading_unit_value_invalid'
      doc: 'Own Trading Unit Value Invalid'
    2327:
      id: 'submitting_trading_unit_value_invalid'
      doc: 'Submitting Trading Unit Value Invalid'
    2328:
      id: 'counterparty_trading_unit_value_invalid'
      doc: 'Counterparty Trading Unit Value Invalid'
    26:
      id: 'trading_unit_restricted'
      doc: 'Trading Unit Restricted'
    2601:
      id: 'trading_unit_restricted_for_security_code'
      doc: 'Trading Unit Restricted For Security Code'
    2602:
      id: 'trading_unit_restricted_for_security_type'
      doc: 'Trading Unit Restricted For Security Type'
    2605:
      id: 'trading_unit_not_allowed_this_business_type'
      doc: 'Trading Unit Not Allowed This Business Type'
    2609:
      id: 'custodian_mode_qfii_account_does_not_match_trading_unit'
      doc: 'Custodian Mode Qfii Account Does Not Match Trading Unit'
    44:
      id: 'invalid_business'
      doc: 'Invalid Business'
    4402:
      id: 'margin_trading_business_not_supported'
      doc: 'Margin Trading Business Not Supported'
    4404:
      id: 'credit_flag_value_error'
      doc: 'Credit Flag Value Error'
    45:
      id: 'odd_lot_sale_prohibited'
      doc: 'Odd Lot Sale Prohibited'
    4501:
      id: 'odd_lot_remainder_must_be_sold_at_once'
      doc: 'Odd Lot Remainder Must Be Sold At Once'
    51:
      id: 'business_type_error'
      doc: 'Business Type Error'
    5101:
      id: 'security_type_not_allowed_this_business_type'
      doc: 'Security Type Not Allowed This Business Type'
    5102:
      id: 'security_code_not_allowed_this_business_type'
      doc: 'Security Code Not Allowed This Business Type'
    5105:
      id: 'security_code_has_no_security_type'
      doc: 'Security Code Has No Security Type'
    5107:
      id: 'business_type_incorrect'
      doc: 'Business Type Incorrect'
    5108:
      id: 'side_value_error'
      doc: 'Side Value Error'
    5109:
      id: 'order_type_value_error'
      doc: 'Order Type Value Error'
    5110:
      id: 'trade_report_transaction_type_value_error'
      doc: 'Trade Report Transaction Type Value Error'
    5111:
      id: 'trade_report_business_type_value_error'
      doc: 'Trade Report Business Type Value Error'
    5112:
      id: 'trade_report_business_sub_type_value_error'
      doc: 'Trade Report Business Sub Type Value Error'
    5113:
      id: 'trade_report_type_value_error'
      doc: 'Trade Report Type Value Error'
    5114:
      id: 'trade_report_mode_value_error'
      doc: 'Trade Report Mode Value Error'
    5115:
      id: 'message_type_value_error'
      doc: 'Message Type Value Error'
    52:
      id: 'business_prohibited'
      doc: 'Business Prohibited'
    5201:
      id: 'security_suspended'
      doc: 'Security Suspended'
    5202:
      id: 'no_cancel_during_call_matching'
      doc: 'No Cancel During Call Matching'
    5203:
      id: 'no_submission_while_closed'
      doc: 'No Submission While Closed'
    5204:
      id: 'business_type_not_allowed_for_security_in_this_period'
      doc: 'Business Type Not Allowed For Security In This Period'
    53:
      id: 'no_order_to_cancel'
      doc: 'No Order To Cancel'
    5301:
      id: 'no_regular_order_to_cancel'
      doc: 'No Regular Order To Cancel'
    5303:
      id: 'cancel_security_code_differs_from_original_order'
      doc: 'Cancel Security Code Differs From Original Order'
    5304:
      id: 'cancel_securities_account_differs_from_original_order'
      doc: 'Cancel Securities Account Differs From Original Order'
    5305:
      id: 'original_order_of_cancel_is_not_a_buy_or_sell_order'
      doc: 'Original Order Of Cancel Is Not A Buy Or Sell Order'
    59:
      id: 'invalid_dealer'
      doc: 'Invalid Dealer'
    5901:
      id: 'own_dealer_code_not_enabled'
      doc: 'Own Dealer Code Not Enabled'
    5902:
      id: 'counterparty_dealer_code_not_enabled'
      doc: 'Counterparty Dealer Code Not Enabled'
    5903:
      id: 'own_dealer_code_value_invalid'
      doc: 'Own Dealer Code Value Invalid'
    5904:
      id: 'counterparty_dealer_code_value_invalid'
      doc: 'Counterparty Dealer Code Value Invalid'
    60:
      id: 'invalid_trader'
      doc: 'Invalid Trader'
    6001:
      id: 'own_trader_code_not_enabled'
      doc: 'Own Trader Code Not Enabled'
    6002:
      id: 'counterparty_trader_code_not_enabled'
      doc: 'Counterparty Trader Code Not Enabled'
    6003:
      id: 'own_trader_code_value_invalid'
      doc: 'Own Trader Code Value Invalid'
    6004:
      id: 'counterparty_trader_code_value_invalid'
      doc: 'Counterparty Trader Code Value Invalid'
    61:
      id: 'application_identifier_value_invalid'
      doc: 'Application Identifier Value Invalid'
    62:
      id: 'own_branch_identification_code_value_invalid'
      doc: 'Own Branch Identification Code Value Invalid'
    6201:
      id: 'counterparty_branch_identification_code_value_invalid'
      doc: 'Counterparty Branch Identification Code Value Invalid'
    63:
      id: 'settlement_method_value_invalid'
      doc: 'Settlement Method Value Invalid'
    64:
      id: 'settlement_period_value_invalid'
      doc: 'Settlement Period Value Invalid'
    65:
      id: 'time_in_force_type_value_invalid'
      doc: 'Time In Force Type Value Invalid'
    66:
      id: 'security_code_source_value_invalid'
      doc: 'Security Code Source Value Invalid'
    67:
      id: 'maximum_price_levels_value_invalid'
      doc: 'Maximum Price Levels Value Invalid'
    68:
      id: 'clearing_firm_code_value_invalid'
      doc: 'Clearing Firm Code Value Invalid'
    69:
      id: 'order_restrictions_value_invalid'
      doc: 'Order Restrictions Value Invalid'
    70:
      id: 'order_owner_type_value_invalid'
      doc: 'Order Owner Type Value Invalid'
    71:
      id: 'securities_holding_accounts_above_limit'
      doc: 'Securities Holding Accounts Above Limit'
    95:
      id: 'invalid_code'
      doc: 'Invalid Code'
    9501:
      id: 'security_code_does_not_exist'
      doc: 'Security Code Does Not Exist'
    9502:
      id: 'security_code_value_invalid'
      doc: 'Security Code Value Invalid'
    9503:
      id: 'security_code_format_invalid'
      doc: 'Security Code Format Invalid'
    96:
      id: 'order_time_format_invalid'
      doc: 'Order Time Format Invalid'
    98:
      id: 'order_number_invalid'
      doc: 'Order Number Invalid'
    9801:
      id: 'client_order_or_trade_report_number_format_invalid'
      doc: 'Client Order Or Trade Report Number Format Invalid'
    9802:
      id: 'original_client_order_or_trade_report_number_format_invalid'
      doc: 'Original Client Order Or Trade Report Number Format Invalid'
    9803:
      id: 'client_order_or_trade_report_number_duplicate'
      doc: 'Client Order Or Trade Report Number Duplicate'
    99:
      id: 'other_error'
      doc: 'Other Error'
    9902:
      id: 'order_validation_method_does_not_exist'
      doc: 'Order Validation Method Does Not Exist'
    9903:
      id: 'order_exception_inconsistent_with_message_definition'
      doc: 'Order Exception Inconsistent With Message Definition'
    20065:
      id: 'platform_closed'
      doc: 'Platform Closed'
    20101:
      id: 'application_identifier_error'
      doc: 'Application Identifier Error'
    20102:
      id: 'security_does_not_support_the_business'
      doc: 'Security Does Not Support The Business'
    20103:
      id: 'unpacking_failed'
      doc: 'Unpacking Failed'
    20104:
      id: 'platform_not_open'
      doc: 'Platform Not Open'
    20105:
      id: 'gateway_has_no_permission_for_trading_unit'
      doc: 'Gateway Has No Permission For Trading Unit'
    20106:
      id: 'field_value_error'
      doc: 'Field Value Error'
    20107:
      id: 'message_type_not_supported'
      doc: 'Message Type Not Supported'
    20108:
      id: 'order_platform_error'
      doc: 'Order Platform Error'
    20112:
      id: 'gateway_has_no_order_submission_permission'
      doc: 'Gateway Has No Order Submission Permission'
    29999:
      id: 'other_error_29999'
      doc: 'Other Error 29999'
  platform_id:
    2:
      id: 'fixed_income_platform'
      doc: 'Fixed Income Platform'
  platform_state:
    0:
      id: 'pre_open'
      doc: 'Pre Open'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'halt'
      doc: 'Halt'
    4:
      id: 'close'
      doc: 'Close'
  owner_type:
    1:
      id: 'individual_investor'
      doc: 'Individual Investor'
    101:
      id: 'exchange'
      doc: 'Exchange'
    102:
      id: 'member'
      doc: 'Member'
    103:
      id: 'institutional_investor'
      doc: 'Institutional Investor'
    104:
      id: 'proprietary_trading'
      doc: 'Proprietary Trading'
    105:
      id: 'liquidity_provider'
      doc: 'Liquidity Provider'
    106:
      id: 'clearing_firm'
      doc: 'Clearing Firm'
  side:
    0x31:
      id: 'buy'
      doc: 'Buy'
    0x32:
      id: 'sell'
      doc: 'Sell'
    0x47:
      id: 'borrow'
      doc: 'Borrow'
    0x46:
      id: 'lend'
      doc: 'Lend'
    0x44:
      id: 'subscribe'
      doc: 'Subscribe'
    0x45:
      id: 'redeem'
      doc: 'Redeem'
  ord_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
    0x55:
      id: 'best_own_side'
      doc: 'Best Own Side'
  time_in_force:
    0x30:
      id: 'day'
      doc: 'Day'
    0x33:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel'
  cash_margin:
    0x31:
      id: 'cash'
      doc: 'Cash'
    0x32:
      id: 'open'
      doc: 'Open'
    0x33:
      id: 'close'
      doc: 'Close'
  settl_type:
    0x31:
      id: 'gross_trade_by_trade'
      doc: 'Gross Trade By Trade'
    0x32:
      id: 'multilateral_net'
      doc: 'Multilateral Net'
  settl_period:
    0x30:
      id: 't_plus_0'
      doc: 'T Plus 0'
    0x31:
      id: 't_plus_1'
      doc: 'T Plus 1'
    0x32:
      id: 't_plus_2'
      doc: 'T Plus 2'
    0x33:
      id: 't_plus_3'
      doc: 'T Plus 3'
  expiration_type:
    1:
      id: 'fixed_term'
      doc: 'Fixed Term'
  ord_status:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x31:
      id: 'partially_filled'
      doc: 'Partially Filled'
    0x32:
      id: 'filled'
      doc: 'Filled'
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x38:
      id: 'reject'
      doc: 'Reject'
  cxl_rej_reason:
    1:
      id: 'invalid_account'
      doc: 'Invalid Account'
    101:
      id: 'own_securities_account_format_invalid'
      doc: 'Own Securities Account Format Invalid'
    102:
      id: 'counterparty_securities_account_format_invalid'
      doc: 'Counterparty Securities Account Format Invalid'
    3:
      id: 'trading_unit_short_sale'
      doc: 'Trading Unit Short Sale'
    4:
      id: 'shareholder_short_sale'
      doc: 'Shareholder Short Sale'
    6:
      id: 'price_too_high'
      doc: 'Price Too High'
    601:
      id: 'price_above_upper_limit_regular_session'
      doc: 'Price Above Upper Limit Regular Session'
    602:
      id: 'price_above_upper_limit_after_hours_session'
      doc: 'Price Above Upper Limit After Hours Session'
    603:
      id: 'price_above_ceiling_in_call_matching'
      doc: 'Price Above Ceiling In Call Matching'
    605:
      id: 'price_above_ceiling_in_continuous_matching'
      doc: 'Price Above Ceiling In Continuous Matching'
    7:
      id: 'price_too_low'
      doc: 'Price Too Low'
    701:
      id: 'price_below_lower_limit_regular_session'
      doc: 'Price Below Lower Limit Regular Session'
    702:
      id: 'price_below_lower_limit_after_hours_session'
      doc: 'Price Below Lower Limit After Hours Session'
    705:
      id: 'price_below_floor_in_call_matching'
      doc: 'Price Below Floor In Call Matching'
    707:
      id: 'price_below_floor_in_continuous_matching'
      doc: 'Price Below Floor In Continuous Matching'
    8:
      id: 'price_error'
      doc: 'Price Error'
    801:
      id: 'price_not_a_multiple_of_the_tick_size'
      doc: 'Price Not A Multiple Of The Tick Size'
    804:
      id: 'price_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Price Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    807:
      id: 'stop_price_value_invalid'
      doc: 'Stop Price Value Invalid'
    9:
      id: 'quantity_invalid'
      doc: 'Quantity Invalid'
    901:
      id: 'quantity_above_maximum_regular_session'
      doc: 'Quantity Above Maximum Regular Session'
    902:
      id: 'quantity_below_minimum_regular_session'
      doc: 'Quantity Below Minimum Regular Session'
    906:
      id: 'quantity_not_a_multiple_of_the_buy_or_sell_unit'
      doc: 'Quantity Not A Multiple Of The Buy Or Sell Unit'
    909:
      id: 'quantity_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Quantity Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    912:
      id: 'minimum_trade_quantity_value_invalid'
      doc: 'Minimum Trade Quantity Value Invalid'
    12:
      id: 'account_invalid'
      doc: 'Account Invalid'
    1201:
      id: 'securities_account_does_not_exist'
      doc: 'Securities Account Does Not Exist'
    1202:
      id: 'securities_account_deactivated'
      doc: 'Securities Account Deactivated'
    13:
      id: 'account_restricted'
      doc: 'Account Restricted'
    1301:
      id: 'account_type_restricted_for_trading_unit'
      doc: 'Account Type Restricted For Trading Unit'
    1302:
      id: 'account_type_restricted_for_trading_unit_type'
      doc: 'Account Type Restricted For Trading Unit Type'
    1306:
      id: 'securities_account_restricted_for_trading_unit'
      doc: 'Securities Account Restricted For Trading Unit'
    1307:
      id: 'securities_account_restricted_for_trading_unit_type'
      doc: 'Securities Account Restricted For Trading Unit Type'
    1310:
      id: 'securities_account_not_allowed_this_business'
      doc: 'Securities Account Not Allowed This Business'
    1315:
      id: 'credit_account_may_not_buy_non_collateral_securities'
      doc: 'Credit Account May Not Buy Non Collateral Securities'
    1316:
      id: 'credit_account_margin_trading_allows_limit_orders_only'
      doc: 'Credit Account Margin Trading Allows Limit Orders Only'
    1909:
      id: 'negotiated_trade_pairing_failed'
      doc: 'Negotiated Trade Pairing Failed'
    22:
      id: 'agreement_number_error'
      doc: 'Agreement Number Error'
    2201:
      id: 'agreement_number_duplicate'
      doc: 'Agreement Number Duplicate'
    2203:
      id: 'agreement_number_format_invalid'
      doc: 'Agreement Number Format Invalid'
    23:
      id: 'invalid_trading_unit'
      doc: 'Invalid Trading Unit'
    2301:
      id: 'trading_unit_does_not_exist'
      doc: 'Trading Unit Does Not Exist'
    2302:
      id: 'trading_unit_deactivated'
      doc: 'Trading Unit Deactivated'
    2317:
      id: 'trading_unit_closed'
      doc: 'Trading Unit Closed'
    2320:
      id: 'trading_unit_value_invalid'
      doc: 'Trading Unit Value Invalid'
    2323:
      id: 'forced_liquidation_from_a_non_margin_trading_unit'
      doc: 'Forced Liquidation From A Non Margin Trading Unit'
    2324:
      id: 'margin_trading_from_a_non_margin_trading_unit'
      doc: 'Margin Trading From A Non Margin Trading Unit'
    2326:
      id: 'own_trading_unit_value_invalid'
      doc: 'Own Trading Unit Value Invalid'
    2327:
      id: 'submitting_trading_unit_value_invalid'
      doc: 'Submitting Trading Unit Value Invalid'
    2328:
      id: 'counterparty_trading_unit_value_invalid'
      doc: 'Counterparty Trading Unit Value Invalid'
    26:
      id: 'trading_unit_restricted'
      doc: 'Trading Unit Restricted'
    2601:
      id: 'trading_unit_restricted_for_security_code'
      doc: 'Trading Unit Restricted For Security Code'
    2602:
      id: 'trading_unit_restricted_for_security_type'
      doc: 'Trading Unit Restricted For Security Type'
    2605:
      id: 'trading_unit_not_allowed_this_business_type'
      doc: 'Trading Unit Not Allowed This Business Type'
    2609:
      id: 'custodian_mode_qfii_account_does_not_match_trading_unit'
      doc: 'Custodian Mode Qfii Account Does Not Match Trading Unit'
    44:
      id: 'invalid_business'
      doc: 'Invalid Business'
    4402:
      id: 'margin_trading_business_not_supported'
      doc: 'Margin Trading Business Not Supported'
    4404:
      id: 'credit_flag_value_error'
      doc: 'Credit Flag Value Error'
    45:
      id: 'odd_lot_sale_prohibited'
      doc: 'Odd Lot Sale Prohibited'
    4501:
      id: 'odd_lot_remainder_must_be_sold_at_once'
      doc: 'Odd Lot Remainder Must Be Sold At Once'
    51:
      id: 'business_type_error'
      doc: 'Business Type Error'
    5101:
      id: 'security_type_not_allowed_this_business_type'
      doc: 'Security Type Not Allowed This Business Type'
    5102:
      id: 'security_code_not_allowed_this_business_type'
      doc: 'Security Code Not Allowed This Business Type'
    5105:
      id: 'security_code_has_no_security_type'
      doc: 'Security Code Has No Security Type'
    5107:
      id: 'business_type_incorrect'
      doc: 'Business Type Incorrect'
    5108:
      id: 'side_value_error'
      doc: 'Side Value Error'
    5109:
      id: 'order_type_value_error'
      doc: 'Order Type Value Error'
    5110:
      id: 'trade_report_transaction_type_value_error'
      doc: 'Trade Report Transaction Type Value Error'
    5111:
      id: 'trade_report_business_type_value_error'
      doc: 'Trade Report Business Type Value Error'
    5112:
      id: 'trade_report_business_sub_type_value_error'
      doc: 'Trade Report Business Sub Type Value Error'
    5113:
      id: 'trade_report_type_value_error'
      doc: 'Trade Report Type Value Error'
    5114:
      id: 'trade_report_mode_value_error'
      doc: 'Trade Report Mode Value Error'
    5115:
      id: 'message_type_value_error'
      doc: 'Message Type Value Error'
    52:
      id: 'business_prohibited'
      doc: 'Business Prohibited'
    5201:
      id: 'security_suspended'
      doc: 'Security Suspended'
    5202:
      id: 'no_cancel_during_call_matching'
      doc: 'No Cancel During Call Matching'
    5203:
      id: 'no_submission_while_closed'
      doc: 'No Submission While Closed'
    5204:
      id: 'business_type_not_allowed_for_security_in_this_period'
      doc: 'Business Type Not Allowed For Security In This Period'
    53:
      id: 'no_order_to_cancel'
      doc: 'No Order To Cancel'
    5301:
      id: 'no_regular_order_to_cancel'
      doc: 'No Regular Order To Cancel'
    5303:
      id: 'cancel_security_code_differs_from_original_order'
      doc: 'Cancel Security Code Differs From Original Order'
    5304:
      id: 'cancel_securities_account_differs_from_original_order'
      doc: 'Cancel Securities Account Differs From Original Order'
    5305:
      id: 'original_order_of_cancel_is_not_a_buy_or_sell_order'
      doc: 'Original Order Of Cancel Is Not A Buy Or Sell Order'
    59:
      id: 'invalid_dealer'
      doc: 'Invalid Dealer'
    5901:
      id: 'own_dealer_code_not_enabled'
      doc: 'Own Dealer Code Not Enabled'
    5902:
      id: 'counterparty_dealer_code_not_enabled'
      doc: 'Counterparty Dealer Code Not Enabled'
    5903:
      id: 'own_dealer_code_value_invalid'
      doc: 'Own Dealer Code Value Invalid'
    5904:
      id: 'counterparty_dealer_code_value_invalid'
      doc: 'Counterparty Dealer Code Value Invalid'
    60:
      id: 'invalid_trader'
      doc: 'Invalid Trader'
    6001:
      id: 'own_trader_code_not_enabled'
      doc: 'Own Trader Code Not Enabled'
    6002:
      id: 'counterparty_trader_code_not_enabled'
      doc: 'Counterparty Trader Code Not Enabled'
    6003:
      id: 'own_trader_code_value_invalid'
      doc: 'Own Trader Code Value Invalid'
    6004:
      id: 'counterparty_trader_code_value_invalid'
      doc: 'Counterparty Trader Code Value Invalid'
    61:
      id: 'application_identifier_value_invalid'
      doc: 'Application Identifier Value Invalid'
    62:
      id: 'own_branch_identification_code_value_invalid'
      doc: 'Own Branch Identification Code Value Invalid'
    6201:
      id: 'counterparty_branch_identification_code_value_invalid'
      doc: 'Counterparty Branch Identification Code Value Invalid'
    63:
      id: 'settlement_method_value_invalid'
      doc: 'Settlement Method Value Invalid'
    64:
      id: 'settlement_period_value_invalid'
      doc: 'Settlement Period Value Invalid'
    65:
      id: 'time_in_force_type_value_invalid'
      doc: 'Time In Force Type Value Invalid'
    66:
      id: 'security_code_source_value_invalid'
      doc: 'Security Code Source Value Invalid'
    67:
      id: 'maximum_price_levels_value_invalid'
      doc: 'Maximum Price Levels Value Invalid'
    68:
      id: 'clearing_firm_code_value_invalid'
      doc: 'Clearing Firm Code Value Invalid'
    69:
      id: 'order_restrictions_value_invalid'
      doc: 'Order Restrictions Value Invalid'
    70:
      id: 'order_owner_type_value_invalid'
      doc: 'Order Owner Type Value Invalid'
    71:
      id: 'securities_holding_accounts_above_limit'
      doc: 'Securities Holding Accounts Above Limit'
    95:
      id: 'invalid_code'
      doc: 'Invalid Code'
    9501:
      id: 'security_code_does_not_exist'
      doc: 'Security Code Does Not Exist'
    9502:
      id: 'security_code_value_invalid'
      doc: 'Security Code Value Invalid'
    9503:
      id: 'security_code_format_invalid'
      doc: 'Security Code Format Invalid'
    96:
      id: 'order_time_format_invalid'
      doc: 'Order Time Format Invalid'
    98:
      id: 'order_number_invalid'
      doc: 'Order Number Invalid'
    9801:
      id: 'client_order_or_trade_report_number_format_invalid'
      doc: 'Client Order Or Trade Report Number Format Invalid'
    9802:
      id: 'original_client_order_or_trade_report_number_format_invalid'
      doc: 'Original Client Order Or Trade Report Number Format Invalid'
    9803:
      id: 'client_order_or_trade_report_number_duplicate'
      doc: 'Client Order Or Trade Report Number Duplicate'
    99:
      id: 'other_error'
      doc: 'Other Error'
    9902:
      id: 'order_validation_method_does_not_exist'
      doc: 'Order Validation Method Does Not Exist'
    9903:
      id: 'order_exception_inconsistent_with_message_definition'
      doc: 'Order Exception Inconsistent With Message Definition'
    20065:
      id: 'platform_closed'
      doc: 'Platform Closed'
    20101:
      id: 'application_identifier_error'
      doc: 'Application Identifier Error'
    20102:
      id: 'security_does_not_support_the_business'
      doc: 'Security Does Not Support The Business'
    20103:
      id: 'unpacking_failed'
      doc: 'Unpacking Failed'
    20104:
      id: 'platform_not_open'
      doc: 'Platform Not Open'
    20105:
      id: 'gateway_has_no_permission_for_trading_unit'
      doc: 'Gateway Has No Permission For Trading Unit'
    20106:
      id: 'field_value_error'
      doc: 'Field Value Error'
    20107:
      id: 'message_type_not_supported'
      doc: 'Message Type Not Supported'
    20108:
      id: 'order_platform_error'
      doc: 'Order Platform Error'
    20112:
      id: 'gateway_has_no_order_submission_permission'
      doc: 'Gateway Has No Order Submission Permission'
    29999:
      id: 'other_error_29999'
      doc: 'Other Error 29999'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x38:
      id: 'reject'
      doc: 'Reject'
    0x46:
      id: 'trade'
      doc: 'Trade'
  ord_rej_reason:
    1:
      id: 'invalid_account'
      doc: 'Invalid Account'
    101:
      id: 'own_securities_account_format_invalid'
      doc: 'Own Securities Account Format Invalid'
    102:
      id: 'counterparty_securities_account_format_invalid'
      doc: 'Counterparty Securities Account Format Invalid'
    3:
      id: 'trading_unit_short_sale'
      doc: 'Trading Unit Short Sale'
    4:
      id: 'shareholder_short_sale'
      doc: 'Shareholder Short Sale'
    6:
      id: 'price_too_high'
      doc: 'Price Too High'
    601:
      id: 'price_above_upper_limit_regular_session'
      doc: 'Price Above Upper Limit Regular Session'
    602:
      id: 'price_above_upper_limit_after_hours_session'
      doc: 'Price Above Upper Limit After Hours Session'
    603:
      id: 'price_above_ceiling_in_call_matching'
      doc: 'Price Above Ceiling In Call Matching'
    605:
      id: 'price_above_ceiling_in_continuous_matching'
      doc: 'Price Above Ceiling In Continuous Matching'
    7:
      id: 'price_too_low'
      doc: 'Price Too Low'
    701:
      id: 'price_below_lower_limit_regular_session'
      doc: 'Price Below Lower Limit Regular Session'
    702:
      id: 'price_below_lower_limit_after_hours_session'
      doc: 'Price Below Lower Limit After Hours Session'
    705:
      id: 'price_below_floor_in_call_matching'
      doc: 'Price Below Floor In Call Matching'
    707:
      id: 'price_below_floor_in_continuous_matching'
      doc: 'Price Below Floor In Continuous Matching'
    8:
      id: 'price_error'
      doc: 'Price Error'
    801:
      id: 'price_not_a_multiple_of_the_tick_size'
      doc: 'Price Not A Multiple Of The Tick Size'
    804:
      id: 'price_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Price Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    807:
      id: 'stop_price_value_invalid'
      doc: 'Stop Price Value Invalid'
    9:
      id: 'quantity_invalid'
      doc: 'Quantity Invalid'
    901:
      id: 'quantity_above_maximum_regular_session'
      doc: 'Quantity Above Maximum Regular Session'
    902:
      id: 'quantity_below_minimum_regular_session'
      doc: 'Quantity Below Minimum Regular Session'
    906:
      id: 'quantity_not_a_multiple_of_the_buy_or_sell_unit'
      doc: 'Quantity Not A Multiple Of The Buy Or Sell Unit'
    909:
      id: 'quantity_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Quantity Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    912:
      id: 'minimum_trade_quantity_value_invalid'
      doc: 'Minimum Trade Quantity Value Invalid'
    12:
      id: 'account_invalid'
      doc: 'Account Invalid'
    1201:
      id: 'securities_account_does_not_exist'
      doc: 'Securities Account Does Not Exist'
    1202:
      id: 'securities_account_deactivated'
      doc: 'Securities Account Deactivated'
    13:
      id: 'account_restricted'
      doc: 'Account Restricted'
    1301:
      id: 'account_type_restricted_for_trading_unit'
      doc: 'Account Type Restricted For Trading Unit'
    1302:
      id: 'account_type_restricted_for_trading_unit_type'
      doc: 'Account Type Restricted For Trading Unit Type'
    1306:
      id: 'securities_account_restricted_for_trading_unit'
      doc: 'Securities Account Restricted For Trading Unit'
    1307:
      id: 'securities_account_restricted_for_trading_unit_type'
      doc: 'Securities Account Restricted For Trading Unit Type'
    1310:
      id: 'securities_account_not_allowed_this_business'
      doc: 'Securities Account Not Allowed This Business'
    1315:
      id: 'credit_account_may_not_buy_non_collateral_securities'
      doc: 'Credit Account May Not Buy Non Collateral Securities'
    1316:
      id: 'credit_account_margin_trading_allows_limit_orders_only'
      doc: 'Credit Account Margin Trading Allows Limit Orders Only'
    1909:
      id: 'negotiated_trade_pairing_failed'
      doc: 'Negotiated Trade Pairing Failed'
    22:
      id: 'agreement_number_error'
      doc: 'Agreement Number Error'
    2201:
      id: 'agreement_number_duplicate'
      doc: 'Agreement Number Duplicate'
    2203:
      id: 'agreement_number_format_invalid'
      doc: 'Agreement Number Format Invalid'
    23:
      id: 'invalid_trading_unit'
      doc: 'Invalid Trading Unit'
    2301:
      id: 'trading_unit_does_not_exist'
      doc: 'Trading Unit Does Not Exist'
    2302:
      id: 'trading_unit_deactivated'
      doc: 'Trading Unit Deactivated'
    2317:
      id: 'trading_unit_closed'
      doc: 'Trading Unit Closed'
    2320:
      id: 'trading_unit_value_invalid'
      doc: 'Trading Unit Value Invalid'
    2323:
      id: 'forced_liquidation_from_a_non_margin_trading_unit'
      doc: 'Forced Liquidation From A Non Margin Trading Unit'
    2324:
      id: 'margin_trading_from_a_non_margin_trading_unit'
      doc: 'Margin Trading From A Non Margin Trading Unit'
    2326:
      id: 'own_trading_unit_value_invalid'
      doc: 'Own Trading Unit Value Invalid'
    2327:
      id: 'submitting_trading_unit_value_invalid'
      doc: 'Submitting Trading Unit Value Invalid'
    2328:
      id: 'counterparty_trading_unit_value_invalid'
      doc: 'Counterparty Trading Unit Value Invalid'
    26:
      id: 'trading_unit_restricted'
      doc: 'Trading Unit Restricted'
    2601:
      id: 'trading_unit_restricted_for_security_code'
      doc: 'Trading Unit Restricted For Security Code'
    2602:
      id: 'trading_unit_restricted_for_security_type'
      doc: 'Trading Unit Restricted For Security Type'
    2605:
      id: 'trading_unit_not_allowed_this_business_type'
      doc: 'Trading Unit Not Allowed This Business Type'
    2609:
      id: 'custodian_mode_qfii_account_does_not_match_trading_unit'
      doc: 'Custodian Mode Qfii Account Does Not Match Trading Unit'
    44:
      id: 'invalid_business'
      doc: 'Invalid Business'
    4402:
      id: 'margin_trading_business_not_supported'
      doc: 'Margin Trading Business Not Supported'
    4404:
      id: 'credit_flag_value_error'
      doc: 'Credit Flag Value Error'
    45:
      id: 'odd_lot_sale_prohibited'
      doc: 'Odd Lot Sale Prohibited'
    4501:
      id: 'odd_lot_remainder_must_be_sold_at_once'
      doc: 'Odd Lot Remainder Must Be Sold At Once'
    51:
      id: 'business_type_error'
      doc: 'Business Type Error'
    5101:
      id: 'security_type_not_allowed_this_business_type'
      doc: 'Security Type Not Allowed This Business Type'
    5102:
      id: 'security_code_not_allowed_this_business_type'
      doc: 'Security Code Not Allowed This Business Type'
    5105:
      id: 'security_code_has_no_security_type'
      doc: 'Security Code Has No Security Type'
    5107:
      id: 'business_type_incorrect'
      doc: 'Business Type Incorrect'
    5108:
      id: 'side_value_error'
      doc: 'Side Value Error'
    5109:
      id: 'order_type_value_error'
      doc: 'Order Type Value Error'
    5110:
      id: 'trade_report_transaction_type_value_error'
      doc: 'Trade Report Transaction Type Value Error'
    5111:
      id: 'trade_report_business_type_value_error'
      doc: 'Trade Report Business Type Value Error'
    5112:
      id: 'trade_report_business_sub_type_value_error'
      doc: 'Trade Report Business Sub Type Value Error'
    5113:
      id: 'trade_report_type_value_error'
      doc: 'Trade Report Type Value Error'
    5114:
      id: 'trade_report_mode_value_error'
      doc: 'Trade Report Mode Value Error'
    5115:
      id: 'message_type_value_error'
      doc: 'Message Type Value Error'
    52:
      id: 'business_prohibited'
      doc: 'Business Prohibited'
    5201:
      id: 'security_suspended'
      doc: 'Security Suspended'
    5202:
      id: 'no_cancel_during_call_matching'
      doc: 'No Cancel During Call Matching'
    5203:
      id: 'no_submission_while_closed'
      doc: 'No Submission While Closed'
    5204:
      id: 'business_type_not_allowed_for_security_in_this_period'
      doc: 'Business Type Not Allowed For Security In This Period'
    53:
      id: 'no_order_to_cancel'
      doc: 'No Order To Cancel'
    5301:
      id: 'no_regular_order_to_cancel'
      doc: 'No Regular Order To Cancel'
    5303:
      id: 'cancel_security_code_differs_from_original_order'
      doc: 'Cancel Security Code Differs From Original Order'
    5304:
      id: 'cancel_securities_account_differs_from_original_order'
      doc: 'Cancel Securities Account Differs From Original Order'
    5305:
      id: 'original_order_of_cancel_is_not_a_buy_or_sell_order'
      doc: 'Original Order Of Cancel Is Not A Buy Or Sell Order'
    59:
      id: 'invalid_dealer'
      doc: 'Invalid Dealer'
    5901:
      id: 'own_dealer_code_not_enabled'
      doc: 'Own Dealer Code Not Enabled'
    5902:
      id: 'counterparty_dealer_code_not_enabled'
      doc: 'Counterparty Dealer Code Not Enabled'
    5903:
      id: 'own_dealer_code_value_invalid'
      doc: 'Own Dealer Code Value Invalid'
    5904:
      id: 'counterparty_dealer_code_value_invalid'
      doc: 'Counterparty Dealer Code Value Invalid'
    60:
      id: 'invalid_trader'
      doc: 'Invalid Trader'
    6001:
      id: 'own_trader_code_not_enabled'
      doc: 'Own Trader Code Not Enabled'
    6002:
      id: 'counterparty_trader_code_not_enabled'
      doc: 'Counterparty Trader Code Not Enabled'
    6003:
      id: 'own_trader_code_value_invalid'
      doc: 'Own Trader Code Value Invalid'
    6004:
      id: 'counterparty_trader_code_value_invalid'
      doc: 'Counterparty Trader Code Value Invalid'
    61:
      id: 'application_identifier_value_invalid'
      doc: 'Application Identifier Value Invalid'
    62:
      id: 'own_branch_identification_code_value_invalid'
      doc: 'Own Branch Identification Code Value Invalid'
    6201:
      id: 'counterparty_branch_identification_code_value_invalid'
      doc: 'Counterparty Branch Identification Code Value Invalid'
    63:
      id: 'settlement_method_value_invalid'
      doc: 'Settlement Method Value Invalid'
    64:
      id: 'settlement_period_value_invalid'
      doc: 'Settlement Period Value Invalid'
    65:
      id: 'time_in_force_type_value_invalid'
      doc: 'Time In Force Type Value Invalid'
    66:
      id: 'security_code_source_value_invalid'
      doc: 'Security Code Source Value Invalid'
    67:
      id: 'maximum_price_levels_value_invalid'
      doc: 'Maximum Price Levels Value Invalid'
    68:
      id: 'clearing_firm_code_value_invalid'
      doc: 'Clearing Firm Code Value Invalid'
    69:
      id: 'order_restrictions_value_invalid'
      doc: 'Order Restrictions Value Invalid'
    70:
      id: 'order_owner_type_value_invalid'
      doc: 'Order Owner Type Value Invalid'
    71:
      id: 'securities_holding_accounts_above_limit'
      doc: 'Securities Holding Accounts Above Limit'
    95:
      id: 'invalid_code'
      doc: 'Invalid Code'
    9501:
      id: 'security_code_does_not_exist'
      doc: 'Security Code Does Not Exist'
    9502:
      id: 'security_code_value_invalid'
      doc: 'Security Code Value Invalid'
    9503:
      id: 'security_code_format_invalid'
      doc: 'Security Code Format Invalid'
    96:
      id: 'order_time_format_invalid'
      doc: 'Order Time Format Invalid'
    98:
      id: 'order_number_invalid'
      doc: 'Order Number Invalid'
    9801:
      id: 'client_order_or_trade_report_number_format_invalid'
      doc: 'Client Order Or Trade Report Number Format Invalid'
    9802:
      id: 'original_client_order_or_trade_report_number_format_invalid'
      doc: 'Original Client Order Or Trade Report Number Format Invalid'
    9803:
      id: 'client_order_or_trade_report_number_duplicate'
      doc: 'Client Order Or Trade Report Number Duplicate'
    99:
      id: 'other_error'
      doc: 'Other Error'
    9902:
      id: 'order_validation_method_does_not_exist'
      doc: 'Order Validation Method Does Not Exist'
    9903:
      id: 'order_exception_inconsistent_with_message_definition'
      doc: 'Order Exception Inconsistent With Message Definition'
    20065:
      id: 'platform_closed'
      doc: 'Platform Closed'
    20101:
      id: 'application_identifier_error'
      doc: 'Application Identifier Error'
    20102:
      id: 'security_does_not_support_the_business'
      doc: 'Security Does Not Support The Business'
    20103:
      id: 'unpacking_failed'
      doc: 'Unpacking Failed'
    20104:
      id: 'platform_not_open'
      doc: 'Platform Not Open'
    20105:
      id: 'gateway_has_no_permission_for_trading_unit'
      doc: 'Gateway Has No Permission For Trading Unit'
    20106:
      id: 'field_value_error'
      doc: 'Field Value Error'
    20107:
      id: 'message_type_not_supported'
      doc: 'Message Type Not Supported'
    20108:
      id: 'order_platform_error'
      doc: 'Order Platform Error'
    20112:
      id: 'gateway_has_no_order_submission_permission'
      doc: 'Gateway Has No Order Submission Permission'
    29999:
      id: 'other_error_29999'
      doc: 'Other Error 29999'
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
  trade_report_trans_type:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'cancel'
      doc: 'Cancel'
    2:
      id: 'replace'
      doc: 'Replace'
  trade_handling_instr:
    0x30:
      id: 'trade_confirm'
      doc: 'Trade Confirm'
    0x31:
      id: 'two_party_report'
      doc: 'Two Party Report'
    0x32:
      id: 'one_party_report_for_matching'
      doc: 'One Party Report For Matching'
    0x33:
      id: 'one_party_report_for_pass_through'
      doc: 'One Party Report For Pass Through'
    0x35:
      id: 'two_party_report_for_claim'
      doc: 'Two Party Report For Claim'
  trd_sub_type:
    0:
      id: 'unrestricted_share_transfer_or_not_applicable'
      doc: 'Unrestricted Share Transfer Or Not Applicable'
    1:
      id: 'restricted_share_transfer'
      doc: 'Restricted Share Transfer'
    10:
      id: 'rollover_keeping_counterparty'
      doc: 'Rollover Keeping Counterparty'
    11:
      id: 'rollover_changing_counterparty'
      doc: 'Rollover Changing Counterparty'
  trd_ack_status:
    0:
      id: 'accepted'
      doc: 'Accepted'
    1:
      id: 'rejected'
      doc: 'Rejected'
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
    100:
      id: 'unmatched'
      doc: 'Unmatched'
    101:
      id: 'matched'
      doc: 'Matched'
  trade_report_reject_reason:
    1:
      id: 'invalid_account'
      doc: 'Invalid Account'
    101:
      id: 'own_securities_account_format_invalid'
      doc: 'Own Securities Account Format Invalid'
    102:
      id: 'counterparty_securities_account_format_invalid'
      doc: 'Counterparty Securities Account Format Invalid'
    3:
      id: 'trading_unit_short_sale'
      doc: 'Trading Unit Short Sale'
    4:
      id: 'shareholder_short_sale'
      doc: 'Shareholder Short Sale'
    6:
      id: 'price_too_high'
      doc: 'Price Too High'
    601:
      id: 'price_above_upper_limit_regular_session'
      doc: 'Price Above Upper Limit Regular Session'
    602:
      id: 'price_above_upper_limit_after_hours_session'
      doc: 'Price Above Upper Limit After Hours Session'
    603:
      id: 'price_above_ceiling_in_call_matching'
      doc: 'Price Above Ceiling In Call Matching'
    605:
      id: 'price_above_ceiling_in_continuous_matching'
      doc: 'Price Above Ceiling In Continuous Matching'
    7:
      id: 'price_too_low'
      doc: 'Price Too Low'
    701:
      id: 'price_below_lower_limit_regular_session'
      doc: 'Price Below Lower Limit Regular Session'
    702:
      id: 'price_below_lower_limit_after_hours_session'
      doc: 'Price Below Lower Limit After Hours Session'
    705:
      id: 'price_below_floor_in_call_matching'
      doc: 'Price Below Floor In Call Matching'
    707:
      id: 'price_below_floor_in_continuous_matching'
      doc: 'Price Below Floor In Continuous Matching'
    8:
      id: 'price_error'
      doc: 'Price Error'
    801:
      id: 'price_not_a_multiple_of_the_tick_size'
      doc: 'Price Not A Multiple Of The Tick Size'
    804:
      id: 'price_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Price Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    807:
      id: 'stop_price_value_invalid'
      doc: 'Stop Price Value Invalid'
    9:
      id: 'quantity_invalid'
      doc: 'Quantity Invalid'
    901:
      id: 'quantity_above_maximum_regular_session'
      doc: 'Quantity Above Maximum Regular Session'
    902:
      id: 'quantity_below_minimum_regular_session'
      doc: 'Quantity Below Minimum Regular Session'
    906:
      id: 'quantity_not_a_multiple_of_the_buy_or_sell_unit'
      doc: 'Quantity Not A Multiple Of The Buy Or Sell Unit'
    909:
      id: 'quantity_value_invalid_must_be_zero_on_a_cancel_and_nonzero_otherwise'
      doc: 'Quantity Value Invalid Must Be Zero On A Cancel And Nonzero Otherwise'
    912:
      id: 'minimum_trade_quantity_value_invalid'
      doc: 'Minimum Trade Quantity Value Invalid'
    12:
      id: 'account_invalid'
      doc: 'Account Invalid'
    1201:
      id: 'securities_account_does_not_exist'
      doc: 'Securities Account Does Not Exist'
    1202:
      id: 'securities_account_deactivated'
      doc: 'Securities Account Deactivated'
    13:
      id: 'account_restricted'
      doc: 'Account Restricted'
    1301:
      id: 'account_type_restricted_for_trading_unit'
      doc: 'Account Type Restricted For Trading Unit'
    1302:
      id: 'account_type_restricted_for_trading_unit_type'
      doc: 'Account Type Restricted For Trading Unit Type'
    1306:
      id: 'securities_account_restricted_for_trading_unit'
      doc: 'Securities Account Restricted For Trading Unit'
    1307:
      id: 'securities_account_restricted_for_trading_unit_type'
      doc: 'Securities Account Restricted For Trading Unit Type'
    1310:
      id: 'securities_account_not_allowed_this_business'
      doc: 'Securities Account Not Allowed This Business'
    1315:
      id: 'credit_account_may_not_buy_non_collateral_securities'
      doc: 'Credit Account May Not Buy Non Collateral Securities'
    1316:
      id: 'credit_account_margin_trading_allows_limit_orders_only'
      doc: 'Credit Account Margin Trading Allows Limit Orders Only'
    1909:
      id: 'negotiated_trade_pairing_failed'
      doc: 'Negotiated Trade Pairing Failed'
    22:
      id: 'agreement_number_error'
      doc: 'Agreement Number Error'
    2201:
      id: 'agreement_number_duplicate'
      doc: 'Agreement Number Duplicate'
    2203:
      id: 'agreement_number_format_invalid'
      doc: 'Agreement Number Format Invalid'
    23:
      id: 'invalid_trading_unit'
      doc: 'Invalid Trading Unit'
    2301:
      id: 'trading_unit_does_not_exist'
      doc: 'Trading Unit Does Not Exist'
    2302:
      id: 'trading_unit_deactivated'
      doc: 'Trading Unit Deactivated'
    2317:
      id: 'trading_unit_closed'
      doc: 'Trading Unit Closed'
    2320:
      id: 'trading_unit_value_invalid'
      doc: 'Trading Unit Value Invalid'
    2323:
      id: 'forced_liquidation_from_a_non_margin_trading_unit'
      doc: 'Forced Liquidation From A Non Margin Trading Unit'
    2324:
      id: 'margin_trading_from_a_non_margin_trading_unit'
      doc: 'Margin Trading From A Non Margin Trading Unit'
    2326:
      id: 'own_trading_unit_value_invalid'
      doc: 'Own Trading Unit Value Invalid'
    2327:
      id: 'submitting_trading_unit_value_invalid'
      doc: 'Submitting Trading Unit Value Invalid'
    2328:
      id: 'counterparty_trading_unit_value_invalid'
      doc: 'Counterparty Trading Unit Value Invalid'
    26:
      id: 'trading_unit_restricted'
      doc: 'Trading Unit Restricted'
    2601:
      id: 'trading_unit_restricted_for_security_code'
      doc: 'Trading Unit Restricted For Security Code'
    2602:
      id: 'trading_unit_restricted_for_security_type'
      doc: 'Trading Unit Restricted For Security Type'
    2605:
      id: 'trading_unit_not_allowed_this_business_type'
      doc: 'Trading Unit Not Allowed This Business Type'
    2609:
      id: 'custodian_mode_qfii_account_does_not_match_trading_unit'
      doc: 'Custodian Mode Qfii Account Does Not Match Trading Unit'
    44:
      id: 'invalid_business'
      doc: 'Invalid Business'
    4402:
      id: 'margin_trading_business_not_supported'
      doc: 'Margin Trading Business Not Supported'
    4404:
      id: 'credit_flag_value_error'
      doc: 'Credit Flag Value Error'
    45:
      id: 'odd_lot_sale_prohibited'
      doc: 'Odd Lot Sale Prohibited'
    4501:
      id: 'odd_lot_remainder_must_be_sold_at_once'
      doc: 'Odd Lot Remainder Must Be Sold At Once'
    51:
      id: 'business_type_error'
      doc: 'Business Type Error'
    5101:
      id: 'security_type_not_allowed_this_business_type'
      doc: 'Security Type Not Allowed This Business Type'
    5102:
      id: 'security_code_not_allowed_this_business_type'
      doc: 'Security Code Not Allowed This Business Type'
    5105:
      id: 'security_code_has_no_security_type'
      doc: 'Security Code Has No Security Type'
    5107:
      id: 'business_type_incorrect'
      doc: 'Business Type Incorrect'
    5108:
      id: 'side_value_error'
      doc: 'Side Value Error'
    5109:
      id: 'order_type_value_error'
      doc: 'Order Type Value Error'
    5110:
      id: 'trade_report_transaction_type_value_error'
      doc: 'Trade Report Transaction Type Value Error'
    5111:
      id: 'trade_report_business_type_value_error'
      doc: 'Trade Report Business Type Value Error'
    5112:
      id: 'trade_report_business_sub_type_value_error'
      doc: 'Trade Report Business Sub Type Value Error'
    5113:
      id: 'trade_report_type_value_error'
      doc: 'Trade Report Type Value Error'
    5114:
      id: 'trade_report_mode_value_error'
      doc: 'Trade Report Mode Value Error'
    5115:
      id: 'message_type_value_error'
      doc: 'Message Type Value Error'
    52:
      id: 'business_prohibited'
      doc: 'Business Prohibited'
    5201:
      id: 'security_suspended'
      doc: 'Security Suspended'
    5202:
      id: 'no_cancel_during_call_matching'
      doc: 'No Cancel During Call Matching'
    5203:
      id: 'no_submission_while_closed'
      doc: 'No Submission While Closed'
    5204:
      id: 'business_type_not_allowed_for_security_in_this_period'
      doc: 'Business Type Not Allowed For Security In This Period'
    53:
      id: 'no_order_to_cancel'
      doc: 'No Order To Cancel'
    5301:
      id: 'no_regular_order_to_cancel'
      doc: 'No Regular Order To Cancel'
    5303:
      id: 'cancel_security_code_differs_from_original_order'
      doc: 'Cancel Security Code Differs From Original Order'
    5304:
      id: 'cancel_securities_account_differs_from_original_order'
      doc: 'Cancel Securities Account Differs From Original Order'
    5305:
      id: 'original_order_of_cancel_is_not_a_buy_or_sell_order'
      doc: 'Original Order Of Cancel Is Not A Buy Or Sell Order'
    59:
      id: 'invalid_dealer'
      doc: 'Invalid Dealer'
    5901:
      id: 'own_dealer_code_not_enabled'
      doc: 'Own Dealer Code Not Enabled'
    5902:
      id: 'counterparty_dealer_code_not_enabled'
      doc: 'Counterparty Dealer Code Not Enabled'
    5903:
      id: 'own_dealer_code_value_invalid'
      doc: 'Own Dealer Code Value Invalid'
    5904:
      id: 'counterparty_dealer_code_value_invalid'
      doc: 'Counterparty Dealer Code Value Invalid'
    60:
      id: 'invalid_trader'
      doc: 'Invalid Trader'
    6001:
      id: 'own_trader_code_not_enabled'
      doc: 'Own Trader Code Not Enabled'
    6002:
      id: 'counterparty_trader_code_not_enabled'
      doc: 'Counterparty Trader Code Not Enabled'
    6003:
      id: 'own_trader_code_value_invalid'
      doc: 'Own Trader Code Value Invalid'
    6004:
      id: 'counterparty_trader_code_value_invalid'
      doc: 'Counterparty Trader Code Value Invalid'
    61:
      id: 'application_identifier_value_invalid'
      doc: 'Application Identifier Value Invalid'
    62:
      id: 'own_branch_identification_code_value_invalid'
      doc: 'Own Branch Identification Code Value Invalid'
    6201:
      id: 'counterparty_branch_identification_code_value_invalid'
      doc: 'Counterparty Branch Identification Code Value Invalid'
    63:
      id: 'settlement_method_value_invalid'
      doc: 'Settlement Method Value Invalid'
    64:
      id: 'settlement_period_value_invalid'
      doc: 'Settlement Period Value Invalid'
    65:
      id: 'time_in_force_type_value_invalid'
      doc: 'Time In Force Type Value Invalid'
    66:
      id: 'security_code_source_value_invalid'
      doc: 'Security Code Source Value Invalid'
    67:
      id: 'maximum_price_levels_value_invalid'
      doc: 'Maximum Price Levels Value Invalid'
    68:
      id: 'clearing_firm_code_value_invalid'
      doc: 'Clearing Firm Code Value Invalid'
    69:
      id: 'order_restrictions_value_invalid'
      doc: 'Order Restrictions Value Invalid'
    70:
      id: 'order_owner_type_value_invalid'
      doc: 'Order Owner Type Value Invalid'
    71:
      id: 'securities_holding_accounts_above_limit'
      doc: 'Securities Holding Accounts Above Limit'
    95:
      id: 'invalid_code'
      doc: 'Invalid Code'
    9501:
      id: 'security_code_does_not_exist'
      doc: 'Security Code Does Not Exist'
    9502:
      id: 'security_code_value_invalid'
      doc: 'Security Code Value Invalid'
    9503:
      id: 'security_code_format_invalid'
      doc: 'Security Code Format Invalid'
    96:
      id: 'order_time_format_invalid'
      doc: 'Order Time Format Invalid'
    98:
      id: 'order_number_invalid'
      doc: 'Order Number Invalid'
    9801:
      id: 'client_order_or_trade_report_number_format_invalid'
      doc: 'Client Order Or Trade Report Number Format Invalid'
    9802:
      id: 'original_client_order_or_trade_report_number_format_invalid'
      doc: 'Original Client Order Or Trade Report Number Format Invalid'
    9803:
      id: 'client_order_or_trade_report_number_duplicate'
      doc: 'Client Order Or Trade Report Number Duplicate'
    99:
      id: 'other_error'
      doc: 'Other Error'
    9902:
      id: 'order_validation_method_does_not_exist'
      doc: 'Order Validation Method Does Not Exist'
    9903:
      id: 'order_exception_inconsistent_with_message_definition'
      doc: 'Order Exception Inconsistent With Message Definition'
    20065:
      id: 'platform_closed'
      doc: 'Platform Closed'
    20101:
      id: 'application_identifier_error'
      doc: 'Application Identifier Error'
    20102:
      id: 'security_does_not_support_the_business'
      doc: 'Security Does Not Support The Business'
    20103:
      id: 'unpacking_failed'
      doc: 'Unpacking Failed'
    20104:
      id: 'platform_not_open'
      doc: 'Platform Not Open'
    20105:
      id: 'gateway_has_no_permission_for_trading_unit'
      doc: 'Gateway Has No Permission For Trading Unit'
    20106:
      id: 'field_value_error'
      doc: 'Field Value Error'
    20107:
      id: 'message_type_not_supported'
      doc: 'Message Type Not Supported'
    20108:
      id: 'order_platform_error'
      doc: 'Order Platform Error'
    20112:
      id: 'gateway_has_no_order_submission_permission'
      doc: 'Gateway Has No Order Submission Permission'
    29999:
      id: 'other_error_29999'
      doc: 'Other Error 29999'

