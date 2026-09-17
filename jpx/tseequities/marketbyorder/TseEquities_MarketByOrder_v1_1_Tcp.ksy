# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx TseEquities MarketByOrder Flex v1.1
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Market By Order
#   Encoding: Flex
#   Version: 1.1
#   Date: 11/20/2024
#   Specification: TSEarrowhead_FLEX_MarketbyOrderSpecifications_ver.1.1.pdf
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
  id: jpx_tseequities_marketbyorder_flex_v1_1_tcp
  title: Jpx TseEquities MarketByOrder Flex v1.1
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Tokyo Stock Exchange Equities Market By Order Flex v1.1'

seq:
  - id: tcp_packet_header
    type: tcp_packet_header_struct
    doc: 'Jpx Flex Tcp packet header carrying length prefix and packet type discriminator'
  - id: tcp_payload
    size: tcp_packet_header.packet_length - 3
    type:
      switch-on: tcp_packet_header.packet_type
      cases:
        'packet_type::login_request_message': login_request_message
        'packet_type::login_result_message': login_result_message
        'packet_type::message_response_message': message_response_message
        'packet_type::end_of_message_message': end_of_message_message

types:
  tcp_packet_header_struct:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of remaining bytes after this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'First byte of the Tcp packet identifying the packet type used as dispatch key'
  login_request_message:
    seq:
      - id: user_id
        type: str
        size: 6
        encoding: ASCII
        doc: 'User ID for login authentication'
      - id: multicast_group_number
        type: u1
        doc: 'Multicast Group Number for the request target'
      - id: number_of_system_reboots
        type: u1
        doc: 'For retransmission set to the number of times the system has been rebooted; for snapshot set to 0'
      - id: sequence_number
        type: u4
        doc: 'For retransmission set to the first sequence number for the request; for snapshot set to 0'
      - id: requested_message_count
        size: 3
        doc: 'For retransmission set to the number of messages from the first sequence number; for snapshot set to 0'
  login_result_message:
    seq:
      - id: multicast_group_number
        type: u1
        doc: 'Multicast Group Number for the request target'
      - id: result_code
        type: u1
        enum: result_code
        doc: 'Set to the result code of the login request'
  message_response_message:
    seq:
      - id: data
        size-eos: true
        doc: 'Variable length payload of FLEX tags including their packet headers'
  end_of_message_message:
    seq:
      - id: multicast_group_number
        type: u1
        doc: 'Multicast Group Number for the request target'
      - id: number_of_system_reboots
        type: u1
        doc: 'For retransmission set to the number of times the system has been rebooted; for snapshot set to 0'
      - id: next_sequence_number
        type: u4
        doc: 'For retransmission set to 0; for snapshot indicates the next multicast transmission sequence number that should be received after capturing the snapshot'

