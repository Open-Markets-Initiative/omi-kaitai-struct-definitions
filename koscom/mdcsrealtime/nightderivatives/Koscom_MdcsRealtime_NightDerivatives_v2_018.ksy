# ---------------------------------------------------------------------
# Kaitai struct definition for: Koscom MdcsRealtime NightDerivatives Exture v2.018
#
# Protocol:
#   Organization: Koscom Co., Ltd.
#   Protocol: MDCS Realtime Night Derivatives
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
  id: koscom_mdcsrealtime_nightderivatives_exture_v2_018
  title: Koscom MdcsRealtime NightDerivatives Exture v2.018
  license: GPL-3.0
  endian: be

doc: 'Koscom Co., Ltd. MDCS Realtime Market Data MDCS Realtime Night Derivatives Exture v2.018'
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
        '"B601V"': derivatives_quote_five_levels_message
        '"B602V"': derivatives_quote_five_levels_message
        '"B603V"': derivatives_quote_five_levels_message
        '"B606V"': derivatives_quote_five_levels_message
        '"B607V"': derivatives_quote_five_levels_message
        '"B608V"': derivatives_quote_five_levels_message
        '"B609V"': derivatives_quote_five_levels_message
        '"B610V"': derivatives_quote_five_levels_message
        '"B611V"': derivatives_quote_five_levels_message
        '"B612V"': derivatives_quote_five_levels_message
        '"B613V"': derivatives_quote_five_levels_message
        '"B615V"': derivatives_quote_five_levels_message
        '"B616V"': derivatives_quote_five_levels_message
        '"B617V"': derivatives_quote_five_levels_message
        '"B604V"': derivatives_quote_ten_levels_message
        '"B605V"': derivatives_quote_ten_levels_message
        '"B618V"': derivatives_quote_ten_levels_message
        '"B201V"': derivatives_snapshot_five_levels_message
        '"B202V"': derivatives_snapshot_five_levels_message
        '"B203V"': derivatives_snapshot_five_levels_message
        '"B206V"': derivatives_snapshot_five_levels_message
        '"B207V"': derivatives_snapshot_five_levels_message
        '"B208V"': derivatives_snapshot_five_levels_message
        '"B209V"': derivatives_snapshot_five_levels_message
        '"B210V"': derivatives_snapshot_five_levels_message
        '"B211V"': derivatives_snapshot_five_levels_message
        '"B212V"': derivatives_snapshot_five_levels_message
        '"B213V"': derivatives_snapshot_five_levels_message
        '"B215V"': derivatives_snapshot_five_levels_message
        '"B216V"': derivatives_snapshot_five_levels_message
        '"B217V"': derivatives_snapshot_five_levels_message
        '"B204V"': derivatives_snapshot_ten_levels_message
        '"B205V"': derivatives_snapshot_ten_levels_message
        '"B218V"': derivatives_snapshot_ten_levels_message
        '"A301V"': derivatives_order_filled_message
        '"A302V"': derivatives_order_filled_message
        '"A303V"': derivatives_order_filled_message
        '"A304V"': derivatives_order_filled_message
        '"A305V"': derivatives_order_filled_message
        '"A306V"': derivatives_order_filled_message
        '"A307V"': derivatives_order_filled_message
        '"A308V"': derivatives_order_filled_message
        '"A309V"': derivatives_order_filled_message
        '"A310V"': derivatives_order_filled_message
        '"A311V"': derivatives_order_filled_message
        '"A312V"': derivatives_order_filled_message
        '"A313V"': derivatives_order_filled_message
        '"A315V"': derivatives_order_filled_message
        '"A316V"': derivatives_order_filled_message
        '"A317V"': derivatives_order_filled_message
        '"A318V"': derivatives_order_filled_message
        '"G701V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G702V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G703V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G706V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G707V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G708V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G709V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G710V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G711V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G712V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G713V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G715V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G716V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G717V"': derivatives_order_filled_plus_quote_five_levels_message
        '"G704V"': derivatives_order_filled_plus_quote_ten_levels_message
        '"G705V"': derivatives_order_filled_plus_quote_ten_levels_message
        '"G718V"': derivatives_order_filled_plus_quote_ten_levels_message
        '"R101V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R102V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R103V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R106V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R107V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R108V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R109V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R110V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R111V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R112V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R113V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R115V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R116V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R117V"': derivatives_market_operation_ts_plus_quote_five_levels_message
        '"R104V"': derivatives_market_operation_ts_plus_quote_ten_levels_message
        '"R105V"': derivatives_market_operation_ts_plus_quote_ten_levels_message
        '"R118V"': derivatives_market_operation_ts_plus_quote_ten_levels_message
        '"C401V"': derivatives_negotiated_trade_message
        '"C402V"': derivatives_negotiated_trade_message
        '"C403V"': derivatives_negotiated_trade_message
        '"C404V"': derivatives_negotiated_trade_message
        '"C405V"': derivatives_negotiated_trade_message
        '"C406V"': derivatives_negotiated_trade_message
        '"C407V"': derivatives_negotiated_trade_message
        '"C408V"': derivatives_negotiated_trade_message
        '"C409V"': derivatives_negotiated_trade_message
        '"C410V"': derivatives_negotiated_trade_message
        '"C411V"': derivatives_negotiated_trade_message
        '"C412V"': derivatives_negotiated_trade_message
        '"C413V"': derivatives_negotiated_trade_message
        '"C415V"': derivatives_negotiated_trade_message
        '"C416V"': derivatives_negotiated_trade_message
        '"C417V"': derivatives_negotiated_trade_message
        '"C418V"': derivatives_negotiated_trade_message
        '"A701S"': derivatives_market_operation_ts_message
        '"A702S"': derivatives_market_operation_ts_message
        '"A703S"': derivatives_market_operation_ts_message
        '"A704S"': derivatives_market_operation_ts_message
        '"A705S"': derivatives_market_operation_ts_message
        '"A701Q"': derivatives_market_operation_ts_message
        '"A701X"': derivatives_market_operation_ts_message
        '"A701B"': derivatives_market_operation_ts_message
        '"A701M"': derivatives_market_operation_ts_message
        '"A701K"': derivatives_market_operation_ts_message
        '"A701R"': derivatives_market_operation_ts_message
        '"A701V"': derivatives_market_operation_ts_message
        '"A702V"': derivatives_market_operation_ts_message
        '"A703V"': derivatives_market_operation_ts_message
        '"A704V"': derivatives_market_operation_ts_message
        '"A705V"': derivatives_market_operation_ts_message
        '"A706V"': derivatives_market_operation_ts_message
        '"A707V"': derivatives_market_operation_ts_message
        '"A708V"': derivatives_market_operation_ts_message
        '"A709V"': derivatives_market_operation_ts_message
        '"A710V"': derivatives_market_operation_ts_message
        '"A711V"': derivatives_market_operation_ts_message
        '"A712V"': derivatives_market_operation_ts_message
        '"A713V"': derivatives_market_operation_ts_message
        '"A715V"': derivatives_market_operation_ts_message
        '"A716V"': derivatives_market_operation_ts_message
        '"A717V"': derivatives_market_operation_ts_message
        '"A718V"': derivatives_market_operation_ts_message
        '"A701G"': derivatives_market_operation_ts_message
        '"A701E"': derivatives_market_operation_ts_message
        '"A601V"': derivatives_issue_closing_message
        '"A602V"': derivatives_issue_closing_message
        '"A603V"': derivatives_issue_closing_message
        '"A604V"': derivatives_issue_closing_message
        '"A605V"': derivatives_issue_closing_message
        '"A606V"': derivatives_issue_closing_message
        '"A607V"': derivatives_issue_closing_message
        '"A608V"': derivatives_issue_closing_message
        '"A609V"': derivatives_issue_closing_message
        '"A610V"': derivatives_issue_closing_message
        '"A611V"': derivatives_issue_closing_message
        '"A612V"': derivatives_issue_closing_message
        '"A613V"': derivatives_issue_closing_message
        '"A615V"': derivatives_issue_closing_message
        '"A616V"': derivatives_issue_closing_message
        '"A617V"': derivatives_issue_closing_message
        '"A618V"': derivatives_issue_closing_message
        '"M401S"': derivatives_market_operation_schedule_message
        '"M402S"': derivatives_market_operation_schedule_message
        '"M403S"': derivatives_market_operation_schedule_message
        '"M404S"': derivatives_market_operation_schedule_message
        '"M405S"': derivatives_market_operation_schedule_message
        '"M401Q"': derivatives_market_operation_schedule_message
        '"M401X"': derivatives_market_operation_schedule_message
        '"M401B"': derivatives_market_operation_schedule_message
        '"M401M"': derivatives_market_operation_schedule_message
        '"M401K"': derivatives_market_operation_schedule_message
        '"M401R"': derivatives_market_operation_schedule_message
        '"M401V"': derivatives_market_operation_schedule_message
        '"M402V"': derivatives_market_operation_schedule_message
        '"M403V"': derivatives_market_operation_schedule_message
        '"M404V"': derivatives_market_operation_schedule_message
        '"M405V"': derivatives_market_operation_schedule_message
        '"M406V"': derivatives_market_operation_schedule_message
        '"M407V"': derivatives_market_operation_schedule_message
        '"M408V"': derivatives_market_operation_schedule_message
        '"M409V"': derivatives_market_operation_schedule_message
        '"M410V"': derivatives_market_operation_schedule_message
        '"M411V"': derivatives_market_operation_schedule_message
        '"M412V"': derivatives_market_operation_schedule_message
        '"M413V"': derivatives_market_operation_schedule_message
        '"M415V"': derivatives_market_operation_schedule_message
        '"M416V"': derivatives_market_operation_schedule_message
        '"M417V"': derivatives_market_operation_schedule_message
        '"M418V"': derivatives_market_operation_schedule_message
        '"M401G"': derivatives_market_operation_schedule_message
        '"M401E"': derivatives_market_operation_schedule_message
        '"Q201V"': derivatives_dynamic_upper_lower_limit_message
        '"Q202V"': derivatives_dynamic_upper_lower_limit_message
        '"Q203V"': derivatives_dynamic_upper_lower_limit_message
        '"Q204V"': derivatives_dynamic_upper_lower_limit_message
        '"Q206V"': derivatives_dynamic_upper_lower_limit_message
        '"Q208V"': derivatives_dynamic_upper_lower_limit_message
        '"Q209V"': derivatives_dynamic_upper_lower_limit_message
        '"Q210V"': derivatives_dynamic_upper_lower_limit_message
        '"Q211V"': derivatives_dynamic_upper_lower_limit_message
        '"Q212V"': derivatives_dynamic_upper_lower_limit_message
        '"Q216V"': derivatives_dynamic_upper_lower_limit_message
        '"Q217V"': derivatives_dynamic_upper_lower_limit_message
        '"V101V"': derivatives_price_limit_range_increase_message
        '"V102V"': derivatives_price_limit_range_increase_message
        '"V103V"': derivatives_price_limit_range_increase_message
        '"V104V"': derivatives_price_limit_range_increase_message
        '"V105V"': derivatives_price_limit_range_increase_message
        '"V108V"': derivatives_price_limit_range_increase_message
        '"V109V"': derivatives_price_limit_range_increase_message
        '"V111V"': derivatives_price_limit_range_increase_message
        '"V112V"': derivatives_price_limit_range_increase_message
        '"V113V"': derivatives_price_limit_range_increase_message
        '"V115V"': derivatives_price_limit_range_increase_message
        '"V116V"': derivatives_price_limit_range_increase_message
        '"V117V"': derivatives_price_limit_range_increase_message
        '"V118V"': derivatives_price_limit_range_increase_message
        '"O601S"': derivatives_quantity_allocation_message
        '"O603S"': derivatives_quantity_allocation_message
        '"O604S"': derivatives_quantity_allocation_message
        '"O605S"': derivatives_quantity_allocation_message
        '"O601Q"': derivatives_quantity_allocation_message
        '"O601X"': derivatives_quantity_allocation_message
        '"O601V"': derivatives_quantity_allocation_message
        '"O602V"': derivatives_quantity_allocation_message
        '"O603V"': derivatives_quantity_allocation_message
        '"O604V"': derivatives_quantity_allocation_message
        '"O605V"': derivatives_quantity_allocation_message
        '"O606V"': derivatives_quantity_allocation_message
        '"O607V"': derivatives_quantity_allocation_message
        '"O608V"': derivatives_quantity_allocation_message
        '"O609V"': derivatives_quantity_allocation_message
        '"O610V"': derivatives_quantity_allocation_message
        '"O611V"': derivatives_quantity_allocation_message
        '"O612V"': derivatives_quantity_allocation_message
        '"O613V"': derivatives_quantity_allocation_message
        '"O615V"': derivatives_quantity_allocation_message
        '"O616V"': derivatives_quantity_allocation_message
        '"O617V"': derivatives_quantity_allocation_message
        '"O618V"': derivatives_quantity_allocation_message
        '"IF01S"': derivatives_group_order_acceptance_halt_message
        '"IF02S"': derivatives_group_order_acceptance_halt_message
        '"IF03S"': derivatives_group_order_acceptance_halt_message
        '"IF04S"': derivatives_group_order_acceptance_halt_message
        '"IF05S"': derivatives_group_order_acceptance_halt_message
        '"IF01Q"': derivatives_group_order_acceptance_halt_message
        '"IF01V"': derivatives_group_order_acceptance_halt_message
        '"IF02V"': derivatives_group_order_acceptance_halt_message
        '"IF03V"': derivatives_group_order_acceptance_halt_message
        '"IF04V"': derivatives_group_order_acceptance_halt_message
        '"IF05V"': derivatives_group_order_acceptance_halt_message
        '"IF06V"': derivatives_group_order_acceptance_halt_message
        '"IF07V"': derivatives_group_order_acceptance_halt_message
        '"IF08V"': derivatives_group_order_acceptance_halt_message
        '"IF09V"': derivatives_group_order_acceptance_halt_message
        '"IF10V"': derivatives_group_order_acceptance_halt_message
        '"IF11V"': derivatives_group_order_acceptance_halt_message
        '"IF12V"': derivatives_group_order_acceptance_halt_message
        '"IF13V"': derivatives_group_order_acceptance_halt_message
        '"IF15V"': derivatives_group_order_acceptance_halt_message
        '"IF16V"': derivatives_group_order_acceptance_halt_message
        '"IF17V"': derivatives_group_order_acceptance_halt_message
        '"IF18V"': derivatives_group_order_acceptance_halt_message
        '"A001V"': derivatives_batch_data_message
        '"A002V"': derivatives_batch_data_message
        '"A003V"': derivatives_batch_data_message
        '"A004V"': derivatives_batch_data_message
        '"A005V"': derivatives_batch_data_message
        '"A006V"': derivatives_batch_data_message
        '"A007V"': derivatives_batch_data_message
        '"A008V"': derivatives_batch_data_message
        '"A009V"': derivatives_batch_data_message
        '"A010V"': derivatives_batch_data_message
        '"A011V"': derivatives_batch_data_message
        '"A012V"': derivatives_batch_data_message
        '"A013V"': derivatives_batch_data_message
        '"A015V"': derivatives_batch_data_message
        '"A016V"': derivatives_batch_data_message
        '"A017V"': derivatives_batch_data_message
        '"A018V"': derivatives_batch_data_message
        '"H404V"': equity_derivatives_adjustment_details_message
        '"H405V"': equity_derivatives_adjustment_details_message
        '"H418V"': equity_derivatives_adjustment_details_message
        '"H606V"': commodity_futures_settlement_reference_ktb_message
        '"H101V"': derivatives_investor_activities_message
        '"H102V"': derivatives_investor_activities_message
        '"H103V"': derivatives_investor_activities_message
        '"H104V"': derivatives_investor_activities_message
        '"H105V"': derivatives_investor_activities_message
        '"H106V"': derivatives_investor_activities_message
        '"H107V"': derivatives_investor_activities_message
        '"H108V"': derivatives_investor_activities_message
        '"H109V"': derivatives_investor_activities_message
        '"H110V"': derivatives_investor_activities_message
        '"H111V"': derivatives_investor_activities_message
        '"H112V"': derivatives_investor_activities_message
        '"H113V"': derivatives_investor_activities_message
        '"H115V"': derivatives_investor_activities_message
        '"H116V"': derivatives_investor_activities_message
        '"H117V"': derivatives_investor_activities_message
        '"H118V"': derivatives_investor_activities_message
        '"H201V"': derivatives_open_interest_message
        '"H202V"': derivatives_open_interest_message
        '"H203V"': derivatives_open_interest_message
        '"H204V"': derivatives_open_interest_message
        '"H205V"': derivatives_open_interest_message
        '"H206V"': derivatives_open_interest_message
        '"H207V"': derivatives_open_interest_message
        '"H208V"': derivatives_open_interest_message
        '"H209V"': derivatives_open_interest_message
        '"H210V"': derivatives_open_interest_message
        '"H211V"': derivatives_open_interest_message
        '"H212V"': derivatives_open_interest_message
        '"H213V"': derivatives_open_interest_message
        '"H215V"': derivatives_open_interest_message
        '"H216V"': derivatives_open_interest_message
        '"H217V"': derivatives_open_interest_message
        '"H218V"': derivatives_open_interest_message
        '"H301V"': futures_settled_price_message
        '"H302V"': futures_settled_price_message
        '"H304V"': futures_settled_price_message
        '"H306V"': futures_settled_price_message
        '"H308V"': futures_settled_price_message
        '"H309V"': futures_settled_price_message
        '"H310V"': futures_settled_price_message
        '"H311V"': futures_settled_price_message
        '"H313V"': futures_settled_price_message
        '"ID03V"': options_base_price_of_clearing_margins_message
        '"ID05V"': options_base_price_of_clearing_margins_message
        '"ID07V"': options_base_price_of_clearing_margins_message
        '"ID12V"': options_base_price_of_clearing_margins_message
        '"ID15V"': options_base_price_of_clearing_margins_message
        '"ID16V"': options_base_price_of_clearing_margins_message
        '"ID17V"': options_base_price_of_clearing_margins_message
        '"ID18V"': options_base_price_of_clearing_margins_message
        '"P103V"': options_implied_volatility_message
        '"P112V"': options_implied_volatility_message
        '"P115V"': options_implied_volatility_message
        '"P116V"': options_implied_volatility_message
        '"P117V"': options_implied_volatility_message
        '"N703V"': options_sensitivity_message
        '"N705V"': options_sensitivity_message
        '"N707V"': options_sensitivity_message
        '"N712V"': options_sensitivity_message
        '"N715V"': options_sensitivity_message
        '"N716V"': options_sensitivity_message
        '"N717V"': options_sensitivity_message
        '"N718V"': options_sensitivity_message
        '"H506V"': commodity_futures_spot_settlement_reference_message
        '"H599V"': commodity_futures_spot_settlement_reference_message
        '"HA06V"': daily_disclosed_rfr_message

