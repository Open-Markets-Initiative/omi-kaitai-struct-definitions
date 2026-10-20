# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Tsx Level1 Qrtmd v2.8
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Level 1
#   Encoding: Quantum Real Time Market Data
#   Version: 2.8
#   Date: 08/10/2021
#   Specification: QRTMD TSX Level 1 CL1 (2.8.0).pdf
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
  id: tmx_tsx_level1_qrtmd_v2_8
  title: Tmx Tsx Level1 Qrtmd v2.8
  license: GPL-3.0
  endian: be

doc: 'TMX Group Toronto Stock Exchange Level 1 Qrtmd v2.8'
doc-ref: https://www.tmxwebstore.com/

seq:
  - id: qrtmd_stx
    type: u1
    doc: 'Start of Qrtmd message'
  - id: message_header
    type: message_header_struct
    doc: 'Twenty two byte ascii header carried on every Qrtmd message'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        '"A"': trade_message
        '"B"': symbol_status_message
        '"C"': moc_imbalance_notification_message
        '"CA"': moc_price_movement_delay_message
        '"D"': stock_state_message
        '"E"': quote_message
        '"G"': general_message
        '"H"': trade_cancellation_message
        '"I"': indicative_price_message
        '"O"': calculated_opening_price_message
        '"R"': tsx_tsxv_closing_price_message
        '"S"': market_state_message
        '"T"': trading_tier_status_message
        '"X"': trade_correction_message
  - id: qrtmd_etx
    type: u1
    doc: 'End of Qrtmd message'

