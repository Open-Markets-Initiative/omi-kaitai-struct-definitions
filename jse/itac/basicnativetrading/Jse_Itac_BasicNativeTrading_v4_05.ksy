# ---------------------------------------------------------------------
# Kaitai struct definition for: Jse Itac BasicNativeTrading Ntgi v4.05
#
# Protocol:
#   Organization: JSE Limited
#   Protocol: Basic Native Trading Gateway
#   Encoding: Native Trading Gateway Interface
#   Version: 4.05
#   Date: 5/28/2024
#   Specification: JSE Volume 01E - Basic Native Trading Gateway (4.05).pdf
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
  id: jse_itac_basicnativetrading_ntgi_v4_05
  title: Jse Itac BasicNativeTrading Ntgi v4.05
  license: GPL-3.0
  endian: le

doc: 'JSE Limited Integrated Trading and Clearing Basic Native Trading Gateway Ntgi v4.05'
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
            'message_type::new_order_message': new_order_message
            'message_type::order_cancel_request_message': order_cancel_request_message
            'message_type::order_mass_cancel_request_message': order_mass_cancel_request_message
            'message_type::order_cancel_replace_request_message': order_cancel_replace_request_message
            'message_type::new_order_cross_message': new_order_cross_message
            'message_type::execution_report_message': execution_report_message
            'message_type::order_cancel_reject_message': order_cancel_reject_message
            'message_type::order_mass_cancel_report_message': order_mass_cancel_report_message
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
  new_order_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: security_id
        type: s4
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
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
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of the order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: expire_time
        type: str
        size: 17
        encoding: ASCII
        doc: 'Date and time the order expires on'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_quantity
        type: s4
        doc: 'Total order quantity'
      - id: display_quantity
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Execution Size that needs to be specified for a Pegged or Pegged Limit Order'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: stop_price
        type: decimal_s8_8
        doc: 'Stop price or Hard Limit. Implied decimal with scale 1e-8'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity in which the order is submitted'
      - id: cancel_on_disconnect
        type: u1
        enum: cancel_on_disconnect
        doc: 'Whether the order is cancelled on disconnect'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
      - id: execution_instruction
        type: s1
        enum: execution_instruction
        doc: 'Whether the order is included in the end of day volume auction uncross'
      - id: order_sub_type
        type: u1
        enum: order_sub_type
        doc: 'Whether the order is a pegged order'
      - id: self_trade_prevention_key
        type: str
        size: 12
        encoding: ASCII
        if: _parent.message_header.message_length > 105
        doc: 'Client specified identifier of order relevant to self-match'
  order_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: orig_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the order being cancelled'
      - id: order_id_alpha_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: security_id
        type: s4
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
      - id: trader_mnemonic
        type: str
        size: 17
        encoding: ASCII
        doc: 'Concatenated identifier of the Trader Group and the JSE Trader ID'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
  order_mass_cancel_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: mass_cancel_request_type
        type: u1
        enum: mass_cancel_request_type
        doc: 'Scope of the mass cancel request'
      - id: security_id
        type: s4
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        doc: 'Identifier of the segment for which orders will be cancelled'
      - id: order_sub_type
        type: u1
        enum: order_sub_type
        doc: 'Whether the order is a pegged order'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
  order_cancel_replace_request_message:
    seq:
      - id: client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the rejected message if it is available'
      - id: original_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the order being amended'
      - id: order_id_string_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
      - id: security_id
        type: s4
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
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
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of the order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: expire_time
        type: str
        size: 17
        encoding: ASCII
        doc: 'Date and time the order expires on'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: order_quantity
        type: s4
        doc: 'Total order quantity'
      - id: display_quantity
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: minimum_quantity
        type: s4
        doc: 'Minimum Execution Size that needs to be specified for a Pegged or Pegged Limit Order'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: stop_price
        type: decimal_s8_8
        doc: 'Stop price or Hard Limit. Implied decimal with scale 1e-8'
      - id: order_book
        type: u1
        enum: order_book
        doc: 'Order book the order belongs to'
  new_order_cross_message:
    seq:
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier of the Cross Order, unique across the trading day'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the Cross Order'
      - id: buy_side_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the buy side'
      - id: buy_side_capacity
        type: u1
        enum: buy_side_capacity
        doc: 'Capacity of the buy side'
      - id: buy_side_trader_mnemonic
        type: str
        size: 17
        encoding: ASCII
        doc: 'Concatenated identifier of the Trader Group and the JSE Trader ID'
      - id: buy_side_account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client Account information of the buy side'
      - id: sell_side_client_order_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Client specified identifier of the sell side'
      - id: sell_side_capacity
        type: u1
        enum: sell_side_capacity
        doc: 'Capacity of the sell side'
      - id: sell_side_trader_mnemonic
        type: str
        size: 17
        encoding: ASCII
        doc: 'Concatenated identifier of the Trader Group and the JSE Trader ID'
      - id: sell_side_account
        type: str
        size: 10
        encoding: ASCII
        doc: 'Client Account information of the sell side'
      - id: security_id
        type: s4
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of the order'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: limit_price
        type: decimal_s8_8
        doc: 'Limit price. Implied decimal with scale 1e-8'
      - id: order_quantity
        type: s4
        doc: 'Total order quantity'
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
      - id: order_id_alpha_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
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
        doc: 'Numeric Identifier of the instrument for which the order is submitted'
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
        doc: 'Whether the order is included in the end of day volume auction uncross'
      - id: cross_id
        type: str
        size: 20
        encoding: ASCII
        doc: 'Identifier of the Cross Order, unique across the trading day'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'The type of the Cross Order'
      - id: display_quantity
        type: s4
        doc: 'Maximum quantity that may be displayed'
      - id: public_order_id
        type: str
        size: 12
        encoding: ASCII
        doc: 'Server specified public order identifier of the order'
      - id: indicator_flags
        type: indicator_flags
        doc: 'Aggressor or passive side of the trade'
      - id: liquidity_indicator
        type: u1
        enum: liquidity_indicator
        doc: 'Whether the fill was a result of a liquidity provider providing or a liquidity taker taking the liquidity'
      - id: type_of_trade
        type: u1
        enum: type_of_trade
        doc: 'Whether the executed portion is visible or hidden'
      - id: self_trade_prevention_key
        type: str
        size: 12
        encoding: ASCII
        if: _parent.message_header.message_length > 165
        doc: 'Client specified identifier of order relevant to self-match'
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
      - id: order_id_alpha_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
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
      - id: order_id_alpha_12
        type: str
        size: 12
        encoding: ASCII
        doc: 'Unique identifier of the order assigned by the matching system'
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
    0x44:
      id: 'new_order_message'
      doc: 'Allows the client to submit a new order.'
    0x46:
      id: 'order_cancel_request_message'
      doc: 'Allows the client to cancel an Open or Parked order.'
    0x71:
      id: 'order_mass_cancel_request_message'
      doc: 'Allows the client to mass cancel orders.'
    0x47:
      id: 'order_cancel_replace_request_message'
      doc: 'Allows the client to modify an Open or Parked order.'
    0x43:
      id: 'new_order_cross_message'
      doc: 'Allows the client to submit an internal cross order.'
    0x38:
      id: 'execution_report_message'
      doc: 'Indicates the status of an order.'
    0x39:
      id: 'order_cancel_reject_message'
      doc: 'Indicates that an order cancel or cancel replace request has been rejected.'
    0x72:
      id: 'order_mass_cancel_report_message'
      doc: 'Indicates the outcome of an order mass cancel request.'
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
  order_type:
    1:
      id: 'market_order'
      doc: 'Market Order'
    2:
      id: 'limit_order'
      doc: 'Limit Order'
    3:
      id: 'stop_order'
      doc: 'Stop Order'
    4:
      id: 'stop_limit_order'
      doc: 'Stop Limit Order'
    50:
      id: 'pegged'
      doc: 'Pegged'
    51:
      id: 'pegged_limit_order'
      doc: 'Pegged Limit Order'
  time_in_force:
    0:
      id: 'day'
      doc: 'Day'
    1:
      id: 'good_till_cancel_gtc'
      doc: 'Good Till Cancel Gtc'
    3:
      id: 'immediate_or_cancel_ioc'
      doc: 'Immediate Or Cancel Ioc'
    4:
      id: 'fill_or_kill_fok'
      doc: 'Fill Or Kill Fok'
    5:
      id: 'at_the_open_opg'
      doc: 'At The Open Opg'
    6:
      id: 'good_till_date_gtd'
      doc: 'Good Till Date Gtd'
    8:
      id: 'good_till_time_gtt'
      doc: 'Good Till Time Gtt'
    9:
      id: 'good_for_auction_gfa'
      doc: 'Good For Auction Gfa'
    10:
      id: 'at_the_close_atc'
      doc: 'At The Close Atc'
    12:
      id: 'closing_price_cross_cpx'
      doc: 'Closing Price Cross Cpx'
    50:
      id: 'good_for_eod_volume_auction_uncross_gdx'
      doc: 'Good For Eod Volume Auction Uncross Gdx'
    51:
      id: 'good_for_intraday_auction_gfx'
      doc: 'Good For Intraday Auction Gfx'
  side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  capacity:
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'agency'
      doc: 'Agency'
  cancel_on_disconnect:
    0:
      id: 'do_not_cancel'
      doc: 'Do Not Cancel'
    1:
      id: 'cancel'
      doc: 'Cancel'
  order_book:
    1:
      id: 'regular'
      doc: 'Regular'
  execution_instruction:
    0:
      id: 'none'
      doc: 'None'
    2:
      id: 'include_in_eod_volume_auction_uncross'
      doc: 'Include In Eod Volume Auction Uncross'
  order_sub_type:
    0:
      id: 'order'
      doc: 'Order'
    50:
      id: 'pegged_to_mid'
      doc: 'Pegged To Mid'
    51:
      id: 'pegged_to_bid'
      doc: 'Pegged To Bid'
    52:
      id: 'pegged_to_offer'
      doc: 'Pegged To Offer'
  mass_cancel_request_type:
    3:
      id: 'all_firm_orders_for_instrument'
      doc: 'All Firm Orders For Instrument'
    4:
      id: 'all_firm_orders_for_segment'
      doc: 'All Firm Orders For Segment'
    7:
      id: 'all_orders_for_client_interface_user_id'
      doc: 'All Orders For Client Interface User Id'
    8:
      id: 'all_orders_for_firm'
      doc: 'All Orders For Firm'
    9:
      id: 'client_interface_user_id_orders_for_instrument'
      doc: 'Client Interface User Id Orders For Instrument'
    15:
      id: 'client_interface_user_id_orders_for_segment'
      doc: 'Client Interface User Id Orders For Segment'
  cross_type:
    5:
      id: 'internal_cross'
      doc: 'Internal Cross'
    50:
      id: 'internal_cross_price_adjustable'
      doc: 'Internal Cross Price Adjustable'
  buy_side_capacity:
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'agency'
      doc: 'Agency'
  sell_side_capacity:
    2:
      id: 'principal'
      doc: 'Principal'
    3:
      id: 'agency'
      doc: 'Agency'
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
  is_market_ops_request:
    0:
      id: 'no_field'
      doc: 'No'
    1:
      id: 'yes_field'
      doc: 'Yes'
  liquidity_indicator:
    0:
      id: 'unset'
      doc: 'Unset'
    1:
      id: 'added_liquidity'
      doc: 'Added Liquidity'
    2:
      id: 'removed_liquidity'
      doc: 'Removed Liquidity'
    4:
      id: 'auction'
      doc: 'Auction'
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
    3:
      id: 'pegged'
      doc: 'Pegged'
  mass_cancel_status:
    0:
      id: 'rejected'
      doc: 'Rejected'
    7:
      id: 'accepted'
      doc: 'Accepted'
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

