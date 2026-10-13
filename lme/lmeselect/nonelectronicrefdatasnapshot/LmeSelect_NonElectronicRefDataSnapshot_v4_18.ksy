# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect NonElectronicRefDataSnapshot LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource NonElectronicRefData Refresh
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
  id: lme_lmeselect_nonelectronicrefdatasnapshot_lmesource_v4_18
  title: Lme LmeSelect NonElectronicRefDataSnapshot LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource NonElectronicRefData Refresh LmeSource v4.18'
doc-ref: https://www.lme.com/Trading/Systems/LMEsource

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'LMEsource packet header, giving the packet size, the number of messages it carries, the sequence number of the first of them and the time the packet was sent'
  - id: messages
    type: messages_struct
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
  messages_struct:
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
            'msg_type::instrument_definition_message': instrument_definition_message
            'msg_type::tradable_instrument_definition_message': tradable_instrument_definition_message
            'msg_type::order_statistics_intraday_message': order_statistics_intraday_message
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
  instrument_definition_message:
    seq:
      - id: instrument_id
        type: u8_nullable
        doc: 'Unique Instrument Identifier. Nullable, No Value = 18446744073709551615'
      - id: name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Instrument name'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract to which the instrument belongs'
      - id: underlying_instrument_id
        type: u8_nullable
        doc: 'A reference to the underlying Instrument. Null otherwise. Nullable, No Value = 18446744073709551615'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'Expiry date, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: strike_price
        type: decimal_s8_6_nullable
        doc: 'Option Exercise Price, in implicit six decimal place format. Null for futures. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Call or Put. Space if Contract Type is Future'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument classification according to ISO 10962'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code. Not applicable if the Instrument belongs to an algorithmic test contract'
  tradable_instrument_definition_message:
    seq:
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable instrument ID'
      - id: instrument_id
        type: u8_nullable
        doc: 'Unique Instrument Identifier. Nullable, No Value = 18446744073709551615'
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: business_days_to_expiry
        type: u4_nullable
        doc: 'Numeric indicator of the number of Business Days to Expiry used as a measure of how far the instrument is down the curve. Null if Contract Type is Option. Nullable, No Value = 4294967295'
      - id: last_trading_date
        type: yyyymmdd_date
        doc: 'Last Trading Date, as YYYYMMDD'
      - id: tick_size_id
        type: u4
        doc: 'Tick Size ID'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract to which the instrument belongs'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Constant contract type'
      - id: instrument_type
        type: u1
        enum: instrument_type
        doc: 'Instrument Type'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: market_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Code'
      - id: market_segment_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A string identifier for the individual market segment to which the tradable instrument belongs'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code. This identifies the metal'
      - id: underlying_tradable_instrument_id
        type: u8_nullable
        doc: 'Underlying Tradable Instrument ID. Null when no underlying Tradable Instrument exists or the Tradable Instrument is a strategy. Nullable, No Value = 18446744073709551615'
      - id: settlement_date
        type: yyyymmdd_date_nullable
        doc: 'Settlement Date, as YYYYMMDD. Null for a rolling prompt or strategy. Nullable, No Value = 4294967295'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'Expiry date, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'Call or Put. Space if Contract Type is Future'
      - id: strike_price
        type: decimal_s8_6_nullable
        doc: 'Option Exercise Price, in implicit six decimal place format. Null for futures. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument classification according to ISO 10962'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code. Not applicable if the Instrument belongs to an algorithmic test contract'
      - id: trade_at_reference
        type: u1
        enum: trade_at_reference
        doc: 'A flag to indicate that the instrument is a TaS or TaR type'
      - id: price_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The price code that specifies the type of TaS or TaR instrument. Not applicable for non Trade at Reference tradable instruments'
      - id: prompt_date_label
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Prompt Date Label. Not applicable for a strategy'
      - id: prompt_type
        type: u1
        enum: prompt_type
        doc: 'Identifies whether the prompt is a single or a rolling prompt. Not applicable for a strategy'
      - id: option_strike_relative_position
        type: u4_nullable
        doc: 'ATM Strike is zero, ITM relative positions are positive and OTM positions are negative. Null if Contract Type is Future or Instrument Type is Strategy. Nullable, No Value = 4294967295'
      - id: strategy_type_code
        type: u4_nullable
        doc: 'Strategy Type. Null for an outright. Nullable, No Value = 4294967295'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining records to be published. When the value of RemainingRecords equals RecordCount this is the last message'
      - id: num_definition_legs
        type: u2
        doc: 'The number of records in this message'
      - id: strategy_leg_count
        type: u4
        doc: 'Number of strategy legs'
      - id: definition_legs
        type: definition_legs
        repeat: expr
        repeat-expr: num_definition_legs
        doc: 'One strategy leg record of a tradable instrument definition, counted by RecordCount rather than by StrategyLegCount: the specification''s length formula gives the repeat as the value of Record Count, StrategyLegCount being the number of legs the whole strategy has'
  definition_legs:
    seq:
      - id: leg_number
        type: u4
        doc: 'An identifier for each leg in the strategy, starting from one and incrementing by one for each leg'
      - id: leg_buy_sell
        type: u1
        enum: leg_buy_sell
        doc: 'Leg direction'
      - id: leg_ratio
        type: decimal_u8_3
        doc: 'Leg ratio of the strategy leg, in implicit three decimal place format. Where the strategy type code is nine it represents the delta value for each delta hedge leg. Implied decimal with scale 1e-3'
      - id: leg_delta_hedge_price
        type: decimal_s8_6_nullable
        doc: 'Underlying price for a futures leg in a delta hedge custom strategy, null otherwise. Implicit six decimal place format. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: leg_tradable_instrument_id
        type: u8
        doc: 'TradableInstrumentID of the strategy leg'
  order_statistics_intraday_message:
    seq:
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'The time at which the transaction occurred. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'Tradable instrument ID'
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
      - id: order_high
        type: decimal_s8_6
        doc: 'Highest 3M bid price for the current Ring session, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: order_low
        type: decimal_s8_6
        doc: 'Lowest 3M ask price for the current Ring session, in implicit six decimal place format. Implied decimal with scale 1e-6'
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
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
  yyyymmdd_date:
    seq:
      - id: packed
        type: s4
    instances:
      year:
        value: packed / 10000
      month:
        value: packed / 100 % 100
      day:
        value: packed % 100
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == -1
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
  decimal_u8_3:
    seq:
      - id: mantissa
        type: u8
    instances:
      real:
        value: mantissa / 1000.0

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    303:
      id: 'instrument_definition_message'
      doc: 'Describes a futures outright prompt date or option call or put strike.'
    304:
      id: 'tradable_instrument_definition_message'
      doc: 'Describes an individual outright, strategy or Trade at Reference tradable instrument on the Ring or Inter Office venue. An option tradable instrument is published only once on the day of creation and is published at the start of day on the next business day.'
    350:
      id: 'order_statistics_intraday_message'
      doc: 'Generated at the end of each Ring trading session for instruments that have traded. Two messages are published, one for each high price and low price. If no price has been received the field is set to null.'
    203:
      id: 'refresh_complete_message'
      doc: 'Published to mark the end of a refresh cycle.'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  contract_type:
    0x46:
      id: 'future'
      doc: 'Future'
    0x4f:
      id: 'option'
      doc: 'Option'
  instrument_type:
    0x4f:
      id: 'outright'
      doc: 'Outright'
    0x53:
      id: 'strategy'
      doc: 'Strategy'
  trade_at_reference:
    0:
      id: 'false_field'
      doc: 'False'
    1:
      id: 'true_field'
      doc: 'True'
  prompt_type:
    0x53:
      id: 'single'
      doc: 'Single'
    0x52:
      id: 'rolling'
      doc: 'Rolling'
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

