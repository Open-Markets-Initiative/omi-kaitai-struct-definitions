# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.12
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vender Feed
#   Version: 1.12
#   Date: 3/23/2018
#   Specification: hsvf-mx-005e-mx-sola-hsvf-multicast-specifications-guide-v1-12-2.pdf
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
  id: tmx_mx_solamulticast_hsvf_v1_12
  title: Tmx Mx SolaMulticast Hsvf v1.12
  license: GPL-3.0
  endian: be

doc: 'TMX Group Montreal Exchange Sola Multicast Hsvf v1.12'
doc-ref: https://www.tmxwebstore.com

seq:
  - id: hsvf_stx
    type: u1
    doc: 'Start of Hsvf message'
  - id: message_header
    type: message_header_struct
    doc: 'Hsvf Udp Market Data Packet Header'
  - id: message_body
    type:
      switch-on: message_header.message_type
      cases:
        '"LI"': login_message
        '"RT"': retransmission_request_message
        '"ER"': error_message_message
        '"C"': option_trade_message
        '"CB"': future_options_trade_message
        '"CF"': futures_trade_message
        '"CS"': strategy_trade_message
        '"D"': option_request_for_quote_rfq_message
        '"DB"': future_options_request_for_quote_rfq_message
        '"DF"': futures_request_for_quote_rfq_message
        '"DS"': strategy_request_for_quote_rfq_message
        '"E"': instrument_schedule_notice_option_message
        '"EB"': instrument_schedule_notice_futures_option_message
        '"EF"': instrument_schedule_notice_future_message
        '"ES"': instrument_schedule_notice_strategy_message
        '"F"': option_quote_message
        '"FB"': future_options_quote_message
        '"FF"': futures_quote_message
        '"FS"': strategy_quote_message
        '"H"': option_market_depth_message
        '"HB"': future_options_market_depth_message
        '"HF"': futures_market_depth_message
        '"HS"': strategy_market_depth_message
        '"I"': option_trade_cancellation_message
        '"IB"': future_options_trade_cancellation_message
        '"IF"': futures_trade_cancellation_message
        '"IS"': strategy_trade_cancellation_message
        '"J"': option_instrument_keys_message
        '"JB"': future_options_instrument_keys_message
        '"JE"': underlying_instrument_keys_message
        '"JF"': futures_instrument_keys_message
        '"JS"': strategy_instrument_keys_message
        '"N"': option_summary_message
        '"NB"': future_options_summary_message
        '"NF"': futures_summary_message
        '"NS"': strategy_summary_message
        '"Q"': beginning_of_options_summary_message
        '"QB"': beginning_of_future_options_summary_message
        '"QF"': beginning_of_futures_summary_message
        '"QS"': beginning_of_strategy_summary_message
        '"XF"': futures_trade_correction_message
        '"GR"': group_status_message
        '"GS"': group_status_strategies_message
        '"L"': bulletins_message
        '"S"': end_of_sales_message
        '"TT"': tick_table_message
        '"U"': end_of_transmission_message
        '"V"': circuit_assurance_message
  - id: hsvf_etx
    type: u1
    doc: 'End of Hsvf message'

