# ---------------------------------------------------------------------
# Kaitai struct definition for: Nextrade EtpCommon NxtBinary v2.12
#
# Protocol:
#   Organization: Nextrade
#   Protocol: Nextrade Etp Market Data Common
#   Encoding: Nextrade Binary Standard Message
#   Version: 2.12
#   Date: 08/13/2026
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
  id: nextrade_nextrade_etpcommon_nxtbinary_v2_12
  title: Nextrade EtpCommon NxtBinary v2.12
  license: GPL-3.0
  endian: le

doc: 'Nextrade Nextrade Nextrade Etp Market Data Common NxtBinary v2.12'
doc-ref: https://nextrade.co.kr/en/main.do

seq:
  - id: tr_code
    type: str
    size: 5
    encoding: ASCII
    pad-right: 0x20
    doc: 'Five-character Ascii TR-CODE identifying the disseminated market data record. Formed by concatenating a 2-character Data Category naming the message family (e.g. "B6" Quote, "A3" Order Filled, "G7" Order Filled plus Quote, "A7" Market Operation TS, "A0" Equities Batch) with a 3-character Information Category naming the market or product variant, typically a 2-digit information code plus a 1-character market code (e.g. "51S" = KOSPI stock, "51Q" = KOSDAQ stock, "53S" = exchange traded product)'
  - id: payload
    type:
      switch-on: tr_code
      cases:
        '"I2500"': polling_data_message
        '"B753S"': securities_quote_mm_lp_quotes_included_10_level_message
        '"A353S"': securities_order_filled_message
        '"A753S"': market_operation_ts_message
        '"A653S"': issue_closing_message
        '"R853S"': triggering_removing_vi_message
        '"E153S"': closing_price_trading_quote_message
        '"B253S"': equities_snapshot_mm_lp_quotes_included_10_level_message
        '"IC53S"': investor_activities_per_commodities_message
        '"V650S"': etp_constituents_message
        '"EA50S"': etp_constituents_message
        '"I753S"': mm_lp_information_message
        '"EB53S"': mm_lp_information_message
        '"M453S"': market_operation_schedule_message
        '"R350S"': member_firm_imposing_lifting_sanctions_message
        '"B953S"': top_five_traders_activities_message
        '"A053S"': equities_batch_data_message
        '"E053S"': equities_batch_data_message
        '"M950S"': member_information_message
        '"E850S"': member_information_message
        '"I653S"': issue_event_message
        '"E653S"': issue_event_message
        '"C453S"': block_basket_trade_data_message
        '"C153S"': investor_activities_per_an_issue_eod_message
        '"I853S"': short_selling_message
        '"E253S"': brokers_acitity_information_message
        '"E353S"': trading_activity_by_session_per_an_issue_message

