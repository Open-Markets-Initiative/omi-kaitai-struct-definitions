# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Turquoise NativeTradingGatewayRecovery Ntgi v6.1.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Native Trading Gateway Recovery
#   Encoding: Native Trading Gateway Interface
#   Version: 6.1.2
#   Date: 10/07/2026
#   Specification: tq301-trading-gateway-native-issue-6-1-2.pdf
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: lseg_turquoise_nativetradinggatewayrecovery_ntgi_v6_1_2
  title: Lseg Turquoise NativeTradingGatewayRecovery Ntgi v6.1.2
  license: MIT-0
  endian: le

doc: 'London Stock Exchange Turquoise Native Trading Gateway Recovery Ntgi v6.1.2'

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Native Trading Gateway Message'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Native Trading Gateway Message Header'
      - id: payload
        size: message_header.message_length + 3 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::logon_message': logon_message
            'message_type::logon_reply_message': logon_reply_message
            'message_type::logout_message': logout_message
            'message_type::missed_message_request_message': missed_message_request_message
            'message_type::missed_message_request_ack_message': missed_message_request_ack_message
            'message_type::missed_message_report_message': missed_message_report_message
            'message_type::reject_message': reject_message
            'message_type::system_status_message': system_status_message
            'message_type::execution_report_message': execution_report_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::order_mass_cancel_report_message': order_mass_cancel_report_message
            'message_type::business_reject_message': business_reject_message
  message_header:
    seq:
      - id: start_of_message
        type: s1
        doc: 'Indicates the start of the message; always the binary value 2'
      - id: message_length
        type: s2
        doc: 'Length of the message from the Message Type field onwards'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Type of message'
  logon_message:
    seq:
      - id: comp_id
        type: str
        size: 25
        encoding: ASCII
        doc: 'Participant name'
      - id: password
        type: str
        size: 25
        encoding: ASCII
        doc: 'Password'
      - id: new_password
        type: str
        size: 25
        encoding: ASCII
        doc: 'New Password'
      - id: message_version
        type: s1
        doc: 'Message Version that will be used in this session. Always set to one (1)'
  logon_reply_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: password_expiry_day_count
        type: str
        size: 30
        encoding: ASCII
        doc: 'The number of days before the password will expire'
  logout_message:
    seq:
      - id: logout_reason
        type: str
        size: 20
        encoding: ASCII
        doc: 'Reason for the logout'
  missed_message_request_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: last_msg_seq_num
        type: s4
        doc: 'Last received Sequence Number. The response will include the LastMsgSeqNum message'
  missed_message_request_ack_message:
    seq:
      - id: missed_message_request_ack_response_type
        type: s1
        enum: missed_message_request_ack_response_type
        doc: 'Whether the recovery request is successful'
  missed_message_report_message:
    seq:
      - id: missed_message_report_response_type
        type: s1
        enum: missed_message_report_response_type
        doc: 'Whether all requested messages have been sent'
  reject_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: reject_reason
        type: str
        size: 30
        encoding: ASCII
        doc: 'Reject Reason'
      - id: rejected_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Message type of the rejected message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
  system_status_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: app_status
        type: s1
        enum: app_status
        doc: 'Availability of the recovery service for the partition'
  execution_report_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: execution_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique ID of the Execution Report. Unique across all partitions'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system: 11 character base 62 with an O prefix'
      - id: exec_type
        type: u1
        enum: exec_type
        doc: 'The reason the Execution Report is being sent'
      - id: execution_report_ref_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Execution ID of the trade being cancelled or corrected. Populated if ExecType is Trade Cancel'
      - id: order_status
        type: s1
        enum: order_status
        doc: 'The status of the order'
      - id: order_reject_code
        type: s4
        doc: 'Code specifying the reason for the reject. See TQ801'
      - id: executed_price
        type: decimal_s8_8
        doc: 'Value of this fill. Required if ExecType is Trade. Implied decimal with scale 1e-8'
      - id: executed_qty
        type: s4
        doc: 'Quantity that was executed in this fill'
      - id: leaves_qty
        type: s4
        doc: 'Quantity available for further execution'
      - id: waiver_flags
        type: u1
        doc: 'Pre-trade waiver flag. Populated when Execution Type is F or H'
      - id: display_qty
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: common_symbol
        type: str
        size: 8
        encoding: ASCII
        doc: 'MTF Common Symbol of the instrument'
      - id: side
        type: s1
        enum: side
        doc: 'Side of the order'
      - id: secondary_order_id
        type: u8
        doc: 'GTP Order ID'
      - id: counterparty
        type: str
        size: 11
        encoding: ASCII
        doc: 'Own Firm ID if internalised, Contra Party Firm ID if not cleared, else the CCP (ECCP, LCH, X-Clear)'
      - id: trade_liquidity_indicator
        type: u1
        enum: trade_liquidity_indicator
        doc: 'Whether the order added or removed liquidity. Only considered if Exec Type is Trade (F) or Trade Cancel (H)'
      - id: trade_match_id
        type: u8
        doc: 'Contains the trade identifier sent on the GTP market data feed'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: target_book
        type: u1
        enum: target_book
        doc: 'Indicates the order book that generated the execution report'
      - id: type_of_trade
        type: s1
        enum: type_of_trade
        doc: 'Indicates whether the executed portion of a passive order is visible or hidden'
      - id: capacity
        type: s1
        enum: capacity
        doc: 'Capacity of the order'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: public_order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique for each replenishment of a particular iceberg order. Base 62 in ASCII'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Fill size. Set to zero if there is no minimum fill size'
      - id: reputational_score
        type: s1
        doc: 'Reputational Score for a BI Participant at the time of the Turquoise Block Discovery match'
      - id: last_market
        type: u1
        enum: last_market
        doc: 'Market (Segment MIC) where execution took place'
      - id: peg_price_type
        type: u1
        enum: peg_price_type
        doc: 'Pegged Price Type of the order or trade'
      - id: owner_type
        type: u1
        enum: owner_type
        doc: 'Denotes whether the order is originated from a retail investor, retail liquidity provider or not'
      - id: waiver_flags_2
        type: u1
        doc: 'The pre-trade waiver flag introduced in MiFID II. Populated when ExecType is F and H'
      - id: reserved_21
        size: 21
        doc: 'Reserved for future use'
  transact_time:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds elapsed since midnight 1 January 1970 UTC, not counting leap seconds. Seconds since Unix epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanosecond portion of the Transact Time. Nanoseconds since Second epoch'
  order_cancel_reject_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system: 11 character base 62 with an O prefix'
      - id: cancel_reject_reason
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  order_mass_cancel_report_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: mass_cancel_response
        type: s1
        enum: mass_cancel_response
        doc: 'Whether the Mass Cancel Request was accepted or rejected'
      - id: mass_cancel_reject_reason
        type: s4
        doc: 'The code that identifies the reason the order mass cancel was rejected'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  business_reject_message:
    seq:
      - id: app_id
        type: s1
        enum: app_id
        doc: 'Partition ID'
      - id: sequence_no
        type: s4
        doc: 'Sequence number of the message'
      - id: reject_code
        type: s4
        doc: 'Code specifying the reason for the reject'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Participant specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system: 11 character base 62 with an O prefix'
      - id: transact_time
        type: transact_time
        doc: 'Composite. Nanoseconds since Unix epoch'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
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

