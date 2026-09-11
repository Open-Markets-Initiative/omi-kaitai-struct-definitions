# ---------------------------------------------------------------------
# Kaitai struct definition for: Biva BivaEquities TotalView Glimpse v1.12
#
# Protocol:
#   Organization: Bolsa Institucional de Valores
#   Protocol: Total View
#   Encoding: Glimpse
#   Version: 1.12
#   Date: 1/1/2022
#   Specification: BIVA_X-Stream_External_ITCH_Specification_v1.12.0.pdf
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
  id: biva_bivaequities_totalview_glimpse_v1_12_client
  title: Biva BivaEquities TotalView Glimpse v1.12
  license: GPL-3.0
  endian: be

doc: 'Bolsa Institucional de Valores Biva Equities Total View Glimpse v1.12'
doc-ref: https://www.biva.mx/en/web/portal-en/technology

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
  sequenced_message_type:
    0x54:
      id: 'time_stamp_seconds_message'
      doc: 'Itch timestamp, number of seconds since midnight of the system start'
    0x53:
      id: 'system_event_message'
      doc: 'System event message'
    0x4c:
      id: 'price_tick_size_message'
      doc: 'Orderbook price tick table'
    0x4d:
      id: 'quantity_tick_size_message'
      doc: 'Orderbook quantity tick table'
    0x52:
      id: 'orderbook_directory_message'
      doc: 'Orderbook directory'
    0x46:
      id: 'participant_directory_message'
      doc: 'Participant directory'
    0x48:
      id: 'orderbook_trading_action_message'
      doc: 'Trading action message'
    0x58:
      id: 'orderbook_reference_price_message'
      doc: 'Orderbook reference price message'
    0x41:
      id: 'add_order_message'
      doc: 'Add order message'
    0x49:
      id: 'indicative_price_quantity_message'
      doc: 'Indicative price quantity message'
    0x47:
      id: 'glimpse_snapshot_message'
      doc: 'Glimpse snapshot message'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_market_hours'
      doc: 'Start Of Market Hours'
    0x4d:
      id: 'end_of_market_hours'
      doc: 'End Of Market Hours'
    0x56:
      id: 'scheduled_auction_starts'
      doc: 'Scheduled Auction Starts'
    0x55:
      id: 'scheduled_auction_closes'
      doc: 'Scheduled Auction Closes'
    0x50:
      id: 'start_of_post_close_session'
      doc: 'Start Of Post Close Session'
    0x54:
      id: 'end_of_post_close_session'
      doc: 'End Of Post Close Session'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  listing_type:
    0x52:
      id: 'regular_securities'
      doc: 'Regular Securities'
    0x53:
      id: 'sub_rm_securities'
      doc: 'Sub Rm Securities'
  trading_state:
    0x54:
      id: 'trading'
      doc: 'Trading'
    0x56:
      id: 'suspended'
      doc: 'Suspended'
  trading_action_reason:
    0x4e:
      id: 'normal_trading'
      doc: 'Normal Trading'
    0x48:
      id: 'volatility_auction'
      doc: 'Volatility Auction'
    0x41:
      id: 'continuous_auction_start'
      doc: 'Continuous Auction Start'
    0x42:
      id: 'continuous_auction_end'
      doc: 'Continuous Auction End'
    0x51:
      id: 'news_pending'
      doc: 'News Pending'
    0x53:
      id: 'static_price_band_breach'
      doc: 'Static Price Band Breach'
    0x4d:
      id: 'market_surveillance_suspension'
      doc: 'Market Surveillance Suspension'
    0x4f:
      id: 'suspension_by_market_of_origin'
      doc: 'Suspension By Market Of Origin'
    0x43:
      id: 'non_compliance'
      doc: 'Non Compliance'
    0x49:
      id: 'start_of_indication_of_interest'
      doc: 'Start Of Indication Of Interest'
    0x45:
      id: 'expired_security_is_unavailable_for_trading'
      doc: 'Expired Security Is Unavailable For Trading'
    0x4c:
      id: 'not_yet_available_for_trading'
      doc: 'Not Yet Available For Trading'
  price_type:
    0x43:
      id: 'close_price'
      doc: 'Close Price'
    0x52:
      id: 'reference_price'
      doc: 'Reference Price'
    0x49:
      id: 'inav'
      doc: 'Inav'
    0x56:
      id: 'vwap_or_ppp'
      doc: 'Vwap Or Ppp'
  reference_price_reason:
    0x20:
      id: 'none'
      doc: 'None'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  cross_type:
    0x4f:
      id: 'preopening_session'
      doc: 'Preopening Session'
    0x49:
      id: 'intraday_auction'
      doc: 'Intraday Auction'

