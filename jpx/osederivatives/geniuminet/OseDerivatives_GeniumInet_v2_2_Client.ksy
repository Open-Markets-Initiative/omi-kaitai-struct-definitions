# ---------------------------------------------------------------------
# Kaitai struct definition for: Jpx OseDerivatives GeniumInet Glimpse v2.2
#
# Protocol:
#   Organization: Japan Exchange Group
#   Protocol: Genium Inet
#   Encoding: Glimpse
#   Version: 2.2
#   Date: 10/31/2025
#   Specification: J-GATE3.0_ITCH_Connectivity_Manual_V2.2.pdf
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
  id: jpx_osederivatives_geniuminet_glimpse_v2_2_client
  title: Jpx OseDerivatives GeniumInet Glimpse v2.2
  license: GPL-3.0
  endian: be

doc: 'Japan Exchange Group Osaka Securities Exchange Genium Inet Glimpse v2.2'

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
      - id: debug_text
        type: str
        size: _parent.client_packet_header.packet_length - 1
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_packet_header.packet_length - 2
        doc: 'The unsequenced (client to server) message carried by the packet, opaque bytes unless an application source dispatches it'

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
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x54:
      id: 'seconds_message'
      doc: 'Provides data on the seconds when each message is disseminated.'
    0x52:
      id: 'series_information_basic_message'
      doc: 'Provides detailed data about the series that can be traded on a given business day.'
    0x4d:
      id: 'series_information_basic_combination_message'
      doc: 'Provides detailed data about the legs of combination trading instruments that can be traded on a given trading day.'
    0x4c:
      id: 'tick_size_data_message'
      doc: 'Provides the tick size of a trading instrument.'
    0x53:
      id: 'system_event_data_message'
      doc: 'Provides system event update data.'
    0x4f:
      id: 'trading_status_data_message'
      doc: 'Provides the trading status data of a trading instrument.'
    0x41:
      id: 'new_order_message'
      doc: 'Provides quote data related to a new order.'
    0x45:
      id: 'execution_notice_message'
      doc: 'Provides an execution notice. The Order ID of the order which is already in the order book is set.'
    0x43:
      id: 'execution_notice_with_trade_information_message'
      doc: 'Provides an execution notice with trade information.'
    0x44:
      id: 'deleted_order_message'
      doc: 'Provided when an order is deleted and does not exist in the order book.'
    0x5a:
      id: 'ep_message'
      doc: 'Provides the equilibrium price for the order reception hours.'
    0x47:
      id: 'snapshot_completion_message'
      doc: 'Sent after completing the transmission of snapshot data.'
  financial_product:
    1:
      id: 'option'
      doc: 'Option'
    3:
      id: 'futures'
      doc: 'Futures'
    11:
      id: 'combination_series'
      doc: 'Combination Series'
  put_or_call:
    0:
      id: 'futures_or_combination_series'
      doc: 'Futures Or Combination Series'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  leg_side:
    0x42:
      id: 'buy_if_on_buy_side_sell_if_on_sell_side'
      doc: 'Buy If On Buy Side Sell If On Sell Side'
    0x43:
      id: 'sell_if_on_buy_side_buy_if_on_sell_side'
      doc: 'Sell If On Buy Side Buy If On Sell Side'
  event_code:
    0x4f:
      id: 'start_of_message_transmission'
      doc: 'Start Of Message Transmission'
    0x43:
      id: 'end_of_message_transmission'
      doc: 'End Of Message Transmission'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  occurred_at_cross:
    0x59:
      id: 'execution_through_auction'
      doc: 'Execution Through Auction'
    0x4e:
      id: 'execution_through_zaraba'
      doc: 'Execution Through Zaraba'

