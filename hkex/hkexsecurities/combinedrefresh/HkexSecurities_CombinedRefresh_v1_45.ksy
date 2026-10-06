# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexSecurities CombinedRefresh Omd v1.45
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Cash Combined Refresh
#   Encoding: Orion Market Data
#   Version: 1.45
#   Date: 1/9/2026
#   Specification: HKEX_OMDC_Binary_Interface_Specifications_v1_45.pdf
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
  id: hkex_hkexsecurities_combinedrefresh_omd_v1_45
  title: Hkex HkexSecurities CombinedRefresh Omd v1.45
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Securities Market Orion Market Data Cash Combined Refresh Omd v1.45'
doc-ref: https://www.hkex.com.hk/Mutual-Market/Stock-Connect/Reference-Materials/Technical-Documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Omd packet header (no payload compression; byte 3 is Filler)'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.msg_count

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'Size of the packet including this field'
      - id: msg_count
        type: u1
        doc: 'Number of messages included in the packet'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        doc: 'Reserved filler byte (OMD does not use payload compression)'
      - id: seq_num
        type: u4
        doc: 'Sequence number of the first message in the packet'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time of the packet — nanoseconds since Unix epoch UTC (precision to millisecond). Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: msg_header
        type: msg_header
        doc: 'Omd message header'
      - id: payload
        size: msg_header.msg_size - 4
        type:
          switch-on: msg_header.msg_type
          cases:
            'msg_type::add_odd_lot_order_message': add_odd_lot_order_message
            'msg_type::add_order_message': add_order_message
            'msg_type::aggregate_order_book_update_message': aggregate_order_book_update_message
            'msg_type::broker_queue_message': broker_queue_message
            'msg_type::closing_price_message': closing_price_message
            'msg_type::index_definition_message': index_definition_message
            'msg_type::index_data_message': index_data_message
            'msg_type::indicative_equilibrium_price_message': indicative_equilibrium_price_message
            'msg_type::news_message': news_message
            'msg_type::nominal_price_message': nominal_price_message
            'msg_type::order_imbalance_message': order_imbalance_message
            'msg_type::market_definition_message': market_definition_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::liquidity_provider_message': liquidity_provider_message
            'msg_type::currency_rate_message': currency_rate_message
            'msg_type::reference_price_message': reference_price_message
            'msg_type::refresh_complete_message': refresh_complete_message
            'msg_type::statistics_message': statistics_message
            'msg_type::market_turnover_message': market_turnover_message
            'msg_type::yield_message': yield_message
            'msg_type::trading_session_status_message': trading_session_status_message
            'msg_type::security_status_message': security_status_message
            'msg_type::stock_connect_daily_quota_balance_message': stock_connect_daily_quota_balance_message
            'msg_type::stock_connect_market_turnover_message': stock_connect_market_turnover_message
            'msg_type::vcm_trigger_message': vcm_trigger_message
  msg_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Length of the message including this field'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Code identifying this message type'
  add_odd_lot_order_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier for each order performed within the trading day'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: broker_id
        type: u2
        doc: 'Integer identifier uniquely identifying the Broker'
      - id: side
        type: u2
        enum: side
        doc: 'Side of the order'
  add_order_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: order_id
        type: u8
        doc: 'Unique identifier for each order performed within the trading day'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: side
        type: u2
        enum: side
        doc: 'Side of the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Order type'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: order_book_position
        type: s4
        doc: 'Order rank information for the order position within the order book for each security'
  aggregate_order_book_update_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: num_book_entry
        type: u1
        doc: 'Number of book entries within the message'
      - id: book_entry
        type: book_entry
        repeat: expr
        repeat-expr: num_book_entry
        doc: 'Aggregate order book entry repeating group'
  book_entry:
    seq:
      - id: aggregate_quantity
        type: u8
        doc: 'IEV'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: number_of_orders
        type: u4
        doc: 'Number of orders'
      - id: side
        type: u2
        enum: side
        doc: 'Side of the order'
      - id: price_level
        type: u1
        doc: 'Price level'
      - id: update_action
        type: u1
        enum: update_action
        doc: 'Type of market data update action'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  broker_queue_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: num_bq_item
        type: u1
        doc: 'Number of items in the message. 0 to 40'
      - id: broker_side
        type: u2
        enum: broker_side
        doc: 'Side of the order (PDF field "Side"; renamed to BQSide to disambiguate from the Bid/Offer Side used in other order-book messages)'
      - id: bq_more_flag
        type: u1
        enum: bq_more_flag
        doc: 'Flag indicating if there are more broker numbers in the queue'
      - id: bq_item
        type: bq_item
        repeat: expr
        repeat-expr: num_bq_item
        doc: 'Broker queue repeating item'
  bq_item:
    seq:
      - id: item
        type: u2
        doc: 'Either the broker number or the number of spreads away from the best price'
      - id: type_field
        type: u1
        enum: type_field
        doc: 'Indicates the type of information contained in the item'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  closing_price_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: closing_price
        type: decimal_s4_3
        doc: 'Current Day Closing Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: number_of_trades
        type: u4
        doc: 'Total Number of Trades performed on the given instrument'
  index_definition_message:
    seq:
      - id: index_code
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Upstream source''s index code or market information identifier'
      - id: index_source
        type: u1
        enum: index_source
        doc: 'Index or market information source'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  index_data_message:
    seq:
      - id: index_code
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Upstream source''s index code or market information identifier'
      - id: index_status
        type: u1
        enum: index_status
        doc: 'Index status. Can be blank if not defined by third party index compilers'
      - id: index_time
        type: s8
        doc: 'Publisher timestamp. Nanoseconds since Unix epoch UTC, precision to the nearest second'
      - id: index_value
        type: decimal_s8_4
        doc: 'Current value of the index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: net_chg_prev_day
        type: decimal_s8_4
        doc: 'Net change of IndexValue from the previous close, as provided in index source. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: high_value
        type: decimal_s8_4
        doc: 'Highest value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: low_value
        type: decimal_s8_4
        doc: 'Lowest value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: eas_value
        type: decimal_s8_2
        doc: 'Estimated Average Settlement Value. 2 implied decimal places. Implied decimal with scale 1e-2'
      - id: index_turnover
        type: decimal_s8_4
        doc: 'Current turnover of underlying constituents. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: opening_value
        type: decimal_s8_4
        doc: 'First value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: closing_value
        type: decimal_s8_4
        doc: 'Last value for an index. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: previous_ses_close
        type: decimal_s8_4
        doc: 'Previous session closing value (previous day for CSI, CES, S&P; previous session for HSI and TR). 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: index_volume
        type: s8
        doc: 'Index volume of underlying constituents. Only applicable for CSI and CES'
      - id: net_chg_prev_day_pct
        type: decimal_s4_4
        doc: 'Percentage change of IndexValue from the previous close. 4 implied decimal places. Implied decimal with scale 1e-4'
      - id: exception
        type: u1
        enum: exception
        doc: 'Exception indicator'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  indicative_equilibrium_price_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: aggregate_quantity
        type: u8
        doc: 'IEV'
  news_message:
    seq:
      - id: news_type
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of Exchange news'
      - id: news_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unique number for the news page within each NewsType'
      - id: headline
        size: 320
        doc: 'News headline. ASCII encoded if NewsType is EXN, Unicode UTF-16LE encoded if NewsType is EXC'
      - id: cancel_flag
        type: u1
        enum: cancel_flag
        doc: 'Indicator of whether previously released exchange news (identified by NewsType and NewsID) has been cancelled'
      - id: last_fragment
        type: u1
        enum: last_fragment
        doc: 'Indicates whether this message is the last in a sequence of messages'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: release_time
        type: u8
        doc: 'Release time of the news. Nanoseconds since Unix epoch UTC, precision to the nearest second'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: num_news_market
        type: u2
        doc: 'Number of Market segment identifiers within this message. 0 to 4'
      - id: news_market
        type: news_market
        repeat: expr
        repeat-expr: num_news_market
        doc: 'Repeating group of market codes referenced by this news item'
      - id: second_filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: num_news_security
        type: u2
        doc: 'Number of security codes within this message. 0 to 200'
      - id: news_security
        type: news_security
        repeat: expr
        repeat-expr: num_news_security
        doc: 'Repeating group of security codes referenced by this news item'
      - id: third_filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: num_news_line_item
        type: u2
        doc: 'Number of news lines. Maximum of 10 lines per news page currently supported'
      - id: news_line_item
        type: news_line_item
        repeat: expr
        repeat-expr: num_news_line_item
        doc: 'Repeating group of news lines'
  news_market:
    seq:
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment identifier'
  news_security:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
  news_line_item:
    seq:
      - id: news_line
        size: 160
        doc: 'News line. ASCII encoded if NewsType is EXN, Unicode UTF-16LE encoded if NewsType is EXC'
  nominal_price_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: nominal_price
        type: decimal_s4_3
        doc: 'Nominal price of a security. 3 implied decimal places. May be 0 in specific cases (e.g. no reference price). Implied decimal with scale 1e-3'
  order_imbalance_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: order_imbalance_direction
        type: u1
        enum: order_imbalance_direction
        doc: 'Indicates the imbalance direction when the matchable buy quantity and sell quantity at IEP are not equal'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: order_imbalance_quantity
        type: u8
        doc: 'The absolute difference between the matchable buy quantity and sell quantity at IEP. Value should be ignored if Order Imbalance Direction is space'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  market_definition_message:
    seq:
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment identifier'
      - id: market_name
        type: str
        size: 25
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment name'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: number_of_securities
        type: u4
        doc: 'Number of securities within the market segment'
  security_definition_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment identifier'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code of the security'
      - id: instrument_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument type of the security'
      - id: product_type
        type: u1
        enum: product_type
        doc: 'Product type of the security'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: spread_table_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Spread table code of the security'
      - id: security_short_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security short name'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: security_name_gccs
        size: 60
        doc: 'Security name in Traditional Chinese using Unicode UTF-16LE encoding'
      - id: security_name_gb
        size: 60
        doc: 'Security name in Simplified Chinese using Unicode UTF-16LE encoding'
      - id: lot_size
        type: u4
        doc: 'Board lot size for the security'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: previous_closing_price
        type: decimal_s4_3
        doc: 'Previous closing price of the security, or NAV published by issuer for ETF or L&I Product on the trading day before its first day listing. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: vcm_flag
        type: u1
        enum: vcm_flag
        doc: 'Indicates whether Volatility Control Mechanism (VCM) is applicable to the security'
      - id: short_sell_flag
        type: u1
        enum: short_sell_flag
        doc: 'Indicator for short-sell authorization'
      - id: cas_flag
        type: u1
        enum: cas_flag
        doc: 'Indicates whether Closing Auction Session (CAS) is applicable to the security'
      - id: ccass_flag
        type: u1
        enum: ccass_flag
        doc: 'Indicates whether or not the security is a CCASS security'
      - id: dummy_security_flag
        type: u1
        enum: dummy_security_flag
        doc: 'Dummy Security Flag'
      - id: second_filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: stamp_duty_flag
        type: u1
        enum: stamp_duty_flag
        doc: 'Indicator for stamp duty requirement'
      - id: third_filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: listing_date
        type: u4
        doc: 'Date of security listing. YYYYMMDD. Value is 19000101 for unknown listing date'
      - id: delisting_date
        type: u4
        doc: 'Date of security delisting. YYYYMMDD. Value is 0 if no date exists'
      - id: free_text
        type: str
        size: 38
        encoding: ASCII
        pad-right: 0x20
        doc: 'Free text associated to the security. When there is no free text, spaces are present instead'
      - id: filler_62
        type: str
        size: 62
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: pos_flag
        type: u1
        enum: pos_flag
        doc: 'Indicates whether Pre-Opening Session (POS) is applicable to the security'
      - id: pos_upper_limit
        type: decimal_s4_3
        doc: 'Upper price limit of all orders in POS Order Input period, and At-auction Limit sell order in POS No Cancellation and Random Matching periods. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
      - id: pos_lower_limit
        type: decimal_s4_3
        doc: 'Lower price limit of all orders in POS Order Input period, and At-auction Limit buy order in POS No Cancellation and Random Matching periods. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
      - id: domain_stmt_security_code
        type: u4
        doc: 'Security code of the corresponding Domain Settlement Counter. Value is 0 if the security itself is already the domain settlement counter'
      - id: filler_37
        type: str
        size: 37
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: efn_flag
        type: u1
        enum: efn_flag
        doc: 'EFN Indicator (Bonds Specific Data)'
      - id: accrued_interest
        type: decimal_u4_3
        doc: 'Accrued interest of the security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: coupon_rate
        type: decimal_u4_3
        doc: 'Coupon rate of a bond security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: fourth_filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: face_value_composite
        type: face_value_composite
        doc: 'Bond face value scaled at runtime by DecimalsInFaceValue. 0 mantissa means Not available'
      - id: face_value_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Face Value'
      - id: bond_maturity_date
        type: u4
        doc: 'Date of maturity of a bond security. YYYYMMDD'
      - id: investor_type
        type: u1
        enum: investor_type
        doc: 'Investor type of a bond security'
      - id: filler_44
        type: str
        size: 44
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: conversion_ratio
        type: decimal_u4_3
        doc: 'Conversion ratio for Structured Product. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
      - id: strike_price_1
        type: decimal_s4_3
        doc: 'Strike price of the security if it has only one strike price, or Lower strike price of the security if it has lower and upper strike prices. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: strike_price_2
        type: decimal_s4_3
        doc: 'Upper strike price of the security if it has lower and upper strike prices. 3 implied decimal places. Value is 0 if the security has only one strike price. Implied decimal with scale 1e-3'
      - id: warrant_maturity_date
        type: u4
        doc: 'Date of maturity of a bond security. YYYYMMDD'
      - id: call_put_flag
        type: u1
        enum: call_put_flag
        doc: 'Indicator of whether the warrant or structured product is a call or put option'
      - id: style
        type: u1
        enum: style
        doc: 'Style of the warrant'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: warrant_type
        type: u1
        enum: warrant_type
        doc: 'Warrant type of the warrant'
      - id: call_price_composite
        type: call_price_composite
        doc: 'CBBC call price scaled at runtime by DecimalsInCallPrice. 0 mantissa means Not available'
      - id: entitlement_composite
        type: entitlement_composite
        doc: 'Warrant entitlement scaled at runtime by DecimalsInEntitlement. 0 mantissa means Not available'
      - id: no_warrants_per_entitlement
        type: u4
        doc: 'Number of warrants per entitlement. Not applicable if Entitlement = 0'
      - id: filler_63
        type: str
        size: 63
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: num_underlying_security
        type: u2
        doc: 'Number of underlying securities if the underlying security is defined in Security Definition (11) message. 0 for structured product of which the underlying is not a security defined in Security Definition, 1 for structured product of which the underlying is defined'
      - id: underlying_security
        type: underlying_security
        repeat: expr
        repeat-expr: num_underlying_security
        doc: 'Repeating group of underlying security references'
  face_value_composite:
    seq:
      - id: face_value
        type: u8
        doc: 'Face value of a bond security. See DecimalsInFaceValue for the number of decimal places. 0 means Not available'
      - id: decimals_in_face_value
        type: u1
        doc: 'Number of decimal places in FaceValue. Not applicable if FaceValue = 0'
  call_price_composite:
    seq:
      - id: call_price
        type: s4
        doc: 'Call price for CBBC. See DecimalsInCallPrice for the number of decimal places. 0 means Not available'
      - id: decimals_in_call_price
        type: u1
        doc: 'Number of decimal places in CallPrice. Not applicable if CallPrice = 0'
  entitlement_composite:
    seq:
      - id: entitlement
        type: s4
        doc: 'Entitlement of the warrant. See DecimalsInEntitlement for the number of decimal places. 0 means Not available'
      - id: decimals_in_entitlement
        type: u1
        doc: 'Number of decimal places in Entitlement. Not applicable if Entitlement = 0'
  underlying_security:
    seq:
      - id: underlying_security_code
        type: u4
        doc: '5-digit code identifying the underlying security'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  liquidity_provider_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: num_liquidity_provider
        type: u2
        doc: 'Number of liquidity providers within this message. 1 to 50'
      - id: liquidity_provider
        type: liquidity_provider
        repeat: expr
        repeat-expr: num_liquidity_provider
        doc: 'Repeating group of liquidity providers'
  liquidity_provider:
    seq:
      - id: lp_broker_number
        type: u2
        doc: 'Broker number of the liquidity provider'
  currency_rate_message:
    seq:
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: currency_factor
        type: u2
        doc: 'Currency factor conversion. A non-zero value n means all price fields for this security should be interpreted as a value equal to the price multiplied by 10^n'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: currency_rate
        type: u4
        doc: 'Rate, expressed in HKD for one foreign currency unit. 4 decimals implied'
  reference_price_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: reference_price
        type: decimal_s4_3
        doc: 'Reference price of the security for order input in POS and CAS. 3 implied decimal places. 0 if the reference price is not available. Implied decimal with scale 1e-3'
      - id: lower_price
        type: decimal_s4_3
        doc: 'Lower price limit of at-auction Limit sell order in POS No Cancellation and Random Matching periods, or lower price of the allowed price band in CAS. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
      - id: upper_price
        type: decimal_s4_3
        doc: 'Upper price limit of at-auction Limit buy order in POS No Cancellation and Random Matching periods, or upper price of the allowed price band in CAS. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
  refresh_complete_message:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Sequence number with which the refresh is synchronized'
  statistics_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: shares_traded
        type: u8
        doc: 'Number of shares traded for a security'
      - id: turnover
        type: decimal_s8_3
        doc: 'Current turnover. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: high_price
        type: decimal_s4_3
        doc: 'Highest trade price currently performed for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: low_price
        type: decimal_s4_3
        doc: 'Lowest trade price currently performed for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: last_price
        type: decimal_s4_3
        doc: 'Last trade price for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: vwap
        type: decimal_s4_3
        doc: 'Volume-Weighted Average Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: short_sell_shares_traded
        type: u4
        doc: 'Number of short-sell shares traded for a security'
      - id: short_sell_turnover
        type: decimal_s8_3
        doc: 'Current short-sell turnover for a security. 3 implied decimal places. Implied decimal with scale 1e-3'
  market_turnover_message:
    seq:
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment identifier'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency code of Index Turnover. Can be blank if not defined by third party index compilers'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: turnover
        type: decimal_s8_3
        doc: 'Current turnover. 3 implied decimal places. Implied decimal with scale 1e-3'
  yield_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: yield_field
        type: decimal_s4_3
        doc: 'Current yield of the bond security based on its coupon rate and nominal price. 3 implied decimal places. 0 means Not available. Implied decimal with scale 1e-3'
  trading_session_status_message:
    seq:
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market segment identifier'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: trading_session_sub_id
        type: u1
        enum: trading_session_sub_id
        doc: 'Trading session sub-identifier'
      - id: trading_ses_status
        type: u1
        enum: trading_ses_status
        doc: 'Status of the current trading session'
      - id: trading_ses_control_flag
        type: u1
        enum: trading_ses_control_flag
        doc: 'Indicates how control of trading session and sub-session transitions are performed'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: start_date_time
        type: u8
        doc: 'Start time of the trading status. Nanoseconds since Unix epoch UTC, precision to the nearest second. 0 if no time is available'
      - id: end_date_time
        type: u8
        doc: 'End time of the trading status. Nanoseconds since Unix epoch UTC, precision to the nearest second. 0 if no time is available'
  security_status_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: suspension_indicator
        type: u1
        enum: suspension_indicator
        doc: 'Indicate whether the security is currently halted/suspended for trading. ''Resume'' means the security is now available for trading'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  stock_connect_daily_quota_balance_message:
    seq:
      - id: stock_connect_market
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Markets connected under Stock Connect Program'
      - id: trading_direction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Direction'
      - id: daily_quota_balance
        type: s8
        doc: 'Northbound Daily Quota Balance (DQB) value for specified Stock Connect Program. DQB in Renminbi (RMB). NULL when DQB is above/equal 30% of the daily quota; actual value when below 30%; 0 when quota is used up'
      - id: daily_quota_balance_time
        type: u8
        doc: 'Time of DailyQuotaBalance. Nanoseconds since Unix epoch UTC, precision to the nearest second'
  stock_connect_market_turnover_message:
    seq:
      - id: stock_connect_market
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Markets connected under Stock Connect Program'
      - id: trading_direction
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Direction'
      - id: buy_turnover
        type: s8
        doc: 'Total turnover of Buy trades from Southbound trading, rounded down to integer. HKD for Southbound; Null for Northbound'
      - id: sell_turnover
        type: s8
        doc: 'Total turnover of Sell trades from Southbound trading, rounded down to integer. HKD for Southbound; Null for Northbound'
      - id: buy_sell_turnover
        type: s8
        doc: 'Sum of BuyTurnover and SellTurnover, rounded down to integer. RMB for Northbound, HKD for Southbound'
  vcm_trigger_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading'
      - id: cooling_off_start_time
        type: u8
        doc: 'Time when the cooling off period starts. Nanoseconds since Unix epoch UTC, precision to the nearest second'
      - id: cooling_off_end_time
        type: u8
        doc: 'Time when the cooling off period ends. Nanoseconds since Unix epoch UTC, precision to the nearest second'
      - id: vcm_reference_price
        type: decimal_s4_3
        doc: 'Reference Price for the cooling off period. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: vcm_lower_price
        type: decimal_s4_3
        doc: 'Lower price in the price band allowed during the cooling off period. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: vcm_upper_price
        type: decimal_s4_3
        doc: 'Upper price in the price band allowed during the cooling off period. 3 implied decimal places. Implied decimal with scale 1e-3'
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
  decimal_s4_3:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 1000.0
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0
  decimal_s4_4:
    seq:
      - id: mantissa
        type: s4
    instances:
      real:
        value: mantissa / 10000.0
  decimal_u4_3:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 1000.0
  decimal_s8_3:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000.0

