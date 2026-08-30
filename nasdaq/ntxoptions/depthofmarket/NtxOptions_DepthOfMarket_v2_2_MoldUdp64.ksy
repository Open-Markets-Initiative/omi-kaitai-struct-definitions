# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq NtxOptions DepthOfMarket Itch v2.2
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Depth Of Market
#   Encoding: Itch
#   Version: 2.2
#   Date: 12/18/2025
#   Specification: Nasdaq_Texas_Options_Depth_of_Market.pdf
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
  id: nasdaq_ntxoptions_depthofmarket_itch_v2_2_moldudp64
  title: Nasdaq NtxOptions DepthOfMarket Itch v2.2
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Texas Options Depth Of Market Itch v2.2'
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
            'message_type::add_order_short_form_message': add_order_short_form_message
            'message_type::add_order_long_form_message': add_order_long_form_message
            'message_type::add_quote_short_form_message': add_quote_short_form_message
            'message_type::add_quote_long_form_message': add_quote_long_form_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::order_cancel_message': order_cancel_message
            'message_type::order_replace_short_form_message': order_replace_short_form_message
            'message_type::order_replace_long_form_message': order_replace_long_form_message
            'message_type::order_delete_message': order_delete_message
            'message_type::order_change_message': order_change_message
            'message_type::quote_replace_short_form_message': quote_replace_short_form_message
            'message_type::quote_replace_long_form_message': quote_replace_long_form_message
            'message_type::quote_delete_message': quote_delete_message
            'message_type::trade_message': trade_message
            'message_type::net_order_imbalance_message': net_order_imbalance_message
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
      - id: expiration_year
        type: u1
        doc: 'Last two digits of the year of the option expiration'
      - id: expiration_month
        type: u1
        doc: 'Expiration Month of the option (1-12)'
      - id: expiration_date
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
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN identifier'
      - id: tick_size_table_id
        type: u2
        doc: 'Tick Size Table ID'
      - id: price_notation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Price notation'
      - id: volume_notation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Volume notation'
      - id: financial_product
        type: u2
        doc: 'Financial Product'
      - id: market_segment_id
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment Id'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Currency'
      - id: mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Identifier Code'
      - id: instrument_long_name
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument Long Name'
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The side of the order being added'
      - id: order_capacity
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order Capacity'
      - id: price_short
        type: u2
        doc: 'The display price of the new order'
      - id: volume_short
        type: u2
        doc: 'The display quantity of the new order'
      - id: rank
        type: u2
        doc: 'Order rank on the book'
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: market_side
        type: u1
        enum: market_side
        doc: 'The side of the order being added'
      - id: order_capacity
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Order Capacity'
      - id: price_long
        type: u4
        doc: 'The display price of the new order'
      - id: volume_long
        type: u4
        doc: 'The display quantity of the new order'
      - id: rank
        type: u2
        doc: 'Order rank on the book'
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the quote'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the quote'
      - id: bid_price_short
        type: u2
        doc: 'The display bid price of the quote'
      - id: bid_size_short
        type: u2
        doc: 'The display bid quantity of the quote'
      - id: ask_price_short
        type: u2
        doc: 'The display ask price of the quote'
      - id: ask_size_short
        type: u2
        doc: 'The display ask quantity of the quote'
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
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the quote'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the quote'
      - id: bid_price_long
        type: u4
        doc: 'The display bid price of the quote'
      - id: bid_size_long
        type: u4
        doc: 'The display bid quantity of the quote'
      - id: ask_price_long
        type: u4
        doc: 'The display ask price of the quote'
      - id: ask_size_long
        type: u4
        doc: 'The display ask quantity of the quote'
  order_executed_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: strategy_id
        type: u4
        doc: 'Strategy ID'
      - id: reference_number
        type: u8
        doc: 'The unique reference number assigned to the order being executed'
      - id: executed_volume
        type: u4
        doc: 'The number of contracts executed'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day'
  order_executed_with_price_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: strategy_id
        type: u4
        doc: 'Strategy ID'
      - id: reference_number
        type: u8
        doc: 'The unique reference number assigned to the order being executed'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day'
      - id: printable
        type: u1
        enum: printable
        doc: 'Printable'
      - id: price_long
        type: u4
        doc: 'The display price of the new order'
      - id: volume_long
        type: u4
        doc: 'The display quantity of the new order'
  order_cancel_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: order_reference_number
        type: u8
        doc: 'The unique reference number assigned to the new order'
      - id: cancelled_volume
        type: u4
        doc: 'Volume to be removed from the display size of the order as the result of a cancellation'
  order_replace_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: original_reference_number
        type: u8
        doc: 'The original reference number associated with the order being replaced'
      - id: new_reference_number
        type: u8
        doc: 'The new reference number assigned to the replacement order'
      - id: price_short
        type: u2
        doc: 'The display price of the new order'
      - id: volume_short
        type: u2
        doc: 'The display quantity of the new order'
  order_replace_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: original_reference_number
        type: u8
        doc: 'The original reference number associated with the order being replaced'
      - id: new_reference_number
        type: u8
        doc: 'The new reference number assigned to the replacement order'
      - id: price_long
        type: u4
        doc: 'The display price of the new order'
      - id: volume_long
        type: u4
        doc: 'The display quantity of the new order'
  order_delete_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: reference_number
        type: u8
        doc: 'The unique reference number assigned to the order being executed'
  order_change_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: reference_number
        type: u8
        doc: 'The unique reference number assigned to the order being executed'
      - id: change_reason
        type: u1
        enum: change_reason
        doc: 'Change Reason'
      - id: price_long
        type: u4
        doc: 'The display price of the new order'
      - id: volume_long
        type: u4
        doc: 'The display quantity of the new order'
  quote_replace_short_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: original_bid_reference_number
        type: u8
        doc: 'The original bid reference number associated with the quote being replaced'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the quote'
      - id: original_ask_reference_number
        type: u8
        doc: 'The original ask reference number associated with the quote being replaced'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the quote'
      - id: bid_price_short
        type: u2
        doc: 'The display bid price of the quote'
      - id: bid_size_short
        type: u2
        doc: 'The display bid quantity of the quote'
      - id: ask_price_short
        type: u2
        doc: 'The display ask price of the quote'
      - id: ask_size_short
        type: u2
        doc: 'The display ask quantity of the quote'
  quote_replace_long_form_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: original_bid_reference_number
        type: u8
        doc: 'The original bid reference number associated with the quote being replaced'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the quote'
      - id: original_ask_reference_number
        type: u8
        doc: 'The original ask reference number associated with the quote being replaced'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the quote'
      - id: bid_price_long
        type: u4
        doc: 'The display bid price of the quote'
      - id: bid_size_long
        type: u4
        doc: 'The display bid quantity of the quote'
      - id: ask_price_long
        type: u4
        doc: 'The display ask price of the quote'
      - id: ask_size_long
        type: u4
        doc: 'The display ask quantity of the quote'
  quote_delete_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: bid_reference_number
        type: u8
        doc: 'The bid reference number associated with the quote'
      - id: ask_reference_number
        type: u8
        doc: 'The ask reference number associated with the quote'
  trade_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: cross_number
        type: u4
        doc: 'Trade Group Id. Ties together all trades of a given atomic transaction'
      - id: match_number
        type: u4
        doc: 'Execution Id. Identifies the component of an execution. Unique for a given day'
      - id: strategy_id
        type: u4
        doc: 'Strategy ID'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Cross Type'
      - id: price_long
        type: u4
        doc: 'The display price of the new order'
      - id: volume_long
        type: u4
        doc: 'The display quantity of the new order'
      - id: printable
        type: u1
        enum: printable
        doc: 'Printable'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type'
  net_order_imbalance_message:
    seq:
      - id: tracking_number
        type: u2
        doc: 'Internal system tracking number'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Nanoseconds since midnight. Nanoseconds since Midnight epoch'
      - id: instrument_id
        type: u4
        doc: 'Integer ID of the option, as defined in the Derivative Directory Message'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Auction Type'
      - id: paired_quantity
        type: u4
        doc: 'The total amount that are eligible to be matched at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: imbalance_price
        type: u4
        doc: 'Imbalance Price'
      - id: imbalance_volume
        type: u4
        doc: 'Imbalance volume'
      - id: customer_firm_indicator
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Customer Firm Indicator'
      - id: best_bid_price
        type: u4
        doc: 'Best Bid Price'
      - id: best_bid_quantity
        type: u4
        doc: 'Best Bid Quantity'
      - id: best_ask_price
        type: u4
        doc: 'Best Ask Price'
      - id: best_ask_quantity
        type: u4
        doc: 'Best Ask Quantity'
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
    0x52:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an option.'
    0x61:
      id: 'add_order_short_form_message'
      doc: 'An Add Order Short Form Message indicates a new order or new quote accepted by the system.'
    0x41:
      id: 'add_order_long_form_message'
      doc: 'An Add Order Long Form Message indicates a new order or new quote accepted by the system.'
    0x6a:
      id: 'add_quote_short_form_message'
      doc: 'An Add Quote Short Form Message indicates a new two-sided quote accepted by the system.'
    0x4a:
      id: 'add_quote_long_form_message'
      doc: 'An Add Quote Long Form Message indicates a new two-sided quote accepted by the system.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'order_replace_short_form_message'
      doc: 'This message is sent whenever an order on the book is replaced.'
    0x55:
      id: 'order_replace_long_form_message'
      doc: 'This message is sent whenever an order on the book is replaced.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being deleted.'
    0x47:
      id: 'order_change_message'
      doc: 'This message is sent whenever an order is being updated for price and (or) contracts.'
    0x6b:
      id: 'quote_replace_short_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x4b:
      id: 'quote_replace_long_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x59:
      id: 'quote_delete_message'
      doc: 'This message is sent whenever a quote on the book is being deleted.'
    0x51:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for the normal different types of trades.'
    0x49:
      id: 'net_order_imbalance_message'
      doc: 'This message is used to announce opening and re-opening auctions.'
    0x4d:
      id: 'end_of_replay_sequence_message'
      doc: 'The End of Replay Sequence message reflects the sequence number at the time replay of existing messages is complete.'
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
      id: 'end_of_normal_hours_processing'
      doc: 'End Of Normal Hours Processing'
    0x4c:
      id: 'end_of_late_hours_processing'
      doc: 'End Of Late Hours Processing'
    0x45:
      id: 'end_of_system_hours'
      doc: 'End Of System Hours'
    0x43:
      id: 'end_of_messages'
      doc: 'End Of Messages'
  option_type:
    0x43:
      id: 'call_option'
      doc: 'Call Option'
    0x50:
      id: 'put_option'
      doc: 'Put Option'
    0x4e:
      id: 'na'
      doc: 'Na'
  closing_type:
    0x4e:
      id: 'normal_hours'
      doc: 'Normal Hours'
    0x4c:
      id: 'late_hours'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'instrument_is_tradable'
      doc: 'Instrument Is Tradable'
    0x4e:
      id: 'instrument_is_not_tradable'
      doc: 'Instrument Is Not Tradable'
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
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x42:
      id: 'buy_side_trading_suspended'
      doc: 'Buy Side Trading Suspended'
    0x53:
      id: 'sell_side_trading_suspended'
      doc: 'Sell Side Trading Suspended'
    0x49:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x52:
      id: 're_opening'
      doc: 'Re Opening'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x58:
      id: 'closed'
      doc: 'Closed'
  market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x58:
      id: 'buy_aon'
      doc: 'Buy Aon'
    0x59:
      id: 'sell_aon'
      doc: 'Sell Aon'
  printable:
    0x4e:
      id: 'nonprintable'
      doc: 'Nonprintable'
    0x59:
      id: 'printable'
      doc: 'Printable'
  change_reason:
    0x55:
      id: 'user'
      doc: 'User'
    0x52:
      id: 'reprice'
      doc: 'Reprice'
    0x53:
      id: 'suspend'
      doc: 'Suspend'
  cross_type:
    0x41:
      id: 'all_auctions'
      doc: 'All Auctions'
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement'
    0x4e:
      id: 'none'
      doc: 'None'
  trade_type:
    0x45:
      id: 'electronic_trade'
      doc: 'Electronic Trade'
  auction_type:
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'price_improvement'
      doc: 'Price Improvement'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'derivative_directory_message'
      doc: 'Derivative Directory Message for active options symbols.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an option.'
    0x61:
      id: 'add_order_short_form_message'
      doc: 'An Add Order Short Form Message indicates a new order or new quote accepted by the system.'
    0x41:
      id: 'add_order_long_form_message'
      doc: 'An Add Order Long Form Message indicates a new order or new quote accepted by the system.'
    0x6a:
      id: 'add_quote_short_form_message'
      doc: 'An Add Quote Short Form Message indicates a new two-sided quote accepted by the system.'
    0x4a:
      id: 'add_quote_long_form_message'
      doc: 'An Add Quote Long Form Message indicates a new two-sided quote accepted by the system.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever an order on the book is executed in whole or in part at a price different from the initial display price.'
    0x58:
      id: 'order_cancel_message'
      doc: 'This message is sent whenever an order on the book is modified as a result of a partial cancellation.'
    0x75:
      id: 'order_replace_short_form_message'
      doc: 'This message is sent whenever an order on the book is replaced.'
    0x55:
      id: 'order_replace_long_form_message'
      doc: 'This message is sent whenever an order on the book is replaced.'
    0x44:
      id: 'order_delete_message'
      doc: 'This message is sent whenever an order on the book is being deleted.'
    0x47:
      id: 'order_change_message'
      doc: 'This message is sent whenever an order is being updated for price and (or) contracts.'
    0x6b:
      id: 'quote_replace_short_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x4b:
      id: 'quote_replace_long_form_message'
      doc: 'This message is sent whenever a quote on the book is replaced.'
    0x59:
      id: 'quote_delete_message'
      doc: 'This message is sent whenever a quote on the book is being deleted.'
    0x51:
      id: 'trade_message'
      doc: 'The Trade Message is designed to provide execution details for the normal different types of trades.'
    0x49:
      id: 'net_order_imbalance_message'
      doc: 'This message is used to announce opening and re-opening auctions.'

