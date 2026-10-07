# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime SecuritiesA Exture v2.018
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Securities A
#   Encoding: Exture
#   Version: 2.018
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
  id: koscom_mdcsrealtime_securitiesa_exture_v2_018
  title: Koscom MdcsRealtime SecuritiesA Exture v2.018
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Securities A Exture v2.018'
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
        '"B601S"': securities_quote_mm_lp_excluded_message
        '"B601Q"': securities_quote_mm_lp_excluded_message
        '"B601X"': securities_quote_mm_lp_excluded_message
        '"B702S"': securities_quote_mm_lp_included_message
        '"B703S"': securities_quote_mm_lp_included_message
        '"B704S"': securities_quote_mm_lp_included_message
        '"B705S"': securities_quote_mm_lp_included_message
        '"B201S"': securities_snapshot_mm_lp_excluded_message
        '"B201Q"': securities_snapshot_mm_lp_excluded_message
        '"B202S"': securities_snapshot_mm_lp_included_message
        '"B203S"': securities_snapshot_mm_lp_included_message
        '"B204S"': securities_snapshot_mm_lp_included_message
        '"B205S"': securities_snapshot_mm_lp_included_message
        '"A301S"': securities_order_filled_message
        '"A302S"': securities_order_filled_message
        '"A303S"': securities_order_filled_message
        '"A304S"': securities_order_filled_message
        '"A305S"': securities_order_filled_message
        '"A301Q"': securities_order_filled_message
        '"A301X"': securities_order_filled_message
        '"C401S"': securities_negotiated_trade_message
        '"C402S"': securities_negotiated_trade_message
        '"C403S"': securities_negotiated_trade_message
        '"C404S"': securities_negotiated_trade_message
        '"C405S"': securities_negotiated_trade_message
        '"C401Q"': securities_negotiated_trade_message
        '"C401X"': securities_negotiated_trade_message
        '"A701S"': securities_market_operation_ts_message
        '"A702S"': securities_market_operation_ts_message
        '"A703S"': securities_market_operation_ts_message
        '"A704S"': securities_market_operation_ts_message
        '"A705S"': securities_market_operation_ts_message
        '"A701Q"': securities_market_operation_ts_message
        '"A701X"': securities_market_operation_ts_message
        '"A701B"': securities_market_operation_ts_message
        '"A701M"': securities_market_operation_ts_message
        '"A701K"': securities_market_operation_ts_message
        '"A701R"': securities_market_operation_ts_message
        '"A701F"': securities_market_operation_ts_message
        '"A702F"': securities_market_operation_ts_message
        '"A703F"': securities_market_operation_ts_message
        '"A704F"': securities_market_operation_ts_message
        '"A705F"': securities_market_operation_ts_message
        '"A706F"': securities_market_operation_ts_message
        '"A707F"': securities_market_operation_ts_message
        '"A708F"': securities_market_operation_ts_message
        '"A709F"': securities_market_operation_ts_message
        '"A710F"': securities_market_operation_ts_message
        '"A711F"': securities_market_operation_ts_message
        '"A712F"': securities_market_operation_ts_message
        '"A713F"': securities_market_operation_ts_message
        '"A715F"': securities_market_operation_ts_message
        '"A716F"': securities_market_operation_ts_message
        '"A717F"': securities_market_operation_ts_message
        '"A718F"': securities_market_operation_ts_message
        '"A701G"': securities_market_operation_ts_message
        '"A701E"': securities_market_operation_ts_message
        '"A401S"': securities_determination_of_base_price_message
        '"A403S"': securities_determination_of_base_price_message
        '"A404S"': securities_determination_of_base_price_message
        '"A405S"': securities_determination_of_base_price_message
        '"A401Q"': securities_determination_of_base_price_message
        '"A401X"': securities_determination_of_base_price_message
        '"A601S"': securities_issue_closing_message
        '"A602S"': securities_issue_closing_message
        '"A603S"': securities_issue_closing_message
        '"A604S"': securities_issue_closing_message
        '"A605S"': securities_issue_closing_message
        '"A601Q"': securities_issue_closing_message
        '"A601X"': securities_issue_closing_message
        '"A601G"': securities_issue_closing_message
        '"A601E"': securities_issue_closing_message
        '"M401S"': securities_market_operation_schedule_message
        '"M402S"': securities_market_operation_schedule_message
        '"M403S"': securities_market_operation_schedule_message
        '"M404S"': securities_market_operation_schedule_message
        '"M405S"': securities_market_operation_schedule_message
        '"M401Q"': securities_market_operation_schedule_message
        '"M401X"': securities_market_operation_schedule_message
        '"M401B"': securities_market_operation_schedule_message
        '"M401M"': securities_market_operation_schedule_message
        '"M401K"': securities_market_operation_schedule_message
        '"M401R"': securities_market_operation_schedule_message
        '"M401F"': securities_market_operation_schedule_message
        '"M402F"': securities_market_operation_schedule_message
        '"M403F"': securities_market_operation_schedule_message
        '"M404F"': securities_market_operation_schedule_message
        '"M405F"': securities_market_operation_schedule_message
        '"M406F"': securities_market_operation_schedule_message
        '"M407F"': securities_market_operation_schedule_message
        '"M408F"': securities_market_operation_schedule_message
        '"M409F"': securities_market_operation_schedule_message
        '"M410F"': securities_market_operation_schedule_message
        '"M411F"': securities_market_operation_schedule_message
        '"M412F"': securities_market_operation_schedule_message
        '"M413F"': securities_market_operation_schedule_message
        '"M415F"': securities_market_operation_schedule_message
        '"M416F"': securities_market_operation_schedule_message
        '"M417F"': securities_market_operation_schedule_message
        '"M418F"': securities_market_operation_schedule_message
        '"M401G"': securities_market_operation_schedule_message
        '"M401E"': securities_market_operation_schedule_message
        '"A501X"': securities_random_end_message
        '"A501G"': securities_random_end_message
        '"R801S"': securities_triggering_vi_message
        '"R803S"': securities_triggering_vi_message
        '"R804S"': securities_triggering_vi_message
        '"R805S"': securities_triggering_vi_message
        '"R801Q"': securities_triggering_vi_message
        '"O601S"': securities_quantity_allocation_message
        '"O603S"': securities_quantity_allocation_message
        '"O604S"': securities_quantity_allocation_message
        '"O605S"': securities_quantity_allocation_message
        '"O601Q"': securities_quantity_allocation_message
        '"O601X"': securities_quantity_allocation_message
        '"O601F"': securities_quantity_allocation_message
        '"O602F"': securities_quantity_allocation_message
        '"O603F"': securities_quantity_allocation_message
        '"O604F"': securities_quantity_allocation_message
        '"O605F"': securities_quantity_allocation_message
        '"O606F"': securities_quantity_allocation_message
        '"O607F"': securities_quantity_allocation_message
        '"O608F"': securities_quantity_allocation_message
        '"O609F"': securities_quantity_allocation_message
        '"O610F"': securities_quantity_allocation_message
        '"O611F"': securities_quantity_allocation_message
        '"O612F"': securities_quantity_allocation_message
        '"O613F"': securities_quantity_allocation_message
        '"O615F"': securities_quantity_allocation_message
        '"O616F"': securities_quantity_allocation_message
        '"O617F"': securities_quantity_allocation_message
        '"O618F"': securities_quantity_allocation_message
        '"R301S"': securities_member_firm_sanctions_message
        '"R302S"': securities_member_firm_sanctions_message
        '"R303S"': securities_member_firm_sanctions_message
        '"R304S"': securities_member_firm_sanctions_message
        '"R305S"': securities_member_firm_sanctions_message
        '"R301Q"': securities_member_firm_sanctions_message
        '"R301X"': securities_member_firm_sanctions_message
        '"R301B"': securities_member_firm_sanctions_message
        '"R301M"': securities_member_firm_sanctions_message
        '"R301K"': securities_member_firm_sanctions_message
        '"R301R"': securities_member_firm_sanctions_message
        '"A801S"': securities_equities_changes_of_batch_data_message
        '"A802S"': securities_equities_changes_of_batch_data_message
        '"A803S"': securities_equities_changes_of_batch_data_message
        '"A804S"': securities_equities_changes_of_batch_data_message
        '"A805S"': securities_equities_changes_of_batch_data_message
        '"A801Q"': securities_equities_changes_of_batch_data_message
        '"A801X"': securities_equities_changes_of_batch_data_message
        '"IF01S"': securities_group_order_acceptance_halt_message
        '"IF02S"': securities_group_order_acceptance_halt_message
        '"IF03S"': securities_group_order_acceptance_halt_message
        '"IF04S"': securities_group_order_acceptance_halt_message
        '"IF05S"': securities_group_order_acceptance_halt_message
        '"IF01Q"': securities_group_order_acceptance_halt_message
        '"IF01F"': securities_group_order_acceptance_halt_message
        '"IF02F"': securities_group_order_acceptance_halt_message
        '"IF03F"': securities_group_order_acceptance_halt_message
        '"IF04F"': securities_group_order_acceptance_halt_message
        '"IF05F"': securities_group_order_acceptance_halt_message
        '"IF06F"': securities_group_order_acceptance_halt_message
        '"IF07F"': securities_group_order_acceptance_halt_message
        '"IF08F"': securities_group_order_acceptance_halt_message
        '"IF09F"': securities_group_order_acceptance_halt_message
        '"IF10F"': securities_group_order_acceptance_halt_message
        '"IF11F"': securities_group_order_acceptance_halt_message
        '"IF12F"': securities_group_order_acceptance_halt_message
        '"IF13F"': securities_group_order_acceptance_halt_message
        '"IF15F"': securities_group_order_acceptance_halt_message
        '"IF16F"': securities_group_order_acceptance_halt_message
        '"IF17F"': securities_group_order_acceptance_halt_message
        '"IF18F"': securities_group_order_acceptance_halt_message
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
        '"C001S"': securities_investor_activities_per_industry_message
        '"C001Q"': securities_investor_activities_per_industry_message
        '"C001X"': securities_investor_activities_per_industry_message
        '"C101S"': securities_investor_activities_per_issue_eod_message
        '"C102S"': securities_investor_activities_per_issue_eod_message
        '"C103S"': securities_investor_activities_per_issue_eod_message
        '"C104S"': securities_investor_activities_per_issue_eod_message
        '"C105S"': securities_investor_activities_per_issue_eod_message
        '"C101Q"': securities_investor_activities_per_issue_eod_message
        '"C101X"': securities_investor_activities_per_issue_eod_message
        '"C101G"': securities_investor_activities_per_issue_eod_message
        '"IC02S"': securities_investor_activities_per_commodities_message
        '"IC03S"': securities_investor_activities_per_commodities_message
        '"IC04S"': securities_investor_activities_per_commodities_message
        '"IC05S"': securities_investor_activities_per_commodities_message
        '"IC01G"': securities_investor_activities_per_commodities_message
        '"I801S"': securities_short_selling_message
        '"I803S"': securities_short_selling_message
        '"I804S"': securities_short_selling_message
        '"I805S"': securities_short_selling_message
        '"I801Q"': securities_short_selling_message
        '"B001S"': securities_treasury_stocks_traded_message
        '"B001Q"': securities_treasury_stocks_traded_message
        '"B001X"': securities_treasury_stocks_traded_message
        '"O401S"': securities_buy_in_volume_message
        '"O402S"': securities_buy_in_volume_message
        '"O403S"': securities_buy_in_volume_message
        '"O404S"': securities_buy_in_volume_message
        '"O401Q"': securities_buy_in_volume_message
        '"O401X"': securities_buy_in_volume_message
        '"A102S"': securities_elw_batch_data_message
        '"A104S"': securities_etn_batch_data_message
        '"X304S"': securities_etn_early_redemption_message
        '"V600S"': securities_etp_constituents_message
        '"M602S"': securities_knock_out_elw_message
        '"M502S"': securities_knock_out_underlying_message
        '"P001S"': securities_program_trading_activity_per_investor_message
        '"P001Q"': securities_program_trading_activity_per_investor_message
        '"C301S"': securities_program_trading_information_per_issue_aggregated_message
        '"C301Q"': securities_program_trading_information_per_issue_aggregated_message
        '"J001S"': securities_program_trading_information_of_total_aggregated_message
        '"J001Q"': securities_program_trading_information_of_total_aggregated_message
        '"B901S"': securities_top_five_traders_activities_message
        '"B901Q"': securities_top_five_traders_activities_message
        '"B901X"': securities_top_five_traders_activities_message
        '"B902S"': securities_top_five_traders_activities_message
        '"B903S"': securities_top_five_traders_activities_message
        '"B904S"': securities_top_five_traders_activities_message
        '"B905S"': securities_top_five_traders_activities_message
        '"F000S"': announcement_kospi_message
        '"F000Q"': announcement_kosdaq_message
        '"F000X"': announcement_konex_message
        '"F0909"': announcement_all_market_message
        '"E900S"': pre_market_announcement_kospi_message
        '"E900Q"': pre_market_announcement_kosdaq_message
        '"E900X"': pre_market_announcement_konex_message
        '"E9909"': pre_market_announcement_all_market_message
        '"B501S"': securities_current_movement_message
        '"B501Q"': securities_current_movement_message
        '"B501X"': securities_current_movement_message
        '"B801S"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"B801Q"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"B801X"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"B803S"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"B804S"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"B805S"': securities_closing_price_trade_remaining_quantity_on_quotes_message
        '"IE01S"': securities_a_blox_trade_quotes_message
        '"IE01Q"': securities_a_blox_trade_quotes_message
        '"IE03S"': securities_a_blox_trade_quotes_message
        '"IE04S"': securities_a_blox_trade_quotes_message
        '"IE05S"': securities_a_blox_trade_quotes_message
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
        doc: 'Calculation Time (HHMMSS)'
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
        doc: 'Reserved filler. ASCII spaces'
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
        doc: 'Calculation Time (HHMMSS)'
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
        doc: 'Reserved filler. ASCII spaces'
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
        doc: 'Calculation Time (HHMMSS)'
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
        doc: 'Reserved filler. ASCII spaces'
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
  securities_quote_mm_lp_excluded_message:
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
      - id: midpoint
        type: str
        size: 11
        encoding: ASCII
        doc: 'The mid-point between the quoted Bid Price and Ask Price'
      - id: ask_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask Mid Price Total Volume'
      - id: bid_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid Mid Price Total Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_quote_mm_lp_included_message:
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
      - id: midpoint
        type: str
        size: 11
        encoding: ASCII
        doc: 'The mid-point between the quoted Bid Price and Ask Price'
      - id: ask_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask Mid Price Total Volume'
      - id: bid_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid Mid Price Total Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_snapshot_mm_lp_excluded_message:
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
      - id: current_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last traded price at the current page'
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
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: midpoint
        type: str
        size: 11
        encoding: ASCII
        doc: 'The mid-point between the quoted Bid Price and Ask Price'
      - id: ask_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask Mid Price Total Volume'
      - id: bid_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid Mid Price Total Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_snapshot_mm_lp_included_message:
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
      - id: current_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'The last traded price at the current page'
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
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: knockout_elw_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'The status of warrants "Y": Knock-out'
      - id: knockout_elw_triggering_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when Knock-out ELW reaches to the designated price HH(0-23) MM(0-59) SS(0-59)'
      - id: midpoint
        type: str
        size: 11
        encoding: ASCII
        doc: 'The mid-point between the quoted Bid Price and Ask Price'
      - id: ask_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask Mid Price Total Volume'
      - id: bid_mid_price_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid Mid Price Total Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_order_filled_message:
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
      - id: trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Trading volume'
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
  securities_negotiated_trade_message:
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
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated trading value of treasury stock'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_market_operation_ts_message:
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
  securities_determination_of_base_price_message:
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
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_issue_closing_message:
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
  securities_market_operation_schedule_message:
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
  securities_random_end_message:
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
        doc: 'In case of trigger and conditional trigger(2) of random end in single price session, random end will be triggered if price requirements defined in the random end rules are met. ##Code Values## 0: No t'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_triggering_vi_message:
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
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: the_time_ending_vi
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time ending VI'
      - id: vi_status_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to show triggering or removal of VI 1: VI triggered 2: VI removed'
      - id: vi_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code to distinguish static VI or dynamic VI 1: Static VI 2: Dynamic VI 3: Static/Dynamic VI'
      - id: a_base_price_to_trigger_static_vi
        type: str
        size: 11
        encoding: ASCII
        doc: 'A Base Price to trigger Static VI'
      - id: a_base_price_to_trigger_dynamic_vi
        type: str
        size: 11
        encoding: ASCII
        doc: 'A Base Price to trigger dynamic VI'
      - id: vi_triggering_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price to tigger VI'
      - id: disparate_ratio_to_trigger_static_vi
        type: str
        size: 13
        encoding: ASCII
        doc: 'A disparate ratio of a base price to an expected price to trigger static VI'
      - id: disparate_ratio_to_trigger_dynamic_vi
        type: str
        size: 13
        encoding: ASCII
        doc: 'A disparate ratio of a previously traded price to an expected price to trigger dynamic VI'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_quantity_allocation_message:
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
      - id: start_end_of_allocation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Start of Allocation 2: End of Allocation'
      - id: allocation_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Bid_Upper Limit 2: Bid_Lower Limit 3: Ask_Upper Limit 4: Ask_Lower Limit'
      - id: time_when_allocation_ended
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Time when Allocation ended'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_member_firm_sanctions_message:
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
        doc: 'End of text sentinel (0xFF)'
  securities_equities_changes_of_batch_data_message:
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
      - id: disclosing_data_type_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'A data type code indicating a Batch data change and imposing/lifting sanctions to/from member firm'
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
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
      - id: appraised_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An appraised price is a base price of an Issue of which base price is settled with today''s single price, and it determines an upper/lower limit price for its opening price'
      - id: highest_order_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An upper limit price of an issue of which base price is settled with today''s single price'
      - id: lowest_order_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'An lower limit price of an issue of which base price is settled with today''s single price'
      - id: type_code_for_an_issue_of_which_base_price_is_settled_with_a_todays_single_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'When a company implements a right/bonus issue or an issue is suspended in the long-term, such issue will use an opening price as a base price instead of closing price. Y/N refers to yes/no to this dec'
      - id: rights_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '(Option) Rights_Type Code C: Call P: Put'
      - id: par_value_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '00: N/A 01: Split at par value 02: Consolidation at par value 03: Stock split 04: Reverse stock split 99: Others'
      - id: lot_sizes
        type: str
        size: 11
        encoding: ASCII
        doc: 'A lot size is an unit of a quote for a financial issue traded on an exchange. The quotes should be submitted with integer multiples'
      - id: number_of_listed_shares
        type: str
        size: 16
        encoding: ASCII
        doc: 'Number of listed shares'
      - id: designation
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Information whether it is a designated issue for administration, liquidation trade, feverish issue in the short-term and issue with super low liquidity'
      - id: closing_price_trading_in_the_preopening_market
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to a Closing Price Trading in the Pre-opening Market'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_group_order_acceptance_halt_message:
    seq:
      - id: market_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Index Derivatives, Equities Derivatives, Bonds Derivatives etc.)'
      - id: me_group_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Matching Engine Group Number'
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
      - id: board_event_group_code
        type: str
        size: 5
        encoding: ASCII
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (Not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (Not a discrete-time traded issue'
      - id: board_event_processing_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Board Event Processing Time'
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
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '(Option) Rights_Type Code C: Call P: Put'
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
  securities_investor_activities_per_industry_message:
    seq:
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Calculation Time (HHMMSS)'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor category code (e.g. 1000 Financial Investors, 2000 Insurance, 3000 Asset Management, etc.)'
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
      - id: accumulated_ask_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Bid Trading Volume'
      - id: accumulated_bid_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Bid Trading Volume'
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
  securities_investor_activities_per_issue_eod_message:
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
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor category code (e.g. 1000 Financial Investors, 2000 Insurance, 3000 Asset Management, etc.)'
      - id: accumulated_ask_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: str
        size: 12
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
        doc: 'End of text sentinel (0xFF)'
  securities_investor_activities_per_commodities_message:
    seq:
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Calculation Time (HHMMSS)'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor category code (e.g. 1000 Financial Investors, 2000 Insurance, 3000 Asset Management, etc.)'
      - id: accumulated_ask_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: str
        size: 12
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
        doc: 'End of text sentinel (0xFF)'
  securities_short_selling_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: covered_short_selling_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Covered Short Selling_Trading Volume'
      - id: covered_short_selling_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Covered Short Selling_Trading Value'
      - id: uptick_rule_applied_covered_short_selling_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Uptick Rule Applied Covered Short Selling Trading Volume'
      - id: uptick_rule_applied_covered_short_selling_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Uptick Rule Applied Covered Short Selling Trading Value'
      - id: uptick_rule_unapplied_covered_short_selling_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Uptick Rule Unapplied Covered Short Selling Trading Volume'
      - id: uptick_rule_unapplied_covered_short_selling_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Uptick Rule Unapplied Covered Short Selling Trading Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_treasury_stocks_traded_message:
    seq:
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
      - id: bid_treasury_stock_declaration_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Bid_Treasury Stock Declaration ID 0: N/A N: Treasury Stock_direct_general S: Treasury Stock_direct_stock options 1 - 99999 Treasury Stock_Trust(report sequence number)'
      - id: ask_treasury_stock_declaration_id
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask_Treasury Stock Declaration ID 0: N/A N: Treasury Stock_direct_general S: Treasury Stock_direct_stock options 1 - 99999 Treasury Stock_Trust(report sequence number)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_buy_in_volume_message:
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
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: buyin_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Buy-in Type Code 1: Regular Buy-in 2: Same day Buy-in'
      - id: security_group_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Security Group ID (Equities, Investment firms, ETF, ELW, Futures, Options etc.)'
      - id: buyin_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-in Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_elw_batch_data_message:
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
      - id: name_of_issuer
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of issuer such as institutions, exchanges and members'
      - id: english_name_of_issuer
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'English name of issuer such as institutions, exchanges and members'
      - id: numbers_of_issuer
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Numbers of issuer such as institutions, exchanges and members'
      - id: market_id_1_for_underlying_assets_indices
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Stock Market Index Derivatives, Equities Derivatives and Bond Derivatives)'
      - id: market_id_2_for_underlying_assets_indices
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Stock Market Index Derivatives, Equities Derivatives and Bond Derivatives)'
      - id: market_id_3_for_underlying_assets_indices
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Stock Market Index Derivatives, Equities Derivatives and Bond Derivatives)'
      - id: market_id_4_for_underlying_assets_indices
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Stock Market Index Derivatives, Equities Derivatives and Bond Derivatives)'
      - id: market_id_5_for_underlying_assets_indices
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market ID (KOSPI, KOSDAQ, Stock Market Index Derivatives, Equities Derivatives and Bond Derivatives)'
      - id: underlying_asset_type_code_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Type Code 1'
      - id: underlying_asset_type_code_2
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Type Code 2'
      - id: underlying_asset_type_code_3
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Type Code 3'
      - id: underlying_asset_type_code_4
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Type Code 4'
      - id: underlying_asset_type_code_5
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Type Code 5'
      - id: underlying_asset_composition_ratio_1
        type: str
        size: 13
        encoding: ASCII
        doc: 'Underlying Asset Composition Ratio 1'
      - id: underlying_asset_composition_ratio_2
        type: str
        size: 13
        encoding: ASCII
        doc: 'Underlying Asset Composition Ratio 2'
      - id: underlying_asset_composition_ratio_3
        type: str
        size: 13
        encoding: ASCII
        doc: 'Underlying Asset Composition Ratio 3'
      - id: underlying_asset_composition_ratio_4
        type: str
        size: 13
        encoding: ASCII
        doc: 'Underlying Asset Composition Ratio 4'
      - id: underlying_asset_composition_ratio_5
        type: str
        size: 13
        encoding: ASCII
        doc: 'Underlying Asset Composition Ratio 5'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: rights_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '(Option) Rights_Type Code C: Call P: Put'
      - id: rights_execution_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rights Execution_Type Code A: American E: European Z: Others'
      - id: payment_methods
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Payment methods C: Cash D: Spot A: Cash + Spot O: N/A'
      - id: last_trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Last Trading Date'
      - id: elw_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when a payment is being made due to the execution of ELW rights'
      - id: base_price_of_underlying_asset
        type: str
        size: 13
        encoding: ASCII
        doc: 'A price of underlying asset which is a basis for exercise price and issue price'
      - id: details_of_rights
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'Details of Options/Warrants Rights'
      - id: elw_conversion_rate
        type: str
        size: 13
        encoding: ASCII
        doc: 'A ratio of number of equities between ELW and underlying asset'
      - id: elw_guaranteed_rate_for_price_increases
        type: str
        size: 10
        encoding: ASCII
        doc: 'A guaranteed minimum ratio of increase for underlying asset'
      - id: elw_guaranteed_rate_for_price_decreases
        type: str
        size: 10
        encoding: ASCII
        doc: 'A guaranteed minimum ratio of decrease for underlying asset. In case of knock-out ELW, the ratio is being used to calculate a minimum payment'
      - id: elw_fixed_payment
        type: str
        size: 22
        encoding: ASCII
        doc: 'An amount of payment due to an execution of ELW rights'
      - id: elw_payment_agent
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'The agent which makes a premium payment on a maturity date. (KB Bank, Yeoui-do Branch)'
      - id: calculation_methods_of_appraised_price_at_maturity
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'A method to calculate an appraised price at maturity'
      - id: elw_rights_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'ELW rights type code such as standard and digital. * Digital ELW: An ELW adopting digital option that makes a payment if a price exceeds certain level rather than a profit is being made depends on und'
      - id: elwlp_holding_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'An amount of ELW that LP accounts hold'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_etn_batch_data_message:
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
      - id: name_of_issuer
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Name of issuer such as institutions, exchanges and members'
      - id: english_name_of_issuer
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'English name of issuer such as institutions, exchanges and members'
      - id: numbers_of_issuer
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Numbers of issuer such as institutions, exchanges and members'
      - id: payment_methods
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Payment methods C: Cash D: Spot A: Cash + Spot O: N/A'
      - id: last_trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Last Trading Date'
      - id: etn_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The date when a payment is being made due to the execution of ETN rights'
      - id: etnlp_holding_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'An amount of ETN that LP accounts hold'
      - id: loss_protection_etn_profit_structure_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'An ETN product that its profit is based on differences of underlying asset and limits loss at certain level to minimizes a sudden increase/decrease of a price. 01: Call 02: Put 03: Call spread 04: Put'
      - id: etn_maximum_redemption_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A maximum redemption price before subtracting expenses'
      - id: etn_minimum_redemption_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A mimimum redemption price before subtracting expenses'
      - id: etn_early_redemption_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to the possibility of early redemption'
      - id: etn_early_redemption_period
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'To identify the period of early redemption for loss protection ETN Available to choose only if ETN Early Redemption Possibility is [Y] ▦▦Code Values▦▦ 01: Permanent(everyday) 02: Every three months 03'
      - id: institution_code_1_appraised_price_calculation
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Institutions calculating appraised price for ETN - Code 1 ▦▦Code Values▦▦ 01:Korea Asset Pricing(KAP) 02:NICE P&I 03:KIS Pricing 04:FnPricing'
      - id: institution_code_2_appraised_price_calculation
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Institutions calculating appraised price for ETN - Code 2 ▦▦Code Values▦▦ 01:Korea Asset Pricing(KAP) 02:NICE P&I 03:KIS Pricing 04:FnPricing'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_etn_early_redemption_message:
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
      - id: etn_early_redemption_period
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'To identify the period of early redemption for loss protection ETN Available to choose only if ETN Early Redemption Possibility is [Y] ▦▦Code Values▦▦ 01: Permanent(everyday) 02: Every three months 03'
      - id: early_redemption_appraisal_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Early Redemption Appraisal Date'
      - id: early_redemption_criteria_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Criteria-Relation Code between Early Redemption Base Index 1 and Early Redemption Base Index 2 In case of multiple criteria, the constraint is Base Index 1 < Base Index 2 ▦▦Code Values▦▦ 1:Single Crit'
      - id: early_redemption_base_index_1
        type: str
        size: 10
        encoding: ASCII
        doc: 'Early Redemption_Base Index 1'
      - id: early_redemption_base_index_2
        type: str
        size: 10
        encoding: ASCII
        doc: 'Early Redemption_Base Index 2'
      - id: early_redemption_price
        type: str
        size: 23
        encoding: ASCII
        doc: 'Early Redemption Price'
      - id: early_repemption_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Early Repemption Payment Date'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_etp_constituents_message:
    seq:
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
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
      - id: index_leverage_inverse_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '## Code Value ## P1: General(1) P2: 2X Leverage(2) P3: 3X Leverage(3) PA: 0.5X Leverage(0.5) PB: 1.5X Leverage(1.5) PC: 2.5X Leverage(2.5) PD: 1.3X Leverage(1.3) N1: 1X Inverse(-1) N2: 2X Inverse(-2)'
      - id: index_name
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Name'
      - id: index_name_in_en
        type: str
        size: 80
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Name in EN'
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
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_knock_out_elw_message:
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
      - id: base_price_to_knockout_elw
        type: str
        size: 13
        encoding: ASCII
        doc: 'Base Price to knock-out ELW'
      - id: knockout_elw_rights
        type: str
        size: 200
        encoding: ASCII
        pad-right: 0x20
        doc: 'Knock-out ELW_Rights'
      - id: knockout_elw_calculation_of_appraised_price
        type: str
        size: 300
        encoding: ASCII
        pad-right: 0x20
        doc: 'A method to calculate an appraised price of an knock-out ELW issue'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_knock_out_underlying_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: message_sequence_number
        type: str
        size: 8
        encoding: ASCII
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: trading_date_of_underlying_asset
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Date of Underlying Asset'
      - id: the_date_knockout_occurred
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date Knock-out occurred'
      - id: ampm_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A: A.M. P: P.M'
      - id: underlying_isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: index_id
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index ID comprising of 6 digits'
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
      - id: filler_4
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Reserved filler. ASCII spaces'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_program_trading_activity_per_investor_message:
    seq:
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Calculation Time (HHMMSS)'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor category code (e.g. 1000 Financial Investors, 2000 Insurance, 3000 Asset Management, etc.)'
      - id: sellside_arbitrage_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Arbitrage Volume'
      - id: sellside_arbitrage_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Sell-side Arbitrage Value'
      - id: sellside_nonarbitrage_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Volume'
      - id: sellside_nonarbitrage_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Value'
      - id: buyside_arbitrage_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Arbitrage Volume'
      - id: buyside_arbitrage_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Buy-side Arbitrage Value'
      - id: buyside_nonarbitrage_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Volume'
      - id: buyside_nonarbitrage_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_program_trading_information_per_issue_aggregated_message:
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
      - id: sellside_arbitrage_trading_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Arbitrage Trading Remaining Quantity'
      - id: buyside_arbitrage_trading_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Arbitrage Trading Remaining Quantity'
      - id: sellside_nonarbitrage_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Remaining Quantity'
      - id: buyside_nonarbitrage_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Remaining Quantity'
      - id: sellside_arbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Arbitrage Quantity'
      - id: buyside_arbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Arbitrage Quantity'
      - id: sellside_nonarbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Quantity'
      - id: buyside_nonarbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Quantity'
      - id: arbitrage_ask_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Ask Trust Trading Volume'
      - id: arbitrage_ask_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Ask Principal Trading Volume'
      - id: arbitrage_bid_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Bid Trust Trading Volume'
      - id: arbitrage_bid_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Bid Principal Trading Volume'
      - id: non_arbitrage_ask_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Trust Trading Volume'
      - id: non_arbitrage_ask_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Principal Trading Volume'
      - id: non_arbitrage_bid_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Trust Trading Volume'
      - id: non_arbitrage_bid_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Principal Trading Volume'
      - id: arbitrage_ask_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Ask Trust Trading Value'
      - id: arbitrage_ask_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Ask Principal Trading Value'
      - id: arbitrage_bid_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Bid Trust Trading Value'
      - id: arbitrage_bid_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Bid Principal Trading Value'
      - id: non_arbitrage_ask_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Trust Trading Value'
      - id: non_arbitrage_ask_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Principal Trading Value'
      - id: non_arbitrage_bid_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Trust Trading Value'
      - id: non_arbitrage_bid_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Principal Trading Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_program_trading_information_of_total_aggregated_message:
    seq:
      - id: sellside_arbitrage_trading_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Arbitrage Trading Remaining Quantity'
      - id: buyside_arbitrage_trading_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Arbitrage Trading Remaining Quantity'
      - id: sellside_nonarbitrage_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Remaining Quantity'
      - id: buyside_nonarbitrage_remaining_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Remaining Quantity'
      - id: sellside_arbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Arbitrage Quantity'
      - id: buyside_arbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Arbitrage Quantity'
      - id: sellside_nonarbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Sell-side Non-arbitrage Quantity'
      - id: buyside_nonarbitrage_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Buy-side Non-arbitrage Quantity'
      - id: arbitrage_ask_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Ask Trust Trading Volume'
      - id: arbitrage_ask_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Ask Principal Trading Volume'
      - id: arbitrage_bid_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Bid Trust Trading Volume'
      - id: arbitrage_bid_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Arbitrage Bid Principal Trading Volume'
      - id: non_arbitrage_ask_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Trust Trading Volume'
      - id: non_arbitrage_ask_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Principal Trading Volume'
      - id: non_arbitrage_bid_trust_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Trust Trading Volume'
      - id: non_arbitrage_bid_principal_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Principal Trading Volume'
      - id: arbitrage_ask_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Ask Trust Trading Value'
      - id: arbitrage_ask_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Ask Principal Trading Value'
      - id: arbitrage_bid_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Bid Trust Trading Value'
      - id: arbitrage_bid_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Arbitrage Bid Principal Trading Value'
      - id: non_arbitrage_ask_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Trust Trading Value'
      - id: non_arbitrage_ask_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Ask Principal Trading Value'
      - id: non_arbitrage_bid_trust_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Trust Trading Value'
      - id: non_arbitrage_bid_principal_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Non-Arbitrage Bid Principal Trading Value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_top_five_traders_activities_message:
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
      - id: member_number_1_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #1 ask-side trader'
      - id: ask_trading_volume_1
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask-side trading volume for the #1 trader'
      - id: ask_trading_value_1
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask-side trading value for the #1 trader'
      - id: member_number_1_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #1 bid-side trader'
      - id: bid_trading_volume_1
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid-side trading volume for the #1 trader'
      - id: bid_trading_value_1
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid-side trading value for the #1 trader'
      - id: member_number_2_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #2 ask-side trader'
      - id: ask_trading_volume_2
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask-side trading volume for the #2 trader'
      - id: ask_trading_value_2
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask-side trading value for the #2 trader'
      - id: member_number_2_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #2 bid-side trader'
      - id: bid_trading_volume_2
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid-side trading volume for the #2 trader'
      - id: bid_trading_value_2
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid-side trading value for the #2 trader'
      - id: member_number_3_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #3 ask-side trader'
      - id: ask_trading_volume_3
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask-side trading volume for the #3 trader'
      - id: ask_trading_value_3
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask-side trading value for the #3 trader'
      - id: member_number_3_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #3 bid-side trader'
      - id: bid_trading_volume_3
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid-side trading volume for the #3 trader'
      - id: bid_trading_value_3
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid-side trading value for the #3 trader'
      - id: member_number_4_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #4 ask-side trader'
      - id: ask_trading_volume_4
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask-side trading volume for the #4 trader'
      - id: ask_trading_value_4
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask-side trading value for the #4 trader'
      - id: member_number_4_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #4 bid-side trader'
      - id: bid_trading_volume_4
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid-side trading volume for the #4 trader'
      - id: bid_trading_value_4
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid-side trading value for the #4 trader'
      - id: member_number_5_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #5 ask-side trader'
      - id: ask_trading_volume_5
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask-side trading volume for the #5 trader'
      - id: ask_trading_value_5
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask-side trading value for the #5 trader'
      - id: member_number_5_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member firm identifier for the #5 bid-side trader'
      - id: bid_trading_volume_5
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid-side trading volume for the #5 trader'
      - id: bid_trading_value_5
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid-side trading value for the #5 trader'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  announcement_kospi_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  announcement_kosdaq_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  announcement_konex_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  announcement_all_market_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  pre_market_announcement_kospi_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  pre_market_announcement_kosdaq_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  pre_market_announcement_konex_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  pre_market_announcement_all_market_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: public_announcement_sequence_number
        type: str
        size: 6
        encoding: ASCII
        doc: 'A sequece number for yearly published public announcement'
      - id: public_announcement_total_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Total Page Number'
      - id: public_announcement_current_page_number
        type: str
        size: 5
        encoding: ASCII
        doc: 'Public Announcement_Current Page Number'
      - id: public_announcement_publishing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Publishing Date'
      - id: transmission_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transmission Date'
      - id: public_announcement_market_code
        type: u1
        enum: public_announcement_market_code
        doc: '1: KOSPI 2: KOSDAQ 3: Derivatives 4: Bonds 6: KONEX 7: Commodities 8: Others (non-listed company, ABS·asset backed securities) 9: Common E: Emission G: Gold Spot'
      - id: abbreviated_issue_name
        type: str
        size: 40
        encoding: ASCII
        pad-right: 0x20
        doc: 'Abbreviated issue Name'
      - id: public_announcement_process_code
        type: u1
        enum: public_announcement_process_code
        doc: 'Public Announcement_Process Code 1: Normal 2: Revision 3: Deleted'
      - id: public_announcement_reason_code
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement_Reason Code (Refer to the Code table) 01008: KOSPI/KOSDAQ/Bonds 12001: Futures Options market (futures market)'
      - id: public_announcement_language_type_code
        type: u1
        enum: public_announcement_language_type_code
        doc: '1: Korean 2: English'
      - id: public_announcement_title
        type: str
        size: 264
        encoding: ASCII
        pad-right: 0x20
        doc: 'Public Announcement Title (Text)'
      - id: public_announcement_content
        type: str
        size: 1000
        encoding: ASCII
        pad-right: 0x20
        doc: 'Content of Public Announcement (HTML)'
      - id: public_announcement_including_isin
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether ISIN is included in public announcement'
      - id: isin_on_a_current_page
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether a current page is filled with only ISINs'
      - id: number_of_instuments_on_a_page
        type: str
        size: 2
        encoding: ASCII
        doc: 'Number of ISINs written on a page (A maximum of 83 ISINs can appear in 1000 Bytes : 83*12=966 Bytes)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_current_movement_message:
    seq:
      - id: total_number_of_issues
        type: str
        size: 5
        encoding: ASCII
        doc: 'A number of issues subjec to calculation of movement'
      - id: number_of_issues_for_movement_calculation
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues for Movement Calculation'
      - id: number_of_issues_of_upper_limit
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of Upper Limit'
      - id: number_of_issues_of_going_up
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of Going Up'
      - id: number_of_issues_of_steadiness
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of steadiness'
      - id: number_of_issues_of_lower_limit
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of Lower Limit'
      - id: number_of_issues_of_going_down
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of Going Down'
      - id: number_of_issues_having_quotes
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues having Quotes'
      - id: number_of_issues_of_which_quotes_are_increasing
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of which Quotes are Increasing'
      - id: number_of_issues_of_which_quotes_are_decreasing
        type: str
        size: 5
        encoding: ASCII
        doc: 'Number of Issues of which Quotes are Decreasing'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_closing_price_trade_remaining_quantity_on_quotes_message:
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
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: accumulated_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Accumulated Trading Volume'
      - id: ask_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  securities_a_blox_trade_quotes_message:
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
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code 1: ASK 2: BID 3: BID + ASK'
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
  public_announcement_market_code:
    0x31:
      id: 'kospi'
      doc: 'Kospi'
    0x32:
      id: 'kosdaq'
      doc: 'Kosdaq'
    0x33:
      id: 'derivatives'
      doc: 'Derivatives'
    0x34:
      id: 'bonds'
      doc: 'Bonds'
    0x36:
      id: 'konex'
      doc: 'Konex'
  public_announcement_process_code:
    0x31:
      id: 'normal'
      doc: 'Normal'
    0x32:
      id: 'retransmission'
      doc: 'Retransmission'
  public_announcement_language_type_code:
    0x31:
      id: 'korean'
      doc: 'Korean'
    0x32:
      id: 'english'
      doc: 'English'

