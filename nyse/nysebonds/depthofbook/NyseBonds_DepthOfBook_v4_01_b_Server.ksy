# ---------------------------------------------------------------------
# Kaitai struct definition for: Nyse NyseBonds DepthOfBook Abp v4.01.b
#
# Protocol:
#   Organization: New York Stock Exchange
#   Protocol: DepthOfBook
#   Encoding: Arca Binary Protocol
#   Version: 4.01.b
#   Date: 10/13/2015
#   Specification: NYSE_Bonds_Depth_of_Book_Client_Spec.pdf
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
  id: nyse_nysebonds_depthofbook_abp_v4_01_b_server
  title: Nyse NyseBonds DepthOfBook Abp v4.01.b
  license: GPL-3.0
  endian: be

doc: 'New York Stock Exchange Nyse Bonds DepthOfBook Abp v4.01.b'
doc-ref: https://www.nyse.com/publicdocs/nyse/data/NYSE_Bonds_Depth_of_Book_Client_Spec.pdf

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
            'message_type::add_order_message': add_order_message
            'message_type::modify_order_message': modify_order_message
            'message_type::delete_order_message': delete_order_message
            'message_type::imbalance_message': imbalance_message
            'message_type::system_event_message': system_event_message
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
        doc: 'Version of the Nyse ArcaBook protocol, formatted vv.vv'
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
  add_order_message:
    seq:
      - id: time
        type: u4le
        doc: 'Message creation timestamp in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: order_reference_number
        type: u4le
        doc: 'The unique reference number per order book (system code) assigned to this order'
      - id: quantity
        type: u4le
        doc: 'The size of the order'
      - id: price
        type: u4le
        doc: 'The limit price of the bond order. See Bond Price Types'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Which order book this order belongs to'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Whether this is a buy or a sell order'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Whether the order is All or None, Minimum Quantity, or unspecified'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Bonds specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: quote_id
        type: str
        size: 5
        encoding: ASCII
        doc: '''A'' plus the Mmid when attributed, otherwise ''ARCAX'''
      - id: padding_ascii_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Not used'
      - id: minimum_quantity
        type: u4le
        doc: 'For an All or None order the size of the order, for a Minimum Quantity order the minimum size of the order, and 0 for other order types'
  modify_order_message:
    seq:
      - id: time
        type: u4le
        doc: 'Message creation timestamp in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: order_reference_number
        type: u4le
        doc: 'The unique reference number per order book (system code) assigned to this order'
      - id: quantity
        type: u4le
        doc: 'The size of the order'
      - id: price
        type: u4le
        doc: 'The limit price of the bond order. See Bond Price Types'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Which order book this order belongs to'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Whether this is a buy or a sell order'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Whether the order is All or None, Minimum Quantity, or unspecified'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Bonds specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: quote_id
        type: str
        size: 5
        encoding: ASCII
        doc: '''A'' plus the Mmid when attributed, otherwise ''ARCAX'''
      - id: padding_ascii_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Not used'
      - id: minimum_quantity
        type: u4le
        doc: 'For an All or None order the size of the order, for a Minimum Quantity order the minimum size of the order, and 0 for other order types'
  delete_order_message:
    seq:
      - id: time
        type: u4le
        doc: 'Message creation timestamp in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: order_reference_number
        type: u4le
        doc: 'The unique reference number per order book (system code) assigned to this order'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Which order book this order belongs to'
      - id: buy_sell_indicator
        type: u1
        enum: buy_sell_indicator
        doc: 'Whether this is a buy or a sell order'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Whether the order is All or None, Minimum Quantity, or unspecified'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Bonds specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: quote_id
        type: str
        size: 5
        encoding: ASCII
        doc: '''A'' plus the Mmid when attributed, otherwise ''ARCAX'''
  imbalance_message:
    seq:
      - id: time
        type: u4le
        doc: 'Message creation timestamp in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: match_quantity
        type: u4le
        doc: 'The indicative match volume'
      - id: total_imbalance
        type: u4le
        doc: 'The total imbalance volume'
      - id: market_imbalance
        type: u4le
        doc: 'The market imbalance volume'
      - id: price
        type: u4le
        doc: 'The limit price of the bond order. See Bond Price Types'
      - id: price_scale_code
        type: u1
        enum: price_scale_code
        doc: 'The power of ten dividing the price fields in this message'
      - id: exchange_code
        type: u1
        enum: exchange_code
        doc: 'Whether this is a Nyse listed bond'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Which order book this order belongs to'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Which auction this imbalance is for'
      - id: flat_pricing
        type: u1
        enum: flat_pricing
        doc: 'Whether flat pricing or interest pricing is in effect'
      - id: trading_action
        type: u1
        enum: trading_action
        doc: 'The current state of trading for this bond'
      - id: security_type
        type: u1
        enum: security_type
        doc: 'The type of bond. Additional types will be supported in future releases'
      - id: quote_condition
        type: u1
        doc: 'Reserved for future use'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Bonds specific identity for this bond'
      - id: cusip_isin
        type: str
        size: 14
        encoding: ASCII
        doc: 'Cusip or Isin for the bond. Null unless the client requested the data and holds a licence'
      - id: auction_time
        type: str
        size: 4
        encoding: ASCII
        doc: 'Projected auction time, formatted hhmm'
  system_event_message:
    seq:
      - id: time
        type: u4le
        doc: 'Message creation timestamp in milliseconds since midnight'
      - id: sequence_number
        type: u4le
        doc: 'Message sequence number, 1 to 2147483647'
      - id: next_expected_sequence_number
        type: u4le
        doc: 'The sequence number that subscribers should expect next'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'What type of event has occurred'
      - id: system_code
        type: u1
        enum: system_code
        doc: 'Which order book this order belongs to'
      - id: nyse_bond_symbol
        type: str
        size: 22
        encoding: ASCII
        doc: 'A Nyse Bonds specific identity for this bond'
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

