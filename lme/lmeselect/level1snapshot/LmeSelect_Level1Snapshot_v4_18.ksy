# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect Level1Snapshot LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource Level1 Refresh
#   Encoding: LMEsource
#   Version: 4.18
#   Date: 08/18/2026
#   Specification: LMEsource Client Interface Specification v4 18.pdf
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
  id: lme_lmeselect_level1snapshot_lmesource_v4_18
  title: Lme LmeSelect Level1Snapshot LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource Level1 Refresh LmeSource v4.18'
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
            'msg_type::top_of_book_message': top_of_book_message
            'msg_type::refresh_complete_message': refresh_complete_message
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
  top_of_book_message:
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
      - id: aggregate_bid_volume
        type: u8
        doc: 'Aggregated quantity available on the bid side'
      - id: aggregate_ask_volume
        type: u8
        doc: 'Aggregated quantity available on the ask side'
      - id: bid_price
        type: decimal_s8_6
        doc: 'The bid price, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: ask_price
        type: decimal_s8_6
        doc: 'The ask price, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: number_bid_explicit_orders
        type: u4
        doc: 'The total number of bid orders in the best price level for explicit orders'
      - id: bid_qty_explicit_orders
        type: u8
        doc: 'The total quantity of bid orders in the best price level for explicit orders'
      - id: number_ask_explicit_orders
        type: u4
        doc: 'The total number of ask orders in the best price level for explicit orders'
      - id: ask_qty_explicit_orders
        type: u8
        doc: 'The total quantity of ask orders in the best price level for explicit orders'
      - id: number_bid_implied_orders
        type: u4
        doc: 'The total number of bid orders in the best price level for implied orders'
      - id: bid_qty_implied_orders
        type: u8
        doc: 'The total quantity of bid orders in the best price level for implied orders'
      - id: number_ask_implied_orders
        type: u4
        doc: 'The total number of ask orders in the best price level for implied orders'
      - id: ask_qty_implied_orders
        type: u8
        doc: 'The total quantity of ask orders in the best price level for implied orders'
  refresh_complete_message:
    seq:
      - id: last_seq_num
        type: u4
        doc: 'Sequence number in the real-time channel with which the refresh is synchronised'
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
    321:
      id: 'top_of_book_message'
      doc: 'Generated when the top price level has been modified. There are no New, Change or Delete actions for Top Of Book: whenever the price, quantity or number of orders at the top of book changes a new message is sent. When an order book is emptied as a result of market activity, a Top Of Book message is sent with the price fields null and the aggregate quantity and number of orders zero. The TimeOfEvent is the latest incoming event timestamp regardless of the event that caused the update; for orders submitted during Pre-Open and reloaded GTC and GTD orders it reflects the uncrossing event time at market open.'
    203:
      id: 'refresh_complete_message'
      doc: 'Published to mark the end of a refresh cycle.'
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

