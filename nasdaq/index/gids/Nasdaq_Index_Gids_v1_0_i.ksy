# ---------------------------------------------------------------------
# Kaitai struct definition for: Nasdaq Index Gids Itch v1.0.i
#
# Protocol:
#   Organization: National Association of Securities Dealers Automated Quotations (Nasdaq)
#   Protocol: Global Index Data Service
#   Encoding: Itch
#   Version: 1.0.i
#   Date: 4/8/2022
#   Specification: globalindex2-0.pdf
#
# Script:
#   Generator: 1.0.0.0
#   License: MIT No Attribution
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
#   https://patents.google.com/patent/US12101388B2/en
#   https://patents.google.com/patent/US20240419416A1/en
#   https://patents.google.com/patent/US20260368281A1/en
#
# Open Markets Initiative website:
#   https://openmarketsinitiative.com
# ---------------------------------------------------------------------

meta:
  id: nasdaq_index_gids_itch_v1_0_i
  title: Nasdaq Index Gids Itch v1.0.i
  license: MIT-0
  endian: be

doc: 'National Association of Securities Dealers Automated Quotations (Nasdaq) Nasdaq Global Indexes Global Index Data Service Itch v1.0.i'
doc-ref: http://www.nasdaqtrader.com/Trader.aspx?id=DPSpecs

seq:
  - id: packet_header
    type: packet_header_struct
    doc: 'Itch Mold Udp 64 Packet Header'
  - id: messages
    repeat: expr
    repeat-expr: packet_header.message_count
    type:
      switch-on: packet_header.message_count
      cases:
        _: message