types:
  polling_data_message:
    seq:
      - id: current_time_1_minute_interval
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Current Time (1-minute interval)'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  securities_quote_mm_lp_quotes_included_10_level_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: processing_time_of_trading_system
        type: hhmmssuuuuuu_ascii_time
        doc: 'HHMMSSuuuuuu'
      - id: ask_level_1_price
        size: 8
        doc: 'The best ask'
      - id: bid_level_1_price
        size: 8
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: s8
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: s8
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: s8
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: s8
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        size: 8
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        size: 8
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: s8
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: s8
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: s8
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: s8
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        size: 8
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        size: 8
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: s8
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: s8
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: s8
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: s8
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        size: 8
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        size: 8
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: s8
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: s8
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: s8
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: s8
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        size: 8
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        size: 8
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: s8
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: s8
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: s8
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: s8
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        size: 8
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        size: 8
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: s8
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: s8
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: s8
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: s8
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        size: 8
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        size: 8
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: s8
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: s8
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: s8
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: s8
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        size: 8
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        size: 8
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: s8
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: s8
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: s8
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: s8
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        size: 8
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        size: 8
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: s8
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: s8
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: s8
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: s8
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        size: 8
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        size: 8
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: s8
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: s8
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: s8
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: s8
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: s8
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: s8
        doc: 'Total bid volume'
      - id: estimated_trading_price
        size: 8
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: s8
        doc: 'An estimated trading volume before the single price trade session'
      - id: mid_price
        size: 8
        doc: 'Average price of NXT BBO with midpoint quote effectiveness(truncation of decimal places)'
      - id: total_mid_price_ask_volume_total_ask_volume_on_mid_price
        type: s8
        doc: 'Total quantity of ask midpoint quotes'
      - id: total_mid_price_bid_volume_total_bid_volume_on_mid_price
        type: s8
        doc: 'Total quantity of bid midpoint quotes'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  securities_order_filled_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
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
        size: 8
        doc: 'A Price change against the previous day'
      - id: trading_price
        size: 8
        doc: 'The price at which a security is traded between ask and bid quotes'
      - id: trading_volume
        type: s8
        doc: 'Trading volume'
      - id: opening_price
        size: 8
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        size: 8
        doc: 'The highest price during the course of a trading day'
      - id: todays_low
        size: 8
        doc: 'The highest price during the course of a trading day'
      - id: accumulated_trading_volume
        type: s8
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        size: 16
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price. 0: N/A 1: ASK 2: BID'
      - id: lp_holding_quantity
        type: s8
        doc: 'LP holding quantity per each account'
      - id: the_best_ask
        size: 8
        doc: 'The lowest price among the ask quotes'
      - id: the_best_bid
        size: 8
        doc: 'The highest price among the bid quotes'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  market_operation_ts_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
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
        type: s4
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (not a unit trading issue) 8: Uni'
      - id: trading_halt_reason_code
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
        doc: 'Trading Halt Reason Code X01: Market Administrative from NXT X99: Request from KRX 1XX~301: KOSPI 6XX: KOSDAQ'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  issue_closing_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: closing_price
        size: 8
        doc: 'Closing price on the day''s regular session. However, for G3 board, the closing price of KRX is set'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 3: No Trades'
      - id: upper_limit_price_on_the_single_price_trade_in_the_off_hours_session
        size: 8
        doc: 'Upper Limit Price on the Single Price Trade in the Off-Hours Session'
      - id: lower_limit_price_on_the_single_price_trade_in_the_off_hours_session
        size: 8
        doc: 'Lower Limit Price on the Single Price in the Off-Hours Session'
      - id: closing_price_weighted_stock_price_average
        size: 8
        doc: 'Weighted Average is calculated by adding up an issue''s aggregated market value, which is part of a certain index or markets, and dividing it with the total shares listed. - Weighted Stock Price Averag'
      - id: closing_price_base_price_of_buy_in
        size: 8
        doc: 'Closing Price_Base Price of Buy-In'
      - id: closing_price_upper_limit_of_buy_in
        size: 8
        doc: 'Closing Price_Upper Limit of Buy-In'
      - id: closing_price_lower_limit_of_buy_in
        size: 8
        doc: 'Closing Price_Lower Limit of Buy-In'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  triggering_removing_vi_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
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
        doc: 'A code to distinguish static VI or dynamic VI 1: Static VI 2: Dynamic VI 3: Static/Dynamic VI 4. Extended VI'
      - id: a_base_price_to_trigger_static_vi
        size: 8
        doc: 'A Base Price to trigger Static VI - if there is no previous single-price (call auction) execution price, base price is set'
      - id: a_base_price_to_trigger_dynamic_vi
        size: 8
        doc: 'A Base Price to trigger dynamic VI'
      - id: vi_triggering_price
        size: 8
        doc: 'A price to trigger VI'
      - id: disparate_ratio_to_trigger_static_vi
        size: 8
        doc: 'A disparate ratio of a base price to an expected price to trigger static VI'
      - id: disparate_ratio_to_trigger_dynamic_vi
        size: 8
        doc: 'A disparate ratio of a previously traded price to an expected price to trigger dynamic VI'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  closing_price_trading_quote_message:
    seq:
      - id: message_sequence_number
        type: s4
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: total_ask_volume
        type: s8
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: s8
        doc: 'Total bid volume'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  equities_snapshot_mm_lp_quotes_included_10_level_message:
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: price_change_against_previous_day
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '0: Mark Impossible 1:high limit 2:ascended 3:unchanged 4:low limit 5:declined'
      - id: a_price_change_against_the_previous_day
        size: 8
        doc: 'A Price change against the previous day'
      - id: upper_limit_price
        size: 8
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        size: 8
        doc: 'A price subtracting the price limit from the base price'
      - id: current_price
        size: 8
        doc: 'The last traded price at the current page'
      - id: opening_price
        size: 8
        doc: 'The first price that a security traded upon the opening of the regular session'
      - id: todays_high
        size: 8
        doc: 'The highest price during the course of a trading day'
      - id: todays_low
        size: 8
        doc: 'The highest price during the course of a trading day'
      - id: accumulated_trading_volume
        type: s8
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        size: 16
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: final_ask_bid_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Ask/Bid Type Code space: order filled with single price. 0: N/A 1: ASK 2: BID'
      - id: ask_level_1_price
        size: 8
        doc: 'The best ask'
      - id: bid_level_1_price
        size: 8
        doc: 'The best bid'
      - id: ask_level_1_volume
        type: s8
        doc: 'The best ask volume'
      - id: bid_level_1_volume
        type: s8
        doc: 'The best bid volume'
      - id: lp_ask_level_1_volume
        type: s8
        doc: 'LP_The best ask volume'
      - id: lp_bid_level_1_volume
        type: s8
        doc: 'LP_The best bid volume'
      - id: ask_level_2_price
        size: 8
        doc: 'The second highest ask price'
      - id: bid_level_2_price
        size: 8
        doc: 'The second lowest bid price'
      - id: ask_level_2_volume
        type: s8
        doc: 'The second highest ask volume'
      - id: bid_level_2_volume
        type: s8
        doc: 'The second lowest bid volume'
      - id: lp_ask_level_2_volume
        type: s8
        doc: 'LP_The second highest ask volume'
      - id: lp_bid_level_2_volume
        type: s8
        doc: 'LP_The second lowest bid volume'
      - id: ask_level_3_price
        size: 8
        doc: 'The third highest ask price'
      - id: bid_level_3_price
        size: 8
        doc: 'The third lowest bid price'
      - id: ask_level_3_volume
        type: s8
        doc: 'The third highest ask volume'
      - id: bid_level_3_volume
        type: s8
        doc: 'The third lowest bid volume'
      - id: lp_ask_level_3_volume
        type: s8
        doc: 'LP_The third highest ask volume'
      - id: lp_bid_level_3_volume
        type: s8
        doc: 'LP_The third lowest bid volume'
      - id: ask_level_4_price
        size: 8
        doc: 'The fourth highest ask price'
      - id: bid_level_4_price
        size: 8
        doc: 'The fourth lowest bid price'
      - id: ask_level_4_volume
        type: s8
        doc: 'The fourth highest ask volume'
      - id: bid_level_4_volume
        type: s8
        doc: 'The fourth lowest bid volume'
      - id: lp_ask_level_4_volume
        type: s8
        doc: 'LP_The fourth highest ask volume'
      - id: lp_bid_level_4_volume
        type: s8
        doc: 'LP_The fourth lowest bid volume'
      - id: ask_level_5_price
        size: 8
        doc: 'The fifth highest ask price'
      - id: bid_level_5_price
        size: 8
        doc: 'The fifth lowest bid price'
      - id: ask_level_5_volume
        type: s8
        doc: 'The fifth highest ask volume'
      - id: bid_level_5_volume
        type: s8
        doc: 'The fifth lowest bid volume'
      - id: lp_ask_level_5_volume
        type: s8
        doc: 'LP_The fifth highest ask volume'
      - id: lp_bid_level_5_volume
        type: s8
        doc: 'LP_The fifth lowest bid volume'
      - id: ask_level_6_price
        size: 8
        doc: 'The sixth highest ask price'
      - id: bid_level_6_price
        size: 8
        doc: 'The sixth lowest bid price'
      - id: ask_level_6_volume
        type: s8
        doc: 'The sixth highest ask volume'
      - id: bid_level_6_volume
        type: s8
        doc: 'The sixth lowest bid volume'
      - id: lp_ask_level_6_volume
        type: s8
        doc: 'LP_The sixth highest ask volume'
      - id: lp_bid_level_6_volume
        type: s8
        doc: 'LP_The sixth lowest bid volume'
      - id: ask_level_7_price
        size: 8
        doc: 'The seventh highest ask price'
      - id: bid_level_7_price
        size: 8
        doc: 'The seventh lowest bid price'
      - id: ask_level_7_volume
        type: s8
        doc: 'The seventh highest ask volume'
      - id: bid_level_7_volume
        type: s8
        doc: 'The seventh lowest bid volume'
      - id: lp_ask_level_7_volume
        type: s8
        doc: 'LP_The seventh highest ask volume'
      - id: lp_bid_level_7_volume
        type: s8
        doc: 'LP_The seventh lowest bid volume'
      - id: ask_level_8_price
        size: 8
        doc: 'The eighth highest ask price'
      - id: bid_level_8_price
        size: 8
        doc: 'The eighth lowest bid price'
      - id: ask_level_8_volume
        type: s8
        doc: 'The eighth highest ask volume'
      - id: bid_level_8_volume
        type: s8
        doc: 'The eighth lowest bid volume'
      - id: lp_ask_level_8_volume
        type: s8
        doc: 'LP_The eighth highest ask volume'
      - id: lp_bid_level_8_volume
        type: s8
        doc: 'LP_The eighth lowest bid volume'
      - id: ask_level_9_price
        size: 8
        doc: 'The ninth highest ask price'
      - id: bid_level_9_price
        size: 8
        doc: 'The ninth lowest bid price'
      - id: ask_level_9_volume
        type: s8
        doc: 'The ninth highest ask volume'
      - id: bid_level_9_volume
        type: s8
        doc: 'The ninth lowest bid volume'
      - id: lp_ask_level_9_volume
        type: s8
        doc: 'LP_The ninth highest ask volume'
      - id: lp_bid_level_9_volume
        type: s8
        doc: 'LP_The ninth lowest bid volume'
      - id: ask_level_10_price
        size: 8
        doc: 'The tenth highest ask price'
      - id: bid_level_10_price
        size: 8
        doc: 'The tenth lowest bid price'
      - id: ask_level_10_volume
        type: s8
        doc: 'The tenth highest ask volume'
      - id: bid_level_10_volume
        type: s8
        doc: 'The tenth lowest bid volume'
      - id: lp_ask_level_10_volume
        type: s8
        doc: 'LP_The tenth highest ask volume'
      - id: lp_bid_level_10_volume
        type: s8
        doc: 'LP_The tenth lowest bid volume'
      - id: total_ask_volume
        type: s8
        doc: 'Total ask volume'
      - id: total_bid_volume
        type: s8
        doc: 'Total bid volume'
      - id: estimated_trading_price
        size: 8
        doc: 'An estimated trading price before the single price trade session'
      - id: estimated_trading_volume
        type: s8
        doc: 'An estimated trading volume before the single price trade session'
      - id: closing_price_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Closing price 3: No Trades'
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
      - id: mid_price
        size: 8
        doc: 'Average price of NXT BBO with midpoint quote effectiveness(truncation of decimal places)'
      - id: total_mid_price_ask_volume_total_ask_volume_on_mid_price
        type: s8
        doc: 'Total quantity of ask midpoint quotes'
      - id: total_mid_price_bid_volume_total_bid_volume_on_mid_price
        type: s8
        doc: 'Total quantity of bid midpoint quotes'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  investor_activities_per_commodities_message:
    seq:
      - id: calculation_time
        type: hhmmss_ascii_time
        doc: 'Calculation Time (HHMMSS)'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor code 1000: Financial Investment 2000: Insurance 3000: Investment Trust 3100: Private Placement 4000: Bank 5000: Other Finance 6000: Pension Fund 7000: Unclassified 7100: Other Corporation 800'
      - id: accumulated_ask_trading_volume
        type: s8
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        size: 16
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: s8
        doc: 'Accumulated Bid Trading Volume'
      - id: accumulated_bid_trading_value
        size: 16
        doc: 'Accumulated Bid Trading Value'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  etp_constituents_message:
    seq:
      - id: message_sequence_number
        type: s4
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: index_calculation_institution_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Calculation Institution_Type Code 01: KRX 02: FnGuide 03: SP 04: KIS Pricing 05: MSCI 06: CSI 07: Korean Asset Pricing(KAP) 08: WiseFn 09: HangSeng 10: TSE(Tokyo Stock Exchange) 11: Markit 12: S'
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
        doc: 'Index Leverage/Inverse_Type Code'
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
        doc: 'Filler'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  mm_lp_information_message:
    seq:
      - id: message_sequence_number
        type: s4
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
        doc: 'Market Participant Number'
      - id: board_id
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'The Board ID refers to each Board in which an issue is traded under different trading schedules and rules. Individual issue can be traded on more than two Boards under each Board''s schedule and with d'
      - id: market_making_lp_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'M: Market making L: Liquidity provider'
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
        type: s8
        doc: 'Minimum number of trading unit for LP/MM placing an order Eg) If the value is 10 and trading_x000D_ unit is 10 shares, LP/MM Quote should be_x000D_ more than 100 shares (Contract)'
      - id: maximum_volume_of_multiple_order
        type: s8
        doc: 'Maximum number of trading unit for LP/MM placing an order'
      - id: bid_ask_spread_unit_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'R: Price Ratio Y: Yield Ratio T: Tick'
      - id: main_market_bid_ask_spread_value
        size: 16
        doc: 'The bid-ask spread interval or ratio at which MM/LP quoting obligations apply in the main market'
      - id: spread_multiple_for_market_holidays
        type: s8
        doc: 'In case the underlying assets for Derivatives, ELW, ETF are indices or issues of foreign market, when the present value of tracking assets is unable to be judged because of the holiday, pre-hours sess'
      - id: an_obligatory_time_interval_to_place_an_order
        type: s4
        doc: 'A time interval that a market maker should obey between placing an bid/ask order. Unit: Sec'
      - id: minimum_ask_price
        size: 16
        doc: 'LP_Minimum ask price'
      - id: maximum_bid_price
        size: 16
        doc: 'LP_Maximum bid price'
      - id: minimum_order_price
        size: 16
        doc: 'A minimum order price for Block/Basket Trading. (Block: 100 million KRW, Basket: more than 1 billion KRW)'
      - id: maximum_order_price
        size: 16
        doc: 'Maximum Order Price'
      - id: extended_market_bid_ask_spread_value
        size: 16
        doc: 'The bid-ask spread interval or ratio at which LP/MM quoting obligations apply in extended markets (Pre-Market/After-Market)'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
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
        type: s4
        doc: 'Board Event Group Code (Bitwise operation) ▦▦ Code ▦▦ 1: A regular Issue (not an issue on the last trading day) 2: An issue on the Last trading day 4: A regular issue (not a unit trading issue) 8: Uni'
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
        doc: 'Trading Halt Reason Code X01: Market Administrative from NXT X99: Request from KRX 1XX~301: KOSPI 6XX: KOSDAQ'
      - id: trading_halt_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: '1: Treasury Stock 2: Warrant 3: Right 4: Underlying Asset ELW 5: Issue ELW 6: Listed Company 7: Underlying Asset Applied Market 8: Index(not using) 9: Issue ETN'
      - id: step_applied
        type: s4
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
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  member_firm_imposing_lifting_sanctions_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
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
        type: s4
        doc: 'Allowance or sanctions for member''s trading. Bitwise operation. 1: Ask Trust 2: Ask Principal 4: Bid Trust 8: Bid Principal'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  top_five_traders_activities_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: member_number_1_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 1 among Top Five Members for Ask'
      - id: ask_trading_volume_1
        type: s8
        doc: 'Trading Volume from Member Number 1 among Top Five Members for Ask'
      - id: ask_trading_value_1
        size: 16
        doc: 'Trading Value from Member Number 1 among Top Five Members for Ask'
      - id: member_number_1_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 1 among Top Five Members for Bid'
      - id: bid_trading_volume_1
        type: s8
        doc: 'Trading Volume from Member Number 1 among Top Five Members for Bid'
      - id: bid_trading_value_1
        size: 16
        doc: 'Trading Value from Member Number 1 among Top Five Members for Bid'
      - id: member_number_2_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 2 among Top Five Members for Ask'
      - id: ask_trading_volume_2
        type: s8
        doc: 'Trading Volume from Member Number 2 among Top Five Members for Ask'
      - id: ask_trading_value_2
        size: 16
        doc: 'Trading Value from Member Number 2 among Top Five Members for Ask'
      - id: member_number_2_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 2 among Top Five Members for Bid'
      - id: bid_trading_volume_2
        type: s8
        doc: 'Trading Volume from Member Number 2 among Top Five Members for Bid'
      - id: bid_trading_value_2
        size: 16
        doc: 'Trading Value from Member Number 2 among Top Five Members for Bid'
      - id: member_number_3_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 3 among Top Five Members for Ask'
      - id: ask_trading_volume_3
        type: s8
        doc: 'Trading Volume from Member Number 3 among Top Five Members for Ask'
      - id: ask_trading_value_3
        size: 16
        doc: 'Trading Value from Member Number 3 among Top Five Members for Ask'
      - id: member_number_3_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 3 among Top Five Members for Bid'
      - id: bid_trading_volume_3
        type: s8
        doc: 'Trading Volume from Member Number 3 among Top Five Members for Bid'
      - id: bid_trading_value_3
        size: 16
        doc: 'Trading Value from Member Number 3 among Top Five Members for Bid'
      - id: member_number_4_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 4 among Top Five Members for Ask'
      - id: ask_trading_volume_4
        type: s8
        doc: 'Trading Volume from Member Number 4 among Top Five Members for Ask'
      - id: ask_trading_value_4
        size: 16
        doc: 'Trading Value from Member Number 4 among Top Five Members for Ask'
      - id: member_number_4_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 4 among Top Five Members for Bid'
      - id: bid_trading_volume_4
        type: s8
        doc: 'Trading Volume from Member Number 4 among Top Five Members for Bid'
      - id: bid_trading_value_4
        size: 16
        doc: 'Trading Value from Member Number 4 among Top Five Members for Bid'
      - id: member_number_5_for_ask
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 5 among Top Five Members for Ask'
      - id: ask_trading_volume_5
        type: s8
        doc: 'Trading Volume from Member Number 5 among Top Five Members for Ask'
      - id: ask_trading_value_5
        size: 16
        doc: 'Trading Value from Member Number 5 among Top Five Members for Ask'
      - id: member_number_5_for_bid
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'Member Number 5 among Top Five Members for Bid'
      - id: bid_trading_volume_5
        type: s8
        doc: 'Trading Volume from Member Number 5 among Top Five Members for Bid'
      - id: bid_trading_value_5
        size: 16
        doc: 'Trading Value from Member Number 5 among Top Five Members for Bid'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  equities_batch_data_message:
    seq:
      - id: message_sequence_number
        type: s4
        doc: 'A message sequence number given by Market data team - Market data: seq number is given by instruments and boards (※ only for high-bandwidth service) - Batch Data: seq number is given by Information Ca'
      - id: total_number_of_instruments_of_the_contract
        type: s4
        doc: 'Total number of instruments per each Information Category'
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
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
      - id: unit_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Unit Trading. (Possibility of Unit trading during the regular session in order)'
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
        size: 8
        doc: 'A base price of a day. A base price to calculate a upper/lower price'
      - id: yesterdays_closing_price_type_code_krx
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Yesterday''s Closing Price_Type Code (KRX) 1: Regular closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: yesterdays_closing_price_krx
        size: 8
        doc: 'Yesterday''s Closing Price (KRX)'
      - id: yesterdays_accumulated_trading_amount
        type: s8
        doc: 'Yesterday''s Accumulated Trading Amount'
      - id: yesterdays_accumulated_trading_value
        size: 16
        doc: 'Yesterday''s Accumulated Trading Value'
      - id: upper_limit_price
        size: 8
        doc: 'A price adding up the price limit to the base price'
      - id: lower_limit_price
        size: 8
        doc: 'A price subtracting the price limit from the base price'
      - id: substitute_price_of_securities
        size: 8
        doc: 'Substitute price of securities as a consignment gurantee money'
      - id: par_value
        size: 8
        doc: 'Par Value'
      - id: issuing_price
        size: 8
        doc: 'Issuing price'
      - id: listing_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Listing Date of derivatives(CLASS) or issues'
      - id: number_of_listed_shares
        type: s8
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
        size: 8
        doc: 'Exercise Price of ELW or BW'
      - id: capital
        size: 16
        doc: 'Capital'
      - id: credit_order_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to Credit Order Possibility'
      - id: limit_order_permission_type_code
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill)'
      - id: market_price_order_permission_type_code
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill)'
      - id: conditioned_order_permission_type_code
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill)'
      - id: best_favorable_order_permission_type_code
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill)'
      - id: first_best_order_permission_type
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill)'
      - id: mid_price_order_permission_type_code
        type: s4
        doc: 'Bitwise opration 1: FAS (Fill And Stay) 2: FOK (Fill Or Kill) 4: FAK (Fill And Kill) 8: GTS (Good for the Session) 16: GTC (Good Till Cancel) 32: GTD (Good Till Date)'
      - id: stop_limit_price_order_permission_type_code
        type: s4
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
        size: 8
        doc: 'An appraised price is a base price of an Issue of which base price is settled with today''s single price, and it determines an upper/lower limit price for its opening price'
      - id: lowest_order_price
        size: 8
        doc: 'An lower limit price of an issue of which base price is settled with today''s single price'
      - id: highest_order_price
        size: 8
        doc: 'An upper limit price of an issue of which base price is settled with today''s single price'
      - id: unit_of_volume_in_main_board
        type: s8
        doc: 'Unit of Volume in Main Board'
      - id: lot_size_afterhours_trading
        type: s8
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
        doc: 'Closing Price Trading Possibility in the After Hours'
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
        size: 8
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
        doc: '0: N/A 1: Non-taxation changed 2: Dividend Income Tax(Holding Period Tax) 3: Securities transaction tax(Corporate Type ETF) 4: Dividend Income Tax(Foreign Stock Investment ETF) 5: Dividend Income Tax('
      - id: appraisal_ratio_of_substitute_price
        size: 8
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
        doc: 'ETF''s underlying assets replication methods type code P:Physical Replication S:Synthetic Replication A:Active'
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
        doc: 'Distribution Type Code 01: Unpaid 02: Paid(indicative value is applied) 03: Paid(indicative value is not applied) 04: Paid(reinvestment) 05: Paid(others)'
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
        doc: 'ETP Product Type Code 1. ETF(Investment Company type) 2. ETF(Beneficiary Fund type) 3. ETN 4. Stop-Loss ETN'
      - id: index_calculation_institution_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Index Calculation Institution_Type Code 01: KRX 02: FnGuide 03: SP 04: KIS Pricing 05: MSCI 06: CSI 07: Korean Asset Pricing(KAP) 08: WiseFn 09: HangSeng 10: TSE(Tokyo Stock Exchange) 11: Markit 12: S'
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
        doc: '## Code Value ## P1: General (1) P2: 2X Leverage (2) P3: 3X Leverage (3) PA: 0.5X Leverage (0.5) PB: 1.5X Leverage (1.5) PC: 2.5X Leverage (2.5) N1: 1X Inverse (-1) N2: 2X Inverse (-2) N3: 2X Inverse'
      - id: reference_index_leverage_inverse_type_code
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: '## Code Value ## P1: General (1) P2: 2X Leverage (2) P3: 3X Leverage (3) PA: 0.5X Leverage (0.5) PB: 1.5X Leverage (1.5) PC: 2.5X Leverage (2.5) N1: 1X Inverse (-1) N2: 2X Inverse (-2) N3: 2X Inverse'
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
        doc: 'LP Order'
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
        size: 16
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
        doc: 'Preferred Stocks with lesser shares'
      - id: spac_merger
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'SPAC Merger'
      - id: segment_type_code
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Segment type code'
      - id: after_market_possibility
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N to after-market possibility'
      - id: choice_on_competitive_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Information whether it is selected issue for trading on competitive trading'
      - id: limit_on_competitive_trading_volume
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Information whether the trading limit for the issue on competitive trading has been reached, resulting in trading restriction'
      - id: occurrence_of_reasons_prohibiting_competitive_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Information whether events prohibiting trading on the competitive trading board have occurred'
      - id: approval_on_competitive_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Final approval for trading on the competitive trading board'
      - id: approval_on_negotiation_trading
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Final approval for trading on the negotiation trading board'
      - id: yesterdays_closing_price_type_code_nxt
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Yesterday''s Closing Price_Type Code (NXT) 1: Regular closing price 2: Quotation 3: No Trades 4: Quotation of an Issue of which base price is settled with a today''s single price'
      - id: yesterdays_closing_price_nxt
        size: 8
        doc: 'Yesterday''s Closing Price (NXT)'
      - id: competition_board_trade_permission_code
        type: s4
        doc: 'Definition of tradable sessions on the competitive trading boards.(Bitwise operation) 1: Pre Market 2: Main Market 4: After Market 8: Closing Price Board'
      - id: negotiation_possible_or_not_before_main_market
        type: str
        size: 1
        encoding: ASCII
        pad-right: 0x20
        doc: 'Y/N on whether Negotiation Trading is allowed before the main-market opens'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  member_information_message:
    seq:
      - id: message_sequence_number
        type: s4
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
        doc: 'Market Participant Number'
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
        doc: 'An Abbreviated Name of a Market Participant in KR'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  issue_event_message:
    seq:
      - id: message_sequence_number
        type: s4
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
        doc: 'Event Reason Code'
      - id: event_start_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Event Start Date'
      - id: event_end_date
        type: str
        size: 8
        encoding: ASCII
        pad-right: 0x20
        doc: 'Event End Date'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  block_basket_trade_data_message:
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
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: accumulated_trading_volume
        type: s8
        doc: 'Accumulated Trading Volume'
      - id: accumulated_trading_value
        size: 16
        doc: 'Accumulated trading value Trading value=trading amount*trading price'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  investor_activities_per_an_issue_eod_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: a_designated_number_for_an_issue_from_krx
        type: s4
        doc: 'A designated number for each issue on a daily basis from KRX'
      - id: investor_code
        type: str
        size: 4
        encoding: ASCII
        pad-right: 0x20
        doc: 'Investor code 1000: Financial Investment 2000: Insurance 3000: Investment Trust 3100: Private Placement 4000: Bank 5000: Other Finance 6000: Pension Fund 7000: Unclassified 7100: Other Corporation 800'
      - id: accumulated_ask_trading_volume
        type: s8
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        size: 16
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: s8
        doc: 'Accumulated Bid Trading Volume'
      - id: accumulated_bid_trading_value
        size: 16
        doc: 'Accumulated Bid Trading Value'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  short_selling_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: covered_short_selling_trading_volume
        type: s8
        doc: 'Covered Short Selling_Trading Volume'
      - id: covered_short_selling_trading_value
        size: 16
        doc: 'Covered Short Selling_Trading Value'
      - id: uptick_rule_applied_covered_short_selling_trading_volume
        type: s8
        doc: 'Uptick Rule Applied Covered Short Selling Trading Volume'
      - id: uptick_rule_applied_covered_short_selling_trading_value
        size: 16
        doc: 'Uptick Rule Applied Covered Short Selling Trading Value'
      - id: uptick_rule_unapplied_covered_short_selling_trading_volume
        type: s8
        doc: 'Uptick Rule Unapplied Covered Short Selling Trading Volume'
      - id: uptick_rule_unapplied_covered_short_selling_trading_value
        size: 16
        doc: 'Uptick Rule Unapplied Covered Short Selling Trading Value'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  brokers_acitity_information_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: member_number
        type: str
        size: 5
        encoding: ASCII
        pad-right: 0x20
        doc: 'A designated number for each member firm'
      - id: accumulated_ask_trading_volume
        type: s8
        doc: 'Accumulated Ask Trading Volume'
      - id: accumulated_ask_trading_value
        size: 16
        doc: 'Accumulated Ask Trading Value'
      - id: accumulated_bid_trading_volume
        type: s8
        doc: 'Accumulated Bid Trading Volume'
      - id: accumulated_bid_trading_value
        size: 16
        doc: 'Accumulated Bid Trading Value'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
  trading_activity_by_session_per_an_issue_message:
    seq:
      - id: isin_code
        type: str
        size: 12
        encoding: ASCII
        pad-right: 0x20
        doc: 'ISIN Code'
      - id: total_number_of_tradable_issues_on_competitive_trading
        type: s4
        doc: 'Total number of tradable issues on Competitive Trading'
      - id: premarket_accumulated_trading_volume
        type: s8
        doc: 'Pre-market accumulated trading volume in the Regular market'
      - id: premarket_accumulated_trading_value
        size: 16
        doc: 'Pre-market accumulated trading value in the Regular market'
      - id: mainmarket_accumulated_trading_volume
        type: s8
        doc: 'Main-market accumulated trading volume in the Regular market'
      - id: mainmarket_accumulated_trading_value
        size: 16
        doc: 'Main-market accumulated trading value in the Regular market'
      - id: aftermarket_accumulated_trading_volume
        type: s8
        doc: 'After-market accumulated trading volume in the Regular market'
      - id: aftermarket_accumulated_trading_value
        size: 16
        doc: 'After-market accumulated trading value in the Regular market'
      - id: end_keyword
        type: s4
        doc: 'A keyword indicating the end of a message. (%HFF) * Data type is Int for Binary'
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

