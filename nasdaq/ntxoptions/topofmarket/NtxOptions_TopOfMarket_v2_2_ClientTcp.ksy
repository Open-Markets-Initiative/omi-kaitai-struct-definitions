# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxOptions TopOfMarket Itch v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Top Of Market
#   Encoding: Itch
#   Version: 2.2
#   Date: 08/30/2024
#   Specification: Nasdaq_Texas_Options_Top_of_Market.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_ntxoptions_topofmarket_itch_v2_2_clienttcp
  title: Nasdaq NtxOptions TopOfMarket Itch v2.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Top Of Market Itch v2.2'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: client_soup_bin_tcp_packet
    type: client_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the client'

types:
  client_soup_bin_tcp_packet_struct:
    seq:
      - id: client_tcp_packet_header
        type: client_tcp_packet_header
        doc: 'Packet header of a packet sent by the client'
      - id: client_tcp_payload
        size: client_tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: client_tcp_packet_header.client_packet_type
          cases:
            'client_packet_type::debug_packet': debug_packet
            'client_packet_type::login_request_packet': login_request_packet
            'client_packet_type::unsequenced_data_packet': unsequenced_data_packet
  client_tcp_packet_header:
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
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
      - id: unsequenced_message
        size: _parent.client_tcp_packet_header.packet_length - 2
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
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'derivative_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates options symbol directory messages for all active options symbols in the system.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x71:
      id: 'best_bid_and_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day.'
    0x51:
      id: 'best_bid_and_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid AND Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x62:
      id: 'best_bid_or_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x42:
      id: 'best_bid_or_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x54:
      id: 'trade_report_message'
      doc: 'Trade Report Message indicates that a trade has occurred for an options contract.'
    0x58:
      id: 'broken_trade_report_message'
      doc: 'Broken Trade Report Message indicates that a previously reported trade has been broken.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of replay Sequence message reflects the sequence number at the time replay of existing messages is complete.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start Of Messages'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start Of Opening Process'
    0x4e:
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x4e:
      id: 'na'
      doc: 'Na'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'instrument_is_tradable'
      doc: 'Instrument Is Tradable'
    0x4e:
      id: 'instrument_is_not_tradable'
      doc: 'Instrument Is Not Tradable'
  mpv:
    0x45:
      id: 'penny_everywhere'
      doc: 'Penny Everywhere'
    0x53:
      id: 'scaled'
      doc: 'Scaled'
    0x50:
      id: 'penny_pilot'
      doc: 'Penny Pilot'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x42:
      id: 'buy_side_trading_suspended'
      doc: 'Buy Side Trading Suspended'
    0x53:
      id: 'sell_side_trading_suspended'
      doc: 'Sell Side Trading Suspended'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x58:
      id: 'closed'
      doc: 'Closed'
  quote_condition:
    0x20:
      id: 'regular_quoteautox_eligible'
      doc: 'Regular Quoteautox Eligible'
    0x58:
      id: 'ask_side_not_firm_bid_side_firm'
      doc: 'Ask Side Not Firm Bid Side Firm'
    0x59:
      id: 'bid_side_not_firm_ask_side_firm'
      doc: 'Bid Side Not Firm Ask Side Firm'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'derivative_directory_message'
      doc: 'At the start of each trading day, Nasdaq disseminates options symbol directory messages for all active options symbols in the system.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x71:
      id: 'best_bid_and_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day.'
    0x51:
      id: 'best_bid_and_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid AND Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x62:
      id: 'best_bid_or_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x42:
      id: 'best_bid_or_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x54:
      id: 'trade_report_message'
      doc: 'Trade Report Message indicates that a trade has occurred for an options contract.'
    0x58:
      id: 'broken_trade_report_message'
      doc: 'Broken Trade Report Message indicates that a previously reported trade has been broken.'

