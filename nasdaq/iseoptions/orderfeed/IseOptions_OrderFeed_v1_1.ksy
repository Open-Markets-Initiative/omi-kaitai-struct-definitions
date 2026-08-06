# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq IseOptions OrderFeed Itch v1.1
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Ise Order Feed Market Data
#   Encoding: Itch
#   Version: 1.1
#   Date: 08/23/2017
#   Specification: ISE-GEMX-MRX-Order-Feed-Specification_tcm5044-42717.pdf
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
  id: iseoptions_orderfeed_v1_1
  title: Nasdaq IseOptions OrderFeed Itch v1.1
  license: GPL-3.0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq ISE Ise Order Feed Market Data Itch v1.1'
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
            'message_type::option_directory_message': option_directory_message
            'message_type::trading_action_message': trading_action_message
            'message_type::security_open_closed_message': security_open_closed_message
            'message_type::opening_imbalance_message': opening_imbalance_message
            'message_type::order_on_book_message': order_on_book_message
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
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System Event Code'
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
  option_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
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
      - id: expiration_day
        type: u1
        doc: 'Day of the Month of expiration (1-31)'
      - id: strike_price
        type: decimal_s8_8
        doc: 'Explicit strike price in fixed point format with 12 whole number places followed by 8 decimal digits. Implied decimal with scale 1e-8'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option Type value'
      - id: source
        type: u1
        doc: 'Identifies the source of the option, valid for the trading day'
      - id: underlying_symbol
        type: str
        size: 13
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the unique symbol assigned to the underlying security within the Exchange System'
      - id: trading_type
        type: u1
        enum: trading_type
        doc: 'Indicates what kind of option this is'
      - id: contract_size
        type: u2
        doc: 'Underlying deliverable size'
      - id: option_closing_type
        type: u1
        enum: option_closing_type
        doc: 'Denotes which System Event is used to determine when trading ceases in this symbol'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Denotes whether or not this option is tradable at the exchange'
      - id: mpv
        type: u1
        enum: mpv
        doc: 'Minimum Price Variation for this option'
      - id: closing_only
        type: u1
        enum: closing_only
        doc: 'Closing position of the option'
  trading_action_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: current_trading_state
        type: u1
        enum: current_trading_state
        doc: 'Reflects the current trading state for the options security in the options market'
  security_open_closed_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: open_state
        type: u1
        enum: open_state
        doc: 'Reflects the current eligibility for auto execution of the options security in the options market'
  opening_imbalance_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: paired_contracts
        type: u4
        doc: 'The total number of contracts that are eligible to be matched at the Current Reference Price'
      - id: imbalance_direction
        type: u1
        enum: imbalance_direction
        doc: 'Indicates the market side of the imbalance'
      - id: imbalance_price
        type: decimal_s4_4
        doc: 'The imbalance price in fixed point format with 6 whole number places followed by 4 decimal digits. Implied decimal with scale 1e-4'
      - id: imbalance_volume
        type: u4
        doc: 'The imbalance volume'
  order_on_book_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: order_type
        type: u1
        enum: order_type
        doc: '‘M’ = Market ‘L’ = Limit'
      - id: side
        type: u1
        enum: side
        doc: 'Side value'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order in fixed point format with 6 whole number places followed by 4 decimal digits. For market orders, the price is zero. Hidden prices are set to zero. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Size of the order (zero if hidden)'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: 'Exec Flag value'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity value'
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
  auction_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time, expressed as the number of nanoseconds after midnight. Nanoseconds since Midnight epoch'
      - id: option_id
        type: u4
        doc: 'Option ID for this option, assigned daily, valid for trading day'
      - id: auction_id
        type: u4
        doc: 'Integer which uniquely identifies the auction'
      - id: order_type
        type: u1
        enum: order_type
        doc: '‘M’ = Market ‘L’ = Limit'
      - id: side
        type: u1
        enum: side
        doc: 'Side value'
      - id: price
        type: decimal_s4_4
        doc: 'Price of the order in fixed point format with 6 whole number places followed by 4 decimal digits. For market orders, the price is zero. Hidden prices are set to zero. Implied decimal with scale 1e-4'
      - id: size
        type: u4
        doc: 'Size of the order (zero if hidden)'
      - id: exec_flag
        type: u1
        enum: exec_flag
        doc: 'Exec Flag value'
      - id: order_capacity
        type: u1
        enum: order_capacity
        doc: 'Order capacity value'
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
      - id: num_auction_response
        type: u1
        doc: 'Number of auction Responses. Next two fields repeat that number of times. Allowable values for this field are 0 or 1'
      - id: auction_response
        type: auction_response
        repeat: expr
        repeat-expr: num_auction_response
        doc: 'Auction Response Information'
  auction_response:
    seq:
      - id: response_price
        type: decimal_s4_4
        doc: 'Best price of the auction response in fixed point format with 6 whole number places followed by 4 decimal digits. The response, if shown (zero if not shown) is the best response on the contra side. Implied decimal with scale 1e-4'
      - id: response_size
        type: u4
        doc: 'Best size of the auction response (zero if not shown)'
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
  decimal_s8_8:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000.0
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
      id: 'option_directory_message'
      doc: 'At the start of each trading day, the options system disseminates directory messages for all symbols eligible for trading in the options system.'
    0x48:
      id: 'trading_action_message'
      doc: 'The options system uses this administrative message to indicate the current trading status of an index or equity option within the options market.'
    0x4f:
      id: 'security_open_closed_message'
      doc: 'The options system uses this administrative message to indicate when an option has completed the opening process and is now available for auto execution or when the option has closed and is no longer available for auto execution.'
    0x4e:
      id: 'opening_imbalance_message'
      doc: 'Nasdaq disseminates Opening Imbalance information at regular intervals in the time leading up to the Nasdaq Opening Auction events.'
    0x42:
      id: 'order_on_book_message'
      doc: 'An Order on Book message is generated for all the following situations whenever an order free from any display restrictions is reported by the matching engine.'
    0x41:
      id: 'auction_message'
      doc: 'This message is used to announce auctions. The start of auction is announced, followed by possible updates on the auction, and announcing the end of the auction.'
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
  trading_type:
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x49:
      id: 'index'
      doc: 'Index'
    0x46:
      id: 'etf'
      doc: 'Etf'
    0x43:
      id: 'currency'
      doc: 'Currency'
  option_closing_type:
    0x4e:
      id: 'normal'
      doc: 'Normal Hours'
    0x4c:
      id: 'late'
      doc: 'Late Hours'
  tradable:
    0x59:
      id: 'tradable'
      doc: 'Option Is Tradable'
    0x4e:
      id: 'not_tradable'
      doc: 'Option Is Not Tradable'
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
  closing_only:
    0x59:
      id: 'closing_position_only'
      doc: 'Closing Position Only'
    0x4e:
      id: 'not_closing_position_only'
      doc: 'Not Closing Position Only'
  current_trading_state:
    0x48:
      id: 'halt_in_effect'
      doc: 'Halt In Effect'
    0x54:
      id: 'trading_on_the_options_system'
      doc: 'Trading On The Options System'
  open_state:
    0x59:
      id: 'open_for_auto_execution'
      doc: 'Open For Auto Execution'
    0x4e:
      id: 'closed_for_auto_execution'
      doc: 'Closed For Auto Execution'
  imbalance_direction:
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
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
    0x20:
      id: 'hidden'
      doc: 'Hidden'
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

