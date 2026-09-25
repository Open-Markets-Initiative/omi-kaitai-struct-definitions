# ---------------------------------------------------------------------
# Kaitai struct definition for: Miax PearlOptions LiquidityFeed Mach v1.2
#
# Protocol:
#   Organization: Miami International Holdings
#   Protocol: Liquidity Feed
#   Encoding: Mach
#   Version: 1.2
#   Date: 10/05/2020
#   Specification: PEARL_Liquidity_Feed_PLF_v1.2.pdf
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
  id: miax_pearloptions_liquidityfeed_mach_v1_2_tcp
  title: Miax PearlOptions LiquidityFeed Mach v1.2
  license: GPL-3.0
  endian: le

doc: 'Miami International Holdings MIAX Pearl Options Liquidity Feed Mach v1.2'
doc-ref: https://www.miaxglobal.com/markets/us-options/miax-pearl/interface-specifications

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
        doc: 'Market-data application message type carried over the SesM sequenced channel (matches the MACH UDP Message Type byte; Pearl Options uses Ascii message codes)'
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
            'message_type::series_update_message': series_update_message
            'message_type::system_state_message': system_state_message
            'message_type::underlying_trading_status_notification_message': underlying_trading_status_notification_message
            'message_type::order_message': order_message
            'message_type::order_close_message': order_close_message
  system_time_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds part of the time that applies to all messages that gets disseminated until this message gets sent again. Seconds since Unix epoch'
  series_update_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Pearl system today. Nanoseconds since Second epoch'
      - id: product_id
        type: u4
        doc: 'Pearl Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
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
      - id: active_on_pearl
        type: u1
        enum: active_on_pearl
        doc: 'Indicates if this symbol is tradable on MIAX in the current session'
      - id: pearl_bbo_posting_increment_indicator
        type: u1
        enum: pearl_bbo_posting_increment_indicator
        doc: 'This is the Minimum Price Variation as agreed to by the Options industry (penny pilot program) and as published by Pearl'
      - id: liquidity_acceptance_increment_indicator
        type: u1
        enum: liquidity_acceptance_increment_indicator
        doc: 'This is the Minimum Price Variation for Quote/Order acceptance as per Pearl rules'
      - id: opening_underlying_market_code
        type: u1
        enum: opening_underlying_market_code
        doc: 'Options opening will be triggered on receipt of Opening quote/trade from this Underlying market'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
  system_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Pearl system today. Nanoseconds since Second epoch'
      - id: plf_version
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Eg: PLF1.0'
      - id: session_id
        type: u4
        doc: 'Pearl assigned ID for the current trading session'
      - id: system_status
        type: u1
        enum: system_status
        doc: 'Current system status'
  underlying_trading_status_notification_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Pearl system today. Nanoseconds since Second epoch'
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
  order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Pearl system today. Nanoseconds since Second epoch'
      - id: action
        type: u1
        enum: action
        doc: 'Order Status'
      - id: product_id
        type: u4
        doc: 'Pearl Product ID mapped to a given option. It is assigned per trading session and is valid for that session'
      - id: order_id
        type: u8
        doc: 'Pearl assigned Order ID'
      - id: order_side
        type: u1
        enum: order_side
        doc: 'Side of order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order price type'
      - id: order_price
        type: decimal_u4_4
        doc: 'Limit price of the order. Zero for market orders. Implied decimal with scale 1e-4'
      - id: order_original_volume
        type: u4
        doc: 'Number of contracts specified on the order'
      - id: remaining_volume_open
        type: u4
        doc: 'Number of contracts that are still open for trading at Pearl'
      - id: time_in_force_tif
        type: u1
        enum: time_in_force_tif
        doc: 'Specifies how long the order remains in effect'
      - id: origin
        type: u1
        enum: origin
        doc: 'Specifies the order origin type'
      - id: openclose_indicator
        type: u1
        enum: openclose_indicator
        doc: 'Specifies if this order opens a position or closes a position. N/A when Origin is set to 4 = Market Maker or 5 = Non-Member Market Maker'
      - id: order_instruction
        type: u1
        enum: order_instruction
        doc: 'Order instruction that came with the order'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
  order_close_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Time at which this product is added/updated on Pearl system today. Nanoseconds since Second epoch'
      - id: order_id
        type: u8
        doc: 'Pearl assigned Order ID'
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
      id: 'series_update_message'
      doc: 'This is the message format that will be used to disseminate all Option series traded on Pearl for the current session.'
    0x53:
      id: 'system_state_message'
      doc: 'This message format is used to notify the firms of the state changes of the system. This is a notification that applies to each Underlying group. Firms can use notifications as triggers in their system to ensure electronic synchronization of systems.'
    0x48:
      id: 'underlying_trading_status_notification_message'
      doc: 'This message format will be used to notify firms of changes to the trading status of all the options of an underlying.'
    0x46:
      id: 'order_message'
      doc: 'This is the message format that will be used to disseminate Pearl Options Orders.'
    0x78:
      id: 'order_close_message'
      doc: 'This is the message format that will be used to disseminate Order Close for Pearl Options Orders.'
  call_or_put:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  restricted_option:
    0x59:
      id: 'yes_field'
      doc: 'Pearl Will Accept Position Closing Orders Only'
    0x4e:
      id: 'no_field'
      doc: 'Pearl Will Accept Open And Close Positions'
  long_term_option:
    0x59:
      id: 'yes_field'
      doc: 'Far Month Expiration As Defined By Pearl Rules'
    0x4e:
      id: 'no_field'
      doc: 'Near Month Expiration As Defined By Pearl Rules'
  active_on_pearl:
    0x41:
      id: 'active'
      doc: 'Active Tradable On Pearl'
    0x49:
      id: 'inactive'
      doc: 'Inactive Not Tradable On Pearl'
  pearl_bbo_posting_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny 0.01 At All Prices'
    0x4e:
      id: 'penny_or_nickel'
      doc: 'Penny If Price 3 Nickel If Price 3'
    0x44:
      id: 'nickel_or_dime'
      doc: 'Nickel If Price 3 Dime If Price 3'
  liquidity_acceptance_increment_indicator:
    0x50:
      id: 'penny'
      doc: 'Penny 0.01 At All Prices'
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
      doc: 'Market Independent Any Market That Opens First'
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
      id: 'bats_y_exchange_inc'
      doc: 'Bats Y Exchange Inc'
    0x5a:
      id: 'bats_exchange_inc'
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
  trading_status:
    0x48:
      id: 'halted'
      doc: 'Pearl Has Halted Trading For This Underlying Symbol'
    0x52:
      id: 'resumed'
      doc: 'Pearl Will Resume Trading Reopen For This Underlying Symbol'
    0x4f:
      id: 'opened'
      doc: 'Pearl Will Open Trading For This Underlying Symbol'
  event_reason:
    0x41:
      id: 'automatic'
      doc: 'This Event Resulted From Automaticmarket Driven Event'
    0x4d:
      id: 'manual'
      doc: 'Pearl Manually Initiated This Event'
  action:
    0x4f:
      id: 'open'
      doc: 'Open'
  order_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
  time_in_force_tif:
    0x47:
      id: 'gtc'
      doc: 'Good Till Canceled'
    0x44:
      id: 'day'
      doc: 'Day'
  origin:
    0x30:
      id: 'priority_customer'
      doc: 'Priority Customer'
    0x31:
      id: 'firm'
      doc: 'Firm'
    0x32:
      id: 'broker_dealer'
      doc: 'Broker Dealer'
    0x34:
      id: 'market_maker'
      doc: 'Market Maker Mm'
    0x35:
      id: 'non_member_market_maker'
      doc: 'Non Member Market Maker'
    0x38:
      id: 'non_priority_customer'
      doc: 'Non Priority Customer'
  openclose_indicator:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'close'
      doc: 'Close'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  order_instruction:
    0x52:
      id: 'routable'
      doc: 'Routable'
    0x44:
      id: 'do_not_route'
      doc: 'Do Not Route Dnr'
    0x50:
      id: 'post_only'
      doc: 'Post Only'
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
      doc: 'Sent by the firm over the PLF Retransmission Interface (SesM Unsequenced Data Packet) to request a Last Value Refresh of a particular data set identified by Refresh Message Type.'
    0x72:
      id: 'refresh_response_message'
      doc: 'Sent by MIAX Pearl Options over the PLF Retransmission Interface (SesM Unsequenced Data Packet) carrying one Application Message that satisfies a previous Refresh Request. Note: Pearl Options PDF assigns Response Type "R" (uppercase) to this message, colliding with the Request Type "R" byte; lowercase "r" is used here to match the Pearl convention for case-distinct discrimination.'
    0x45:
      id: 'end_of_refresh_notification_message'
      doc: 'Sent by MIAX Pearl Options over the PLF Retransmission Interface (SesM Unsequenced Data Packet) when the refresh response is complete.'
  refresh_message_type:
    0x50:
      id: 'series_update_refresh'
      doc: 'Series Update Refresh'
    0x55:
      id: 'underlying_trading_status_refresh'
      doc: 'Underlying Trading Status Refresh'
    0x53:
      id: 'system_state_refresh'
      doc: 'System State Refresh'
    0x4f:
      id: 'order_book_refresh'
      doc: 'Order Book Refresh'
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

