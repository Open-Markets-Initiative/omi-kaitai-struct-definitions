# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseBonds Trades Abp v1.07.a
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: Trades
#   Encoding: Arca Binary Protocol
#   Version: 1.07.a
#   Date: 09/04/2012
#   Specification: NYSE_Bonds_Trades_Client_Specification_v1.07a.pdf
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
  id: nyse_nysebonds_trades_abp_v1_07_a_client
  title: Nyse NyseBonds Trades Abp v1.07.a
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange Nyse Bonds Trades Abp v1.07.a'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Bonds_Trades_Client_Specification_v1.07a.pdf

seq:
  - id: client_message_header
    type: client_message_header_struct
    doc: 'The single Ascii type code that opens every client message'
  - id: client_data
    type:
      switch-on: client_message_header.client_message_type
      cases:
        '"L"': login_message
        '"O"': logoff_message
        '"H"': heartbeat_response_message
        '"T"': test_request_message

types:
  client_message_header_struct:
    seq:
      - id: client_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Alpha character indicating the type of message the client is sending'
  login_message:
    seq:
      - id: username
        type: str
        size: 8
        encoding: ASCII
        doc: 'Username authenticating the session'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Password authenticating the session'
      - id: login_sequence_number
        type: str
        size: 10
        encoding: ASCII
        doc: 'Recovery sequence number, or 0 to receive current updates. 0 to 2147483647. Written as text, not binary'
      - id: listed_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: etf_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: otc_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: arca_edge_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: bond_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Whether the session subscribes to bond trades. Y is yes, N is no'
      - id: options_subscription
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: client_padding
        type: str
        size: 5
        encoding: ASCII
        doc: 'Reserved for future use'
      - id: etx
        type: u1
        doc: 'Message terminating character, 0x03'
  logoff_message:
    seq:
      - id: etx
        type: u1
        doc: 'Message terminating character, 0x03'
  heartbeat_response_message:
    seq:
      - id: etx
        type: u1
        doc: 'Message terminating character, 0x03'
  test_request_message:
    seq:
      - id: test_request_text
        type: str
        size: 20
        encoding: ASCII
        doc: 'Optional text for the exchange to echo back'
      - id: etx
        type: u1
        doc: 'Message terminating character, 0x03'

enums:
  message_type:
    0x51:
      id: 'login_accepted_message'
      doc: 'Sent to indicate a successful login. Carries the current version of ArcaTrade.'
    0x52:
      id: 'login_rejected_message'
      doc: 'Sent when login fails authentication, the client does not log in within 30 seconds, no trade data feed was subscribed to, the sequence number was invalid, or no connections are available. The socket is closed afterwards.'
    0x48:
      id: 'heartbeat_message'
      doc: 'Sent every 60 seconds during periods of client inactivity, so that firewalls do not time the connection out. The client must answer with a Heartbeat Response. There is no message body, and the header length is always zero.'
    0x53:
      id: 'test_response_message'
      doc: 'Sent in response to a Test Request, echoing back any text the request carried.'
    0x58:
      id: 'last_sale_message'
      doc: 'Sent when an order partially trades or completely trades.'
    0x55:
      id: 'trade_bust_or_correction_message'
      doc: 'Sent when trades are busted or corrected. The Event Code field says which.'
    0x5a:
      id: 'nyse_bond_closing_price_message'
      doc: 'Sent during day end processing with the final closing price and volume for a bond. The specification notes this message is not supported at the time of writing and will be implemented in a future release.'
  reject_code:
    0x41:
      id: 'not_authorized'
      doc: 'Not Authorized'
    0x4d:
      id: 'maximum_server_connections_reached'
      doc: 'Maximum Server Connections Reached'
    0x52:
      id: 'invalid_subscription'
      doc: 'Invalid Subscription'
    0x53:
      id: 'invalid_sequence'
      doc: 'Invalid Sequence'
    0x54:
      id: 'timeout'
      doc: 'Timeout'
  price_scale_code:
    0x30:
      id: 'no_division'
      doc: 'No Division'
    0x31:
      id: 'ten'
      doc: 'Ten'
    0x32:
      id: 'one_hundred'
      doc: 'One Hundred'
    0x33:
      id: 'one_thousand'
      doc: 'One Thousand'
    0x34:
      id: 'ten_thousand'
      doc: 'Ten Thousand'
    0x35:
      id: 'one_hundred_thousand'
      doc: 'One Hundred Thousand'
    0x36:
      id: 'one_million'
      doc: 'One Million'
  system_code:
    0x46:
      id: 'bonds_trading_platform'
      doc: 'Bonds Trading Platform'
  exchange_code:
    0x4e:
      id: 'nyse_listed_bond'
      doc: 'Nyse Listed Bond'
  security_type:
    1:
      id: 'corporate_bonds'
      doc: 'Corporate Bonds'
  event_code:
    0x42:
      id: 'trade_bust'
      doc: 'Trade Bust'
    0x43:
      id: 'trade_correction'
      doc: 'Trade Correction'

