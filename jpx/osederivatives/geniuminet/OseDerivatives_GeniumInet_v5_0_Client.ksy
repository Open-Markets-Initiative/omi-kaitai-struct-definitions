# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx OseDerivatives GeniumInet Ouch v5.0
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Genium Inet
#   Encoding: Ouch
#   Version: 5.0
#   Date: 9/16/2020
#   Specification: OUCH_ProtSpec_OSE_va2656.pdf
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
  id: jpx_osederivatives_geniuminet_ouch_v5_0_client
  title: Jpx OseDerivatives GeniumInet Ouch v5.0
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Osaka Securities Exchange Genium Inet Ouch v5.0'

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
        pad-right: 0x20
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
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
            'unsequenced_message_type::enter_order': enter_order
            'unsequenced_message_type::enter_mm_order': enter_mm_order
            'unsequenced_message_type::replace_order': replace_order
            'unsequenced_message_type::cancel_order': cancel_order
            'unsequenced_message_type::cancel_by_order_id': cancel_by_order_id
            'unsequenced_message_type::mass_cancel': mass_cancel
  enter_order:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated unique order identifier'
      - id: order_book_id
        type: s4
        doc: 'Order book identifier. The Order Book ID can be obtained via ITCH'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: quantity
        type: u8
        doc: 'Order quantity'
      - id: price
        type: decimal_s4_2
        doc: 'Signed integer price. Implied decimal with scale 1e-2'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in force'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position update indicator'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through client/account field'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through customer information'
      - id: exchange_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Exchange info field is formatted and validated'
  enter_mm_order:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated unique order identifier'
      - id: order_book_id
        type: s4
        doc: 'Order book identifier. The Order Book ID can be obtained via ITCH'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: quantity
        type: u8
        doc: 'Order quantity'
      - id: price
        type: decimal_s4_2
        doc: 'Signed integer price. Implied decimal with scale 1e-2'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through client/account field'
      - id: exchange_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Exchange info field is formatted and validated'
  replace_order:
    seq:
      - id: existing_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'References the order to be replaced. Must be the original order token or the most recent successful replacement order token'
      - id: replacement_order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated replacement order identifier'
      - id: quantity
        type: u8
        doc: 'Order quantity'
      - id: price
        type: decimal_s4_2
        doc: 'Signed integer price. Implied decimal with scale 1e-2'
      - id: open_close
        type: u1
        enum: open_close
        doc: 'Position update indicator'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through client/account field'
      - id: customer_info
        type: str
        size: 15
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through customer information'
      - id: exchange_info
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Exchange info field is formatted and validated'
  cancel_order:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated unique order identifier'
  cancel_by_order_id:
    seq:
      - id: order_book_id
        type: s4
        doc: 'Order book identifier. The Order Book ID can be obtained via ITCH'
      - id: side
        type: u1
        enum: side
        doc: 'Order side'
      - id: order_id
        type: u8
        doc: 'Identifier assigned to the order by the system'
  mass_cancel:
    seq:
      - id: order_token
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Client-generated unique order identifier'
      - id: underlying_id
        type: u4
        doc: 'Underlying instrument identifier. Required when canceling orders for the underlying instrument'
      - id: scope
        type: u1
        enum: scope
        doc: 'Cancellation scope'
      - id: client_account
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Pass-through client/account field'
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

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
      id: 'enter_order'
      doc: 'Client-generated enter order request.'
    0x50:
      id: 'enter_mm_order'
      doc: 'Client-generated enter market maker order request.'
    0x55:
      id: 'replace_order'
      doc: 'Client-generated replace order request.'
    0x58:
      id: 'cancel_order'
      doc: 'Client-generated cancel order request.'
    0x59:
      id: 'cancel_by_order_id'
      doc: 'Client-generated request to cancel an order by system-assigned order ID.'
    0x4d:
      id: 'mass_cancel'
      doc: 'Client-generated request to cancel multiple orders.'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy Order'
    0x53:
      id: 'sell'
      doc: 'Sell Order'
  time_in_force:
    0:
      id: 'day'
      doc: 'Order Is Valid For The Trading Day'
    3:
      id: 'immediate_or_cancel'
      doc: 'Immediate Or Cancel Fill And Kill'
    4:
      id: 'fill_or_kill'
      doc: 'Fill Or Kill'
  open_close:
    0:
      id: 'no_change'
      doc: 'No Change To The Current Position'
    1:
      id: 'open'
      doc: 'Open Position'
    2:
      id: 'close_net'
      doc: 'Close Or Net The Position'
    3:
      id: 'mandatory_close'
      doc: 'Mandatory Close Of The Position'
    4:
      id: 'default_field'
      doc: 'Default Behavior For The Account'
  scope:
    1:
      id: 'participant'
      doc: 'Applies To All Orders For The Participant'
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
    0x41:
      id: 'order_accepted'
      doc: 'Acknowledges the receipt and acceptance of a valid Enter Order Message'
    0x4d:
      id: 'mass_cancel_accepted'
      doc: 'System notification indicating acceptance of a mass cancel request.'
    0x4a:
      id: 'order_rejected'
      doc: 'System notification indicating that an order has been rejected.'
    0x55:
      id: 'order_replaced'
      doc: 'System notification indicating that an order has been successfully replaced.'
    0x43:
      id: 'order_canceled'
      doc: 'System notification indicating that an order has been canceled.'
    0x45:
      id: 'order_executed'
      doc: 'System notification indicating that an order (or order leg) has been executed.'
  order_state:
    1:
      id: 'on_book'
      doc: 'Order Is Currently On The Order Book'
    2:
      id: 'not_on_book'
      doc: 'Order Is Not Currently On The Order Book'
  cancel_reason:
    1:
      id: 'canceled_by_user'
      doc: 'Order Was Canceled By The User'
    4:
      id: 'order_inactivated'
      doc: 'Order Was Inactivated By The System'
    9:
      id: 'canceled_by_system'
      doc: 'Order Was Canceled By The System'
    10:
      id: 'canceled_by_proxy'
      doc: 'Order Was Canceled By A Proxy'
    15:
      id: 'canceled_by_system_limit_change'
      doc: 'Order Was Canceled Due To A System Limit Change'
    19:
      id: 'deleted_by_time_validity_expiration'
      doc: 'Order Was Deleted After Time Validity Expiration'
    20:
      id: 'canceled_due_to_iss'
      doc: 'Order Was Canceled Due To Iss'
    21:
      id: 'inactivated_due_to_iss'
      doc: 'Order Was Inactivated Due To Iss'
    34:
      id: 'canceled_after_auction'
      doc: 'Order Was Canceled After The Auction'
    41:
      id: 'canceled_by_system_delta_protection'
      doc: 'Order Was Canceled By System Delta Protection'
    42:
      id: 'canceled_by_system_quantity_protection'
      doc: 'Order Was Canceled By System Quantity Protection'
    43:
      id: 'self_trade_prevention'
      doc: 'Order Was Canceled Because The Trader Is Not Allowed To Trade With Himself'
  deal_source:
    1:
      id: 'system_matched'
      doc: 'Matched By The System Automatically'
    7:
      id: 'combination_matched'
      doc: 'Combination Order Matched Against Another Combination Order When Matched Electronically By The Exchange'
    20:
      id: 'auction_end_deal'
      doc: 'Deal Made At The End Of An Auction'

