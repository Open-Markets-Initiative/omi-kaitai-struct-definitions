# ---------------------------------------------------------------------
# Kaitai struct definition for: Hkex HkexSecurities FullTickRetrans Omd v1.44
#
# Protocol:
#   Organization: Hong Kong Exchanges and Clearing
#   Protocol: Orion Market Data Cash FullTick Retransmission
#   Encoding: Orion Market Data
#   Version: 1.44
#   Date: 7/21/2025
#   Specification: HKEX_OMD-C_Binary_Interface_Specifications_v1.44.pdf
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
  id: hkex_hkexsecurities_fulltickretrans_omd_v1_44
  title: Hkex HkexSecurities FullTickRetrans Omd v1.44
  license: GPL-3.0
  endian: le

doc: 'Hong Kong Exchanges and Clearing Hkex Securities Market Orion Market Data Cash FullTick Retransmission Omd v1.44'
doc-ref: https://www.hkex.com.hk/Mutual-Market/Stock-Connect/Reference-Materials/Technical-Documents

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Omd packet header (byte-identical to the Udp form; SeqNum and SendTime set to 0 on Tcp per §3.5)'
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
        doc: 'Sequence number field — set to 0 on Tcp retrans per §3.5'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'Send time field — set to 0 on Tcp retrans per §3.5. Nanoseconds since Unix epoch'
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
            'msg_type::add_order_message': add_order_message
            'msg_type::sequence_reset_message': sequence_reset_message
            'msg_type::disaster_recovery_signal_message': disaster_recovery_signal_message
            'msg_type::delete_order_message': delete_order_message
            'msg_type::indicative_equilibrium_price_message': indicative_equilibrium_price_message
            'msg_type::modify_order_message': modify_order_message
            'msg_type::order_imbalance_message': order_imbalance_message
            'msg_type::market_definition_message': market_definition_message
            'msg_type::security_definition_message': security_definition_message
            'msg_type::liquidity_provider_message': liquidity_provider_message
            'msg_type::currency_rate_message': currency_rate_message
            'msg_type::reference_price_message': reference_price_message
            'msg_type::refresh_complete_message': refresh_complete_message
            'msg_type::logon_message': logon_message
            'msg_type::logon_response_message': logon_response_message
            'msg_type::retransmission_request_message': retransmission_request_message
            'msg_type::retransmission_response_message': retransmission_response_message
            'msg_type::trading_session_status_message': trading_session_status_message
            'msg_type::security_status_message': security_status_message
            'msg_type::trade_message': trade_message
            'msg_type::trade_cancel_message': trade_cancel_message
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
  add_order_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: order_id
        type: u8
        doc: 'Unique identifier for each order performed within the trading day. Values may not be consecutive'
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
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'New sequence number. Always set to 1'
  disaster_recovery_signal_message:
    seq:
      - id: dr_status
        type: u4
        enum: dr_status
        doc: 'Status during site failover'
  delete_order_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: order_id
        type: u8
        doc: 'Unique identifier for each order performed within the trading day. Values may not be consecutive'
      - id: side
        type: u2
        enum: side
        doc: 'Side of the order'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  indicative_equilibrium_price_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: aggregate_quantity
        type: u8
        doc: 'IEV'
  modify_order_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: order_id
        type: u8
        doc: 'Unique identifier for each order performed within the trading day. Values may not be consecutive'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: side
        type: u2
        enum: side
        doc: 'Side of the order'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: order_book_position
        type: s4
        doc: 'Order rank information for the order position within the order book for each security'
  order_imbalance_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
        doc: 'Base currency code of the market segment'
      - id: number_of_securities
        type: u4
        doc: 'Number of securities within the market segment'
  security_definition_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
        doc: 'Base currency code of the market segment'
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
      - id: face_value
        type: u8
        doc: 'Face value of a bond security. See DecimalsInFaceValue for the number of decimal places. 0 means Not available'
      - id: decimals_in_face_value
        type: u1
        doc: 'Number of decimal places in Face Value. Not applicable if FaceValue = 0'
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
      - id: call_price
        type: s4
        doc: 'Call price for CBBC. See DecimalsInCallPrice for the number of decimal places. 0 means Not available'
      - id: decimals_in_call_price
        type: u1
        doc: 'Number of decimal places in Call Price. Not applicable if CallPrice = 0'
      - id: entitlement
        type: s4
        doc: 'Entitlement of the warrant. See DecimalsInEntitlement for the number of decimal places. 0 means Not available'
      - id: decimals_in_entitlement
        type: u1
        doc: 'Number of decimal places in Entitlement. Not applicable if Entitlement = 0'
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
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
        doc: 'Base currency code of the market segment'
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
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
  logon_message:
    seq:
      - id: username
        type: str
        size: 12
        encoding: ASCII
        doc: 'Username to log on, padded with binary null characters'
  logon_response_message:
    seq:
      - id: session_status
        type: u1
        enum: session_status
        doc: 'Status of the session'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
  retransmission_request_message:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID with which the retransmission relates'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of last message in range to be resent'
  retransmission_response_message:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID with which the retransmission relates'
      - id: retrans_status
        type: u1
        enum: retrans_status
        doc: 'Status of the Retransmission response'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of last message in range to be resent'
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
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
  trade_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: trade_id
        type: u4
        doc: 'Unique identifier per security for each trade performed within the trading system. Starting from 1, incrementing by 1. Reset for each trading day'
      - id: price
        type: decimal_s4_3
        doc: 'Price. 3 implied decimal places. Implied decimal with scale 1e-3'
      - id: quantity
        type: u4
        doc: 'Number of shares'
      - id: trd_type
        type: s2
        enum: trd_type
        doc: 'Public trade type'
      - id: filler_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Padding'
      - id: trade_time
        type: u8
        doc: 'Time of trade. Nanoseconds since Unix epoch UTC. Precision to microsecond'
  trade_cancel_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
      - id: trade_id
        type: u4
        doc: 'Unique identifier per security for each trade performed within the trading system. Starting from 1, incrementing by 1. Reset for each trading day'
  vcm_trigger_message:
    seq:
      - id: security_code
        type: u4
        doc: 'Uniquely identifies a security available for trading. 5 digit security codes with possible values 1 to 99999'
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
  decimal_u4_3:
    seq:
      - id: mantissa
        type: u4
    instances:
      real:
        value: mantissa / 1000.0