enums:
  message_type:
    0x41:
      id: 'logon_message'
      doc: 'Allows the Participant and server to establish a session.'
    0x42:
      id: 'logon_reply_message'
      doc: 'Allows the server to acknowledge a Participant''s Logon.'
    0x35:
      id: 'logout_message'
      doc: 'Allows the Participant and server to terminate a session.'
    0x30:
      id: 'heartbeat_message'
      doc: 'Allows the Participant and server to exercise the communication line during periods of inactivity and verify that the interfaces at each end are available.'
    0x4d:
      id: 'missed_message_request_message'
      doc: 'Allows the Participant to subscribe to missed messages through the Recovery Channel.'
    0x4e:
      id: 'missed_message_request_ack_message'
      doc: 'Allows the server to acknowledge a Participant''s Missed Message Request.'
    0x50:
      id: 'missed_message_report_message'
      doc: 'Allows the Server to communicate the result of a Missed Message Request.'
    0x33:
      id: 'reject_message'
      doc: 'Allows the Server to reject a message that does not comply with the Native Trading Gateway messaging protocol.'
    0x6e:
      id: 'system_status_message'
      doc: 'Sent to All Native Recovery Channel Participants on the event of Order Cache Outage.'
    0x38:
      id: 'execution_report_message'
      doc: 'Indicates order accepted, rejected, executed, expired, cancelled, cancel/replaced, trade cancel, BI triggered or pending cancel.'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Indicates that an Order Cancel Request or Order Cancel/Replace Request has been rejected.'
    0x72:
      id: 'order_mass_cancel_report_message'
      doc: 'Indicates a mass order cancel request was accepted or rejected.'
    0x6a:
      id: 'business_reject_message'
      doc: 'Indicates that an application message could not be processed.'
  app_id:
    0:
      id: 'system_suspended_unknown_instrument'
      doc: 'System Suspended Unknown Instrument'
    1:
      id: 'partition_1'
      doc: 'Partition 1'
    2:
      id: 'partition_2'
      doc: 'Partition 2'
    3:
      id: 'partition_3'
      doc: 'Partition 3'
  missed_message_request_ack_response_type:
    0:
      id: 'successful'
      doc: 'Successful'
    1:
      id: 'recovery_request_limit_reached'
      doc: 'Recovery Request Limit Reached'
    2:
      id: 'invalid_app_id'
      doc: 'Invalid App Id'
    3:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
  missed_message_report_response_type:
    0:
      id: 'download_complete'
      doc: 'Download Complete'
    1:
      id: 'message_limit_reached'
      doc: 'Message Limit Reached'
    2:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
  app_status:
    1:
      id: 'recovery_service_resumed'
      doc: 'Recovery Service Resumed'
    2:
      id: 'recovery_service_not_available'
      doc: 'Recovery Service Not Available'
  exec_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x35:
      id: 'replaced'
      doc: 'Replaced'
    0x36:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x43:
      id: 'expired'
      doc: 'Expired'
    0x44:
      id: 'restated'
      doc: 'Restated'
    0x46:
      id: 'trade'
      doc: 'Trade'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
    0x4c:
      id: 'triggered'
      doc: 'Triggered'
  order_status:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'partially_filled'
      doc: 'Partially Filled'
    2:
      id: 'filled'
      doc: 'Filled'
    4:
      id: 'cancelled'
      doc: 'Cancelled'
    6:
      id: 'expired'
      doc: 'Expired'
    8:
      id: 'rejected'
      doc: 'Rejected'
    13:
      id: 'pending_cancel'
      doc: 'Pending Cancel'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  trade_liquidity_indicator:
    0x41:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    0x52:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    0x43:
      id: 'turquoise_dark_uncross_or_periodic_auctions_execution'
      doc: 'Turquoise Dark Uncross Or Periodic Auctions Execution'
    0x53:
      id: 'turquoise_block_discovery_execution_turquoise_dark_uncross'
      doc: 'Turquoise Block Discovery Execution Turquoise Dark Uncross'
    0x42:
      id: 'btf_trade'
      doc: 'Btf Trade'
  target_book:
    0:
      id: 'turquoise_dark_order_book_trqm_or_tqem'
      doc: 'Turquoise Dark Order Book Trqm Or Tqem'
    1:
      id: 'turquoise_lit_order_book_trqx_or_tqex'
      doc: 'Turquoise Lit Order Book Trqx Or Tqex'
    3:
      id: 'turquoise_dark_lit_sweep_trqm_and_trqx_or_tqem_and_tqex'
      doc: 'Turquoise Dark Lit Sweep Trqm And Trqx Or Tqem And Tqex'
    4:
      id: 'turquoise_periodic_auctions_order_book_trqa_or_tqea'
      doc: 'Turquoise Periodic Auctions Order Book Trqa Or Tqea'
  type_of_trade:
    0:
      id: 'visible'
      doc: 'Visible'
    1:
      id: 'hidden'
      doc: 'Hidden'
    2:
      id: 'not_specified'
      doc: 'Not Specified'
  capacity:
    1:
      id: 'matched_principal_mtch'
      doc: 'Matched Principal Mtch'
    2:
      id: 'dealing_on_own_account_deal'
      doc: 'Dealing On Own Account Deal'
    3:
      id: 'any_other_trading_capacity_aotc'
      doc: 'Any Other Trading Capacity Aotc'
  last_market:
    1:
      id: 'trqx_turquoise_lit_order_book'
      doc: 'Trqx Turquoise Lit Order Book'
    2:
      id: 'trqm_turquoise_dark_order_book'
      doc: 'Trqm Turquoise Dark Order Book'
    3:
      id: 'trqa_turquoise_periodic_auctions_order_book'
      doc: 'Trqa Turquoise Periodic Auctions Order Book'
    5:
      id: 'tqex_turquoise_lit_order_book_tghe'
      doc: 'Tqex Turquoise Lit Order Book Tghe'
    6:
      id: 'tqem_turquoise_dark_order_book_tghe'
      doc: 'Tqem Turquoise Dark Order Book Tghe'
    7:
      id: 'tqea_turquoise_periodic_auctions_order_book_tghe'
      doc: 'Tqea Turquoise Periodic Auctions Order Book Tghe'
  peg_price_type:
    0:
      id: 'default_midpoint'
      doc: 'Default Midpoint'
    1:
      id: 'closing_price_clse_tghl_only'
      doc: 'Closing Price Clse Tghl Only'
    2:
      id: 'midpoint'
      doc: 'Midpoint'
    10:
      id: 'best_bid'
      doc: 'Best Bid'
    11:
      id: 'best_offer'
      doc: 'Best Offer'
  owner_type:
    0:
      id: 'non_retail'
      doc: 'Non Retail'
    1:
      id: 'retail'
      doc: 'Retail'
    2:
      id: 'retail_lp'
      doc: 'Retail Lp'
  mass_cancel_response:
    0:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'accepted'
      doc: 'Accepted'

