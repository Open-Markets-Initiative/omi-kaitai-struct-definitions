# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NomOptions Bono Itch v3.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Nom Binary Order Entry
#   Encoding: Itch
#   Version: 3.2
#   Date: 11/02/2017
#   Specification: http://www.nasdaqtrader.com/content/productsservices/trading/optionsmarket/BONO_spec.pdf
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
# The Binary Data Compiler technologies used to produce this file
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
  id: nomoptions_bono_v3_2
  title: Nasdaq NomOptions Bono Itch v3.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Options Market Nom Binary Order Entry Itch v3.2'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs#options_q

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
            'message_type::timestamp_message': timestamp_message
            'message_type::system_event_message': system_event_message
            'message_type::options_directory_message': options_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::security_open_closed_message': security_open_closed_message
            'message_type::short_best_bid_and_ask_update_message': short_best_bid_and_ask_update_message
            'message_type::long_best_bid_and_ask_update_message': long_best_bid_and_ask_update_message
            'message_type::short_best_ask_update_message': short_best_ask_update_message
            'message_type::short_best_bid_update_message': short_best_bid_update_message
            'message_type::long_best_ask_update_message': long_best_ask_update_message
            'message_type::long_best_bid_update_message': long_best_bid_update_message
            'message_type::trade_report_message': trade_report_message
            'message_type::broken_trade_report_message': broken_trade_report_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  timestamp_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Number of seconds since midnight (U.S. Eastern Time). Seconds since Midnight epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
      - id: version
        type: u1
        doc: 'Version of this interface. Currently set to 3'
      - id: subversion
        type: u1
        doc: 'Sub-version of this interface. Currently set to 0'
  options_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol)'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month of the option (1-12)'
      - id: expiration_day
        type: u1
        doc: 'Day of the Month of expiration (1-31)'
      - id: strike_price
        type: s4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type value'
      - id: source
        type: u1
        doc: 'Identifies the source of the option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within the Exchange System'
      - id: option_closing_type
        type: u1
        enum: option_closing_type
        doc: 'Denotes which System Event is used to determine when trading ceases in this symbol'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange:'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option'
  trading_action_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the option in the options market'
  security_open_closed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security in the options market'
  short_best_bid_and_ask_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: bid_price_2
        type: s2
        doc: 'Best bid price. NOTE: When converted to a decimal format, the price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: bid_size_2
        type: u2
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: ask_price_2
        type: s2
        doc: 'Best ask price. NOTE: When converted to a decimal format, the price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: ask_size_2
        type: u2
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
  long_best_bid_and_ask_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: bid_price_4
        type: s4
        doc: 'Best bid price. Implied decimal with scale 1e-4'
      - id: bid_size_4
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
      - id: ask_price_4
        type: s4
        doc: 'Best ask price. Implied decimal with scale 1e-4'
      - id: ask_size_4
        type: u4
        doc: 'Aggregated number of contracts on the ask side being displayed in the options market at the current time'
  short_best_ask_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: price_2
        type: s2
        doc: 'Best bid or ask price, the side determined by the Message Type. NOTE: When converted to a decimal format, the price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: size_2
        type: u2
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
  short_best_bid_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: price_2
        type: s2
        doc: 'Best bid or ask price, the side determined by the Message Type. NOTE: When converted to a decimal format, the price is in fixed point format with 3 whole number places followed by 2 decimal digits. Implied decimal with scale 1e-2'
      - id: size_2
        type: u2
        doc: 'Aggregated number of contracts on the bid or ask side being displayed in the options market at the current time'
  long_best_ask_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: price_4
        type: s4
        doc: 'Best bid or ask price, the side determined by the Message Type. Implied decimal with scale 1e-4'
      - id: size_4
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
  long_best_bid_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: quote_condition
        type: u1
        enum: quote_condition
        doc: 'Quote Condition value'
      - id: price_4
        type: s4
        doc: 'Best bid or ask price, the side determined by the Message Type. Implied decimal with scale 1e-4'
      - id: size_4
        type: u4
        doc: 'Aggregated number of contracts on the bid side being displayed in the options market at the current time'
  trade_report_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: cross_id
        type: u4
        doc: 'Indicates the internal control number (cross id) associated with the given option trade transaction'
      - id: trade_condition
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'To obtain a list of Trade Conditions, refer to the NOTE below'
      - id: price_4
        type: s4
        doc: 'Best bid or ask price, the side determined by the Message Type. Implied decimal with scale 1e-4'
      - id: volume
        type: u4
        doc: 'Reflects the number of contracts traded for an option in one trade'
  broken_trade_report_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'The sub-second portion of the time, in nanoseconds (0-999999999). The second portion of the time is obtained from the most recent timestamp message. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: original_cross_id
        type: u4
        doc: 'Indicates the internal control number (cross id) associated with the given trade transaction in the options market system'
      - id: original_price
        type: s4
        doc: 'Reported Premium Price of an option contract in the original trade report message on this feed. Implied decimal with scale 1e-4'
      - id: original_volume
        type: u4
        doc: 'Reported number of contracts in the original trade report message on this feed'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000

enums:
  message_type:
    0x54:
      id: 'timestamp_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, the options system disseminates directory messages for all symbols eligible for the auction process in the options system.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x4f:
      id: 'security_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when an option has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x71:
      id: 'short_best_bid_and_ask_update_message'
      doc: 'Whenever the best bid and ask position changes on both sides, the options system will send its best bid and ask update via the data feed for the affected security.'
    0x51:
      id: 'long_best_bid_and_ask_update_message'
      doc: 'This message is the same as the Best Bid AND Ask Update Message – Short Form described above except that Prices and Sizes are 4 byte Integers, the prices having 4 implied decimal places.'
    0x61:
      id: 'short_best_ask_update_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this feed for the affected security.'
    0x62:
      id: 'short_best_bid_update_message'
      doc: 'The options system will continuously calculate its best bid and offer position for active options contracts on the options market during the trading day. Whenever the best bid or ask position changes on one side but not the other side, the options system will send its best bid or ask update via this feed for the affected security.'
    0x41:
      id: 'long_best_ask_update_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message – Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x42:
      id: 'long_best_bid_update_message'
      doc: 'This message is the same as the Best Bid OR Ask Update Message – Short Form described above except that Prices and Sizes are 4 byte Integers, the price having 4 implied decimal places.'
    0x52:
      id: 'trade_report_message'
      doc: 'The Trade Report message will be used to relay execution system transactions that are reported during the current business day. The options system only reports one-side of a trade execution on the feed and other data feed products.'
    0x58:
      id: 'broken_trade_report_message'
      doc: 'The following message is used in the event that an options trade transaction is broken on the same business day that it is reported.'
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
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
  option_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
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
    0x54:
      id: 'trading'
      doc: 'Trading On The Options System'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed For Auto Execution'
  quote_condition:
    0x20:
      id: 'regular_quoteautox_eligible'
      doc: 'Regular Quoteautox Eligible'
    0x52:
      id: 'rotational_quote'
      doc: 'Rotational Quote'
    0x58:
      id: 'bid_side_firm'
      doc: 'Ask Side Not Firm Bid Side Firm'
    0x59:
      id: 'ask_side_firm'
      doc: 'Bid Side Not Firm Ask Side Firm'

