# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions DepthOfMarket Glimpse v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Depth Of Market
#   Encoding: Glimpse
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Depth_of_Market_Glimpse.pdf
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
  id: nasdaq_iseoptions_depthofmarket_glimpse_v2_1_server
  title: Nasdaq IseOptions DepthOfMarket Glimpse v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Depth Of Market Glimpse v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: server_soup_bin_tcp_packet
    type: server_soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet sent by the server'

types:
  server_soup_bin_tcp_packet_struct:
    seq:
      - id: server_packet_header
        type: server_packet_header
        doc: 'Packet header of a packet sent by the server'
      - id: server_payload
        size: server_packet_header.packet_length + 2 - 3
        type:
          switch-on: server_packet_header.server_packet_type
          cases:
            'server_packet_type::debug_packet': debug_packet
            'server_packet_type::login_accepted_packet': login_accepted_packet
            'server_packet_type::login_rejected_packet': login_rejected_packet
            'server_packet_type::sequenced_data_packet': sequenced_data_packet
  server_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: server_packet_type
        type: u1
        enum: server_packet_type
        doc: 'Code identifying this packet type sent by the server'
  debug_packet:
    seq:
      - id: text
        type: str
        size: 1
        encoding: ASCII
        doc: 'Free form human readable text'
  login_accepted_packet:
    seq:
      - id: accepted_session
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: u1
        enum: reject_reason_code
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.server_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::derivative_directory_message': derivative_directory_message
            'sequenced_message_type::trading_action_message': trading_action_message
            'sequenced_message_type::add_order_short_form_message': add_order_short_form_message
            'sequenced_message_type::add_order_long_form_message': add_order_long_form_message
            'sequenced_message_type::add_quote_short_form_message': add_quote_short_form_message
            'sequenced_message_type::add_quote_long_form_message': add_quote_long_form_message
            'sequenced_message_type::snapshot_message': snapshot_message
  system_event_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
  derivative_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: security_symbol
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
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
        type: u4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within the Exchange System'
      - id: closing_type
        type: u1
        enum: closing_type
        doc: 'Closing Type'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Tradable'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation'
      - id: reserved_16
        size: 16
        doc: 'Reserved for future use'
  trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Current Trading State'
  add_order_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity'
      - id: price_short
        type: u2
        doc: 'The display price of the new order being added to the book'
      - id: volume_short
        type: u2
        doc: 'The total quantity of the new order being added to the book'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  add_order_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity'
      - id: price_long
        type: u4
        doc: 'The display price of the new order being added to the book'
      - id: volume_long
        type: u4
        doc: 'The total quantity of the new order being added to the book'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
  add_quote_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the new quote'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the new quote'
      - id: bid_price_short
        type: u2
        doc: 'The display bid price of the new quote'
      - id: bid_size_short
        type: u2
        doc: 'The bid quantity of the new quote'
      - id: ask_price_short
        type: u2
        doc: 'The display ask price of the new quote'
      - id: ask_size_short
        type: u2
        doc: 'The ask quantity of the new quote'
  add_quote_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Options Directory Message'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the new quote'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the new quote'
      - id: bid_price_long
        type: u4
        doc: 'The display bid price of the new quote'
      - id: bid_size_long
        type: u4
        doc: 'The bid quantity of the new quote'
      - id: ask_price_long
        type: u4
        doc: 'The display ask price of the new quote'
      - id: ask_size_long
        type: u4
        doc: 'The ask quantity of the new quote'
  snapshot_message:
    seq:
      - id: sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Depth of Market Feed sequence number when the Glimpse snapshot was taken'
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

enums:
  client_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x4c:
      id: 'login_request_packet'
      doc: 'SoupbinTcp Login Request Packet'
    0x55:
      id: 'unsequenced_data_packet'
      doc: 'Soupbin Tcp Unsequenced Data Packet'
    0x52:
      id: 'client_heartbeat_packet'
      doc: 'SoupbinTcp Client Heartbeat Packet'
    0x4f:
      id: 'logout_request_packet'
      doc: 'SoupbinTcp Logout Request Packet'
  server_packet_type:
    0x2b:
      id: 'debug_packet'
      doc: 'SoupbinTcp Debug Packet'
    0x41:
      id: 'login_accepted_packet'
      doc: 'SoupbinTcp Login Accepted Packet'
    0x4a:
      id: 'login_rejected_packet'
      doc: 'SoupbinTcp Login Rejected Packet'
    0x53:
      id: 'sequenced_data_packet'
      doc: 'Sequenced Data Packet'
    0x48:
      id: 'server_heartbeat_packet'
      doc: 'SoupbinTcp Server Heartbeat Packet'
    0x5a:
      id: 'end_of_session_packet'
      doc: 'SoupbinTcp Login End of Session Packet'
  reject_reason_code:
    0x41:
      id: 'not_authorized'
      doc: 'The Login Request Packet''s username and password combination was invalid'
    0x53:
      id: 'session_not_available'
      doc: 'The Login Request Packet''s requested session was invalid or not available'
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x6d:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x72:
      id: 'add_order_short_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6f:
      id: 'add_order_long_form_message'
      doc: 'An Add Order Message indicates that a new order has been accepted and was added to the displayable book.'
    0x6a:
      id: 'add_quote_short_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x4a:
      id: 'add_quote_long_form_message'
      doc: 'An Add Quote Message indicates that a new quote has been accepted and was added to the displayable book.'
    0x4d:
      id: 'snapshot_message'
      doc: 'The Snapshot message reflects the Depth of Market sequence number at the time the GLIMPSE spin was requested.'
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
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
    0x4e:
      id: 'not_applicable'
      doc: 'Not Applicable'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Not Tradable'
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
    0x42:
      id: 'buy_side_suspended'
      doc: 'Buy Side Suspended'
    0x53:
      id: 'sell_side_suspended'
      doc: 'Sell Side Suspended'
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x58:
      id: 'closed'
      doc: 'Closed'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x4d:
      id: 'buy_implied'
      doc: 'Buy Implied'
    0x4e:
      id: 'sell_implied'
      doc: 'Sell Implied'
  order_capacity:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'market_maker_order'
      doc: 'Market Maker Order'
    0x42:
      id: 'broker_dealer_order'
      doc: 'Broker Dealer Order'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x4f:
      id: 'other_exchange_market_maker_order'
      doc: 'Other Exchange Market Maker Order'
    0x4a:
      id: 'joint_back_office'
      doc: 'Joint Back Office'
    0x20:
      id: 'na'
      doc: 'Na'

