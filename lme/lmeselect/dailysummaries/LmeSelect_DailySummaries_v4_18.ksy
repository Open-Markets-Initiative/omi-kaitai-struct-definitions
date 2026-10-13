# ---------------------------------------------------------------------
# Kaitai struct definition for: Lme LmeSelect DailySummaries LmeSource v4.18
#
# Protocol:
#   Organization: The London Metal Exchange
#   Protocol: LMEsource DailySummaries
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
  id: lme_lmeselect_dailysummaries_lmesource_v4_18
  title: Lme LmeSelect DailySummaries LmeSource v4.18
  license: GPL-3.0
  endian: le

doc: 'The London Metal Exchange LMEselect LMEsource DailySummaries LmeSource v4.18'
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
            'msg_type::open_interest_message': open_interest_message
            'msg_type::open_interest_band_message': open_interest_band_message
            'msg_type::position_band_message': position_band_message
            'msg_type::warrant_band_message': warrant_band_message
            'msg_type::trading_volume_message': trading_volume_message
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
  open_interest_message:
    seq:
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date for which the open interest is being reported, as YYYYMMDD'
      - id: open_interest_type
        type: u1
        enum: open_interest_type
        doc: 'Type of open interest. The specification names this field Type; it is qualified here because the Reference FX Rate and Warrant Band messages give a Type of their own carrying different sets of values'
      - id: instrument_id
        type: u8_nullable
        doc: 'Instrument to which the open interest applies. Nullable, No Value = 18446744073709551615'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
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
      - id: volume
        type: u4_nullable
        doc: 'Number of open positions expressed in lots. Nullable, No Value = 4294967295'
  open_interest_band_message:
    seq:
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date for which the open interest is being reported, as YYYYMMDD'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
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
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The currency code according to ISO 4217'
      - id: num_date_bands
        type: u4
        doc: 'Number of open interest date bands'
      - id: date_bands
        type: date_bands
        repeat: expr
        repeat-expr: num_date_bands
        doc: 'One open interest date band, giving the open interest volume for the period between two dates'
  date_bands:
    seq:
      - id: from_date
        type: yyyymmdd_date
        doc: 'The date from which open interest volume for the period is calculated, inclusive, as YYYYMMDD'
      - id: to_date
        type: yyyymmdd_date
        doc: 'The date to which open interest volume for the period is calculated, inclusive, as YYYYMMDD'
      - id: volume
        type: u4_nullable
        doc: 'Number of open positions expressed in lots. Nullable, No Value = 4294967295'
  position_band_message:
    seq:
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date for which the open interest is being reported, as YYYYMMDD'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
      - id: num_long_position_bands
        type: u4
        doc: 'Number of bands for long position'
      - id: num_short_position_bands
        type: u4
        doc: 'Number of bands for short position'
      - id: long_position_bands
        type: long_position_bands
        repeat: expr
        repeat-expr: num_long_position_bands
        doc: 'One long position band, giving the percentage range of Market Open Interest and the prompt dates participants hold long positions in'
      - id: short_position_bands
        type: short_position_bands
        repeat: expr
        repeat-expr: num_short_position_bands
        doc: 'One short position band, giving the percentage range of Market Open Interest and the prompt dates participants hold short positions in'
  long_position_bands:
    seq:
      - id: long_position_lower_value
        type: decimal_s8_6
        doc: 'Long position lower band percentage value, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: long_position_upper_value
        type: decimal_s8_6
        doc: 'Long position upper band percentage value, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: num_long_prompt_dates
        type: u4
        doc: 'Number of prompt dates'
      - id: long_prompt_dates
        type: long_prompt_dates
        repeat: expr
        repeat-expr: num_long_prompt_dates
        doc: 'One prompt date of a long position band and the number of participants holding long positions in it'
  long_prompt_dates:
    seq:
      - id: prompt_date_label
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Prompt date label'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'Expiry date, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: participant_count
        type: u4
        doc: 'Number of market participants holding long positions in the given band and prompt'
  short_position_bands:
    seq:
      - id: short_position_lower_value
        type: decimal_s8_6
        doc: 'Short position lower band percentage value, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: short_position_upper_value
        type: decimal_s8_6
        doc: 'Short position upper band percentage value, in implicit six decimal place format. The specification describes this field as the long position upper band percentage value, repeating the wording of the long band; the field is the short band''s upper value. Implied decimal with scale 1e-6'
      - id: num_short_prompt_dates
        type: u4
        doc: 'Number of prompt dates'
      - id: short_prompt_dates
        type: short_prompt_dates
        repeat: expr
        repeat-expr: num_short_prompt_dates
        doc: 'One prompt date of a short position band and the number of participants holding short positions in it'
  short_prompt_dates:
    seq:
      - id: prompt_date_label
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Prompt date label'
      - id: expiry_date
        type: yyyymmdd_date_nullable
        doc: 'Expiry date, as YYYYMMDD. Nullable, No Value = 4294967295'
      - id: participant_count
        type: u4
        doc: 'Number of market participants holding long positions in the given band and prompt'
  warrant_band_message:
    seq:
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date for which the open interest is being reported, as YYYYMMDD'
      - id: warrant_band_type
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type of warrant band. The specification names this field Type; it is qualified here because the Reference FX Rate and Open Interest messages give a Type of their own carrying different sets of values'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
      - id: unreported_warrants
        type: decimal_s8_6_nullable
        doc: 'Percentage of total live, on warrant, stock that remains unreported, in implicit six decimal place format. Applicable to Type WB, otherwise null. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: num_warrant_bands
        type: u4
        doc: 'Number of warrant bands'
      - id: warrant_bands
        type: warrant_bands
        repeat: expr
        repeat-expr: num_warrant_bands
        doc: 'One warrant band, giving the percentage range and the number of participants whose warrant concentration falls within it'
  warrant_bands:
    seq:
      - id: lower_value
        type: decimal_s8_6
        doc: 'Lower band percentage value, in implicit six decimal place format. Implied decimal with scale 1e-6'
      - id: upper_value
        type: decimal_s8_6_nullable
        doc: 'Upper band percentage value, in implicit six decimal place format. Null for Type WC or WT if one hundred. Implied decimal with scale 1e-6. Nullable, No Value = -9223372036854775808'
      - id: participant_count
        type: u4
        doc: 'Number of market participants holding long positions in the given band and prompt'
  trading_volume_message:
    seq:
      - id: business_date
        type: yyyymmdd_date
        doc: 'The business date for which the open interest is being reported, as YYYYMMDD'
      - id: trade_date
        type: yyyymmdd_date
        doc: 'The trade date for which the trading volume is being reported, as YYYYMMDD'
      - id: calculation_type
        type: u1
        enum: calculation_type
        doc: 'Trading volume calculation type'
      - id: instrument_id
        type: u8_nullable
        doc: 'Instrument to which the open interest applies. Nullable, No Value = 18446744073709551615'
      - id: product_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The product code. This identifies the metal for the instrument'
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
      - id: volume
        type: u4_nullable
        doc: 'Number of open positions expressed in lots. Nullable, No Value = 4294967295'
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
  u4_nullable:
    seq:
      - id: value
        type: u4
    instances:
      is_null:
        value: value == 4294967295
  decimal_s8_6:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 1000000.0
  yyyymmdd_date_nullable:
    seq:
      - id: value
        type: yyyymmdd_date
    instances:
      is_null:
        value: value.packed == -1
  decimal_s8_6_nullable:
    seq:
      - id: value
        type: decimal_s8_6
    instances:
      is_null:
        value: value.mantissa == -9223372036854775808

