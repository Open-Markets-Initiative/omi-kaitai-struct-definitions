# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions ComplexTopOfMarket Mach v1.3
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Complex Top Of Market
#   Encoding: Mach
#   Version: 1.3
#   Date: 03/16/2018
#   Specification: Complex_Top_Of_Market_Feed_cToM_v1_3.pdf
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
  id: miax_miaxoptions_complextopofmarket_mach_v1_3
  title: Miax MiaxOptions ComplexTopOfMarket Mach v1.3
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Options Complex Top Of Market Mach v1.3'
doc-ref: https://www.miaxoptions.com/interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Sequence number of this data packet'
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
            'message_type::complex_top_of_market_bid_compact_message': complex_top_of_market_bid_compact_message
            'message_type::complex_top_of_market_offer_compact_message': complex_top_of_market_offer_compact_message
            'message_type::complex_top_of_market_bid_wide_message': complex_top_of_market_bid_wide_message
            'message_type::complex_top_of_market_offer_wide_message': complex_top_of_market_offer_wide_message
            'message_type::complex_double_sided_top_of_market_compact_message': complex_double_sided_top_of_market_compact_message
            'message_type::complex_double_sided_top_of_market_wide_message': complex_double_sided_top_of_market_wide_message
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
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Expressed in HH:MM:SS format. Eg: 09:30:00'
      - id: closing_time
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expressed in HH:MM:SS format. Eg: 16:15:00'
      - id: restricted_option
        type: u1
        enum: restricted_option
        doc: 'Restricted Option value'
      - id: long_term_option
        type: u1
        enum: long_term_option
        doc: 'Long Term Option value'
      - id: active_on_miax
        type: u1
        enum: active_on_miax
        doc: 'Indicates if this symbol is tradable on MIAX in the current session'
      - id: miax_bbo_posting_increment_indicator
        type: u1
        enum: miax_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by MIAX'
      - id: liquidity_acceptance_increment_indicator
        type: u1
        enum: liquidity_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote/Order acceptance as per MIAX rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market:'
      - id: priority_quote_width
        type: decimal_u4_4
        doc: 'Maximum allowable width for a quote for this Option during regular trading in order to be considered as Priority Quote. 0 when Priority Quote Width is not applicable. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  complex_strategy_definition_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: active_on_miax
        type: u1
        enum: active_on_miax
        doc: 'Indicates if this symbol is tradable on MIAX in the current session'
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
      - id: num_leg_definition
        type: u1
        doc: 'Number of Legs. Variable from 2 to 8'
      - id: leg_definition
        type: leg_definition
        repeat: expr
        repeat-expr: num_leg_definition
        doc: 'Complex Strategy Number of Legs'
  leg_definition:
    seq:
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: leg_ratio_qty
        type: u2
        doc: 'The ratio of this individual leg'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'The side of this individual leg'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: CTOM01.01'
      - id: session_id
        type: u4
        doc: 'MIAX assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  complex_top_of_market_bid_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_2
        type: decimal_s2_2
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Price for the Complex Strategy'
      - id: top_of_market_quote_condition
        type: u1
        enum: top_of_market_quote_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_offer_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_2
        type: decimal_s2_2
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Price for the Complex Strategy'
      - id: top_of_market_quote_condition
        type: u1
        enum: top_of_market_quote_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_bid_wide_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_8
        type: decimal_s8_4
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Price for the Complex Strategy'
      - id: top_of_market_quote_condition
        type: u1
        enum: top_of_market_quote_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_top_of_market_offer_wide_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: price_8
        type: decimal_s8_4
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Price for the Complex Strategy'
      - id: top_of_market_quote_condition
        type: u1
        enum: top_of_market_quote_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_double_sided_top_of_market_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: bid_price_2
        type: decimal_s2_2
        doc: 'MIAX Best Bid net price. Implied decimal with scale 1e-2'
      - id: bid_size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Bid Net Price'
      - id: bid_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Bid Price for the Complex Strategy'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Top of Strategy Market Quote Conditions'
      - id: offer_price_2
        type: decimal_s2_2
        doc: 'MIAX Best Offer net price. Implied decimal with scale 1e-2'
      - id: offer_size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Bid Net Price'
      - id: offer_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Offer Price for the Complex Strategy'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Top of Strategy Market Quote Conditions'
  complex_double_sided_top_of_market_wide_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: bid_price_8
        type: decimal_s8_4
        doc: 'MIAX Best Bid net price. Implied decimal with scale 1e-4'
      - id: bid_size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Bid Net Price'
      - id: bid_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Bid Price for the Complex Strategy'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Top of Strategy Market Quote Conditions'
      - id: offer_price_8
        type: decimal_s8_4
        doc: 'MIAX Best Offer net price. Implied decimal with scale 1e-4'
      - id: offer_size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Bid Net Price'
      - id: offer_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at MIAX Best Offer Price for the Complex Strategy'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Top of Strategy Market Quote Conditions'
  strategy_last_sale_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: trade_id
        type: u4
        doc: 'Unique Complex Trade ID assigned to every trade'
      - id: net_price
        type: decimal_s8_4
        doc: 'The net transaction price of the complex package. (Leg component prices times base sizes +/- other leg component prices times their base sizes, split pricing accounted for). Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Number of strategies executed in this trade'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Type'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  underlying_trading_status_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
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
      - id: expected_event_time_seconds
        type: u4
        doc: 'Seconds portion of the expected time of the event. Always use in conjunction with the Nano-seconds part field'
      - id: expected_event_time_nano_seconds
        type: u4
        doc: 'Nano-seconds portion of the expected time of the event. Specifies number of nano-seconds since the seconds specified in “Expected Event Time Seconds” field'
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
      doc: 'Mach Start Of Session Message'
    2:
      id: 'end_of_session'
      doc: 'Mach end of session Message'
    3:
      id: 'application_message'
      doc: 'Mach Application Message'
  message_type:
    0x31:
      id: 'system_time_message'
      doc: 'This is the message format that will be used to disseminate the “seconds” part of the timestamp that is applicable to all messages that are sent in the current second.'
    0x50:
      id: 'simple_series_update_message'
      doc: 'This is the message format that will be used to disseminate all Option series traded on MIAX for the current session. The product ID sent in this message is what will be disseminated in Top of Market BBO and Last Sale messages.'
    0x43:
      id: 'complex_strategy_definition_message'
      doc: 'This is the message format that will be used to disseminate stock option strategies traded on MIAX for the current session.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x62:
      id: 'complex_top_of_market_bid_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Complex Top of Market for options with low Net Price and small aggregate MIAX Best Bid or Offer (MBBO) size'
    0x6f:
      id: 'complex_top_of_market_offer_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Complex Top of Market for options with low Net Price and small aggregate MIAX Best Bid or Offer (MBBO) size'
    0x65:
      id: 'complex_top_of_market_bid_wide_message'
      doc: 'This is the message format that will be used to disseminate MIAX Complex Top of Market for strategies with high net price or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x66:
      id: 'complex_top_of_market_offer_wide_message'
      doc: 'This is the message format that will be used to disseminate MIAX Complex Top of Market for strategies with high net price or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x6d:
      id: 'complex_double_sided_top_of_market_compact_message'
      doc: 'This is the message format that will be used to disseminate both sides of the MIAX top of market for strategies (cMBBO) with low net price and small aggregate size.'
    0x77:
      id: 'complex_double_sided_top_of_market_wide_message'
      doc: 'This is the message format that will be used to disseminate both sides of the MIAX top of market for strategies (cMBBO) with net prices or aggregate sizes which cannot be specified in the compact format.'
    0x74:
      id: 'strategy_last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on MIAX during the current trading session'
    0x48:
      id: 'underlying_trading_status_notification_message'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying'
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
      doc: 'Miax Will Accept Position Closing Orders Only'
    0x4e:
      id: 'no_field'
      doc: 'Miax Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'yes_field'
      doc: 'Far Month Expiration'
    0x4e:
      id: 'no_field'
      doc: 'Near Month Expiration'
  active_on_miax:
    0x41:
      id: 'active'
      doc: 'Activetradable On Miax'
    0x49:
      id: 'inactive'
      doc: 'Inactivenontradable On Miax'
  miax_bbo_posting_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny If Price 3 Nickel If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel If Price 3 Dime If Price 3'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny If Price 3 Nickel If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel If Price 3 Dime If Price 3'
  opening_underlying_market_code:
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'nse'
      doc: 'National Stock Exchange'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x45:
      id: 'market_independent'
      doc: 'Market Independent Any Market That Opens First'
    0x49:
      id: 'ise'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'edga'
      doc: 'Edga Exchange Inc'
    0x4b:
      id: 'edgx'
      doc: 'Edgx Exchange Inc'
    0x4d:
      id: 'cse'
      doc: 'Chicago Stock Exchange'
    0x4e:
      id: 'nyse_euronext'
      doc: 'Nyse Euronext'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca Exchange'
    0x51:
      id: 'nasdaq_omx_utp'
      doc: 'Nasdaq Omx Via Utp Feed'
    0x54:
      id: 'nasdaq_omx_cta'
      doc: 'Nasdaq Omx Via Cta Feed'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x58:
      id: 'nasdaq_omx_phlx'
      doc: 'Nasdaq Omx Phlx'
    0x59:
      id: 'bats_y'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats'
      doc: 'Bats Exchange Inc'
  update_reason:
    0x4e:
      id: 'new_strategy_created'
      doc: 'New'
    0x55:
      id: 'updated'
      doc: 'Strategy Definition Updated'
  leg_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
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
  top_of_market_quote_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
    0x57:
      id: 'wide'
      doc: 'Wide Market Protection'
    0x53:
      id: 'simple_auction'
      doc: 'Simple Market Auction Or Timer In Progress'
    0x43:
      id: 'complex_auction'
      doc: 'Complex Auction In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'leg_market_protection'
      doc: 'Leg Market Protection Book Match Prevented'
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
    0x53:
      id: 'simple_auction'
      doc: 'Simple Market Auction Or Timer In Progress'
    0x43:
      id: 'complex_auction'
      doc: 'Complex Auction In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'leg_market_protection'
      doc: 'Leg Market Protection Book Match Prevented'
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
    0x53:
      id: 'simple_auction'
      doc: 'Simple Market Auction Or Timer In Progress'
    0x43:
      id: 'complex_auction'
      doc: 'Complex Auction In Progress'
    0x4d:
      id: 'simple_market_protection'
      doc: 'Simple Market Protections Strategy Match Blocked'
    0x4c:
      id: 'leg_market_protection'
      doc: 'Leg Market Protection Book Match Prevented'
  trade_condition:
    0x53:
      id: 'matched'
      doc: 'Complex Order Matched With Another Complex Order'
    0x4c:
      id: 'legged'
      doc: 'Complex Order Matched Legged With Simple Orders'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Miax Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'resumed'
      doc: 'Miax Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'opened'
      doc: 'Miax Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'automatic'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'manual'
      doc: 'Miax Manually Initiated This Event'

