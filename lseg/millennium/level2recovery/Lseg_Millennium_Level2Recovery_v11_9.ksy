# ---------------------------------------------------------------------
# Kaitai struct definition for: Lseg Millennium Level2Recovery Mitch v11.9
#
# Protocol:
#   Organization: London Stock Exchange
#   Protocol: 
#   Encoding: Millennium Itch
#   Version: 11.9
#   Date: 8/28/2018
#   Specification: mit303issue119.pdf
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
  id: lseg_millennium_level2recovery_mitch_v11_9
  title: Lseg Millennium Level2Recovery Mitch v11.9
  license: GPL-3.0
  endian: le

doc: 'London Stock Exchange Millennium Exchange Mitch v11.9'
doc-ref: https://docs.londonstockexchange.com/sites/default/files/documents/mit303issue119.pdf

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
      - id: message
        type: message
        repeat: expr
        repeat-expr: unit_header.message_count
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
        doc: 'Sequence number from which client can build the order book, only required for instrument level requests'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mitch Tcp Message Header'
      - id: payload
        size: message_header.message_length - 2
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::login_request_message': login_request_message
            'message_type::login_response_message': login_response_message
            'message_type::snapshot_request_message': snapshot_request_message
            'message_type::snapshot_response_message': snapshot_response_message
            'message_type::snapshot_complete_message': snapshot_complete_message
            'message_type::symbol_status_message': symbol_status_message
            'message_type::add_order_message': add_order_message
            'message_type::add_attributed_order_message': add_attributed_order_message
  message_header:
    seq:
      - id: message_length
        type: u1
        doc: 'Length of message including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  login_request_message:
    seq:
      - id: username
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'CompID assigned to the client'
      - id: password
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Password assigned to the CompID'
  login_response_message:
    seq:
      - id: login_status
        type: u1
        enum: login_status
        doc: 'Status of the login request'
  snapshot_request_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number from which client can build the order book, only required for instrument level requests'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the request relates to. The field should contain only spaces if the Instrument ID field is populated'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. The field should contain only zeros if it does not relate to an instrument'
  snapshot_response_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number from which client can build the order book, only required for instrument level requests'
      - id: order_count
        type: u4
        doc: 'This field will always be populated with 0'
      - id: snapshot_status
        type: u1
        enum: snapshot_status
        doc: 'Status of the snapshot request'
  snapshot_complete_message:
    seq:
      - id: sequence_number
        type: u4
        doc: 'Sequence number from which client can build the order book, only required for instrument level requests'
      - id: segment
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment the request relates to. The field should contain only spaces if the Instrument ID field is populated'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. The field should contain only zeros if it does not relate to an instrument'
      - id: snapshot_complete_flags
        type: snapshot_complete_flags
        doc: 'Snapshot Complete Flags'
  snapshot_complete_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: rfq_quote
        type: b1
        doc: 'RFQ Quote'
      - id: unused_1
        type: b1
        doc: 'Unused'
  symbol_status_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last Time message, accurate to the nearest microsecond'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. The field should contain only zeros if it does not relate to an instrument'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: trading_status
        type: u1
        enum: trading_status
        doc: 'Trading Status'
      - id: symbol_status_flags
        type: symbol_status_flags
        doc: 'Symbol Status Flags'
      - id: reason
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for the manual session change or the trading halt'
      - id: session_change_reason
        type: u1
        enum: session_change_reason
        doc: 'Session Change Reason'
      - id: new_end_time
        type: str
        size: 8
        encoding: ASCII
        doc: 'New time the session will end. Will only be stamped if the session change was not in the original schedule e.g. AESP auction call or unscheduled session'
      - id: book_type
        type: u1
        enum: book_type
        doc: 'Book Type'
  symbol_status_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_5
        type: b5
        doc: 'Unused'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'
  add_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last Time message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. The field should contain only zeros if it does not relate to an instrument'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: add_order_flags
        type: add_order_flags
        doc: 'Add Order Flags'
      - id: reserved_10
        size: 10
        doc: 'Reserved field'
  add_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: market_order
        type: b1
        doc: 'Market Order'
      - id: unused_1
        type: b1
        doc: 'Unused'
      - id: private_rfq
        type: b1
        doc: 'Private RFQ'
      - id: second_unused_1
        type: b1
        doc: 'Unused'
  add_attributed_order_message:
    seq:
      - id: nanosecond
        type: u4
        doc: 'Nanoseconds since last Time message, accurate to the nearest microsecond'
      - id: order_id
        type: u8
        doc: 'Unique identifier of the order'
      - id: side
        type: u1
        enum: side
        doc: 'Side'
      - id: quantity
        type: u4
        doc: 'Displayed quantity of the order'
      - id: instrument_id
        type: u4
        doc: 'Instrument the request relates to. The field should contain only zeros if it does not relate to an instrument'
      - id: reserved_a
        size: 1
        doc: 'Reserved field'
      - id: reserved_b
        size: 1
        doc: 'Reserved field'
      - id: price
        type: s8
        doc: 'Limit price of the order'
      - id: attribution
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identity of firm that submitted the order'
      - id: add_attributed_order_flags
        type: add_attributed_order_flags
        doc: 'Add Attributed Order Flags'
  add_attributed_order_flags:
    meta:
      bit-endian: le
    seq:
      - id: unused_4
        type: b4
        doc: 'Unused'
      - id: named_market_order
        type: b1
        doc: 'Named Market Order'
      - id: firm_quote
        type: b1
        doc: 'Firm Quote'
      - id: unused_2
        type: b2
        doc: 'Unused'

