# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect ReferencePrices LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource ReferencePrices
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
  id: lme_lmeselect_referenceprices_lmesource_v4_18
  title: Lme LmeSelect ReferencePrices LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource ReferencePrices LmeSource v4.18'
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
            'msg_type::reference_price_message': reference_price_message
            'msg_type::reference_forward_curve_price_message': reference_forward_curve_price_message
            'msg_type::reference_fx_rate_message': reference_fx_rate_message
            'msg_type::reference_volatility_price_message': reference_volatility_price_message
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
  reference_price_message:
    seq:
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'The time at which the price was established. Nanoseconds since Unix epoch'
      - id: reference_price_category
        type: u1
        enum: reference_price_category
        doc: 'Category of the reference price. The specification names this field Category; it is qualified here because the Reference FX Rate message gives a Category of its own carrying a different set of values'
      - id: reference_price_type
        type: str
        size: 32
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference price type. The specification names this field PriceType; it is qualified here because the Contract Definition message gives a PriceType of its own carrying a different set of values'
      - id: price_status
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The status of reference price'
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date on which the price was established, as YYYYMMDD'
      - id: instrument_id
        type: u8_nullable
        doc: 'Unique Instrument Identifier. Null for PriceType Index. Nullable, No Value = 18446744073709551615'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: bid
        type: decimal_s8_6
        doc: 'A reference bid price, in implicit six decimal place format. Represents the average bid price for a reference price categorised as such. Implied decimal with scale 1e-6'
      - id: price
        type: decimal_s8_6_nullable
        doc: 'A reference price, in implicit six decimal place format. For an Average represents the mean of bid ask averages. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: ask
        type: decimal_s8_6
        doc: 'A reference ask price, in implicit six decimal place format. Represents the average ask price for a reference price categorised as such. Implied decimal with scale 1e-6'
  reference_forward_curve_price_message:
    seq:
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'The time at which the price was established. Nanoseconds since Unix epoch'
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date on which the price was established, as YYYYMMDD'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
      - id: price_status
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'The status of reference price'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining prices to be published for a product. When the value of RemainingRecords equals RecordCount this is the last message for the product'
      - id: num_curve_prices
        type: u2
        doc: 'The number of reference prices in this message'
      - id: curve_prices
        type: curve_prices
        repeat: expr
        repeat-expr: num_curve_prices
        doc: 'One forward curve reference price and the prompt date or dates it relates to. The specification''s length formula names the repeat NumPrices, a field no table of this message declares; RecordCount is the count it gives, as the number of reference prices in this message'
  curve_prices:
    seq:
      - id: price
        type: decimal_s8_6_nullable
        doc: 'A reference price, in implicit six decimal place format. For an Average represents the mean of bid ask averages. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: prompt_date_1
        type: yyyymmdd_date
        doc: 'The date to which the price relates, as YYYYMMDD. For a spread this is the first leg'
      - id: prompt_date_label_1
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The label representing date1. Not applicable for all dates'
      - id: prompt_date_2
        type: yyyymmdd_date_nullable
        doc: 'The date to which the price relates, as YYYYMMDD. For a spread this is the second leg. Null if not applicable. Nullable, No Value = 4294967295'
      - id: prompt_date_label_2
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'The label representing date2. For a spread the date label associated with the second leg, if there is one. Not applicable for all dates'
  reference_fx_rate_message:
    seq:
      - id: fx_rate_category
        type: u1
        enum: fx_rate_category
        doc: 'FX rate category. The specification names this field Category; it is qualified here because the Reference Price message gives a Category of its own carrying a different set of values'
      - id: fx_rate_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'FX rate type. The specification names this field Type; it is qualified here because the Open Interest and Warrant Band messages give a Type of their own carrying different sets of values'
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date on which the price was established, as YYYYMMDD'
      - id: maturity_date
        type: yyyymmdd_date
        doc: 'The business date to which the rate applies, as YYYYMMDD'
      - id: base_currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: target_currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: conversion_rate
        type: decimal_s8_6
        doc: 'The conversion rate between base and target currencies, in implicit six decimal place format. Implied decimal with scale 1e-6'
  reference_volatility_price_message:
    seq:
      - id: time_of_event
        type: nanosecond_timestamp
        doc: 'The time at which the price was established. Nanoseconds since Unix epoch'
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date on which the price was established, as YYYYMMDD'
      - id: contract_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contract code of the Option or TAPO'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'Option expiry date, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: remaining_records
        type: u2
        doc: 'Number of remaining prices to be published for a product. When the value of RemainingRecords equals RecordCount this is the last message for the product'
      - id: num_volatility_points
        type: u2
        doc: 'The number of reference prices in this message'
      - id: volatility_points
        type: volatility_points
        repeat: expr
        repeat-expr: num_volatility_points
        doc: 'One point of the reference volatility curve. The specification''s length formula names the repeat NumVolatilityRecords, a field no table of this message declares; RecordCount is the count it gives, as the number of reference volatility points in this message'
  volatility_points:
    seq:
      - id: surface_domain
        type: u1
        enum: surface_domain
        doc: 'Indicates whether the reference volatility was created in Delta or Strike space'
      - id: delta
        type: decimal_s8_6
        doc: 'Option delta for the volatility point, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: strike_price
        type: decimal_s8_6_nullable
        doc: 'Strike price for the volatility point, in implicit six decimal place format. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: atm
        type: u1
        enum: atm
        doc: 'Identifies the ATM strike, one, or delta point, zero'
      - id: call_volatility
        type: decimal_s8_6
        doc: 'Call volatility, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: put_volatility
        type: decimal_s8_6
        doc: 'Put volatility, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: call_premium
        type: decimal_s8_6
        doc: 'Call premium, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: put_premium
        type: decimal_s8_6
        doc: 'Put premium, in implicit six decimal place format. Implied decimal with scale 1e-6'
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
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == -1

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    401:
      id: 'reference_price_message'
      doc: 'Reference prices are published for instruments with an InstrumentID for the Official, Settlement, Closing and Index price types. Instruments are published in the Instrument Definition message.'
    402:
      id: 'reference_forward_curve_price_message'
      doc: 'Indicative and closing prices for Carries and indicative prices for the Aluminium Premiums.'
    403:
      id: 'reference_fx_rate_message'
      doc: 'Exchange FX rates are published for the Cash prompt. Daily and Monthly Moving Average Exchange FX rates are published each day, with the Monthly Average Exchange FX rate published on the last business day of the month. MonthlyMovingAverage and MonthlyAverage are published only for the Exchange category.'
    404:
      id: 'reference_volatility_price_message'
      doc: 'Provides raw strikes. LME volatilities are quoted in Delta space, and the strikes for which LME provide volatilities correspond to plus or minus 5, 10 and 25, the 50 delta, the at the money strike and the tradable strikes for the instrument. The calculated Call Premium and Put Premium are provided for each volatility and strike price for both Traded Options and TAPOs.'
  reference_price_category:
    0x49:
      id: 'instrument'
      doc: 'Instrument'
    0x50:
      id: 'product'
      doc: 'Product'
  fx_rate_category:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
    0x43:
      id: 'closing'
      doc: 'Closing'
  surface_domain:
    0x53:
      id: 'strike'
      doc: 'Strike'
    0x44:
      id: 'delta'
      doc: 'Delta'
  atm:
    0:
      id: 'delta_point'
      doc: 'Delta Point'
    1:
      id: 'atm_strike'
      doc: 'Atm Strike'

