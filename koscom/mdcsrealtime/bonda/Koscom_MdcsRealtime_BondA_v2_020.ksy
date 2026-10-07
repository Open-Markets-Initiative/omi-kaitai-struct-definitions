# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime BondA Exture v2.020
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Bond A
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
  id: koscom_mdcsrealtime_bonda_exture_v2_020
  title: Koscom MdcsRealtime BondA Exture v2.020
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Bond A Exture v2.020'
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
        '"A701S"': market_operation_ts_message
        '"A702S"': market_operation_ts_message
        '"A703S"': market_operation_ts_message
        '"A704S"': market_operation_ts_message
        '"A705S"': market_operation_ts_message
        '"A701Q"': market_operation_ts_message
        '"A701X"': market_operation_ts_message
        '"A701B"': market_operation_ts_message
        '"A701M"': market_operation_ts_message
        '"A701K"': market_operation_ts_message
        '"A701R"': market_operation_ts_message
        '"A701F"': market_operation_ts_message
        '"A702F"': market_operation_ts_message
        '"A703F"': market_operation_ts_message
        '"A704F"': market_operation_ts_message
        '"A705F"': market_operation_ts_message
        '"A706F"': market_operation_ts_message
        '"A707F"': market_operation_ts_message
        '"A708F"': market_operation_ts_message
        '"A709F"': market_operation_ts_message
        '"A710F"': market_operation_ts_message
        '"A711F"': market_operation_ts_message
        '"A712F"': market_operation_ts_message
        '"A713F"': market_operation_ts_message
        '"A715F"': market_operation_ts_message
        '"A716F"': market_operation_ts_message
        '"A717F"': market_operation_ts_message
        '"A718F"': market_operation_ts_message
        '"A701G"': market_operation_ts_message
        '"A701E"': market_operation_ts_message
        '"M401S"': market_operation_schedule_message
        '"M402S"': market_operation_schedule_message
        '"M403S"': market_operation_schedule_message
        '"M404S"': market_operation_schedule_message
        '"M405S"': market_operation_schedule_message
        '"M401Q"': market_operation_schedule_message
        '"M401X"': market_operation_schedule_message
        '"M401B"': market_operation_schedule_message
        '"M401M"': market_operation_schedule_message
        '"M401K"': market_operation_schedule_message
        '"M401R"': market_operation_schedule_message
        '"M401F"': market_operation_schedule_message
        '"M402F"': market_operation_schedule_message
        '"M403F"': market_operation_schedule_message
        '"M404F"': market_operation_schedule_message
        '"M405F"': market_operation_schedule_message
        '"M406F"': market_operation_schedule_message
        '"M407F"': market_operation_schedule_message
        '"M408F"': market_operation_schedule_message
        '"M409F"': market_operation_schedule_message
        '"M410F"': market_operation_schedule_message
        '"M411F"': market_operation_schedule_message
        '"M412F"': market_operation_schedule_message
        '"M413F"': market_operation_schedule_message
        '"M415F"': market_operation_schedule_message
        '"M416F"': market_operation_schedule_message
        '"M417F"': market_operation_schedule_message
        '"M418F"': market_operation_schedule_message
        '"M401G"': market_operation_schedule_message
        '"M401E"': market_operation_schedule_message
        '"A601B"': issue_closing_message
        '"A601M"': issue_closing_message
        '"A601K"': issue_closing_message
        '"A601R"': issue_closing_message
        '"R301S"': member_firm_sanctions_message
        '"R302S"': member_firm_sanctions_message
        '"R303S"': member_firm_sanctions_message
        '"R304S"': member_firm_sanctions_message
        '"R305S"': member_firm_sanctions_message
        '"R301Q"': member_firm_sanctions_message
        '"R301X"': member_firm_sanctions_message
        '"R301B"': member_firm_sanctions_message
        '"R301M"': member_firm_sanctions_message
        '"R301K"': member_firm_sanctions_message
        '"R301R"': member_firm_sanctions_message
        '"B601B"': regular_bonds_ktb_quote_message
        '"B601K"': regular_bonds_ktb_quote_message
        '"A301B"': bonds_order_filled_message
        '"A301M"': bonds_order_filled_message
        '"A301K"': bonds_order_filled_message
        '"G701B"': general_bonds_ktb_order_filled_plus_quote_message
        '"G701K"': general_bonds_ktb_order_filled_plus_quote_message
        '"C401B"': bonds_negotiated_trade_data_message
        '"C401K"': bonds_negotiated_trade_data_message
        '"C401R"': repo_negotiated_trade_data_message
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
        '"G001M"': baby_bonds_reporting_market_yield_message
        '"PA01K"': ktb_confirmed_info_for_wit_message
        '"PB01K"': ktb_short_term_yield_message
        '"PC01K"': ktb_average_yield_message
        '"JA077"': bonds_credit_rating_information_message
        '"R401B"': regular_bonds_disclosure_basic_exchange_rate_message
        '"P401B"': investor_activities_per_bond_types_message
        '"P401M"': investor_activities_per_bond_types_message
        '"P401K"': investor_activities_per_bond_types_message
        '"J9077"': bonds_isin_issue_information_message
        '"JB077"': bonds_isin_information_text_message
        '"B601M"': baby_bonds_quote_message
        '"B601R"': repo_quote_message
        '"OA01B"': bonds_total_remaining_volume_on_quotes_message
        '"OA01M"': bonds_total_remaining_volume_on_quotes_message
        '"G701M"': baby_bonds_order_filled_plus_quote_message
        '"G701R"': repo_order_filled_plus_quote_message

