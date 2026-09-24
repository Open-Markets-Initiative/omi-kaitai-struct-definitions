# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlOptions TopOfMarket Mach v1.9
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.9
#   Date: 1/15/2016
#   Specification: Top_Of_Market_Feed_ToM_v1_9.pdf
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
  id: miax_pearloptions_topofmarket_mach_v1_9
  title: Miax PearlOptions TopOfMarket Mach v1.9
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Options Top Of Market Mach v1.9'
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
            'message_type::series_update': series_update
            'message_type::system_state_message': system_state_message
            'message_type::top_of_market_bid_compact_message': top_of_market_bid_compact_message
            'message_type::top_of_market_offer_compact_message': top_of_market_offer_compact_message
            'message_type::wide_top_of_market_bid_message': wide_top_of_market_bid_message
            'message_type::wide_top_of_market_offer_message': wide_top_of_market_offer_message
            'message_type::double_sided_top_of_market_compact_message': double_sided_top_of_market_compact_message
            'message_type::wide_double_sided_top_of_market_message': wide_double_sided_top_of_market_message
            'message_type::trade_message': trade_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::underlying_trading_status_message': underlying_trading_status_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  series_update:
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option Type: “C” = Call, “P” = Put'
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
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '“Y” = MIAX will accept position closing orders only'
      - id: long_term_option
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '“Y” = Far month expiration, “N” = Near month expiration (as defined by MIAX rules)'
      - id: active_on_miax
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if this symbol is tradable on MIAX in the current session: “A” = Active (tradable) on MIAX “I” = Inactive (not tradable) on MIAX'
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
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: ToM01.01'
      - id: session_id
        type: u4
        doc: 'MIAX assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status: “S” = Start of System hours “C” = End of System hours, “1” = Start of Test Session (sent before tests). “2” = End of Test Session'
  top_of_market_bid_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: mbbo_price_2
        type: decimal_u2_2
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: mbbo_size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: mbbo_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Price'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  top_of_market_offer_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: mbbo_price_2
        type: decimal_u2_2
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: mbbo_size_2
        type: u2
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: mbbo_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Price'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  wide_top_of_market_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: mbbo_price_4
        type: decimal_u4_4
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: mbbo_size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: mbbo_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Price'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  wide_top_of_market_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: mbbo_price_4
        type: decimal_u4_4
        doc: 'MIAX Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: mbbo_size_4
        type: u4
        doc: 'Aggregate size at MIAX Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: mbbo_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Price'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  double_sided_top_of_market_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: bid_price_2
        type: decimal_u2_2
        doc: 'MIAX best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: bid_size_2
        type: u2
        doc: 'Aggregate size at MIAX best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: bid_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Bid Condition Values'
      - id: offer_price_2
        type: decimal_u2_2
        doc: 'MIAX best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: offer_size_2
        type: u2
        doc: 'Aggregate size at MIAX best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: offer_priority_customer_size_2
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Valid Values:'
  wide_double_sided_top_of_market_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: bid_price_4
        type: decimal_u4_2
        doc: 'MIAX best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: bid_size_4
        type: u4
        doc: 'Aggregate size at MIAX best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: bid_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Bid Condition Values'
      - id: offer_price_4
        type: decimal_u4_2
        doc: 'MIAX best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: offer_size_4
        type: u4
        doc: 'Aggregate size at MIAX best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: offer_priority_customer_size_4
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the MIAX Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Valid Values:'
  trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: trade_id
        type: u4
        doc: 'Unique Trade ID assigned to every Trade'
      - id: correction_number
        type: u1
        doc: 'Trade correction number. 0 for New trades. Greater than or equal to 0 for trades resulting from corrections/adjustments'
      - id: reference_trade_id
        type: u4
        doc: '0 (zero) if new trade. Trade ID of the original trade if this trade originated as a correction of the original trade'
      - id: reference_correction_number
        type: u1
        doc: 'Correction Number of the trade that was just corrected/adjusted. 0 for new trades'
      - id: trade_price
        type: decimal_u4_4
        doc: 'Price at which this product traded. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Number of contracts executed in this trade'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Values'
  trade_cancel_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: trade_id
        type: u4
        doc: 'Unique Trade ID assigned to every Trade'
      - id: correction_number
        type: u1
        doc: 'Trade correction number. 0 for New trades. Greater than or equal to 0 for trades resulting from corrections/adjustments'
      - id: trade_price
        type: decimal_u4_4
        doc: 'Price at which this product traded. Implied decimal with scale 1e-4'
      - id: trade_size
        type: u4
        doc: 'Number of contracts executed in this trade'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition Values'
  underlying_trading_status_message:
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
        doc: '“H” = MIAX has halted trading for this Underlying Symbol'
      - id: event_reason
        type: u1
        enum: event_reason
        doc: 'Values: “A” = This event resulted from automatic/market driven event “M” = MIAX manually initiated this event'
      - id: seconds_part
        type: u4
        doc: 'Seconds portion of the expected time of the event. Always use in conjunction with the Nano-seconds part field'
      - id: expected_event_time_nano_seconds_part
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
  decimal_u2_2:
    seq:
      - id: mantissa
        type: u2
    instances:
      real:
        value: mantissa / 100.0
  decimal_u4_2:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 100.0

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
      id: 'series_update'
      doc: 'This is the message format that will be used to disseminate all Option series traded on MIAX for the current session. The product ID sent in this message is what will be disseminated in Top of Market BBO and Last Sale messages.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x42:
      id: 'top_of_market_bid_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Top of Market for options with low premiums and small aggregate MIAX Best Bid or Offer (MBBO) size'
    0x4f:
      id: 'top_of_market_offer_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Top of Market for options with low premiums and small aggregate MIAX Best Bid or Offer (MBBO) size'
    0x57:
      id: 'wide_top_of_market_bid_message'
      doc: 'This is the message format that will be used to disseminate MIAX Top of Market for options with high premiums or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x41:
      id: 'wide_top_of_market_offer_message'
      doc: 'This is the message format that will be used to disseminate MIAX Top of Market for options with high premiums or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x64:
      id: 'double_sided_top_of_market_compact_message'
      doc: 'This is the message format that will be used, in the refresh service only, to disseminate both sides of the MIAX Top of Market for options with low premiums and small aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x44:
      id: 'wide_double_sided_top_of_market_message'
      doc: 'This is the message format that will be used to disseminate the “seconds” part of the timestamp that is applicable to all messages that are sent in the current second.This is the message format that will be used, in the refresh service only, to disseminate both sides of the MIAX Top of Market for options with high premiums or large aggregate MIAX Best Bid or Offer (MBBO) sizes.'
    0x54:
      id: 'trade_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on MIAX during the current trading session.'
    0x58:
      id: 'trade_cancel_message'
      doc: 'This is the message format that will be used to disseminate canceled Trades that are resulting from Trade cancellations or corrections on MIAX during the current trading session'
    0x48:
      id: 'underlying_trading_status_message'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying'
  miax_bbo_posting_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny'
    0x4e:
      id: 'nickel'
      doc: 'Nickel'
    0x44:
      id: 'dime'
      doc: 'Dime'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny'
    0x4e:
      id: 'nickel'
      doc: 'Nickel'
    0x44:
      id: 'dime'
      doc: 'Dime'
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
    0x42:
      id: 'top_bid'
      doc: 'Miax Top Of Market On Bid Side'
    0x4f:
      id: 'top_offer'
      doc: 'Miax Top Of Market On Offer Side'
  mbbo_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority Less Than Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  bid_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority Less Than Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  offer_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority Less Than Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  trade_condition:
    0x41:
      id: 'cancel_of_trade'
      doc: 'Cancel Of Trade Previously Reported Other Than As The Last Or Opening For The Particular Option'
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

