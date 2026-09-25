# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax MiaxOptions Ais Mach v2.6
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Administrative Information Subscriber
#   Encoding: Mach
#   Version: 2.6
#   Date: 03/02/2026
#   Specification: Administrative_Information_Subscriber_Feed_AIS_v2.6.pdf
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
  id: miax_miaxoptions_ais_mach_v2_6_tcp
  title: Miax MiaxOptions Ais Mach v2.6
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Options Administrative Information Subscriber Mach v2.6'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-options/interface-specifications

seq:
  - id: sesm_tcp_packet
    type: sesm_tcp_packet_struct
    repeat: eos
    doc: 'SesM Tcp Packet'

types:
  sesm_tcp_packet_struct:
    seq:
      - id: sesm_packet_header
        type: sesm_packet_header
        doc: 'SesM packet header'
      - id: sesm_payload
        size: sesm_packet_header.sesm_packet_length + 2 - 3
        type:
          switch-on: sesm_packet_header.sesm_packet_type
          cases:
            'sesm_packet_type::sequenced_data_packet': sequenced_data_packet
            'sesm_packet_type::unsequenced_data_packet': unsequenced_data_packet
            'sesm_packet_type::login_request': login_request
            'sesm_packet_type::login_response': login_response
            'sesm_packet_type::synchronization_complete': synchronization_complete
            'sesm_packet_type::retransmission_request': retransmission_request
            'sesm_packet_type::logout_request': logout_request
            'sesm_packet_type::goodbye_packet': goodbye_packet
            'sesm_packet_type::test_packet': test_packet
  sesm_packet_header:
    seq:
      - id: sesm_packet_length
        type: u2
        doc: 'The length of rest of the packet'
      - id: sesm_packet_type
        type: u1
        enum: sesm_packet_type
        doc: 'SesM protocol packet type'
  sequenced_data_packet:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: matching_engine_id
        type: u1
        doc: 'Matching Engine that originated the packet'
      - id: sequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Market-data application message type carried over the SesM sequenced channel (matches the MACH UDP Message Type byte; Miax Options uses Ascii message codes)'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: u1
        enum: unsequenced_message_type
        doc: 'Market-data Refresh request/response discriminator carried over the SesM unsequenced channel (Request Type R, Response Type r, End of Refresh E)'
      - id: unsequenced_message
        size: _parent.sesm_packet_header.sesm_packet_length - 2 - 1
        type:
          switch-on: unsequenced_message_type
          cases:
            'unsequenced_message_type::refresh_request_message': refresh_request_message
            'unsequenced_message_type::refresh_response_message': refresh_response_message
            'unsequenced_message_type::end_of_refresh_notification_message': end_of_refresh_notification_message
  refresh_request_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  refresh_response_message:
    seq:
      - id: sequence_number
        type: u8
        doc: 'Original sequence number from the live feed'
      - id: application_message
        type: application_message
        size: _parent._parent.sesm_packet_header.sesm_packet_length - 12
  application_message:
    seq:
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
      - id: data
        size: _parent._parent._parent.sesm_packet_header.sesm_packet_length - 12 - 1
        type:
          switch-on: message_type
          cases:
            'message_type::system_time_message': system_time_message
            'message_type::simple_series_update_message': simple_series_update_message
            'message_type::complex_strategy_definition_update_message': complex_strategy_definition_update_message
            'message_type::system_state_message': system_state_message
            'message_type::simple_liquidity_seeking_event_notification_message': simple_liquidity_seeking_event_notification_message
            'message_type::complex_liquidity_seeking_event_notification_message': complex_liquidity_seeking_event_notification_message
            'message_type::underlying_trading_status_notification_message': underlying_trading_status_notification_message
            'message_type::theoretical_settlement_reference_price_notification_message': theoretical_settlement_reference_price_notification_message
            'message_type::theoretical_settlement_price_notification_message': theoretical_settlement_price_notification_message
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
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: priority_quote_width
        type: decimal_u4_4
        doc: 'Maximum allowable width for a quote for this Option during regular trading in order to be considered as Priority Quote. 0 when Priority Quote Width is not applicable. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  complex_strategy_definition_update_message:
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
        doc: 'The ratio of this individual leg. Number of option contracts or Number of stock shares for this leg is: LegRatioQty * OrderQty'
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
      - id: ais_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: AIS2.0'
      - id: session_id
        type: u4
        doc: 'MIAX assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  simple_liquidity_seeking_event_notification_message:
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
        doc: 'When Event Type is ''O'': always 0. When Event Type is ''L'', ''R'', or ''P'': Unique Event ID for the current event'
      - id: price_short
        type: decimal_u4_4
        doc: 'Current price of the Event. Please refer to Appendix C for details. Implied decimal with scale 1e-4'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'This is the side of the excess liquidity that is waiting to get matched. Please refer to Appendix C for details'
      - id: quantity_1
        type: u4
        doc: 'When Event Type is ''O'', ''L'', ''R'', or ''P'': MatchQty - Number of contracts ready to be matched (both buyers and sellers already present). Other Event Types: 0 (zero). Please refer to Appendix C for details'
      - id: quantity_2
        type: u4
        doc: 'When Event Type is ''O'', ''L'' or ''R'': Routable Quantity. Number of contracts that may be routed. Other Event Types: 0 (zero). Please refer to Appendix C for details'
      - id: quantity_3
        type: u4
        doc: 'When Event Type is ''O'', ''L'' or ''R'': Imbalance Quantity. Number of contracts on the Imbalance Side that cannot be matched. Other Event Types: 0 (zero). Please refer to Appendix C for details'
      - id: quantity_4
        type: u4
        doc: 'When Event Type is ''O'', ''L'' or ''R'': Must Fill Quantity. Number of contracts, on the provided Side, that must be matched at the provided Price. These contracts are crossing the provided Price and MIAX is seeking liquidity for these contracts. Other Event Types: 0 (zero). Please refer to Appendix C for details'
      - id: attributable_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned Attributable ID (Executing Broker MPID) of an Order. Otherwise, it is space filled'
      - id: origin
        type: u1
        enum: origin
        doc: 'Origin of either the single liquidity which initiated the event or origins of multiple liquidities which initiated the event if they are all of identical origin'
      - id: reserved_7
        size: 7
        doc: 'Reserved for future use'
  complex_liquidity_seeking_event_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'MIAX Strategy ID is assigned per trading day and is valid only for that day'
      - id: event_type
        type: u1
        enum: event_type
        doc: 'Type of Event'
      - id: event_id
        type: u4
        doc: 'When Event Type is ''O'': always 0. When Event Type is ''L'', ''R'', or ''P'': Unique Event ID for the current event'
      - id: side
        type: u1
        enum: side
        doc: 'Side. When Event Type is ''P'': Agency side of the cPRIME order being auctioned'
      - id: price_long
        type: decimal_s8_4
        doc: 'The net limit price for the strategy. When Event Type is ''P'': Auction Start Price of the cPRIME auction. Implied decimal with scale 1e-4'
      - id: matched_quantity
        type: u4
        doc: 'Number of strategies ready to be matched (both buyers and sellers already present)'
      - id: imbalance_quantity_signed
        type: s4
        doc: 'When Event Type is ''C'': Number of strategies on the Imbalance Side that cannot be matched. Other Even Types: 0 (zero)'
      - id: attributable_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'MIAX assigned Attributable ID (Executing Broker MPID) of an Order. Otherwise, it is space filled'
      - id: origin
        type: u1
        enum: origin
        doc: 'Origin of either the single liquidity which initiated the event or origins of multiple liquidities which initiated the event if they are all of identical origin'
      - id: reserved_7
        size: 7
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
      - id: expected_event_time_seconds_part
        type: u4
        doc: 'Seconds portion of the expected time of the event. Always use in conjunction with the Nano-seconds part field'
      - id: expected_event_time_nano_seconds_part
        type: u4
        doc: 'Nano-seconds portion of the expected time of the event. Specifies number of nano-seconds since the seconds specified in "Expected Event Time Seconds" field'
  theoretical_settlement_reference_price_notification_message:
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
      - id: option_state
        type: u1
        enum: option_state
        doc: 'Option State'
      - id: prior_day_reference_price
        type: decimal_u4_4
        doc: 'Reference Price of the option used for Index calculation at the end of the prior trading day. Implied decimal with scale 1e-4'
      - id: settlement_reference_price
        type: decimal_u4_4
        doc: 'Current Settlement Reference Price (SRP) of the Option could be theoretical (TSRP) or final (FSRP). Implied decimal with scale 1e-4'
      - id: settlement_reference_price_type
        type: u1
        enum: settlement_reference_price_type
        doc: 'Type of the Settlement Reference Price'
      - id: sao_buy_quantity_1
        type: u4
        doc: 'All open SAO Buy liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: sao_sell_quantity_1
        type: u4
        doc: 'All open SAO Sell liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: sao_buy_quantity_2
        type: u4
        doc: 'All open SAO Buy liquidity at all prices'
      - id: sao_sell_quantity_2
        type: u4
        doc: 'All open SAO Sell liquidity at all prices'
      - id: non_sao_buy_quantity
        type: u4
        doc: 'All open non-SAO Buy liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: non_sao_sell_quantity
        type: u4
        doc: 'All open non-SAO Sell liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: total_buy_quantity
        type: u4
        doc: 'Total SAO and non-SAO open Buy liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: total_sell_quantity
        type: u4
        doc: 'Total SAO and non-SAO open Sell liquidity priced equal to or better than the Theoretical Settlement Reference Price, including Market Orders'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'This is the side of the excess liquidity that is waiting to get matched. Please refer to Appendix C for details'
      - id: imbalance_quantity_unsigned
        type: u4
        doc: 'Number of contracts on the Imbalance Side that cannot be matched either at a price equal or better than the Theoretical Settlement Reference Price or at expected opening price'
      - id: must_fill_quantity
        type: u4
        doc: 'Number of unmatched contracts, on the provided Side, that must be matched at the price better than the Theoretical Settlement Reference Price'
      - id: matched_quantity
        type: u4
        doc: 'Number of strategies ready to be matched (both buyers and sellers already present)'
      - id: opening_condition
        type: u1
        enum: opening_condition
        doc: 'Current Opening Condition'
      - id: mbb
        type: decimal_u4_4
        doc: 'MIAX Best Quote Bid. Implied decimal with scale 1e-4'
      - id: mbo
        type: decimal_u4_4
        doc: 'MIAX Best Quote Offer. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  theoretical_settlement_price_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on MIAX system today. Nanoseconds since Second epoch'
      - id: settlement_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlement Symbol'
      - id: theoretical_settlement_price
        type: decimal_u4_2
        doc: 'Theoretical Settlement Price. Implied decimal with scale 1e-2'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  end_of_refresh_notification_message:
    seq:
      - id: refresh_message_type
        type: u1
        enum: refresh_message_type
        doc: 'Identifies the data set the firm is requesting a refresh of'
  login_request:
    seq:
      - id: sesm_version
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Protocol version'
      - id: username
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX during initial setup'
      - id: computer_id
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'issued by MIAX Futures Exchange during initial setup'
      - id: application_protocol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Miax Application Protocol'
      - id: requested_trading_session_id
        type: u1
        doc: 'Specifies the session the client would like to log into, or zero to log into the currently active session'
      - id: requested_sequence_number
        type: u8
        doc: 'Specifies client requested sequence number'
  login_response:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Login Status'
      - id: trading_session_id
        type: u1
        doc: 'The current trading session ID of the corresponding Matching Engine'
      - id: highest_sequence_number
        type: u8
        doc: 'the highest sequence number that the server currently has for the client'
  synchronization_complete:
    seq:
      - id: number_of_matching_engines
        type: u1
        doc: 'Count of all Matching Engines for the exchange'
  retransmission_request:
    seq:
      - id: start_sequence_number
        type: u8
        doc: 'Sequence number of the first packet to be retransmitted'
      - id: end_sequence_number
        type: u8
        doc: 'Sequence number of the last packet to be retransmitted'
  logout_request:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  goodbye_packet:
    seq:
      - id: logout_reason
        type: u1
        enum: logout_reason
        doc: 'Logout Request Reason'
      - id: logout_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 2
        encoding: ASCII
        doc: 'Free form human readable text'
  test_packet:
    seq:
      - id: test_text
        type: str
        size: _parent.sesm_packet_header.sesm_packet_length - 1
        encoding: ASCII
        doc: 'Free form human readable text'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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
      doc: 'This is the message format that will be used to disseminate all Option series traded on MIAX for the current session.'
    0x43:
      id: 'complex_strategy_definition_update_message'
      doc: 'This is the message format that will be used to disseminate stock option strategies traded on MIAX for the current session.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x4c:
      id: 'simple_liquidity_seeking_event_notification_message'
      doc: 'This is the message format that will be used to disseminate information each time a Liquidity seeking event (defined in Event Type field below) starts at MIAX.'
    0x6c:
      id: 'complex_liquidity_seeking_event_notification_message'
      doc: 'This is the message format that will be used to disseminate information each time a Liquidity seeking event (defined in Event Type field below) starts at MIAX'
    0x48:
      id: 'underlying_trading_status_notification_message'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying.'
    0x4d:
      id: 'theoretical_settlement_reference_price_notification_message'
      doc: 'This message format will be used to notify firms of the current state and Theoretical Settlement Reference Price (TSRP) or Final Settlement Reference Price (FSRP) of each option involved in settlement, on the settlement day, until the Final Settlement Price is determined.'
    0x4e:
      id: 'theoretical_settlement_price_notification_message'
      doc: 'This message format will be used to notify firms of the Theoretical Settlement Price, on the settlement day, until the Final Settlement Price is determined.'
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
      doc: 'Far Month Expiration As Defined By Miax Rules'
    0x4e:
      id: 'no_field'
      doc: 'Near Month Expiration As Defined By Miax Rules'
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
      doc: 'Penny 0.01 For All Prices'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny If Price 3 Nickel If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel If Price 3 Dime If Price 3'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny 0.01 For All Prices'
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
      doc: 'Cbsx'
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
      id: 'start_of_test_session'
      doc: 'Sent Before Tests'
    0x32:
      id: 'end_of_test_session'
      doc: 'End Of Test Session'
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
    0x50:
      id: 'miax_prime_paired_order'
      doc: 'Miax Prime Paired Order'
    0x53:
      id: 'settlement_opening_imbalance_mechanism'
      doc: 'Settlement Opening Imbalance Mechanism'
    0x45:
      id: 'liquidity_exposure_process'
      doc: 'Liquidity Exposure Process'
    0x43:
      id: 'complex_order_auction'
      doc: 'Complex Order Auction'
  imbalance_side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  origin:
    0x31:
      id: 'market_maker'
      doc: 'Market Maker'
    0x32:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x33:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x34:
      id: 'firm'
      doc: 'Firm'
    0x35:
      id: 'priority_customer'
      doc: 'Priority Customer'
    0x36:
      id: 'non_priority_customer'
      doc: 'Non Priority Customer'
    0x20:
      id: 'multiple_initiators_of_varying_origin'
      doc: 'Multiple Initiators Of Varying Origin'
  side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
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
  option_state:
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4e:
      id: 'open_but_no_fsrp'
      doc: 'Open But No Fsrp'
    0x4f:
      id: 'open_with_fsrp'
      doc: 'Open With Fsrp'
  settlement_reference_price_type:
    0x45:
      id: 'expected_opening_price'
      doc: 'Tsrp'
    0x41:
      id: 'auction_only_price'
      doc: 'Tsrp'
    0x4f:
      id: 'opening_price'
      doc: 'Tsrp'
    0x53:
      id: 'final_settlement_reference_price'
      doc: 'Fsrp'
  opening_condition:
    0x51:
      id: 'need_quote'
      doc: 'Need Quote'
    0x43:
      id: 'crossed_quote'
      doc: 'Crossed Quote'
    0x41:
      id: 'crossed_away_quote'
      doc: 'Crossed Away Quote'
    0x42:
      id: 'need_buyers'
      doc: 'When Imbalance Side A'
    0x53:
      id: 'need_sellers'
      doc: 'When Imbalance Side B'
    0x4f:
      id: 'would_open'
      doc: 'Would Open'
    0x4e:
      id: 'open_with_no_final_srp'
      doc: 'Open With No Final Srp'
    0x52:
      id: 'open_with_final_srp'
      doc: 'Open With Final Srp'
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
      doc: 'Sent by the firm over the AIS Retransmission Interface (SesM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Options over the AIS Retransmission Interface (SesM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request. Note: MIAX Options PDF assigns Response Type "R" (uppercase) to this message, colliding with the Request Type "R" byte; lowercase "r" is used here to match the Pearl convention for case-distinct discrimination.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Options over the AIS Retransmission Interface (SesM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x50:
      id: 'simple_series_update_refresh'
      doc: 'Simple Series Update Refresh'
    0x43:
      id: 'complex_strategy_definition_refresh'
      doc: 'Complex Strategy Definition Refresh'
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

