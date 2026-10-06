# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Lse Level2MboReplay Gtp v26.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Level 2 MBO Replay
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
  id: lseg_lse_level2mboreplay_gtp_v26_2
  title: Lseg Lse Level2MboReplay Gtp v26.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange London Stock Exchange Level 2 MBO Replay Gtp v26.2'
doc-ref: https://www.lseg.com/areas-expertise/technology/group-technology/group-ticker-plant

seq:
  - id: tcp_unit
    type: tcp_unit_struct
    repeat: eos
    doc: 'One unit on the tcp stream: the unit header and its payload messages'

types:
  tcp_unit_struct:
    seq:
      - id: unit_header
        type: unit_header
        doc: 'Gtp Tcp Unit Header'
      - id: message
        type: message
        repeat: expr
        repeat-expr: unit_header.message_count
        doc: 'Gtp Tcp Message'
  unit_header:
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
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Gtp Tcp Message Header'
      - id: payload
        size: message_header.message_length - 3
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_request_message': login_request_message
            'message_type::replay_request_message': replay_request_message
            'message_type::login_response_message': login_response_message
            'message_type::replay_response_message': replay_response_message
            'message_type::replay_and_recovery_complete_message': replay_and_recovery_complete_message
            'message_type::system_event_message': system_event_message
            'message_type::instrument_directory_message': instrument_directory_message
            'message_type::instrument_status_message': instrument_status_message
            'message_type::add_order_mbo_message': add_order_mbo_message
            'message_type::add_order_short_mbo_message': add_order_short_mbo_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::trade_message': trade_message
            'message_type::statistics_message': statistics_message
            'message_type::statistics_update_message': statistics_update_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_request_message:
    seq:
      - id: username
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'CompID assigned to the client'
  replay_request_message:
    seq:
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u4
        doc: 'Number of messages to be resent'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
  login_response_message:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Status of the login request'
  replay_response_message:
    seq:
      - id: first_message
        type: u4
        doc: 'Sequence number of the first message in range to be retransmitted'
      - id: count
        type: u4
        doc: 'Number of messages to be resent'
      - id: replay_status
        type: u1
        enum: replay_status
        doc: 'Status of the replay request'
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
  replay_and_recovery_complete_message:
    seq:
      - id: request_id
        type: u4
        doc: 'The value set in this will be echoed back in the corresponding Replay Response. The system will not validate uniqueness of the set value'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session'
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
  add_order_mbo_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order'
      - id: size
        type: decimal_u8_8
        doc: 'Displayed size of the order. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
      - id: participant
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of trading participant that submitted the order'
      - id: depth
        type: u1
        doc: 'Total number of orders disseminated including this one, on this side of the book as indicated by Side field'
  add_order_short_mbo_message:
    seq:
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: size
        type: decimal_u8_8
        doc: 'Displayed size of the order. Implied decimal with scale 1e-8'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: participant
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of trading participant that submitted the order'
  order_book_clear_message:
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
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book the status applies to'
  trade_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'Execution timestamp as reported by the supported market. If a trade is cancelled or amended, this field will contain the transaction time of the original trade. Nanoseconds since Unix epoch'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: executed_size
        type: decimal_u8_8
        doc: 'Total executed quantity. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied decimal with scale 1e-8'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: trade_id
        type: u8
        doc: 'Unique identifier of the trade'
      - id: trade_type
        type: u1
        enum: trade_type
        doc: 'Type of the trade'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'The value in this field is only relevant when Trade Type is 1'
      - id: trade_flags
        type: trade_flags
        doc: 'Trade Flags'
      - id: hidden_execution_indicator
        type: u1
        enum: hidden_execution_indicator
        doc: 'For London Stock Exchange, during continuous trading and CPX session, 1[2] will be sent for execution of visible[hidden] quantities. For London Stock Exchange Auction Trades, 0 will be sent indicating ''Not Applicable'' (N/A)'
      - id: trade_qualifier
        type: u1
        enum: trade_qualifier
        doc: 'Qualifier of the trade'
  trade_flags:
    meta:
      bit-endian: le
    seq:
      - id: trade_cancellation
        type: b1
        doc: 'Trade Cancellation'
      - id: trade_correction
        type: b1
        doc: 'Trade Correction'
      - id: unused_6
        type: b6
        doc: 'Reserved'
  statistics_message:
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
      - id: volume
        type: decimal_u8_4
        doc: 'Cumulative volume of all trades for the trading day. Implied decimal with scale 1e-4'
      - id: volume_onbook_only
        type: decimal_u8_4
        doc: 'Cumulative volume for the trading day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: vwap
        type: decimal_s8_4
        doc: 'Volume weighted average price for the day for all trades. Implied decimal with scale 1e-4'
      - id: vwap_onbook_only
        type: decimal_s8_4
        doc: 'Volume weighted average price for the day excluding off-book trades. Implied decimal with scale 1e-4'
      - id: number_of_trades
        type: u4
        doc: 'Count of all trades for the day'
      - id: number_of_trades_onbook_only
        type: u4
        doc: 'Count of trades for the day excluding off-book trades'
      - id: turnover
        type: decimal_s8_4
        doc: 'Turnover of all trades for the day. Implied decimal with scale 1e-4'
      - id: turnover_onbook_only
        type: decimal_s8_4
        doc: 'Turnover for the day excluding off-book trades. Implied decimal with scale 1e-4'
  statistics_update_message:
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
      - id: statistic_type
        type: u2
        enum: statistic_type
        doc: 'The statistic that is disseminated with this message instance'
      - id: statistic_price
        type: decimal_s8_8
        doc: 'The value of price type statistics. If the Opening or Closing Price is cleared manually by the venue, ''-1'' will be stamped. Implied decimal with scale 1e-8'
      - id: statistic_size
        type: decimal_u8_8
        doc: 'The value of size type statistics. Implied decimal with scale 1e-8'
      - id: auction_type
        type: u1
        enum: auction_type
        doc: 'The value in this field is only relevant when Trade Type is 1'
      - id: imbalance_quantity
        type: decimal_u8_8
        doc: 'Quantity that is eligible to be matched at the indicative price but will not be matched. Implied decimal with scale 1e-8'
      - id: auction_info
        type: u1
        enum: auction_info
        doc: 'Populated if the Statistic Type is 1'
      - id: opening_closing_price_indicator
        type: u1
        enum: opening_closing_price_indicator
        doc: 'Populated if the Statistic Type is 2 or 3'
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
  decimal_u8_8:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 100000000.0
  decimal_u8_4:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 10000.0

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the replay or recovery channel.'
    0x03:
      id: 'replay_request_message'
      doc: 'Used by the client to request a retransmission of messages on the replay channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request to the replay or recovery channel.'
    0x04:
      id: 'replay_response_message'
      doc: 'Used by the server to respond to a retransmission request on the replay channel.'
    0x83:
      id: 'replay_and_recovery_complete_message'
      doc: 'Used by the server to indicate the successful completion of servicing a message replay or a recovery request.'
    0x53:
      id: 'system_event_message'
      doc: 'Sent to indicate the start and end of the day.'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a common and limited set of data for all configured instrument types, except strategy instruments, on the real-time channels.'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate scheduled and unscheduled session changes. When sent in the recovery channel, used to indicate the current trading status of an instrument.'
    0x41:
      id: 'add_order_mbo_message'
      doc: 'Indicates the first order of a given side of an MBO snapshot.'
    0x65:
      id: 'add_order_short_mbo_message'
      doc: 'Used to indicate individual orders of an MBO snapshot.'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all orders from the order book for the specified instrument.'
    0x50:
      id: 'trade_message'
      doc: 'Sent to indicate trades executed on supported markets.'
    0x77:
      id: 'statistics_message'
      doc: 'Contains a set of statistics that are updated frequently, usually as a result of executions.'
    0x6a:
      id: 'statistics_update_message'
      doc: 'Contains a set of statistics that are not updated frequently.'
  login_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x61:
      id: 'comp_id_inactive_suspended'
      doc: 'Comp Id Inactive Suspended'
    0x62:
      id: 'login_limit_reached'
      doc: 'Login Limit Reached'
    0x63:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
    0x64:
      id: 'maximum_connections_limit_reached'
      doc: 'Maximum Connections Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
    0x66:
      id: 'invalid_comp_id_or_ip_address'
      doc: 'Invalid Comp Id Or Ip Address'
  replay_status:
    0x41:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x44:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x55:
      id: 'replay_unavailable'
      doc: 'Replay Unavailable'
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
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
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  trade_type:
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
      id: 'onbook_trade_cancellation'
      doc: 'Onbook Trade Cancellation'
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
  hidden_execution_indicator:
    0:
      id: 'na'
      doc: 'Na'
    1:
      id: 'visible'
      doc: 'Visible'
    2:
      id: 'hidden'
      doc: 'Hidden'
  trade_qualifier:
    0x20:
      id: 'na'
      doc: 'Na'
    0x43:
      id: 'closing_price_cross_cpx'
      doc: 'Closing Price Cross Cpx'
  statistic_type:
    1:
      id: 'indicative_auction_uncrossing_data'
      doc: 'Indicative Auction Uncrossing Data'
    2:
      id: 'official_opening_price'
      doc: 'Official Opening Price'
    3:
      id: 'official_closing_price'
      doc: 'Official Closing Price'
    4:
      id: 'trade_high_on_book'
      doc: 'Trade High On Book'
    5:
      id: 'trade_low_on_book'
      doc: 'Trade Low On Book'
    6:
      id: 'trade_high_all_trades'
      doc: 'Trade High All Trades'
    7:
      id: 'trade_low_all_trades'
      doc: 'Trade Low All Trades'
    8:
      id: 'fifty_two_week_trade_high_all_trades'
      doc: 'Fifty Two Week Trade High All Trades'
    9:
      id: 'fifty_two_week_trade_low_all_trades'
      doc: 'Fifty Two Week Trade Low All Trades'
    10:
      id: 'best_closing_bid'
      doc: 'Best Closing Bid'
    11:
      id: 'best_closing_ask'
      doc: 'Best Closing Ask'
    16:
      id: 'static_reference_price'
      doc: 'Static Reference Price'
    17:
      id: 'dynamic_reference_price'
      doc: 'Dynamic Reference Price'
  auction_info:
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x42:
      id: 'buy_imbalance'
      doc: 'Buy Imbalance'
    0x4e:
      id: 'no_imbalance'
      doc: 'No Imbalance'
    0x4f:
      id: 'insufficient_orders_for_auction'
      doc: 'Insufficient Orders For Auction'
    0x53:
      id: 'sell_imbalance'
      doc: 'Sell Imbalance'
  opening_closing_price_indicator:
    0x41:
      id: 'ut'
      doc: 'Ut'
    0x42:
      id: 'at'
      doc: 'At'
    0x43:
      id: 'mid_of_bbo'
      doc: 'Mid Of Bbo'
    0x44:
      id: 'last_at'
      doc: 'Last At'
    0x45:
      id: 'last_ut'
      doc: 'Last Ut'
    0x46:
      id: 'manual'
      doc: 'Manual'
    0x49:
      id: 'previous_close'
      doc: 'Previous Close'

