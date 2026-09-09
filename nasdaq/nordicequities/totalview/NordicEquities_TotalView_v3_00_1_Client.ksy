# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NordicEquities TotalView Glimpse v3.00.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nordic Equity TotalView
#   Encoding: Glimpse
#   Version: 3.00.1
#   Date: 12/01/2015
#   Specification: Nasdaq Nordic INET Equity GLIMPSE (3.00.1).pdf
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
  id: nasdaq_nordicequities_totalview_glimpse_v3_00_1_client
  title: Nasdaq NordicEquities TotalView Glimpse v3.00.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Nordic Equities Nordic Equity TotalView Glimpse v3.00.1'
doc-ref: https://www.nasdaq.com/solutions/technical-information-inet-nordic-trading-platform

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
    0x53:
      id: 'system_event_message'
      doc: 'Signals a market or data feed handler event'
    0x48:
      id: 'order_book_trading_action_message'
      doc: 'Indicates the current trading status of a security'
    0x52:
      id: 'order_book_directory_message'
      doc: 'Disseminated for all active order books at the start of each trading day'
    0x41:
      id: 'add_order_message'
      doc: 'An order added to the book without Mpid attribution'
    0x46:
      id: 'add_order_mpid_attribution_message'
      doc: 'An order added to the book with Mpid attribution'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Denotes the TotalView Itch sequence number to begin real time processing from'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  symbol_state:
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x4c:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x53:
      id: 'post_trade'
      doc: 'Post Trade'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x51:
      id: 'auction_period'
      doc: 'Auction Period'
    0x41:
      id: 'trading_at_closing_price'
      doc: 'Trading At Closing Price'
  extension:
    0x45:
      id: 'cross_extension'
      doc: 'Cross Extension'
  financial_product:
    1:
      id: 'stock'
      doc: 'Stock'
    2:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    3:
      id: 'equity_right'
      doc: 'Equity Right'
    4:
      id: 'bond'
      doc: 'Bond'
    6:
      id: 'lottery_bond_series'
      doc: 'Lottery Bond Series'
    7:
      id: 'convertible'
      doc: 'Convertible'
    8:
      id: 'warrant'
      doc: 'Warrant'
    11:
      id: 'unit_trust_certificate'
      doc: 'Unit Trust Certificate'
    12:
      id: 'index_fund_unit'
      doc: 'Index Fund Unit'
  price_notation:
    0x4d:
      id: 'monetary_value'
      doc: 'Monetary Value'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'

