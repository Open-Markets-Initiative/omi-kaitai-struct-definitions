# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions TopOfMarket Mach v1.3
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Top Of Market
#   Encoding: Mach
#   Version: 1.3
#   Date: 11/07/2012
#   Specification: Top_Of_Market_Feed_ToM_v1.3.pdf
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: miax_miaxoptions_topofmarket_mach_v1_3
  title: Miax MiaxOptions TopOfMarket Mach v1.3
  license: MIT-0
  endian: le

doc: 'Miami International Holdings MIAX Options Top Of Market Mach v1.3'
doc-ref:
  - https://www.miaxoptions.com/interface-specifications
  - https://www.miaxglobal.com/markets/us-options/miax-options/interface-specifications

seq:
  - id: mach_message
    type: mach_message_struct
    repeat: eos

types:
  mach_message_struct:
    seq:
      - id: mach_packet_header
        type: mach_packet_header
        doc: 'Mach packet header (12 bytes)'
      - id: payload
        size: mach_packet_header.packet_length - 12
        type:
          switch-on: mach_packet_header.packet_type
          cases:
            'packet_type::application_message': application_message
  mach_packet_header:
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
        doc: 'Mach protocol packet type'
      - id: session_number
        type: u1
        doc: 'The Session this packet was generated from'
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent.mach_packet_header.packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::series_update_message': series_update_message
            'message_type::system_state_message': system_state_message
            'message_type::top_of_market_bid_compact_message': top_of_market_bid_compact_message
            'message_type::top_of_market_offer_compact_message': top_of_market_offer_compact_message
            'message_type::top_of_market_bid_wide_message': top_of_market_bid_wide_message
            'message_type::top_of_market_offer_wide_message': top_of_market_offer_wide_message
            'message_type::last_sale_message': last_sale_message
            'message_type::trade_cancel_message': trade_cancel_message
            'message_type::liquidity_seeking_event_notification_message': liquidity_seeking_event_notification_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  series_update_message:
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
        type: yyyymmdd_ascii_date
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
        doc: '“Y” = Far month expiration, “N” = Near month expiration (as defined by MIAX rules)'
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
        doc: 'Current system status'
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
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
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
      - id: reserved_2
        size: 2
        doc: 'Reserved for future use'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  top_of_market_bid_wide_message:
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
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  top_of_market_offer_wide_message:
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
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: mbbo_condition
        type: u1
        enum: mbbo_condition
        doc: 'MBBO Condition Values'
  last_sale_message:
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
        doc: 'Trade Condition Value'
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
        doc: 'Trade Condition Value'
  liquidity_seeking_event_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'MIAX Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Type of Event'
      - id: event_id
        type: u4
        doc: 'When Event Type is “O”: always 0. When Event Type is “L” or “R”: Unique Event ID for the current event'
      - id: price
        type: decimal_u4_4
        doc: 'Current price of the Event. Usage: Please refer to Appendix D for details. Implied decimal with scale 1e-4'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'This is the side of the excess liquidity that is waiting to get matched. When Event Type is “O”: Imbalance Side. When Event Type is “R”: Side that will be routed. When Event Type is “L”: Side of oversized order initiating liquidity refresh'
      - id: quantity_1
        type: u4
        doc: 'When Event Type is “O”, “L” or “R”: MatchQty - Number of contracts ready to be matched (both buyers and sellers already present). Other Event Types: 0 (zero)'
      - id: quantity_2
        type: u4
        doc: 'When Event Type is “O”, “L” or “R”: Routable Quantity. Number of contracts that may be routed. Other Event Types: 0 (zero)'
      - id: quantity_3
        type: u4
        doc: 'When Event Type is “O”, “L” or “R”: Imbalance Quantity. Number of contracts on the Imbalance Side that cannot be matched. Other Event Types: 0 (zero)'
      - id: quantity_4
        type: u4
        doc: 'When Event Type is “O”, “L” or “R”: Must Fill Quantity. Number of contracts, on the provided Side, that must be matched at the provided Price. These contracts are crossing the provided Price and MIAX is seeking liquidity for these contracts. Other Event Types: 0 (zero)'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
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
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
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
      doc: 'This is the message format that will be used to disseminate the “seconds” part of the timestamp that is applicable to all messages that are sent in the current second.'
    0x50:
      id: 'series_update_message'
      doc: 'This is the message format that will be used to disseminate all Option series traded on MIAX for the current session. The product ID sent in this message is what will be disseminated in Top of Market BBO and Last Sale messages.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x42:
      id: 'top_of_market_bid_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Top of Market for options with low premiums and small aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x4f:
      id: 'top_of_market_offer_compact_message'
      doc: 'This is the message format that will be used to disseminate each side of the MIAX Top of Market for options with low premiums and small aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x57:
      id: 'top_of_market_bid_wide_message'
      doc: 'This is the message format that will be used to disseminate MIAX Top of Market for options with high premiums or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x41:
      id: 'top_of_market_offer_wide_message'
      doc: 'This is the message format that will be used to disseminate MIAX Top of Market for options with high premiums or large aggregate MIAX Best Bid or Offer (MBBO) size.'
    0x54:
      id: 'last_sale_message'
      doc: 'This is the message format that will be used to disseminate Trades that are resulting from executions on MIAX during the current trading session.'
    0x58:
      id: 'trade_cancel_message'
      doc: 'This is the message format that will be used to disseminate canceled Trades that are resulting from Trade cancellations or corrections on MIAX during the current trading session'
    0x4c:
      id: 'liquidity_seeking_event_notification_message'
      doc: 'This is the message format that will be used to disseminate information each time a Liquidity seeking event (defined in Event Type field below) starts at MIAX.'
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
      doc: 'Miax Will Accept Position Closing Orders Only'
    0x4e:
      id: 'accept_open_and_close'
      doc: 'Miax Will Accept Open And Close Positions'
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
      doc: 'Active Tradable On Miax'
    0x49:
      id: 'inactive'
      doc: 'Inactive Not Tradable On Miax'
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
  mbbo_condition:
    0x41:
      id: 'regular'
      doc: 'Regular Eligible For Automatic Execution'
    0x42:
      id: 'public_customer_interest'
      doc: 'Quote contains Public Customer interest'
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
    0x20:
      id: 'regular'
      doc: 'Regular'
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
      id: 'reserved_i'
      doc: 'Reserved For Future Use'
    0x4a:
      id: 'reopening_of_an_option'
      doc: 'Trade Due To Reopening Of An Option In Which Trading Has Been Previously Halted Process As A Regular Transaction'
    0x4b:
      id: 'reserved_k'
      doc: 'Reserved For Future Use'
    0x4c:
      id: 'reserved_l'
      doc: 'Reserved For Future Use'
    0x4d:
      id: 'reserved_m'
      doc: 'Reserved For Future Use'
    0x4e:
      id: 'reserved_n'
      doc: 'Reserved For Future Use'
    0x4f:
      id: 'reserved_o'
      doc: 'Reserved For Future Use'
    0x50:
      id: 'reserved_p'
      doc: 'Reserved For Future Use'
    0x51:
      id: 'reserved_q'
      doc: 'Reserved For Future Use'
    0x52:
      id: 'execution_of_an_order_which_was_stopped_at_a_price_that_did_not_constitute_a_trade_through_on_another_market_at_the_time_of_the_stop'
      doc: 'Trade Was The Execution Of An Order Which Was Stopped At A Price That Did Not Constitute A Trade Through On Another Market At The Time Of The Stop Process Like A Normal Transaction Except Dont Update Last'
    0x53:
      id: 'execution_of_an_iso_order'
      doc: 'Trade Was The Execution Of An Order Identified As An Intermarket Sweep Order Iso'
    0x54:
      id: 'reserved_t'
      doc: 'Reserved For Future Use'
    0x58:
      id: 'trade_through_exempt'
      doc: 'Trade That Is Trade Through Exempt The Trade Should Be Treated Like A Regular Sale'
  event_type:
    0x4c:
      id: 'liquidity_refresh_mechanism'
      doc: 'Liquidity Refresh Mechanism'
    0x4f:
      id: 'opening_reopening_imbalance_mechanism'
      doc: 'Opening Reopening Imbalance Mechanism'
    0x52:
      id: 'route_mechanism'
      doc: 'Route Mechanism'
  imbalance_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'

