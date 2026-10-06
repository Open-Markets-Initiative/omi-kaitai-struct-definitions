# ---------------------------------------------------------------------
# Kaitai struct definition for: Nextrade Stock10Level NxtBinary v2.12
#
# Protocol:
#   Organization: Nextrade
#   Protocol: Nextrade Stock Market Data 10 Level
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
  id: nextrade_nextrade_stock10level_nxtbinary_v2_12
  title: Nextrade Stock10Level NxtBinary v2.12
  license: GPL-3.0
  endian: le

doc: 'Nextrade Nextrade Nextrade Stock Market Data 10 Level NxtBinary v2.12'
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
        '"B651S"': securities_quote_10_level_message
        '"B651Q"': securities_quote_10_level_message
        '"A351S"': securities_order_filled_message
        '"A351Q"': securities_order_filled_message
        '"A751S"': market_operation_ts_message
        '"A751Q"': market_operation_ts_message
        '"A651S"': issue_closing_message
        '"A651Q"': issue_closing_message
        '"R851S"': triggering_removing_vi_message
        '"R851Q"': triggering_removing_vi_message
        '"E151S"': closing_price_trading_quote_message
        '"E151Q"': closing_price_trading_quote_message

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
  securities_quote_10_level_message:
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
      - id: total_ask_volume
        type: s8
        doc: 'Total ask volume on Closing Price Trading'
      - id: total_bid_volume
        type: s8
        doc: 'Total bid volume on Closing Price Trading'
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
        doc: '0: Initial value 1:high limit 2:ascended 3:unchanged 4:low limit 5:declined'
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
        doc: 'The lowest price during the course of a trading day'
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
        doc: '1: Closing price 3: No Trades Closing price type code of NXT is set on each board'
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
        doc: 'Total ask volume on Closing Price Trading'
      - id: total_bid_volume
        type: s8
        doc: 'Total bid volume on Closing Price Trading'
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