types:
  packet_header_struct:
    seq:
      - id: session
        type: str
        size: 10
        encoding: ASCII
        doc: 'Identity of the multicast session'
      - id: sequence_number
        type: u8
        doc: 'Sequence number of the first message to follow this header'
      - id: message_count
        type: u2
        doc: 'Number of messages to follow this header'
  message:
    seq:
      - id: message_header
        type: message_header
        doc: 'Mold Udp 64 Message Header'
      - id: payload
        size: message_header.message_length - 1
        type:
          switch-on: message_header.message_type
          cases:
            'message_type::timestamp_seconds_message': timestamp_seconds_message
            'message_type::system_event_message': system_event_message
            'message_type::index_directory_message': index_directory_message
            'message_type::issue_symbol_participation_message': issue_symbol_participation_message
            'message_type::intraday_index_value_message': intraday_index_value_message
            'message_type::settlement_value_message': settlement_value_message
            'message_type::equities_summary_message': equities_summary_message
            'message_type::fixed_income_summary_message': fixed_income_summary_message
            'message_type::commodity_summary_message': commodity_summary_message
            'message_type::etp_directory_and_daily_valuation_message': etp_directory_and_daily_valuation_message
            'message_type::etp_intra_day_valuation_message': etp_intra_day_valuation_message
            'message_type::etp_summary_message': etp_summary_message
  message_header:
    seq:
      - id: message_length
        type: u2
        doc: 'Length of data message not including this field'
      - id: message_type
        type: u1
        enum: message_type
        doc: 'Code identifying this message type'
  timestamp_seconds_message:
    seq:
      - id: second
        type: second_timestamp
        doc: 'The UTC time, giving the number of seconds since the Unix epoch (midnight, January 1, 1970). Seconds since Unix epoch'
  system_event_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: event_code
        type: u1
        enum: event_code
        doc: 'Denotes the GIDS system event code'
      - id: schedule
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Populated only for session-related event messages, otherwise space filled. Refer to Appendix A'
  index_directory_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: dissemination_flag
        type: u1
        enum: dissemination_flag
        doc: 'Flag to indicate if the index detail messages will be disseminated via GIDS 2.0 for the Instrument ID during the current system date'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: strategy
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index strategy for the Instrument ID. Refer to Appendix A for allowable values'
      - id: asset_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The primary asset class for the Instrument ID. Refer to Appendix A for allowable values'
      - id: market_cap_size
        type: u1
        enum: market_cap_size
        doc: 'The Index market capitalization size for the Instrument ID. Refer to Appendix A for allowable values'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
      - id: geography
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Index Geography code associated with the Instrument ID. Refer to Appendix A for allowable values'
      - id: index_settlement_type
        type: u1
        enum: index_settlement_type
        doc: 'Denotes the Index Settlement Type. Populated for Index Settlement Symbols only'
      - id: index_calculation_method
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Index Calculation Method code associated with the Instrument ID'
      - id: state
        type: u1
        enum: state
        doc: 'Denotes the current Index state associated with the Instrument ID'
      - id: index_usage
        type: u1
        enum: index_usage
        doc: 'Denotes the current Index usage code associated with the Instrument ID'
      - id: schedule
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Populated only for session-related event messages, otherwise space filled. Refer to Appendix A'
      - id: frequency
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Index frequency code associated with the Instrument ID'
      - id: number_of_issue_participation_messages
        type: s4
        doc: 'Reflects the number of Issue Participation messages associated with the given Index Instrument ID; zero if not supported'
      - id: base_value
        type: decimal_s8_11
        doc: 'Index value at inception. Implied decimal with scale 1e-11'
      - id: base_date
        type: yyyymmdd_date
        doc: 'Inception date of the index'
      - id: len_instrument_name
        type: s2
        doc: 'The number of bytes for the Instrument Name field to follow'
      - id: instrument_name
        type: str
        size: len_instrument_name
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Instrument Name or Index Name'
  issue_symbol_participation_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: issue_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The security trading symbol for the component security, as assigned by the Issue MIC'
      - id: issue_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 10383 Market Identification Code (MIC) of the component security''s primary listing market'
      - id: len_issue_name
        type: s2
        doc: 'The number of bytes for the Instrument Name field to follow'
      - id: issue_name
        type: str
        size: len_issue_name
        encoding: ASCII
        pad-right: 0x20
        doc: 'The issue name for the component security, as defined by the Issue MIC'
  intraday_index_value_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: tick_value
        type: decimal_s8_11
        doc: 'The current calculated tick value for instrument ID. Implied decimal with scale 1e-11'
      - id: tick_direction
        type: u1
        enum: tick_direction
        doc: 'The net change direction for the tick value (since the last tick update)'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  settlement_value_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: settlement_value
        type: decimal_s8_11
        doc: 'The current calculated settlement value for the instrument ID. Implied decimal with scale 1e-11'
      - id: settlement_type
        type: u1
        enum: settlement_type
        doc: 'The Index Settlement Type for the Instrument ID. Refer to Appendix A for allowable values'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  equities_summary_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: summary_type
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Summary type'
      - id: sod_value
        type: decimal_s8_11
        doc: 'Start of Day Value (prior day''s closing price adjusted for corporate actions). Implied decimal with scale 1e-11'
      - id: high
        type: decimal_s8_11
        doc: 'calculated high value. Implied decimal with scale 1e-11'
      - id: low
        type: decimal_s8_11
        doc: 'calculated low value. Implied decimal with scale 1e-11'
      - id: eod_value
        type: decimal_s8_11
        doc: 'end of day value. Implied decimal with scale 1e-11'
      - id: net_change
        type: decimal_s8_11
        doc: 'net change (signed, to indicate direction). Implied decimal with scale 1e-11'
      - id: effective_date
        type: yyyymmdd_date
        doc: 'Effective Date to which the information should be applied'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  fixed_income_summary_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: summary_type
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Summary type'
      - id: sod_value
        type: decimal_s8_11
        doc: 'Start of Day Value (prior day''s closing price adjusted for corporate actions). Implied decimal with scale 1e-11'
      - id: high
        type: decimal_s8_11
        doc: 'calculated high value. Implied decimal with scale 1e-11'
      - id: low
        type: decimal_s8_11
        doc: 'calculated low value. Implied decimal with scale 1e-11'
      - id: eod_value
        type: decimal_s8_11
        doc: 'end of day value. Implied decimal with scale 1e-11'
      - id: net_change
        type: decimal_s8_11
        doc: 'net change (signed, to indicate direction). Implied decimal with scale 1e-11'
      - id: effective_date
        type: yyyymmdd_date
        doc: 'Effective Date to which the information should be applied'
      - id: yield_field
        type: decimal_s8_11
        doc: 'Denotes the yield for the instrument value calculated as the weighted average. Implied decimal with scale 1e-11'
      - id: duration
        type: decimal_s8_11
        doc: 'Denotes the Instrument duration value calculated as the weighted average according to Macaulay''s duration. Implied decimal with scale 1e-11'
      - id: coupon
        type: decimal_s8_11
        doc: 'Denotes the index coupon value calculated as the weighted average. Implied decimal with scale 1e-11'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  commodity_summary_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: brand
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index brand name for the Instrument ID. Refer to Appendix A for allowable values'
      - id: series
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Index series identifier for the Instrument ID. Refer to Appendix A for allowable values'
      - id: instrument_id
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'The instrument identifier for the Index'
      - id: summary_type
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Summary type'
      - id: sod_value
        type: decimal_s8_11
        doc: 'Start of Day Value (prior day''s closing price adjusted for corporate actions). Implied decimal with scale 1e-11'
      - id: high
        type: decimal_s8_11
        doc: 'calculated high value. Implied decimal with scale 1e-11'
      - id: low
        type: decimal_s8_11
        doc: 'calculated low value. Implied decimal with scale 1e-11'
      - id: eod_value
        type: decimal_s8_11
        doc: 'end of day value. Implied decimal with scale 1e-11'
      - id: net_change
        type: decimal_s8_11
        doc: 'net change (signed, to indicate direction). Implied decimal with scale 1e-11'
      - id: effective_date
        type: yyyymmdd_date
        doc: 'Effective Date to which the information should be applied'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  etp_directory_and_daily_valuation_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: industry_mic
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 10383 Market Identification Code (MIC) of the component security''s primary listing market'
      - id: etp_trading_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the ETP instrument trading symbol as assigned by the listing market'
      - id: etp_ipv_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Intraday Portfolio Value (IPV) to be disseminated in the ETP IPV Value message'
      - id: schedule
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Populated only for session-related event messages, otherwise space filled. Refer to Appendix A'
      - id: frequency
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the Index frequency code associated with the Instrument ID'
      - id: state
        type: u1
        enum: state
        doc: 'Denotes the current Index state associated with the Instrument ID'
      - id: nav_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Net Asset Value per Creation Unit'
      - id: nav
        type: decimal_s8_2
        doc: 'Net Asset Value per Creation Unit. Implied decimal with scale 1e-2'
      - id: estimated_cash_per_cu_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Estimated Cash Per Creation Unit'
      - id: ecu
        type: decimal_s8_2
        doc: 'Estimated Cash Per Creation Unit. Implied decimal with scale 1e-2'
      - id: total_cash_per_cu_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Total Cash Amount Per Creation Unit'
      - id: total_cash_per_cu
        type: decimal_s8_2
        doc: 'The Estimated T-1 Cash Amount Per Creation Unit. Implied decimal with scale 1e-2'
      - id: estimated_cash_per_share_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Estimated Cash Per Share - Net Accrued Dividend'
      - id: ecs
        type: decimal_s8_2
        doc: 'Estimated Cash Per Share. Implied decimal with scale 1e-2'
      - id: tso_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Symbol identifying the Total Shares Outstanding'
      - id: tso_outstanding
        type: s8
        doc: 'Total Shares Outstanding'
      - id: effective_date
        type: yyyymmdd_date
        doc: 'Effective Date to which the information should be applied'
      - id: yield_field
        type: decimal_s8_11
        doc: 'Denotes the yield for the instrument value calculated as the weighted average. Implied decimal with scale 1e-11'
      - id: coupon
        type: decimal_s8_11
        doc: 'Denotes the index coupon value calculated as the weighted average. Implied decimal with scale 1e-11'
      - id: maturity_date
        type: yyyymmdd_date
        doc: 'For ETN products this will represent when the ETN reaches maturity. Populated for ETN products only'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
      - id: len_etp_name
        type: s2
        doc: 'Length of the following Name'
      - id: etp_name
        type: str
        size: len_etp_name
        encoding: ASCII
        pad-right: 0x20
        doc: 'ETP Instrument Name'
  etp_intra_day_valuation_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: ipv_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the IPV or IIV symbol for the ETP'
      - id: ipv_value
        type: decimal_s8_11
        doc: 'The current calculated value for the IPV symbol. Implied decimal with scale 1e-11'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  etp_summary_message:
    seq:
      - id: nanoseconds
        type: nanosecond_offset
        doc: 'Reflects nanosecond portion of timestamp. Nanoseconds since Second epoch'
      - id: financial_product_type
        type: u1
        enum: financial_product_type
        doc: 'The financial product code associated with the instrument ID. Refer to Appendix A for allowable values'
      - id: summary_type
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Summary type'
      - id: ipv_or_iiv_symbol
        type: str
        size: 18
        encoding: ASCII
        pad-right: 0x20
        doc: 'Denotes the instrument identifier for the ETP in the directory message'
      - id: sod_value
        type: decimal_s8_11
        doc: 'Start of Day Value (prior day''s closing price adjusted for corporate actions). Implied decimal with scale 1e-11'
      - id: high
        type: decimal_s8_11
        doc: 'calculated high value. Implied decimal with scale 1e-11'
      - id: low
        type: decimal_s8_11
        doc: 'calculated low value. Implied decimal with scale 1e-11'
      - id: eod_value
        type: decimal_s8_11
        doc: 'end of day value. Implied decimal with scale 1e-11'
      - id: net_change
        type: decimal_s8_11
        doc: 'net change (signed, to indicate direction). Implied decimal with scale 1e-11'
      - id: effective_date
        type: yyyymmdd_date
        doc: 'Effective Date to which the information should be applied'
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ISO 4217 Currency Code for the Instrument ID'
  second_timestamp:
    seq:
      - id: time
        type: s4
    instances:
      hour:
        value: time / 3600 % 24
      minute:
        value: time / 60 % 60
      second:
        value: time % 60
  nanosecond_offset:
    seq:
      - id: time
        type: s4
    instances:
      millisecond:
        value: time / 1000000 % 1000
      microsecond:
        value: time / 1000 % 1000
      nanosecond:
        value: time % 1000
  decimal_s8_11:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100000000000.0
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
  decimal_s8_2:
    seq:
      - id: mantissa
        type: s8
    instances:
      real:
        value: mantissa / 100.0

