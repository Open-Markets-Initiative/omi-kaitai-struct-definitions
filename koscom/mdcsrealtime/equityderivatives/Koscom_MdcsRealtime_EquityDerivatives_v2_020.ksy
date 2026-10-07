# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime EquityDerivatives Exture v2.020
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Equity Derivatives
#   Encoding: Exture
#   Version: 2.020
#   Date: 9/23/2026
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
  id: koscom_mdcsrealtime_equityderivatives_exture_v2_020
  title: Koscom MdcsRealtime EquityDerivatives Exture v2.020
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Equity Derivatives Exture v2.020'
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
        '"B201S"': equity_derivatives_underlying_snapshot_kospi_message
        '"B201Q"': equity_derivatives_underlying_snapshot_kosdaq_message
        '"B202S"': equity_derivatives_underlying_snapshot_kospi_mm_lp_included_message
        '"B203S"': equity_derivatives_underlying_snapshot_kospi_mm_lp_included_message
        '"B204S"': equity_derivatives_underlying_snapshot_kospi_mm_lp_included_message
        '"B205S"': equity_derivatives_underlying_snapshot_kospi_mm_lp_included_message
        '"A001S"': securities_equities_batch_data_message
        '"A002S"': securities_equities_batch_data_message
        '"A003S"': securities_equities_batch_data_message
        '"A004S"': securities_equities_batch_data_message
        '"A005S"': securities_equities_batch_data_message
        '"A001Q"': securities_equities_batch_data_message
        '"A001X"': securities_equities_batch_data_message
        '"I501S"': securities_closing_date_message
        '"I503S"': securities_closing_date_message
        '"I504S"': securities_closing_date_message
        '"I505S"': securities_closing_date_message
        '"I501Q"': securities_closing_date_message
        '"I501X"': securities_closing_date_message
        '"I701S"': securities_mm_lp_information_message
        '"I702S"': securities_mm_lp_information_message
        '"I703S"': securities_mm_lp_information_message
        '"I704S"': securities_mm_lp_information_message
        '"I705S"': securities_mm_lp_information_message
        '"I701Q"': securities_mm_lp_information_message
        '"I701X"': securities_mm_lp_information_message
        '"M900S"': securities_member_information_message
        '"M900Q"': securities_member_information_message
        '"M900X"': securities_member_information_message
        '"A901S"': securities_treasury_stocks_batch_message
        '"A901Q"': securities_treasury_stocks_batch_message
        '"A901X"': securities_treasury_stocks_batch_message
        '"CA01S"': securities_equity_index_indicator_message
        '"CA01Q"': securities_equity_index_indicator_message
        '"P200S"': securities_dividend_yield_per_industry_message
        '"P200Q"': securities_dividend_yield_per_industry_message
        '"A001B"': bonds_batch_data_message
        '"A001R"': repo_batch_data_message
        '"I601S"': issue_event_message
        '"I602S"': issue_event_message
        '"I603S"': issue_event_message
        '"I604S"': issue_event_message
        '"I605S"': issue_event_message
        '"I601Q"': issue_event_message
        '"I601X"': issue_event_message
        '"I601B"': issue_event_message
        '"I601M"': issue_event_message
        '"I601K"': issue_event_message
        '"I601R"': issue_event_message
        '"F901B"': corporate_bonds_reference_message
        '"F901M"': corporate_bonds_reference_message
        '"BN01B"': regular_bonds_installment_repayment_date_message
        '"CB01R"': repo_classification_data_message
        '"S001R"': repo_trade_availability_per_term_message
        '"G300B"': retail_bonds_type_code_message