enums:
  message_type:
    0x54:
      id: 'seconds_timestamp_message'
      doc: 'Provides information about the time of processing on the Trading Server to the nearest second. Always delivered at the time the information is generated, except for Reset and Communication Control. Only one tag is delivered per process and stored at the top of the first packet.'
    0x4f:
      id: 'trading_status_message'
      doc: 'Provides information about the status of trading on a per-issue basis. Delivered when there is a change in the tag.'
    0x4b:
      id: 'execution_summary_message'
      doc: 'Provides summary information about execution. Delivered when an execution occurs.'
    0x41:
      id: 'add_order_message'
      doc: 'Provides information about book registration. Delivered when a new order or modification order is registered.'
    0x45:
      id: 'order_executed_message'
      doc: 'Provides information about registered orders in case of Zaraba execution. Delivered when an execution occurs in Zaraba.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'Provides information about registered orders in case of Itayose execution. Delivered when an execution occurs by the Itayose method or while an SQ or STQ is displayed.'
    0x44:
      id: 'order_delete_message'
      doc: 'Provides information about order deletion from the order book. Delivered when an order is deleted via a cancel order or a modification order or when a registered order expires.'
    0x52:
      id: 'reset_message'
      doc: 'A tag requesting the resetting (i.e. cancellation) of all distributed information. When the user receives this tag, the user must clear all valid A tags.'
    0x4c:
      id: 'communication_control_message'
      doc: 'Provides information about communication control. Delivered when communication starts and ends, and in between at minute intervals.'
  market_status:
    11:
      id: 'morning_session_order_acceptance_time'
      doc: 'Morning Session Order Acceptance Time'
    12:
      id: 'morning_session_trading_hours'
      doc: 'Morning Session Trading Hours'
    19:
      id: 'end_of_morning_session'
      doc: 'End Of Morning Session'
    21:
      id: 'afternoon_session_order_acceptance_time'
      doc: 'Afternoon Session Order Acceptance Time'
    22:
      id: 'afternoon_session_trading_hours'
      doc: 'Afternoon Session Trading Hours'
    23:
      id: 'afternoon_session_preclosing'
      doc: 'Afternoon Session Preclosing'
    29:
      id: 'end_of_afternoon_session'
      doc: 'End Of Afternoon Session'
  short_selling_status:
    0:
      id: 'short_selling_regulation_is_not_applied'
      doc: 'Short Selling Regulation Is Not Applied'
    1:
      id: 'short_selling_regulation_is_applied'
      doc: 'Short Selling Regulation Is Applied'
  pricing_method:
    1:
      id: 'itayose_method'
      doc: 'Itayose Method'
    2:
      id: 'zaraba_method'
      doc: 'Zaraba Method'
    3:
      id: 'sell_special_quote_displayed'
      doc: 'Sell Special Quote Displayed'
    4:
      id: 'buy_special_quote_displayed'
      doc: 'Buy Special Quote Displayed'
    5:
      id: 'sell_sequential_trade_quote_displayed'
      doc: 'Sell Sequential Trade Quote Displayed'
    6:
      id: 'buy_sequential_trade_quote_displayed'
      doc: 'Buy Sequential Trade Quote Displayed'
    0:
      id: 'other_than_the_above'
      doc: 'Other Than The Above'
  triggered_side:
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x20:
      id: 'itayose_execution'
      doc: 'Itayose Execution'
  side:
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
  order_condition:
    0:
      id: 'nonconditional'
      doc: 'Nonconditional'
    2:
      id: 'onopen'
      doc: 'Onopen'
    4:
      id: 'onclose'
      doc: 'Onclose'
    6:
      id: 'funari'
      doc: 'Funari'
  modification_flag:
    0:
      id: 'cancel_order_or_modification_order_that_changes_time_priority'
      doc: 'Cancel Order Or Modification Order That Changes Time Priority'
    1:
      id: 'modification_order_that_does_not_change_time_priority'
      doc: 'Modification Order That Does Not Change Time Priority'
  adopted_pricing_method:
    1:
      id: 'itayose_method'
      doc: 'Itayose Method'
    2:
      id: 'quote_displayed'
      doc: 'Quote Displayed'
  reset_start_end_flag:
    1:
      id: 'start_of_reset_dissemination'
      doc: 'Start Of Reset Dissemination'
    2:
      id: 'end_of_reset_dissemination'
      doc: 'End Of Reset Dissemination'
  test_mode_flag:
    1:
      id: 'production'
      doc: 'Production'
    2:
      id: 'test'
      doc: 'Test'
  communication_start_end_flag:
    0:
      id: 'health_check_control'
      doc: 'Health Check Control'
    1:
      id: 'communication_start'
      doc: 'Communication Start'
    2:
      id: 'communication_end'
      doc: 'Communication End'
  packet_type:
    0x52:
      id: 'login_request_message'
      doc: 'Tcp login request for retransmission or snapshot. Packet Type R selects retransmission and L selects snapshot.'
    0x41:
      id: 'login_result_message'
      doc: 'Tcp login response. Packet Type A indicates accepted and J indicates rejected.'
    0x53:
      id: 'message_response_message'
      doc: 'Tcp message response carrying tag data including their packet headers in response to a retransmission or snapshot request.'
    0x47:
      id: 'end_of_message_message'
      doc: 'Tcp end of message marker terminating a retransmission or snapshot session.'
  result_code:
    0x41:
      id: 'accepted'
      doc: 'Accepted'
    0x4f:
      id: 'out_of_service'
      doc: 'Out Of Service'
    0x55:
      id: 'incorrect_user_id'
      doc: 'Incorrect User Id'
    0x53:
      id: 'incorrect_sequence_number'
      doc: 'Incorrect Sequence Number'
    0x54:
      id: 'incorrect_packet_type'
      doc: 'Incorrect Packet Type'
    0x4d:
      id: 'incorrect_mcg_number'
      doc: 'Incorrect Mcg Number'
    0x5a:
      id: 'other_error'
      doc: 'Other Error'