enums:
  message_type:
    0x54:
      id: 'timestamp_seconds_message'
      doc: 'For every second during which there is at least one payload message, the seconds since the Unix epoch.'
    0x53:
      id: 'system_event_message'
      doc: 'Signals a data feed handler event.'
    0x52:
      id: 'index_directory_message'
      doc: 'Relays instrument level or reference data for Nasdaq and third party indexes.'
    0x50:
      id: 'issue_symbol_participation_message'
      doc: 'Relays the component securities for select Nasdaq indexes.'
    0x49:
      id: 'intraday_index_value_message'
      doc: 'The Intraday Index Value for a given instrument, disseminated at a defined frequency and schedule.'
    0x41:
      id: 'settlement_value_message'
      doc: 'Sends the official settlement price and settlement session used to settle cash derivatives on financial products when they expire.'
    0x46:
      id: 'equities_summary_message'
      doc: 'Relays the summary of the current trading day''s activity for an equity index.'
    0x42:
      id: 'fixed_income_summary_message'
      doc: 'Relays the summary of the current trading day''s activity for a fixed income index.'
    0x43:
      id: 'commodity_summary_message'
      doc: 'Relays the summary of the current trading day''s activity for a commodity index.'
    0x44:
      id: 'etp_directory_and_daily_valuation_message'
      doc: 'Provides the symbols and values of the prior day''s closing ETP valuations, disseminated as part of the pre-opening processes.'
    0x45:
      id: 'etp_intra_day_valuation_message'
      doc: 'Disseminates the Intraday Portfolio Value (IPV) of an ETF or the Intra-Day Indicative Value (IIV) of an ETMF.'
    0x56:
      id: 'etp_summary_message'
      doc: 'Relays the summary of the current trading day''s IPV activity for an ETF or the IIV activity for an ETMF.'
  event_code:
    0x4f:
      id: 'start_of_messages'
      doc: 'Outside of time stamp messages, the first message sent in any trading day.'
    0x53:
      id: 'start_of_day'
      doc: 'The beginning of the operational cycle for processing.'
    0x45:
      id: 'end_of_day'
      doc: 'The end of active message dissemination for the operational cycle.'
    0x43:
      id: 'end_of_messages'
      doc: 'Always the last message sent in any trading day'
    0x51:
      id: 'session_open'
      doc: 'Start of the stated GIDS Index Schedule identified in the next field.'
    0x4d:
      id: 'session_close'
      doc: 'End of the stated GIDS Index Schedule identified in the next field.'
  dissemination_flag:
    0x59:
      id: 'disseminated'
      doc: 'Index Detail messages are being disseminated'
    0x4e:
      id: 'not_disseminated'
      doc: 'Index Detail messages are not being disseminated'
  financial_product_type:
    0x20:
      id: 'not_specified'
      doc: 'Not Specified'
    0x49:
      id: 'index'
      doc: 'Index'
    0x45:
      id: 'exchange_traded_fund'
      doc: 'Exchange Traded Fund (ETF)'
    0x4e:
      id: 'exchange_traded_note'
      doc: 'Exchange Traded Note (ETN)'
    0x46:
      id: 'exchange_traded_managed_fund'
      doc: 'Exchange Traded Managed Fund (ETMF)'
    0x53:
      id: 'settlement'
      doc: 'Settlement'
    0x50:
      id: 'spot'
      doc: 'Spot'
    0x4c:
      id: 'subordinated_product'
      doc: 'Subordinated product'
    0x57:
      id: 'world_currency'
      doc: 'World Currency'
    0x41:
      id: 'alpha_index'
      doc: 'Alpha Index'
  market_cap_size:
    0x20:
      id: 'not_specified'
      doc: 'Not Specified'
    0x41:
      id: 'all'
      doc: 'All'
    0x4c:
      id: 'large'
      doc: 'Large'
    0x4d:
      id: 'mid'
      doc: 'Mid'
    0x53:
      id: 'small'
      doc: 'Small'
    0x58:
      id: 'large_and_mid'
      doc: 'Large And Mid'
    0x59:
      id: 'mid_and_small'
      doc: 'Mid And Small'
  index_settlement_type:
    0x20:
      id: 'not_specified'
      doc: 'Not Specified'
    0x4f:
      id: 'settles_at_the_open'
      doc: 'Instrument settles at the open'
    0x43:
      id: 'settles_at_the_close'
      doc: 'Instrument settles at the close'
    0x4d:
      id: 'settles_at_mid_day'
      doc: 'Instrument settles at mid day'
  state:
    0x41:
      id: 'active'
      doc: 'Active'
    0x48:
      id: 'held'
      doc: 'Held'
    0x50:
      id: 'pending'
      doc: 'Pending'
    0x44:
      id: 'deleted'
      doc: 'Deleted'
  index_usage:
    0x4c:
      id: 'live'
      doc: 'Live'
    0x44:
      id: 'demo'
      doc: 'Demo'
    0x54:
      id: 'test'
      doc: 'Test'
  tick_direction:
    0x2b:
      id: 'positive'
      doc: 'Positive or zero net change (net gain)'
    0x2d:
      id: 'negative'
      doc: 'Negative net change (net loss)'
    0x20:
      id: 'no_net_change_calculated'
      doc: 'No net change calculated'
  settlement_type:
    0x20:
      id: 'not_specified'
      doc: 'Not Specified'
    0x4f:
      id: 'settles_at_the_open'
      doc: 'Instrument settles at the open'
    0x43:
      id: 'settles_at_the_close'
      doc: 'Instrument settles at the close'
    0x4d:
      id: 'settles_at_mid_day'
      doc: 'Instrument settles at mid day'