types:
  polling_data_message:
    seq:
      - id: current_time
        type: hhmm_ascii_time
        doc: 'Current time in HHMM format, transmitted at one-minute intervals'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  krx_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
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
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. Always 4 ASCII space characters'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  krx_estimated_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
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
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. Always 4 ASCII space characters'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  global_index_message:
    seq:
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
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
        doc: 'ISIN Code'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  bond_index_krx_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: calculating_date
        type: yyyymmdd_ascii_date
        doc: 'Calculation date in YYYYMMDD format'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  equity_derivatives_underlying_snapshot_kospi_message:
    seq:
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: session_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Session is a subordinate concept of a Board and each session follows different trading methods and rules'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: price_change_against_previous_day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Mark Impossible 1:high limit 2:ascended 3:unchanged 4:low limit 5:declined'
      - id: a_price_change_against_the_previous_day
        type: str
        size: 11
        encoding: ASCII
        doc: 'A Price change against the previous day'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: opening_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest price at which an issue traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: the_best_ask
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest offer price'
      - id: the_best_bid
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest quoted bid'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  equity_derivatives_underlying_snapshot_kosdaq_message:
    seq:
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: session_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Session is a subordinate concept of a Board and each session follows different trading methods and rules'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: price_change_against_previous_day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Mark Impossible 1:high limit 2:ascended 3:unchanged 4:low limit 5:declined'
      - id: a_price_change_against_the_previous_day
        type: str
        size: 11
        encoding: ASCII
        doc: 'A Price change against the previous day'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: opening_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest price at which an issue traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: the_best_ask
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest offer price'
      - id: the_best_bid
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest quoted bid'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  equity_derivatives_underlying_snapshot_kospi_mm_lp_included_message:
    seq:
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: session_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Session is a subordinate concept of a Board and each session follows different trading methods and rules'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: price_change_against_previous_day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Mark Impossible 1:high limit 2:ascended 3:unchanged 4:low limit 5:declined'
      - id: a_price_change_against_the_previous_day
        type: str
        size: 11
        encoding: ASCII
        doc: 'A Price change against the previous day'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: opening_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest price at which an issue traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: the_best_ask
        type: str
        size: 11
        encoding: ASCII
        doc: 'The lowest offer price'
      - id: the_best_bid
        type: str
        size: 11
        encoding: ASCII
        doc: 'The highest quoted bid'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_equities_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: total_number_of_instruments_of_the_contract
        type: str
        size: 6
        encoding: ASCII
        doc: '- Total number of instruments per each Information Category'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: abbreviated_issue_code
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated Issue Code'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: abbreviated_issue_name_in_en
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name in EN'
      - id: group_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Group Number'
      - id: market_operation_product_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ID refers to a group of products that are traded with the same trading schedule control'
      - id: security_group_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Group ID (Equities, Investment firms, ETF, ELW, Futures, Options etc.)'
      - id: discrete_time_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to discrete-time trading. (Eligibility for periodic discrete-time trading execution)'
      - id: rights_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rights Type Code (spot) is the same as adjustment code (derivatives) 00: N/A 01: Ex-rights 02: Ex-dividends 03: Ex-distribution 04: Ex-rights and Ex-dividends 05: Interim(quarterly) ex-dividend 06: In'
      - id: par_value_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '00: N/A 01: Split at par value 02: Consolidation at par value 03: Stock split 04: Reverse stock split 99: Others'
      - id: an_issue_of_which_base_price_is_settled_with_a_todays_single_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to an Issue of which base price is settled with a today''s single price'
      - id: reevaluation_reason_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Re-evaluation Reason Code 00: N/A 01: Split-off 02: Reduction of capital 03: Long term-Business stop 04: Excessive dividends 05: Large-scale dividends 06: Split-merger 07: Consolidation or Split-up of'
      - id: base_price_change
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to change of base price due to par-value change or increase of capital'
      - id: random_end_trigger_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'In case of trigger and conditional trigger(2) of random end in single price session, random end will be triggered if price requirements defined in the random end rules are met. ##Code Values## 0: No t'
      - id: market_alert
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Alert'
      - id: market_alert_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Alert_Type Code 00: N/A (None of items chosen for those may notified market warning) 01: Investment Warning 02: Investment Alert 03: Investment Danger'
      - id: korea_corporate_governance_stock_price_index_kogi
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether an issuer has a good governance (only for KOSDAQ)'
      - id: issue_for_administration
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue for Administration'
      - id: unfaithful_disclosure
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Unfaithful Disclosure'
      - id: backdoor_listing
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Back-door Listing'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: industry_id
        type: str
        size: 10
        encoding: ASCII
        pad-right: 0x20
        doc: 'Industry ID'
      - id: small_medium_sized_business
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Small & Medium Sized Business (only for KOSDAQ)'
      - id: section_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: KOSDAQ Prime 2: KOSDAQ Venture 3: KOSDAQ Standard 4: KOSDAQ Growth A: Foreign Company(No Section Type) B: Investment Company(No Section Type) C: SPAC(No Section Type) D: ETF(No Section Type) E: Adm'
      - id: investment_institution_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '"0":N/A, "1": stock overhead investment org. "2": derivative overhead investment org. "3": real-estate overhead investment org. "4": spot goods overhead investment org. "5": short-term financial overh'
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: yesterdays_closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Regular closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: yesterdays_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Yesterday''s Closing Price'
      - id: yesterdays_accumulated_trading_amount
        type: str
        size: 12
        encoding: ASCII
        doc: 'Yesterday''s Accumulated Trading Amount'
      - id: yesterdays_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Yesterday''s Accumulated Trading Value'
      - id: upper_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price subtracting the price limit from the base price'
      - id: substitute_price_of_securities
        type: str
        size: 11
        encoding: ASCII
        doc: 'Substitute price of securities as a consignment guarantee money'
      - id: par_value
        type: str
        size: 11
        encoding: ASCII
        doc: 'Par Value'
      - id: issuing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Issuing price'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: number_of_listed_shares
        type: str
        size: 16
        encoding: ASCII
        doc: 'Number of listed shares'
      - id: liquidation_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Liquidation Trade'
      - id: the_establishment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The establishment date of an investment company, REITs, the ship investment corporation'
      - id: maturity_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Maturity date of Mutual Fund, REITs, Shipbuilding Company'
      - id: exercising_period
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Exercising Period'
      - id: expiration_date_for_right
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiration Date for Right'
      - id: exercise_price_of_elw_or_bw
        type: str
        size: 13
        encoding: ASCII
        doc: 'Exercise Price of ELW or BW'
      - id: capital
        type: str
        size: 22
        encoding: ASCII
        doc: 'Capital'
      - id: credit_order_possibillity
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Credit Order Possibillity'
      - id: limit_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: market_price_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: conditioned_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: best_favorable_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: first_best_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: mid_price_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: stop_limit_price_order_permission_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: capital_increase_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '00:N/A 01: Paid In Capital Increase 02: Free Capital Increase 03: Paid In Capital & Free Capital Increase 99: Others'
      - id: other_stock_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A(Common Stock) 1: Old Preferred Stock 2: New Preferred Stock 9: Other types of Stocks'
      - id: national_stock
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'National Stock (only for KOSPI)'
      - id: appraised_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An appraised price is a base price of an Issue of which base price is settled with today''s single price, and it determines an upper/lower limit price for its opening price'
      - id: lowest_order_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An lower limit price of an issue of which base price is settled with today''s single price'
      - id: highest_order_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An upper limit price of an issue of which base price is settled with today''s single price'
      - id: unit_of_volume_in_main_board
        type: str
        size: 11
        encoding: ASCII
        doc: 'Unit of Volume in Main Board'
      - id: lot_size_afterhours_trading
        type: str
        size: 11
        encoding: ASCII
        doc: 'Lot Size(After-hours Trading)'
      - id: rei_ts_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: General REITs 2: CRV REITs'
      - id: target_stock_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Target Stock_ISIN Code'
      - id: currency_iso_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Codes (ISO 4217) AUD: Austrailian Dollar EUR: Euro GBP: Pound Sterling HKD: Hong Kong Dollar JPY: Japanese Yen KRW: Korean Won SGD: Singapore Dollar USD: US Dollar CHF: Swiss Franc CAD: Canad'
      - id: country_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Country Code'
      - id: market_making_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Making Possibility'
      - id: closing_price_trading_possibility_in_the_after_hours
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Closing PriceTrading Possibility in the After Hours'
      - id: closing_price_trading_in_the_preopening_market
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to a Closing Price Trading in the Pre-opening Market'
      - id: block_trading_in_the_preopening_market
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Block Trading in the Pre-opening Market'
      - id: basket_trading_in_the_preopening_market
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Basket Trading in the Pre-opening Market'
      - id: announcement_of_estimated_trading_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Announcement of Estimated Trading Price'
      - id: short_selling
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Short Selling'
      - id: etf_tracking_difference
        type: str
        size: 13
        encoding: ASCII
        doc: 'ETF Tracking Difference'
      - id: regs
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to REGS'
      - id: spac
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to SPAC (Special Purpose Acquisition Company)'
      - id: tax_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dividend Income Tax, Securities Transaction Tax, etc'
      - id: appraisal_ratio_of_substitute_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'Appraisal ratio of substitute price'
      - id: investment_caution_issue
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether an issue to be an administrative issue or delisted (only for KOSDAQ)'
      - id: delisting_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Delisting date for Issues (Spot: the next of a last trading date, Derv: the last payment date)'
      - id: shortterm_overheat_issue_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A 1: Designation Alert 2: Designation 3: Extension of Designation(Delay in lifting)'
      - id: etf_replication_methods_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ETF''s underlying assets replication methods type code'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiration Date'
      - id: distribution_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Distribution Type Code 01: Unpaid 02: Paid(indicative value is applied ) 03: Paid(indicative value is not applied) 04: Paid(reinvestment) 05: Paid(others)'
      - id: calculation_of_redemption_price_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation of Redemption Price_Start Date'
      - id: calculation_of_redemption_price_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation of Redemption Price_End Date'
      - id: etp_product_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ETP Product Type Code'
      - id: index_calculation_institution_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Calculation Institution_Type Code'
      - id: index_market_classification_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: '*Level 1_classification(2 digits) + Level 2_classification(2 digits) + Level 3 classification(2 digits). - ''00'' is marked in case the value(s) of each classification is(are) omitted. However, the valu'
      - id: index_sequence_number
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Sequence Number'
      - id: tracking_index_leverage_inverse_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Tracking Index Leverage/Inverse Type Code'
      - id: reference_index_leverage_inverse_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reference Index Leverage/Inverse Type Code'
      - id: index_asset_classification_id_1
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: '*Level 1_classification(2 digits) + Level 2_classification(2 digits) + Level 3 classification(2 digits). - ''00'' is marked in case the value(s) of each classification is(are) omitted. However, the valu'
      - id: index_asset_classification_id_2
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: '*Level 1_classification(2 digits) + Level 2_classification(2 digits) + Level 3 classification(2 digits). - ''00'' is marked in case the value(s) of each classification is(are) omitted. However, the valu'
      - id: ipo_underwriter_member_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'IPO Underwriter_Member Number'
      - id: lp_order
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to LP Order'
      - id: low_liquidity
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Low Liquidity'
      - id: abnormal_rise
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abnormal Rise'
      - id: upper_limit_quantity
        type: str
        size: 23
        encoding: ASCII
        doc: 'Upper Limit Quantity'
      - id: investment_precaution_issue
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investment Precaution Issue'
      - id: preferred_stocks_with_lesser_shares
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to possibility of lack of listed shares on a certain time compared to the standard'
      - id: spac_merger
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N'
      - id: segment_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'KOSDAQ Market Segment type code'
      - id: after_market_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to after-market possibility'
      - id: pre_market_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to pre-market possibility'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_closing_date_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: closing_date
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Closing date of a listed company (Dec 31, June 30, Mar 31)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_mm_lp_information_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: market_participant_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A number given to each market participants. If a participant is a member of more than two exchanges, different numbers to be given by exchanges'
      - id: lp_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Start date of Liquidity Provide'
      - id: lp_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'End date of Liquidity Provide'
      - id: minimum_order_volume
        type: str
        size: 11
        encoding: ASCII
        doc: 'Minimum number of trading unit for LP/MM placing an order Eg) If the value is 10 and trading_x000D_ unit is 10 shares, LP/MM Quote should be_x000D_ more than 100 shares (Contract)'
      - id: maximum_volume_of_multiple_order
        type: str
        size: 11
        encoding: ASCII
        doc: 'Maximum number of trading unit for LP/MM placing an order'
      - id: bid_ask_spread_unit_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'R: Price Ratio Y: Yield Ratio T: Tick'
      - id: upper_limit_of_bid_ask_spread
        type: str
        size: 22
        encoding: ASCII
        doc: 'Upper limit of bid-ask spread. A trade can be made within a fixed upper limit of bid-ask spread'
      - id: spread_multiple_for_market_holidays
        type: str
        size: 11
        encoding: ASCII
        doc: 'In case the underlying assets for Derivatives, ELW, ETF are indices or issues of foreign market, when the present value of tracking assets is unable to be judged because of the holiday, pre-hours sess'
      - id: an_obligatory_time_interval_to_place_an_order
        type: str
        size: 6
        encoding: ASCII
        doc: 'A time interval that a market maker should obey between placing an bid/ask order. Unit: Sec'
      - id: minimum_ask_price
        type: str
        size: 22
        encoding: ASCII
        doc: 'LP_Minimum ask price'
      - id: maximum_bid_price
        type: str
        size: 22
        encoding: ASCII
        doc: 'LP_Maximum bid price'
      - id: minimum_order_price
        type: str
        size: 22
        encoding: ASCII
        doc: 'A minimum order price for Block/Basket Trading. (Block: 100 million KRW, Basket: more than 1 billion KRW)'
      - id: maximum_order_price
        type: str
        size: 22
        encoding: ASCII
        doc: 'Maximum Order Price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_member_information_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: market_participant_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A number given to each market participants. If a participant is a member of more than two exchanges, different numbers to be given by exchanges'
      - id: name_of_a_market_participant_in_kr
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of a Market Participant in KR'
      - id: name_of_a_market_participant_in_en
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of a Market Participant in EN'
      - id: an_abbreviated_name_of_a_market_participant_in_kr
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Managing an abbreviated name of a market participant in KR'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_treasury_stocks_batch_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: treasury_stock_report_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A N: Treasury Stock_direct_general S: Treasury Stock_direct_stock options 1 - 99999 Treasury Stock_Trust(report sequence number)'
      - id: treasury_stock_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid_Type Code 1. Ask 2. Bid 3. Ask + Bid'
      - id: treasury_stock_application_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'A date to submit a bid price for treasury stock'
      - id: treasury_stock_trading_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Start date of buying treasury stock'
      - id: treasury_stock_trading_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'End date of buying treasury stock'
      - id: trearsury_stock_trading_method_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Method Type Code 0: N/A 1: Treasury Stocks in General 2: Treasury Stocks including Bank of Korea 3.Treasury Stocks including Government *2,3: The trade is only available with block trading in'
      - id: market_participant_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A number given to each market participants. If a participant is a member of more than two exchanges, different numbers to be given by exchanges'
      - id: buying_volume_open_single_price_session
        type: str
        size: 12
        encoding: ASCII
        doc: 'An amount of treasury stock that a company plans to buy during the opening single price session'
      - id: buying_volume_regular_session
        type: str
        size: 12
        encoding: ASCII
        doc: 'An amount of treasury stock that a company plans to buy during the regular session'
      - id: buying_volume_block_trading_in_offhours_session
        type: str
        size: 12
        encoding: ASCII
        doc: 'An amount of treasury stock that a company plans to buy during off-hours session'
      - id: accumulated_trading_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated trading quantity of treasury stock'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_equity_index_indicator_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: security_group_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Group ID (Equities, Investment firms, ETF, ELW, Futures, Options etc.)'
      - id: eps_calculation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to EPS Calculation'
      - id: eps
        type: str
        size: 22
        encoding: ASCII
        doc: 'EPS'
      - id: loss_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Loss(whether a value of EPS is positive or negative)'
      - id: per
        type: str
        size: 13
        encoding: ASCII
        doc: 'PER'
      - id: bps_calculation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'BPS Calculation'
      - id: bps
        type: str
        size: 22
        encoding: ASCII
        doc: 'Book-value Per Share'
      - id: pbr
        type: str
        size: 13
        encoding: ASCII
        doc: 'Price-to-book Ratio'
      - id: dps_calculation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to DPS Calculation'
      - id: dps
        type: str
        size: 22
        encoding: ASCII
        doc: 'Dividend per Share'
      - id: dividend_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The dividend yield is a ratio that how much dividends an investor would receive relative to the amounts of investment'
      - id: market_capitalization_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Capitalization Type Code KOSPI(0: N/A, 1: Large, 2: Medium, 3: Small) KOSDAQ(0: N/A, 1: Large, 2: Medium, 3: Small)'
      - id: filler_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: index_classification_level_1
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Classification_Level 1(Six digits)'
      - id: index_classification_level_2
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Classification_Level 2(Six digits)'
      - id: index_classification_level_3
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Classification_Level 3(Six digits)'
      - id: kospi_200_sector_code_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'KOSPI200 Sector Index Industry Code (ST,MF,RT,SC,IF) 0: N/A 1: Constructions 2: Heavy Industries 3: Steels & Materials 4: Energy & Chemicals 5: IT 6: Finances 7: Consumer Staples 8: Consumer Discretio'
      - id: kospi_200_sector_code_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'KOSPI200 Sector Index Industry Code (ST,MF,RT,SC,IF) 0: N/A 1: Constructions 2: Heavy Industries 3: Steels & Materials 4: Energy & Chemicals 5: IT 6: Finances 7: Consumer Staples 8: Consumer Discretio'
      - id: kospi
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSPI)'
      - id: kosdaq
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSDAQ)'
      - id: kospi_100
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSPI 100)'
      - id: kospi_50
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSPI 50)'
      - id: kosdaq_150
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSDAQ 150)'
      - id: krx_100
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KRX100)'
      - id: krx_300
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KRX 300)'
      - id: kospi_200_high_dividend_yield_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KOSPI200 High Dividend Yield Index)'
      - id: krx_bbig_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KRX BBIG Index)'
      - id: krx_secondary_battery_top_10_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KRX Secondary Battery TOP 10 Index)'
      - id: krx_bio_top_10_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of KRX Bio TOP 10 Index)'
      - id: korea_valueup_index
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N (whether an issue is a constituent of Korea Value-up Index)'
      - id: filler_8
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Filler 8'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_dividend_yield_per_industry_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: dividend_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'The dividend yield is a ratio that how much dividends an investor would receive relative to the amounts of investment'
      - id: filler_3
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  bonds_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: total_number_of_instruments_of_the_contract
        type: str
        size: 6
        encoding: ASCII
        doc: '- Total number of instruments per each Information Category'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: retail_bond_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'BA: Financial Bonds CA: Corporate Bonds ET: Municipal Bonds EC: Others GA: KTB MA: MSB'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: abbreviated_issue_name_in_en
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name in EN'
      - id: market_operation_product_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ID refers to a group of products that are traded with the same trading schedule control'
      - id: bond_listing_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing type code D:Delisted E: Others I: Pre-Issue N: Not Listed Y:Listed'
      - id: bond_category_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category code'
      - id: bond_guaranteed_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond_Guaranteed Type Code 1:Guaranteed 2:Partial Guaranteed 3:Collateral-backed 4:Non-Guaranteed 5:Government Guaranteed 6:Covered Bond'
      - id: coupon_payment_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '11: Fixed Rate_Discount Bond 12: Fixed Rate_Compounding Interest Bond 13: Fixed Rate_Coupon Bond 14: Fixed Rate_Simple Interest Bond 15: Fixed Rate_Compound(5yrs)+Simple(2yrs) 19: Fixed Rate_Others 21'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: issue_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Date'
      - id: redemption_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Redemption Date'
      - id: sale_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Sale Date'
      - id: bond_issuance_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'Issuance rate of Bond'
      - id: coupon_rate
        type: str
        size: 14
        encoding: ASCII
        doc: 'A coupon rate=an amount of yearly interest/A bond''s face value'
      - id: monthly_cycle_of_coupon_payment
        type: str
        size: 4
        encoding: ASCII
        doc: '0: Irregular 0: Coupon Bond, Compound Interest Bond and others are not transmitted'
      - id: coupon_payment_timing_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Paid in advance 2: Paid afterwards'
      - id: interest_payment
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Issuing date 2: Redemption date'
      - id: coupon_payment_date_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Coupon Payment Date Type Code 1: Based on the date 2: Based on the last date'
      - id: decimal_point_of_coupon_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: No 1: Floor 2: Ceiling 3: Rounding up'
      - id: pre_issue_sale_coupon_payment_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A method of paying an interest during the period from sale date to issue date when pre-sale occurs before issue date. 1: At sales 2: At 1st coupon payment 3. At maturity 4. At sales (KTB Types)'
      - id: issuing_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Issuing Amount'
      - id: listed_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Listed Amount'
      - id: redemption_ratio_at_maturity
        type: str
        size: 13
        encoding: ASCII
        doc: 'Redemption Ratio at Maturity'
      - id: amortization_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Amortization Type Code 1: Level Payment of Principal 2: Level Payment of Principal and Interest 3: Un-level Payment'
      - id: number_of_months_for_grace
        type: str
        size: 4
        encoding: ASCII
        doc: 'Number of Months for Grace'
      - id: number_of_amortization
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Amortization'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: prior_coupon_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Prior Coupon Payment Date'
      - id: next_coupon_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Next Coupon Payment Date'
      - id: perpetual_bond_maturity_structure_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Perpetual Bond_Maturity Structure Status Y: Applicable N: Not Applicable'
      - id: strip_bond_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Strip Bond Type Code 1: General bond 2: Separation of Principal 3: Separation of Interest'
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: liquidation_trade
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Liquidation Trade'
      - id: investment_caution_bond_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investment caution Bond Type Code 0: N/A 1: Designation Alert 2: Designation'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  repo_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: total_number_of_instruments_of_the_contract
        type: str
        size: 6
        encoding: ASCII
        doc: '- Total number of instruments per each Information Category'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: market_operation_product_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ID refers to a group of products that are traded with the same trading schedule control'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: market_value
        type: str
        size: 11
        encoding: ASCII
        doc: 'Market Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  issue_event_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: event_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Event Type Code 01: Trading Halt 02: Oversight Issues 03: Unfaithful Disclosure 04: Liquidation Trade 05: Backdoor Listing 06: Abeyance of Collateralized Security 07: Superior Corporate Governance 08:'
      - id: event_reason_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'When Event Type Code is 01(Trading Halt), 02(Oversight Issues), 05(Backdoor Listing), please refer to the below for more details. "0000" is N/A. 01: (Designation Alert) Application for restoration pro'
      - id: event_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Start date of Issue Event'
      - id: event_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'End date of Issue Event'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  corporate_bonds_reference_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: issue_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Date'
      - id: redemption_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Redemption Date'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: coupon_payment_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '11: Fixed Rate_Discount Bond 12: Fixed Rate_Compounding Interest Bond 13: Fixed Rate_Coupon Bond 14: Fixed Rate_Simple Interest Bond 15: Fixed Rate_Compound(5yrs)+Simple(2yrs) 19: Fixed Rate_Others 21'
      - id: issuing_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Issuing Amount'
      - id: listed_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Listed Amount'
      - id: coupon_payment_timing_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Paid in advance 2: Paid afterwards'
      - id: number_of_months_for_grace
        type: str
        size: 4
        encoding: ASCII
        doc: 'Number of Months for Grace'
      - id: number_of_amortization
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Amortization'
      - id: interest_payment
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Issuing date 2: Redemption date'
      - id: coupon_payment_date_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Coupon Payment Date Type Code 1: Based on the date 2: Based on the last date'
      - id: coupon_rate
        type: str
        size: 14
        encoding: ASCII
        doc: 'A coupon rate=an amount of yearly interest/A bond''s face value'
      - id: substitute_price_of_securities
        type: str
        size: 11
        encoding: ASCII
        doc: 'Substitute price of securities as a consignment guarantee money'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN'
      - id: date_to_start_exercising
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date to Start Exercising'
      - id: date_to_end_exercising
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Date to End Exercising'
      - id: record_date_of_dividend_payout
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Record date of dividend payout 1: Exercise day 2: Last day of previous year 3: Last day of current year'
      - id: exercise_ratio
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exercise Ratio'
      - id: yield_to_maturity
        type: str
        size: 13
        encoding: ASCII
        doc: 'Yield to Maturity'
      - id: corporate_bonds_related_to_securities_exercise_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Equity-linked Bond Exercise Price'
      - id: abbreviated_issue_code
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated Issue Code'
      - id: baby_bonds_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Baby Bonds Type Code'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  regular_bonds_installment_repayment_date_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: installment_repayment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Redemption at maturity date with level/un-leveled payment'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  repo_classification_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: repo_classification_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'REPO Classification Code'
      - id: repo_classification_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'REPO Classification Name'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  repo_trade_availability_per_term_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: number_of_repo_trade_periods
        type: str
        size: 3
        encoding: ASCII
        doc: 'Acutal number of Repo trade periods in Spec'
      - id: repo_trade_period_1
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_2
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_3
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_4
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_5
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_6
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_7
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_8
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_9
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: repo_trade_period_10
        type: str
        size: 3
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  retail_bonds_type_code_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: retail_bond_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'BA: Financial Bonds CA: Corporate Bonds ET: Municipal Bonds EC: Others GA: KTB MA: MSB'
      - id: retail_bond_category_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Retail Bond_Category Name'
      - id: retail_bond_category_name_in_en
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Retail Bond_Category Name in EN'
      - id: retail_bond_generated_quotes
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Generated Quotes'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
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
  end_keyword:
    255:
      id: 'end_of_message'
      doc: 'End Of Message'
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