enums:
  msg_type:
    100:
      id: 'sequence_reset_message'
      doc: 'Sent on each multicast channel at start of day, and intraday in case of a disaster recovery. The client must ignore the sequence number of the Sequence Reset message itself and set the next expected sequence number to NewSeqNo, clear all cached data for all instruments and subscribe to the refresh channels to receive the current state of the market.'
    420:
      id: 'open_interest_message'
      doc: 'Reports Exchange and Market Open Interest for open positions in futures and options contracts. Exchange open interest volumes are provided per currency, by contract code, and not aggregated across currencies, whereas market open interest volumes are aggregated across currencies and reported against USD denominated instruments.'
    421:
      id: 'open_interest_band_message'
      doc: 'Reports open interest for all futures trades by product between given dates. Open interest volumes are provided per currency, by contract code, and not aggregated across currencies.'
    422:
      id: 'position_band_message'
      doc: 'Reports the number of market participants holding futures positions as a percentage of Market Open Interest.'
    423:
      id: 'warrant_band_message'
      doc: 'Reports the number of market participants holding a significant percentage of warrants and positions along the front of the curve, being Tom, Cash and Cash plus one day.'
    424:
      id: 'trading_volume_message'
      doc: 'Provides the traded volume in lots for matched trades in futures and options instruments. All trades resulting from Cross Order execution, whether off-book or not, are included in the trading volume calculation.'
  open_interest_type:
    0x45:
      id: 'exchange'
      doc: 'Exchange'
    0x4d:
      id: 'market'
      doc: 'Market'
  contract_type:
    0x46:
      id: 'future'
      doc: 'Future'
    0x4f:
      id: 'option'
      doc: 'Option'
  calculation_type:
    0x44:
      id: 'daily'
      doc: 'Daily'
    0x49:
      id: 'intraday'
      doc: 'Intraday'