types:
  message_header_struct:
    seq:
      - id: message_length
        type: str
        size: 4
        encoding: ASCII
        doc: 'Total length of header and message business content, excluding Stx and Etx'
      - id: sequence_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Assigned at service broadcast from 000000001 to 999999999, blank on a heartbeat'
      - id: service_identifier
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Service code identifying the market data service carried on the feed'
      - id: retransmission_identifier
        type: u1
        enum: retransmission_identifier
        doc: 'Marks a normal transmission, and is always blank on a heartbeat'
      - id: continuation_identifier
        type: u1
        enum: continuation_identifier
        doc: 'Provides for fragmentation of a message exceeding the maximum transmission unit'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique code assigned to each message type, specific to each market service'
      - id: exchange_identifier
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Code assigned to the originating exchange'
  trade_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier per stock assigned to each trade'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Identifies the type of an intentional cross'
      - id: moc
        type: u1
        enum: moc
        doc: 'Marks a Market On Close trade'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An indicator for bypass crosses, which can be printed outside of the Protected NBBO and are not subject to cross interference'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'An indicator as to whether the trade occurred at the opening or was the first board lot trade of the day'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement terms associated with the order'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
      - id: trade_date
        type: yyyymmdd_ascii_date
        doc: 'Effective date of the trade, filled in only when it differs from the current date'
      - id: is_mid_only
        type: u1
        enum: is_mid_only
        doc: 'Indicates a dark Contra Midpoint Only Plus to Contra Midpoint Only Plus execution'
      - id: is_dark
        type: u1
        enum: is_dark
        doc: 'Indicates the passive side of the trade is dark'
      - id: is_conditional
        type: u1
        enum: is_conditional
        doc: 'Indicates a firm-up conditional to firm-up conditional execution'
  symbol_status_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: exchange_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the exchange from which the message originated'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing and settlement registration number'
      - id: board_lot
        type: str
        size: 9
        encoding: ASCII
        doc: 'Board lot volume'
      - id: currency
        type: str
        size: 1
        encoding: ASCII
        doc: 'The currency of a price'
      - id: face_value
        type: str
        size: 9
        encoding: ASCII
        doc: 'The face value of a debenture. Implied decimal with scale 1e-3'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: moc_eligible
        type: u1
        enum: moc_eligible
        doc: 'Identifies whether the stock is eligible to participate in the Market On Close session each day'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
      - id: symbol_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'The security or issue symbol''s complete company name'
      - id: stock_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'An indicator of stock group'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The state of the stock'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: buy_maximum_quantity
        type: str
        size: 9
        encoding: ASCII
        doc: 'The maximum quantity of a mutual fund allowed to buy'
      - id: buy_minimum_quantity
        type: str
        size: 9
        encoding: ASCII
        doc: 'The minimum quantity of a mutual fund required to buy'
      - id: sell_maximum_quantity
        type: str
        size: 9
        encoding: ASCII
        doc: 'The maximum quantity of a mutual fund allowed to sell'
      - id: sell_minimum_quantity
        type: str
        size: 9
        encoding: ASCII
        doc: 'The minimum quantity of a mutual fund required to sell'
      - id: test_symbol
        type: u1
        enum: test_symbol
        doc: 'Indicates the symbol is a test symbol'
  moc_imbalance_notification_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: imbalance_side
        type: u1
        enum: imbalance_side
        doc: 'Marker to indicate which side has a Volume Imbalance for Market On Close'
      - id: imbalance_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Identifies the volume of shares of the Imbalance side of Market on Close'
      - id: imbalance_reference_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price that decides if a given limit-priced Market on Close order can contribute to the MOC Imbalance. Implied decimal with scale 1e-5'
      - id: paired_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The number of MOC and LOC shares that can be matched at the reference price'
      - id: market_order_imbalance_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Indicates the share imbalance when only MOC orders are considered'
      - id: market_order_imbalance_side
        type: u1
        enum: market_order_imbalance_side
        doc: 'Side of the Market Order Imbalance Volume'
      - id: near_indicative_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The calculated closing price that will maximize the number of shares matched based on the on-close orders and visible continuous market orders. Implied decimal with scale 1e-5'
      - id: far_indicative_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The calculated closing price that will maximize the number of shares matched based on closing interest only. Implied decimal with scale 1e-5'
      - id: price_variation
        type: str
        size: 5
        encoding: ASCII
        doc: 'The absolute value of the percentage of deviation of the Near Indicative Closing Price from the Reference Price. Implied decimal with scale 1e-2'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  moc_price_movement_delay_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The state of the stock'
      - id: ccp
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which the maximum amount of stock will trade. Implied decimal with scale 1e-5'
      - id: vwap
        type: str
        size: 11
        encoding: ASCII
        doc: 'Volume-weighted average price based on trades. Implied decimal with scale 1e-5'
  stock_state_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: comment
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text accompanying the state change'
      - id: stock_state
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The state of the stock'
      - id: opening_time
        type: hhmmss_ascii_time
        doc: 'The opening time for a stock'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
  quote_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: bid_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid price for the equity. Implied decimal with scale 1e-3'
      - id: bid_size
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume on the bid side'
      - id: ask_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask price for the equity. Implied decimal with scale 1e-3'
      - id: ask_size
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume on the ask side'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  general_message:
    seq:
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: bulletin_indicator
        type: u1
        enum: bulletin_indicator
        doc: 'Indicates the message is a bulletin'
      - id: message_text
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bulletin in textual format'
  trade_cancellation_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: original_trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trade number'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
      - id: trade_date
        type: yyyymmdd_ascii_date
        doc: 'Effective date of the trade, filled in only when it differs from the current date'
  indicative_price_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing and settlement registration number'
      - id: indicative_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Represents the Indicative Closing Price when the Price Marker is C. Implied decimal with scale 1e-5'
      - id: price_marker
        type: u1
        enum: price_marker
        doc: 'Identifies the price type'
      - id: business_date
        type: yyyymmdd_ascii_date
        doc: 'Business Date'
  calculated_opening_price_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing and settlement registration number'
      - id: cop
        type: str
        size: 11
        encoding: ASCII
        doc: 'Calculated and published by the trading engine continuously before the Tsx market opens. Implied decimal with scale 1e-5'
      - id: price_marker
        type: u1
        enum: price_marker
        doc: 'Identifies the price type'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
  tsx_tsxv_closing_price_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: cusip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Clearing and settlement registration number'
      - id: tsx_tsxv_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'For non ETF securities the Last Sales Price of the current trading day is the closing price. Implied decimal with scale 1e-5'
      - id: tsx_tsxv_last_bid
        type: str
        size: 9
        encoding: ASCII
        doc: 'The time weighted average price of the best bids during the last ten minutes of the trading session. Implied decimal with scale 1e-3'
      - id: tsx_tsxv_last_ask
        type: str
        size: 9
        encoding: ASCII
        doc: 'The time weighted average price of the best offers during the last ten minutes of the trading session. Implied decimal with scale 1e-3'
      - id: business_date
        type: yyyymmdd_ascii_date
        doc: 'Business Date'
  market_state_message:
    seq:
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: stock_group
        type: str
        size: 2
        encoding: ASCII
        doc: 'An indicator of stock group'
      - id: market_state
        type: u1
        enum: market_state
        doc: 'The indication of the current market state'
  trading_tier_status_message:
    seq:
      - id: exchange_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the exchange from which the message originated'
      - id: total_number_of_symbols
        type: str
        size: 5
        encoding: ASCII
        doc: 'The total number of stocks per trading tier and Exchange ID'
      - id: total_number_of_stock_groups
        type: str
        size: 3
        encoding: ASCII
        doc: 'Total number of stock groups per trading tier and exchange ID'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: trading_tier_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Trading Engine identifier'
  trade_correction_message:
    seq:
      - id: symbol
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Stock symbol'
      - id: volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Volume of shares traded'
      - id: trade_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Price at which the transaction took place. Implied decimal with scale 1e-5'
      - id: buyer_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the buying broker'
      - id: seller_id
        type: str
        size: 3
        encoding: ASCII
        doc: 'Identifies the selling broker'
      - id: trade_time_stamp
        type: hhmmss_ascii_time
        doc: 'Time of trade'
      - id: last_sale
        type: str
        size: 11
        encoding: ASCII
        doc: 'Last sale price of the symbol. Implied decimal with scale 1e-5'
      - id: trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Unique identifier per stock assigned to each trade'
      - id: cross_type
        type: u1
        enum: cross_type
        doc: 'Identifies the type of an intentional cross'
      - id: moc
        type: u1
        enum: moc
        doc: 'Marks a Market On Close trade'
      - id: bypass
        type: u1
        enum: bypass
        doc: 'An indicator for bypass crosses, which can be printed outside of the Protected NBBO and are not subject to cross interference'
      - id: opening_trade
        type: u1
        enum: opening_trade
        doc: 'An indicator as to whether the trade occurred at the opening or was the first board lot trade of the day'
      - id: settlement_terms
        type: u1
        enum: settlement_terms
        doc: 'Settlement terms associated with the order'
      - id: original_trade_id
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trade number'
      - id: trading_system_time_stamp
        type: str
        size: 23
        encoding: ASCII
        doc: 'The time at which the business action occurred'
      - id: listing_market
        type: u1
        enum: listing_market
        doc: 'The market on which a security is listed'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'The product type for a symbol'
      - id: trade_date
        type: yyyymmdd_ascii_date
        doc: 'Effective date of the trade, filled in only when it differs from the current date'
      - id: is_mid_only
        type: u1
        enum: is_mid_only
        doc: 'Indicates a dark Contra Midpoint Only Plus to Contra Midpoint Only Plus execution'
      - id: is_dark
        type: u1
        enum: is_dark
        doc: 'Indicates the passive side of the trade is dark'
      - id: is_conditional
        type: u1
        enum: is_conditional
        doc: 'Indicates a firm-up conditional to firm-up conditional execution'
  hhmmss_ascii_time:
    seq:
      - id: text
        type: str
        size: 6
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i