enums:
  message_type:
    0x51:
      id: 'login_accepted_message'
      doc: 'Sent to indicate a successful login. Carries the current version of the Nyse ArcaBook protocol.'
    0x52:
      id: 'login_rejected_message'
      doc: 'Sent when login fails authentication, the client does not log in within 5 seconds, no order data feed was subscribed to, the sequence number was invalid, no connections are available, or a timeout occurred. The socket is closed afterwards.'
    0x48:
      id: 'heartbeat_message'
      doc: 'Sent every 60 seconds during periods of client inactivity, so that firewalls do not time the connection out. The client must answer with a Heartbeat Response. There is no message body, and the header length is always zero.'
    0x53:
      id: 'test_response_message'
      doc: 'Sent in response to a Test Request, echoing back any text the request carried.'
    0x4e:
      id: 'add_order_message'
      doc: 'Sent for a new open order. The Order Reference Number is unique per order book, while the Sequence Number is unique across all order books.'
    0x43:
      id: 'modify_order_message'
      doc: 'Sent when an order in a Nyse Bonds book is modified: its price or size changes, it is partially filled, or it is routed away with shares remaining. The Order Reference Number refers to the original Add Order.'
    0x4b:
      id: 'delete_order_message'
      doc: 'Sent when an order is taken off the open order book because it was cancelled, expired, routed to an away market, or filled.'
    0x57:
      id: 'imbalance_message'
      doc: 'Sent in response to orders submitted during pending auctions, at the conclusion of the Opening, Market Order and Closing Auctions, and for Halt Auctions. Total and market imbalance volumes are negative for a sell imbalance.'
    0x59:
      id: 'system_event_message'
      doc: 'Sent to indicate a special system event to an order book. The Event Code says what happened and the System Code which book is affected. Also carries the next sequence number subscribers should expect, which is generally the current one plus one but may restart at 1.'
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
  exchange_code:
    0x4e:
      id: 'nyse_listed_bond'
      doc: 'Nyse Listed Bond'
  system_code:
    0x46:
      id: 'bonds'
      doc: 'Bonds'
  buy_sell_indicator:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  flat_pricing:
    0x46:
      id: 'flat_pricing_is_in_effect'
      doc: 'Flat Pricing Is In Effect'
  trading_action:
    1:
      id: 'called'
      doc: 'Called'
    2:
      id: 'delisted'
      doc: 'Delisted'
    3:
      id: 'exinterest'
      doc: 'Exinterest'
    4:
      id: 'missed_an_interest_payment'
      doc: 'Missed An Interest Payment'
    5:
      id: 'bankrupt'
      doc: 'Bankrupt'
    6:
      id: 'late_filing'
      doc: 'Late Filing'
    7:
      id: 'below_listing_standards'
      doc: 'Below Listing Standards'
    8:
      id: 'late_filing_and_below_listing_standards'
      doc: 'Late Filing And Below Listing Standards'
    9:
      id: 'bankrupt_and_late_filing'
      doc: 'Bankrupt And Late Filing'
    10:
      id: 'bankrupt_and_below_listing_standards'
      doc: 'Bankrupt And Below Listing Standards'
  security_type:
    1:
      id: 'corporate_bonds'
      doc: 'Corporate Bonds'
  order_type:
    0:
      id: 'unspecified'
      doc: 'Unspecified'
    1:
      id: 'all_or_none'
      doc: 'All Or None'
    2:
      id: 'minimum_quantity'
      doc: 'Minimum Quantity'
  auction_type:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x4d:
      id: 'market'
      doc: 'Market'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x43:
      id: 'closing'
      doc: 'Closing'
  event_code:
    0x43:
      id: 'clear_book'
      doc: 'Clear Book'
    0x53:
      id: 'clear_book_by_symbol'
      doc: 'Clear Book By Symbol'
    0x48:
      id: 'halt_symbol'
      doc: 'Halt Symbol'
    0x55:
      id: 'un_halt_symbol'
      doc: 'Un Halt Symbol'

