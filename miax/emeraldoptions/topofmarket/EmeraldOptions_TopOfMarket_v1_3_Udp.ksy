# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax EmeraldOptions TopOfMarket Mach v1.3
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top of Market
#   Encoding: Mach
#   Version: 1.3
#   Date: 04/24/2023
#   Specification: Top_Of_Market_Feed_ToM_v1.3.pdf
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
  id: miax_emeraldoptions_topofmarket_mach_v1_3_udp
  title: Miax EmeraldOptions TopOfMarket Mach v1.3
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Emerald Options Top of Market Mach v1.3'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-emerald/interface-specifications

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
            'message_type::system_state_message': system_state_message
            'message_type::simple_top_of_market_best_bid_or_offer_compact_bid_message': simple_top_of_market_best_bid_or_offer_compact_bid_message
            'message_type::simple_top_of_market_best_bid_or_offer_compact_bid_with_priority_customer_message': simple_top_of_market_best_bid_or_offer_compact_bid_with_priority_customer_message
            'message_type::simple_top_of_market_best_bid_or_offer_compact_offer_message': simple_top_of_market_best_bid_or_offer_compact_offer_message
            'message_type::simple_top_of_market_best_bid_or_offer_compact_offer_with_priority_customer_message': simple_top_of_market_best_bid_or_offer_compact_offer_with_priority_customer_message
            'message_type::simple_top_of_market_best_bid_or_offer_wide_bid_message': simple_top_of_market_best_bid_or_offer_wide_bid_message
            'message_type::simple_top_of_market_best_bid_or_offer_wide_bid_with_priority_customer_message': simple_top_of_market_best_bid_or_offer_wide_bid_with_priority_customer_message
            'message_type::simple_top_of_market_best_bid_or_offer_wide_offer_message': simple_top_of_market_best_bid_or_offer_wide_offer_message
            'message_type::simple_top_of_market_best_bid_or_offer_wide_offer_with_priority_customer_message': simple_top_of_market_best_bid_or_offer_wide_offer_with_priority_customer_message
            'message_type::simple_double_sided_top_of_market_best_bid_or_offer_compact_message': simple_double_sided_top_of_market_best_bid_or_offer_compact_message
            'message_type::simple_double_sided_top_of_market_best_bid_or_offer_wide_message': simple_double_sided_top_of_market_best_bid_or_offer_wide_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_cancel_message': trade_cancel_message
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
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: '"Y" = Far month expiration (as defined by Emerald rules), "N" = Near month expiration (as defined by Emerald rules)'
      - id: active_on_miax
        type: u1
        enum: active_on_miax
        doc: 'Indicates if this symbol is tradable on Emerald in the current session'
      - id: emerald_bbo_posting_increment_indicator
        type: u1
        enum: emerald_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by Emerald'
      - id: liquidity_acceptance_increment_indicator
        type: u1
        enum: liquidity_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote/Order acceptance as per Emerald rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
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
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: to_m_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: TOM1.0'
      - id: session_id
        type: u4
        doc: 'Emerald assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  simple_top_of_market_best_bid_or_offer_compact_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_short
        type: decimal_u2_2
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: ebbo_size_short
        type: u2
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_compact_bid_with_priority_customer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_short
        type: decimal_u2_2
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: ebbo_size_short
        type: u2
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_compact_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_short
        type: decimal_u2_2
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: ebbo_size_short
        type: u2
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_compact_offer_with_priority_customer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_short
        type: decimal_u2_2
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: ebbo_size_short
        type: u2
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_wide_bid_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_long
        type: decimal_u4_4
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: ebbo_size_long
        type: u4
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_wide_bid_with_priority_customer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_long
        type: decimal_u4_4
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: ebbo_size_long
        type: u4
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_wide_offer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_long
        type: decimal_u4_4
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: ebbo_size_long
        type: u4
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_top_of_market_best_bid_or_offer_wide_offer_with_priority_customer_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: ebbo_price_long
        type: decimal_u4_4
        doc: 'Emerald Best price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: ebbo_size_long
        type: u4
        doc: 'Aggregate size at Emerald Best Price at the time stated in Timestamp and side specified in Message Type'
      - id: ebbo_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Price'
      - id: ebbo_condition
        type: u1
        enum: ebbo_condition
        doc: 'EBBO Condition Values'
  simple_double_sided_top_of_market_best_bid_or_offer_compact_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: bid_price_short
        type: decimal_u2_2
        doc: 'Emerald best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: bid_size_short
        type: u2
        doc: 'Aggregate size at Emerald best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: bid_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Bid Condition Values'
      - id: offer_price_short
        type: decimal_u2_2
        doc: 'Emerald best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-2'
      - id: offer_size_short
        type: u2
        doc: 'Aggregate size at Emerald best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: offer_priority_customer_size_short
        type: u2
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Offer Condition Values'
  simple_double_sided_top_of_market_best_bid_or_offer_wide_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: bid_price_long
        type: decimal_u4_4
        doc: 'Emerald best bid price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: bid_size_long
        type: u4
        doc: 'Aggregate size at Emerald best bid Price at the time stated in Timestamp and side specified in Message Type'
      - id: bid_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Bid Price'
      - id: bid_condition
        type: u1
        enum: bid_condition
        doc: 'Bid Condition Values'
      - id: offer_price_long
        type: decimal_u4_4
        doc: 'Emerald best offer price at the time stated in Timestamp and side specified in Message Type. Implied decimal with scale 1e-4'
      - id: offer_size_long
        type: u4
        doc: 'Aggregate size at Emerald best offer Price at the time stated in Timestamp and side specified in Message Type'
      - id: offer_priority_customer_size_long
        type: u4
        doc: 'Aggregate size of Priority Customer contracts at the Emerald Best Offer Price'
      - id: offer_condition
        type: u1
        enum: offer_condition
        doc: 'Offer Condition Values'
  last_sale_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Trade Condition Values. Please refer to Appendix A'
  trade_cancel_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Emerald Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
        doc: 'Trade Condition Values. Please refer to Appendix A'
  underlying_trading_status_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Emerald system today. Nanoseconds since Second epoch'
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
      doc: 'This is the message format that will be used to disseminate all Option series traded on Emerald for the current session. The product ID sent in this message is what will be disseminated in Top of Market BBO and Last Sale messages.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x42:
      id: 'simple_top_of_market_best_bid_or_offer_compact_bid_message'
      doc: 'This is the message format that will be used to disseminate each side of the Emerald Simple Top of Market for options with low premiums and small aggregate Emerald Best Bid or Offer (EBBO) size. "B" = Simple Top of Market on Bid side.'
    0x68:
      id: 'simple_top_of_market_best_bid_or_offer_compact_bid_with_priority_customer_message'
      doc: 'Simple Top of Market on Bid side with Priority Customer establishing new aggressive price. Compact format for options with low premiums and small aggregate Emerald Best Bid or Offer (EBBO) size.'
    0x4f:
      id: 'simple_top_of_market_best_bid_or_offer_compact_offer_message'
      doc: 'This is the message format that will be used to disseminate each side of the Emerald Simple Top of Market for options with low premiums and small aggregate Emerald Best Bid or Offer (EBBO) size. "O" = Simple Top of Market on Offer side.'
    0x69:
      id: 'simple_top_of_market_best_bid_or_offer_compact_offer_with_priority_customer_message'
      doc: 'Simple Top of Market on Offer side with Priority Customer establishing new aggressive price. Compact format for options with low premiums and small aggregate Emerald Best Bid or Offer (EBBO) size.'
    0x57:
      id: 'simple_top_of_market_best_bid_or_offer_wide_bid_message'
      doc: 'This is the message format that will be used to disseminate Emerald Simple Top of Market for options with high premiums or large aggregate Emerald Best Bid or Offer (EBBO) size. "W" = Simple Top of Market on Bid side (wide).'
    0x6a:
      id: 'simple_top_of_market_best_bid_or_offer_wide_bid_with_priority_customer_message'
      doc: 'Simple Top of Market on Bid side with Priority Customer establishing new aggressive price. Wide format for options with high premiums or large aggregate Emerald Best Bid or Offer (EBBO) size.'
    0x41:
      id: 'simple_top_of_market_best_bid_or_offer_wide_offer_message'
      doc: 'This is the message format that will be used to disseminate Emerald Simple Top of Market for options with high premiums or large aggregate Emerald Best Bid or Offer (EBBO) size. "A" = Simple Top of Market on Offer side (wide).'
    0x6b:
      id: 'simple_top_of_market_best_bid_or_offer_wide_offer_with_priority_customer_message'
      doc: 'Simple Top of Market on Offer side with Priority Customer establishing new aggressive price. Wide format for options with high premiums or large aggregate Emerald Best Bid or Offer (EBBO) size.'
    0x64:
      id: 'simple_double_sided_top_of_market_best_bid_or_offer_compact_message'
      doc: 'This is the message format that will be used in the real-time feed and refresh service to disseminate both sides of the Emerald Simple Top of Market for options with low premiums and small aggregate Emerald Best Bid or Offer (EBBO) size.'
    0x44:
      id: 'simple_double_sided_top_of_market_best_bid_or_offer_wide_message'
      doc: 'This is the message format that will be used in the real-time feed and refresh service to disseminate both sides of the Emerald Simple Top of Market for options with high premiums or large aggregate Emerald Best Bid or Offer (EBBO) sizes.'
    0x54:
      id: 'last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on Emerald during the current trading session.'
    0x58:
      id: 'trade_cancel_message'
      doc: 'This is the message format that will be used to disseminate canceled Trades that are resulting from Trade cancellations or corrections on Emerald during the current trading session.'
    0x48:
      id: 'underlying_trading_status_notification_message'
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
      id: 'accept_position_closing'
      doc: 'Emerald Will Accept Position Closing Orders Only'
    0x4e:
      id: 'accept_open_and_close'
      doc: 'Emerald Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'far_month_expiration'
      doc: 'Far Month Expiration'
    0x4e:
      id: 'near_month_expiration'
      doc: 'Near Month Expiration'
  active_on_miax:
    0x41:
      id: 'active'
      doc: 'Active Tradable On Emerald'
    0x49:
      id: 'inactive'
      doc: 'Inactive Not Tradable On Emerald'
  emerald_bbo_posting_increment_indicator:
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
      id: 'nasdaq_omx_utp'
      doc: 'Nasdaq Omx Via Utp Feed'
    0x54:
      id: 'nasdaq_omx_cta'
      doc: 'Nasdaq Omx Via Cta Feed'
    0x55:
      id: 'memx'
      doc: 'Memx'
    0x56:
      id: 'iex'
      doc: 'Iex'
    0x57:
      id: 'cboe_stock_exchange'
      doc: 'Cboe Stock Exchange Cbsx'
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
      id: 'start_of_test_session'
      doc: 'Start Of Test Session Sent Before Tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
  ebbo_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  bid_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  offer_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote Contains Public Customer Interest Priority And Non Priority Customer Interest'
    0x43:
      id: 'not_firm'
      doc: 'Quote Is Not Firm On This Side'
    0x52:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    0x54:
      id: 'trading_halt'
      doc: 'Trading Halt'
  trade_condition:
    0x41:
      id: 'cancel_of_trade_previously_reported_other_than_as_the_last_or_opening'
      doc: 'Cancel Of Trade Previously Reported Other Than As The Last Or Opening For The Particular Option'
    0x42:
      id: 'late_and_is_out_of_sequence'
      doc: 'Trade That Is Late And Is Out Of Sequence'
    0x43:
      id: 'cancel_of_the_last_reported_trade'
      doc: 'Cancel Of The Last Reported Trade For The Particular Option'
    0x44:
      id: 'late_and_is_in_correct_sequence'
      doc: 'Trade That Is Late And Is In Correct Sequence'
    0x45:
      id: 'cancel_of_the_first_reported_trade'
      doc: 'Cancel Of The First Opening Reported Trade For The Particular Option'
    0x46:
      id: 'late_report_of_the_opening_trade_and_is_out_of_sequence'
      doc: 'Trade That Is Late Report Of The Opening Trade And Is Out Of Sequence'
    0x47:
      id: 'cancel_of_the_only_reported_trade'
      doc: 'Cancel Of The Only Reported Trade For The Particular Option'
    0x48:
      id: 'late_report_of_the_opening_trade_and_is_in_correct_sequence'
      doc: 'Trade That Is Late Report Of The Opening Trade And Is In Correct Sequence'
    0x49:
      id: 'auto_field'
      doc: 'Auto'
    0x4a:
      id: 'reopening_of_an_option'
      doc: 'Trade Due To Reopening Of An Option In Which Trading Has Been Previously Halted Process As A Regular Transaction'
    0x4b:
      id: 'reserved'
      doc: 'Reserved For Future Use'
    0x4c:
      id: 'a_buy_and_a_sell_in_the_same_class'
      doc: 'Transaction Represents A Trade In Two Options In The Same Class A Buy And A Sell In The Same Class Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4d:
      id: 'a_buy_and_a_sell_in_a_put_and_a_call'
      doc: 'Transaction Represents A Trade In Two Options In The Same Class A Buy And A Sell In A Put And A Call Prefix Appears Solely For Information Process As A Regular Transaction'
    0x4e:
      id: 'reserved_x4e'
      doc: 'Reserved For Future Use'
    0x4f:
      id: 'reserved_x4f'
      doc: 'Reserved For Future Use'
    0x50:
      id: 'buy_or_sell_of_a_call_or_put'
      doc: 'Transaction Represents The Option Portion Of An Order Involving A Single Option Leg Buy Or Sell Of A Call Or Put And Stock Prefix Appears Solely For Information Process As A Regular Transaction'
    0x51:
      id: 'buy_of_a_call_and_a_sell_of_a_put_for_the_same_underlying_stock_or_index'
      doc: 'Transaction Represents The Buying Of A Call And The Selling Of A Put For The Same Underlying Stock Or Index Prefix Appears Solely For Information Process As A Regular Transaction'
    0x52:
      id: 'execution_of_an_order_which_was_stopped_at_a_price_that_did_not_constitute_a_trade_through_on_another_market_at_the_time_of_the_stop'
      doc: 'Trade Was The Execution Of An Order Which Was Stopped At A Price That Did Not Constitute A Trade Through On Another Market At The Time Of The Stop Process Like A Normal Transaction Except Dont Update Last'
    0x53:
      id: 'execution_of_an_iso_order'
      doc: 'Trade Was The Execution Of An Order Identified As An Intermarket Sweep Order Iso'
    0x54:
      id: 'reserved_x54'
      doc: 'Reserved For Future Use'
    0x58:
      id: 'trade_through_exempt'
      doc: 'Trade That Is Trade Through Exempt The Trade Should Be Treated Like A Regular Sale'
    0x61:
      id: 'paired_prime'
      doc: 'Trade From A Paired Prime Transaction Non Iso'
    0x62:
      id: 'iso_paired_prime'
      doc: 'Trade From A Iso Paired Prime Transaction'
    0x63:
      id: 'prime_customer_to_customer_cross_or_prime_qcc'
      doc: 'Trade From Prime Customer To Customer Cross Or Prime Qcc Transaction'
    0x64:
      id: 'reserved_x64'
      doc: 'Reserved For Future Use'
    0x65:
      id: 'reserved_x65'
      doc: 'Reserved For Future Use'
    0x66:
      id: 'complex_transaction_that_is_not_complex_stock_tied_and_does_not_involve_legging'
      doc: 'Trade From A Complex Transaction That Is Not Complex Stocktied And Does Not Involve Legging'
    0x67:
      id: 'complex_prime_transaction_that_is_not_complex_stock_tied_and_does_not_involve_legging'
      doc: 'Trade From A Complex Prime Transaction That Is Not Complex Stocktied And Does Not Involve Legging'
    0x68:
      id: 'complex_prime_customer_to_customer_cross_or_complex_prime_qcc_transaction_that_is_not_complex_stock_tied'
      doc: 'Trade From A Complex Prime Customer To Customer Cross Or Complex Prime Qcc Transaction That Is Not Complex Stocktied'
    0x69:
      id: 'reserved_x69'
      doc: 'Reserved For Future Use'
    0x6a:
      id: 'complex_legging_transaction_that_is_not_complex_stock_tied'
      doc: 'Trade From A Complex Legging Transaction That Is Not Complex Stocktied'
    0x6b:
      id: 'complex_prime_stock_tied_transaction_that_does_not_involve_legging'
      doc: 'Trade From A Complex Prime Stocktied Transaction That Does Not Involve Legging'
    0x6c:
      id: 'complex_prime_legging_transaction_that_is_not_complex_stock_tied'
      doc: 'Trade From A Complex Prime Legging Transaction That Is Not Complex Stocktied'
    0x6d:
      id: 'reserved_x6d'
      doc: 'Reserved For Future Use'
    0x6e:
      id: 'complex_stock_tied_transaction_that_does_not_involve_legging'
      doc: 'Trade From A Complex Stocktied Transaction That Does Not Involve Legging'
    0x6f:
      id: 'complex_customer_to_customer_cross_stock_tied_or_complex_qcc_stock_tied_transaction'
      doc: 'Trade From Complex Customer To Customer Cross Stocktied Or Complex Qcc Stocktied Transaction'
    0x70:
      id: 'reserved_x70'
      doc: 'Reserved For Future Use'
    0x71:
      id: 'reserved_x71'
      doc: 'Reserved For Future Use'
    0x72:
      id: 'reserved_x72'
      doc: 'Reserved For Future Use'
    0x73:
      id: 'reserved_x73'
      doc: 'Reserved For Future Use'
    0x74:
      id: 'reserved_x74'
      doc: 'Reserved For Future Use'
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Emerald Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'resumed'
      doc: 'Emerald Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'opened'
      doc: 'Emerald Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'automatic'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'manual'
      doc: 'Emerald Manually Initiated This Event'
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
      doc: 'Sent by the firm over the ToM Retransmission Interface (SesM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Emerald over the ToM Retransmission Interface (SesM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request. Note: MIAX Emerald PDF assigns Response Type "R" (uppercase) to this message, colliding with the Request Type "R" byte; lowercase "r" is used here to match the Pearl convention for case-distinct discrimination.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Emerald over the ToM Retransmission Interface (SesM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x50:
      id: 'simple_series_update_refresh'
      doc: 'Simple Series Update Refresh'
    0x51:
      id: 'simple_top_of_market_refresh'
      doc: 'Simple Top Of Market Refresh'
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

