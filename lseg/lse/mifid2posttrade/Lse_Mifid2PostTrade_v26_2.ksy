# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Lse Mifid2PostTrade Gtp v26.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: MiFID II Post Trade
#   Encoding: Group Ticker Plant
#   Version: 26.2
#   Date: 10/15/2025
#   Specification: gtp-002-technical-guide-london-stock-exchange-issue-26.2.pdf
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
  id: lseg_lse_mifid2posttrade_gtp_v26_2
  title: Lseg Lse Mifid2PostTrade Gtp v26.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange London Stock Exchange MiFID II Post Trade Gtp v26.2'
doc-ref: https://www.lseg.com/areas-expertise/technology/group-technology/group-ticker-plant

seq:
  - id: unit_header
    type: unit_header_struct
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: unit_header.message_count

types:
  unit_header_struct:
    seq:
      - id: length
        type: u2
        doc: 'Length of the message block including the header and all payload messages'
      - id: message_count
        type: u1
        doc: 'Number of payload messages that will follow the header'
      - id: market_data_group
        type: str
        size: 1
        encoding: ASCII
        doc: 'Identity of the market data group the payload messages relate to'
      - id: sequence_number
        type: u4
        doc: 'Sequence number of the first payload message'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'Gtp Udp Message Header'
      - id: payload
        size: message_header.message_length - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::system_event_message': system_event_message
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::mifid_ii_trade_message': mifid_ii_trade_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Start or end of day event code'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
  instrument_directory_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code of an instrument'
      - id: allowed_book_types
        type: allowed_book_types
        doc: 'Defines the order-book types that are allowed for the instrument'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: venue_instrument_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identifier used by the source venue'
      - id: tick_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The tick structure applicable for the instrument'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: dynamic_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Dynamic Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: static_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Static Circuit Breaker Tolerance (%) of the instrument. Implied decimal with scale 1e-8'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
      - id: reserved_11
        size: 11
        doc: 'Reserved for future use'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217'
      - id: partition_id
        type: str
        size: 1
        encoding: ASCII
        doc: 'Trading System''s partition in which the instrument is traded'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: average_daily_turnover_adt
        type: decimal_s8_4
        doc: 'Not Applicable to LSE. Implied decimal with scale 1e-4'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: fourth_reserved_8
        size: 8
        doc: 'Reserved for future use'
  allowed_book_types:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved'
      - id: firm_quote_book
        type: b1
        doc: 'Firm Quote Book'
      - id: offbook
        type: b1
        doc: 'Off-book'
      - id: electronic_order_book
        type: b1
        doc: 'Electronic Order Book'
      - id: private_rfq
        type: b1
        doc: 'Private RFQ'
      - id: unused_3
        type: b3
        doc: 'Reserved'
  instrument_status_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current trading status of the instrument'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason the trading session changed'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'New time the session will end. The field will contain only spaces if Session Change Reason is ''0'' or the Session Change Reason is not present. New End Time will be in terms of the local time on the server (i.e., not UTC)'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
  mifid_ii_trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: transaction_identification_code
        type: str
        size: 52
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique trade identifier. The value will be right aligned'
      - id: mifid_trade_type
        type: u1
        enum: mifid_trade_type
        doc: 'Type of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'The value in this field is only relevant when Trade Type is 1'
      - id: mifid_price
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'MiFID compliant Price field populated using either Price or Percentage. {DECIMAL-18/13} in case the price is expressed as monetary value. {DECIMAL-11/10} in case the price is expressed as percentage'
      - id: mifid_quantity
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Number of units of the financial instrument. {DECIMAL-18/17} Will be set to default value (20 spaces) if the traded security is a bond'
      - id: trading_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was executed/agreed upon. If a trade is cancelled or amended, this field will contain the Trading Date and Time of the original trade'
      - id: instrument_identification_code_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Only relevant for non-equity instruments. Empty for equity and equity-like instruments'
      - id: instrument_identification_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument identification number (ISIN code)'
      - id: price_notation
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates if the price is expressed in monetary value or in percentage. Only relevant for non-equity instruments'
      - id: price_major_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major currency in which the price is expressed (applicable if the price is expressed as monetary value). Currency Code as per ISO 4217'
      - id: notional_amount
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Notional value relevant to the security. {DECIMAL-18/5} Only relevant for non-equity instruments'
      - id: notional_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Major Currency in which the notional amount is denominated. Only relevant for non-equity instruments'
      - id: venue_of_execution
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the venue where the transaction was executed'
      - id: publication_date_and_time
        type: str
        size: 27
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date and time when the transaction was published'
      - id: pt_ref_price_waiver_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to LSE'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: market_closing_price_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market closing price flag'
      - id: pt_algo_trade
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Algorithmic trade flag'
      - id: pt_cancellation_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade cancellation flag'
      - id: pt_amendment_flag
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trade amendment flag'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_3
        size: 3
        doc: 'Reserved for future use'
      - id: reserved_20
        size: 20
        doc: 'Reserved for future use'
      - id: second_reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: trade_qualifier
        type: u1
        enum: trade_qualifier
        doc: 'Qualifier of the trade'
      - id: market_mechanism
        type: u1
        enum: market_mechanism
        doc: 'Market mechanism the trade was executed under'
      - id: trading_mode
        type: u1
        enum: trading_mode
        doc: 'Trading mode the trade was executed under'
      - id: transaction_category
        type: u1
        enum: transaction_category
        doc: 'Category of the transaction'
      - id: negotiation_indicator
        type: u1
        enum: negotiation_indicator
        doc: 'Indicates whether the trade was negotiated'
      - id: agency_cross_indicator
        type: u1
        enum: agency_cross_indicator
        doc: 'Indicates whether the trade was an agency cross'
      - id: modification_indicator
        type: u1
        enum: modification_indicator
        doc: 'Indicates whether the report cancels or amends a previous report'
      - id: reference_price_indicator
        type: u1
        enum: reference_price_indicator
        doc: 'Indicates whether the trade was a reference price trade'
      - id: special_dividend_indicator
        type: u1
        enum: special_dividend_indicator
        doc: 'Indicates whether the trade was a special dividend trade'
      - id: off_book_automated_indicator
        type: u1
        enum: off_book_automated_indicator
        doc: 'Indicates whether the off book trade was automated'
      - id: price_formation_indicator
        type: u1
        enum: price_formation_indicator
        doc: 'Indicates how the price was formed'
      - id: algorithmic_indicator
        type: u1
        enum: algorithmic_indicator
        doc: 'Indicates whether the trade was algorithmic'
      - id: post_trade_deferral_reason
        type: u1
        enum: post_trade_deferral_reason
        doc: 'Reason publication of the trade was deferred'
      - id: deferral_enrichment_type
        type: u1
        enum: deferral_enrichment_type
        doc: 'Type of deferral or enrichment applied'
      - id: duplicative_indicator
        type: u1
        enum: duplicative_indicator
        doc: 'Indicates whether the trade report is duplicative'
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
  decimal_s8_4:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 10000.0
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

