# ---------------------------------------------------------------------
# Kaitai struct definition for: Asx AsxSecurities Mdf Itch v1.0
#
# Protocol:
#   Organization: Australian Securities Exchange
#   Protocol: Trade Market Data Feed
#   Encoding: Itch
#   Version: 1.0
#   Date: 3/1/2026
#   Specification: asx-trade-mdf-message-specification.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: asx_asxsecurities_mdf_itch_v1_0
  title: Asx AsxSecurities Mdf Itch v1.0
  license: MIT-0
  endian: be

doc: 'Australian Securities Exchange Asx Securities Trade Market Data Feed Itch v1.0'
doc-ref: https://www.asxonline.com/public/documents/asx-trade-technical-library.html

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
            'message_type::order_book_directory_message': order_book_directory_message
            'message_type::exchange_directory_message': exchange_directory_message
            'message_type::market_directory_message': market_directory_message
            'message_type::combination_order_book_leg_directory_message': combination_order_book_leg_directory_message
            'message_type::tick_size_table_entry_message': tick_size_table_entry_message
            'message_type::corporate_action_entry_message': corporate_action_entry_message
            'message_type::order_book_directory_extension_message': order_book_directory_extension_message
            'message_type::system_event_message': system_event_message
            'message_type::order_book_state_message': order_book_state_message
            'message_type::business_date_message': business_date_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::equilibrium_price_message': equilibrium_price_message
            'message_type::market_by_price_message': market_by_price_message
            'message_type::trade_statistics_message': trade_statistics_message
            'message_type::reference_price_message': reference_price_message
            'message_type::index_message': index_message
            'message_type::open_interest_message': open_interest_message
            'message_type::trade_ticker_message': trade_ticker_message
            'message_type::price_limits_message': price_limits_message
            'message_type::market_announcement_message': market_announcement_message
            'message_type::end_of_snapshot_message': end_of_snapshot_message
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
  order_book_directory_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: partition_id
        type: u1
        doc: 'Is always zero'
      - id: symbol
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Orderbook symbol'
      - id: long_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Human-readable long name of orderbook'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code identifying security'
      - id: asset_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Is currently always set to N/A'
      - id: financial_product
        type: u1
        enum: financial_product
        doc: 'Financial product'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading currency'
      - id: number_of_decimals_in_price
        type: u2
        doc: 'This value defines the number of decimals used in price for this order book'
      - id: number_of_decimals_in_nominal_value
        type: u2
        doc: 'This value defines the number of decimals in Nominal Value'
      - id: round_lot_size
        type: u4
        doc: 'Indicates the quantity that represents a round lot for the issue'
      - id: nominal_value
        type: u8
        doc: 'Nominal value'
      - id: number_of_legs
        type: u1
        doc: 'Number of legs. Only applicable for combination instruments'
      - id: commodity_code
        type: u4
        doc: 'ID of the Underlying instrument (Underlying Order Book ID)'
      - id: strike_price
        type: decimal_s8_4
        doc: 'Only applicable for derivative instruments. Implied decimal with scale 1e-4'
      - id: expiration_date
        type: yyyymmdd_date
        doc: 'Date of expiration. 0 for instruments that do not have an Expiration date'
      - id: number_of_decimals_in_strike_price
        type: u2
        doc: 'This value defines the number of decimals used in Strike Price for this order book'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Option type'
      - id: market_id
        type: u4
        doc: 'Market ID'
      - id: exchange_id
        type: u4
        doc: 'Exchange code'
      - id: number_of_decimals_in
        type: u2
        doc: 'Currently not in use'
      - id: sector_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sector Code (Currently set to N/A)'
      - id: number_of_tradable_equities
        type: u8
        doc: 'The number of shares/equities held by all shareholders (Currently set to 0)'
      - id: number_of_outstanding_equities
        type: u8
        doc: 'The number of shares/equities available for trading at the exchange, also called floating shares (Currently set to 0)'
      - id: last_traded_date
        type: yyyymmdd_date
        doc: 'This is the last date the asset can be traded'
      - id: contract_multiplier
        type: u8
        doc: 'The number of Underlying Assets one unit of the derivatives contract is based on'
      - id: multiplier
        type: u8
        doc: 'Specifies the ratio or multiply factor used to convert from contracts to shares'
      - id: decimals_in_multiplier
        type: u2
        doc: 'The number of decimals used for Multiplier or Contract Multiplier'
      - id: min_order_quantity
        type: u8
        doc: 'For ASX this will be set to 1'
      - id: max_order_quantity
        type: u8
        doc: 'For ASX this is the Max value for the field'
      - id: number_of_settlement_days
        type: u4
        doc: 'The number of settlement days applicable for trades in this order book'
      - id: primary
        type: u1
        enum: primary
        doc: 'Primary Order Book'
      - id: test_order_book
        type: u1
        enum: test_order_book
        doc: 'Test Order Book'
      - id: alias_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Alias name of orderbook. The Square Bracket Value from the LongName'
      - id: settlement_date
        type: yyyymmdd_date
        doc: 'The settlement date'
      - id: tradable
        type: u1
        enum: tradable
        doc: 'Tradable'
      - id: externally_price_sourced
        type: u1
        enum: externally_price_sourced
        doc: 'Indicates if the Item is externally priced'
      - id: deliverable
        type: u1
        enum: deliverable
        doc: 'Defines if a series can be delivered or not (cash settlement)'
      - id: price_unit
        type: u1
        enum: price_unit
        doc: 'Price unit'
      - id: issuer
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer of underlying'
      - id: foreign_ownership_restriction
        type: u1
        enum: foreign_ownership_restriction
        doc: 'Foreign ownership restriction. Incorporated outside country'
      - id: last_trading_time
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Used in conjunction with Last Traded Date. Set to null if no Last Trading time'
      - id: option_style
        type: u1
        enum: option_style
        doc: 'The Execution Style'
      - id: minimum_value_for_initial_trade_report
        type: u8
        doc: 'The required minimum trade value for initial trade reports'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currently it is set to blank. 6 Letter Code in line with the ISO Standard for Classification of Financial Instruments'
      - id: upper_level_series
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Upper-Level series. Only populated for instruments that have an Underlying'
      - id: upper_series_level_order_book_id
        type: u4
        doc: 'The Order Book ID of the Upper-Level series. Zero otherwise'
      - id: instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The four-letter instrument Type'
      - id: status
        type: u1
        enum: status
        doc: 'Status of the Instrument'
  exchange_directory_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: exchange_id
        type: u4
        doc: 'Exchange code'
      - id: exchange_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exchange Name'
  market_directory_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: market_id
        type: u4
        doc: 'Market ID'
      - id: market_name
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Name'
      - id: market_type
        type: u1
        enum: market_type
        doc: 'Market type'
      - id: index_market
        type: u1
        enum: index_market
        doc: 'Indicates if the market is an Index Market'
  combination_order_book_leg_directory_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: combination_order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: leg_order_book_id
        type: u4
        doc: 'Order book ID of Leg instrument'
      - id: leg_side
        type: u1
        enum: leg_side
        doc: 'Leg side'
      - id: leg_ratio
        type: u4
        doc: 'Leg ratio'
  tick_size_table_entry_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: tick_size
        type: u8
        doc: 'Tick Size for the give price range'
      - id: price_from
        type: decimal_s8_4
        doc: 'Start of price range for this entry. Always set to 4 decimals. Implied decimal with scale 1e-4'
      - id: price_to
        type: decimal_s8_4
        doc: 'End of price range for this entry. Zero (0) means infinity. Implied decimal with scale 1e-4'
  corporate_action_entry_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: corporate_action_id
        type: u4
        doc: 'Identifier of a Corporate Action. (Currently set to 0)'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: corporate_action_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The name of the CA Code (Appendix 1)'
      - id: corporate_action_type
        type: u1
        enum: corporate_action_type
        doc: 'The type of the CA Code'
      - id: start_date
        type: yyyymmdd_date
        doc: 'The first date the CA is active. (Currently set to 0)'
      - id: end_date
        type: yyyymmdd_date
        doc: 'The last date the CA is active. (Currently set to 0)'
      - id: record_date
        type: yyyymmdd_date
        doc: 'The record date for the CA. Informational field only. (Currently set to 0)'
      - id: corporate_action_status
        type: u1
        enum: corporate_action_status
        doc: 'Corporate action status'
      - id: action
        type: u1
        doc: 'Currently set to 0. This field will be used in future releases'
  order_book_directory_extension_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: accrued_interest_rounding
        type: u4
        doc: 'Accrued interest rounding decimals'
      - id: accrued_interest_updown
        type: u1
        enum: accrued_interest_updown
        doc: 'Accrued interest up/down'
      - id: calculation_convention
        type: u1
        enum: calculation_convention
        doc: 'Calculation Convention'
      - id: clean_price_rounding
        type: u4
        doc: 'Clean price rounding decimals'
      - id: clean_price_updown
        type: u1
        enum: clean_price_updown
        doc: 'Clean price up/down'
      - id: coupon_frequency
        type: u4
        doc: 'Number of coupons per year'
      - id: coupon_interest
        type: u8
        doc: 'Coupon interest for the underlying. Only applicable for interest related underlyings'
      - id: coupon_from_date
        type: yyyymmdd_date
        doc: 'Dated date. Contains the date of the underlying from when the coupon interest is calculated'
      - id: issue_date
        type: yyyymmdd_date
        doc: 'Contains the issue date of the underlying if it has a limited lifetime'
      - id: maturity_date
        type: yyyymmdd_date
        doc: 'Contains the maturity date of the underlying if it has a limited lifetime'
      - id: day_calculation_rule
        type: u1
        enum: day_calculation_rule
        doc: 'Day Calculation Rule'
      - id: day_count_convention
        type: u1
        enum: day_count_convention
        doc: 'Day Count Convention'
      - id: ex_coupon_period
        type: yyyymmdd_date
        doc: 'Ex coupon period'
      - id: dividend
        type: u8
        doc: 'The dividend for the stock'
      - id: fixed_income_type
        type: u1
        enum: fixed_income_type
        doc: 'Type of fixed income security'
      - id: rate_determination_days
        type: u4
        doc: 'Specifies number of rate determination days'
      - id: yield_convention
        type: u4
        doc: 'Yield convention. Number of months'
      - id: end_of_month_count_convention
        type: u4
        enum: end_of_month_count_convention
        doc: 'End of month count convention'
      - id: first_settlement_date
        type: yyyymmdd_date
        doc: 'First settlement date in YYYYMMDD format'
      - id: coupon_div_date
        type: yyyymmdd_date
        doc: 'Coupon date for bond underlying or dividend date for stock underlying'
      - id: date_books_close
        type: yyyymmdd_date
        doc: 'Books close date for bond underlying'
      - id: effective_expiration_date
        type: yyyymmdd_date
        doc: 'The effective expiration date is the actual expiration date of the series'
      - id: proceed_date
        type: yyyymmdd_date
        doc: 'Proceed date for fixed income underlying'
      - id: set_end_consideration
        type: u1
        enum: set_end_consideration
        doc: 'End consideration'
      - id: set_start_consideration
        type: u1
        enum: set_start_consideration
        doc: 'Start consideration'
  system_event_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'System event code'
  order_book_state_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the Order Book State'
      - id: display_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'The display name of the state'
  business_date_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: business_date
        type: yyyymmdd_date
        doc: 'Today''s Business Date'
  instrument_status_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: trading_state_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the State. NoState means the previous state at Instrument Series level or Underlying Level has been removed'
      - id: instrument_state_level
        type: u1
        enum: instrument_state_level
        doc: 'Instrument state level'
      - id: name_of_the_instrument_state_level
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the applicable Instrument State level'
      - id: start_date
        type: yyyymmdd_date
        doc: 'The first date the CA is active. (Currently set to 0)'
      - id: start_time
        type: hhmmss_time
        doc: 'Start Time. Leading zeros are removed in this field'
  equilibrium_price_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: available_bid_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the bid side'
      - id: available_ask_quantity_at_equilibrium_price
        type: u8
        doc: 'Quantity at equilibrium price on the ask side'
      - id: equilibrium_price
        type: decimal_s8_4
        doc: 'Equilibrium Price. Implied decimal with scale 1e-4'
      - id: best_bid_price
        type: decimal_s8_4
        doc: 'Best Bid Price. Implied decimal with scale 1e-4'
      - id: best_ask_price
        type: decimal_s8_4
        doc: 'Best Ask Price. Implied decimal with scale 1e-4'
      - id: best_bid_quantity
        type: u8
        doc: 'Best Bid Quantity'
      - id: best_ask_quantity
        type: u8
        doc: 'Best Ask Quantity'
      - id: equilibrium_quantity
        type: u8
        doc: 'The tradable quantity at equilibrium price'
  market_by_price_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: maximum_level
        type: u1
        doc: 'The maximum price level. Price levels above Maximum Level shall be deleted by a consumer'
      - id: num_array_of_level_items
        type: u1
        doc: 'The number of times the item fields below are repeated'
      - id: array_of_level_items
        type: array_of_level_items
        repeat: expr
        repeat-expr: num_array_of_level_items
        doc: 'Array of Level items'
  array_of_level_items:
    seq:
      - id: level_update_action
        type: u1
        enum: level_update_action
        doc: 'Type of market update action'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: level
        type: u1
        doc: 'The numeric order of the price level, where 1 is the first price level'
      - id: price
        type: decimal_s8_4
        doc: 'Price. Implied decimal with scale 1e-4'
      - id: quantity
        type: u8
        doc: 'Quantity'
      - id: number_of_deletes
        type: u1
        doc: 'Number of Levels deleted in this update. Used for a Price Delete Item'
      - id: number_of_orders
        type: u8
        doc: 'Number of orders at this level'
  trade_statistics_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: open_price
        type: decimal_s8_4
        doc: 'Open price of the Order Book. Implied decimal with scale 1e-4'
      - id: high_price
        type: decimal_s8_4
        doc: 'Highest price of the Order Book during the current day. Implied decimal with scale 1e-4'
      - id: low_price
        type: decimal_s8_4
        doc: 'Lowest price of the Order Book during the current day. Implied decimal with scale 1e-4'
      - id: last_price
        type: decimal_s8_4
        doc: 'Last Traded price. Implied decimal with scale 1e-4'
      - id: last_auction_price
        type: decimal_s8_4
        doc: 'Last Auction price. Implied decimal with scale 1e-4'
      - id: last_quantity
        type: u8
        doc: 'Quantity of last trade'
      - id: turnover_quantity
        type: u8
        doc: 'Calculated as sum of Traded Quantity. Includes Reported Trades Quantity'
      - id: reported_trades_turnover_quantity
        type: u8
        doc: 'Calculated as sum of Reported Trades Quantity'
      - id: turnover_value
        type: u8
        doc: 'Calculated as sum of Traded Price * Traded Quantity'
      - id: number_of_trades
        type: u8
        doc: 'The total number of trades'
      - id: trend_indicator
        type: u1
        enum: trend_indicator
        doc: 'Trend indicator'
  reference_price_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: price_type
        type: u1
        enum: price_type
        doc: 'Type of price published'
      - id: price
        type: decimal_s8_4
        doc: 'Price. Implied decimal with scale 1e-4'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time (in UTC) when the Price was updated (if available). Nanoseconds since Unix epoch'
      - id: price_date
        type: yyyymmdd_date
        doc: 'The date of the price. Implemented as the date of the updated time stamp in Local time'
  index_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: last_price
        type: decimal_s8_4
        doc: 'Last Traded price. Implied decimal with scale 1e-4'
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'The time (in UTC) when the Price was updated (if available). Nanoseconds since Unix epoch'
      - id: change_previous
        type: u4
        doc: 'Change since previous'
      - id: change_yesterday
        type: u4
        doc: 'Change since yesterday'
      - id: trend_indicator
        type: u1
        enum: trend_indicator
        doc: 'Trend indicator'
      - id: point_of_movement
        type: u4
        doc: 'Number of points of movement'
  open_interest_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: open_interest
        type: u8
        doc: 'Open interest'
      - id: transact_time
        type: u8
        doc: 'Currently set to -9223372036854775808 (minimum value of an 8 byte signed integer)'
  trade_ticker_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: deal_id
        type: u8
        doc: 'Deal identifier'
      - id: deal_source
        type: u1
        enum: deal_source
        doc: 'Deal source'
      - id: price
        type: decimal_s8_4
        doc: 'Price. Implied decimal with scale 1e-4'
      - id: quantity
        type: u8
        doc: 'Quantity'
      - id: deal_time
        type: nanosecond_timestamp
        doc: 'Nano seconds since Epoch. Nanoseconds since Unix epoch'
      - id: action
        type: u1
        enum: action
        doc: 'Currently set to 0. This field will be used in future releases'
      - id: aggressor
        type: u1
        enum: aggressor
        doc: 'Aggressor side'
      - id: trade_report_type
        type: u2
        doc: '0 (zero) indicates not a trade report'
      - id: printable
        type: u1
        enum: printable
        doc: 'Printable'
      - id: as_of_date
        type: yyyymmdd_date
        doc: 'As of Date if populated, else zero'
      - id: boq_list
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Corporate action codes. May be null filled'
      - id: participant_id_buy
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID of participant on Buy side if public. Null otherwise'
      - id: order_id_buy
        type: u8
        doc: 'ID of order on buy side if public. Zero otherwise'
      - id: participant_id_sell
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Participant ID of participant on Sell side if public. Null otherwise'
      - id: order_id_sell
        type: u8
        doc: 'ID of order on sell side if public. Zero otherwise'
      - id: trade_slip_number
        type: u4
        doc: 'TSN'
      - id: exchange_order_type
        type: u4
        enum: exchange_order_type
        doc: 'Exchange Order Type'
      - id: trade_condition
        type: u1
        enum: trade_condition
        doc: 'Trade Condition'
  price_limits_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: upper_limit
        type: decimal_s8_4
        doc: 'The Upper Price Limit. Min Long Value means limit is removed/no limits. Implied decimal with scale 1e-4'
      - id: lower_limit
        type: decimal_s8_4
        doc: 'The Lower Price Limit. Min Long Value means limit is removed/no limits. Implied decimal with scale 1e-4'
      - id: type_field
        type: u1
        enum: type_field
        doc: 'Limit type'
      - id: category
        type: u1
        enum: category
        doc: 'Limit category'
      - id: reference_price
        type: decimal_s8_4
        doc: 'The reference price used for the calculated static or dynamic Price limits. Implied decimal with scale 1e-4'
  market_announcement_message:
    seq:
      - id: timestamp_nanoseconds
        type: nanosecond_offset
        doc: 'Nanoseconds portion of the timestamp. Nanoseconds since Second epoch'
      - id: order_book_id
        type: u4
        doc: 'Denotes the primary identifier of an order book'
      - id: exchange_id
        type: u4
        doc: 'Exchange code'
      - id: market_id
        type: u4
        doc: 'Market ID'
      - id: message_information_type
        type: u1
        enum: message_information_type
        doc: 'Kind of message sent in announcement'
      - id: message_source
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'A description of the source of the message, e.g. the market control'
      - id: message_priority
        type: u1
        enum: message_priority
        doc: 'Message priority'
      - id: header
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Header of the message'
      - id: items_url
        type: u1
        doc: 'Characters in Document URL link'
      - id: document_url
        type: str
        size: 255
        encoding: ASCII
        pad-right: 0x20
        doc: 'The URL link where more information may be found, typically a document'
      - id: num_array_of_message_items
        type: u1
        doc: 'The number of message items in the following array. A maximum of 10 items may be used'
      - id: number_of_messages_items
        type: u1
        doc: 'Duplicate field of Number of Message Items. Not used for current encoding'
      - id: array_of_message_items
        type: array_of_message_items
        repeat: expr
        repeat-expr: num_array_of_message_items
        doc: 'Array of Message items'
      - id: commodity_code
        type: u4
        doc: 'ID of the Underlying instrument (Underlying Order Book ID)'
  array_of_message_items:
    seq:
      - id: message_item
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'A row in the message'
  end_of_snapshot_message:
    seq:
      - id: snapshot_sequence_number
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'MDF SoupBin TCP sequence number when the snapshot was taken, in ASCII'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  hhmmss_time:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 10000 % 100
      minute:
        value: time / 100 % 100
      second:
        value: time % 100
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
    0x54:
      id: 'seconds_message'
      doc: 'Sent every second for which at least one MDF message is being generated.'
    0x52:
      id: 'order_book_directory_message'
      doc: 'Disseminated at the start of each trading day for all active securities, including halted securities.'
    0x65:
      id: 'exchange_directory_message'
      doc: 'Disseminated at the start of each trading day for all active Exchanges in the system.'
    0x6d:
      id: 'market_directory_message'
      doc: 'Disseminated at the start of each trading day for all active Markets in the system.'
    0x4d:
      id: 'combination_order_book_leg_directory_message'
      doc: 'Provides a mapping between a combination order book and one of the combination leg order books.'
    0x4c:
      id: 'tick_size_table_entry_message'
      doc: 'Contains information on a tick size for a price range.'
    0x43:
      id: 'corporate_action_entry_message'
      doc: 'Displays the entries of assigned Corporate Action Codes to Order Books.'
    0x66:
      id: 'order_book_directory_extension_message'
      doc: 'Provides additional information that are valid only for Fixed Income instruments; sent for all instruments.'
    0x53:
      id: 'system_event_message'
      doc: 'Used to signal a market or data feed handler event.'
    0x4f:
      id: 'order_book_state_message'
      doc: 'Relays information on state changes.'
    0x42:
      id: 'business_date_message'
      doc: 'Relays information on the current business date.'
    0x67:
      id: 'end_of_recovery_message'
      doc: 'Received when a recovery is done and it has reached the end.'
    0x74:
      id: 'instrument_status_message'
      doc: 'Received when the State of an Instrument is changed at any of the applicable levels.'
    0x5a:
      id: 'equilibrium_price_message'
      doc: 'Used when auctions occur; provides the changes in equilibrium price.'
    0x62:
      id: 'market_by_price_message'
      doc: 'Publishes order book Prices per Price level.'
    0x49:
      id: 'trade_statistics_message'
      doc: 'Publishes Trade Statistics per Orderbook ID for the current Trading Day.'
    0x51:
      id: 'reference_price_message'
      doc: 'Publishes Reference Prices per Price Types.'
    0x4a:
      id: 'index_message'
      doc: 'Used for sending index price information.'
    0x68:
      id: 'open_interest_message'
      doc: 'Publishes Open Interest.'
    0x69:
      id: 'trade_ticker_message'
      doc: 'Publishes Trade Ticker.'
    0x6b:
      id: 'price_limits_message'
      doc: 'Provides an update to the price limits or circuit breaker limits for an order book.'
    0x4e:
      id: 'market_announcement_message'
      doc: 'Publishes Market Announcements for Order Books, Markets, Underlyings or Exchanges.'
    0x47:
      id: 'end_of_snapshot_message'
      doc: 'Returns the current MDF sequence number to be used when connecting to the MDF feed (Glimpse).'
  financial_product:
    0:
      id: 'not_applicable'
      doc: 'Not applicable'
    1:
      id: 'option'
      doc: 'Option'
    2:
      id: 'forward'
      doc: 'Forward'
    3:
      id: 'future'
      doc: 'Future'
    4:
      id: 'fra'
      doc: 'FRA'
    5:
      id: 'cash'
      doc: 'Cash'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'exchange_rate'
      doc: 'Exchange Rate'
    8:
      id: 'interest_rate_swap'
      doc: 'Interest Rate Swap'
    9:
      id: 'repo'
      doc: 'REPO'
    10:
      id: 'synthetic_box_leg_reference'
      doc: 'Synthetic Box Leg/Reference'
    11:
      id: 'standard_combination'
      doc: 'Standard Combination'
    12:
      id: 'guarantee'
      doc: 'Guarantee'
    13:
      id: 'otc_general'
      doc: 'OTC General'
    14:
      id: 'equity_warrant'
      doc: 'Equity Warrant'
    15:
      id: 'security_lending'
      doc: 'Security Lending'
  option_type:
    0:
      id: 'undefined'
      doc: 'Put or Call is undefined for the order book'
    1:
      id: 'call'
      doc: 'Call'
    2:
      id: 'put'
      doc: 'Put'
  primary:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  test_order_book:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  tradable:
    1:
      id: 'yes_field'
      doc: 'Yes'
    0:
      id: 'no_field'
      doc: 'No'
  externally_price_sourced:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  deliverable:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  price_unit:
    1:
      id: 'yield_field'
      doc: 'Yield'
    2:
      id: 'price'
      doc: 'Price'
    3:
      id: 'points'
      doc: 'Points'
    4:
      id: 'yield_difference'
      doc: 'Yield difference'
    5:
      id: 'imm_index'
      doc: 'IMM Index'
    6:
      id: 'basis_points'
      doc: 'Basis points'
    7:
      id: 'inverted_yield'
      doc: 'Inverted yield'
    8:
      id: 'percentage_of_nominal'
      doc: 'Percentage of Nominal'
    9:
      id: 'dirty_price'
      doc: 'Dirty Price'
  foreign_ownership_restriction:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  option_style:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'american'
      doc: 'American'
    2:
      id: 'european'
      doc: 'European'
    3:
      id: 'asian'
      doc: 'Asian'
  status:
    0x41:
      id: 'active'
      doc: 'Active'
    0x44:
      id: 'delisted'
      doc: 'Delisted'
    0x53:
      id: 'suspended'
      doc: 'Suspended'
  market_type:
    1:
      id: 'stock'
      doc: 'Stock'
    2:
      id: 'fixed_income'
      doc: 'Fixed Income'
    3:
      id: 'currency'
      doc: 'Currency'
    4:
      id: 'power_energy'
      doc: 'Power/Energy'
    5:
      id: 'commodity'
      doc: 'Commodity'
    6:
      id: 'payment'
      doc: 'Payment'
    7:
      id: 'index'
      doc: 'Index'
    8:
      id: 'general'
      doc: 'General'
  index_market:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  leg_side:
    0x42:
      id: 'buy_leg'
      doc: 'Buy Leg'
    0x43:
      id: 'sell_leg'
      doc: 'Sell Leg'
  corporate_action_type:
    0x42:
      id: 'basis_of_quotation'
      doc: 'Basis of Quotation'
    0x53:
      id: 'status_note'
      doc: 'Status Note'
  corporate_action_status:
    1:
      id: 'ca_active'
      doc: 'CA Active'
    2:
      id: 'ca_inactive'
      doc: 'CA Inactive'
  accrued_interest_updown:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'up'
      doc: 'Up'
    2:
      id: 'down'
      doc: 'Down'
  calculation_convention:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'compound'
      doc: 'Compound'
    2:
      id: 'compound_simple'
      doc: 'Compound Simple'
    3:
      id: 'simple_mm'
      doc: 'Simple MM'
    4:
      id: 'discount'
      doc: 'Discount'
    5:
      id: 'us_treasury'
      doc: 'US Treasury'
    6:
      id: 'proceed'
      doc: 'Proceed'
  clean_price_updown:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'up'
      doc: 'Up'
    2:
      id: 'down'
      doc: 'Down'
  day_calculation_rule:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'actact'
      doc: 'ACTACT'
    2:
      id: 'actafb'
      doc: 'ACTAFB'
    3:
      id: 'eu_30360'
      doc: 'EU30360'
    4:
      id: 'us_30360'
      doc: 'US30360'
    5:
      id: 'act_365'
      doc: 'ACT365'
    6:
      id: 'act_360'
      doc: 'ACT360'
  day_count_convention:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'actact'
      doc: 'ACTACT'
    2:
      id: 'actafb'
      doc: 'ACTAFB'
    3:
      id: 'eu_30360'
      doc: 'EU30360'
    4:
      id: 'us_30360'
      doc: 'US30360'
    5:
      id: 'act_365'
      doc: 'ACT365'
    6:
      id: 'act_360'
      doc: 'ACT360'
  fixed_income_type:
    0:
      id: 'not_applicable'
      doc: 'Not Applicable'
    1:
      id: 'bill'
      doc: 'Bill'
    2:
      id: 'bond'
      doc: 'Bond'
    3:
      id: 'index_linked_bonds'
      doc: 'Index Linked Bonds'
    4:
      id: 'bond_floating'
      doc: 'Bond Floating'
    5:
      id: 'lottery_bond'
      doc: 'Lottery Bond'
    6:
      id: 'convertible_bond'
      doc: 'Convertible Bond'
    7:
      id: 'structured_bond'
      doc: 'Structured Bond'
    8:
      id: 'fixing'
      doc: 'Fixing'
    9:
      id: 'credit_certificates'
      doc: 'Credit Certificates'
  end_of_month_count_convention:
    0:
      id: 'blank'
      doc: 'Blank'
    1:
      id: 'same'
      doc: 'SAME'
    2:
      id: 'last_360'
      doc: 'LAST360'
    3:
      id: 'last'
      doc: 'LAST'
  set_end_consideration:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  set_start_consideration:
    1:
      id: 'yes_field'
      doc: 'Yes'
    2:
      id: 'no_field'
      doc: 'No'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Start of Messages. Outside of time stamp messages, the first message sent in any trading day.'
    0x43:
      id: 'end_of_messages'
      doc: 'End of Messages. Always the last message sent in any trading day.'
    0x45:
      id: 'done_for_day'
      doc: 'Done for day. No More Trades, Trade Reporting Done for Day'
  instrument_state_level:
    1:
      id: 'market'
      doc: 'Market'
    2:
      id: 'instrument_type'
      doc: 'Instrument Type'
    4:
      id: 'instrument_series'
      doc: 'Instrument series'
    5:
      id: 'underlying'
      doc: 'Underlying'
  level_update_action:
    0x4e:
      id: 'new_field'
      doc: 'New price level added, or the number of price levels reduced with contents changed'
    0x43:
      id: 'change'
      doc: 'Number of price levels remain the same but the contents of the price level changed'
    0x44:
      id: 'delete_from'
      doc: 'Price level removed compared to the last update'
  side:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  trend_indicator:
    0x4e:
      id: 'no_change'
      doc: 'No Change'
    0x55:
      id: 'up'
      doc: 'Up'
    0x44:
      id: 'down'
      doc: 'Down'
    0x20:
      id: 'no_trend_available'
      doc: 'Unset/No trend available'
  price_type:
    0:
      id: 'externally_injected'
      doc: 'Externally Injected'
    3:
      id: 'previous_last_paid_price'
      doc: 'Previous Last Paid Price'
    4:
      id: 'settlement_price'
      doc: 'Settlement Price'
    5:
      id: 'ever_last_price'
      doc: 'Ever last price'
  deal_source:
    0:
      id: 'not_set'
      doc: 'Not set or not disseminated.'
    1:
      id: 'matched_by_system_automatically'
      doc: 'Matched by system automatically.'
    3:
      id: 'matched_outside_exchange_different_brokers'
      doc: 'Matched outside exchange, different brokers, trade report.'
    5:
      id: 'matched_outside_exchange_one_broker'
      doc: 'Matched outside exchange, one broker, trade report, crossing.'
    7:
      id: 'standard_combination_matched'
      doc: 'Standard Combination order matched against another combination order or against a single order by the exchange electronically.'
    20:
      id: 'trade_matched_in_an_auction'
      doc: 'Trade matched in an auction.'
    36:
      id: 'tmc_order_matched'
      doc: 'TMC order matched against another combination order or against a single order by the exchange electronically.'
    44:
      id: 'booked_unintentional_crossing_prevention'
      doc: 'Booked transaction, resulting from Unintentional Crossing Prevention.'
    45:
      id: 'booked_unintentional_crossing_prevention_auction'
      doc: 'Booked transaction, resulting from Unintentional Crossing Prevention during an auction.'
    46:
      id: 'centre_point_preference_matching'
      doc: 'Centre Point Preference Matching.'
    47:
      id: 'executions_in_centre_point'
      doc: 'Executions in Centre Point.'
    48:
      id: 'booked_centre_point_unintentional_crossing_prevention'
      doc: 'Booked transaction in Centre Point, resulting from Unintentional Crossing Prevention.'
    50:
      id: 'centre_point_any_price_block_trade'
      doc: 'Centre Point Any Price Block Trade.'
    51:
      id: 'preference_centre_point_any_price_block_trade'
      doc: 'Preference Centre Point Any Price Block Trade'
    90:
      id: 'post_close_auto'
      doc: 'Post Close Auto'
    91:
      id: 'post_close_booked_transaction'
      doc: 'Post Close Booked Transaction'
  action:
    1:
      id: 'new_field'
      doc: 'New'
    2:
      id: 'updated'
      doc: 'Updated (Not used by ASX)'
    3:
      id: 'canceled'
      doc: 'Canceled'
  aggressor:
    0x42:
      id: 'bid'
      doc: 'Bid'
    0x41:
      id: 'ask'
      doc: 'Ask'
  printable:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  exchange_order_type:
    0:
      id: 'undefined'
      doc: 'Undefined'
    8:
      id: 'price_stabilisation'
      doc: 'Price Stabilisation'
    64:
      id: 'centre_point'
      doc: 'Centre Point'
  trade_condition:
    0:
      id: 'no_condition'
      doc: 'No Condition'
    2:
      id: 'internal_trade_crossing'
      doc: 'Internal Trade/Crossing'
    8:
      id: 'buy_write'
      doc: 'Buy Write (Equity/Derivative Combination)'
    10:
      id: 'buy_write_internal_trade_crossing'
      doc: 'Buy Write (Equity/Derivative Combination) which is an Internal Trade/Crossing'
  type_field:
    1:
      id: 'price_limits'
      doc: 'Price Limits'
    2:
      id: 'circuit_breaker_limits'
      doc: 'Circuit Breaker Limits'
  category:
    1:
      id: 'static_limits'
      doc: 'Static Limits'
    2:
      id: 'dynamic_limits'
      doc: 'Dynamic Limits'
  message_information_type:
    1:
      id: 'company_announcement'
      doc: 'Company Announcement'
    2:
      id: 'market_message'
      doc: 'Market Message'
    3:
      id: 'static_line'
      doc: 'Static Line'
    4:
      id: 'notice_received'
      doc: 'Notice Received'
  message_priority:
    1:
      id: 'low_priority'
      doc: 'Low Priority'
    2:
      id: 'medium_priority'
      doc: 'Medium Priority'
    3:
      id: 'high_priority'
      doc: 'High Priority'
    4:
      id: 'critical_priority'
      doc: 'Critical Priority'