types:
  polling_data_message:
    seq:
      - id: current_time_1_minute_interval
        type: hhmm_ascii_time
        doc: 'Current Time (1-minute interval)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_quote_five_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_quote_ten_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: ask_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 6_Order Counts'
      - id: bid_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 6_Order Counts'
      - id: ask_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: ask_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 7_Order Counts'
      - id: bid_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 7_Order Counts'
      - id: ask_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: ask_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 8_Order Counts'
      - id: bid_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 8_Order Counts'
      - id: ask_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: ask_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 9_Order Counts'
      - id: bid_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 9_Order Counts'
      - id: ask_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: ask_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 10_Order Counts'
      - id: bid_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 10_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_snapshot_five_levels_message:
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
      - id: upper_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price subtracting the price limit from the base price'
      - id: trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: nearby_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of nearby month (a component of a futures spread)'
      - id: distant_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of distant month (a component of a futures spread)'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price at which an instrument traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: open_interest
        type: str
        size: 10
        encoding: ASCII
        doc: 'Open interest is the total number of outstanding derivative contracts, such as options or futures that have not been settled for an asset after the end of session'
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
        type: u1
        enum: final_ask_bid_type_code
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_snapshot_ten_levels_message:
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
      - id: upper_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price subtracting the price limit from the base price'
      - id: trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: nearby_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of nearby month (a component of a futures spread)'
      - id: distant_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of distant month (a component of a futures spread)'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price at which an instrument traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: open_interest
        type: str
        size: 10
        encoding: ASCII
        doc: 'Open interest is the total number of outstanding derivative contracts, such as options or futures that have not been settled for an asset after the end of session'
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
        type: u1
        enum: final_ask_bid_type_code
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: ask_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 6_Order Counts'
      - id: bid_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 6_Order Counts'
      - id: ask_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: ask_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 7_Order Counts'
      - id: bid_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 7_Order Counts'
      - id: ask_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: ask_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 8_Order Counts'
      - id: bid_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 8_Order Counts'
      - id: ask_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: ask_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 9_Order Counts'
      - id: bid_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 9_Order Counts'
      - id: ask_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: ask_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 10_Order Counts'
      - id: bid_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 10_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_order_filled_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trading volume'
      - id: nearby_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of nearby month (a component of a futures spread)'
      - id: distant_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of distant month (a component of a futures spread)'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price at which an instrument traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: previous_price
        type: str
        size: 9
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
        type: u1
        enum: final_ask_bid_type_code
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_order_filled_plus_quote_five_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trading volume'
      - id: nearby_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of nearby month (a component of a futures spread)'
      - id: distant_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of distant month (a component of a futures spread)'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price at which an instrument traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: previous_price
        type: str
        size: 9
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
        type: u1
        enum: final_ask_bid_type_code
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_order_filled_plus_quote_ten_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'The price at which a security is currently selling in the market'
      - id: trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Trading volume'
      - id: nearby_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of nearby month (a component of a futures spread)'
      - id: distant_month_contract_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A trading price of distant month (a component of a futures spread)'
      - id: opening_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        type: str
        size: 9
        encoding: ASCII
        doc: 'The highest price at which an instrument traded during the course of the trading day. Also, the record high of a year refers to the highest price of a year'
      - id: todays_low
        type: str
        size: 9
        encoding: ASCII
        doc: 'The lowest price or index at which an issue traded during the course of a day, week, month or year'
      - id: previous_price
        type: str
        size: 9
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
        type: u1
        enum: final_ask_bid_type_code
        doc: 'Ask/Bid Type Code space: order filled with single price 0: N/A 1: ASK 2: BID'
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: ask_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 6_Order Counts'
      - id: bid_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 6_Order Counts'
      - id: ask_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: ask_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 7_Order Counts'
      - id: bid_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 7_Order Counts'
      - id: ask_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: ask_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 8_Order Counts'
      - id: bid_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 8_Order Counts'
      - id: ask_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: ask_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 9_Order Counts'
      - id: bid_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 9_Order Counts'
      - id: ask_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: ask_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 10_Order Counts'
      - id: bid_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 10_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_market_operation_ts_plus_quote_five_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_market_operation_ts_plus_quote_ten_levels_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: ask_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask'
      - id: bid_level_1_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The best bid volume'
      - id: ask_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 1_Order Counts'
      - id: bid_level_1_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 1_Order Counts'
      - id: ask_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The second lowest bid volume'
      - id: ask_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 2_Order Counts'
      - id: bid_level_2_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 2_Order Counts'
      - id: ask_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The third lowest bid volume'
      - id: ask_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 3_Order Counts'
      - id: bid_level_3_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 3_Order Counts'
      - id: ask_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fourth lowest bid volume'
      - id: ask_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 4_Order Counts'
      - id: bid_level_4_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 4_Order Counts'
      - id: ask_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The fifth lowest bid volume'
      - id: ask_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 5_Order Counts'
      - id: bid_level_5_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 5_Order Counts'
      - id: ask_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The sixth lowest bid volume'
      - id: ask_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 6_Order Counts'
      - id: bid_level_6_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 6_Order Counts'
      - id: ask_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The seventh lowest bid volume'
      - id: ask_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 7_Order Counts'
      - id: bid_level_7_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 7_Order Counts'
      - id: ask_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The eighth lowest bid volume'
      - id: ask_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 8_Order Counts'
      - id: bid_level_8_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 8_Order Counts'
      - id: ask_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The ninth lowest bid volume'
      - id: ask_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 9_Order Counts'
      - id: bid_level_9_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 9_Order Counts'
      - id: ask_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'The tenth lowest bid volume'
      - id: ask_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Level 10_Order Counts'
      - id: bid_level_10_order_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Level 10_Order Counts'
      - id: ask_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Ask Total Volume'
      - id: bid_total_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'Bid Total Volume'
      - id: ask_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Ask Price_ Valid Counts'
      - id: bid_price_valid_counts
        type: str
        size: 5
        encoding: ASCII
        doc: 'Bid Price_ Valid Counts'
      - id: estimated_trading_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: str
        size: 9
        encoding: ASCII
        doc: 'An estimated trading volume before the single price trade session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_negotiated_trade_message:
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
  derivatives_market_operation_ts_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
  derivatives_issue_closing_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
        size: 9
        encoding: ASCII
        doc: 'Closing price on the day''s regular session'
      - id: closing_price_type_code
        type: str_1_nullable
        doc: '1: Closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price. Nullable, No Value ='
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
  derivatives_market_operation_schedule_message:
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
  derivatives_dynamic_upper_lower_limit_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: dynamic_price_limit_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Dynamic Price Limit Type Code 0: Removal 1: Applying 2: Reapplying'
      - id: upper_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Upper Limit of Dynamic Price Range'
      - id: lower_limit_of_dynamic_price_range
        type: str
        size: 9
        encoding: ASCII
        doc: 'Lower Limit of Dynamic Price Range'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_price_limit_range_increase_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: the_time_imposing_a_price_limit
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The time when a price limit is imposed'
      - id: price_limit_expansion_upper_limit
        type: str
        size: 2
        encoding: ASCII
        doc: 'Price Limit Expansion_Upper Limit'
      - id: price_limit_expansion_lower_limit
        type: str
        size: 2
        encoding: ASCII
        doc: 'Price Limit Expansion_Lower Limit'
      - id: upper_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        type: str
        size: 9
        encoding: ASCII
        doc: 'A price subtracting the price limit from the base price'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_quantity_allocation_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
  derivatives_group_order_acceptance_halt_message:
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
  derivatives_batch_data_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: futures_options_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A C: Call Options F: Futures P: Put Options'
      - id: product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product ID'
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
      - id: spread_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'F: Farther month contract(Time spread) N: Nearby month contract(Time spread H: High Price Contract (Money Spread) L: Low Price Contract (Money Spread) C: Short-term contract(Intercommodity spread)'
      - id: payment_methods
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Payment methods C: Cash D: Spot A: Cash + Spot O: N/A'
      - id: direction_of_price_limit_expansion_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'A direction of a price limit to expand, if it expands by several stages. X: N/A F: Forward B: Backward T: Two-way'
      - id: final_stage_of_price_limit_expansion
        type: str
        size: 3
        encoding: ASCII
        doc: 'Final stage of price limit expansion when a limit expands by several stages'
      - id: upper_price_limit_1_st_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price adding the first stage of the price limit to the base price'
      - id: upper_price_limit_2_nd_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price adding the second stage of the price limit to the base price'
      - id: upper_price_limit_3_rd_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price adding the third stage of the price limit to the base price'
      - id: lower_price_limit_1_st_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price subtracting the first stage of the price limit from the base price'
      - id: lower_price_limit_2_nd_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price subtracting the second stage of the price limit from the base price'
      - id: lower_price_limit_3_rd_stage
        type: str
        size: 11
        encoding: ASCII
        doc: 'A price subtracting the third stage of the price limit from the base price'
      - id: base_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: underlying_asset_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset ID of Derivatives'
      - id: rights_execution_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Rights Execution_Type Code A: American E: European Z: Others'
      - id: spread_composition_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A composition of spread contract replaing combination quote. The composition method varies depends on the type of spread. ▦▦Code Value▦▦ 1. Time Spread - T1: The nearest month contract + the next-near'
      - id: spread_issue_isin_1
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Nearby month contract in case of time spread ATM contract in case of money spread ISIN of base product contract in case of intercommodity spread'
      - id: spread_issue_isin_2
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Farther month contract in case of time spread Non-ATM contract in case of time spread ISIN of subsidiary product contract in case of intercommodity spread'
      - id: last_trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Last Trading Date'
      - id: last_payment_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Last Payment Date'
      - id: sequence_number_for_delivery_month
        type: str
        size: 3
        encoding: ASCII
        doc: 'e.g.) The nearest-month contract: 1 The next nearest-month contract: 2'
      - id: expiration_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Expiration Date'
      - id: exercise_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Exercise Price'
      - id: base_price_adjustment_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'To distinguish whether the base price of underlying asset is adjusted by integral multiple(open interest) or non-integral multiple(trading multipler) N: Normal O: Open interest C: Trading multiplier'
      - id: trading_unit
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading Unit'
      - id: trading_multiplier
        type: str
        size: 22
        encoding: ASCII
        doc: 'A multiplier used for calculating trading value and settlement'
      - id: type_of_liquidityproviding_lp
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: An issue which is not designated as a subject to the LP until the effective date. 1: An issues which is designated as a subject to the LP on the effective date 2: An issues which had been designate'
      - id: listing_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: New listing 2: Additional Listing 3: Existing Issue 4: Initial Listing 5: Adjusted Issue 6: Special Case'
      - id: atm
        type: str
        size: 11
        encoding: ASCII
        doc: 'An exercise price almost the same as base price of underlying asset'
      - id: adjustment_reason_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: Paid-in capital increase (given to the existing shareholders) 11: Paid-in capital increase (given to the third party) 12: Paid-in capital increase (by public offering) 13: Paid-in capital increase'
      - id: isin_of_underlying_asset
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN of Underlying Asset'
      - id: closing_price_of_underlying_asset
        type: str
        size: 11
        encoding: ASCII
        doc: 'Closing Price of underlying Asset'
      - id: remaining_days
        type: str
        size: 8
        encoding: ASCII
        doc: 'number of remaining days before the last trading day of derivatives'
      - id: adjusted_base_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Adjusted Base Price'
      - id: base_price_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'A code for a base price of derivatives products decided based on the condition of adjustment, transaction, theoretical value. * Futures 11: Previous day''s settlement price 12: Previous day''s base pric'
      - id: base_price_for_trading_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A 1: Regular Price 2: Price change with no trade 3: theoretical price 4: closing price of underlying asset'
      - id: previous_days_adjusted_closing_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Previous Day''s Adjusted Closing Price'
      - id: block_trading_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y: Relevant to block trading (CLASS: 3year KTB Futures, USD Futures, Euro Futures and JPY Futures) N: No relevant to block trading'
      - id: previous_days_bpmm
        type: str
        size: 23
        encoding: ASCII
        doc: 'Previous Day''s BPMM'
      - id: base_price_of_clearing_margins_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: No BPMM 11: Today''s Closing Price (regular price) 12: Today''s quote with no trade (a quote with no trade made after trade) 13: Previous day’s BPMM (no closing price after trade) 14: Today’s theore'
      - id: theoretical_settlement_price
        type: str
        size: 16
        encoding: ASCII
        doc: 'Theoretical Settlement Price'
      - id: base_theoretical_price
        type: str
        size: 16
        encoding: ASCII
        doc: 'Base Theoretical Price'
      - id: previous_days_settlement_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Previous Day’s Settlement Price'
      - id: trading_halt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Trading Halt'
      - id: futures_circuit_breakers_upper_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'high limit pirce to exercise Futures CB (If the "base price +/-5%" is the condition to exercise CB, base price +5% is high limit price) ex) 9999999999.99'
      - id: futures_circuit_breakers_lower_limit_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'low limit pirce to exercise Futures CB (If the "base price +/-5%" is the condition to exercise CB, base price -5% is low limit price) ex) 9999999999.99'
      - id: exercise_price_for_displaying_not_for_trading
        type: str
        size: 18
        encoding: ASCII
        doc: 'Exercise Price for Displaying (not for trading)'
      - id: atm_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Futures 1: ATM 2: ITM 3: OTM'
      - id: last_trading_day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to whether it is the last trading day'
      - id: dividend_value_for_settlement_price
        type: str
        size: 16
        encoding: ASCII
        doc: '- the Future value of a settlement price (Futures) - the present value of a settlement price (Options)'
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
      - id: previous_days_opening_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Previous Day''s Opening Price'
      - id: previous_days_high_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Previous Day''s High Price'
      - id: previous_days_low_price
        type: str
        size: 11
        encoding: ASCII
        doc: 'Previous Day''s Low price'
      - id: the_first_trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The First Trading Date'
      - id: the_last_trading_time
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Last Trading Time'
      - id: settlement_price_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: No settlement price 11: Today’s closing price(real trade) 12: today''s quote with no trade 13: previous day''s settled price 14: Today’s theoretical price(no closing price after traded) 15: Closing'
      - id: disparate_ratio
        type: str
        size: 13
        encoding: ASCII
        doc: 'Disparate Ratio'
      - id: previous_days_open_interest
        type: str
        size: 12
        encoding: ASCII
        doc: 'Previous Day''s Open Interest'
      - id: previous_days_best_ask
        type: str
        size: 11
        encoding: ASCII
        doc: 'Previous Day’s Best Ask'
      - id: previous_days_best_bid
        type: str
        size: 11
        encoding: ASCII
        doc: 'Previous Day’s Best Bid'
      - id: implied_volatility
        type: str
        size: 11
        encoding: ASCII
        doc: 'Implied Volatility'
      - id: the_highest_premium_of_the_lifetime
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Highest premium of the Life-time'
      - id: the_lowest_premium_of_the_lifetime
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Lowest premium of the Life-time'
      - id: the_highest_premium_in_a_year
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Highest Premium in a Year'
      - id: the_lowest_premium_in_a_year
        type: str
        size: 11
        encoding: ASCII
        doc: 'The Lowest Premium in a Year'
      - id: the_date_of_the_highest_premium_of_the_lifetime
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date of the Highest premium of the Life-time'
      - id: the_date_of_the_lowest_premium_of_the_lifetime
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date of the Lowest premium of the Life-time'
      - id: the_date_of_the_highest_premium_in_a_year
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date of the Highest Premium in a Year'
      - id: the_date_of_the_lowest_premium_in_a_year
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Date of the Lowest Premium in a Year'
      - id: number_of_listing_days_per_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of Listing Days per Year'
      - id: number_of_trading_days_per_month
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of Trading Days per Month'
      - id: number_of_trading_days_per_year
        type: str
        size: 8
        encoding: ASCII
        doc: 'Number of Trading Days per Year'
      - id: number_of_previous_days_trading
        type: str
        size: 15
        encoding: ASCII
        doc: 'Number of Previous Day''s Trading'
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
      - id: previous_days_total_accumulated_trading_volume
        type: str
        size: 15
        encoding: ASCII
        doc: 'Previous Day''s Total Accumulated Trading Volume'
      - id: previous_days_total_accumulated_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Previous Day''s Total Accumulated Trading Value'
      - id: interest_rate
        type: str
        size: 11
        encoding: ASCII
        doc: '-Equity Derivatives: a term structure of interest rate -FICC and products without a calculated theoretical price(VIX, KOSPI High Dividend 50 Futures, KOSPI Dividend Growth 50 Futures and Spreads): CD'
      - id: open_interest_limit_quantity
        type: str
        size: 15
        encoding: ASCII
        doc: 'Open Interest Limit Quantity'
      - id: underlying_asset_product_id
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset_Product ID'
      - id: offset_rate_of_asset_group
        type: str
        size: 11
        encoding: ASCII
        doc: 'Offset Rate of Asset Group'
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
      - id: efp_trading_item
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'EFP Trading Item'
      - id: flex_trading_item
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'FLEX Trading Item'
      - id: efp_trading_volume
        type: str
        size: 12
        encoding: ASCII
        doc: 'EFP Trading Volume'
      - id: efp_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'EFP Trading Value'
      - id: market_holidays
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Market Holidays'
      - id: limitation_of_dynamic_price
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Limitation of Dynamic Price'
      - id: gap_between_upper_limit_price_of_dynamic_price_and_trading_value
        type: str
        size: 11
        encoding: ASCII
        doc: 'Upper Limit Price of Dynamic Price=Previous trading price + Gap between Upper Limit Price of Dynamic Price and Trading Value'
      - id: gap_between_lower_limit_price_of_dynamic_price_and_trading_value
        type: str
        size: 11
        encoding: ASCII
        doc: 'Lower Limit Price of Dynamic Price=Previous trading price + Gap between Lower Limit Price of Dynamic Price and Trading Value'
      - id: underlying_asset_market_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset Market ID'
      - id: upper_limit_quantity
        type: str
        size: 23
        encoding: ASCII
        doc: 'Upper Limit Quantity'
      - id: lower_limit_quantity
        type: str
        size: 23
        encoding: ASCII
        doc: 'Lower Limit Quantity'
      - id: upper_limit_quantity_for_block_trade
        type: str
        size: 23
        encoding: ASCII
        doc: 'Upper Limit Quantity for Block Trade'
      - id: lower_limit_quantity_for_block_trade
        type: str
        size: 23
        encoding: ASCII
        doc: 'Lower Limit Quantity for Block Trade'
      - id: base_product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Base Product ID'
      - id: subsidiary_product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Subsidiary Product ID'
      - id: number_of_issues_for_base_product
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of Issues for Base Product'
      - id: number_of_issues_for_subsidiary_product
        type: str
        size: 6
        encoding: ASCII
        doc: 'Number of Issues for Subsidiary Product'
      - id: settlement_week
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Settlement Week'
      - id: suspended_stocks
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Suspended Stocks'
      - id: designation_date_for_suspended_stocks
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Designation Date for Suspended Stocks'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  equity_derivatives_adjustment_details_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
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
      - id: denominator_coefficient_of_adjustment
        type: str
        size: 18
        encoding: ASCII
        doc: 'Denominator Coefficient of Adjustment'
      - id: numerator_adjustment_of_coefficient
        type: str
        size: 18
        encoding: ASCII
        doc: 'Numerator Adjustment of Coefficient'
      - id: trading_multiplier_before_adjustment
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading Multiplier before Adjustment (Equity options: 10)'
      - id: trading_multiplier_after_adjustment_equity_options_10
        type: str
        size: 22
        encoding: ASCII
        doc: 'Trading Multiplier after Adjustment (Equity options: 10)'
      - id: exercise_price_before_adjustment
        type: str
        size: 18
        encoding: ASCII
        doc: 'Exercise Price before Adjustment'
      - id: exercise_price_after_adjustment
        type: str
        size: 18
        encoding: ASCII
        doc: 'Exercise Price after Adjustment'
      - id: adjustment_coefficient_of_open_intetest_volumes_that_have_been_adjusted
        type: str
        size: 6
        encoding: ASCII
        doc: 'Adjustment Coefficient of Open Intetest Volumes that have been adjusted'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  commodity_futures_settlement_reference_ktb_message:
    seq:
      - id: message_sequence_number
        type: str_8_nullable
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca. Nullable, No Value ='
      - id: application_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Application Date'
      - id: underlying_asset_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset ID of Derivatives'
      - id: ktb_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'KTB_ISIN'
      - id: isin_of_base_issue_for_payment
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN of Base Issue for Payment'
      - id: conversion_factor
        type: str
        size: 22
        encoding: ASCII
        doc: 'Conversion Factor'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_investor_activities_message:
    seq:
      - id: date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'A date of creation of data'
      - id: calculation_time_activities
        type: hhmmss_ascii_time
        doc: 'Calculation Time (HHMMSS)'
      - id: transaction_status_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Transaction Status Type Code 00: Data occurred on the previous day 01: Data occurred during the regular session 02: Confirmed Data E1: Transmission completed regular session data E2: Transmission comp'
      - id: product_id
        type: str
        size: 11
        encoding: ASCII
        pad-right: 0x20
        doc: 'Product ID'
      - id: futures_options_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: N/A C: Call Options F: Futures P: Put Options'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor Code 1000: Financial Investors 2000: Insurance Company 3000: Asset Management Company and Investment Trust Company 3100: Private Equity Fund 4000: Banks 5000: Other Financial Institutions 600'
      - id: bid_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Bid Trading Volume'
      - id: ask_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Ask Trading Volume'
      - id: bid_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Bid Trading Value(trading price*trading volume)'
      - id: ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Ask Trading Value(Trading price*trading volume)'
      - id: spread_bid_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Spread_Bid Trading volume'
      - id: spread_ask_trading_volume
        type: str
        size: 10
        encoding: ASCII
        doc: 'Spread_Ask Trading volume'
      - id: spread_bid_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Spread_Bid Trading value'
      - id: spread_ask_trading_value
        type: str
        size: 22
        encoding: ASCII
        doc: 'Spread_Ask Trading value'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  derivatives_open_interest_message:
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
      - id: open_interest_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Open Interest Type Code M0: Morning data M1: Real-time data M2: Confirmed data'
      - id: trading_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading date'
      - id: open_interest
        type: str
        size: 10
        encoding: ASCII
        doc: 'Open interest is the total number of outstanding derivative contracts, such as options or futures that have not been settled for an asset after the end of session'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  futures_settled_price_message:
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
      - id: settlement_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'Settlement Price'
      - id: settlement_price_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: No settlement price 11: Today’s closing price(real trade) 12: today''s quote with no trade 13: previous day''s settled price 14: Today’s theoretical price(no closing price after traded) 15: Closing'
      - id: the_last_settlement_price
        type: str
        size: 18
        encoding: ASCII
        doc: 'The Last Settlement Price'
      - id: last_settlement_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price of underlying asset 2: A price with calculation 3: No final settlement price 4: Special Quotation(SQ) 5: Closing price of underlying asset on a recent day (limited to equities) 6: Adj'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  options_base_price_of_clearing_margins_message:
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
      - id: base_price_of_clearing_margins
        type: str
        size: 18
        encoding: ASCII
        doc: 'Base Price of Clearing Margins'
      - id: base_price_of_clearing_margins_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '10: No BPMM 11: Today''s Closing Price (regular price) 12: Today''s quote with no trade (a quote with no trade made after trade) 13: Previous day’s BPMM (no closing price after trade) 14: Today’s theore'
      - id: settlement_price_after_exercising_an_option
        type: str
        size: 18
        encoding: ASCII
        doc: 'Settlement Price after Exercising an Option'
      - id: type_code_of_settlement_price_after_exercising_an_option
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Type Code of Settlement Price after Exercising an Option 1: KOSPI200 Closing Price Index 2: No KOSPI200 3: Sprecial Quotation 4: Adjusted closing price 5: closing price on the recent day'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  options_implied_volatility_message:
    seq:
      - id: call_averaged_implied_volatility
        type: str
        size: 11
        encoding: ASCII
        doc: 'Call_Averaged Implied Volatility'
      - id: put_averaged_implied_volatility
        type: str
        size: 11
        encoding: ASCII
        doc: 'Put_Averaged Implied Volatility'
      - id: representative_implied_volatility
        type: str
        size: 11
        encoding: ASCII
        doc: 'Representative Implied Volatility'
      - id: historical_volatility_90_days
        type: str
        size: 11
        encoding: ASCII
        doc: 'Historical Volatility (90 days)'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  options_sensitivity_message:
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
      - id: calculating_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculating Date'
      - id: calculation_time_sensitivity
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: 'Calculation Time'
      - id: implied_volatility_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Yesterday''s final data 2: Today''s temporary data 3: Today''s final data'
      - id: underlying_asset_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset ID of Derivatives'
      - id: sensitivity_delta
        type: str
        size: 20
        encoding: ASCII
        doc: 'Sensitivity Delta'
      - id: sensitivity_theta
        type: str
        size: 20
        encoding: ASCII
        doc: 'Sensitivity Theta'
      - id: sensitivity_vega
        type: str
        size: 20
        encoding: ASCII
        doc: 'Sensitivity Vega'
      - id: sensitivity_gamma
        type: str
        size: 20
        encoding: ASCII
        doc: 'Sensitivity Gamma'
      - id: sensitivity_rho
        type: str
        size: 20
        encoding: ASCII
        doc: 'Sensitivity Rho'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  commodity_futures_spot_settlement_reference_message:
    seq:
      - id: bis_announcement_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'BIS_Announcement Date'
      - id: bis_announcement_time
        type: hhmmss_ascii_time
        doc: 'BIS_Announcement Time (HHMMSS)'
      - id: underlying_asset_id
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Underlying Asset ID of Derivatives'
      - id: bis_yield_ratio
        type: str
        size: 9
        encoding: ASCII
        doc: 'BIS_Yield Ratio'
      - id: isin_of_base_issue_for_payment
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN of Base Issue for Payment'
      - id: ktb_isin
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'KTB_ISIN'
      - id: bis_time_of_inputting_yield_rate
        type: hhmm_ascii_time
        doc: 'BIS_Time of Inputting Yield Rate (HHMM or HH" ")'
      - id: end_keyword
        type: u1
        enum: end_keyword
        doc: 'End of text sentinel (0xFF)'
  daily_disclosed_rfr_message:
    seq:
      - id: base_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Risk Free Reference rate Base Date'
      - id: disclosure_type
        type: str
        size: 2
        encoding: ASCII
        doc: '1: Periodic disclosure 2 or more: Occasional disclosure'
      - id: disclosure_date
        type: str
        size: 14
        encoding: ASCII
        pad-right: 0x20
        doc: 'Disclosure date'
      - id: rfr
        type: str
        size: 9
        encoding: ASCII
        pad-right: 0x20
        doc: '999V999999 Based on the previous business day(RP settlement date) of the disclosure date'
      - id: indexed_interest_rate
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'Indexed interest rate 9999V99999999'
      - id: interest_rate_30_day
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: '30 day average interest rate 9999V99999999'
      - id: interest_rate_90_day
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: '90 day average interest rate 9999V99999999'
      - id: interest_rate_180_day
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: '180 day average interest rate 9999V99999999'
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
  str_8_nullable:
    seq:
      - id: value
        size: 8
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == "        "
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
  str_1_nullable:
    seq:
      - id: value
        size: 1
    instances:
      text:
        value: value.to_s("ASCII")
      is_null:
        value: text == " "
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

enums:
  end_keyword:
    255:
      id: 'end_of_message'
      doc: 'End Of Message'
  final_ask_bid_type_code:
    0x20:
      id: 'single_price'
      doc: 'Order Filled With Single Price'
    0x30:
      id: 'not_applicable'
      doc: 'Not Applicable'
    0x31:
      id: 'ask'
      doc: 'Ask'
    0x32:
      id: 'bid'
      doc: 'Bid'

