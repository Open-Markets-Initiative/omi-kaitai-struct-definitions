# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect RingDataSnapshot LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource RingData Refresh
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
  id: lme_lmeselect_ringdatasnapshot_lmesource_v4_18
  title: Lme LmeSelect RingDataSnapshot LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource RingData Refresh LmeSource v4.18'
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
            'msg_type::market_state_product_message': market_state_product_message
            'msg_type::market_data_order_message': market_data_order_message
            'msg_type::indicative_trade_price_message': indicative_trade_price_message
            'msg_type::market_data_trade_message': market_data_trade_message
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
  market_state_product_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: timeof_event
        type: nanosecond_timestamp
        doc: 'Time of event. The specification spells this field TimeofEvent, where every other message spells it TimeOfEvent; the name is carried as the specification gives it. Nanoseconds since Unix epoch'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: trading_state
        type: u1
        enum: trading_state
        doc: 'Trading State'
      - id: ring_session
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This identifies the ring trading session'
  market_data_order_message:
    seq:
      - id: timeof_event
        type: nanosecond_timestamp
        doc: 'Time of event. The specification spells this field TimeofEvent, where every other message spells it TimeOfEvent; the name is carried as the specification gives it. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: ring_session
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This identifies the ring trading session'
      - id: cancellation_reason
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indicates that the event relates to an order cancellation. Space if not applicable'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: buy_sell
        type: u1
        enum: buy_sell
        doc: 'Buy or Sell'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price of the order, in implicit six decimal place format. Can be null for a strategy market data order originating from LMEsmart. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: volume
        type: u4_nullable
        doc: 'Order quantity. Can be null for a strategy market data order originating from LMEsmart. Nullable, No Value = 4294967295'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining records to be published. When the value of RemainingRecords equals RecordCount this is the last message'
      - id: num_order_legs
        type: u2
        doc: 'The number of records in this message'
      - id: strategy_leg_count
        type: u4
        doc: 'Number of legs present'
      - id: order_legs
        type: order_legs
        repeat: expr
        repeat-expr: num_order_legs
        doc: 'One strategy leg record of a market data order, counted by RecordCount rather than by StrategyLegCount: the specification''s length formula gives the repeat as the value of RecordCount, StrategyLegCount being the number of legs present in the strategy'
  order_legs:
    seq:
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
  indicative_trade_price_message:
    seq:
      - id: timeof_event
        type: nanosecond_timestamp
        doc: 'Time of event. The specification spells this field TimeofEvent, where every other message spells it TimeOfEvent; the name is carried as the specification gives it. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: ring_session
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This identifies the ring trading session'
      - id: indicative_price_type
        type: u1
        enum: indicative_price_type
        doc: 'Indicative trade price type'
      - id: indicative_trade_price
        type: decimal_s8_6
        doc: 'The price of the trade, in implicit six decimal place format. Implied decimal with scale 1e-6'
  market_data_trade_message:
    seq:
      - id: timeof_event
        type: nanosecond_timestamp
        doc: 'Time of event. The specification spells this field TimeofEvent, where every other message spells it TimeOfEvent; the name is carried as the specification gives it. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable Instrument ID'
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: matched_time
        type: nanosecond_timestamp_nullable
        doc: 'Time the trade was matched in LMEsmart. Null until such time. Nanoseconds since Unix epoch. Nullable, No Value = 18446744073709551615'
      - id: ring_session
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'This identifies the ring trading session'
      - id: trade_cancel_flag
        type: u1
        enum: trade_cancel_flag
        doc: 'Trade Cancel Flag'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'Price of the order, in implicit six decimal place format. Can be null for a strategy market data order originating from LMEsmart. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: volume
        type: u4_nullable
        doc: 'Order quantity. Can be null for a strategy market data order originating from LMEsmart. Nullable, No Value = 4294967295'
      - id: match_id
        type: u8
        doc: 'Assigned trade match identifier for the matched trade'
      - id: trade_at_reference_price_type
        type: u1
        enum: trade_at_reference_price_type
        doc: 'For a TaR, indicates whether the price is differential or substituted. Defaults to space, meaning not applicable'
      - id: sub_type_of_trade
        type: u1
        enum: sub_type_of_trade
        doc: 'Sub type of trade'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining records to be published. When the value of RemainingRecords equals RecordCount this is the last message'
      - id: num_trade_legs
        type: u2
        doc: 'The number of records in this message'
      - id: strategy_leg_count
        type: u4
        doc: 'Number of legs present'
      - id: trade_legs
        type: trade_legs
        repeat: expr
        repeat-expr: num_trade_legs
        doc: 'One leg record of a strategy trade, counted by RecordCount rather than by StrategyLegCount, which states the total legs of the strategy'
  trade_legs:
    seq:
      - id: leg_price
        type: decimal_s8_6
        doc: 'Price allocated to this leg of the strategy, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: leg_volume
        type: u4
        doc: 'Quantity allocated to this leg of the strategy'
      - id: leg_match_id
        type: u8
        doc: 'Leg Match ID'
      - id: leg_trade_at_reference_price
        type: u1
        enum: leg_trade_at_reference_price
        doc: 'Indicates whether the leg price is differential or substituted'
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
  nanosecond_timestamp_nullable:
    seq:
      - id: value
        type: nanosecond_timestamp
    instances:
      is_null:
        value: value.time == -1

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    310:
      id: 'market_state_product_message'
      doc: 'Indicates the trading state of the product on the Ring and includes the ring session.'
    328:
      id: 'market_data_order_message'
      doc: 'Generated each time there is a new order price and when Ring prices are withdrawn or deleted. Prices can be withdrawn if they are no longer being quoted by traders in the Ring, and deleted if incorrectly entered.'
    340:
      id: 'indicative_trade_price_message'
      doc: 'Generated each time there is a trade price and when a price has been deleted.'
    341:
      id: 'market_data_trade_message'
      doc: 'Generated each time a trade has been performed in the Electronic, Inter Office or Ring venues. When an incoming order matches against multiple resting orders there is one Market Data Trade published for each matched trade.'
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
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
  indicative_price_type:
    0:
      id: 'indicative_trade_price'
      doc: 'Indicative Trade Price'
    1:
      id: 'indicative_trade_price_deleted'
      doc: 'Indicative Trade Price Deleted'
  trade_cancel_flag:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  trade_at_reference_price_type:
    0x44:
      id: 'differential'
      doc: 'Differential'
    0x53:
      id: 'substituted'
      doc: 'Substituted'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'
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
  leg_trade_at_reference_price:
    0x44:
      id: 'differential'
      doc: 'Differential'
    0x53:
      id: 'substituted'
      doc: 'Substituted'
    0x20:
      id: 'not_applicable'
      doc: 'Not Applicable'

