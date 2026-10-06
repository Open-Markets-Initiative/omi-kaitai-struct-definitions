# ---------------------------------------------------------------------
# Kaitai struct definition for: Jse Itac EnhancedNativeTradingRecovery Ntgi v4.04
#
# Protocol:
#   Organization: JSE Limited
#   Protocol: Enhanced Native Trading Recovery
#   Encoding: Native Trading Gateway Interface
#   Version: 4.04
#   Date: 3/28/2024
#   Specification: JSE Volume 01D - Enhanced Native Trading Gateway (4.04).pdf
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
  id: jse_itac_enhancednativetradingrecovery_ntgi_v4_04
  title: Jse Itac EnhancedNativeTradingRecovery Ntgi v4.04
  license: GPL-3.0
  endian: le

doc: 'JSE Limited Integrated Trading and Clearing Enhanced Native Trading Recovery Ntgi v4.04'
doc-ref: https://www.jse.co.za/services/technologies/equity-market-trading-and-information-solution

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
        doc: 'Jse Native Trading Gateway Message Header'
      - id: payload
        size: message_header.message_length + 3 - 4
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::logon_message': logon_message
            'message_type::logon_response_message': logon_response_message
            'message_type::logout_message': logout_message
            'message_type::reject_message': reject_message
            'message_type::missed_message_request_message': missed_message_request_message
            'message_type::missed_message_request_ack_message': missed_message_request_ack_message
            'message_type::transmission_complete_message': transmission_complete_message
            'message_type::system_status_message': system_status_message
            'message_type::execution_report_message': execution_report_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::order_mass_cancel_report_message': order_mass_cancel_report_message
            'message_type::security_definition_response_message': security_definition_response_message
            'message_type::news_message': news_message
            'message_type::business_reject_message': business_reject_message
  message_header:
    seq:
      - id: start_of_message
        type: u1
        doc: 'Indicates the start of the message; always the binary value 2'
      - id: message_length
        type: u2
        doc: 'Length of the message from the Message Type field onwards'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Type of message rejected'
  logon_message:
    seq:
      - id: comp_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'Interface User ID (CompID) assigned to the client'
      - id: password
        type: str
        size: 25
        encoding: ASCII
        doc: 'Password assigned to the Interface User ID (CompID)'
      - id: new_password
        type: str
        size: 25
        encoding: ASCII
        doc: 'New password for Interface User ID (CompID)'
      - id: protocol_version
        type: s4
        doc: 'Specifies the version of protocol'
  logon_response_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: password_expiry
        type: s4
        doc: 'Number of days for password expiry'
  logout_message:
    seq:
      - id: reason
        type: str
        size: 20
        encoding: ASCII
        doc: 'Reason for the logout'
  reject_message:
    seq:
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: reject_reason
        type: str
        size: 30
        encoding: ASCII
        doc: 'Reason for the reject'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Type of message rejected'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
  missed_message_request_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
  missed_message_request_ack_message:
    seq:
      - id: missed_message_status
        type: u1
        enum: missed_message_status
        doc: 'Outcome of the missed message request'
  transmission_complete_message:
    seq:
      - id: transmission_status
        type: u1
        enum: transmission_status
        doc: 'Outcome of the missed message transmission'
  system_status_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Status of the partition'
  execution_report_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
      - id: execution_id
        type: str
        size: 21
        encoding: ASCII
        doc: 'Unique Identifier of the Execution Report'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Server specified identifier of the order'
      - id: execution_type
        type: u1
        enum: execution_type
        doc: 'Execution Type of the order'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Status of the order'
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: executed_price
        type: decimal_s8_8
        doc: 'Executed price of the trade in Zac. Implied decimal with scale 1e-8'
      - id: executed_quantity
        type: s4
        doc: 'Executed quantity'
      - id: leaves_quantity
        type: s4
        doc: 'Quantity available for further execution'
      - id: working_indicator
        type: u1
        enum: working_indicator
        doc: 'Whether the order is currently being worked on'
      - id: security_id
        type: s4
        doc: 'Identifier of the instrument the Execution Report is sent for'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: trader_mnemonic
        type: str
        size: 17
        encoding: ASCII
        doc: 'Concatenated identifier of the Trader Group and the JSE Trader ID'
      - id: account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client Account information'
      - id: is_market_ops_request
        type: u1
        enum: is_market_ops_request
        doc: 'Whether the request was submitted by Market Operations'
      - id: transact_time
        type: transact_time
        doc: 'Time the Execution Report was generated. Nanoseconds since Unix epoch'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
      - id: execution_instruction
        type: s1
        enum: execution_instruction
        doc: 'Whether hidden limit orders are excluded'
      - id: multi_leg_reporting_type
        type: u1
        enum: multi_leg_reporting_type
        doc: 'Type of trade'
      - id: last_opt_px
        type: decimal_s8_8
        doc: 'Price or Converted volatility of the executed options instrument. Implied decimal with scale 1e-8'
      - id: volatility
        type: decimal_s8_8
        doc: 'Volatility or Converted Volatility of the executed price of the options instrument. Implied decimal with scale 1e-8'
      - id: secondary_trade_report_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client specified additional order identifier of the new order or order cancel replace request'
      - id: indicator_flags
        type: indicator_flags
        doc: 'Aggressor or passive side of the trade'
  transact_time:
    seq:
      - id: transact_time_seconds
        type: u4
        doc: 'Seconds elapsed since midnight UTC of 1 January 1970, the first four bytes of Transact Time'
      - id: transact_time_nanoseconds
        type: u4
        doc: 'Nanoseconds elapsed since the second, the last four bytes of Transact Time. The document names them microseconds and states accuracy up to nanoseconds, the last three digits being zero'
  indicator_flags:
    meta:
      bit-endian: le
    seq:
      - id: aggressor_indicator
        type: b1
        doc: 'Whether the order initiator is the aggressor'
      - id: reserved_28
        type: b7
  order_cancel_reject_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Server specified identifier of the order'
      - id: transact_time
        type: transact_time
        doc: 'Time the Execution Report was generated. Nanoseconds since Unix epoch'
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
      - id: rfq_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client specified RFQ ID for a rejected order cancel submitted for a quote'
  order_mass_cancel_report_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: mass_cancel_status
        type: u1
        enum: mass_cancel_status
        doc: 'Outcome of the mass cancel request'
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: transact_time
        type: transact_time
        doc: 'Time the Execution Report was generated. Nanoseconds since Unix epoch'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
  security_definition_response_message:
    seq:
      - id: security_request_id
        type: str
        size: 10
        encoding: ASCII
        doc: 'Security Request ID of the Security Definition Request'
      - id: security_response_type
        type: u1
        enum: security_response_type
        doc: 'Outcome of the Security Definition Request'
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: security_id
        type: s4
        doc: 'Identifier of the instrument the Execution Report is sent for'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'Value submitted in the Security Definition Request'
  news_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
      - id: orig_time
        type: str
        size: 24
        encoding: ASCII
        doc: 'Time the announcement was published'
      - id: urgency
        type: u1
        enum: urgency
        doc: 'Urgency of the announcement'
      - id: headline
        type: str
        size: 100
        encoding: ASCII
        doc: 'Headline or subject of market operations announcement'
      - id: text
        type: str
        size: 750
        encoding: ASCII
        doc: 'Text of the market operations announcement'
      - id: instruments
        type: str
        size: 100
        encoding: ASCII
        doc: 'Pipe separated list of symbols of the instruments the announcements relate to'
      - id: underlyings
        type: str
        size: 100
        encoding: ASCII
        doc: 'Pipe separated list of symbols of underlyings the instruments relate to'
      - id: firm_list
        type: str
        size: 54
        encoding: ASCII
        doc: 'Pipe separated list of firms that the announcement should be sent to'
      - id: user_list
        type: str
        size: 54
        encoding: ASCII
        doc: 'Pipe separated list of users that the announcement should be sent to'
  business_reject_message:
    seq:
      - id: partition_id
        type: u1
        doc: 'Identity of the matching partition the request relates to'
      - id: sequence_number
        type: s4
        doc: 'Sequence number immediately after that of the last message received from the partition'
      - id: reject_code
        type: s4
        doc: 'Will be zero or three if login is accepted'
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Server specified identifier of the order'
      - id: transact_time
        type: transact_time
        doc: 'Time the Execution Report was generated. Nanoseconds since Unix epoch'
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

