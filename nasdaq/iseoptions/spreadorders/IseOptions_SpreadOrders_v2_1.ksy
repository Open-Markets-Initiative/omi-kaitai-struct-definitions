# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions SpreadOrders Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Phlx Options Spread Orders
#   Encoding: Itch
#   Version: 2.1
#   Date: 09/15/2025
#   Specification: Options_Spread_Feed_2.1.pdf
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
# For full Omi information:
#   https://github.com/Open-Markets-Initiative/Directory
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_iseoptions_spreadorders_itch_v2_1
  title: Nasdaq IseOptions SpreadOrders Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Phlx Options Spread Orders Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

seq:
  - id: soup_bin_tcp_packet
    type: soup_bin_tcp_packet_struct
    repeat: eos
    doc: 'Soup Bin Tcp Packet'

types:
  soup_bin_tcp_packet_struct:
    seq:
      - id: tcp_packet_header
        type: tcp_packet_header
      - id: tcp_payload
        size: tcp_packet_header.packet_length + 2 - 3
        type:
          switch-on: tcp_packet_header.packet_type
          cases:
            'packet_type::debug_packet': debug_packet
            'packet_type::login_accepted_packet': login_accepted_packet
            'packet_type::login_rejected_packet': login_rejected_packet
            'packet_type::sequenced_data_packet': sequenced_data_packet
            'packet_type::login_request_packet': login_request_packet
            'packet_type::unsequenced_data_packet': unsequenced_data_packet
  tcp_packet_header:
    seq:
      - id: packet_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: packet_type
        type: u1
        enum: packet_type
        doc: 'Code identifying this packet type'
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
        doc: 'The session ID of the session that is now logged into. Left padded with spaces'
      - id: accepted_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'The sequence number in ASCII of the next Sequenced Message to be sent. Left padded with spaces'
  login_rejected_packet:
    seq:
      - id: reject_reason_code
        type: str
        size: 1
        encoding: ASCII
        doc: 'Login Reject Codes'
  sequenced_data_packet:
    seq:
      - id: sequenced_message_type
        type: u1
        enum: sequenced_message_type
        doc: 'Value identifying sequenced message type'
      - id: sequenced_message
        size: _parent.tcp_packet_header.packet_length - 2
        type:
          switch-on: sequenced_message_type
          cases:
            'sequenced_message_type::system_event_message': system_event_message
            'sequenced_message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'sequenced_message_type::strategy_trading_action_message': strategy_trading_action_message
            'sequenced_message_type::complex_add_order_message': complex_add_order_message
            'sequenced_message_type::complex_strategy_auction_message': complex_strategy_auction_message
            'sequenced_message_type::end_of_replay_sequence_message': end_of_replay_sequence_message
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
  complex_strategy_directory_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'Strategy Type'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: num_leg_information
        type: u1
        doc: 'Number of legs in the strategy'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information'
  leg_information:
    seq:
      - id: option_id
        type: u4
        doc: 'Option ID for this leg, valid for the trading day'
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
        type: decimal_u4_4
        doc: 'Explicit strike price. Refer to Data Types for field processing notes. Zero (0) for Stock Leg. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
  strategy_trading_action_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Current Trading State'
  complex_add_order_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: original_order_volume
        type: u4
        doc: 'Original Order Volume for this order'
      - id: executable_order_volume
        type: u4
        doc: 'Volume available for execution'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Indicates the current status of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the type of order'
      - id: limit_price
        type: decimal_u4_4
        doc: 'Price of the order in fixed point format with 6 whole number places followed Integer by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Indicates duration of the order'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Indicates the order capacity'
      - id: scope
        type: u1
        enum: scope
        doc: 'Scope'
      - id: owner_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide Firm ID to disseminate with order; Spaces when not set'
      - id: giveup
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide Give-up to disseminate with order; Spaces when not set'
      - id: cmta
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide CMTA to disseminate with order; Spaces when not set'
  complex_strategy_auction_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'Option ID assigned daily. Valid for trading day'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of Auction'
      - id: auction_duration
        type: u4
        doc: 'User defined for Auction Duration. In milliseconds between 3,000 and 300,000'
      - id: auction_event
        type: u1
        enum: auction_event
        doc: 'Auction Event'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the type of order'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: price
        type: decimal_u4_4
        doc: 'Price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Size'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: 'Exec Flag'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Indicates the order capacity'
      - id: scope
        type: u1
        enum: scope
        doc: 'Scope'
      - id: owner_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide Firm ID to disseminate with order; Spaces when not set'
      - id: giveup
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide Give-up to disseminate with order; Spaces when not set'
      - id: cmta
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Attributable Order may provide CMTA to disseminate with order; Spaces when not set'
      - id: response_price
        type: decimal_u4_4
        doc: 'Price of the aggregated auction responses in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: response_size
        type: u4
        doc: 'Size of the aggregated auction responses at the best price (zero if not shown)'
      - id: reserved_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
      - id: num_flex_dac_leg_information
        type: u1
        doc: 'Number of Flex DAC legs in the strategy Legs'
      - id: flex_dac_leg_information
        type: flex_dac_leg_information
        repeat: expr
        repeat-expr: num_flex_dac_leg_information
        doc: 'Flex DAC leg information'
  flex_dac_leg_information:
    seq:
      - id: reserved_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
  end_of_replay_sequence_message:
    seq:
      - id: end_of_replay_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sequence number once the replay is complete'
  login_request_packet:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        doc: 'Session username'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        doc: 'Login password'
      - id: requested_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Specifies the session the client would like to log into, or all blanks to log into the currently active session'
      - id: requested_sequence_number
        type: str
        size: 20
        encoding: ASCII
        doc: 'Specifies the next sequence number in ASCII the client wants to receive upon connection, or 0 to start receiving the most recently generated message'
  unsequenced_data_packet:
    seq:
      - id: unsequenced_message_type
        type: str
        size: 1
        encoding: ASCII
        doc: 'Value identifying unsequenced message type'
  mold_udp_64_packet:
    seq:
      - id: udp_packet_header
        type: udp_packet_header_struct
        doc: 'Itch Mold Udp 64 Packet Header'
      - id: messages
        repeat: expr
        repeat-expr: udp_packet_header.message_count
        type:
          switch-on: udp_packet_header.message_count
          cases:
            _: message
  udp_packet_header_struct:
    seq:
      - id: udp_session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: udp_sequence_number
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
      - id: udp_payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'message_type::strategy_trading_action_message': strategy_trading_action_message
            'message_type::complex_add_order_message': complex_add_order_message
            'message_type::complex_strategy_auction_message': complex_strategy_auction_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
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
  decimal_u4_4:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  packet_type:
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
  sequenced_message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x43:
      id: 'complex_add_order_message'
      doc: 'A Complex Add Order message is generated for all the following situations whenever an order free from any display restrictions is reported by the matching engine.'
    0x61:
      id: 'complex_strategy_auction_message'
      doc: 'This message is used to announce strategy auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of replay Sequence message reflects the sequence number at the time replay of existing messages is complete.'
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
  strategy_type:
    0x56:
      id: 'vertical_spread'
      doc: 'Vertical Spread'
    0x54:
      id: 'time_spread'
      doc: 'Time Spread'
    0x44:
      id: 'diagonal_spread'
      doc: 'Diagonal Spread'
    0x53:
      id: 'straddle'
      doc: 'Straddle'
    0x47:
      id: 'strangle'
      doc: 'Strangle'
    0x43:
      id: 'combo'
      doc: 'Combo'
    0x52:
      id: 'risk_reversal'
      doc: 'Risk Reversal'
    0x41:
      id: 'ratio_spread'
      doc: 'Ratio Spread'
    0x42:
      id: 'box_spread'
      doc: 'Box Spread'
    0x46:
      id: 'butterfly_spread'
      doc: 'Butterfly Spread'
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  current_trading_state:
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
  order_status:
    0x4f:
      id: 'open'
      doc: 'Open'
    0x46:
      id: 'filled'
      doc: 'Filled'
    0x43:
      id: 'cancelled'
      doc: 'Cancelled'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
  time_in_force:
    0x44:
      id: 'day_order'
      doc: 'Day Order'
    0x47:
      id: 'good_till_cancelled'
      doc: 'Good Till Cancelled'
  order_capacity:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'nasdaq_registered_market_maker'
      doc: 'Nasdaq Registered Market Maker'
    0x42:
      id: 'broker_dealer_oder'
      doc: 'Broker Dealer Oder'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x4f:
      id: 'other_exchange_registered_market_maker'
      doc: 'Other Exchange Registered Market Maker'
    0x4a:
      id: 'jbo_joint_back_office_only_phlx'
      doc: 'Jbo Joint Back Office Only Phlx'
  scope:
    0x4c:
      id: 'local'
      doc: 'Local'
    0x4e:
      id: 'national'
      doc: 'National'
  auction_type:
    0x45:
      id: 'complex_exposure'
      doc: 'Complex Exposure'
    0x50:
      id: 'price_improvement_pim_auction'
      doc: 'Price Improvement Pim Auction'
    0x43:
      id: 'facilitation'
      doc: 'Facilitation'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x58:
      id: 'flex_auction'
      doc: 'Flex Auction'
  auction_event:
    0x53:
      id: 'start'
      doc: 'Start'
    0x55:
      id: 'auction_update'
      doc: 'Auction Update'
    0x45:
      id: 'end_of_auction'
      doc: 'End Of Auction'
  exec_flag:
    0x4e:
      id: 'none'
      doc: 'None'
    0x41:
      id: 'aon'
      doc: 'Aon'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x73:
      id: 'complex_strategy_directory_message'
      doc: 'A Complex Strategy Directory Message containing the strategy definition will be sent whenever a complex order is added in the system.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x43:
      id: 'complex_add_order_message'
      doc: 'A Complex Add Order message is generated for all the following situations whenever an order free from any display restrictions is reported by the matching engine.'
    0x61:
      id: 'complex_strategy_auction_message'
      doc: 'This message is used to announce strategy auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'

