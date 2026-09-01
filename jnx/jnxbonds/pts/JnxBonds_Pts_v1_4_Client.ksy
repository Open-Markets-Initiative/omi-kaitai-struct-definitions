# ---------------------------------------------------------------------
# Kaitai struct definition for: Jnx JnxBonds Pts Ouch v1.4
#
# Protocol:
#   Organization: Japannext Securities
#   Protocol: 
#   Encoding: Ouch
#   Version: 1.4
#   Date: 04/01/2020
#   Specification: Japannext_PTS_OUCH_Bonds_v1.4.pdf
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
  id: jnx_jnxbonds_pts_ouch_v1_4_client
  title: Jnx JnxBonds Pts Ouch v1.4
  license: GPL-3.0
  endian: be

doc: 'Japannext Securities Japannext Bonds Ouch v1.4'
doc-ref: https://www.japannext.co.jp/library

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_packet_header
        type: client_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_payload
        size: client_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: client_packet_type
        type: u1
        enum: client_packet_type
        doc: 'Code identifying this packet type sent by the client'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::enter_order_message': enter_order_message
            'unsequenced_message_type::replace_order_message': replace_order_message
            'unsequenced_message_type::cancel_order_message': cancel_order_message
  enter_order_message:
    seq:
      - id: order_token
        type: u4
        doc: 'Must be unique per Ouch account within a trading day and increase on each subsequent transaction'
      - id: client_reference
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Assigned by client Not validated'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Side of order'
      - id: quantity
        type: u4
        doc: 'Number of bonds'
      - id: orderbook_id
        type: u4
        doc: 'Bond code per SICC definition'
      - id: group
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order book group identifier'
      - id: price
        type: decimal_s4_3
        doc: 'Yield of the order. Implied decimal with scale 1e-3'
      - id: time_in_force
        type: u4
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: firm_id
        type: u4
        doc: 'Order entry firm identifier'
      - id: display
        type: u1
        enum: display
        doc: 'Order handling instruction'
      - id: capacity
        type: u1
        enum: capacity
        doc: 'Capacity of firm placing order'
      - id: minimum_quantity
        type: u4
        doc: 'Minimum acceptable quantity to execute'
      - id: order_classification
        type: u1
        enum: order_classification
        doc: 'High-frequency trading order classification'
      - id: cash_margin_type
        type: u1
        enum: cash_margin_type
        doc: 'Cash margin type of order'
  replace_order_message:
    seq:
      - id: existing_order_token
        type: u4
        doc: 'Must match current live order'
      - id: replacement_order_token
        type: u4
        doc: 'Must be unique per Ouch account within a trading day and increase on each subsequent transaction'
      - id: quantity
        type: u4
        doc: 'Number of bonds'
      - id: price
        type: decimal_s4_3
        doc: 'Yield of the order. Implied decimal with scale 1e-3'
      - id: time_in_force
        type: u4
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: display
        type: u1
        enum: display
        doc: 'Order handling instruction'
      - id: minimum_quantity
        type: u4
        doc: 'Minimum acceptable quantity to execute'
  cancel_order_message:
    seq:
      - id: order_token
        type: u4
        doc: 'Must be unique per Ouch account within a trading day and increase on each subsequent transaction'
      - id: quantity
        type: u4
        doc: 'Number of bonds'
  decimal_s4_3:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 1000.0

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  unsequenced_message_type:
    0x4f:
      id: 'enter_order_message'
      doc: 'An Enter Order Message is used to enter a new order into the Japannext PTS execution system'
    0x55:
      id: 'replace_order_message'
      doc: 'A Replace Order Message is used to modify an existing order'
    0x58:
      id: 'cancel_order_message'
      doc: 'A Cancel Order Message is used to request that an order be canceled'
  buy_sell_indicator:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  time_in_force:
    0:
      id: 'immediate'
      doc: 'Immediate'
    99999:
      id: 'day'
      doc: 'Day'
  display:
    0x20:
      id: 'unused'
      doc: 'Unused'
    0x50:
      id: 'postonly'
      doc: 'Postonly'
  capacity:
    0x41:
      id: 'agency'
      doc: 'Agency'
    0x50:
      id: 'principal'
      doc: 'Principal'
  order_classification:
    0x31:
      id: 'non_hft'
      doc: 'Non Hft'
    0x33:
      id: 'hft_market_making_strategy'
      doc: 'Hft Market Making Strategy'
    0x34:
      id: 'hft_arbitrage_strategy'
      doc: 'Hft Arbitrage Strategy'
    0x35:
      id: 'hft_directional_strategy'
      doc: 'Hft Directional Strategy'
    0x36:
      id: 'hft_other_strategy'
      doc: 'Hft Other Strategy'
  cash_margin_type:
    0x31:
      id: 'cash'
      doc: 'Cash'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'A System Event Message signals a Japannext PTS system-wide event'
    0x41:
      id: 'order_accepted_message'
      doc: 'An Order Accepted Message acknowledges the receipt and acceptance of a valid Enter Order Message'
    0x55:
      id: 'order_replaced_message'
      doc: 'An Order Replaced Message acknowledges the receipt and acceptance of a valid Replace Order Message'
    0x43:
      id: 'order_canceled_message'
      doc: 'An Order Canceled Message denotes that an order has been canceled'
    0x44:
      id: 'order_aiq_canceled_message'
      doc: 'An Order AIQ Canceled Message denotes that an order has been canceled by Japannext PTS to prevent a self-trade'
    0x65:
      id: 'order_executed_with_counter_party_message'
      doc: 'An Order Executed with Counter Party Message denotes that all or part of an order has been executed'
    0x4a:
      id: 'order_rejected_message'
      doc: 'An Order Rejected Message may be sent in response to an Enter Order Message if the order cannot be accepted'
  system_event:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
  order_state:
    0x4c:
      id: 'live'
      doc: 'Live'
    0x44:
      id: 'dead'
      doc: 'Dead'
  order_canceled_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User Requested Cancel'
    0x4c:
      id: 'user_logged_off'
      doc: 'User Logged Off'
    0x53:
      id: 'canceled_by_supervisory_terminal'
      doc: 'Canceled By Supervisory Terminal'
    0x49:
      id: 'immediate_order_remaining_quantity_canceled'
      doc: 'Immediate Order Remaining Quantity Canceled'
    0x4d:
      id: 'order_expired_during_matching'
      doc: 'Order Expired During Matching'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x5a:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    0x4e:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x59:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x44:
      id: 'invalid_display_type'
      doc: 'Invalid Display Type'
    0x52:
      id: 'order_not_allowed_at_this_time'
      doc: 'Order Not Allowed At This Time'
    0x46:
      id: 'flow_control_throttled'
      doc: 'Flow Control Throttled'
    0x47:
      id: 'margin_order_canceled_due_to_margin_restriction'
      doc: 'Margin Order Canceled Due To Margin Restriction'
    0x4f:
      id: 'other'
      doc: 'Other'
  liquidity_indicator:
    0x41:
      id: 'added'
      doc: 'Added'
    0x52:
      id: 'removed'
      doc: 'Removed'
  order_rejected_reason:
    0x48:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x53:
      id: 'invalid_order_book_identifier'
      doc: 'Invalid Order Book Identifier'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x5a:
      id: 'invalid_quantity'
      doc: 'Invalid Quantity'
    0x4e:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x59:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x44:
      id: 'invalid_display_type'
      doc: 'Invalid Display Type'
    0x52:
      id: 'order_not_allowed_at_this_time'
      doc: 'Order Not Allowed At This Time'
    0x46:
      id: 'flow_control_throttled'
      doc: 'Flow Control Throttled'
    0x47:
      id: 'invalid_margin_specification'
      doc: 'Invalid Margin Specification'
    0x4c:
      id: 'mpid_not_allowed_for_this_port'
      doc: 'Mpid Not Allowed For This Port'
    0x63:
      id: 'no_permission_to_enter_order_on_given_board'
      doc: 'No Permission To Enter Order On Given Board'
    0x4f:
      id: 'other'
      doc: 'Other'