enums:
  msg_type:
    33:
      id: 'add_odd_lot_order_message'
      doc: 'The Add Odd Lot Order message is generated when a new odd lot order is inserted into the order book.'
    30:
      id: 'add_order_message'
      doc: 'The Add Order message is generated when a new order is inserted into the order book. The OrderId is unique per security but will not increment consecutively. Note for Securities instruments the OrderBookPosition is always set to zero.'
    53:
      id: 'aggregate_order_book_update_message'
      doc: 'The Aggregate Order Book Update message is sent whenever there is an orderbook change. Applies to Board Lots only.'
    54:
      id: 'broker_queue_message'
      doc: 'The Broker Queue message contains the priority list of the (max) top 40 broker IDs for a given side, and is generated whenever any of the entries in the list are modified. Entries are ordered according to distance away from the best price. Spread level entries are marked with Type set to ''S''.'
    62:
      id: 'closing_price_message'
      doc: 'The Closing Price message is generated near the end of the business day for each security. If the closing price is not available, ClosingPrice is set to 0. NumberOfTrades is not populated for SS (OMD Securities Standard) clients.'
    70:
      id: 'index_definition_message'
      doc: 'The Index Definition message contains the static referential data for the given index and is generated at the start of the business day. May be re-disseminated during trading hours.'
    71:
      id: 'index_data_message'
      doc: 'The Index Data message contains all the real-time data for a given index. Fields may be populated with null values to indicate when an update is not provided.'
    41:
      id: 'indicative_equilibrium_price_message'
      doc: 'The Indicative Equilibrium Price (IEP) message is generated whenever there is change of the IEP or Indicative Equilibrium Volume (IEV) during Pre-Opening Session (POS) or Closing Auction Session (CAS). The IEP is 0 when IEP does not exist.'
    22:
      id: 'news_message'
      doc: 'The News message is generated whenever a news update occurs. The message indicates which markets and/or securities the news applies to. If NoMarketCode and NoSecurityCodes are both zero, the news applies to all markets. News may be fragmented across multiple consecutive messages; LastFragment is ''Y'' in the message with the last fragment. Headline is only carried in the first message and blanked from the second message onwards.'
    40:
      id: 'nominal_price_message'
      doc: 'The Nominal message may be generated when an order is added, deleted or modified in a book or when trade or trade cancel is performed. Before the first Nominal Price message, the nominal price should be the same as the previous closing price provided in Security Definition (11).'
    56:
      id: 'order_imbalance_message'
      doc: 'The Order Imbalance message provides order imbalance information at the Indicative Equilibrium Price (IEP) during the Pre-Opening Session (POS) and Closing Auction Session (CAS).'
    10:
      id: 'market_definition_message'
      doc: 'The Market Definition message is generated at the start of the business day for each market segment.'
    11:
      id: 'security_definition_message'
      doc: 'The Security Definition message contains all the reference data for a security. Security Definition messages may be received intraday (for example the FreeText field may be updated during the day).'
    13:
      id: 'liquidity_provider_message'
      doc: 'The Liquidity Provider message is generated at the start of the business day for securities that have at least one liquidity provider.'
    14:
      id: 'currency_rate_message'
      doc: 'The Currency Rate message provides the foreign exchange conversion rates between various foreign currencies and the Hong Kong dollar.'
    43:
      id: 'reference_price_message'
      doc: 'Reference price, lower and upper price limits for order input during an applicable auction session (POS or CAS). Sent again when there is any change.'
    203:
      id: 'refresh_complete_message'
      doc: 'This message is published to mark the end of a refresh.'
    60:
      id: 'statistics_message'
      doc: 'The Statistics message provides statistics including volume-weighted average price and turnover. Generated (excluding overseas trades) once after CTS/auction match, manual trade, odd lot trade, or trade cancel. VWAP is not populated for SS (OMD Securities Standard) clients.'
    61:
      id: 'market_turnover_message'
      doc: 'The Market Turnover message contains the total turnover (excluding overseas trades) for all securities on a given market segment for a given trading currency. When CurrencyCode is blank, the turnover represents the total for all trading currencies, expressed in HKD. Updates disseminated around every 2 seconds during trading hours.'
    44:
      id: 'yield_message'
      doc: 'The Yield message is generated for bond securities when their yield percentage changes.'
    20:
      id: 'trading_session_status_message'
      doc: 'The Trading Session Status provides information on the status of a market segment. It is sent whenever there is change of trading session. This message may be sent on a separate multicast channel from order and trade data and therefore may not be synchronized.'
    21:
      id: 'security_status_message'
      doc: 'The Security Status message is generated at the start of the business day if the security is not available for trading, and whenever a security state changes.'
    80:
      id: 'stock_connect_daily_quota_balance_message'
      doc: 'Provides updates on the Northbound Daily Quota Balance (DQB) for Shanghai-Hong Kong Stock Connect and Shenzhen-Hong Kong Stock Connect separately. Updates disseminated around every 5 seconds during trading hours.'
    81:
      id: 'stock_connect_market_turnover_message'
      doc: 'Provides aggregate turnover under Shanghai-Hong Kong and Shenzhen-Hong Kong Stock Connect programs. Aggregate turnover provided separately for Northbound and Southbound trading. For Northbound, Buy+Sell Turnover only provided after market close (typically by 16:00). For Southbound, updates disseminated around every minute during trading hours.'
    23:
      id: 'vcm_trigger_message'
      doc: 'The VCM Trigger message is generated whenever a cooling off period is triggered by Volatility Control Mechanism (VCM).'
  side:
    0:
      id: 'bid'
      doc: 'Bid'
    1:
      id: 'offer'
      doc: 'Offer'
  order_type:
    0x31:
      id: 'market'
      doc: 'Market'
    0x32:
      id: 'limit'
      doc: 'Limit'
  update_action:
    0:
      id: 'new_field'
      doc: 'New'
    1:
      id: 'change'
      doc: 'Change'
    2:
      id: 'delete_field'
      doc: 'Delete'
    74:
      id: 'orderbook_clear'
      doc: 'Orderbook Clear'
  broker_side:
    1:
      id: 'buy'
      doc: 'Buy'
    2:
      id: 'sell'
      doc: 'Sell'
  bq_more_flag:
    0x59:
      id: 'more_broker_numbers_exist_in_the_queue'
      doc: 'More Broker Numbers Exist In The Queue'
    0x4e:
      id: 'no_more_exist'
      doc: 'No More Exist'
  type_field:
    0x42:
      id: 'broker_number'
      doc: 'Broker Number'
    0x53:
      id: 'number_of_spread'
      doc: 'Number Of Spread'
  index_source:
    0x43:
      id: 'csi_and_ces'
      doc: 'Csi And Ces'
    0x48:
      id: 'hsi'
      doc: 'Hsi'
    0x53:
      id: 's_and_p'
      doc: 'S And P'
  index_status:
    0x43:
      id: 'closing_value'
      doc: 'Closing Value'
    0x49:
      id: 'indicative'
      doc: 'Indicative'
    0x4f:
      id: 'opening_index'
      doc: 'Opening Index'
    0x50:
      id: 'last_close_value_previous_session'
      doc: 'Last Close Value Previous Session'
    0x52:
      id: 'preliminary_close'
      doc: 'Preliminary Close'
    0x53:
      id: 'stop_loss_index'
      doc: 'Stop Loss Index'
    0x54:
      id: 'realtime_index_value'
      doc: 'Realtime Index Value'
  exception:
    0x23:
      id: 'index_with_hsil_defined_exceptional_rule_applied'
      doc: 'Index With Hsil Defined Exceptional Rule Applied'
    0x20:
      id: 'normal_index'
      doc: 'Normal Index'
  cancel_flag:
    0x59:
      id: 'cancelled'
      doc: 'Cancelled'
    0x4e:
      id: 'not_cancelled'
      doc: 'Not Cancelled'
  last_fragment:
    0x59:
      id: 'complete'
      doc: 'Complete'
    0x4e:
      id: 'not_complete'
      doc: 'Not Complete'
  order_imbalance_direction:
    0x4e:
      id: 'buy_equals_sell'
      doc: 'Buy Equals Sell'
    0x42:
      id: 'buy_surplus'
      doc: 'Buy Surplus'
    0x53:
      id: 'sell_surplus'
      doc: 'Sell Surplus'
    0x20:
      id: 'not_applicable_iep_not_available'
      doc: 'Not Applicable Iep Not Available'
  product_type:
    1:
      id: 'equity_ordinary_shares'
      doc: 'Equity Ordinary Shares'
    2:
      id: 'equity_preference_shares'
      doc: 'Equity Preference Shares'
    6:
      id: 'equity_rights'
      doc: 'Equity Rights'
    7:
      id: 'equity_depository_receipt_hdr_ordinary_shares'
      doc: 'Equity Depository Receipt Hdr Ordinary Shares'
    12:
      id: 'equity_depository_receipt_hdr_preference_shares'
      doc: 'Equity Depository Receipt Hdr Preference Shares'
    24:
      id: 'equity_spac_shares'
      doc: 'Equity Spac Shares'
    3:
      id: 'warrant_derivative_warrant_dw'
      doc: 'Warrant Derivative Warrant Dw'
    11:
      id: 'warrant_callable_bull_bear_contract_cbbc'
      doc: 'Warrant Callable Bull Bear Contract Cbbc'
    13:
      id: 'warrant_equity_warrant'
      doc: 'Warrant Equity Warrant'
    15:
      id: 'warrant_inline_warrant'
      doc: 'Warrant Inline Warrant'
    21:
      id: 'warrant_spac_warrants'
      doc: 'Warrant Spac Warrants'
    4:
      id: 'bond_debt_security'
      doc: 'Bond Debt Security'
    8:
      id: 'trust_real_estate_investment_trust_reit'
      doc: 'Trust Real Estate Investment Trust Reit'
    9:
      id: 'trust_other_unit_trusts'
      doc: 'Trust Other Unit Trusts'
    10:
      id: 'trust_leveraged_and_inverse_product_lip'
      doc: 'Trust Leveraged And Inverse Product Lip'
    16:
      id: 'trust_equity_etf'
      doc: 'Trust Equity Etf'
    17:
      id: 'trust_fixed_income_and_money_market_etf'
      doc: 'Trust Fixed Income And Money Market Etf'
    18:
      id: 'trust_commodities_etf'
      doc: 'Trust Commodities Etf'
    99:
      id: 'others_none_of_the_above'
      doc: 'Others None Of The Above'
  vcm_flag:
    0x59:
      id: 'vcm_applicable'
      doc: 'Vcm Applicable'
    0x4e:
      id: 'vcm_not_applicable'
      doc: 'Vcm Not Applicable'
  short_sell_flag:
    0x59:
      id: 'shortsell_allowed'
      doc: 'Shortsell Allowed'
    0x4e:
      id: 'shortsell_not_allowed'
      doc: 'Shortsell Not Allowed'
  cas_flag:
    0x59:
      id: 'cas_applicable'
      doc: 'Cas Applicable'
    0x4e:
      id: 'cas_not_applicable'
      doc: 'Cas Not Applicable'
  ccass_flag:
    0x59:
      id: 'ccass_security'
      doc: 'Ccass Security'
    0x4e:
      id: 'non_ccass_security'
      doc: 'Non Ccass Security'
  dummy_security_flag:
    0x59:
      id: 'dummy_security'
      doc: 'Dummy Security'
    0x4e:
      id: 'normal_security'
      doc: 'Normal Security'
  stamp_duty_flag:
    0x59:
      id: 'stamp_duty_required'
      doc: 'Stamp Duty Required'
    0x4e:
      id: 'stamp_duty_not_required'
      doc: 'Stamp Duty Not Required'
  pos_flag:
    0x59:
      id: 'pos_applicable'
      doc: 'Pos Applicable'
    0x4e:
      id: 'pos_not_applicable'
      doc: 'Pos Not Applicable'
  efn_flag:
    0x59:
      id: 'efn'
      doc: 'Efn'
    0x4e:
      id: 'non_efn'
      doc: 'Non Efn'
  investor_type:
    0x52:
      id: 'retail_investor'
      doc: 'Retail Investor'
    0x50:
      id: 'professional_investor'
      doc: 'Professional Investor'
  call_put_flag:
    0x43:
      id: 'call_or_bull'
      doc: 'Call Or Bull'
    0x50:
      id: 'put_or_bear_range'
      doc: 'Put Or Bear Range'
    0x4f:
      id: 'others'
      doc: 'Others'
  style:
    0x41:
      id: 'american_style'
      doc: 'American Style'
    0x45:
      id: 'european_style'
      doc: 'European Style'
    0x20:
      id: 'other'
      doc: 'Other'
  warrant_type:
    0x4e:
      id: 'normal_instrument'
      doc: 'Normal Instrument'
    0x58:
      id: 'exotic_instrument'
      doc: 'Exotic Instrument'
    0x30:
      id: 'not_available'
      doc: 'Not Available'
  trading_session_sub_id:
    100:
      id: 'not_yet_open_no'
      doc: 'Not Yet Open No'
    1:
      id: 'pos_order_input_oi'
      doc: 'Pos Order Input Oi'
    101:
      id: 'pos_no_cancellation_nw'
      doc: 'Pos No Cancellation Nw'
    108:
      id: 'pos_random_matching_rm'
      doc: 'Pos Random Matching Rm'
    2:
      id: 'pos_order_matching_ma'
      doc: 'Pos Order Matching Ma'
    7:
      id: 'blocking_bl'
      doc: 'Blocking Bl'
    3:
      id: 'continuous_trading_ct'
      doc: 'Continuous Trading Ct'
    105:
      id: 'cas_reference_price_fixing_rp'
      doc: 'Cas Reference Price Fixing Rp'
    5:
      id: 'cas_order_input_oi'
      doc: 'Cas Order Input Oi'
    106:
      id: 'cas_no_cancellation_nw'
      doc: 'Cas No Cancellation Nw'
    107:
      id: 'cas_random_close_rc'
      doc: 'Cas Random Close Rc'
    4:
      id: 'cas_order_matching_ma'
      doc: 'Cas Order Matching Ma'
    102:
      id: 'exchange_intervention_ei'
      doc: 'Exchange Intervention Ei'
    103:
      id: 'close_cl'
      doc: 'Close Cl'
    104:
      id: 'order_cancel_oc'
      doc: 'Order Cancel Oc'
    0:
      id: 'day_close_dc'
      doc: 'Day Close Dc'
  trading_ses_status:
    0:
      id: 'unknown_for_no'
      doc: 'Unknown For No'
    10:
      id: 'halted_for_ei'
      doc: 'Halted For Ei'
    20:
      id: 'pre_open_for_pos_oi_nw_rm_ma_bl'
      doc: 'Pre Open For Pos Oi Nw Rm Ma Bl'
    30:
      id: 'open_for_ct_and_oc'
      doc: 'Open For Ct And Oc'
    40:
      id: 'pre_close_for_cas_rp_oi_nw_rc_ma'
      doc: 'Pre Close For Cas Rp Oi Nw Rc Ma'
    50:
      id: 'closed_for_cl'
      doc: 'Closed For Cl'
    100:
      id: 'day_closed_for_dc'
      doc: 'Day Closed For Dc'
  trading_ses_control_flag:
    0x30:
      id: 'automatic_default'
      doc: 'Automatic Default'
    0x31:
      id: 'manual_invalidates_the_normal_schedule_for_the_day'
      doc: 'Manual Invalidates The Normal Schedule For The Day'
  suspension_indicator:
    2:
      id: 'trading_halt_or_suspend'
      doc: 'Trading Halt Or Suspend'
    3:
      id: 'resume'
      doc: 'Resume'

