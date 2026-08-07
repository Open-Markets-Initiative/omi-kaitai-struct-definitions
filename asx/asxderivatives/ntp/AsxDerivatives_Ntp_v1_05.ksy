# ---------------------------------------------------------------------
# Kaitai struct definition for: Asx AsxDerivatives Ntp Itch v1.05
#
# Protocol:
#   Organization: Australian Securities Exchange
#   Protocol: New Trading Platform
#   Encoding: Itch
#   Version: 1.05
#   Date: 12/01/2017
#   Specification: asx-market-data-protocol-specification.pdf
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
  id: asx_asxderivatives_ntp_itch_v1_05
  title: Asx AsxDerivatives Ntp Itch v1.05
  license: GPL-3.0
  endian: be

doc: 'Australian Securities Exchange Asx Derivatives New Trading Platform Itch v1.05'
doc-ref: https://asxonline.com/public/landing-pages/ntp-document-library.html

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
            'message_type::seconds_message': seconds_message
            'message_type::end_of_business_trade_date_message': end_of_business_trade_date_message
            'message_type::future_symbol_directory_message': future_symbol_directory_message
            'message_type::options_symbol_directory_message': options_symbol_directory_message
            'message_type::combination_symbol_directory_message': combination_symbol_directory_message
            'message_type::bundles_symbol_directory': bundles_symbol_directory
            'message_type::order_book_state_message': order_book_state_message
            'message_type::add_order_message': add_order_message
            'message_type::order_volume_cancelled_message': order_volume_cancelled_message
            'message_type::order_deleted_message': order_deleted_message
            'message_type::order_executed_message': order_executed_message
            'message_type::auction_order_executed_message': auction_order_executed_message
            'message_type::combination_order_executed_message': combination_order_executed_message
            'message_type::implied_order_added_message': implied_order_added_message
            'message_type::implied_order_replaced_message': implied_order_replaced_message
            'message_type::implied_order_deleted_message': implied_order_deleted_message
            'message_type::trade_executed_message': trade_executed_message
            'message_type::combination_trade_executed_message': combination_trade_executed_message
            'message_type::trade_cancellation_message': trade_cancellation_message
            'message_type::equilibrium_price_message': equilibrium_price_message
            'message_type::open_high_low_last_trade_adjustment_message': open_high_low_last_trade_adjustment_message
            'message_type::market_settlement_message': market_settlement_message
            'message_type::text_message': text_message
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
  seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'Unix time (number of seconds since 1970-01-01 00:00:00 UTC). Seconds since Unix epoch'
  end_of_business_trade_date_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Event Code'
  future_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: symbol_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique tradable instrument name'
      - id: long_name
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
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
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of security using ISO 10962 standard, CFI code values'
      - id: expiry_year
        type: u2
        doc: 'Year of expiry (YYYY) for futures contract types, zero otherwise'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Month of expiry for futures contract types, zero otherwise'
      - id: price_display_decimals
        type: u1
        doc: 'Suggested number of decimals to display the price at'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the price to yield the floating point price'
      - id: price_minimum_tick
        type: u4
        doc: 'Minimum tick size. Divide by the Price Fractional Denominator to determine the floating point value'
      - id: last_trading_date
        type: u4
        doc: 'The Last Trading Day as specified in the ASX 24 Contract Specifications. Reported in Unix Time (number of seconds since 00:00 1 January 1970 GMT). Convert to AEST/ADST as appropriate to determine the date'
      - id: prior_day_settlement
        type: decimal_s8_2
        doc: 'Prior Day Settlement price. Divide by the Price Fractional Denominator to determine the floating point value. Implied decimal with scale 1e-2'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency of contract'
      - id: lot_size_or_face_value
        type: u8
        doc: 'The Contract Unit as specified in the ASX 24 Contract Specifications'
      - id: maturity_value
        type: u1
        doc: 'The number of days or years to maturity for bills or bonds as specified in the ASX 24 Contract Specifications'
      - id: coupon_rate
        type: u2
        doc: 'The coupon percentage rate for bonds'
      - id: payments_per_year
        type: u1
        doc: 'Number of payments per year for bonds'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of lots that represent a block lot for the order book'
      - id: expiry_date
        type: u4
        doc: 'The Settlement Date as specified in the ASX 24 Contract Specifications. Reported in Unix Time (number of seconds since 00:00 1 January 1970 GMT). Convert to AEST/ADST as appropriate to determine the date'
  options_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: symbol_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique tradable instrument name'
      - id: long_name
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved for future use'
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
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of security using ISO 10962 standard, CFI code values'
      - id: expiry_year
        type: u2
        doc: 'Year of expiry (YYYY) for futures contract types, zero otherwise'
      - id: expiry_month
        type: u1
        enum: expiry_month
        doc: 'Month of expiry for futures contract types, zero otherwise'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Indicates the type of option'
      - id: strike
        type: decimal_s8_2
        doc: 'Strike price of contract. Divide by the Strike Price Fractional Denominator to determine the floating point value. Implied decimal with scale 1e-2'
      - id: underlying_tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Underlying Tradeable Instrument (can be zero if underlying not defined)'
      - id: price_display_decimals
        type: u1
        doc: 'Suggested number of decimals to display the price at'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the price to yield the floating point price'
      - id: price_minimum_tick
        type: u4
        doc: 'Minimum tick size. Divide by the Price Fractional Denominator to determine the floating point value'
      - id: strike_price_decimal_position
        type: u1
        doc: 'Number of decimals to display the strike price'
      - id: strike_price_fractional_denominator
        type: u4
        doc: 'Denominator of the Strike Price to yield the floating point strike price'
      - id: strike_price_minimum_tick
        type: u4
        doc: 'Minimum tick size for the Strike Price. Divide by the Strike Price Fractional Denominator to determine the floating point value'
      - id: last_trading_date
        type: u4
        doc: 'The Last Trading Day as specified in the ASX 24 Contract Specifications. Reported in Unix Time (number of seconds since 00:00 1 January 1970 GMT). Convert to AEST/ADST as appropriate to determine the date'
      - id: prior_day_settlement
        type: decimal_s8_2
        doc: 'Prior Day Settlement price. Divide by the Price Fractional Denominator to determine the floating point value. Implied decimal with scale 1e-2'
      - id: volatility
        type: u8
        doc: 'Volatility for an option contract'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency of contract'
      - id: lot_size_or_face_value
        type: u8
        doc: 'The Contract Unit as specified in the ASX 24 Contract Specifications'
      - id: maturity_value
        type: u1
        doc: 'The number of days or years to maturity for bills or bonds as specified in the ASX 24 Contract Specifications'
      - id: coupon_rate
        type: u2
        doc: 'The coupon percentage rate for bonds'
      - id: payments_per_year
        type: u1
        doc: 'Number of payments per year for bonds'
      - id: block_lot_size
        type: u4
        doc: 'Indicates the number of lots that represent a block lot for the order book'
      - id: expiry_date
        type: u4
        doc: 'The Settlement Date as specified in the ASX 24 Contract Specifications. Reported in Unix Time (number of seconds since 00:00 1 January 1970 GMT). Convert to AEST/ADST as appropriate to determine the date'
      - id: basis_of_quotation
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Blank filled. Not available for ASX 24 products'
  combination_symbol_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: symbol_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique tradable instrument name'
      - id: long_name
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of security using ISO 10962 standard, CFI code values'
      - id: price_method
        type: u1
        enum: price_method
        doc: 'Pricing method'
      - id: price_display_decimals
        type: u1
        doc: 'Suggested number of decimals to display the price at'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the price to yield the floating point price'
      - id: price_minimum_tick
        type: u4
        doc: 'Minimum tick size. Divide by the Price Fractional Denominator to determine the floating point value'
      - id: legs
        type: u1
        doc: 'Number of legs'
      - id: combination_leg
        type: combination_leg
        repeat: expr
        repeat-expr: 6
        doc: 'Combination Leg'
  combination_leg:
    seq:
      - id: tradeable_instrument_id_leg
        type: u4
        doc: 'Instrument Id of the leg'
      - id: side_leg
        type: u1
        enum: side_leg
        doc: 'Side of the leg'
      - id: ratio_leg
        type: u4
        doc: 'Ratio of the leg'
      - id: price_leg
        type: decimal_s8_2
        doc: 'Price of the leg. Implied decimal with scale 1e-2'
  bundles_symbol_directory:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: symbol_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The unique tradable instrument name'
      - id: long_name
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional instrument series information'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates the type of security using ISO 10962 standard, CFI code values'
      - id: price_method
        type: u1
        enum: price_method
        doc: 'Pricing method'
      - id: price_display_decimals
        type: u1
        doc: 'Suggested number of decimals to display the price at'
      - id: price_fractional_denominator
        type: u4
        doc: 'Denominator of the price to yield the floating point price'
      - id: price_minimum_tick
        type: u4
        doc: 'Minimum tick size. Divide by the Price Fractional Denominator to determine the floating point value'
      - id: legs
        type: u1
        doc: 'Number of legs'
      - id: bundle_leg
        type: bundle_leg
        repeat: expr
        repeat-expr: 20
        doc: 'Bundle Leg'
  bundle_leg:
    seq:
      - id: tradeable_instrument_id_leg
        type: u4
        doc: 'Instrument Id of the leg'
      - id: side_leg
        type: u1
        enum: side_leg
        doc: 'Side of the leg'
      - id: ratio_leg
        type: u4
        doc: 'Ratio of the leg'
      - id: price_leg
        type: decimal_s8_2
        doc: 'Price of the leg. Implied decimal with scale 1e-2'
  order_book_state_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: session_state
        type: u1
        enum: session_state
        doc: 'Indicates the current session state for the contract as per'
  add_order_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: order_book_priority
        type: u8
        doc: 'Time priority of this order within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s8_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  order_volume_cancelled_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
  order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
  order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Nature of the match'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s8_2
        doc: 'Price of trade (may be negative for combination trades). Implied decimal with scale 1e-2'
      - id: combination_trade_id
        type: u8
        doc: 'A non-zero value indicates that this trade is part of an execution cycle for a combination trade'
      - id: counter_party_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the aggressive party to the execution in non-anonymous markets. Space filled for anonymous instruments'
  auction_order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Nature of the match'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s8_2
        doc: 'Price of trade (may be negative for combination trades). Implied decimal with scale 1e-2'
      - id: opposite_order_id
        type: u8
        doc: 'Public Order Id of the order to be removed from the opposite side of the same Order Book id, as order has traded out'
  combination_order_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: quantity_remaining
        type: u4
        doc: 'Volume remaining on Order after matching, if 0, order has traded out and should be deleted'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Nature of the match'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s8_2
        doc: 'Price of trade (may be negative for combination trades). Implied decimal with scale 1e-2'
      - id: opposite_tradeable_instrument_id
        type: u4
        doc: 'Identifier of the opposite Tradeable Instrument Id (references the combination Tradeable Instrument Id party to this trade)'
      - id: opposite_side
        type: u1
        enum: opposite_side
        doc: 'Type of order'
      - id: opposite_order_id
        type: u8
        doc: 'Public Order Id of the order to be removed from the opposite side of the same Order Book id, as order has traded out'
      - id: combination_trade_id
        type: u8
        doc: 'A non-zero value indicates that this trade is part of an execution cycle for a combination trade'
  implied_order_added_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: order_book_priority
        type: u8
        doc: 'Time priority of this order within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s8_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  implied_order_replaced_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
      - id: order_book_priority
        type: u8
        doc: 'Time priority of this order within the order book'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
      - id: price
        type: decimal_s8_2
        doc: 'Price of the order. Implied decimal with scale 1e-2'
  implied_order_deleted_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: side
        type: u1
        enum: side
        doc: 'Type of order'
      - id: order_id
        type: u8
        doc: 'Public order id of the order'
  trade_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Nature of the match'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s8_2
        doc: 'Price of trade (may be negative for combination trades). Implied decimal with scale 1e-2'
      - id: combination_trade_id
        type: u8
        doc: 'A non-zero value indicates that this trade is part of an execution cycle for a combination trade'
      - id: participant_id_buyer
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the owner of the buying order. Blank for anonymous instruments'
      - id: participant_id_seller
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant identifier of the owner of the selling order. Blank for anonymous instruments'
  combination_trade_executed_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Nature of the match'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
      - id: executed_quantity
        type: u4
        doc: 'Volume traded'
      - id: trade_price
        type: decimal_s8_2
        doc: 'Price of trade (may be negative for combination trades). Implied decimal with scale 1e-2'
      - id: buyer_tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Buyers Order Book'
      - id: buyer_side
        type: u1
        enum: buyer_side
        doc: 'Type of order'
      - id: buyer_order_id
        type: u8
        doc: 'Reference number of the Buyer’s order – 0 if order is aggressive'
      - id: buyer_combination_trade_id
        type: u8
        doc: 'A non-zero value indicates that this trade is part of an execution cycle for a combination trade from the E or P message'
      - id: buyer_participant_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buying participant identifier of the owner of the aggressive order'
      - id: seller_tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Seller’s Order Book'
      - id: seller_side
        type: u1
        enum: seller_side
        doc: 'Type of order'
      - id: seller_order_id
        type: u8
        doc: 'Reference number of the Seller’s order – 0 if order is aggressive'
      - id: seller_combination_trade_id
        type: u8
        doc: 'A non-zero value indicates that this trade is part of an execution cycle for a combination trade from the E or P message'
      - id: seller_participant_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Selling participant identifier of the owner of the aggressive order'
  trade_cancellation_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: trade_id
        type: u8
        doc: 'Public trade id of the trade'
  equilibrium_price_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: equilibrium_price
        type: decimal_s8_2
        doc: 'Price at which matching will occur. Implied decimal with scale 1e-2'
      - id: matched_quantity
        type: u8
        doc: 'The indicative auction volume'
      - id: bid_quantity
        type: u8
        doc: 'Total Bid Quantity available for execution'
      - id: ask_quantity
        type: u8
        doc: 'Total Ask Quantity available for execution'
  open_high_low_last_trade_adjustment_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: opening_trade
        type: decimal_s8_2
        doc: 'Opening Traded Price. Implied decimal with scale 1e-2'
      - id: highest_trade
        type: decimal_s8_2
        doc: 'Highest Traded Price. Implied decimal with scale 1e-2'
      - id: lowest_trade
        type: decimal_s8_2
        doc: 'Lowest Traded Price. Implied decimal with scale 1e-2'
      - id: last_trade
        type: decimal_s8_2
        doc: 'Last Traded Price. Implied decimal with scale 1e-2'
      - id: last_volume
        type: u4
        doc: 'Last Traded Volume'
      - id: total_traded_volume
        type: u8
        doc: 'Total Traded Volume'
  market_settlement_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: opening_trade
        type: decimal_s8_2
        doc: 'Opening Traded Price. Implied decimal with scale 1e-2'
      - id: highest_trade
        type: decimal_s8_2
        doc: 'Highest Traded Price. Implied decimal with scale 1e-2'
      - id: lowest_trade
        type: decimal_s8_2
        doc: 'Lowest Traded Price. Implied decimal with scale 1e-2'
      - id: last_trade
        type: decimal_s8_2
        doc: 'Last Traded Price. Implied decimal with scale 1e-2'
      - id: last_volume
        type: u4
        doc: 'Last Traded Volume'
      - id: total_traded_volume
        type: u8
        doc: 'Total Traded Volume'
  text_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: source_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates source of message'
      - id: text
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Message being communicated'
  request_for_quote_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: rfq_side
        type: u1
        enum: rfq_side
        doc: 'Identifies side of the RFQ'
      - id: quantity
        type: u4
        doc: 'Number of lots added to the book (all volume is visible)'
  anomalous_order_threshold_publish_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: aot_price
        type: decimal_s8_2
        doc: 'Anomalous Order Threshold price (AOT). Implied decimal with scale 1e-2'
      - id: aot_upper_price
        type: decimal_s8_2
        doc: 'Upper range of the AOT. Implied decimal with scale 1e-2'
      - id: aot_lower_price
        type: decimal_s8_2
        doc: 'Lower range of the AOT. Implied decimal with scale 1e-2'
      - id: etr_price
        type: decimal_s8_2
        doc: 'Extreme Trade Range price (ETR), if zero, then MIR is not enforced. Implied decimal with scale 1e-2'
      - id: etr_upper_price
        type: decimal_s8_2
        doc: 'Upper range of the ETR. Implied decimal with scale 1e-2'
      - id: etr_lower_price
        type: decimal_s8_2
        doc: 'Lower range of the ETR. Implied decimal with scale 1e-2'
  volume_and_open_interest_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the Nanoseconds, accurate to 1,000 nanoseconds. Nanoseconds since Second epoch'
      - id: trade_date
        type: u2
        doc: 'Trade Date. Represented as number of days since 1 January 1970'
      - id: tradeable_instrument_id
        type: u4
        doc: 'Identifier of the Order Book'
      - id: cumulative_volume
        type: u8
        doc: 'Volume traded for the specified VOI Trade Date'
      - id: open_interest
        type: u8
        doc: 'Number of open contracts at EOD for the specified VOI Trade Date'
      - id: voi_trade_date
        type: u2
        doc: 'Trade Date the VOI information is applicable to'
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
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x54:
      id: 'seconds_message'
      doc: 'A ‘seconds’ Nanoseconds is issued every second and any message thereafter will be stamped with the number of nanoseconds past the last Time message received as a time reference point'
    0x53:
      id: 'end_of_business_trade_date_message'
      doc: 'This message will be sent as the last message for a Business Trade Date to signal no further messages will be disseminated for that date.'
    0x66:
      id: 'future_symbol_directory_message'
      doc: 'The Future Symbol Directory message describes futures contract'
    0x68:
      id: 'options_symbol_directory_message'
      doc: 'The Options Symbol Directory message describes options and warrants contracts.'
    0x4d:
      id: 'combination_symbol_directory_message'
      doc: 'The Combination Symbol Directory is a specialised reference data message used for defining combinations with up to 6 legs. It represents both standard combinations defined by ASX and user defined combinations created by participants'
    0x6d:
      id: 'bundles_symbol_directory'
      doc: 'The Bundles Symbol Directory is a specialised reference data message used for defining combinations with legs greater than 6, specifically Bundle products with legs of 8, 12, 16 or 20 legs'
    0x4f:
      id: 'order_book_state_message'
      doc: 'This message indicates the current session state of a contract to the market'
    0x41:
      id: 'add_order_message'
      doc: 'An Order Added message indicates a new order or a restated order that has been accepted by the matching engine and added to the order book'
    0x58:
      id: 'order_volume_cancelled_message'
      doc: 'An Order Volume Cancelled message is sent when an order is modified as a result of partial cancellation of volume'
    0x44:
      id: 'order_deleted_message'
      doc: 'This message is sent whenever an order in the book is cancelled by the owner, expired, cancelled by the exchange, purged or volume cancelled'
    0x45:
      id: 'order_executed_message'
      doc: 'This message is sent whenever a resting order of the book is executed in whole or in part and the counterparty to the trade is an aggressive order'
    0x43:
      id: 'auction_order_executed_message'
      doc: 'This message is sent when orders are executed in the auction at the open of the market'
    0x65:
      id: 'combination_order_executed_message'
      doc: 'This message is sent whenever a resting order is matched with an open leg of a resting combination order in whole or in part'
    0x6a:
      id: 'implied_order_added_message'
      doc: 'This message is a similar format to the Order Added message, except the nature of this order is it has an implied price, implied volume and a priority that is derived from two or more “real” orders deriving the implied price'
    0x6c:
      id: 'implied_order_replaced_message'
      doc: 'This message notifies the subscriber that an existing implied order is to be replaced when the implied price, volume or priority has changed due to a price or volume movement of “real” orders for a side of a single Tradeable Instrument Id'
    0x6b:
      id: 'implied_order_deleted_message'
      doc: 'This message is sent whenever the implied pricing or volume has changed due to price or volume movement of “real” orders for a side of a single contract number. When received, any implied volume is no longer accessible so the “implied” order of the indicated side must be removed from the book'
    0x50:
      id: 'trade_executed_message'
      doc: 'The Trade Message is designed to provide details for executions in combination order books. Trade Executed messages are reported in the same sequence as order execution messages are reported'
    0x70:
      id: 'combination_trade_executed_message'
      doc: 'The Combination Trade Executed Message is designed to provide details for executions where one or both orders are resting from a different order book id from the order book id of the trade'
    0x42:
      id: 'trade_cancellation_message'
      doc: 'This message is sent whenever a trade is cancelled by ASX'
    0x5a:
      id: 'equilibrium_price_message'
      doc: 'This message is disseminated in response to changes in the equilibrium price for an order book during a pre-open period'
    0x74:
      id: 'open_high_low_last_trade_adjustment_message'
      doc: 'Market trade price adjustments are sent resulting from modifications of Open, High, Low, Last and volume statistics due to market operations, prior to the instrument moving to the next session within the trade date, or at the close of instrument'
    0x59:
      id: 'market_settlement_message'
      doc: 'This message disseminates the final settlement price of a future or option contracts order book for the trade date it pertains to'
    0x78:
      id: 'text_message'
      doc: 'This message disseminates free text information describing ad-hoc market events'
    0x71:
      id: 'request_for_quote_message'
      doc: 'This message is disseminated for anonymous Request for Quotes (RFQs) from the market'
    0x57:
      id: 'anomalous_order_threshold_publish_message'
      doc: 'This message disseminates price band information to the market advising the setting, zeroing or adjusting of the Extreme Trade Range price, the Anomalous Order Threshold price and the associated ranges for a contract that requires Market Integrity Rules enforcement'
    0x56:
      id: 'volume_and_open_interest_message'
      doc: 'This message disseminates Volume and Open Interest (VOI) information for each trade date'
  event_code:
    0x43:
      id: 'business_trade_date_has_ended'
      doc: 'Business Trade Date Has Ended'
  expiry_month:
    1:
      id: 'jan'
      doc: 'Jan'
    2:
      id: 'feb'
      doc: 'Feb'
    3:
      id: 'mar'
      doc: 'Mar'
    4:
      id: 'apr'
      doc: 'Apr'
    5:
      id: 'may'
      doc: 'May'
    6:
      id: 'jun'
      doc: 'Jun'
    7:
      id: 'jul'
      doc: 'Jul'
    8:
      id: 'aug'
      doc: 'Aug'
    9:
      id: 'sep'
      doc: 'Sep'
    10:
      id: 'oct'
      doc: 'Oct'
    11:
      id: 'nov'
      doc: 'Nov'
    12:
      id: 'dec'
      doc: 'Dec'
  option_type:
    0x50:
      id: 'put'
      doc: 'Put'
    0x43:
      id: 'call'
      doc: 'Call'
  price_method:
    0:
      id: 'net_price'
      doc: 'Leg Ratios Are Used To Calculate The Net Price'
    2:
      id: 'yield_difference'
      doc: 'Leg Ratios Greater Than 1 Do Not Affect The Net Price Calculation'
    3:
      id: 'individual'
      doc: 'First Leg Is Fixed Price Remaining Legs Are Net Price'
    4:
      id: 'average_price'
      doc: 'Legs Are Same Side Ie Bid Buys All Legs Or Ask Sells All Legs'
  side_leg:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  session_state:
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opened'
      doc: 'Opened'
    0x52:
      id: 'regulatory_halt'
      doc: 'Regulatory Halt'
    0x48:
      id: 'halted'
      doc: 'Halted'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x4d:
      id: 'maintenance'
      doc: 'Maintenance'
  side:
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x42:
      id: 'buy'
      doc: 'Buy Order'
  trade_type:
    0x54:
      id: 'normal_trade'
      doc: 'An Outright To Outright Trade'
    0x74:
      id: 'normal_cross'
      doc: 'An Outright To Outright Cross'
    0x4c:
      id: 'auction_trade'
      doc: 'Trade Price May Be Different Than Price Of Resting Order'
    0x6c:
      id: 'auction_cross'
      doc: 'Trade Price May Be Different Than Price Of Resting Order'
    0x53:
      id: 'combination_to_underlying_trade'
      doc: 'Price Is Based On The Order Price Of An Underlying Order Book Relating To Intraspread Interspread Or User Defined Combination Matching With An Outright Order'
    0x73:
      id: 'combination_to_underlying_cross'
      doc: 'Price Is Based On The Order Price Of An Underlying Order Book Relating To Intraspread Interspread Or User Defined Combination Matching With An Outright Order'
    0x52:
      id: 'combination_to_combination_trade'
      doc: 'Trade Price Is Based On The Current Indicative Pricing From The Underlying Order Book'
    0x72:
      id: 'combination_to_combination_cross'
      doc: 'Cross Price Is Based On The Current Indicative Pricing From The Underlying Order Book'
    0x41:
      id: 'strip_to_strip_trade'
      doc: 'Indicates An Average Price Type Combination Order Has Matched With Another Average Price Type Combination Order'
    0x61:
      id: 'strip_to_strip_cross'
      doc: 'Indicates An Average Price Type Combination Order Has Matched With Another Average Price Type Combination Order'
    0x42:
      id: 'strip_to_outright_trade'
      doc: 'Indicates An Average Price Type Combination Order Has Matched With An Outright Order'
    0x62:
      id: 'strip_to_outright_cross'
      doc: 'Indicates An Average Price Type Combination Order Has Matched With An Outright Order'
  opposite_side:
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x42:
      id: 'buy'
      doc: 'Buy Order'
  buyer_side:
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x42:
      id: 'buy'
      doc: 'Buy Order'
  seller_side:
    0x53:
      id: 'sell'
      doc: 'Sell Order'
    0x42:
      id: 'buy'
      doc: 'Buy Order'
  rfq_side:
    0x54:
      id: 'two_sided_quote'
      doc: 'Two Sided Quote'
    0x42:
      id: 'bid_quote'
      doc: 'Bid Quote'
    0x53:
      id: 'ask_quote'
      doc: 'Ask Quote'
    0x58:
      id: 'crossing'
      doc: 'Crossing'

