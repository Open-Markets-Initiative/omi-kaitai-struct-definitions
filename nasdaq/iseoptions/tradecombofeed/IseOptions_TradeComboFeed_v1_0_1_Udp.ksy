# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions TradeComboFeed Itch v1.0.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ise Trade Combo Feed
#   Encoding: Itch
#   Version: 1.0.1
#   Date: 08/23/2017
#   Specification: Nasdaq ISE Trade Combo Feed.pdf
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
  id: nasdaq_iseoptions_tradecombofeed_itch_v1_0_1_udp
  title: Nasdaq IseOptions TradeComboFeed Itch v1.0.1
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Ise Trade Combo Feed Itch v1.0.1'
doc-ref: https://business.nasdaq.com/trade/US-Options/Technical-Specifications.html

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'message_type::strategy_trading_action_message': strategy_trading_action_message
            'message_type::strategy_open_closed_message': strategy_open_closed_message
            'message_type::complex_strategy_ticker_message': complex_strategy_ticker_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
      - id: current_year
        type: u2
        doc: 'The current calendar year (example: 2016)'
      - id: current_month
        type: u1
        doc: 'The current calendar month, with values 1 to 12 inclusive, January=1, etc'
      - id: current_day
        type: u1
        doc: 'The current calendar day, with values 1 to 31 inclusive'
      - id: version
        type: u1
        doc: 'Version of this interface. Currently set to 1'
      - id: sub_version
        type: u1
        doc: 'Sub-version of this interface. Currently set to 0'
  complex_strategy_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'The kind of strategy the legs below make up'
      - id: source
        type: u1
        doc: 'Identifies the source of the Strategy, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: num_leg_information
        type: u1
        doc: 'Number of legs in the strategy'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information, legs repeated. n = 0, 1 and so on'
  leg_information:
    seq:
      - id: option_id
        type: u4
        doc: 'ISE’s Option ID for this leg, valid for the trading day. The same ID as the corresponding Option in the Options Directory Message. Zero (0) for Stock Leg'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
      - id: leg_id
        type: u1
        doc: 'Leg identifier within this strategy. This is an exchange-assigned 0-based index. E.g. Nth leg has LegId=N-1'
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
        type: decimal_s8_8
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Zero (0) for Stock Leg. Implied decimal with scale 1e-8'
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
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the strategy on the ISE market'
  strategy_open_closed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security in the options market'
  complex_strategy_ticker_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: last_price
        type: decimal_s8_8
        doc: 'Most recent price. Implied decimal with scale 1e-8'
      - id: size
        type: u4
        doc: 'Last traded quantity'
      - id: volume
        type: u4
        doc: 'Total traded quantity'
      - id: high
        type: decimal_s8_8
        doc: 'High price for the day. Implied decimal with scale 1e-8'
      - id: low
        type: decimal_s8_8
        doc: 'Low price for the day. Implied decimal with scale 1e-8'
      - id: first
        type: decimal_s8_8
        doc: 'Opening price for the day. Implied decimal with scale 1e-8'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same value as the Trade Condition sent to OPRA for this trade. To obtain a list of Trade Conditions, refer to the NOTES below'
  nanosecond_timestamp:
    seq:
      - id: time
        type: b48
    instances:
      hour:
        value: time.as<s8> / 3600000000000 % 24
      minute:
        value: time.as<s8> / 60000000000 % 60
      second:
        value: time.as<s8> / 1000000000 % 60
      millisecond:
        value: time.as<s8> / 1000000 % 1000
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0

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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'complex_strategy_directory_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'ISE uses this administrative message to indicate the current trading status of a strategy within the ISE Options Market. Messages will be sent when the strategy is halted or is released for trading.'
    0x4f:
      id: 'strategy_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when a strategy has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x74:
      id: 'complex_strategy_ticker_message'
      doc: 'The ticker message is used to send real time trade information.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. This is always the first message sent in any trading day.'
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start of System Hours. This message indicates that the options system is open and ready to start accepting orders.'
    0x51:
      id: 'start_of_opening_process'
      doc: 'Start of Opening Process. This message is intended to indicate that the options system has started its opening auction process.'
    0x4e:
      id: 'start_of_normal_hours_closing_process'
      doc: 'Start of Normal Hours Closing Process. This message is intended to indicate that the options system will no longer generate new executions for options that trade during normal hours.'
    0x4c:
      id: 'start_of_late_hours_closing_process'
      doc: 'Start of Late Hours Closing Process. This message is intended to indicate that the options system will no longer generate new executions for options that trade during extended hours.'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End of System Hours. This message indicates that the options system is now closed.'
    0x43:
      id: 'end_of_messages'
      doc: 'End of Messages. This is always the last message sent in any trading day.'
    0x57:
      id: 'end_of_wco_early_closing'
      doc: 'End of WCO Early closing. This message is intended to indicate that the exchange will no longer accept any new orders or changes to existing Orders on last trading date of WCO options.'
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
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x20:
      id: 'na'
      doc: 'Blank for Stock Leg'
  side:
    0x42:
      id: 'buy'
      doc: 'Leg is on Buy side'
    0x53:
      id: 'sell'
      doc: 'Leg is on Sell side'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt in effect'
    0x54:
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  open_state:
    0x59:
      id: 'open'
      doc: 'Open for auto execution'
    0x4e:
      id: 'closed'
      doc: 'Closed for auto execution'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'complex_strategy_directory_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'ISE uses this administrative message to indicate the current trading status of a strategy within the ISE Options Market. Messages will be sent when the strategy is halted or is released for trading.'
    0x4f:
      id: 'strategy_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when a strategy has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x74:
      id: 'complex_strategy_ticker_message'
      doc: 'The ticker message is used to send real time trade information.'

