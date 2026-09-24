# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax SapphireOptions ComplexTopOfMarket Mach v1.0.a
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Complex Top of Market
#   Encoding: Mach
#   Version: 1.0.a
#   Date: 01/25/2024
#   Specification: Sapphire_Complex_Top_Of_Market_Feed_cToM_v1.0a.pdf
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
  id: miax_sapphireoptions_complextopofmarket_mach_v1_0_a_udp
  title: Miax SapphireOptions ComplexTopOfMarket Mach v1.0.a
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Sapphire Options Complex Top of Market Mach v1.0.a'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-sapphire/interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: packet_length
        type: u2
        doc: 'Length of the packet, including the header and application data'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'protocol packet type'
      - id: session_number
        type: u1
        doc: 'protocol packet type'
      - id: payload
        type:
          switch-on: packet_type
          cases:
            'packet_type::application_message': application_message
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::simple_series_update_message': simple_series_update_message
            'message_type::complex_strategy_definition_message': complex_strategy_definition_message
            'message_type::system_state_message': system_state_message
            'message_type::complex_top_of_market_best_bid_or_offer_compact_format_bid_message': complex_top_of_market_best_bid_or_offer_compact_format_bid_message
            'message_type::complex_top_of_market_best_bid_or_offer_compact_format_offer_message': complex_top_of_market_best_bid_or_offer_compact_format_offer_message
            'message_type::complex_top_of_market_best_bid_or_offer_wide_format_bid_message': complex_top_of_market_best_bid_or_offer_wide_format_bid_message
            'message_type::complex_top_of_market_best_bid_or_offer_wide_format_offer_message': complex_top_of_market_best_bid_or_offer_wide_format_offer_message
            'message_type::complex_double_sided_top_of_market_best_bid_and_offer_compact_format_message': complex_double_sided_top_of_market_best_bid_and_offer_compact_format_message
            'message_type::complex_double_sided_top_of_market_best_bid_and_offer_wide_format_message': complex_double_sided_top_of_market_best_bid_and_offer_wide_format_message
            'message_type::strategy_last_sale_message': strategy_last_sale_message
            'message_type::underlying_trading_status_notification_message': underlying_trading_status_notification_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  simple_series_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Sapphire Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option Security Symbol'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiration date of the option in YYYYMMDD format'
      - id: strike_price
        type: decimal_u4_4
        doc: 'Explicit strike price of the option. Refer to data types for field processing notes. Implied decimal with scale 1e-4'
      - id: call_or_put
        type: u1
        enum: call_or_put
        doc: 'Option Type'
      - id: opening_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. e.g.: 09:30:00'
      - id: closing_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. e.g.: 16:15:00'
      - id: restricted_option
        type: u1
        enum: restricted_option
        doc: 'Restricted Option value'
      - id: long_term_option
        type: u1
        enum: long_term_option
        doc: 'Long Term Option value'
      - id: active_on_sapphire
        type: u1
        enum: active_on_sapphire
        doc: 'Indicates if this symbol is tradable on Sapphire in the current session'
      - id: sapphire_bbo_posting_increment_indicator
        type: u1
        enum: sapphire_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by Sapphire'
      - id: liquidity_acceptance_increment_indicator
        type: u1
        enum: liquidity_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote/Order acceptance as per Sapphire rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
  complex_strategy_definition_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: active_on_sapphire
        type: u1
        enum: active_on_sapphire
        doc: 'Indicates if this symbol is tradable on Sapphire in the current session'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: update_reason
        type: u1
        enum: update_reason
        doc: 'Update Reason value'
      - id: reserved_10
        size: 10
        doc: 'Reserved for future use'
      - id: number_of_legs
        type: u1
        doc: 'Number of Legs. Valid values: 2-12 (for Options only), 2-13 (for Stock-tied)'
      - id: leg_definition_0
        type: str
        size-eos: true
        encoding: ASCII
        doc: 'Repeating leg block, count given by Number of Legs'
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: c_to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'e.g.: CTOM01.01'
      - id: session_id
        type: u4
        doc: 'Sapphire assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  complex_top_of_market_best_bid_or_offer_compact_format_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_short
        type: decimal_s2_2
        doc: 'Sapphire Best price at the time stated in Timestamp and side specified in Message Type. The net limit price for the strategy. Implied decimal with scale 1e-2'
      - id: size_short
        type: u2
        doc: 'Aggregate size at Sapphire Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Price for the Complex Strategy'
      - id: condition
        type: u1
        enum: condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_best_bid_or_offer_compact_format_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_short
        type: decimal_s2_2
        doc: 'Sapphire Best price at the time stated in Timestamp and side specified in Message Type. The net limit price for the strategy. Implied decimal with scale 1e-2'
      - id: size_short
        type: u2
        doc: 'Aggregate size at Sapphire Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Price for the Complex Strategy'
      - id: condition
        type: u1
        enum: condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_best_bid_or_offer_wide_format_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_long
        type: decimal_s8_4
        doc: 'Sapphire Best price at the time stated in Timestamp and side specified in Message Type. The net limit price for the strategy. Implied decimal with scale 1e-4'
      - id: size_long
        type: u4
        doc: 'Aggregate size at Sapphire Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Price for the Complex Strategy'
      - id: condition
        type: u1
        enum: condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_best_bid_or_offer_wide_format_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_long
        type: decimal_s8_4
        doc: 'Sapphire Best price at the time stated in Timestamp and side specified in Message Type. The net limit price for the strategy. Implied decimal with scale 1e-4'
      - id: size_long
        type: u4
        doc: 'Aggregate size at Sapphire Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Price for the Complex Strategy'
      - id: condition
        type: u1
        enum: condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_double_sided_top_of_market_best_bid_and_offer_compact_format_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: bid_price_short
        type: decimal_s2_2
        doc: 'Sapphire Best Bid net price. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Aggregate size at Sapphire Best Bid Net Price'
      - id: bid_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Bid Price for the Complex Strategy'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Top of Strategy Market Quote Conditions'
      - id: offer_price_short
        type: decimal_s2_2
        doc: 'Sapphire Best Offer net price. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'Aggregate size at Sapphire Best Bid Net Price'
      - id: offer_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Offer Price for the Complex Strategy'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_double_sided_top_of_market_best_bid_and_offer_wide_format_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: bid_price_long
        type: decimal_s8_4
        doc: 'Sapphire Best Bid net price. Implied decimal with scale 1e-4'
      - id: bid_size_long
        type: u4
        doc: 'Aggregate size at Sapphire Best Bid Net Price'
      - id: bid_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Bid Price for the Complex Strategy'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Top of Strategy Market Quote Conditions'
      - id: offer_price_long
        type: decimal_s8_4
        doc: 'Sapphire Best Offer net price. Implied decimal with scale 1e-4'
      - id: offer_size_long
        type: u4
        doc: 'Aggregate size at Sapphire Best Bid Net Price'
      - id: offer_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at Sapphire Best Offer Price for the Complex Strategy'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Top of Strategy Market Quote Conditions'
  strategy_last_sale_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'Sapphire Strategy ID is assigned per trading day and is valid only for that day'
      - id: trade_id
        type: u4
        doc: 'Unique Complex Trade ID assigned to every trade'
      - id: net_price
        type: decimal_s8_4
        doc: 'The net transaction price of the complex package. Implied decimal with scale 1e-4'
      - id: size_long
        type: u4
        doc: 'Aggregate size at Sapphire Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: reserved_17
        size: 17
        doc: 'Reserved for future use'
  underlying_trading_status_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Sapphire system today. Nanoseconds since Second epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status value'
      - id: event_reason
        type: u1
        enum: event_reason
        doc: 'Event Reason value'
      - id: expected_event_time_seconds_part
        type: u4
        doc: 'Seconds portion of the expected time of the event. Always use in conjunction with the Nano-seconds part field'
      - id: expected_event_time_nano_seconds_part
        type: u4
        doc: 'Nano-seconds portion of the expected time of the event. Specifies number of nano-seconds since the seconds specified in "Expected Event Time Seconds" field'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s2_2:
    seq:
      - id: mantissa
        type: s2
    instances:
      real:
        value: mantissa / 100.0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  packet_type:
    0:
      id: 'heartbeat'
      doc: 'Mach Heartbeat Message'
    1:
      id: 'start_of_session'
      doc: 'Mach Start Of Session Message; Sequence Number is set to 0'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    0x31:
      id: 'system_time_message'
      doc: 'This is the message format that will be used to disseminate the "seconds" part of the timestamp that is applicable to all messages that are sent in the current second.'
    0x50:
      id: 'simple_series_update_message'
      doc: 'This is the message format that will be used to disseminate all Option series traded on Sapphire for the current session.'
    0x43:
      id: 'complex_strategy_definition_message'
      doc: 'This is the message format that will be used to disseminate stock option strategies traded on Sapphire for the current session.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x62:
      id: 'complex_top_of_market_best_bid_or_offer_compact_format_bid_message'
      doc: 'This is the message format that will be used to disseminate each side of the Sapphire Complex Top of Market for strategies with low Net Price and small aggregate Sapphire Best Bid or Offer (SBBO) size. Sapphire Complex Top of Market on Bid side.'
    0x6f:
      id: 'complex_top_of_market_best_bid_or_offer_compact_format_offer_message'
      doc: 'This is the message format that will be used to disseminate each side of the Sapphire Complex Top of Market for strategies with low Net Price and small aggregate Sapphire Best Bid or Offer (SBBO) size. Sapphire Complex Top of Market on Offer side.'
    0x65:
      id: 'complex_top_of_market_best_bid_or_offer_wide_format_bid_message'
      doc: 'This is the message format that will be used to disseminate Sapphire Complex Top of Market for strategies with high net price or large aggregate Sapphire Best Bid or Offer (SBBO) size. Sapphire Complex Top of Market on Bid side.'
    0x66:
      id: 'complex_top_of_market_best_bid_or_offer_wide_format_offer_message'
      doc: 'This is the message format that will be used to disseminate Sapphire Complex Top of Market for strategies with high net price or large aggregate Sapphire Best Bid or Offer (SBBO) size. Sapphire Complex Top of Market on Offer side.'
    0x6d:
      id: 'complex_double_sided_top_of_market_best_bid_and_offer_compact_format_message'
      doc: 'This is the message format that will be used to disseminate both sides of the Sapphire top of market for strategies (cSBBO) with low net price and small aggregate size.'
    0x77:
      id: 'complex_double_sided_top_of_market_best_bid_and_offer_wide_format_message'
      doc: 'This is the message format that will be used to disseminate both sides of the Sapphire top of market for strategies (cSBBO) with net prices or aggregate sizes which cannot be specified in the compact format.'
    0x74:
      id: 'strategy_last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on Sapphire during the current trading session.'
    0x48:
      id: 'underlying_trading_status_notification_message'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying.'
  call_or_put:
    0x43:
      id: 'call'
      doc: 'Call Option Type'
    0x50:
      id: 'put'
      doc: 'Put Option Type'
  restricted_option:
    0x59:
      id: 'yes_field'
      doc: 'Sapphire Will Accept Position Closing Orders Only'
    0x4e:
      id: 'no_field'
      doc: 'Sapphire Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'yes_field'
      doc: 'Far Month Expiration As Defined By Sapphire Rules'
    0x4e:
      id: 'no_field'
      doc: 'Near Month Expiration As Defined By Sapphire Rules'
  active_on_sapphire:
    0x41:
      id: 'active'
      doc: 'Active Tradable On Sapphire'
    0x49:
      id: 'inactive'
      doc: 'Inactive Not Tradable On Sapphire'
  sapphire_bbo_posting_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny 001 For All Prices'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny 001 If Price 3 Nickel 005 If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel 005 If Price 3 Dime 010 If Price 3'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny 001 For All Prices'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny 001 If Price 3 Nickel 005 If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel 005 If Price 3 Dime 010 If Price 3'
  opening_underlying_market_code:
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'national_stock_exchange'
      doc: 'National Stock Exchange'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x45:
      id: 'market_independent'
      doc: 'Any Market That Opens First'
    0x48:
      id: 'miax_pearl_equities'
      doc: 'Miax Pearl Equities'
    0x49:
      id: 'international_securities_exchange'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'edga_exchange_inc'
      doc: 'Edga Exchange Inc'
    0x4b:
      id: 'edgx_exchange_inc'
      doc: 'Edgx Exchange Inc'
    0x4c:
      id: 'ltse'
      doc: 'Ltse'
    0x4d:
      id: 'chicago_stock_exchange'
      doc: 'Chicago Stock Exchange'
    0x4e:
      id: 'nyse_euronext'
      doc: 'Nyse Euronext'
    0x50:
      id: 'nyse_arca_exchange'
      doc: 'Nyse Arca Exchange'
    0x51:
      id: 'nasdaq_omx_via_utp_feed'
      doc: 'Nasdaq Omx Via Utp Feed'
    0x54:
      id: 'nasdaq_omx_via_cta_feed'
      doc: 'Nasdaq Omx Via Cta Feed'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x57:
      id: 'cboe_stock_exchange_cbsx'
      doc: 'Cboe Stock Exchange Cbsx'
    0x58:
      id: 'nasdaq_omx_phlx'
      doc: 'Nasdaq Omx Phlx'
    0x59:
      id: 'bats_y_exchange_inc'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats_exchange_inc'
      doc: 'Bats Exchange Inc'
  update_reason:
    0x4e:
      id: 'new_strategy_created'
      doc: 'New Strategy Created'
    0x55:
      id: 'updated'
      doc: 'Strategy Definition Updated'
  system_status:
    0x53:
      id: 'start_of_system_hours'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x31:
      id: 'start_test_session'
      doc: 'Start Of Test Session Sent Before Tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x57:
      id: 'wide'
      doc: 'Wide Market Protection'
    0x43:
      id: 'timer_in_progress'
      doc: 'Timer In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'simple_market_protection_prevented'
      doc: 'Simple Market Protections Strategy Match Prevented'
  bid_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x57:
      id: 'wide'
      doc: 'Wide Market Protection'
    0x43:
      id: 'timer_in_progress'
      doc: 'Timer In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'simple_market_protection_prevented'
      doc: 'Simple Market Protections Strategy Match Prevented'
  offer_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x57:
      id: 'wide'
      doc: 'Wide Market Protection'
    0x43:
      id: 'timer_in_progress'
      doc: 'Timer In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'simple_market_protection_prevented'
      doc: 'Simple Market Protections Strategy Match Prevented'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Sapphire Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'resumed'
      doc: 'Sapphire Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'opened'
      doc: 'Sapphire Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'automatic'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'manual'
      doc: 'Sapphire Manually Initiated This Event'
  sesm_packet_type:
    0x73:
      id: 'sequenced_data_packet'
      doc: 'SesM sequenced data packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'SesM unsequenced data packet'
    0x6c:
      id: 'login_request'
      doc: 'SesM Login Request'
    0x72:
      id: 'login_response'
      doc: 'SesM Login Response'
    0x63:
      id: 'synchronization_complete'
      doc: 'SesM Synchronization Complete'
    0x61:
      id: 'retransmission_request'
      doc: 'SesM Retransmission Request'
    0x58:
      id: 'logout_request'
      doc: 'SesM Logout Request'
    0x47:
      id: 'goodbye_packet'
      doc: 'SesM Logout Request'
    0x75:
      id: 'trading_session_update'
      doc: 'SesM Trading Session Update'
    0x30:
      id: 'server_heartbeat'
      doc: 'SesM Server Heartbeat'
    0x31:
      id: 'client_heartbeat'
      doc: 'SesM Client Heartbeat'
    0x54:
      id: 'test_packet'
      doc: 'SesM Test Packet'
  unsequenced_message_type:
    0x52:
      id: 'refresh_request_message'
      doc: 'Sent by the firm over the cToM Retransmission Interface (SesM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Sapphire over the cToM Retransmission Interface (SesM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request. Note: MIAX Sapphire PDF assigns Response Type "R" (uppercase) to this message, colliding with the Request Type "R" byte; lowercase "r" is used here to match the Pearl convention for case-distinct discrimination.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Sapphire over the cToM Retransmission Interface (SesM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x50:
      id: 'simple_series_update_refresh'
      doc: 'Simple Series Update Refresh'
    0x43:
      id: 'complex_strategy_update_refresh'
      doc: 'Complex Strategy Update Refresh'
    0x54:
      id: 'top_of_strategy_market_refresh'
      doc: 'Top Of Strategy Market Refresh'
    0x55:
      id: 'underlying_trading_status_refresh'
      doc: 'Underlying Trading Status Refresh'
    0x53:
      id: 'system_state_refresh'
      doc: 'System State Refresh'
  login_status:
    0x20:
      id: 'successful'
      doc: 'Successful'
    0x53:
      id: 'invalid_trading_session_requested'
      doc: 'Invalid trading session requested for the Matching Engine'
    0x55:
      id: 'no_active_trading_session_exists'
      doc: 'No active trading session exists for the Matching Engine, Matching Engine unavailable'
    0x58:
      id: 'rejected'
      doc: 'Invalid Username/Computer ID combination'
    0x4e:
      id: 'invalid_start_sequence_number_requested'
      doc: 'Invalid start sequence number requested'
    0x49:
      id: 'incompatible_session_protocol_version'
      doc: 'Incompatible Session protocol version'
    0x41:
      id: 'incompatible_application_protocol_version'
      doc: 'Incompatible application protocol version'
    0x4c:
      id: 'request_rejected_because_client_already_logged_in'
      doc: 'Request rejected because client already logged in'
  logout_reason:
    0x20:
      id: 'graceful_logout'
      doc: 'Graceful Logout'
    0x42:
      id: 'bad_packet'
      doc: 'Bad SesM packet'
    0x4c:
      id: 'timed_out'
      doc: 'Timed out waiting for Login Packet'
    0x41:
      id: 'application_terminating_connection'
      doc: 'Application terminating connection'