enums:
  retransmission_identifier:
    0x30:
      id: 'normal_transmission'
      doc: 'Used for normal transmission, and unchanged on a message sent for a recovery'
  continuation_identifier:
    0x30:
      id: 'stand_alone_message'
      doc: 'All of the message fits in one packet'
  cross_type:
    0x49:
      id: 'internal_field'
      doc: 'Internal'
    0x42:
      id: 'basis'
      doc: 'Basis'
    0x43:
      id: 'contingent'
      doc: 'Contingent'
    0x44:
      id: 'derivative_related'
      doc: 'Derivative Related'
    0x52:
      id: 'regular'
      doc: 'Regular'
    0x53:
      id: 'special_trading_session'
      doc: 'Special Trading Session'
    0x56:
      id: 'volume_weighted_average_price'
      doc: 'Volume Weighted Average Price'
    0x20:
      id: 'default_field'
      doc: 'Trade was not a cross'
  moc:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  bypass:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  opening_trade:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  settlement_terms:
    0x20:
      id: 'default_field'
      doc: 'Default'
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x4e:
      id: 'non_net'
      doc: 'Non Net'
    0x4d:
      id: 'derivatives_related_contingent_equity_trade'
      doc: 'Derivatives Related Contingent Equity Trade'
    0x54:
      id: 'cash_today'
      doc: 'Cash Today'
    0x44:
      id: 'settlement_date'
      doc: 'There is a valid Settlement Date associated with the order'
  listing_market:
    0x54:
      id: 'tsx'
      doc: 'Tsx'
    0x56:
      id: 'tsxv'
      doc: 'Tsxv'
    0x4e:
      id: 'navex'
      doc: 'Navex'
    0x51:
      id: 'nasdaq'
      doc: 'Nasdaq'
    0x53:
      id: 'nyse'
      doc: 'Nyse'
    0x4d:
      id: 'nyse_mkt'
      doc: 'Nyse Mkt'
    0x58:
      id: 'no_market'
      doc: 'Unlisted securities, posted for trading only'
  product_type:
    0x42:
      id: 'debenture'
      doc: 'Debenture'
    0x45:
      id: 'equity'
      doc: 'Equity'
    0x4d:
      id: 'mutual_fund'
      doc: 'Mutual Fund'
    0x46:
      id: 'etf'
      doc: 'Etf'
    0x55:
      id: 'us_equity'
      doc: 'Us Equity'
    0x4f:
      id: 'bond'
      doc: 'Bond'
  is_mid_only:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  is_dark:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  is_conditional:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  moc_eligible:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  test_symbol:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  market_order_imbalance_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
  bulletin_indicator:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'Default'
  price_marker:
    0x43:
      id: 'indicative_closing_price'
      doc: 'Indicative Closing Price'
    0x4f:
      id: 'calculated_opening_price'
      doc: 'Calculated Opening Price'
  market_state:
    0x50:
      id: 'pre_open'
      doc: 'Pre Open'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x53:
      id: 'open'
      doc: 'Open'
    0x43:
      id: 'closed'
      doc: 'Closed'
    0x52:
      id: 'extended_hours_open'
      doc: 'Extended Hours Open'
    0x46:
      id: 'extended_hours_close'
      doc: 'Extended Hours Close'
    0x4e:
      id: 'extended_hours_cxls'
      doc: 'Extended Hours Cxls'
    0x4d:
      id: 'moc_imbalance'
      doc: 'Moc Imbalance'
    0x54:
      id: 'moc_freeze'
      doc: 'Moc Freeze'
    0x41:
      id: 'ccp_determination'
      doc: 'Ccp Determination'
    0x45:
      id: 'price_movement_extension'
      doc: 'Price Movement Extension'
    0x4c:
      id: 'closing'
      doc: 'Closing'
    0x4a:
      id: 'navex_closed'
      doc: 'Navex stock groups'
    0x47:
      id: 'navex_order_entry'
      doc: 'Navex stock groups'
    0x48:
      id: 'navex_order_entry_close'
      doc: 'Navex stock groups'
    0x4b:
      id: 'navex_am_execution'
      doc: 'Navex stock groups'
    0x58:
      id: 'navex_pm_execution'
      doc: 'Navex stock groups'
    0x59:
      id: 'navex_close'
      doc: 'Navex stock groups'

