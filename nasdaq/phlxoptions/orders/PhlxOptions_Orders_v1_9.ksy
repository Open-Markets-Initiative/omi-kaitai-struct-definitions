# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq PhlxOptions Orders Itch v1.9
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: PHLX Orders
#   Encoding: Itch
#   Version: 1.9
#   Date: 08/10/2015
#   Specification: topoplusorders.pdf
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
  id: nasdaq_phlxoptions_orders_itch_v1_9
  title: Nasdaq PhlxOptions Orders Itch v1.9
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq PHLX PHLX Orders Itch v1.9'
doc-ref: http://www.phlx.com/Trader.aspx?id=DPSpecs#options_x

seq:
  - id: packet_header
    type: packet_header_struct
  - id: messages
    repeat: expr
    repeat-expr: packet_header.count
    type:
      switch-on: packet_header.count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session the payload relates to'
      - id: sequence
        type: u4
        doc: 'Sequence Number of the first message to follow this header'
      - id: count
        type: u2le
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
      - id: payload
        size: message_header.length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::options_directory_message': options_directory_message
            'message_type::complex_order_strategy_message': complex_order_strategy_message
            'message_type::security_trading_action_message': security_trading_action_message
            'message_type::complex_trading_action_message': complex_trading_action_message
            'message_type::security_open_closed_message': security_open_closed_message
            'message_type::strategy_open_closed_message': strategy_open_closed_message
            'message_type::simple_order_message': simple_order_message
            'message_type::complex_order_message': complex_order_message
            'message_type::auction_notification_message': auction_notification_message
            'message_type::complex_auction_notification_message': complex_auction_notification_message
  message_header:
    seq:
      - id: length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
      - id: version
        type: u1
        doc: 'Version of PHLX Orders. Currently set to 1'
  options_directory_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: source
        type: u1
        doc: 'Identifies the source of the Option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: option_closing_type
        type: u1
        enum: option_closing_type
        doc: 'Denotes the closing of the option'
      - id: phlx_tradable
        type: u1
        enum: phlx_tradable
        doc: 'Denotes whether or not this option is tradable at the PHLX exchange'
  expiration:
    seq:
      - id: day
        type: b5
        doc: 'Day bits'
      - id: month
        type: b4
        doc: 'Month bits'
      - id: year
        type: b7
        doc: 'Year bits'
  complex_order_strategy_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'PHLX Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: source
        type: u1
        doc: 'Identifies the source of the Option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: action
        type: u1
        enum: action
        doc: 'Defines the state of the strategy'
      - id: num_complex_order_strategy_leg
        type: u1
        doc: 'Number of legs in the strategy'
      - id: complex_order_strategy_leg
        type: complex_order_strategy_leg
        repeat: expr
        repeat-expr: num_complex_order_strategy_leg
        doc: 'Complex Order Strategy Leg Information'
  complex_order_strategy_leg:
    seq:
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
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
        doc: 'Strategy Leg Ratio'
  security_trading_action_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the option on the PHLX market'
  complex_trading_action_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'PHLX Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the option on the PHLX market'
  security_open_closed_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security on the PHLX. The allowable values are:'
  strategy_open_closed_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'PHLX Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security on the PHLX. The allowable values are:'
  simple_order_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order id'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: original_order_volume
        type: u4
        doc: 'Original Order Volume for this order'
      - id: executable_order_volume
        type: u4
        doc: 'Volume available for execution at PHLX'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Indicates the current status of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the type of order'
      - id: market_qualifier
        type: u1
        enum: market_qualifier
        doc: 'Market Qualifier value'
      - id: limit_price
        type: decimal_s4_4
        doc: 'Limit Price of Limit or Stop Order. Otherwise field is zero. Implied decimal with scale 1e-4'
      - id: all_or_none
        type: u1
        enum: all_or_none
        doc: 'Indicates if order is All or None Order:'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Indicates duration of the order'
      - id: customer_firm_indicator
        type: u1
        enum: customer_firm_indicator
        doc: 'Indicates whether this is a Customer/Firm'
      - id: open_close_indicator
        type: u1
        enum: open_close_indicator
        doc: 'Indicates whether this Order opens or closes a position'
  complex_order_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'PHLX Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: order_id
        type: u4
        doc: 'PHLX assigned order id'
      - id: side
        type: u1
        enum: side
        doc: 'Indicates the side of the order'
      - id: original_order_volume
        type: u4
        doc: 'Original Order Volume for this order'
      - id: executable_order_volume
        type: u4
        doc: 'Volume available for execution at PHLX'
      - id: order_status
        type: u1
        enum: order_status
        doc: 'Indicates the current status of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Indicates the type of order'
      - id: limit_price
        type: decimal_s4_4
        doc: 'Limit Price of Limit or Stop Order. Otherwise field is zero. Implied decimal with scale 1e-4'
      - id: debit_or_credit
        type: u1
        enum: debit_or_credit
        doc: 'Price Debit or Credit value'
      - id: all_or_none
        type: u1
        enum: all_or_none
        doc: 'Indicates if order is All or None Order:'
      - id: time_in_force
        type: u1
        enum: time_in_force
        doc: 'Indicates duration of the order'
      - id: customer_firm_indicator
        type: u1
        enum: customer_firm_indicator
        doc: 'Indicates whether this is a Customer/Firm'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: num_complex_order_leg
        type: u1
        doc: 'Number of legs in the strategy'
      - id: complex_order_leg
        type: complex_order_leg
        repeat: expr
        repeat-expr: num_complex_order_leg
        doc: 'Complex Order Leg Information'
  complex_order_leg:
    seq:
      - id: leg_open_close_indicator
        type: u1
        enum: leg_open_close_indicator
        doc: 'Indicates whether this Order opens or closes a position for leg:'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
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
        doc: 'Strategy Leg Ratio'
  auction_notification_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: option_id
        type: u4
        doc: 'PHLX Option ID assigned daily, valid for the trading day'
      - id: security_symbol
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option symbol (security symbol) post-symbology rollout. Denotes the root portion of the OPRA symbol pre-symbology rollout'
      - id: expiration
        type: expiration
        doc: 'Expiration Year, Month and Day Bitfield'
      - id: explicit_strike_price
        type: decimal_s4_4
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-4'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day. Presently the Auction ID will be zero for non-PIXL auctions'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of Auction:'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which auction is started. For PIXL auctions, price is zero. The price at which an exposed order is available for execution. Implied decimal with scale 1e-4'
      - id: auction_side
        type: u1
        enum: auction_side
        doc: 'Indicates the side of the auction:'
      - id: matched_volume
        type: u4
        doc: 'Volume that can be traded at Price. For Order Exposure, Matched Volume is zero'
      - id: imbalance_volume
        type: u4
        doc: 'Total number of contracts better than Price (includes Orders that cannot be filled). The Exposed Order size'
      - id: reserved
        type: u4
        doc: 'Reserved for future use'
  complex_auction_notification_message:
    seq:
      - id: seconds
        type: second_timestamp
        doc: 'Seconds portion of the timestamp. Seconds since Midnight epoch'
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: strategy_id
        type: u4
        doc: 'PHLX Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: auction_id
        type: u4
        doc: 'Uniquely identifies the Auction for the trading day. Presently the Auction ID will be zero for non-PIXL auctions'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'Type of Auction:'
      - id: price
        type: decimal_s4_4
        doc: 'Price at which auction is started. For PIXL auctions, price is zero. The price at which an exposed order is available for execution. Implied decimal with scale 1e-4'
      - id: auction_side
        type: u1
        enum: auction_side
        doc: 'Indicates the side of the auction:'
      - id: debit_or_credit
        type: u1
        enum: debit_or_credit
        doc: 'Price Debit or Credit value'
      - id: volume
        type: u4
        doc: 'Total volume available in COLA/PIXL/Solicitation. This field will be 0 under certain conditions for COLA when the strategy is opening'
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
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x44:
      id: 'options_directory_message'
      doc: 'At the start of each trading day, PHLX disseminates directory messages for all symbols trading on the PHLX option system.'
    0x52:
      id: 'complex_order_strategy_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Order Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'security_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of an index or equity option within the PHLX Options Market.'
    0x49:
      id: 'complex_trading_action_message'
      doc: 'PHLX uses this administrative message to indicate the current trading status of a strategy within the PHLX Options Market.'
    0x50:
      id: 'security_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when an option has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x51:
      id: 'strategy_open_closed_message'
      doc: 'PHLX uses this administrative message to indicate when a strategy has completed the opening process or when the strategy has closed and is no longer available for auto execution.'
    0x4f:
      id: 'simple_order_message'
      doc: 'When a Single Order is received or any change is made to an order, an Order message containing the current order status will be sent.'
    0x58:
      id: 'complex_order_message'
      doc: 'When a Complex Order is received or any change is made to a complex order for an underlying, a Complex Order Message containing the order information will be sent.'
    0x41:
      id: 'auction_notification_message'
      doc: 'When a symbol goes into an auction, an Auction Notification Message is sent. Also if any auction parameters change during the auction, size for example, a new Auction Notification message will be sent for that symbol.'
    0x43:
      id: 'complex_auction_notification_message'
      doc: 'When a Complex Order Live Auction (COLA) or PIXL/Solicitation auction starts for a strategy of an underlying, a COLA/PIXL/Solicitation notification message containing the auction information will be sent.'
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
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
    0x20:
      id: 'stock'
      doc: 'Stock'
  option_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
    0x57:
      id: 'wco_early_closing'
      doc: 'Wco Early Closing At 1200 Noon'
  phlx_tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
  action:
    0x41:
      id: 'add'
      doc: 'Add'
    0x44:
      id: 'delete_field'
      doc: 'Delete'
  side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x2a:
      id: 'hidden'
      doc: 'Side Is Hidden'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'phlx_trading_resumed'
      doc: 'Phlx Trading Resumed'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed For Auto Execution'
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
    0x52:
      id: 'renotification'
      doc: 'Renotification'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
    0x2a:
      id: 'anonymous'
      doc: 'Anonymous'
  market_qualifier:
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
      id: 'gtc'
      doc: 'Good Till Cancelled'
    0x49:
      id: 'ioc'
      doc: 'Immediate Or Cancel'
  customer_firm_indicator:
    0x43:
      id: 'customer_order'
      doc: 'Customer Order'
    0x46:
      id: 'firm_order'
      doc: 'Firm Order'
    0x4d:
      id: 'onfloor_market_maker'
      doc: 'Onfloor Market Maker'
    0x42:
      id: 'broker_dealer_order'
      doc: 'Broker Dealer Order'
    0x50:
      id: 'professional_order'
      doc: 'Professional Order'
    0x20:
      id: 'na_for_implied_order'
      doc: 'Na For Implied Order'
  open_close_indicator:
    0x4f:
      id: 'opens_position'
      doc: 'Opens Position'
    0x43:
      id: 'closes_position'
      doc: 'Closes Position'
    0x20:
      id: 'na'
      doc: 'Na For Implied Order'
  debit_or_credit:
    0x44:
      id: 'net_debit'
      doc: 'Net Debit'
    0x43:
      id: 'net_credit'
      doc: 'Net Credit'
    0x20:
      id: 'even_or_market_order'
      doc: 'Even Or Market Order'
    0x2a:
      id: 'anonymous'
      doc: 'Anonymous'
  leg_open_close_indicator:
    0x4f:
      id: 'opens_position'
      doc: 'Opens Position'
    0x43:
      id: 'closes_position'
      doc: 'Closes Position'
    0x20:
      id: 'stock_leg'
      doc: 'Stock Leg'
  auction_type:
    0x43:
      id: 'cola'
      doc: 'Cola'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x52:
      id: 'reopening'
      doc: 'Reopening'
    0x50:
      id: 'pixl'
      doc: 'Pixl'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x49:
      id: 'order_exposure'
      doc: 'Order Exposure'
  auction_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x2a:
      id: 'solicitation_auction'
      doc: 'Solicitation Auction'