enums:
  message_type:
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types, except strategy instruments, on the real-time channels.'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes. When sent in the recovery channel, used to indicate the current trading status of an instrument.'
    0x51:
      id: 'mifid_ii_trade_message'
      doc: 'Sent to represent different types of MiFID compliant trades published by markets.'
  event_code:
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
  source_venue:
    1:
      id: 'london_stock_exchange'
      doc: 'London Stock Exchange'
  trading_status:
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x4a:
      id: 'halt_matching_partition_suspended'
      doc: 'Halt Matching Partition Suspended'
    0x4b:
      id: 'halt_system_suspended'
      doc: 'Halt System Suspended'
    0x54:
      id: 'regular_trading_start_trade_reporting'
      doc: 'Regular Trading Start Trade Reporting'
    0x50:
      id: 'halt_regulatory'
      doc: 'Halt Regulatory'
    0x74:
      id: 'end_trade_reporting'
      doc: 'End Trade Reporting'
    0x61:
      id: 'opening_auction_call'
      doc: 'Opening Auction Call'
    0x62:
      id: 'post_close'
      doc: 'Post Close'
    0x63:
      id: 'closed'
      doc: 'Closed'
    0x64:
      id: 'closing_auction_call'
      doc: 'Closing Auction Call'
    0x65:
      id: 'aesp_auction_call'
      doc: 'Aesp Auction Call'
    0x66:
      id: 'resume_auction'
      doc: 'Resume Auction'
    0x6d:
      id: 'pre_mandatory'
      doc: 'Pre Mandatory'
    0x6e:
      id: 'mandatory'
      doc: 'Mandatory'
    0x6f:
      id: 'post_mandatory'
      doc: 'Post Mandatory'
    0x71:
      id: 'edsp_auction_call'
      doc: 'Edsp Auction Call'
    0x72:
      id: 'periodic_auction_call'
      doc: 'Periodic Auction Call'
    0x31:
      id: 'inactive'
      doc: 'Inactive'
    0x32:
      id: 'suspended'
      doc: 'Suspended'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x75:
      id: 'closing_price_crossing_session'
      doc: 'Closing Price Crossing Session'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
    1:
      id: 'extended_by_market_ops'
      doc: 'Extended By Market Ops'
    2:
      id: 'shortened_by_market_ops'
      doc: 'Shortened By Market Ops'
    3:
      id: 'market_order_imbalance'
      doc: 'Market Order Imbalance'
    4:
      id: 'price_outside_range'
      doc: 'Price Outside Range'
    5:
      id: 'aesp_circuit_breaker_tripped'
      doc: 'Aesp Circuit Breaker Tripped'
    9:
      id: 'unavailable'
      doc: 'Unavailable'
  order_book_type:
    1:
      id: 'firm_quote_book'
      doc: 'Firm Quote Book'
    2:
      id: 'offbook'
      doc: 'Offbook'
    3:
      id: 'electronic_order_book'
      doc: 'Electronic Order Book'
    4:
      id: 'private_rfq'
      doc: 'Private Rfq'
  mifid_trade_type:
    0:
      id: 'regular_or_continuous_trade'
      doc: 'Regular Or Continuous Trade'
    1:
      id: 'auction_trade_bulk'
      doc: 'Auction Trade Bulk'
    2:
      id: 'auction_trade_individual'
      doc: 'Auction Trade Individual'
    9:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
    11:
      id: 'trade_correction'
      doc: 'Trade Correction'
    22:
      id: 'rfq_trade'
      doc: 'Rfq Trade'
    23:
      id: 'rfq_trade_cancellation'
      doc: 'Rfq Trade Cancellation'
    24:
      id: 'rfq_trade_correction'
      doc: 'Rfq Trade Correction'
  auction_type:
    0x43:
      id: 'closing_auction'
      doc: 'Closing Auction'
    0x4f:
      id: 'opening_auction'
      doc: 'Opening Auction'
    0x41:
      id: 'aesp'
      doc: 'Aesp'
    0x42:
      id: 'edsp'
      doc: 'Edsp'
    0x45:
      id: 'resume_auction'
      doc: 'Resume Auction'
    0x46:
      id: 'periodic_auction'
      doc: 'Periodic Auction'
  trade_qualifier:
    0x20:
      id: 'na'
      doc: 'Na'
    0x43:
      id: 'closing_price_cross_cpx'
      doc: 'Closing Price Cross Cpx'
  market_mechanism:
    0x31:
      id: 'central_limit_order_book'
      doc: 'Central Limit Order Book'
    0x36:
      id: 'request_for_quote'
      doc: 'Request For Quote'
  trading_mode:
    0x4f:
      id: 'scheduled_opening_auction'
      doc: 'Scheduled Opening Auction'
    0x4b:
      id: 'scheduled_closing_auction'
      doc: 'Scheduled Closing Auction'
    0x49:
      id: 'scheduled_intraday_auction'
      doc: 'Scheduled Intraday Auction'
    0x55:
      id: 'unscheduled_auction'
      doc: 'Unscheduled Auction'
    0x32:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x33:
      id: 'at_market_close_trading'
      doc: 'At Market Close Trading'
  transaction_category:
    0x44:
      id: 'dark_trade'
      doc: 'Dark Trade'
    0x2d:
      id: 'none_apply'
      doc: 'None Apply'
  negotiation_indicator:
    0x2d:
      id: 'not_a_negotiated_trade'
      doc: 'Not A Negotiated Trade'
  agency_cross_indicator:
    0x2d:
      id: 'no_agency_cross_trade'
      doc: 'No Agency Cross Trade'
  modification_indicator:
    0x43:
      id: 'trade_cancellation_canc'
      doc: 'Trade Cancellation Canc'
    0x41:
      id: 'trade_amendment_amnd'
      doc: 'Trade Amendment Amnd'
    0x2d:
      id: 'new_trade'
      doc: 'New Trade'
  reference_price_indicator:
    0x31:
      id: 'market_closing_price_trade_clse'
      doc: 'Market Closing Price Trade Clse'
    0x2d:
      id: 'not_a_reference_price_trade'
      doc: 'Not A Reference Price Trade'
  special_dividend_indicator:
    0x2d:
      id: 'no_special_dividend_trade'
      doc: 'No Special Dividend Trade'
  off_book_automated_indicator:
    0x2d:
      id: 'unspecified_or_does_not_apply'
      doc: 'Unspecified Or Does Not Apply'
  price_formation_indicator:
    0x50:
      id: 'plain_vanilla_trade'
      doc: 'Plain Vanilla Trade'
  algorithmic_indicator:
    0x48:
      id: 'algorithmic_trade_algo'
      doc: 'Algorithmic Trade Algo'
    0x2d:
      id: 'not_an_algorithmic_trade'
      doc: 'Not An Algorithmic Trade'
  post_trade_deferral_reason:
    0x2d:
      id: 'immediate_publication'
      doc: 'Immediate Publication'
  deferral_enrichment_type:
    0x2d:
      id: 'not_applicable_no_relevant_enrichment_type'
      doc: 'Not Applicable No Relevant Enrichment Type'
  duplicative_indicator:
    0x2d:
      id: 'unique_trade_report'
      doc: 'Unique Trade Report'

