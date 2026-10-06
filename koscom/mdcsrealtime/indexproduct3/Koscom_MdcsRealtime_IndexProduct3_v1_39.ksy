# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime IndexProduct3 Exture v1.39
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Index Product 3
#   Encoding: Exture
#   Version: 1.39
#   Date: 5/18/2026
#   Specification: Unknown
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
  id: koscom_mdcsrealtime_indexproduct3_exture_v1_39
  title: Koscom MdcsRealtime IndexProduct3 Exture v1.39
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Index Product 3 Exture v1.39'
doc-ref: https://data.koscom.co.kr

seq:
  - id: message_code
    type: str
    size: 5
    encoding: ASCII
    pad-right: 0x20
    doc: 'Five-character ASCII TR-CODE identifying the disseminated market data record. Formed by concatenating a 2-character Data Category (message family, e.g. "IA" Krx Index, "B6" Quote, "C4" Negotiated Trade, "A7" Market Operation TS) with a 3-character Information Category (market/product variant, typically 2-digit information code plus 1-character market code, e.g. "01S" = Equities/KOSPI, "01F" = Derivatives, "000" = All Market)'
  - id: payload
    type:
      switch-on: message_code
      cases:
        '"I2000"': polling_data_message
        '"IA000"': krx_index_message
        '"IB000"': krx_estimated_index_message
        '"J2000"': global_index_message
        '"J4000"': bond_prime_index_message
        '"K1000"': bond_ktb_index_message
        '"K8000"': bond_ktb_index_term_structure_message
        '"IG000"': bond_index_krx_message