types:
  polling_data_message:
    seq:
      - id: current_time
        type: hhmm_ascii_time
        doc: 'Current time in HHMM format, transmitted at one-minute intervals'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
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
        size: 15
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
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
        size: 15
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Time'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bond_index_krx_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  market_operation_ts_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  market_operation_schedule_message:
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  issue_closing_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: duration_of_term_repo
        type: str
        size: 4
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
      - id: closing_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing price on the day''s regular session'
      - id: closing_price_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Closing Price_Yield'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  member_firm_sanctions_message:
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
      - id: disclosing_data_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'A data type code indicating a Batch data change and imposing/lifting sanctions to/from member firm'
      - id: disclosure_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time to disclose market operation information and market measures for trade such as corrections for the previous day''s notice, and today''s notice'
      - id: member_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A designated number for each member firm'
      - id: member_firm_trust_principal_type_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Allowance or sanctions for member''s trading. Bitwise operation. 1: Ask Trust 2: Ask Principal 4: Bid Trust 8: Bid Principal'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  regular_bonds_ktb_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 1 Yield'
      - id: bid_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 1 Yield'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 2 Yield'
      - id: bid_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 2 Yield'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 3 Yield'
      - id: bid_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 3 Yield'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 4 Yield'
      - id: bid_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 4 Yield'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 5 Yield'
      - id: bid_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 5 Yield'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_order_filled_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading value = Trading Price * Trading Volume'
      - id: bond_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bond Yield'
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
      - id: yield_opening_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of an opening price'
      - id: yield_todays_high
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s high price'
      - id: yield_todays_low
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s low price'
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: settlement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the buyer makes payment to the seller while the seller delivers the assets to the buyer'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  general_bonds_ktb_order_filled_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading value = Trading Price * Trading Volume'
      - id: bond_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bond Yield'
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
      - id: yield_opening_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of an opening price'
      - id: yield_todays_high
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s high price'
      - id: yield_todays_low
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s low price'
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: settlement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the buyer makes payment to the seller while the seller delivers the assets to the buyer'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 1 Yield'
      - id: bid_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 1 Yield'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 2 Yield'
      - id: bid_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 2 Yield'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 3 Yield'
      - id: bid_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 3 Yield'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 4 Yield'
      - id: bid_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 4 Yield'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 5 Yield'
      - id: bid_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 5 Yield'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_negotiated_trade_data_message:
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
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_negotiated_trade_data_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: rfq_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'RFQ Accumulated Trading value'
      - id: report_trading_total_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Report Trading_Total Trading Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: '11: Fixed Rate_Discount Bond 12: Fixed Rate_Compounding Interest Bond 13: Fixed Rate_Coupon Bond 14: Fixed Rate_Simple Interest Bond 15: Fixed Rate_Compound(5yrs)+Simple(2yrs) 19: Fixed Rate_Othe'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  issue_event_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  corporate_bonds_reference_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: '11: Fixed Rate_Discount Bond 12: Fixed Rate_Compounding Interest Bond 13: Fixed Rate_Coupon Bond 14: Fixed Rate_Simple Interest Bond 15: Fixed Rate_Compound(5yrs)+Simple(2yrs) 19: Fixed Rate_Othe'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  regular_bonds_installment_repayment_date_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_classification_data_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_trade_availability_per_term_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  retail_bonds_type_code_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
        doc: 'A keyword indicating the end of a message. (%HFF)'
  baby_bonds_reporting_market_yield_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
      - id: business_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Business Date'
      - id: baby_bonds_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Baby Bonds Type Code'
      - id: report_market_yield_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'Report Market_Yield Rate'
      - id: report_market_a_price_with_yield
        type: str
        size: 11
        encoding: ASCII
        doc: 'Report Market_A price with Yield'
      - id: closing_price_yield_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'Closing Price_Yield Rate'
      - id: closing_price_with_yield
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price with Yield'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  ktb_confirmed_info_for_wit_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: bid_closing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Closing Date'
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: cancellation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Cancellation'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  ktb_short_term_yield_message:
    seq:
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: calculation_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
      - id: shortterm_interest_rates_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short-term Interest Rates Type Code'
      - id: shortterm_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Short-term Yield'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  ktb_average_yield_message:
    seq:
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: calculation_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
      - id: shortterm_interest_rates_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Short-term Interest Rates Type Code'
      - id: average_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Average Yield'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_credit_rating_information_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: credit_rating_agency_code_no_1
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Agency_Code no. 1'
      - id: credit_rating_per_agency_code_no_1
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Per Agency_Code no. 1'
      - id: sf_ratings_1
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SF Ratings 1'
      - id: credit_rating_agency_code_no_2
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Agency_Code no. 2'
      - id: credit_rating_per_agency_code_no_2
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Per Agency_Code no. 2'
      - id: sf_ratings_2
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SF Ratings 2'
      - id: credit_rating_agency_code_no_3
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Agency_Code no. 3'
      - id: credit_rating_per_agency_code_no_3
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Per Agency_Code no. 3'
      - id: sf_ratings_3
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SF Ratings 3'
      - id: credit_rating_agency_code_no_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Agency_Code no. 4'
      - id: credit_rating_per_agency_code_no_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Credit Rating Per Agency_Code no. 4'
      - id: sf_ratings_4
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SF Ratings 4'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  regular_bonds_disclosure_basic_exchange_rate_message:
    seq:
      - id: disclosing_data_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'A data type code indicating a Batch data change and imposing/lifting sanctions to/from member firm'
      - id: disclosure_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time to disclose market operation information and market measures for trade such as corrections for the previous day''s notice, and today''s notice'
      - id: applied_exchange_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'Applied Exchange Rate'
      - id: currency_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Codes 1: Korean Won(KRW) 2: US Dollar(USD) 3: Japanese Yen(JPY) 4: Euro(EUR) 5: Yuan Renminbi(CNY) 6: Pound Sterling(GBP) 7: Hong Kong Dollar(HKD) 8: Austrailian Dollar(AUD) 9: Singap'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  investor_activities_per_bond_types_message:
    seq:
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor Code 1000: Financial Investors 2000: Insurance Company 3000: Asset Management Company and Investment Trust Company 3100: Private Equity Fund 4000: Banks 5000: Other Financial Institutions 600'
      - id: bond_category_code
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Category code'
      - id: accumulated_ask_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Bid Trading Volume'
      - id: accumulated_bid_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Bid Trading Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_isin_issue_information_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: transmission_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Time'
      - id: record_process_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Record Process Category D:delete I:Insert O:old U:update'
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
      - id: issuer_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issuer Code'
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
      - id: bond_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond_Type Code AB: Special Bonds CO: Corporate Bonds FO: Foreign Bonds GB: Governmental Bonds MB: Municipal Bonds'
      - id: special_bond_issue_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Special Bond_Issue Code'
      - id: mb_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'MB_Type Code 1:Offering Regional Bond 2:Regional Development Bond 3:City Railroad Bond 4:Other MB 5:Others'
      - id: bond_guaranteed_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond_Guaranteed Type Code 1:Guaranteed 2:Partial Guaranteed 3:Collateral-backed 4:Non-Guaranteed 5:Government Guaranteed 6:Covered Bond'
      - id: guaranteed_rate_for_payment
        type: str
        size: 13
        encoding: ASCII
        doc: 'Guaranteed Rate for Payment'
      - id: other_types_of_bond
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Other Types of Bond 1:Regular Bond 2:Equity Related Bond 3:ELS/ELB 4:DLS/DLB 5:Electronic Short-term (For the code 3 and 4; in Bond market, only ELB and DLB can be listed while ELS, DLS cannot'
      - id: optionembedded_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Option-embedded_Type Code 1:Call(Call) 2:Put(Put) 3:CallandPut(Call and Put)'
      - id: coupon_payment_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '11: Fixed Rate_Discount Bond 12: Fixed Rate_Compounding Interest Bond 13: Fixed Rate_Coupon Bond 14: Fixed Rate_Simple Interest Bond 15: Fixed Rate_Compound(5yrs)+Simple(2yrs) 19: Fixed Rate_Othe'
      - id: risk_bond_redemption_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Maturity, 2: Partially Redeemed, 3: Perpetual Bond'
      - id: bond_issuance_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: '(Three of them can appear all at once) 100: Indirect Public Issue 010: Direct Public Issue 001: Private Issue 000: QIB Securities'
      - id: securitization_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Securitization_Type Code 11:ABS(Bond) 12:ABS(Beneficiary Certificate) 13:ABS(unstructured) 21:MBS(Bond) 22:MBS(Beneficiary Certificate) 31:SLBS(Bond) 32:SLBS(Beneficiary Certificate)'
      - id: redemption_priority_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Redemption Priority_Type Code 1:Senior(default) 2:Sub-Senior 3:Subordinated 4:Equity-like'
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
      - id: the_1_st_coupon_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The 1st Coupon Payment Date'
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
      - id: number_of_months_to_pay_interest
        type: str
        size: 4
        encoding: ASCII
        doc: 'Used if it is Coupon Bond, Compounding Interest Bond, or Amortized Bond (Coupon Bond:3-month paid afterwards, 3-month, Compounding Interest Bond:Actual coupon is paid on maturity date. In this case,'
      - id: bond_sale_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Pre-Issue Sae ,2: Issue Sale, 3: Post-Issue Sale'
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
      - id: confirmation_of_lump_sum_payment
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Confirmation of Lump sum Payment'
      - id: currency_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Currency Codes 1: Korean Won(KRW) 2: US Dollar(USD) 3: Japanese Yen(JPY) 4: Euro(EUR) 5: Yuan Renminbi(CNY) 6: Pound Sterling(GBP) 7: Hong Kong Dollar(HKD) 8: Austrailian Dollar(AUD) 9: Singap'
      - id: redemption_ratio_at_maturity
        type: str
        size: 13
        encoding: ASCII
        doc: 'Redemption Ratio at Maturity'
      - id: yield_to_maturity
        type: str
        size: 13
        encoding: ASCII
        doc: 'Yield to Maturity'
      - id: guaranteed_yield_effective_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Guaranteed Yield_Effective Date'
      - id: additional_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Additional Yield'
      - id: additional_yield_effective_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Additional Yield_Effective Date'
      - id: facility_fund
        type: str
        size: 22
        encoding: ASCII
        doc: 'Facility Fund'
      - id: maintenance_fund
        type: str
        size: 22
        encoding: ASCII
        doc: 'Maintenance Fund'
      - id: loan_fund
        type: str
        size: 22
        encoding: ASCII
        doc: 'Loan Fund'
      - id: other_funds
        type: str
        size: 22
        encoding: ASCII
        doc: 'Other Funds'
      - id: inscription_type_of_bond
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Inscription Type of Bond'
      - id: taxation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Taxation'
      - id: bond_lead_manager_company_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond Lead Manager Company Code'
      - id: payment_guarantor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'If it is ""Guaranteed"" in Guaranteed Category, Institution Code should exist. (for name verification purpose)'
      - id: trustee_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trustee Code'
      - id: register_institute_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Register Institute Code'
      - id: payment_agent_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Payment Agent Code'
      - id: abbreviated_issue_code
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated Issue Code'
      - id: bond_delisting_reason_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '01: Matured 02: Repaid in full before maturity 03: Rights exercised etc'
      - id: bond_delisted_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bond_Delisted Date'
      - id: equitylinked_bond_rights_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: Convertible 11: Coverting debt to stock (Conditional) 21: Newly Issued Underwriting (Separable) 22: Newly Issued Underwriting (Non-separable) 31: Exchangeable (Separable) 32: Exchangeable(Non-s'
      - id: isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN'
      - id: issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: equitylinked_bond_exercise_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Equity-linked Bond Exercise Price'
      - id: exercise_ratio
        type: str
        size: 7
        encoding: ASCII
        doc: 'Exercise Ratio'
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
      - id: institution_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code for an institution raising a claim'
      - id: record_date_of_dividend_payout
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Record date of dividend payout 1: Exercise day 2: Last day of previous year 3: Last day of current year'
      - id: profit_participating_accum_status
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Profit Participating_Accum. Status Y: Accumulated, N: Non Accumulated'
      - id: issue_code_of_postexercise
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Code of Post-exercise'
      - id: amortization_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Amortization Type Code 1: Level Payment of Principal 2: Level Payment of Principal and Interest 3: Un-level Payment'
      - id: level_payment_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Level Payment Amount'
      - id: number_of_months_for_grace
        type: str
        size: 4
        encoding: ASCII
        doc: 'Number of Months for Grace'
      - id: interest_type_code_during_amortization
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Simple Interest 2: Compounding Interest 3: Coupon Bond'
      - id: number_of_amortization
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Amortization'
      - id: interest_rate_decision_other_base_rate_name
        type: str
        size: 20
        encoding: ASCII
        pad-right: 0x20
        doc: 'Interest Rate Decision_Other Base Rate Name'
      - id: spread
        type: str
        size: 10
        encoding: ASCII
        doc: 'Spread'
      - id: timing_of_interest_rate_decision_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Morning 2: Afternoon'
      - id: upper_limit_coupon_rate
        type: str
        size: 14
        encoding: ASCII
        doc: 'Upper Limit_Coupon Rate'
      - id: lower_limit_coupon_rate
        type: str
        size: 14
        encoding: ASCII
        doc: 'Lower Limit_Coupon Rate'
      - id: the_date_to_decide_interest_rate
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date to Decide Interest Rate'
      - id: first_call_exercise_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '1st Call Exercise_Start Date'
      - id: first_call_exercise_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '1st Call Exercise_End Date'
      - id: second_call_exercise_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '2nd Call Exercise_Start Date'
      - id: second_call_exercise_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '2nd Call Exercise_End Date'
      - id: first_put_exercise_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '1st Put Exercise_Start Date'
      - id: first_put_exercise_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '1st Put Exercise_End Date'
      - id: second_put_exercise_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '2nd Put Exercise_Start Date'
      - id: second_put_exercise_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: '2nd Put Exercise_End Date'
      - id: coupon_payment_decision_code_for_bank_holidays
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Previous Business Day (No accrued interest when coupon paid on the next business day) 2: Previous Business Day (Accrued interest applied when coupon paid on the next business day) 3: Next Busines'
      - id: hybrid_bond
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Hybrid Bond'
      - id: co_cos_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Not applicable 1: Conversion 2: Write-off'
      - id: coupon_rate_confirmation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Coupon Rate Confirmation'
      - id: principal_guranteed_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'Principal Guranteed Rate'
      - id: participating_rate
        type: str
        size: 11
        encoding: ASCII
        doc: 'Participating Rate'
      - id: maximum_yield
        type: str
        size: 11
        encoding: ASCII
        doc: 'Maximum Yield'
      - id: strip_bond_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Strip Bond Type Code 1: General bond 2: Separation of Principal 3: Separation of Interest'
      - id: original_bond_type_code_subjec_to_strip
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Original Bond Type Code (Subjec to strip)'
      - id: unstripped_balance
        type: str
        size: 22
        encoding: ASCII
        doc: 'Unstripped Balance'
      - id: inflation_indexed_category
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Inflation Indexed Category'
      - id: reference_index_for_issue_date
        type: str
        size: 11
        encoding: ASCII
        doc: 'Reference Index For Issue Date'
      - id: coupon_rate_decision_base_rate_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '01: Final Quotes - KTB(3-Month) 02: Final Quotes - KTB(6-Month) 03: Final Quotes - KTB(1-Year) 04: Final Quotes - KTB(3-Year) 05: Final Quotes - KTB(5-Year) 06: Final Quotes - KTB(10-Year) 07: Final Q'
      - id: bond_odd_lot_days_base_interest_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: 360 Days, 2: 365 Days, 3: 366 Days'
      - id: base_interest_rate_on_bank_holidays_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Coupon Rate 2: Market Rate'
      - id: accrued_interest_rate_on_bank_holidays_type_code
        type: str
        size: 14
        encoding: ASCII
        doc: 'Accrued Interest Rate on Bank Holidays_Type Code'
      - id: principal_payment_methods_on_bank_holidays_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Prior to Business Day (No accrued interest) 2: Prior to Business Day (Accrued interest is added) 3: Post Business Day (No accrued interest) 4: Post Business Day (Accrued interest is added)'
      - id: principal_base_rate_on_bank_holidays_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Coupon Rate 2: Market Rate'
      - id: principal_accrued_interest_rate_on_bank_holidays_type_code
        type: str
        size: 14
        encoding: ASCII
        doc: 'Principal Accrued Interest Rate on Bank Holidays_Type Code'
      - id: stopout_rate
        type: str
        size: 14
        encoding: ASCII
        doc: 'Stop-out Rate'
      - id: crowdfunding
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Crowdfunding'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_isin_information_text_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Issue Name'
      - id: english_issue_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'English Issue Name'
      - id: unusual_issuance_condition
        type: str
        size: 60
        encoding: ASCII
        pad-right: 0x20
        doc: 'Unusual Issuance Condition'
      - id: reason_for_exercising_a_call
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for Exercising a Call'
      - id: reason_for_exercising_a_put
        type: str
        size: 50
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reason for Exercising a Put'
      - id: contents_of_underlying_asset
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'Contents of Underlying Asset'
      - id: els_condition_1
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'ELS Condition 1'
      - id: els_condition_2
        type: str
        size: 100
        encoding: ASCII
        pad-right: 0x20
        doc: 'ELS Condition 2'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  baby_bonds_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 1 Yield'
      - id: bid_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 1 Yield'
      - id: ask_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 1_price'
      - id: bid_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 1_price'
      - id: ask_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 1_Remaining Quantity'
      - id: bid_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level1_Remaining Quantity'
      - id: ask_per_type_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 1_Yield'
      - id: bid_per_type_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 1_Yield'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 2 Yield'
      - id: bid_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 2 Yield'
      - id: ask_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 2_price'
      - id: bid_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 2_price'
      - id: ask_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 2_Remaining Quantity'
      - id: bid_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 2_Remaining Quantity'
      - id: ask_per_type_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 2_Yield'
      - id: bid_per_type_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 2_Yield'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 3 Yield'
      - id: bid_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 3 Yield'
      - id: ask_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 3_price'
      - id: bid_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 3_price'
      - id: ask_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 3_Remaining Quantity'
      - id: bid_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 3_Remaining Quantity'
      - id: ask_per_type_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 3_Yield'
      - id: bid_per_type_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 3_Yield'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 4 Yield'
      - id: bid_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 4 Yield'
      - id: ask_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 4_price'
      - id: bid_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 4_price'
      - id: ask_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 4_Remaining Quantity'
      - id: bid_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 4_Remaining Quantity'
      - id: ask_per_type_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 4_Yield'
      - id: bid_per_type_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 4_Yield'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 5 Yield'
      - id: bid_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 5 Yield'
      - id: ask_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 5_price'
      - id: bid_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 5_price'
      - id: ask_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 5_Volume'
      - id: bid_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 5_Volume'
      - id: ask_per_type_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 5_Yield'
      - id: bid_per_type_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 5_Yield'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: ask_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type_Total Remaining Quantity'
      - id: bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type_Total Remaining Quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: duration_of_term_repo
        type: str
        size: 4
        encoding: ASCII
        doc: 'Duration of Term Repo (such as 1 day, 3 days, 5 days, 7 days)'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 1_Trading Amount'
      - id: total_bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 1_price'
      - id: total_bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 1_volume'
      - id: bid_level_1_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level1 including GC'
      - id: ask_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 1_price'
      - id: bid_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 1_price'
      - id: ask_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 1_Remaining Quantity'
      - id: bid_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level1_Remaining Quantity'
      - id: ask_per_type_level_1_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 1_Trading Amount'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 2_Trading Amount'
      - id: total_bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 2_price'
      - id: total_bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 2_Remaining Quantity'
      - id: bid_level_2_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 2 including GC'
      - id: ask_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 2_price'
      - id: bid_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 2_price'
      - id: ask_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 2_Remaining Quantity'
      - id: bid_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 2_Remaining Quantity'
      - id: ask_per_type_level_2_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 2_Trading Amount'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 3_Trading Amount'
      - id: total_bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 3_price'
      - id: total_bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 3_Remaining Quantity'
      - id: bid_level_3_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 3 including GC'
      - id: ask_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 3_price'
      - id: bid_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 3_price'
      - id: ask_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 3_Remaining Quantity'
      - id: bid_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 3_Remaining Quantity'
      - id: ask_per_type_level_3_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 3_Trading Amount'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 4_Trading Amount'
      - id: total_bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 4_price'
      - id: total_bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 4_Remaining Quantity'
      - id: bid_level_4_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 4 including GC'
      - id: ask_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 4_price'
      - id: bid_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 4_price'
      - id: ask_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 4_Remaining Quantity'
      - id: bid_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 4_Remaining Quantity'
      - id: ask_per_type_level_4_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 4_Trading Amount'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 5_Trading Amount'
      - id: total_bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 5_price'
      - id: total_bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 5_Remaining Quantity'
      - id: bid_level_5_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 5 including GC'
      - id: ask_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 5_price'
      - id: bid_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 5_price'
      - id: ask_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 5_Volume'
      - id: bid_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 5_Volume'
      - id: ask_per_type_level_5_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 5_Trading Amount'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: ask_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type_Total Remaining Quantity'
      - id: bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type_Total Remaining Quantity'
      - id: designated_bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 1_Price'
      - id: designated_bid_level_1_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 1_REPO Remaining Quantity'
      - id: designated_bid_level_1_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 1_ISIN'
      - id: designated_bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 2_Price'
      - id: designated_bid_level_2_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 2_REPO Remaining Quantity'
      - id: designated_bid_level_2_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 2_ISIN'
      - id: designated_bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 3_Price'
      - id: designated_bid_level_3_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 3_REPO Remaining Quantity'
      - id: designated_bid_level_3_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 3_ISIN'
      - id: designated_bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 4_Price'
      - id: designated_bid_level_4_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 4_REPO Remaining Quantity'
      - id: designated_bid_level_4_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 4_ISIN'
      - id: designated_bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 5_Price'
      - id: designated_bid_level_5_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 5_REPO Remaining Quantity'
      - id: designated_bid_level_5_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 5_ISIN'
      - id: designated_bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 6_Price'
      - id: designated_bid_level_6_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 6_REPO Remaining Quantity'
      - id: designated_bid_level_6_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 6_ISIN'
      - id: designated_bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 7_Price'
      - id: designated_bid_level_7_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 7_REPO Remaining Quantity'
      - id: designated_bid_level_7_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 7_ISIN'
      - id: designated_bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 8_Price'
      - id: designated_bid_level_8_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 8_REPO Remaining Quantity'
      - id: designated_bid_level_8_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 8_ISIN'
      - id: designated_bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 9_Price'
      - id: designated_bid_level_9_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 9_REPO Remaining Quantity'
      - id: designated_bid_level_9_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 9_ISIN'
      - id: designated_bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 10_Price'
      - id: designated_bid_level_10_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 10 REPO Remaining Quantity'
      - id: designated_bid_level_10_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 10_ISIN'
      - id: designated_best_bid_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Best Bid_Price'
      - id: net_bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Net Bid per Type_Total Remaining Quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  bonds_total_remaining_volume_on_quotes_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: ask_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type_Total Remaining Quantity'
      - id: bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type_Total Remaining Quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  baby_bonds_order_filled_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading value = Trading Price * Trading Volume'
      - id: bond_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bond Yield'
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
      - id: yield_opening_price
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of an opening price'
      - id: yield_todays_high
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s high price'
      - id: yield_todays_low
        type: str
        size: 13
        encoding: ASCII
        doc: 'A yield of Today''s low price'
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: settlement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when the buyer makes payment to the seller while the seller delivers the assets to the buyer'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 1 Yield'
      - id: bid_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 1 Yield'
      - id: ask_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 1_price'
      - id: bid_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 1_price'
      - id: ask_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 1_Remaining Quantity'
      - id: bid_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level1_Remaining Quantity'
      - id: ask_per_type_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 1_Yield'
      - id: bid_per_type_level_1_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 1_Yield'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 2 Yield'
      - id: bid_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 2 Yield'
      - id: ask_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 2_price'
      - id: bid_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 2_price'
      - id: ask_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 2_Remaining Quantity'
      - id: bid_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 2_Remaining Quantity'
      - id: ask_per_type_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 2_Yield'
      - id: bid_per_type_level_2_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 2_Yield'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 3 Yield'
      - id: bid_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 3 Yield'
      - id: ask_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 3_price'
      - id: bid_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 3_price'
      - id: ask_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 3_Remaining Quantity'
      - id: bid_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 3_Remaining Quantity'
      - id: ask_per_type_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 3_Yield'
      - id: bid_per_type_level_3_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 3_Yield'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 4 Yield'
      - id: bid_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 4 Yield'
      - id: ask_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 4_price'
      - id: bid_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 4_price'
      - id: ask_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 4_Remaining Quantity'
      - id: bid_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 4_Remaining Quantity'
      - id: ask_per_type_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 4_Yield'
      - id: bid_per_type_level_4_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 4_Yield'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask Level 5 Yield'
      - id: bid_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid Level 5 Yield'
      - id: ask_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 5_price'
      - id: bid_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 5_price'
      - id: ask_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 5_Volume'
      - id: bid_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 5_Volume'
      - id: ask_per_type_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Ask per Type Level 5_Yield'
      - id: bid_per_type_level_5_yield
        type: str
        size: 13
        encoding: ASCII
        doc: 'Bid per Type Level 5_Yield'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: ask_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type_Total Remaining Quantity'
      - id: bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type_Total Remaining Quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
  repo_order_filled_plus_quote_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information'
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
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading value = Trading Price * Trading Volume'
      - id: ask_repo_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type Code of Bond REPO CA: Other Bonds GA: Korea Treasury Bond/Municipal Bonds SA: Monetary Stabilization Bond / Deposit Insurance Bond'
      - id: ask_duration_of_term_repo
        type: str
        size: 4
        encoding: ASCII
        doc: 'Ask_Duration of Term Repo'
      - id: bid_repo_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type Code of Bond REPO CA: Other Bonds GA: Korea Treasury Bond/Municipal Bonds SA: Monetary Stabilization Bond / Deposit Insurance Bond'
      - id: bid_duration_of_term_repo
        type: str
        size: 4
        encoding: ASCII
        doc: 'Bid_Duration of Term Repo'
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
      - id: category_opening_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Category_Opening Price'
      - id: category_todays_high
        type: str
        size: 11
        encoding: ASCII
        doc: 'Category_Today''s High'
      - id: category_todays_low
        type: str
        size: 11
        encoding: ASCII
        doc: 'Category_Todays Low'
      - id: accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: category_accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bond REPO'
      - id: category_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bond REPO'
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
      - id: ask_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The lowest ask remaining quantity'
      - id: bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The highest bid remaining quantity'
      - id: ask_level_1_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 1_Trading Amount'
      - id: total_bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 1_price'
      - id: total_bid_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 1_volume'
      - id: bid_level_1_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level1 including GC'
      - id: ask_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 1_price'
      - id: bid_per_type_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 1_price'
      - id: ask_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 1_Remaining Quantity'
      - id: bid_per_type_level_1_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level1_Remaining Quantity'
      - id: ask_per_type_level_1_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 1_Trading Amount'
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
      - id: ask_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second highest ask remaining quantity'
      - id: bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The second lowest bid remaining quantity'
      - id: ask_level_2_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 2_Trading Amount'
      - id: total_bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 2_price'
      - id: total_bid_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 2_Remaining Quantity'
      - id: bid_level_2_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 2 including GC'
      - id: ask_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 2_price'
      - id: bid_per_type_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 2_price'
      - id: ask_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 2_Remaining Quantity'
      - id: bid_per_type_level_2_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 2_Remaining Quantity'
      - id: ask_per_type_level_2_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 2_Trading Amount'
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
      - id: ask_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third highest ask remaining quantity'
      - id: bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The third lowest bid remaining quantity'
      - id: ask_level_3_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 3_Trading Amount'
      - id: total_bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 3_price'
      - id: total_bid_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 3_Remaining Quantity'
      - id: bid_level_3_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 3 including GC'
      - id: ask_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 3_price'
      - id: bid_per_type_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 3_price'
      - id: ask_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 3_Remaining Quantity'
      - id: bid_per_type_level_3_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 3_Remaining Quantity'
      - id: ask_per_type_level_3_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 3_Trading Amount'
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
      - id: ask_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth highest ask remaining quantity'
      - id: bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fourth lowest bid remaining quantity'
      - id: ask_level_4_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 4_Trading Amount'
      - id: total_bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 4_price'
      - id: total_bid_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 4_Remaining Quantity'
      - id: bid_level_4_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 4 including GC'
      - id: ask_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 4_price'
      - id: bid_per_type_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 4_price'
      - id: ask_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 4_Remaining Quantity'
      - id: bid_per_type_level_4_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 4_Remaining Quantity'
      - id: ask_per_type_level_4_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 4_Trading Amount'
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
      - id: ask_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth highest ask remaining quantity'
      - id: bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'The fifth lowest bid remaining quantity'
      - id: ask_level_5_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Level 5_Trading Amount'
      - id: total_bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Total Bid Level 5_price'
      - id: total_bid_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Total Bid Level 5_Remaining Quantity'
      - id: bid_level_5_including_gc
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid Level 5 including GC'
      - id: ask_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Ask per Type Level 5_price'
      - id: bid_per_type_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Bid per Type Level 5_price'
      - id: ask_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type Level 5_Volume'
      - id: bid_per_type_level_5_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type Level 5_Volume'
      - id: ask_per_type_level_5_trading_amount
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask per Type Level 5_Trading Amount'
      - id: ask_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask total remaining quantity'
      - id: bid_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid total remaining quantity'
      - id: ask_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Ask per Type_Total Remaining Quantity'
      - id: bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Bid per Type_Total Remaining Quantity'
      - id: designated_bid_level_1_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 1_Price'
      - id: designated_bid_level_1_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 1_REPO Remaining Quantity'
      - id: designated_bid_level_1_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 1_ISIN'
      - id: designated_bid_level_2_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 2_Price'
      - id: designated_bid_level_2_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 2_REPO Remaining Quantity'
      - id: designated_bid_level_2_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 2_ISIN'
      - id: designated_bid_level_3_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 3_Price'
      - id: designated_bid_level_3_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 3_REPO Remaining Quantity'
      - id: designated_bid_level_3_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 3_ISIN'
      - id: designated_bid_level_4_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 4_Price'
      - id: designated_bid_level_4_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 4_REPO Remaining Quantity'
      - id: designated_bid_level_4_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 4_ISIN'
      - id: designated_bid_level_5_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 5_Price'
      - id: designated_bid_level_5_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 5_REPO Remaining Quantity'
      - id: designated_bid_level_5_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 5_ISIN'
      - id: designated_bid_level_6_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 6_Price'
      - id: designated_bid_level_6_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 6_REPO Remaining Quantity'
      - id: designated_bid_level_6_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 6_ISIN'
      - id: designated_bid_level_7_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 7_Price'
      - id: designated_bid_level_7_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 7_REPO Remaining Quantity'
      - id: designated_bid_level_7_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 7_ISIN'
      - id: designated_bid_level_8_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 8_Price'
      - id: designated_bid_level_8_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 8_REPO Remaining Quantity'
      - id: designated_bid_level_8_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 8_ISIN'
      - id: designated_bid_level_9_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 9_Price'
      - id: designated_bid_level_9_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 9_REPO Remaining Quantity'
      - id: designated_bid_level_9_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 9_ISIN'
      - id: designated_bid_level_10_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Bid Level 10_Price'
      - id: designated_bid_level_10_repo_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Designated Bid Level 10 REPO Remaining Quantity'
      - id: designated_bid_level_10_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designated Bid Level 10_ISIN'
      - id: designated_best_bid_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Designated Best Bid_Price'
      - id: net_bid_per_type_total_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Net Bid per Type_Total Remaining Quantity'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'A keyword indicating the end of a message. (%HFF)'
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
  hhmmss_ascii_time:
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