types:
  message_header_struct:
    seq:
      - id: sequence_number
        type: str
        size: 9
        encoding: ASCII
        doc: 'Sequence numbers will range from ascii decimal 000000001 to 999999999'
      - id: message_type
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
        doc: 'Identifies the type of message being sent'
  login_message:
    seq:
      - id: user_1
        type: str
        size: 16
        encoding: ASCII
      - id: pwd_1
        type: str
        size: 16
        encoding: ASCII
      - id: login_timestamp
        type: str
        size: 6
        encoding: ASCII
      - id: protocol
        type: str
        size: 2
        encoding: ASCII
  retransmission_request_message:
    seq:
      - id: line
        type: str
        size: 2
        encoding: ASCII
      - id: start
        type: str
        size: 9
        encoding: ASCII
      - id: end
        type: str
        size: 9
        encoding: ASCII
  error_message_message:
    seq:
      - id: error_code
        type: str
        size: 4
        encoding: ASCII
      - id: error_msg
        type: str
        size: 80
        encoding: ASCII
  option_trade_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  long_message_header:
    seq:
      - id: message_timestamp
        type: str
        size: 12
        encoding: ASCII
  option_symbol:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
  future_options_trade_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: filler_2
        size: 2
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  future_option_symbol:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
      - id: call_put_code
        type: str
        size: 1
        encoding: ASCII
      - id: strike_price
        type: str
        size: 7
        encoding: ASCII
      - id: strike_price_fraction_indicator
        type: u1
        enum: strike_price_fraction_indicator
  futures_trade_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  future_product:
    seq:
      - id: root
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
  strategy_trade_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  option_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: str
        size: 1
        encoding: ASCII
  future_options_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: str
        size: 1
        encoding: ASCII
  futures_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: str
        size: 1
        encoding: ASCII
  strategy_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: str
        size: 1
        encoding: ASCII
  instrument_schedule_notice_option_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
  instrument_schedule_notice_futures_option_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
  instrument_schedule_notice_future_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
  instrument_schedule_notice_strategy_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
      - id: series_status
        type: str
        size: 1
        encoding: ASCII
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
  option_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
  future_options_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
      - id: filler_1
        size: 1
  futures_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
  strategy_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
  option_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
      - id: num_market_depth_level
        type: str
        size: 1
        encoding: ASCII
      - id: market_depth_level
        type: market_depth_level
        repeat: expr
        repeat-expr: num_market_depth_level.to_i
        doc: 'One level of market depth. The guide prints Ask Price as N for futures alone, where every other depth message prints X; read as N it could not hold the indicator codes its own description refers to, so it is marked y, an Omi type'
  market_depth_level:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
  future_options_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
      - id: num_market_depth_level
        type: str
        size: 1
        encoding: ASCII
      - id: market_depth_level
        type: market_depth_level
        repeat: expr
        repeat-expr: num_market_depth_level.to_i
        doc: 'One level of market depth. The guide prints Ask Price as N for futures alone, where every other depth message prints X; read as N it could not hold the indicator codes its own description refers to, so it is marked y, an Omi type'
  futures_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
      - id: num_market_depth_level
        type: str
        size: 1
        encoding: ASCII
      - id: market_depth_level
        type: market_depth_level
        repeat: expr
        repeat-expr: num_market_depth_level.to_i
        doc: 'One level of market depth. The guide prints Ask Price as N for futures alone, where every other depth message prints X; read as N it could not hold the indicator codes its own description refers to, so it is marked y, an Omi type'
  strategy_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: instrument_status_marker
        type: str
        size: 1
        encoding: ASCII
      - id: num_strategy_market_depth_level
        type: str
        size: 1
        encoding: ASCII
      - id: strategy_market_depth_level
        type: strategy_market_depth_level
        repeat: expr
        repeat-expr: num_strategy_market_depth_level.to_i
        doc: 'One level of strategy market depth, which carries a sign with each price'
  strategy_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: str
        size: 1
        encoding: ASCII
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: bid_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
      - id: ask_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: ask_price_quote
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
  option_trade_cancellation_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  future_options_trade_cancellation_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: price
        type: str
        size: 7
        encoding: ASCII
      - id: price_fraction_indicator
        type: u1
        enum: price_fraction_indicator
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: filler_2
        size: 2
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  futures_trade_cancellation_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  strategy_trade_cancellation_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  option_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      - id: minimum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      - id: tick_increment
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
      - id: option_type
        type: str
        size: 1
        encoding: ASCII
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
      - id: option_marker
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_symbol_root
        type: str
        size: 12
        encoding: ASCII
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: delivery_type
        type: str
        size: 1
        encoding: ASCII
  future_options_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: expiry_date
        type: str
        size: 6
        encoding: ASCII
      - id: strike_price_currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      - id: minimum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      - id: tick_increment
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: delivery_type
        type: str
        size: 1
        encoding: ASCII
      - id: underlying_root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_symbol_month
        type: str
        size: 1
        encoding: ASCII
      - id: underlying_symbol_year
        type: str
        size: 2
        encoding: ASCII
  underlying_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
  futures_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: expiry_date
        type: str
        size: 6
        encoding: ASCII
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      - id: minimum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      - id: tick_increment
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
      - id: contract_size
        type: str
        size: 8
        encoding: ASCII
      - id: tick_value
        type: str
        size: 7
        encoding: ASCII
      - id: tick_value_fraction_indicator
        type: u1
        enum: tick_value_fraction_indicator
      - id: currency
        type: str
        size: 3
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_symbol
        type: str
        size: 12
        encoding: ASCII
      - id: delivery_type
        type: str
        size: 1
        encoding: ASCII
      - id: associated_product
        type: associated_product
        doc: 'Associated future product symbology'
  associated_product:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: symbol_month
        type: str
        size: 1
        encoding: ASCII
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
  strategy_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_month
        type: str
        size: 1
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
      - id: maximum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: minimum_number_of_contracts_per_order
        type: str
        size: 6
        encoding: ASCII
      - id: maximum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      - id: minimum_threshold_price
        type: str
        size: 7
        encoding: ASCII
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      - id: tick_increment
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
      - id: market_flow_indicator
        type: str
        size: 2
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: instrument
        type: str
        size: 4
        encoding: ASCII
      - id: instrument_external_code
        type: str
        size: 30
        encoding: ASCII
      - id: strategy_allow_implied
        type: str
        size: 1
        encoding: ASCII
      - id: strategy_code
        type: str
        size: 2
        encoding: ASCII
      - id: num_strategy_instrument_leg
        type: str
        size: 2
        encoding: ASCII
      - id: strategy_instrument_leg
        type: strategy_instrument_leg
        repeat: expr
        repeat-expr: num_strategy_instrument_leg.to_i
        doc: 'One leg of a strategy instrument'
  strategy_instrument_leg:
    seq:
      - id: leg_ratio_sign
        type: str
        size: 1
        encoding: ASCII
      - id: leg_ratio
        type: str
        size: 4
        encoding: ASCII
      - id: leg_symbol
        type: str
        size: 30
        encoding: ASCII
  option_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
      - id: tick
        type: str
        size: 1
        encoding: ASCII
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
      - id: option_marker
        type: str
        size: 2
        encoding: ASCII
        pad-right: 0x20
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
      - id: previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
      - id: reason
        type: str
        size: 1
        encoding: ASCII
  future_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
      - id: tick
        type: str
        size: 1
        encoding: ASCII
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: opening_price
        type: str
        size: 7
        encoding: ASCII
      - id: opening_price_fraction_indicator
        type: u1
        enum: opening_price_fraction_indicator
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
      - id: filler_2
        size: 2
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
      - id: previous_settlement_price
        type: str
        size: 7
        encoding: ASCII
      - id: previous_settlement_price_fraction_indicator
        type: u1
        enum: previous_settlement_price_fraction_indicator
      - id: reason
        type: str
        size: 1
        encoding: ASCII
  futures_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
      - id: settlement_price
        type: str
        size: 7
        encoding: ASCII
      - id: settlement_price_fraction_indicator
        type: u1
        enum: settlement_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: previous_settlement
        type: str
        size: 7
        encoding: ASCII
      - id: previous_settlement_fraction_indicator
        type: u1
        enum: previous_settlement_fraction_indicator
      - id: open_interest
        type: str
        size: 7
        encoding: ASCII
      - id: open_interest_date
        type: str
        size: 6
        encoding: ASCII
      - id: reason
        type: str
        size: 1
        encoding: ASCII
      - id: external_price_at_source
        type: str
        size: 7
        encoding: ASCII
      - id: external_price_fraction_indicator
        type: u1
        enum: external_price_fraction_indicator
  strategy_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
      - id: bid_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: bid_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: ask_price_summary
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: last_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
      - id: open_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
      - id: high_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
      - id: low_price_sign
        type: str
        size: 1
        encoding: ASCII
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: reason
        type: str
        size: 1
        encoding: ASCII
  beginning_of_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
  beginning_of_future_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
  beginning_of_futures_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
  beginning_of_strategy_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
  futures_trade_correction_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: net_change_sign
        type: str
        size: 1
        encoding: ASCII
      - id: net_change
        type: str
        size: 7
        encoding: ASCII
      - id: net_change_fraction_indicator
        type: u1
        enum: net_change_fraction_indicator
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
      - id: price_indicator_marker
        type: str
        size: 1
        encoding: ASCII
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  group_status_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: group_status
        type: str
        size: 1
        encoding: ASCII
  group_status_strategies_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: group_status
        type: str
        size: 1
        encoding: ASCII
  bulletins_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: bulletin_type
        type: str
        size: 1
        encoding: ASCII
        doc: '1 = Regular text bulletin, 2 = Special text bulletin'
      - id: bulletin
        type:
          switch-on: bulletin_type
          cases:
            '"1"': regular_text_bulletin
            '"2"': special_text_bulletin
  regular_text_bulletin:
    seq:
      - id: regular_bulletin_contents
        type: str
        size: 79
        encoding: ASCII
      - id: continue_marker
        type: str
        size: 1
        encoding: ASCII
  special_text_bulletin:
    seq:
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
      - id: special_bulletin_contents
        type: str
        size: 49
        encoding: ASCII
      - id: continue_marker
        type: str
        size: 1
        encoding: ASCII
  end_of_sales_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: time
        type: str
        size: 6
        encoding: ASCII
  tick_table_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: tick_table_name
        type: str
        size: 50
        encoding: ASCII
      - id: tick_table_short_name
        type: str
        size: 2
        encoding: ASCII
      - id: num_tick_entry
        type: str
        size: 2
        encoding: ASCII
      - id: tick_entry
        type: tick_entry
        repeat: expr
        repeat-expr: num_tick_entry.to_i
        doc: 'One tick table entry'
  tick_entry:
    seq:
      - id: min_price
        type: str
        size: 7
        encoding: ASCII
      - id: min_price_fraction_indicator
        type: u1
        enum: min_price_fraction_indicator
      - id: tick_price
        type: str
        size: 7
        encoding: ASCII
      - id: tick_price_fraction_indicator
        type: u1
        enum: tick_price_fraction_indicator
  end_of_transmission_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: str
        size: 1
        encoding: ASCII
      - id: time
        type: str
        size: 6
        encoding: ASCII
  circuit_assurance_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: time
        type: str
        size: 6
        encoding: ASCII