types:
  polling_data_message:
    seq:
      - id: current_time
        type: hhmm_ascii_time
        doc: 'Current time in HHMM format, transmitted at one-minute intervals'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  krx_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code for the index. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Index calculation time. During market hours: HHMMSS (time:min:sec). End of the regular session: final calculation timestamp'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current index value (9 ASCII digits with 2 implied decimal places)'
      - id: index_change_sign_against_the_previous_day
        type: u1
        enum: index_change_sign_against_the_previous_day
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' unchanged, ''-'' declined'
      - id: index_change_against_the_previous_day
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places)'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume of the index constituents (12 ASCII digits). Unit: 1,000 shares'
      - id: accumulated_trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value of the index constituents (12 ASCII digits). Unit: Million KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. Always 4 ASCII space characters'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  krx_estimated_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code for the index. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Index calculation time. During market hours: HHMMSS (time:min:sec). End of the regular session: final calculation timestamp'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current index value (9 ASCII digits with 2 implied decimal places)'
      - id: index_change_sign_against_the_previous_day
        type: u1
        enum: index_change_sign_against_the_previous_day
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' unchanged, ''-'' declined'
      - id: index_change_against_the_previous_day
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places)'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading volume of the index constituents (12 ASCII digits). Unit: 1,000 shares'
      - id: accumulated_trading_value
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated trading value of the index constituents (12 ASCII digits). Unit: Million KRW'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. Always 4 ASCII space characters'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  global_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code for the index. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: business_date
        type: yyyymmdd_ascii_date
        doc: 'Business date for the index calculation in YYYYMMDD format'
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Index calculation time. During market hours: HHMMSS (time:min:sec). End of the regular session: final calculation timestamp'
      - id: index
        type: str
        size: 9
        encoding: ASCII
        doc: 'Current index value (9 ASCII digits with 2 implied decimal places)'
      - id: index_change_sign_against_the_previous_day
        type: u1
        enum: index_change_sign_against_the_previous_day
        doc: 'Sign of the index change against the previous day. ''+'' ascended, '' '' unchanged, ''-'' declined'
      - id: index_change_against_the_previous_day
        type: str
        size: 9
        encoding: ASCII
        doc: 'Magnitude of the index change against the previous day (9 ASCII digits with 2 implied decimal places)'
      - id: currency_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISO 4217 currency code of the index value'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. Always 4 ASCII space characters'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  bond_prime_index_message:
    seq:
      - id: calculating_date
        type: yyyymmdd_ascii_date
        doc: 'Calculation date in YYYYMMDD format'
      - id: calculating_time
        type: hhmmss_ascii_time
        doc: 'Calculation time in HHMMSS plus two trailing spaces'
      - id: group_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond Prime Index Group Code. JA000 group identifier; check the TR-CODE for the specific group'
      - id: maturity_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond Prime Index Maturity Code. JA000 maturity identifier; check the TR-CODE for the specific maturity bucket'
      - id: clean_price_index_krx
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clean price index value (16 ASCII digits with 6 implied decimal places)'
      - id: total_earnings_index
        type: str
        size: 16
        encoding: ASCII
        doc: 'Total earnings index value (16 ASCII digits with 6 implied decimal places)'
      - id: clean_price_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted clean price index value (16 ASCII digits with 6 implied decimal places)'
      - id: total_earnings_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted total earnings index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_clean_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the clean index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_sum_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the sum index value (16 ASCII digits with 6 implied decimal places)'
      - id: average_duration
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average duration across the index constituents (16 ASCII digits with 6 implied decimal places)'
      - id: average_convexity
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average convexity across the index constituents (16 ASCII digits with 6 implied decimal places)'
      - id: average_yld
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average yield across the index constituents (16 ASCII digits with 6 implied decimal places). Unit: percent'
      - id: transmission_time
        type: hhmmssmm_ascii_time
        doc: 'Transmission time in HHMMSSMM format (8 ASCII digits)'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  bond_ktb_index_message:
    seq:
      - id: bond_index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond index identifier. Examples: BGG01T (KTB Index), BGG03T (KTB 10Y Index)'
      - id: base_date
        type: yyyymmdd_ascii_date
        doc: 'Base date for the index calculation in YYYYMMDD format'
      - id: base_time
        type: hhmmss_ascii_time
        doc: 'Base time for the index calculation in HHMMSS format'
      - id: total_profit_index
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total profit index (11 ASCII digits with 4 implied decimal places)'
      - id: clean_price_index_ktb
        type: str
        size: 11
        encoding: ASCII
        doc: 'Clean price index (11 ASCII digits with 4 implied decimal places)'
      - id: market_price_index_ktb
        type: str
        size: 11
        encoding: ASCII
        doc: 'Market price index (11 ASCII digits with 4 implied decimal places)'
      - id: call_reinvestment_index_ktb
        type: str
        size: 11
        encoding: ASCII
        doc: 'Call re-investment index (11 ASCII digits with 4 implied decimal places)'
      - id: zero_reinvestment_index_ktb
        type: str
        size: 11
        encoding: ASCII
        doc: 'Zero re-investment index (11 ASCII digits with 4 implied decimal places)'
      - id: futures_basis_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Futures basis price (10 ASCII digits with 2 implied decimal places)'
      - id: duration
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond index average duration (7 ASCII digits with 3 implied decimal places)'
      - id: convexity
        type: str
        size: 7
        encoding: ASCII
        doc: 'Bond index average convexity (7 ASCII digits with 3 implied decimal places)'
      - id: average_ytm
        type: str
        size: 7
        encoding: ASCII
        doc: 'Average yield to maturity (7 ASCII digits with 3 implied decimal places). Unit: percent'
      - id: average_forward_ytm
        type: str
        size: 7
        encoding: ASCII
        doc: 'Average forward yield to maturity (7 ASCII digits with 3 implied decimal places). Unit: percent'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  bond_ktb_index_term_structure_message:
    seq:
      - id: bond_index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond index identifier. Examples: BGG01T (KTB Index), BGG03T (KTB 10Y Index)'
      - id: base_date
        type: yyyymmdd_ascii_date
        doc: 'Base date for the index calculation in YYYYMMDD format'
      - id: base_time
        type: hhmmss_ascii_time
        doc: 'Base time for the index calculation in HHMMSS format'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code for the index. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: basis_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Basis price of the constituent (10 ASCII digits with 2 implied decimal places)'
      - id: clean_price
        type: str
        size: 10
        encoding: ASCII
        doc: 'Clean price of the constituent (10 ASCII digits with 2 implied decimal places)'
      - id: average_ytm
        type: str
        size: 7
        encoding: ASCII
        doc: 'Average yield to maturity (7 ASCII digits with 3 implied decimal places). Unit: percent'
      - id: index_constituent
        type: u1
        enum: index_constituent
        doc: 'Flag identifying whether the security is included in the index. ''0'' securities are included in the ETF but not in the Index; ''1'' securities are included in the Index'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  bond_index_krx_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'Message sequence number assigned by the Market Engine'
      - id: calculating_date
        type: yyyymmdd_ascii_date
        doc: 'Calculation date in YYYYMMDD format'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
      - id: clean_price_index_krx
        type: str
        size: 16
        encoding: ASCII
        doc: 'Clean price index value (16 ASCII digits with 6 implied decimal places)'
      - id: total_earnings_index
        type: str
        size: 16
        encoding: ASCII
        doc: 'Total earnings index value (16 ASCII digits with 6 implied decimal places)'
      - id: market_price_index_krx
        type: str
        size: 16
        encoding: ASCII
        doc: 'Market price index value (16 ASCII digits with 6 implied decimal places)'
      - id: zero_reinvestment_index_krx
        type: str
        size: 16
        encoding: ASCII
        doc: 'Zero re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: call_reinvestment_index_krx
        type: str
        size: 16
        encoding: ASCII
        doc: 'Call re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: clean_price_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted clean price index value (16 ASCII digits with 6 implied decimal places)'
      - id: total_earnings_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted total earnings index value (16 ASCII digits with 6 implied decimal places)'
      - id: market_price_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted market price index value (16 ASCII digits with 6 implied decimal places)'
      - id: zero_re_investment_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted zero re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: call_re_investment_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted call re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_clean_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the clean index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_sum_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the sum index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_zero_re_investment_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the zero re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: weight_of_call_re_investment_index_value_for_integrity_index_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Integrity-index weight for the call re-investment index value (16 ASCII digits with 6 implied decimal places)'
      - id: average_duration
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average duration across the index constituents (16 ASCII digits with 6 implied decimal places)'
      - id: average_convexity
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average convexity across the index constituents (16 ASCII digits with 6 implied decimal places)'
      - id: average_yld
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average yield across the index constituents (16 ASCII digits with 6 implied decimal places). Unit: percent'
      - id: average_coupon_price
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average coupon price (16 ASCII digits with 6 implied decimal places)'
      - id: average_remaining_maturity_price
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average remaining maturity (16 ASCII digits with 6 implied decimal places). Unit: year'
      - id: average_current_yield
        type: str
        size: 16
        encoding: ASCII
        doc: 'Average current yield (16 ASCII digits with 6 implied decimal places)'
      - id: average_spread_sign
        type: u1
        enum: average_spread_sign
        doc: 'Sign of the average spread. ''+'' ascended, '' '' unchanged, ''-'' declined'
      - id: average_spread
        type: str
        size: 16
        encoding: ASCII
        doc: 'Magnitude of the average spread (16 ASCII digits with 6 implied decimal places)'
      - id: index_number_of_securities
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of constituent securities included in the index (8 ASCII digits)'
      - id: issued_amount
        type: str
        size: 20
        encoding: ASCII
        doc: 'Total issued amount across constituents (20 ASCII digits). Unit: KRW'
      - id: issued_amount_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted issued amount (16 ASCII digits with 6 implied decimal places)'
      - id: index_market_capitalization
        type: str
        size: 20
        encoding: ASCII
        doc: 'Total market capitalization of the index constituents (20 ASCII digits). Unit: KRW'
      - id: market_capitalization_weight
        type: str
        size: 16
        encoding: ASCII
        doc: 'Weighted market capitalization (16 ASCII digits with 6 implied decimal places)'
      - id: accumulated_cash
        type: str
        size: 26
        encoding: ASCII
        doc: 'Accumulated cash position (26 ASCII digits with 6 implied decimal places)'
      - id: cash_inflow
        type: str
        size: 26
        encoding: ASCII
        doc: 'Cash inflow during the calculation period (26 ASCII digits with 6 implied decimal places)'
      - id: reinvest_call_cash
        type: str
        size: 26
        encoding: ASCII
        doc: 'Reinvested call cash during the calculation period (26 ASCII digits with 6 implied decimal places)'
      - id: end_keyword
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'End of text sentinel (0xFF) marking the end of the message'
  hhmm_ascii_time:
    seq:
      - id: text
        type: str
        size: 4
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
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
  yyyymmdd_ascii_date:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      year:
        value: text.substring(0, 4).to_i
      month:
        value: text.substring(4, 6).to_i
      day:
        value: text.substring(6, 8).to_i
  hhmmssmm_ascii_time:
    seq:
      - id: text
        type: str
        size: 8
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
      hundredth:
        value: text.substring(6, 8).to_i

enums:
  index_change_sign_against_the_previous_day:
    0x2b:
      id: 'ascended'
      doc: 'Ascended'
    0x20:
      id: 'unchanged'
      doc: 'Unchanged'
    0x2d:
      id: 'declined'
      doc: 'Declined'
  index_constituent:
    0x30:
      id: 'included_in_etf_not_in_index'
      doc: 'Included In Etf Not In Index'
    0x31:
      id: 'included_in_index'
      doc: 'Included In Index'
  average_spread_sign:
    0x2b:
      id: 'ascended'
      doc: 'Ascended'
    0x20:
      id: 'unchanged'
      doc: 'Unchanged'
    0x2d:
      id: 'declined'
      doc: 'Declined'