enums:
  message_type:
    0x41:
      id: 'logon_message'
      doc: 'Allows the client to login to the server.'
    0x42:
      id: 'logon_response_message'
      doc: 'Used by the server to accept or reject a login request.'
    0x35:
      id: 'logout_message'
      doc: 'Used by the client or server to terminate a session.'
    0x30:
      id: 'heartbeat_message'
      doc: 'Used by the client and server to exercise the communication line during periods of inactivity.'
    0x33:
      id: 'reject_message'
      doc: 'Used by the server to reject a message that does not comply with the specifications.'
    0x4d:
      id: 'missed_message_request_message'
      doc: 'Used by the client to recover missed messages through the Recovery Channel.'
    0x4e:
      id: 'missed_message_request_ack_message'
      doc: 'Used by the server to accept or reject a request for missed messages.'
    0x50:
      id: 'transmission_complete_message'
      doc: 'Used by the server to indicate that the transmission of missed messages is complete.'
    0x6e:
      id: 'system_status_message'
      doc: 'Disseminated in the recovery channel to indicate the status of a partition.'
    0x38:
      id: 'execution_report_message'
      doc: 'Indicates the status of an order.'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Indicates that an order cancel or cancel replace request has been rejected.'
    0x72:
      id: 'order_mass_cancel_report_message'
      doc: 'Indicates the outcome of an order mass cancel request.'
    0x52:
      id: 'security_definition_response_message'
      doc: 'Indicates that a Security Definition Request has been accepted or rejected.'
    0x5a:
      id: 'news_message'
      doc: 'Carries a market operations announcement.'
    0x6a:
      id: 'business_reject_message'
      doc: 'Indicates that an application message could not be processed.'
  missed_message_status:
    0:
      id: 'request_accepted_successful'
      doc: 'Request Accepted Successful'
    1:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    2:
      id: 'invalid_partition_id'
      doc: 'Invalid Partition Id'
    3:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
  transmission_status:
    0:
      id: 'all_messages_transmitted'
      doc: 'All Messages Transmitted'
    1:
      id: 'message_limit_reached'
      doc: 'Message Limit Reached'
    3:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
  system_status:
    1:
      id: 'recovery_service_resumed'
      doc: 'Recovery Service Resumed'
    2:
      id: 'recovery_service_unavailable'
      doc: 'Recovery Service Unavailable'
    3:
      id: 'partition_suspended'
      doc: 'Partition Suspended'
  execution_type:
    0x30:
      id: 'new_field'
      doc: 'New'
    0x34:
      id: 'cancelled'
      doc: 'Cancelled'
    0x35:
      id: 'amended_modified'
      doc: 'Amended Modified'
    0x38:
      id: 'rejected'
      doc: 'Rejected'
    0x39:
      id: 'suspended'
      doc: 'Suspended'
    0x43:
      id: 'expired'
      doc: 'Expired'
    0x46:
      id: 'trade'
      doc: 'Trade'
    0x47:
      id: 'trade_correct'
      doc: 'Trade Correct'
    0x48:
      id: 'trade_cancel'
      doc: 'Trade Cancel'
    0x44:
      id: 'restated'
      doc: 'Restated'
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
    9:
      id: 'suspended'
      doc: 'Suspended'
  working_indicator:
    0:
      id: 'unset'
      doc: 'Unset'
    1:
      id: 'order_is_being_worked'
      doc: 'Order Is Being Worked'
    2:
      id: 'order_is_not_currently_in_a_working_state'
      doc: 'Order Is Not Currently In A Working State'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  is_market_ops_request:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  order_book:
    1:
      id: 'regular'
      doc: 'Regular'
    9:
      id: 'bulletin_board'
      doc: 'Bulletin Board'
    11:
      id: 'negotiated_trades'
      doc: 'Negotiated Trades'
    51:
      id: 'fx_auction'
      doc: 'Fx Auction'
  execution_instruction:
    0:
      id: 'do_not_exclude_hidden_limit_orders'
      doc: 'Do Not Exclude Hidden Limit Orders'
    1:
      id: 'exclude_hidden_limit_orders'
      doc: 'Exclude Hidden Limit Orders'
  multi_leg_reporting_type:
    1:
      id: 'trade_of_single_instrument'
      doc: 'Trade Of Single Instrument'
    2:
      id: 'leg_trade_of_a_multi_leg_instrument'
      doc: 'Leg Trade Of A Multi Leg Instrument'
    3:
      id: 'trade_of_multi_leg_instrument'
      doc: 'Trade Of Multi Leg Instrument'
  mass_cancel_status:
    0:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'accepted'
      doc: 'Accepted'
  security_response_type:
    0:
      id: 'rejected'
      doc: 'Rejected'
    1:
      id: 'accepted'
      doc: 'Accepted'
  security_type:
    1:
      id: 'future'
      doc: 'Future'
    2:
      id: 'call_option'
      doc: 'Call Option'
    3:
      id: 'put_option'
      doc: 'Put Option'
    99:
      id: 'fwd_fwd'
      doc: 'Fwd Fwd'
    100:
      id: 'delta_option'
      doc: 'Delta Option'
  urgency:
    0x30:
      id: 'regular'
      doc: 'Regular'
    0x31:
      id: 'high_priority'
      doc: 'High Priority'
    0x32:
      id: 'low_priority'
      doc: 'Low Priority'