enums:
  strike_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  trade_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  net_change_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  bid_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  ask_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  maximum_threshold_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  minimum_threshold_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  tick_increment_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  tick_value_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  last_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  open_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  high_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  low_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  settlement_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  previous_settlement_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  opening_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  previous_settlement_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  external_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  min_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'
  tick_price_fraction_indicator:
    0x30:
      id: 'whole'
      doc: '1/1'
    0x31:
      id: 'ten'
      doc: '1/10'
    0x32:
      id: 'hundred'
      doc: '1/100'
    0x33:
      id: 'thousand'
      doc: '1/1,000'
    0x34:
      id: 'ten_thousand'
      doc: '1/10,000'
    0x35:
      id: 'hundred_thousand'
      doc: '1/100,000'
    0x36:
      id: 'million'
      doc: '1/1,000,000'
    0x37:
      id: 'ten_million'
      doc: '1/10,000,000'
    0x38:
      id: 'hundred_million'
      doc: '1/100,000,000'
    0x39:
      id: 'billion'
      doc: '1/1,000,000,000'
    0x41:
      id: 'negative_whole'
      doc: '-1/1'
    0x42:
      id: 'negative_ten'
      doc: '-1/10'
    0x43:
      id: 'negative_hundred'
      doc: '-1/100'
    0x44:
      id: 'negative_thousand'
      doc: '-1/1,000'
    0x45:
      id: 'negative_ten_thousand'
      doc: '-1/10,000'
    0x46:
      id: 'negative_hundred_thousand'
      doc: '-1/100,000'
    0x47:
      id: 'negative_million'
      doc: '-1/1,000,000'

