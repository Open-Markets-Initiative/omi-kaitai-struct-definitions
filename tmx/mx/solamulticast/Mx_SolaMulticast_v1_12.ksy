# ---------------------------------------------------------------------
# Kaitai struct definition for: Tmx Mx SolaMulticast Hsvf v1.12
#
# Protocol:
#   Organization: TMX Group
#   Protocol: Sola Multicast
#   Encoding: High Speed Vendor Feed
#   Version: 1.12
#   Date: 3/23/2018
#   Specification: MX SOLA HSVF Multicast Specifications Guide (1.12.2).pdf
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
  - id: packet
    type: packet_struct
    repeat: eos
    doc: 'Hsvf Udp Packet'

types:
  packet_struct:
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
  option_trade_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: price_indicator_marker
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
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: expiry_month
        type: u1
        enum: expiry_month
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
        type: u1
        enum: exchange_id
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
        type: u1
        enum: price_indicator_marker
      - id: net_change_sign
        type: u1
        enum: net_change_sign
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
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: symbol_month
        type: u1
        enum: symbol_month
      - id: symbol_year
        type: str
        size: 2
        encoding: ASCII
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
      - id: call_put_code
        type: u1
        enum: call_put_code
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
        type: u1
        enum: exchange_id
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
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: price_indicator_marker
      - id: trade_number
        type: str
        size: 8
        encoding: ASCII
  future_product:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: symbol_month
        type: u1
        enum: symbol_month
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
        type: u1
        enum: exchange_id
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price_sign
        type: u1
        enum: trade_price_sign
      - id: trade_price
        type: str
        size: 7
        encoding: ASCII
      - id: trade_price_fraction_indicator
        type: u1
        enum: trade_price_fraction_indicator
      - id: net_change_sign
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: price_indicator_marker
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
        type: u1
        enum: exchange_id
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: u1
        enum: requested_market_side
  future_options_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: u1
        enum: requested_market_side
  futures_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: u1
        enum: requested_market_side
  strategy_request_for_quote_rfq_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: requested_size
        type: str
        size: 8
        encoding: ASCII
      - id: requested_market_side
        type: u1
        enum: requested_market_side
  instrument_schedule_notice_option_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: option_symbol_schedule_notice
        type: option_symbol_schedule_notice
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: series_status
        type: u1
        enum: series_status
      - id: scheduled_status_change_time
        type: str
        size: 6
        encoding: ASCII
  option_symbol_schedule_notice:
    seq:
      - id: root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: expiry_month
        type: u1
        enum: expiry_month
      - id: filler_1
        size: 1
      - id: strike_price_schedule_notice
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
  instrument_schedule_notice_futures_option_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: series_status
        type: u1
        enum: series_status
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
        type: u1
        enum: exchange_id
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: series_status
        type: u1
        enum: series_status
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
        type: u1
        enum: exchange_id
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: series_status
        type: u1
        enum: series_status
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
        type: u1
        enum: exchange_id
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: filler_1
        size: 1
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
  bid_price_quote_opening_pair:
    seq:
      - id: bid_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
  bid_price_quote_numeric_pair:
    seq:
      - id: bid_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
      - id: bid_price_fraction_indicator
        type: u1
        enum: bid_price_fraction_indicator
  ask_price_quote_opening_pair:
    seq:
      - id: ask_price_quote_opening
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
  ask_price_quote_numeric_pair:
    seq:
      - id: ask_price_quote_numeric
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
  future_options_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
      - id: filler_1
        size: 1
  futures_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
  strategy_quote_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
  option_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: option_symbol
        type: option_symbol
        doc: 'The guide states the option symbol once and every option message carries it'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
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
        type: u1
        enum: level_of_market_depth
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
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
        type: u1
        enum: exchange_id
      - id: future_option_symbol
        type: future_option_symbol
        doc: 'The guide states the future option symbol once and every future options message carries it'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
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
        type: u1
        enum: exchange_id
      - id: future_product
        type: future_product
        doc: 'The guide states the future product once and every futures message carries it'
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
      - id: num_futures_market_depth_level
        type: str
        size: 1
        encoding: ASCII
      - id: futures_market_depth_level
        type: futures_market_depth_level
        repeat: expr
        repeat-expr: num_futures_market_depth_level.to_i
        doc: 'One level of market depth. The guide prints Ask Price as N for futures alone, where every other depth message prints X; read as N it could not hold the indicator codes its own description refers to, so it is marked y, an Omi type'
  futures_market_depth_level:
    seq:
      - id: level_of_market_depth
        type: u1
        enum: level_of_market_depth
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
      - id: ask_price_futures_depth_market_depth_level_hf
        type:
          switch-on: ask_price_futures_depth_market_depth_level_hf.ask_price_futures_depth_market_depth_level_hf_opening_pair.ask_price_futures_depth_opening
          cases:
            '"OUV"': ask_price_futures_depth_market_depth_level_hf_opening_pair
            '"0"': ask_price_futures_depth_market_depth_level_hf_opening_pair
            _: ask_price_futures_depth_market_depth_level_hf_numeric_pair
      - id: ask_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_ask_orders
        type: str
        size: 2
        encoding: ASCII
  ask_price_futures_depth_market_depth_level_hf_opening_pair:
    seq:
      - id: ask_price_futures_depth_opening
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
  ask_price_futures_depth_market_depth_level_hf_numeric_pair:
    seq:
      - id: ask_price_futures_depth_numeric
        type: str
        size: 7
        encoding: ASCII
      - id: ask_price_fraction_indicator
        type: u1
        enum: ask_price_fraction_indicator
  strategy_market_depth_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: instrument_status_marker
        type: u1
        enum: instrument_status_marker
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
        type: u1
        enum: level_of_market_depth
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
      - id: bid_price_quote
        type:
          switch-on: bid_price_quote.bid_price_quote_opening_pair.bid_price_quote_opening
          cases:
            '"OUV"': bid_price_quote_opening_pair
            '"0"': bid_price_quote_opening_pair
            _: bid_price_quote_numeric_pair
      - id: bid_size
        type: str
        size: 5
        encoding: ASCII
      - id: number_of_bid_orders
        type: str
        size: 2
        encoding: ASCII
      - id: ask_price_sign
        type: u1
        enum: ask_price_sign
      - id: ask_price_quote
        type:
          switch-on: ask_price_quote.ask_price_quote_opening_pair.ask_price_quote_opening
          cases:
            '"OUV"': ask_price_quote_opening_pair
            '"0"': ask_price_quote_opening_pair
            _: ask_price_quote_numeric_pair
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
        type: u1
        enum: exchange_id
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
        doc: 'Time of cancellation transaction, HHMMSSmmm'
      - id: filler_1
        size: 1
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
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
        type: u1
        enum: exchange_id
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
        type: u1
        enum: price_indicator_marker
      - id: filler_6
        size: 6
      - id: trade_timestamp
        type: str
        size: 9
        encoding: ASCII
        doc: 'Time of cancellation transaction, HHMMSSmmm'
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
        type: u1
        enum: exchange_id
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
        doc: 'Time of cancellation transaction, HHMMSSmmm'
      - id: price_indicator_marker
        type: u1
        enum: price_indicator_marker
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
        type: u1
        enum: exchange_id
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: trade_price_sign
        type: u1
        enum: trade_price_sign
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
        doc: 'Time of cancellation transaction, HHMMSSmmm'
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
        type: u1
        enum: exchange_id
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
        type:
          switch-on: tick_increment.tick_increment_numeric_pair.tick_increment_fraction_indicator
          cases:
            'tick_increment_fraction_indicator::whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::billion': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
      - id: option_type
        type: u1
        enum: option_type
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
        pad-right: 0x20
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
        type: u1
        enum: delivery_type
  tick_increment_numeric_pair:
    seq:
      - id: tick_increment_numeric
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
  tick_increment_raw_pair:
    seq:
      - id: tick_increment_raw
        type: str
        size: 7
        encoding: ASCII
      - id: tick_increment_fraction_indicator
        type: u1
        enum: tick_increment_fraction_indicator
  future_options_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
        type:
          switch-on: tick_increment.tick_increment_numeric_pair.tick_increment_fraction_indicator
          cases:
            'tick_increment_fraction_indicator::whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::billion': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
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
        pad-right: 0x20
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
        type: u1
        enum: delivery_type
      - id: underlying_root_symbol
        type: str
        size: 6
        encoding: ASCII
        pad-right: 0x20
      - id: underlying_symbol_month
        type: u1
        enum: underlying_symbol_month
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
        type: u1
        enum: exchange_id
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
        pad-right: 0x20
  futures_instrument_keys_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
      - id: maximum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
      - id: maximum_threshold_price_fraction_indicator
        type: u1
        enum: maximum_threshold_price_fraction_indicator
      - id: minimum_threshold_price_futures
        type: str
        size: 7
        encoding: ASCII
      - id: minimum_threshold_price_fraction_indicator
        type: u1
        enum: minimum_threshold_price_fraction_indicator
      - id: tick_increment
        type:
          switch-on: tick_increment.tick_increment_numeric_pair.tick_increment_fraction_indicator
          cases:
            'tick_increment_fraction_indicator::whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::billion': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
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
        pad-right: 0x20
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
        type: u1
        enum: delivery_type
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
        type: u1
        enum: symbol_month
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
        type: u1
        enum: exchange_id
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: expiry_year
        type: str
        size: 2
        encoding: ASCII
        doc: 'Last two digits of the contract expiry year from the first expiring leg'
      - id: expiry_month_strategy
        type: str
        size: 1
        encoding: ASCII
        doc: 'Contract expiry month from the first expiring leg Refer to Month Codes'
      - id: expiry_day
        type: str
        size: 2
        encoding: ASCII
        doc: 'Contract expiry day from the first expiring leg'
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
        type:
          switch-on: tick_increment.tick_increment_numeric_pair.tick_increment_fraction_indicator
          cases:
            'tick_increment_fraction_indicator::whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::ten_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::hundred_million': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::billion': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_whole': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_ten_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_hundred_thousand': tick_increment_numeric_pair
            'tick_increment_fraction_indicator::negative_million': tick_increment_numeric_pair
            _: tick_increment_raw_pair
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
        pad-right: 0x20
      - id: strategy_allow_implied
        type: u1
        enum: strategy_allow_implied
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
        type: u1
        enum: leg_ratio_sign
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
        type: u1
        enum: exchange_id
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
        type: u1
        enum: tick
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: net_change_sign
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: reason
  future_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
        type: u1
        enum: tick
      - id: volume
        type: str
        size: 8
        encoding: ASCII
      - id: net_change_sign
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: reason
  futures_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: reason
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
        type: u1
        enum: exchange_id
      - id: strategy_symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: bid_price_sign
        type: u1
        enum: bid_price_sign
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
        type: u1
        enum: ask_price_sign
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
        type: u1
        enum: last_price_sign
      - id: last_price
        type: str
        size: 7
        encoding: ASCII
      - id: last_price_fraction_indicator
        type: u1
        enum: last_price_fraction_indicator
      - id: open_price_sign
        type: u1
        enum: open_price_sign
      - id: open_price
        type: str
        size: 7
        encoding: ASCII
      - id: open_price_fraction_indicator
        type: u1
        enum: open_price_fraction_indicator
      - id: high_price_sign
        type: u1
        enum: high_price_sign
      - id: high_price
        type: str
        size: 7
        encoding: ASCII
      - id: high_price_fraction_indicator
        type: u1
        enum: high_price_fraction_indicator
      - id: low_price_sign
        type: u1
        enum: low_price_sign
      - id: low_price
        type: str
        size: 7
        encoding: ASCII
      - id: low_price_fraction_indicator
        type: u1
        enum: low_price_fraction_indicator
      - id: net_change_sign
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: reason
  beginning_of_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
  beginning_of_future_options_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
  beginning_of_futures_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
  beginning_of_strategy_summary_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
  futures_trade_correction_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
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
        type: u1
        enum: net_change_sign
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
        type: u1
        enum: price_indicator_marker
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
        type: u1
        enum: exchange_id
        doc: 'Identifies the exchange Q = Montreal'
      - id: root_symbol_group
        type: str
        size: 6
        encoding: ASCII
        doc: 'Root of the instrument group'
      - id: group_status
        type: u1
        enum: group_status
  group_status_strategies_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: exchange_id
        type: u1
        enum: exchange_id
      - id: group_instrument
        type: str
        size: 2
        encoding: ASCII
      - id: group_status
        type: u1
        enum: group_status
  bulletins_message:
    seq:
      - id: long_message_header
        type: long_message_header
        doc: 'The guide states these fields once, as Table 3: Long Message Header, for every message the eight Table 2 frames do not. Sequence Number and Message Type are read by the packet, so they are not repeated here'
      - id: reserved
        size: 1
        doc: 'Reserved for future use'
      - id: bulletin_type
        type: u1
        enum: bulletin_type
        doc: '1 = Regular text bulletin, 2 = Special text bulletin'
      - id: bulletin
        type:
          switch-on: bulletin_type
          cases:
            'bulletin_type::regular_text_bulletin': regular_text_bulletin
            'bulletin_type::special_text_bulletin': special_text_bulletin
  regular_text_bulletin:
    seq:
      - id: regular_bulletin_contents
        type: str
        size: 79
        encoding: ASCII
        pad-right: 0x20
      - id: continue_marker
        type: u1
        enum: continue_marker
  special_text_bulletin:
    seq:
      - id: symbol
        type: str
        size: 30
        encoding: ASCII
        pad-right: 0x20
      - id: special_bulletin_contents
        type: str
        size: 49
        encoding: ASCII
        pad-right: 0x20
      - id: continue_marker
        type: u1
        enum: continue_marker
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
        type: u1
        enum: exchange_id
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
        type: u1
        enum: exchange_id
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
  exchange_id:
    0x51:
      id: 'montreal'
      doc: 'Montreal'
  expiry_month:
    0x41:
      id: 'january_call'
      doc: 'January Call'
    0x42:
      id: 'february_call'
      doc: 'February Call'
    0x43:
      id: 'march_call'
      doc: 'March Call'
    0x44:
      id: 'april_call'
      doc: 'April Call'
    0x45:
      id: 'may_call'
      doc: 'May Call'
    0x46:
      id: 'june_call'
      doc: 'June Call'
    0x47:
      id: 'july_call'
      doc: 'July Call'
    0x48:
      id: 'august_call'
      doc: 'August Call'
    0x49:
      id: 'september_call'
      doc: 'September Call'
    0x4a:
      id: 'october_call'
      doc: 'October Call'
    0x4b:
      id: 'november_call'
      doc: 'November Call'
    0x4c:
      id: 'december_call'
      doc: 'December Call'
    0x4d:
      id: 'january_put'
      doc: 'January Put'
    0x4e:
      id: 'february_put'
      doc: 'February Put'
    0x4f:
      id: 'march_put'
      doc: 'March Put'
    0x50:
      id: 'april_put'
      doc: 'April Put'
    0x51:
      id: 'may_put'
      doc: 'May Put'
    0x52:
      id: 'june_put'
      doc: 'June Put'
    0x53:
      id: 'july_put'
      doc: 'July Put'
    0x54:
      id: 'august_put'
      doc: 'August Put'
    0x55:
      id: 'september_put'
      doc: 'September Put'
    0x56:
      id: 'october_put'
      doc: 'October Put'
    0x57:
      id: 'november_put'
      doc: 'November Put'
    0x58:
      id: 'december_put'
      doc: 'December Put'
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
  net_change_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
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
  price_indicator_marker:
    0x41:
      id: 'asof_trade'
      doc: 'Asof Trade'
    0x42:
      id: 'block_trade'
      doc: 'Block Trade'
    0x20:
      id: 'actual_transaction_took_place'
      doc: 'Actual Transaction Took Place'
    0x44:
      id: 'crossed'
      doc: 'Crossed'
    0x45:
      id: 'efp_reporting'
      doc: 'Efp Reporting'
    0x47:
      id: 'contingent_trade'
      doc: 'Contingent Trade'
    0x48:
      id: 'riskless_basis_cross'
      doc: 'Riskless Basis Cross'
    0x49:
      id: 'implied_trade'
      doc: 'Implied Trade'
    0x4a:
      id: 'delta_trade'
      doc: 'Delta Trade'
    0x4b:
      id: 'committed_block'
      doc: 'Committed Block'
    0x4c:
      id: 'late_trade'
      doc: 'Late Trade'
    0x4d:
      id: 'for_future_use'
      doc: 'For Future Use'
    0x4e:
      id: 'for_future_use_x4e'
      doc: 'For Future Use'
    0x50:
      id: 'strategy_reporting'
      doc: 'Strategy Reporting'
    0x51:
      id: 'for_future_use_x51'
      doc: 'For Future Use'
    0x52:
      id: 'efr_reporting'
      doc: 'Efr Reporting'
    0x53:
      id: 'reference_price'
      doc: 'Reference Price (volume field zero filled)'
    0x74:
      id: 'trade_correction'
      doc: 'Trade Correction'
    0x54:
      id: 'committed'
      doc: 'Committed'
    0x55:
      id: 'basis_on_close'
      doc: 'Basis On Close'
    0x56:
      id: 'price_volume_adjustment'
      doc: 'Price Volume Adjustment'
    0x59:
      id: 'for_future_use_x59'
      doc: 'For Future Use'
    0x5a:
      id: 'for_future_use_x5a'
      doc: 'For Future Use'
  symbol_month:
    0x46:
      id: 'january'
      doc: 'January'
    0x47:
      id: 'february'
      doc: 'February'
    0x48:
      id: 'march'
      doc: 'March'
    0x4a:
      id: 'april'
      doc: 'April'
    0x4b:
      id: 'may'
      doc: 'May'
    0x4d:
      id: 'june'
      doc: 'June'
    0x4e:
      id: 'july'
      doc: 'July'
    0x51:
      id: 'august'
      doc: 'August'
    0x55:
      id: 'september'
      doc: 'September'
    0x56:
      id: 'october'
      doc: 'October'
    0x58:
      id: 'november'
      doc: 'November'
    0x5a:
      id: 'december'
      doc: 'December'
  call_put_code:
    0x43:
      id: 'call'
      doc: 'Call'
    0x50:
      id: 'put'
      doc: 'Put'
  trade_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  requested_market_side:
    0x42:
      id: 'buy'
      doc: 'Buy'
    0x53:
      id: 'sell'
      doc: 'Sell'
    0x32:
      id: 'both'
      doc: 'Both'
  series_status:
    0x59:
      id: 'preopening'
      doc: 'Preopening'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x46:
      id: 'forbidden'
      doc: 'Forbidden'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'halted_trading'
      doc: 'Halted Trading'
    0x52:
      id: 'reserved'
      doc: 'Reserved (goes into a state as pre-opening where orders can be sent, modified, or canceled)'
    0x53:
      id: 'suspended'
      doc: 'Suspended (goes into a state as pre-opening where orders can be sent, modified, or cancelled)'
    0x41:
      id: 'surveillance_intervention'
      doc: 'Surveillance intervention (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries'
      doc: 'Endof Day Inquiries'
    0x20:
      id: 'if_not_used'
      doc: 'If Not Used'
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
  instrument_status_marker:
    0x59:
      id: 'preopening'
      doc: 'Preopening'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x46:
      id: 'forbidden'
      doc: 'Forbidden'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'halted_trading'
      doc: 'Halted Trading'
    0x52:
      id: 'reserved'
      doc: 'Reserved (goes into a state as pre-opening where orders can be sent, modified, or canceled)'
    0x53:
      id: 'suspended'
      doc: 'Suspended (goes into a state as pre-opening where orders can be sent, modified, or cancelled)'
    0x41:
      id: 'surveillance_intervention'
      doc: 'Surveillance intervention (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries'
      doc: 'Endof Day Inquiries'
    0x20:
      id: 'if_not_used'
      doc: 'If Not Used'
  bid_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  ask_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  level_of_market_depth:
    0x31:
      id: 'level_1'
      doc: 'Level 1'
    0x32:
      id: 'level_2'
      doc: 'Level 2'
    0x33:
      id: 'level_3'
      doc: 'Level 3'
    0x34:
      id: 'level_4'
      doc: 'Level 4'
    0x35:
      id: 'level_5'
      doc: 'Level 5'
    0x41:
      id: 'implied'
      doc: 'Implied'
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
  option_type:
    0x41:
      id: 'american'
      doc: 'American'
    0x45:
      id: 'european'
      doc: 'European'
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
  delivery_type:
    0x43:
      id: 'cash'
      doc: 'Cash'
    0x50:
      id: 'physical'
      doc: 'Physical'
  underlying_symbol_month:
    0x46:
      id: 'january'
      doc: 'January'
    0x47:
      id: 'february'
      doc: 'February'
    0x48:
      id: 'march'
      doc: 'March'
    0x4a:
      id: 'april'
      doc: 'April'
    0x4b:
      id: 'may'
      doc: 'May'
    0x4d:
      id: 'june'
      doc: 'June'
    0x4e:
      id: 'july'
      doc: 'July'
    0x51:
      id: 'august'
      doc: 'August'
    0x55:
      id: 'september'
      doc: 'September'
    0x56:
      id: 'october'
      doc: 'October'
    0x58:
      id: 'november'
      doc: 'November'
    0x5a:
      id: 'december'
      doc: 'December'
  strategy_allow_implied:
    0x59:
      id: 'yes_field'
      doc: 'Yes'
    0x4e:
      id: 'no_field'
      doc: 'No'
  leg_ratio_sign:
    0x2b:
      id: 'buy_of_the_underlying'
      doc: 'Buy Of The Underlying'
    0x2d:
      id: 'sell_of_the_underlying'
      doc: 'Sell Of The Underlying'
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
  tick:
    0x2b:
      id: 'uptick'
      doc: 'Uptick'
    0x2d:
      id: 'downtick'
      doc: 'Downtick'
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
  reason:
    0x53:
      id: 'start_of_day'
      doc: 'Start Of Day'
    0x45:
      id: 'end_of_day'
      doc: 'End Of Day'
    0x55:
      id: 'instrument_new_or_update'
      doc: 'Instrument New Or Update'
    0x43:
      id: 'trade_cancellation'
      doc: 'Trade Cancellation'
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
  last_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  open_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  high_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  low_price_sign:
    0x2b:
      id: 'positive'
      doc: 'Positive'
    0x2d:
      id: 'negative'
      doc: 'Negative'
  group_status:
    0x59:
      id: 'preopening'
      doc: 'Preopening'
    0x4f:
      id: 'opening'
      doc: 'Opening'
    0x54:
      id: 'continuous_trading'
      doc: 'Continuous Trading'
    0x46:
      id: 'forbidden'
      doc: 'Forbidden'
    0x45:
      id: 'intervention_before_opening'
      doc: 'Intervention Before Opening'
    0x48:
      id: 'halted_trading'
      doc: 'Halted Trading'
    0x41:
      id: 'surveillance_intervention'
      doc: 'Surveillance intervention (Consultation phase)'
    0x43:
      id: 'endof_day_inquiries'
      doc: 'Endof Day Inquiries'
    0x20:
      id: 'if_not_used'
      doc: 'If Not Used'
  bulletin_type:
    0x31:
      id: 'regular_text_bulletin'
      doc: 'Regular Text Bulletin'
    0x32:
      id: 'special_text_bulletin'
      doc: 'Special Text Bulletin'
  continue_marker:
    0x30:
      id: 'bulletin_continues_in_next_record'
      doc: 'Bulletin Continues In Next Record'
    0x31:
      id: 'bulletin_ended'
      doc: 'Bulletin Ended'
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

