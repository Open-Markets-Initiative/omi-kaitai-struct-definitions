# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq GemxOptions TopOfMarket Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Top Of Market
#   Encoding: Itch
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Top_of_Market_Feed_2.1.pdf
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
  id: nasdaq_gemxoptions_topofmarket_itch_v2_1_tcp
  title: Nasdaq GemxOptions TopOfMarket Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq GEMX Top Of Market Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: soup_bin_tcp_packet
    type: soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet'

types:
  soup_bin_tcp_packet_struct:
    seq:
      - id: tcp_packet_header
        type: tcp_packet_header
      - id: tcp_payload
        size: tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: tcp_packet_header.packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
  tcp_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
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
        size: _parent.tcp_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::derivative_directory_message': derivative_directory_message
            'sequenced_message_type::trading_action_message': trading_action_message
            'sequenced_message_type::best_bid_and_ask_update_short_form_message': best_bid_and_ask_update_short_form_message
            'sequenced_message_type::best_bid_and_ask_update_long_form_message': best_bid_and_ask_update_long_form_message
            'sequenced_message_type::best_bid_update_short_form_message': best_bid_update_short_form_message
            'sequenced_message_type::best_ask_update_short_form_message': best_ask_update_short_form_message
            'sequenced_message_type::best_bid_update_long_form_message': best_bid_update_long_form_message
            'sequenced_message_type::best_ask_update_long_form_message': best_ask_update_long_form_message
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
  derivative_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
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
        type: u4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes'
      - id: option_type
        type: u1
        enum: option_type
        doc: '"C" = Call option, "P" = Put option, "N" = Not Applicable'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within the Exchange System'
      - id: closing_type
        type: u1
        enum: closing_type
        doc: 'Denotes which System Event is used to determine when trading ceases in this symbol'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the options security in the options market'
  best_bid_and_ask_update_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: bid_market_order_size_short
        type: u2
        doc: 'Number of market order contracts on the bid side'
      - id: bid_price_short
        type: u2
        doc: 'Best bid price in fixed point format with 3 whole number places followed by 2 decimal digits'
      - id: bid_size_short
        type: u2
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: bid_cust_size_short
        type: u2
        doc: 'Customer quantity on the bid side'
      - id: bid_procust_size_short
        type: u2
        doc: 'Customer professional quantity on the bid side'
      - id: ask_market_order_size_short
        type: u2
        doc: 'Number of market order contracts on the ask side'
      - id: ask_price_short
        type: u2
        doc: 'Best ask price in fixed point format with 3 whole number places followed by 2 decimal digits'
      - id: ask_size_short
        type: u2
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
      - id: ask_cust_size_short
        type: u2
        doc: 'Customer quantity on the ask side'
      - id: ask_procust_size_short
        type: u2
        doc: 'Customer professional quantity on the ask side'
  best_bid_and_ask_update_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: bid_market_order_size_long
        type: u4
        doc: 'Number of market order contracts on the bid side'
      - id: bid_price_long
        type: u4
        doc: 'Best bid price in fixed point format with 6 whole number places followed by 4 decimal digits'
      - id: bid_size_long
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: bid_cust_size_long
        type: u4
        doc: 'Customer quantity on the bid side'
      - id: bid_procust_size_long
        type: u4
        doc: 'Customer professional quantity on the bid side'
      - id: ask_market_order_size_long
        type: u4
        doc: 'Number of market order contracts on the ask side'
      - id: ask_price_long
        type: u4
        doc: 'Best ask price in fixed point format with 6 whole number places followed by 4 decimal digits'
      - id: ask_size_long
        type: u4
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
      - id: ask_cust_size_long
        type: u4
        doc: 'Customer quantity on the ask side'
      - id: ask_procust_size_long
        type: u4
        doc: 'Customer professional quantity on the ask side'
  best_bid_update_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: market_order_size_short
        type: u2
        doc: 'Number of market order contracts on the bid or ask side'
      - id: price_short
        type: u2
        doc: 'Best bid or Ask price in fixed point format with 3 whole number places followed by 2 decimal digits'
      - id: size_short
        type: u2
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size_short
        type: u2
        doc: 'Customer quantity on the bid or ask side'
      - id: procust_size_short
        type: u2
        doc: 'Customer professional quantity on the bid or ask side'
  best_ask_update_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: market_order_size_short
        type: u2
        doc: 'Number of market order contracts on the bid or ask side'
      - id: price_short
        type: u2
        doc: 'Best bid or Ask price in fixed point format with 3 whole number places followed by 2 decimal digits'
      - id: size_short
        type: u2
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size_short
        type: u2
        doc: 'Customer quantity on the bid or ask side'
      - id: procust_size_short
        type: u2
        doc: 'Customer professional quantity on the bid or ask side'
  best_bid_update_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: market_order_size_long
        type: u4
        doc: 'Number of market order contracts on the bid or ask side'
      - id: price_long
        type: u4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits, the side determined by Message Type'
      - id: size_long
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size_long
        type: u4
        doc: 'Customer quantity on the bid and ask side'
      - id: procust_size_long
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
  best_ask_update_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote condition'
      - id: market_order_size_long
        type: u4
        doc: 'Number of market order contracts on the bid or ask side'
      - id: price_long
        type: u4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits, the side determined by Message Type'
      - id: size_long
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size_long
        type: u4
        doc: 'Customer quantity on the bid and ask side'
      - id: procust_size_long
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
  end_of_replay_sequence_message:
    seq:
      - id: end_of_replay_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sequence number once the replay is complete'
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
  packet_type:
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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x6d:
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
      id: 'best_bid_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x61:
      id: 'best_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x42:
      id: 'best_bid_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x41:
      id: 'best_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
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
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
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
    0x42:
      id: 'buy_side_suspended'
      doc: 'Buy Side Suspended'
    0x53:
      id: 'sell_side_suspended'
      doc: 'Sell Side Suspended'
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
  quote_condition:
    0x20:
      id: 'regular_quote_autox_eligible'
      doc: 'Regular Quote Autox Eligible'
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
    0x6d:
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
      id: 'best_bid_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x61:
      id: 'best_ask_update_short_form_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this data feed for the affected security.'
    0x42:
      id: 'best_bid_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x41:
      id: 'best_ask_update_long_form_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message - Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'

