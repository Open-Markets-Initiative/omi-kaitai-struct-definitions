# ---------------------------------------------------------------------
# Kaitai struct definition for: Asx AsxDerivatives T24 Itch v1.13
#
# Protocol:
#   Organization: Australian Securities Exchange
#   Protocol: 24 Itch
#   Encoding: Itch
#   Version: 1.13
#   Date: 07/15/2014
#   Specification: T24ITCH_External_Message_Specification_V1.13.pdf
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
  id: asx_asxderivatives_t24_itch_v1_13
  title: Asx AsxDerivatives T24 Itch v1.13
  license: GPL-3.0
  endian: be

doc: 'Australian Securities Exchange Asx Derivatives 24 Itch Itch v1.13'

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
        type: session
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  session:
    seq:
      - id: protocol_version
        type: str
        size: 3
        encoding: ASCII
        doc: 'T24 identifies the ASX Trade24 Trading System'
      - id: session_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Year in format YY'
      - id: session_week
        type: str
        size: 2
        encoding: ASCII
        doc: 'WW is the week of the year (week of 1st of January is week 1)'
      - id: trading_service
        type: str
        size: 3
        encoding: ASCII
        doc: 'A Trading Service session number from 001-999'
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
            'message_type::time_message': time_message
            'message_type::system_event_message': system_event_message
            'message_type::future_symbol_directory_message': future_symbol_directory_message
            'message_type::spread_symbol_directory_message': spread_symbol_directory_message
            'message_type::option_symbol_directory_message': option_symbol_directory_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::order_added_message': order_added_message
            'message_type::order_replaced_message': order_replaced_message
            'message_type::order_volume_cancelled_message': order_volume_cancelled_message
            'message_type::order_deleted_message': order_deleted_message
            'message_type::implied_order_added_message': implied_order_added_message
            'message_type::implied_order_replaced_message': implied_order_replaced_message
            'message_type::implied_order_deleted_message': implied_order_deleted_message
            'message_type::custom_market_order_added_message': custom_market_order_added_message
            'message_type::custom_market_order_replaced_message': custom_market_order_replaced_message
            'message_type::custom_market_order_deleted_message': custom_market_order_deleted_message
            'message_type::order_executed_message': order_executed_message
            'message_type::order_executed_with_price_message': order_executed_with_price_message
            'message_type::spread_executed_message': spread_executed_message
            'message_type::trade_spread_execution_chain_message': trade_spread_execution_chain_message
            'message_type::custom_market_executed_message': custom_market_executed_message
            'message_type::custom_market_trade_message': custom_market_trade_message
            'message_type::trade_cancellation_message': trade_cancellation_message
            'message_type::equilibrium_price_auction_info_message': equilibrium_price_auction_info_message
            'message_type::open_high_low_last_trade_adjustment_message': open_high_low_last_trade_adjustment_message
            'message_type::market_settlement_message': market_settlement_message
            'message_type::ad_hoc_text_message': ad_hoc_text_message
            'message_type::request_for_quote_message': request_for_quote_message
            'message_type::anomalous_order_threshold_publish_message': anomalous_order_threshold_publish_message
            'message_type::volume_and_open_interest_message': volume_and_open_interest_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  time_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Second message will be disseminated for every second change where there is at least one payload message. Seconds since Unix epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'See System Event Code Explanation below'
  future_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: exchange
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the exchange identifier of the contract'
      - id: instrument
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the instrument identifier of the contract'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Indicates the type of contract'
      - id: expiry_year
        type: u2
        doc: 'Year of expiry (YYYY) for Contract Type “F”, zero otherwise'
      - id: expiry_month
        type: u1
        doc: 'Month of expiry for Contract Types, zero otherwise'
      - id: price_decimal_position
        type: u1
        doc: 'Position of the decimal point in the price'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the fractional part'
      - id: price_minimum_tick
        type: u2
        doc: 'Minimum tick size'
      - id: last_trading_date
        type: u4
        doc: 'Last Trading Date and Time. Applicable to Contract Types “F” only, zero otherwise. Note where the time is defined, it is local time AEST or ADST depending if the expiry date is during AEST or ADST'
      - id: prior_day_settlement
        type: decimal_s4_2
        doc: 'Prior Day Settlement price. Implied decimal with scale 1e-2'
      - id: financial_type
        type: u1
        enum: financial_type
        doc: 'Indicates the how to valuate a contract'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency of contract'
      - id: lot_size_or_face_value
        type: u4
        doc: 'Size of each lot or face value of each lot'
      - id: maturity_value
        type: u1
        doc: 'Number of days or years to maturity for bills or bonds, Financial Type is “X” or “B”'
      - id: coupon_rate
        type: u2
        doc: 'Implied 2 decimal value indicating the coupon rate for bonds, e.g. 1234=12.34%, Financial Type is “X” only'
      - id: payments_per_year
        type: u1
        doc: 'Number payments per year for bonds, Financial Type is “X” only'
  spread_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: exchange
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the exchange identifier of the contract'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Indicates the type of contract'
      - id: first_leg_contract_number
        type: u4
        doc: 'Underlying Contract Number Field Element Identifier of the first contract leg'
      - id: second_leg_contract_number
        type: u4
        doc: 'Underlying Contract Number Field Element Identifier of the second contract leg'
      - id: primary_ratio
        type: u1
        doc: 'Ratio of the first contract leg'
      - id: secondary_ratio
        type: u1
        doc: 'Ratio of the second contract leg'
      - id: price_decimal_position
        type: u1
        doc: 'Position of the decimal point in the price'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the fractional part'
      - id: price_minimum_tick
        type: u2
        doc: 'Minimum tick size'
  option_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: exchange
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the exchange identifier of the contract'
      - id: instrument
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the instrument identifier of the contract'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Indicates the type of contract'
      - id: expiry_year
        type: u2
        doc: 'Year of expiry (YYYY) for Contract Type “F”, zero otherwise'
      - id: expiry_month
        type: u1
        doc: 'Month of expiry for Contract Types, zero otherwise'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Indicates the type of option “P” – Put Option or “C” – Call Option'
      - id: strike
        type: u4
        doc: 'Strike price of contract'
      - id: underlying_contract_number
        type: u4
        doc: 'Underlying Future Contract Number (zero if Contract Type “E”)'
      - id: price_decimal_position
        type: u1
        doc: 'Position of the decimal point in the price'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the fractional part'
      - id: price_minimum_tick
        type: u2
        doc: 'Minimum tick size'
      - id: strike_price_decimal_position
        type: u1
        doc: 'Position of the decimal point in the price'
      - id: strike_price_fractional_denominator
        type: u4
        doc: 'Denominator of the fractional part'
      - id: strike_price_minimum_tick
        type: u2
        doc: 'Minimum tick size for the Strike Price'
      - id: last_trading_date
        type: u4
        doc: 'Last Trading Date and Time. Applicable to Contract Types “F” only, zero otherwise. Note where the time is defined, it is local time AEST or ADST depending if the expiry date is during AEST or ADST'
      - id: prior_day_settlement
        type: decimal_s4_2
        doc: 'Prior Day Settlement price. Implied decimal with scale 1e-2'
      - id: volatility
        type: u4
        doc: 'Implied 3 decimal volatility for an option, i.e. 12345 is 12.345%'
      - id: financial_type
        type: u1
        enum: financial_type
        doc: 'Indicates the how to valuate a contract'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency of contract'
      - id: lot_size_or_face_value
        type: u4
        doc: 'Size of each lot or face value of each lot'
      - id: maturity_value
        type: u1
        doc: 'Number of days or years to maturity for bills or bonds, Financial Type is “X” or “B”'
      - id: coupon_rate
        type: u2
        doc: 'Implied 2 decimal value indicating the coupon rate for bonds, e.g. 1234=12.34%, Financial Type is “X” only'
      - id: payments_per_year
        type: u1
        doc: 'Number payments per year for bonds, Financial Type is “X” only'
      - id: activated
        type: u1
        enum: activated
        doc: 'For single session options only, “Y” indicates strike is active or is activated, “N” indicates strike is inactive or is deactivated'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Indicates the current session state for the contract'
  order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  order_volume_cancelled_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
  order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
  implied_order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  implied_order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  implied_order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
  custom_market_order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: legs
        type: u1
        doc: 'Number of legs'
      - id: contract_legs
        type: contract_legs
        repeat: expr
        repeat-expr: 6
        doc: 'Contract Legs'
  contract_legs:
    seq:
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: ratio
        type: u2
        doc: 'Volume Ratio of this leg'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  custom_market_order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: order_book_priority
        type: u4
        doc: 'Time priority within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
  custom_market_order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
  order_executed_with_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: buying_order_number
        type: u8
        doc: 'Buyer’s Reference number of order'
      - id: buyer_quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0 order has traded out and should be deleted'
      - id: selling_order_number
        type: u8
        doc: 'Seller''s Reference number of order'
      - id: seller_quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0 order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
  spread_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
      - id: traded_contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier of the underlying Order Book Traded'
      - id: spread_trade_price
        type: decimal_s4_2
        doc: 'If a spread-to-spread trade, this will be set to the spread price. Implied decimal with scale 1e-2'
      - id: trade_side_of_leg
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '‘B’ – Order Leg is Buyer, ‘S’ – Order Leg is Seller'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays: “N” = non-printable or “Y” = printable'
  trade_spread_execution_chain_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: buyer
        type: u4
        doc: 'Buyer Contract Number Field Element Identifier'
      - id: side_of_buyer
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side of order: “B” – Buy Order, “S” – Sell Order'
      - id: buyer_order_number
        type: u8
        doc: 'Buyer’s Reference number of order'
      - id: buyer_quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0 order has traded out and should be deleted'
      - id: seller_contract_number
        type: u4
        doc: 'Seller’s Contract Number Field Element Identifier'
      - id: side_of_seller
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side of order: “B” – Buy Order, “S” – Sell Order'
      - id: selling_order_number
        type: u8
        doc: 'Seller''s Reference number of order'
      - id: seller_quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0 order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
      - id: traded_contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier of the underlying Order Book Traded'
      - id: spread_trade_price
        type: decimal_s4_2
        doc: 'If a spread-to-spread trade, this will be set to the spread price. Implied decimal with scale 1e-2'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays: “N” = non-printable or “Y” = printable'
  custom_market_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
      - id: traded_contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier of the underlying Order Book Traded'
      - id: trade_side_of_leg
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '‘B’ – Order Leg is Buyer, ‘S’ – Order Leg is Seller'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays: “N” = non-printable or “Y” = printable'
  custom_market_trade_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order: “B” – Buy Order, “S” – Sell Order'
      - id: order_number
        type: u8
        doc: 'Order number assigned by Matching Engine'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: custom_market_order_number
        type: u8
        doc: 'Custom Market Order Reference number of order'
      - id: custom_market_quantity_remaining
        type: u4
        doc: 'Volume remaining on custom market order after matching. If zero, custom market order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Trade Type Explanation'
      - id: match_number
        type: u4
        doc: 'Deal Number'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s4_2
        doc: 'Price of Trade. Implied decimal with scale 1e-2'
      - id: traded_contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier of the underlying Order Book Traded'
      - id: trade_side_of_non_custom_order
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Side of non-custom order: “B” – is the Buyer, “S” – is the Seller'
      - id: printable
        type: u1
        enum: printable
        doc: 'Indicates if the execution should be reflected on time and sale displays: “N” = non-printable or “Y” = printable'
  trade_cancellation_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: match_number
        type: u4
        doc: 'Deal Number'
  equilibrium_price_auction_info_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: equilibrium_price
        type: decimal_s4_2
        doc: 'Price at which matching will occur. Implied decimal with scale 1e-2'
      - id: best_bid_price
        type: decimal_s4_2
        doc: 'Best Bid Price. Implied decimal with scale 1e-2'
      - id: best_ask_price
        type: decimal_s4_2
        doc: 'Best Ask Price. Implied decimal with scale 1e-2'
      - id: best_bid_quantity
        type: u4
        doc: 'Best Bid Volume'
      - id: best_ask_quantity
        type: u4
        doc: 'Best Ask Volume'
  open_high_low_last_trade_adjustment_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: opening_trade
        type: decimal_s4_2
        doc: 'Opening Traded Price. Implied decimal with scale 1e-2'
      - id: highest_trade
        type: decimal_s4_2
        doc: 'Highest Traded Price. Implied decimal with scale 1e-2'
      - id: lowest_trade
        type: decimal_s4_2
        doc: 'Lowest Traded Price. Implied decimal with scale 1e-2'
      - id: last_trade
        type: decimal_s4_2
        doc: 'Last Traded Price. Implied decimal with scale 1e-2'
      - id: last_volume
        type: u4
        doc: 'Last Traded Volume'
      - id: total_traded_volume
        type: u4
        doc: 'Total Traded Volume'
      - id: total_trades
        type: u4
        doc: 'Total Number of Trades'
      - id: market_updates
        type: market_updates
        doc: 'Bitwise flags indicating which fields have been adjusted'
  market_updates:
    seq:
      - id: opening_trade_price
        type: b1
        doc: 'Has Opening Trade Price Changed'
      - id: highest_traded_price
        type: b1
        doc: 'Has Highest Traded Price Changed'
      - id: lowest_traded_price
        type: b1
        doc: 'Has Lowest Traded Price Changed'
      - id: total_traded_volume_and_total_trades
        type: b1
        doc: 'Has Total Traded Volume and Total Trades Changed'
      - id: last_traded_price
        type: b1
        doc: 'Has Last Traded Price Changed'
      - id: last_traded_volume
        type: b1
        doc: 'Last Traded Volume'
      - id: all_fields
        type: b2
        doc: 'All Fields'
  market_settlement_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: settlement_price
        type: decimal_s4_2
        doc: 'Settlement Price as indicated by Settlement Type. Implied decimal with scale 1e-2'
      - id: volatility
        type: u4
        doc: 'Implied 3 decimal volatility for an option, i.e. 12345 is 12.345%'
      - id: settlement_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlement Type'
  ad_hoc_text_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: source_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates source of message'
      - id: text_message
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Text message'
  request_for_quote_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: price
        type: decimal_s4_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
  anomalous_order_threshold_publish_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: aot_price
        type: decimal_s4_2
        doc: 'Anomalous Order Threshold price (AOT). Implied decimal with scale 1e-2'
      - id: aot_upper_price
        type: decimal_s4_2
        doc: 'Upper range of the AOT. Implied decimal with scale 1e-2'
      - id: aot_lower_price
        type: decimal_s4_2
        doc: 'Lower range of the AOT. Implied decimal with scale 1e-2'
      - id: etr_price
        type: decimal_s4_2
        doc: 'Extreme Trade Range price (ETR); if zero, MIR is not enforced. Implied decimal with scale 1e-2'
      - id: etr_upper_price
        type: decimal_s4_2
        doc: 'Upper range of the ETR. Implied decimal with scale 1e-2'
      - id: etr_lower_price
        type: decimal_s4_2
        doc: 'Lower range of the ETR. Implied decimal with scale 1e-2'
  volume_and_open_interest_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date of event as applicable, if Event Code is “P” or “R”, applies to all active trade dates'
      - id: contract_number
        type: u4
        doc: 'Contract Number Field Element Identifier'
      - id: cumulative_volume
        type: u4
        doc: 'Volume traded or cleared for the specified VOI trade date'
      - id: open_interest
        type: u4
        doc: 'Number of open contracts at end of day for the specified VOI trade date'
      - id: voi_trade_date
        type: u2
        doc: 'Trade date to which the VOI information applies'
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
  decimal_s4_2:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x54:
      id: 'time_message'
      doc: 'The server will, on each packet multicast, transmit this message for every second for which at least one application message is generated'
    0x53:
      id: 'system_event_message'
      doc: 'The system event message is used to signal a market or trading period event.'
    0x66:
      id: 'future_symbol_directory_message'
      doc: 'As each product moves to the new Trade Date, ASX Trade24 will disseminate the future symbol messages defining the available futures, CFDs and Share Future contracts for each instrument. The action of disseminating this message will automatically imply the contract is in a “Pending” session state.'
    0x67:
      id: 'spread_symbol_directory_message'
      doc: 'As each product moves to the new Trade Date, ASX Trade24 will disseminate the spread symbol messages defining the available calendar spread and inter-spread contracts. For contracts that are inter-spreads, the underlying legs are in the same Trade Date.'
    0x68:
      id: 'option_symbol_directory_message'
      doc: 'As each product moves to the new Trade Date, ASX Trade24 will disseminate the option symbol messages defining all the available options contracts. For Single Session Options only, the exchange can activate or de-activate option symbols during the course of trading by issuing Order Book State messages for affected option contracts. If an option symbol is not active (Activated field is ‘N’) or is de-activated (Trading Status is “I”), reference to that option contract should be removed from the list of actively traded contracts. If an option symbol is active (Activated field is ‘Y’) or is activated (Trading Status is “A”), reference to that option contract should be added to the list of actively traded contracts.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'ASX Trade24 uses this message to indicate the current session state of a contract to the market.'
    0x41:
      id: 'order_added_message'
      doc: 'An Order Added message indicates a new order has been accepted by the ASX Trade24 system and was added to the order book. All orders in ASX Trade24 are anonymous and one “Add” type is supported for “real” orders that are not custom market orders. The message is referenced by an Order Number assigned by ASX Trade24 and is unique for the life of the order.'
    0x55:
      id: 'order_replaced_message'
      doc: 'This message is sent whenever an order in the book has been modified for price or volume where the priority changes. Even though the side and contract number cannot be changed, these fields are included in the message to provide fast look-up.'
    0x58:
      id: 'order_volume_cancelled_message'
      doc: 'This message is sent whenever an order in the book is modified as a result of a partial cancellation of volume. The difference between this message and the Order Replaced is an Order Replaced will always show a change of order book priority in regards to the order’s position in the queue. An Order Volume Cancelled message is not sent when an order has partially traded.'
    0x44:
      id: 'order_deleted_message'
      doc: 'This message is sent whenever an order in the book is cancelled by the owner, expired, cancelled by the exchange, purged or volume cancelled. All remaining volume is no longer accessible so the order must be removed from the book.'
    0x6a:
      id: 'implied_order_added_message'
      doc: 'This message is the same format as the Order Added message, except the nature of this order is it has an implied price, implied volume and a priority that is derived from two or more spreadable “real” orders.'
    0x6c:
      id: 'implied_order_replaced_message'
      doc: 'This message is the same format as the Order Replaced message, except this replacement refers to an implied order and is sent whenever the implied pricing or volume has changed due to a price or volume movement of “real” orders for a side of a single contract number.'
    0x6b:
      id: 'implied_order_deleted_message'
      doc: 'This message is the same format as the Order Deleted message, except this deletion refers to an implied order. When received, any implied volume is no longer accessible so the “implied” order of the indicated side must be removed from the book.'
    0x6d:
      id: 'custom_market_order_added_message'
      doc: 'Any resting Custom Market Order that trades will be reported using the Custom Market Executed or Custom Market Trade message.'
    0x6e:
      id: 'custom_market_order_replaced_message'
      doc: 'This message is sent whenever an order in the custom market book has been modified for volume. Custom market order modification messages always include the Order Number of the Custom Market Order Added to which the update applies. To determine the current display volume for an order, subscribers must replace the original volume stated in the Custom Market Order Added message with the quantity stated in the Custom Market Order Replaced message of the same order number.'
    0x72:
      id: 'custom_market_order_deleted_message'
      doc: 'This message is sent whenever an order in the custom market book is cancelled by the owner, expired, cancelled by the exchange or purged. All remaining volume is no longer accessible so the order must be removed from the book. A Custom Market Order Deleted message is not sent when an order has traded out.'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever a resting order of the book is executed in whole or in part where the price and contract number of the order and trade are the same. It is possible to receive several Order Executed messages for the same order reference number if that order is executed in several parts.'
    0x43:
      id: 'order_executed_with_price_message'
      doc: 'This message is sent whenever two resting orders of the same contract are executed. This can occur in two circumstances: During levelling in whole or in part at a price that could be different from one or both resting order prices.'
    0x65:
      id: 'spread_executed_message'
      doc: 'This message is sent whenever the open leg of a resting spread order is traded in whole or in part where the price and the contract number will be different than the traded contract number. It is possible to receive several Spread Executed messages for the same order number if that order is executed in several parts.'
    0x50:
      id: 'trade_spread_execution_chain_message'
      doc: 'This message is sent whenever two resting orders of different contracts are executed in whole or in part at a price different from the initial display price(s) such as sweeping or spreading orders. Since the execution price is different than the display price of the original Add Order, a trade price field is included within the execution message.'
    0x75:
      id: 'custom_market_executed_message'
      doc: 'This message is sent whenever the open leg of a resting custom market order is traded in whole or in part.'
    0x70:
      id: 'custom_market_trade_message'
      doc: 'This message is sent whenever a resting custom market order is matched with a resting non-custom market order executed in whole or in part at a price that could be different from the initial display price(s) such as spreading orders. Since the execution price could be different than the display price of the original Order Added, a trade price field is included within the execution message.'
    0x42:
      id: 'trade_cancellation_message'
      doc: 'This message is sent whenever a trade is cancelled by exchange operations. This message does not affect any resting orders and is more for Information purposes. Adjustments to the Open, High, Low, Last will be performed as separate action using the Open, High, Low, Last Trade Adjustment message.'
    0x5a:
      id: 'equilibrium_price_auction_info_message'
      doc: 'ASX Trade24 disseminates equilibrium prices during a price discovery period. As orders are added, modified, cancelled or deleted a message will be reported informing the market the potential opening price.'
    0x74:
      id: 'open_high_low_last_trade_adjustment_message'
      doc: 'ASX Trade24 disseminates market trade price adjustments where the exchange operator modifies the open, high, low, last, last volume, total traded volume or total number of trades (usually due to a trade cancellation) or the product resets the open, high, low, last, last volume when it moves to the next session within the trade date. Each price is re-distributed with the Market Updates bitwise flags indicating which fields have been adjusted. This message is also issued during a snapshot download to enable the requestor to generate an up-to-date market image without having to regenerate from previous trades and market trade adjustment messages.'
    0x59:
      id: 'market_settlement_message'
      doc: 'ASX Trade24 disseminates settlement prices for all future and option contracts in two instalments, an interim and then a final. When the contract moves to the next trade date, the Future Symbol Directory or Option Symbol Directory message will reflect the final settlement price reported from the previous trade date in the prior day settlement field.'
    0x78:
      id: 'ad_hoc_text_message'
      doc: 'ASX Trade24 disseminates text messages to inform the market of ad hoc events.'
    0x71:
      id: 'request_for_quote_message'
      doc: 'ASX Trade24 disseminates anonymous non-custom RFQs from the market.'
    0x57:
      id: 'anomalous_order_threshold_publish_message'
      doc: 'ASX Trade24 reports this message to inform the market of setting, zeroing or adjusting the Extreme Trade Range price (ETR), the Anomalous Order Threshold price (AOT) and the associated ranges for a contract that requires Market Integrity Rules enforcement.'
    0x56:
      id: 'volume_and_open_interest_message'
      doc: 'ASX Trade24 disseminates volume and open interest information for each trade date. The VOI Trade Date indicates the trade date to which the information applies.'
  event_code:
    0x4f:
      id: 'open'
      doc: 'New Trade Date Is Opening'
    0x53:
      id: 'start'
      doc: 'Messages Will Start For This Trade Date'
    0x43:
      id: 'end'
      doc: 'Trade Date Has Ended'
    0x50:
      id: 'paused'
      doc: 'System Is Paused Note Applies To All Trade Dates'
    0x52:
      id: 'resumed'
      doc: 'System Is Resumed Note Applies To All Trade Dates'
  contract_type:
    0x46:
      id: 'cfut'
      doc: 'Future Or Forward Contract Cfut'
    0x4f:
      id: 'copta'
      doc: 'Regular Option Contract Copta'
    0x45:
      id: 'eopta'
      doc: 'Equity Option Contract Eopta'
    0x4e:
      id: 'oopt'
      doc: 'Single Session Option Oopt'
    0x53:
      id: 'csprd'
      doc: 'Calendar Or Intra Spread Contract Csprd'
    0x41:
      id: 'sprd'
      doc: 'Arbitrage Or Inter Spread Contract Sprd'
    0x44:
      id: 'sfut'
      doc: 'Equity Cfd Or Share Future Sfut'
  financial_type:
    0x43:
      id: 'commodity'
      doc: 'Commodity Product'
    0x44:
      id: 'cfd'
      doc: 'Cfd Product'
    0x45:
      id: 'equity'
      doc: 'Equity Product'
    0x58:
      id: 'government_bond'
      doc: 'Government Bond Product'
    0x42:
      id: 'bank_bill'
      doc: 'Bank Bill Product'
  option_type:
    0x50:
      id: 'put'
      doc: 'Put Option'
    0x43:
      id: 'call'
      doc: 'Call Option'
  activated:
    0x59:
      id: 'yes_field'
      doc: 'Strike Is Active'
    0x4e:
      id: 'no_field'
      doc: 'Strike Is Inactive'
  trading_status:
    0x70:
      id: 'pending'
      doc: 'Pending'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x50:
      id: 'pre_open'
      doc: 'Pre Open Or First Price Discovery'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x6c:
      id: 'levelling'
      doc: 'Levelling'
    0x4c:
      id: 'locked'
      doc: 'Locked'
    0x4f:
      id: 'opened'
      doc: 'Opened'
    0x55:
      id: 'unavailable'
      doc: 'End Lock Or Unavailable'
    0x64:
      id: 'pre_price_discovery'
      doc: 'Pre Price Discovery'
    0x49:
      id: 'inactive'
      doc: 'Inactive Or Deactivated Single Session Option'
    0x44:
      id: 'price_discovery'
      doc: 'Price Discovery A Subsequent Price Discovery'
    0x41:
      id: 'activated'
      doc: 'Activated Or Reactivated Single Session Option'
    0x52:
      id: 'regulatory_halt'
      doc: 'Regulatory Halt An Ad Hoc Price Discovery'
  side:
    0x53:
      id: 'sell'
      doc: 'Sell Side'
    0x42:
      id: 'buy'
      doc: 'Buy Side'
  trade_type:
    0x54:
      id: 'normal'
      doc: 'Normal Trade Trade Price Matches Both Order Prices'
    0x74:
      id: 'crossing_normal'
      doc: 'Crossing Normal Trade Trade Price Matches Both Order Prices'
    0x57:
      id: 'sweeping'
      doc: 'Sweeping Trade Trade Price Matches Resting Order'
    0x77:
      id: 'crossing_sweeping'
      doc: 'Crossing Sweeping Trade Trade Price Matches Resting Order'
    0x4c:
      id: 'levelling'
      doc: 'Levelling Trade Trade Price May Be Different Than Price Of Resting Orders'
    0x6c:
      id: 'crossing_levelling'
      doc: 'Crossing Levelling Trade Trade Price May Be Different Than Price Of Resting Orders'
    0x53:
      id: 'spread_to_underlying'
      doc: 'Spreadto Underlying Trade Price Is Based On The Order Of The Underlying Future Relating To Intra Inter Or Custom Matching With An Outright Order'
    0x73:
      id: 'crossing_spread_to_underlying'
      doc: 'Crossing Spreadto Underlying Trade Price Is Based On The Order Of The Underlying Future Relating To Intra Inter Or Custom Matching With An Outright Order'
    0x52:
      id: 'intra_spread'
      doc: 'Intra Spreadto Intra Spread Trade Price Is Based On The Near Contracts Prior Day Settlement'
    0x72:
      id: 'crossing_intra_spread'
      doc: 'Crossing Intra Spreadto Intra Spread Trade Price Is Based On The Near Contracts Prior Day Settlement'
    0x51:
      id: 'inter_spread'
      doc: 'Inter Spreadto Inter Spread Trade Price Is Based On The Secondarys Contracts Prior Day Settlement'
    0x71:
      id: 'crossing_inter_spread'
      doc: 'Crossing Inter Spreadto Inter Spread Trade Price Is Based On The Secondarys Contracts Prior Day Settlement'
    0x55:
      id: 'custom'
      doc: 'Customto Custom Trade'
    0x75:
      id: 'crossing_custom'
      doc: 'Crossing Customto Custom Trade'
  printable:
    0x59:
      id: 'yes_field'
      doc: 'Printable'
    0x4e:
      id: 'no_field'
      doc: 'Non Printable'

