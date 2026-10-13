# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect ReferenceData LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource ReferenceData
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
  id: lme_lmeselect_referencedata_lmesource_v4_18
  title: Lme LmeSelect ReferenceData LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource ReferenceData LmeSource v4.18'
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
            'msg_type::contract_definition_message': contract_definition_message
            'msg_type::outright_definition_message': outright_definition_message
            'msg_type::strategy_definition_message': strategy_definition_message
            'msg_type::price_limits_message': price_limits_message
            'msg_type::trade_statistics_end_of_day_message': trade_statistics_end_of_day_message
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
  contract_definition_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique code to identify the contract'
      - id: name
        type: str
        size: 64
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of the contract'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Constant contract type'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Underlying Type'
      - id: underlying_contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference to the underlying contract'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement Type'
      - id: settlement_pricing_method
        type: u1
        enum: settlement_pricing_method
        doc: 'Settlement Pricing Method'
      - id: exercise_style
        type: s1_nullable
        doc: 'Exercise Style. Null for futures. Nullable, No Value = -128'
      - id: lot_unit
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Lot Unit'
      - id: lot_size
        type: u8
        doc: 'The lot size for this tradable instrument'
      - id: lot_size_type
        type: u1
        enum: lot_size_type
        doc: 'Lot Size Type'
      - id: contract_price_type
        type: u1
        enum: contract_price_type
        doc: 'Price for futures, premium or volatility for options. The specification names this field PriceType; it is qualified here because the Reference Price message gives a PriceType of its own carrying a different set of values'
      - id: first_trading_date
        type: yyyymmdd_date
        doc: 'First Trading Date, as YYYYMMDD'
  outright_definition_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: tradable_instrument_id
        type: u8
        doc: 'The id of the security for which trades in this tradable instrument are held'
      - id: merged_tradable_instrument_id
        type: u8_nullable
        doc: 'The TradableInstrumentID of the merged tradable instrument. Null means no merged tradable instrument. Nullable, No Value = 18446744073709551615'
      - id: linked_tradable_instrument_id
        type: u8
        doc: 'The TradableInstrumentID of the linked tradable instrument'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Constant contract type'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique code to identify the contract'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'The expiry date for this tradable instrument, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: prompt_type
        type: u1
        enum: prompt_type
        doc: 'Identifies whether the prompt is single or a range'
      - id: strike_price
        type: decimal_s8_6_nullable
        doc: 'The strike price for this tradable instrument, in implicit six decimal place format. Null for futures. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: option_type
        type: u1
        enum: option_type
        doc: 'For option tradable instruments, the type of option'
      - id: exercise_style
        type: s1_nullable
        doc: 'Exercise Style. Null for futures. Nullable, No Value = -128'
      - id: prompt_date_label
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Prompt Date Label'
      - id: price_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to represent the Trade at Reference or Trade at Settlement price code'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code. Space if not applicable'
      - id: cfi_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument classification code'
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
        doc: 'A string identifier for the individual market segment to which the outright belongs'
      - id: tick_size_id
        type: u4
        doc: 'Tick Size ID'
      - id: lot_size
        type: u8
        doc: 'The lot size for this tradable instrument'
      - id: lot_size_type
        type: u1
        enum: lot_size_type
        doc: 'Lot Size Type'
      - id: last_trading_date
        type: yyyymmdd_date
        doc: 'Last Trading Date, as YYYYMMDD'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement Type'
      - id: settlement_pricing_method
        type: u1
        enum: settlement_pricing_method
        doc: 'Settlement Pricing Method'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Underlying Type'
  strategy_definition_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: tradable_instrument_id
        type: u8
        doc: 'The id of the security for which trades in this tradable instrument are held'
      - id: merged_tradable_instrument_id
        type: u8_nullable
        doc: 'The TradableInstrumentID of the merged tradable instrument. Null means no merged tradable instrument. Nullable, No Value = 18446744073709551615'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product code'
      - id: contract_type
        type: u1
        enum: contract_type
        doc: 'Constant contract type'
      - id: trading_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: strategy_type_code
        type: u4_nullable
        doc: 'Strategy Type. Nullable, No Value = 4294967295'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A unique code to identify the contract'
      - id: exercise_style
        type: s1_nullable
        doc: 'Exercise Style. Null for futures. Nullable, No Value = -128'
      - id: price_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to represent the Trade at Reference or Trade at Settlement price code'
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
        doc: 'A string identifier for the individual market segment to which the outright belongs'
      - id: tick_size_id
        type: u4
        doc: 'Tick Size ID'
      - id: lot_size
        type: u8
        doc: 'The lot size for this tradable instrument'
      - id: lot_size_type
        type: u1
        enum: lot_size_type
        doc: 'Lot Size Type'
      - id: last_trading_date
        type: yyyymmdd_date
        doc: 'Last Trading Date, as YYYYMMDD'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'Settlement Type'
      - id: settlement_pricing_method
        type: u1
        enum: settlement_pricing_method
        doc: 'Settlement Pricing Method'
      - id: underlying_type
        type: u1
        enum: underlying_type
        doc: 'Underlying Type'
      - id: num_strategy_legs
        type: u4
        doc: 'Number of legs of this strategy instrument'
      - id: strategy_legs
        type: strategy_legs
        repeat: expr
        repeat-expr: num_strategy_legs
        doc: 'One leg of a strategy tradable instrument definition'
  strategy_legs:
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
  price_limits_message:
    seq:
      - id: tradable_instrument_id
        type: u8
        doc: 'The id of the security for which trades in this tradable instrument are held'
      - id: upper_price_limit
        type: decimal_s8_6
        doc: 'Upper price limit for the outright tradable instrument for the current trading day, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: lower_price_limit
        type: decimal_s8_6
        doc: 'Lower price limit for the outright tradable instrument for the current trading day, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: transaction_time
        type: nanosecond_timestamp
        doc: 'The time at which the price limits were created. Nanoseconds since Unix epoch'
  trade_statistics_end_of_day_message:
    seq:
      - id: trading_venue
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading venue'
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'The time LMEselect computed or derived the designated price. Nanoseconds since Unix epoch'
      - id: tradable_instrument_id
        type: u8
        doc: 'The id of the security for which trades in this tradable instrument are held'
      - id: open_price
        type: decimal_s8_6
        doc: 'Opening trade price for the current day, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: trade_high
        type: decimal_s8_6
        doc: 'Highest trade price for the current day, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: trade_low
        type: decimal_s8_6
        doc: 'Lowest trade price for the current day, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: closing_price
        type: decimal_s8_6
        doc: 'Closing, final, trade price for the current day, in implicit six decimal place format. Implied decimal with scale 1e-6'
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
  s1_nullable:
    seq:
      - id: value
        type: s1
    instances:
      is_null:
        value: value == -128
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
  u8_nullable:
    seq:
      - id: value
        type: u8
    instances:
      is_null:
        value: value == 18446744073709551615
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
    300:
      id: 'contract_definition_message'
      doc: 'Published for a new contract prior to its first trading date, to enable participants to configure risk management parameters before the contract becomes tradable.'
    301:
      id: 'outright_definition_message'
      doc: 'Describes individual outright tradable instruments available from LMEsource.'
    302:
      id: 'strategy_definition_message'
      doc: 'Describes individual strategy tradable instruments available from LMEsource.'
    305:
      id: 'price_limits_message'
      doc: 'Describes the upper and lower price limits for an outright tradable instrument. Where Daily Price Limits are enabled for a contract they are published for electronic tradable instruments, and the same limits also apply to non-electronic tradable instruments.'
    351:
      id: 'trade_statistics_end_of_day_message'
      doc: 'Generated when the market moves to the Post-Trade session for instruments that have traded. LMEsource publishes the LMEselect Opening and Closing Prices, LMEselect Trading High and LMEselect Trading Low for all contracts that have traded during the day. Off book trades resulting from Cross Order execution are not used in the calculation.'
  contract_type:
    0x46:
      id: 'future'
      doc: 'Future'
    0x4f:
      id: 'option'
      doc: 'Option'
  underlying_type:
    0x43:
      id: 'commodity'
      doc: 'Commodity'
    0x46:
      id: 'future'
      doc: 'Future'
  settlement_type:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x50:
      id: 'physical'
      doc: 'Physical'
  settlement_pricing_method:
    0x44:
      id: 'daily'
      doc: 'Daily'
    0x4d:
      id: 'monthly_average'
      doc: 'Monthly Average'
  exercise_style:
    0:
      id: 'european'
      doc: 'European'
    1:
      id: 'american'
      doc: 'American'
    2:
      id: 'asian'
      doc: 'Asian'
  lot_size_type:
    0x53:
      id: 'standard'
      doc: 'Standard'
    0x4d:
      id: 'mini'
      doc: 'Mini'
  contract_price_type:
    0x50:
      id: 'premium'
      doc: 'Premium'
    0x56:
      id: 'volatility'
      doc: 'Volatility'
    0x20:
      id: 'futures'
      doc: 'Futures'
  prompt_type:
    0x53:
      id: 'single'
      doc: 'Single'
    0x52:
      id: 'rolling'
      doc: 'Rolling'
  option_type:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  leg_buy_sell:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'

