# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg TradeEcho Level2IncrementalReplay Gtp v26.1.2
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: Level 2 Incremental Replay
#   Encoding: Group Ticker Plant
#   Version: 26.1.2
#   Date: 01/27/2026
#   Specification: gtp-002-technical-guide-tradecho-pre-trade-si-quote-issue-26-1-2_0.pdf
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
  id: lseg_tradeecho_level2incrementalreplay_gtp_v26_1_2
  title: Lseg TradeEcho Level2IncrementalReplay Gtp v26.1.2
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange TRADEcho Level 2 Incremental Replay Gtp v26.1.2'
doc-ref: https://www.londonstockexchange.com/resources/equities-trading-resources/gtp-technical-specifications

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
            'message_type::delete_order_message': delete_order_message
            'message_type::order_book_clear_message': order_book_clear_message
            'message_type::si_quote_message': si_quote_message
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session. Blank if not applicable'
  system_event_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Session transition event'
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
        doc: 'Not Applicable to TRADEcho'
      - id: price_band_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: dynamic_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: static_circuit_breaker_tolerances
        type: decimal_s8_8
        doc: 'Not Applicable to TRADEcho. Implied decimal with scale 1e-8'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the instrument is assigned to. UVIN for the Non-XLON Instrument Universe, otherwise the XLON Instrument Universe segment code'
      - id: reserved_12
        size: 12
        doc: 'Reserved for future use'
      - id: security_exchange
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Not Applicable to TRADEcho'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217. For additional currencies supported refer to the Additional Field Values section of this document'
      - id: reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: reserved_4
        size: 4
        doc: 'Reserved for future use'
      - id: average_daily_turnover_adt
        type: decimal_s8_4
        doc: 'Average Daily Turnover as reported by the Source Venue. Implied decimal with scale 1e-4'
      - id: reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: second_reserved_1
        size: 1
        doc: 'Reserved for future use'
      - id: second_reserved_8
        size: 8
        doc: 'Reserved for future use'
      - id: third_reserved_8
        size: 8
        doc: 'Reserved for future use'
  allowed_book_types:
    meta:
      bit-endian: le
    seq:
      - id: unused_1
        type: b1
        doc: 'Reserved for future use'
      - id: si_quote_book
        type: b1
        doc: 'SI Quote book trading is allowed for the instrument'
      - id: unused_6
        type: b6
        doc: 'Reserved for future use'
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
        doc: 'Current Trading status of the Instrument. Populated only when the message is sent at the end of individual order book snapshots during a trading session. Blank if not applicable'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Reason for the session change'
      - id: new_end_time
        type: hhmmss_ascii_time
        doc: 'Not Applicable to TRADEcho'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book type the status applies to'
  delete_order_message:
    seq:
      - id: timestamp
        type: nanosecond_timestamp
        doc: 'Time the message was generated. Nanoseconds since Unix epoch'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: side
        type: u1
        enum: side
        doc: 'Side of the order that was deleted'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book type the status applies to'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: previous_price
        type: decimal_s8_8
        doc: 'Price of the order that was deleted from the book. Implied decimal with scale 1e-8'
      - id: previous_quantity
        type: decimal_u8_8
        doc: 'Quantity of the order that was deleted from the book. Implied decimal with scale 1e-8'
      - id: internal_id
        type: u8
        doc: 'Internal ID for system use. This field should be ignored by consumers'
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
        doc: 'Order book type the status applies to'
  si_quote_message:
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
        doc: 'Side of the order that was deleted'
      - id: size
        type: decimal_u8_8
        doc: 'Displayed Size of the order. Implied decimal with scale 1e-8'
      - id: instrument
        type: u8
        doc: 'GTP Instrument identifier'
      - id: price
        type: decimal_s8_8
        doc: 'Limit price of the order. Implied price if instrument trades in yield. Implied decimal with scale 1e-8'
      - id: internal_id
        type: u8
        doc: 'Internal ID for system use. This field should be ignored by consumers'
      - id: source_venue
        type: u2
        enum: source_venue
        doc: 'Venue from which market data is received for the instrument'
      - id: order_book_type
        type: u1
        enum: order_book_type
        doc: 'Order book type the status applies to'
      - id: participant
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of trading participant that submitted the order'
      - id: order_type
        type: u1
        enum: order_type
        doc: 'Type of the order'
      - id: reserved_10
        size: 10
        doc: 'Reserved field'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Code as per ISO 4217. For additional currencies supported refer to the Additional Field Values section of this document'
      - id: venue_of_publication
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identification of the regulatory regime under which the transaction was published. The value sent by the source venue is passed on'
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

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the replay or recovery channel'
    0x03:
      id: 'replay_request_message'
      doc: 'Used by the client to request a retransmission of messages on the replay channel'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request to the replay or recovery channel'
    0x04:
      id: 'replay_response_message'
      doc: 'Used by the server to respond to a retransmission request on the replay channel'
    0x83:
      id: 'replay_and_recovery_complete_message'
      doc: 'Used by the server to indicate the successful completion of servicing a message replay or a recovery request'
    0x53:
      id: 'system_event_message'
      doc: 'Broadcast at the start and end of day on TRADEcho. Customers should consider the SI Quote book to be empty following receipt of this message; no explicit Order Book Clear or delete order messages will be sent'
    0x70:
      id: 'instrument_directory_message'
      doc: 'Used to disseminate a limited set of data for all configured instrument types on the real-time channels'
    0x48:
      id: 'instrument_status_message'
      doc: 'Used to communicate status of an instrument. Instrument status messages are disseminated prior to system event start of day message'
    0x44:
      id: 'delete_order_message'
      doc: 'Sent to instruct recipients to delete a quote'
    0x79:
      id: 'order_book_clear_message'
      doc: 'Sent to instruct recipients to remove all quotes from the book for the specified instrument'
    0x47:
      id: 'si_quote_message'
      doc: 'Publishing Systematic Internaliser (SI) Quotes'
  login_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x61:
      id: 'comp_id_inactive_or_suspended'
      doc: 'Comp Id Inactive Or Suspended'
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
    0x31:
      id: 'inactive'
      doc: 'Inactive'
    0x32:
      id: 'suspended'
      doc: 'Suspended'
    0x33:
      id: 'active'
      doc: 'Active'
    0x50:
      id: 'regulatory_halt'
      doc: 'Regulatory Halt'
  event_code:
    0x4f:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x54:
      id: 'start_of_open'
      doc: 'Start Of Open'
    0x50:
      id: 'start_of_pre_close'
      doc: 'Start Of Pre Close'
    0x43:
      id: 'end_of_day'
      doc: 'End Of Day'
  source_venue:
    11:
      id: 'trad_echo'
      doc: 'Trad Echo'
  session_change_reason:
    0:
      id: 'scheduled_transition'
      doc: 'Scheduled Transition'
  order_book_type:
    1:
      id: 'si_quote_book'
      doc: 'Si Quote Book'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'
  order_type:
    0:
      id: 'si_quote'
      doc: 'Si Quote'

