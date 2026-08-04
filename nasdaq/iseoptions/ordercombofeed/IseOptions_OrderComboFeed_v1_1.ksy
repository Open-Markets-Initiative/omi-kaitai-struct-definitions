# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions OrderComboFeed Itch v1.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ise Order Combo Market Data Feed
#   Encoding: Itch
#   Version: 1.1
#   Date: 06/13/2017
#   Specification: ISEOrderComboFeedSpecification_tcm5044-41354.pdf
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
# The Binary Data Compiler technologies used to produce this file
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
  id: iseoptions_ordercombofeed_v1_1
  title: Nasdaq IseOptions OrderComboFeed Itch v1.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Ise Order Combo Market Data Feed Itch v1.1'
doc-ref: https://business.nasdaq.com/trade/US-Options/Technical-Specifications.html

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
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
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::complex_strategy_directory_message': complex_strategy_directory_message
            'message_type::strategy_trading_action_message': strategy_trading_action_message
            'message_type::strategy_open_closed_message': strategy_open_closed_message
            'message_type::complex_strategy_order_on_book_message': complex_strategy_order_on_book_message
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
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Refer to System Event Codes below'
      - id: current_year
        type: u2
        doc: 'The current calendar year (example: 2016)'
      - id: current_month
        type: u1
        doc: 'The current calendar month, with values 1 to 12 inclusive, January=1, etc'
      - id: current_day
        type: u1
        doc: 'The current calendar day, with values 1 to 31 inclusive'
      - id: version
        type: u1
        doc: 'Version of this interface. Currently set to 1'
      - id: subversion
        type: u1
        doc: 'Sub-version of this interface. Currently set to 0'
  complex_strategy_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: strategy_type
        type: u1
        enum: strategy_type
        doc: 'StrategyType value'
      - id: source
        type: u1
        doc: 'Identifies the source of the Strategy, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Symbol for the strategy. All legs in this strategy belong to this Underlying'
      - id: num_leg_information
        type: u1
        doc: 'Number of legs in the strategy NOTE: Leg field offsets below are an equation, where “n” is the zero based leg number (0, 1, …)'
      - id: leg_information
        type: leg_information
        repeat: expr
        repeat-expr: num_leg_information
        doc: 'Leg information'
  leg_information:
    seq:
      - id: option_id
        type: u4
        doc: 'ISE’s Option ID for this leg, valid for the trading day. The same ID as the corresponding Option in the Options Directory Message. Zero (0) for Stock Leg'
      - id: security_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the option root symbol (security symbol)'
      - id: leg_id
        type: u1
        doc: 'Leg identifier within this strategy. This is an exchange-assigned 0-based index. E.g. Nth leg has LegId=N-1'
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
        type: s8
        doc: 'Denotes the explicit strike price of the option. Refer to Data Types for field processing notes. Implied decimal with scale 1e-8'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type:'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Indicates the side of the leg'
      - id: leg_ratio
        type: u4
        doc: 'Leg Ratio'
  strategy_trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the strategy on the ISE market'
  strategy_open_closed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security in the options market'
  complex_strategy_order_on_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: side
        type: u1
        enum: side
        doc: '‘B’ = Bid ‘A’ = Offer (Ask) ‘ ’ (blank) = not set (hidden)'
      - id: price
        type: s4
        doc: 'Price of the order in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Size of the order'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: '‘N’ = None ‘A’ = AON'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity value'
      - id: scope
        type: u1
        enum: scope
        doc: 'Scope value'
      - id: owner_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
      - id: giveup
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
      - id: cmta
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
  complex_strategy_auction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: strategy_id
        type: u4
        doc: 'ISE’s Strategy ID assigned daily, valid while there are any open complex orders for the day'
      - id: auction_id
        type: u4
        doc: 'Integer which uniquely identifies the auction'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order Type'
      - id: side
        type: u1
        enum: side
        doc: '‘B’ = Bid ‘A’ = Offer (Ask) ‘ ’ (blank) = not set (hidden)'
      - id: price
        type: s4
        doc: 'Price of the order in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Size of the order'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: '‘N’ = None ‘A’ = AON'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order Capacity value'
      - id: scope
        type: u1
        enum: scope
        doc: 'Scope value'
      - id: owner_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
      - id: giveup
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
      - id: cmta
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spaces when not set'
      - id: auction_event
        type: u1
        enum: auction_event
        doc: '‘S’ = Start ‘U’ = Auction Update ‘E’ = End of Auction'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: '‘E’ = Exposure ‘C’ = Facilitation ‘S’ = Solicitation ‘P’ = PIM'
      - id: num_auction_response
        type: u1
        doc: 'Number of auction Responses. Next two fields repeat that number of times. Allowable values for this field are 0 or 1'
      - id: auction_response
        type: auction_response
        repeat: expr
        repeat-expr: num_auction_response
        doc: 'Auction Response information'
  auction_response:
    seq:
      - id: response_price
        type: s4
        doc: 'Price of the auction response in fixed point format with 6 whole number places followed by 4 decimal digits. The response, if shown (zero if not shown) is the best response on the contra side. Implied decimal with scale 1e-4'
      - id: response_size
        type: u4
        doc: 'Size of the auction response (zero if not shown)'
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
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'The system event message type is used to signal a market or data feed handler event.'
    0x52:
      id: 'complex_strategy_directory_message'
      doc: 'Whenever a complex order is added in the system for an underlying, the order is normalized and results in either the creation of a new complex strategy or is added to an existing strategy. A Complex Strategy Message containing the strategy definition will be sent.'
    0x48:
      id: 'strategy_trading_action_message'
      doc: 'ISE uses this administrative message to indicate the current trading status of a strategy within the ISE Options Market.'
    0x4f:
      id: 'strategy_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when an strategy has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x4c:
      id: 'complex_strategy_order_on_book_message'
      doc: 'An Order on Book message is generated for all the following situations whenever an order free from any display restrictions is reported by the matching engine. In all such cases the order size to be displayed is as reported by the matching engine'
    0x4a:
      id: 'complex_strategy_auction_message'
      doc: 'This message is used to announce strategy auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'
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
    0x55:
      id: 'custom'
      doc: 'Custom'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call Option'
    0x50:
      id: 'put'
      doc: 'Put Option'
    0x20:
      id: 'stock'
      doc: 'Stock Leg'
  leg_side:
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
      id: 'trading_resumed'
      doc: 'Trading Resumed'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed For Auto Execution'
  order_type:
    0x4d:
      id: 'market'
      doc: 'Market'
    0x4c:
      id: 'limit'
      doc: 'Limit'
  side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'offer_ask'
      doc: 'Offer Ask'
    0x20:
      id: 'hidden'
      doc: 'Hidden'
  exec_flag:
    0x4e:
      id: 'none'
      doc: 'None'
    0x41:
      id: 'aon'
      doc: 'Aon'
  order_capacity:
    0x43:
      id: 'customer'
      doc: 'Customer'
    0x44:
      id: 'customer_professional'
      doc: 'Customer Professional'
    0x46:
      id: 'firm'
      doc: 'Firm'
    0x42:
      id: 'broker_dealer_customer'
      doc: 'Broker Dealer Customer'
    0x4b:
      id: 'broker_dealer_firm'
      doc: 'Broker Dealer Firm'
    0x45:
      id: 'proprietary'
      doc: 'Proprietary'
    0x4e:
      id: 'away_market_maker'
      doc: 'Away Market Maker'
    0x4d:
      id: 'market_maker'
      doc: 'Market Maker'
  scope:
    0x4c:
      id: 'local'
      doc: 'Local'
    0x4e:
      id: 'national'
      doc: 'National'
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
  auction_type:
    0x45:
      id: 'exposure'
      doc: 'Exposure'
    0x43:
      id: 'facilitation'
      doc: 'Facilitation'
    0x53:
      id: 'solicitation'
      doc: 'Solicitation'
    0x50:
      id: 'pim'
      doc: 'Pim'

