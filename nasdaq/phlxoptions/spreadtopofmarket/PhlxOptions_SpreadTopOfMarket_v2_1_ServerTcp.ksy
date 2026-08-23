# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PhlxOptions SpreadTopOfMarket Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Spread Top Of Market
#   Encoding: Itch
#   Version: 2.1
#   Date: 09/15/2025
#   Specification: Options_Spread_Feed_2.1.pdf
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
  id: nasdaq_phlxoptions_spreadtopofmarket_itch_v2_1_servertcp
  title: Nasdaq PhlxOptions SpreadTopOfMarket Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX Spread Top Of Market Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_tcp_packet_header
        type: server_tcp_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_tcp_payload
        size: server_tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_tcp_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_tcp_packet_header:
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
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
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
        size: _parent.server_tcp_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'sequenced_message_type::strategy_trading_action_message': strategy_trading_action_message
            'sequenced_message_type::strategy_best_bid_and_ask_update_message': strategy_best_bid_and_ask_update_message
            'sequenced_message_type::strategy_best_bid_update_message': strategy_best_bid_update_message
            'sequenced_message_type::strategy_best_ask_update_message': strategy_best_ask_update_message
            'sequenced_message_type::end_of_replay_sequence_message': end_of_replay_sequence_message
  system_event_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  complex_strategy_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'Strategy Type'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: num_leg_information
        type: u1
        doc: 'Number of legs in the strategy'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information'
  leg_information:
    seq:
      - id: option_id
        type: u4
        doc: 'Option ID for this leg, valid for the trading day'
      - id: security_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month of the option (1-12)'
      - id: expiration_day
        type: u1
        doc: 'Day of the Month of expiration (1-31)'
      - id: explicit_strike_price
        type: decimal_u4_4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Zero (0) for Stock Leg. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the leg'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
  strategy_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Current Trading State'
  strategy_best_bid_and_ask_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: quote_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quote Condition'
      - id: bid_market_size
        type: u4
        doc: 'The aggregate market size on Bid side'
      - id: bid_price
        type: u4
        doc: 'Best bid price in fixed point format with 6 whole number places followed by 4 decimal digits'
      - id: bid_size
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: bid_cust_size
        type: u4
        doc: 'Customer quantity on the bid side'
      - id: bid_pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid side'
      - id: bid_dntt_size
        type: u4
        doc: 'Aggregated Bid DNTT (Do not Trade Through) Limit Size'
      - id: bid_dntt_market_size
        type: u4
        doc: 'The aggregated DNTT (Do Not Trade Through) Market Size on Bid Size'
      - id: ask_market_size
        type: u4
        doc: 'Aggregate market quantity on Ask side'
      - id: ask_price
        type: u4
        doc: 'Best ask price in fixed point format with 6 whole number places followed by 4 decimal digits'
      - id: ask_size
        type: u4
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
      - id: ask_cust_size
        type: u4
        doc: 'Customer quantity on the ask side'
      - id: ask_pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the ask side'
      - id: ask_dntt_size
        type: u4
        doc: 'Aggregated Ask DNTT (Do not Trade Through) Limit Size'
      - id: ask_dntt_market_size
        type: u4
        doc: 'The aggregated DNTT (Do Not Trade Through) Market Size on Ask Size'
  strategy_best_bid_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: quote_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quote Condition'
      - id: market_size
        type: u4
        doc: 'The aggregate market size on Bid or Ask side'
      - id: price
        type: decimal_u4_4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size
        type: u4
        doc: 'Customer quantity on the bid or ask side'
      - id: pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
      - id: dntt_size
        type: u4
        doc: 'Aggregated DNTT (Do Not Trade Through) Limit Size'
      - id: dntt_market_size
        type: u4
        doc: 'The aggregated DNTT (Do Not Trade Through) Market Size on Bid or Ask Size'
  strategy_best_ask_update_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: quote_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Quote Condition'
      - id: market_size
        type: u4
        doc: 'The aggregate market size on Bid or Ask side'
      - id: price
        type: decimal_u4_4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size
        type: u4
        doc: 'Customer quantity on the bid or ask side'
      - id: pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
      - id: dntt_size
        type: u4
        doc: 'Aggregated DNTT (Do Not Trade Through) Limit Size'
      - id: dntt_market_size
        type: u4
        doc: 'The aggregated DNTT (Do Not Trade Through) Market Size on Bid or Ask Size'
  end_of_replay_sequence_message:
    seq:
      - id: end_of_replay_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sequence number once the replay is complete'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

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
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x45:
      id: 'strategy_best_bid_and_ask_update_message'
      doc: 'The options system will continuously calculate its best bid and ask position for active strategies on the options market during the trading day.'
    0x63:
      id: 'strategy_best_bid_update_message'
      doc: 'Strategy Best bid OR ask update. Quote update bid side.'
    0x64:
      id: 'strategy_best_ask_update_message'
      doc: 'Strategy Best bid OR ask update. Quote update ask side.'
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
      id: 'start_of_normal_hours_closing_process'
      doc: 'Start Of Normal Hours Closing Process'
    0x4c:
      id: 'start_of_late_hours_closing_process'
      doc: 'Start Of Late Hours Closing Process'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End Of Wco Early Closing'
  strategy_type:
    0x56:
      id: 'vertical_spread'
      doc: 'Vertical Spread'
    0x54:
      id: 'time_spread'
      doc: 'Time Spread'
    0x44:
      id: 'diagonal_spread'
      doc: 'Diagonal Spread'
    0x53:
      id: 'straddle'
      doc: 'Straddle'
    0x47:
      id: 'strangle'
      doc: 'Strangle'
    0x43:
      id: 'combo'
      doc: 'Combo'
    0x52:
      id: 'risk_reversal'
      doc: 'Risk Reversal'
    0x41:
      id: 'ratio_spread'
      doc: 'Ratio Spread'
    0x42:
      id: 'box_spread'
      doc: 'Box Spread'
    0x46:
      id: 'butterfly_spread'
      doc: 'Butterfly Spread'
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x58:
      id: 'closed'
      doc: 'Closed'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x45:
      id: 'strategy_best_bid_and_ask_update_message'
      doc: 'The options system will continuously calculate its best bid and ask position for active strategies on the options market during the trading day.'
    0x63:
      id: 'strategy_best_bid_update_message'
      doc: 'Strategy Best bid OR ask update. Quote update bid side.'
    0x64:
      id: 'strategy_best_ask_update_message'
      doc: 'Strategy Best bid OR ask update. Quote update ask side.'

