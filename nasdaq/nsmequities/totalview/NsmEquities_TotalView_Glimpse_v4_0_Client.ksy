# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NsmEquities TotalView Glimpse v4.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: TotalView Itch
#   Encoding: Glimpse
#   Version: 4.0
#   Date: 01/22/2010
#   Specification: Nasdaq Glimpse.pdf
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
  id: nasdaq_nsmequities_totalview_glimpse_v4_0_client
  title: Nasdaq NsmEquities TotalView Glimpse v4.0
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Stock Market TotalView Itch Glimpse v4.0'

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
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside of time stamp messages, the start of day message is the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'This message indicates that NASDAQ is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are available for execution.'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'This message is intended to indicate that Market Hours orders are no longer available for execution.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'It indicates that NASDAQ is now closed and will not accept any new orders today.'
    0x43:
      id: 'end_of_messages'
      doc: 'This is always the last message sent in any trading day.'
    0x41:
      id: 'emergency_market_condition_halt'
      doc: 'This message is sent to inform NASDAQ market participants that the EMC is in effect. No trading is allowed during the EMC.'
    0x52:
      id: 'emergency_market_condition_quote_only_period'
      doc: 'This message is sent to inform NASDAQ market participants that the EMC quotation only period is in effect.'
    0x42:
      id: 'emergency_market_condition_resumption'
      doc: 'This message is sent to inform NASDAQ market participants that EMC is no longer in effect.'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy order.'
    0x53:
      id: 'sell_order'
      doc: 'Sell order.'
  market_category:
    0x54:
      id: 'cqs_equities'
      doc: 'CQS Equities including New York Stock Exchange (NYSE), NYSE Amex and NYSE Arca'
    0x51:
      id: 'nasdaq_global_select_market'
      doc: 'NASDAQ Global Select Market'
    0x47:
      id: 'nasdaq_global_market'
      doc: 'NASDAQ Global Market'
    0x53:
      id: 'nasdaq_capital_market'
      doc: 'NASDAQ Capital Market'
  financial_status_indicator:
    0x44:
      id: 'deficient'
      doc: 'Deficient'
    0x45:
      id: 'delinquent'
      doc: 'Delinquent'
    0x51:
      id: 'bankrupt'
      doc: 'Bankrupt'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
    0x47:
      id: 'deficient_and_bankrupt'
      doc: 'Deficient and Bankrupt'
    0x48:
      id: 'deficient_and_delinquent'
      doc: 'Deficient and Delinquent'
    0x4a:
      id: 'delinquent_and_bankrupt'
      doc: 'Delinquent and Bankrupt'
    0x4b:
      id: 'deficient_delinquent_and_bankrupt'
      doc: 'Deficient, Delinquent and Bankrupt'
  round_lots_only:
    0x59:
      id: 'round_lots_only'
      doc: 'Only round lots are accepted in this stock.'
    0x4e:
      id: 'odd_and_mixed_lots_allowed'
      doc: 'Odd/mixed lots are allowed.'
  trading_state:
    0x48:
      id: 'halted_across_sr_os'
      doc: 'Halted or paused across all U.S. equity markets / SROs'
    0x56:
      id: 'halted_on_nasdaq_only'
      doc: 'Halted or paused on NASDAQ only'
    0x51:
      id: 'quotation_only_period_across_sro'
      doc: 'Quotation only period for cross-SRO halt or pause'
    0x52:
      id: 'quotation_only_period_on_nasdaq_only'
      doc: 'Quotation only period for NASDAQ only halt or pause'
    0x54:
      id: 'trading'
      doc: 'Trading on NASDAQ OMX'

