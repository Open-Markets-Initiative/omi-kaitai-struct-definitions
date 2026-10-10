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
  id: nyse_nysebonds_trades_abp_v1_07_a_server
  title: Nyse NyseBonds Trades Abp v1.07.a
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange Nyse Bonds Trades Abp v1.07.a'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Bonds_Trades_Client_Specification_v1.07a.pdf

seq:
  - id: message
    type: message_struct
    repeat: eos
    doc: 'Nyse Abp message sent by the exchange'

types:
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Nyse Arca Binary Protocol message header'
      - id: payload
        size: message_header.message_body_length
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_accepted_message': login_accepted_message
            'message_type::login_rejected_message': login_rejected_message
            'message_type::test_response_message': test_response_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_bust_or_correction_message': trade_bust_or_correction_message
            'message_type::nyse_bond_closing_price_message': nyse_bond_closing_price_message
  message_header:
    seq:
      - id: message_body_length
        type: u2
        doc: 'The size of the message body in bytes, excluding this four byte header'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Alpha character indicating the type of message'
      - id: padding
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
  login_accepted_message:
    seq:
      - id: version_id
        type: str
        size: 5
        encoding: ASCII
        doc: 'Version of the ArcaTrade protocol, formatted vv.vv'
      - id: padding_ascii_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
  login_rejected_message:
    seq:
      - id: reject_code
        type: u1
        enum: reject_code
        doc: 'The reason the login was rejected'
      - id: padding_ascii_1
        type: str
        size: 1
        encoding: ASCII
        doc: 'Not used'
  test_response_message:
    seq:
      - id: test_message
        type: str
        size: 20
        encoding: ASCII
        doc: 'Text sent in the Test Request message'
  last_sale_message:
    seq:
      - id: last_sale_time
        type: u4le
        doc: 'Time the trade occurred, in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: trade_reference_number
        type: u4le
        doc: 'The unique reference number per trading platform (system code) assigned to this trade'
      - id: quantity
        type: u4le
        doc: 'Number of bonds traded'
      - id: price
        type: u4le
        doc: 'Trade price. Divide by the denominator the Price Scale Code names'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'The trading platform that produced this trade'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: trade_condition
        type: u1
        doc: 'Reserved for future use'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Arca specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: padding_ascii_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Not used'
  trade_bust_or_correction_message:
    seq:
      - id: last_sale_time
        type: u4le
        doc: 'Time the trade occurred, in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: trade_reference_number
        type: u4le
        doc: 'The unique reference number per trading platform (system code) assigned to this trade'
      - id: quantity
        type: u4le
        doc: 'Number of bonds traded'
      - id: price
        type: u4le
        doc: 'Trade price. Divide by the denominator the Price Scale Code names'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'The trading platform that produced this trade'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Whether the trade was busted or corrected'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: trade_condition
        type: u1
        doc: 'Reserved for future use'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Arca specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: padding_ascii_2
        type: str
        size: 2
        encoding: ASCII
        doc: 'Not used'
  nyse_bond_closing_price_message:
    seq:
      - id: closing_time
        type: u4le
        doc: 'Time the closing price was set, in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: trade_reference_number
        type: u4le
        doc: 'The unique reference number per trading platform (system code) assigned to this trade'
      - id: quantity
        type: u4le
        doc: 'Number of bonds traded'
      - id: closing_price
        type: u4le
        doc: 'The closing price'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'The trading platform that produced this trade'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: trade_condition
        type: u1
        doc: 'Reserved for future use'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Arca specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: padding_ascii_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Not used'

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

