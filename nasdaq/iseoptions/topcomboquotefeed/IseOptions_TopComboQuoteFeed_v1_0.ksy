# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions TopComboQuoteFeed Itch v1.0
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ise Top Combo Quote Feed
#   Encoding: Itch
#   Version: 1.0
#   Date: 08/23/2017
#   Specification: ISEOrderComboFeedSpecification_tcm5044-41354.pdf
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
  id: nasdaq_iseoptions_topcomboquotefeed_itch_v1_0
  title: Nasdaq IseOptions TopComboQuoteFeed Itch v1.0
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Ise Top Combo Quote Feed Itch v1.0'
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
            'message_type::strategy_open_closed_message': strategy_open_closed_message
            'message_type::strategy_trading_action_message': strategy_trading_action_message
            'message_type::strategy_best_bid_and_ask_update': strategy_best_bid_and_ask_update
            'message_type::strategy_best_bid_update': strategy_best_bid_update
            'message_type::strategy_best_ask_update': strategy_best_ask_update
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
      - id: subversion
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
        doc: 'StrategyType value'
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
        doc: 'Number of legs in the strategy NOTE: Leg field offsets below are an equation, where “n” is the zero based leg number (0, 1, …)'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information'
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
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-8'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type:'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the leg'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
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
  strategy_best_bid_and_ask_update:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: '<space> = regular quote/autox eligible “X” = Pre-Open/Halted'
      - id: bid_price
        type: decimal_s4_4
        doc: 'Best bid price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: bid_size
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: bid_cust_size
        type: u4
        doc: 'Customer quantity on the bid side'
      - id: bid_pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid side'
      - id: bid_ntt_size
        type: u4
        doc: 'Limit Bid size that can’t be traded through'
      - id: bid_market_size
        type: u4
        doc: 'The aggregate market size on Bid side'
      - id: bid_ntt_market_size
        type: u4
        doc: 'The aggregated NTT Market Size on Bid Size'
      - id: ask_price
        type: decimal_s4_4
        doc: 'Best ask price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: ask_size
        type: u4
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
      - id: ask_cust_size
        type: u4
        doc: 'Customer quantity on the ask side'
      - id: ask_pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the ask side'
      - id: ask_ntt_size
        type: u4
        doc: 'Limit Ask size that can’t be traded through'
      - id: ask_market_size
        type: u4
        doc: 'Aggregate market quantity on Ask side'
      - id: ask_ntt_market_size
        type: u4
        doc: 'The aggregated NTT Market Size on Ask Size'
  strategy_best_bid_update:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: '<space> = regular quote/autox eligible “X” = Pre-Open/Halted'
      - id: price
        type: decimal_s4_4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits, the side determined by Message Type. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size
        type: u4
        doc: 'Customer Quantity on the bid or ask side'
      - id: pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
      - id: ntt_size
        type: u4
        doc: 'Limit size that can’t be traded through'
      - id: market_size
        type: u4
        doc: 'The aggregate market size'
      - id: ntt_market_size
        type: u4
        doc: 'The aggregated NTT Market Size'
  strategy_best_ask_update:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: '<space> = regular quote/autox eligible “X” = Pre-Open/Halted'
      - id: price
        type: decimal_s4_4
        doc: 'Best bid or ask price in fixed point format with 6 whole number places followed by 4 decimal digits, the side determined by Message Type. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: cust_size
        type: u4
        doc: 'Customer Quantity on the bid or ask side'
      - id: pro_cust_size
        type: u4
        doc: 'Customer professional quantity on the bid or ask side'
      - id: ntt_size
        type: u4
        doc: 'Limit size that can’t be traded through'
      - id: market_size
        type: u4
        doc: 'The aggregate market size'
      - id: ntt_market_size
        type: u4
        doc: 'The aggregated NTT Market Size'
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
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
      - id: volume
        type: u4
        doc: 'Total traded quantity'
      - id: high
        type: u8
        doc: 'High price for the day'
      - id: low
        type: u8
        doc: 'Low price for the day'
      - id: first
        type: u8
        doc: 'Opening price for the day'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Same value as the Trade Condition sent to OPRA for this trade. To obtain a list of Trade Conditions, refer to the NOTES below'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'complex_strategy_directory_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Strategy Message containing the strategy definition will be sent.'
    0x4f:
      id: 'strategy_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when an strategy has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'ISE uses this administrative message to indicate the current trading status of a strategy within the ISE Options Market.'
    0x43:
      id: 'strategy_best_bid_and_ask_update'
      doc: 'The options system uses this administrative message to indicate when an strategy has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x44:
      id: 'strategy_best_bid_update'
      doc: 'The options system will continuously calculate its best bid position for active strategies on the options market during the trading day. Whenever the best bid position changes on one side but not the other side, the options system will send its best bid update via this feed for the affected security.'
    0x45:
      id: 'strategy_best_ask_update'
      doc: 'The options system will continuously calculate its best offer position for active strategies on the options market during the trading day. Whenever the best ask position changes on one side but not the other side, the options system will send its best ask update via this feed for the affected security'
    0x74:
      id: 'complex_strategy_ticker_message'
      doc: 'The ticker message is used to send real time trade information'
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
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
    0x20:
      id: 'na'
      doc: 'Blank For Stock Leg'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'hidden'
      doc: 'Not Set Hidden'
  open_state:
    0x59:
      id: 'open'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed'
      doc: 'Closed For Auto Execution'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  quote_condition:
    0x20:
      id: 'regular_quote'
      doc: 'Regular Quote Auto Execution Eligible'
    0x58:
      id: 'halted'
      doc: 'Halsted Or Preopen'

