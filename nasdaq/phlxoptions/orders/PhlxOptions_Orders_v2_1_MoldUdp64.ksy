# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PhlxOptions Orders Itch v2.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: PHLX Orders
#   Encoding: Itch
#   Version: 2.1
#   Date: 02/13/2026
#   Specification: Options_Order_Feed_2.1.pdf
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
  id: nasdaq_phlxoptions_orders_itch_v2_1_moldudp64
  title: Nasdaq PhlxOptions Orders Itch v2.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX PHLX Orders Itch v2.1'
doc-ref: https://data.nasdaq.com/market-data-specifications

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

types:
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
            'message_type::derivative_directory_message': derivative_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::add_order_message': add_order_message
            'message_type::auction_message': auction_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
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
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
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
  add_order_message:
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
      - id: original_order_volume
        type: u4
        doc: 'Original Order Volume for this order'
      - id: executable_order_volume
        type: u4
        doc: 'Volume available for execution at the venue'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Order Status'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: order_qualifier
        type: u1
        enum: order_qualifier
        doc: 'Order Qualifier'
      - id: limit_price
        type: u4
        doc: 'Original Limit Price of Limit or Stop Order, will not include repricing updates. Otherwise field is zero'
      - id: all_or_none
        type: u1
        enum: all_or_none
        doc: 'All or None'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Time in Force'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'Open Close Indicator'
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
  auction_message:
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
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: auction_duration
        type: u4
        doc: 'User defined for Auction Duration. In milliseconds between 3,000 and 300,000'
      - id: auction_event
        type: u1
        enum: auction_event
        doc: 'AuctionEvent'
      - id: quantity
        type: u4
        doc: 'Auction Quantity. Opening auction will present paired quantity in this field'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: price
        type: u4
        doc: 'Price for the auction; hidden prices are set to zero'
      - id: imbalance_volume
        type: u4
        doc: 'Imbalance volume for opening auction. Will be 0 for other auctions'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: 'Exec Flag'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity'
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
      - id: reserved_16
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
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
    0x4f:
      id: 'add_order_message'
      doc: 'The Order Message indicates a new order has been accepted and was added to the displayable book.'
    0x4a:
      id: 'auction_message'
      doc: 'This message is used to announce auctions, including the opening auction.'
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
  order_qualifier:
    0x4f:
      id: 'opening_order'
      doc: 'Opening Order'
    0x49:
      id: 'implied_order'
      doc: 'Implied Order'
    0x20:
      id: 'na'
      doc: 'Na'
  all_or_none:
    0x59:
      id: 'all_or_none_order'
      doc: 'All Or None Order'
    0x4e:
      id: 'not_all_or_none_order'
      doc: 'Not All Or None Order'
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
  open_close_indicator:
    0x4f:
      id: 'opens_position'
      doc: 'Opens Position'
    0x43:
      id: 'closes_position'
      doc: 'Closes Position'
    0x20:
      id: 'na'
      doc: 'Na'
  auction_type:
    0x42:
      id: 'block_auction'
      doc: 'Block Auction'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
    0x50:
      id: 'price_improvement_auction'
      doc: 'Price Improvement Auction'
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
      id: 'start_of_auction'
      doc: 'Start Of Auction'
    0x45:
      id: 'end_of_auction'
      doc: 'End Of Auction'
    0x55:
      id: 'auction_update'
      doc: 'Auction Update'
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
    0x6d:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x4f:
      id: 'add_order_message'
      doc: 'The Order Message indicates a new order has been accepted and was added to the displayable book.'
    0x4a:
      id: 'auction_message'
      doc: 'This message is used to announce auctions, including the opening auction.'