enums:
  message_type:
    0x01:
      id: 'login_request_message'
      doc: 'Used by the client to log in to the recovery channel.'
    0x02:
      id: 'login_response_message'
      doc: 'Used by the server to accept or reject a login request.'
    0x81:
      id: 'snapshot_request_message'
      doc: 'Used by the client to request a snapshot of the order book for a segment or an instrument.'
    0x82:
      id: 'snapshot_response_message'
      doc: 'Used by the server to accept or reject a snapshot request.'
    0x83:
      id: 'snapshot_complete_message'
      doc: 'Sent once the details of all active orders of an order book, or of every instrument in a segment, are disseminated.'
    0x05:
      id: 'logout_request_message'
      doc: 'Used by the client to log out of the recovery channel.'
    0x48:
      id: 'symbol_status_message'
      doc: 'Indicates the trading session (pre-opening, regular trading, etc.) that currently applies to an instrument.'
    0x41:
      id: 'add_order_message'
      doc: 'Sent to indicate that an anonymous limit or market order is added to the order book.'
    0x46:
      id: 'add_attributed_order_message'
      doc: 'Indicates that a named order is added to the order book.'
  login_status:
    0x41:
      id: 'login_accepted'
      doc: 'Login Accepted'
    0x61:
      id: 'comp_id_inactive_locked'
      doc: 'Comp Id Inactive Locked'
    0x62:
      id: 'login_limit_reached'
      doc: 'Login Limit Reached'
    0x63:
      id: 'service_unavailable'
      doc: 'Service Unavailable'
    0x64:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
  snapshot_status:
    0x41:
      id: 'request_accepted'
      doc: 'Request Accepted'
    0x4f:
      id: 'out_of_range'
      doc: 'Out Of Range'
    0x55:
      id: 'snapshot_unavailable'
      doc: 'Snapshot Unavailable'
    0x61:
      id: 'valid_segment_or_symbol_not_specified'
      doc: 'Valid Segment Or Symbol Not Specified'
    0x62:
      id: 'request_limit_reached'
      doc: 'Request Limit Reached'
    0x63:
      id: 'concurrent_limit_reached'
      doc: 'Concurrent Limit Reached'
    0x64:
      id: 'unsupported_message_type'
      doc: 'Unsupported Message Type'
    0x65:
      id: 'failed_other'
      doc: 'Failed Other'
  trading_status:
    0x20:
      id: 'active'
      doc: 'Active'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x54:
      id: 'regular_trading_start_of_trade_reporting'
      doc: 'Regular Trading Start Of Trade Reporting'
    0x61:
      id: 'opening_first_auction_call'
      doc: 'Opening First Auction Call'
    0x62:
      id: 'post_close'
      doc: 'Post Close'
    0x63:
      id: 'market_close_system_shutdown'
      doc: 'Market Close System Shutdown'
    0x64:
      id: 'closing_auction_call'
      doc: 'Closing Auction Call'
    0x65:
      id: 'aesp_auction_call'
      doc: 'Aesp Auction Call'
    0x66:
      id: 'resume_auction_call'
      doc: 'Resume Auction Call'
    0x6c:
      id: 'pause'
      doc: 'Pause'
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
    0x74:
      id: 'end_trade_reporting'
      doc: 'End Trade Reporting'
    0x77:
      id: 'no_active_session'
      doc: 'No Active Session'
    0x78:
      id: 'end_of_post_close'
      doc: 'End Of Post Close'
    0x75:
      id: 'closing_price_crossing'
      doc: 'Closing Price Crossing'
    0x47:
      id: 'scheduled_level_1_only_auction'
      doc: 'Scheduled Level 1 Only Auction'
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
    9:
      id: 'unavailable_recovery_service_only'
      doc: 'Unavailable Recovery Service Only'
  book_type:
    1:
      id: 'on_book'
      doc: 'On Book'
    2:
      id: 'off_book'
      doc: 'Off Book'
    3:
      id: 'private_rfq'
      doc: 'Private Rfq'
  side:
    0x42:
      id: 'buy_order'
      doc: 'Buy Order'
    0x53:
      id: 'sell_order'
      doc: 'Sell Order'

