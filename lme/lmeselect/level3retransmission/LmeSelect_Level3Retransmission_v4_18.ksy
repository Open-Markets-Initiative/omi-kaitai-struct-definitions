# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect Level3Retransmission LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource Level3 Retransmission
#   Encoding: LMEsource
#   Version: 4.18
#   Date: 08/18/2026
#   Specification: lmesource-client-interface-specification-v4-18.pdf
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
  id: lme_lmeselect_level3retransmission_lmesource_v4_18
  title: Lme LmeSelect Level3Retransmission LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource Level3 Retransmission LmeSource v4.18'
doc-ref: https://www.lme.com/Trading/Systems/LMEsource

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'LMEsource packet header, giving the packet size, the number of messages it carries, the sequence number of the first of them and the time the packet was sent'
  - id: message
    type: message_struct
    repeat: expr
    repeat-expr: packet_header.msg_count
    doc: 'LMEsource application messages carried by this packet; a message is never fragmented across packets'

types:
  packet_header_struct:
    seq:
      - id: pkt_size
        type: u2
        doc: 'Size of the packet, including this field'
      - id: msg_count
        type: u1
        doc: 'Number of messages included in the packet'
      - id: filler
        type: str
        size: 1
        encoding: ASCII
        doc: 'Filler aligning the sequence number to a four byte boundary'
      - id: seq_num
        type: u4
        doc: 'Sequence number of the first message in the packet'
      - id: send_time
        type: nanosecond_timestamp
        doc: 'UTC timestamp for the time this packet was sent, in nanoseconds since epoch, provided to the nearest microsecond. Nanoseconds since Unix epoch'
  message_struct:
    seq:
      - id: message_header
        type: message_header
        doc: 'LMEsource message header, giving the size of the message and its type'
      - id: payload
        size: message_header.msg_size - 4
        type:
          switch-on: message_header.msg_type
          cases:
            'msg_type::sequence_reset_message': sequence_reset_message
            'msg_type::market_state_contract_message': market_state_contract_message
            'msg_type::market_state_instrument_message': market_state_instrument_message
            'msg_type::indicative_opening_price_message': indicative_opening_price_message
            'msg_type::quote_request_message': quote_request_message
            'msg_type::order_book_clear_message': order_book_clear_message
            'msg_type::cross_request_message': cross_request_message
            'msg_type::order_add_message': order_add_message
            'msg_type::order_amend_message': order_amend_message
            'msg_type::order_cancel_message': order_cancel_message
            'msg_type::order_executed_message': order_executed_message
            'msg_type::logon_message': logon_message
            'msg_type::logon_response_message': logon_response_message
            'msg_type::retransmission_request_message': retransmission_request_message
            'msg_type::retransmission_response_message': retransmission_response_message
  message_header:
    seq:
      - id: msg_size
        type: u2
        doc: 'Message length, including this field'
      - id: msg_type
        type: u2
        enum: msg_type
        doc: 'Type of message, selecting the payload that follows the message header'
  sequence_reset_message:
    seq:
      - id: new_seq_no
        type: u4
        doc: 'New sequence number. Always set to 1'
  market_state_contract_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A string that combines the contract symbol, contract type and currency'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Trading State'
      - id: start_time
        type: nanosecond_timestamp
        doc: 'Trading State Start Time. Zero, meaning not applicable, for Technical Halt. Nanoseconds since Unix epoch'
      - id: end_time
        type: nanosecond_timestamp
        doc: 'Trading State End Time. Zero, meaning not applicable, for Technical Halt. Nanoseconds since Unix epoch'
      - id: trading_state_condition
        type: u1
        enum: trading_state_condition
        doc: 'Current trading state condition'
      - id: filler_string_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  market_state_instrument_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: timetable_control_type
        type: u1
        enum: timetable_control_type
        doc: 'Timetable Control Type'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Trading State'
      - id: start_time
        type: nanosecond_timestamp
        doc: 'Trading State Start Time. Zero, meaning not applicable, for Technical Halt. Nanoseconds since Unix epoch'
      - id: end_time
        type: nanosecond_timestamp
        doc: 'Trading State End Time. Zero, meaning not applicable, for Technical Halt. Nanoseconds since Unix epoch'
      - id: trading_state_condition
        type: u1
        enum: trading_state_condition
        doc: 'Current trading state condition'
      - id: filler_string_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  indicative_opening_price_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: indicative_opening_price
        type: decimal_s8_6_nullable
        doc: 'Indicative Opening Price, in implicit six decimal place format. Defaults to null. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: indicative_opening_volume
        type: u4
        doc: 'Indicative Opening Volume. Defaults to zero'
      - id: indicative_opening_mid_price
        type: decimal_s8_6_nullable
        doc: 'Indicative Opening Mid Price, in implicit six decimal place format. Defaults to null. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: filler_string_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  quote_request_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: quote_request_type
        type: u1
        enum: quote_request_type
        doc: 'Type of Quote Request'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'Side of order. Null for a two sided quote'
      - id: volume
        type: u4_nullable
        doc: 'Amended delta quantity. Nullable, No Value = 4294967295'
      - id: filler_string_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  order_book_clear_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
  cross_request_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: cross_id
        type: u8
        doc: 'The identifier of the Cross that is unique for the day. The specification types this field UInt64; the documented data types define Uint64 and the stated length of eight bytes agrees'
      - id: volume
        type: u4_nullable
        doc: 'Amended delta quantity. Nullable, No Value = 4294967295'
      - id: expire_time
        type: nanosecond_timestamp
        doc: 'The time this cross request will expire. Nanoseconds since Unix epoch'
      - id: filler_string_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  order_add_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: t_1
        type: nanosecond_timestamp_nullable
        doc: 'The time of the order request from the LMEselect gateway. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_2
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect captured the order request. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_3
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect published this order request to LMEsource. Null for reloaded GTC and GTD, stop loss and speedbump orders. The specification types this field Unit64, a typo for Uint64; the stated length of eight bytes agrees. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: order_id
        type: u8_nullable
        doc: 'Order ID assigned by LMEselect. Nullable, No Value = 18446744073709551615'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'Side of order. Null for a two sided quote'
      - id: volume
        type: u4_nullable
        doc: 'Amended delta quantity. Nullable, No Value = 4294967295'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price of order, in implicit six decimal place format. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: order_book_position
        type: u4
        doc: 'Relative order position within this side of the order book based upon price and time priority'
      - id: filler_string_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  order_amend_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: t_1
        type: nanosecond_timestamp_nullable
        doc: 'The time of the order request from the LMEselect gateway. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_2
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect captured the order request. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_3
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect published this order request to LMEsource. Null for reloaded GTC and GTD, stop loss and speedbump orders. The specification types this field Unit64, a typo for Uint64; the stated length of eight bytes agrees. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: order_id
        type: u8_nullable
        doc: 'Order ID assigned by LMEselect. Nullable, No Value = 18446744073709551615'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'Side of order. Null for a two sided quote'
      - id: volume
        type: u4_nullable
        doc: 'Amended delta quantity. Nullable, No Value = 4294967295'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price of order, in implicit six decimal place format. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: order_book_position
        type: u4
        doc: 'Relative order position within this side of the order book based upon price and time priority'
      - id: filler_string_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  order_cancel_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: t_1
        type: nanosecond_timestamp_nullable
        doc: 'The time of the order request from the LMEselect gateway. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_2
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect captured the order request. Null for reloaded GTC and GTD, stop loss and speedbump orders. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: t_3
        type: nanosecond_timestamp_nullable
        doc: 'The time when LMEselect published this order request to LMEsource. Null for reloaded GTC and GTD, stop loss and speedbump orders. The specification types this field Unit64, a typo for Uint64; the stated length of eight bytes agrees. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: order_id
        type: u8_nullable
        doc: 'Order ID assigned by LMEselect. Nullable, No Value = 18446744073709551615'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'Side of order. Null for a two sided quote'
      - id: filler_string_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  order_executed_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'Time of event. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price of order, in implicit six decimal place format. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: volume
        type: u4_nullable
        doc: 'Amended delta quantity. Nullable, No Value = 4294967295'
      - id: order_id
        type: u8_nullable
        doc: 'Order ID assigned by LMEselect. Nullable, No Value = 18446744073709551615'
      - id: match_id
        type: u8
        doc: 'An id that can be used to identify all orders that matched against each other'
      - id: trade_cancel_flag
        type: u1
        enum: trade_cancel_flag
        doc: 'Trade Cancel Flag'
      - id: sub_type_of_trade
        type: u1
        enum: sub_type_of_trade
        doc: 'Sub type of trade. The specification types this field UiInt8, a typo for Uint8; the stated length of one byte agrees'
      - id: trade_buy_sell
        type: u1
        enum: trade_buy_sell
        doc: 'The side of the trade for this order'
      - id: num_executed_legs
        type: u4
        doc: 'Number of legs present'
      - id: executed_legs
        type: executed_legs
        repeat: expr
        repeat-expr: num_executed_legs
        doc: 'One leg of an executed strategy trade'
  executed_legs:
    seq:
      - id: leg_tradable_instrument_id
        type: u8
        doc: 'TradableInstrumentID of the strategy leg'
      - id: leg_buy_sell
        type: u1
        enum: leg_buy_sell
        doc: 'Leg direction'
      - id: leg_price
        type: decimal_s8_6
        doc: 'Price allocated to this leg of the strategy, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: leg_volume
        type: u4
        doc: 'Quantity allocated to this leg of the strategy'
      - id: leg_match_id
        type: u8
        doc: 'Leg Match ID'
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
      - id: filler_string_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
  retransmission_request_message:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID to which the retransmission relates'
      - id: filler_string_2
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of the last message in the range to be resent'
  retransmission_response_message:
    seq:
      - id: channel_id
        type: u2
        doc: 'Multicast Channel ID to which the retransmission relates'
      - id: retrans_status
        type: u1
        enum: retrans_status
        doc: 'Status of the Retransmission response'
      - id: filler_string_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler'
      - id: begin_seq_num
        type: u4
        doc: 'Beginning of sequence'
      - id: end_seq_num
        type: u4
        doc: 'Message sequence number of the last message in the range to be resent'
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
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
  decimal_s8_6_nullable:
    seq:
      - id: value
        type: decimal_s8_6
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    311:
      id: 'market_state_contract_message'
      doc: 'Indicates the trading state of instruments at the contract level, for example Copper Futures or Aluminium Options. The ContractCode field is common across the Market State - Contract, Outright Definition and Strategy Definition messages and links the contract state to individual tradable instruments.'
    312:
      id: 'market_state_instrument_message'
      doc: 'Indicates the trading state of an individual tradable instrument. Sent when the instrument state differs from that at contract level, for example when TOM goes into Post Trade before the contract.'
    320:
      id: 'indicative_opening_price_message'
      doc: 'Carries the price at which a tradable instrument would open, computed by the uncrossing algorithm during Pre-Open. If there are no crossed prices no IOP is calculated or disseminated; where the book is not crossed but has both a bid and an offer, a mid price is calculated and published instead. At the transition from Pre-Open to Open an IOP message is published for every tradable instrument with both prices null and the volume zero, to indicate the prices are no longer valid.'
    329:
      id: 'quote_request_message'
      doc: 'Generated when a request for quote is accepted by the Matching Engine.'
    327:
      id: 'order_book_clear_message'
      doc: 'Generated when the order book is required to be cleared, for example after the transition between certain market states, or when an instrument''s Trading State Condition is Trade Halt. Following an Order Book Clear, if an instrument is subsequently open for trading any resting orders are sent as Top Of Book, Aggregate Order Book or Order Add messages to allow clients to rebuild the order book. It is not published when an instrument enters or leaves Trade Pause.'
    330:
      id: 'cross_request_message'
      doc: 'Generated when a cross request is created on LMEselect.'
    323:
      id: 'order_add_message'
      doc: 'Generated when an order is placed in the order book. An incoming, aggressing order that matches against one or more resting orders is not published as an Order Add unless it has residual volume after matching. For orders submitted during Pre-Open and reloaded GTC and GTD orders the TimeOfEvent reflects the uncrossing event time at market open.'
    324:
      id: 'order_amend_message'
      doc: 'Generated when an order amendment updates the volume downward or the position in the order book.'
    325:
      id: 'order_cancel_message'
      doc: 'Generated when an order is cancelled from the order book.'
    326:
      id: 'order_executed_message'
      doc: 'Generated when an order is executed. Not published for an aggressing order unless it matches with a resting implied order; publishing for a resting implied order occurs only when two implied orders are matched. If an electronic cross order is matched against itself off book, the message is published with a SubTypeOfTrade of nine.'
    101:
      id: 'logon_message'
      doc: 'Enables client authentication. Not required for multicast channels and only used for retransmission requests. The client sends a Logon containing a username, to which LMEsource responds with a Logon Response.'
    102:
      id: 'logon_response_message'
      doc: 'Response to a Logon, carrying the status of the session.'
    201:
      id: 'retransmission_request_message'
      doc: 'Requests the retransmission of a range of messages on a multicast channel.'
    202:
      id: 'retransmission_response_message'
      doc: 'Response to a Retransmission Request, carrying the status of the request and the sequence range being resent.'
  trading_state:
    1:
      id: 'pre_open'
      doc: 'Pre Open'
    2:
      id: 'open'
      doc: 'Open'
    3:
      id: 'post_trade'
      doc: 'Post Trade'
    4:
      id: 'close'
      doc: 'Close'
    6:
      id: 'technical_halt'
      doc: 'Technical Halt'
  trading_state_condition:
    0x50:
      id: 'pause'
      doc: 'Pause'
    0x48:
      id: 'halt'
      doc: 'Halt'
    0x20:
      id: 'active'
      doc: 'Active'
  timetable_control_type:
    0x41:
      id: 'automatic_the_default_trading_schedule'
      doc: 'Automatic The Default Trading Schedule'
    0x4d:
      id: 'manual_a_temporary_trading_schedule'
      doc: 'Manual A Temporary Trading Schedule'
  quote_request_type:
    1:
      id: 'manual_a_single_quote_request'
      doc: 'Manual A Single Quote Request'
    2:
      id: 'auto_a_streaming_quote_request'
      doc: 'Auto A Streaming Quote Request'
  buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x20:
      id: 'two_sided_quote'
      doc: 'Two Sided Quote'
  trade_cancel_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  sub_type_of_trade:
    1:
      id: 'the_trade_resulted_from_an_explicit_order'
      doc: 'The Trade Resulted From An Explicit Order'
    2:
      id: 'the_trade_resulted_from_uncrossing'
      doc: 'The Trade Resulted From Uncrossing'
    7:
      id: 'the_trade_resulted_from_an_implied_order'
      doc: 'The Trade Resulted From An Implied Order'
    8:
      id: 'the_trade_resulted_from_two_implied_orders_matching'
      doc: 'The Trade Resulted From Two Implied Orders Matching'
    9:
      id: 'the_trade_resulted_from_an_off_book_cross_trade'
      doc: 'The Trade Resulted From An Off Book Cross Trade'
  trade_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
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

