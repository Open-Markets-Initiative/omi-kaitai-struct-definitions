# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime Commodities Exture v2.020
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Commodities
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
  id: koscom_mdcsrealtime_commodities_exture_v2_020
  title: Koscom MdcsRealtime Commodities Exture v2.020
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Commodities Exture v2.020'
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
        '"B601G"': spot_gold_quote_message
        '"A301G"': spot_gold_order_filled_message
        '"G701G"': spot_gold_order_filled_plus_quote_message
        '"R101G"': spot_gold_market_operation_ts_plus_quote_message
        '"B201G"': spot_gold_snapshot_message
        '"C401G"': spot_gold_negotiated_trade_message
        '"B601E"': emissions_quote_message
        '"A301E"': emissions_order_filled_message
        '"G701E"': emissions_order_filled_plus_quote_message
        '"R101E"': emissions_market_operation_ts_plus_quote_message
        '"B201E"': emissions_snapshot_message
        '"C401E"': emissions_negotiated_trade_message
        '"A401E"': emissions_determination_of_base_price_message
        '"AC01E"': emissions_auction_results_message
        '"A001G"': spot_gold_batch_data_message
        '"A001E"': emissions_batch_data_message
        '"M200G"': external_gold_spot_closing_price_message
        '"A701G"': spot_gold_market_operation_ts_message
        '"A601G"': spot_gold_issue_closing_message
        '"M401G"': spot_gold_market_operation_schedule_message
        '"A701E"': emissions_market_operation_ts_message
        '"A601E"': emissions_issue_closing_message
        '"M401E"': emissions_market_operation_schedule_message
        '"A501X"': spot_gold_random_end_message
        '"A501G"': spot_gold_random_end_message

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
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
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
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
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
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
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
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
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
        doc: 'Index identifier. Refer to Code Table sheet "Index List by Contracts (Real-Time)"'
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
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Provided only in case of "USDKRW" - GOLDKRWGR'
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
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_order_filled_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: previous_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A trading price made right before the final trading price as of now but with a differenct value. E.g.) 10 am: 90 KRW, 10:10 a.m: 100 KRW, 10:20 a.m (now): 100 -> the previous price is 90 KRW'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: lp_holding_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'LP holding quantity per each account'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_order_filled_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: previous_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A trading price made right before the final trading price as of now but with a differenct value. E.g.) 10 am: 90 KRW, 10:10 a.m: 100 KRW, 10:20 a.m (now): 100 -> the previous price is 90 KRW'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: lp_holding_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'LP holding quantity per each account'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_market_operation_ts_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_snapshot_message:
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: current_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last traded price at the current page'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_negotiated_trade_message:
    seq:
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
      - id: negotiated_trade_accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Negotiated Trade_Accumulated Trading volume'
      - id: negotiated_trade_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Negotiated Trade_Accumulated Trading value'
      - id: total_accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Accumulated Trading volume'
      - id: total_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Total Accumulated Trading Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_order_filled_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: previous_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A trading price made right before the final trading price as of now but with a differenct value. E.g.) 10 am: 90 KRW, 10:10 a.m: 100 KRW, 10:20 a.m (now): 100 -> the previous price is 90 KRW'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_order_filled_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: previous_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A trading price made right before the final trading price as of now but with a differenct value. E.g.) 10 am: 90 KRW, 10:10 a.m: 100 KRW, 10:20 a.m (now): 100 -> the previous price is 90 KRW'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_market_operation_ts_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_snapshot_message:
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: current_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last traded price at the current page'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
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
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: negotiated_block_trade_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Negotiated Block Trade_Trading Volume'
      - id: negotiated_block_trade_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Negotiated Block Trade_Trading Value'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: ask_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: total_ask_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Total bid volume'
      - id: estimated_trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_negotiated_trade_message:
    seq:
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
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
      - id: trading_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_determination_of_base_price_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
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
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: upper_limit_of_base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Price of Base Price'
      - id: lower_limit_of_base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Lower Price of Base Price'
      - id: block_trading_upper_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price of Block Trading After hours'
      - id: block_trading_lower_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Lower Limit Price of Block Trading After hours'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_auction_results_message:
    seq:
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
      - id: auction_bid_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Auction_Bid Volume'
      - id: auction_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Auction Price'
      - id: auction_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Auction Volume'
      - id: volume_in_the_bid_invitation
        type: str
        size: 12
        encoding: ASCII
        doc: 'Volume in the Bid Invitation'
      - id: number_of_bidders
        type: str
        size: 13
        encoding: ASCII
        doc: 'Number of Bidders'
      - id: bidtocover_ratio
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid-to-cover Ratio'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_batch_data_message:
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
      - id: issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: english_issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'English Issue Name'
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
      - id: security_group_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Group ID (Equities, Investment firms, ETF, ELW, Futures, Options etc.)'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: delisting_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Delisting date for Issues (Spot: the next of a last trading date, Derv: the last payment date)'
      - id: market_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Index Derivatives, Equities Derivatives, Bonds Derivatives etc.)'
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
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: random_end_trigger_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Trigger of Random End in the opening single price session 2: Removal of Random End in the opening single price session 3: Trigger of Random End in the closing single price session 4: Removal of Ran'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: unit_of_volume_in_main_board
        type: str
        size: 11
        encoding: ASCII
        doc: 'Unit of Volume in Main Board'
      - id: yesterdays_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Yesterday''s Closing Price'
      - id: yesterdays_closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Regular closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: substitute_price_of_securities
        type: str
        size: 11
        encoding: ASCII
        doc: 'Substitute price of securities as a consignment guarantee money'
      - id: appraisal_ratio_of_substitute_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'Appraisal ratio of substitute price'
      - id: a_representative_issue_to_calculate_base_price
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Representative Issue to Calculate Base Price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_batch_data_message:
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
      - id: issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: english_issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'English Issue Name'
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
      - id: security_group_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Group ID (Equities, Investment firms, ETF, ELW, Futures, Options etc.)'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: delisting_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Delisting date for Issues (Spot: the next of a last trading date, Derv: the last payment date)'
      - id: market_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Index Derivatives, Equities Derivatives, Bonds Derivatives etc.)'
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
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: random_end_trigger_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Trigger of Random End in the opening single price session 2: Removal of Random End in the opening single price session 3: Trigger of Random End in the closing single price session 4: Removal of Ran'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: unit_of_volume_in_main_board
        type: str
        size: 11
        encoding: ASCII
        doc: 'Unit of Volume in Main Board'
      - id: yesterdays_closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Yesterday''s Closing Price'
      - id: yesterdays_closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Regular closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: substitute_price_of_securities
        type: str
        size: 11
        encoding: ASCII
        doc: 'Substitute price of securities as a consignment guarantee money'
      - id: appraisal_ratio_of_substitute_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'Appraisal ratio of substitute price'
      - id: a_representative_issue_to_calculate_base_price
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'A Representative Issue to Calculate Base Price'
      - id: an_issue_of_which_base_price_is_settled_with_a_todays_single_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to an Issue of which base price is settled with a today''s single price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  external_gold_spot_closing_price_message:
    seq:
      - id: data_type
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1 : Real-Time 2 : Closing price'
      - id: job_code_symbol
        type: str
        size: 16
        encoding: ASCII
        pad-right: 0x20
        doc: '"GOLDUSDOZ " or "GOLDKRWGR "'
      - id: trading_date
        type: yyyymmdd_ascii_date
        doc: 'YYYYMMDD'
      - id: trading_time
        type: hhmmss_ascii_time
        doc: 'HHMMSS'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
      - id: high_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
      - id: low_price
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
      - id: closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing price on the day''s regular session'
      - id: change_from_previous_day_sign
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '+'' : up '' '' : steady ''-'' : down'
      - id: change_from_previous_day
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V99 ex) : " 1471"'
      - id: fluctuating_rate
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '+999999V99 ex1) +1% = " +100" ex2) : -1% = " -100" ex3) : 0% = " 0"'
      - id: bid_quote
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
      - id: ask_quote
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999999V999 ex) : " 1209855"'
      - id: currency_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Provided only in case of "USDKRW" - GOLDKRWGR'
      - id: conversion_basic_exchange_rate
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Provided only in case of "USDKRW" - GOLDKRWGR ex) : " 1209855"'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_market_operation_ts_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_issue_closing_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
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
      - id: closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing price on the day''s regular session'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: filler_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price on the Single Price Trade in the Off-Hours Session'
      - id: second_filler_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price on the Single Price Trade in the Off-Hours Session'
      - id: closing_price_weighted_stock_price_average
        type: str
        size: 11
        encoding: ASCII
        doc: '- Weighted Average is calculated by adding up an issue''s aggregated market value, which is part of a certain index or markets, and dividing it with the total shares listed. - Weighted Stock Price Aver'
      - id: closing_price_base_price_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Base Price of Buy-In'
      - id: closing_price_upper_limit_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Upper Limit of Buy-In'
      - id: closing_price_lower_limit_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Lower Limit of Buy-In'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_market_operation_schedule_message:
    seq:
      - id: market_operation_product_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ID refers to a group of products that are traded with the same trading schedule control'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: session_start_end_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code refers to the start/end of session. Board will end when the last session ends. BS: Board Start BE: Board End SS: Session Start SE: Session End SH: Session Halt SR: Session Resumption'
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
      - id: isin_code_of_a_common_stock
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code of a Common Stock'
      - id: product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product ID'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: trading_halt_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Treasury Stock 2: Warrant 3: Right 4: Underlying Asset ELW 5: Issue ELW 6: Listed Company 7: Underlying Asset Applied Market 8: Index(not using) 9: Issue ETN D: Issue (New securities)'
      - id: step_applied
        type: str
        size: 2
        encoding: ASCII
        doc: 'Managing steps to be applied'
      - id: price_limit_range_expansion_for_base_issue_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to expand price limit range for Base Issue D: descending U: Up X: N/A'
      - id: expected_time_of_expanding_price_limit_range
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expected Time of Expanding Price Limit Range'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_market_operation_ts_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: a_designated_number_for_an_issue
        type: str
        size: 6
        encoding: ASCII
        doc: 'A designated number for each issue on a daily basis - Market(Information Product) : KOSPI(Securities A, Securities C), KOSDAQ(Securities B), KONEX(Securities B), Derivatives(DRV A), Spot Gold(Commodit'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_issue_closing_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
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
      - id: closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing price on the day''s regular session'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: filler_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price on the Single Price Trade in the Off-Hours Session'
      - id: second_filler_11
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price on the Single Price Trade in the Off-Hours Session'
      - id: closing_price_weighted_stock_price_average
        type: str
        size: 11
        encoding: ASCII
        doc: '- Weighted Average is calculated by adding up an issue''s aggregated market value, which is part of a certain index or markets, and dividing it with the total shares listed. - Weighted Stock Price Aver'
      - id: closing_price_base_price_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Base Price of Buy-In'
      - id: closing_price_upper_limit_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Upper Limit of Buy-In'
      - id: closing_price_lower_limit_of_buy_in
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price_Lower Limit of Buy-In'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  emissions_market_operation_schedule_message:
    seq:
      - id: market_operation_product_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'The ID refers to a group of products that are traded with the same trading schedule control'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: board_event_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ID indicates an event that occurs on a Board in a designated time'
      - id: start_time_of_a_board_event
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a Board Event occurs'
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: session_start_end_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code refers to the start/end of session. Board will end when the last session ends. BS: Board Start BE: Board End SS: Session Start SE: Session End SH: Session Halt SR: Session Resumption'
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
      - id: isin_code_of_a_common_stock
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN code of a Common Stock'
      - id: product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product ID'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code 1XX~301: KOSPI 6XX: KOSDAQ + KONEX 7XX: KONEX BXX: Bond RXX: REPO'
      - id: trading_halt_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Treasury Stock 2: Warrant 3: Right 4: Underlying Asset ELW 5: Issue ELW 6: Listed Company 7: Underlying Asset Applied Market 8: Index(not using) 9: Issue ETN D: Issue (New securities)'
      - id: step_applied
        type: str
        size: 2
        encoding: ASCII
        doc: 'Managing steps to be applied'
      - id: price_limit_range_expansion_for_base_issue_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to expand price limit range for Base Issue D: descending U: Up X: N/A'
      - id: expected_time_of_expanding_price_limit_range
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expected Time of Expanding Price Limit Range'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  spot_gold_random_end_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
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
      - id: random_end_trigger_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Trigger of Random End in the opening single price session 2: Removal of Random End in the opening single price session 3: Trigger of Random End in the closing single price session 4: Removal of Ran'
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
  hhmmssuuuuuu_ascii_time:
    seq:
      - id: text
        type: str
        size: 12
        encoding: ASCII
    instances:
      hour:
        value: text.substring(0, 2).to_i
      minute:
        value: text.substring(2, 4).to_i
      second:
        value: text.substring(4, 6).to_i
      microsecond:
        value: text.substring(6, 12).to_i

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

