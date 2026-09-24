# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlOptions TopOfMarket Mach v1.0
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.0
#   Date: 02/27/2017
#   Specification: PEARL_Top_Of_Market_Feed_ToM_v1.0b.pdf
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
  id: miax_pearloptions_topofmarket_mach_v1_0
  title: Miax PearlOptions TopOfMarket Mach v1.0
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Options Top Of Market Mach v1.0'
doc-ref: https://www.miaxoptions.com/interface-specifications/pearl

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
        doc: 'Length of the packet. This includes the header and application data'
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
            'message_type::series_update_message': series_update_message
            'message_type::system_state_message': system_state_message
            'message_type::compact_top_of_market_bid_message': compact_top_of_market_bid_message
            'message_type::compact_top_of_market_best_offer_message': compact_top_of_market_best_offer_message
            'message_type::wide_top_of_market_best_bid_message': wide_top_of_market_best_bid_message
            'message_type::wide_top_of_market_best_offer_message': wide_top_of_market_best_offer_message
            'message_type::compact_double_sided_top_of_market_message': compact_double_sided_top_of_market_message
            'message_type::wide_double_sided_top_of_market_message': wide_double_sided_top_of_market_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::underlying_trading_status_notification': underlying_trading_status_notification
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  series_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
      - id: long_term_option
        type: u1
        enum: long_term_option
      - id: active_on_pearl
        type: u1
        enum: active_on_pearl
        doc: 'Indicates if this symbol is tradable on PEARL in the current session:'
      - id: pearl_bbo_posting_increment_indicator
        type: u1
        enum: pearl_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by PEARL'
      - id: liquidity_acceptance_increment_indicator
        type: u1
        enum: liquidity_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote/Order acceptance as per PEARL rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market:'
      - id: reserved_12
        size: 12
        doc: '** Reserved for future use **'
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: TOM1.0'
      - id: session_id
        type: u4
        doc: 'PEARL assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status:'
  compact_top_of_market_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: pbbo_price
        type: decimal_u2_2
        doc: 'PEARL Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: pbbo_size
        type: u2
        doc: 'Aggregate size at PEARL Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: pbbo_priority_customer_size
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Price'
      - id: pbbo_condition
        type: u1
        enum: pbbo_condition
        doc: 'Valid Values:'
  compact_top_of_market_best_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: pbbo_price
        type: decimal_u2_2
        doc: 'PEARL Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: pbbo_size
        type: u2
        doc: 'Aggregate size at PEARL Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: pbbo_priority_customer_size
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Price'
      - id: pbbo_condition
        type: u1
        enum: pbbo_condition
        doc: 'Valid Values:'
  wide_top_of_market_best_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: wide_pbbo_price
        type: decimal_u4_4
        doc: 'PEARL Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: wide_pbbo_size
        type: u4
        doc: 'Aggregate size at PEARL Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: wide_pbbo_priority_customer_size
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Price'
      - id: pbbo_condition
        type: u1
        enum: pbbo_condition
        doc: 'Valid Values:'
  wide_top_of_market_best_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: wide_pbbo_price
        type: decimal_u4_4
        doc: 'PEARL Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: wide_pbbo_size
        type: u4
        doc: 'Aggregate size at PEARL Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: wide_pbbo_priority_customer_size
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Price'
      - id: pbbo_condition
        type: u1
        enum: pbbo_condition
        doc: 'Valid Values:'
  compact_double_sided_top_of_market_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: bid_price
        type: decimal_u2_2
        doc: 'PEARL best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: bid_size
        type: u2
        doc: 'Aggregate size at PEARL best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: bid_priority_customer_size
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Valid Values:'
      - id: offer_price
        type: decimal_u2_2
        doc: 'PEARL best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: offer_size
        type: u2
        doc: 'Aggregate size at PEARL best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: offer_priority_customer_size
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Valid Values:'
  wide_double_sided_top_of_market_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: wide_bid_price
        type: decimal_u4_4
        doc: 'PEARL best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: wide_bid_size
        type: u4
        doc: 'Aggregate size at PEARL best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: wide_bid_priority_customer_size
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Valid Values:'
      - id: wide_offer_price
        type: decimal_u4_4
        doc: 'PEARL best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: wide_offer_size
        type: u4
        doc: 'Aggregate size at PEARL best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: wide_offer_priority_customer_size
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the PEARL Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Valid Values:'
  last_sale_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Valid Values: Please refer to Appendix A'
  trade_cancel_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'PEARL Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Valid Values: Please refer to Appendix A'
  underlying_trading_status_notification:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on PEARL system today. Nanoseconds since Second epoch'
      - id: underlying_symbol
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock Symbol for the option'
      - id: trading_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
      - id: event_reason
        type: u1
        enum: event_reason
      - id: expected_event_time_seconds_part
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
      id: 'series_update_message'
      doc: 'This is the message format that will be used to disseminate all Option series traded on PEARL for the current session. The product ID sent in this message is what will be disseminated in Top of Market BBO and Last Sale messages.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x42:
      id: 'compact_top_of_market_bid_message'
      doc: 'This is the message format that will be used to disseminate each side of the PEARL Top of Market for options with low premiums and small aggregate PEARL Best Bid or Offer (PBBO) size.'
    0x4f:
      id: 'compact_top_of_market_best_offer_message'
      doc: 'This is the message format that will be used to disseminate each side of the PEARL Top of Market for options with low premiums and small aggregate PEARL Best Bid or Offer (PBBO) size.'
    0x57:
      id: 'wide_top_of_market_best_bid_message'
      doc: 'This is the message format that will be used, in the refresh service and during trading hours, to disseminate both sides of the PEARL Top of Market for options with low premiums and small aggregate PEARL Best Bid or Offer (PBBO) size.'
    0x41:
      id: 'wide_top_of_market_best_offer_message'
      doc: 'This is the message format that will be used, in the refresh service and during trading hours, to disseminate both sides of the PEARL Top of Market for options with low premiums and small aggregate PEARL Best Bid or Offer (PBBO) size.'
    0x64:
      id: 'compact_double_sided_top_of_market_message'
      doc: 'This is the message format that will be used, in the refresh service and during trading hours, to disseminate both sides of the PEARL Top of Market for options with low premiums and small aggregate PEARL Best Bid or Offer (PBBO) size.'
    0x44:
      id: 'wide_double_sided_top_of_market_message'
      doc: 'This is the message format that will be used, in the refresh service and during trading hours, to disseminate both sides of the PEARL Top of Market for options with high premiums or large aggregate PEARL Best Bid or Offer (PBBO) sizes.'
    0x54:
      id: 'last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on PEARL during the current trading session.'
    0x58:
      id: 'trade_cancel_message'
      doc: 'This is the message format that will be used to disseminate canceled Trades that are resulting from Trade cancellations or corrections on PEARL during the current trading session.'
    0x48:
      id: 'underlying_trading_status_notification'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying.'
  call_or_put:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  restricted_option:
    0x59:
      id: 'position_closing_orders_only'
      doc: 'Pearl Will Accept Position Closing Orders Only'
    0x4e:
      id: 'open_and_close_positions'
      doc: 'Pearl Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month'
      doc: 'Far Month Expiration As Defined By Pearl Rules'
    0x4e:
      id: 'near_month'
      doc: 'Near Month Expiration As Defined By Pearl Rules'
  active_on_pearl:
    0x41:
      id: 'active_tradable'
      doc: 'Active Tradable On Pearl'
    0x49:
      id: 'inactive_not_tradable'
      doc: 'Inactive Not Tradable On Pearl'
  pearl_bbo_posting_increment_indicator:
    0x50:
      id: 'penny_001'
      doc: 'Penny 001'
    0x4e:
      id: 'penny_001_x4e'
      doc: 'Penny 001 Nickel 005'
    0x44:
      id: 'nickel_005'
      doc: 'Nickel 005 Dime 010'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny_001'
      doc: 'Penny 001'
    0x4e:
      id: 'penny_001_x4e'
      doc: 'Penny 001 Nickel 005'
    0x44:
      id: 'nickel_005'
      doc: 'Nickel 005 Dime 010'
  opening_underlying_market_code:
    0x41:
      id: 'nyse_amex'
      doc: 'Nyse Amex'
    0x42:
      id: 'nasdaq_omx_bx'
      doc: 'Nasdaq Omx Bx'
    0x43:
      id: 'national_stock'
      doc: 'National Stock Exchange'
    0x44:
      id: 'finra_adf'
      doc: 'Finra Adf'
    0x45:
      id: 'market_independent'
      doc: 'Market Independent Any Market That Opens First'
    0x49:
      id: 'international_securities'
      doc: 'International Securities Exchange'
    0x4a:
      id: 'edga_exchange'
      doc: 'Edga Exchange Inc'
    0x4b:
      id: 'edgx_exchange'
      doc: 'Edgx Exchange Inc'
    0x4d:
      id: 'chicago_stock'
      doc: 'Chicago Stock Exchange'
    0x4e:
      id: 'nyse_euronext'
      doc: 'Nyse Euronext'
    0x50:
      id: 'nyse_arca'
      doc: 'Nyse Arca Exchange'
    0x51:
      id: 'nasdaq_omx'
      doc: 'Nasdaq Omx Via Utp Feed'
    0x54:
      id: 'nasdaq_omx_x54'
      doc: 'Nasdaq Omx Via Cta Feed'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x58:
      id: 'nasdaq_omx_phlx'
      doc: 'Nasdaq Omx Phlx'
    0x59:
      id: 'bats_y_exchange'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats_exchange'
      doc: 'Bats Exchange Inc'
  system_status:
    0x53:
      id: 'start'
      doc: 'Start Of System Hours'
    0x43:
      id: 'end'
      doc: 'End Of System Hours'
    0x31:
      id: 'start_x31'
      doc: 'Start Of Test Session Sent Before Tests'
    0x32:
      id: 'end_x32'
      doc: 'End Of Test Session'
  pbbo_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'quote_contains_public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'quote_is_not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  bid_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'quote_contains_public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'quote_is_not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  offer_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'quote_contains_public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'quote_is_not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  trade_condition:
    0x20:
      id: 'regular'
      doc: 'Regular'
    0x41:
      id: 'cancel_of_trade'
      doc: 'Cancel Of Trade Previously Reported Other Than As The Last Or Opening For The Particular Option'
    0x42:
      id: 'trade_that_is_late_and_is_out_of_sequence'
      doc: 'Trade That Is Late And Is Out Of Sequence'
    0x43:
      id: 'cancel_of_the_last_reported_trade'
      doc: 'Cancel Of The Last Reported Trade For The Particular Option'
    0x44:
      id: 'trade_that_is_late_and_is_in_correct_sequence'
      doc: 'Trade That Is Late And Is In Correct Sequence'
    0x45:
      id: 'cancel_of_the_first_opening_reported_trade'
      doc: 'Cancel Of The First Opening Reported Trade For The Particular Option'
    0x46:
      id: 'trade_that_is_late_report_of_the_opening_trade_and_is_out_of_sequence'
      doc: 'Trade That Is Late Report Of The Opening Trade And Is Out Of Sequence'
    0x47:
      id: 'cancel_of_the_only_reported_trade'
      doc: 'Cancel Of The Only Reported Trade For The Particular Option'
    0x48:
      id: 'trade_that_is_late_report_of_the_opening_trade_and_is_in_correct_sequence'
      doc: 'Trade That Is Late Report Of The Opening Trade And Is In Correct Sequence'
    0x49:
      id: 'reserved_for_future_use'
      doc: 'Reserved For Future Use'
    0x4a:
      id: 'trade_due_to_reopening_of_an_option_in_which_trading_has_been_previously_halted'
      doc: 'Trade Due To Reopening Of An Option In Which Trading Has Been Previously Halted Process As A Regular Transaction'
    0x4b:
      id: 'reserved_for_future_use_x4b'
      doc: 'Reserved For Future Use'
    0x4c:
      id: 'reserved_for_future_use_x4c'
      doc: 'Reserved For Future Use'
    0x4d:
      id: 'reserved_for_future_use_x4d'
      doc: 'Reserved For Future Use'
    0x4e:
      id: 'reserved_for_future_use_x4e'
      doc: 'Reserved For Future Use'
    0x4f:
      id: 'reserved_for_future_use_x4f'
      doc: 'Reserved For Future Use'
    0x50:
      id: 'reserved_for_future_use_x50'
      doc: 'Reserved For Future Use'
    0x51:
      id: 'reserved_for_future_use_x51'
      doc: 'Reserved For Future Use'
    0x52:
      id: 'trade_was_the_execution_of_an_order_which_was_stopped_at_a_price_that_did_not_constitute_a_trade_through_on_another_market_at_the_time_of_the_stop'
      doc: 'Trade Was The Execution Of An Order Which Was Stopped At A Price That Did Not Constitute A Trade Through On Another Market At The Time Of The Stop Process Like A Normal Transaction Except Dont Update Last'
    0x53:
      id: 'trade_was_the_execution_of_an_order_identified'
      doc: 'Trade Was The Execution Of An Order Identified As An Intermarket Sweep Order Iso'
    0x54:
      id: 'reserved_for_future_use_x54'
      doc: 'Reserved For Future Use'
    0x58:
      id: 'trade_that_is_trade_through_exempt'
      doc: 'Trade That Is Trade Through Exempt The Trade Should Be Treated Like A Regular Sale'
  event_reason:
    0x41:
      id: 'resulted_from_automaticmarket_driven_event'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'manually_initiated'
      doc: 'Pearl Manually Initiated This Event'

