# ---------------------------------------------------------------------
# Kaitai struct definition for: Biva BivaEquities OrderEntry Ouch v1.05
#
# Protocol:
#   Organization: Bolsa Institucional de Valores
#   Protocol: Order Entry
#   Encoding: Ouch
#   Version: 1.05
#   Date: 1/1/2016
#   Specification: BIVA_External_OUCH_Specification_v1.05.pdf
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
  id: biva_bivaequities_orderentry_ouch_v1_05_server
  title: Biva BivaEquities OrderEntry Ouch v1.05
  license: GPL-3.0
  endian: be

doc: 'Bolsa Institucional de Valores Biva Equities Order Entry Ouch v1.05'
doc-ref: https://www.biva.mx/en/web/portal-en/technology

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::accepted_message': accepted_message
            'sequenced_message_type::replaced_message': replaced_message
            'sequenced_message_type::canceled_message': canceled_message
            'sequenced_message_type::executed_order_message': executed_order_message
            'sequenced_message_type::broken_trade_message': broken_trade_message
            'sequenced_message_type::rejected_order_message': rejected_order_message
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System event code'
  accepted_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: account_type
        type: u1
        enum: account_type
        doc: 'Account type'
      - id: account_id
        type: u4
        doc: 'Assigned by the participant and forwarded to the clearing and settlement venues'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: 'Side of the order'
      - id: quantity
        type: u8
        doc: 'Total number of shares'
      - id: orderbook
        type: u4
        doc: 'Unique orderbook identifier'
      - id: price
        type: u4
        doc: 'The price of this order, 0x7FFFFFFF for a market order'
      - id: time_in_force
        type: u4
        enum: time_in_force
        doc: 'How long the order remains in effect'
      - id: client_id
        type: u4
        doc: 'The client identifier for this order, returned via the Accepted or Replaced messages'
      - id: order_reference_number
        type: u8
        doc: 'Day unique order reference number'
      - id: minimum_quantity
        type: u8
        doc: 'Minimum number of shares to execute for an immediate order'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order state upon acceptance'
  replaced_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: replacement_order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: order_verb
        type: u1
        enum: order_verb
        doc: 'Side of the order'
      - id: quantity
        type: u8
        doc: 'Total number of shares'
      - id: orderbook
        type: u4
        doc: 'Unique orderbook identifier'
      - id: price
        type: u4
        doc: 'The price of this order, 0x7FFFFFFF for a market order'
      - id: order_reference_number
        type: u8
        doc: 'Day unique order reference number'
      - id: order_state
        type: u1
        enum: order_state
        doc: 'Order state upon acceptance'
      - id: previous_order_token
        type: u4
        doc: 'The order token of the order that was replaced'
  canceled_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: quantity
        type: u8
        doc: 'Total number of shares'
      - id: canceled_reason
        type: u1
        enum: canceled_reason
        doc: 'Reason the order was cancelled'
  executed_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: executed_quantity
        type: u8
        doc: 'Incremental quantity executed for this execution only'
      - id: executed_price
        type: u4
        doc: 'The executed price for executed quantity'
      - id: liquidity_flag
        type: u1
        enum: liquidity_flag
        doc: 'Liquidity indicator for this execution'
      - id: match_number
        type: u8
        doc: 'Match identifier for each trade, the same for buy and sell sides'
      - id: counter_party_id
        type: u4
        doc: 'Counterparty identifier, may contain a masking Ccp or a trading counterparty'
  broken_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: match_number
        type: u8
        doc: 'Match identifier for each trade, the same for buy and sell sides'
      - id: broken_trade_reason
        type: u1
        enum: broken_trade_reason
        doc: 'The reason the trade was broken'
  rejected_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Number of nanoseconds past midnight. Nanoseconds since Midnight epoch'
      - id: order_token
        type: u4
        doc: 'Token must be unique for each Ouch user per trading cycle'
      - id: rejected_reason
        type: u1
        enum: rejected_reason
        doc: 'The reason the order was rejected'
  nanosecond_timestamp:
    seq:
      - id: time
        type: s8
    instances:
      hour:
        value: time / 3600000000000 % 24
      minute:
        value: time / 60000000000 % 60
      second:
        value: time / 1000000000 % 60
      millisecond:
        value: time / 1000000 % 1000

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
      doc: 'Enter order message'
    0x55:
      id: 'replace_order_message'
      doc: 'Replace order message, the account id orderbook client id and order verb are inherited from the original order'
    0x58:
      id: 'cancel_order_message'
      doc: 'Cancel order message'
  account_type:
    0x43:
      id: 'client'
      doc: 'Client'
    0x48:
      id: 'house'
      doc: 'House'
    0x4f:
      id: 'other'
      doc: 'Other'
    0x59:
      id: 'strategy'
      doc: 'Strategy'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
    0x53:
      id: 'stabilisation'
      doc: 'Stabilisation'
  order_verb:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x54:
      id: 'short_sell'
      doc: 'Short Sell'
  time_in_force:
    0:
      id: 'immediate'
      doc: 'Immediate'
    99997:
      id: 'session'
      doc: 'Session'
    99998:
      id: 'day'
      doc: 'Day'
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
      doc: 'System event message'
    0x41:
      id: 'accepted_message'
      doc: 'Accepted message echoing the data fields of the Enter Order Message'
    0x55:
      id: 'replaced_message'
      doc: 'Replaced message'
    0x43:
      id: 'canceled_message'
      doc: 'Canceled order message'
    0x45:
      id: 'executed_order_message'
      doc: 'Order executed message'
    0x42:
      id: 'broken_trade_message'
      doc: 'Broken trade message'
    0x4a:
      id: 'rejected_order_message'
      doc: 'Rejected order message'
  event_code:
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
  canceled_reason:
    0x55:
      id: 'user_requested_cancel'
      doc: 'User Requested Cancel'
    0x49:
      id: 'immediate_order_expired'
      doc: 'Immediate Order Expired'
    0x54:
      id: 'timeout_session_or_day_order_expired'
      doc: 'Timeout Session Or Day Order Expired'
    0x53:
      id: 'supervisory'
      doc: 'Supervisory'
    0x4c:
      id: 'user_logged_off'
      doc: 'User Logged Off'
    0x5a:
      id: 'invalid_quantity_or_quantity_exceeds_maximum_limit'
      doc: 'Invalid Quantity Or Quantity Exceeds Maximum Limit'
    0x52:
      id: 'order_not_allowed_at_this_time'
      doc: 'Order Not Allowed At This Time'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x4e:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x59:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x46:
      id: 'flow_control_in_place_for_user'
      doc: 'Flow Control In Place For User'
    0x57:
      id: 'unknown'
      doc: 'Unknown'
  liquidity_flag:
    0x41:
      id: 'added_for_the_passive_firm'
      doc: 'Added For The Passive Firm'
    0x52:
      id: 'removed_for_the_aggressor'
      doc: 'Removed For The Aggressor'
    0x55:
      id: 'uncross_for_auction_executions'
      doc: 'Uncross For Auction Executions'
  broken_trade_reason:
    0x43:
      id: 'consent_both_parties_agreed_to_break_the_trade'
      doc: 'Consent Both Parties Agreed To Break The Trade'
    0x53:
      id: 'supervisory_broken_by_biva_market_control'
      doc: 'Supervisory Broken By Biva Market Control'
  rejected_reason:
    0x48:
      id: 'secboard_instrument_board_or_market_not_tradeable'
      doc: 'Secboard Instrument Board Or Market Not Tradeable'
    0x5a:
      id: 'invalid_quantity_or_quantity_exceeds_maximum_limit'
      doc: 'Invalid Quantity Or Quantity Exceeds Maximum Limit'
    0x53:
      id: 'invalid_orderbook_identifier'
      doc: 'Invalid Orderbook Identifier'
    0x52:
      id: 'order_not_allowed_at_this_time'
      doc: 'Order Not Allowed At This Time'
    0x58:
      id: 'invalid_price'
      doc: 'Invalid Price'
    0x4e:
      id: 'invalid_minimum_quantity'
      doc: 'Invalid Minimum Quantity'
    0x59:
      id: 'invalid_order_type'
      doc: 'Invalid Order Type'
    0x46:
      id: 'flow_control_in_place_for_user'
      doc: 'Flow Control In Place For User'
    0x57:
      id: 'unknown'
      doc: 'Unknown'