enums:
  msg_type:
    30:
      id: 'add_order_message'
      doc: 'The Add Order message is generated when a new order is inserted into the order book. The OrderId is unique per security but will not increment consecutively. Note for Securities instruments the OrderBookPosition is always set to zero.'
    100:
      id: 'sequence_reset_message'
      doc: 'The Sequence Reset message is sent on each multicast channel at start of day. It may also be sent when there is a need for the rectification of stock reference data before market open.'
    105:
      id: 'disaster_recovery_signal_message'
      doc: 'The Disaster Recovery (DR) Signal message is sent on a dedicated multicast channel whenever a site failover scenario is triggered.'
    32:
      id: 'delete_order_message'
      doc: 'The Delete Order message is generated when an existing order identified by the OrderId is deleted.'
    41:
      id: 'indicative_equilibrium_price_message'
      doc: 'The Indicative Equilibrium Price (IEP) message is generated whenever there is change of the IEP or Indicative Equilibrium Volume (IEV) during Pre-Opening Session (POS) or Closing Auction Session (CAS). The IEP is 0 when IEP does not exist.'
    31:
      id: 'modify_order_message'
      doc: 'The Modify Order message is generated when an existing order identified by the OrderId is modified. The only attribute that can be modified is the quantity. Note for Securities instruments the OrderBookPosition is always set to zero.'
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
    101:
      id: 'logon_message'
      doc: 'The Logon message enables client authentication. Not required for multicast channels; only used for retransmission requests.'
    102:
      id: 'logon_response_message'
      doc: 'Response to a Logon request indicating session status.'
    201:
      id: 'retransmission_request_message'
      doc: 'Client-initiated request to retransmit a range of messages from a specific multicast channel.'
    202:
      id: 'retransmission_response_message'
      doc: 'Server response to a Retransmission Request indicating whether the range can be resent.'
    20:
      id: 'trading_session_status_message'
      doc: 'The Trading Session Status provides information on the status of a market segment. It is sent whenever there is change of trading session. This message may be sent on a separate multicast channel from order and trade data and therefore may not be synchronized.'
    21:
      id: 'security_status_message'
      doc: 'The Security Status message is generated at the start of the business day if the security is not available for trading, and whenever a security state changes.'
    50:
      id: 'trade_message'
      doc: 'The Trade message is generated each time a trade has been performed.'
    51:
      id: 'trade_cancel_message'
      doc: 'The Trade Cancel message is generated when a trade has been cancelled.'
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
  dr_status:
    1:
      id: 'dr_in_progress'
      doc: 'Dr In Progress'
    2:
      id: 'dr_completed'
      doc: 'Dr Completed'
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
    14:
      id: 'warrant_equity_linked_instrument_eli'
      doc: 'Warrant Equity Linked Instrument Eli'
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
  session_status:
    0:
      id: 'session_active'
      doc: 'Session Active'
    5:
      id: 'invalid_username_or_ip_address'
      doc: 'Invalid Username Or Ip Address'
    100:
      id: 'user_already_connected'
      doc: 'User Already Connected'
  retrans_status:
    0:
      id: 'request_accepted'
      doc: 'Request Accepted'
    1:
      id: 'unknown_or_unauthorized_channel_id'
      doc: 'Unknown Or Unauthorized Channel Id'
    2:
      id: 'messages_not_available'
      doc: 'Messages Not Available'
    100:
      id: 'exceeds_maximum_sequence_range'
      doc: 'Exceeds Maximum Sequence Range'
    101:
      id: 'exceeds_maximum_requests_in_a_day'
      doc: 'Exceeds Maximum Requests In A Day'
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
  trd_type:
    0:
      id: 'automatch_normal_public_trade_type_space'
      doc: 'Automatch Normal Public Trade Type Space'
    4:
      id: 'late_trade_offexchange_previous_day_public_trade_type_p'
      doc: 'Late Trade Offexchange Previous Day Public Trade Type P'
    22:
      id: 'nondirect_off_exchange_trade_public_trade_type_m'
      doc: 'Nondirect Off Exchange Trade Public Trade Type M'
    100:
      id: 'automatch_internalized_public_trade_type_y'
      doc: 'Automatch Internalized Public Trade Type Y'
    101:
      id: 'direct_offexchange_trade_public_trade_type_x'
      doc: 'Direct Offexchange Trade Public Trade Type X'
    102:
      id: 'odd_lot_trade_public_trade_type_d'
      doc: 'Odd Lot Trade Public Trade Type D'
    103:
      id: 'auction_trade_public_trade_type_u'
      doc: 'Auction Trade Public Trade Type U'
    104:
      id: 'overseas_trade'
      doc: 'Overseas Trade'

